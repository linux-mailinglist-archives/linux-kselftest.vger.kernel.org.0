Return-Path: <linux-kselftest+bounces-16449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822B96150E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4103C2883E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4C1D6789;
	Tue, 27 Aug 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmKo/f2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C81D61A3;
	Tue, 27 Aug 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778174; cv=fail; b=LXoEYvV04cRA5h3Cmq7Yi7sVuTaFOsSDTJJsPjrP0aUNA3QpFugWAKe39V2SRKQjFFpURH+yEDk3bxaeq87/83LdRnT6dpxvWH8CgH9JOatYLK6gKHrI9oeyO6UUDRxu1qQr4Id963+RymQGsjOD0eh+k77IIsrO/2BTdZq9yds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778174; c=relaxed/simple;
	bh=0CoHLhwL1c1t318kq4SEDJgELclaNJdvHUqZyCxCgmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aok6HAb4EH86rW+NNiqHcduMD5FLDqHsDRDzbM7wsi3qwjH9/fz130bPILp0nnkCCgFg+SC5HvT0ETr1dUppBa1hxkPKFm5+nwarnqrstyGPYyQuklgYmpoSi4ppCQx5Syih4+YlM3/tzBC8VhwPWbtr6TEqyzFCZjipeSrZCdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmKo/f2A; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/vB5olj1Of/G6BGeTqZURggacHUTmkGFpvtj8Uju4RTdi4vBzz99LxNFKUlZ+L3TrdYDUuDHsmQ0L1g2KFyAFQn+e9UeuCTFqjXZeRnQsZdSFYqMpNU93cNIFuYuH98qxF3Tj8/4bcVGQM1mvtGHXva0/F0b9cvd4BV4JaDCeedkVoelRR+HuHuBgHFbMJNHECrAusWCZOzdrQRaGkdCftFdOrcV+pbrOAz9MASFbxod8Lg7ZbK0TRZK8MaDRBngmFOq/ilaoIIOYYXHJkLAvibdhw48xG6MGtcAAfDwvNkQr9jfTXUqi/PQfCLWV0oBhTmovQervmcBNisYWS70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4dsKNnuk6CqIH0N6k5Osr46RlFdbBtzX+OpDl0TX4E=;
 b=nW6kYJHpSrHauj3ScRyzlZR0fMUr1sc7KKLt4WeG279H6aaUjHG7UqtAFeufKT4XPSnhhJgxk7S4MwLLnccvF/pxS47FvuH5RGG73oNrT5pBJFR1PAApmIcsXszruRBM4/VoRCoubzZslmJQ3urKSRDyKNqU7yApxBqv1dVj7+ipVQ1dTq9mZeNt/2X4gNfiXOujXQ+UKykl71OfWjuKseeeWW5ZTcnO6UrCxhFL7C1QgabhN8ZFoopqXMc+x9gMHYu9gOs5v8Y2hVpqO9Wl3Ps6Puc4x24BojXNbJk+PnH+9OWzg8J7q0PJYJl5KmJI6quAzpjzn8Anm1U3mgcmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4dsKNnuk6CqIH0N6k5Osr46RlFdbBtzX+OpDl0TX4E=;
 b=ZmKo/f2AnOy0M6IuI3srG6IK7gSqSM7yh6/y9KnUk6AjZBaH4bThE953xLTE3aMd0Fkm9AdoTaqexNAS3DLX3SSBtk3CR4Intef/UaxCXtwt/Ft8TQm/YbTNHhelSe4RT7qF+r78T0djYDJzdmwBTlBDAkMRNHCtj0cKLSJEizZlj++kYmrsY4+Ix9mQFT5Mb7bnnbFJaVB2DDJNN92p21Y/gdQU/MzboFvBiV6V8XGWap1Qnxpmcs9Z3jPiSfSh81LWF00iDT/dtM45vBNBNJusSDPkbxxpGq/BgxwJbFPzMXOw21X+crXJUYbvMGUddxRITaC8wmT9eX4n4clauA==
Received: from CH2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:610:38::35)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 17:02:45 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::22) by CH2PR05CA0058.outlook.office365.com
 (2603:10b6:610:38::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control vdev_id lifecycle
Date: Tue, 27 Aug 2024 10:02:06 -0700
Message-ID: <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f22e4f-e1b0-4631-bcad-08dcc6ba1210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3DT1ktkjJ5BHCUUbufscsayewbPC6AUzfDrYPenJLPTtOBiI84vQifG/0onA?=
 =?us-ascii?Q?ODaNlEPCM7hslmuHM6pZEjn0VyfNjTqWbU473DO+ILsRiTKKYm0eM8t66u1L?=
 =?us-ascii?Q?RSqUKUv5jS0QY1sUTMDAAbwQL691ZGkmHiK9dthSHASu1fSNzBzTyWOit9Ho?=
 =?us-ascii?Q?hKta/otcoN/f/N+BgZWc9RzQg2KMGPBCaZ2cZ/dZM44KnSuujSdpV2/L1Sn9?=
 =?us-ascii?Q?r1HqBkN8nvb6wiNfaKQNa9/F0Nh4rQrFn32D68YjE5lskZqmGi2QzhXku6vQ?=
 =?us-ascii?Q?yv6sewzhzSyAr58UNcxVs//ZFPjdwbtnMTHKQGprXbQil5KWiuRatEGycgPo?=
 =?us-ascii?Q?+mukvoGtBSbg8Zz9PScUSIV6L96K0BiK8EaYjko3s3qJgnm0+KP2rpXB4ttl?=
 =?us-ascii?Q?YcJebdyqXLsBeLdwkFCSpDjMzPy3szarm+Gj/wqLgo2pdnd+w5aDse9iMU4q?=
 =?us-ascii?Q?XK5f2Dn+VvDFu30dtcdkwfHkPeZZ094j1Mdwo4R5qkkt3rtZlrfs8iCOV4GE?=
 =?us-ascii?Q?cLPxW0w1fK0BavzkzdtYJvBlvXUZFDS4UB3NLpTDEKKlie6qhmvcW/Lai646?=
 =?us-ascii?Q?TzPvVXl+47M5iX/wYfxHhNleJaG3wOiXwB+gLRPhqk2StXyLLyOzo66mahkB?=
 =?us-ascii?Q?Frz8IZrljI+TLfpek9LW4OLgOVKu3fhzqXEEMsP4APly4nUfsumJeEPPqM3l?=
 =?us-ascii?Q?irDtHK2tTsdT26fujBQ8G465rz4Xw0VbIQIJ1Tk/AHs4+PXJdilZzfIXDHqH?=
 =?us-ascii?Q?UwW9mQMspZ+rPl7LlG7KuwapAy+/rkwGre5GcUrSZTt1seQq8zWRHd+HUg/9?=
 =?us-ascii?Q?3t9x6y1YakI6qASx1cDnZY9xnzlEU8gtd0gsxDJPmi8qDBqi3SPrak5RSDUh?=
 =?us-ascii?Q?pJM0oGCEAHk7T9HI6KGzN6fJGxuKkAOkfGgfKFbIWFDNlyUzWwlV203coSnm?=
 =?us-ascii?Q?odsCc3tTcxXFnj2Uw4mkYxrdURtpNIfH1FK45FNZf50wFp50FYI6QhtncICx?=
 =?us-ascii?Q?BG9ehYJQ9hBJHv+u2hz57n9omadqchEDg8m2QPHxKtfzQXvgGnOJlSonVFNA?=
 =?us-ascii?Q?CayZYO3D6rAM0JDzepdh7TER3/i1l62YCi3zaJrsYcMKpAB2JXRJUGPv+oWi?=
 =?us-ascii?Q?PHyPvMkdN+Q3OKS8MI4WKABSbQMAJmR84wHyY56Mv3ERyRO/FMLcTaDgp93S?=
 =?us-ascii?Q?vYP/6aeuyoyOF7cSZ/DaBziN11qLnXqJMcsVJE0hamZCQ+POnwY0YzokOH5c?=
 =?us-ascii?Q?DQfJI9sK+/Gpsq5q/Q28cGlCDxfqQukJGP0PTLK4MAb9AGR8jfE/sYbtX7on?=
 =?us-ascii?Q?HnoRS1QnYq4HVUCxySi/bUv1gdcoD5erj0OHoxEddN0+fHSar1zT3n0iLTsv?=
 =?us-ascii?Q?TcIJ4MAF7sFrYQcFJKpHr93f6QNDEa+p9SCmmrUQPYSq1vqGUJk4q6ilvN3m?=
 =?us-ascii?Q?SZORs4AX0Nmsno+aEf0NBbJPYTbEYzje?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:44.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f22e4f-e1b0-4631-bcad-08dcc6ba1210
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606

The iommufd core provides a lookup helper for an IOMMU driver to find a
device pointer by device's per-viommu virtual ID. Yet a driver may need
an inverted lookup to find a device's per-viommu virtual ID by a device
pointer, e.g. when reporting virtual IRQs/events back to the user space.
In this case, it'd be unsafe for iommufd core to do an inverted lookup,
as the driver can't track the lifecycle of a viommu object or a vdev_id
object.

Meanwhile, some HW can even support virtual device ID lookup by its HW-
accelerated virtualization feature. E.g. Tegra241 CMDQV HW supports to
execute vanilla guest-issued SMMU commands containing virtual Stream ID
but requires software to configure a link between virtual Stream ID and
physical Stream ID via HW registers. So not only the iommufd core needs
a vdev_id lookup table, drivers will want one too.

Given the two justifications above, it's the best practice to provide a
a pair of set_vdev_id/unset_vdev_id ops in the viommu ops, so a driver
can implement them to control a vdev_id's lifecycle, and configure the
HW properly if required.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  2 ++
 drivers/iommu/iommufd/iommufd_private.h |  6 ------
 drivers/iommu/iommufd/viommu.c          | 23 +++++++++++++++++++----
 include/linux/iommufd.h                 | 13 +++++++++++++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3ad759971b32..01bb5c9f415b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -145,6 +145,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 		old = xa_cmpxchg(&viommu->vdev_ids, vdev_id->id, vdev_id, NULL,
 				 GFP_KERNEL);
 		WARN_ON(old != vdev_id);
+		if (vdev_id->viommu->ops && vdev_id->viommu->ops->unset_vdev_id)
+			vdev_id->viommu->ops->unset_vdev_id(vdev_id);
 		kfree(vdev_id);
 		idev->vdev_id = NULL;
 	}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index be1f1813672e..4cb1555991b8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -621,12 +621,6 @@ struct iommufd_viommu {
 	unsigned int type;
 };
 
-struct iommufd_vdev_id {
-	struct iommufd_viommu *viommu;
-	struct iommufd_device *idev;
-	u64 id;
-};
-
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 9adc9c62ada9..b1eb900b7fbf 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -13,6 +13,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 
 	xa_for_each(&viommu->vdev_ids, index, vdev_id) {
 		/* Unlocked since there should be no race in a destroy() */
+		if (viommu->ops && viommu->ops->unset_vdev_id)
+			viommu->ops->unset_vdev_id(vdev_id);
 		vdev_id->idev->vdev_id = NULL;
 		kfree(vdev_id);
 	}
@@ -116,10 +118,18 @@ int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
 		goto out_unlock_igroup;
 	}
 
-	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
-	if (!vdev_id) {
-		rc = -ENOMEM;
-		goto out_unlock_igroup;
+	if (viommu->ops && viommu->ops->set_vdev_id) {
+		vdev_id = viommu->ops->set_vdev_id(viommu, idev->dev, cmd->vdev_id);
+		if (IS_ERR(vdev_id)) {
+			rc = PTR_ERR(vdev_id);
+			goto out_unlock_igroup;
+		}
+	} else {
+		vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
+		if (!vdev_id) {
+			rc = -ENOMEM;
+			goto out_unlock_igroup;
+		}
 	}
 
 	vdev_id->idev = idev;
@@ -137,6 +147,8 @@ int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
 	goto out_unlock_igroup;
 
 out_free:
+	if (viommu->ops && viommu->ops->unset_vdev_id)
+		viommu->ops->unset_vdev_id(vdev_id);
 	kfree(vdev_id);
 out_unlock_igroup:
 	mutex_unlock(&idev->igroup->lock);
@@ -185,6 +197,9 @@ int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
 		rc = xa_err(old);
 		goto out_unlock_igroup;
 	}
+
+	if (viommu->ops && viommu->ops->unset_vdev_id)
+		viommu->ops->unset_vdev_id(old);
 	kfree(old);
 	idev->vdev_id = NULL;
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index f7c265c6de7c..c89583c7c792 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -56,8 +56,18 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_vdev_id {
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 id;
+};
+
 /**
  * struct iommufd_viommu_ops - viommu specific operations
+ * @set_vdev_id: Set a virtual device id for a device assigned to a viommu.
+ *               Driver allocates an iommufd_vdev_id and return its pointer.
+ * @unset_vdev_id: Unset a virtual device id for a device assigned to a viommu.
+ *                 iommufd core frees the memory pointed by an iommufd_vdev_id.
  * @cache_invalidate: Flush hardware cache used by a viommu. It can be used for
  *                    any IOMMU hardware specific cache as long as a viommu has
  *                    enough information to identify it: for example, a VMID or
@@ -69,6 +79,9 @@ void iommufd_ctx_get(struct iommufd_ctx *ictx);
  *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
+	struct iommufd_vdev_id *(*set_vdev_id)(struct iommufd_viommu *viommu,
+					       struct device *dev, u64 id);
+	void (*unset_vdev_id)(struct iommufd_vdev_id *vdev_id);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
 };
-- 
2.43.0


