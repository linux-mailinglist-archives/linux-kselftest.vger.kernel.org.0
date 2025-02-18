Return-Path: <linux-kselftest+bounces-26863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B7A3A167
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77C83A17BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA726D5AC;
	Tue, 18 Feb 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbMDAhYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808426B953;
	Tue, 18 Feb 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892948; cv=fail; b=Lk3zEZ7vxHAbvztbN3wroj0uGOkhkFDOGncOO9iyb3je6odgGZYmQQclp037V53XfpNQnOxquL4zQMX88aQS3WZK+74HH3lVQHrhIUVJk/15RTz3ooO4pEVnZiNur6psGUQZB6ToQCTE9hX5lYd+3Wt+EVxmZdvN9+w1a1PuVpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892948; c=relaxed/simple;
	bh=fuvwUI7iyS4PiPKz3SAAWvbHKlGU//cSxS9RMjGVSVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEtyjB0qXpCS4J60fVz8x6bNbKbIfzO8xG7VhtSbYBtRAwORbGLMuRFmfv2rY3W05QdJAXIUcBO8uegmoVz9IaCFVvidaGOFyVTO3y/ijI+LBkfQtLXpd/2IOYmLjEGF++hmVZRHpzu2aPu65SjnYoKqzCfW/O/9KN39sxys31o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbMDAhYG; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+ru0lKmtVi7uA9vfV1Eo6SAi/N6t4qqHYT2JjnJ2agnadwwIoaf2jcfCnMByJuKnQ4bLWaPk1pFsMSpOyzly8fNImfO1vKSHEej2B6APPMuLzRr9WrjiF6/mXxcE8m7aie5Hung9UImjA6AyzucLqK2/p0+lsAc+KNaJAlGoPOhEN2VXZai4YA0ekpdhSeatWHxDPpvChWCpJT0AsJ5aowxAjxV/1uTgl3psyxoh1ltSpxj6DyM+fmrkb5OvrB9JJqeNAlBPaFs8YO801819HlPeBmcBQm1CV0LMYUIh3MOa8nUAXnYcLlWbP480Obky8M5M7J7rLvoxdAyiRsSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0otcvY23eT9OoTQ7Pb8x3d1xsUwGft+diR2jE+SdxWA=;
 b=kekh7PUCIVokbyR+joRQZPuR698akL72XZYgiyaqIWxO5PdSRKvCXL4OOhgTJvEfEsCHwNoeoIMUqYoC/IS5TJM99kAyd8qdY7kXc0Cd2K2e2Wswvn6NcMcaBBkjXioICeb2tU8EFcgpTSvOnPadlDMy1ZeIuEyAoSt/IWFY3qasz8fAm/7qF0VVrhzgvOqSvJCifTQpDXUQNb+6IlCUofSHyUoTlyrUkh2iKbIFsmXeNfQW/FSBI4xnu7IJBmprq67ZdwZWywYXBhdUgtAB1Qc+LzyLgL64iEqS0w5TgX3Oh/ulsnA6eqwBXituBoqizNLYrMjh0yep/i2YMFo6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0otcvY23eT9OoTQ7Pb8x3d1xsUwGft+diR2jE+SdxWA=;
 b=pbMDAhYGzDvxVQykoGszMhYXYEsZCF8Dzf95poblkE/cIkDCwJf59YwLZ4X8SUJt7GFEQ3cCzjMxGvJA82Zf7ov8FjD4Ci0p3jKCG93TZwVqw+wsRw1u9MH1xyUMitLaH/2AP+D6IOdprpsGTYJS/mJQ6kR3rjf9Pk/dEOvM3Jc/Vh0FoUS8tWUrukhV2CybIUmeCWN/hFbEMTTsnKtsiHObL1L0NEu8QgMKZapGGb8unugg8UlZEN05SRlCRjJkm7fvFuI9X1o41SbPnpn+/3AYsdBNps5AXndJ4WeP3yn/A0JPGk6QvT7NREdmHJLUfFXriFr5ZbXBpJCJMxfWhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 15:35:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 15:35:43 +0000
Date: Tue, 18 Feb 2025 11:35:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250218153541.GD4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0781.namprd03.prod.outlook.com
 (2603:10b6:408:13f::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: a4399d16-ae7d-481e-f337-08dd5031e7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+F1gLeSOlYisbQjtARiVHMCuAgrrZL5FWFqQ+jRuYko91uyupVCjDF/FYu0?=
 =?us-ascii?Q?I3PH+hf0yypkANvQcf0vRqVIawxjOdeEOK83UbpHy7B7mlAkeUw++eiWrcig?=
 =?us-ascii?Q?POj4UKS26LBZBetynXKcPmiF2k8PWdtvWcmBGgx9Mn0mAm85kcjQz8uqt4Ky?=
 =?us-ascii?Q?mrHXZBv8RxJow1yBwGAKIR/zXX6fu99fJMrqnqlfz5X9kQF+Om4yE3yWAIMs?=
 =?us-ascii?Q?43BpWm5rKGwFOSH/8MkCBQE1fngQ8H3bQ+AywmCViIDpny36IBJoB2douRXe?=
 =?us-ascii?Q?WjpmCIvNwsVolVLWLhDYkn86QM7NLmceBIuglNeL/3i699xAFZDJZ58RVj2D?=
 =?us-ascii?Q?2yZD9iNsXOmHN1u5lZuVMNYREenLrOkWG29GNCFY0WYZo+pb/DFzj7zR/0f/?=
 =?us-ascii?Q?As0HL+zVr6S+Z0IRcLK6GIW4AVbwS0ngKhkj++ianWr61uCF5RctkmvpMwoV?=
 =?us-ascii?Q?YZOqvMfMh2qDUxpNUkAjNsK5NmS5qkOyVbF8Mi10AvUfWkMPjidTDSw+Ub9i?=
 =?us-ascii?Q?FBazUvVDliwJJg93kGp6aq2dPon2iv2LnRlS7Rkl3V4wNl2dQKZillDOVgWZ?=
 =?us-ascii?Q?kYmFP2vmmrMvBAngMZIrJO8O7KH5SbUtWHiAZByADEHY0wCE2Vj3Iv8EgAfp?=
 =?us-ascii?Q?57AwHgvOI00qKIvKVbsi7zp3H6Rb65vUkEwXy4kAeHLSxaZHeoIIf2Om/SGM?=
 =?us-ascii?Q?vjeIuZUAPY/KNlLuoiPqbwVvsHpednykLQrt0eoWsTVy0F7Hwr6espWvUDkN?=
 =?us-ascii?Q?jbky/Ehc8XNaMzxziAlFiUqkSbc+2F13n2jgiD7RrPd3t05PmVcIqBRLk/e9?=
 =?us-ascii?Q?BLi4AET04QMUaI5e0UYOtm38DQtjA4iGwp3HTnNNrRPDVadT7Ze0fuag0HC+?=
 =?us-ascii?Q?RX4vXoPIZuaAwvo2SrQO1igJCeS9VINCcFRXR5hZnYiB8PaOBQmgvF0IoaRz?=
 =?us-ascii?Q?Yqlnz9c33pno5zL19zoLEpI2LWaMll5fI516A9h4N8IJ501SYoUxgQaKWWpW?=
 =?us-ascii?Q?NGAFtJ9ZwknqoMN3DcBGLnEX4nyrSaY++/pYyw2fSF3vwhHq4f6fZFZXijRX?=
 =?us-ascii?Q?exg2sbAk8DGLKUAdJzxOAvAT/Rqe3UNvXN12h2p7ssQXCd4Qjrkjj4D8vR3n?=
 =?us-ascii?Q?Nav659VbfQA8RIq3GrepD+dCSL4urMkJncEZIcu797s0C0Mdz+Y5fkk/ox41?=
 =?us-ascii?Q?2Cx54Us+dDwwWfsFFmagcmq3PjEsOhVVqjVIxIzc3URjueWcAW98hUJ5oRaW?=
 =?us-ascii?Q?0+fjn9DrgMBGA4BYe1Oi8tR6a0G2Pv+qGtfYzbA2jp7a2mPAC4Rc3Uy3g1J3?=
 =?us-ascii?Q?vKNnvUzcSsCVDTCLEIId1rL7Q8GC2HLRwaTDIkeZjUliPpE2MIAT6iiFXBk8?=
 =?us-ascii?Q?EEwlf3rNR917IGlRlHLibMeUB5P4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oX4238ABy/NRPOUeQTHKZvVvMg6Qa4aCyVQFpfQtUOyQUbSZQFhJ0At6z+p4?=
 =?us-ascii?Q?9/BwdfTjTtsksTEVTWKgxEISKvF9vxs/lMHIPFlxxLp8WPYwEm7vnVBeDekn?=
 =?us-ascii?Q?RYhZy5iKrmGzLeapaq8DVBRg9XOS/gqwIaCqLCryHD9n4PNlyMwgBssIUuIU?=
 =?us-ascii?Q?bP0J+ZWwMAAOhIJf1TNAjKT06HxYWDxgnySlBzjJSgjGbRlcUZTv/mzV2e+8?=
 =?us-ascii?Q?nZn1cbjyALxccwXNPYmLHHGcJtl41TDkxsloTA9MqB+NLg34gMjth0zNF0DR?=
 =?us-ascii?Q?WwuJEq8cqlCKWkp/tR4cQs7zcIQhbyVGcnQomI3gzjayTD5IhdUtU+HW8WTY?=
 =?us-ascii?Q?IlOilcPbztbLgJ/ZmAkQKZGG9QXkJc+j+kGi7uEs4Nn6Yh3CSjMdXra6fbkx?=
 =?us-ascii?Q?k3qY3tXb6YEnNlgAGbEvxP5H2XFNoKaeCBv/R56gWeNq498WcYL2vpBudDp1?=
 =?us-ascii?Q?DfzqW6N9B9BBj1jtGZkl4oHcsmRcabj2oXg5rwRvZlKgWcra2CGHinse9iu7?=
 =?us-ascii?Q?Jt3L/YBMdbWy+k8TqhJm1JQ5fSuNUMEYRaHLU9+mC+yJhpSXHFJl+JkGtQUu?=
 =?us-ascii?Q?HwqLNfG7dWVo1w09y4izJsfGC+l9doGVnsMfKnfJjQzVTzjdur6FNs9PJQEG?=
 =?us-ascii?Q?PeVNyzY4Dg51lqcqRNjQ+WNT8i0qImDi8imyyxU3erVlC45DP0nseSrka2Wp?=
 =?us-ascii?Q?Dr0TyYX8GrFSuCrNnG2gd35PSqMHk74XdvUbb/vw0519AEY3j9cqiExe0EGs?=
 =?us-ascii?Q?jr4li0+PbkLefmz8N26Y8P0IcnAgQ4Re0dOcOivXg++F53FhbXnDZs/BNT4z?=
 =?us-ascii?Q?UcyGqnUzEYnxBGTOdd1IhLLoOPx1nOfvFaZs8iM6mxorxrhFknqrxH0dUZr6?=
 =?us-ascii?Q?REbax6F8+fCIj+zXanktz6NH1OjRSoDD8BTsEvvF80tfLhkJyzQwGAp/73bC?=
 =?us-ascii?Q?QpQ5haIsncQwndre2NEJJ+r6dKEFLVRbu41SRxCeVDI6pKoYvbKkdfQ+/hRL?=
 =?us-ascii?Q?vTKUH25tQRaGC3wofT0FFwNZGj5QIia/JGNiVU/F31u2q4Z3YebMYqHhSt5t?=
 =?us-ascii?Q?piZ0ueVYaN8fOGIhhgzrwS1FCzkgJsQQ/clqmXQr3pUsHLZPsMDYJN/4wkiH?=
 =?us-ascii?Q?JbTALQsNdO5EtLWI1ZUlIZmYmQfwfar4fqO+A0sF9S1bDNG4ShPqzyBED965?=
 =?us-ascii?Q?Em+EUKXaVWGj1HJeU9EppYv4XdkbSzAgKRnA01eCvdzrdSzleLvjoPD+jfPN?=
 =?us-ascii?Q?wGN/MghzZ/rymwshCjxqLcqWuLJKzk9gYip9DnZxwaRrn7Jhqfac4vYlJ2NU?=
 =?us-ascii?Q?ZP44ljhE0uxdSZrOlub4xOBCrGGPVvIQ886GugF4W7TJg9VcAJQTFtewBVbX?=
 =?us-ascii?Q?51Xb97QbbX1p347xw/FXTe1Jcn13SbRsx/qVlDEGOf0oZrmJLGMVMutuCj2m?=
 =?us-ascii?Q?4a2ar1rS7WGO1Smn7Jetp8EpKdd+1oIxLuCYuEdvT8f88lFNNtBbkdTg1mIN?=
 =?us-ascii?Q?erPo3XWcbXLyE7NMpw2bwKjMeilnFdpmLXx2wtfhLcEHVD4YIofcXFINmZpy?=
 =?us-ascii?Q?qYIWYiQ8HULq1gZbHMq+WeTHkvxI1ldoY27N+h2G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4399d16-ae7d-481e-f337-08dd5031e7bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:35:42.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7zs6m0n8PYtNPeAkaQFYk1tJV7QDbMqWxrxynbjjxmjwZEwF6F61CcL1CbrDcfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334

On Fri, Jan 24, 2025 at 04:30:36PM -0800, Nicolin Chen wrote:
> +int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
> +				enum iommu_veventq_type type, void *event_data,
> +				size_t data_len)
> +{
> +	struct iommufd_veventq *veventq;
> +	struct iommufd_vevent *vevent;
> +	int rc = 0;
> +
> +	if (WARN_ON_ONCE(!data_len || !event_data))
> +		return -EINVAL;
> +
> +	down_read(&viommu->veventqs_rwsem);
> +
> +	veventq = iommufd_viommu_find_veventq(viommu, type);
> +	if (!veventq) {
> +		rc = -EOPNOTSUPP;
> +		goto out_unlock_veventqs;
> +	}
> +
> +	if (atomic_read(&veventq->num_events) == veventq->depth) {
> +		vevent = &veventq->overflow;
> +		goto out_set_header;
> +	}
> +
> +	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
> +	if (!vevent) {
> +		rc = -ENOMEM;
> +		goto out_unlock_veventqs;

This should record an overflow too

Jason

