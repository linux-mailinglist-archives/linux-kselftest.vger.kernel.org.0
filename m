Return-Path: <linux-kselftest+bounces-9432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50E8BB507
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054DDB20FD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143CA2C190;
	Fri,  3 May 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAtIJOfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEED28DC9;
	Fri,  3 May 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769191; cv=fail; b=uv/RMxvUotbrMj2VhUADcEz67y1E06EC20t5WuUVcXkIMWdxd5Mfus3laQN9E5n6nlAEd5I1U/bkqJaM7bh24BPBIHUyZdwjUtzf1xKa+ChjKuCZFeH+srAorHjiGMQhUgPjhJIv2VAOreCfAUD/fEr0uSWEbbasDhpKfnjNluM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769191; c=relaxed/simple;
	bh=ZXpH7wUqOqFpygugdVj4Bb4S6oL10ZpLVAwPUagvVyg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvCPOseN0nmi+WSoaHRvoxbJndBsNNebT70B4UxGiQbHGLbjlIpyzApmFb8cVPsD8oysrM21LAZqDb+9EM+++PUI/DxaBazGd/cO/oP2EQRlnNg6abWV3/mJNuy2qZY/jmwr41MrjcVzNg3e6EJO+CEpevRjthMiMupqVYdHyjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAtIJOfn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714769189; x=1746305189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXpH7wUqOqFpygugdVj4Bb4S6oL10ZpLVAwPUagvVyg=;
  b=KAtIJOfnXDQdj/9X5mhEsVOXXfzRNBfbVLeB6tExXuIomLuTXOY/4ywo
   uOYlQks+PU5TgaqdrOnaCUy5ono72FXmYR0GsuMmvn/laDMMMWi2ILBMQ
   h95J1PDfvJInp7LVLhnkw9m89w5yWdMgihgaeNMhoUxTlxj8Tcj5RxFRx
   EQb1HSxpRjKLEThQjHEEPbl0cT0lZ1SESH2P26TskxdXSGn/e0MenvF/X
   UrR0rKUT45xpqoGG74hFgLgEK5b1iMMszpH0KQR56ssCuaL8FQVZjt5jO
   sKC2Ou9wVMaNYbumHdvvcqFglTKKPF8V7GbYnZnq4tH7P05A0OTCv4m9J
   Q==;
X-CSE-ConnectionGUID: WJm93V0FStmCZXYHLU/HIw==
X-CSE-MsgGUID: a6JKX50OT1ah5xcwAf1STw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10718628"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10718628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:46:28 -0700
X-CSE-ConnectionGUID: S5+nCdzOS7eKKQwmpto90g==
X-CSE-MsgGUID: jFb2mKXXRV2DfWToNzWi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27962602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 13:46:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 13:46:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 13:46:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 13:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipcef/qusVtAQ9K7FleTwIjWz3GJy0M8lvP4Srcos7rCU+DsatmACJyUD6Su/0bznfDh18p94Z+33uUmEBhWEIPSVLWWska03+D4zCN7gPI4CZ0bqf8RS6PjGQxjjXv1dEEcbP9CisyZU82EZ4ruhWFKwMwoElxQ5v6IHI2uLwuN4LM4RHQSU+TJyb2x51CtUE0c8sfIhQM2WF3k5TfZ6AgaybW6WVmBjUf86Ld1UA74ZxZiBMXcihGm89ZxVEa7Zywg7kpZ1NUOL2jjUP8bUPo+FLN1t323vihdd9Uua/s91D3VW8U60n7pnRCCkkyhrrcXcqmap+4mf52An5E1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWuDh1BMdBzAw6pMVdl7Rr+jKBCSLa8eLBs9dnZZtIw=;
 b=P51FAx0lGZxaNJfXDSS1zhICDf3P62GEpk+XKlriecPSwx0dLvOcpgBOSubt9qlhElywa9CCnSywUoaNm8tCwlwoIC0dygxV6aFwvt3dwIatp3bpin2YYxWEEKj8alua7NqjjY3KVOAjKRC1zEfN3cffvkzHn+6vkVp6FMREAvqW4C0QolVGeQ/vdXFpe4acNhj9qPPwTG6+nAsIzDiENnZU5bnkHYFwe+ERSwiIdQFsg4CBTrqKvajmZyJWuC15e9ShUDRw6ZKY4Tfj+0vCeM8htexNx68mZ80/BNa/wdO60CVv40hpSVUTJwsgOck/n3UeuZv+IrA9xq1z5U8afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8499.namprd11.prod.outlook.com (2603:10b6:a03:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 20:46:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 20:46:25 +0000
Message-ID: <46a6019c-b029-4764-8c66-ad61f4191716@intel.com>
Date: Fri, 3 May 2024 13:46:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240503023209.80787-1-jhubbard@nvidia.com>
 <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
 <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
 <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
 <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 16923af6-ad80-4d14-f7f8-08dc6bb21943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzU5OXI1ZU5vSnVkbkZFaU0ycVNVVWcwc1pibnJYYlhEUEVDSXFrRDNnaDVV?=
 =?utf-8?B?WjFTK1BlNURUSUJYOElpVTNpaWs3eWh2WXVTR205RHpuWUtKOThsYmZJWExl?=
 =?utf-8?B?a2kwdGswdzdpOStsS3dYZWVtN0UyMUtLdzZxZGVHQXkvbGdqdXRuMGhlWVhq?=
 =?utf-8?B?dTljajdXZFpxOHY3bExLUC83QzVUblh6dDJpSDV2dHhMNnZnd3MyS2QwQ1gx?=
 =?utf-8?B?T2FXZkRwa1JxNVNYd3JvaWV0VEw4MXhkVVZJT0pONGhmcmRlUUFHc1AyUTNU?=
 =?utf-8?B?bUlFNzhMd0taNTFLMTgrYnNFK2h3MkN1NDdhSTJKV0QxVzJERi8yYWExandk?=
 =?utf-8?B?MGFnbG1KekxvZGpldVZYL1B5Z25FcFhSSi93K0Q1VUMrN0FsQlhlUHRrV1Fn?=
 =?utf-8?B?UnBOQ25wNGMreDYrSjVhZUFLWDlpQWc4ZksrNXN3ZWszaUUyTXI2SFA3b2VE?=
 =?utf-8?B?bi9iS3FkTmFEcEp2Q0VEYmpJU0JBZ0pXMUlZc25HMnJCd3dSQXFvSW1hNXN3?=
 =?utf-8?B?a21xSlFneTZWN1lqRzdxNHhlSmRDNW9iaVhnY1FFS2QyQ0hqOVRrTEVtZVlJ?=
 =?utf-8?B?T0NuSTNaeGJGQnowbHhTZlIzVlhRK21RK0RIbytRbFNFd1B0cThKNFBPQW1B?=
 =?utf-8?B?b0NaT2xFdGZNN3U1ZGhsWWhWT0xPdlg1MFNuSXluZytiejQwb3A3S2cxZERi?=
 =?utf-8?B?R3gwMW9aQVBzVFc1V3dkSE9ha2ZYVVNTeHJtSVdpdDlWeURLbkpDNDRqQ21P?=
 =?utf-8?B?VWlZaEpMNHBDTjd4MWNucnhKeStIK1FpMjM2VitPNkE1elA0M1NhdzhuUldr?=
 =?utf-8?B?cEsrVytJZm5LTzZVU1hCb0gyZC9rQ3pwSk1WQURnZG1jMzVmRUxDTGZQYk5I?=
 =?utf-8?B?VmpFN09lWlBzYVZMcWduenYveUlVY1dUKzFySlF3a3ZuUTNIWldBZ1VLYmhI?=
 =?utf-8?B?QWlSS2t2TkovUElLRW1Yb2w0YW14UHBvYlQya1B4ZXVoMWZ1UU9SN2plRi82?=
 =?utf-8?B?aVdDVzhRZTJDejcxemtBQmVNSWVhdjlqN2wxZ3B3YldEL2ZsNlBwVlZaaFFB?=
 =?utf-8?B?aUZPQmxBaTRlMnJnL2VlM2V4SytMVGRpTEdSZWp5MWp4bldxbndTR2FXcDZu?=
 =?utf-8?B?OWV3eHZMV2RaRDV6TytHYkVOYXF4T3lnT0RtWk1wQUVkcmNxZXg1UnJjTWJ0?=
 =?utf-8?B?cUxPRjFHT3ZGRXIraG1aanRkWVgvUVBaMjFmd3h6WjUzZXJrQmNmRnNtOFVD?=
 =?utf-8?B?aGZiNzFiMTg4U29uZTVaMCtTZGRQWjlpdTdpUksyS1QyOW5tQXNVTlFUZFln?=
 =?utf-8?B?S2dHY2JGTEpZY0tvbnB2bDhTUXpTTUhlMDYxVWJ2eHNVRFQ1aXZjVS95bU16?=
 =?utf-8?B?ZHFKblZ0MWdPamR4SUNJMWdWZlI5VHVySUd6ZDBMekNFMmRpelZJVERXME8x?=
 =?utf-8?B?bWh3WWdzSks4NFBtNERFS3loWjFQSG1iczYxV0VNNlRsQnl4QVZBSEVXV2xY?=
 =?utf-8?B?N1E1czZabHNqa0xOYkM5TW9HeVIrRGNpMTg0OHA4amhrOFpOeHkrTTN0eFBt?=
 =?utf-8?B?SDRrbitkUU0wbm1lZ1M1K1BNSjBUcms4RFZMZmVXOEtYOUdFT013clBQdEkw?=
 =?utf-8?B?S29SUGZmcXBEdlFNNU85K0hNZHU2Vnhqc0VFK2VldjEycWJQOW1SWkdQUXhq?=
 =?utf-8?B?eEMwU3pyQkxKOWRUR2o2TTBvTzMzUitnaGhoOFQ0YXpBUU8yYlJabnV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTl2eDV2aHRLM0p2M2VTYjJCMFFSWG9KMDVBaktpakhEYzBkci9nQ2lMMnFP?=
 =?utf-8?B?ZWxFYXBuYTVCS251MjkyMURVSkFjSUhkTlM0amE1R3UwelVyRVllbmFlbTBh?=
 =?utf-8?B?Q2pRV0gyLzlSNm9KbFdNTmVoZ0tFcERUdTN1SXhJWlMyNUY2aGxsRmpBS3VR?=
 =?utf-8?B?akZ4VnU5U3h2amV1dWQ2Zk50cFlkMEx5M2FjUW5hL1VTeGRoSm05WkE4V040?=
 =?utf-8?B?M1AyeWRWT0VpWG01eFhMeTlxbEx5TU5PLy9UNUZEOHBLZmVoWFlXZnhYYVFQ?=
 =?utf-8?B?Rmcza3hlUGZId2lsU3FPdEVSU2s4TWdpRlRETU0zSjRLMG9LM1lXYjVRSUtI?=
 =?utf-8?B?ZkcrcERHN1QvWkl1WTZwYStlUGNlVU4rU3pHaDU2ZHlHUG11emI2UkpyR1FL?=
 =?utf-8?B?b2FrZHg5cU94ajRGWmdlaTZNay9SUldJR3A1UFRDdXlrZ1dQNWlrc3pOOWpU?=
 =?utf-8?B?NDBBdUZwWnZlWEJKT1pvemRNUmUzV0RCRGRLUDU3MjB0dU1VMmluQ3Jrem41?=
 =?utf-8?B?NWpjZ05wMmo4TElSY05sNVcwbncyRFhzVzBzYkRFT2hqMElWcWw0ZUFqbTF2?=
 =?utf-8?B?bno3NGNzdFhwMmI5WUxtMjhnK21yRTNub2h0MjFkVyttNXoxajRTd2FYdkJz?=
 =?utf-8?B?N1o4WG9xZjlMYTI2TnMydklIUjBKQzRnclR4aFZpS0VRb2F3ZkM4WVRSc0sx?=
 =?utf-8?B?aGJva0s5Syt2VWdGNFRaY05IZHp0V1Zuam5XYWQrQkF1WXNUc3NxTE9XcGVO?=
 =?utf-8?B?U01ldFFOZnRIL3FxN1NjRG5tbEoxcFU2KzVML0RqS08rTE5ST2NnYi9qa0NG?=
 =?utf-8?B?eXhDWUkzeWlqVGhMVElsQlR0REVuT1ErYVdzaU1mcEplQkMxNTJKR3FaQjYr?=
 =?utf-8?B?cjd5OS9ndkRjbHJIdi9oNDQxdUh4UUVuU0ZKYkpOSjJGai9TOFMwZG9UL0xU?=
 =?utf-8?B?bHFLWEFhQmc4WDJrS3hpZjdYQkUrZWxFdmpSeGh2dHR4NGxrWm5jTld2bDVh?=
 =?utf-8?B?blVwT2FDQ1JKbFpUNXNtTUJJUUNPVGZSeUNaaVY2bDNnTWhITGJDWkRmS3Bx?=
 =?utf-8?B?WVJFK1VtZ0gyL1VBMko1NEN2MDdRcGdoU2plZmRFeGYxWUVyZzA5UzZJS1N2?=
 =?utf-8?B?K3MwbXNyYUh4MzgvZ0I5Y0ZXYXFkcVdCdFhWeDVPRU1kVXZuNlVBS1RhY3o0?=
 =?utf-8?B?QWlGMWwxL1Fac3J6V0NQNHlqNkpnVE5KSllhRVQ2bU1yMm1VQ01IQk5JMG05?=
 =?utf-8?B?V28xc1RpcGVsL2lVK2ZPNUd4UTcxYUswSmwySnluOGwzcjNTZEEwMjFLL1pP?=
 =?utf-8?B?b1pFanBtQllrUlFKaE8ycWZLR2pCdlBJbTNVYlpVeEpvQTVwS0NkdURoL2tt?=
 =?utf-8?B?T0puMG5XbzZiTjdSM3RIY2ZzbHVBNnVFL1pOdFIySnltVjk3LzFmRFBZVjIx?=
 =?utf-8?B?ZkV0bzE4N1ZjcXRwYlhya1BjMmFQdWI5WnNERHdoT1MxZkthdXVDelRiVnVz?=
 =?utf-8?B?TGpUZXlFZUNxc2lTNmI1UStreVgyM2tRRjVUakpBcFo0NGEvbzR2dTN0M3Rk?=
 =?utf-8?B?TUI2aTR2YW1uaXMvV0hMeWg3VlpLSEw0NmxWYnAwMnBNc1FvU2htT2JsQnhB?=
 =?utf-8?B?RWxPbUVncUI4ZmNVcmhrOXhOREhhRE55WDNZRzhsVmY1N1MvdEJwWm5MUHpX?=
 =?utf-8?B?UmF2SENlNlR1YnQ2eGJTL1k2bEtiM29ONGRJNEhhSHdJTWpubS9lenQyL3BS?=
 =?utf-8?B?WGk1MVI0TWZ0d1UzUUV3Zk1aSzd6VGtqSDhzSlBZa3p6T0tNcVRwU2hMQ0ta?=
 =?utf-8?B?M3lFbnFZYitOa2Q0RTFTVEE3SGdxdUs5ZUxwc0xGUTBsQjZVMS9YaGNjb3J5?=
 =?utf-8?B?emZtZzRzL3JaWUZyeGF5K2lwNHc0UGRUTE5IREhLNWxkSVNsQWIzNTh4MGJs?=
 =?utf-8?B?YnlnemxLU1JxS1BDR2luUFM5enBuemFYeGlZQWUzWlpjUkJUekc3ZXNKSTRS?=
 =?utf-8?B?bTZERTYyVEhjNUNXaG5WaWo0TkVLaEorWWhOclB5UG9wcmkvdnQ0VUMyVWdz?=
 =?utf-8?B?QVZOTEpMQ2NYVjBHMkU5V0Jhc0ZEdS9uTWJSb2dkQkJyZkFDRVJNZTFiWC9z?=
 =?utf-8?B?dU1wNngwazNGS2JBTjVwaW0wVWpRb1JrWDZrdEEzOUN5N2oyd1N1YzYzdVJx?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16923af6-ad80-4d14-f7f8-08dc6bb21943
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:46:25.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bzP8iUNs/CJYR3f2EsSbLGN/wg2YAqaZFMhrIKuhn7EideXeRH+uaq40FdBDwukjMpSGkvBxQ4WMKP8QX34zKhO4farZWSVl0+0QVQvX/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8499
X-OriginatorOrg: intel.com

Hi John,

On 5/3/2024 12:12 PM, John Hubbard wrote:
> On 5/3/24 11:37 AM, Reinette Chatre wrote:
>> On 5/3/2024 9:52 AM, John Hubbard wrote:
>>> On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
>>>> On Thu, 2 May 2024, John Hubbard wrote:
>>> ...
>>>>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>>>>> index d67ffa3ec63a..c873793d016d 100644
>>>>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>>>>> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>>>>          avg_bw_imc = sum_bw_imc / 4;
>>>>>        avg_bw_resc = sum_bw_resc / 4;
>>>>> -    avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>>> +    avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>>>        avg_diff_per = (int)(avg_diff * 100);
>>>>>          ret = avg_diff_per > MAX_DIFF_PERCENT;
>>>>
>>>> But how are these two cases same after your change when you ended up
>>>> removing taking the absolute value entirely?
>>>
>>> All of the arguments are unsigned integers, so all arithmetic results
>>> are interpreted as unsigned, so taking the absolute value of that is
>>> always a no-op.
>>
>> It does not seem as though clang can see when values have been casted.
>> I tried to do so explicitly with a:
>>       avg_diff = labs((long)avg_bw_resc - avg_bw_imc) / (float)avg_bw_imc;
> 
> The subtraction result will get promoted to an unsigned long, before being
> passed into labs(3).
> 
>>
>> But that still triggers:
>> warning: taking the absolute value of unsigned type 'unsigned long' has no effect [-Wabsolute-value]
> 
> As expected, yes.
> 
>>
>> Looks like we may need to be more explicit types and not rely on casting so much
>> to make the compiler happy.
>>
> 
> I assumed that this code did not expect to handle negative numbers,
> because it is using unsigned math throughout.
> 
> If you do expect it to handle cases where, for example, this happens:
> 
>    avg_bw_imc > avg_bw_resc

The existing code seems to handle this ok. A sample program with this
scenario comparing existing computation with your first proposal is
below:

#include <stdio.h>
#include <stdlib.h>

void main(void) {
	unsigned long avg_bw_resc = 20000;
	unsigned long avg_bw_imc = 40000;
	float avg_diff;

	/* Existing code */
	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
	printf("Existing code: avg_diff = %f\n", avg_diff);

	/* Original proposed fix */
	avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
	printf("Original proposed fix: avg_diff = %f\n", avg_diff);
}

output:
Existing code: avg_diff = 0.500000
Original proposed fix: avg_diff = 461168590192640.000000

> 
> ...then a proper solution is easy, and looks like this:
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index c873793d016d..b87f91a41494 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -17,8 +17,8 @@
>  static int
>  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  {
> -       unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
> -       unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> +       long avg_bw_imc = 0, avg_bw_resc = 0;
> +       long sum_bw_imc = 0, sum_bw_resc = 0;
>         int runs, ret, avg_diff_per;
>         float avg_diff = 0;
> 
> Should I resend the patch with that approach?

ok. That indeed makes the computations easier to understand. I assume
you intend to fix the snippet in mba_test.c also?

Reinette

