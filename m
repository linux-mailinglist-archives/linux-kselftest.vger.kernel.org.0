Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB16AFB32
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCHAgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCHAgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE19CBD8;
        Tue,  7 Mar 2023 16:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va5nkwZtKiBCjXigjJ2tKB7hy3ObLbBxyP8JRD6cx0UcwjrNRP4ewsabwkT+2k4yLi0aA0jFrdFfOhC0lm/Pmo9LI8RdQEwQtU2SeausN3xC2/ZcfFnbHeG50J/f3Xnfyf1bFS/QTK6AGLwSgtRNfWe/pD1n6pmAt38/7e+J7hR/cQ1pGVShxeOFcvwH1XZoknJsZ3gPB/796Uq6RQpqWMCf/pC3dVdHaZp0Xb2Kag1YgeDEORkH2bx+ne90ADBnIebcMgLfNUymhcZnDKWNptozoR0+kpLQXGt5A461Kb9PeI90DK1/+315UKe+X4ihxYolevla9FwBfrXcubegsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDzu/bVQ5b9/poFRYYw0YguR2+DgJqvTVbIdcgQTUxA=;
 b=hW83oe3e4coSIxT8X13NtuiCY5wsoRvOzE/jt+z/mk4/6m3sTAFQ+g0jCUvXO/tyYlxSFQvRILzqP6UU5hU616VZWQ4+KB5ewStsq2+6p/D+fN0sRhijqQ9zB+NgV6gvSFzcvENGHvK6+ZC4IlGJUVmfZocsX+fBs0fvtEovolVuVJeB1FGVJpJ0jlulewvgmRVmmKlTR5vsL9cs84W9I+CVAWtxtXCV4Dw1kr8a8tjwpaPRXELIIqFJOKw6s0p+vjnyK+yiNhifiS1Ove0G+IrMy3mSScLNefKV7ILsslfMaCr3gE5QQpaboXB9UiIrfOoJaZSb5jYnnJGtl0aNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDzu/bVQ5b9/poFRYYw0YguR2+DgJqvTVbIdcgQTUxA=;
 b=Pj1ifXs5g4Pw6JFPq72IIY63L29fY5fIxtkm7yW/u6/4YLdIk+4wA3aBuP3WzhyuHgzHrjL2E9XHIwdC514hgBigj7wKWb6k3H0vXRq5Rbyq8QfTL0fMzDytZ8V8tS6ZQXm10T6VAqOlKi4K0rPshZq8GIttudZLPj13A3aKkeTQsbVKdS71p+h+jt4cEHD9WIbQV2BIxfuzSG/PQrh4zidyG1gLtb35I0B+mpT2YFRTsfUWULwEwPXx1p+37l3ZvhuIGRiOnHQ/0Sd1Gr/wXvSpUA6V24/m2sOQXm+wrCbiZC0f1JTRdkfK/JeLouv8APAx81OSvU1H9+5s1SHcJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:58 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 00/17] Add iommufd physical device operations for replace and alloc hwpt
Date:   Tue,  7 Mar 2023 20:35:39 -0400
Message-Id: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 55be5767-b48c-4ef3-41e5-08db1f6d1573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU/CMZEWlUmNZIsevhXxDKzh8Mk2Dau7MjEdFdGqsDtnEi7M7rLppPb2gR2xo0INMqUmFQE4Y8ExyrCgun4xOeyMaU3nSoBIWhSlbQ/bGTPEEO8RdpHgyF662dWkGBOnbBAKoixScoWcBBljz6rDkufJTlgpNqOy03dO/nxWnSQ4a3FUYcA8/hess1s5wRunX6LmijC0+V7dHTfjCC5M4QKIXBBjcsNRoiisszxD3dnr6dn5g8AQMLr6kdBjh1KytDqfDUZ77KXBgxRPVHZlEgc2B7BW45DE3g6FgSk8mNGJoRCz/I8iz47L67ZQQXc5gdD1Q6rcAv872dCekK8qKDLkZDLnJHPGFE0oYoknsODm2dkEipo1Xc85TWf9LdT9OVeWMjv704CGqDEcfMplQPMA4ger1oluzQQdYR/vtPGYfPSlC54uiakU74b+qcOGCZNQaaFBpClkI+0LZ+BSS96/ZDaR7xSWHTTFmwkb+KvqPBALZByTFUnP5YzS6JqX91tySPhQ6x8Hai4woE9oCgK7PkgVR8IEhM0Sib4zaKpKfNQPP4UY58ESu7a+P4c3HRYQTbo+oQA1reht+VLJKD5oNq7AtkZ09PNXvcuKd5+EL9O+jXODIDmv0045HnIcUJZFJtrNLbj6Z6w17pUfc2O5/COyLYtTvdLBwQPLT8LmkxZXfSAkWNm3ruzD4k37r+Q/akm+cFVd/SMeQ+6eXUeTEd475D9VAJlSGA6sKJgbdtYCuJ7dvWPwGHHTmYpfEfmbr2Z4gu/zfBOyt9vdMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(966005)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4axcOWH7VIlQu72OAFYnxoaRHkyTOKQ++77P4z31+MeMyuVN6qe7PkOH7cD5?=
 =?us-ascii?Q?e8sqz0gLP1mC6Qf4138w1WmRCrNyw9wpvkIh09p1T99W+dMpenAOjww2gN1E?=
 =?us-ascii?Q?8Y3vh0n0TMs9a6rGSbYTnAJucOVQqH8Ojo6VxoTQd+Gv4czV5UKuKQgJ4FV3?=
 =?us-ascii?Q?4yhBr3FeUyzGDOHTxA+ne6NanckYvW97AHK2epmtlizEFB4nwTJMtBfBH6Lg?=
 =?us-ascii?Q?kgota6ePSG0eiOCAzdzlS/1EZXyxDY+UOh6zhcH8n5gL/SIj0wD3yLQbjmH5?=
 =?us-ascii?Q?LHufZAFIOkPM5lXooezWkkQGy3xxUHIeiLE4zgcCn60nU9mk8O291qWPR4Tg?=
 =?us-ascii?Q?zpvqLoyk4RCIgmRf8iLpurKN/7f0I75p6U2MVy0HTUerGCM7J//eeIY1cK7H?=
 =?us-ascii?Q?IWfxBjiAIa4MQlxinsH+DCVS24Xpb+0SK+urNawEmd4wMdYu2eaXqqYVEAM8?=
 =?us-ascii?Q?nbiYGiCQUs4eXjbO/zF1Byyt2D2V8jVrBb/GSwtFcDH3nlJne6s39Qs7EGP8?=
 =?us-ascii?Q?AKfkiQR3ar9TCZ7ZT//mHjGYl5gxSWkkUcWocRLQaosmW+C2kUKIj0TNDZwi?=
 =?us-ascii?Q?wsilBthKyXCMaXwBHjWdnQHS7jktdx+N31qJA6ZpVvMPRftH+uXP8y7GW2bC?=
 =?us-ascii?Q?lUoVu26MB6tdjGDXle4W4EwqsBUEAqA18dFJW0DNrgd4Csz+dPxoRaTBfHXs?=
 =?us-ascii?Q?9sMgNl45lqMHsm/93wmXdL1u+phm/ZcqTbfNokEikj7XP4qAwNHzg3dT0lKs?=
 =?us-ascii?Q?4ECQWGZTzE6dIekIAwbjrZ6VfVUhclK/eRkwTnnt4JB8I5n/0K6dWY6eR2Jp?=
 =?us-ascii?Q?XY+9eiIY9/22Lb8KKkiZyTFC4as07Wbey01Ld4EpRFLCTiGnBXJLqffmcRbN?=
 =?us-ascii?Q?GVTpH0CJY3jRZGXR2VkrKjcJlM2DOHYEonRCMSJoL9rSZfeaGi/ajJPrQ6Qt?=
 =?us-ascii?Q?DaZTAIKcn7WdUAfqxdM9uzyd0QYZFq0QzmNDXrNBDmoz1gkspsYONxRSy1rO?=
 =?us-ascii?Q?55egXlm4odBdUVfGVtuxPiC7h3JLnLzOseHKUHWGrLMwesN+Qhyt+t0zyody?=
 =?us-ascii?Q?fWqpmcdpqApWOkQ0FXGaV7LggajMtdSRt0e/PsVvCLBH/09rMj/8Oqc4xmjG?=
 =?us-ascii?Q?sx0Zhei4Zx1qZFMewgAq5ZaObcef7YEBmwfXqIZREeCu2r3Hu+8rdqIn0nGc?=
 =?us-ascii?Q?8ZuAgwkKuogBxepYas0dZIo0/sTrABjqXp16ofpwcR2V+RSZFT1TXYce4gDA?=
 =?us-ascii?Q?NHxdni69DfxNXyhf43jBBDbv2Q3A86HCUNyiJkCi6CnDBVbxvmAncpzOeJiO?=
 =?us-ascii?Q?Q1ASv8BpsRWQAneEVfG8NvWKMqkMnFR96VDlbQnS/3sX5zXl4r+7IQ6p2tZj?=
 =?us-ascii?Q?ublsM9RTvXhYQ0aDx3+bN0FaVQ1+ubdKoPmIjfXwB4J4Hfzp1A0MT8v9Xt80?=
 =?us-ascii?Q?TP6XVumNdkI7Hr7j8DZMScF1BXVdZxZnQImKibPGBqI7SSI9s/SXD+dni+UQ?=
 =?us-ascii?Q?y7hFch1bzm/4gwSrVtgb+fXxA1x6QY+wkpCRYCmZKjpE67MU9lvEjNi0/YmG?=
 =?us-ascii?Q?G056LsrU9McAdUnSa7fc0s6LSo+qLaWHuMOF/qdK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55be5767-b48c-4ef3-41e5-08db1f6d1573
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXnafeZg0j8ABTdL33pTYX11W82oIu1OmY/sJIcVES1wXi3L/3/9b+cNgUAMhY8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the basic functionality for iommufd to support
iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.

iommufd_device_replace() allows changing the HWPT associated with the
device to a new IOAS or HWPT. Replace does this in way that failure leaves
things unchanged, and utilizes the iommu iommu_group_replace_domain() API
to allow the iommu driver to perform an optional non-disruptive change.

IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
used by attach or replace. At this point it isn't very useful since the
HWPT is the same as the automatically managed HWPT from the IOAS. However
a following series will allow userspace to customize the created HWPT.

The implementation is complicated because we have to introduce some
per-iommu_group memory in iommufd and redo how we think about multi-device
groups to be more explicit. This solves all the locking problems in the
prior attempts.

This series is infrastructure work for the following series which:
 - Add replace for attach
 - Expose replace through VFIO APIs
 - Implement driver parameters for HWPT creation (nesting)

Once review of this is complete I will keep it on a side branch and
accumulate the following series when they are ready so we can have a
stable base and make more incremental progress. When we have all the parts
together to get a full implementation it can go to Linus.

I have this on github:

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v2:
 - Use WARN_ON for the igroup->group test and move that logic to a
   function iommufd_group_try_get()
 - Change igroup->devices to igroup->device list
   Replace will need to iterate over all attached idevs
 - Rename to iommufd_group_setup_msi()
 - New patch to export iommu_get_resv_regions()
 - New patch to use per-device reserved regions instead of per-group
   regions
 - Split out the reorganizing of iommufd_device_change_pt() from the
   replace patch
 - Replace uses the per-dev reserved regions
 - Use stdev_id in a few more places in the selftest
 - Fix error handling in IOMMU_HWPT_ALLOC
 - Clarify comments
 - Rebase on v6.3-rc1
v1: https://lore.kernel.org/all/0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com/

Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (15):
  iommufd: Move isolated msi enforcement to iommufd_device_bind()
  iommufd: Add iommufd_group
  iommufd: Replace the hwpt->devices list with iommufd_group
  iommu: Export iommu_get_resv_regions()
  iommufd: Keep track of each device's reserved regions instead of
    groups
  iommufd: Use the iommufd_group to avoid duplicate MSI setup
  iommufd: Make sw_msi_start a group global
  iommufd: Move putting a hwpt to a helper function
  iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
  iommufd: Reorganize iommufd_device_attach into
    iommufd_device_change_pt
  iommufd: Add iommufd_device_replace()
  iommufd: Make destroy_rwsem use a lock class per object type
  iommufd: Add IOMMU_HWPT_ALLOC
  iommufd/selftest: Return the real idev id from selftest mock_domain
  iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC

Nicolin Chen (2):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd/selftest: Test iommufd_device_replace()

 drivers/iommu/iommu-priv.h                    |  10 +
 drivers/iommu/iommu.c                         |  41 +-
 drivers/iommu/iommufd/device.c                | 498 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          |  96 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  25 +-
 drivers/iommu/iommufd/iommufd_private.h       |  51 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  17 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  64 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  52 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  61 ++-
 14 files changed, 789 insertions(+), 199 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: 4ed4791afb34c61650b17407846174a72e4034f4
-- 
2.39.2

