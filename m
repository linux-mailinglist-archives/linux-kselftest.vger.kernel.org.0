Return-Path: <linux-kselftest+bounces-17317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884296E191
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0181B2435A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704C17A599;
	Thu,  5 Sep 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFRqm6dn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0017172760;
	Thu,  5 Sep 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559741; cv=fail; b=gTMciLznMF43lx/+Gm/uPiRwHoWoTw9XQPv+C0az/zCzJDyGRnXDuEJ7X4N24d/+y32gUnxtcXBhw7qCTi7+5Z1IXubg+qw/Aj/C0l3pE7Kp8rxcdnSmoIkdqcIUl+EaNk7Gtsk5ImKRuPmtpOFAjw75HKa5zDmOYmb85RXrOyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559741; c=relaxed/simple;
	bh=G71ig1avybbOd5KFrGDo05HZLUye2pacU5WDp+P1aSo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tkDp8RkaeU12uHlL3cV2fbXMls2ZXXjyVmoU8SWWiGk1vplwrWXmdsuaQXmUSqAiSyxWz36NuVLzzPnPP1pNlD4p+tOULW9sScNWgQe5N4F7VGd6/AajjxNzkw/Wg7nzZnKqi6Q1QtUWkLXQmIuoAWsGmC/oQ7lp73V7fAYiX+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFRqm6dn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725559739; x=1757095739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G71ig1avybbOd5KFrGDo05HZLUye2pacU5WDp+P1aSo=;
  b=cFRqm6dnoNdFK3j0WY/rVzN1e6a+6n7t2qYQkMIA+OsCBrMywo+u+E5P
   zCARhsrCvel/QFnyLzfxJltpA4BQJt+MHzoPFkhHkhxV8YOsaePbdbK7+
   ZWB3/SaUxYKXlWkycrSAimX/XlbdJqlF/QfLrIXeiu8MUPNT+8WbVGK1Z
   NAChnn45Uwmy2KURtquViVUjRFBkcNMdxnkiBnBJtWcHQX8dRTKhuxrEN
   0tvA0pAC7SE9/PqtLgXWkR75zGedTilWsLFQo9OeaAokmAyHXgV+O9r3h
   0di4LrXW5zNhaMGNsIpyKOgDNVmbiMhe7wkLF5ptun4JClmt/bd6P+RUh
   Q==;
X-CSE-ConnectionGUID: b02PPpA6ShKIo/kTMjkP1g==
X-CSE-MsgGUID: sZwlQPOnQDeXMSmCloX1BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28089023"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="28089023"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 11:08:58 -0700
X-CSE-ConnectionGUID: Trv+4ZV/Tn2lx6/FbK6XgQ==
X-CSE-MsgGUID: 8l+DDNO7TUKtXu5Nrwdumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70278159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 11:08:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 11:08:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 11:08:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 11:08:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 11:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srqfWPn98V/DXGRM1y5Mq54Y93d3lHbyQGRr3K6+nxvYf0obo7L5vd7mOOOlyDMQVBHff4+BqzbwKKbkXQNSV5AZGsPnDXgf1LbfyC0kJrMdkw62bvbFaieOOdwXS7TvxaKWBoojxixepMKN1j0pdmIX9UvabKevHKmB35fm8G/Di/42pz02p5Y1FAPLu8jRJiNBXh5YnJp6CwneEFs6sQHG4QTwB3QQWkwj8S2FKq8DD2EUnSykWb1xAndl5Gqim7i5VvXb7BJK9NErxBx+EQUH6CRrqPhGdePJmFW6xGJtp+0x3kNWFY+k4y0Om561K6A0FqqTLPFmztqCjvPYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbEPLXm6wN7LmcayEydhjbHuewaeFDK6EQCv8H+GEUc=;
 b=L/ZyXfyTUURK7QPoB9lJdQe1HkD2TpJj74Y0iTtg/1u4+966R8TqO4SozeDImkSXoYedo/XZznIVW9qmNNXDTLk8u2RW9rP0JK7eRaJuvGnKeCqrklb8rofxG1Az54Rjboaaxk/0TExVE20FBd0kJEk4kai59hiAas9J9EhDYxjRswrQVlUmqA6MIPa2ds4ZF4Lz3PSqkPw/YdDp8PFmOoDUDBzpEpkIRwLKdunxfvW++XSPBxgBLu0uGTU7mJWUcwkd0DlZt5//TDQUfBClBaAXm/4ik9jhyWGY6XdH9RQrdbwCvimmY12pSn6ceUdAD338KGAJ3CBQzhm69dz29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 18:08:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:08:06 +0000
Message-ID: <86ca3bcd-de60-4784-8a32-8df360a4ceda@intel.com>
Date: Thu, 5 Sep 2024 11:08:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
 <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com>
 <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com>
 <156ad739-3f80-456f-92df-74da9266dca0@intel.com>
 <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: f52f8aea-d43e-43fd-4061-08dccdd5b0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDN1RDFyQmtrV3pacmNTcG9pNjBXWjN4Vkd5YnlWU2RRbVBkUnVsdlhUdVdk?=
 =?utf-8?B?bW5pVlJEUzZKQmFRWmZITU01cnBBVGJNNzhmK0RFaWFJQUZ2d2d5dytMcGdw?=
 =?utf-8?B?TFZ2dUg3SjRlRTFxVkRvd3VHQWlIRGhzM08vLzVjMlRnOTVZMU9POG1qOFA2?=
 =?utf-8?B?T0UzOVRyQVF0WVFGNFRjUU44cnRhQ0EyaS9ZUzdJbDRDYW13dExNa3FvZ0VT?=
 =?utf-8?B?Rkh6YU05UjVxM29nUUdaamNaa3Jlb2FUR2ZPWi9jMGZ5REtQSnFvdzVvK3Vu?=
 =?utf-8?B?emFNTkUzcVlUKzZCMDhGVGRsWFV4Qk4vNW83QmdpWlBlSFFGeFEyS2haTVVm?=
 =?utf-8?B?YkNYeWVNOVpCQmhiZEhqeVFROFdobTlTc2VoazlQMGw2OW5qaFhvNGk0VExG?=
 =?utf-8?B?V0ZzU2ZBTmVObFI5QldHS0NaSVp4eWljNytWUk1ZaVB2dWl2T1oyWFprd1RT?=
 =?utf-8?B?RWJMQUkzNHQ2b00wZndsWW43QTdodmorMnNjQ0RiS3BsY1ZCajUxOHVzcnB0?=
 =?utf-8?B?S3lzdlVYUXJIdE9XTlFMV3JBOXJjMmhWMzk1RE1UWVVvUGhHRCs0dzhzbzBp?=
 =?utf-8?B?VlU4aFkzem9OQ3B2aHo4VmZObzlGUVplSndadkpJNW43U1JKazRtanBMNEtY?=
 =?utf-8?B?VjA5dzdYUTh5bGZtOVhSNGQ0L3VKMmxDeHZOYTlFVmFvRVBIY3FyTkI0S3lx?=
 =?utf-8?B?VjJQb3NuOCtyNzh5dFRtSG5tK1pEMFk0aytVOVNyVHdVL1YyOTdkZE9leDBm?=
 =?utf-8?B?SzZZbVhiaForRkdOcEJuNXlVOXhZcUV2dDYrVGdRQWdSb3dkWEFLSXAwM2pz?=
 =?utf-8?B?cjlqMUErdGJLNzZMUTBCYml0VDRGd2E0cjRxY24wQW5ieU9KVE5vVzJmOCs3?=
 =?utf-8?B?a2JRUW9zV1dhbW4rdDhsNnNZK3FDZ3hQR2RIdFE1c3NyQUlHUWxubUtra0pQ?=
 =?utf-8?B?QTMzOGNTVWY5VS96OHNqQjdRWlVJcjBMTjBxbGhUVWhtcGI2eXBEMU9YdmJo?=
 =?utf-8?B?UmRuQ3dPS1k5UCtxUHR4Sy9uck1rNTJJOG5Gb1BIcjZGbk43V09YUldaaXZD?=
 =?utf-8?B?UEZXUk5JV1NQVG45WE9NVDZrTGk1VW1mMXZ1aERpVFpEam4yWndJbW1yWkUy?=
 =?utf-8?B?WERMMVV2WmtKbXluRFRHK2VtcDF2T3hnbTcvVEtzTkxlOWphUnVlMURRZ0RO?=
 =?utf-8?B?c2htNnI5azU3RlpHNFV6ampDYk5pbmFPUEF3T2lIR1RnbXo0MHJSQnhXVGJl?=
 =?utf-8?B?MEw5UWs0MEs3VmI1YnhkQlhDeWtKT1hpSTgyRnc2alZ3WllLY0F0WkIxY0Y2?=
 =?utf-8?B?VURRQ2hJbnhJS1dKVkdSRW1SdGt3VmJDa2JwYUYvbENiUHdyZ1dONS9EaXhv?=
 =?utf-8?B?bGxHVHRiWThMU1B5bjhUWFUxL3FrUWlIdGlaR0NQVkd6SW5COXV1Sm9PNTRP?=
 =?utf-8?B?eWNRUzEzeDhZYlFoVFdycFJtd3pubEp5dktySnpBZVg1eE9vZEZJOTQxd1Vh?=
 =?utf-8?B?UFhWakFTYlpaM1k2SUhMbjZDRE44N1Buck1adnp2SG4yM3Vzcy8zVjBzNXQv?=
 =?utf-8?B?WFg2aEl4QnIwT3FjM3piZlh5RFRtak0xem9YN3ZyTWhwcnI5RFVpSW9sUEJF?=
 =?utf-8?B?ZkR4NEdoMlozOXFvaFhyMzZ3aFJTWGlJWHlabkc1UVlmRk12bk5FU3RIVDU4?=
 =?utf-8?B?OU1tLzd5SmtmUlhaMG52RmFEU1VIU1JRaVUwWDVRVXprVm42WE44RDFFWUJY?=
 =?utf-8?B?L0NuSTNxK1gvbVRIL0RpVS9KZTlxOHZwbTRRMlhLZjd0ZTRxMldNUUQ0SlJN?=
 =?utf-8?B?N0Z0a28yZlA2d1RhWkVTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhNSi9JVzM1MjJwUUJMV1Z4bFBxSERvRUJYRW5ZaWhSd3k2TCtqNkhCUDN3?=
 =?utf-8?B?SUlDVURabnJWWEhYMFNvMXFIY1d2QzZVQkpjOTc1ZnV3Sm9yZzRDbzZGWUp0?=
 =?utf-8?B?cjlpUEdUOFhWZ2hQSFJPSFN5WXVrVjZMZ0xxV1Z2dzkydnV5czloaC8wa3g4?=
 =?utf-8?B?QjZyc1pISW1tK2ZpM3pIaFRzdm1IUVdORjUxVHF3dkdJYW9mNFBQQkdnVTVr?=
 =?utf-8?B?bjFTNGhkeW03VkNUR05JVjVSbURHSk1FZUVrckdKM3RHWHY3VXJmeTBYQ0d2?=
 =?utf-8?B?bmJlYStNa0RsMXZvbXJtTkVJdFVyb3YzS3grVWRmZmgrVFhBVFVOTjlWcVVT?=
 =?utf-8?B?NkN3ODF3L2NQSnkxUlhHZ2ZFOXZLVzNOMUoraHhJYW1RWVoySlliZHJtWmg5?=
 =?utf-8?B?Vyt0dW5rUElESFNUelg1TWU2UTZmY3dsaEtuRXorbnhDamI3NDN0R0FQNEs3?=
 =?utf-8?B?Snc4YjIwQnJNSkpaMVAyQkp5eHpCY3VkTzF6ekd6eXBBUnl3enhXVjNXc0Ns?=
 =?utf-8?B?Z1ZGMmQ3SERQR3p4QVA4RHBmT3daeHdOZHp0SUd2N1l1cUZPZW9QaSs1QXZh?=
 =?utf-8?B?QUVzeEFVZXRuWm5TcWZua2R3OXQxVVY0WDFIWUFjNDFKM3VMVzk2eHJEN3FJ?=
 =?utf-8?B?V01MNzRtcVhYb2k0emZRQm0yY0EzMm5ObjI0MzB6MGJ1WGpCdWlSRjdDRFJW?=
 =?utf-8?B?QVhuS1BLdFhaWWRxRktQQWROQk9LM0hYa3pIcGQwbXowTDN2bzN3ajR4VjIw?=
 =?utf-8?B?c3FSU2Z1Sy9lKzFtS0ZlNVNSUTd2QkIybEZqbldlUEN6SmhTQjZVcTlqalNk?=
 =?utf-8?B?NnVwdUJlenZtK0w2MW51aTR3UTM5b3Z6RFpPa1dsVW5yNndlQWhRYVc2TC9Y?=
 =?utf-8?B?aitUS3kvcFJ1dU9iTks5aW9wc1VacVgwN3hqeExiR1ZvZnhuOVhEeVdTMTZL?=
 =?utf-8?B?UE1QWWwxd3FoU05kRlBIRUQ3cVFiZk9LemJEbC82d1RaRWRJcEdIdjFEbUVp?=
 =?utf-8?B?M3p5dFRsdVc2aXFwNHpFK3dMRUttRHpQSVEwcTRPSXlmYVJGTmtWWnpGTXpt?=
 =?utf-8?B?RUlPWnkwTlRPNGZ1ZEd0RHdZNU0vVEh5MEc0c1QzUmJpL05leWhCdEFpUnA2?=
 =?utf-8?B?WmdnVUhSODdQcnBOT0RWMmFUTXI2Q0dkdmJ6OHQzdVJQTVQzYmNTZEZVNEFy?=
 =?utf-8?B?RHVraEdYOHMreDNLNllVdiszZWJIdmI3TkNjRzFVNk90NWIxRHhVRHYvYkhB?=
 =?utf-8?B?OWFPYU9kaTNWb0dkQ3JHOWt2bzVCWDh2cDJrVSsvRDJZRkk4cGY0U0tYVUFv?=
 =?utf-8?B?MlpuUjBxT1A4SkduWnVvNVhHR256SVc0THhHL2hQdyt5b0FJM1NvWFlIU3Bj?=
 =?utf-8?B?VkNXTktsRHdNbUgzRzk3MzNKSjZSWWZpbTUxcDE2d2xGY2tFMFprUjBXRGs5?=
 =?utf-8?B?cXRpVlV4cVNGWjVqWXh6b0ZQVkRRR2tQNVd4amc3a2NCTU5uSmN1ckVvNmdS?=
 =?utf-8?B?UVZUT3I1S2VFbGowL3J5cmtFYlg5enIwbTI3WkxhZHEvU0dweVEwdDNRY3lN?=
 =?utf-8?B?WHM5ZTFsTytickM2N3Z4bkZpazRLYlJORUNiTC80c1RDVFczaFMwajRUWXJ4?=
 =?utf-8?B?SGZHWUZLMVZCYXRCakZ3dTI4RCtCZ1kzTU55SnNJc1l0YmxRckJ5T2h4VzEx?=
 =?utf-8?B?b2FkcEJOQ0ZJdk5uTlpLRGM3T20yVlZTVll0NmRrNXAxbG91aEw3V05oRUkx?=
 =?utf-8?B?Mlg5U0RkUGt2a1Y1alJicW9wWDQ1SEVoZndQTFgzaUhVWUhtTnNPMXVzakUz?=
 =?utf-8?B?clp6RUk5MjBIK0VxVEQxRHBwVjdMait0WVgwcHVJNFRyM2ZsdHJ5cjlBNnBP?=
 =?utf-8?B?UFl1TmRkcW54MnJUT3V5VDJpekk1NjNaVDZzSGhRZjgvQnZpTlZuaU5VMGxG?=
 =?utf-8?B?VTlGbm1rbUFnc2Fpak1zbTY1MlZYQmJWSnlNVy9DdTFtYUQ5cDhHRE9NRHp6?=
 =?utf-8?B?bmhNNWFyQXd6TVcyb3gySjliSEdMcDlyNldndXJ0bDlOeUE3dEs3WHoyODFQ?=
 =?utf-8?B?OWsvQ1VMN1I3SXF2R25UMmU4Y3NkUDUreU5DeHVONTNLVTIweDlUNWErM1Bl?=
 =?utf-8?B?UDZSd3RVTjRZdnBsbktqc3ZESGlUUjhYcTY0NWZRQzQ2aDRnb0Y4L3RhOFI5?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f52f8aea-d43e-43fd-4061-08dccdd5b0fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:08:06.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25PzH+KZjAY7DeT39LJ+kfeMvZjgkihkxSeOSr+4lqJZ99IaPCH8BZmL4e+kfV6wORUOiPo0TSFnlpEc77e4Wp1hyvk2NRtUODRtudDgCAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/5/24 5:10 AM, Ilpo Järvinen wrote:
> On Wed, 4 Sep 2024, Reinette Chatre wrote:
>> On 9/4/24 4:57 AM, Ilpo Järvinen wrote:
>>> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>>>> On 8/30/24 3:56 AM, Ilpo Järvinen wrote:
>>>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
> 
>>>>>> @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test
>>>>>> *test,
>>>>>>     		return ret;
>>>>>>     	}
>>>>>>     -	/*
>>>>>> -	 * If benchmark wasn't successfully started by child, then
>>>>>> child
>>>>>> should
>>>>>> -	 * kill parent, so save parent's pid
>>>>>> -	 */
>>>>>>     	ppid = getpid();
>>>>>>     -	if (pipe(pipefd)) {
>>>>>> -		ksft_perror("Unable to create pipe");
>>>>>> +	/* Taskset test to specified CPU. */
>>>>>> +	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);
>>>>>
>>>>> Previously only CPU affinity for bm_pid was set but now it's set before
>>>>> fork(). Quickly checking the Internet, it seems that CPU affinity gets
>>>>> inherited on fork() so now both processes will have the same affinity
>>>>> which might make the other process to interfere with the measurement.
>>>>
>>>> Setting the affinity is intended to ensure that the buffer preparation
>>>> occurs in the same topology as where the runtime portion will run.
>>>> This preparation is done before the work to be measured starts.
>>>>
>>>> This does tie in with the association with the resctrl group and I
>>>> will elaborate more below ...
>>>
>>> Okay, that's useful to retain but thinking this further, now we're also
>>> going do non-trivial amount of work in between the setup and the test by
>>
>> Could you please elaborate how the amount of work during setup can be an
>> issue? I have been focused on the measurements that are done afterwards
>> that do have clear boundaries from what I can tell.
> 
> Well, you used it as a justification: "Setting the affinity is intended
> to ensure that the buffer preparation occurs in the same topology as where
> the runtime portion will run." So I assumed you had some expectations about
> "preparations" done outside of those "clear boundaries" but now you seem
> to take entirely opposite stance?

I do not follow you here. With the "clear boundaries" I meant the
measurements and associated variables that have  a clear start/init and
stop/read while the other task sleeps. Yes, preparations are done outside
of this since that should not be measured. You stated "now we're also going
do non-trivial amount of work in between the setup and the test" ...
could you clarify what the problem is with this? Before this work
the "non-trivial amount of work" (for "fill_buf") was done as part of the
test with (wrong) guesses about how long it takes. This work aims to improve
this.

> 
> fork() quite heavy operation as it has to copy various things including
> the address space which you just made to contain a huge mem blob. :-)

As highlighted in a comment found in the patch, the kernel uses copy-on-write
and all tests only read from the buffer after fork().

> 
> BTW, perhaps we could use some lighter weighted fork variant in the
> resctrl selftests, the processes don't really need to be that separated
> to justify using full fork() (and custom benchmarks will do execvp()).

Are you thinking about pthreads? It is not clear to me that this is
necessary. It is also not clear to me what problem you are describing that
needs this solution. When I understand that better it will be easier to
discuss solutions.

> 
>>> forking. I guess that doesn't matter for memflush = true case but might be
>>> meaningful for the memflush = false case that seems to be there to allow
>>> keeping caches hot (I personally haven't thought how to use "caches hot"
>>> test but we do have that capability by the fact that memflush paremeter
>>> exists).
>>
>> I believe that memflush = true will always be needed/used by the tests
>> relying on memory bandwidth measurement since that reduces cache hits during
>> measurement phase and avoids the additional guessing on how long the workload
>> should be run before reliable/consistent measurements can start.
>>
>> Thinking about the memflush = false case I now think that we should use that
>> for the CMT test. The buffer is allocated and initialized while the task
>> is configured with appropriate allocation limits so there should not be a
>> reason to flush the buffer from the cache. In fact, flushing the cache
>> introduces
>> the requirement to guess the workload's "settle" time (time to allocate the
>> buffer
>> into the cache again) before its occupancy can be measured. As a quick test I
>> set memflush = false on one system and it brought down the average diff
>> between
>> the cache portion size and the occupancy counts. I'll try it out on a few more
>> systems to confirm.
> 
> Oh great!
> 
> I've not really figured out the logic used in the old CMT test because
> there was the rewrite for it in the series I started to upstream some of
> these improvements from. But I was unable to rebase successfully that
> rewrite either because somebody had used a non-publically available tree
> as a basis for it so I never did even have time to understand what even
> the rewritten test did thanks to the very complex diff.
> 
>>>>> Neither behavior, however, seems to result in the intended behavior as
>>>>> we
>>>>> either get interfering processes (if inherited) or no desired resctrl
>>>>> setup for the benchmark process.
>>>>
>>>> There are two processes to consider in the resource group, the parent
>>>> (that
>>>> sets up the buffer and does the measurements) and the child (that runs the
>>>> workload to be measured). Thanks to your commit da50de0a92f3
>>>> ("selftests/resctrl:
>>>> Calculate resctrl FS derived mem bw over sleep(1) only") the parent
>>>> will be sleeping while the child runs its workload and there is no
>>>> other interference I am aware of. The only additional measurements
>>>> that I can see would be the work needed to actually start and stop the
>>>> measurements and from what I can tell this falls into the noise.
>>>>
>>>> Please do keep in mind that the performance counters used, iMC, cannot
>>>> actually
>>>> be bound to a single CPU since it is a per-socket PMU. The measurements
>>>> have
>>>> thus never been as fine grained as the code pretends it to be.
>>>
>>> I was thinking if I should note the amount of work is small. Maybe it's
>>> fine to leave that noise there and I'm just overly cautious :-), when I
>>> used to do networking research in the past life, I wanted to eliminate as
>>> much noise sources so I guess it comes from that background.
>>
>> The goal of these tests are to verify *resctrl*, these are not intended to be
>> hardware validation tests. I think it would be better for resctrl if more time
>> is spent on functional tests of resctrl than these performance tests.
> 
> This sounds so easy... (no offence) :-) If only there wouldn't be the
> black boxes and we'd have good and fine-grained ways to instrument it,
> it would be so much easier to realize non-statistical means to do
> functional tests.
>

To me functional tests of resctrl indeed sounds easier. Tests can interact with the
resctrl interface to ensure it works as expected ... test the boundaries
of user input to the various files, test task movement between groups, test moving of
monitor groups, test assigning CPUs to resource groups, ensure the "mode" of a
resource group can be changed and behaves as expected (for example, shared vs exclusive),
ensure changes to one file are reflected in others, like changing schemata is reflected
in "size" and "bit_usage", etc. etc. These are all tests of *resctrl* that supports
development and can be used to verify all is well as major changes (that we are seeing
more and more of) are made to the kernel subsystem. None of this is "black box" and
is all deterministic with obvious pass/fail. This can be made even more reliable with
not just checking of resctrl files but see if changes via resctrl is reflected in MSRs
as expected.

Reinette

  

