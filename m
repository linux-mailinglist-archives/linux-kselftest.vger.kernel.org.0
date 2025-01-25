Return-Path: <linux-kselftest+bounces-25151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49712A1BFD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2A16E977
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BF149C7B;
	Sat, 25 Jan 2025 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5oSlFO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B13C914;
	Sat, 25 Jan 2025 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765089; cv=fail; b=bxWLhRlWz+EUz9nT7CwtkvdwyRw3J1SfpUYa0I+LhsLkHc4cTQ1k3Y1kgrcyRt+yh6ryLCpdiML6v+ykmYsryU+R/d0mJkHJg7upb7FztA6jo5XueoysqIHEq5+GU7eyRdEGlkC1/aicJLfM0UX3sLr9Zm6P3aT7hwfjwfpsP3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765089; c=relaxed/simple;
	bh=Y4bmkc7CsWrlPmvo62YhV2rZwAWHwsUAWojVCwJTEFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvDOVa1EWAq2RfGkXv6BZm4u0/rqcZMw42ZhmLsoxZFSpjct5Xh/g7lFXkDwN47ROXUG0T0YO9A50RO+cxSQDtCZyU817GsKotxVjbCI5975Y5hHzjAAyk0Mlq1FUgaa8wHAZIxaL3QyvzhYmcyg4ukxvuepGNd30fjgF0m8EVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5oSlFO/; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdizHZTdnIDbflOZgkCuQjO55bK5BQojnp1225pYzi7oX8xkKW7jJqG8bWQGgqPY+PZLrGHEjZFjg51VwZ61SEQE7gWC1itUU2+Auw1OdeoEioCMqvTJfrpoKfIrwioV6UWWc8+/dYxrLCMT3g8+YvYp08L+NnScuqgxxAdO6TeU9nee5GYlKNSCKXhhCEIAZ+Me2QbU2vqBFgQ0GLFr02YmMhdAKuoYv9Hx1bUu02DNJxLB568W8guGc4B3fEsgdVWibkyV+FWanQFG5QuT0WbAU1DsRKz1JRXMqQx5VirhxGI8pmUjNtcvNd1UfZj2JGuhUZ4L9QHe48gYJpWVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dVngxfsS73Y9oFRbe5xIpbXWA3obKblmqWLgSIMVrY=;
 b=urLZ4lJuw7l7qoU4A7WlVn1SVTySCBlZAKvacY+G2MQQnD+fh/Lbz3MOGgTKkfzaGVaD9boHAV5MGvMDOQjx1bnRkqf6lvvGm0EEHcqYSN3f7ydj6zVTjRH0D+7TzPwLsUmpkFRr7Hcl6howg8FrCjUh4MssX4iIeSOQVDectHbmWBroiudz2QsIHYcHpl99EtuEpGCoMaS1UlyPlGMq6b5yMx6xM1xjdh8HTihrbFPAAe+5KY3AWFqwE5EAkwVg0Fk7zcJ7UdBe5cVnOF0639ywQSesOssxUgVU1gQ7nQrDq4rRBaOu78X6n1SpkdCtFyL8PLCtOsR0On5cUQTp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dVngxfsS73Y9oFRbe5xIpbXWA3obKblmqWLgSIMVrY=;
 b=c5oSlFO/GDnFOC4tMFwm9iyakexPJX1HbIXGVWdaGZ/PYySiERDpNKbjHY16JpPA6iT0xzjTzDO0BddvGuvkBcvmw/mecbyhcVZDzu5FzJJ4jYXZ+eo448PUukvuEdEef0mcx7/dSVIfmqKlCLgUvVEosjo+XWiw3sQT3xBJkZ+2n8jxLJwT84qYGn0zYTBTTBLJ6yrG6uCc8LHwmynrpE78m572mUP5wBhjhZFAxQ7nuosUJqAjhO000mjV5+FAFoM+o9GD3wfvQQABL0n+LvrE5t9IlYJmlCIh1MTHHnKypyunu8xGW5aqR1IjWsUsBy5Xvha1tVxcqAbca839jw==
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 00:31:23 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::bb) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 00:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:09 -0800
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
Subject: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Fri, 24 Jan 2025 16:30:42 -0800
Message-ID: <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fd593a-c322-41ac-1ee0-08dd3cd7988d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZAKEahGUPugstV5Or//eKeiavt5/HZcku3kq9MvDR+pBVufe45GH0VIyPEN?=
 =?us-ascii?Q?O8L/R3qipeATycELuYizCnLb/ALYLper9bLuoETfCPbBXOp0v9EmO9BoFeYl?=
 =?us-ascii?Q?OBpPOh68ZjVBURAZD5Ef3AbtG0vFkm4isQO276UPasCKt3bRArXrm9OaPozz?=
 =?us-ascii?Q?LWhrIDlyjTGKkB+fY4ua6TQ5fJlksbLU0evUZZP6w2zb3pkgQa+98yTcQGLT?=
 =?us-ascii?Q?ubDCKxsklxx4lu2MZm5IJtdjcg1yQAMmC9UnFoBzh8pJKaAx7RdpzIlSFcic?=
 =?us-ascii?Q?ob53cDhqTjrb/y7J/+/xSi7rKGWsF1E4uoVCAp164dzN7bzDrybWKXDkypIg?=
 =?us-ascii?Q?ZAft2vYViyjHJ/0GyhiH6g/8GcIK5lwwSIcvVu3socm6JKRb1NGeFQswMbuZ?=
 =?us-ascii?Q?t24srk8u5YXqSsWl04cnu5AoM1WlkoIT0OGI6DXKyT2B0jbXCIkxjzUX/Vix?=
 =?us-ascii?Q?MY50nby/Y82jOm86N3RjO15PfMc4Zygh77qoiKTqUkuFqFG+XzGZ0mAE8rZr?=
 =?us-ascii?Q?OxS244Acs2CPEJBdAnwBIcwSPm/KPXDka/ChVSiwiCp0JQUedlwcoqFE6+Xt?=
 =?us-ascii?Q?vViR2rtoG5kcaoPdLZ3m3ezY753gSLTXmn1ZTQJYKtTau+GrYnAfIpGDMXGr?=
 =?us-ascii?Q?7HcZCnQhOp+EhwB4Bk6vsdxH5q7zcuWXHws+377sq1AsdC0r7c3gFMxvp+EJ?=
 =?us-ascii?Q?V6bze3E2qOT8x3zSphmFvZWdQCLFREStxCDuoIYZoc9pYPtJB2LRb9XhpfL6?=
 =?us-ascii?Q?6JmK2B+5bxXgvBv46XCxOran0FJCbB+rPBqOQvyh0U3Bw618rT0RgZ9pYDBG?=
 =?us-ascii?Q?dYjcNV6S7nv/YHiOokLuZl8SPFBAKBtW8KPMnqjvk8aaq59Eh1RPKZgDfo21?=
 =?us-ascii?Q?RZETEjelRsc1F51fcdkzU3waS9wGdFWLFkeVrl673IzXraXCLAoCXYDPheU0?=
 =?us-ascii?Q?FK8GLFuthiiMJZU1MeQcc+4cLbZXCnaBuScKS+ZujMjxHxQ+ivRC6czHfmeA?=
 =?us-ascii?Q?QE3eCSMsCA94sd7RBMVcFnGB//tclpzntdfLTzaTUjT10nOByTS8GXfT18aM?=
 =?us-ascii?Q?c9cnQh4uyCrXpItq3sgbHGRvpGnRl5dZR5J+AZZ0sWtR4kaN3vesSe10cvSb?=
 =?us-ascii?Q?B8hlzPNZW+MZcuAQMrHlxNSjXgMN5cwIKn9AHmC7NqqMvTjCV/jhKhXc1eqN?=
 =?us-ascii?Q?XroIRPCnojVNZ55I3cKnMVRFwxdD+rw0WMjpVL03h62/CIJrO/zL4mTDxT6/?=
 =?us-ascii?Q?t61QK/ytw3pEAnqp7SfocrDq6VsAAJydY5KDTg+kou9iDXj874WsXqdO19Z5?=
 =?us-ascii?Q?JSNcfNH7hIgBL0fw7f1m2d24x/xHV3JuOSBLYODSEDr8LCW71FgfjGXhztMe?=
 =?us-ascii?Q?5310dbmuHblUd2g48sLF5QYnCnjq8zL9R2TowrkgELWgYn6SzX45wmPEHbA6?=
 =?us-ascii?Q?FoImx4lgHCgjgxPkH+QUwMC0N+qsvZpNlOJ+LoWKfZPj6te2+0nHimMeZ/dH?=
 =?us-ascii?Q?lSSBiQ5RThzcbXo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:23.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd593a-c322-41ac-1ee0-08dd3cd7988d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
in the threaded IRQ handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 15 +++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 +++++++++++--------
 4 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4435ad7db776..d24c3d8ee397 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1066,6 +1066,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct iommu_domain *domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1081,6 +1082,12 @@ static inline void
 arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 {
 }
+
+static inline int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster,
+					   u64 *evt)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 08cbc6bc3725..cbc30eff302d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1058,9 +1058,24 @@ struct iommufd_vevent_header {
 /**
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
+ *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual event for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_vevent_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 98138088fd16..ceeed907a714 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -443,4 +443,19 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	return &vsmmu->core;
 }
 
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
+{
+	struct iommu_vevent_arm_smmuv3 vevt;
+	int i;
+
+	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
+				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
+	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
+		vevt.evt[i] = cpu_to_le64(evt[i]);
+
+	return iommufd_viommu_report_event(&vmaster->vsmmu->core,
+					   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &vevt,
+					   sizeof(vevt));
+}
+
 MODULE_IMPORT_NS("IOMMUFD");
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 686c171dd273..59fbc342a095 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1812,8 +1812,8 @@ static void arm_smmu_decode_event(struct arm_smmu_device *smmu, u64 *raw,
 	mutex_unlock(&smmu->streams_mutex);
 }
 
-static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
-			       struct arm_smmu_event *event)
+static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
+				 struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
@@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		return -EOPNOTSUPP;
 	}
 
-	if (!event->stall)
-		return -EOPNOTSUPP;
-
-	if (event->read)
-		perm |= IOMMU_FAULT_PERM_READ;
-	else
-		perm |= IOMMU_FAULT_PERM_WRITE;
+	if (event->stall) {
+		if (event->read)
+			perm |= IOMMU_FAULT_PERM_READ;
+		else
+			perm |= IOMMU_FAULT_PERM_WRITE;
 
-	if (event->instruction)
-		perm |= IOMMU_FAULT_PERM_EXEC;
+		if (event->instruction)
+			perm |= IOMMU_FAULT_PERM_EXEC;
 
-	if (event->privileged)
-		perm |= IOMMU_FAULT_PERM_PRIV;
+		if (event->privileged)
+			perm |= IOMMU_FAULT_PERM_PRIV;
 
-	flt->type = IOMMU_FAULT_PAGE_REQ;
-	flt->prm = (struct iommu_fault_page_request) {
-		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = event->stag,
-		.perm = perm,
-		.addr = event->iova,
-	};
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request){
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.grpid = event->stag,
+			.perm = perm,
+			.addr = event->iova,
+		};
 
-	if (event->ssv) {
-		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = event->ssid;
+		if (event->ssv) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = event->ssid;
+		}
 	}
 
 	mutex_lock(&smmu->streams_mutex);
@@ -1865,7 +1864,16 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (event->stall) {
+		ret = iommu_report_device_fault(master->dev, &fault_evt);
+	} else {
+		down_read(&master->vmaster_rwsem);
+		if (master->vmaster && !event->s2)
+			ret = arm_vmaster_report_event(master->vmaster, evt);
+		else
+			ret = -EFAULT; /* Unhandled events should be pinned */
+		up_read(&master->vmaster_rwsem);
+	}
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
@@ -1943,7 +1951,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
-			if (arm_smmu_handle_event(smmu, &event))
+			if (arm_smmu_handle_event(smmu, evt, &event))
 				arm_smmu_dump_event(smmu, evt, &event, &rs);
 
 			put_device(event.dev);
-- 
2.43.0


