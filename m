Return-Path: <linux-kselftest+bounces-22786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E09E2F9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2AAB43CA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8D20B1FE;
	Tue,  3 Dec 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/NDcl9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF3205E31;
	Tue,  3 Dec 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263866; cv=fail; b=mFbgz268F5gnnV57x0stN5XWDyp1Mr+bYaB5d/uWyLUm6W8QIWWLQ0jA4sklxyUhdi6TVfqI8HLUvI2LZm7MnYECymm3Q1RB2H9Ecmow8s4M852GAi5+TKN36ibAFe1yKEhDRD4AV8uvkaDtb4TqkbXXZn0eeVe54ha+84eHEK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263866; c=relaxed/simple;
	bh=jD3QI6TREKgfkXF+zFFY0+YvWhn4z4bHhmMtca578jY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiuZjTZwclynEwMuDMxNTBJOMyZ3X/AV4B+XLajhP2owcyMySuNXoomAnJd9gknC/W9xY3wz5ESlO7ANgxmVe2odWqmVnTdBFuBuHWZHnnIyeqG7DpqwDacw/uGzr60W3+KgrqOZXLms9FbRUot310uo8CAMiAJvn2oDPu/MxLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/NDcl9z; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vADHkl/sHsIxsZ62wD3JFsOk/zh3TiCO/1T9gkllYG3es7501btt4D1d6scoh4A2+ugdKdtOfMtSQvF+jibtPvke58XTDng87YDfkREVRS7WHh0Ou/UDUSkIRT/4oywPixfmzWzWCVhSSn43nk+wbnjrAkb2aJ/q5mOF95NYtWtZm+UrOPbrfsbGxjZ1+xzFsRFPREzHQu7sklbRetlCkolIFp7/n3LnwM4UOOwc2Gt/YlHpj3p7yas/QYKRtdgSgjZWFCx2i5slxgYYpf4r0WV6mclNWnwQrjAPHpsHsXaXX3Ob5JMR13yCyS9+eFSA5DpPFZ7cn6kRzVSJXuXaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz+PkQd0y9lcDfj6LfaI68k2iko+rUkTXwu93/VdqjE=;
 b=Po8YjdTUUa0C3CHJoaAB7JLRfy0jSpGm5bXdU7sn/158imjsxvtYcbA/lpaa8yO24BM2Z2wwhewjyI2G00kT9OG3dct4aTMAnytFGqdRyLmupmN9ptkWqhRywhWkXrMg6VjHhRJtw8EbTTPYgebbUMjOia/gySwxDtT03aClZSF42ctDbTRLy5bC/Dc8BeAkjzpzY/NkTJhoNEhWPh5aherO2bXcDjA/LDFsltuqQ8PYZ8GdufEMZ7j7c2xiX3TrCq/13g98G4BflQYIvA5516yPSMiibBwEtaQFyS9hMVSlypqss3AMKme0eDacRJSR/8VnG8P1gYL8cAoknDaZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz+PkQd0y9lcDfj6LfaI68k2iko+rUkTXwu93/VdqjE=;
 b=i/NDcl9zuZ3wHv7UB43gXYQPCKyZjQIIQ0AkqV5DHTrOLkd5h7snr9dVoo7bLkgnEvbFWjMjRWCY2pTKVmc0moGbC51UA0I9oBbjXMT+tQdNzLa3uRodFC+WkXQwaGmHZpuVKpTNonxczyztdqEHGvj2lWl1WDxPN7CB6FWjzN5WZPR/8BM2UoBnSf9bns8Q8XnLPjFom3Ne3s5OyYLuTpoYWe6egyodxaSTVuoBGF0ZuYCsbYlKCF1NhqNdc3aaCbS0atjDiV3RtoDtOFN1Uv80UgRDLk+pNbl52/K73equL1ivSwg21Q5lBUUk9JjGQGbk1Iem2yMXoe/O/sU5lw==
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:10:54 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::4b) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:34 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 01/13] iommufd/fault: Add an iommufd_fault_init() helper
Date: Tue, 3 Dec 2024 14:10:06 -0800
Message-ID: <3bc49512a42b88130cf447a7ac10acf5c02e056c.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fa567a-d783-4cc8-ffe9-08dd13e75a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UH6/CUOozmiDphQsdTLndBxowY9OFaTOTYHzCElgpCPQ9BDXXI5McrTa3NFf?=
 =?us-ascii?Q?diCeAsSr3nzpqCIGUvmyn2HmZLVG36rwilEegxdtNYlnpzeuvBtGEnTgh+7i?=
 =?us-ascii?Q?Nkb7ElwXnSnZoGp65w/66KwBugVQV11V1tYkknorvGFey9oOwOxXd3hyX2LY?=
 =?us-ascii?Q?bZWOTSPNwN2Y9mwMsQl/mwhU7hpvums5/avyFI2EYJJJcGfGX4YxeCdFNqrQ?=
 =?us-ascii?Q?nVfrhfnsCU92DEkOIrK9w1qmXhyDlYmKwjmUWcMjpii4m8G4aBsWvFaBAKiZ?=
 =?us-ascii?Q?4nh4mij5rozLNZMsSDlLRT6gZxK713Frrm4zUf/czV3OgwuZEKrE9la7kOQ8?=
 =?us-ascii?Q?PrQUbArPw7ifDm17rhQwZPxbH4BCi1YPVuZK5gNJo1uMtoG3YkT+1FKyqh5K?=
 =?us-ascii?Q?VpFKPz4WwgL//JXQ8urDlDMcBZGAAPhqavxlyNFzwfqjpJpjXKi/H/rIHoLY?=
 =?us-ascii?Q?pKidgioN2d/0sS0wS+xWBD9Kw6h72A5NTqbimtWvdVdWHBVqodt1iKeF/4Cx?=
 =?us-ascii?Q?b57jkkpjsnqJFtHZVgs6o3SG33K9Ed3XoVRsq7msKGdhImv7USWOaNAnW7oR?=
 =?us-ascii?Q?2UDvb+iwi98jwei+JHiBr27CRK/dxJe3XXxTk7JGXQlbKe8F+04CMXNjGciv?=
 =?us-ascii?Q?2J2cIih8V4YtPPOiXLdLJ/LOrcU/aSyANxyHyVNZ9GK63s5+4YkmYCiarAaU?=
 =?us-ascii?Q?4MQjQHoxLSclC74VKCK+vqNTKTLxSd98eijyxgbopoQ5/upu6DpzBMK7FwsQ?=
 =?us-ascii?Q?mEKofXmQijRAMBCC4oPR4I0ScfZVbnC3RsYRLQ8nZRnL/8C7g5emtqy4MqnV?=
 =?us-ascii?Q?41N0gIVeGs44fK5l66/1AwZHPLkrhFwg9H6BStPN7tQM1X14Nbc3hZOcEV1N?=
 =?us-ascii?Q?kzzX4+8NZ9wBMEHqg836L65V0yTkHjEk1v+Rj4ZwfCqR/+p1Z7bMUJEwe/kr?=
 =?us-ascii?Q?5okrKKYkjCMTZD4etaVul0BrJsP00UEXA2DQYppcGvo85oqNrNTKZKSP70FW?=
 =?us-ascii?Q?XmGkY8+zgSjuacQ1Pz9IBunvmNAsK7Wb2vg+4QMFcIHDZn4ufIAw2Bwcl6II?=
 =?us-ascii?Q?59OKEhDnn7oEGPLRJQ+j6xDfhM8u50v3VkOUTvUx8l5r4WJZhqVaLb8//LyP?=
 =?us-ascii?Q?78Qv5/dpXBr7snsL0gTv0wJns1xjlid+yJzm4gzP5ijJlG89yjjFvyLEOoNI?=
 =?us-ascii?Q?46kmv/uKWy0HY1KZBleER+N+xZkhxvIZ08k3KAs6SBly/FTooRjWKTK2RADS?=
 =?us-ascii?Q?w9YzEqZLSPNVajtJkJjVoSloiwiuQKxUiMxbNOVcEgiHo6pl5Kx0/htfx9QL?=
 =?us-ascii?Q?IyKaJdidDNkYIw5poMnvhLLYdNhxDxh+ygzvslqOU6fQvux+iA2tIZNup48Q?=
 =?us-ascii?Q?37iMTiwYd/Nq4TMZu+Z9spHB5RfsMMUGyg/sIbEFVXB6SuLxrrAGn6s5eZiw?=
 =?us-ascii?Q?+W4c7KgIl1ySlUsnqMtvJr7eSpiPeeVZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:53.1117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa567a-d783-4cc8-ffe9-08dd13e75a7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162

A fault object will be renamed and shared with a new vIRQ object in one of
the following changes. Add a helper for the new allocator to call it too.

Reorder the iommufd_ctx_get and refcount_inc to keep them symmetrical with
the iommufd_fault_fops_release().

Since the new vIRQ object doesn't need "response", leave the xa_init_flags
in its original location.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 48 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..87c811b9c0d0 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -367,11 +367,35 @@ static const struct file_operations iommufd_fault_fops = {
 	.release	= iommufd_fault_fops_release,
 };
 
+static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
+			      struct iommufd_ctx *ictx)
+{
+	struct file *filep;
+	int fdno;
+
+	fault->ictx = ictx;
+	mutex_init(&fault->mutex);
+	INIT_LIST_HEAD(&fault->deliver);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile(name, &iommufd_fault_fops, fault, O_RDWR);
+	if (IS_ERR(filep))
+		return PTR_ERR(filep);
+
+	fault->filep = filep;
+	iommufd_ctx_get(fault->ictx);
+	refcount_inc(&fault->obj.users);
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		fput(filep);
+	return fdno;
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	struct file *filep;
 	int fdno;
 	int rc;
 
@@ -382,27 +406,12 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
-	fault->ictx = ucmd->ictx;
-	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
-	mutex_init(&fault->mutex);
-	init_waitqueue_head(&fault->wait_queue);
-
-	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
-				   fault, O_RDWR);
-	if (IS_ERR(filep)) {
-		rc = PTR_ERR(filep);
-		goto out_abort;
-	}
 
-	refcount_inc(&fault->obj.users);
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
-
-	fdno = get_unused_fd_flags(O_CLOEXEC);
+	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx);
 	if (fdno < 0) {
 		rc = fdno;
-		goto out_fput;
+		goto out_abort;
 	}
 
 	cmd->out_fault_id = fault->obj.id;
@@ -418,8 +427,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-out_fput:
-	fput(filep);
+	fput(fault->filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
 
-- 
2.43.0


