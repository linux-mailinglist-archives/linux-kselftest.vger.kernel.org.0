Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98136C3A11
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCUTPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCUTPJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E216E92;
        Tue, 21 Mar 2023 12:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8un91b4sPZ3Z2m46svOQGPfO9h8d49FRwfhN1GEBCazBLXD4LwdYsDM/TXruyWJhVs1Tm2b8qXBWJAiEa4Bl8M8uYR1SfhimmMz72RqbfWQCdwz9ibjcv486bfwnBONhfr6TTFYMPPcisrrI4f/x3y88WGczArClGFzLpl8IF/nPxjY3DgedtNy1127F/qCArFQjacwFV33rv32Sc9KCmc5YNmC7Nl5yvc9oau0wIvVooPrJiHymWtDsIhjoy4K5OKj82aNQ99Xp2Cflbz9goDu9QzKEU0DvMqGgBQ2vxazt8nEjQnlvdc6ozM37YfeGWqc2yNH2Z6p3AW/7xRAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl6Q9ElGv0qsh+jn0Vo3f74UZLIIdua4N3S71p8h1DA=;
 b=K913myb9Kury1biwZyeRf2Bsn34dXDnZCeVrMZOnljop+jgrTcSLJDQ5NpdnfBZl4VFfULZSwNiIu2OA3c2k0rhBoyOaGYWf+vh0LvpDPJhpFDla1X7Ed7BmXlWv7Q4m7UzjbjcfBWNRIZQzbnIfEIrRZEE38ZknXX+k2JcmndjN54Qy5reFhKQD/LuJLXLeeiyQhmqYZ5XltANftCu3tcpyq4hc8+GkDFVB90/h40ccrViksC4QSqE4pIbEXfwq05jCtrD5gsYv0KrrR/+a9iuFh9/ScwVmh+dlAGPkkgG9PfEVoR7MBcMBxGe3IC/zlJ3nU3KuLK47bHtLnV8bPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl6Q9ElGv0qsh+jn0Vo3f74UZLIIdua4N3S71p8h1DA=;
 b=CXXyqw4lmHli3Jr2v/X9aItEiZrae+hUBN7riDlBP7T767GaJBRMN+R8uXVrvuvWbvGkEy7njzgRyZbgX8wf/1GO+MAweIfslmV8e5uHv6qfOl8N5MEIeu7ofsI403Q6vT6Gj9lSMFT1BWlov88BrKeo/5btZ+Kzg9jyShJIL/FsfIulqjYviT8jWnAVfIM9gHDRwKMPB9segeE8Rk9I6RSFNcTUsOyZv91JqAj4lK26c5ChNHxtohZ3dltHWfy4rhGznKza30etCPrs1AltfRT4v6g+1mS+y1wSJLIXUTZ2Gjn1peYI08rl6AeAgN8/U1QNrE1oOM86khu6JP9w3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:52 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 00/17] Add iommufd physical device operations for replace and alloc hwpt
Date:   Tue, 21 Mar 2023 16:14:34 -0300
Message-Id: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e30fafd-ffa3-49a3-548f-08db2a408c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARpsxhSg+rjPBfAR9+T2kjBjg4j4BGuKfGyjfFMTfuj7rZ9+DTnIaDXgd21iv0Wpk99TUTqm24pBlQpgH+nuIgEDOGEYLhQ2/48Y4z3Qc59OOy1AreHdDEZyptJWpkycRIhM5+gb0qJn19JU5hgWYg2x6oz+b3WeIXC3ciwj5OLwW/X5GzRXLHV9FWxE4iQpB5UGHq+cH333b/y468aeBqWwj8Uq+RiJE9Bs0lHyzC47ChBH6sg/xf4KOzzWDe4DPCezuUOIg7S1cYYtyIaokf5/4uNPOpGBIVGxNqS4QZnXSnPdICfm8+8UN1OCo24AQGMENjM2Pm0rUk8zEmiFiAjqdrjP0m4HBtW6pCzWFpt9ZsSilkHF+dcHCD74BFgxO7JMu5EKtYbmc+eo4LvhHskwf1EhFQs3dda4YhcZ6QVja7kvsnRAB+uzd+GKzVhcSgY1EGEre5Xv/k7mqI8tncLKfhAZjZU4p3mXgfmTQOZBip2SlvhcVs+YjhUZiilGTzDmBphFjyZskGDzld5banW11P++EYlnF8bOLJcHUU9WDrhyXrfqdi/9dNjuwLv0hNdfAWs22wIquY5KqQhNxXri/Kc6FN/slyj+uwAbFyMNxP0Vlt+Z3+pqhCgjFt1MB8h2W5+x4U/pIZtorU5HaqulXWEZMC1m22F7RgrdoVYsO+7LA+cd3TTrvX4WR5OnHb8kd9ZUEWsCMsBD9EhwdeqIxNzmcemeEuTDr/2rn6JbWFQOr/Irrf/H5s6sMMC49Dhx1dmEIeZ14C8F1uWpYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(966005)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjcpZQKH6V87TtPGeHLxOWczWxnUrxR+VgG357k72CwIxFfkAITWwYu7+xFO?=
 =?us-ascii?Q?Q3ZMRIZHgAa86EEWGYKAw3cpHa5pHi77JQL+tocg/pJBxGPGD0mqRd/LupGY?=
 =?us-ascii?Q?k43lWXF8yroDDiRYitGNEtGl145pVx7tu+wl2TlkuPEYwGjqmGPExgZCqCnz?=
 =?us-ascii?Q?EVd+2o+I6lSf3W4NDr3rFPbQS9WwRUVbRgPtkFq8uMhFRA69A0vgLeWD3qNB?=
 =?us-ascii?Q?6gkIyBoj1/U/L2k5aSl3thfjBsP2hq0m2V3zJ+GWJk2vrrsw2ejxO4XO20Ua?=
 =?us-ascii?Q?tA/truWDvbYxFm/v/sTTGo2s/h8RwCt9YcVRqbh/M2h1cPDq3K1evkxv8Mg/?=
 =?us-ascii?Q?qWBAimu3keE0J22mKfl99+7vBbnk3ZGqUAJCZHLnM+XaMsuHkRW1nSGy1WXf?=
 =?us-ascii?Q?308blxm2dO2xCg9olbPaz3am/EBt6x425K35oMSprcju9f2g5nKdhvUJJ9Go?=
 =?us-ascii?Q?ziwPO+YxasYcsNaDpaFfAKCLuXjUchJrmcKTh8DcxrroJGEVQhOTMpae3ilq?=
 =?us-ascii?Q?HdiG8R6AlhOLKWmMNDhEZNqpaYxR1JEfYaWmbN+/o6YJCvCYOe4Ct33UkCBH?=
 =?us-ascii?Q?irronPj4F7B3sUFb4BQfYcfCWN4EjWp8IBAvbHdvBqiu+PB2it7Ftjkbj4wv?=
 =?us-ascii?Q?miJr4GOA+jxWLdp71xQUuraTN070nvFgH0ZjgDsLdtsKTYVTBeXNmBDTyQaa?=
 =?us-ascii?Q?YxhxNJZTzoEkq72Den30RbcaJXCB7fCMhaHZRMTFBIghIkBtNiuR3/1rVoiL?=
 =?us-ascii?Q?lZ7JRXwcEQ5w4BmnNEl3OliE6AxpuT4TxWeduoL54X3Q7h1IF6znhFFiSiZK?=
 =?us-ascii?Q?Hs90iu01oAFor5PoFzcTlOAHOMa06mfSNES7JtAePpZL83nEZEs0LpueuVYk?=
 =?us-ascii?Q?Yg8TMMHvQ8DRWmzNDlo3kkp4iKlVzRfEgJqe0kk3CS0fTCSwhItWdCaqvJDn?=
 =?us-ascii?Q?w3euS8UKe4/GuS/Cw7HXuQN8Cv7gQrMz61ZiM6kL0NXB45N0b3OzNr2yjD0V?=
 =?us-ascii?Q?lmTrozfAnph1ijfET8ranqxFGG0Xl08tp2duy02ukBvuYlbo2kTiU1FuyVLC?=
 =?us-ascii?Q?NNpc8U17GPqLkQOF65JcXO9hRb7xpKxwHoLK1iX98+rjimwSc49lVUe4CNHf?=
 =?us-ascii?Q?+YDdBlfZl2aB0mK+dto4pZM0byiJfCzLwoXaWRJar1h8TgKWgDLP63u0Ff1j?=
 =?us-ascii?Q?oGm+hZ0CW561ClrHcjL7UIk2RA9VQPveNlA43kbALm+vTjwYqvSdL52GfwUg?=
 =?us-ascii?Q?5r9ihIy/IhtohOoWp2mwApt43/OoLNza2fydEqwLZkzrEdbVWMVaPqOvP24v?=
 =?us-ascii?Q?02P5b1uLjFIANy0ipn5hzvhe+QEJjX9g8z8k78uZKh03G9kvWXKKXMs4hzsR?=
 =?us-ascii?Q?7xtpAhp95+Cvfs+gQnYbFJE+7VhSOyNT0MOxLLTQf5oOBoJ7jh7YeVVrKxb4?=
 =?us-ascii?Q?I92dBRjHsAVFepzLMpy0HLkcP/C/jGsAZRXb8Ws/UHSLbU64mo3vzT6plciR?=
 =?us-ascii?Q?21Br9v0+kDyjcDRTkBGGzPdpwSbrRnhmvXCPHercmjAZfkKbI5zT+OBc2dvh?=
 =?us-ascii?Q?dRh5WQAAoKu0luwjUPbV31weBlBg2LPc5dDDgQqr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e30fafd-ffa3-49a3-548f-08db2a408c48
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:52.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2k1E6v87dOKdgTlzK/SA8OtPbQEaSlJwO/YyiEsjl/4MVtbgarJ/8uXxl1oOs5JF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

v3:
 - Refine comments and commit messages
 - Adjust the flow in iommufd_device_auto_get_domain() so pt_id is only
   set on success
 - Reject replace on non-attached devices
 - Add missing __reserved check for IOMMU_HWPT_ALLOC
v2: https://lore.kernel.org/r/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com
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
 drivers/iommu/iommufd/device.c                | 512 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          |  96 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  27 +-
 drivers/iommu/iommufd/iommufd_private.h       |  51 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  17 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  64 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  52 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  61 ++-
 14 files changed, 804 insertions(+), 200 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: fd8c1a4aee973e87d890a5861e106625a33b2c4e
-- 
2.40.0

