Return-Path: <linux-kselftest+bounces-20334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6069A9451
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 01:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C353C1C21B4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1321FF029;
	Mon, 21 Oct 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKS+6mlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA89198A24;
	Mon, 21 Oct 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729554119; cv=fail; b=OuRjjb1ZbYSr2xqd97YuGHffpp5NkTkFFAyZIsfQ2UKvSSOkdHtkbaznz+Pvy8JlWHdypH9UJFA70ZFV9UHNvRwLZtCSqbjFWOmBH++1s5KPEk8lL8MQ4i9qmViRos/scat35isANbdCsh1hoyZATmVd1BzgXwKXJkDtlx+i/wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729554119; c=relaxed/simple;
	bh=31enK/iAS59LzhbCB5PAp5Y5ypho9mubI2aEjKu34UA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pStWkaaaCpbmi0DUP0PwvdjxTNWBBIYoQTTxP9zn3MZs6MwwFXdoIGCbVVG+Xv9RcJAp1HzbPd41i4tcezQI5jaOLNHZDL9vIoCxeeBYBKRMkzn/Lo/eaLYaWx3mSzlZHLa8WwpJHQtbX4BKqlg8xmpt/h9fyL/lJcbtdD7dBwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKS+6mlC; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1hHbFl9L4W2yW9XNIx44sMZSMYluMHsDlkW89wm7QFMlanf9d7aC32DEYEEK0k+NaTuEmj74gsLB9XSQ1nZrFqrd1nnRGALYv8jTn9de/0oOloe3BuXpYxJcXnHmofh5+ZYVyiiQ6NgPWfN5eoWl2DlHx5kae3dv2ABe87kT0QKaZTK2fuRMuMVRjSzBHdJDw+wSFI6DDwhyh6WsYyUPL5QiZapHUh3rzWwGXJ2lUllS6bzdmuz6qPlSRX2gvJy+3gsy/EIBHqyqS0eNizXtlbDq3Y1RnW8c7FlszI8JI10hjHX+REdJ7kmDAt5StEOVzlQoYlzH83w2DSK2XAFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYC5LOJkUjOGNATPnPjfODSz3gncfkOk29jwYYBEK5g=;
 b=P8e/Oh/1PbmnyEKcduqnKaz7d7J9Tjwg5u+9tdbLMmuvW5BqGifsFZrXaXC6J2kMmjlBKNEeguMyNriy8S9q6fPJOzSiDzsjBwOPX823XhyloJardtyCsvP4l3+6+U8k1I0/3KEpjYcwN1fuJAwjw/1KZZGhMafiMhUubc6j3LK0MCgcPjloIYv4kkZppiaSFnkPQwOw5aNUc3t4LGGTbAuvzeSeTzjrMKCrhr0BrFTxxSn+4pnEMyiZtUVhkeLfw4wW1SCUgxlc4Mcwu/y15KM7iyvCb9Wz43wQWMNP00MN4thB2e4aAyO79R3F/3Cf1jfin24YvikjNRliQE7A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYC5LOJkUjOGNATPnPjfODSz3gncfkOk29jwYYBEK5g=;
 b=MKS+6mlCXbYO4xbAN3WykrFbcRnrNy1SwoovjqyDS1Rx1VZ2kKuAX/CZndwAw+yKtaAU8jnW4fMO5U2l7FPEsTUXMPRqY2SJxzyFKYZzra4t9mKfqiaTYqd0dvXB7D0hndU//ZaDTp+3bTjPZt7URm069zleFVVnci8UgFRTFlTGpjXfxlyNEn9ozDpaOZZ4CFyacjubmzr0P2e5NPB9gP+ar8gIOuGo8ts+ssf+0X3iuCqlOs/cC147Jk18DJGu9PrLn4HMa2CQQjfGcYFrHUwnzP041V/yTd7ImWt4SwDaUj7mJM3UgByLsSEdEgaBzELCareFmh7JTk2lxPTqmA==
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 23:41:52 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::39) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 23:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 23:41:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:41:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:41:39 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 16:41:38 -0700
Date: Mon, 21 Oct 2024 16:41:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZxbmsVM9WzUG9eCS@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
 <6ac9e666-75c3-4cc3-beed-03295368294c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ac9e666-75c3-4cc3-beed-03295368294c@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 820cd75e-dc62-427a-a3ae-08dcf229f02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0JoFIUkDAl0iuIkCC/ojjzMAEEgcMaEKhCQmtRfxHPxeU+uA2yG7W65rLXK?=
 =?us-ascii?Q?goKaP9HNbM+1V7QVlLPYqoOH8Bf/dijXA2TtL9mPCqTxt3TKlYV108hy9Ye/?=
 =?us-ascii?Q?3g5hFFCjkri+oNQTYYlu/Nkr43Fj8TZwJIf3xieY/OYzWQ2/riDMz8Xq9FDp?=
 =?us-ascii?Q?KYRSuoZoWGto91XcFqPRr4eV5x1o3cHsb1YH7JRFOwLEV1mM8RWxNX/zYDkI?=
 =?us-ascii?Q?PbsBfeIjdVaBLT9YlTGSMldloA5SZuCC02zbe8HSPeQYYhq96bsSNT5flX+q?=
 =?us-ascii?Q?q+YOMRzTf1vYuOhl5QI47rk7ARmVL76CkCkQeEcx9MEQlSheAGD0fXxBpvyM?=
 =?us-ascii?Q?UjCdtSFsfBJliqHUFcRCVfRclrPd3r61O9etA3a0ggKUvMPd/59DcYBHliBm?=
 =?us-ascii?Q?MS5Xo6jbfmSWHhmmBb9Swj2yEfVnyQohIXH4CTDMeHOSTSjgzhtqHlv03C1F?=
 =?us-ascii?Q?5hXigfNBN+VUQBb4AO5z8dTnH6VXmROfWUEu65DmAzgiLBGqG754naRgF313?=
 =?us-ascii?Q?6qcdGk2+XfecjkFbuPZrSmOg3FEibH51WCy2rhX3VssJE+2puBD6mcBRagv7?=
 =?us-ascii?Q?sgvdI/xsxJyUytTa1U/DbWdzZgZe7n4NF3xNkWkcT2ZnuaveQ4nhI1c+PNH8?=
 =?us-ascii?Q?NcCinTfrXyiUlX36QrpR93LnpY4hPZr2PD7CfAa9qcv5gwwHjlKu96QK/keA?=
 =?us-ascii?Q?IaPHNa197fEfVSitP3VF9w798MNlhaOcUs5WDKf4Pkm43+PRxbKZEcz7DS4w?=
 =?us-ascii?Q?JorwaOoL0xRGDMON/NjLDkelGR0qlabEWWo2VeCSRtiIbNu3v3mh+KiT0hCY?=
 =?us-ascii?Q?cgtW64n46qI0qea3K0Wa2HXOqGGXudnfRD2HQHqelhdYe4QxfEX06OGU2wss?=
 =?us-ascii?Q?oUHGZ/1Z2y1i57ytSR2Z4Ng8agwND+5m+E/BiitJce6CdAAgBG44+rAtZwNZ?=
 =?us-ascii?Q?37OCKiAhp9OKyg6w42AmzyeYH4kawsYLYx4/caYog2PcqSCpk4zM2GQP1Mdc?=
 =?us-ascii?Q?e870KqMHJEuIgqsBEN/XypecHIqoE7ra1nqFaO25vBD0J1sD++B7EyU/6fyr?=
 =?us-ascii?Q?69N2goOUsbGoH/AbEDBsr6C1QDLy+Fv/zzXzpE2uiOHAt/qgIfc12J0GAZzd?=
 =?us-ascii?Q?dUrwalSjgAv1Tpg1Q2OlH6R4nfGJjAdNL2G+tQ2Vt6vLgm9p0z9fdTPN+UK2?=
 =?us-ascii?Q?TIUMPte2JJseD5GSL1ojm0a+qXLjZ42Ssc30evZvDGniW25VegOGFgLfzd8V?=
 =?us-ascii?Q?5G224pmgRj/pP7IgNXZiZ1ZXXkkvcsz1nX1JQOrVYWkjhkeXl0GDAcQng7ZB?=
 =?us-ascii?Q?E5rX4SrSR08VfCbkYGFHH6QomAYme1v9sIC8Gqmm8j7/OUwFbs22AsHViE2s?=
 =?us-ascii?Q?01e1tBpkLOoKXrxiocbgURkYAzbPztA3BhG4c83XLmQXaGAhvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 23:41:51.5334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820cd75e-dc62-427a-a3ae-08dcf229f02b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325

On Mon, Oct 21, 2024 at 07:11:47PM +1100, Alexey Kardashevskiy wrote:
> > +     /*
> > +      * A real physical IOMMU instance would unlikely get unplugged, so the
> > +      * life cycle of this iommu_dev is guaranteed to stay alive, mostly. A
> > +      * pluggable IOMMU instance (if exists) is responsible for refcounting
> > +      * on its own.
> 
> "Assume IOMMUs are unpluggable (the most likely case)" would do imho,
> all these "unlikely" and "mostly" and "if exists" confuse.

Done.

-----------------------------------------------------------------
@@ -63,13 +63,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
        viommu->type = cmd->type;
        viommu->ictx = ucmd->ictx;
        viommu->hwpt = hwpt_paging;
-
-       /*
-        * A real physical IOMMU instance would unlikely get unplugged, so the
-        * life cycle of this iommu_dev is guaranteed to stay alive, mostly. A
-        * pluggable IOMMU instance (if exists) is responsible for refcounting
-        * on its own.
-        */
+       /* Assume physical IOMMUs are unpluggable (the most likely case) */
        viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);

        refcount_inc(&viommu->hwpt->common.obj.users);
-----------------------------------------------------------------

Thanks
Nicolin

