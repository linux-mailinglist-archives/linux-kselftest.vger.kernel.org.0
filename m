Return-Path: <linux-kselftest+bounces-22796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A639E2FCE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687662833D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA7202F84;
	Tue,  3 Dec 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koB2sxhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B61DF268;
	Tue,  3 Dec 2024 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268415; cv=fail; b=IgjHPwzhEvdkedS5OMg8TpyRmFkSHUuPv2kDxg2LICQ/TrKrkAOmngXsfA0pBQJLwK1U7GkzERyZjpQTGVDif9eCMOI4gT5kpy9m+N2w9/JBrSF3E9vTYHC+pbwFcqR7NwO/J+L/OnNtkhw93ulAgDizNz9GSFSKl/EBueX2kWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268415; c=relaxed/simple;
	bh=IWeYIvEf7QQK+tlojqPgtCrQvoQ2FGEuGNy+rjoyanE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KStdeunErrC5VIBYK01c6RSzOaF2jo1RBVw/u4OTWjPlusYUfsmfOMroxHTOtQSdxxRWa2TlcX6YuzxqCGMtzOVL3ItPHec4OYCR6IV+YqNQaAiUk5KSObW2YGtrniIJCoj7MRfXFzzo1D4EbECITW5oI2T5276BEutmjxAgKsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koB2sxhv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733268413; x=1764804413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IWeYIvEf7QQK+tlojqPgtCrQvoQ2FGEuGNy+rjoyanE=;
  b=koB2sxhv4rS4rx0WjRkNBbTWkMQ+CJJ8VIhmNPeRZbq8u39nOvo6ThgO
   k3IOvsxRbXKIr4mpeY4saeoMooynHHX+xaHJrCuPDK5Va1fIWKX31L14j
   jqJHk77islrK76xqLonlO0++vesOl4DEK+9KL0HaCJhFq07H/0HrDwGaJ
   TOjg55byiTBMhk7/UBwSsa2fUWcxDXsw55HjKU+1nYKtK8gpWyLxUkgdj
   xo/R5psN8nrMQnaaTOr36/pxEwBFPS4OlGL/7HvFhwfCykJXBVe2BAXyE
   PejFVaKVg7wL3guJh4jUXaO904y5Dl4vMgC4YHd2ssgsWWobDBxGPKkqD
   w==;
X-CSE-ConnectionGUID: W0EZSIGbTFKa7eM6ligTTg==
X-CSE-MsgGUID: ziSE3CFiQEGfLh073nJyOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37169469"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37169469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:26:52 -0800
X-CSE-ConnectionGUID: 2t7GV98OSZy8SnydWQeXYw==
X-CSE-MsgGUID: ZjQbd0FhQOqwXO3trdNlFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98664894"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 15:26:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 15:26:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 15:26:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 15:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv18wTX91EpnIuOEY7bU6rqRa0Ht0a9/oRZFruaUBa87PpU4rNthsz4EtiUWJrETeIn8Bjl+/4nbJekp+C85nBb79NqXX6rgotU/uQm7NjPPHPjKjkotS0U4fdc9ZJj7K7fB1ZF8xJBTk8foumisVT6BRNASHEKJMPLVXoh1fQHDaZgUWvTTt8UlnIJWx3A5773ata+FG5LMC7ObL0M5q5kSKSZK7kFT6myRJo4hHflWTD/v5BLTeESt/LVHJsbeVh/8DZRX1KJhxawGIGgNiQMTUDZf4JWLXYRtfMZ8nbr095/imLiOPYzappBksiRx6xVaDac/vVghaEmY+2QRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaquCD7V2Bdw8Rv2FnY4j6RHS/P3xyMnLYbImHjtnRE=;
 b=R1HCBzu+JCrYEJwm5XuzPVdWIRm1FmDWlG96SvrqrwecNZb6MiVX4qZ8jkCpqiU1xgJuMBNlFoQQFlcrxYFYVMopZ3OiFALgbWpKuUdMIX77rJdE+a+1aLqlcKjRdQl2H8A1UIBt86mkY3jAs3Mqes10BXOrBcKPRV2dt0Rmotu5RTgFgZkbkDFyFAOR1zIOQr37POs/peYHWG1i1JG8h0IdYDHsyY+yExhcwksryt5RC/ZCuA+Kiybj6oHUtcT6GfKhBtBfa0wveEg88PpIYC0LQci8w/MlfintOTT6Dw4bV9MC4sqB/Xc+kia7iHcZCA/Lg9DCkBQ7FaVlXSu8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:26:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:26:43 +0000
Message-ID: <d7353315-9183-417e-8501-8beeb4e77085@intel.com>
Date: Tue, 3 Dec 2024 15:26:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
 <c708db702405eef5c6796502863c9142c8a0bff8.1733136454.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c708db702405eef5c6796502863c9142c8a0bff8.1733136454.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 157ef371-2a36-4be7-dffb-08dd13f1f261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVlzalN3dVppV1ZhOUNWT2JVRERXQTVZS2ZadWFtL2pCQjZDZ1BDVTlDUkxu?=
 =?utf-8?B?dUlzSm5vZ0xUREFpaEN4MVdKY0pZNmpERFNlV0xJa2dkV2lqUmJicGhlM2da?=
 =?utf-8?B?dlJaUU9tZS8vd0psODI5U2VPeUJuRzlNNGtKY0NONEpxT2lybUF4RWk3dEZY?=
 =?utf-8?B?OUh4WGhOaDIyTVFzaUQzMWx1QjRzeWlidzJwUDNqYXlUdUxuek5vK016NUdG?=
 =?utf-8?B?M29lNHpNNDcvVDU3YnlCRllCeEdKL1VoODgwaXFaaFdOdlg3VkVBZS9Zd2VJ?=
 =?utf-8?B?Q0tmY0F0Y1dlYldwTys0RXlaaUNKWGNqaHhZUnVFN3l4R3BoakRXTXVSNklF?=
 =?utf-8?B?RWEvYVVTKzNVTW1zWXdrS2E1dGlxNFMyUnR2dTRFZTNHR01CRmNXMFlIMDRP?=
 =?utf-8?B?cEFLZjBmeENYNG9oQVJLQTAxL25jSk5rUzFmbHRjV2ZzSmtONXJ6YlQ4VEJB?=
 =?utf-8?B?M2c2TlZMTXJ3eGlveEJTWmp1aUhpdnl3Y2RycjdtazFpaE5mUWJ2SjdvV1h2?=
 =?utf-8?B?ZGNQSklhY0FLVzByR1NHa3FZdTNmdDhJTzY4SHNLeHR5TUNHT3kwMXVtNkxU?=
 =?utf-8?B?R3I3TlJ3WlBibDdMNGh6OXdhUXYwYkxNdUpDSVRvTXEveXBGM2FjNFFDNGxE?=
 =?utf-8?B?ZGJMZ1l6RllzNzg1VmtQZHhVR3hFK2UwODJaQ2hSSEprSW4xQVZHT1lhN0NN?=
 =?utf-8?B?TmhrR3RjcFYyZy9ReUdSbUw3cjNZRlNKSytPd3Q2bGtpd1lkZFhnWmJ5alEr?=
 =?utf-8?B?Ylg2S0NJQVRqUGg2M012K3NVL3BIYkFMVWFsdERYMmx6YkV3VHBkVTBJNHdV?=
 =?utf-8?B?UFVvU1M4dTBxN240THlZZXVyNDhlcmprbnZWeVFaVUlBU0IwQ0dCK0VXaTJB?=
 =?utf-8?B?UmpMd0R5bDdhbWtrem0zdGF3K3NlNWp0Tkw3UENDUk9GTHZ0Y1Z3OWd0QlZs?=
 =?utf-8?B?c2RlNnoyV0VMaGRaL1pJbnFmelhZQU40UnpZRVQ4bytKTnBMeWx2bFpEZlY3?=
 =?utf-8?B?MFM2R0dCWGt4RjhPVjJydzlyOUFWazhEVWNHT2RIMExZdThmMW5nd0o1Njhv?=
 =?utf-8?B?eWJJUzN1dmZ6dVViTUlmSWNlTStSUUo3VzMxMVNoa1B6c0p3UGtkVzMzaE5W?=
 =?utf-8?B?MnpTMEdzTXZhVFFpYkkxV2ZBdkNnR3QwcHR1S0l1a0ZVLzhWeG1hQU12RDZD?=
 =?utf-8?B?L1BDVWxwbW5Mb1dCUFZOL1pKbk9hdDJZdzllNGc1ZmlVZE13NXVLd2k5WUFF?=
 =?utf-8?B?QktyOXBkQ3AzeDdqcE0xSTRpTjd4cFZoYmg5VU40aVphVUwrTXM3c20xSHZ5?=
 =?utf-8?B?c2RqalVidVk0cGN4MUFFYWR0U29MaDNPSi92Rk5SQXplZHgrK05rOXQ1aUtZ?=
 =?utf-8?B?cmJOQ244dnByN1cySTJzblk5ZGFVTWZmdThIdkZNbGl3VTVDMnpOV21iQVZU?=
 =?utf-8?B?bmdWS25uenhYeWpSclVaeG1sdnhqQ0UzWnhpUEhTRWV0MlI4WmFGVng3b2ta?=
 =?utf-8?B?aUJZWS8xZ2o4dy90MnR2eFNZdkZ3U05xUDlwQTBUejBVT0NQWTFob1JJWnR0?=
 =?utf-8?B?VGhCUHMxWVpBRkR6bm8vNWNmb1U5ZVhYVFpobFdGMFpHT0tmazZ6bHFTTjVp?=
 =?utf-8?B?aWlmd2ZUVHcvR3BzbVZEdmRyKy9KRVJ2MVEvNEdFSU9lNGp0YldjMCtRVFln?=
 =?utf-8?B?cmkrR2dpa2Ywdkw4WU1ZNkp0b2grbFhVN3hLenpRdXdHam1ac1ROQjBWSzBB?=
 =?utf-8?B?ZDMzMlAzY25qYXNVQUJyNTlTZlkzdFJMdzQzQVF2a2tJbW0xV0RvM1RHaWRl?=
 =?utf-8?Q?8qlRJiRyRhTLAxL+n8V6fmiecNzVSs6qi9WeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amprL3FOMXRxN21ZbmdVMlhsWjFCNjRNRmN2dmNpWUNyemJNSzdmTXJIVUpt?=
 =?utf-8?B?a0lJRHpvUnhCTzBzSGdWTmp4T3VSSnNxZjlpNWdYT2xWeExsK1N0b1hmZXBw?=
 =?utf-8?B?eXh4eWFiRmcvTE52YUVVWDNxblNxbUJzWFJIS091Q1pSQWFzbE52bGRpdzFO?=
 =?utf-8?B?cGVMeTB0cTRLT2ptZVR6Q2N6SW5TaitzNXdiRmFZbExLL2dqZS9ubFduSmNF?=
 =?utf-8?B?V2g4VTMzZXBMUkNQUy9GSGgxK01RdUc1K1RhdlNZWlRGVC9ZUG1QeUtTMXZ0?=
 =?utf-8?B?RDA4T0tORzUvUlZiNitWdk4wb0lQRDJXaldzNHhjYkZoY1pNc2NEcjZjMXBy?=
 =?utf-8?B?VGMvWTRRVWFuUnZXVUxYZ21FWVFYbWhjZlp3UzR1RXFjbTdEQXNoTGVLQWZZ?=
 =?utf-8?B?LzI3d014UE1wNkVUL1Ywd0tEZDUyNWJWaFY5TzJaTmZKUzZDRXdJeU5jZkpp?=
 =?utf-8?B?ZmpIbmJabElpakxCcE5QTjhvcWZ6bGhZeS9wRjdxZitLU3hiZE9pNVdmd2cx?=
 =?utf-8?B?ak96RitJQytqc1ZQS2JDREVTTWEwTnFVNXBpbFI2bUlPTHUwRnVPdVl0MzBC?=
 =?utf-8?B?aFFqbjFrYVpmeFJzREtOY0dtYzhCY0tCQzNHbkM2eUNMY2xsUFhZL3RUd2w3?=
 =?utf-8?B?MG54cUt1b3BLWjgyNGFtUkJjaXh1dit0VmhjWk1EVW52YVdHV1ZvQUhXMHZV?=
 =?utf-8?B?TFNlZENWUEF3MXlYSXBpUjFHTVd3ZFVRSENJaU9HV3ozSElFYjJrYkhrR2U3?=
 =?utf-8?B?SFV1M3JTQ2RSVmNwTUwvaXpaejBub1REMlJyVzFBTEprSlhhb1A2VkpjbW1J?=
 =?utf-8?B?V2F1T0hGWFBJSkhqckc1YUpKSnhnQTY4YmpjUnYxRGV3NFRRMjJVNnB4aDIy?=
 =?utf-8?B?RzhWWFJJT01TUUQxaURweXB3Ty96MDlkTnQ5aTNsQ1FGUHlndDZGSWowK3NW?=
 =?utf-8?B?VEx5RzV2bUxhWVg3NW9TQ3ByZzVqNWowUGx5MFF4ZlVvcUw0NGVIaUgzMzJY?=
 =?utf-8?B?dEVaQUpPYitKM0RTOFIzR2grak43WnNKaExsN21mcHQ2VDNjN0ozL29xdWRJ?=
 =?utf-8?B?NENZY1QrdU14Yk1HbGJiWnBiRk8ycWhCWnl4elZkZjR6VnQ4MHFSL1ZPa05p?=
 =?utf-8?B?SkpUdVp1VkNJU1FPMHJiazJ1TkN0LzgwZWVHZW1JUTZXWVpjMDVCdnRqMDlz?=
 =?utf-8?B?Z2hjbDN4bU9vU1V2OEhEQ3I3dHhnNzIwOWJMb3psOGVWREZkUDJkY2F1R214?=
 =?utf-8?B?bkFLNWdFSkRiNEFIZ3JQMGhrVzRqWjRQNDIrbTdKWG1IMjNtVHduVGZqRFZl?=
 =?utf-8?B?ZVREbUljdDdrY1BzZ2dhdlVlVDBJMi8yR1F5TzV6V1NidGNmVlFjcGJNZ2lo?=
 =?utf-8?B?SGVHTGVMUDlac2NwY2M0VEdCRUJkUWNodjBKaEtmWlRHM0F4eTh6U3RrcDV0?=
 =?utf-8?B?M2RKbGNOTGkxbnJZczdDV2c4V2NHcE5HK3NTVmRTRCt2Z1hvMDNRa0V6S1k1?=
 =?utf-8?B?SitRMjhqYm5GSWkrcEphN0dFNnNObG9LeHgxMVBBT3ZyYlpvYjNWTEVKRkg3?=
 =?utf-8?B?d1JtQThDYnhqdmZOTVduMmpzbkdxWWpVSGpNREtFS0lUa2FHNWdhUDNRSlI5?=
 =?utf-8?B?UzFmd05DemtReStsdnUzekdXeFlrdWpPUWVIdTJEUXM2WlVOaVNxdWcwSlpK?=
 =?utf-8?B?RS9PM1hLV2NJcXRWc2JKK2hmanBMN0kxMXA1OEI0Tmw2WWxXOUJPNXp3VTRl?=
 =?utf-8?B?L29TSkJHYlIyKzJjTzJ4R1FjRWd1QjU0Tml0WFFiMmVkeVpqdExNUlRTZ3J0?=
 =?utf-8?B?ZVdtckp3NEUzaVQyM1BlU1kyTGd5Uk84OTduVitodFJlN0l5NHppMGU5SzRx?=
 =?utf-8?B?TEEzTUJjMVFlTTdsTWxvN1pxbnNhNWlXck1oalBna1pEbjNVdHJ4UFRQSER5?=
 =?utf-8?B?cUJMOSttNGdRSldhRjArYmhnZG9lenFvWExTc05IN01zMm8vN2JmVU5qTWQy?=
 =?utf-8?B?NXJaS1g2dEwxT2w4Y2QyaVRIQTNTRm5XTXRab3NWQXRhNU5sQ1FDMDVJVFI1?=
 =?utf-8?B?cFhSeXpDUUE3UHNRdnhlYUR2Q0pJcy9jWEtzam5lNHp2azg1Q2xtTnBaSzBO?=
 =?utf-8?B?OVk0dnpZSTR1Wkdvd25sbjl2bEcwbE9UTW42WHQxYWJ2a3hCakZmblpUK01s?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ef371-2a36-4be7-dffb-08dd13f1f261
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:26:43.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kD72qs9sBmv1im9/mNawLGJKAHHtfFKxxetdvshgePI+bJYebi88ufQLpXSLwSXiJAi7ojCti1F8xMA6edOSn9HZTMLNsSxvdQ2unW/G9TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/2/24 3:08 AM, Maciej Wieczor-Retman wrote:

> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index d38d6dd90be4..50561993d37c 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -13,6 +13,8 @@
>  
>  #include "resctrl.h"
>  
> +int snc_unreliable;
> +
>  static int find_resctrl_mount(char *buffer)
>  {
>  	FILE *mounts;
> @@ -156,6 +158,90 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>  	return 0;
>  }
>  
> +/*
> + * Count number of CPUs in a /sys bitmap
> + */
> +static unsigned int count_sys_bitmap_bits(char *name)
> +{
> +	FILE *fp = fopen(name, "r");
> +	int count = 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +

running this through a syntax checker triggers a couple of complaints due to the
missing break statements. I think this can be made more robust by making use of
"fallthrough" and "break". It looks like this can be obtained by including
linux/compiler.h ... but from what I can tell care should be taken to set
the include directory _after_ includink lib.mk so that top_srcdir is set
correctly.

> +	return count;
> +}
> +
> +static bool cpus_offline_empty(void)
> +{
> +	char offline_cpus_str[64];
> +	FILE *fp;
> +
> +	fp = fopen("/sys/devices/system/cpu/offline", "r");

Please check fp before use.

> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {

This needs something equivalent to 
46058430fc5d ("selftests/resctrl: Protect against array overflow when reading strings")

> +		if (!errno) {
> +			fclose(fp);
> +			return 1;
> +		}
> +		ksft_perror("Could not read /sys/devices/system/cpu/offline");
> +	}
> +
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
> + * If any CPUs are offline declare the detection as unreliable and skip the
> + * tests.

nit: "and skip the tests" can be dropped since the function need not make
assumption about how callers will use it.

> + */
> +int snc_nodes_per_l3_cache(void)
> +{
> +	int node_cpus, cache_cpus;
> +	static int snc_mode;
> +
> +	if (!snc_mode) {
> +		snc_mode = 1;
> +		if (!cpus_offline_empty()) {
> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
> +			ksft_print_msg("Setting SNC mode to disabled.\n");
> +			snc_unreliable = 1;
> +			return snc_mode;
> +		}
> +		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +		if (!node_cpus || !cache_cpus) {
> +			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
> +			snc_unreliable = 1;
> +			return snc_mode;
> +		}
> +		snc_mode = cache_cpus / node_cpus;
> +
> +		if (snc_mode > 1)
> +			ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
> +	}
> +
> +	return snc_mode;
> +}
> +
>  /*
>   * get_cache_size - Get cache size for a specified CPU
>   * @cpu_no:	CPU number
> @@ -211,6 +297,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>  			break;
>  	}
>  
> +	/*
> +	 * The amount of cache represented by each bit in the masks
> +	 * in the schemata file is reduced by a factor equal to SNC
> +	 * nodes per L3 cache.
> +	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
> +	 * allocates memory from its local SNC node (default behavior
> +	 * without using libnuma) will only see 50 MB llc_occupancy
> +	 * with a fully populated L3 mask in the schemata file.
> +	 */
> +	if (cache_num == 3)
> +		*cache_size /= snc_nodes_per_l3_cache();
>  	return 0;
>  }
>  

Reinette


