Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1317469FD58
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBVVCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjBVVCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:51 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57536115
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8z6Vv8xBbSWsEADdCPfAzbfLwMXFYyJ6J+66Jk7BVOnzn22EyqA2Za7nWup1xcGktKtU5p7A4TI8JtTuyZIkPa4SJNwvsOh3EUeMy9GXB+hXhpIwk77wF/3Ij0suo3nGSL8kG/Ar34CNMZ4I16wy2RHlRq/OuWaQrHZtPdNd8qeVVoKmlValne64pfDhFWsMcjM3HYryfo5cXAayMX5cqB/mFOy9S6OBD0ho1gxDjCg/B8tyiGCUSqAj9SeEsmFZKNJt0eM56Q5vrHm1xVY2V3t+2VtMt4Ns+Yv8v420uzHB2td9N5B9ZKgzETCcDb5LGoMaawE28THTPIXh4b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCU8jNTjqFN7Vn1dS+auXwiRqFMsW8rKw+wdmt9hWVo=;
 b=MRrx3xev0MzD+orkRQms8G8Eo/bSOKrgB4uCoL9kpiR86GhXI31nH8uvXwxyuZRyD7D/11ZRs2XuTI0hiYN4oZrLYSMTugop9nFuBvYmN5JSm0DZRVvsuft71TV+SIHRLxRZ/yPtr2OfokpgWuASfn1cuIfS+oY3wDcIiIfHd+F8JbPZLamUk3NtrRohdIHCWUqkYxgYEEyFxG4gqimU++QOZYAfLhMxzEy0u4UOpRTfhFnj7Mu5zqhIabaY9RUVBXT8kHLOcMdjRFKwybCX+ngAjSOD6iaLsOlg86UBhU9PweDHKHE8Dc8QYXxkhsnz/ZMlWpcL/0G3DYt7FzufSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCU8jNTjqFN7Vn1dS+auXwiRqFMsW8rKw+wdmt9hWVo=;
 b=utztPF7twp0d5nT1Uhb3ndzfDjzQlr1U2+3F6jyhqk1zRkjIrdBhWx70wmnBl2gqQt9dPUtAfYf7TPSzgPLiJHfZytGFOGV+VjX0PnxKal8xO+hFxRMuJpjXy/OlbA0D4wbI2nlvNfS/x7nmwn3UJVdUwDFCIFz1Yka0Eq3PC6eFCjb1Lqphjo4si7ltAcl2+XqWmhYufhgz0A2byZN/EXpv/VNv0oK+m5829yV+whu3TmmkJID4XzdjNQoz1V+JCo4BLJYI83iZfgfz6kHXm7IbeW4B22AKzECXUr+io/FGAXstPCdHeh31ae3giOot0DNonwcydwjnTr62Na9Cag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:43 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 0/7] Revise the hwpt lifetime model
Date:   Wed, 22 Feb 2023 17:02:33 -0400
Message-Id: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: b53d9739-48dd-49a0-e368-08db15182371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDKPzaDQRerAyWhojoGLTIFjY7RVyWKqmQZCEU5PKH1USucgaQuHAZ0hL6aUtxuk3fd3N+pJIHXZGWv8Lpe0HxmrgNE0bGyIdgTJtvvCglnyDw86sWtWh1HktN5Fsx48sq4G33BzW3h2HHQYcrzbusSztEnDleS5iN5NoPWJywb1gDOIJvwtAiIiaAGazFAjecVe/Y99ZtEuBJwcIsKzuS7PGHrVaZQ+DHc8vEmHVTSgs6mUWR8ft0V4iREYVdcdBiL5VqFxVQYSW0UmU2YDSrm59V5IZ8Dr+X60psnnuF3psFHckgi2a34iV3X2QUCSjFdqpVz/ub8UiC8ADOS+8ffn01tWaRbE/cC2cYs720c7aNdyJQnQK6SHo2ACOd8Plw7tXjcf+kpJmQzhxCMA0MyiEd3x2PoBGxwDWqKyLPvR/4qxh0EwzNFP8wP3q8DpNJIQuYI6syuW6YoHQxF/LaIzQRUPysxceHcr3t1xShP6mAxj5/dlOUudEFjoU0Ohll9yToeyi313NJhvVV9jbYAtfIPBfTpRIwgnh3C51OjDtwo1luVtaaVFZX6lmK1ezVlRpXXE7JtQdO/qa4TPnwaw7Ic2PMzXZBJiEcy4OSIQfPfYjesclgO/BrZxhsEG0w5waYIL7bsxEFL0/2VImSfV2BzU8GhH3O6D1Vf+BYLVO1gVqnjlPhLJGZ4CAj4yDv0KxOLHyjcu6heKi5kFzs96i2eAXyxcCxRrqd5WrvgMuy7JicfOfCBGJKOLxPXaV4YCKMJuaP+n5ABjbcrI1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(966005)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(83380400001)(2906002)(6486002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bODXgfg2nvIJ6p+ykUq+BcTrSXcdw8/JfANtuQscnJJu/vnC9/HGWj+h88Do?=
 =?us-ascii?Q?hg1u3wG6DlEHgz9uG9z7vQSbqwmlO9LEoEwcCgciclDX7xodFRQkYh/j/byN?=
 =?us-ascii?Q?kTMFYJHHiXKD8vmJIuxoHXVKERzHGRAryCKdrxTWHr9K5fxCkbzrqSg74P9i?=
 =?us-ascii?Q?+kByXNaL7qgDiN2LyRYt6hKnKZDOAE6hGZdOR7p9gUj8JJUTLjWAqIDptilW?=
 =?us-ascii?Q?PIQl2HLGrd7Ei4HInraI9AYJc06MkudvVYMuEhyVliBTkjSDVG5FLnbCykhU?=
 =?us-ascii?Q?VRA1AUVBX5C/dqYZcT0DFAKuyXuXPoheXSFq15awuctQUOdiJaCKTiLpDMBU?=
 =?us-ascii?Q?TLchdM6jR5H2eS0XRjwMrVBmYiMhzbn1O6tibddVzEP1ifKqi/+/kLX1Je4g?=
 =?us-ascii?Q?XcCh7gzexn7dbRIFvIatmujKxbBP7i8j8bCdUwypKo55whqYJFq193/9vwcF?=
 =?us-ascii?Q?ekGlEjDIUSNisJUSpVDcGzpKRjHI2llo4zBWx46hu4vhdpCpgAgjCpXbCddT?=
 =?us-ascii?Q?G/XoWpOhcIN3NlaI6Mce1mwq3Yc3YbZ6/YWyZze1WaYRozCum5TzHmL/f38Z?=
 =?us-ascii?Q?guJTtEbF+Tu0fsM81ua5W3qGyfCgHsS5HGe4Y6SvVlSnsaOOzGxhYHxXe5Ta?=
 =?us-ascii?Q?6+uQcmwENeob1Dsi6XXTb4O4KASQ+tR66kgqDKitFlBPNWWjXsUakFDThViK?=
 =?us-ascii?Q?kl3hngf0Y3RMsJ4qXTNb22JE9ssm1jnTPk7HOHSg8rZXPnIktxbuPAhxRNAM?=
 =?us-ascii?Q?FNMS6LmTNgDK9AN0rRJrR+omj8PCNGm+l12QjxAzBQyzcJy1U9mMmxnAjDhr?=
 =?us-ascii?Q?2qwvhH2JfqnMv3JXZsfRhHrv1YChXZr/VohEIN42OYT/lB2AtWF04767e+IK?=
 =?us-ascii?Q?K95AvznmHLJEpOGtcOxiWLSjGJrWcqat6dC8LrE0+5E7oYXT8i3V2D/AyWQl?=
 =?us-ascii?Q?9mjg9rEdxovDi9iJ7qskUDHtzgDL08rFmgJ5HCY1Q4QYCwuCGzTG9WlxxIRz?=
 =?us-ascii?Q?bVj2xH4pwe2ew7vHIrgM0hq8GFsSOcarQkkN/C4+8pPWI7REBxHzU+iqU6c2?=
 =?us-ascii?Q?70f+9WwiUY0/6SU7YUjHvW5qz0HXkbzCmz+KhSyhZnpydFRDgZ968GA3AaCt?=
 =?us-ascii?Q?Zchf5arhV5fSI+7KhWvis0VXQkAqXjfAx0azByPjNKyqYYf+AI9SA9wLt5Fb?=
 =?us-ascii?Q?zShsST5DpOyIlvTq/FuHBLVTb1sJmiJrWpE5vmMpTY6vU04QKxtlvbMW0OXy?=
 =?us-ascii?Q?E/7pnTs4p5nxk7012+HHNSdLbOYd0UiHXXhBfNLI2WfynBswMX73ui/tFHj0?=
 =?us-ascii?Q?450ODxZbc3TErhP9ICDywfnh3fUpvIqLBvqX/J8Gmwt/ZvmY9zsfyBvEHYQ2?=
 =?us-ascii?Q?uDVGH29H5nVGrxAr8wDr4TmDvJ3May96pPDLZpBPMWOBRC/dlL6KYNGUbjTs?=
 =?us-ascii?Q?GE9F1SHUXKY+pvQV0Vhy7Lq+K+1N6gozpQiACiOZNduTTUhOIrLNtKcXvjKg?=
 =?us-ascii?Q?5aXMNe25fwA4YUi9lfItEnDoW50C3DTQIP84O/4CJrktKRjEXBqnnahB2k3Q?=
 =?us-ascii?Q?z7aWALMRC4HY2BVrrndkYgIgV752p3zXBz332HjD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53d9739-48dd-49a0-e368-08db15182371
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:42.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqpwCs9BbYOWElO0HzecTfUf5ejOoQJIhHcWhgO3BeHR0jlLMLEZn8Iiom0M5mQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As discussed here is a small series to address the confusing lifetime
scheme for the hwpt. This was some leftover from prior rework that was
never fully cleaned up.

Make it clear that the ioas and ioas->hwpt_list are associated with the
hwpt during creation and never changed until it is destroyed. A hwpt with
a positive reference count is always valid for device attachment.

This is a step toward the nesting and replace series.

I have this on github:

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v2:
 - Basically completely different
 - Add a test for HWPT cases by enhancing the mock iommu driver to be more
   complete
 - Move the device attachment as well into iommufd_hw_pagetable_alloc()
   so destroy is more symmetric
v1: https://lore.kernel.org/r/0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com

Jason Gunthorpe (7):
  iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
  iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
  iommufd: Move ioas related HWPT destruction into
    iommufd_hw_pagetable_destroy()
  iommufd: Move iommufd_device to iommufd_private.h
  iommufd: Make iommufd_hw_pagetable_alloc() do iopt_table_add_domain()
  iommufd/selftest: Make selftest create a more complete mock device
  iommufd/selftest: Add a selftest for iommufd_device_attach() with a
    hwpt argument

 drivers/iommu/iommufd/device.c                | 150 +++++---------
 drivers/iommu/iommufd/hw_pagetable.c          |  72 ++++++-
 drivers/iommu/iommufd/iommufd_private.h       |  35 +++-
 drivers/iommu/iommufd/selftest.c              | 196 +++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c       |  15 +-
 .../selftests/iommu/iommufd_fail_nth.c        |   8 -
 6 files changed, 319 insertions(+), 157 deletions(-)


base-commit: 8473685c99683f9e2c7e2a42ef3d3f14a79be274
-- 
2.39.1

