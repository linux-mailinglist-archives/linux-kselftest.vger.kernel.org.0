Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB4756B7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGQSNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjGQSNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7551715;
        Mon, 17 Jul 2023 11:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZB8FKAC7yPZwFtiN+ZRGsqISOU79+S55EhyLKMQBGa+8+Pv4oSu9VtofXh0tKRAUME1f9wYGw2eWXRxDHoEzCEYkcqpZyN6jbUfHFV3NMonj0Hg3M2ayZqJASU/iWaPdBw4KjAayJyjDDLNA2F9Op1QtXhaANGAf2HB3MF4JbI1q2recNs6koQdkZyhkHB0FO5xVQVSpOw3nXdHqfu1+mdbTthBANHZCNg5PrCCvM7DG/d6Kk82VKEG9V3EQb4j6wGA3a5b+n5u8wZIiVm0R4gXD1EH8oaa3qN+J1X8KNBk6EdKT0ZgN5AbPKLxUUjHaLl2o3IffQEpJSmzYHbjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c2aZCioer7nUuGmazaUBZJSlCsTpeM5vC70gd3TSvA=;
 b=HnNpAcg4/6lxfAuvcdcyUJsNsMrXkUfKRZP0EEXXsNey1OcBiWFBTerlFjze7WC9Q72Iotgt1nzd8nYlhByN2mprcP0iOtRODOxA1mY2NGFU8ZeY15mwUJZQwVSzm0t4mhwduqoNOZLE5eCjQHot4M3O+lkdfF9Nn5sDdeSN+4ppgjM3tRFSLIvJ1kyY7baTnyzNnYyDU1DjQb2QS8ay6f66mltFTU+74LdY2+zeyL4raOIdmZokbjvEw2h1Emz+k3YHWWol0dQqXkNxgmizG4y9U24Wu0gS9b3bEXZOj3CRUQyqvPFTM373yoGqEZ5faC+L+oNg3so6nZ0zWNI1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c2aZCioer7nUuGmazaUBZJSlCsTpeM5vC70gd3TSvA=;
 b=FvpYcxV2i83kQqXCIlF758Pwl3wBEQBj/qiGJ2qeD4Us+/ZfSEGDpDVKZUR3sxhewB1cYZkZCbTNSKayM6x8jIphyxLTgTtrsCKZK+xPLmzdkB7V2WIb3L3EinzgXBGgU+j4Mr30aJHsaFbgVYUZjDnuNWTCKlrPHMLcuafxs4dcQmzt/04VDMASJnzYpa5gRVwmdDijXM9HHhvnGVESJ4uhRNp7w8bEFrX8LrMdnqfiNqYzox8rOvcPqChBk69EgIu1+ZBF/QKwWV2SRZg/NJ/y8pq4NuLq/G2PpskuD8sznsyKE4cq+W3N2Xltpnf8HIe9r+Pd8Bw/CcKpO3B7BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:29 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 00/19] Add iommufd physical device operations for replace and alloc hwpt
Date:   Mon, 17 Jul 2023 15:11:56 -0300
Message-ID: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f03730-479e-4389-9265-08db86f15d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXV9GD0XFZURtEexcNmIllJTbaM/lLFflWaTaxexNHbx632jrveA4TxEp1+rvHUd+gGi3sZrfzqiysSzv8XebTIKTM3cdc/Fiam+JDOOxZYwBurOtavS1Yal8CylWr89ICCgMRVyqdVc6OzNiccW+OSL4pn4fPR2dtiDP1MGAeBRq1ITbDwcJWQFegNVU3atjoKxS4bp1fHEHOJ7NPrjATA+Mv1/zuUOo8dELke7/jQ2IMBlCXU0A4/g8J7+S3nD5fgcuU79DVopGVacVcu60IZFrqbWCIEZB8GP+29HL7nbInHCdJZ6AWNcS/uoJSGaS6dsUhQKOLvcUBSpM4vk/qQF13l9kN2Ky8zOa80NaUUI+p8aVMnocowskvdftQm9Omb/rycTJE30mhTCa6Ee0kIKplHT9t+M+vIEgpZGnlLbYDxXKM/kOO9cnd1iMKQi9TX6+NjUMTpmmJThxvrOZ4GHUPHUmVNtWhx+DHcCOcJoOIjbpKiO6QIIYmgXfqRBr1vOc3AFcG+/glCegXgzD7upYc2RDdNr5RhJUfRu9uUtRS995etCjomnrj8df7QlvdAJv7Sx0TcVDFfuNFnLPfWu/Dr32Mdm4KdTPjA0ZCdFFoOs21t61hxfTHLB1zPLrLopdLnQSsWkgLK2CuTVwSKYBMqvM4YR7rKJ259+yNaxB2W+TbxW/GHcMawBMW75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2906002)(54906003)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(66556008)(41300700001)(66476007)(316002)(4326008)(66946007)(83380400001)(38100700002)(86362001)(6512007)(966005)(5660300002)(26005)(2616005)(186003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Fwn+RxyryWcvFr9r4j+cwluu59C4Kre3sC/FBA+tbycdNEMhnDgha4BBLr5?=
 =?us-ascii?Q?Av3hrI/mgnizmy53U8HiJRwUTUqQTbafzjvyyIE4ssaS6f+qmcVxa8b0N+xN?=
 =?us-ascii?Q?LA5X2TWN9XdxTfUPfgn21aNeemjkZ00kXFSSo5NsvLTmbmqdUHHOhAnIZn83?=
 =?us-ascii?Q?bdhQJgXKBCq4GugNnu7UKZ4C6YqE1SbSqqu6jOByIw/uIWRm43CoAd2rp6Vl?=
 =?us-ascii?Q?soMAbCa3N+91CgnWyP9PXbx//PH4q1Khwhd6cvNonascGo4NUxRvB9AVjFc0?=
 =?us-ascii?Q?PyNvhF6UsWXSQBGo31xh7iILgTUeLVowhiN+Ngh4ra2CAZdhHhdtcqUkgOHO?=
 =?us-ascii?Q?Hgi2pq8aPS4f3rZloPabiuqkqFIa7aFk6+ioY2dTej5wKmSzY1A5QzyD832s?=
 =?us-ascii?Q?cS2NpU9PQUMWKZpYgz+w0gw/OeDpyVUCWR28BqxWvWFZ0SKDQ/xtociqygh8?=
 =?us-ascii?Q?RD9eODVZDG06ph/OG1lNDIW7klQPFoIPhWcEUo9P8sl38ytCg4GDOdiqhDjP?=
 =?us-ascii?Q?4V9uKNcrfTVrkYf0RMUm+157/vjPHTe9NVnFYNNoSTSJgvRCnipfi4vehoe3?=
 =?us-ascii?Q?wf+oE3vqHD/Hu6ffKYYPcvRAuW4u2ZTVVwERxEjr8/Ug+JYovnQjHwUSnNPn?=
 =?us-ascii?Q?i3e+DjmCPNuKh1k6+P4o+v6sWfWW7kJrhe87EfawbMmyuVmHQAvhCLDopJHA?=
 =?us-ascii?Q?BtoItAoWr/FZxQIAD5sYOicdhY9AVFNOQQfTeJJKAYqkbhzt3u1M10YiapKp?=
 =?us-ascii?Q?0J9xxa4sU5XubJHOZS83xuEHzUtA9DQo7i83hoPt4oD3ViqCRnRIEoa8063a?=
 =?us-ascii?Q?dzbC5pjSImGiIoNmxKgHCbS7qvxob0l0ZS2w8i5kI6U5+n4fRVq5RVRS0SAu?=
 =?us-ascii?Q?brL/dbcogOEQOtQmDpLSZaeziYtBgxVWOJ0EY3bY4MyHGS4ejL7WRrdjq0ej?=
 =?us-ascii?Q?AUUzkq54UEAH3naptUuX5ZJ1Iy/g8WSpzA8NqbiNRR9BpLultks0IqwgaLUr?=
 =?us-ascii?Q?LUv3I0sd8ov3sxNRXLB4DwxWEiFYPep0l13nyG71plIPHlp7lq9n2yXh5pmt?=
 =?us-ascii?Q?gt/OCtEm7D3PJcEGRUcty4HOK88Ha7vmyFOQSxSNarlRJKc5DyGWYYUj+6oN?=
 =?us-ascii?Q?9g6tQhbyRMVRUMikLIfWX+glODYpRna0PXz0X/up7EnuzpVWsaODUC0Lgq2p?=
 =?us-ascii?Q?8kX997vbzdAiLkAlAoAogy2O8phJhfn/H5LG7ffXbHg4b5g0U8KpEdWmfJZx?=
 =?us-ascii?Q?QL+YXVYIuamxV7v6AWMLAKfcvTBXBFyocuSOthOeqir7iGPCTDJMzoM6rlJd?=
 =?us-ascii?Q?Dj6FH9hKBSDeqPzrMc8nhBl74XTJURIrd8lE03di1tIgGiHAP7nMF38kIcK2?=
 =?us-ascii?Q?jEGlWeB7wblL1kRqrX7LUA4z55vXBDf/tNQ91qTM633boP08kFDK69/8f1ck?=
 =?us-ascii?Q?nGdgRfCQpdHnO+/LpPUqk8ARN13sOwR4cfJ89bIspIn/sLtP7FTLY2dV2cSC?=
 =?us-ascii?Q?79ylTjUU1zYwhHIgx49EdYuqz0E88I6h9uGom93eqMIrCqu+XtVhGnvrggqD?=
 =?us-ascii?Q?xbNvM24rsqZlPny5AKeLYJq803E8TZVp75KL/u1i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f03730-479e-4389-9265-08db86f15d78
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:21.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgyS0mpy+unej7MAp7eDlOrq1kg3BfmdUeDLiHJVUqHPrgUigyQfENIjae1jD5hX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v8:
 - Rebase to v6.5-rc2, update to new behavior of __iommu_group_set_domain()
v7: https://lore.kernel.org/r/0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com
 - Rebase to v6.4-rc2, update to new signature of iommufd_get_ioas()
v6: https://lore.kernel.org/r/0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com
 - Go back to the v4 locking arragnment with now both the attach/detach
   igroup->locks inside the functions, Kevin says he needs this for a
   followup series. This still fixes the syzkaller bug
 - Fix two more error unwind locking bugs where
   iommufd_object_abort_and_destroy(hwpt) would deadlock or be mislocked.
   Make sure fail_nth will catch these mistakes
 - Add a patch allowing objects to have different abort than destroy
   function, it allows hwpt abort to require the caller to continue
   to hold the lock and enforces this with lockdep.
v5: https://lore.kernel.org/r/0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com
 - Go back to the v3 version of the code, keep the comment changes from
   v4. Syzkaller says the group lock change in v4 didn't work.
 - Adjust the fail_nth test to cover the path syzkaller found. We need to
   have an ioas with a mapped page installed to inject a failure during
   domain attachment.
v4: https://lore.kernel.org/r/0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com
 - Refine comments and commit messages
 - Move the group lock into iommufd_hw_pagetable_attach()
 - Fix error unwind in iommufd_device_do_replace()
v3: https://lore.kernel.org/r/0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com
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

Jason Gunthorpe (17):
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
  iommufd: Allow a hwpt to be aborted after allocation
  iommufd: Fix locking around hwpt allocation
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
 drivers/iommu/iommu.c                         |  38 +-
 drivers/iommu/iommufd/device.c                | 555 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          | 112 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  32 +-
 drivers/iommu/iommufd/iommufd_private.h       |  52 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  24 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  67 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  67 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  63 +-
 14 files changed, 867 insertions(+), 226 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0

