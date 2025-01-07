Return-Path: <linux-kselftest+bounces-24012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E622A047AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB53A161ED0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130F1F4282;
	Tue,  7 Jan 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TG4zefpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F21DB37B;
	Tue,  7 Jan 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269855; cv=fail; b=aHNyNPw32/7iqyFKz69obXb5hrCTRp+uKhhGk04rhhyieJGlBSXYKJ9EePz9BWVQ5+QQUx1vK4Xt/QyyOxB1LUDUfPioOnZlrMGdMiHGQo9KVCFlzdDiwA7ZNNKv2PXH3RchQKr+oBk6mDt/Sb1fl62LuUuKjpFuarMg1hXEls8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269855; c=relaxed/simple;
	bh=qyRiPyi+ekJryH++m1ndFKUc5UMY2qb/CnM//Oz++gg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pn47T5QEcY+GeNQjgmzMWPapMkVyisiDJEqB6hFOWKEaZE1StlKNutJJK2ZuWAcuYIKnDunLy1nx9rcfD02NenCtIS7jf2iZxOeMRU9Twx7qwTpd11yu+itrCQaD4D+5wiOJ6JlYHA5TcF7zpELwj9vpoZVKdzF4HYKR9I2WsWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TG4zefpf; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeH4+RdRGe9l5AMR50P/QL3O8Yve5mP/03ZxDXY02XZK8T8mbR93TPzR8m1oJFrJ61Mzlr6VYnTPeZrzZZJA/9qoCGZUEttd7yW1ZAkNiUGJIOlHppA/dJPN9bXsfIZ9+ZAn0tRjMgAVRhWNC32i8Pk7xbF55p7GAAvfX5bkkR9Rt6f/FI+kvGNFP/cFf8tI+E/Dda1cj8WVc1oAQPYHz1j3mF58ek1Uls8beI1rKp12c57Go0wwxnPbGQvKHndeqXxS5UraIvLE+MInhUhr1d0whrtNg7XJUJOneiWDl4dDEb0w2juZVVg+//g4X+hjJ7sjFsoVog0EyvyQcPy8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D08K/Z0G1I0X552pH5l1aY9pz8UErztZHDmBLvJtrBM=;
 b=FrW+HCMt+x1qbXWL4CrBXBYyEzyIhw1cL3vzHHZlsT8lCKArD/noBgq9hrJidBxrMWWzv1fy9Bch6/0cgyH1KWOkVGUKZDmWZhKbPDc7YTnKGPvz+qscUNqiGpBKR0WIjt3vki/vZmZ4+o1zn9P5Gdf/mQOPErg1b24Rk+Y7Q+Ef5JpaqzLwHCdFZsdP3bR8hIp9x35ApU2TXONBoo8Acbu9PicJyvoNOBgg7AE8AVzQtuQDt+AGUaoc/GlxwqI4/S5DRWq68xn1I/inOfU6+/cJmmhAkKVYS/4r5mJLAway2bY6aXtLoj80ykt3P7GCO1VzINIU08nb6Xm6v9+uOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D08K/Z0G1I0X552pH5l1aY9pz8UErztZHDmBLvJtrBM=;
 b=TG4zefpfqv95fFgvJFKmxZhxBkHc+nrfMGNO6Za0JKg+v+x4aveRMMsDbsyW6U6ElA0TciRlSCJsQaXDNIilTsoFMTKE4/xO9xBelNfQg0WSHj3Zy/SeNS/9pK9bCDpwJD7r93w9+dP4VCejL9qnKC2O1LENCp25YaPMdmrYpmov8eyQ2ICAhQbrbUVUKuh37REXUFi9UXN2I9CAJib31XTHb1XkEwy3eIcxQexwojNoSwFbr81CJkJMZpIKLCURtNLQuKqFJemT5HR4o3TfZrgdougu2HG7lb0+27c0sHeCyZWuesKdVlOGBo/0rujuHKI4C+qVkNeaBwFM2E8w8Q==
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Tue, 7 Jan
 2025 17:10:42 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::78) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:10:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Tue, 7 Jan 2025 09:10:03 -0800
Message-ID: <cover.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb02d60-cab6-4851-484c-08dd2f3e376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTiLozlfZBgCB0DjKcj1V5U/IFvnAbmrsyzv1TcJ9jMwyWEbH2SV3dP3VdnO?=
 =?us-ascii?Q?KDihdffWo/gDbtxb5iJTJYj6doQvHdBd8+c9ZbA20B4d88+M9+2NrvWspopP?=
 =?us-ascii?Q?wXYfgWdorWe3HVUSx7lA+k0NL6yMugLEp6/4ZLUMC/jhHrYPwZYPmqdmxDHd?=
 =?us-ascii?Q?KZcl62+oJFGrE1+A6SlFaq44UfvC+Pmd+q+lBdPhNeyeOm1kcDbxaqWsc6H8?=
 =?us-ascii?Q?UjgMugV0LCsz1ljnScYqNuGzAI6NEK3eVqEHNoAp/0IwDulecODzVI/TIAY5?=
 =?us-ascii?Q?g5AH/FIS5YC0KvTJGEFvbxtv++bCymg1+PJfxLUyYDPqFNEXWwmzo+8gmJuL?=
 =?us-ascii?Q?GVaBM8NWaIIg2dLYKUlQYIlboQ7tnlAwfdDsM+vLlhi2FUzikXqhLyikgv7J?=
 =?us-ascii?Q?bZmz0ceVtwVET5mFpLZ6Fib44G0VXXTa/2tQdkXA5U/M2o03sNLivzQfJR0Q?=
 =?us-ascii?Q?RKe3r+Ko7q24MEgjYkUqLm0MX/IpeKBxyOggtoNXn2r39ze59jj26jb6AdE4?=
 =?us-ascii?Q?W0hT5Oq/a7aAHNRBz3Zmj//YHwKiqF5ubjXY1IcInoZ9TGPd5OsoQU5vjUcj?=
 =?us-ascii?Q?NGbl4Chhz29QstctgjRzJtdv/xyvRx9D7Wfa8rf/PEu1G293ZP3iWkTiZGfX?=
 =?us-ascii?Q?Mf5O1nNCEY5UQXQst3Fd5SNK81rRkfpyGV4tdOx93xUcr5cdvgbel3jRvKDM?=
 =?us-ascii?Q?xCHj8x5UUzxn6ef1UEpshKU+EAodMjotjuMRIpF3fUcORmGEpk/FGvZBKx92?=
 =?us-ascii?Q?iUYE3Uc2TuGUbaYti5FwsXOt97L04swqI5VEB+PdoOjEmW8w2xxmw4HVkW24?=
 =?us-ascii?Q?zzGifcrLN++Z8BuCD5MwU9J4ZSqdYfacqpZ/QtcDJsIsYBLac3FswZDTDj7n?=
 =?us-ascii?Q?rb9VJr8RxsdojBiOX4cl8QN3AfqxynzFSY4P2euuOOEQXV8WXoywO77adt3T?=
 =?us-ascii?Q?2VI3L7RglZbvxdXva5GDkPNe6sTyuTOvdsX2KvXe71TQn5KYsDyeUjCrnVVu?=
 =?us-ascii?Q?1MXVXbqcw4v+S40UH8eq/tge+gw9z3jyYefD8Qe/RN2B0aUsnluzMWXUnlDs?=
 =?us-ascii?Q?HlKi29krVpwm2l93Am7VrMSg6UmmelEr0Jw2rrVTpAV4V5JTUh3N3F1AVcG0?=
 =?us-ascii?Q?RXYWemuqm6L64901uh7UBA4wGox+qzzaiMQoyOg/vz3GfrDzzlHsRrIj5lL8?=
 =?us-ascii?Q?NGWXV7Gd8FnqsmHiG3EVquz9CaUUGHS2+PwXwM3H8UeiLfimYDVRSvygDXDz?=
 =?us-ascii?Q?1ZbOzfIM2TEHfPdVV1qJZICC5Cw9S+bot2NTkBw38vnveeBaoHPtEfus3nSP?=
 =?us-ascii?Q?rKcEfD+iDR/FZTbKy3waLrRYqcsqLdgjbY+/I4ufUwiMiBpXsVAELZTJI7iO?=
 =?us-ascii?Q?1eqdJLMSTEBkC8z6Jbx1ZjbIRePb/Hd0KPzyjosvsSHW54MegZX2/lCprO62?=
 =?us-ascii?Q?qA/Lqi/g2cJcOFmrqKAC6RZmNPu7WAtocJH6wbGzH6NaX9To2Bhtj6lneDPX?=
 =?us-ascii?Q?xOBnMUpEzpM+Nv4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:41.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb02d60-cab6-4851-484c-08dd2f3e376e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489

As the vIOMMU infrastructure series part-3, this introduces a new vEVENTQ
object. The existing FAULT object provides a nice notification pathway to
the user space with a queue already, so let vEVENTQ reuse that.

Mimicing the HWPT structure, add a common EVENTQ structure to support its
derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VEVENTQ (new).

An IOMMUFD_CMD_VEVENTQ_ALLOC is introduced to allocate vEVENTQ object for
vIOMMUs. One vIOMMU can have multiple vEVENTQs in different types but can
not support multiple vEVENTQs in the same type.

The forwarding part is fairly simple but might need to replace a physical
device ID with a virtual device ID in a driver-level event data structure.
So, this also adds some helpers for drivers to use.

As usual, this series comes with the selftest coverage for this new ioctl
and with a real world use case in the ARM SMMUv3 driver.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v5

Testing with RMR patches for MSI:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v5-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v5

Changelog
v5
 * Add Reviewed-by from Baolu
 * Reorder the OBJ list as well
 * Fix alphabetical order after renaming in v4
 * Add supports_veventq viommu op for vEVENTQ type validation
v4
 https://lore.kernel.org/all/cover.1735933254.git.nicolinc@nvidia.com/
 * Rename "vIRQ" to "vEVENTQ"
 * Use flexible array in struct iommufd_vevent
 * Add the new ioctl command to union ucmd_buffer
 * Fix the alphabetical order in union ucmd_buffer too
 * Rename _TYPE_NONE to _TYPE_DEFAULT aligning with vIOMMU naming
v3
 https://lore.kernel.org/all/cover.1734477608.git.nicolinc@nvidia.com/
 * Rebase on Will's for-joerg/arm-smmu/updates for arm_smmu_event series
 * Add "Reviewed-by" lines from Kevin
 * Fix typos in comments, kdocs, and jump tags
 * Add a patch to sort struct iommufd_ioctl_op
 * Update iommufd's userpsace-api documentation
 * Update uAPI kdoc to quote SMMUv3 offical spec
 * Drop the unused workqueue in struct iommufd_virq
 * Drop might_sleep() in iommufd_viommu_report_irq() helper
 * Add missing "break" in iommufd_viommu_get_vdev_id() helper
 * Shrink the scope of the vmaster's read lock in SMMUv3 driver
 * Pass in two arguments to iommufd_eventq_virq_handler() helper
 * Move "!ops || !ops->read" validation into iommufd_eventq_init()
 * Move "fault->ictx = ictx" closer to iommufd_ctx_get(fault->ictx)
 * Update commit message for arm_smmu_attach_prepare/commit_vmaster()
 * Keep "iommufd_fault" as-is and rename "iommufd_eventq_virq" to just
   "iommufd_virq"
v2
 https://lore.kernel.org/all/cover.1733263737.git.nicolinc@nvidia.com/
 * Rebase on v6.13-rc1
 * Add IOPF and vIRQ in iommufd.rst (userspace-api)
 * Add a proper locking in iommufd_event_virq_destroy
 * Add iommufd_event_virq_abort with a lockdep_assert_held
 * Rename "EVENT_*" to "EVENTQ_*" to describe the objects better
 * Reorganize flows in iommufd_eventq_virq_alloc for abort() to work
 * Adde struct arm_smmu_vmaster to store vSID upon attaching to a nested
   domain, calling a newly added iommufd_viommu_get_vdev_id helper
 * Adde an arm_vmaster_report_event helper in arm-smmu-v3-iommufd file
   to simplify the routine in arm_smmu_handle_evt() of the main driver
v1
 https://lore.kernel.org/all/cover.1724777091.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Nicolin Chen (14):
  iommufd: Keep OBJ/IOCTL lists in an alphabetical order
  iommufd/fault: Add an iommufd_fault_init() helper
  iommufd/fault: Move iommufd_fault_iopf_handler() to header
  iommufd: Abstract an iommufd_eventq from iommufd_fault
  iommufd: Rename fault.c to eventq.c
  iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
  iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
  iommufd/viommu: Add iommufd_viommu_report_event helper
  iommufd/selftest: Require vdev_id when attaching to a nested domain
  iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ
    coverage
  iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
  iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
  iommu/arm-smmu-v3: Report events that belong to devices attached to
    vIOMMU

 drivers/iommu/iommufd/Makefile                |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  30 ++
 drivers/iommu/iommufd/iommufd_private.h       | 116 ++++++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  24 ++
 include/uapi/linux/iommufd.h                  |  46 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  65 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  71 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  90 ++++--
 drivers/iommu/iommufd/driver.c                |  63 ++++
 drivers/iommu/iommufd/{fault.c => eventq.c}   | 303 ++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/main.c                  |  37 ++-
 drivers/iommu/iommufd/selftest.c              |  53 +++
 drivers/iommu/iommufd/viommu.c                |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  27 ++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 +
 Documentation/userspace-api/iommufd.rst       |  16 +
 18 files changed, 843 insertions(+), 125 deletions(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (54%)


base-commit: e94dc6ddda8dd3770879a132d577accd2cce25f9
-- 
2.43.0


