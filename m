Return-Path: <linux-kselftest+bounces-21074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE939B5A8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D053AB235EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61219415D;
	Wed, 30 Oct 2024 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmoWAwBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6061187FE4;
	Wed, 30 Oct 2024 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261137; cv=fail; b=X9q8gRLxTGlaebkscBqkLUw7QFPQhxlhlsKPnhZigLhYpHjg/N/OajkqCyKESc4J7Uq5DgcCvEq89U8MftJSU8MpsbGgwL8jZvl0MP1xvpxQW4ixTYJ/R5iWd4R5Sl7bdS+hhIrulgYYyrMEYzt+sCf6KrxzFa1b+kQX4q4jq7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261137; c=relaxed/simple;
	bh=VY9D/HEP6CJcW5DHCcQbMumdP1fG2K9AvurPHERJqjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRKrBaA4mRLisXUAIY5aDYHX96Q135IjT1IEliLR/mi5sG4dT0nHHOvKhpF7TqZGuQOT27Y4SVbudA5yJ4JjhD0AkiXMAzXwSXSKpk2zTO/vVM0AHDFe0XUU4nfcAPLE1kH3/2kMdNcrblvM6G+eAJxkYl1/kT69gjY+3STP+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmoWAwBn; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZogCzycnlsFWVPZr3SIh9s8HRVrvOTFbc+ug8o8u7AATk+9bhsUjDZYhcJenGfkJq7vS1R/LE7hHeM/ffVgeqC0L70QsrVpnQEpGc4gRSxeRSZqvTvQ2ZOo2rCR+8x0+QArR2/jlrnnD1vBz4dy3OpkBDzo5De9mG9qnCwbfx8lBOqJshmKowDOg1GGc4oSOVa45C39L3XKdN/MfhF+utPKFHP91+LLRFNRpHUO458TD0thPLm/siFv9cPBA8oBdEez95UE8W/pyxLWq4fwBhUjvhpUFY1hiBhjRKoikxE1uZ9Z32XWS/lNx8wHBZU+quPDA7vzh2bDHa6D2k8UwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJWMssJ/Q+/91OnGV38k9jXgxPwQ5XSXZB4E1kzlKg4=;
 b=KCcR7yzyfCy9xWmHL2XqaruSEiU/YNoHDA/J6Acuot/goRjkuCT7swpTPfJkM/d2zH0OSzL6wPgOWnzhH3dR6AW5JLd+OxAQ6Rjpwz85Y0m+SMeyFZ724K3QXSz5VwPiFWt6wropV57BDxztF6DNyxyEEDt3cZDaWbzLdAhuhwKj71c8nWsH+4sB51NN3hHGSTy9ZPqegO0gXvr6vwFuivxuxpTZWzt8FgQu/ELkb6gfz5aPQRhPBKZRKRHmu7lDGDpmfwQVorJnoJndovpFPLKqh/4+x81MasMFKO/WSYje9LTNtAMfP2xoajFY/a9Bpym6MllfRPpOq11sAw73vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJWMssJ/Q+/91OnGV38k9jXgxPwQ5XSXZB4E1kzlKg4=;
 b=BmoWAwBnG5w3V9oqMUmjgQUBiE5bOjKzU1zpUaET/idEld1ZzvONWLwQrC1IGp24EDWLossrVT8qRR7YiJm4QsANHys/o27yeOjIzBSf7WAeusyACyJr9W3pEEmLT8xiIVhSJxpudBy/s2fHWe1BVmaCCVCtFdJQ9XL65/vXwLQ2DAbsbCHJVnv2PFRweMeOGlTBsDdkEfZoRPueiRovvcgC9vJwCpJy1LmluCn/PFZQ0lfwBa7i8hgi/SScK7nRGF8fj7cRphQ53OsDLVE1ult6Sy0BCB+aALXFbx0EwcX81zOnikcIfC4r01TyE33eru2EhJ8kUI/KYzqEqGbVeA==
Received: from CH2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:610:38::28)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 04:05:26 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::85) by CH2PR05CA0051.outlook.office365.com
 (2603:10b6:610:38::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Wed, 30 Oct 2024 04:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 04:05:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 21:05:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 21:05:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 21:05:16 -0700
Date: Tue, 29 Oct 2024 21:05:14 -0700
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
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Message-ID: <ZyGwemWwixBA+VIh@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
 <20241029144907.GB209124@nvidia.com>
 <ZyEKvcpgUsS1nCEg@Asurada-Nvidia>
 <20241029185558.GZ6956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029185558.GZ6956@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc2ede6-c6fc-4393-121a-08dcf89815f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3d3l6xe8v/8ksQgJ5J2EMOUVAoeeJxNQ902m+7ukIvPxJPf56zL0oBx9gyuf?=
 =?us-ascii?Q?Vp+eUVWBOGwHGzcWt/qcYGdJRxZ1+LBS7Q9tqgsn1NHDayxnLRDNfTA1QQic?=
 =?us-ascii?Q?fBzl05G4a318Js/COMNX7tCht/evk70IoXk/AgvRwqvU0p+Bs9l6C9NqV6oR?=
 =?us-ascii?Q?O8VAchGWwVDADxHkiV7ZlkmFnxJTAdj/fsI9NeR26wfNojxduZVE1wipIiXH?=
 =?us-ascii?Q?Jap2a8jUQob/awXxT8ZpGsf+UWIEvcuuQXSjinnIqNzL6QRWo75ThBVuCu5j?=
 =?us-ascii?Q?E1FPlkBilzl1YWemfaKV/IgBxmNd+SeflRgDUIOsxiSBShh86K6c/mwe+bT3?=
 =?us-ascii?Q?cVuipU3qDvunSo1zQi/E+YMki2SYqEKlRTGjH8LodQRnjweGhVJh/RHYKyxr?=
 =?us-ascii?Q?avwPRcpLoY870li30fSM0IypUEJRRnTuReHUALITy4201frPTiFV3p8L+GvY?=
 =?us-ascii?Q?jjMdyyN1p6BlxltMTm1Ht5DmAgDXOZm9hOsR+XHmu8j00+iQPKdr+IUqcmeQ?=
 =?us-ascii?Q?ibr0C1fL7sRAKsJPkkBBrx3Xv3PMvIn3WxJKvRsJUyILWEzJMoIXKFWv+EAf?=
 =?us-ascii?Q?27552FcLWw3o+717hsux3q4RwcMuPb3CHKq4y47co49GttKH9iLE0kl9BA2k?=
 =?us-ascii?Q?+G/2ZqMZctCsS7lwA2k/JiSNrdUucypDKk7OymKAH7EUzTxT1rBSQVbuUB88?=
 =?us-ascii?Q?6B4Id6Mpt1OYAvUEotQ5LodWHp1iL9oXBg47TU2oZ2DTqP+0bbUtEVRPIGtV?=
 =?us-ascii?Q?ruPqn69d5OdhqTKgqnNo2V/lyaTOYUeQAATruSbMIh8SLifgAMoe0pfes8BM?=
 =?us-ascii?Q?AsiV2jr4wozc1rCe4T4I/eYSbs8jAw7xU9DALvZQlXO6gHMVAG6mMx4Hfiro?=
 =?us-ascii?Q?YbcSfw9yyAUvpu6bPSxCqXebmLhWUXwpCsQkufSdKWgTKlxvBbKncoztOAYA?=
 =?us-ascii?Q?UxZV1aFPI2SgwA6Uv4fupH35rSJSUseL/Prz9j9SlqPGR488728vlx2QKNTm?=
 =?us-ascii?Q?xTzA9NNcZJsEulkRsgA3xSdSb/9fHl3bcKzrPxgaSE9dfE4N1+ViAsJdHZ9N?=
 =?us-ascii?Q?nsCUEleWg+tiODbi1Hm7IbgW8qL4RR3kKZ1R4ziDqV8NFiNZ4UvyUUMhpvm/?=
 =?us-ascii?Q?DmakgD6x3mGNFTxI+pTnjZuz2eDqtBhlGgLrcDtUKk41Hk8G1Vy8nMjPRuQW?=
 =?us-ascii?Q?7HWB3/4wRKp3nLyr6g4/ryWjhyBySgi/+HjwAXENzgxrF+XkKALdFphNe25J?=
 =?us-ascii?Q?qcfOCakD+oNRi6tb+JXcnAm2jR3mNy7zTq70jkqFCu5cJfHnfSZHLxd/1j1t?=
 =?us-ascii?Q?bXidIRlNz2Rc5B8FGcnfgtnmomfXs1BgkpPe5saIlS8tY0oGtWRw7ikuzoCb?=
 =?us-ascii?Q?OE7JFJ1axHXgqZLRn3GPG2bIiew78pb3J4uo2SPq5zSWNe2VjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:05:26.5879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc2ede6-c6fc-4393-121a-08dcf89815f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430

On Tue, Oct 29, 2024 at 03:55:58PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2024 at 09:18:05AM -0700, Nicolin Chen wrote:
> > I think we'd need the same change in iommufd_object_abort() too.
> 
> Makes sense

I found xa_cmpxchg() does xas_result to its returning value, which
turns XA_ZERO_ENTRY into NULL failing our intended verifications.

So, I replaced that further with xas_store:
-----------------------------------------------------------------
@@ -41,20 +41,26 @@ static struct miscdevice vfio_misc_dev;
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
                             struct iommufd_object *obj)
 {
+       XA_STATE(xas, &ictx->objects, obj->id);
        void *old;

-       old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
-       /* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
-       WARN_ON(old);
+       xa_lock(&ictx->objects);
+       old = xas_store(&xas, obj);
+       xa_unlock(&ictx->objects);
+       /* obj->id was returned from xa_alloc() so the xas_store() cannot fail */
+       WARN_ON(old != XA_ZERO_ENTRY);
 }

 /* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 {
+       XA_STATE(xas, &ictx->objects, obj->id);
        void *old;

-       old = xa_erase(&ictx->objects, obj->id);
-       WARN_ON(old);
+       xa_lock(&ictx->objects);
+       old = xas_store(&xas, NULL);
+       xa_unlock(&ictx->objects);
+       WARN_ON(old != XA_ZERO_ENTRY);
        kfree(obj);
 }
-----------------------------------------------------------------

Thanks
Nicolin

