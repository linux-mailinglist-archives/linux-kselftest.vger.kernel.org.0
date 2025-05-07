Return-Path: <linux-kselftest+bounces-32551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7265AAD3F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 05:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC0C3A3D2B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9A139579;
	Wed,  7 May 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Drb+4KTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77978C9C;
	Wed,  7 May 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587915; cv=fail; b=qLK0/CTKE71izpfj0TacrMp1oXz0Zr3oIi6L1peO9H5ts4zQ+CTT+1c32fKlxIm8PlzGJWUYxMgiDz7u9LUmUyEXi9piWMa9/fbzRCO6JJ/eoKoYzXiytxtCbyJZ37LBb9EhjGCqxoo4qm5Hd/wQl4vDuskd1pUCYNWQPOZZZxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587915; c=relaxed/simple;
	bh=2PM87knPRgJbYwf6jT8j8GhoV78O31XlDRL7aGtvXEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZ9tBT4okFYIbEruCELZE9vId7AfxGbmm6n79knlUK3RUr5B67o0Y6OwaPdMUp5+B+gp61zYctbuQKNCBsy6tos3FUbdMN0QPlzDW1HQYsFBmJm5yjdbUuLKJTCyik1qJesarYdAGLrv6Tq3Wl+3QhHyYTwHWmhyluBY5djGQLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Drb+4KTk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746587913; x=1778123913;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=2PM87knPRgJbYwf6jT8j8GhoV78O31XlDRL7aGtvXEk=;
  b=Drb+4KTkU3h7B5oEhyouoFnXC8S1fh+YVHXrwTREb9IUrClqihcxFqSv
   9bJOcdSiGLOVQqjbd4XjvD3g1qYZoczCiXPfZxLBZ0GIcP23K0fCbUOaE
   krwblhl1U9N0XrPHuKn/Z7R64lkStjDbGb1WXZoNjt/DTnYvDOrMEtQjC
   44EbNB1uW9R72K0sCoPzo2sVK5qFbCRbmO1LMu1P16U2883tZFjCJ79Zy
   W954cCqVIRQID53T1UXvKb8qc1x+I+Rp0/WL090eQgiKdrBEs0V4aUCye
   gnm8K7+beOoIo8BCCvNQZfZW4MBI1JQwA1bO8noX9TXFamEeQkOhFrYHz
   Q==;
X-CSE-ConnectionGUID: lTXyXzfwSuWhzwYm9pGkBQ==
X-CSE-MsgGUID: /jZY/mOLSHCMF+A8kS7lLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59649122"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="59649122"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 20:18:32 -0700
X-CSE-ConnectionGUID: 2vOdpGrMSdiUXzHNOOBlug==
X-CSE-MsgGUID: syB6m8nmRTybSvvuiRNpPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140994354"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 20:18:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 20:18:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 20:18:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 20:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr8MeOYn9JtGHrO1NlXMmJjYb5ihzoT+cggAcRsDPyO9ba0dEVepMTNS9XuXps3p6vGf1lyIX0L6Db5R4I5gQHzhVjHqwTvZ/jJ8kGXAEXxdehcA/LK/ClAjcXyoZOcCGn/pXxpOSMhiWrqaEUh6cYS9mRkVaX5IEdnl8Me7jsCI2j7M0Oq3xGsqb57UvOS2o4HEGAkXACwWjpYmENVcFvSe6uKHb0XoK7hNoe3wnkM0YfaBAyjPr7CxKHuqbfQsOmi57l1HYYprxE9/5WWxUdUIjt6cjAmp3nvdUn5A5p6yBYssdg8qfgpcIQOlRGHHVZZSusiOjLisjEGOBfDXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MCAhQUO1QipXb4T704c03MJNrb1G5W6sjduAxWUTR4=;
 b=Dfktq9kBuXl2F5q71rr0eA1kH2ySMe5RLEL1VgtTfAzwMOrz54m/o4mOer9ELEHmxkGnE2MwwYyqUIogCDt5dwqEUnbfnOHdxLSfg8Z5YJvfeYp+hWB6pHh8WuqOdJveOfaqwLPpUKWmyNMog0b65XMzxc+Sa7/hq1JpkYSf59qhZYUQhVFNXG+851qJCIGlij2oy2YO+TrX1OGVG1c+N/MZ+0uixBWPTUnFdZqD3MgEDnlMVVS0/TUABeZLGajsC7s6VRPhbdGTTu1MyKhzQ35jMUw2H2TH73x9JucgKZuk1elA/h0V3Jnlj2M32ScexbbMHcO1FjcdQdKGaIOiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 03:17:52 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 03:17:52 +0000
Date: Wed, 7 May 2025 11:15:44 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <vannapurve@google.com>, <chenyi.qiang@intel.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<jun.miao@intel.com>, <isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<erdemaktas@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aBrQYIyrxhqd+fBO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <aA7UXI0NB7oQQrL2@yzhao56-desk.sh.intel.com>
 <diqz4iy5xvgi.fsf@ackerleytng-ctop.c.googlers.com>
 <aBlkplRxLNojF4m1@yzhao56-desk.sh.intel.com>
 <diqz1pt1sfw8.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqz1pt1sfw8.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH7PR11MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c098166-6eb4-456d-57ba-08dd8d15c07b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DZDvFDeQVzsxdSQkOgp8tvrF/fpUQGoJbVzJhYwwJt1JBrZgFU3m1/7uDjp?=
 =?us-ascii?Q?EqbD7DWVxgSe1jveyy/UcWe71/YF8xSGKO8bVI/UIH5ECAwV5FvK4e598oiM?=
 =?us-ascii?Q?hXpmv4QMyPhLvV5YaXndN5G5/TW/zFnq+wt3pTSuDiK1kJ9pNG0grVRO9fd2?=
 =?us-ascii?Q?wG8DKd1d8FzzrFummG65pCFHFlKfCbTm7FxXgLLbN76guj/FE1/zprb3J/u9?=
 =?us-ascii?Q?4oZgx/DWL9UI1+Bla/13rOck7eU2K3MBHEv3pQccV8eGIPbxiSC/BfpMuKmI?=
 =?us-ascii?Q?sIIz2ef8MyAHAfa/azEAl8a9wv1hpPf+JVBjmAT6cnpw3LRKAaxAF5+i7gEL?=
 =?us-ascii?Q?sdmFjBrHhU+r/u0p4w9OrHLAgPglvDXnBWwJFjmly0qUj6BKLg8VZmFVSUDy?=
 =?us-ascii?Q?BlY2eJGJRKKOUdu+8OrbnsvUmiN0FdKRGhmcO1PMyx6alxx5u7wCos+Z50BS?=
 =?us-ascii?Q?vSh/Ckw7J6ne4r7p6i/ejTr0rc3ZK5RjgdQayD4YLqEU5GcT8lnrCGnbrf5z?=
 =?us-ascii?Q?rS3J6SOtntCJNnbuVyP97PLGJ2g4HAF6Kljq6a0n6ymZpogC7++Vmw8nDtBj?=
 =?us-ascii?Q?zPVMzu/4eFOKLgNgRxyGttgM+JhLOGoP401Z2zp5ueEjZ9OWBqATR/lhX6t/?=
 =?us-ascii?Q?wmEfD76mE/yxDdNaWuMI+SpfzD/DPrVA9wBP/+aO0Ioy04JpnmF9hCQEXD3q?=
 =?us-ascii?Q?6HopEwg5JsrqYR+Cf2zcpaHyGZxOrWX68n2hJ/hX4S77pU38AFW3qHncQhlo?=
 =?us-ascii?Q?PKvd8sbK2WZqRoiWIckW59cwdIXmFWbKE7SKcfsDieCrFmPPUrYWLAyutO8Q?=
 =?us-ascii?Q?P3r8aHcOZYmUU1ZLtEn/ZGBpgGhZyLxgnzmNWVh8GMMQfeI+5/fWpoe2RNiJ?=
 =?us-ascii?Q?7ZiLpTdQ/TvdqW3yEjx5354iRnPvrIFIC6IzhzOdcM9Skh6SLbWSM26n1s1Q?=
 =?us-ascii?Q?xcVc5N0TI3nio10pDJSi03kyz38TBm42GB0sPi0cdA3TiLKt9AjxzXi3hYHG?=
 =?us-ascii?Q?nUvvjp2fhZ25CdOg3B45BdL9f9VB11/znEalYAs+l1AvUxsCWIbqhOd6XRxz?=
 =?us-ascii?Q?UGLBqp8h3O5I//eo1iHQYOP7/M72FrCh6i5uqhLOy2pFcyOij/uTfmLSrTwI?=
 =?us-ascii?Q?xZR/JIf2m8e4GdE0/kfaLvywufHmxg5QZwMwAQPWuJhMxugaZaNxM7XlJ+C4?=
 =?us-ascii?Q?tC3II9gVpRvqqdb0DjsiI3xtTSbtWNe+SWRtHTUFSYdkZuyObtjhDxluU1JC?=
 =?us-ascii?Q?JMISUGvP6ZX0KVErttOhB1/FRkJqSE4t3glwdXU9k3xQYChw98YYCYmL5p6i?=
 =?us-ascii?Q?WC7Lnjok4EZ3rts8KT8i0kzedU/c3zJ2FSyHR50i3fGMxQfqzn9efWpk7pcH?=
 =?us-ascii?Q?OxrAF7OK1jtzsixv5AjeNyR9UtFN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8NtwTaN8TUMpiHlCNn3G+OV8fXM+RJzLU5/kU9a8iyqXIUsWmOMaBUL4Cje?=
 =?us-ascii?Q?2O+UnDt1V89SMOlEeV0MYAd1NrpspWRhENWylNHSWAe1bC6opt5PRosK8W/k?=
 =?us-ascii?Q?LeSP3jTwoFvbM3SRgLpWJb36+P4y8oeP140utodMvWhqZ4bzub/tSePc8XOO?=
 =?us-ascii?Q?gJpwhT0BhFQsP5ZQwyXFpcnpRryAsze+ajcrM6zFEGx2INyOMQc/QGftRz7H?=
 =?us-ascii?Q?D0QHzbTLEwqMoqAAOQ+WMMrzMjHe5sWkbisPcs9jELgm662uwJ68mEdxP+Dp?=
 =?us-ascii?Q?TK/wZ9OMUEfvmU//fSUjvomUQOGIzQ+2vvCNggRaWsw2OkmSqEz15HwdFaFp?=
 =?us-ascii?Q?m76S0VSPV2ZT8FXvJ+KSwACwz6GmKOUc3l8KevoWwhanNX+Kf5xQ0Zaf1F5i?=
 =?us-ascii?Q?0osMFGkk8ZBX0kOPF9/AcNVxyFLkSySlY0P0vsFrEs+Ljw0IykO1H0vXWqnd?=
 =?us-ascii?Q?3lj9uIV9Ez6n1Ba90OCAsvwnw5/vDMwAg5o6KuE6KDWuhumTFeIMBZNi1chl?=
 =?us-ascii?Q?OS/IY57806bIga7QiDYVd3lIJcyUekIZtdKCt5/HP3pKLZX+qUEa/Gdm1xhO?=
 =?us-ascii?Q?8DeZtph2urkJnfTSU3ZhwnYEXz8OSHvCSwM3CSxJwJV7CsDF78TDkbJNuGBs?=
 =?us-ascii?Q?78q6t1NdBLhsVkGOFzVsQ6ewFcx6lCdntGM1BvuYIYVLAxrIVTSdubhjIlaC?=
 =?us-ascii?Q?kIAPyYRQhiRN5nGfcIr/jxFuFa+t+Bfpqne6AyFN+y9GgU2um8SyxBdrpJNs?=
 =?us-ascii?Q?K2uWLLsqDotYvEMdsmKqBnufsRIMnRemulvYppNykuStw57wTVluZyUux7bO?=
 =?us-ascii?Q?93t4J6viYxthXwcpjqj8ae6r6xROUpu2E5LfZSkf4EiXTPz+tf10jqzg38tO?=
 =?us-ascii?Q?8c6f59DGDCvaIeXkIUdL8xuJMCUnOK66hu+pIcwvZPlbhWa9MSHoundjfvx6?=
 =?us-ascii?Q?Wq4qABC+swNRU0MIxxidHdvLj0X2g46zlmzp0h3iOTpoRipihNIZFdfEhigO?=
 =?us-ascii?Q?FrLhrDNY+TaizDGSfqQbqxDblrORyVQeNedfLSestV/mYydeM/FIG4sKk0WB?=
 =?us-ascii?Q?3dYhRQEOl37GkB4qwKpEXsWcVTcjDHH2HTTTTXn64kl/WHmk/9DS6g/81KcW?=
 =?us-ascii?Q?DPjhxOvilICVOLpqJvZ7D8yl4vX7kHr8/lqoje4WXWssEAtuZJzr21AtOM+o?=
 =?us-ascii?Q?ekZQNB9UShkdoIozNutuBVJYh57PmI0oTdMLnI03GRAo8MF+KhvLqliPrWwq?=
 =?us-ascii?Q?IiBEzA1lOkXTM32gL0M2ihCr1Wy3GmzzjU0CiAkjnceh2e3lOKLEjPXi9tGM?=
 =?us-ascii?Q?sjFwI7TTkT93IqQuuTI65eTWexgLkkaNBPaGvwrclboW0xIuaaPT0CHTXawa?=
 =?us-ascii?Q?azD7vJ7npQYLgpWr1ktcarKwUFatJgrlUmMC8UByIunz3MSGc56rgPskOlTG?=
 =?us-ascii?Q?YzTCPvigzgJg763meat+aK1Wxm93t0S+XCPA9qB7S+SyDn4c/EUx5o+I1ss8?=
 =?us-ascii?Q?FQC/4maFWb6Xe2YGh52gu+lkxBpwZKe65jDp9KRZ4guPKzkQ0SJ1qsCcFd6n?=
 =?us-ascii?Q?L6XL96rRT6/b+32MDb/Un1sctkN+hB1V/buuYGLt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c098166-6eb4-456d-57ba-08dd8d15c07b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 03:17:52.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0KwSNibL4Jr+1jQ8Zu9ZOjn0h1Zz6iI8zKaJJOCy7kABhLUxfqq69B63UVNBx/+wgrxbiTmIW4Lo1iXUo7zaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

On Tue, May 06, 2025 at 12:22:47PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> >> > <snip>
> >> >
> >> > What options does userspace have in this scenario?
> >> > It can't reduce the flag to KVM_GUEST_MEMFD_HUGE_2MB. Adjusting the gmem.pgoff
> >> > isn't ideal either.
> >> >
> >> > What about something similar as below?
> >> >
> >> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> > index d2feacd14786..87c33704a748 100644
> >> > --- a/virt/kvm/guest_memfd.c
> >> > +++ b/virt/kvm/guest_memfd.c
> >> > @@ -1842,8 +1842,16 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
> >> >         }
> >> >
> >> >         *pfn = folio_file_pfn(folio, index);
> >> > -       if (max_order)
> >> > -               *max_order = folio_order(folio);
> >> > +       if (max_order) {
> >> > +               int order;
> >> > +
> >> > +               order = folio_order(folio);
> >> > +
> >> > +               while (order > 0 && ((slot->base_gfn ^ slot->gmem.pgoff) & ((1 << order) - 1)))
> >> > +                       order--;
> >> > +
> >> > +               *max_order = order;
> >> > +       }
> >> >
> >> >         *is_prepared = folio_test_uptodate(folio);
> >> >         return folio;
> >> >
> >> 
> >> Vishal was wondering how this is working before guest_memfd was
> >> introduced, for other backing memory like HugeTLB.
> >> 
> >> I then poked around and found this [1]. I will be adding a similar check
> >> for any slot where kvm_slot_can_be_private(slot).
> >>
> >> Yan, that should work, right?
> > No, I don't think the checking of ugfn [1] should work.
> >
> > 1. Even for slots bound to in-place-conversion guest_memfd (i.e. shared memory
> > are allocated from guest_memfd), the slot->userspace_addr does not necessarily
> > have the same offset as slot->gmem.pgoff. Even if we audit the offset in
> > kvm_gmem_bind(), userspace could invoke munmap() and mmap() afterwards, causing
> > slot->userspace_addr to point to a different offset.
> >
> > 2. for slots bound to guest_memfd that do not support in-place-conversion,
> > shared memory is allocated from a different backend. Therefore, checking
> > "slot->base_gfn ^ slot->gmem.pgoff" is required for private memory. The check is
> > currently absent because guest_memfd supports 4K only.
> >
> >
> 
> Let me clarify, I meant these changes:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4b64ab3..d0dccf1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12938,6 +12938,11 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
>         return 0;
>  }
>  
> +static inline bool kvm_is_level_aligned(u64 value, int level)
> +{
> +       return IS_ALIGNED(value, KVM_PAGES_PER_HPAGE(level));
> +}
> +
>  static int kvm_alloc_memslot_metadata(struct kvm *kvm,
>                                       struct kvm_memory_slot *slot)
>  {
> @@ -12971,16 +12976,20 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
>  
>                 slot->arch.lpage_info[i - 1] = linfo;
>  
> -               if (slot->base_gfn & (KVM_PAGES_PER_HPAGE(level) - 1))
> +               if (!kvm_is_level_aligned(slot->base_gfn, level))
>                         linfo[0].disallow_lpage = 1;
> -               if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
> +               if (!kvm_is_level_aligned(slot->base_gfn + npages, level))
>                         linfo[lpages - 1].disallow_lpage = 1;
>                 ugfn = slot->userspace_addr >> PAGE_SHIFT;
>                 /*
> -                * If the gfn and userspace address are not aligned wrt each
> -                * other, disable large page support for this slot.
> +                * If the gfn and userspace address are not aligned or if gfn
> +                * and guest_memfd offset are not aligned wrt each other,
> +                * disable large page support for this slot.
>                  */
> -               if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1)) {
> +               if (!kvm_is_level_aligned(slot->base_gfn ^ ugfn, level) ||
> +                   (kvm_slot_can_be_private(slot) &&
> +                    !kvm_is_level_aligned(slot->base_gfn ^ slot->gmem.pgoff,
> +                                          level))) {
>                         unsigned long j;
>  
>                         for (j = 0; j < lpages; ++j)
> 
> This does not rely on the ugfn check, but adds a similar check for gmem.pgoff.
In the case of shared memory is not allocated from guest_memfd, (e.g. with the
current upstream code), the checking of gmem.pgoff here will disallow huge page
of shared memory even if "slot->base_gfn ^ ugfn" is aligned.

> I think this should take care of case (1.), for guest_memfds going to be
> used for both shared and private memory. Userspace can't update
> slot->userspace_addr, since guest_memfd memslots cannot be updated and
> can only be deleted.
> 
> If userspace re-uses slot->userspace_addr for some other memory address
> without deleting and re-adding a memslot,
> 
> + KVM's access to memory should still be fine, since after the recent
>   discussion at guest_memfd upstream call, KVM's guest faults will
>   always go via fd+offset and KVM's access won't be disrupted
>   there. Whatever checking done at memslot binding time will still be
>   valid.
Could the offset of shared memory and offset of private memory be different if
userspace re-uses slot->userspace_addr without deleting and re-adding a memslot?

Then though the two offsets are validated as equal in kvm_gmem_bind(), they may
differ later on.

> + Host's access and other accesses (e.g. instruction emulation, which
>   uses slot->userspace_addr) to guest memory will be broken, but I think
>   there's nothing protecting against that. The same breakage would
>   happen for non-guest_memfd memslot.
Why is host access broken in non-guest_memfd case?
The HVA is still a valid one in QEMU's mmap-ed address space.

> p.s. I will be adding the validation as you suggested [1], though that
> shouldn't make a difference here, since the above check directly
> validates against gmem.pgoff.
> 
> Regarding 2., checking this checks against gmem.pgoff and should handle
> that as well.
> 
> [1] https://lore.kernel.org/all/aBnMp26iWWhUrsVf@yzhao56-desk.sh.intel.com/
> 
> I prefer checking at binding time because it aligns with the ugfn check
> that is already there, and avoids having to check at every fault.
> 
> >> [1] https://github.com/torvalds/linux/blob/b6ea1680d0ac0e45157a819c41b46565f4616186/arch/x86/kvm/x86.c#L12996
> >> 
> >> >> >> Adding checks at binding time will allow hugepage-unaligned offsets (to
> >> >> >> be at parity with non-guest_memfd backing memory) but still fix this
> >> >> >> issue.
> >> >> >> 
> >> >> >> lpage_info will make sure that ranges near the bounds will be
> >> >> >> fragmented, but the hugepages in the middle will still be mappable as
> >> >> >> hugepages.
> >> >> >> 
> >> >> >> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/binding-must-have-same-alignment.svg

