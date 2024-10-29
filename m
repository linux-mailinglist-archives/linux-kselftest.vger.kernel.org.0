Return-Path: <linux-kselftest+bounces-20980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4E9B4EBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2211C21125
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF63196C86;
	Tue, 29 Oct 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4vGh3Vz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52F19309C;
	Tue, 29 Oct 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217583; cv=fail; b=IUHdvnFosU7Xxasi/PkK2Ox5Ic413uMryCtRGyCUf9gFDS7wj/hxzSdbpY5ilzj6/Hg3WrvwdiGpCuWawxRpfYhmO7gV2X+Fy4Yk/c1MIxmuPfWG+bFRazLMrngAUvASDSgkGq7wQjiHGvNG8UXSXuYXhWgJ3GGNiBB4RP9QTdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217583; c=relaxed/simple;
	bh=CwXhb8BxrXUKazcNNyneQuAFkju4gtYnWbBRjovVjNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bh/orLYHVhzYrsnxqRD/OCfo2IuF1+7DRpWVf8kAOjvfRevR2T/hvezQzDelf03isBamv41KPh6DWRStnzu0PVpYesOnUXSIA3d/xLzDwhgX7B360EzzuqYCTDdqYocvXnehzqFkCPYINVioSHr95YNWxNoRZh9eTuxH0On0/7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4vGh3Vz; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lhsre/VTgfIzkLJjV3mIAohoYIkZ/PEh+4QKlGzMJ0D3wmnlYKGnaaSj8ioxUUUAlGSnN/ydOZ6kfpaayIhqQOAznyPbqaTYr/v97LWZ1bEuJ93D3C6Zx3gtFUkR8McidlsiS5uE63rzoW+iYPcrrtV9uUZHTBX0JBkD3nTyTWeH7JIWbpgWW6Al4gMmbD2ITMbmOJ8QZdZiUhwNnWiiFj4X4iY/nDOWnnuW6r63Sqb47GRByOBSg6ljVQEHkVQBgWjissrSlRfcYVhr9VA/QEs0n78VRgDmOh5J63Wywd+HVjfWAd7KyNkJJEoHRGVnNaFB6gCle2wnewc0Ub/lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H4TaC3drlJ6gsOjvZlTEDA8fwuAFvu7OdrEfZtpHZU=;
 b=H0thNBCHs/R1x1PJRtW/mtKlvlLoPxLzaBphtxIHKasxjwdLxLg//ZEejIDxPjF2mS200shzFhMXDCPzsy6BUepyYmBwBcDzIYs/5L+3q8N2GH7PxqL8mE4paVvA0QvNG8SUdhv556oFYUEUeDPo0w7WVn8q0gDirLZ/4ipKGxpQ9naip+FFMsOGJEoaSQT+c1Z9ATzYZ8iVFoGxcXgR70mxCDHA6SyUuOKjLkxUzzgAWPvalpmvErCRmQMOxFP3G2f6AOntOPAJMzHUiApGyo0Anal4S+CM247ywAEKaYP26HCN8hpYKUi+wE4Dpc1UwuwlgMuh+ssgCjSTSa2SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H4TaC3drlJ6gsOjvZlTEDA8fwuAFvu7OdrEfZtpHZU=;
 b=f4vGh3VzbjKuCAW8Xwq+ewYEEkPBcOU/J+dgcriwiWhfbP7CiR8ZRNBUYYBrm3pvsqDk5uVX9widwd/XDYiJv6STWt8jwzCWITjBugb6JUs25hj8uib/wf8d2AOD6iPT3ZzLcHqNHDHsLYdyNciiQNEa+FvCzRqU0rQ4Kgt2XvNzaf2WY+uSsiPlYUIhLnB9napFIBkbIyQoYcs+SWNFM9sq2ANjkgGZ+r2iK9eQFbpdZ5En4zNjL+F7J3STnOkmun6peA7EPovHioD71rYkGwnHbxnA7355Hl1+euV0QM+S7lz1ieEbRU7/6eJDfDxRvC2ICw1WpnrqwkLtLpTuww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:59:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:59:36 +0000
Date: Tue, 29 Oct 2024 12:59:35 -0300
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
Subject: Re: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20241029155935.GV6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
 <20241029145436.GC209124@nvidia.com>
 <20241029153624.GA210796@nvidia.com>
 <ZyEDYFxHZ3XkwTfh@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEDYFxHZ3XkwTfh@Asurada-Nvidia>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e769cd-ce67-409e-5c89-08dcf832afaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3VfaomtTWDvlcN+7xPUZjNjYQ5VRE3UMLbRzhmUxb1fv1tt+T6gt/ZLSR9b?=
 =?us-ascii?Q?A9WIEYa+hj5PoGaQIEjrAR6OwiZPA2asswawaD0GEDuX1/rpGUR0+QkYMBly?=
 =?us-ascii?Q?e3ANHtKhgopUbbZgdouegnFIpRwRV/nwePeqhVr5O6spa2WwtXifnPOUDfuN?=
 =?us-ascii?Q?oqQP7LIT6pO7KntF/HjxgyQyvJZLV8/aTnB7bkZt2EJ3xx5vM2HgGsPlxQiK?=
 =?us-ascii?Q?M13652kEnTaKktfW8kpkgLcbiveHLOYnJU71nfsTxgYbjIwODP+NuqmXR22X?=
 =?us-ascii?Q?cfmTrFviZZXDUtfwJZNjX3WNvoUGjfHHY0MGzRwoAy1TqCDBPHUrij7aA3KX?=
 =?us-ascii?Q?72/rx9k8lKAthAWgA7m6Rcgw8CLWSaxyU5GlqBqgZNJ9doqPNjwfzP9jkR1k?=
 =?us-ascii?Q?H4YhCPgIdMRChi0e0EOO0YOSkyLyrf40PaYqmjoQo4CavPYZIgZqsg4mZTWa?=
 =?us-ascii?Q?OypPgyrk/PxGqc5+102wZXq0nQm381CFS8pinj8b+Kjz1PN6poDNQjE8f10f?=
 =?us-ascii?Q?mEO8rjAE7sGvc/d4NsjzBcpNeLAt0tBwr3LaxY1UOzsOnyZzYmcQwkeGcQPq?=
 =?us-ascii?Q?Nj3DDbx8DhiUr2LmrmljQlYyymTH3GpEMGxBlBRI+tQSmdxIgL+AnPiYd0En?=
 =?us-ascii?Q?pTubCHYYselRIHYSiy8ac7L/430LbezoVmbdlFMBfYGp5IDYPqoCJjzzeM5x?=
 =?us-ascii?Q?SF/JsG5fhxCab9yQiNvfK0ERkEEeTmO5etcYtgV3hUUViO50qajQHagYHGp0?=
 =?us-ascii?Q?LH+C+rScH/klaEfl/axgG+UAro89auOvKKmmsvHfX3Xj5u3s5b0Vf7zzHNqK?=
 =?us-ascii?Q?1zGuue1bo/EohtcTkWIgALYVdtjYZBWCLeaDJN8/HA1ELTdVA10N8ENzFDSs?=
 =?us-ascii?Q?ABJOzvFBeEPJ5j3hI4MrZPgfHgVVwqJEPVuTuL5ZEgW0PSDzusmc+ffR4sB/?=
 =?us-ascii?Q?ydtvsTMd7JhMG9UIXH0wNCBUl7wcWWqWaFn3SSCAOmJmxXPHE2y1dCyoUg4+?=
 =?us-ascii?Q?fpPB0a2CvnWhnlIHSIFT7sxnlrHb+sg+OazdHZloLf4v8pTO5nDBSKH8/P1l?=
 =?us-ascii?Q?zoMGZKXnJMZed33r2AtkrtQ2XHuozn3cA4w0cDmHRmN0xeUMiik1pkcQLPwT?=
 =?us-ascii?Q?D6gmpOolFiR59gywdAUktVD6KCiDAQwGcBcdJ0zBxxIv6KjkJePxoptcSX/l?=
 =?us-ascii?Q?L27+IGpCFP/3yzr2PctUhnWY38H8xzHw/bl7JHKkt/o95ZyAgp1pH0MW8yxy?=
 =?us-ascii?Q?vhfNprh3/o3XCgKq0MpBUKyYqNciuzBeyAnivhCCRR9WpPTV4sNxpCWhfekL?=
 =?us-ascii?Q?gKyskZdt30N/kX2Znl9KeRpe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?seb7rhvGY61KlI59wfYKxZGpywXSIZuRhp5H5LppFOCXpKUNezUEzHlfoDgS?=
 =?us-ascii?Q?ffIziy87SsX1j9Kr9qYtk9opyfKTFW8rzYnZOW9mmp+/PihZpXU0BPAJutzF?=
 =?us-ascii?Q?I38geTEHoqJMMCiKFgp2bT5x5fhCQdYQ+dXt1KtJCRGWbTKGMRND2Aqco+18?=
 =?us-ascii?Q?YtAxIWcpjcRJuuYIus/QqDXUU0f+BKYD1AUDS+5IyOfjnXwFLAoGtbCYwqei?=
 =?us-ascii?Q?ZpzrhB0SeIhchDq8VgqduwvWhiEdPIfI0ACm7KtmjK1nLkC9slSPCPmXh1/L?=
 =?us-ascii?Q?f9DJQFkO/vmpIMJiXL8bSa/Dbf1FRBWalH/OXJune4MBvxHvWhw7T58HbvVg?=
 =?us-ascii?Q?fN+GiQvhGBpt76+9LaXir9kdR9QVZECpKDsB+4kp+/q2OtmVfNn0iVrzlcOe?=
 =?us-ascii?Q?O1Mth8ckJsYdtTtb2NGGPkYKSW+ijLkLiiyJKGyEsPVGog6Z44fAGtJFzTl0?=
 =?us-ascii?Q?tTTX72QiKFMnLU60zYCqKxXD+uNZOcLISuYOXB9oPhMTe+q7knnOeNmVs0aM?=
 =?us-ascii?Q?v4B5n4zefFo6hl9RoKUPS7LYGAnH4T+4sviUfRSBhfOY145DVK35w+h+BjL4?=
 =?us-ascii?Q?6+k3plwTtUv+Rgo7Yfti/Y0NQ07iXc2mxBr50HAkJlxw5rgnSsMYJIkJESx8?=
 =?us-ascii?Q?NeZ53+qqYFHLjmfkFHgVKmq7ygVzAelmK7f15CcH0PO0uKSVtR/XaOXSlOEJ?=
 =?us-ascii?Q?rZiohkgxY1uss7972L74ZDILNioi4Rz12jZfEhAdwmxXinJXUUkK8m6DD0wd?=
 =?us-ascii?Q?madRUeU8xhUZiXxen6MrAPmSVsbbRB/C13n6xzMqPJkj2wFx9l9u1tTOo2sA?=
 =?us-ascii?Q?whGhyVIGJ4esayFrmUesLUWXl1x2J850pG11yxXeaYbA+wGioagR7nvI+2QA?=
 =?us-ascii?Q?s9IYUnksd1AM/GR4NeaREQvMne1adM5RzU6+WLJDbLBBxp8PIIajduc/04jx?=
 =?us-ascii?Q?Y4gO3KY7t4VA0RkefCYZo1CieEaK64P7Ga7kfVGyvmuy6iUahXzGz3RbM4eG?=
 =?us-ascii?Q?N6Mkzsj9mQxt/413NfRcwBg/hBOWO9jZgvg7eTK8in+ZxqvkdGSlWXp28Tza?=
 =?us-ascii?Q?jfziDj1Axw53VdYk2bjW8Eex+TR8jbulESBVUor+NzpwaD72rqE0nj/DuZot?=
 =?us-ascii?Q?y5L9zcCjxP71ocATrNn/cgSl+MTtGg+71sMxPVFikaTEcfpjWeUhh7b1WHBL?=
 =?us-ascii?Q?VUvCNr3+Ot4d2BD6sfu/i0NwCOabVvk+PlPv+NLg9LysGxv+kstFLKxbcDLP?=
 =?us-ascii?Q?+8Rzy7mz82Oe6swXxy38ED16GuYkXHT1PZWmjGg9lEs7Oj6CxuVEglpuquGD?=
 =?us-ascii?Q?+6T5Rzwg7RkiNzNRIK4eIHdOCI1uTwr39ND/h2Ud1PGzqUglOBmSU40Klu4d?=
 =?us-ascii?Q?7H8GQ1hqhnT+Rc6hAMgKQSH0duzXYtUHx9oU/3QFY4VhNW+tQ0+aq6K9cBaK?=
 =?us-ascii?Q?Fvyl82kuNI3D4qZj0CS33VuIMXwq7ECKLzXc8jnFaMIq4Sp5E4ya2Vffghlf?=
 =?us-ascii?Q?EcUwEqUREHumbhgthY+D23yuVyFrH/jH+6U2kwdcWL92AnDGJFybycSyZMs5?=
 =?us-ascii?Q?XyUOGPumuSNMqex4uWo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e769cd-ce67-409e-5c89-08dcf832afaf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:59:36.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpJwexs58kSm152v0VWwH+7Shdnf8iIp4Ze8mzDnz3s78hY5f5Tox+3oJlu8lrPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

On Tue, Oct 29, 2024 at 08:46:40AM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 12:36:24PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 29, 2024 at 11:54:36AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 25, 2024 at 04:49:44PM -0700, Nicolin Chen wrote:
> > > > +void iommufd_viommu_destroy(struct iommufd_object *obj)
> > > > +{
> > > > +	struct iommufd_viommu *viommu =
> > > > +		container_of(obj, struct iommufd_viommu, obj);
> > > > +
> > > > +	if (viommu->ops && viommu->ops->free)
> > > > +		viommu->ops->free(viommu);
> > > 
> > > Ops can't be null and free can't be null, that would mean there is a
> > > memory leak.
> > 
> > Actually, it is just named wrong, it should be called destroy like
> > this op, it doesn't free any memory..
> 
> Well, it frees if driver allocated something in its top structure.
> Yet, "destroy" does sound less confusing. Let's rename it, assuming
> it can still remain to be optional as we have here.

Yes, optional is right, I was confused by the name. The core code uses
destroy so I'd stick with that.

Jason

