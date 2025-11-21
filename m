Return-Path: <linux-kselftest+bounces-46161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26632C76CC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 024124E35BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16A146588;
	Fri, 21 Nov 2025 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouWWUU3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BEBA45;
	Fri, 21 Nov 2025 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763686046; cv=fail; b=dFvWrruAH5cqnzMBTEgHN5vP7nyOuC8wHKP5PtHtiskt03s8v6EBli/xJMBPcqZ/T120mXdBJs0YAX0QQpyZDSSKuqLnxfA8I5iEenak/jgNE5CSzEBqvBcnk8+EDXLJsmCBXOnolAIrLf76SKGiur5QNqhzDVxBBQOJJxxjROE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763686046; c=relaxed/simple;
	bh=WTvGoOqJt3BgtHvNCSsWwB+stkvb2mtzVLMXY4iNCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=joeUbFsl/Ia++B0oM1wcZ9z8s9cfPmKUkEtOJuXwDs9ZZhF3QHkApM+0aYRTND2vQkrJU32jG2SYzaAtyOitZG0GqNAVo6DvX+cDZxFfuD5IP4CSIR4NXvTco4DBCJ98jT76/9rrh4CaK6mCT5ZGSrScUPbYM76fpBgtjQTOw5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouWWUU3H; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/kyiO3lKG54ZoDmqxwXbJTI7Q8nIG1444Sq4DjAV5hicuvvqWHIO9IqMoIcIQk43KlNFgs1TBiZH/TYYjMspkWtSe+Db/WbnZtuoUNEGGkIaA0JYycQIMifA/6bopGe9AAuXhuSfVdG+3mcGbxuOi/cBqqZDT05WDuoEiZHBfKhwBQspAjW9mIkbqzoUbSw3CNsonA3mR8RY77zr6eTLRIdWJW3AMJexNG9tWd2OMV626yROWnXGAJg6AtD1tMC7u6o08r6FrD3/lcCnQD1xSVOK3YgTjlsIcuZTMmI7Ix9semfUEntN+8qXubrS0S8QHpBCJ5kRRkrdZQbGrI9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEeZzbtlfgZ6cibpsf61ef2/aVliNIQUo/35eGVPdr4=;
 b=s5ZGOJyLeq9oCsf6oO1R2lM22Fi62drXGc5B2MMx1MW2zxFlVUA+oCmeDwpaU4cOV6YtCc2IyIMY/I9reF+G2UooQLfrG55H+etb4BtOK9ShL9r7AzMuEm3N26ITOka0hAWucuZO0GLq1SIiZp7YPm5GZsRUk+kaxINfffA8P3cYcbQ+U2Dcky2LHqxFT9Kj8UR6lzabn5G+yt3F+jODqFR0Gq/yJ3JzJN0D7cu9YPOGh9zQelraXAC2LL/3gmS+Yv+fbFFCh9gOMd6fGlaX7sMVRXVmtMFdlqeA1SswISyG22yA9XyMFq4r/lXGrczUJQHscQReudV45tJDAoPE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEeZzbtlfgZ6cibpsf61ef2/aVliNIQUo/35eGVPdr4=;
 b=ouWWUU3Hvrtb/PJkOi3R2sh6zyE2ylHe5X4bunxagnDPSSZaVsfn4cF+B2R8OqGjFRoLDCSJRonVKdp8YPShgSEWsj7CleHkbdAhl509SnxYXjk4gDtykVNE5pRSF/RGZtNgXBP+8JvwiiK3lPl/hz4sz3+U8en4qvwMLXJDGT+VsNB0Jl14yzfhq+OsmsuEzuojWaEoEAaD9pHVyQfcntQ45ZmOlNmORG0VOoQqmUhUBEIPgDKb1grqJfWJ6ukHEjtGXjTm7XK+iWux9NXR8kB0NXwud5SYsI+df/udj8senDdTkN/efmSdxtsO8c+olmqdzlkryZX9XZobBlV5QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 00:47:21 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 00:47:21 +0000
Date: Thu, 20 Nov 2025 20:47:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Message-ID: <20251121004720.GF153257@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <BN9PR11MB52769E70061CE3AB22F9E0618CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769E70061CE3AB22F9E0618CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:208:d4::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3d466-c9e7-47df-c7b8-08de2897878c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9eRDoqkECgi/8n+ut5sQ85pTufvDCMmNkSa2+krjhI7zYwr+KunTeAtrbjBZ?=
 =?us-ascii?Q?UEGuOaGp0YhF3/Qtoa/PgUUpLLVFEWvwf7bG/5BoCb43uXn8ExrYv2HpPSEl?=
 =?us-ascii?Q?vPNj0sxqOUy5suPdrVckMHJSCBlLoZ5l07GWf045KTyyDehbp0PaR4lAFubU?=
 =?us-ascii?Q?rL0oQrpHgJGdE5SaRbbI9eB3MIakxqNF2CI5T123MqYXJPVoqS49C4k1PqSc?=
 =?us-ascii?Q?4o6OXzrmXvkutLmZQoLjsh6GQIDU0SMuffhqKxZqs3S2PV3TjrdUZ3tED7Y6?=
 =?us-ascii?Q?QI421XsLGufFK8WEAMzJ0D80Qf29k43NHlroaNHAE5BLZmsRMuJt0gwerTt9?=
 =?us-ascii?Q?3WMRg/LjVUJxJJG3KI39mJlXPAXBJrznhyNBjm1V37kmDLE2zHlbEbMj29C5?=
 =?us-ascii?Q?8DYT4y/ZTzOe3XSIV19q9HF8lTJOjictJI350HCsMRT/czZlJQtN98k3hIft?=
 =?us-ascii?Q?RKvgw7nZYa+uBXBh3TLrwZQE3rrbu4r0gvdZ9NOZqwoFt1TxRLtd084V2a5c?=
 =?us-ascii?Q?K+W2KNydUOlTC3yAaUj0gg0l1amLT0wmb3pRRFra17knhgOYd8UF3SuI5Ql2?=
 =?us-ascii?Q?5L6uwf+8RrYfIBsQ0kNvS5xyI4PwR54OOco8NFCbdtA90yyt0Mz211o5AHlT?=
 =?us-ascii?Q?K1doqFODrcW+mlTdsb77OhUXwo6sUYBaVqtPGm5LQXGiuEnbms1WQjXd4Zkn?=
 =?us-ascii?Q?OkoqY1OJbnyrMSPrkAvV9d2AAXSM8DVcn2f3gDz6gPMvCkKEPYvQc6m9F69o?=
 =?us-ascii?Q?u5n8uCBUAeUQ0PnwfZ0iy1iX8NrewPadgcBbfOoGIdpmtzwmohupSEyA9vFI?=
 =?us-ascii?Q?4p6w7nG6jBkV+jIc2c/5TUbfd/1aPf8oLmen9FPp7q8Rx/EC0i3tqScuSNWv?=
 =?us-ascii?Q?JulFQnZ9jVPoQUqt5YZ99kGI3SKOs+izAzqE1FUG4VZFICaI05uqZJaWZrMK?=
 =?us-ascii?Q?OG0OLQg5BaFN2BBl2QsrQetJJK4XlRomPEiy5PeJEj/STD4T/BPEhyJfdvIy?=
 =?us-ascii?Q?2AU7hSXgsFAlP/iBc1RNwhcnrB29valsMvnbKU+qoyETGkP+bRzPzCiXE7Y+?=
 =?us-ascii?Q?4VXMi/R670pr3PvNAIPx5zHWnlmSzaIg0ZTSWwiWEzP1VADRk4N6XSner4cK?=
 =?us-ascii?Q?jym5PpB99ghLum4iAqylAMy8JDIZ9IpIc+myQrww03fe7duC26F0Nwu4kHue?=
 =?us-ascii?Q?0yTf4eoiDr1hZOyJ9CsEFr9gfci+vUlFg5GA/uXt6bPauiWAQIvvJYo+KfkY?=
 =?us-ascii?Q?otCzRTMbyWjhIObCA9yOY3hQk4nBrfMiA2NnpLrjIFBFHAqCrgHbSFTHH5P3?=
 =?us-ascii?Q?41QesVsJ6kSAhql1sbz/sLnNtSUho7CdMQlfAJZBO7t0DhtVcIV40KHiN9YG?=
 =?us-ascii?Q?qOFed0UQQ+Jj4dVzyTVrLxuHHqnGR4G7nWI1pvDKf+NWrgeDJ+4qh4XVK2QS?=
 =?us-ascii?Q?QD7BRjml624quTFs9qny2fYjcOOzQA0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IA43vWoiiSYBcs6t0cIiNQZW0u6hWcrbb6k/NViupQzjW0S8HQkwvgfeLR6?=
 =?us-ascii?Q?AsgrWjIormW1nPAuEs8FM+keuVbmfsD2LzIkJ+IW7JxHs8ZNfNfXEwR9F75A?=
 =?us-ascii?Q?/65Q26eogM4XqPxwrTSXduZ0q0sazzaZjv4AyCkdd+YBmwY6LyxnJrroPqS6?=
 =?us-ascii?Q?Y3/zbgmQIfnUjSpPC1mcqSYZK4KnFWghMmaaPaQNrfT9It4WCEl0JoZMsWiS?=
 =?us-ascii?Q?1tU4N0c+TDS0uSjHI3G+lTCfvI7m5hQ7FJpUf/cUdOdZfZloKWeRoZb5kDSu?=
 =?us-ascii?Q?oiuzsn/IsHdnxRJNeM1wWb/eBRVMEumCNWjQXLrf04fMcL4qbdXNkDF7MwXf?=
 =?us-ascii?Q?LbUOAdmOe7EVPw98F/eMB/1rZtd3b+uEu6iIikVNO3iWwjki2t05ULj/Jxw6?=
 =?us-ascii?Q?l+ps1qK/NWNGIdA+xAFRXDjt+pUPm89Yl7ca1LD2rULR+5h4OcNypBFjz20d?=
 =?us-ascii?Q?8fNwt2Fq+OqhQzWcCLsoq2CY0KpICLl42dO4jtTT+tiyHZC5FAUM+W3R3Me5?=
 =?us-ascii?Q?YLqAu6sOizzNhfLD1fcQTY5iqwVNPwYI6CPL4KTb/g2zfVocsHbZpvZFm1NO?=
 =?us-ascii?Q?uwaNo9m8Kp8ltNCEPeX1ibHWcUnXRsX1FrEGJtUmKVdam0TWLys5Z6uVA0CP?=
 =?us-ascii?Q?hIBp3I4PSpnSMCUz1iTVilS+61DMK7f40vke9c94Grn3vc3CRBPMXEy4dfTg?=
 =?us-ascii?Q?8ROHbhxGM+fXQ6Enn5AfQPTPXrSyccAIrlw3EH6GCGZSKxtyN4FRHZ3OAFW7?=
 =?us-ascii?Q?kQC9z2a+1Xodu0vn+jdxTkr84VVVw7ia+RHzY0xYseZh5ATwUU6dU83tsYSV?=
 =?us-ascii?Q?mImwZZ8sJGJaXSiqUCJN1JZSHI3vs6vR3mRufpW5ftmlkCuA+5/qnb75s7lP?=
 =?us-ascii?Q?iFWp0fPx0FTiOVofWGD7yzE4u+5BbBYgRb5jiMrLxNcin36VgJ1+YGs2IP2h?=
 =?us-ascii?Q?DVipz4ncyLSBm5lxyJ4lfBzOvCvU1IDOjSdzKGj+Xska8nHta+NUISoXmuvq?=
 =?us-ascii?Q?ObwBptIll0BV9B3mSv5Ayrjl8LZjrpJ5WHdmvzmITqE8smMyZnVUwfHVGFza?=
 =?us-ascii?Q?q82zxcukRSYJSCfq9Hq7NxC/wQyQjXs08+LNnGUr10jMRaYFsj9vnOeNnGcp?=
 =?us-ascii?Q?tcZLjOrStxsUFKNqpNL95TiHjQpal0GXFghmR0U1tLk+URbr08u2ov8gxYai?=
 =?us-ascii?Q?SrSeeSK561u2iwg420Cfvtt8NarpkYVyx14mSDjGu9Fnm//MP+JtlYCmvoWp?=
 =?us-ascii?Q?CToouQDSCjB7xpUkIcdB2c4g3hPRLtmT5srVnE58O8AubicKuLhPN52kwTzM?=
 =?us-ascii?Q?xYfJ/axw/DhPiWSytag626leUC3pmSig+II+n7WLBMYn9bdYhdfvgzv9jOyf?=
 =?us-ascii?Q?F3iVpH+C9m9zw/QoAYNPueNmnt2MpY4pBSNA7XkefPZDgASNglMtwk0sc5pu?=
 =?us-ascii?Q?NoBykzgKRkzUScFK5Z1KiiF8MKNKRDekOEB6WdMJoUM6tYDwl5cJW0bkZ3oz?=
 =?us-ascii?Q?1SXTKV1yr+hWnm37xzsb5fYILpRdRSJr7Tb4PdjhvZJEJB5iuJj1Sa5cV9aN?=
 =?us-ascii?Q?lpdKNKjaYzxWKw1HQ/k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3d466-c9e7-47df-c7b8-08de2897878c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 00:47:21.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEo3i9MnaCYKuxo3BCLwCIVglXt+VW5EGMWdztz3xhrNk61SLUwj2afGahbOmgEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

On Thu, Nov 20, 2025 at 08:04:37AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, November 8, 2025 12:50 AM
> > +
> > +static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
> > +				  struct pfn_batch *batch,
> > +				  unsigned long start_index,
> > +				  unsigned long last_index)
> > +{
> > +	unsigned long start = dmabuf->start_offset + start_index * PAGE_SIZE;
> > +
> > +	/*
> > +	 * This works in PAGE_SIZE indexes, if the dmabuf is sliced and
> > +	 * starts/ends at a sub page offset then the batch to domain code will
> > +	 * adjust it.
> > +	 */
> 
> dmabuf->start_offset comes from pages->dmabuf.start, which is initialized as:
> 
> 	pages->dmabuf.start = start - start_byte;
> 
> so it's always page-aligned. Where is the sub-page offset coming from?

I need to go over this again to check it, this sub-page stuff is
a bit convoluted. start_offset should include the sub page offset
here..

> > @@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct
> > iopt_area *area,
> > 
> >  	lockdep_assert_held(&pages->mutex);
> > 
> > +	if (iopt_is_dmabuf(pages)) {
> > +		iopt_area_unmap_domain_range(area, domain, start_index,
> > +					     last_index);
> > +		return;
> > +	}
> > +
> 
> this belongs to patch3?

This is part of programming the domain with the dmabuf, the patch3 was
about the revoke which is a slightly different topic though they are
both similar.

Thanks,
Jason

