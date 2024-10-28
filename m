Return-Path: <linux-kselftest+bounces-20806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522019B3144
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F40D28221E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6F1DA2F6;
	Mon, 28 Oct 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzignjoM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E11D2B24;
	Mon, 28 Oct 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120600; cv=fail; b=osXxK3KKRqZO9qg9D2USZY9F+E168yshbGyN5mpQLl+mJZXpGkpFwXZusaEansJdNL0rtd+5JKuh2gBr0Ttj0DLH6hvTooilizC4eEy1G5vq/wS6yIZh2LwcxoiE5FGwb5UR86vhUstjlhhpb0lqNM69H8b5G/nSks9UynhY/8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120600; c=relaxed/simple;
	bh=uYlh8fXbOH3D/lj+Wj+M49E/LpYjdaQa3FuCqqXmebI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Se9/qhQSz+vJvanUWfslc2OnOeloIPx66sfrNc3V59Due+zpYOCDY2BhJx5+05MH8JS56D/4HXIKZqDGhW9aojM085mRfvd+MqbuX4DAIeraFDSGmEoanFhWwIreygC1ln7DGr/oU2FvHpolpQZAE+e1ahCjEilY8fXtawzESiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzignjoM; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgxL7/EjUmlRZx32aGDHelo3CnCkbgB+qvUDLXScMLTIhonlfYq2XZ/0w+5QW+INY8X6AFIIDBgFVjzd/9IPHQrrYpDeXcH/g9UVo+y2KT9Jrf7TCyrTF9GUXImdGDt6jFPEQZoAqluxMlkYijTePQywhixMXxYhDfg54uaLio+/d1D9YeTHctBgItC4Ly/mG6UEF5/0z4WIDY6syAovzaj0hVeyUkmXw44Mcr/KtygtVL28H2uOcheoa1GiQ7eM7ZcuWJgXuaP6h7UoCp8lIqKjSZyp5elsXZS6nmqsi5kpgM7FrIHjGubGOslCKVhJ5mGyjhCYvMLZO8XSEs/WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYWI785iCesU4wan3zpk5ZjyfTPpQMcBw55xLd9CfCw=;
 b=l0Oeqag9iEWWasKdw2t+U9amcxentKkqEKnKniJcmlx6fW4ycU6FZf9YBKOhUlXCkdZVE0HuPaifqE6JzE0cSRelUcTkwjB45sXjtLE9Hv5U2/IOEaDPSv95N8RJ4jhRHxlAg2DyGni+K0u2U4CICP/sMT7RF1VgN1AXf6U85TwrJOfBxcxscQvo3c6e/fHECbgBvqXYXqCzRq1HQV18RBc94pXrzBdpAHDZUwa8y74yZPhqn+pJLQwboTYHl8RB2Cy2U08nvWwBZBvp/6uR9JYhtVbq+9EKxMUavUwtlY0HN3Ts+laitqty4jtfXXivP/jzdIXbmGgayMJGnTe2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYWI785iCesU4wan3zpk5ZjyfTPpQMcBw55xLd9CfCw=;
 b=UzignjoMojNf+GXnLtfsePeAZ2N+Z6GQwZg7s8YimnIl6juvl99F1xX+y7vFvyvfuA/dvvlliyT+Ld1D/ERkVBd11B6/WoarkbvqWUCsgyys7gq5CrgF4Vz3CtQMAcER8wiKmlj3iKbOYLVX/eyBTbhuO2baoLgbrMXDTt879sAPjGD9oX7fcG+Yhr7v06xvJinEt+dU9kZhWiHrzcZzpMwn30E0MkcTv4f6/xqWW/5QAw8Xr3xVr5lc8JJxdAKsb/Ao8b9n/+0XIhbqNhcDvPYHCfrW/E0udecnPs+AzR+aTTvSj2JjiTZniKBIwcC+aTTf2n+6t92XXjHATQxreg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 13:03:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 13:03:10 +0000
Date: Mon, 28 Oct 2024 10:03:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20241028130309.GP6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
X-ClientProxiedBy: BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9ff0d5-58dc-43dd-d8f7-08dcf750dfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZSm3bJMw1PAW4PALNGy+eq2IP0dBzYu3v9nTaRnJjglsXB3v0iw/nSkDXqV?=
 =?us-ascii?Q?ciR+uZE2KXCufGvBRoeEFYay3ozqse7F+7oD32Wmh6Mlq3Cs87RcTtlBKLs5?=
 =?us-ascii?Q?PjCZoQ9a9x27FzYp5dFHmPYJQfFt2QKlabDuH3CyTaiqq3e0O3H9c+uf7qVv?=
 =?us-ascii?Q?br5FE+rJRylvIO4mjM8uTpoOo25GrFqzUmvAPQtXYY9s5AC+cxgtmEb+xpFB?=
 =?us-ascii?Q?rJ3+TSHfCXgeMP81CxctDI3dCIIF2Oy+Eh69ZbtkzQ6tt2Xza/pcG6+/laRk?=
 =?us-ascii?Q?PSebXKLrCjOvFMvYipzSFDCX+tY6pBfvHxjalIsph6KWNcjGvvpJ90Ju35V+?=
 =?us-ascii?Q?31f746IOqu8Jck+nYXzXwStYTO2r79fIDMJ7f9sj03fRfbTJ5Muf/GJ0/LRA?=
 =?us-ascii?Q?z1PIk3f7LsUdEvxwwSx1E8Car8q+Sr1qVcVqrA2tUrmh9jw+KSaYuDxm+Dul?=
 =?us-ascii?Q?+xAIp6USvlC0CaAqdrpoyUzNOYDd7wUjQe1ti43PX3sD6hw73TaMJqHTKxx0?=
 =?us-ascii?Q?Ry6n62nGkWyDK6YAg9j6aNdd4ig4ZRU8Hang2OI59kDWC4UGnw5Q4ocrd2pi?=
 =?us-ascii?Q?S5PeL92y4zUZ9m8v0nKK4hRbm388IllG+ku6Hirg96RQV168zAzi7skWy1Xy?=
 =?us-ascii?Q?5JiBKSQi+UvlAEQerfbWJkA7BZXuSDwb9dND7K1HS4L83lPsvvsZ9EWiJk2X?=
 =?us-ascii?Q?baXqX3EpRLtt0jKORAVyf4jOLyFKe3iZEB5isvy9MEAkoVyCJh33OMBVyOqD?=
 =?us-ascii?Q?HaGXozFgXaQ38XppEVVJUk9U+SQGptE46AO9OYokyRvOCMclQBGrqKuuushu?=
 =?us-ascii?Q?v/WceL1Jqbbb38jXgtvxRv/7mrrpdFLh8lHGEYmJWJXBK2RfugjAbP9w20bm?=
 =?us-ascii?Q?0WgPUK9hTHz+lnIDGdjfK+C+lXMkdKNPr1s9gcWvmCAh3bjwhQDEEBvpK6up?=
 =?us-ascii?Q?go4dnTMBLjMSL22nAB2hgyKYpNRmvvSh2fzsLWBfjELf9pZBmJbaBrEIQ9Cs?=
 =?us-ascii?Q?ACUGtQPNXbVVNhCem92gT0qiRX8PUpc0bmU6wufkBLNCgIPBLWvYb5S+9S0/?=
 =?us-ascii?Q?fudH7UfYp0anGGEPPhjTLQ8l0C7yyknpT90coWrnRR6m5MiVOEEIsD10uRZq?=
 =?us-ascii?Q?vb5HWNZqUNeohvZwYaLPu5mtnzK+pnX+YFRSnWGxASuQca7cKTqJSH82SDx8?=
 =?us-ascii?Q?Bcd/lUfVbPMgI2OSfUpP1O8CjTDuqz49pkzM0uRQr+D3U39LS4CJQbsKaZfm?=
 =?us-ascii?Q?vrGDl4QsLZhJU6ACzxi3wyNA6h4EFSoUUotPIJVDAO1E9VirMY3FAMFrDnqq?=
 =?us-ascii?Q?24zE6sEyxwxI61kcakCMSPUf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JrvZRncIbeOgUhGgdQinSGcRc7G5CUOAh8zCAdMYptYBii2sQ0ytWoGsKPk?=
 =?us-ascii?Q?hpR2ew/ZOFit9HUbS5xcp1Ad6sjfkpmMFxd2WFW9Ro3RE2Jo4jzMLhIKbNy+?=
 =?us-ascii?Q?zjNDhy/z5kvB+mtnxFXzjYTug2M9d5dP4ccjOeinrVnNYhH/oTObGxpX6hPh?=
 =?us-ascii?Q?tRuxyrHyVnP4PClB7t47vzdMBDeeDWtIjjcvrrubTwx0th6IUSaA1KUg9bP+?=
 =?us-ascii?Q?ejc2aFWU3cinkxMFRjancQ4PLRsFt4f50M0Qw/4QQrrFd5XdQ0LZkeUXFn/m?=
 =?us-ascii?Q?1qzw8AYPwwVKYv1sFmbK6ZKTpKokAgpZBJPzrpvS9aJB2s14pwYi5IRqIy+Z?=
 =?us-ascii?Q?MIOBD12V5idm6ieX4SsVrZImp+qQ9EDkcH/lc7fEenR0zRQUxx7Wd2nnk5nE?=
 =?us-ascii?Q?ggCcj9B8kpU+JA7gMBOtOOpwCDk5CwGOsZvOC5G8wfrGh0AvFusVc7mXqFbl?=
 =?us-ascii?Q?GJFY89pdMUNLpT/hUOgcC4ekp1cQyZ6S+7pp7gnTWVx/dWTVKFsF/VjRA3jG?=
 =?us-ascii?Q?BQr5fDMdd7XfODxls3Hz6dvTg0QfS2N5iUbMONIl+1qLWto7xViXnOTFjKQG?=
 =?us-ascii?Q?Jq/7WvldNXNG433J5hUmwjaQjeP0Pmz9RWUNtp+qKYl4AHljE/tN8si3ByDH?=
 =?us-ascii?Q?Edg/KvXPtaLNG2bBNmtoZtVxu5va5i5xMF2BZW9OdH2MgrjNlCYvIt3mc6wp?=
 =?us-ascii?Q?d3mckeKjaLgHSHpkTaawnrjurLhQnfNgvQd2s0TF9LIU9uh9swYVn8AbD2xN?=
 =?us-ascii?Q?0tkBLDTVaviyTq7h55uKSFGiexn8vt3twLOBjiJ4rjwmp8B1whJGipJJKy4l?=
 =?us-ascii?Q?9cOJEIvPPLyx6+v4VqRks6bzSaC7Vs90sCjWRZg1BWojInq3MaNV3Vk2v++S?=
 =?us-ascii?Q?6JBZAYSQzkVeGI0fnPy8xFWWMnSQFDuYUiCp8a3N0KTMFoN6sM+Q+bH/v0wa?=
 =?us-ascii?Q?mkLG6url5uozj8BG5GgOMRB46oQaxezvP1hxQfWQfwtTlMiunAvC5QRTLR6H?=
 =?us-ascii?Q?IkqzMIhVxvV/EgOIwskCCKdocgcYvy4yVtchiQ96BHugE2HSPQaChDYRAYxn?=
 =?us-ascii?Q?xzcNGj23bUQrRI66F+bZ/E7sW6FEj+FULo5hXPLWXdsnJwd5tmHB2pRW0KAH?=
 =?us-ascii?Q?is2x8glNNZSvbUYPZir3OXEOilxivi/fcNJ1dUScg1s2wcy94PM7npoTg5SH?=
 =?us-ascii?Q?5biwvoIfylrHpXdEIXu7xrVw/eWGxCnk8GuTDDzExj797p0+F/7fNH8OI+5z?=
 =?us-ascii?Q?pONJ3zJfDtoLCAW3hiFIti7M7r1Zx9B+drWHTdvqrukn+i0WEd3lCl3ivolK?=
 =?us-ascii?Q?CvxBrhknC4PxerZpbY0qOHSADY3YAahuLCm2K0fbxHNQA6zfr1YIZ6TSMXo/?=
 =?us-ascii?Q?dfaA9St7NTQwYm8+CnMu/H1QmEfKuaVclfGzRitPztAYaFjbR6PowrsmBxTz?=
 =?us-ascii?Q?cwbzCckEoDp2Kdtwzr+yw4bNRTdurJIeXt91VgwaI1TZta7yZeoGFp4mxD9f?=
 =?us-ascii?Q?3jpG4fkupq37kMAYp1nXpFMUM6CR+bTMg8zrYzl5Vi6m+oGDf25UmnFCQkbO?=
 =?us-ascii?Q?+HYjFkYLKEFb2+dcXKg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ff0d5-58dc-43dd-d8f7-08dcf750dfd8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:03:10.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXOCLPjXoLbkHxHa/mKs8BKZRqlFjmvGb+/IoIqXQil5tZhWdVBBIq/rn1LxSYbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

On Mon, Oct 28, 2024 at 11:24:10AM +0800, Zhangfei Gao wrote:

> > +/**
> > + * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
> > + * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
> > + * @user_data: user_data pointer. Must be valid
> > + *
> > + * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
> > + * hw_pagetable.
> > + */
> > +static struct iommufd_hwpt_nested *
> > +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> > +                                const struct iommu_user_data *user_data)
> > +{
> > +       struct iommufd_hwpt_nested *hwpt_nested;
> > +       struct iommufd_hw_pagetable *hwpt;
> > +       int rc;
> > +
> > +       if (flags)
> > +               return ERR_PTR(-EOPNOTSUPP);
> 
> This check should be removed.
> 
> When a user page fault is required, IOMMU_HWPT_FAULT_ID_VALID is set.
> if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {

It can't just be removed..

I suspect that IOMMU_HWPT_FAULT_ID_VALID should not be set on the
nested domain but on the parent?

Jason

