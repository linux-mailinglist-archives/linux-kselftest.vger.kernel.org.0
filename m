Return-Path: <linux-kselftest+bounces-12380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BC911674
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733231F23479
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150F147C74;
	Thu, 20 Jun 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uczZss8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D471422D5;
	Thu, 20 Jun 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925101; cv=fail; b=tms0O4pAffF8ViO9BnW5/x/XU36h/buGp0O9aerEU/4dDPe/ViCjsicwSYEsZ2KVLGVWeqonTt0XjEYFkHmrfsaJEn2ir/dauY0q/FSUZI8jhWEuNzmQo4gLg/xN1T23wPQORQqLjGKy3US+wgQw9x5+JharYNDMbpcTMgQcMd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925101; c=relaxed/simple;
	bh=en88DzFweWVf1WNwRMTV09u1VsCl/1qH/1V1NlJGb+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DC/ZqznwEddgd5i7hZO6X+0Dkze8Y6D5A+ArDT0IWVVhurBZsWUIrR6FC10BUdv8wJhHkGfKdi/jpj2wd5J3+WwWQsOkGa29TDNBXhiDdx/VL4uaM0+mbsopkWPH11r8aZg+eP4nSAh5+xUxW0vMCwDSODMRtfnLYI7XSJOEVCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uczZss8T; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYgW0aSo+m9YSJnt6Oss7vz/Y1c2nL+k9Q2mpzAz0QmpCp6pFdoN0GUwvta6SX8EyAhZzNZsCjcpSgofQ71ss91em2stW60/a8blz/cMONLFhISq8/7TNmf8CB+0SoM4pm9hKYKlkGuEB/DPmm/PwyvY7BUliINGPArvt4Iv8SODqpB0aVUFmide08V8EgbxgqjImcbfT4aTDkhYTo834DCscyNK0CQTCCG2TFMMVXoFBn6283h/pCpbw9g0sRX6pdkyHwPG/RcgaueY86n5PsbixdBhqP9elwe3Z9OY+fMTMA7y7DuDCUP9iC5hNSi8iTYYEbo2LenpAH/9XQO9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QUG8o2x4KoTXZg+DxKhZB8v2C0KFM98ikBqhwz+O3A=;
 b=hItaKjS0Q+poCZuPrkhmXVazu+JElGzPkYN886EynhzUfl9rxy0ij/dKuE6If8uddFPZYH9Wnv1nxFLlQ5aFa1VCx+qKmeSDxgkbFlk141nWsM4AbAD5iHfF2MSTgQOkLAXuapcEnNWSN2psBcbS+YKqCP14ZSGej1D2IQBNOVJFtrn598YRE2QrSm3AF535RYcpCYcAw7usZ8yn4Kr19VvzKHBaSjU0LIV3+IRlgz6XuRoXScdcUBDpVos+DfyFzzTw57r2s7UnBDgZ+Bkn3hPMAG4RekOHmnvDG237spE5Ngd2h0M6G3Vhf6hwEsezPRq4Bgsgr5hNEJokv9Kk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QUG8o2x4KoTXZg+DxKhZB8v2C0KFM98ikBqhwz+O3A=;
 b=uczZss8T+uRawr8ko3cJCctvQlfadKOm1C/5tRnQc2cT0/0o2ON5HAKoipZy7BCAC/2ljtQeY4+aHYALdEmfsZa7uS2Eh/OdzI3LCyMAlViyFDpFplF6lM2urNeid7D0Nz+ZdOiE4lCX2NzYOwRxy9RY5faBzo2E42v6JcNu/0pCf2nttrXNUU0KUo8wobi38z4wst7RmhozgMme693/BZsAJsCZm8mkyGjZW/Rhsuk3ANyGL7AZ0JQqmWw0Ghx7HabLibeUIp90ASfyO0OOWnTdwm5r7gjpJoA4IqKeJ97YmjyMcs6n6j43q09sL5vbOIAjeroao14ePjKlDlmK+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 23:11:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 23:11:35 +0000
Date: Thu, 20 Jun 2024 20:11:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620231133.GN2494510@nvidia.com>
References: <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSRZcap1dc2_WBV@google.com>
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f58d01-9b9d-4cee-2395-08dc917e548b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LucShqRHgIKy0OMUZ7qIZ4kBN53H2Bn/A/JXLAE/aCmx+SHjUNJdm3O2S4y?=
 =?us-ascii?Q?BQ6O/r7wlOCdyj3nofq+EPggVEbURjzEZzUcMY3MnO4wn3ncJJ0tDCXZpU5j?=
 =?us-ascii?Q?/xvFeShnZcwlwqITOwrlBw/ppUs/trHTUPDSMykO/c0DUcd/sicda7BImTGz?=
 =?us-ascii?Q?mIn3VwTuQ+QLtH8ZRoePaDjeHcGC0CLDPO1duApt2tbUtc3c80Dihykf6ywL?=
 =?us-ascii?Q?rmDiqgp5JwQAsShXktCdXe9vcO2wF50sOWii8gFIXhdLt1pc3m2mhv+5afjH?=
 =?us-ascii?Q?BX4vK+1yzEugrwEJCB6hACLcE56utb1PmuRKIsUYCzJ7cW8xwLLNffCxk3cz?=
 =?us-ascii?Q?3dJj9li6B7GQoOZtRy7dSueHcEPGmsdSRfVLCNRxQU1Jo87UHD5+DuMDw266?=
 =?us-ascii?Q?RXjd2bED/hWykJ8xChKL3UF1SONDzKbpMLB+2qLMS6xy6KG+1i3Mbn4EZw3X?=
 =?us-ascii?Q?5yIorTui78exaWzvxEd2xiLP0WazMoqDRcPzsbAFY6Xw/YjEWExg5og9w1jr?=
 =?us-ascii?Q?j+ZLPW15OPU4mS7OZp8ztcCQOS+mVX28IXyNmCe60+atc736llRvvMa/q09w?=
 =?us-ascii?Q?bArzo5KQ7x+AfVNokM81vkVgMtGHpMmp9Uh4wr2kt4qLFJBAlKFa2pUlgd+w?=
 =?us-ascii?Q?VXbQGl/LkMEIY1sAXDXMW5mGXf5ZWLEWUDaW9AJL7tUQeb/JaSgjBJYiepFD?=
 =?us-ascii?Q?dwSUYE8PKn+s4axeFyJU80brVWxggcRKfiWG9dZN6yhtrWImdWsy3fVdBfCP?=
 =?us-ascii?Q?wOxJLXUc2bGyyo7+ALaHzfDye0KoRwa3zzwbJbTiEsEuj+u0Plwiv9SMr4x8?=
 =?us-ascii?Q?EMlePwjXMTY3VXYWWuN20H50I3FbieqTAtcR/hEtNMgOtpE0RKFrrzXx3CE+?=
 =?us-ascii?Q?k0bdYuBPy1ugvpAs4CZAcZC/JS2fHW26/B9pSPPDGhiNnI0ABuj8OQFLbL3A?=
 =?us-ascii?Q?sQWSddLYkZttwjl9ODb+kMYBC9SVm7MC1EN4tGX6Fh/UNbKE2ZrwFvAJovcA?=
 =?us-ascii?Q?VUP+Tau/RR7V0hi0H6KezWSVG5yJDUOcmjfpjTo3Q7wY6IrtD3GwfqZdPhEF?=
 =?us-ascii?Q?yk4INQTas+ihRUBWbqUX3Rq3u2K46bJHx+jXUN4IHgLVtwwUL5Dk1gnGfs+p?=
 =?us-ascii?Q?S8oteeJpS4t4omZ6aBcVwsjFiJV+qQ5Bg9nhcCrp3QmNY8SAo4Yhkao/bHXD?=
 =?us-ascii?Q?D27rg+lc8qccSTB67K5udyf532vKsrb0pKQXxgsiZRvzIajNDPFQP561FJYj?=
 =?us-ascii?Q?n5GzDbiof4Ar93fQ945037E3XX4aehNW0mmBEFLawgEXSOyNpiD8yFRjhkuj?=
 =?us-ascii?Q?ZVHFedCj3Z8HHX41F9E5kxa/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQgy+g9KVtg5FTAeVvUJM6xY7ghdONtrYjRAWJ/PHoUdre8RW361ZpbuDLbh?=
 =?us-ascii?Q?+uKKKIgonKpu1HJJUD3Tbv/+Ae7CyITNEwbtOieF+0I9/GOfHOtTAz3h01++?=
 =?us-ascii?Q?DVy7fHo0I7pOI4xmiT91mfI/pah7foyReblyq2usQRkdEIShIQaMbIP5KLkN?=
 =?us-ascii?Q?RkSqyltK7vJDuXpPFazGnjNrrXes4BTOuC1vDRwnVw9IccvGh4V1lXBfsvSV?=
 =?us-ascii?Q?W7X0YmOISKcvwJ4JNpW5Kd88dWd/No/i1Xog9vcr7pWQYDK6SgA4J86zyyHy?=
 =?us-ascii?Q?5L9TcKNrgqLnHHIb4wPGfTYq5mhudiiAfq/6Hi57u7CLk5KPgZVWaL7VYko9?=
 =?us-ascii?Q?xK9zHthyW9WmK+9u2xDR8ZiD6qnmU6C0iCVxCaakDrfCMevmC/l4aO2ppFZy?=
 =?us-ascii?Q?NrPzVTYxPpEi70fGY7cr3ema+4tNlQ7f0BWQbvIrSg3GsS+JQoJMiCfjdNcS?=
 =?us-ascii?Q?DRIQyVNxUkQF8G332uUikHzilwYHkirD8TIuMQKn1Exu9MXnwM7UGNcilfrU?=
 =?us-ascii?Q?6Tx2fmgjikKCrG5UzBpzkDTZhHhKGHnMfYNy6XLGEhnqEY26BmQfnhfjoQ4Z?=
 =?us-ascii?Q?dWRlZ7gcmyz8RO988xEQyxu4z27RiIvN2YbU3usu9VB5mSlT1TbFERxI0Ak6?=
 =?us-ascii?Q?LzOYow+E9x+wDi7UFfWroIlKLoojWbhpvVa4dYMDX6siVN4cqrvXAS+t9x8c?=
 =?us-ascii?Q?BC3r+NOFK+2KA3GcF/0EDmfjoo5Ek9+xwS1DoM318qoQ39bKrpVxwXhAt+rI?=
 =?us-ascii?Q?mXmodXr+RYcEUAG46m1FCI0g605b0dzn6gR38+1KrB7hHeaCCWPc/FxG2b3v?=
 =?us-ascii?Q?mfOxpusydXKb3rpefbEoioD268UbLA5VOsCGMZZabsL8+FoQmhAtCOF6nE5h?=
 =?us-ascii?Q?RcebjhyGtACw31aXV26yulpZ7auX/QGFofJPGtfKPzRpoF9WxGKc1C+Ef7i2?=
 =?us-ascii?Q?/GnXO1phZhThkhPt0W2HF3plrJEFO1YweOqJaHVPbq9ZBvcN4hKAvfEAJZkV?=
 =?us-ascii?Q?Nw7OcSbqyeHvYLNK6XfdHy8/vV6JmauFKEvSkqglqpFp0NDftDQs50vQjJRd?=
 =?us-ascii?Q?CRZHmSRubppJO7T7FMf1653D91l3DEZR7FOw4e07TvmMm8SEnzSsSi3EWKve?=
 =?us-ascii?Q?VdrjG6bj4/lAYn2RdNg9tUQDZVkyCxX+QwOooeJURbqhuWPvXjMIrHz6CaiR?=
 =?us-ascii?Q?+1SsIrswiMll+qAiG0CXjpk2kwKN6EhIpnQzydJF0kLCw6/MAH2qfZXp0mtO?=
 =?us-ascii?Q?iAPyxW9DyLbhC6rpbGMQgmyJ5yivs01qfi0YieZG8UECGxHJbvntfAiFy4Vk?=
 =?us-ascii?Q?j2S8ox2TM85iFiUzrpLG8Uo+62lRiwPeOP+sIsFixmL7ea8Zno76+s/haVV+?=
 =?us-ascii?Q?KRmM36+YBvUSu+etDeM3C5DlZVJ3QmuBc0XRXSWnmFaGs7cVppKfBF2H395T?=
 =?us-ascii?Q?9ZwHRk7BkO5A++9TXQfJpO0YU7fHbK6Qo8RsMNbi8a8UPDefhps0bRSpRyjV?=
 =?us-ascii?Q?4fjnvZSJ51Lf0LICFqqhm6cPzIisc+wZd2dlI075yYdEAfPDnRJ0aoaJV2m8?=
 =?us-ascii?Q?Sw16mnwY/O4En8LtC/e/Na5XZZyx4qLdddc0TaxH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f58d01-9b9d-4cee-2395-08dc917e548b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 23:11:35.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ch1hsacQnDVGowEX+UPOllAMzGVoWIEX63NPEOXdbh+Jtcl7rI/4yRIz67QlW0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

On Thu, Jun 20, 2024 at 01:30:29PM -0700, Sean Christopherson wrote:
> I.e. except for blatant bugs, e.g. use-after-free, we need to be able to guarantee
> with 100% accuracy that there are no outstanding mappings when converting a page
> from shared=>private.  Crossing our fingers and hoping that short-term GUP will
> have gone away isn't enough.

To be clear it is not crossing fingers. If the page refcount is 0 then
there are no references to that memory anywhere at all. It is 100%
certain.

It may take time to reach zero, but when it does it is safe.

Many things rely on this property, including FSDAX.

> For non-CoCo VMs, I expect we'll want to be much more permissive, but I think
> they'll be a complete non-issue because there is no shared vs. private to worry
> about.  We can simply allow any and all userspace mappings for guest_memfd that is
> attached to a "regular" VM, because a misbehaving userspace only loses whatever
> hardening (or other benefits) was being provided by using guest_memfd.  I.e. the
> kernel and system at-large isn't at risk.

It does seem to me like guest_memfd should really focus on the private
aspect.

If we need normal memfd enhancements of some kind to work better with
KVM then that may be a better option than turning guest_memfd into
memfd.

Jason

