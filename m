Return-Path: <linux-kselftest+bounces-17061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC696A665
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 20:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ECD286424
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE519048D;
	Tue,  3 Sep 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMXc/1ws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D519047A;
	Tue,  3 Sep 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387776; cv=fail; b=CZ7fhoUOCUeKR31cMtLlfj/Czlm0BpERlad8dVzRnfRBe581GGe39BAXRev+1SJQS3owWpIIq0kkwpZAMl4UR1u29+EaHsQnqly08mpp8RGZAnPgtLoC4a19RUuuq30EGHvmB4sjUi+GkwcZEON5oL3fJVe2Ew/fQQWbsPYjnuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387776; c=relaxed/simple;
	bh=x0zEOD0oSSbTChbFRIRWnpODCJJb0t94VakDStM0jX0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BKZOaNG2L9kJDwNrNL9IPdKUL+T3XWjYH3e2yliSv+dwqshfitjyrbLf8jnJrPzMXFK+BogmzAvH2+/vNBTPgTeKGoM3mXpUcUEdzf36RxN8ESGsxn6ngS1n2NXieoH6USHObZ/Itm9pXBZWn9HiKuaRObmFZU6Y393U+9F+8iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMXc/1ws; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725387774; x=1756923774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x0zEOD0oSSbTChbFRIRWnpODCJJb0t94VakDStM0jX0=;
  b=hMXc/1wsqxqGYFVEgjEC1exJkONvG40rqSW/RcHsBlIrJ/NZNCKvrmnV
   t1Whi2oMYFLSXZ07PKiSCS8yyTjzGBf/38HPISO1DeLQQTRx3ahSQac48
   lvQQ87wsFudWsizIEoufRk75763B3JDo1GYa/jdJ3m9lgWk+sLS+yR0S3
   A2XLYLN4aqmgIkZ4O683jqzC/BXb7S/T5mb0+lMnsrogaBhFAyd1OPNmI
   WTOpspjW4lLN5CZKDpvBQGhH1KjrpUGGnl1TauAXknoMAX1NV5NaNDTKY
   lsWAB0jR2YrgyxZ8lP/d3nHLYJL74UHT9THK0a+6pkqHX4aiHSOeK27rX
   Q==;
X-CSE-ConnectionGUID: Te6FeAf1TM2qYsNMAFLyoQ==
X-CSE-MsgGUID: a5AdbaeCQuSOwXKAn59p9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35164747"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="35164747"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:22:53 -0700
X-CSE-ConnectionGUID: iAclhNIYR4i9hXP3Hb1HCQ==
X-CSE-MsgGUID: vJ+YFagRRza6MtRAUL/zjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64984868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 11:22:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 11:22:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 11:22:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 11:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3Ew9aHYkKPImhT9fyl4ICt+lFIynmM9OPJs9slFJ89N2UQF/kDDYvPg7gD6Msbm1j9CtegUasL1t40pS5m16exfx1xCBrKIuTSOjH23H0NrMlG0YobHWIxc4/QqIZ56sTfuaq/5UtJNfMiw14UEF0Mwf5Xd9d/qqRmznKyYailnQVqKncBfD03z95TxGt2sP9KIUfIw00Y4GQ3844qhO5aIwPpS3AUim1DZ8PHCluM30RC3kBWbOGjdGqrEzmE2OblE8lpWzgM+kMFcBPzTcsHcKy07SU/sQ9/+IEqADBx6EgsnrnVI5TJicxI8dvGJLrZuRb3DH0kx/ix4ow1Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sea+EErJFm+k0g9gJTuIfq0Xn+a5K9DA6/OVfJCpPE=;
 b=nZX+fWL5RsHGk7lJso07XLGRpUMefJUddbswdi86mIMHcSiq8fv32OjycgkncSVxWyUUH891pkPpL6UsmRn1mUDjChXUjiN+zg5MYgJlYjPovZA26QzavTMQKUjsJGPB73hLNQTyICEr0ghJQQroSHvs07wvjflTBTw7RE8qsCCSI4zxRCrXK8bw24bylpdtWdDOjS0adBmcM+clDud44kdYaVp7Lp8+yREU4neEJvU3HkrSLkUf6/pKpjLHLw6dW98d8UzBhl/xNne3Spt9vZa/uGiafPhFG79h8uj3rB7Q367qCTY7ptsSCE5MlHN4L1l/wFnYn4i2VaJ3j5Jg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 18:22:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 18:22:50 +0000
Message-ID: <611d1e93-6f64-4eb5-a054-4d92f076de41@intel.com>
Date: Tue, 3 Sep 2024 11:22:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests/x86: don't clobber CFLAGS
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu
	<fenghua.yu@intel.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
 <20240903144528.46811-4-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240903144528.46811-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 458d66ea-b6a7-4159-2b57-08dccc456b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEJyOXhLWGtVcmlCNlAxVjlqVjBWQnVYWExabU9QSGZSdlloa05xOXRwckFQ?=
 =?utf-8?B?RjVaN0NPdFJTeFMxRDhJRGNNZzNPMG5YbW9iYXVnenNCNi9xam9IL2xXRTVW?=
 =?utf-8?B?Q05GMUQ2TTlZZno4MW1oQ2NaQnY2UlIxK0pvbXplTXpHdXUzSms5eFVyS0Nu?=
 =?utf-8?B?RUp3aXZLWXMxL1gzTXhNQS91MEh5WGRROEJOK3lIeHFFWTVCN2JEeG52Yjdx?=
 =?utf-8?B?MVFPQ2ZPcmwwZDg3ZG5wanBtMWZpVEIwODFUMTI0aVk3ZW1Wem83UVZEQVps?=
 =?utf-8?B?MHNVaUFkV21lOFo0UlJvaVQxYmRnbjd1QURoZmJjTy9lZjZ6K2ZYcjhyWEdH?=
 =?utf-8?B?eFBMakZaa0J5cks0c2NrLytOWFVqWlMwSXZJcXYvWkMzOUJ5bEFjYlFCcXI5?=
 =?utf-8?B?RU1mdElrcEpHd1lBZGFXak0wakFhVmhtaEpEbXk2dFZMVFo2OGVlSnVTdVlB?=
 =?utf-8?B?VmErakpSWWN1SUVmYzFSUU40eXd5cUtTOHEwRmRZL1ZiTUlheU9zbk02TndT?=
 =?utf-8?B?QWpseHZENnRoZlpnei9Mbk01UlF2RUY1UEpjNkdmNER5eEV5Y2p4ZER6SW1v?=
 =?utf-8?B?WStDVVBRK0tCSHViOE1lWUNFaWlDZ3VpTmduZERORHFqVGJJRW9ZbGw5ZVlk?=
 =?utf-8?B?ZVV4TXRybEhvYTJuMk9mSFZmUVdoL1p2cmEySzdKaFR3L0VSMGQvckRmWjVX?=
 =?utf-8?B?UkgyTFMrLzlOb3B5VVRjNkYyd0Vmc2d4S3UxS1hDY012d3g2bzVta2Y1TTZ1?=
 =?utf-8?B?YSs0cEtjNlJxdVhnUFgxaDc4b1FyczZIVVdadWZaRjlCa3lBU1labG1LNFVN?=
 =?utf-8?B?UUdJRVdlaDBYdExkdHRmZmo4NG5sWW96Y245M1EyV21peWQzRzgzMWoyM2xt?=
 =?utf-8?B?K1hUbGtXNUR6b08vYUVBbFhSTExHaGFpK3A2VnY2Tk42MFJFaEZtWXdCd3Iz?=
 =?utf-8?B?LzdGVUc1aGNRNk9sTnZGb2xtTG9NSVFrU0RsZURmRS9SQWtVMjR0WjZQOTlu?=
 =?utf-8?B?WEZhRGdJU3h0ZEhZd3VBZEhuK0ZDenpFK2R5MHZXU3d0REZUSmQ2ODIxTkU1?=
 =?utf-8?B?UUNtcXBTT040N3BjSkpFSHZvcWk2K2FEcXNQUXJya2F5SE5uNUt1YjNqY2lZ?=
 =?utf-8?B?dnNJby9FYmhZVi9YalFVTm5kWVkwVDN6UFFVeW92NXBteklkSEkrOUxYNjBK?=
 =?utf-8?B?bHdnUFlxWXc3OC9jcjRiZXhXcVdzdVZvc21XUjdrSnNxNVJsc2hDM0F1c1Zm?=
 =?utf-8?B?c3ZyTC9KM0QzS0piaW1sRmh4UDZwMmRUMFFSeFpONkt5NDM0K21PeHN6Zkxy?=
 =?utf-8?B?Um40VHBBQkIwNHpnSXJiV0UzZk81bWZsRmo2c3NnUlRQR0xRV0ZKZklsNHJh?=
 =?utf-8?B?c1lHTzhTTjFkbm8rWThHc2tBdW84ZFdpSEhaMW8xWnBjNUNNWEhMV3JZRGtN?=
 =?utf-8?B?Z05LT2RldzNEREZYckhwNmZBdFRrUGwzTmFqMDdRUVVHOW9JbUVUdDVkZFVo?=
 =?utf-8?B?cm1FNy94aTVwcVQzTGFzcmw5anEvTUlzVWtEaW9vRElFS0JwMXNTMENNanhC?=
 =?utf-8?B?TkJTeXo1VkJ1dlB6dThMTFFRQldtcjhHZUFOMjA2NUVkbDh6NHlEQUlnVFhI?=
 =?utf-8?B?WTJwaHg2ZFluSld6Sld6eGlTU0tRU3FaWTBIZTZZcHRwV01odG1VTE83cEZG?=
 =?utf-8?B?VUlYWWNEc20vbWQwQWpvZ2E2eWN6ay9ubWFZcDU0dkMyekVjaUhNVXFoNnZE?=
 =?utf-8?B?ZDJadlNXMlpYUTNBK2lVMWgyZlZHQ2ttelZLMEJIQ2lHVmdVTEV1S0UwK3Y1?=
 =?utf-8?B?WG05d0FOMnRobU5mYTZsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9uTUlFemFVUU5UZEtrOFVkTk5kK3NDdWRPWGV6d2RWVXN5WFl1UFJrNGMx?=
 =?utf-8?B?WC9ZVVQ1K0RZK2gyWTRRSmorU216RHFBOEFNcTdUWnE0aG9xUy85bVNycURP?=
 =?utf-8?B?ZWpMMjNXQVd4aUh0SG9SQnlsVkdFU3BMamlpam1Rb3RxZ2d4RDJpQzVCbHd2?=
 =?utf-8?B?K05McXd5T3BMU01wZmtoRXgwK1hUSVA2YXVJWlJGRlUweXN5VnVFNCsxa2tW?=
 =?utf-8?B?ZE5jUXg2U3B5Q1RsL3FtazFiRC9OMWZNMnFyeGFxWlArMjFJSFJ4cWh1WFFT?=
 =?utf-8?B?a3hFcnYwejZVbkdRNGJnOFU3QW4wbzEvclptMURia2ZMYjhsWDNaZFVWa3Jn?=
 =?utf-8?B?a043TVpMamV2eTVNd2UvbHFwY2VDSkw1UnpQM0xzTDVsVCtTU3BkaFl5aUpu?=
 =?utf-8?B?ZXc3L0VDT0tuYWxZeVhoc2dOUjNiVHlDR0NqSElMWlZ6c0IrdzhXVnhGSDRN?=
 =?utf-8?B?Q2FQN0FubmttaDZhaWVhWmNyeXgyTDN3NSs1NHNRcXcxeGNKRE1qOEpjN0Ex?=
 =?utf-8?B?RmttNGVsYklWRVZzTTZZcVg3K3Zxcjd5azByU0V6K2FmR1l5LzBOOGxCUXNE?=
 =?utf-8?B?N0ZKTHVtSGlZTW5nWGEvTU44Z0hXMjZtOHhDN2UxT2RyNHNqb0tNUmk1QmVN?=
 =?utf-8?B?MHkzQ1FvUjVBYVZJVlM1VW14MmVwRnlXQXJRdkRiNTFrRlpvd2t3VnUrQmlV?=
 =?utf-8?B?MHlaczZMaFJJTEhjUlZIcmRiTjl5MWNLUVk1R3ZFVHhXUzYzWTZLOUNMcTY4?=
 =?utf-8?B?UVJZS2YydVVXbE5sakZKMk1lWlZ3WFI0K0p4ZzU1VVgzL3A1WnJ3RTJwWXpl?=
 =?utf-8?B?UjFpNVQrRkhwdUl1dHhPTnE0VDlIcFJBVXhSRDk4NHZKdVlyYUxGNWIyVW5X?=
 =?utf-8?B?Qk1xL2hCbTRNZ2ZGbzUvVXJaeXBsTWE2WnY2MHdTeFJoTzJyWndTWUNUU3l6?=
 =?utf-8?B?ODh5S2F2OFdjUDBrckRYdzY1a2NsRHBMVWhCTnk1bTlnSTZZeXU1ZGJwOGhp?=
 =?utf-8?B?YXdhK0dnMmU0N2pKaE8zSmtOMlNMYlJ3emxNOVZnS0JUdHViSnl6YWRmdEww?=
 =?utf-8?B?RE5zVnZmakVwQThvd3JtYmRpaVFRNHgyNmx1TXd2YmhpRVAyK3NwSytvK0Jt?=
 =?utf-8?B?cFJCOWxCZHhBZW1DY1ZkSDN0c2FhRC9acW16d08wMC93Q09ITWNCVWFIeGJ2?=
 =?utf-8?B?djZRSHhSdlFNVUFNNFRXWlgrMWNoaHk3aGswdjJISTdzZ05PdTBDdDd3UkdR?=
 =?utf-8?B?SU83WnBaSlN5ZmhTaklvQWYxOXZ4NEdLSk5wcTJRV0FkNzEzTXZ6dFdaZHBw?=
 =?utf-8?B?cUhkVHhxcmx4Qnp5MVhYRXptUS8yQWJTZFZJWndSYm94NllGQjE2TGVrcDh3?=
 =?utf-8?B?UFVzTC9ZVlFTeFlRcjBEcHBZMjRZN2tGWkZ6cUMzMFUvTTV5NXdwTU4xbFJ1?=
 =?utf-8?B?UXdhMmdjOW5FbUw4dElvQk94TEdEaFZFYml4ODJYSEUyS1FETERXbmVnYTBj?=
 =?utf-8?B?WUlYdG8yTFNWWWhvVXIwNzhsVEJvRzJWRWJDTDJ6V2s2L25kU08rbkkzL3dM?=
 =?utf-8?B?WEREdlI2YXVkOTlmWnZPU3FaOVB5SEdHSEZIM1dkUHNTWXQ3VVFkMGI0L1hw?=
 =?utf-8?B?dmR0Tk1Yd0YzaDRtNjBmNVgySDhTV1IySTdDOFhpWEgzbmFnVVgxUmQ5TTRv?=
 =?utf-8?B?TVlMS0pjaVpLNVkyYnV3K3BwUWQ4aWpLTDFkL2NBdHBtNmc4SURkSUcrU2c3?=
 =?utf-8?B?RFBzK2FSbENoWmR1NGJvZVp3Vkx0MFV3ZFcrcEdJcnd5SlhQWHVXUHh1cUR6?=
 =?utf-8?B?eFgwVHFKWnc3YldqbGo1MThpR1J6ZVJMZDBnUnIzM3R4Q2N5L28yQ2Rwdkl5?=
 =?utf-8?B?Ym1RaEJld2l1ZVVRODlBZGNGQ2RIL0xCY1JlMWpIOHVTK05WZlpuQlNSMUha?=
 =?utf-8?B?NTU0UjBVV2RaOTBFMG80V1d2TkMrMkw3ZTJPcGJ4QmdGMjMraGY5RUE4TWE1?=
 =?utf-8?B?RjBxUjlsNkNhcXQzRmlDTWxJTGJEWjdnVGl1ODE1WWVzdXVTczVHeVR3Vmgy?=
 =?utf-8?B?amcvYVdySUFIMDJPZTY2K0RpWnA1cGlwTlQyK0ZTKzgzTHNmaWZXQzBsQjAw?=
 =?utf-8?B?clZzNk9KdncvOFhMU1lJOXQwbWlXcFFtdmpiVmhzSXBhTmFsMzFtb3RBS3VY?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 458d66ea-b6a7-4159-2b57-08dccc456b03
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 18:22:50.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+8TWjAoiThSH5Z/paQGtEsdpHRIw8SxFe73kGEjGLUxxD4XYmKLv1Le80KVL6M21DnHSIcmsr+DHX3PZm/B91uHm73X8Yt0NLCmQ+dEP8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/3/24 7:45 AM, Ilpo Järvinen wrote:
> The x86 selftests makefile clobbers CFLAGS preventing lib.mk from
> making the necessary adjustments into CFLAGS. This would lead to a
> build failure after upcoming change which wants to add -DHAVE_CPUID=
> into CFLAGS.
> 
> Reorder CFLAGS initialization in x86 selftest. Place the constant part
> of CFLAGS initialization before inclusion of lib.mk but leave adding
> KHDR_INCLUDES into CFLAGS into the existing position because
> KHDR_INCLUDES might be generated inside lib.mk.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v4:
> - New patch
> 
>   tools/testing/selftests/x86/Makefile | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 5c8757a25998..88a6576de92f 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -1,4 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
> +CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
> +
>   all:
>   
>   include ../lib.mk
> @@ -35,7 +37,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
>   BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>   BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>   
> -CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   # call32_from_64 in thunks.S uses absolute addresses.
>   ifeq ($(CAN_BUILD_WITH_NOPIE),1)

These changes are becoming less obvious to me. The first two
red flags are:
- Most other top level Makefiles assign KHDR_INCLUDES to CFLAGS
   *before* including lib.mk
- What current Makefiles do matches the guidance from
   Documentation/dev-tools/kselftest.rst as per example (verbatim copy):
     CFLAGS = $(KHDR_INCLUDES)
     TEST_GEN_PROGS := close_range_test
     include ../lib.mk

Looking closer it is not clear to me why lib.mk sets KHDR_INCLUDES.
As I understand the usage is intended to be:
   make TARGETS="target" -C tools/testing/selftests
This means that it is tools/testing/selftests/Makefile that will
run first and it ensures that KHDR_INCLUDES is set and supports
the usage documented in Documentation/dev-tools/kselftest.rst

One usage that a change like in this patch could support is
for users to be able to run "make" from within the test
directory self ... but considering the current KHDR_INCLUDES
custom this does not seem to be supported? (but we cannot
know which tests/users rely on this behavior)

Looking further I also noticed that
tools/testing/selftests/Makefile even sets ARCH (but does
not export it). When considering the next patch it almost looks
like what is missing is for tools/testing/selftests/Makefile to
"export ARCH" ... but that potentially impacts the Makefiles that
do manipulation of ARCH.

I initially started to look at this because of the
resctrl impact, but I clearly am not familiar enough
with the kselftest build files to understand the
impacts nor provide guidance. I do hope the kselftest
folks can help here.

Reinette

