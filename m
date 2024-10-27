Return-Path: <linux-kselftest+bounces-20766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D59B2123
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Oct 2024 23:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD71C2092F
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Oct 2024 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7523173336;
	Sun, 27 Oct 2024 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXudX+2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C85286A1;
	Sun, 27 Oct 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069379; cv=fail; b=rgZshR12wwNqTj8uzq8UlQRqibvk6FkVQfDPQ1I5CEVH7dU2geIknq7cLU5gDfIdu/UmDoZXF/XVLOkq6vB6bsRgSDOckh+Yhm1Tt5pbrzgXE+6v+bszamskZy9pypasfmkgTCmnnAjKf0sKBgg3e4RmiYIcJwd90eh9fjfZNoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069379; c=relaxed/simple;
	bh=XhoFRBeXMgMQW4LX4GCxnPU04PevIh3s2bGTPDoXYRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGJRMpjs28Gq5xOY1nfh/6/UcZcXD933dz7Tu5LYQmXE6OWCYUNHlqt0NL1qEsjhvn0zDurJAKDQyD6lcIs8TInDky7/fgStn3q5fU8691LdLB0dbTQYnFqxCOZXNOuYZgMmAOliE9hBWn10cTFIj0XEjm1TIodLMbGQyg1xIUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXudX+2Q; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdeE0sV5Nm9atWbMj3fmE+pg81DKv7+4hvOgXFrVYUB8nDHGmDEBdfBnkyYtY7mfuD54iszxXcnDCyyLasL5tKeerCqanbE9357p19W/F5p+hN6DarB9dgX0YlgbZo9aGRB/5Gjz/XFQk6l7gJeT0SZsrY2qSDzQ44fu+AuCHhxQRA6iV5iYMAyoyXXAAPvXfVGYfoCwOK/D5/fYVHcKkANetbrfTZcylpLnWycU73R/Gx8p3tBoyx3oj5lr15rPfBjdeXx1eEuZ28mgVW4nSQa1wZGiSvtIlkeUBLHxNgO6NTpE+xV8fNKX5F/SN/HuVBgjfWMkjBn5nj9VLtgKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbHKFKO5IxI4QZvGkL8Vc8LZBTGxCpbQFVtBuYwA68Q=;
 b=ekXaFpzdNHcBGH04dyITGq1xQoPUDdrGvKAkHtfQZ3Dt8T78ZR0q1MtESwp+JUK1ieSLLj/va16TYPulwjeHpsmKLQXsy6P+ok+apQnA/I8wSJsblc6KDzwPN3kRiaX3sBxIPu4vVT7a9rPUBvbA5JCMLv76ZOb7SFOJHJBretFTVlop78ZrehvcNCBS5+EJ5N3IIyTWfW/03dcCdf3gk1s+qf3EPv/pkO+IvMGTObeFJxXCiFDeR0AxuC3/oyUr1RtdYhiz18eId02zo+MEksW2ZGrqCj90paf1+1R6ZviF0RfD6tlgZSyvwMdiPuzAO/CgK8hhghChtNRUTeuOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbHKFKO5IxI4QZvGkL8Vc8LZBTGxCpbQFVtBuYwA68Q=;
 b=eXudX+2QrCEoplqhHRHxt/rEZu+OGV4xAHNhuv7FVd/idm46pEmuOmBdd/Hm8T0/yLu77tFG/Cqz31faP2iTpJvzOPhcjd48Udgqh3CmEMCSvotytG9W8iqHcMg4ACk5fS+ey4htNedp/0HnTGzgLMKaY4qrDNW/YMpnpIpHgyNy+Fi/S3TaBiiFnFHrjDnZBDtO3hjECLXRHL/hAnEp532wKE5Wbl92W/FtEOqGudWcDKXzBWU/KgEWiDnqWu3HS0CYR35UmLJViBc9p0pA5LFBNvRPqJc0A2wf5Ksb/Y4N+9KR5X8Eh6oU/a3vPC2VbHZXiWtSULAAA361gjuYmg==
Received: from BL0PR0102CA0050.prod.exchangelabs.com (2603:10b6:208:25::27) by
 CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Sun, 27 Oct
 2024 22:49:34 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:25:cafe::d2) by BL0PR0102CA0050.outlook.office365.com
 (2603:10b6:208:25::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Sun, 27 Oct 2024 22:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.0 via Frontend Transport; Sun, 27 Oct 2024 22:49:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Oct
 2024 15:49:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Oct
 2024 15:49:27 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 27 Oct 2024 15:49:26 -0700
Date: Sun, 27 Oct 2024 15:49:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 07/13] iommufd/viommu: Add iommufd_viommu_find_dev
 helper
Message-ID: <Zx7DdPmEF/9aU70W@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <384f7b4333a1f75da09e390902b8f82be21a0dd3.1729897278.git.nicolinc@nvidia.com>
 <CABQgh9EpGPwdQhv7mepiMGVgR-8NMx5dcXyJ2A92W8ZzQt3bJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9EpGPwdQhv7mepiMGVgR-8NMx5dcXyJ2A92W8ZzQt3bJw@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 577be983-55e4-49c0-00c2-08dcf6d9a07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1E8WdFaRy8SXcdsUfYf3k8SgWImgsmrFYoN1PQuNxw5SPFSf1NdWaK59M0V?=
 =?us-ascii?Q?ARUHcXc4gzhV5BrAq0DHkdAbGjdJm8U6Pxn8lj/MFumN5Ro9YiAPOKP3EbJk?=
 =?us-ascii?Q?O0yarCpQXO8wntLRZZlASU0jWdy7iArRi4c0OScdWa6FY6MzYzRp7KhZ7Vad?=
 =?us-ascii?Q?MGt2NEYy96CKmJ99N8p4k8n1uLOMhYGCeeCmj9ePnxAOsjZFPzBewWlNvT67?=
 =?us-ascii?Q?SkeXVtyUpqYViz/zQf83dDh7Wcv/rZnTOaMx9LTo8/cbr6IL4SwTPYTKdkRP?=
 =?us-ascii?Q?expzjm8pWiD65Oj88I19TUcvKQZ8RUArhBda8MmyyVksF94rSZpYUgoEqSPM?=
 =?us-ascii?Q?RV2RsvDg46E0MJiWKyopwHxFjQ1mqzaPI3XejdgqMQlRFd+ZnUU0LcrnkP49?=
 =?us-ascii?Q?O3mkHf5h9EznkJJu9tFIPAIOlnCKmxJXW7j+Ejb3OInjLTmaGKcrD3JYXsJ0?=
 =?us-ascii?Q?EdPcXhgeIxPtUNYigi9q4/luXkY5Dtp8Fey296MILLp5ILFHb5gcW5T8BMqv?=
 =?us-ascii?Q?UeR0veSTQREfnbRD+7gHH49dX6x/E7lgXHQDlpayyrQfTPmMrFzOo5ANPoKC?=
 =?us-ascii?Q?YRgy5D5AYQac2hwt260VeC1w5HoURdxrpdynCKtsqf9UerXJu7oMSYdK+uwQ?=
 =?us-ascii?Q?kXJ78Nn0EjV0D9XLv6nV56iHsGsCWwY1Cd+rPaCzEw77cLa6YN59HgKSpWCD?=
 =?us-ascii?Q?awGlv/Ui+J57PHS2DHGFFfxlfi7dnJRjW0art3eYACWGLsrWj/Xx7joYRO+R?=
 =?us-ascii?Q?xUe/WmHz7i2NNmAV1PLfMVBdFDfQpjWLEz4yd8cRIR0uJJfREhulB3NC2al2?=
 =?us-ascii?Q?HKuy/Zfmska1TYR1xZS2zrS/6M/nru4udDNxPpZbbt7NHXpsZhm8aGam4PSE?=
 =?us-ascii?Q?X3EEc2DFJ3AupU7Rkh0qrlG1UxuxE4A9rJLIcBGlqn2NWXhXN2lQBRk0iN8G?=
 =?us-ascii?Q?WSjN5JOnGsvhNQTe+gqZgSPw0GNX0YuNcYOAoxcIQeIhcUwuHAbHfkyS/gpH?=
 =?us-ascii?Q?gJaDAOhfGFRPK4L8AjNak/kFbKDgEos79Rg86vbF1W0s6BYFVUetGsVekjrc?=
 =?us-ascii?Q?hum35+lGrr7RfXMZ37RrY7Whwm2WinGH18TIp52omCVLExDeQUv2HbxOJfIq?=
 =?us-ascii?Q?8nouaaO7ZWMbE9JoIQVvXKElBtXEoVQpmOuvfHSY1ZMVIR+xf6cxi/yxTUlK?=
 =?us-ascii?Q?Ks9wgm5Lik/Aw9rys3qB5/SAYlfJZwFF1mE5rSgP7RITFYtIyCwjX/fJMYDx?=
 =?us-ascii?Q?p6cAJjC7Gyy4bHSmDXoDNSNWTjeAzsiQhjJoUiAGhDoMag+VIpKFkf/DKJoy?=
 =?us-ascii?Q?oqRFZIt2+1uHWrzQGLVFpRzI1x7Fb4ftRIZVQSfMbTo6JHfHzF3fDDSzbx1q?=
 =?us-ascii?Q?W4NX46bnx0hslAjBXx6VzhV5RIGMy7Hkjlzrb8oNimO5bLfWBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 22:49:33.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577be983-55e4-49c0-00c2-08dcf6d9a07f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

On Sun, Oct 27, 2024 at 11:02:31PM +0800, Zhangfei Gao wrote:
> On Sat, 26 Oct 2024 at 07:51, Nicolin Chen <nicolinc@nvidia.com> wrote:
> > +/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> > +struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > +                                      unsigned long vdev_id)
> > +{
> > +       struct iommufd_vdevice *vdev;
> > +
> > +       lockdep_is_held(&viommu->vdevs.xa_lock);
> > +
> > +       vdev = xa_load(&viommu->vdevs, vdev_id);
> > +       return vdev ? vdev->idev->dev : NULL;
> > +}
> 
> Got this error?
> 
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: drivers/iommu/iommufd/driver.o: in function `iommufd_viommu_find_dev':
> linux/drivers/iommu/iommufd/driver.c:47: undefined reference to
> `lockdep_is_held'
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[1]: *** [/home/linaro/iommufd/linux/Makefile:1166: vmlinux] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

Should fix it with:
-	lockdep_is_held(&viommu->vdevs.xa_lock);
+	lockdep_assert_held(&viommu->vdevs.xa_lock);

Thanks
Nicolin

