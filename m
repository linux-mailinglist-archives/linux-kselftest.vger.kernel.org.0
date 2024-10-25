Return-Path: <linux-kselftest+bounces-20745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D49B1398
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F25283C37
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321EC21E754;
	Fri, 25 Oct 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6mWOfFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6721E63F;
	Fri, 25 Oct 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900279; cv=fail; b=rEXDhZTzkyfuzxGdlmgX2IF/2seeCgLtxAbKLfwuQu0Grtug/n0seH56g8LXF8SwoBHRHt9HrCCB+oCvnyK5kP6GjXAlUTv/lBmOsJKG99z6b5H9vBp8bwPRNCcJvzXRHqBdboym2AKJH10XL0p1bSKSCW2wStH/9yC6gsizFyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900279; c=relaxed/simple;
	bh=cC0jz4bcpNdkQAMS+QyStdtWW6QC3eJ5+coK2iC9kcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwb3W4pyLNaY747nYK6jCHFT6NLwGaML2DslKMNgz+LZkC1J/+4eVLn9nMfOLfTrnCSM9UdaCBP3AlnYTn58VpltPxwBLXHbjWg/fG4XNRJ7DOS/aNJbjVVdQYmBdJLX3eMc34fqkvy8fUCj0zUb+CtWP9pjVshQRKMkPWKzoxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6mWOfFS; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBAEzV2DVBhnv07V7YJ1qR8aYDH0KbH63/g4tGjvgQXiYbhVZLGQj8AzhQr92wO/z0ZrRqL/xOwNy3vIbRTubR7aoMYqkKl/dTCP5LjhkOwQj6eMiBk1GT0fqm+gjXYgVncds6UiWyIakHm1Lts5871xPLEQzvfkcf9cRSwQ8QivXE8cej91xbKG0EuUqGp1XEGBtGuaK79zd+WCcVSC+CRjVRxrn3vzVgrOFu7ngF5tl6eDb+SnIp/Snld5/xTTM4iJKJj5ltGyutR3G2a5MqO4P6brrdM300IrjeXGiXsSbNrKZUzJC2Zms0xuVcvd81J0ZKyilEycAzczHmN9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiC5SOn5wx3+AyofS3XSFjYoRsquGrqqghEx28hfyWA=;
 b=s5udR2+alF03cZ0t0VZMclhCcbToQ3QVPW3pi9EA/Y3S/jUdeGcaJZPsZ0VEnIykAwBSUCy+gMitreM7KOiAF5WY6gyiqZDvpiDLrU2pyUyHz59VR0HrzK21e4Dauo4NKmCaPmYWIqqHqqBHrlqt0shQ6ePxdsyCjfDHtmFn0BT+qosq+bbMzgGHy8P8BZlyW4O4kPdZkjBLgTZd8YRBbn3WEwNUpfT5oXwBdKRqdF7Kf6FDz5agqr6N1On0RDbCf/xrKeU0Jb/vmO83oqena6Ne9lyJ07+fDDrWkF2RGurmAF+sVw4AYyULuOk9WLAFNfuzwJTmGyF7d89OLnqCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiC5SOn5wx3+AyofS3XSFjYoRsquGrqqghEx28hfyWA=;
 b=t6mWOfFSGhvKlOrVNHx+lDqYbsr6BLt3p1kFFTHO9FqdtNhh6qObuspiZdYWp8hgXO/aL/02F96xTYty8cuvDNNn/kd6Z881sBzrL+dW7Pe0FIbUARaENCGsOPtruFLTUDA2NhICwelGtqUIhqrpVafvgU+juTopM8CsY//UclO/r4v+USUSFFLvTnfR16QL5SEN+mFXb4xevEep3B6Gj/EcMkqJATQfgG5weCbKkJH6zaECZI6MEvojUUCZ5JWcwnB+35wSg57I/i5Dwxis9+hFz+yuf3lXkxrCwaBH2VTETv78FSYklNZC6mAPwuTSOzEwGGY8ckChd7pN+Zo/cg==
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 23:51:11 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::54) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:51:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:51:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:51:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 11/13] Documentation: userspace-api: iommufd: Update vDEVICE
Date: Fri, 25 Oct 2024 16:50:40 -0700
Message-ID: <3e7166c065f767ff55c3207b12144a8aa4dc8ae3.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fe2ed3-74de-4192-7b26-08dcf54fe749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+vgNPwMxTHLVBk5kHJ84rM/aLRx9iOOq9CW+jOJZwPsRmSrjedvaR4az60v?=
 =?us-ascii?Q?m4U0Et+1xHOth42nFSjmYJvh91gvy3DcLjaoFa6SenceKd1MpH1N2bH96KXO?=
 =?us-ascii?Q?3JVtnHB/Zp1PuEoo03OngZKYIO4ZttuYETlZZumKNuU/d2OC8fj1nT1xLOo+?=
 =?us-ascii?Q?nKDQTwzrIUqjdlWfS9ZDU0mmukSLtLYJsw74a6vSUZ4xgYF9kCqSUp7Yn4LD?=
 =?us-ascii?Q?G419YyS3xEsLphyTWTqMurO+OYwKfbLrN6qH7sNAW6CzGoNLH/ofc+b08K8+?=
 =?us-ascii?Q?+TlFFRdIrZZpuBWDdYymsuc1k5qT6tY4HJE+eZV7iW0zjV+f3/T+U1w95PwF?=
 =?us-ascii?Q?sim4rm2f1QetztxS4TWD1xPIcan66csRXmXpUYPv+ZQF6SuAnze/9Ois9uMW?=
 =?us-ascii?Q?9INR+E/LUDv1fQ1jDXOJ403LrLtp+vOMn1p4Lcov7n5j5kCVY4ZDtU4rLilJ?=
 =?us-ascii?Q?F1ZbVzfD/0jxqOzbsoc6urzFlI+q/QO+5ieQoaGE52NbCNSn7vCpKFaowcc8?=
 =?us-ascii?Q?FYB5j/FPBz3s9lbad5Sdv3wMyObpMqSLXZCqvb4YebtGvmhe7vru1886yCuO?=
 =?us-ascii?Q?fc+7mFlXfA0PE5i2OfxF6kindT/qUUHL4SDgTzsNCbm2KgpbBPAWS65kiIQX?=
 =?us-ascii?Q?K6h/HpDibwHhYUmDwNSgtcM0xFr6QijcTagsPux2AcHlP3Gw4bfWH8e8E+Y3?=
 =?us-ascii?Q?+aV/Neoij7J7Uh8W6I/S4lsxBMq0DmDkCr2VTqvudQ6081/yCdlQ7E+cNquH?=
 =?us-ascii?Q?wDSxiq6GGTYOmS9mEIu6nyProUNI5UO7BclDldx+0cEzKrPICjltkq9RPk+a?=
 =?us-ascii?Q?QIjGc+XQpi5dGXVFk+v768LtCcelRiWXtzJgUCGOahukDg+euXxzdnLwVnw4?=
 =?us-ascii?Q?N410Zsz4YriaVtneZ7u0RBQgZ8ouYNMx9np4fBfTYJoeCtEdIWVHVpMhEARg?=
 =?us-ascii?Q?sl5A/DaAN4NhxncyuTD3sGu7qJoADYnVFnz3OZlj9EjAS0LEFSh2jcssmf0X?=
 =?us-ascii?Q?x6MF1TSDB9alPfGUh/XtXgUsEoSAOEj963K6wZGylpmiqoAxtHA0QoNP3vkA?=
 =?us-ascii?Q?whwvPxJh86eSAcP/+5g4r7PSKutTE7vBxettnrmt1QPE+0I4pda2x0t6aBCT?=
 =?us-ascii?Q?Z0/QCahW/zhXtsM3TLelqLCFiAY+ASGp6omXJG13VB5EVn65YU70JXcVM7Y+?=
 =?us-ascii?Q?HgIx4zCJV6i/dnz5iq4qVfCV7zfpwp6yyeXWNPVuyKv8Mb8AxvlrQwqdJ0l3?=
 =?us-ascii?Q?ivlvdi2h/sqWPYMZm1tYpQFVG7WfmU0h8gp9/xTltb3aKx/wczgkhoB7Z5A3?=
 =?us-ascii?Q?L1YUw4twxA3MhcY38oFt9RMEDx5zajo3fU9cycRmyjxCamifiohSFCcyNHkC?=
 =?us-ascii?Q?3YVf52INzz8y9k4DCJGKz//1T3oNk3XM8QXFOQDRozsAGu0z8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:11.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe2ed3-74de-4192-7b26-08dcf54fe749
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604

With the introduction of the new object and its infrastructure, update the
doc and the vIOMMU graph to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 41 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 92d16efad5b0..3c27cc92c2cb 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -94,6 +94,19 @@ Following IOMMUFD objects are exposed to userspace:
       backed by corresponding vIOMMU objects, in which case a guest OS would do
       the "dispatch" naturally instead of VMM trappings.
 
+ - IOMMUFD_OBJ_VDEVICE, representing a virtual device for an IOMMUFD_OBJ_DEVICE
+   against an IOMMUFD_OBJ_VIOMMU. This virtual device holds the device's virtual
+   information or attributes (related to the vIOMMU) in a VM. An immediate vDATA
+   example can be the virtual ID of the device on a vIOMMU, which is a unique ID
+   that VMM assigns to the device for a translation channel/port of the vIOMMU,
+   e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to a
+   Context Table. Potential use cases of some advanced security information can
+   be forwarded via this object too, such as security level or realm information
+   in a Confidential Compute Architecture. A VMM should create a vDEVICE object
+   to forward all the device information in a VM, when it connects a device to a
+   vIOMMU, which is a separate ioctl call from attaching the same device to an
+   HWPT_PAGING that the vIOMMU holds.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -133,16 +146,16 @@ creating the objects and links::
                          |____________|     |____________|     |______|
 
   _______________________________________________________________________
- |                      iommufd (with vIOMMU)                            |
+ |                      iommufd (with vIOMMU/vDEVICE)                    |
  |                                                                       |
- |                             [5]                                       |
- |                        _____________                                  |
- |                       |             |                                 |
- |      |----------------|    vIOMMU   |                                 |
- |      |                |             |                                 |
- |      |                |             |                                 |
- |      |      [1]       |             |          [4]             [2]    |
- |      |     ______     |             |     _____________     ________  |
+ |                             [5]                [6]                    |
+ |                        _____________      _____________               |
+ |                       |             |    |             |              |
+ |      |----------------|    vIOMMU   |<---|   vDEVICE   |<----|        |
+ |      |                |             |    |_____________|     |        |
+ |      |                |             |                        |        |
+ |      |      [1]       |             |          [4]           | [2]    |
+ |      |     ______     |             |     _____________     _|______  |
  |      |    |      |    |     [3]     |    |             |   |        | |
  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
  |      |    |______|    |_____________|    |_____________|   |________| |
@@ -215,6 +228,15 @@ creating the objects and links::
    the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
    as a nesting parent object to allocate an HWPT_NESTED object described above.
 
+6. IOMMUFD_OBJ_VDEVICE can be only manually created via the IOMMU_VDEVICE_ALLOC
+   uAPI, provided a viommu_id for an iommufd_viommu object and a dev_id for an
+   iommufd_device object. The vDEVICE object will be the binding between these
+   two parent objects. Another @virt_id will be also set via the uAPI providing
+   the iommufd core an index to store the vDEVICE object to a vDEVICE array per
+   vIOMMU. If necessary, the IOMMU driver may choose to implement a vdevce_alloc
+   op to init its HW for virtualization feature related to a vDEVICE. Successful
+   completion of this operation sets up the linkages between vIOMMU and device.
+
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
 
@@ -228,6 +250,7 @@ User visible objects are backed by following datastructures:
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
+- iommufd_vdevice for IOMMUFD_OBJ_VDEVICE
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


