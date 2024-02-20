Return-Path: <linux-kselftest+bounces-5006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A4585B5D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC08D1F22F8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55B5F48D;
	Tue, 20 Feb 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bparihsg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F55F477;
	Tue, 20 Feb 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419051; cv=fail; b=N/IymxfnSmaRXs6YWmYHxf857nC6xQf0PZtqf2toltJkINhVbs8h9iSRQCnUsJXHz9NMi8k2RoednO9z4652V7Uaq2kTD00Qt9hVHUfHZiSP0q4HU+FxzOIjIAmmZ7G6tgDflf5Z2hJXHR1EMlzWBsEp+Vk9rKw+fRq4NtDmIEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419051; c=relaxed/simple;
	bh=O49VgiCJApzoMALdqnBzqOFBz3Ttw3CMrrg7F91z800=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCacIUJUeuCHAh/Cyr8BF7UyQE6+147KeG1TyxXt86r0kKWLbes+Oz0/t/joUWUB4WEgH4pn5PbwAOZejHsN9TLkzLwWLUJahIcjNIvIbbm/Yd0tCXrKk9ULAYMSEUABOk2/2Bkik27YCPMPr8Nxc1YvMgrFMu64eFwlBfSG8DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bparihsg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708419049; x=1739955049;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=O49VgiCJApzoMALdqnBzqOFBz3Ttw3CMrrg7F91z800=;
  b=Bparihsg8ARVyLzY+WKxkBRruGnod5xAbmKCtbitn+J/6qZAWI58vMOo
   /CJpm0+fEHa9owHbULggACDC/BcS2H3imtRf8nw7URdVxWXIBtWqBqY2T
   LBoEBEM3O90bDdHDak70Rabn9jEBd13LiLt4HE9CaoNE60op2kMje96AF
   qCuD8Q5zgR2x0SPPs3U4AADddkQb/8xMSIVtQdhm7Qpa/Jnadvue0UoUw
   nZh/J+9hTd4o5hy4gYN0dKqqYKOR+4Y/LDoajhEveB0op00Nfp1TUtqD8
   89abzpRzW/QquLxcf9jq3rQ863FoeRqvTvLE5bn2+Lup0qtZRO6sK19d2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2377128"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2377128"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936420868"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936420868"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:50:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:50:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:50:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:50:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg+7AMY7W4dxYhYPOZvZqQjOjaS7aACY6x5Zh/DpjyhQJMbuhUdm1q+00F55WquISWeZvJqYVmfiDjn6WEQ9GY54eyVRmzR6QjNB47yceAqWiurU0Fl/3VEHenUVtuLJyCTDg4ZxGoYqg0eV4FFKswySJYHHDbRqfOMJScky9gFA64axjq9JEZ813yJldFjJ/U2RzSfyT3885qNdQujVv6sW9I8XRt45JlrCJ4QI499o8FuvVAS7Gxy0cOkrJKhlgxuEJFq74aQpASRutsGpLZr3ypvN14cNcssc/FSxaxgrWrkaGchSMmVXhqdK1k1sT+494CpZsYBHJdRmRb47Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxwBDeU70/GgTLxx96k14C1pzgxSvUjATv2qFeu0t34=;
 b=HTVZJ2bQldm98MzkZwCSTAfNAs3xZ8jxyMWs75utic9GpwNKqOl0r+cv3trMllHT8aeN8coZKXcwGoi1I470G8B3pl4eTWC2Q5VvTNQlJmkzyBV19AQKc3GeCJH+m44zkm+0XmaH0xSackEEWewk83aPAyTFFzo0XmKEgki6c0h01kHgHqkmMul6i2nqGDZFEWAdUeAdWrB7qhzBuQF3ETye8RWGtm9epnHt6cFcLLPP3kvHrU5IZkmpT/AFL5vU9NlOQ0OWOl1sumt7jXGq/Ha1nrUgwKJ7RkkcI/JvbX7hh4GPDQ7igD1ErZRixWR/xz6qHufp6LuYzb27rLpCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.38; Tue, 20 Feb 2024 08:50:41 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:50:40 +0000
Date: Tue, 20 Feb 2024 16:20:58 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<stevensd@chromium.org>
Subject: Re: [RFC PATCH v2 0/3] KVM: allow mapping of compound tail pages for
 IO or PFNMAP mapping
Message-ID: <ZdRg6pubbRSqWehY@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <Zcrc7UxSO3-Cncjm@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zcrc7UxSO3-Cncjm@google.com>
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 35234f0e-69a6-4c05-0490-08dc31f1041d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqVVEkUITMV033dPmYWPyvN49KPOJlr24GQzmani3oE7ggPh95XZVCG3x9f9YukeNzzs/Ow/t0q92eu83zy5ZTkjqWymudBaU7khEuysjknGk2lA9rrp1h0LflpmPN0F4Dkyg+wUJRmOw9kjsic4obCee+MM+vmd3y4oHdvIVAkKjA8zAfzX+6NP3LNd4TvaCLr7aTLobbpUsyhd6FiWp1sigkueGp2oVvDFT77crMzOeDXzEcuodQ0XPQaH2c+wFRvFiWuf/cVNy2dvUwNIJdTaxBl5vw/YMLhrIahFWAicJqISdTRB6m8ntDHjnDVqSQ6JPPkwOIbf1tiBXDa/n+TEBhpnVQT7Kdk5mjvqwXowjTNXzZwXwwDcYA9GNOOS6Am9G3j7oH7ST50DXchM9KIU0On6eDRygDCnmvweJWoMwXgiiQ+O0hRCtfwlBAB3c6jZnRm+F9jw4ddE/ExPNJxdLMVSW9N4ZzdHiSyIqoPhaXwo8GO67a300W6ubqiezmISgyar3K2JVUkYJ7pJpMdMrMUapxjp/nxWICwnwro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FMomVVPv+5XCqTU8Kwlrmsf5krP07bLFX+3+J6DaPn+tBO9vHwlvRuolOLjb?=
 =?us-ascii?Q?wDkCxVW/UpuE6eHEsHzlNn2rkAiHBvB1YWyAidohAdS99dOtAi5ZP8TR97vY?=
 =?us-ascii?Q?LQ15KEhgQrA4C7+OcQ5Zlxd0qPeKIaKwDw6JXG8ZAEFIB2HTiYj+nJjNHM6D?=
 =?us-ascii?Q?PraE4Nn3Xu3BK+u4oNpp8gWCUfeT9ReN5c+Xi8q6DsEGdhQNmka1IoymtjEj?=
 =?us-ascii?Q?RKuPOjzeV/Tol5MCH9a3o6rkFd6t8w2RmoAtQdmuHAbAe/D12j3JP3ffpIgf?=
 =?us-ascii?Q?r+54KjxhYS47hRYQyu2AhRuo3bAsQ89wX5MYoY7zh317H0k3IaIpc6OfeI1I?=
 =?us-ascii?Q?wIAovOBq5yVmmXvArhBaBkBN1X9aUtYo6UVqoea4JEy0U1YcLR2lvp1q2LUx?=
 =?us-ascii?Q?CNURi4xfyi4CJoLVRWUXM21k6LQRo4DqmczprujgAA340/0PZfdiM41I3Oli?=
 =?us-ascii?Q?uekqj1UQeRxF9ZKk0Ug4Z91xVQ4Cdzm6xfMszq/0gD9AZgjoVfxndltbE4mz?=
 =?us-ascii?Q?eOsaOCb76oIMT7LPq6FfxPxyFC5q+uTqNH19N4G1omXmciAyaVK6dtNBbBnl?=
 =?us-ascii?Q?EKSMpOVp4xPajFn55e/NG+YNLOYpBb/+3JFwutLu2tkVtOZ/Aei8fD1aYiS1?=
 =?us-ascii?Q?ONCCyubmRmw9e2jf+9a0aPofi1z6UNdkfhgf/vPYL9Axk5qZdu8HhroE1Wpt?=
 =?us-ascii?Q?NsGV9PvGqpm7HfWv0Qf9B+IOeE0TQf4dEZ7u7agKy1yf8psK7UqTdVgoUtu8?=
 =?us-ascii?Q?0/EKSUJ4NXNEdjkoqOcWt85Lqcw0QJzkJ68faDR+t4mHFylbcOVkOnoDx6MD?=
 =?us-ascii?Q?5bOlV9us+kiqfEWlQbS+9A3Fk0zWt0P9s8KPTNIsnkIU4SK2L9vdyXsDKqpx?=
 =?us-ascii?Q?T+0Txv2lMqrhHo237ZEEHkqSzugnk9rXSRACerBmcthldIv+4+7GQg3zlizS?=
 =?us-ascii?Q?TU0kGrPHBd3dCbheokMpwWAhpcqVNRq7zEkk0aEljwQy++Q3I4vF64/S98ZK?=
 =?us-ascii?Q?wRlch9WZtEAv299OV5EeILkXB5xVVOOgDznQm2nv5IC+7YCMcPVAqgBRGonI?=
 =?us-ascii?Q?QeFgc0F4+lMr3s6QDS5r0/8Xpfv43MH9ruAH3YFt0zMquHCD1aCCx6sckbDv?=
 =?us-ascii?Q?ep/Ylp5eZsUMX7TS8m6J9RU8Ndj6cBxxVCwoYAzjccOEPzvXr5jJUduvnwWy?=
 =?us-ascii?Q?0MjAYSD8DBiyIVtdJzuQi+SyuBG+/xtbFhQu08eTQFcQxkTgYneCb7ZbKRdg?=
 =?us-ascii?Q?o2Sxnb1ELFS+c9ifngng7CPSM+VwmFvSM7cFHFjbn9jvH3cG1MaNtJr6EhDs?=
 =?us-ascii?Q?XU7aLgbfG5yPgNqr1LW5oOitqI54MDNnyg8KRToLmj3njdvvrvrChya7o424?=
 =?us-ascii?Q?izRU+ukvZwrVPSV2Re3t2+657hzrFuOUdhdDcSuQFxm4b8I8YX+2KeP+wBtd?=
 =?us-ascii?Q?dZ88TRZAmu4JwEXeDCbKoMVr2TlY6OKZX53EC6KhezEBcmVC1fiwusy2D1sN?=
 =?us-ascii?Q?Xr/iHGajD3AEexQCuXQ46EW1fP8yDVYUpeFEgKQ4dylYFjskfQZ8R/WIO5CH?=
 =?us-ascii?Q?R0XeYsnaKlH4S8kIAtwEAnRHeCc7dki4ee0iQBQC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35234f0e-69a6-4c05-0490-08dc31f1041d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:50:40.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBAJ3enmaG6nJGVD12eglf8oILlwC5k9XvwR17Rxy5zUgz6+axavbXWcb+1GJUgDHMauCoy5JBZar8axG3soGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 07:07:25PM -0800, Sean Christopherson wrote:
> On Wed, Jan 03, 2024, Yan Zhao wrote:
> > This is a v2 for previous series [1] to allow mapping for compound tail
> > pages for IO or PFNMAP mapping.
> > 
> > Compared to v1, this version provides selftest to check functionality in
> > KVM to map memslots for MMIO BARs (VMAs with flag VM_IO | VM_PFNMAP), as
> > requested by Sean in [1].
> 
> Doh.  So I didn't intend for you to have to create a mock device just to be able
> to run a selftest.  I assumed it would be easy-ish to utilize an existing generic
> device.  I take it that's not the case?

The selftest requires a vma with flag (VM_IO | VM_PFNMAP) with non-reserved
pages as backend.

Without a mock device, I don't find a easy way to let the selftest take
effect.
So, I borrowed the way in "tools/testing/selftests/mm/hmm-tests.c" which
uses a mock driver in "lib/test_hmm.c".

