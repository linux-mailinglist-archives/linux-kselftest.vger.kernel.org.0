Return-Path: <linux-kselftest+bounces-16446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A36961509
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5DA1F2349C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D791D619D;
	Tue, 27 Aug 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="si8LOEgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020021D47A2;
	Tue, 27 Aug 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778172; cv=fail; b=PMAh5ySH9ya+X54NzIT8rk6cgp/yxK1uUfJ/i9YttWIjg1qAhgYUHrK/81Q/3+ft/I3MiM8cL/mU22OSbSqdXB8Weu7eL3KIm3T5QNakF0UNIaQmC4zrNYqn8zxuJ3mE9gCTeOt7QBC7VF3d54+JZE859+ZaGH5dZVrRlxKGsbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778172; c=relaxed/simple;
	bh=ay41kGInixDl7+pcy/nF6cJSLpDSCyi2pmarGm/TqM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbAEOtMxtKzXxC4lmnuHlNialQD/KN5sYSyi6kPbUll717CmlOPG8Zf9QE8blT+80OLALFvSCHULVeVpin9fM/E1IC3r/bjIuZHZoEl7q66z7kDbSyTPOSQWfQMicDASuqHQWfOdST5tY+M9ApFptqYgt0yVa10VEoeGmx3z1/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=si8LOEgX; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbULXPWoQQHrpru0qkYq17J6lsc2Nae419Jo1CrDCAp56p7/CsSqU+tyrR/FohtRDCA5n/X8j0UEYUrtztdhObhekvqRc9kOf9rR6EcInEVjUpV5uvTxg3dljQIPPSUENE0XyTY+WC/1VqTVHPyXB5aQxqDf/LemKZIIxVJLISwbrVLJ3VmDrIe839+wNdzjAUMBhcyEg0Jh88rZKN01qsdeeVEGnRato+bLlw7kpZblhOnl5uZKh4cC/Mbj3iEcNk12TwEkv/dR1VAu88S701rI1nHsHSPqQEXSV5XZfXQWpJY2RBxsx7KeyLXNsHmQPZ1N9L7HWY2UvmuPYt/eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02OaAJNXTmBe3J9SJNEhtuFoRPRVInbsx8Sh8Tc6Tk8=;
 b=QaoWyz3xXv24RdE3EixtqH239liaIxZ0s/qW92//JjgowvKeOOQbWtbchv6zTAYTNyrNrRqD1j4DMCnGcM27z0mde9JPIBOvS+qQ/meRmHGuMHqvlTCwO8kLh0VrlqSRBiFycdioZNK2bLx6ujup05IwS1gfabwCWd7bm2dIhlXwsKNu98m4m/Rco7BjkGhrOEbcsfETf3jJwCr7S6uLM+VzPUXsPU/2Bxqm2gdO2DGSzXy3WuSZrhwvgejgs36EbvDapSW/ReH2hs/sjk/EGWdV9xfI34vkwJW+Hcd9oUV6/u1x4ZHC00+3vFORmzc1CQ7X5sWzGILfZ9KUsbW+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02OaAJNXTmBe3J9SJNEhtuFoRPRVInbsx8Sh8Tc6Tk8=;
 b=si8LOEgXGfrQdJ6K4w6vV1lDXOpzF5u+mUP2fnmqjP7bwSRoF3fgDGGpObqbkn3ZimNjFAfM+14r9U00fuiV/3elxrGWFgANRaSzbRJxW/ctMVoLuhAcc0Rhx5bwYujS5u7LlEV67SqJ2a1Mf+YFozVRfkHjKEHDWjinrdNj+oxg5rpmoyPphwqlSbjTCWz8dLfKVJAjzmcY0xlxrDFo/7WKFOImOD4P+F2TAaXvau0UQ/5GrSnvUJGUI1SR6KzqcSnpI1JD9ZEIVlD06eZkx7y+4mbHaYxwDy16fTDAmsAz52tg4qJK9Km6AwTMrcHwcUYzO/1+1RPVD6C5gr7vBw==
Received: from DS7PR05CA0080.namprd05.prod.outlook.com (2603:10b6:8:57::18) by
 DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 17:02:44 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::8e) by DS7PR05CA0080.outlook.office365.com
 (2603:10b6:8:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 03/10] iommufd: Add IOMMUFD_OBJ_EVENT_VIRQ and IOMMUFD_CMD_VIRQ_ALLOC
Date: Tue, 27 Aug 2024 10:02:05 -0700
Message-ID: <aa6f1ef7f9fd456e62f422a4ad0057af30b11cbe.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 264d9098-a355-485d-1136-08dcc6ba112b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/mszNF4xyI5WOQFnoCoDZeYvwJrbe/2W19JkYcnvukFWkGiQ6dkV4E3m9O6?=
 =?us-ascii?Q?ulESVYCgaF6bB6XPrIqkWo6sK72xFEC7kh9+x0+xe94SsY7xthFkBHLItEoS?=
 =?us-ascii?Q?YytzMQWP220f/LgMif5Xq4qcjT9caLKbrTtQxIQUjKAkFtCAazk0nLR5UuHY?=
 =?us-ascii?Q?mcWkwmHZPl2buP30vs6QCMGrL/ng5VQltfx0djnx+eqmKyC7laosgZdv8dXS?=
 =?us-ascii?Q?d4Z9SwGLlcPL81vasKMW2tpp++cRh/hGWJaY3N08iOQVj9QcOABp5fLRDhCg?=
 =?us-ascii?Q?OvMUqhShX0eV+/dG7Wl4aM6SuS7I5p7/zsIubkLWwNK2Wjg2EyuC9iS2xZqG?=
 =?us-ascii?Q?7t9euIJhLOUXJZaw9E/oVOAvFxKXqcBCK6lKwwpZZfCGIIlWSoknZqf6Z1kP?=
 =?us-ascii?Q?h5bZgfOKANKsVx1RTGfIzbKp3X89g3MBgpYVsaSl3VdwfSTwzXkjowa15DZn?=
 =?us-ascii?Q?oagfHJEklGkAomeY1U5h1deuozSHP5xF6vF6Wk9G62FW+3hlqGHW4ro7AQxB?=
 =?us-ascii?Q?zM+IWWmdCUCmFuBbUtt8AB0vmmTF0VxgXLNK5zryuNae6jeUKVowEsLZct1N?=
 =?us-ascii?Q?0EwT6qvFDbmQBZgV787G2Qg0AuSuZ6Mc/WAZG0amKZTvYKHM0434IRM/v01h?=
 =?us-ascii?Q?Xdf5r3SUWCIDYPPomNhNnRKjRnIyEnDDlsoc8m+npZZRarO8xRxtMYgiI8mv?=
 =?us-ascii?Q?PnTmsB0AotoN4hA7RruvuCDOpzDRFmIp3C0BAiNSNugikEGRyX+R8dfpIdYN?=
 =?us-ascii?Q?KUYgOnxF7uR7nwg065S5RSUlnqmwfcAnAvftZU+ZpkJORFwZCiMlqUTYEkId?=
 =?us-ascii?Q?u7dpA/pWxgmGJFXAe86rCOOm8JTd1DXWyOtom+w7Zwcyhpmmk2j1/MQHCSqb?=
 =?us-ascii?Q?pUwvKYkGOOD4qWiZmMH32uTFr78jLG/prHNKZUur7PEdfoE1k1aDlg0RDmQc?=
 =?us-ascii?Q?7kRR3Z4J2SIVSWkztJi4MdM2gdEKevF18/tb6dFyCwIc3/ojCeGU7rXvUd4o?=
 =?us-ascii?Q?XJt20eX0mvUJfrIWJeDk/RKuye5lxsJUYaHT6AAzgk80VecSwIvorPo6YpFE?=
 =?us-ascii?Q?VvS7dMO6QW6nDyxGbn3KvfiZQ0K2mERl4oM5I73+9rrzzwwUGvuWgfdYRLdN?=
 =?us-ascii?Q?vezHQVBh9GlB5yj7rbcK3NjzoK+VP9V3Do3YldWvellne4VAJbvnMCri/QNX?=
 =?us-ascii?Q?2fdB+TjBtIADALGy7r3nU1B8b4eIOdSiI+ejM0qLSScQyhhVFfHROlOTNghm?=
 =?us-ascii?Q?Ebspknk3/XBTmg/cAqB4DlhMUfNUXt5Fm2clIc5LzVe2TOjDnOkYsi/HUvNU?=
 =?us-ascii?Q?NYvmImkBa26SEgSjxuxlFFsaVFcWQEja4atxoqJ75u5rSpMfzAwlmsOzUZ89?=
 =?us-ascii?Q?5ZFGahpk2YG1J9tRREFCCS/EFprPpv18p0IQ2tVQh8P3sdkpP649GDHZAlmD?=
 =?us-ascii?Q?pJLdrQApAke3CzC7LVCpctUUg/Hwa15E?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:43.2613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d9098-a355-485d-1136-08dcc6ba112b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

Allow a VIOMMU object to allocate VIRQ events. Each VIOMMU is allowed to
have multiple VIRQ events but they must not have a duplicated type.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/event.c           | 136 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  54 ++++++++++
 drivers/iommu/iommufd/main.c            |   5 +
 drivers/iommu/iommufd/viommu.c          |   2 +
 include/uapi/linux/iommufd.h            |  32 ++++++
 5 files changed, 229 insertions(+)

diff --git a/drivers/iommu/iommufd/event.c b/drivers/iommu/iommufd/event.c
index 8fea142e1ac2..f10827ce9cbd 100644
--- a/drivers/iommu/iommufd/event.c
+++ b/drivers/iommu/iommufd/event.c
@@ -339,6 +339,67 @@ static const struct iommufd_event_ops iommufd_event_iopf_ops = {
 	.write = &iommufd_event_iopf_fops_write,
 };
 
+/* IOMMUFD_OBJ_EVENT_VIRQ Functions */
+
+void iommufd_event_virq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_event *event =
+		container_of(obj, struct iommufd_event, obj);
+	struct iommufd_event_virq *event_virq = to_event_virq(event);
+	struct iommufd_viommu_irq *virq, *next;
+
+	/*
+	 * The iommufd object's reference count is zero at this point.
+	 * We can be confident that no other threads are currently
+	 * accessing this pointer. Therefore, acquiring the mutex here
+	 * is unnecessary.
+	 */
+	list_for_each_entry_safe(virq, next, &event->deliver, node) {
+		list_del(&virq->node);
+		kfree(virq);
+	}
+	destroy_workqueue(event_virq->irq_wq);
+	list_del(&event_virq->node);
+	refcount_dec(&event_virq->viommu->obj.users);
+}
+
+static ssize_t
+iommufd_event_virq_fops_read(struct iommufd_event *event,
+			     char __user *buf, size_t count, loff_t *ppos)
+{
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	mutex_lock(&event->mutex);
+	while (!list_empty(&event->deliver) && count > done) {
+		struct iommufd_viommu_irq *virq =
+			list_first_entry(&event->deliver,
+					 struct iommufd_viommu_irq, node);
+		void *virq_data = (void *)virq + sizeof(*virq);
+
+		if (virq->irq_len > count - done)
+			break;
+
+		if (copy_to_user(buf + done, virq_data, virq->irq_len)) {
+			rc = -EFAULT;
+			break;
+		}
+		done += virq->irq_len;
+		list_del(&virq->node);
+		kfree(virq);
+	}
+	mutex_unlock(&event->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static const struct iommufd_event_ops iommufd_event_virq_ops = {
+	.read = &iommufd_event_virq_fops_read,
+};
+
 /* Common Event Functions */
 
 static ssize_t iommufd_event_fops_read(struct file *filep, char __user *buf,
@@ -475,3 +536,78 @@ int iommufd_event_iopf_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_event_virq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_virq_alloc *cmd = ucmd->cmd;
+	struct iommufd_event_virq *event_virq;
+	struct workqueue_struct *irq_wq;
+	struct iommufd_viommu *viommu;
+	int fdno;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+	if (cmd->type == IOMMU_VIRQ_TYPE_NONE)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+	down_write(&viommu->virqs_rwsem);
+
+	if (iommufd_viommu_find_event_virq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_virqs;
+	}
+
+	event_virq = __iommufd_object_alloc(ucmd->ictx, event_virq,
+					    IOMMUFD_OBJ_EVENT_VIRQ, common.obj);
+	if (IS_ERR(event_virq)) {
+		rc = PTR_ERR(event_virq);
+		goto out_unlock_virqs;
+	}
+
+	irq_wq = alloc_workqueue("viommu_irq/%d", WQ_UNBOUND, 0,
+				 event_virq->common.obj.id);
+	if (!irq_wq) {
+		rc = -ENOMEM;
+		goto out_abort;
+	}
+
+	rc = iommufd_event_init(&event_virq->common, "[iommufd-viommu-irq]",
+				ucmd->ictx, &fdno, &iommufd_event_virq_ops);
+	if (rc)
+		goto out_irq_wq;
+
+	event_virq->irq_wq = irq_wq;
+	event_virq->viommu = viommu;
+	event_virq->type = cmd->type;
+	cmd->out_virq_id = event_virq->common.obj.id;
+	cmd->out_virq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+	iommufd_object_finalize(ucmd->ictx, &event_virq->common.obj);
+
+	fd_install(fdno, event_virq->common.filep);
+
+	list_add_tail(&event_virq->node, &viommu->virqs);
+	refcount_inc(&viommu->obj.users);
+
+	goto out_unlock_virqs;
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(event_virq->common.filep);
+	iommufd_event_deinit(&event_virq->common);
+out_irq_wq:
+	destroy_workqueue(irq_wq);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &event_virq->common.obj);
+out_unlock_virqs:
+	up_write(&viommu->virqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c22d72c981c7..be1f1813672e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -133,6 +133,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_EVENT_IOPF,
+	IOMMUFD_OBJ_EVENT_VIRQ,
 	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
@@ -567,6 +568,43 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+struct iommufd_event_virq {
+	struct iommufd_event common;
+	struct iommufd_viommu *viommu;
+	struct workqueue_struct *irq_wq;
+	struct list_head node;
+
+	unsigned int type;
+};
+
+static inline struct iommufd_event_virq *
+to_event_virq(struct iommufd_event *event)
+{
+	return container_of(event, struct iommufd_event_virq, common);
+}
+
+static inline struct iommufd_event_virq *
+iommufd_get_event_virq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_EVENT_VIRQ),
+			    struct iommufd_event_virq, common.obj);
+}
+
+int iommufd_event_virq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_event_virq_destroy(struct iommufd_object *obj);
+
+struct iommufd_viommu_irq {
+	struct iommufd_event_virq *event_virq;
+	struct list_head node;
+	ssize_t irq_len;
+};
+
+static inline int iommufd_event_virq_handler(struct iommufd_viommu_irq *virq)
+{
+	return iommufd_event_notify(&virq->event_virq->common, &virq->node);
+}
+
 struct iommufd_viommu {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
@@ -575,6 +613,8 @@ struct iommufd_viommu {
 	/* The locking order is vdev_ids_rwsem -> igroup::lock */
 	struct rw_semaphore vdev_ids_rwsem;
 	struct xarray vdev_ids;
+	struct rw_semaphore virqs_rwsem;
+	struct list_head virqs;
 
 	const struct iommufd_viommu_ops *ops;
 
@@ -595,6 +635,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_event_virq *
+iommufd_viommu_find_event_virq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_event_virq *event_virq, *next;
+
+	lockdep_assert_held(&viommu->virqs_rwsem);
+
+	list_for_each_entry_safe(event_virq, next, &viommu->virqs, node) {
+		if (event_virq->type == type)
+			return event_virq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 015f492afab1..22381ba031b5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -361,6 +361,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_event_iopf_alloc,
 		 struct iommu_fault_alloc, out_fault_fd),
+	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_event_virq_alloc,
+		 struct iommu_virq_alloc, out_virq_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -528,6 +530,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_EVENT_IOPF] = {
 		.destroy = iommufd_event_iopf_destroy,
 	},
+	[IOMMUFD_OBJ_EVENT_VIRQ] = {
+		.destroy = iommufd_event_virq_destroy,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index a4ba8bff4a26..9adc9c62ada9 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -67,6 +67,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 
 	xa_init(&viommu->vdev_ids);
 	init_rwsem(&viommu->vdev_ids_rwsem);
+	INIT_LIST_HEAD(&viommu->virqs);
+	init_rwsem(&viommu->virqs_rwsem);
 
 	refcount_inc(&viommu->hwpt->common.obj.users);
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0d973486b604..f9ec07efed8d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -54,6 +54,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
 	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
+	IOMMUFD_CMD_VIRQ_ALLOC = 0x92,
 };
 
 /**
@@ -951,4 +952,35 @@ struct iommu_viommu_unset_vdev_id {
 	__aligned_u64 vdev_id;
 };
 #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
+
+/**
+ * enum iommu_virq_type - Virtual IRQ Type
+ * @IOMMU_VIRQ_TYPE_NONE: INVALID type
+ */
+enum iommu_virq_type {
+	IOMMU_VIRQ_TYPE_NONE = 0,
+};
+
+/**
+ * struct iommu_virq_alloc - ioctl(IOMMU_VIRQ_ALLOC)
+ * @size: sizeof(struct iommu_virq_alloc)
+ * @flags: Must be 0
+ * @viommu: viommu ID to associate the virtual IRQ with
+ * @type: Type of the virtual IRQ. Must be defined in enum iommu_virq_type
+ * @out_virq_id: The ID of the new VIRQ
+ * @out_fault_fd: The fd of the new VIRQ
+ *
+ * Explicitly allocate a virtual IRQ handler for a VIOMMU. A VIOMMU can have
+ * multiple FDs for different @type, but is confined to have only one FD per
+ * @type.
+ */
+struct iommu_virq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 out_virq_id;
+	__u32 out_virq_fd;
+};
+#define IOMMU_VIRQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIRQ_ALLOC)
 #endif
-- 
2.43.0


