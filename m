Return-Path: <linux-kselftest+bounces-21062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BE9B583A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C5B212F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7C7E9;
	Wed, 30 Oct 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJGbkodV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCDA92F;
	Wed, 30 Oct 2024 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246912; cv=fail; b=CNDVDwxX8Z0ceuId8DuOg4hFq0Jwp4iCSANEpvvQnhp0bjqLXvn3vsP6LSRTNR8OfTezeMsj7xKgf0JCmn9suFYYheWQjUM3Pt/8fF6Lj995VjuQ8P8V42CRLeSifaNeg1wqGfbCsLpwEHjJUgOXFZ6xDGJ9+5bppTaj4vvr6wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246912; c=relaxed/simple;
	bh=zJ/7/xveIjnNhNNcbgDnYtO/AMrdK3pTlJxCXvAj208=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IliqMS/QNplUCn9nwdXsxGOpQTdzYOvAKOh1GtsumQpzhPwk0+f+xfR6HDGdcX8VL9NFRzxxwh4+AohzVWhTEiX26CqulbaORAQ1hXmadOh9rv01NRiu9Rl/OaSNsPh3qPZB4vZS+9GCdXxnCddcARun2V74uxAfZBuQEOPtEcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJGbkodV; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/tP4z/B4taprzEOII7BHnperhMaGTN+Gy/7wEs7O2boN1A8H/Qgsq4iI4TBkLd9qmsDXg5e+d1oVl1kJAaTH7DEed9TuTKl2jtHQG5u5r/yce/6uVtAheIsmg414s2rIcn5DWCITR0ZuaUvOWaVdcXia53Kwu+SPbAuKnax6jCztPhCS1fEuZeywKIcQO7dN3kgIhPNiCrIqJZV42kSMFB8fBaglurHqkuDKlI4enU7aczJZEfJHZlsk6hGdjgXU2i3FgHrYtIY8atXtOvBP7OMQewaSmwQa0MBcfUITRNS/I1HKhEvTHwoKeCuLcaLbBXFVIIuVTr4Amtb2wxI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5N8wTPh3BvBVMPR0zOuE2MoVNbbswrL1P5ZoxR2ous=;
 b=d/JKHQIvtGt5eOzbwrlRJ3mqZOaDvoujIzIqPTL196VdCVuFrx4qJe/VQGVHiOtEuacGngZ8r3zD9WxLCGxdQ4FjGn/VAWs0kn5ICuKzt/SAwif244yVj7zcYjBaocCWkvCNrtLX/n6n/vTwEgZuI3cJqWMjsQpotmsjqHhY4Mr/4R4RN/YxnXlKWz5pZ2KfDQeYyFHZharisZj0L3XGopey3tE+tSMs+GhF6iqJyiaeKStbvqPqHRc/UnbdIuw9zDNi2kZMq3ZE0yNjLjSQbeWKRhtu0A+C+qd+i3k/c1LmEXV20Rim/kMA08yzUwOx44JHdEs3CGBFXePWlnziYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5N8wTPh3BvBVMPR0zOuE2MoVNbbswrL1P5ZoxR2ous=;
 b=KJGbkodVEWd7YIjr9+nZKflZVi0/bBiBfWBnE0t7gbVL36DaRXvkIbRzX7cztOgRQplIOk4cSjComUeETQQxQMn8hpHHKYh/L4p+cGO3/iTSMuSL3IMhxi3A+tXhvZxT2Mg7++Ppradb3jOCXD/8E7uAE7DzwpzLUVqAJwSpaRoqhRwlkX3e4f6dHuI/BqWZJSRkUE1Ab0LhL4YT19Rvmgd9Herm1GyCdUqp/mCHYV2A41IRWHaH0nVVSjaZUdOAdzU+eaGDqR6TcWYol54Wno0M1Bfx/j49FDDS4n0akQTY7l+sLdtn4cFtLGumvWM7vccnmeH3wU4qIJZHT5Pjaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:08:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 00:08:26 +0000
Date: Tue, 29 Oct 2024 21:08:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241030000825.GA6956@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
 <20241029155824.GJ209124@nvidia.com>
 <ZyEblBMkvuq2rPAT@Asurada-Nvidia>
 <20241029184801.GW6956@nvidia.com>
 <ZyE3uGyVx9ivJeHI@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyE3uGyVx9ivJeHI@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3751d11a-4d37-4bd1-0b4c-08dcf876f9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1Kf5OJ4dmfZ0HK6oqBisU3kUcTQBY04kx3f5SfDtyd0ZCHr9r2/vlv1HBeH?=
 =?us-ascii?Q?A11V7mge/qm5BbG4+ijOGFSKN5psjlwHHz6tOQjkes1i4XWv7RxC8MBN/lLZ?=
 =?us-ascii?Q?Qh15cRHMTvfaUW97MYdLQbgQbwFtZuE5Y81A/Ne+41eR4hnkgFVLCiTdNe1Z?=
 =?us-ascii?Q?Kk40JwHS9QZDchsq88kNSdkdiiqKfY8Y381OL0Y6tfW3OdbanMqC3LOKp/cD?=
 =?us-ascii?Q?FR+38cNXqTefNrlGXUqV6O1IDobtMu/Sd2zGfvDm/Htfxb6MXofmLdDJNVLM?=
 =?us-ascii?Q?Iz/jkfyAfdCaj4NJa8eE6Un61LQnfYyxYR+LBXNmOLZBemvowdHp+hBWnopa?=
 =?us-ascii?Q?w4Wv4297WdhsGCToB7midkDyfGqCiRv24q6RKhkijsWIYxCtASZ1wodeGNp7?=
 =?us-ascii?Q?WxitBNvBm4bysAIhebF8bE+Skw5cHQE2hbVATaBzL3ujKyDDor4+PMSN9/Gh?=
 =?us-ascii?Q?1uCAwBKrf7+USyED90aQnkITeyptK9KY1DjN0MvcxIrqdjbppA39N/1C1J/5?=
 =?us-ascii?Q?vQROMGXMVYhLBwGCZNQzneptzV3FeuAAvVUuJlKhj3nZCII1aGB2PWT3ncci?=
 =?us-ascii?Q?uBlxcg1FUybholauqXAX/IN3SySNVMVAa0cEqzRU8WkIjiIkdnxoUy3BX2G0?=
 =?us-ascii?Q?dr2xmXb+HGjSr1Li7ZQ98+szxFV5dfoNrVlV1LWpeDqxtdbIqX3mxnp0Mntz?=
 =?us-ascii?Q?jE49AjoTfNNgVv5zQ058pL8DtKtEGJ+dSxXsmIAOmX+DfO2a4GNbLMCIf6yC?=
 =?us-ascii?Q?nZ76leLRZ+IjUNink+u2/tw9HMtSCGB2KBVNSKkHpxJMsgFslNxldYLD9c5a?=
 =?us-ascii?Q?eSiaoZCwiLr1mpVyj3GUA8zo3pCGog1X3rUpbW30ZXmi8s0iQx2CUPAUIevh?=
 =?us-ascii?Q?9mSWG/QSqD29PxerwZZr4nQ5y69k08SbVSpnrMAyiwQ90Af0VBsTjuBBgKGm?=
 =?us-ascii?Q?Uo3sD+dFvWYW+YRNmFKP9QxUMo1d+gVVR9Q9o4gkjNRaoVjvDvl9LWVCbSZG?=
 =?us-ascii?Q?+3XfLPZgXW77sKhJLBamAq1xUVh5LC1hz1QpunJ8Jw6POqkmi91o+uuP6cew?=
 =?us-ascii?Q?XcsADJ1XDeeBD8TqHVmNLyzV391MTNVFX7FQ3Z72iZ57kmvFpLsfwfhIJoC7?=
 =?us-ascii?Q?zctwKV6wf4V/5YUS7FMPRJU54Iv+CCY7+vrWY5ptP1MxhPcl2U/x2Aov5soR?=
 =?us-ascii?Q?+v3T1HKmOVK5AWNOyax4n+DMUZajTteBDhu6gH7HOUdZCx27nePT/MKTFMxe?=
 =?us-ascii?Q?f4acvpW0nBshjqf1/UVG9Xhk6Sjl/QZJkwMJp8Xk+XoN3G8roxz5Dz3rgoFF?=
 =?us-ascii?Q?DhR+WZwmf7BaPs9UTcR/BJe4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMSIWbfKtTlf7vF/xnksJ7/JgIhh8H4uHK+gSCxNKB2vq/bM8RfM6W10v1nx?=
 =?us-ascii?Q?eCAEnctasnr1qXaW7QbiZEAma4L/dfrCJNE7p3IcI6RdTYIrwAfV8E+TVndH?=
 =?us-ascii?Q?H6p8l7Jj2WFvFS7mZniLaDQbcnYPrtDxWRP2OLZGSPvE3hiogFA0670kQbFB?=
 =?us-ascii?Q?30a8P4E0TwoBj+x5/f6KWyRjgbwo/OYl0ogGmE0ahOVTWrM6leqaW1tczqhS?=
 =?us-ascii?Q?m7rMSeYCTO9x0WFV4LPOmqH9ZXbiVjxpoEVwT9z82XpCInzoZpelTD5paMN8?=
 =?us-ascii?Q?Z+vogAjYkepwFUfeknxWtKvhCnCQ/OmsUURyrR4sLxpFE64liJ4F9uUKP5FS?=
 =?us-ascii?Q?I9K9i/u2FzaZO1Dgyz9Fj0Zl81lzF1tzp1bsG8CjAn/VsnwHdwtKD9kHuIY/?=
 =?us-ascii?Q?i2iN+x6/FZe+eikMJj0K7X1cbcHkh2QuWBcRQcWXaC1dmL/WsP6KyZ66+oVP?=
 =?us-ascii?Q?uKRgN770SA6qw6qZVDU/LUHewbv4HL1oOMf0tkrrHyRxl0OuexZJtDSiAEET?=
 =?us-ascii?Q?uRqa2J21X0YqwWpL0tjbZPNCiDR778nyG3gjLQHGQErOFPvuMBR6tKNmcTC4?=
 =?us-ascii?Q?MrNww56sDE5RWA7r4khXqsKFGdH/0CEcFwuvT94Z6xCr21Y5VhXpUzkfxgrG?=
 =?us-ascii?Q?jBgVHOZ8vL3D/dryFTvDGZdpPtsPlAcegoDGSBOtqzeyVQK9I0KcFqb9Ad9i?=
 =?us-ascii?Q?b9Rcyw1uXUFcXPMb/QGs5P8tyS4PPLb+I12QHoCOlXYIVHMUZE1lozvlQwhP?=
 =?us-ascii?Q?fx5w8/ymIbZvsBrSMCUvpsQotv+itIgqhIkF2uYUeh8LTlECrQLlrNP2AZCv?=
 =?us-ascii?Q?7vcowB9N5ubVJLTADZQPTGXhc1HAYR+ksSAUXsiUzK3PoM4S5cJZbnoAPJGs?=
 =?us-ascii?Q?WU3DYHnfHGVnJhdptrVh+JiESMDcztdVx1Tt5fG3V5SvSokws1XLCcgrzgxX?=
 =?us-ascii?Q?Do+JG7RevzYfW3ZkKVfo/DDUNSG3CpOsPN4dPzL3pjV7WARrDObWoB1aZKWh?=
 =?us-ascii?Q?JydlroYLvmpsPpw7Rsnl3V1eG+I9eQkNxhNse8S43oyB3Q5fhNFI18/kdAQm?=
 =?us-ascii?Q?nCgsh1JuL9ZyIo4CMDEq6yRMJIHO6hQkLJNqCdhn8FXmWvXMYbJ4OUmQf3Ic?=
 =?us-ascii?Q?6wVddMrrU9b0VBnxtybG3fO+AXImijoLL2ni4akpppeA5X40pA8zjw0mDeZv?=
 =?us-ascii?Q?oDDMzaYnv9lMC8LUMUPrRaY4hFavkGh80AaI31JHn+Ax5XSU05Chp7ErbNEF?=
 =?us-ascii?Q?awV852llTPs5TH2AGl04mAjWE2i9KeiYKM+FeTL5pwhBZZ7L7Ia+Mm2SZ+0W?=
 =?us-ascii?Q?762cguHjw2TITBk7u54Z71M4+VQ6u8q5cLgFh/bxv7JNEOW+eU/wTOQc9cUD?=
 =?us-ascii?Q?Est2LXUCIevkGhiLsmqwCMW/ewm3KJQ0T2k1sCXLWhni7SnviUcu+jeGbY29?=
 =?us-ascii?Q?XvppMxxsF6oYao46LjbaaOepEGOQNfLwagK55YUoeiPLW9KZaeqx23fcjni9?=
 =?us-ascii?Q?zTdvYppeU9yUgTfsjffZ8ewKEkBPRTadarPfN8ivaJeyg+dujZ2vVMSsVjnM?=
 =?us-ascii?Q?t1UdloUPJEZkzmwmT6U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3751d11a-4d37-4bd1-0b4c-08dcf876f9d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:08:26.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrLJGs42Rx+/At+OqLWCxUnxi1/bL8frAhEwe6ZZrPairw5+IcJni7ZXMAZjC/Wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

On Tue, Oct 29, 2024 at 12:30:00PM -0700, Nicolin Chen wrote:

> > iommufd_device_unbind() can't fail, and if the object can't be
> > destroyed because it has an elevated long term refcount it WARN's:
> > 
> > 
> > 	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT_SHORTTERM);
> > 
> > 	/*
> > 	 * If there is a bug and we couldn't destroy the object then we did put
> > 	 * back the caller's users refcount and will eventually try to free it
> > 	 * again during close.
> > 	 */
> > 	WARN_ON(ret);
> > 
> > So you cannot take long term references on kernel owned objects. Only
> > userspace owned objects.
> 
> OK. I think I had got this part. Gao ran into this WARN_ON at v3,
> so I added iommufd_object_remove(vdev_id) in unbind() prior to
> this iommufd_object_destroy_user(idev->ictx, &idev->obj).

Oh I see, so the fix to that is to not take a longterm reference, not
to try to destroy a vdev.

The alternative ould be to try to unlink the idev from the vdev and
leave a zombie vdev, but that didn't look so nice to implement. If we
need it we can do it later

Jason

