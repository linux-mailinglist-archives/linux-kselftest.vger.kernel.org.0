Return-Path: <linux-kselftest+bounces-28770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94008A5CFBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3BA3AC135
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE57264F98;
	Tue, 11 Mar 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Div2z26w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A56264A73;
	Tue, 11 Mar 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722339; cv=fail; b=K4BAoZ4NQCr3B7nmmh75ISoX9zBlyUnPZamIvqTzU82TVXAcqfxJkLrEHLDveNXKtsSbrAe1K7TM/KUSyW63tsVQ+q+NbUMLlBOmSMG5qmsynmSe68e1kRPTtHytDWC1zymmNy7FGvicYmFxGVVUKnkrF1kA1zIZcvFyeP/d5vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722339; c=relaxed/simple;
	bh=eQWfMySKNCTUTxoIz0mf9YmYHsKUjPyxqOuygFPBCYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFxBMzINUHUTV5GoVsMqc9v5E8NE0xcNuZgn8IClIYdxqoS3MUY2z5v60gVco8HHmiJ1BkoFIM6gJ7ipMFU3qDha4i4Bu81eGnnLXjkE52B6y/N1j4UAE30SNE5P3dY86DjOczM6EgkfRNeEFaW9P7D3BMafBDkgkGD57rYAL64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Div2z26w; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn0UqcFtdWnpZUFCiqOQBEJyyzCpaXDNnbTKmTHJ9+ki7GCbaiQN31WnlrMOxH+NYf7y+PePawWL+Kg2FFhle8n4hogi9u7JIh4jujPZMkWmqdtJcCoda7za//3c2ArPD1tfRHrDGTQdv3JwajmdOPZliTHdb9EJKOF+/nK7IjYVcDYovAtjTY2gZIY/pfXaHJ90m66wZZtK6yiiFhEEfdPCpHxV/Mz/49D0MdfaC5wTtj0EmfwXJxI2fyyt9IkYvd6gz5433UrbM9ar5IXOqMwX6otDW1fqWwvWoHYL6ZuIbPcm4dUF0Uauhj+/QBIkMre9MCbQNuVwEkpwSH7Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTZ/HF3UVdxjFI4T5WdFmZ/S49Ns4vmDqtnqXeARvXw=;
 b=H+qRCU/YWa4A/7bnzrWmRCN+KA7iyWopXAAZl8eMJKxR2NP9wk2GURQFS1zqSu/UD5n0lY4+Fx8TW9b1W0sTLUidSyQ3D2p92Y7uPWC2ElDPQpOSZvZHIX3LbiteFdjIzYUxJhdCYSrNzIqTlo2JTVBGLUBEPml3TZtl6vq/pBtQQlRaM6fIyqyW2f/3A9f4aXY2u5/qN04BqItHXXLzSgRUE47KMBi9jpJDdXH2I4t72SWgIJU7hX8438ORMgN0IGI7+omZof/7owZztcrZsZgGbBUWDFMJAETtoA7/Y2T+pqwzqdmPUzwTfnsA2FSa/hEMfWq56tdOBkQlfySetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTZ/HF3UVdxjFI4T5WdFmZ/S49Ns4vmDqtnqXeARvXw=;
 b=Div2z26wBUgR0htIaJOWszPP4ehE76fNnTHGCCelEB/6USnLYT6WBCEPtTaTH3F4AvYRf8EK2I9/C+/bJejj02b0dSVPaWSMG5/eY3KTNZ9bmiUN2kPCtQUbVEEgxRhv9c5PRsu3Slul8vmBLjJ2pnfqY9BCfqP1N+et4mDTt4TZLUgjAhkQroq1ylakaeOWIoDJWmbrQISs32KWpu15PgC1zNo021KSx9Hj+PY2whHOhf+3njSgK9xmigvPoj2Ruz6gPadlTQmbPi6R5XLRBV3cR5NpeESbe9+ZzT49xU7Buu22E1UplfW2reSSJ/PbdCf/Fr2YR5PKf3+HAPKHqQ==
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:30 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::c2) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 19:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 07/14] iommufd/viommu: Add iommufd_viommu_report_event helper
Date: Tue, 11 Mar 2025 12:44:25 -0700
Message-ID: <44be825042c8255e75d0151b338ffd8ba0e4920b.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: dba623fc-25aa-4ee2-0acf-08dd60d547ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8M/m8nFlGUtCHa6Q1OwTA7ERJ+qYMKdYYgWEkZe8AZeLpmkxXp4+JxwzeZQf?=
 =?us-ascii?Q?uy8EhXSulQV8iyAqsFYsFlLNgy0ATwV1AAehI7k1CT1FUi7zmJvJfAFm+lwV?=
 =?us-ascii?Q?IJ9n5Tbd89rfOj9wp280nk4v5VFU346wWrgaVi7+JdyH9/5jwxDqGC5vp3n+?=
 =?us-ascii?Q?pOZRdBEtMQ/6GRIXAh+75/S6dr710Zr+LPLjYC6g4m3ju/iPnQBXT1CrT24k?=
 =?us-ascii?Q?hG6zWx3v1uDS8Lo2Huk6D6eqmEJEWC4KOG8nkfgJmNNFw2TabFpcRlnAimu+?=
 =?us-ascii?Q?q5u/puJ/LSAyCKIrYWt22Ufz/8CxugxlNiqpae+wkrzi37cAT23MMrmzcYfZ?=
 =?us-ascii?Q?DKhljmRYuiGtqztxD5qGPUpWpCRy83fJ4yy1+hAd0GhzR9ZPDu0nphpBZjDU?=
 =?us-ascii?Q?WkoH5E/aekG53nk+F+sl9tuawDn4b/dIlcvh7D+ahpYF1bwJEFUx6BS8GQZe?=
 =?us-ascii?Q?qIsH7GbecOyB1KYmsy0xeYYeA9gr19iiehB05CT+xGbGIyCZQPkiiaoEbb7a?=
 =?us-ascii?Q?sshXVp0ndVycAFYujtotiFDzGjlfZn6AW6FdFJ630bS0/t5x/pLeRnEtMZNm?=
 =?us-ascii?Q?ZWRXQLycgp8MDb1uzvW8+4WBT8tBrnpAThaXEMB5cCacTnKptnNefuN99lFT?=
 =?us-ascii?Q?MN6SWeRzcOkVxgWqG3cnWdJnAf5qzNxgNqtJE5jgXzTOSE8voldSMDpG+ptm?=
 =?us-ascii?Q?MxrCdCZyafSDMoQh4HFgGAtsE+9gxYp+Oeqtqv8ROyY53uOEe8e+rroFcfao?=
 =?us-ascii?Q?LVbiedYiJJWtb9f7ZXgMdPsDOP/441mLU2dbx5/2tFKafLk16WHqordcpqKn?=
 =?us-ascii?Q?1uDaOFrWVzsYtxAb62iiGOD+We77LAtx4iKdHG4ITCbnEK5nn+BRLjMx+fx4?=
 =?us-ascii?Q?6byVFs1rKTWvGQbbTuX8Md8MD47OZMT4nElnOs1xrkV7JeRV26gv6Awm1Sm0?=
 =?us-ascii?Q?/hRUH9TS81bdldqkcWM5ROdYvV57ToYshNg0FvS8q9lX6h5/WniljVN544op?=
 =?us-ascii?Q?vEB/C3+5WRcxAXL6JsRcL2hs2JFODRHwsse0uM5amXpr1p+RnVR3WKvjOogn?=
 =?us-ascii?Q?zN6JsRB7+FGdLr5FgbMfLz7sp3DWasGnMlhb9UBtpghH+v6yPpQY1sQWhoZP?=
 =?us-ascii?Q?J3UiraVYaPbQQX1SOzWtGodUACMAadCG6bDdVYUrUOB6QJSZRxE6EVTPBDy1?=
 =?us-ascii?Q?nKvGu7Moy/VRCB8BQt2PjOzty8ZbofnARWBCRHvNGPfQUGqyQrRZ0HjyKwYT?=
 =?us-ascii?Q?jEoAZd/z0mvEN4cPPQKCKWwktaGQZdWSVb/UC9CmTHCbmTh/8tRzCBvGx6IN?=
 =?us-ascii?Q?w13EYrBCLywmFO51tlNTw9GoJ1IBsWfxgnNlpWcS24ZUS2pubdBJQwqUJxfz?=
 =?us-ascii?Q?Yoi6dZZUHb/tGaTS8XfK/bkyrVA0L+X3Ft9sh+zA9BuaWJ/lMcM8zShVoW6o?=
 =?us-ascii?Q?5f/RcsRepHvV2m/62uZNR7CiEe13VXbVTcE4TtzFNSu45pfWAFM/1Bj/5qB5?=
 =?us-ascii?Q?I8TT890cTGJC6gQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:30.1492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba623fc-25aa-4ee2-0acf-08dd60d547ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

Similar to iommu_report_device_fault, this allows IOMMU drivers to report
vIOMMU events from threaded IRQ handlers to user space hypervisors.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 11 ++++++++
 drivers/iommu/iommufd/driver.c | 48 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 05cb393aff0a..60eff9272551 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <uapi/linux/iommufd.h>
 
 struct device;
 struct file;
@@ -192,6 +193,9 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 			       struct device *dev, unsigned long *vdev_id);
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -212,6 +216,13 @@ static inline int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 {
 	return -ENOENT;
 }
+
+static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+					      enum iommu_veventq_type type,
+					      void *event_data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index f132b98fb899..75b365561c16 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -73,5 +73,53 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
 
+/*
+ * Typically called in driver's threaded IRQ handler.
+ * The @type and @event_data must be defined in include/uapi/linux/iommufd.h
+ */
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len)
+{
+	struct iommufd_veventq *veventq;
+	struct iommufd_vevent *vevent;
+	int rc = 0;
+
+	if (WARN_ON_ONCE(!data_len || !event_data))
+		return -EINVAL;
+
+	down_read(&viommu->veventqs_rwsem);
+
+	veventq = iommufd_viommu_find_veventq(viommu, type);
+	if (!veventq) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock_veventqs;
+	}
+
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+
+	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
+	if (!vevent) {
+		rc = -ENOMEM;
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+	memcpy(vevent->event_data, event_data, data_len);
+	vevent->data_len = data_len;
+	veventq->num_events++;
+
+out_set_header:
+	iommufd_vevent_handler(veventq, vevent);
+	spin_unlock(&veventq->common.lock);
+out_unlock_veventqs:
+	up_read(&viommu->veventqs_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


