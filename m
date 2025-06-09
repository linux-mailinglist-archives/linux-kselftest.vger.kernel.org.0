Return-Path: <linux-kselftest+bounces-34496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918EAD23F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5BB3A2FFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00B212B3A;
	Mon,  9 Jun 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVBm3buh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034523A1B6;
	Mon,  9 Jun 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486876; cv=fail; b=HW767J0g4TxGYomSInyYJUStVezb2XSgs5/W6YfhoEUypdvH1Fi4vyi1nibaD1QStLLeDTm7/RGR/Aj64YShE+xh4Dml9UJ+FlrntTVqOfKwNSbGmEdCZVu0xCtoHR/jD9A6lHP7BJWS6liewN8nX8XoesK1kVHu1oSNrG6jZH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486876; c=relaxed/simple;
	bh=RyBXszOHDMA58Bbht2PNr3Mz0wLtB/cEqIPMI2iIst0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klHZXzUp5G6gj+dRld05xr65X1UI0Qh/vePsFI7rvJjdr7IpQFO7GFEufiLBJDDe1+5eTK8ZOA8D94sH50U89N++5EYQwdbH0bS+INjopMvFu8aNWZCQ15Bbl9CVXgGGs4gyrsKn7DsBl7MVxDrR5JfXoI/V1Nv2Y3nCPaQmzzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVBm3buh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749486875; x=1781022875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RyBXszOHDMA58Bbht2PNr3Mz0wLtB/cEqIPMI2iIst0=;
  b=nVBm3buhOol2AKHhoQzyxHV8J7w6B8GdTf8OQOynS38kjjuwvxZiXpqV
   50+9srj3aF8wGWFwE9VaSwOeqxQiSFZIIqQefiE553mEi7We9+P260a6m
   vTnjioQpZ6KK3JKXTXGp7cY5xWpAXp1/rwRir8pgoaDFu28o0HKqWg5Ob
   W3VJSrAe2RoAEbrTIdZ6ItuEMVtv8pN9yQgx0c3sWX+Hi4G+o5dciP+O9
   AToz5FX/ej+gXqlTz28rp14AnPB/bXZHSsQA/S9oQrgYfC1nE3khWaU5L
   5AbL49DatshvQaFKgvQoK52njp1iOQH71G8VxSjbC4WFvccqcOh+KwpTZ
   Q==;
X-CSE-ConnectionGUID: zxOYaK0WTWGAPa+6wBHIiA==
X-CSE-MsgGUID: zYKgGw9JQEaja+kdeLCNMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51278654"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51278654"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:34:35 -0700
X-CSE-ConnectionGUID: ygKksHNBSbKcyMBoThKkCQ==
X-CSE-MsgGUID: 0t0Jg2N4TR+Rq7JOCwrLCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="150402823"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:34:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 09:34:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 09:34:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 09:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuQ43G4u4lrJlYdqyIf8aX3eA7yQUzlaxkD2ZQ1MHQyQ6W6T5U9fWm04QKdd3Wzcxz+Gu3DlF9fh6b30Jktk6IfIv6sIsROPuBWiEi8P8KAmCK+OCNHDFlpkuOYk9d9bcfZqlrMK4W0Dlfq4NdiQvO5LsIR8v3aVqo04XE7um3uVQJ2SLpurdOAEN5+Q2jV5GDabwaHUQUaDdWuPiyDuMFRArQmpra2yDIT1Q7KBfVExbbBsC6Rq1dtZB5mc62RHknNF8u1AffOIsIt1ce5K+o/jR1qCGtP0RbTCjaFrbadAk3QHDcVrFRnZdcFR6uPyeUUYHYYbUOvFVCDa9KzlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uha44ENY+QvecICQ5SK7Yj1C0hbNgo3eyedJx+bXMJ4=;
 b=HcqwPHPFFgUebq/xQ0XewC+INBV9j/HiT2xbKNrtQdXNDOOjIDLaOzGn9pLofLxz/1DceVE3BMHQ33HQDMWJMrxrNcZGkaw/HDUmsK2g36TmX321f07obi64GybivE/e6q3Hx6rLiVQKKFsMW1o7rCqVwdN+BlB73X/VTmts1XrtKMj6xpRHwVnvip1HMQ9r1kbEjAMHYH0VIgEB8c5FkIF7RZHY1NqMxeZWRQLIi+TaWRbqeub/16PxuNaBaGkv0Fky53ujgmauZAPY0m2btZ9eAQyWVgqkgw8EmJhQw4xA5rLFQYQkFhmtdTQjzbW1m5fbIeRnvn5mDJqHElCeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.31; Mon, 9 Jun 2025 16:34:30 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%4]) with mapi id 15.20.8813.020; Mon, 9 Jun 2025
 16:34:30 +0000
Message-ID: <a31448d0-bc0a-4bc9-8edd-1986ff5244bc@intel.com>
Date: Mon, 9 Jun 2025 09:34:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] x86/fred: Prevent immediate repeat of single step
 trap on return from SIGTRAP handler
To: "Xin Li (Intel)" <xin@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <andrew.cooper3@citrix.com>, <stable@vger.kernel.org>
References: <20250609084054.2083189-1-xin@zytor.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250609084054.2083189-1-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|CO1PR11MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6f5f22-c4f4-4077-5495-08dda77381ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU9yRnFQa2ZjT0lScTlzUmV3bm1BdHFscXBBWVNSNDg4RDQ2VnZWbXZramhJ?=
 =?utf-8?B?UngvZVJ1d29PbnY0Kzl0YmZ2SmJuNkExSXAzRU5rNFNPd1N0SlVTM3Q0TnJn?=
 =?utf-8?B?aVdpYUIzbDRvQVY3RkdYeUFFVmd6VXRvaGNTMEZWbnErWmN4RkxISWJvQjF1?=
 =?utf-8?B?M1JURkk3RXgrMHpnY0Q3S1ZyS2tLSUp0SFl6VVVUeStXWTc0WUZCTWlxTEtE?=
 =?utf-8?B?NmZKZjRqV3loNlp2T0QrSi9YL09WUU1FSTV6ZHhnTXNvUnpieTJJaDB2aVNT?=
 =?utf-8?B?eDdzUXl1NUN2TXlzMnAzWjNVWGRYOGkxUWJ2TTVwSHA5TzZTYkcyOGhIaWtJ?=
 =?utf-8?B?SHNWNnUyOFF2YVh0WGVsRlhuQUNkWFlaOERYV0J6R2NtRzgvOXExK3NzSjhV?=
 =?utf-8?B?VHo4WFpYcjlWQk9mRWhUaHoxUlZza0RZbzI4Z2dSM2FVR1pDQ1MrRlI4VjQz?=
 =?utf-8?B?K29zUVhpTkJRamFOSnVoWUtZd1hVR1dkam5zZmVmNlJObkJKa3lOUk9oMEE3?=
 =?utf-8?B?Wk9ERndjVVJiU3B6UEhQUldPczlHK2pJRFZSRkRtdVBYdGJSZ25mbUpyTHcv?=
 =?utf-8?B?VXF0OWpWUithREJWU3dKWVNFQVg0N2hhbng3SmxScGxFYm42ZWQzWEpwcm1C?=
 =?utf-8?B?Vk9GRVBZVFErRzJCWVlmVVdJVFRDYndLQ1N4R3hTejNwT0lKLzlJdEZxVUNJ?=
 =?utf-8?B?SjZyREZuN04rRk9iYWpiSi9weVo3aExsU0hHVHdJNWdQOFJaUGdxUFNwa0pL?=
 =?utf-8?B?bXVlYUlHMWxMSG9jK2dUcno4dFg3OWdlS3BnMlpwbnB1SS8yZmRtN24xYTFW?=
 =?utf-8?B?NGJTY3p1L3VKajUyRVlzUzJEY3dDQzhaTHJUMkY1b1hJbU5BdGxkV3A4VnhF?=
 =?utf-8?B?Q2RoU1pMclRDMFdRdFVpUTF6Y3hPUzVCbVJmWkhTMGFNamN4UDNCR2FaMXVW?=
 =?utf-8?B?b3RmdGN4bDY4dGJPOUFib2ZMQStOd3hMbnNQdzVGWmMzT0FKdXdMN1F1eDBN?=
 =?utf-8?B?cTRVVkZLMmJHWkNRbGN2L0RCMTg4WWdMMVdRQUtGSkwvcG1sdTloTmtoMW0v?=
 =?utf-8?B?ejcvSWR4eDUrKzVmc3VjTkFTT1RidzZzNDFJRUVLaUs0R0QrQnFWZHgvMHVG?=
 =?utf-8?B?TlNUclg4ZnJUUkJiWkFMdzl5dGdrUm5YMnVEdENTK1NVQjh5UStqUzNGaVpz?=
 =?utf-8?B?WUZVakx0WkxTRzhJN2dGUHo2cGpkblBTQ1I1dnNrWCtNWVRoNTdRM0JLNG1z?=
 =?utf-8?B?MEVvSnQzQ2gyNDhuUm5aaGxYWDNXejVTV0Y5NkJ2UTZOUzdvTCtrNG8xWTdM?=
 =?utf-8?B?bUZvQzdzbTlzdWI3K2FPSGVMT05sV2VDdlNnakdERWR1Um9xK2NJeWtiUmJa?=
 =?utf-8?B?TFpJcU5oMFlveFpEUHFQRXN0Q0RQaVJzNGF0UTFJbU9mTmJ6OUxTMjVzazdv?=
 =?utf-8?B?MHRCRm5tSU0zWUtsOFVMUjVWczdqWEF5aEphWTcxSW5zNU9jbjYvTE1IUnZT?=
 =?utf-8?B?bFJmclhrUjJLSDUvYjF5MjdXejV0cXdVUmkwc0NmdXIyamlyMzQvZ2JFK09a?=
 =?utf-8?B?VlduNWs1R1grbTBrZ0NuQWUxb29GbTBFQWVFVCtaaERWcE1CZFJHdEQyUjdo?=
 =?utf-8?B?NExHTFhJY0hQZk56NlpiNWRaSFBmcnMrTmNYU0NLQ1orUUt2SWh1NW41YnZC?=
 =?utf-8?B?VDNNdEFtL1dMYnhIeGVyK2lCTnVmeHpXWVF0aitwb1ZPSlJWejNiYkRmMURW?=
 =?utf-8?B?cFdFU0lwRTdLQUp2REVrVXZCWlpzTHJ0ZC9Xb2llU3d1NTI2SVg1TEdtSXlw?=
 =?utf-8?B?T2IycVVOZUxjOW14RThtdkNhOHgxbTJyWnBwL0cvRERwN1g0WExRSTFMN3NK?=
 =?utf-8?B?UVlGZFQxNXBSaHJocFVmZmZBU3c5YUxadzczT2IvVWtDbkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhMYWh5QS94N0pjYTBnQ3VteFNuS3JtTlhrMFFELzBKcktFMmlmLytaQVFv?=
 =?utf-8?B?Mkw3V0pPSVJRV2N6ZWVFNHFYRFIxWnl0ZHh2RUtGNTRLMWl2RTlhdkxObzdB?=
 =?utf-8?B?S3JCckpveGFXRm1VYmthUjBYczB0SWpuRUVkUFJiZUZVVzltdng3ZlhjR2Nq?=
 =?utf-8?B?WXYzcHlzMG1zYVV1WFZTSk9Tb0hQUDJZbVQrUzJPWDMwYS9FWUR3WDUzZnB3?=
 =?utf-8?B?Q09seENKbFE2alJnemlabUFiZTVUa2JETTVHZXBjQ043ZER1U3A5aURlWlVo?=
 =?utf-8?B?dEdOVGVLYzA3NWczVDZtWXdIUnpmcHJ6N0tmekJHT1FrNUc0MzB3cnVEbnkz?=
 =?utf-8?B?SUtzRDJvcEF4QmR0cXk1bFpVaEhHS2FjTlE4b0taMmtJUVRzbFpRUDBNcDAx?=
 =?utf-8?B?SlFrbzNURDN2N21OSWZ5QWxwV2grUGtpMVhhRXh0VGx1M1dnVU52T0ZHWDFZ?=
 =?utf-8?B?UlYyMkMzbm1IWVhxNWVVRmo2OGFndVVJNVY3ZHNxVjJ2YkN0V1EzODlzSWhV?=
 =?utf-8?B?TUl3dVUxQUxyMnBOK2Z0U285UXpsTzlJSTdzdkhQZTJIUGNXSWRBa21WMEY5?=
 =?utf-8?B?a1kxc0R1ZnplS1NWL29tNUNjU0lTcy9rZCsvOVMxRjNUMi9kZlBsZndVVURK?=
 =?utf-8?B?N1B1bloxT3dhRGFwOTBEODhZZE1SRkwrODgyZFFQdmFWNmpwV24xUzZRT3hX?=
 =?utf-8?B?VnB6T242VXNna204VFZXN2VkOG9aR0xzUjdjd0JRTEhqb3Vmelk1MlRTa1Ft?=
 =?utf-8?B?Mk9vaFYwRkxxbkxtUVpaYWREWjJKeTdaTUtId3czWUtkM04vVUMwN2dteUhj?=
 =?utf-8?B?ZEVYY1RKY21hS1VKcnFyOVo2K05yTUJOc2lOaGdtS2FkZ05EeTJrWDNQYTRC?=
 =?utf-8?B?SXZFSzc3R2puS2ZuSVpuVFMxL3N2SEV3ZUhZSDhzS0MrSVFQRDJyaTJseVZO?=
 =?utf-8?B?TUhrWVBERHlIK2x6MGFFZEh5OGZHK2pMd0wzeU1QMXNRditIUTVldFlhV0dO?=
 =?utf-8?B?cGF4RStWS3IxQzQ0WnNWbHRPSGZMdnNoZVBWU1VGZXVxeG5Tb1Y2dkJSVnlj?=
 =?utf-8?B?L0NBT01zNTMrVWZJTTJDNndPNUg3M2M1eFVHTHphWkhPMDBPREk5VEwzaXFm?=
 =?utf-8?B?aTdZdjYyY2F5ZS9BeEZaZ000TG5FT3d2My9aNkkwVzRnekdDTVE0WjBuVkl3?=
 =?utf-8?B?RWhLY25LM21QcUlBRmo2S1RBS2UzdnpvRGFjSWZFc2I5LzcwRHY0aUVyN1p2?=
 =?utf-8?B?OUM3OUszcUxveENRS3BydlB6dFE3ZlRrRy9ESkVzbHlrNkxRU3dkOUJFbThw?=
 =?utf-8?B?Q1hRUjJHekNOdml1UVl1WUo3ekJMM0gzRkpwaEFlUkdDR2hwRThPZmNJNlRW?=
 =?utf-8?B?UlhydXlTNzJVUXB5SVY4ajF3QVRKeHROU2dvMUZGVWxSWkxlTExrazRVVlJz?=
 =?utf-8?B?N214cFdHaHk0L1ZtVTZwUk5wQnFMTkF3b2ROSTZJaHR2ZXJQNlJFaUFBaThy?=
 =?utf-8?B?UU84RFpFYlpQZlJ2bFUvbGNQc2ZGRENCYmQ5N2cvSFlxaU94YWlYRVlwbkhF?=
 =?utf-8?B?UzBVdHJvWFJ4V3Zqc25YRlV4MDd2cU14b0VaZEI5UWFIc2lEK01YSEpLeHEy?=
 =?utf-8?B?UE9YUE4wTHR3L0xCR2U3N3BMbmVvUHRrRWRpL05TbmVGbGd6dnBIS2lOWit3?=
 =?utf-8?B?Q2ZRcUM3SVU4SWNMelMweFZ0aWxQcll5VnVZQWpqdmYwV2c1c3QxZlJNSnF0?=
 =?utf-8?B?TVQ3NCtQc3VzVGxFSmQ4WkJCdTF3clZkamJVR0t1OG5pRS9jRU5VNWhEdWtH?=
 =?utf-8?B?WXg1dEt6RUFMQ1R4ampLY3FlRUh1WXBJazVOdlNZQWI4M2NTZTFsbzVidjZF?=
 =?utf-8?B?Wm5XUmtEWVpBMjBIdmZpWVpkQlFOTlZrWE54SDZvYU5ncXZMcjV4eHB4V2Nn?=
 =?utf-8?B?SGlLTFR2aThlUzM5U3lNZHRieWNMV3AwTS9zOUVSdWNZcEhxTmJEUi9SM3hT?=
 =?utf-8?B?cmZNUDBjVVo3SnlDS3hhRC9vN3BubW9vWGp4bWFIeXp3ekh5S0tnUjN6dmxX?=
 =?utf-8?B?N2Z5RUVuQVd3NFBpcGc2a09zK0tPUVIzMlZYckE5Q1lpVjR3YU1RNytDL0N1?=
 =?utf-8?Q?y8+9eBQ/9ZWb1bdexwwcODLWB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f5f22-c4f4-4077-5495-08dda77381ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:30.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj/ZDqou6qQVC9S84Jk5gcki21YEBKCbURqw81XOzHJu4P35VovVI8NOn6mmYHgg1YkaDrLyi4Dk2n6dN3J9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com

On 6/9/2025 1:40 AM, Xin Li (Intel) wrote:
> 
> Xin Li (Intel) (2):
>   x86/fred/signal: Prevent immediate repeat of single step trap on
>     return from SIGTRAP handler
>   selftests/x86: Add a test to detect infinite SIGTRAP handler loop
> 

I see that Dave just applied the patches. Sending this out anyway since
I was done reviewing them.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


>  arch/x86/include/asm/sighandling.h         |  22 +++++
>  arch/x86/kernel/signal_32.c                |   4 +
>  arch/x86/kernel/signal_64.c                |   4 +
>  tools/testing/selftests/x86/Makefile       |   2 +-
>  tools/testing/selftests/x86/sigtrap_loop.c | 101 +++++++++++++++++++++
>  5 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c
> 
> 
> base-commit: dd2922dcfaa3296846265e113309e5f7f138839f


