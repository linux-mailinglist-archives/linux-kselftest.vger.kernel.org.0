Return-Path: <linux-kselftest+bounces-38674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B2B202BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF597ADCCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300F2DEA6E;
	Mon, 11 Aug 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZS+X1YM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE1213248;
	Mon, 11 Aug 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903370; cv=fail; b=MPBKFwrylekxJVIyuD4gqEN6PD2kB7f+iHxSVuO5Ns9eoWsrDLLc3+2eYurkLE/3JLfVClv+TQxSVgJxH+23ZJGUn+ASknETsEDOysFdxhjhrsn6eR1hcPx9tujLyHZgUV48lQOzmk/Kdh/n5/PFEuUsIfsmeUbCOX6c+oJmmmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903370; c=relaxed/simple;
	bh=gNrrRQmlSevDjTTbO5U3Q9zpDDLapS7x39jrWQMwiro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKnznCPpm/ehpAN1OBmPU2WXm9TvDWIHaGuXFQA8y/AmEDNEHbjOhb+FS4ahD9VHJ82w9rMgfbC2eHXJuBZnTn73B8dpqvTP9hJHOIZATc3x9liiNMMILV11uEpKtcQCjVlUynWjQbw8FhrYeRqzmQI/fXhw/XJvqxJ9EEbcnjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZS+X1YM; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2AGc9vl4RzRMsb2px5t8MjzPbm4uDrqno3/HYmJGz+kDG9InJCjQgQqTeBsmqTLnLYcWNjQkBEyIBAJaX7aspZ0k9er+V6lmq0cJUjo3zC2eNm7ROBrWJ4J4KCFTUuo8y334y39BrTTBm3PXR1TB4nCAvWVVOVXWzObSugJ+8YpFGriIloFKZh2KTs1+vkCcjZ54Ay1GB4LUO/vOYxiD0z70SKss+79Hzh1PW6AEXcMNUUcmtxBX3xbLlI7AxsAy5+129hXuctXrlif/TCCFjMSl9tHKvY/nc8csjeVTbJS6MaU0eF0XHmYwXly+IBA5nk51+E9is/qCeX//chocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W45yesxpn18HlaHWc18OlVJMhy1GtzgV9/IHBn3sx+I=;
 b=O5eQRPpSRw2x3p8w0GgcPBC06Pphd5Ggpa0EBc8m7vmbBhk3wCUHaEBmesWpee72SNjK6bAUKwud3JM0fAJX66QJSb7RjPBj3JlmAZXu3SdQoFSgXR9u15K3CvwMlghnL8DP9G3NW0+3xW8vpUQ0XQ3wVsDgLvYrLz5hTqVvsuF7GVakFP7iWDTAssV3nMBZF0FwY+Dzn+4gKzBwRDOF6RiI1iOwnnP9NfryTdSnpmRszHtDyQHkwuBuicfOIpZjF3fOjdfkMWL0JqsOZNOVbyY0FgUzwP+od2dMboXIBoVSquXve8aNOWjkgRtqKjIBLsY7MBRolEpp/rLPsRJ/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W45yesxpn18HlaHWc18OlVJMhy1GtzgV9/IHBn3sx+I=;
 b=0ZS+X1YMP5xHLDTZTm+68FONhNTuOX8hKli2jAMdBocKwfawfBRCrIiH/aGrQ+2z+8NOxdEnqiMyI9+M0VKDe9suE0J5xpyZz3p+zAz6ePZbtpOkiBr0qjXtrhwEXhpVUHU/1C3L9SgETTyCslq6VPBc85mIUwwD9Vxn/fle1Mo=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:09:25 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::7f) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 09:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:09:25 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:09:09 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<shdhiman@amd.com>, <yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <kalyazin@amazon.com>, <peterx@redhat.com>,
	<shivankg@amd.com>, <jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
	<cgzones@googlemail.com>, <ira.weiny@intel.com>, <rientjes@google.com>,
	<roypat@amazon.co.uk>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <kent.overstreet@linux.dev>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<chao.p.peng@intel.com>, <amit@infradead.org>, <ddutile@redhat.com>,
	<dan.j.williams@intel.com>, <ashish.kalra@amd.com>, <gshan@redhat.com>,
	<jgowans@amazon.com>, <pankaj.gupta@amd.com>, <papaluri@amd.com>,
	<yuzhao@google.com>, <suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<aneeshkumar.kizhakeveetil@arm.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH RFC V10 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Date: Mon, 11 Aug 2025 09:06:07 +0000
Message-ID: <20250811090605.16057-11-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
References: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b04328e-e43c-4cd6-4fb3-08ddd8b6c4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S57Pzl4fFLxA4l0gw9EpJLZWQ3OpvDmaZlTIeQG76u4ZXi4okPlh/vGgy09A?=
 =?us-ascii?Q?XRmZ5tJOgU4MR7TB7gIVzrYtm4pXTHXVVaCMD5BCRo473+m+6dRbfHez5siv?=
 =?us-ascii?Q?fF5FuoSv1i5ZPPOJBI+d2jp1gfzfCGmOOMR226ssMC7oUDThkIvH/vlSV/gN?=
 =?us-ascii?Q?pUY+JJy4WMaajLPpzoxJnonE3KjnPIGvHMGcxiPuxsYORA3xIFSH6dQfqUet?=
 =?us-ascii?Q?ehZnxMkVfqVt7W3OEpOWZOdpI9btiHx/fiLW22N2U5FH4OzdJv51PJsolJ/K?=
 =?us-ascii?Q?ThKWoIvKIS4uoU0WdWaJubQmqAY8XJrPJRJD8aEjG6hZn5PbxNb11HVI5O0+?=
 =?us-ascii?Q?RjLyIq4jx5Dv5zJL4qE4OS9WbLIHpT/lA76IzEFmMgQ+pfMXbvje8AzgcY8c?=
 =?us-ascii?Q?052g/kllcexlIItRZChLZoD/RKu/HWD0KedZHAk/brm8jhwItZSqRBSQB/Vm?=
 =?us-ascii?Q?yvs48rFboakjO/5VT5wKcs+5vc1F/UxQE0m2tW9pzDghgg3HWjmvfQ6R3Ka/?=
 =?us-ascii?Q?8T7mAtJVnjWB4qLU61WRQMSPDydaLmvAaiHpIR1+Xr5xLBd7kkpcxQLliF20?=
 =?us-ascii?Q?l2VFjYeTy5K4ln8Ug68OmAvfElzg/hNoCqOvwmJqD4OwR42RBNuYCJrxPxJy?=
 =?us-ascii?Q?STCcL598eywBO2u/smj9yK083JEmI1RsElrXKE+fXiZ4lqD6ltT1esHNH6tM?=
 =?us-ascii?Q?E515h9UfqMv+/YrbkbVXLdyoTEIAun87AaRZFA8Q0KDwUSTy+lPdL4qHxY+I?=
 =?us-ascii?Q?N6/EYfWd9YtGbtOa4YvJ/7+FIV4tUT+C4EByHPaYSrCi37QkbZnKj9Qpg5dv?=
 =?us-ascii?Q?niOF0rUsIezsGFhnqC637HFQaVdVa6aF0D12OHWWTzFAq2g6348tlyISTUbM?=
 =?us-ascii?Q?iNZjLwv6Mdqm9hwjUz4qfiJHHYHuQVCZa6HjwTD/M33KyhfSLwUOdSFnF/E3?=
 =?us-ascii?Q?A1tk0hYLtdOq6FnHm1ekMbpB9WVmHqnposTwZiOZ5o0iD7cDMfqB61JN02k2?=
 =?us-ascii?Q?/LWVOczttX0j3zLdsqWBlI43Cl9p4QI9uU+DgCV+c8WD5Gr8eGltFsvMvKzV?=
 =?us-ascii?Q?P9bCKeIC4OgOff/oKSBK/EgCwv6VzQXgmHrbm+QMRrLR/xgBMulmqYmQVBBh?=
 =?us-ascii?Q?cxHg4ycZ8h8NQ8kwwsn5H/k/UyLOUJ8qQgiCwv4lV2xLDPYhKRBzq3+lk92d?=
 =?us-ascii?Q?RgCk6hl0cX49bwGOubyIsum8rhyThXhpQm9eNSqWSY6pMpefD7fUtRf83glC?=
 =?us-ascii?Q?MGNjSkZPgkWLWCPJjQVtrAb+B9UxDAhQrtJTnyx45D2Ic5fheNzLQGSc9O0k?=
 =?us-ascii?Q?bpZe0L7llhOjs8CoXi4M5hVjYTg+GyeGT6jtpx7JSjOP30R8ru1OXdDOprR0?=
 =?us-ascii?Q?qpycSrpwA/srfRAJ+JdaSEK3p3YstbuR5gJNO/wfEf+zr/4qMspYcK2/4gLt?=
 =?us-ascii?Q?iBHQpqV/L8MGTVdfKv54C8Y/XqiVQYhUFwrFq5dAQYCa9Agl0cbzaGMHla7V?=
 =?us-ascii?Q?jZkWz0T4pTTZo+9lnBAvdJKpoxntjQWrCZIm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:09:25.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04328e-e43c-4cd6-4fb3-08ddd8b6c4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 69 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0e93323fc839..d9c23401e770 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -17,6 +17,15 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_info {
+	struct inode vfs_inode;
+};
+
+static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -389,13 +398,46 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static struct kmem_cache *kvm_gmem_inode_cachep;
+
+static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
+{
+	struct kvm_gmem_inode_info *info;
+
+	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	return &info->vfs_inode;
+}
+
+static void kvm_gmem_destroy_inode(struct inode *inode)
+{
+}
+
+static void kvm_gmem_free_inode(struct inode *inode)
+{
+	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
+}
+
+static const struct super_operations kvm_gmem_super_operations = {
+	.statfs		= simple_statfs,
+	.alloc_inode	= kvm_gmem_alloc_inode,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
+};
+
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
 {
+	struct pseudo_fs_context *ctx;
+
 	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
 		return -ENOMEM;
 
 	fc->s_iflags |= SB_I_NOEXEC;
 	fc->s_iflags |= SB_I_NODEV;
+	ctx = fc->fs_private;
+	ctx->ops = &kvm_gmem_super_operations;
 
 	return 0;
 }
@@ -417,17 +459,40 @@ static int kvm_gmem_init_mount(void)
 	return 0;
 }
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
 int kvm_gmem_init(struct module *module)
 {
-	kvm_gmem_fops.owner = module;
+	int ret;
+	struct kmem_cache_args args = {
+		.align = 0,
+		.ctor = kvm_gmem_init_inode,
+	};
 
-	return kvm_gmem_init_mount();
+	kvm_gmem_fops.owner = module;
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  &args, SLAB_ACCOUNT);
+	if (!kvm_gmem_inode_cachep)
+		return -ENOMEM;
+	ret = kvm_gmem_init_mount();
+	if (ret) {
+		kmem_cache_destroy(kvm_gmem_inode_cachep);
+		return ret;
+	}
+	return 0;
 }
 
 void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.43.0


