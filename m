Return-Path: <linux-kselftest+bounces-22791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C19E2ED3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE62167837
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0B20C46F;
	Tue,  3 Dec 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WWImZl99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52BC20B808;
	Tue,  3 Dec 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263870; cv=fail; b=MY3Al0b97elpSct6ZlCh+9M0R4+x67bzZrZ1oN/hVm9PB7UBQ46UokbE4qcI8OZq4JKtfhnKTeUlKbOQmGcUjAgZ2UuFt2oiOKdEGE1fAi6YdK7ea8EW5yVY3jalVVCjBzGs89PjzMcUaB0etEGqXbOrmhayTM7uH5OKwh69NPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263870; c=relaxed/simple;
	bh=uSiEPC1hkjfTYDXYSXQgzHJ+fs+VLHYMKyvGm+Wkrgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxDa5SBJJULt6v5U2iJv2tSYINLy6YFXcbyhM+heGeXktXxnusn4bblTrkai2AY80kV6UG9nyN/Vt7z+kNU5rj0QX07OjJ/aU/7H06mXGeJE4R3KsJVt/y9pnY7b/gjBDrlpPjoPxcD81yDBK/lo2ynpFNBVHuZiRB5tjjQysVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WWImZl99; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUmM1FrQdtpfDejOWO1zwkqNmOqo36BeFOHsBGHVbxixuyCSS9+br/0gyIA306dAnz4Jka88tA16qCm9j7xm232z9GPYdHTft9xjesHL2P5ZUkNlFUFssThXGZTXoJ/u2kP2dvqKAvqYouNppR9pGO8i5pFFoAUdt6j80BQZ19NQpc2qva45FD5npcx4FKxn5uisS06QrLvKXM660W6V0C4FGhka5hcccMdJAJkyBEEkQ03BZbDYFFmnCZK7s8BiGLYy3ms1pKuMUuHf5XaBy90tLsCVbQm7o+am6FoqEpYP/RI5tGQznAyTJfQVrg48IoXkfGHZ3bi+CrT60q4TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMVM3GEpN/ubnRSNFWvYwht1Bf3kSMJ6EqjcuzIeoCg=;
 b=EtzNBVpEqf+dAeuGeLeD7UDMM9Fdc+XOKQtquExY+IACqOtVvc8sCTWnE4GWu/bNgNCmt0IgchP7n0bmmaQna9SXxghC/UO1yadtVjN+bUVOKXEZ3zRDeW5onUw4aRIPPAl1hi7eTW6LpfEm67rFTDKpEKPfXgeIc11+LoLHE/9JN7HHA6qHsCP7x03oZ8SKf37lBO4eT+DqTnPrghYnLgL2PvC8XJAdf3VpHNB9ePdAm2C790Wd+kuW7bGjxDAg+xRPHxNCCUwFFjbzjY8P3lBMsWln6AvMmgtytkRGX5Gz6bNctEFtvU6uKGtKF52UDvbPggjpGU6WV7TcwXULlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMVM3GEpN/ubnRSNFWvYwht1Bf3kSMJ6EqjcuzIeoCg=;
 b=WWImZl99hpUr5UpsWu6x9HFa5KIPBnqkd+epfIChm7lZPL21Gq/j0bZdbbldKwSsyGaSiRh83TMQKTG75JO2U9rvUOFtP2FWm56G6F4wGgHDwK8350+wTupo9r0AGL9FBzecHsBwMprTy38OQBT3LpR+8yoF3tCzkat615R9KG61WLmcqFxpCh/qDNcncyWci9JlRjwR7XM8fR4gItWI2f3CsMIpW8UedGP0BDnUKlLD9y5MOFK/GCyBPrOSbK1yg6VISLRCwmEwOhsNO1ckSv8AlDwr8Yd/IAS1Z9sJgSZeMvTR3b65+qemM6mwyNSArVRwQg5lMJ/BTzZpehIK9A==
Received: from BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:11:01 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::8d) by BL0PR05CA0001.outlook.office365.com
 (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:47 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:47 -0800
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
Subject: [PATCH v2 11/13] Documentation: userspace-api: iommufd: Update EVENTQ_IOPF and EVENTQ_VIRQ
Date: Tue, 3 Dec 2024 14:10:16 -0800
Message-ID: <a5025cbbd16f9c12dcaae7a14868419f17ce1d16.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: f05f9605-11b4-41e0-30f7-08dd13e75f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QydaB9LXjYPbnst7IR+yyYqA+WLz/guQXeke5a+twiKsA0KtJxHmXENiHkz4?=
 =?us-ascii?Q?I+ha14S3gkHbadbhFoS2jeAN4HSlraRt6TQYpyf9EgzLZRj9k6atxTjT0p6H?=
 =?us-ascii?Q?b47Ot/IAZGmOOkXUv7NfZ/Yucvf/ZT/g/ND8kus8oo+etHcY+rDYu1Zl2qEh?=
 =?us-ascii?Q?xDl8YY/KMTIzXIbew6dwKFWa7Z2/upBGyJkheSUyW3OSCOubUdIaNfGKgyuZ?=
 =?us-ascii?Q?0V1ME9YVKr4/WRgboWnGxZCbg0DCa2j5HFQu4bCqCQ871WtwZ5uv25YcHnW4?=
 =?us-ascii?Q?zHn1mFvqrUFzSds7B0Vy5rCOjnL0jsDe2Lxm0A6RNZSrIcC0UtJnKXrJ81sx?=
 =?us-ascii?Q?aby7DbT6i2JJBdZeyrvoRXEzQDg2uqQTQxXnjMJI++H7Xl3yBRanYPv7Shqm?=
 =?us-ascii?Q?rfksKves51wViB9LYwqee+GhYA0NP+IZ1BIENZsm3Kkc54ubIY3dI9+pfJVZ?=
 =?us-ascii?Q?x7B+8cveGhbv76kIKnml02598vxoK19tyS4LvugufJX7MdwdGV+irWBRwlm2?=
 =?us-ascii?Q?XD/7ziPL1RqNK5MurRJFLatSfVEES/G0wmeS1VW3yYqivsvTpdKfj9yp4xmI?=
 =?us-ascii?Q?OqsIx2COAHQxteoiDoAVk7Px3EDSLA4XbNFbeuFk1lZCM/wUiv+ViAlmRSok?=
 =?us-ascii?Q?oWY8Glw694FoMD2xfWKPJbB2lhCNbT46hRL8exVLerYNFTDws7arD07R4GVl?=
 =?us-ascii?Q?L1cMXK9N79FlX1vEw6LiIEbJzqZOPshW7vXU+jSUz4hvpSkCRUATMJYL/xMI?=
 =?us-ascii?Q?aHIEWlCmLd6s9oIqTe8WUNEURHRNpL2wRK43fVkHOA3Vd9Jay2jnmSlDyEGi?=
 =?us-ascii?Q?9i/YLLcZ4u/kK2rnWyso/2jy+s/eHITx8U3Qp+U6uLPDZT02aesxsqlx5CuL?=
 =?us-ascii?Q?GxS3P/8OykBDomEs5SN5zjudG2tYH/aS5xm1fDBIL8QzP8YoxIpEg4c5Bhsu?=
 =?us-ascii?Q?xVia4eiq3z3zcF9WEbdbN1UPa+501XVCHaJHV5d/KtxNIf6ZAdMsvZUCWQKz?=
 =?us-ascii?Q?22k2Wgk437NGuZX5F5LQFPD5oGyr1w4pmPLrCaHU+y3mdLmPjgGm+BiI+YJz?=
 =?us-ascii?Q?I+6+VL22h63ULnnnYWQYS1zRf4IdL2ECmjXlxJkr+OF7N5mJFvX/bw5gsFwc?=
 =?us-ascii?Q?ynVePf9DbmSbaJIAoxeaczWBRaiPQLXkwS8EwnhOybb400Ypb/zcbHern/Na?=
 =?us-ascii?Q?poaF8FTIrakTlw5Hw+V5uIyB/xBu03UeFV1xP7rPUpE1vts2kygruOg4IQDX?=
 =?us-ascii?Q?SIBfgr6AWNB2lCUV6p+3M/rB4RscYwUujGC7OE5QdLJtVckzgYxyUlTmW2tb?=
 =?us-ascii?Q?fz99xlwh1aP9fcWAnse/L2Ln1sPpe1OB7Z8Kbmy1HDhm/teOEuK9nkX72OX4?=
 =?us-ascii?Q?0ylItVQBHZGcL8gmiXhF+XFBDBLakv/mnllGG6DxqKZg6M47Pgi/t9hRyTdd?=
 =?us-ascii?Q?odfhyYbMKxnuvDuSIEHHY1Lo9OeSKck5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:00.8896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05f9605-11b4-41e0-30f7-08dd13e75f22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

With the introduction of the new objects, update the doc to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..798520d9344d 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,14 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_OBJ_EVENTQ_IOPF, representing a software queue for an HWPT_NESTED
+  reporting IO Page Fault using the IOMMU HW's PRI (Page Request Interface).
+  This queue object provides user space an FD to poll the page fault events
+  and also to respond to those events. An EVENTQ_IOPF object must be created
+  first to get a fault_id that could be then used to allocate an HWPT_NESTED
+  via the IOMMU_HWPT_ALLOC command setting IOMMU_HWPT_FAULT_ID_VALID set in
+  its flags field.
+
 - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
   passed to or shared with a VM. It may be some HW-accelerated virtualization
   features and some SW resources used by the VM. For examples:
@@ -109,6 +117,15 @@ Following IOMMUFD objects are exposed to userspace:
   vIOMMU, which is a separate ioctl call from attaching the same device to an
   HWPT_PAGING that the vIOMMU holds.
 
+- IOMMUFD_OBJ_EVENTQ_VIRQ, representing a software queue for IOMMUFD_OBJ_VIOMMU
+  reporting its non-affiliated events, such as translation faults occurred to a
+  nested stage-1 and HW-specific events/irqs e.g. events to invalidation queues
+  that are assigned to VMs via vIOMMUs. This queue object provides user space an
+  FD to poll the vIOMMU events. A vIOMMU object must be created first to get its
+  viommu_id that could be then used to allocate an EVENTQ_VIRQ. Each vIOMMU can
+  support multiple types of EVENTQ_VIRQs, but is confined to one EVENTQ_VIRQ per
+  vIRQ type.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -251,8 +268,10 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_eventq_iopf for IOMMUFD_OBJ_EVENTQ_IOPF.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
+- iommufd_eventq_virq for IOMMUFD_OBJ_EVENTQ_VIRQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


