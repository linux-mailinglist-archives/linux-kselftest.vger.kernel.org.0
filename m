Return-Path: <linux-kselftest+bounces-24023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EBA047D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B633A1752
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E51F8923;
	Tue,  7 Jan 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imSraK2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F81F5419;
	Tue,  7 Jan 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269888; cv=fail; b=cOSQgPZ61eSw9Ljw1Gzqml5QjFxeMtAAbSBfMRNY3VCJlrrCgGZzYreYPmT7XM8WwNkGip1fIwbLiGiFb3ZA/SqgaAdl2kogKMHLKfXeVoLkjb2nX3o5gfDqb8mBoWrSKQTxmwwEuKxIGfH3ja/22zIFq9NMTmW9ccmii7xU7YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269888; c=relaxed/simple;
	bh=EyUjKClCbMYJZgltIFBS8tvlMQrXFu3sJ3g4/blqaek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzSMf/8VrLkIrF3Fuwmecr+Q2HuYDDSTihNK+6gzJKtbUHSBxh8Pbxy+TYzfRNeZEAB0b9HVyZq3TYI0wuJWeqraIck5alA1GYQqL6O2IItuXFgqxQTAY9J1tHGo5XBpfj8YCbcgBOFspChru8qBkZw/JSKy6W3/8bpzxZ3kbsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imSraK2m; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7srKtizauBGjgtjUHDNFpVrufuLD1GSU7ppB9GMo/HNtu2cW3oQJSuTBbcEAW1N7FHgTRJ26xuJkeYZjebUV/r4kw7BfM5DZDyEGm2ImBiDlDywHAUrN8r4GH9w/hnIjLH7XjWldXAMbm+0+lLF0RuBTDj7xE406ZYWxO8IxmS0Pp1lbV0Jsgv3ECX+/Fml+bWdpzTPdKiBm+UW8aFCVI0ew0UP+UrTvaNTiBVQzrCA6n/4Kadl4BmP+072uE3huz+TtbWPyuTXTI5lEFLPzHwFbHciTTWwk+fDOgt4xuBASooP6TQpVWZJ2yIHO9CPQjzVHRxjlLA0HXDhZgmSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfHoRj1WC5ljgSSUhvbNe904c/9I5exdjZ4GUcFUI8Y=;
 b=m5TYku6ekd5bfGcDGp2X2so/fHB5kIcCQS6vFDLS3NTU0ig2R70u4EaUvrDuFrjFOLK2aviEf2kQOVub/3j53EOg4SOTQcYyeFCQwXDaK4+4ONNG7kPhfrcRh0kOfny1gq3ghz0kb/f6SXWUCRJdwayl+T50Drf/iqWeJp1rdv0CHKvs+BCLEq3R2ffAE3O4IO6jNf5cJLmNWVVP58pL+1hDfUhy0iEwraU1uoDoRGsej2s3U0BMOsnP3FYEJwIyHIStVztX0GeJ/kXoM6mcaFpHJyKNbsk7pzePf7jRbfNq4DL7Bq7WFMm9qvsAAb/X1ki6Dp8/htBrzVzflgVv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfHoRj1WC5ljgSSUhvbNe904c/9I5exdjZ4GUcFUI8Y=;
 b=imSraK2mWZ/wAmq+AmYXzwLHIlpGctzcb73w1agaCUj6xfCLiFsyRfRU+noImwiwGwaqoTND1JtpGR1NlLGCW6CVXwyuYMUhd+dcKQX03lnVHYZRvgVJUXQ2HJpmWJN8OgRhoyfT0E64H6M32+B0D13dEV4yzKJnq5JTBX7OQb+JQhNAREGYzBJfl9OODBmfYazSxaI7umatQhNT1LcmD1FwBVsPN6bD9URTpnwp7x1zvBt5YqCQJpMjlNO75yY8bYxFDl6FYjoQ3MykGLPRB0sulgEaXqIAKJnnJF8o4smUA8m83I0lEFH4lO66FyTqX6SQgNoDdNJOIOYMVyZC2w==
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 7 Jan
 2025 17:11:15 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::ce) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Tue,
 7 Jan 2025 17:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:58 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:56 -0800
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
Subject: [PATCH v5 12/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Tue, 7 Jan 2025 09:10:15 -0800
Message-ID: <02e47317606d0e6f1220596a98152f61f422167f.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 9935aedc-a1b6-498c-ddec-08dd2f3e4b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtrvDhB4MuqoYByCw4Vb5vLWcL+ERWthWldNGWu1492T1C7/vMYgNHDTnTBy?=
 =?us-ascii?Q?xHmT9kjrOuJEi1PSlFp5vNkX2bQAO9ZkhrNdUuIyjQys5oyQu26B2lOUWYFT?=
 =?us-ascii?Q?Rowfznll0rSqyoltx0nZrFUiIQPvxqGcpcrW0KapfhsI2wZP+Fq6nQIGjrZ7?=
 =?us-ascii?Q?ZsPjfq44s5sBhijions6LcSRqi8USTdvl3c8olX3fpcG8igMg5jqsAn5mgc3?=
 =?us-ascii?Q?qKE2n4Aj3Bnpfrk6Lo5GY9XGLDRnkLKhvagVEymxDKRcNkuqkGMs5swo6bK+?=
 =?us-ascii?Q?xmGut3y72P95ELjBYsgLV2pgcXdMY7Pg/ee6J4bUEuVmOzMhwW/EHliw44hi?=
 =?us-ascii?Q?fN4gQauccUlP/7nzf4STMjrMcztMBPurdW3ldwPL4eZtajqDg4rz05Kznjb4?=
 =?us-ascii?Q?g+sW2bjVjzGh/whRMjOrxrKC/PktffRtr9O1WcHwJgXnChvqvwl8PF6d3L5S?=
 =?us-ascii?Q?LN+UXa85lWQN4sMgU8LPc94Swu6iomJP80RT2dy/05FW8qjhiwjNi9CCocGj?=
 =?us-ascii?Q?zVOvxe7zC5EBAGumMHJ3Wl73IPNtlfIleE3rguXp5xjzvaHbriR6SIESZxCA?=
 =?us-ascii?Q?OufKHsdXav0uKlwmJ/A4zH3tpVEUHxUxcGuS+Eh5c48a31AMTCZmHS/Ou5xM?=
 =?us-ascii?Q?zEyQ3MuB+UpqPRlDsjVDtWT6Ld1MXMV4S+4EhshguijNY03Yy7hiLYW3CnBa?=
 =?us-ascii?Q?xXeV5AZNaE/RGB+IZvYpikd0ItOR8udupYhcf4F4EZ85xVKZKzclk9MsTCLd?=
 =?us-ascii?Q?tapsb7Pb1GBF/L2TgmhXRiJ4qGDbKA8mDeLJTzLxrmeEHpBxjpxoA2SmgKw2?=
 =?us-ascii?Q?vBEle01wDPU77UV+7jWA3TAKpQcQoWS71lxIzGLLojJ0rR3m38GPchjdfaNy?=
 =?us-ascii?Q?jTola25b2iBWbsmj/BoOVSJx28KhDkJ6D7uLAgMWTGNHPLYk7WDp1Ng0npvB?=
 =?us-ascii?Q?iTfzAk7IU0sTmthTnUq6LIABuRPqbNI3pGeLDxqZtOn5NTHcdVQakltfDeQH?=
 =?us-ascii?Q?1TNUzkM7LgxrBMaXF6utdSA6aJp+8+Yo9KrBVhI/DO1ZVdq6GeTzetBPxQH2?=
 =?us-ascii?Q?yWEQ6pKhQ5LtdbPzY2Hy2LvorkR4MeVYT4LBBrVbbPhKQhhY9WsSBlazAQy5?=
 =?us-ascii?Q?dPbnepZ+sYul7t6bV2zsmlr9ls4Rntx1ZBi0gdR42cNoJBQAY9agn/16ixlD?=
 =?us-ascii?Q?8OHxU58rPMBT2noyukL/xoZKBL+UYDPRB4TfTj3JGOSBG6AJXmq1m87cIdWz?=
 =?us-ascii?Q?TVewexir0acphRmOMSaFwatU5lyWYp1x8Th+yeAfW7msYJekYQ/AgFkOmyq1?=
 =?us-ascii?Q?RaphxlMiUaoGVtHxawPuSDyNWR6byWPEoh43UfcjNuPGXKEYa0YZp7uPEmcm?=
 =?us-ascii?Q?ulaWG4AI2ovn0N2lnoAES+OaUv+Jpj2v7ZubJ47Y6Fg07xCLQ2088G1PWgOC?=
 =?us-ascii?Q?r3J+zRdXSBRpi44Xk/mc+AZPFUevDczw1bB7+/ieeW11uF6xoIHAVcpsY4gY?=
 =?us-ascii?Q?jZJDtDRELU2GtsA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:15.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9935aedc-a1b6-498c-ddec-08dd2f3e4b72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

With the introduction of the new objects, update the doc to reflect that.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..cb2edce6f87d 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,13 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_FAULT, representing a software queue for an HWPT reporting IO page
+  faults using the IOMMU HW's PRI (Page Request Interface). This queue object
+  provides user space an FD to poll the page fault events and also to respond
+  to those events. A FAULT object must be created first to get a fault_id that
+  could be then used to allocate a fault-enabled HWPT via the IOMMU_HWPT_ALLOC
+  command by setting the IOMMU_HWPT_FAULT_ID_VALID bit in its flags field.
+
 - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
   passed to or shared with a VM. It may be some HW-accelerated virtualization
   features and some SW resources used by the VM. For examples:
@@ -109,6 +116,13 @@ Following IOMMUFD objects are exposed to userspace:
   vIOMMU, which is a separate ioctl call from attaching the same device to an
   HWPT_PAGING that the vIOMMU holds.
 
+- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to report its
+  events such as translation faults occurred to a nested stage-1 and HW-specific
+  events. This queue object provides user space an FD to poll the vIOMMU events.
+  A vIOMMU object must be created first to get its viommu_id that could be then
+  used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
+  but is confined to one vEVENTQ per vEVENTQ type.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -251,8 +265,10 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_fault for IOMMUFD_OBJ_FAULT.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
+- iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


