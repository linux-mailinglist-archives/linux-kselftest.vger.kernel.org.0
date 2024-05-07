Return-Path: <linux-kselftest+bounces-9655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39138BEFCB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D17B21788
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE647C6C6;
	Tue,  7 May 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIqWmDwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AA7B3E1;
	Tue,  7 May 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121066; cv=fail; b=I9Pa+Iwaii89UhcNrt+HNW4XCkP3vVyCFTEmncQwv5f0R+AL4QKYhhZQDKpJWpp2P+D5cYqVCgTCnxn+LZC2RN4U/vjpnimwqNqywrXu5ERP7RMqqvDiSARvZeUi3gIYd3SO+MhfKxMcVYEA/v3e0X9sUA/jF4e1LVe5zkcvRcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121066; c=relaxed/simple;
	bh=7jAL3rtBcB8lF6S/dZynF+/ETDBGStt0n0kin6SJFuc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ID5mESEJg9TaWWODgG8HW0HJ/eyaFNifeZ7yp9kXBB+30i62lHaoKGMHXLFT001/2T3Wl62qcrqxLI1aUc07t0rIA4Q+suvNRvXBg8qztFGtuGss0QcreTMeMUEfHGEYzOMShxU+SrewQ/huIGGimPObJOM7M4dkadjNSdtY1/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIqWmDwV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715121065; x=1746657065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7jAL3rtBcB8lF6S/dZynF+/ETDBGStt0n0kin6SJFuc=;
  b=YIqWmDwVvpdzgzXFFs+FQwiTN06j/AbV2nVofMEuQuKeJLyxwe9mVDiK
   fPIPSFlfZDjUwjHRruLB8NJm9GcBulTHUneBAVv+7vf19MlbDfuRRnsBh
   RDpbiYpCCbChX5x3JNtSt2rGwXuk7/jXLnLU5pp5U50rYGZvNc3f+oOrU
   HSSVQXjx75RP7SwZBGFkg6e3yQM6ZPtZhhWhuJkf1jXVPpLp9aPzQ5Hl0
   OUsoBFONQx1Bbhx2DVrJ2fOF3Vs6QnaMeiF7VPd15vaLclrS4ZrlCAjNe
   w9lH0optcc3IXRjMrU9EY6RML944IZrngd32W5KylpfXbYe034Hg/CdLh
   Q==;
X-CSE-ConnectionGUID: 0cXD5dmzRJKAHfj3a9Jdqg==
X-CSE-MsgGUID: pXFSlEB2Ttmg4jThlcAn9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11107421"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11107421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 15:31:04 -0700
X-CSE-ConnectionGUID: 4Rr5YUMwSce6iDDW3Qr10Q==
X-CSE-MsgGUID: NwzIo5LKSFCCrfzcqf6frw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28723155"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 15:31:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 15:31:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 15:31:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 15:31:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 15:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtRnUZrZ0DTzdjf0xxR90oJLeQSoiMuUh3IxxUQ9RivXmiiXUP/JW+19X82QCGF1XVvRuK4oBaYAap9E72XifLXwDLF1QS9/O+R2mtyhNiG3u3JvyyRUIgUrVlnQ1BfVMtgPQMKA4S9B9yfjIwgMOkz4kYeliSyLkVhKUUyFze2HN1/AckJzonFedjqJ0Izb092dkk7OKARnh/cj+krAvKvxnb6ajY8wmRLSTexcD2crZSCpPmkwhgiU9/9QgIWnwqCIip7b3bsU9jvAYXEhBDFJF5BwCwtSJFlMZ6yzgkXVLXfk/5jvlELt0YA6rrWNsgaVk8bx+8F++auDUWTm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhB0vjJcLEehihfXmx0lBdNuL3MbL+qLcveoXYx52qo=;
 b=Rzb4KbHloJLXBReroJbwEkY1OJ2BXsW3eWR4Y533GAEyiGSVBnrG2DPL2FMEgxKEHPRlfqYS9g6+Ck8N34Le60lwmlbAKs3xc4m9Auke3/nvM/JVo1S/3rNIqI7+8WVrg0aQzH2SG+EIFOmCWXb1/5GnHSbPhtJNFAhMura/rk3fm912jTu+M9ik8uecvKE/NV48/lRUUna0mThKfFtLCDd22QYqzumi27Q2nCVLidUW6avYlOVD19xSkM3wbZZMCYP1Usrl4L8PU1V9EGJG21RgVTMJwOgUapJtY3RcU7Z+E+WIGoePWTvGHw5TJ66ExivHD0AvNYDhkR2z53EVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 22:30:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 22:30:56 +0000
Message-ID: <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
Date: Tue, 7 May 2024 15:30:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503234051.21217-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240503234051.21217-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcb8737-dfb3-425c-83ef-08dc6ee55b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ky8yb1hyQUZ0WFRzUjZSUWZtUjRDOS8vdWRmSFRlUHRUMkVtZm5PSkwyUHQ1?=
 =?utf-8?B?VU5MdnJQaVMvRUoydTlLWkN2N09ISkVyUHZqUFNjVDNlbnpJTXFobjVLSFN5?=
 =?utf-8?B?ejhlaXRTMmFZUXNBU0VlWkR3WU1wbnhBWkpia3B3MzZYWFRoU1FaNXlLS01j?=
 =?utf-8?B?TUZKMngvQWIwWlorR0xqa1dGUEhVMmh1MVViYTdKdzc1TUxwTVAxME1uWTF5?=
 =?utf-8?B?dUd1d2IvTU8rSDRENm9BRnFRM0wzM2x3U2ZSOFVjQVNjckdqU1A5K056K1No?=
 =?utf-8?B?a1JKVTRhYWVYMmVyVDlyclZacDFybDZuTlJZNWpmZHVEUXhoNU9vR1djdGhr?=
 =?utf-8?B?TThsSFdiQXFIVXByMEt2RkxoSXlFSEtza2NPODgyNkFmMG9tZERpWUUwYnFY?=
 =?utf-8?B?QzlLSWpPYXdTRUVGV1ZTMXAvSGUwK2hXam1xcjRNemlOaXN5RTcyK2l5dnJ6?=
 =?utf-8?B?SGZ5eDJRZ0VRSFJ1OS81aGpIa3d6T1F6eHZxemY0VlFoR3l3bUFxUHBISENm?=
 =?utf-8?B?eVhZbWN5bVc2eGhYSUdxRUlEVjQvY3JBdkJtNFp5ZGtnd0hWL2RZTEpPNHpy?=
 =?utf-8?B?SHpNaHdhWkxoV1lYcitFZDlwWTBPUDI4YWpzNDBiMkx6Y0ROM0I0aTBzcWw1?=
 =?utf-8?B?OFNzRkplUXpaRWVVWG14TitTNDBSY0w5dDhIRXQyWTl0QmdmNWUvK29SRmJi?=
 =?utf-8?B?VDJoVDkza2U4czZ6MEJWSmdnU0I4QjJEYUxPQkV2b1VybDVSdHRWbk9DQk1Y?=
 =?utf-8?B?L1VvTGJ0VEhjaFhRallIQmQ4YVdkUGNMeGVyL3gxNlNQZ1NqbUl5ZmtVOXBD?=
 =?utf-8?B?dEVtMGFoZXJ3Nk85NWdxOG8wRWxLNm9KTTZwLzFpRkhHS3FJNXk5MlhXM3lN?=
 =?utf-8?B?Z3dNckJaTTNuMENtVGh4R3BNaEhOUTUvMTd3aGIxcVVzZDR5TkdJa3ZSU0Rr?=
 =?utf-8?B?TURiT3RVM0VvSlVBSkkzNWZEODRpYTQ3YlBwcVJFM1VSVi9Ic2tIQUNFQmww?=
 =?utf-8?B?TWE0aTZjUmZudmpQdWJmb1B5UUM2SWRJdWNFcHdnMUJvZ3p6THNjYU0yMWRl?=
 =?utf-8?B?VEZZekNQUDR1QWpQWUZPMkFCNmt3a2NKamNNS2VzNlcxQjNqalZkOW9KZGVX?=
 =?utf-8?B?WndGY1gzWG5kRk4ycDk2REVROW14ZHBZMTNucndzR016WU1lY0t4Y2FERW5U?=
 =?utf-8?B?VGdhYTRLb1E1QjJyK1YzWkJsNUNoS3NZRVVNcVFoaTFna0s5dUJmbis0MXp3?=
 =?utf-8?B?bDV6NW90cVFCUjNHWkVxNDVBeUx6Y3cvVjFnMVd1WExZTkZLTU5CK3BUQ21B?=
 =?utf-8?B?b2cxV0JHK3BacVl3QVRURWlXY05ybURpZGd2bGVzallhSFdqb0RuRnpjTldP?=
 =?utf-8?B?V0JJL1QrbCsxR0pBcnFzVXhQOTJhK2VwZkhmcklxWU9aV3lZZzlPK3BLamtF?=
 =?utf-8?B?eUM5d0RrYlhRQ2x1OC9PU2c3azBPWEhJQnVKTXhSNVpEUitQUkJEWHN2S1Fz?=
 =?utf-8?B?dllscm1BN3dkMEFaaGordUhJS0NFOENnN3cxRzhJRFA1dmhBeTU4VXZiTEFF?=
 =?utf-8?B?WEdXN3Q4ei9GUUFjQlZHeFRmem1LNXNSOHF1cWRYQXlPSFJ6bVFBOG0ydDE0?=
 =?utf-8?Q?cUbkyfmiIGBMJ/7hKsDX6lZzgQehnqRl9vI9joDDKrRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHV4VHBvZytGMDhvZFpzQVFZOVRBWGd0TTZxV0ZkMm5qSGV2ZXhEeDgvZkg5?=
 =?utf-8?B?VnF0MmFnVjcvYzNlcXBtRjYvUFZWQXkxSUsySkR6cC9SaWtYOWlITEVxem5W?=
 =?utf-8?B?VG1xZDRwM1NGTzl1cHl3VUcvMFJXUVRuUGxmL3Z3UVRoL2hsQ1FvRy94VXdy?=
 =?utf-8?B?ZTBrS0RobGZZQlFleVhCR2xQZGllQlFnYkgyWGJJWU5zQmN5cVlmUTZwaG5C?=
 =?utf-8?B?dzFqRjUwRkZ6UUZSODUrcFZxME5YNWdZQ0V6QVFIS01SbTBoc1ZGbmV0NVAz?=
 =?utf-8?B?QndBSnFhTHhYcjZab2pUWHo4Z3NmaUNMWVREODNXOVE5N05hL2dLdmV2Sm1D?=
 =?utf-8?B?MjFRM3A2MUZtTGFUUVN5bUtHUkpYUVlGcHcwZElQbVREY2RNQTVnOFZ4ZFRU?=
 =?utf-8?B?d0N4ZXhXUUVrQlIyL1l3OGxTajNIbWY3RWh4cGRvWjVYeDJCZ0dJM2tDRnJM?=
 =?utf-8?B?MXhrcHJHZkdSMC9VczNmTE1tTFhEMmpLWW5BVWE4N1RtRy9lYkkvbEhHWGRN?=
 =?utf-8?B?STAxTlh0Qmk5UFZVblpBNGhVdWN5SDg5OHVKOENwd1JmZU1GZTM5TmZudndP?=
 =?utf-8?B?cFFjUnBuelR2WEJUQ3JjYlQ4UkFTUmdxb0JYOWxiMEVJTTkyYnQxdXNzVnVk?=
 =?utf-8?B?dWtCMFYrNFMrN210RSsyQk1lZlZiSDZYR0wvZG5wS1YyT1dYbXp0SmF0SXNt?=
 =?utf-8?B?R3oxUDBYcXp5VW42R1FWekN6RHhoL2F3K2pSUnpmRzlCR0ltM0MxVWpwL3F4?=
 =?utf-8?B?L1BydkY3TlYydS9EQndTMmgrVkRjUTNzMmVDNEVqZEpDTEJ0REpnMm9teHBm?=
 =?utf-8?B?L1N1S2pUcWt6aGtSV1ZPaEQyUHVkZXNuRG9GWm5FUHVhbGJZU25VNHVHaVBW?=
 =?utf-8?B?dUZVWlZNUGJuTlNyc0prZGF2cE5MNkY5SFU4SkFrRlUzN1ZIN3hpcDZNbTRB?=
 =?utf-8?B?bWhSZlh4YnRNUTNWNzFpa3NBRUJCQ3FtcWFFZDBEQ2JpanJMK1E4eUZjY014?=
 =?utf-8?B?S1NibzFJQ2pBeGNFQlQrMHpNNmZ4dlJrV25SYitCdmhjdnhnc2ZsY0szL0Q3?=
 =?utf-8?B?K3Qzb09xUlVoREtyeFVOeXNpRDZIdlpnSmtDbkViNStrTTlqZnppSFRkMXA4?=
 =?utf-8?B?UVVNVVRUYWM5cXBGZFc5S1pDRWx0WHdzYW1UQWNoRzhuSFo3ZE9BVElFM2hK?=
 =?utf-8?B?UXVqTmlkSGtTQXFaMHVDWkJzL1pnRDNlME5SNk5BSHY3Q1A0Y2lLTTZXeDZw?=
 =?utf-8?B?N1R3cmNPYzZGcm9ZbitKbWMzN24rNVBXQ3RvU2x4M1J0WlprTG4rZEpFUWQx?=
 =?utf-8?B?alhEZjhVeUh5b0J4NFdORGM5RFBBd3ZaN0dNQmJKSGR3cDdwY0lqWWRnZ2xT?=
 =?utf-8?B?NkhCdWNpNjE5aHlHayswNWJQMkZLZFJ3OFdpa1BJY1pzdndxcDVQdmxkeGV1?=
 =?utf-8?B?QWlRdndDWXNlWlBpYnVMckdYTWZUQ0JhZnlPaXFQV0VHUXZoYkxVRFdtMGlD?=
 =?utf-8?B?QytNN0w1dHhaUmQrbEN6QXdKaVlJZ1hjcWlIUm5tZ3VQKzVIVmJndC9tSURj?=
 =?utf-8?B?citGMVRWU045Q3pENmZ1aHQrYXdNNy95SWxlSjBubDVpUlNTSW9oZTlzbnFK?=
 =?utf-8?B?ZlhlNWJtQVBGMmJJemR5cFhuYWxWdW1GVmZiVTRDUWZHT1I5Y3lnMXVRTmto?=
 =?utf-8?B?Q3N6VElzd3BIZnR2RkhHNzBvL0pPMzU1a1c2TlJXODdJWUhsSW80cmxCQko5?=
 =?utf-8?B?N1E0N1M1Q0daM3MzTTE1eTFFL25mSCtscjRYNWVUWm93b1RYSVdWZmlFZGVK?=
 =?utf-8?B?YjVjMzJLd29ySTNyVi9DMk0wNlZKTjVYRVNZcWFTMDZSeVlDaXpPaFhtNUtH?=
 =?utf-8?B?cGZib2JSeUdFakQzVmdHZThrVGo4aXh6Q2RMUVVTTHlpWWlkR0VyNmgwdkdC?=
 =?utf-8?B?bXhkR0lpSmI2MXgxZEV1eVB3ZytDOEg2ZDQ0YmQvNWRYNko5SGFPNGNnY3BK?=
 =?utf-8?B?UWFRQmZUZFowbmdBVFo2Vm0vWEc0MlJ3ejluTnFyQ2g4NmFucEtuaFptNlJh?=
 =?utf-8?B?MS9xbXFxSWk3TXRpNjltT0lweGo4UTI1MWZWWjdrSDFXdmJ6RTAvcmd3TklR?=
 =?utf-8?B?N3hTSDlya2N4UlA4VUkvcnAyWUUzTFVNTVA2aFlmcmR2QTM0SjhFTnNTdG1L?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb8737-dfb3-425c-83ef-08dc6ee55b86
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 22:30:56.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZXc9wKelar3zMA10g6N7MLsF7GGjspcLjqxqYrEUiGtwwL7MXsGTEU5jwTTk3P7EnHqn0cH20Kv+QMpfufu80BXXhDzUddphs6cJ9CjPTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
X-OriginatorOrg: intel.com

Hi John,

On 5/3/2024 4:40 PM, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Furthermore, for this particular
> resctrl directory, my pending fix [2] must also be applied. Once those
> fixes are in place, then when building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...two types of warnings occur:
> 
>     warning: absolute value function 'abs' given an argument of type
>     'long' but has parameter of type 'int' which may cause truncation of
>     value
> 
>     warning: taking the absolute value of unsigned type 'unsigned long'
>     has no effect
> 
> Fix these by:
> 
> a) using labs() in place of abs(), when long integers are involved, and
> 
> b) Change to use signed integer data types, in places where subtraction
>    is used (and could end up with negative values).
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> [2] https://lore.kernel.org/all/20240503021712.78601-1-jhubbard@nvidia.com/
> 
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi Reinette,
> 
> This v2 includes a fix for the bugs that you pointed out (thanks!) in v1.
> 
> I kept the changes to signed integers minimal: only what is required in
> order to get a clean clang build.
> 
> thanks,
> John Hubbard
> 
>  tools/testing/selftests/resctrl/cmt_test.c | 12 ++++++------
>  tools/testing/selftests/resctrl/mba_test.c |  4 ++--
>  tools/testing/selftests/resctrl/mbm_test.c |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index a81f91222a89..af33abd1cca7 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -29,22 +29,22 @@ static int cmt_setup(const struct resctrl_test *test,
>  	return 0;
>  }
>  
> -static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
> -			     unsigned long cache_span, unsigned long max_diff,
> -			     unsigned long max_diff_percent, unsigned long num_of_runs,
> +static int show_results_info(long sum_llc_val, int no_of_bits,
> +			     long cache_span, long max_diff,
> +			     long max_diff_percent, long num_of_runs,
>  			     bool platform)
>  {
> -	unsigned long avg_llc_val = 0;
> +	long avg_llc_val = 0;
>  	float diff_percent;
>  	long avg_diff = 0;
>  	int ret;
>  
>  	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> +	avg_diff = labs(cache_span - avg_llc_val);
>  	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>  
>  	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      abs(avg_diff) > max_diff;
> +	      labs(avg_diff) > max_diff;
>  
>  	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>  		       ret ? "Fail:" : "Pass:", max_diff_percent);

The changes in this hunk are unexpected. The changes to this area made by previous
version was ok, no? It really seems like this just does a brute force of everything
to long (while taking labs() twice) unnecessarily.

> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..707b07687249 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -60,8 +60,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>  	/* Memory bandwidth from 100% down to 10% */
>  	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>  	     allocation++) {
> -		unsigned long avg_bw_imc, avg_bw_resc;
> -		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> +		long avg_bw_imc, avg_bw_resc;
> +		long sum_bw_imc = 0, sum_bw_resc = 0;
>  		int avg_diff_per;
>  		float avg_diff;
>  

On second look it only seems necessary to change avg_bw_imc and avg_bw_resc. What do you think?


> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d67ffa3ec63a..30af15020731 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -17,8 +17,8 @@
>  static int
>  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  {
> -	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
> -	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> +	long avg_bw_imc = 0, avg_bw_resc = 0;
> +	long sum_bw_imc = 0, sum_bw_resc = 0;
>  	int runs, ret, avg_diff_per;
>  	float avg_diff = 0;
>

Same here wrt the avg_ variables.

  
> 
> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279

Reinette

