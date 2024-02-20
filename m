Return-Path: <linux-kselftest+bounces-5014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FE85B731
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521871F26015
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C955F480;
	Tue, 20 Feb 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GinGzWtV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C055FBA8;
	Tue, 20 Feb 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420915; cv=fail; b=nqsQ3tynjvD9SwEtt8qqjLP2bKsMFxh6f7WARlxJAiY3aAU3/bDPs5amDThSyS24eP8RN9uc0uRVIhXiR5tyipPhH4uasj59zVc1wZmPerLYCV6B66zbSHVRMYacp7CJeEtYwje1F/IJsbHetnnVRcRRjRH2kyEz1Z/JCWDIZiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420915; c=relaxed/simple;
	bh=KTzUhwozaFQkCyxWX/9l8OEbVVEqL4DRAmCKNNbTu30=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5lVga1b5utBNRCVnUKMbnigdKuHP/m9b7G64Ql32uXIc6kjufpaAN7CY6QxjO1IFobkLjbLTAgKNILkosEynGCJ8U8z9m93bcE/FlLEqiTXj+y2NMQ0JwJldft89uq8FIz3j2vNwficpKfg9CO5n3Or1BrdeUS963aisotoCVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GinGzWtV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708420914; x=1739956914;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=KTzUhwozaFQkCyxWX/9l8OEbVVEqL4DRAmCKNNbTu30=;
  b=GinGzWtV9RPmdNm6oZq7LV8pVN6tAodSaOVj/T/cHpfdQ6fWHekCDiAd
   hiXMOtk4OoFukSH0+WurwrX0+H7vZ4OF2K/VjvSf2YZtGEWc+SoEGhQv9
   mxGKPpO/Xv8OAV5zNxXt+acgA7L6XuBLZxZd/qi0i+VpAO1fSQJvJZVp9
   VvhygtAbn7meOEQgmIACEzzExvsK3SxZuII+nteUAkrmDGuLk8Xyxn6yR
   GpLWOki9JaoU9bRJymGS7IXdmU7dD9bIOUbpsHiFa837Kr+FYdnhzFcWA
   hsDic+OtPktYBLX4J/xzjkq/NJKKWyaDfplryY/Nu77xAAtiqCMMdZZSX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6337302"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6337302"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4716274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 01:21:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:21:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 01:21:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 01:21:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPkZXtZmwkXaErGCSrkxZV2ggtXvP0N/XEjsDohBRPp5T3eLFqWmfnTKaSig2f1PdyMx6ZxBOXlYx8mw6V2Fd7R+6+ThKtvs2pUyAxxTbbi+YKkfxNPIbc6JhLD0tKBnB33djZ//XNx6/Nun+jg3mU55YehLEcW02l0noFxCpSbWiTCju47cKi2pOWlRTNoLZ5pBGX+MpuQ09nPoezACCoTRUJi1mvjazDkJryrtdtrHglKsOyxdSQwvtn0Wa8/wrwTdJSvVbg5Pd9dzfqUC6Zql5WjE58zZQXtlI3B4DZ2FFrr8fOGqbrIojZbG6mgqYGdWqWVZ8lnPeXVn9ACVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsQkJYaRbdH2weUKw3J+KVkcutU8Y/Vlfipw50jTExQ=;
 b=AJwWZtVXwSk8pBHdkTI9QH5tdsAHYHA+kVw0ra+Ywj059DOyP235igylurn9gljTEm9z+fF6OrwS32jsSDUz0G5KsgyE5l4sat96B7CxPH4dknB2fbAdQJhsqtcBxqqax3V9HUKa+abM+cfLWvaRqsiAp1ChFM+YC46jSXp1hfx4AbsItiJz0C2yLr2XrjRQKmkIMAdxSaoX/bgXDOv5Qqvi3/y2wIxME+AvH8SOGcGuyKPYYrndwpjml6rlmoUsNnR5pzA/331dvXmSB6+RuEo232To7+89l0iGd8gWoGHFRUTIFixgHxklBqGuvpLsBd7qOyZly49v+gVM+K+adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 09:21:49 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 09:21:49 +0000
Date: Tue, 20 Feb 2024 16:52:09 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<stevensd@chromium.org>
Subject: Re: [RFC PATCH v2 1/3] KVM: allow mapping of compound tail pages for
 IO or PFNMAP mapping
Message-ID: <ZdRoOVA2jv+DXAzL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084424.20014-1-yan.y.zhao@intel.com>
 <ZcrfQS883NfOso4r@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcrfQS883NfOso4r@google.com>
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a254a4-87ca-4268-f3d5-08dc31f55e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbt2KpRNqMMYfZC7AVuwJxHMFL43u9OBMt26QeBDZpvOYBgUA6gKpeSVt/6V6BxCdzrCR9s0llkxfny+nZ2UJ0gz3GqkfxLn45Xzpk/zXBRoFv58yoKkGOp5PhofvEa331Qw6BH4Ucm8vQ0Fs6D3qN5j3z+bK1oUhI9xEIdjvKxYUKOKlgk/aDAyL/1Y6HUMAI/gZUhdqB1b26C7v13i3rCusQcBsnucuAMXhSq3qWRKjN6Myp24bC+OkaP+/m8bCVh3KnxOqWJsfA4supZJwysQi0sV61MwaCZXMOwrHACeyg2yCk86KCrEbDRCcCe3cZCgfkZQu+57SHN+h44t+j9GqeiklfJJyDyKW6B0iMQTWYVdQAob6Ww59sY0RAImW7FaZP8P7HW5ZUtvjWzH9L+lEwG4jzqT6qoNTmtJxk0iO8lDlIg6HVEI2YRzV48GZuOWLguoXUJFFmlKnHymzgHSbi2VU5gQCzq9JFnVcHm3Avfo12WC0QttkosamayzOV/l3vANEXRHSR7qRAqof1KJCSiRcEd5G3XdpiITuzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJAH5wyzXyx2AaPzWl0MP/tYltSmziWogyohxFunfJWmKQO8OR9FFtAaNXKR?=
 =?us-ascii?Q?mv9ajrRoxVkOlDW+N9hZpADfPCTtn+TnyUOWHvgYFyUyU9TNBS/FbBxFA0if?=
 =?us-ascii?Q?WcemlUEyQcnGUHKCUVSEJK9kOUwOV3fdbzWWagmd1hHeKByZv/CU+7D1CTCA?=
 =?us-ascii?Q?+RqqLuadi4atLx7PAz52fhXm1SJtDrbYl+3DRy06VfiqPtR1I7xotXUIsQ1c?=
 =?us-ascii?Q?u0LBMCYHRE2LUWYYmLJ3fLvdXQY8zxUeAGrenJd+RqsJTlXtmkkbLe00R6wz?=
 =?us-ascii?Q?rPPCGc66+n8s2KYvGS7nVghtFjTg/5Zb6iqJPmSxDqncnLm/FnbS7HTx9V9o?=
 =?us-ascii?Q?73NtgsqxLxAfiXFSfIita1hAwoerdUhVtFRjjsu+Auakh+TAn5WCmUYAWqvP?=
 =?us-ascii?Q?cO2gmOoKu4BuGMsWWyfUxN44Lt2sl7s+TvsoB3co/bgrhULLd594ORpSjG/O?=
 =?us-ascii?Q?e740Fr3NVXkmZf1TtE4swspDyLTLV1zCtm4CoPHZzLfBhh9LEMb3BhuEmXXn?=
 =?us-ascii?Q?qgucV8q/0xV5gJzMb7nP/80uTlQayMVnfkfkBRQW4QHakWdDvhf4ZfU2uCUr?=
 =?us-ascii?Q?7g8EvYYKwE5mwH6njnUMOamcPoT5SQLuwEZBr3HFKAZePKiEEwUNmrm0EXmF?=
 =?us-ascii?Q?iaApjaWzEaKD/dzReWlSwmbAcaPrBXxERMgwsyT3jHdBh05cDTG5+nHNra/D?=
 =?us-ascii?Q?Jf3+liUphUPF42dJibp0atQEwQyHlbEr5pMSrS4Fh9XQ0OMP4ZG6Z1a6g+f0?=
 =?us-ascii?Q?N/fvWelqBaTS3bFVvmgbspTEkrJkBiDZbWewa0Z5vVP54icynWqOPg/5jJw0?=
 =?us-ascii?Q?fHm4L7vF3yAdIiHQa5ATBhWTXtgD7EBOpYprR1IEcfwCdZhsOSA/52cxP2dH?=
 =?us-ascii?Q?E4d+lQpw4F6//yo7Vp53uHWCTRhM7pmOSDZ7amXdHbRONWF7/OofhmyLOHiz?=
 =?us-ascii?Q?Pfg1jUvQezHSZCqPbIVk0yCFbHQ4PkDa98E9UxprYc/9GbZ4ajFyyLi1K/WH?=
 =?us-ascii?Q?sm2KXVPpC1PEJ3O5q7IZYiSC0LU7cFw7qN1Q81eCcZg3sktqp65P8E2ITe2U?=
 =?us-ascii?Q?/bClxaEfh7zre6hK7O+NhKlRS4JLoCfLwNiNRmZkH9JPvPW1CGInRnqIivON?=
 =?us-ascii?Q?7F9EU1nSX/SqCnrVWVFXlnybMFkPc0lTGsZPkmm12vwg46h2cwK1QDVyyJ8r?=
 =?us-ascii?Q?niE5RVgmfunErO7449qW47FKKmJDZ8gjiX1bY17mtDeK5PzJrQo1JAvkKa3e?=
 =?us-ascii?Q?QRAzZ8CWi5DRKHKt72gthyDvDQVpmCQWzcOKPwq8nTMSjA2sNhLQlqIRDG2r?=
 =?us-ascii?Q?n2Dqd10ZJVLVv1etgJDWjSe3lBAeGxNjGnIUvEx/lOxGc7zFYDd5gIm06qQQ?=
 =?us-ascii?Q?mAUTDM/qAbbN+WXmRDx3L9bYndmWSZ7VJla0YrL8WUq0xgxsl1sN3yEtjq+b?=
 =?us-ascii?Q?LgdWXYdZpUVwG+Zzpalj09b1juA4JiaMgM719m4FAoYSrw5FvCFie4TM54xE?=
 =?us-ascii?Q?QS0F0cWnUlAIxhLEWfM67uVYjup6jTQhCUGD9Bpp25GOmmI8/xt3OGPQ2bq+?=
 =?us-ascii?Q?bhZdHF0jDIFdhFskdBIryq9P6XLSL6j1Ajuj/FOn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a254a4-87ca-4268-f3d5-08dc31f55e1f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:21:49.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBHWf/N+tP2DdVmA9WFEh9lBKdfOzWB8BS9wvc5QMw+k7Pf20W6YjV8l7Sf7zocjlnDI7skgQLa0hBQuZgXTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 07:17:21PM -0800, Sean Christopherson wrote:
> On Wed, Jan 03, 2024, Yan Zhao wrote:
> > Allow mapping of tail pages of compound pages for IO or PFNMAP mapping
> > by trying and getting ref count of its head page.
> > 
> > For IO or PFNMAP mapping, sometimes it's backed by compound pages.
> > KVM will just return error on mapping of tail pages of the compound pages,
> > as ref count of the tail pages are always 0.
> > 
> > So, rather than check and add ref count of a tail page, check and add ref
> > count of its folio (head page) to allow mapping of the compound tail pages.
> 
> Can you add a blurb to call out that this is effectively what gup() does in
> try_get_folio()?  That knowledge give me a _lot_ more confidence that this is
> correct (I didn't think too deeply about what this patch was doing when I looked
> at v1).
Sure.

> 
> > This will not break the origial intention to disallow mapping of tail pages
> > of non-compound higher order allocations as the folio of a non-compound
> > tail page is the same as the page itself.
> > 
> > On the other side, put_page() has already converted page to folio before
> > putting page ref.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  virt/kvm/kvm_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index acd67fb40183..f53b58446ac7 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2892,7 +2892,7 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
> >  	if (!page)
> >  		return 1;
> >  
> > -	return get_page_unless_zero(page);
> > +	return folio_try_get(page_folio(page));
> 
> This seems like it needs retry logic, a la try_get_folio(), to guard against a
> race with the folio being split.  From page_folio():
>   
>  If the caller* does not hold a reference, this call may race with a folio split,
>  so it should re-check the folio still contains this page after gaining a
>  reference on the folio.
> 
> I assume that splitting one of these folios is extremely unlikely, but I don't
> see any harm in being paranoid (unless this really truly cannot race).
Yes, you are right!
Will do the retry. Thanks!

