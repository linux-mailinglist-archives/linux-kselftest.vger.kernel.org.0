Return-Path: <linux-kselftest+bounces-20205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D49A51EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 03:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE81B250C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630681FC8;
	Sun, 20 Oct 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pllLiP7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B90632;
	Sun, 20 Oct 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729388157; cv=fail; b=qi5GIgXrfhdwzJdMxKlBDdq//6yQV7nvlvkgnNrECkuWsv9p9mL2HfSP+ifiUpfIZap8ZKb6n+3BVNN7Q9uzccI6i63ohv0QcSYQuvu1lriHJ5AR7kdaTrqo+lg2C1UbTTb3MH11s3s1hZiGmURL5iKJdNm1q6coFDIZgDAfBkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729388157; c=relaxed/simple;
	bh=hEWQ1O/yPYwCiBIEEvHyKBaVsjqKhpqFliGdl9EkgDg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke4R6bzUfxo9Q0Xf/t1EY5vVLh4wb313PvLoKoiuoqtpIpoE0l/LydvGuqvj9sqvTH0EoAVxzaNgzNlP6D8cRURZ5IqO8PpHkQzJjBO414OmlVhPEFJvMLjILYuF4Z1ckKWlq8us65iR3/jsEhH6JfqLMnIqqZCq3CcwHKKzmoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pllLiP7W; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxkXr3Q9d718hLEa9vqcwh44TIQ/dSoB2e4DMySad27Ejk53vPu0OGkC26VNcTYdd2Z5ynAnnkijO4bKSVdBQO6X7a/HCbxigufVVr2Q4t/4sej8zv61tMXuEy8k52UCDXth0JfoZG0p8tnkpVAJJP+j001ed79bJPeGLgUOZUMjz1ahGOul3AkfV3EW7jjlnNEBG7rU/Kw+st+2TTQ9r8+rsyYxetLa17w0ieEt1HblKyUL0BsbpWzfQXtleeyuEu+tuAb20v2wPBew/q0AgZqWAgv6Rkgv1qFdCosp2n4MgWZnF1gRnJgwSNNAf0BzXicvLeSsBaBny2TFDardPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+ibpAVR+QFcvVdTx4qMiifjf8cA9uyuckRiTmJ1k8M=;
 b=BnbVicjj9EyL7TADQtoFobcmG7bNWlC6FsnAqFlEK5XcBMZAWccN5P7tz8k80ZYIWFQa9tgTDGIxKruSVWzjUfhWweZgd/vU/5oxRdNd4vKJ7/qMMc1vA7WDIAGJz9R7zm9G2n07axStUE6bIMBPpJIyWGA2XU4z0wALbAFeyFDMCWqk61ROxuvKZaybUD/P5+fLcDoAdHm00hbfW1+auVAUAfhwDwlVpo7i3V8xj5KskS5BoBNToQhICVgapiVwNF/Deu3KaU9bx1dflKD2+YUOn2IymTi5Q/4iZnIdTJ2graV7Gs9IBY2jh+EfweoUwJjDwco6X39ehDVlEZ6rvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+ibpAVR+QFcvVdTx4qMiifjf8cA9uyuckRiTmJ1k8M=;
 b=pllLiP7WaDotsdWUGxmyx+oZTL5aY9trDpd6cXFrkcuUiM973+2G5ryEElEJsgZSGHKNJB5PMXEXpNVc2WHS1mrB58sC3NzQv7mMEFCZFMO92CiXFUfInm0LUI/5GQQi7bfVwrr1izUesMbXmA8oMGpQqrC3lEi36R2U/3U4N69ga0y8orH1Hx3/BPKDSfrOLhyxnpHn8raD1aC3GUU5iL7G4yrgrCMeXTV0xY47gtJKvk5VxO9BfC7aegR9Q44oSo/l9fegFwwsmhjyXyA9SGxujLNTwsUr3L6h2+kOjYh3xqV8uwWJh/gq9S1lGsDnwbRSAJwGtYjBRKlMrpaXLw==
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Sun, 20 Oct
 2024 01:35:50 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::12) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.13 via Frontend
 Transport; Sun, 20 Oct 2024 01:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sun, 20 Oct 2024 01:35:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 19 Oct
 2024 18:35:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Oct 2024 18:35:47 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Oct 2024 18:35:46 -0700
Date: Sat, 19 Oct 2024 18:35:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 01/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <ZxRecZKbXd7cLOqy@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
 <20241017184556.GQ3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017184556.GQ3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cd7101-cb67-4fd3-87d2-08dcf0a78754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ppw3qTGKLHcCwVeZa62DIdGpuvHj1LvVwyCEbjh+M39DEZG/6oUfevr0Iu90?=
 =?us-ascii?Q?AGO1D0Ajfj3O11PwRErudUjarvdnpri5OXfrBt6ZkCvx9Fv1pBUD4a7kHmzU?=
 =?us-ascii?Q?IIyXXEDwkD3wCm4qbnjPYz2xpLyQZpHQt4eD0HHjGVDatFzRmRXt+cfOBesp?=
 =?us-ascii?Q?nXii0q4mWIEyXWe6i4pddzqhjZhZ5E18E83XZWzY0/TucbvpaonqJU4dhzHL?=
 =?us-ascii?Q?zlBa5MJCszfXzsL5BhlHnvN7uA7TEQS5xV8aRWAnnPK6GJbCvVt2OGSaNFof?=
 =?us-ascii?Q?kP5kD9v4hL2DupiqnyXSqVn7VPD6pc+SGTTwFsyOEdTWWEH4LRMHyNEDsiT2?=
 =?us-ascii?Q?Z/HjiPRFftP5SXcTkTqff4lkm0GrApQ+oJXBz4LjA6oP6mlnVRmqez/10Qlh?=
 =?us-ascii?Q?QW8BQJPiHqC+JNmko9DhRn8tQkh7DKF6lN/P84J5dVGSwPliGHgMtOg1XU9A?=
 =?us-ascii?Q?QFHHJfTgXYidg9Rf24fbyomDBWQ/9CUqQVvzB6GTeMIIv/c6UNy/l92vT2qg?=
 =?us-ascii?Q?MtsL4860VffsZf+5rUkPV8pZR3KoKoBtWZr3deg23tFSxpXQD6QsMnUugLIj?=
 =?us-ascii?Q?Abs/oF1EHwJBvWiQh525Lc08xj1xznW2JL5VU1xbyxePaY1ePsrkAlvf94fR?=
 =?us-ascii?Q?m07xKmVM77xBs2082xOJILzaQ8XMXPrw565NzJ087nxyAYeVQ91PmOwcEWV6?=
 =?us-ascii?Q?A4mxBkbR73CqqKtvhNyrgjAKqAggDA0Q21hPBFN/YTc0M32D7MxS4sWIhMBX?=
 =?us-ascii?Q?oeNcTeuMKiXZ34Q6BKS0+SjdDvaa1vlVR2XTqogoU1tC18BoK9cUc7p2QJyf?=
 =?us-ascii?Q?UHW9DPM5xBvlfdvIsMhrR5cT7foz+PzWPODgDffFNcGRY32Dv3j/hbw1FfaD?=
 =?us-ascii?Q?XT1KrWrzz+4rHDFrcAFcxbJbyLODT1o/dyyxoNk57zgqCUqV8PdTTXArDrFy?=
 =?us-ascii?Q?xPw0AQfPoDA4YPf/0hn8VxjBO3N3GbQZCvqmoNPV2Y0LWbBLl+4tQcFDMA/I?=
 =?us-ascii?Q?M2TkPLpxE35YJsGjKDHTP9avmF9PMH22ubPsv6LEAyz8a/GL7e6n3KQQj2FF?=
 =?us-ascii?Q?NUEFzVHjkog05AL8O61h1GCO9++TwFaax1uLKyYyWkzxvzbGxFC1z2OHM5MC?=
 =?us-ascii?Q?M8yMOIzUuOoN+fkPQahahcuMxH+0BSzTIO2NYtF/zg0et8IVPOczF9A5oEzB?=
 =?us-ascii?Q?m2MLvJO9wQgj+bU94XkZT8bHz11Gk9O/2FlBF6X8TfvJ0E8X7oRlU+mRK1sE?=
 =?us-ascii?Q?7Ljfvghpej8WsXDgq+vRUT9/bYlQJmJRPI4ofjnts8wJhmi01FM8kZyU9MAZ?=
 =?us-ascii?Q?tx7RRF3qoHuDZvhxfC5k0zl5aeDK2/JvXu/td1GK2Z1Q7cfbvFAPie/ov+jw?=
 =?us-ascii?Q?tWLrOKdPgJ0dmwsoDF2fxvPPq7aynhtBuzA3gA/EKCyiQqiMlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 01:35:49.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd7101-cb67-4fd3-87d2-08dcf0a78754
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On Thu, Oct 17, 2024 at 03:45:56PM -0300, Jason Gunthorpe wrote:
> > +struct iommufd_vdevice *
> > +__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
> > +{
> > +	struct iommufd_object *obj;
> > +
> > +	if (WARN_ON(size < sizeof(struct iommufd_vdevice)))
> > +		return ERR_PTR(-EINVAL);
> > +	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VDEVICE);
> > +	if (IS_ERR(obj))
> > +		return ERR_CAST(obj);
> > +	return container_of(obj, struct iommufd_vdevice, obj);
> > +}
> 
> Like for the viommu this can all just be folded into the #define

It seems that we have to keep two small functions as followings,
unless we want to expose the enum iommufd_object_type.

---------------------------------------------------------------
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 4495f1aaccca..fdd203487bac 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -38,10 +38,19 @@ _iommufd_object_alloc_member(struct iommufd_ctx *ictx, size_t size,
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc_member, IOMMUFD);

 struct iommufd_viommu *_iommufd_viommu_alloc(struct iommufd_ctx *ictx,
                                             size_t size)
 {
        return container_of(_iommufd_object_alloc_member(ictx, size,
                                                         IOMMUFD_OBJ_VIOMMU),
                            struct iommufd_viommu, obj);
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_viommu_alloc, IOMMUFD);
+
+struct iommufd_vdevice *_iommufd_vdevice_alloc(struct iommufd_ctx *ictx,
+                                              size_t size)
+{
+       return container_of(_iommufd_object_alloc_member(ictx, size,
+                                                        IOMMUFD_OBJ_VDEVICE),
+                           struct iommufd_vdevice, obj);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_vdevice_alloc, IOMMUFD);
---------------------------------------------------------------

Thanks
Nicolin

