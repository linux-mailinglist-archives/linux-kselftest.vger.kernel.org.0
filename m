Return-Path: <linux-kselftest+bounces-18657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9E98A949
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D029F1F2368B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509E188714;
	Mon, 30 Sep 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExPmNT4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2935894;
	Mon, 30 Sep 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712255; cv=fail; b=T0rowa297//tBug8ij2IBttErQLVl1C/wxL/FvxdTn89oNizkNuStpYGtfxfrZVHTPpG8yiG9vArUyAdV4BGNa9sre4nP6xPDyJdf3hyMHBj9rOpAh4a3r7dAfc0JlFwH2O0A6HuxYXbZsx0Um94kQiH+upTnMUVJl/gWLRQflI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712255; c=relaxed/simple;
	bh=tdGP+EqdAwwd5yhk3TFkNMv46ZDBF5XIAm0qs5RfkLA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AaTQ+XVgS69G89zBtyr/EBmCV/mpZr80Kff5v76HeaADaHnPJpuR2ClpzLGwVggfC2u5aJp3g72FA5Vt+amobWmDDMOYDnWh80BHiLGzO1Hsf+gkR40hEBzeVe05JA7U+n8YWpJiKFJgNTtNl9SGcV4ZkdT8gsLdN9qnaItDCC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExPmNT4c; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727712253; x=1759248253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdGP+EqdAwwd5yhk3TFkNMv46ZDBF5XIAm0qs5RfkLA=;
  b=ExPmNT4ccYvNzatHyf0Sc3p4jMXojDqqPxhK+Kk/7TfRJcBhYYcUOEL8
   5hesgIjQmzPUK+/XYUoyKyh5Z7HYkgf+FMTz5MhxyyewQCeArB4yviz1x
   XxKzjsDGvnKT7TccXhTrHc0ZuxNTuPKVAANKq9MwhszhJb1KWQoAAJkZX
   BeG4acKjcHnIzqaGOZtnevwZHeUQKvJkhXp86rtEaDjsn6tyHhHBOkKzL
   f7luQCtYfiSGZX4rfhMFsVPz4WsIP8fLA74U4iVTUmMwEJhf34E6IzCWM
   0qYCkWAxIRH0Ga9vfORfsN18wimqPwDQ0KN9kxhAAtt044ugqD9AZfoMv
   Q==;
X-CSE-ConnectionGUID: tVpPXZfdQDmLUasXwiVN+Q==
X-CSE-MsgGUID: UuaLaXNzR2KIThfOl6p2wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30608491"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30608491"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 09:04:12 -0700
X-CSE-ConnectionGUID: CH09mVtrQwOGPte/i5oIgQ==
X-CSE-MsgGUID: A1FAmS93SPumCtXb5VukKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="104149348"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 09:04:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 09:04:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 09:04:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 09:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTP1QVQrED9bX8LyxfO79DIKjpHZIf9sPrrnzEbqN1jxC8fiMYy3QFl4EspnvEx+GNGzzv6ouRTehQWc0aCFIVga7Hpc6QPmTXQVCs/oCOXx+1KCdj1OVEoqXMGy4lORcnafWa+PmJo/gfolUr/kTD6aYcej1hHozxSQeQYMo1vOegMzSSO2nbwzXlD3oWzY9ikhoEhhsH22XmdVsr+tQbf80okQXMfzGBhc9uBgVfMDFTlvM7lThqf7HHUoV6uXcN2YEz4kE2IkTUjYW8wxTsTU7iJvnCqveBLTTokT049F3C6yGIeLNQiD5C3qeZj/VswLb5JrGwh4eKtRK6aCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6wV0mDaG2yo7WB7Af23D4jTopFRgFvn30Q8IcjfHy8=;
 b=oGwDueHas8r8wR56tTtG4hf6IWE0LDcCYBC8kkUGmO+ucmGr7lEeUqDP0L20cB0q41z8HVVZfvR54LGVBeAYUgex+yyvUV3spK319VnUKP6OVVniKx8PmO0bpGBUk6viPzXMyMpwP348a3cZRx6myh2POf3RFvu40tYWfr0Iodf99lWCyE1Dody/9CjgyR5/tTuBTa5VrV+p0jcyN+51BDW1K1XQTfPbGYI5kz7qFZNnXQN3BZb4Ua6QIjp5TfSL2TVYiRmc4XHCJb4vQSiRYCEFVjIBkU40EMy+4yXqeYtC14a2OzRXymbaZtwfZ8t6nPmumFnP7oNMKcZl7Uiywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 16:04:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 16:04:08 +0000
Message-ID: <cbfc027c-264d-47f4-949a-3216cd79bf0b@intel.com>
Date: Mon, 30 Sep 2024 09:04:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/13] selftests/resctrl: Protect against array overrun
 during iMC config parsing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <c3ff2c7df3d10931087e25e5488eb1ab2f5fe13c.1726164080.git.reinette.chatre@intel.com>
 <93b9f530-1d2d-dc19-1d48-c15aced32804@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <93b9f530-1d2d-dc19-1d48-c15aced32804@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a442731-7ba0-48e0-9e3c-08dce1698437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnFPZU94YkgyZTFFdE0veC9YTi93V0ZHYklEcGlXN3gyTS9FWmwrRkNtTE9I?=
 =?utf-8?B?MTJYOFNZdW1SMDZzOE5yMmNtdm5SQzczbm5aUFMxalMrUjVtOTBSVGEwbXM3?=
 =?utf-8?B?T0xOU1dCZ2FtQ0RoYUVvNkpGcVhPU3VMcG45My9adkNJTHY0dUI0Uk8wWnFQ?=
 =?utf-8?B?dW52WGdnMVJQMzRRcHdqSmFQM3hjdWdYNVBJNm5sbEhKUDRZMWZ5aFRiMVB4?=
 =?utf-8?B?Q0Rzc2JwcUZmcUgzcHFDMk0vWnl4b2x2MTlBcks3WXZNS2kySzBvbm9FU2tw?=
 =?utf-8?B?djltNDNoMFZIdG1YWURsNWdZTmtHUU9rM29uUVJ4ai9WQlN6WTVYQzNUOTdB?=
 =?utf-8?B?ZkdMVkd4OW5ET2dkTm8zbzZBN1ZPdDdNUnFpSVJVNXQ1cXNxTjhEd21Hc3Fn?=
 =?utf-8?B?UkdldnZqT21DbG1SS2NERUNVejJtSFloM2VjaFVCM1RIOEZvMWFNTVd1amZm?=
 =?utf-8?B?SHRLZnBqUmVIb055OFVWR25Eb2hKYk1MalJUMkRyVncyS0JTRlBkc3JDajYy?=
 =?utf-8?B?c3VtUVBtTjBtNnlSYzA5Y1VoZzNlVElaZHZ0T0taZHVBMm1MV2pOeHFnUVF1?=
 =?utf-8?B?SzMwZWR1SkFnTVgzK3VOZVhQbXJ0VWxmWU4rZG4rVGV4a3IranBwSndPMzJN?=
 =?utf-8?B?dW9KSkFZamZ6aVVWT3FCTkQ4dC9QRmdabmZzTzNYbDNsTE1YL1hWVktnT1NX?=
 =?utf-8?B?MnE3dzlUUW5jdTdrNlNWcERVR1N1NzV4TnN0VzJVZkVFeEdXRU5kWXg0RUFF?=
 =?utf-8?B?YmZ0anpnOFRSMEg1c3ZBb0RHL2VEV1A1T3ZQNGplelAwU0c3OVFYVTc4bGtW?=
 =?utf-8?B?ZVdtMnU1WlVRQjlyVTJNS2J2dWU0dDhEdUFCRVI5TUx1UFNucjI5QTM0NHJM?=
 =?utf-8?B?dEMrenExd0t4anJFZmRjM1N2NU91WnNjd2dxSXJJUGl6dXJjQ3BSQXg4bzFJ?=
 =?utf-8?B?dUNtZmp1MkhPcm5TTGx4N0UxaFJVRFlNQVdBbnV5R04wMjZwVTlYbHoyMzIr?=
 =?utf-8?B?UmgyOEZ6OXpEdVRlNWJzc1JPL1pUbjc4ZUQ1L1RnS080Ym1ZSTVRN2MrSDJn?=
 =?utf-8?B?VEVVL2FhRXdVSWx5N3R3RjEvQ3dwS0tSU2ZzTkZDaFV0OUFTSlZ4SHRhaFpy?=
 =?utf-8?B?MEE3bnZ6bFhSM1dTMlZGQzc4QkVKd1dzUHVyczljeEpMTHVOQWtiUUw4K2tI?=
 =?utf-8?B?SVZJRnJ1V3c5SU9hblNKUXphRUw3NkRXcnBzNnFEdG5iSmlNZXhvR2hSd0cv?=
 =?utf-8?B?UzkyY0d4ZmFXL0lrTE55aWZSWDhjUFNCMmd5eklyUmpROXBGT2V5ZDBRb0NX?=
 =?utf-8?B?MDNjajlTTExVOC83QjVnY3c3d000bzBITFpMTFMybEhaZTdrV0UwZjhzZXI2?=
 =?utf-8?B?bC9sa29hMzZtZjFCMUJSTDFCbXlxSXRVM0dpMVQ4ZmtxMEdDK0oyZ20vUkk1?=
 =?utf-8?B?SU5Hd1hCVFZHaXlWWVR6UnY4Rjk5cnFjL2h5QUJRNlYwbWNXdDNwSzFEdEZQ?=
 =?utf-8?B?L01hNDVvVEZYdEZIcEtJcm5zNndqRGVkNjA4WVlRNFJvenYrMkhzNzBFODdG?=
 =?utf-8?B?RHk2M0NIZGlhOFhya0VjMjA1eXQwYVpucHViY0xNQ3JnSmxNRzY2ZVhQSE9x?=
 =?utf-8?B?Sk9WOUszZ3JmOEFWUHBIZURrQVlubklzanV4Z3czMDF2VmhZcnVmN2ZZdEZC?=
 =?utf-8?B?THNHTzc1RWxlQlduaDhrOW9jOGM1SG5YejRJRjdBcmJBRG5xSW1pVDV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmQ2RktIZHVzZ0NMdG5BSkJNYWpHVkZCNE9JL0doRjBQdTRPc24wQ1pURnhW?=
 =?utf-8?B?bXgyMk1JWTRJc2V5MDlJa3JSNmhrZWVQR1FpN04wQnI2TDQwWlJGeHlsRkRE?=
 =?utf-8?B?YW5rcVEzN212NDZHdUY1cG55WFFYNG94Q1BWRk9pRUUvM005S0VJMUdEYnNO?=
 =?utf-8?B?ZlFNQ2pkNzUraDV3WmlwWk15S3hkR3RYNVJLbU1idmRRckZ4VTdLNzh6TGgr?=
 =?utf-8?B?RzEvVlBVMm5wbi9obGV0VVRrbFhwSEE1ZGUwTW03ZjE0eUtGOHh1TkkvSjJF?=
 =?utf-8?B?ZUg3V2NGaFBHTnA3aUpVMXlGQmhmZDR3bElSaXRGZDVyYUsvUktROGdaMHBm?=
 =?utf-8?B?Q01Yd3FwdklMWHZ6WmR3YUlGb25YMWlzNmoxYjE5VTlKRkFrc0hadUxiMkVC?=
 =?utf-8?B?Wk1DaUp0YWthRWliZFRFcGRKOFpScmdGbGc2dzJ6aEErYmcyMWNEeXAxblc3?=
 =?utf-8?B?SS96NzVHQUI0Z3YvcG1URFBFelgxSFVGNVJlUWxoSGlibnlGR3ZUNm9tUmpT?=
 =?utf-8?B?YUw4UjhkeGQ3ZmhtQi93Ujg0c3dMRzdOMldoS0Q0V08yQVdydVRVQXNYVW5H?=
 =?utf-8?B?TTEvbkJRd3RkL0xOYjRUUWpsVzdtNEFBbmEzcFdseEFMeTZQNFdPKzBvd3ZV?=
 =?utf-8?B?blQ5NnBGai9KMC85MldrQXUxdnBKbHlORS9RUmdsSVY2RkNFckVpdjh0RlV6?=
 =?utf-8?B?Q1BYRFBQMjRubnlZdkt3N29waFNVc3hFcy8xM0lQbFBMTFFKS0NzTGVWUWt6?=
 =?utf-8?B?MTJzZytGU0FoME5uTGRpUXBBOWo1akVQdU52M1R2Y2VCdjZkeWgwbUErWTY2?=
 =?utf-8?B?ejBHWEFMRTFuVWhKUWxhSlhPTnBUQjcxbnRXeWJmNmVLbHh4c2NQUGRZdjZw?=
 =?utf-8?B?L3VPMHQ5b0ptZTBramp3K2xOaHRkcklOVnRuWDJIOUo1WTVDblpxSW5VYXpl?=
 =?utf-8?B?VHdhdVYyYU1IWXh0cktDZzQ4dFdjSWppdmU1T21lS3gyVUZGMFB0WndNdkNS?=
 =?utf-8?B?THZCajdudFpkVVNlWTVDVnI0OXpFWEhHWDZwK2pBQ2tlTW9Zektib3dCQ0la?=
 =?utf-8?B?dDQ4cFpaSFpKTVBUM1o5WUcvNjdzYlJQc1NFVjlHbnNvd3J0c3A1TFlWUm50?=
 =?utf-8?B?dlh5ZFJXbG9PaC9HM083MkprcStKTHFBTDVzWTZ3YUtqRkdsdUdYTHhUQUI1?=
 =?utf-8?B?MVd6QTlXaENSa2QxcmNBdHl3OXpLNTNUbE5UdDRKc3lBT0U3NWsvQmIzU1l5?=
 =?utf-8?B?RHBBcnZNVVBXTDluN1JTZEMwMmNNeUFSRnRnM3JCdUROMzVETnNQUzllV3N0?=
 =?utf-8?B?SVVaKzlSQm1EK3RJZnFkQ004NmozNHlyY1RMU1dCVHljU1M5WDNZTlhDTlBt?=
 =?utf-8?B?ay9xd01HOWN3a1d2TUhGaTFDM29GRjRuQjl4RGhEOXR6YVhiN0pqa241dXJP?=
 =?utf-8?B?ZTdKNGNVNG9MR2lwM0o0MUhxVkZKUVBYa3JNL2tPT0RmbURxK1JHQUU0SFZM?=
 =?utf-8?B?YVdzRVZsdCtwRTlqUStmUWs3K1YyNng2ek90RWFyMEs4MWF5NW1LcUQxaldT?=
 =?utf-8?B?M0t5emlzT1VpSzVrbisxeTBwT2dMK2FIYkh2VmJGWDlIZWpoejZKN05nVWYr?=
 =?utf-8?B?RXhybWNxaDEyc3ppaXV4bk9DbjJaVkhTTGtxTm5XczNOOVhUNFZ1NStpOUxB?=
 =?utf-8?B?U01lMG1RTll3Q1BzUzIrai9IMkxGRFB2REVWMnhXbDVYSGluREtFVk5STCtB?=
 =?utf-8?B?WWdZR3lIWUE0enFKSjJCZzlDRUt3Wk5nMWRPbUJMVUdTbXJLblBKcVJObWdC?=
 =?utf-8?B?UHU3Sk1JWGFSNGFlWllVOFFhTWZ3c0JXcS9lMVRsS3hGWjczOXpkMzJTalUy?=
 =?utf-8?B?ZlVaZzRWMkFHaGorV2VYN0lIUkJkR0t0OXJkVkxncFJYTWJpNnl3N1JMSTlw?=
 =?utf-8?B?UjVlczBqcGVVcXVRSllzcDU3SktNUVBiVjZVVHRFTDhjRTBwQytxbis1QmVz?=
 =?utf-8?B?VTVHQ3RNeHp0SGdBRU9wRjRQdGgwZmtjYjQzdUhEYWR1U2xOU2tPMWNnWFJo?=
 =?utf-8?B?UUpMN1paeFptWHV5dmc0ZDFNSGZLUS9KWEJaSkJzZFErVU5PcnlHYTFXTjlR?=
 =?utf-8?B?MDN5TW5zREVPQzRvUlBpa2Z3TDloT3FuR2dXSm95UVJ1TGxVZmVjckErSFAw?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a442731-7ba0-48e0-9e3c-08dce1698437
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 16:04:08.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+bwefgA2lOiDFCEso4Qx0J9tUqgtknz0ofHtRLZr77ooJPQ03RcaFRurbiWIa0/ecEMz3coIHTrEwvx7jYbxRHwHLvOccm8J2kuYLN2ADY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/30/24 6:35 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:
> 
>> The MBM and MBA tests need to discover the event and umask with which to
>> configure the performance event used to measure read memory bandwidth.
>> This is done by parsing the
>> /sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_read
>> file for each iMC instance that contains the formatted
>> output: "event=<event>,umask=<umask>"
>>
>> Parsing of cas_count_read contents is done by initializing an array of
>> MAX_TOKENS elements with tokens (deliminated by "=,") from this file.
>> Start by removing the unnecessary append of a delimiter to the string
> 
> Start what? (It sounds odd given the lack of any context, my guess is 
> you're trying to refer to start/first one of the changes you make in the 
> patch but the textual context does not support that conclusion.) I suggest 
> you just rephrase it and avoid using "start" word altogether.

Indeed, I'll just drop the "Start by" and have the sentence be:
"Remove the unnecessary append of a delimiter ..."

> 
>> needing to be parsed. Per the strtok() man page: "delimiter bytes at
>> the start or end of the string are ignored". This has no impact on
>> the token placement within the array.
>>
>> After initialization, the actual event and umask is determined by
>> parsing the tokens directly following the "event" and "umask" tokens
>> respectively.
>>
>> Iterating through the array up to index "i < MAX_TOKENS" but then
>> accessing index "i + 1" risks array overrun during the final iteration.
>> Avoid array overrun by ensuring that the index used within for
>> loop will always be valid.
>>
>> Fixes: 1d3f08687d76 ("selftests/resctrl: Read memory bandwidth from perf IMC counter and from resctrl file system")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - New patch.
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 70e8e31f5d1a..e88d5ca30517 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -83,13 +83,12 @@ static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
>>  	char *token[MAX_TOKENS];
>>  	int i = 0;
>>  
>> -	strcat(cas_count_cfg, ",");
>>  	token[0] = strtok(cas_count_cfg, "=,");
>>  
>>  	for (i = 1; i < MAX_TOKENS; i++)
>>  		token[i] = strtok(NULL, "=,");
>>  
>> -	for (i = 0; i < MAX_TOKENS; i++) {
>> +	for (i = 0; i < MAX_TOKENS - 1; i++) {
>>  		if (!token[i])
>>  			break;
>>  		if (strcmp(token[i], "event") == 0) {
>>
> 
> The code change seems fine so after improving the commit message, please 
> add:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Thank you very much.

Reinette


