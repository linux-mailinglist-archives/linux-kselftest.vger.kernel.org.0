Return-Path: <linux-kselftest+bounces-25147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D4A1BFC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E5F16B6FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104854414;
	Sat, 25 Jan 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqgFu15Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7122612;
	Sat, 25 Jan 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765082; cv=fail; b=rihvqcHK5OLLPifPJzSSqzbReh0ECek8Hr27c6M/E1SzHyepHWJQDEDUt9EY8EVqXAZYu4tmM+4iplysQ4AP0Kkt4GS83ktpQEjp4pWfxbIiKg0jnD+XLYokwqG8sA+l8rnFYHxuImgKnZ3l6afV9Tj55Z7FM65eMzXFHzAOS0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765082; c=relaxed/simple;
	bh=KYwgvHd0RWBv2cnsy3P/HnZoqWQgbxWdmScqQrkKGvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzIJO9agRh84XA4+7wtczFe0xvwhZpyP3a+uSid4FCAEQVEBybO+nsdRTxzTqdXYZEghLOc5oBlBE/2SbCe5Tzo2yG407NZ8jrJ0PF88CbUetqTZFohibU7hsUqYvCD3ENWWffR6bxb9T/QsisTVchqAydsYgl1YeyDyloqwR9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqgFu15Q; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tar/O/fuSVrtusWr57OQlRYTbOtfgFVGHKYxKLnD3SgwuCD8YTEIK4zcqLzzMzfi718sPfX6XIdMWWGGE+6Ib1YHoMGHqBuAlAXD8ylHJ3mbGptEJnKNRqF8fAFg+FnffogTUU1o2WxdAbG7Qjs3eP2NMBHd/EmukqKQq/DGfTIrp1mXiVDpLHwtsxT+kjD39U5GKCOPRHG7snpeuQQCESYXmv1qowmEYrM339pIfEqx5nWHwQmxl3X+HalMhqbnTKvuucdokd/mL+LQKYsSoEcofs/47uRDC76/0intUNO7ckBGukloXUCCgqeH1bvfX080By2WbXTAGOHqwV7eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mbMOzsXAZIyTwJpyI4MRb9rgUVKt9R8pIKULzUDjYU=;
 b=wBsLKEdDibrT5ORWQm2fnhZvACmR6gcQ4vc94jVUCI1IrLbLJ2a9ZVjPeFoKowv0WR81uYLTyQqMGMPZz67qlSzjiBEA2fvvJB4jTKfIDvI/VVQjDj0jTqHvD0EJg5ZwgTiPabr4uDArhBkC176zJgEOh+dVsgJDriqCey2slZaD54IX+D90LxVr4qm8i/LgNtu2wca5RKDmH1vJ85FZ5Gkh666CeSaeXOUII/CPgd34X/Z7ctPjKmW/MWLiQhT4I+xCrchvx5sLkIsq+B0Mp+5zK57CmESG1mVm9hGv3mDCu0JwfGHGLlFfHtYTbQpKsI/jN1p7R0pvgw/6ik5DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mbMOzsXAZIyTwJpyI4MRb9rgUVKt9R8pIKULzUDjYU=;
 b=OqgFu15QZf5uV33dSq3AVrJ1kkn6dDDYEnQCNDUXvAX86f9qOdVVoBqBvNDMz05liA0bOlS/vIVzV3S4BHA6TWrQCylJs2OvdaAAcON8PvoKNbS36vuMF22A7VRvh7kZv+tLt34TyfSZGv8QGxp3J23Lh0i3c6y20Lhh3Ub54uuUmj91smTPCGlnYWjYb6RKeOF/XYmc8Keb96AvXdhyuIcUyop4BobZARr+b2SVBXJt+GLCysmrsDV3wHeHd3mKRiG1mKgmd6EdaxLqug/oRQEjd7YneW9baGOdY4crd55U4NrQGpa9dJoqkI0ldzAIjfF8gqJUzXcOr0sBFEspcg==
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 00:31:11 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::11) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Sat,
 25 Jan 2025 00:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:30:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:30:58 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:57 -0800
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
Subject: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
Date: Fri, 24 Jan 2025 16:30:34 -0800
Message-ID: <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: f862127c-efac-4e48-d068-08dd3cd79171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGAG0oNgCW6XczzOZUZudX9s62dNyhuD/RQjLidZq74oQ1774BipokLgRr2c?=
 =?us-ascii?Q?taZaWzlr4d6i9PwkkQYpBOBlAzIQJjfU/hgQdYLJ7hL+oebXgf/C2FVidNHQ?=
 =?us-ascii?Q?phNuk3wTSOxAGIbrHJpyHof1dGRZMPNyjUx3mf4HSL63x7a2RxtK+mow0ApC?=
 =?us-ascii?Q?cUsNJc6kcbS7RQjqS+wd6dm9P1I3ZCq4AKohAedkxh5GWJylEShfUSN6LC8I?=
 =?us-ascii?Q?URM+V6Vwq9WufUdIX0lxz7VoyvWnah0sSxz6FYWZ+NkrIZ4PbZaoUG/oK6ip?=
 =?us-ascii?Q?Tj0mJB5+NTGFMwJznxYsQK18aghr/K/CIRMg61rVz+iGRG9hIjfjsQDtnjkC?=
 =?us-ascii?Q?hLISazWkGRrZIn1o6PvCyjcXUEbrJJLQsVWZWQ69FxRITx0jb1Xt60E88mRJ?=
 =?us-ascii?Q?L7PSp29XJyyykiHaPzv1wgwKVdktN8g87/wCp5JgqOHMfNiIu+cBt+Nein0q?=
 =?us-ascii?Q?eW0xGwsBYsuPavH3/+4+z5UUkMorGdiUnlC9n4pb6/Pk1DKL20SSWL19cpZr?=
 =?us-ascii?Q?qA/0tpsX8gi8f7iZz48ZhkIBBnVbFVpR8zsDWNtENgVKEA+3NCYXpxtR4ULE?=
 =?us-ascii?Q?4ngxEHdLZPRyR8hI3f1qtajb2Uilj1SJKNFZbuD8C0EIZ/Et7A24+hH3nWyX?=
 =?us-ascii?Q?5BJBbcDW5Ym/A+fYQtFkKBDmArzXaFSpKOdlKKM8HSPROsHLYeRSM4K6TQB7?=
 =?us-ascii?Q?3THUl6JEQ9EInU+McPE8ymspF87/gRR8tTj7L8xvTukQdZdJJnyk7hEPVbr+?=
 =?us-ascii?Q?0r8Ag69NOnRDAKRbGP95/cb8SRunDznvceWkvYeQzGSxIhGf2TxEmSReZ5uY?=
 =?us-ascii?Q?CcmMwlbyQVXTuiRgniCMqHwVL8tO8KC14/vdMQpmCBkvWfx+jcJdgUgSiU/p?=
 =?us-ascii?Q?xQZ83VgCOXW+DhadqbRtnEPUvZkdrkjeSniENctx3PBpphCiNfVfpVXEEuzL?=
 =?us-ascii?Q?EuAsY2WecL1Pvi20h9pWc3bUQ0+cPCc1zAOvUSDwQ47CU499UJnIuBLZdXCX?=
 =?us-ascii?Q?amZHtkZLJg8B903Anj0JCAjZWAmtInjGeCGP08xzoN3GcusI1a4SxNivxoI4?=
 =?us-ascii?Q?GsB5I0TyIgPoOno5Z9zFuPG+mpYwdWQFZKOv4hxjH67B6Yr43k/NeADCoBWS?=
 =?us-ascii?Q?gJUXaIkwEFhs7YoMjVuli2/jqWC7qHCPE4HESeiifqatiUyiZBSN5eV9A2VQ?=
 =?us-ascii?Q?w5N9eVGkFwjF/H5sP+FhTUd6CBxN5yf6ZPgI3dT5zQ9zYsTbhxwRF+pNfqFn?=
 =?us-ascii?Q?GqeN8tV9jAGTTimT3iOyxR4HZmP6p5IqOzXGqt2Ipm4E9u3HSd4wlY3U8BmH?=
 =?us-ascii?Q?2vmtkMktNn+Y7/3BL1ITPA1XprM76OOH9zVuKtaGJhSDuPhaCadtOdI7k9Wq?=
 =?us-ascii?Q?pmCkEQJbSDVltxJ8oDUzsp5kT31RaQ0tYcvcET8VS2k4aD2Uil/n1OE4SMdG?=
 =?us-ascii?Q?bX9JYQj31faAFhfcki25gX27lbwI8D2cUia1K2qyL4an7USC+xF8LoG26gYe?=
 =?us-ascii?Q?nnAZyETxLpW0Goo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:11.0237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f862127c-efac-4e48-d068-08dd3cd79171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
provides user space (VMM) another FD to read the vIOMMU Events.

Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
vIOMMU can only have one single vEVENTQ per type.

Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  88 ++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  85 ++++++++++
 drivers/iommu/iommufd/eventq.c          | 206 +++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            |   7 +
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 390 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index ee365c85dda9..7a8feedcea2e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -519,6 +519,80 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+/* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
+struct iommufd_vevent {
+	struct iommufd_vevent_header header;
+	struct list_head node; /* for iommufd_eventq::deliver */
+	bool on_list;
+	ssize_t data_len;
+	u64 event_data[] __counted_by(data_len);
+};
+
+#define vevent_for_overflow(vevent) \
+	(vevent->header.flags & IOMMU_VEVENTQ_FLAG_OVERFLOW)
+
+/*
+ * An iommufd_veventq object represents an interface to deliver vIOMMU events to
+ * the user space. It is created/destroyed by the user space and associated with
+ * vIOMMU object(s) during the allocations.
+ */
+struct iommufd_veventq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct list_head node; /* for iommufd_viommu::veventqs */
+	struct iommufd_vevent overflow; /* pre-allocated overflow node */
+
+	unsigned int type;
+	unsigned int depth;
+
+	atomic_t num_events;
+	atomic_t sequence;
+};
+
+static inline struct iommufd_veventq *
+eventq_to_veventq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_veventq, common);
+}
+
+static inline struct iommufd_veventq *
+iommufd_get_veventq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VEVENTQ),
+			    struct iommufd_veventq, common.obj);
+}
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_veventq_destroy(struct iommufd_object *obj);
+void iommufd_veventq_abort(struct iommufd_object *obj);
+
+static inline void iommufd_vevent_handler(struct iommufd_veventq *veventq,
+					  struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+
+	/*
+	 * Remove the overflow node and add the new node at the same time. Note
+	 * it is possible that vevent == &veventq->overflow for sequence update
+	 */
+	spin_lock(&eventq->lock);
+	if (veventq->overflow.on_list) {
+		list_del(&veventq->overflow.node);
+		veventq->overflow.on_list = false;
+	}
+	list_add_tail(&vevent->node, &eventq->deliver);
+	vevent->on_list = true;
+	vevent->header.sequence = atomic_read(&veventq->sequence);
+	if (atomic_read(&veventq->sequence) == INT_MAX)
+		atomic_set(&veventq->sequence, 0);
+	else
+		atomic_inc(&veventq->sequence);
+	spin_unlock(&eventq->lock);
+
+	wake_up_interruptible(&eventq->wait_queue);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -527,6 +601,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_veventq *
+iommufd_viommu_find_veventq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_veventq *veventq, *next;
+
+	lockdep_assert_held(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(veventq, next, &viommu->veventqs, node) {
+		if (veventq->type == type)
+			return veventq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..8948b1836940 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -34,6 +34,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
+	IOMMUFD_OBJ_VEVENTQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head veventqs;
+	struct rw_semaphore veventqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..08cbc6bc3725 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 };
 
 /**
@@ -1014,4 +1015,88 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
+ * @IOMMU_VEVENTQ_FLAG_OVERFLOW: vEVENTQ is overflowed
+ */
+enum iommu_veventq_flag {
+	IOMMU_VEVENTQ_FLAG_OVERFLOW = (1ULL << 0),
+};
+
+/**
+ * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
+ * @flags: Combination of enum iommu_veventq_flag
+ * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a range of
+ *            [0, INT_MAX] where the following index of INT_MAX is 0
+ * @__reserved: Must be 0
+ *
+ * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
+ *  ---------------------------------------------------------------------------
+ * || header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN ||
+ *  ---------------------------------------------------------------------------
+ * And this sequence index is expected to be monotonic to the sequence index of
+ * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
+ * 1, it indicates that an overflow occurred to the vEVENTQ and that delta - 1
+ * number of vEVENTs lost due to the overflow (e.g. two lost vEVENTs):
+ *  ---------------------------------------------------------------------------
+ * || ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... ||
+ *  ---------------------------------------------------------------------------
+ * If an overflow occurred to the tail of the vEVENTQ and there is no following
+ * vEVENT providing the next sequence index, a special overflow header would be
+ * added to the tail of the vEVENTQ, where there would be no more type-specific
+ * data following the vEVENTQ:
+ *  ---------------------------------------------------------------------------
+ * ||...| header3 {sequence=3} | data4 | header4 {flags=OVERFLOW, sequence=4} ||
+ *  ---------------------------------------------------------------------------
+ */
+struct iommufd_vevent_header {
+	__aligned_u64 flags;
+	__u32 sequence;
+	__u32 __reserved;
+};
+
+/**
+ * enum iommu_veventq_type - Virtual Event Queue Type
+ * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_veventq_type {
+	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
+ * @size: sizeof(struct iommu_veventq_alloc)
+ * @flags: Must be 0
+ * @viommu: virtual IOMMU ID to associate the vEVENTQ with
+ * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
+ * @veventq_depth: Maximum number of events in the vEVENTQ
+ * @out_veventq_id: The ID of the new vEVENTQ
+ * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
+ *                  successfully returned fd after using it
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
+ * can have multiple FDs for different types, but is confined to one per @type.
+ * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
+ * if there are vEVENTs available. A vEVENTQ will overflow if the number of the
+ * vEVENTs hits @veventq_depth.
+ *
+ * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
+ * a type-specific data structure, in a normal case:
+ *  -------------------------------------------------------------
+ * || header0 | data0 | header1 | data1 | ... | headerN | dataN ||
+ *  -------------------------------------------------------------
+ * unless a tailing overflow is logged (refer to struct iommufd_vevent_header).
+ */
+struct iommu_veventq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 veventq_depth;
+	__u32 out_veventq_id;
+	__u32 out_veventq_fd;
+	__u32 __reserved;
+};
+#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 0da39c3dfcdb..a08c8ebaea62 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -382,13 +382,141 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	return done == 0 ? rc : done;
 }
 
+/* IOMMUFD_OBJ_VEVENTQ Functions */
+
+void iommufd_veventq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_viommu *viommu = veventq->viommu;
+	struct iommufd_vevent *cur, *next;
+
+	lockdep_assert_held_write(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
+		list_del(&cur->node);
+		kfree(cur);
+	}
+
+	refcount_dec(&viommu->obj.users);
+	list_del(&veventq->node);
+}
+
+void iommufd_veventq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_veventq *veventq = eventq_to_veventq(
+		container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&veventq->viommu->veventqs_rwsem);
+	iommufd_veventq_abort(obj);
+	up_write(&veventq->viommu->veventqs_rwsem);
+}
+
+static struct iommufd_vevent *
+iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+	struct iommufd_vevent *vevent = NULL;
+
+	spin_lock(&eventq->lock);
+	if (!list_empty(list)) {
+		vevent = list_first_entry(list, struct iommufd_vevent, node);
+		list_del(&vevent->node);
+		vevent->on_list = false;
+	}
+	/* Make a copy of the overflow node for copy_to_user */
+	if (vevent == &veventq->overflow) {
+		vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
+		if (vevent)
+			memcpy(vevent, &veventq->overflow, sizeof(*vevent));
+	}
+	spin_unlock(&eventq->lock);
+	return vevent;
+}
+
+static void iommufd_veventq_deliver_restore(struct iommufd_veventq *veventq,
+					    struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+
+	spin_lock(&eventq->lock);
+	if (vevent_for_overflow(vevent)) {
+		/* Remove the copy of the overflow node */
+		kfree(vevent);
+		vevent = NULL;
+		/* An empty list needs the overflow node back */
+		if (list_empty(list))
+			vevent = &veventq->overflow;
+	}
+	if (vevent) {
+		list_add(&vevent->node, list);
+		vevent->on_list = true;
+	}
+	spin_unlock(&eventq->lock);
+}
+
+static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_vevent_header *hdr;
+	struct iommufd_vevent *cur;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		/* Validate the remaining bytes against the header size */
+		if (done >= count || sizeof(*hdr) > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+		hdr = &cur->header;
+
+		/* If being a normal vEVENT, validate against the full size */
+		if (!vevent_for_overflow(cur) &&
+		    sizeof(hdr) + cur->data_len > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+
+		if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		done += sizeof(*hdr);
+
+		if (cur->data_len &&
+		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		atomic_dec(&veventq->num_events);
+		done += cur->data_len;
+		kfree(cur);
+	}
+
+	return done == 0 ? rc : done;
+}
+
 /* Common Event Queue Functions */
 
 static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 					 struct poll_table_struct *wait)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
-	__poll_t pollflags = EPOLLOUT;
+	__poll_t pollflags = 0;
+
+	if (eventq->obj.type == IOMMUFD_OBJ_FAULT)
+		pollflags |= EPOLLOUT;
 
 	poll_wait(filep, &eventq->wait_queue, wait);
 	spin_lock(&eventq->lock);
@@ -403,6 +531,10 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
 
+	if (eventq->obj.type == IOMMUFD_OBJ_VEVENTQ) {
+		atomic_set(&eventq_to_veventq(eventq)->sequence, 0);
+		atomic_set(&eventq_to_veventq(eventq)->num_events, 0);
+	}
 	refcount_dec(&eventq->obj.users);
 	iommufd_ctx_put(eventq->ictx);
 	return 0;
@@ -508,3 +640,75 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 
 	return 0;
 }
+
+static const struct file_operations iommufd_veventq_fops =
+	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_veventq_alloc *cmd = ucmd->cmd;
+	struct iommufd_veventq *veventq;
+	struct iommufd_viommu *viommu;
+	int fdno;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->veventq_depth)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	down_write(&viommu->veventqs_rwsem);
+
+	if (iommufd_viommu_find_veventq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_veventqs;
+	}
+
+	veventq = __iommufd_object_alloc(ucmd->ictx, veventq,
+					 IOMMUFD_OBJ_VEVENTQ, common.obj);
+	if (IS_ERR(veventq)) {
+		rc = PTR_ERR(veventq);
+		goto out_unlock_veventqs;
+	}
+
+	veventq->type = cmd->type;
+	veventq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	atomic_set(&veventq->sequence, 0);
+	atomic_set(&veventq->num_events, 0);
+	veventq->depth = cmd->veventq_depth;
+	list_add_tail(&veventq->node, &viommu->veventqs);
+	veventq->overflow.header.flags = IOMMU_VEVENTQ_FLAG_OVERFLOW;
+
+	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
+				   ucmd->ictx, &iommufd_veventq_fops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	cmd->out_veventq_id = veventq->common.obj.id;
+	cmd->out_veventq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
+	fd_install(fdno, veventq->common.filep);
+	goto out_unlock_veventqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(veventq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
+out_unlock_veventqs:
+	up_write(&viommu->veventqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index a11e9cfd790f..0d451601fb9a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -308,6 +308,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vdevice_alloc vdev;
+	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
@@ -363,6 +364,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
+	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
+		 struct iommu_veventq_alloc, out_veventq_fd),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
@@ -505,6 +508,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
+	[IOMMUFD_OBJ_VEVENTQ] = {
+		.destroy = iommufd_veventq_destroy,
+		.abort = iommufd_veventq_abort,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..01df2b985f02 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -59,6 +59,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
+	INIT_LIST_HEAD(&viommu->veventqs);
+	init_rwsem(&viommu->veventqs_rwsem);
 	/*
 	 * It is the most likely case that a physical IOMMU is unpluggable. A
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
-- 
2.43.0


