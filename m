Return-Path: <linux-kselftest+bounces-16440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21A9614FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0921F21248
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C051D47C0;
	Tue, 27 Aug 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5a9J5J/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DD1D47A8;
	Tue, 27 Aug 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778136; cv=fail; b=EZUvNPLGfhe3u6v04LFsf1HaohylnH1oolhue//q4qoGw282cL903oHbx+0/T9e8qMo2/DM+lIzR1+z9ZRvv58G7eUobiGS2YkjkIk8vhWF/6UfW6gkeuMOrbUUbIN73mOTYiyGtGUqda/YMkRAJlFsi/fKrrur43jpATY5h9lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778136; c=relaxed/simple;
	bh=0gOPJWglZCrj0XGM0MvHTvCgRioePLfXKFWXa9BpxSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjhlCioeFIuJUGBOhITBDkgqYZswFW3G1OY7Dq+A1qKD8Lm79A0Mx0idL2/i0l20PgELAJwey0Ax7gwfZ7xaw8PtDg+B0h9E7wSNxlOkA9VvyZxtZojeXhVwmHmSFdyIYY5qX8hajQP0rAf9pXz8I8VHrB3TC7HJZ769nkob9gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5a9J5J/; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEuGyeeN71qV1zN+IDD2T0gOaSZgAZQmeeKyxkbZD47cLyxv6C+1Gvo6DDrNPEryZqIMX3ot4qJ3i1jBgI1qE7LMfLrzAyqIryfzGsah1rJFdzcdcp1dKb5cUfPsVaQLWAel/Wu3aZHdx6Fy8fMRO33k6Zq97nYtvd0XCybN7EvJ5Y70PUrMuDU2oPauZFWGzOW/OCM2/7B7LLiLaHa1RXglOMNWfOrNROO80CYZx2xV1JnIAMS1lnhCmRtxEixUI0J4+Ki3L6HJhyx6BV/JOWuTuh9y6n2CsnU7bfgHwWee0ghzO7bA+hNIspjEo6FS8Rt+Gks5uVKx09WHxlQGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgQHuGwJdlBZ3eGDsGtZNadxJL1VrI90zT+eC/OkuC4=;
 b=PUIoJpmossnND+5Z+/vzE+ZZbhbTGPgpwO23/YL4HYOthp4N8ZaJXOaE+KcwkkxghwyZ8usx9zmuA/Gs3Z0VpRp0Uoxdm5huq0xrSdDuNON42L0cw/1R1e0i7lXxYeNAAmxeakAJ3c+fMCaskqScR64RtHto/USYnGHoLTtHqF6eK43kqN2VYvy96yuRNKNOspakLiqxqZJaLp8xC/xcP40psZkmAcEg+l0faW2/4t9ji1xlTZDs7K6S+8ZFWG9O+/Q7fHwIc1EKhL5heAFI5seWL3rUJp2gFqbAsepdZQNnQLbNgTOfozcgiduSrzV4mfGU2GH7EDdesMyAJJD+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgQHuGwJdlBZ3eGDsGtZNadxJL1VrI90zT+eC/OkuC4=;
 b=C5a9J5J/hK9oE74nL5Ps1G0jW4OFS14/Te+sFz2/GFSCCnLPoE0RLulaLnQBi15jM8ZCeNyl4o+nyz7mfBa1E8KDxZTHZAycCBMnoJg/QLrmbBMfTbsxkLAntk32GAQAmD1Ku0RLFEFa33jWCJFWzB8Hgr/Z1SBIKUFv3C+bRMO0idd0fDRIjOAzTlhkYoPurtm+DZDhQKeaxG3p7HCJee88Iy9t6YLc+wT8BJ0f7Mgyq0Y0+ygAAIpeyGOguk7gBdAe5BgNkkx9XUNrI4oXqf25Uf8RxIQ/qKLOtRrJbVgxUftk+7aixHTOfBEKhPjsbmvuZZBZDLnjzFRzutjKSQ==
Received: from PH7PR17CA0050.namprd17.prod.outlook.com (2603:10b6:510:325::22)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 17:02:05 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::b3) by PH7PR17CA0050.outlook.office365.com
 (2603:10b6:510:325::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 16/19] iommu/arm-smmu-v3: Add arm_smmu_cache_invalidate_user
Date: Tue, 27 Aug 2024 09:59:53 -0700
Message-ID: <3548bfff43a0e1c072b77fc37a1a8a6c930bcec9.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: e48426dc-876e-43c0-e8ef-08dcc6b9fa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqQUgPGKhDgAA5/dgaTpkdnSmr6EUsI/kEQUsMdvkqgtDYfuvUCwTcy0NVby?=
 =?us-ascii?Q?grTYVmNpAlwUElxdo2fDIm46rj4Np3tpdILnYY1fCc7vtAdNfX5v5HUdtTyK?=
 =?us-ascii?Q?N7YxQLyV7PfyzopOma+QAgAd+yqIq37GA1R9vfIh/4Ty4u614S2BBXMKRHj4?=
 =?us-ascii?Q?YGSKfzpUjRasKdK9dnnw5Pq3snAQuxvWSNlMcrR2J981OSYxjLoupTFaRwsj?=
 =?us-ascii?Q?2KYSLPtF5p2AQ3aQdqnVNOehX6jhoGBHm+i25f8hxYvLfPZvuOnsHdUlKvZ/?=
 =?us-ascii?Q?dUFaLjIUhfoWaMAVlblnlARp4nsc9FSMDeBJqKyS+jbowB1uo4F1DXjjaRWr?=
 =?us-ascii?Q?cnYeGr1ZXhBiOacLZZR0qHLoYKxVysW0wBaxo2dbl5TTuMc2azFl2VuN5fqd?=
 =?us-ascii?Q?pIyG/+RZj79GoVBWEtQk3GWQfylLGpoagd2qHkSkcHGA0F2cB9McBMKCzrW+?=
 =?us-ascii?Q?CgWZ938cuJzupXDhNajSn7Y7tQxbuq8zJ3YlWPoSGCtOiU/+bkQrx7zJNrIh?=
 =?us-ascii?Q?w2jC+ag+S5oQO8ZUWMAuNcWEgYlbmO0GdDPz5DUiAfMpzb5aFOheXoqXzxqg?=
 =?us-ascii?Q?MCrwnSaHv7DBQgKAlc4PLvFtguCHkNZXwrbYWkUCffvmc/amFuIebFN5Nzgw?=
 =?us-ascii?Q?odhTfdsFr/IqEpTUxHJb5fUZImhsYny7C2O6Xjm1i1CiFfSPEMBEODr0shAL?=
 =?us-ascii?Q?jF+fZjx2KLTi0p83qyNlkVui9KiKYSMxYRjyIyfOqpb74bxy4UqxsUZNgg1V?=
 =?us-ascii?Q?t9ebaGHFV+G3aWK0RFu6wovTE1CLnPy9g9y3DJ+K1bVuhFazm1I4HNV/yrmn?=
 =?us-ascii?Q?s+Hy+p8wil66UrQTi9lzompEhd+y/PP9GSVi0H+XSXfDrxbiTXL+hRqn+tfU?=
 =?us-ascii?Q?WwxQ3+NDIQ4R0oBmzFSz+vEW3F6LdvmRnpryQMi1gF3wuqFCABUN50ljeLqL?=
 =?us-ascii?Q?451yPJ8Nh54WNOzCr91G7/NNe7BwwIO0N/iRhxut5q1fPvHsk6ZrDgR+VHEs?=
 =?us-ascii?Q?XC/FCWAMh4QAzjZaYGYPkQkZtwHq4nF4o0+C6ZwOD2riZwD6SAjs5q+cHIcM?=
 =?us-ascii?Q?5j2tI4v5ZfUw+QhU3LigTcyijuWdjWcmDR/Md4kkfbZnTHlmy0norKElcxt/?=
 =?us-ascii?Q?UqF16pKpTBKZNy7lO5MjESiPhQ3vFjqPY9Nx7s7ZpDHgUvPQifhxeU+KNt7D?=
 =?us-ascii?Q?v6uc7LnXj8TU4P5kHiwMltds31NzX4rEuvgKyowYidz+CNZmuAAJWSXQjbCs?=
 =?us-ascii?Q?w3/7bjzXq1JTIbKYR4kaScrUzwAiOUC1+M7ufaRLhORlQn2XMAqf4O+cOHVP?=
 =?us-ascii?Q?StKt+4KVgU7bc+Z+rpseGLgavKuJJ95g3Y9SgUoens+HusEDTYi9K6Pi9lRv?=
 =?us-ascii?Q?FYQHAomCOJA+Qi9VPVVNCWpxFfmIFOh/24MHFepMA3KsvxQhIoGCt0lscYgg?=
 =?us-ascii?Q?2Cup84QitDQApf8evYgtyWY+LvM+AABi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:04.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48426dc-876e-43c0-e8ef-08dcc6b9fa3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

Add arm_smmu_cache_invalidate_user() function for user space to invalidate
IOTLB entries that are still cached by the hardware.

Add struct iommu_hwpt_arm_smmuv3_invalidate defining an invalidation entry
that is simply the native format of a 128-bit TLBI command. Scan commands
against the permitted command list and fix their VMID fields.

Co-developed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 include/uapi/linux/iommufd.h                |  21 ++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d40f1e150cb..a2af693bc7b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3267,10 +3267,117 @@ static void arm_smmu_domain_nested_free(struct iommu_domain *domain)
 	kfree(container_of(domain, struct arm_smmu_nested_domain, domain));
 }
 
+/*
+ * Convert, in place, the raw invalidation command into an internal format that
+ * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
+ * stored in CPU endian.
+ *
+ * Enforce the VMID on the command.
+ */
+static int
+arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
+			  struct iommu_hwpt_arm_smmuv3_invalidate *cmd)
+{
+	u16 vmid = s2_parent->s2_cfg.vmid;
+
+	cmd->cmd[0] = le64_to_cpu(cmd->cmd[0]);
+	cmd->cmd[1] = le64_to_cpu(cmd->cmd[1]);
+
+	switch (cmd->cmd[0] & CMDQ_0_OP) {
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		/* Convert to NH_ALL */
+		cmd->cmd[0] = CMDQ_OP_TLBI_NH_ALL |
+			      FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
+		cmd->cmd[1] = 0;
+		break;
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_VAA:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NH_ASID:
+		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
+		break;
+	default:
+		return -EIO;
+	}
+	return 0;
+}
+
+static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
+					    struct iommu_user_data_array *array)
+{
+	struct arm_smmu_device *smmu = s2_parent->smmu;
+	struct iommu_hwpt_arm_smmuv3_invalidate *last_batch;
+	struct iommu_hwpt_arm_smmuv3_invalidate *cmds;
+	struct iommu_hwpt_arm_smmuv3_invalidate *cur;
+	struct iommu_hwpt_arm_smmuv3_invalidate *end;
+	struct arm_smmu_cmdq_ent ent;
+	struct arm_smmu_cmdq *cmdq;
+	int ret;
+
+	/* A zero-length array is allowed to validate the array type */
+	if (array->entry_num == 0 &&
+	    array->type == IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3) {
+		array->entry_num = 0;
+		return 0;
+	}
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+	cur = cmds;
+	end = cmds + array->entry_num;
+
+	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+	ret = iommu_copy_struct_from_full_user_array(
+		cmds, sizeof(*cmds), array,
+		IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3);
+	if (ret)
+		goto out;
+
+	ent.opcode = cmds->cmd[0] & CMDQ_0_OP;
+	cmdq = arm_smmu_get_cmdq(smmu, &ent);
+
+	last_batch = cmds;
+	while (cur != end) {
+		ret = arm_smmu_convert_user_cmd(s2_parent, cur);
+		if (ret)
+			goto out;
+
+		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
+		cur++;
+		if (cur != end && (cur - last_batch) != CMDQ_BATCH_ENTRIES - 1)
+			continue;
+
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, last_batch->cmd,
+						  cur - last_batch, true);
+		if (ret) {
+			cur--;
+			goto out;
+		}
+		last_batch = cur;
+	}
+out:
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return ret;
+}
+
+static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
+					  struct iommu_user_data_array *array)
+{
+	struct arm_smmu_nested_domain *nested_domain =
+		container_of(domain, struct arm_smmu_nested_domain, domain);
+
+	return __arm_smmu_cache_invalidate_user(
+			nested_domain->s2_parent, array);
+}
+
 static const struct iommu_domain_ops arm_smmu_nested_ops = {
 	.get_msi_mapping_domain	= arm_smmu_get_msi_mapping_domain,
 	.attach_dev = arm_smmu_attach_dev_nested,
 	.free = arm_smmu_domain_nested_free,
+	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
 };
 
 static struct iommu_domain *
@@ -3298,6 +3405,14 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	    !(master->smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
+	 * defect is needed to determine if arm_smmu_cache_invalidate_user()
+	 * needs any change to remove this.
+	 */
+	if (WARN_ON(master->smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	ret = iommu_copy_struct_from_user(&arg, user_data,
 					  IOMMU_HWPT_DATA_ARM_SMMUV3, ste);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 79afaef18906..6c8ae70c90fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -523,6 +523,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_NH_ALL     0x10
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
+		#define CMDQ_OP_TLBI_NH_VAA	0x13
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
 		#define CMDQ_OP_TLBI_EL2_ASID	0x21
 		#define CMDQ_OP_TLBI_EL2_VA	0x22
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fd7d16fd441d..f3aefb11f681 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -685,9 +685,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
+	IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3 = 1,
 };
 
 /**
@@ -726,6 +728,25 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ *         (IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3)
+ * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
+ *       Must be little-endian.
+ *
+ * Supported command list:
+ *     CMDQ_OP_TLBI_NSNH_ALL
+ *     CMDQ_OP_TLBI_NH_VA
+ *     CMDQ_OP_TLBI_NH_VAA
+ *     CMDQ_OP_TLBI_NH_ALL
+ *     CMDQ_OP_TLBI_NH_ASID
+ *
+ * -EIO will be returned if the command is not supported.
+ */
+struct iommu_hwpt_arm_smmuv3_invalidate {
+	__aligned_u64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.43.0


