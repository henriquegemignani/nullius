
-- data.raw.

---@param prototype data.Prototype
---@param description data.CustomTooltipField
local function add_description(prototype, description)
    if not prototype.custom_tooltip_fields then
        prototype.custom_tooltip_fields = {}
    end
    table.insert(prototype.custom_tooltip_fields, description)
end

---comment
---@param prototype data.Prototype
---@param mineable? data.MinableProperties
---@param fluid_box data.FluidBox
local function add_pipeline_extent(prototype, mineable, fluid_box)
    local extent = fluid_box.max_pipeline_extent
    if extent and mineable then
        local result = mineable.result
        if not result then
            for _, r in pairs(mineable.results or {}) do
                if r.type == "item" then
                    result = r.name
                    break
                end
            end
        end
        local item = data.raw.item[result]
        if not item then return end

        local description = {
            name = { "description.pipeline-extent" },
            value = tostring(extent),
        }
        add_description(item, description)
    end
end

for _, pipe in pairs(data.raw["pipe"]) do
    add_pipeline_extent(pipe, pipe.minable, pipe.fluid_box)
end
for _, pipe in pairs(data.raw["pipe-to-ground"]) do
    add_pipeline_extent(pipe, pipe.minable, pipe.fluid_box)
end
for _, tank in pairs(data.raw["storage-tank"]) do
    add_pipeline_extent(tank, tank.minable, tank.fluid_box)
end
