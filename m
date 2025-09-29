Return-Path: <linux-kselftest+bounces-42579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71832BA99CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35C41921C2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33130B506;
	Mon, 29 Sep 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R69Qo/Fk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833730AD1A;
	Mon, 29 Sep 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156712; cv=fail; b=VsLJx1rD7lNL2C0Bin1n7rNp20592vF2B4+Dxy6SZVSRofMvHHWDxapG9bbzzRVX8x1VFHMtiUIfkhvQDU7Dx71NE0iGHQugvv4yA5Gq0mDGVsHnnOkZX7kYpxWNLaAGB1QMRKEnYfqaTh6jLFtlrGFTttT8lHXVDBqprVMprNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156712; c=relaxed/simple;
	bh=OnujSwQExvT05vReZiFxFJ/SA4oPab8yWzuEZ9gLY4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7GkZyP/vZayFMstbaCDD+1JvnXFzhcKy7zj68x2O/zgpXcMBxuq+a96NsqYTOwRzBAuOHejZ2HI9Mx7l+xhhnPy3y4GodJQkijjfJlVEFXyOfAmacAYh86F/dvJ/inGLqRoEwwDiIy5WsGGUBSeyRLW0t2wgc0NZSdbLY0Qx3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R69Qo/Fk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759156711; x=1790692711;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OnujSwQExvT05vReZiFxFJ/SA4oPab8yWzuEZ9gLY4c=;
  b=R69Qo/FkcZZ8hDZXAlPcXjpJtJdxay4r6gWgqKVzFsTUt1YnurxFW7Je
   QF+62zq/i1Yj1k1aFRmKtW8zbAA3AvchJk1UR5ogOeEuSGvO1kE1rVK6B
   tkSoMkJxsVcPJd7+/JbZ6UDdgeBwSi1ulX+3thGrjh12F8q2oB0xaAZFM
   IgKMV6W2nyeR+RveoZlzca6a1jQn1LaJFejcJgVr1MGrZJIVYwla5XpSh
   i2U0aYTzBuzLmb3hajeCP0F56xFo9Qnpwhs3et06a2mfaeIn2l0a4ngzY
   6k1P42xCmtmSTcmCaJ5MIsGMewNQkaKzoNCiNaDO6jd13XHJs9lfc8dZN
   Q==;
X-CSE-ConnectionGUID: BJ3MBFsETgqdUomE5T14EA==
X-CSE-MsgGUID: CBCtYgkBT/Ogj2Mgg1BAIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60432452"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="60432452"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 07:38:28 -0700
X-CSE-ConnectionGUID: ERSjiSOCRtOpCuBXo9ZaAQ==
X-CSE-MsgGUID: 2YDWkkC/QnKopvuTvKF+Gw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 07:38:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 07:37:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 07:37:53 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 07:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnsxoKcWGJYquoeZu7uM4ZUZZm++s8JRjG5zMUD4yn7vkBICcEFPWMoWStKRaT6yxyVtxbXAZuhzGZEyxxgci096DhH6rnufWiL6BrM+zaOrEaXMpinYyLqz6pd1Yb4htAahkj1L1PfHPqPXnPxG763lXnQlSoHiKpqpQXpV/UKr49AGLCwZSK83yPQZDgGv8Q6d7ndG0jzVLkPz0AV3b3obgBnZbQIvbNHXIHIozN8PlzjfZHw3l6LsczN+Ibk7xvKT49fbXLhYBkCw0JpP7WijESO1LyfsjMFadywfDna+UDtEybFZB6ZzQIwi0ZD1U399JStxN9ufIvOvCiWPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ5EEsIbNntn63b+WdvkuCfNtl3F4YwjJ9bADZXgx+I=;
 b=Nmdl6/51y8xT60qr+hdy5g9J7dgum+3fGK4uaFhn58GEGnJiNs9hc04RxXaa902K/GD2kbU6Hw4BZc+EfNhQpfSGQXXQWdIizMmmcVwse2er4EqaDyWOu6rD+Sg/gJ2f8qz0oqRstBZmrxzJFHjv94BX+6EhBmUuQVmQ4C89hssYJhJXQSYBttYrv4/BKIbPfTMuyVP53Kg9kXgiMtlMKLCiKj/bIrz0ff4uFj6TDm+PGP+5nJPAvt6Ll+Scz8JAAoinH6pMCOOFfP+Xw76ZDpEd24TSRMNJ7P6dOxpZzXRKu88AkImH5NvgUEV0YSnf+BzOVOHXdFAZYLWIWzp6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 14:37:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 14:37:46 +0000
Date: Mon, 29 Sep 2025 16:37:37 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development
	<netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
Message-ID: <aNqZsZAbqNieTkjS@boxer>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com>
 <aNVEiTJywHNJeEzL@boxer>
 <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
 <aNZ9VWLgNGHQg1Tv@boxer>
 <CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com>
 <4c4edfc4-f69e-43d3-8bb7-95d00bad45c5@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c4edfc4-f69e-43d3-8bb7-95d00bad45c5@bootlin.com>
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f7e8ff-5a73-413e-5f9f-08ddff65c186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dTV3F3Qkp0bDRxMTRKRngxVkcrSDl3SDFZekcrNVJmcHVVTmdES1VVMVRE?=
 =?utf-8?B?ak1BZUh5bTJMYnBzdG9VNVcyaWp3WmRoMEx1bVBvQ2lwcTVSRFhzQXRTdG4y?=
 =?utf-8?B?N3Q4ZzVZVXpFZHdhb3J5azFKb2NpZHNnTWxTSVdTY2dWNUMvSHo2ZndEV3FD?=
 =?utf-8?B?cCtoeEhtTktJSU1aUlNSMXpyR2hkbjFiaXpOTVc2Zi9wdXJIUFRIWDg1Zkw3?=
 =?utf-8?B?Q3pUNWt4OHhjTCtmSGxXalFMZVlFdSthZnAzYkVla3J6cVp0OHAxMWNZYUhz?=
 =?utf-8?B?eXFGTDZRNlNuQXhFUXBYWDdaRW5WSWpTVEZ6S1dCOFFsQjJQLzBjc0ZGWkZP?=
 =?utf-8?B?ZTd0WEFBcGYwa1hYL2xReERTeCs5c0Z6SlIwdHE0akoxL3NNclA2UDkvaCs1?=
 =?utf-8?B?aGlINHduSHFkK3BTQkZYQjNUalBlajl4NExEZlBWb3VGMzQvVGVZTVIzYWQ5?=
 =?utf-8?B?bVJKOUw4TkRSV29JOFV4T1VJLzdDZUxaQWtIY3VXbkZEVWFMaG9GMEdxckoy?=
 =?utf-8?B?Qk1WVUVsQUZoaEttOFVuSGx1QXlLSitQd1liN3pGL24reldMaElxYk14ejg5?=
 =?utf-8?B?akZvSXlmVXZSR0VidHBxVUxieW4zQU8xUEJpVDF2Z1FSQmhDMmRubUVmcnJZ?=
 =?utf-8?B?VjkzZGwzNGpnUTJLREVuM001YTF5Z2E4ZTFGNWlEaS9vU0NZR1JYbEJlOXBr?=
 =?utf-8?B?cElLREZONHFra1FNWm9Ba2hFRHZQdlRSL2F2THIva1lLc1g2Q2hOckFqazc2?=
 =?utf-8?B?K1BqMENRZ0FjUU9ydFZqeXdJWkUxUHdoNnBXU0hvRWtMQ2ltK3pwY1JFYnNQ?=
 =?utf-8?B?QlFIdysvNVN2S05SZWxjTjNCdGxreGsxQ3pYWnhZRVAxVjR6NEVFZDRiWUpM?=
 =?utf-8?B?b2dFUHQ1bDlCMnAzOGVRcU1XNjZhNVhMaHlSUmtLR21SbFJoR3RLcjhCRENV?=
 =?utf-8?B?Q290NXRlajBFVG9vQUluc2hkOW4wYmt3QlBJWFZPM2JCb2RLSk11N1FHYldt?=
 =?utf-8?B?QlIrNmpleld5ZFJCaXJiWitmcExDeUR5NDZsSzFDak5ielI3SzUxeW5nd0dq?=
 =?utf-8?B?RStwdDV1NkJPb1BUejJ3clpZYk9tRTAyV01TbDlvN055eVVWdXpUWWJOT0xP?=
 =?utf-8?B?bWNoZ1FlNHR1N0wrRkNkUFAvQnlYYUVmK1lHQ0MvWlJKQVRKd3RmYjFITXND?=
 =?utf-8?B?Tno4eHBUWjJoc1g2VkRLL0JjK0Z4dWJUK3plZTIzeVRobFQ4MjlRbnAxM25U?=
 =?utf-8?B?Z2ZGN0Nkckpmd1NWZ2pmV0xEY0prYnVQZFFMY1dXU2MwWExxdUhFWERlMHky?=
 =?utf-8?B?cTY1WFNDTk16ZFJiVUxBblB5S2tZRFEyOWROWHBCTm9iV3E4V3NTZTRwY0FQ?=
 =?utf-8?B?UnJ4UzNOOVpmemZvNU0zeHF3cDJrV2xZTWNQaEZtc0w3VGdxNUkyaXZ5aHFs?=
 =?utf-8?B?c1lmSG1kT2FjOFhzeDhGaEtoUkQ0S0hQMFFVSitFSnF0Vlhya2txKzNMU25i?=
 =?utf-8?B?SDh3TTg5YlBHMzZpRUVBRyszdTIwN3NubFhsTjE3Zm5FZW1rK3BBYTJBMEJw?=
 =?utf-8?B?RDUwQnE1K29pcDhhNy9YWlpQZWxvRi9ZRWZ1VGE0Y0ZuZzhQKzllNzlZNVJj?=
 =?utf-8?B?R3FEZk1XaEdBYmh6R1hEdVJURVprWkF5Skk0L1d3YjhlRGpBbGpiQjkwaytJ?=
 =?utf-8?B?TEhBOWhQeG05dEdSbnFFTlMzNTFpVHNuM0pUUTdDNlV1Qmlnc2cyWWh0QkJW?=
 =?utf-8?B?R09xNk44R2hTYUxiWDZxdFRIRjJlcll5ZWJBTTFTdDNTY1d6bUNLK005VjFD?=
 =?utf-8?B?ZXY1VlRPRWw0RnduT2l1OXBmaUZZSjRVdHp5aDE5WDRLQmRtdGlYZUlNcnJz?=
 =?utf-8?B?MzBLR1ZIbGQwSktWNGhIUzZXOGhVczFxNnlZdGZMUTZWOVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlIMGxZNUpKK3NUcnRUZzVka2ozY1VmUU8vWHJGdytZVW5Jb1ZQUjlObTdW?=
 =?utf-8?B?ZTVobllGMVNWTHE0Y0FsQzNSTzZIenpGMVZBaW9RcTNjTTdqVURENkVFWTJp?=
 =?utf-8?B?VEtFZ3Nud2E5aVkzbG1ESHpOWjQxbWJXYmFYNk94RnkySmg3NUd5YkxFdk1H?=
 =?utf-8?B?dlRYZzkwbXNsbGFXQTNGUzRScmlzZ1N4RmUwVWJiMC83RVZWL3ZkQkVyREVa?=
 =?utf-8?B?VCt2bFloQlZKZm81d0w5M3p3M2JFTVBVSDZrZWNQN3FMRmt4bHZ2U0ZSc2w5?=
 =?utf-8?B?QnJ1WXc3QU11cmVwbnpKZi9hbElYTHdGSGYxOWdYdTJwcnJOK3pJQi9oQWsr?=
 =?utf-8?B?RU5ISFZ0TEhzRnhnbXpZR3RYdGxWZnlBQlo2YXhRK0hpUlVxeTR2Q0VocThZ?=
 =?utf-8?B?WWJIcDBlSWdkdC8yVlZCM3pJVHFwYklZMzczTU50MjRmUzkzR2ZnWkJSenhy?=
 =?utf-8?B?Um5GMnN6QnNjVFJ1RXpFREZVYncrYXI2YUFORnUvNFZuWEo2bGFSTks3OG4x?=
 =?utf-8?B?RURMdGRhc042NmU2UFczRHZKbkc5aVFBS0ZjN3M3OXJzVkcxa1FBdE9XOXBh?=
 =?utf-8?B?ZVJiVXAzdlJleS9rWlFiRHJGZFhmaWJ5WlUxMHh3UGc0bHIzWHFKWHdxL1VY?=
 =?utf-8?B?ZDRPVkdIU0pQZmVEbVpnb3RzZVNZRUVBNElnTSs4R0xKQkF2QTFMbUE1Y1Zz?=
 =?utf-8?B?MUtUOHFqRTZNUUhnOVRyZUZRYkxaQnBUbU1hSmNROUF6Y0dHTGhZZUJPZVVP?=
 =?utf-8?B?ZEdsaHFkZGNRc1BhcGo4RFNVaEdCV1JFdS9HL2hrRmNmLzRVNGFRRUZ0L2dR?=
 =?utf-8?B?NTErQ2k0czZYNXR0bDUvMmZsQlF0ejZ0Z2RGb2lrbk1Lc0llOXllc0NNWGxU?=
 =?utf-8?B?MlBVRXd4aXZUSDFlOW1ubjdidFlrQjlPeWxHZG5ldVVweFU1SlE5cUpqYU9y?=
 =?utf-8?B?dGFOZDVBbVRvZTZjVUUyS2Y1QWk1bFB5QnZHalQwOHRiRDREcE41anJOU0Rr?=
 =?utf-8?B?eERFU1UrMVduQm02M2JhQ0VkK3VjZ2p1RmZWanVQZXdzUXg3eGZZTThMNEhi?=
 =?utf-8?B?T0oyenAvZEh1N2xVc2tyK096V2dTMlRDZ1UzTUJrRVRsaXBwR05EbDUrRExm?=
 =?utf-8?B?NGtnSkRtd1VXNXMzN2tLaU1rSzlOODdONTVzelJIYkRnOGgyUjNLU3BIb2xL?=
 =?utf-8?B?blJWaFRibXpFOTFBS3ZXY2Mwd2hGYmxEcEUvQUtGRmJ5ckYxWUd0RVFyV042?=
 =?utf-8?B?VFY3cmhuSUtnc0FhUFBqWXVIZllIUjlKd1ZvK1pvTHdDUFlOd3NFNThOV201?=
 =?utf-8?B?eXNYSy9uUzV2NlpIdjljek0yVVdCV2drak1kUmo2QzhsVCtLRGlLaW1XUTkv?=
 =?utf-8?B?Ly8yK2Q0SnRub0JVL0tablljSnhnRFR3UWJ1eTQ3ZWhYT0hTVVQwaEYzcjBn?=
 =?utf-8?B?OWxUT3ovNDBHQk1Ub0tScGFBQ3Zscit5TnJyNndVZXRnY1Z2RTZWRTBaYmdV?=
 =?utf-8?B?VkxCaDI0TTRtcWpuN2d6bzBpUTF3dWxWVklPbGZiY2FpbmhwWFc3dDFSUUNB?=
 =?utf-8?B?bUJZVnRMR3JKZEdUS1c0cmc3a2NyNzA2Z3UwemtSM0wrV2pVeFJVSHR0S0w4?=
 =?utf-8?B?NkREMGdnV3R4WDM4MVBYbTNLNzBPeFNtVFhLZ1kwdUtsUnlHM2xTSVZqaFpU?=
 =?utf-8?B?aGpYbVRTRXIydEVZNmFZSXZQL2VsSHA2MzlzVmhUSlBPWmlmOEV3OU5uZENC?=
 =?utf-8?B?bjRzMlR6azlzQlRkVHFtMnN2QUE4cE40Z0dGalZlUUxBSE83dGJIdHMxV2Ju?=
 =?utf-8?B?VFBYMnVzUDBBbVl2eG40YVhnTkJISEhUd1B3SHAzRFRsNWRnQVNYb0pnVEo4?=
 =?utf-8?B?b3hrTk0rQy9MTUpRQlVnRThjWXVMUkxJblJFS0dLeE1la3dRZmpFZnVNM08r?=
 =?utf-8?B?M0czSUtyUnNTcittZEdGdnRqUXM3WElWdktLUjNZTDRKTXBZQjdiMUlpWFQ3?=
 =?utf-8?B?SEMwczRKa1NSMkpCOGxIbXo4bld5dEExT3RPOVNOWjVubXdYbjl3a1gyTk5w?=
 =?utf-8?B?eGphSW1hZWU1Zkgyd0RFSDNoT011amd5ZGl4UGNxaHpMWjVpSTNOaml4RkV6?=
 =?utf-8?B?a09zNkZFVkZic3F3NlJGVFM3MjVPbWs1S041dnA4YitJVzVlQjZyYjBYNVp5?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7e8ff-5a73-413e-5f9f-08ddff65c186
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:37:46.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMf24d5tqUEho89wHf+zLwSg/9LdL5k8wErGSG7p33CO7FCDZucksXJ2VWDBa1WUZxFrBx7L1HVeo8T1lvYUWheVQVsirw9ISPx0T4ZZnnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

On Mon, Sep 29, 2025 at 10:57:45AM +0200, Bastien Curutchet wrote:
> On 9/27/25 1:19 PM, Alexei Starovoitov wrote:
> > On Fri, Sep 26, 2025 at 12:47 PM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > > 
> > > On Fri, Sep 26, 2025 at 08:39:28AM +0200, Bastien Curutchet wrote:
> > > > Hi Maciej,
> > > > 
> > > > On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> > > > > On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> > > > > > testapp_stats_rx_dropped() generates pkt_stream twice. The last
> > > > > > generated is released by pkt_stream_restore_default() at the end of the
> > > > > > test but we lose the pointer of the first pkt_stream.
> > > > > > 
> > > > > > Release the 'middle' pkt_stream when it's getting replaced to prevent
> > > > > > memory leaks.
> > > > > > 
> > > > > > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> > > > > > ---
> > > > > >    tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
> > > > > >    1 file changed, 7 insertions(+)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> > > > > > index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
> > > > > > --- a/tools/testing/selftests/bpf/test_xsk.c
> > > > > > +++ b/tools/testing/selftests/bpf/test_xsk.c
> > > > > > @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
> > > > > >            struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> > > > > >            u32 i;
> > > > > > + if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
> > > > > > +         /* Packet stream has already been replaced so we have to release this one.
> > > > > > +          * The newly created one will be freed by the restore_default() at the
> > > > > > +          * end of the test
> > > > > > +          */
> > > > > > +         pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> > > > > 
> > > > > I don't see why this one is not addressed within test case
> > > > > (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
> > > > > 
> > > > 
> > > > pkt_stream_receive_half() can be used by other tests. I thought it would be
> > > 
> > > So is pkt_stream_replace_half() and other routines that eventually call
> > > pkt_stream_generate() and overwrite the pkt_stream, right?
> > > 
> > > It just feels odd to have a special treatment in one function and other
> > > are left as-is just because currently we don't have another abusive test
> > > case.
> > > 
> > > Maybe it's enough of bike-shedding here, just wanted to clarify on my POV.
> > > 
> > > In the end don't get me wrong here, this interface is a bit PITA for me
> > > and thanks for whole effort!
> > 
> > My reading of this discussion that it doesn't block the series
> > and can be done in the follow up if necessary.
> > 
> > So I was planning to apply it, but it found real bugs:
> > 
> > ./test_progs -t xsk
> > [   18.066989] bpf_testmod: loading out-of-tree module taints kernel.
> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000
> > index:0x0 pfn:0x11c98b
> > [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000
> > 0000000000000000
> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff
> > 0000000000000000
> > [   32.220900] page dumped because: page_pool leak
> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G
> >        O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> > [   32.224638] Tainted: [O]=OOT_MODULE
> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   32.224641] Call Trace:
> > [   32.224644]  <IRQ>
> > [   32.224646]  dump_stack_lvl+0x4b/0x70
> > [   32.224653]  bad_page.cold+0xbd/0xe0
> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> > [   32.224688]  ? veth_set_channels+0x920/0x920
> > [   32.224691]  ? get_stack_info+0x2f/0x80
> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> > [   32.224700]  ? common_startup_64+0x13e/0x148
> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> > [   32.224706]  ? stack_trace_save+0x84/0xa0
> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> > [   32.224716]  ? timerqueue_add+0x217/0x320
> > [   32.224719]  veth_poll+0x115/0x5e0
> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
> > [   32.224733]  __napi_poll+0xa0/0x420
> > [   32.224736]  net_rx_action+0x901/0xe90
> > [   32.224740]  ? run_backlog_napi+0x50/0x50
> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> > [   32.224749]  handle_softirqs+0x151/0x430
> > [   32.224752]  do_softirq+0x3f/0x60
> > [   32.224755]  </IRQ>
> > [   32.224756]  <TASK>
> > [   32.224757]  __local_bh_enable_ip+0x58/0x60
> > [   32.224759]  __dev_direct_xmit+0x295/0x540
> > [   32.224762]  __xsk_generic_xmit+0x180a/0x2df0
> > [   32.224764]  ? ___kmalloc_large_node+0xdf/0x130
> > [   32.224767]  ? __mutex_unlock_slowpath.isra.0+0x330/0x330
> > [   32.224770]  ? __rtnl_unlock+0x65/0xd0
> > [   32.224773]  ? xsk_create+0x700/0x700
> > [   32.224774]  ? netdev_run_todo+0xce/0xbe0
> > [   32.224777]  ? _raw_spin_lock_irqsave+0x7b/0xc0
> > [   32.224780]  xsk_sendmsg+0x365/0x770
> > [   32.224782]  ? xsk_poll+0x640/0x640
> > [   32.224783]  __sock_sendmsg+0xc1/0x150
> > [   32.224787]  __sys_sendto+0x1d0/0x260
> > [   32.224790]  ? __ia32_sys_getpeername+0xb0/0xb0
> > [   32.224793]  ? fput+0x29/0x80
> > [   32.224796]  ? __sys_bind+0x187/0x1c0
> > [   32.224798]  ? __sys_bind_socket+0x90/0x90
> > [   32.224801]  ? randomize_page+0x60/0x60
> > [   32.224804]  ? fget+0x18e/0x230
> > [   32.224807]  __x64_sys_sendto+0xe0/0x1b0
> > [   32.224810]  ? fpregs_assert_state_consistent+0x57/0xe0
> > [   32.224812]  do_syscall_64+0x46/0x180
> > [   32.224815]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > and at the end:
> > 
> > # ERROR: [receive_pkts] Receive loop timed out
> > test_xsk:FAIL:Run test unexpected error: -1 (errno 12)
> > #251/32  ns_xsk_drv/XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF:FAIL
> > #251     ns_xsk_drv:FAIL
> > Summary: 1/67 PASSED, 0 SKIPPED, 1 FAILED
> > 
> > [   99.308243] page_pool_release_retry() stalled pool shutdown: id
> > 185, 48 inflight 60 sec
> > [  159.724173] page_pool_release_retry() stalled pool shutdown: id
> > 185, 48 inflight 120 sec
> > 
> > 
> > The test is great and the work to make it run as part of test_progs
> > paid off big time.
> > 
> > But we cannot enable it by default, since it will be crashing CI VMs.
> > 
> > Please reproduce the above issue.
> > You might need
> > CONFIG_DEBUG_VM=y
> > and other mm debug flags.
> > 
> 
> I did reproduce the issue with CONFIG_DEBUG_VM=y
> 
> > If the fix can be done quickly let's land the fix first.
> > If not, please respin the series, but disable the test by default
> > until the bug is fixed.
> 
> I won't have much time this week to investigate this further, so I'll respin
> the series with this test in the 'flaky table'.

I'll take a look at the splat then.

> 
> Best regards,
> -- 
> Bastien Curutchet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

