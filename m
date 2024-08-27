Return-Path: <linux-kselftest+bounces-16439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9839614FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115871F2317C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F41D461B;
	Tue, 27 Aug 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ur+OorAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A051D45F5;
	Tue, 27 Aug 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778134; cv=fail; b=WI0NzaajY5IR7sLEQo42c4Wei50vdpOhb8mWUoJzMvZtWvhHI4WL+m4DlPFr5xLif6xBVwnExOSxO0w54CrApmcKry+eGjUEYtVAJGE673EXuXs5Ka3BwoSiTE8Z40ftRrJNePRtTjAPXBLZJS77eaEuFKAgUs6Yk4Yf0qamJsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778134; c=relaxed/simple;
	bh=z6CoklI7fGfDu2fOkVYhUvd0cQDAkAJWwtzQULY6cJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vETHEH5idwpS4fyEZA4plcjq2H3mbV0sMDqHQZv+XLBIN0OsG1MMbmnClmWH7/Ct09C5l9IlxsAil1zbevXKq+pqoaj6GR4Np3+vxMWh5Btu0gFzqzaHgnAWxNcpowObwj5fKS/08zO7f/6+EstKMnQaY017mKd7jX6tNRGVu/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ur+OorAB; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TA4QwYUX5tQ7grnyv4HsptQKGtSCSmiNc27DF4TaSUogThGUAQZhyN9DMlwPdIYPCHAQEK105Qv64EmfK1f9LJDsMlTg72Fn9brcz6zqaljHsqar2cQ9gUIzStpZuRFi9tMghR1cpEAjGzrPu3nb6e/yi6oCCAZoN/less8m/I1Kc3HZOo1am0VLxO1py3mshEOwx+j+prQaYDyMPyhey2PvbYdjv9dYgjMWcm63mmjY2cr1A1thtqCwqg977I0TMU7CeCyyfJsRJC6fqwsL7BqxDm86n6v4bNWtwQRt07NGqPV9dwy2D1Sv/pzjyolHzR0A2/rdMGYBC0nLuq15Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9gwxzjSvuGPTbOjmKyokAYc9NQ9/GvPyzwo1NIRlQA=;
 b=h9VMi3I04nOFfjw+22wHW1+Xi5nrP1OHrvjh6eXUDC9HXW4evIPeuIGMXijgDquNhWrRgiN9RCa//RAZR9uMEv1ichrvIO3RuaDMmQ1nW3U7LuPLm3psKQeYDM+UVUXsuIeNFwjKXDTHyIcK9sD4BWue3uooU70L3jPp5agWn7HzYkOuE5lvAaG9fw03676ZLtz5ILn0z7oKnVIYR1Y4knwCg1cnLpw355rRcqRYJ7rIZkLwS9DQfgHJsqyE5DLn86bdXsboqDK28/GExmSglcY1U94OVGuSb9cwRLGWoT3YPa/z5HR9jW/d/pdn9pi4bEip2BrUQQI3Oajg9968aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9gwxzjSvuGPTbOjmKyokAYc9NQ9/GvPyzwo1NIRlQA=;
 b=Ur+OorABI7h7xR/vSSBobkCQkHaHvwELtu2xQg8HumIbgnjw1Q+32qlu2iUGkPDMZjXqWEtSKCXXB9EcluUHKSo59rYJBQpdjaPRMMfedSusU8tt+LxXvazWwMPhvMZtNX5Jq24GRqThXgpWf4iZtemLkEuBBgKSgLYbuxbqpAKab+MM1+sBvg3gwDLyGmDN/11pgPi8qHfbY7/q6mhJR2chyudo3Ic6jvr1EaJi40LMpuqN0GXTNFmF9Ydcfp/4VCyhpW7JQlKd55mus0qYrn0z/ej6VkPuLjVS1qxApUCiupJDoxd7oRR797vq3ofMMyPD3hZlZSED//gwkW7TXw==
Received: from PH7PR17CA0072.namprd17.prod.outlook.com (2603:10b6:510:325::20)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:02:06 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::7d) by PH7PR17CA0072.outlook.office365.com
 (2603:10b6:510:325::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 17/19] iommu/arm-smmu-v3: Add arm_smmu_viommu_cache_invalidate
Date: Tue, 27 Aug 2024 09:59:54 -0700
Message-ID: <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b50a8f-8dda-4362-7eae-08dcc6b9faf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/5co3YfiFIiHlr7VIKZXaf13Pk20CqvzPtsNpP2c3cPpdfWqRxNbTwowGyy?=
 =?us-ascii?Q?n31cC64zJIcgim73jIn1pUE/znzPGgF+XSt93/aozXaVCUhm4veXRPsYKFiF?=
 =?us-ascii?Q?hHvSNi7MPNq4DaUoTPged6R7NU58kAH8OCClUhcP/nqMLLyLklqZ0XAIHtpA?=
 =?us-ascii?Q?7hHBbSJ2AXjZd4sIXILkk5b/s+W4FkKfQPJ8hAKyAkWrDlhFpiH9NRbG4lgI?=
 =?us-ascii?Q?MRNMUo+Qd7EqjVFFb32qoD1BPWxSosCzLyWI3oHF+aS9RHqIofrXIsocmN9e?=
 =?us-ascii?Q?xl/AkorsQBgnb/Jr91Yn9tUWPwUGY1NLUc8OkZgR6fxcUiq2x3/noJDi1TA3?=
 =?us-ascii?Q?dd5wccxm3bpAQbGJwqSG7LEq0DKqSKu9LUWip0t16aGBFj9ZUtxXJR5s1/Y6?=
 =?us-ascii?Q?pswHqkbq8N9rf1x11YvWBiyq47erkMZTCRxjiq3FfDGB2iIBYlT71sck0CAQ?=
 =?us-ascii?Q?u2pOd+MOEs0K2CTORk2w786Tcq2pdX4DnKsLVF50o4LBzwsrQkx2Q8WVTnPw?=
 =?us-ascii?Q?CczFlOLwdct1htBCOAg3rnsRZyekGNwjBYkVlv0jLf6VkMCH/7/IjIJixHh3?=
 =?us-ascii?Q?WA9EAxAvy5Afl0t8OBCNCXRwNJc9Qwtu4vBpVvCblwC25qGMaHFC57qyPosd?=
 =?us-ascii?Q?wn1Uzl5LBgfUn6MljNgMO36Xv7Ks6ubAhdKmdou5Q2nY3PL8c3HU/JpKs9A0?=
 =?us-ascii?Q?DFw1jc1+Uz+UiDjpuWrTxzgqElzb67IUPGw2k0z/O/ic+L3YstAyG6e7Hla+?=
 =?us-ascii?Q?+nJ9jkezN0E7BsHwJMKMerIUU2Ioe9gmxlrcP7wbuw5CN7fKb62S708QqiB7?=
 =?us-ascii?Q?ZA3ssrl1ZdQ7kvi2EeUudbCj8Xb6TOIQl+FMcIWI0fDnqVyG4E0UAHw4wTc8?=
 =?us-ascii?Q?LdwsWuNsxVB88i1fmiCBn5vcr2s+d3xrliTEG6RSal+zRFGxVayvgLdp9D1e?=
 =?us-ascii?Q?alDJqDqzjju8CnF46LINryPsNlRmY/P2y0GBPsvfpXjuDPzOOjGkLse0GE3a?=
 =?us-ascii?Q?HTeXiWD620kYB+ue+z07DF4blL0+iCcXrmer1gmMcOZl3RCZiebadBE3CVS4?=
 =?us-ascii?Q?v7XuY+iTX3Ig4z3YIEXF39oeNXSdDDEzigtjzHzCUOBYcs8afRtOm3/w6IMQ?=
 =?us-ascii?Q?DnEK+rLG/5HlRWsr4z9Ob0ex2MROsBYvX/x6fcopmYQXuk91t7gwxch8aRJI?=
 =?us-ascii?Q?OmoBjaWnlJdNCFhHLMk0qsYCbRkaQ5ImjFFKMSeWfEhp+PgUBLchSOFrRWRp?=
 =?us-ascii?Q?eJubYSUJMZofR0Let/pzuIYWgrVf5PZEJrxQbVWrj7W5b5nsz3v4c7T6yUGp?=
 =?us-ascii?Q?ygFcEOIZ9ZrC2zDVx2qyzCIhkoNUdespOLu+DuTGvDIm6fWWPlmVzGQZWwcF?=
 =?us-ascii?Q?dvjDJU6jfDu1KitiO0qWXC2TS6lyNfeE1erM5UZZQOn5RM1oVtkEuMSvU+kD?=
 =?us-ascii?Q?tTpgGnqoENkSAemLlhFuQ0nk89sXrGom?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:06.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b50a8f-8dda-4362-7eae-08dcc6b9faf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Add an arm_smmu_viommu_cache_invalidate() function for user space to issue
cache invalidation commands via viommu.

The viommu invalidation takes the same native format of a 128-bit command,
as the hwpt invalidation. Thus, reuse the same driver data structure, but
make it wider to accept CMDQ_OP_ATC_INV and CMDQ_OP_CFGI_CD{_ALL}.

Scan the commands against the supported ist and fix the VMIDs and SIDs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 76 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 include/uapi/linux/iommufd.h                |  7 +-
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a2af693bc7b2..bddbb98da414 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3267,15 +3267,32 @@ static void arm_smmu_domain_nested_free(struct iommu_domain *domain)
 	kfree(container_of(domain, struct arm_smmu_nested_domain, domain));
 }
 
+static int arm_smmu_convert_viommu_vdev_id(struct iommufd_viommu *viommu,
+					   u32 vdev_id, u32 *sid)
+{
+	struct arm_smmu_master *master;
+	struct device *dev;
+
+	dev = iommufd_viommu_find_device(viommu, vdev_id);
+	if (!dev)
+		return -EIO;
+	master = dev_iommu_priv_get(dev);
+
+	if (sid)
+		*sid = master->streams[0].id;
+	return 0;
+}
+
 /*
  * Convert, in place, the raw invalidation command into an internal format that
  * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
  * stored in CPU endian.
  *
- * Enforce the VMID on the command.
+ * Enforce the VMID or the SID on the command.
  */
 static int
 arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
+			  struct iommufd_viommu *viommu,
 			  struct iommu_hwpt_arm_smmuv3_invalidate *cmd)
 {
 	u16 vmid = s2_parent->s2_cfg.vmid;
@@ -3297,13 +3314,46 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
 		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
 		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
 		break;
+	case CMDQ_OP_ATC_INV:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+		if (viommu) {
+			u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
+
+			if (arm_smmu_convert_viommu_vdev_id(viommu, vsid, &sid))
+				return -EIO;
+			cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
+			cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+			break;
+		}
+		fallthrough;
 	default:
 		return -EIO;
 	}
 	return 0;
 }
 
+static inline bool
+arm_smmu_must_lock_vdev_id(struct iommu_hwpt_arm_smmuv3_invalidate *cmds,
+			   unsigned int num_cmds)
+{
+	int i;
+
+	for (i = 0; i < num_cmds; i++) {
+		switch (cmds[i].cmd[0] & CMDQ_0_OP) {
+		case CMDQ_OP_ATC_INV:
+		case CMDQ_OP_CFGI_CD:
+		case CMDQ_OP_CFGI_CD_ALL:
+			return true;
+		default:
+			continue;
+		}
+	}
+	return false;
+}
+
 static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
+					    struct iommufd_viommu *viommu,
 					    struct iommu_user_data_array *array)
 {
 	struct arm_smmu_device *smmu = s2_parent->smmu;
@@ -3313,6 +3363,7 @@ static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
 	struct iommu_hwpt_arm_smmuv3_invalidate *end;
 	struct arm_smmu_cmdq_ent ent;
 	struct arm_smmu_cmdq *cmdq;
+	bool must_lock = false;
 	int ret;
 
 	/* A zero-length array is allowed to validate the array type */
@@ -3335,12 +3386,17 @@ static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
 	if (ret)
 		goto out;
 
+	if (viommu)
+		must_lock = arm_smmu_must_lock_vdev_id(cmds, array->entry_num);
+	if (must_lock)
+		iommufd_viommu_lock_vdev_id(viommu);
+
 	ent.opcode = cmds->cmd[0] & CMDQ_0_OP;
 	cmdq = arm_smmu_get_cmdq(smmu, &ent);
 
 	last_batch = cmds;
 	while (cur != end) {
-		ret = arm_smmu_convert_user_cmd(s2_parent, cur);
+		ret = arm_smmu_convert_user_cmd(s2_parent, viommu, cur);
 		if (ret)
 			goto out;
 
@@ -3358,6 +3414,8 @@ static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
 		last_batch = cur;
 	}
 out:
+	if (must_lock)
+		iommufd_viommu_unlock_vdev_id(viommu);
 	array->entry_num = cur - cmds;
 	kfree(cmds);
 	return ret;
@@ -3370,7 +3428,7 @@ static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
 		container_of(domain, struct arm_smmu_nested_domain, domain);
 
 	return __arm_smmu_cache_invalidate_user(
-			nested_domain->s2_parent, array);
+			nested_domain->s2_parent, NULL, array);
 }
 
 static const struct iommu_domain_ops arm_smmu_nested_ops = {
@@ -3863,6 +3921,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					    struct iommu_user_data_array *array)
+{
+	struct iommu_domain *domain = iommufd_viommu_to_parent_domain(viommu);
+
+	return __arm_smmu_cache_invalidate_user(
+			to_smmu_domain(domain), viommu, array);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -3893,6 +3960,9 @@ static struct iommu_ops arm_smmu_ops = {
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.free			= arm_smmu_domain_free_paging,
+		.default_viommu_ops = &(const struct iommufd_viommu_ops) {
+			.cache_invalidate = arm_smmu_viommu_cache_invalidate,
+		}
 	}
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6c8ae70c90fe..e7f6e9194a9e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f3aefb11f681..0d973486b604 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -734,13 +734,18 @@ struct iommu_hwpt_vtd_s1_invalidate {
  * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
  *       Must be little-endian.
  *
- * Supported command list:
+ * Supported command list when passing in a HWPT via @hwpt_id:
  *     CMDQ_OP_TLBI_NSNH_ALL
  *     CMDQ_OP_TLBI_NH_VA
  *     CMDQ_OP_TLBI_NH_VAA
  *     CMDQ_OP_TLBI_NH_ALL
  *     CMDQ_OP_TLBI_NH_ASID
  *
+ * Additional to the list above, when passing in a VIOMMU via @hwpt_id:
+ *     CMDQ_OP_ATC_INV
+ *     CMDQ_OP_CFGI_CD
+ *     CMDQ_OP_CFGI_CD_ALL
+ *
  * -EIO will be returned if the command is not supported.
  */
 struct iommu_hwpt_arm_smmuv3_invalidate {
-- 
2.43.0


