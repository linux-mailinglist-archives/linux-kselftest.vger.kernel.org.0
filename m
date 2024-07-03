Return-Path: <linux-kselftest+bounces-13143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08109269BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D0B23B7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB351862B3;
	Wed,  3 Jul 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzwZOIEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB4183077;
	Wed,  3 Jul 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039871; cv=fail; b=Efohn66YSHyOBw3ehZh//T9dQU7qN9bLmNOEa3/oLvclxnP96WPRiZWnRsFCbawMzC2ieBHW21fKfO2Wzj4XYPJM7MlCejrGAUh4iF2CakuJzoor38M5LpZ1EF73bD69NcbuxzlA3CR88Lo2jdY85KgQLTmW1Htx+xiRvjidawc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039871; c=relaxed/simple;
	bh=de2Sh6vdIbTm9iNEZlCKeDDCX/7LODJmMIy/7YnFd2U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tcrrltr0/h1Qmwy76824UJ0CFOR6dDX9AkBpdOjFOkiti2fxqwgFl/bujUa0iddpVAIqOMWLrNAwTG+N276G0kHj74v+91qWmWB5jvq/2Pp4fzRXAOHwqlm4vojUChsAd68MwDKDsLybj7D1Q35zgcphxKM0Uz+bvjcZXGkmeGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzwZOIEy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720039870; x=1751575870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=de2Sh6vdIbTm9iNEZlCKeDDCX/7LODJmMIy/7YnFd2U=;
  b=lzwZOIEytvOaiMAjMG/7KL2z/C7/8pq1d0mQ1l9yRix0W9NJs/sn4w7N
   BwKWh83WA4DN6vMjuTfuAsfVp/yI10xLaLoKH/rzUfG+j21konuoqSofb
   hhLUIA6G8wov1MTHQC5963ZAJ7vLObF6oPKkolY+gGGo4q03mop3WOBUh
   4sosjzvWIpi92F5cJy9ctR8jXAVaYGYPiwV9JkVV+oQaMdzmbbxbVkp6U
   eTdtJv1tlpomhN50xy3RPGMBHLbmSIKkbCViMSnHoLTooJkj7YjhZmkUI
   ixTddDTNAbN27+4FqRuPI2qxvAIgkRdvCzoWs8YLmHpNU2Kmb8McijjzV
   A==;
X-CSE-ConnectionGUID: VYbgjHuBR2ufV4gEQS/PHQ==
X-CSE-MsgGUID: Xz9t6k5HTN2POTO4cydNrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17250222"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17250222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:51:10 -0700
X-CSE-ConnectionGUID: Use9Q1llTg6EWdz1LBIDpg==
X-CSE-MsgGUID: 6LN3szorSqi/VWdrYBBW2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46806619"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 13:51:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 13:51:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 13:51:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 13:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B24BcR5fp4DTXWBYYtK3kIoRbIHlwXdZ9pSMsEJslP9BIPWkG9alxRLLevmwVDoGtW4KTiUkKNQzwow1tbUo96ep11KNGzBy8CyRUCMB8fdoIrZJgCvZAsw5TxB7bK3+9jdzBzyEV1sbRaBaKbi54V/WaQEO0c/THBa0uv0hgSSnsUlDEopm5p4bEgOSDdHTkRhNJkjgUFGeEq1t61TzYl+Q0SHbctSyrbiIujV/KDL0uRWdjC0FrcdGwWvKZH5vAieXEHKhtRiETgSbCiXJ7NH1vuY+Q6EKXGVqPrYDyuwyqQERmVKTC4AEITleidjGpyGmZQ9T8GjDP78eqTCtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L2lrZOUtxM/NZVQ2ps0BTyHZxCI1+VFwt8xH61JCc4=;
 b=Qbqis0DS9yaKtlFYtpVIfLzSl5Hl/tqBF7V6U57WgBMCPguSuo1Fno25EOYVjMOgOMK31zsKBGDZOdC1RLaSCtfGmdfQxQOD3s8RpXrUs0Mx8On54evboXXibO6vD5+YRrrXiyluY4aW4SmfPO2JtkaJZ57Jr5EC68kQX/dAjGWPDu5nC5G1XfhIsX14fhrGrh5qpcPGLAk0KkoyQzOIKfoln3MnSjMYc+FFud3x5qd96H7ON8dc2x1EWF8mflSj5o+MDJ8NrCy6X3tRaNL5w9ecEWhFQT6W58e7n8AVtd9blVtTiwL9tOpMoppMJPHzTbi57IYZ1OCyuFMtn7WGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6705.namprd11.prod.outlook.com (2603:10b6:510:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.39; Wed, 3 Jul
 2024 20:51:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:51:05 +0000
Message-ID: <d5bd6275-ab86-439a-887f-17c04a586716@intel.com>
Date: Wed, 3 Jul 2024 13:51:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
 <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fd0d3a-71a7-4aa8-ac2e-08dc9ba1db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dERnTW94ZEFKOTBPdWJlN0FGNGdsdkxRQkhjYnF3cm9XYklKV200aWNpcE4w?=
 =?utf-8?B?ZDVMT1ZpS21ETzdSYThMcHZ1NU5GaXNOM2pmcmZoT2UxMklOYkFUbTNEUVBZ?=
 =?utf-8?B?ZGtQOWVGalhBYjhrUmVtY2xZeDlCa1k4VkMzdjBJaldzVHhidTlaQ1JqOUUx?=
 =?utf-8?B?dTM0YVYrYlBnWjdreDNCQVdGM2Z1RUtiLzNpQ3ZYWFZGQkxTVkwvYmorN3Er?=
 =?utf-8?B?WEFSMVJYcE9zZnJFN3A4Yk1qVHIrc2tVdTluNE4rTUkySFRRODh5WUIzWW82?=
 =?utf-8?B?cFFNYXkybTB1QVZqNmp2Wm9Pb0djMnZpRkFZRk5zcjNWb3duR2dRTmNjNW1r?=
 =?utf-8?B?L1kzT3BoOEtua2JRVDR3RSsxTGJ1VHpVNlhNbkFtVUhjY1E1bWxBWXdCU0pn?=
 =?utf-8?B?RXZvTHovS1F0TTJna055bVY1TXBaT0dkSWNTSGp5MEY5YVNoR0R6bkN2L2JX?=
 =?utf-8?B?RnVVVmZ1cEJKYTAzUm1WeHo0aEgzOE16emFOSzFtZ1JucFdyYjhidTdZempo?=
 =?utf-8?B?VkdDMWxzN29wUzFqdmQvYTd4TU1MUFJtcmIvcWpDcjk3WU9FWWpFeTIzUGhV?=
 =?utf-8?B?bDg5bUNwRmxkYndrRGh5WVN3NVB2N2hKSkdjZ0VXZ3FacU1JQkhqblc4TEFS?=
 =?utf-8?B?T1BUM3piaVdFWTVjMkd1RmNld25xYlAwVC80V3lQcFhwcCtSMUZFQXBHeThw?=
 =?utf-8?B?M2NrQStSSVVZa3RZcDN1cWtGVTE5bWpuQUZhMVdiV1cxNlcwM25lZzE5ZzMv?=
 =?utf-8?B?cjVhQjYyaEdNTVNqVlRiY2ROcWZKUTI3SVhRRFRqLzRkN2xtTVlyYjNxSDhE?=
 =?utf-8?B?aDU2S29PM3B0Mm1MKzJNQWZuRUx3M2taU2tSbEZ1SVkvSVBVdnhaNFZYL2FQ?=
 =?utf-8?B?MVAybnh6NENySmlCamJuUElEOEhSK2tVZDhBc3NUUS9MRXc4ajNQa2ZCSnBG?=
 =?utf-8?B?bUxwemxMKzhla0dxNUI0bko3R0RUTWdUcUdYZHhXay94anhtQ1VMeEE1bUov?=
 =?utf-8?B?NzVFUythcGxFQThERXhFUFV0bHV3RFpxNm9EZ2xhY3pZNUQ1bVhhRW82cnU2?=
 =?utf-8?B?dkdHVHNuTzE3ZE5iRzBWVjU2ejBqbk5MMWpyMjFYMVNVYlRiekorL2pzWnNK?=
 =?utf-8?B?c2w0OEtNK09vZXZ6ckZoSXo3RWhzeXZVbmYyQ0hodlBXdWVnRlltTlMyWEY5?=
 =?utf-8?B?SXVjS3FpOU81M25haXRPZURweXg1Q2loSXowSFZqTGR1UXM2NSttTENCYmNa?=
 =?utf-8?B?TzFvR21LNEZoQWV2MUpkNGZWVmdVK0dYUTRlcVVNeEtUTHNnUVV6RHNJWUww?=
 =?utf-8?B?Zm1CTWs5VFpiM3B5Wmx6ZkFyalAzV2EwejhENUZIUDNRQTZWcW1JNVVCeHRS?=
 =?utf-8?B?RGF2aUNMU1drajN6QWNuS2sraXQvblV4NzVqV3hOajN6NnFkNHZTQWtLbUY4?=
 =?utf-8?B?SEJ0MHVqSElpcnRyOEQvTlVqc21qZ21HRzN3NEJrcnNldXVZU1lIUWx6MTB4?=
 =?utf-8?B?Z2NtblZNRHlZenNJK0oxS3lmRHRrRjF0NEN0NmlsTlBDOHYxbkJEb25jSGNh?=
 =?utf-8?B?SmhaWVVTcXFOWGwvNDdIdjJmWkp2Tjhkc0w0Rit2KzJHWmNqOEEwTE50UnNp?=
 =?utf-8?B?aWRuTEZIeVNzZGkvdS9xNFMzVktLYnpHS09xSXNnU0pUdjZSa01JZVE4VWJC?=
 =?utf-8?B?MjFpU0VYSlRVUm1Hc3NmYmNpSTd5d3E0b1JLVnpLWFpHYTUra0hLYmpSMkR0?=
 =?utf-8?B?bzIvS0pWamE2TXVnRHVvbDlWa3VuS21vMUs0WjJRWkRFekNRS29nSzJtY1VC?=
 =?utf-8?B?YWxsRTZJOUE2R2JMM043UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNDQXhtTzJPM1J2MS9UUjNqeUhoNjh6emN2NEorL25TRlduWHM2UW9ibTFG?=
 =?utf-8?B?cEJ0Skd1UmVCRGx5bjVGL01iVFVDUmo5dlR0clJxMTd3SmJ4QzZvVUd1b2Zt?=
 =?utf-8?B?c0FBNDJsYTBYWEYvV05FRS9hRitEc0N3LzdXQXZ2QzRHVWFzK0wxazd0Mzc5?=
 =?utf-8?B?QSt5ckZ4dHpWbndDUGMzcHZDK1FUQ2ZESVNjRU8zNEdkWGlHNG8xdmZJelNM?=
 =?utf-8?B?Wm1TanZhVTZxTzhVSnJLTEVjUnlyQ1FOb3FmeWlyUDNVUjdwV0NkdmZaTHpw?=
 =?utf-8?B?WFM5cThHTEFmTnZiWEZlNDdNT3Zrbm9EeGRkUXpQYTBYMG0vd0I3RUx1b3lv?=
 =?utf-8?B?VTRGUUo3K3cwV21YUzhoQittRDFFMEFWMUc4ZDR2c05jaG9nTXZwcEY4cUpC?=
 =?utf-8?B?SlZuUSs1cTdIdG1nTzdwNEkwdkRya2U0a0ZDWEFTOFpoSDNQR3k5QStSTzlQ?=
 =?utf-8?B?TllDWkNwdk9GbTJkc1VDWXh2b2NqVDNUVk85RHlacDc5RTVmdjZvZEF2ZG1w?=
 =?utf-8?B?T2NWQ21Ndi9ISDdiblFkNkMzeFVwM3pKQ1RZYmdVV3lKVSt1U2d4NTRQUWlX?=
 =?utf-8?B?cXRYZ20yL1QrSGFTVzdMd3c1ck5YZWVSeHQ4WmpiM09JMHQxK1gwMHJpZXRV?=
 =?utf-8?B?V3M0cWVFWUhGS2tUOEdMaUlqZnh4cnNmRUtJYkZIVGtEWk40NjVFUVNWaFFq?=
 =?utf-8?B?WThPdkJESURISTdKaTczTDIzaFIyVXN6Um5ENkhscGR6aUt0a3BxamVldS84?=
 =?utf-8?B?bjlDbXdnOHNjRnczZ2RFRllxQXZxTnozNEZKNyswVGFKc2hROEkvUGlPOWsy?=
 =?utf-8?B?Q3oySmNwVUQyYUdpVVplbnI0NnkxY1hjQjNmejlNOVdHbDVjay9HK0ZqTVJZ?=
 =?utf-8?B?UUVZT205aUlMay90akFhUzhyb0hQakE4bjlNTllYdDByVFNxTDVuZnpBdUNq?=
 =?utf-8?B?alVXTnF4WURBVjRBdEJTUmdUV0NnMHFiazhCWkxiNWFtMGZxZ0N6RVN3SkNv?=
 =?utf-8?B?bFJWaXdKT05rQWtkdXNNTmlMR0ZtazZDVmVOTEJGSTM4cVhIR1prbktlMmZp?=
 =?utf-8?B?c0tJRUY3UENJRElZaGdKSHY5c3BqMnF2Q01SL2RaeWJTL2p6YTNyR0lrdVNs?=
 =?utf-8?B?TzhyNjlVaU96dUwwamtRa1Z1ZS9NbmZhZmFXN1ZvUDJSR0hpZU9PaTExdXJG?=
 =?utf-8?B?dU1rYmdsL0piUFlHZ0lJb056NEgzQnd1em5QT3dOMGFOMENFeW5uMW82U1pP?=
 =?utf-8?B?bTJIVzJNeG01QmpqVGR3M1NrQ1hDNm1XM0NrSTlsVXBLR3Byblh4dGFpMmhD?=
 =?utf-8?B?cVdOclkxZUtyV21EUlNqZXVjRG9vQXoyOXdoVzFZSXVpMjhHR2MzbEFVSTRB?=
 =?utf-8?B?dDlORld2ME14aGVQK3ZRdTVhSGtRREdKWDlzdGdUL0FOa0hhTktkdUpPQnNz?=
 =?utf-8?B?d0Z5MGhrbjJjdWFJZlVmRzhEdldTVWd2cmhiWXdaREhZOXBrNnMwQy9WY0dW?=
 =?utf-8?B?dUNsMk1NL3c2QzlSZnJ5bC83YXA4czVuQ3daQWYyT2wvamljVlkzeEMvSm8w?=
 =?utf-8?B?Ty8zK0ltT0dVRjcxc0ZkVTlXcWREbnFBMndaK3dHNncrSUM4NktlcXljTnZ0?=
 =?utf-8?B?Q1d3cWtsMGVmUzFLMDZYUmc1UFBWQmVpZDgzOHVXS0JReUErenBpdzU3TXhP?=
 =?utf-8?B?UTM1b2dzWVRHTzFnOWFxNFBUZW5adWRSTG96NjhuRkNTUGVkeW81bWxwcGo1?=
 =?utf-8?B?NzQzcDYrZmdBaEFRUVdCaUp6RWlOYXROTGRLSGxoU0ZGZDFQY2Y3TGtvaXlS?=
 =?utf-8?B?c2FZMExKSVhTZW5PRVBhL2x6MnlIZVJreUYxbTRaaGZrekd4WjZvRG5keDRF?=
 =?utf-8?B?S204Q2VmbW9ZK1pZaEJjOGVTTkJJYWl0cjh2OXpvT1pMSEFudmhzTmdEQUw4?=
 =?utf-8?B?VnJaVXd0Q3dRMXQxN0l6TmZna3V0bHlnQ0EyNFhodlhqT2hDRThoYUNOTGRN?=
 =?utf-8?B?VW9BZnFtZ3dISUU1eEJEZi9ZWHlQYWJuVVpvQXlFT1dLUS9QdHFZQjV5eUI2?=
 =?utf-8?B?eGFtRzI0V0xPZDFjN3liZFlnaHQxU2JBdk5CTXJESWZXUXZ3SThKQUZWU3NX?=
 =?utf-8?B?OGlrQ0QwOU9hZm9PRmEyZk5WUUI4bnlwbFFWbEEzd2FOM25LN3lEdTZlMFZB?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fd0d3a-71a7-4aa8-ac2e-08dc9ba1db9e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:51:05.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rxN0YfgpXMO+FSNfzaNuSonyE7tU/KDr5mpb8YFNf8QP/UIqgyOzOdIlfWOajQeEl8OTVemdjp1wmjOVUzCGb+Q6iXCeNixhP+jXdqsxSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6705
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/3/24 12:43 AM, Maciej Wieczór-Retman wrote:
> On 3.07.2024 00:21, Reinette Chatre wrote:
>> On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:

>>> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
>>> index 1ff1104e6575..9885d64b8a21 100644
>>> --- a/tools/testing/selftests/resctrl/cache.c
>>> +++ b/tools/testing/selftests/resctrl/cache.c
>>> @@ -186,4 +186,7 @@ void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool
>>>        ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
>>>        ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
>>>                   cache_span);
>>> +    if (snc_unreliable)
>>> +        ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
>>
>> The message abour SNC detection being unreliable is already printed at beginning of every
>> test so I do not think it is necessary to print it again at this point.
>>
> 
> The "SNC detection was unreliable" only gets printed on the first execution of run_single_test().

There is more about this later, but this can be printed at start of each test.

> That's what the global snc_mode was for mostly, it starts initialized to 0, and then on the first
> run of run_single_test() it is set so other tests don't call get_snc_mode(). And then the local static
> variable inside get_snc_mode() prevents the detection from running more than once when other places
> call get_snc_mode() (like when the cache size is adjusted).

The shadowing of variables can get confusing. I think the global snc_mode is not necessary, having the
local static variable within snc_nodes_per_l3_cache() should be sufficient and run_single_test()
can just do a:

	int snc_mode; /* new name welcome */

	snc_mode = snc_nodes_per_l3_cache();
	if (snc_mode > 1)
		ksft_print_msg("SNC-%d mode discovered\n", snc_mode);
	else if (snc_unreliable)
		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");

> 
> And as we discussed last time it's beneficial to put error messages at the end of the test in case the
> user misses the initial warning at the very beginning.

Right. What I found unexpected was that it is done "at the end" but from two places, from the show*info()
as well as from run*test(). I expect "the end" to be a single place.

>>>    }
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>> index 0c045080d808..588543ae2654 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -175,8 +175,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>>            goto out;
>>>          ret = check_results(&param, span, n);
>>> -    if (ret && (get_vendor() == ARCH_INTEL))
>>> -        ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>>
>> This message does seem to still be applicable if snc_unreliable == 1.
> 
> I was going for this one error message to specifically catch the kernel
> not having snc support for resctrl while snc is enabled. While the
> above message could be true when snc_unreliable == 1, it doesn't have to.

If a test fails when snc_unreliable == 1 then nothing is certain and some generic message
is needed.

> SNC might not be enabled at all so there would be no reason to send the user
> to check their BIOS - instead they can learn they have offline CPUs and they can
> work on fixing that. In my opinion it could be beneficial to have more specialized
> messages in the selftests to help users diagnose problems quicker.

My goal is indeed to have specialized messages. There cannot be a specialized message
if snc_reliable == 1. In this case it needs to be generic since SNC may or may not be
enabled and it is up to the user to investigate further.

> 
> Having only this one message wihtout the "if snc unreliable" messages would
> mean nothing would get printed at the end on success with unreliable SNC detection.

Having a pass/fail is what user will focus on. If the test passes then SNC detection
should not matter. The messages are just there to help user root cause where a failure
may be.

...
>>
>>>    volatile int *value_sink = &sink_target;
>>>      static struct resctrl_test *resctrl_tests[] = {
>>> @@ -123,6 +124,12 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>>>        if (test->disabled)
>>>            return;
>>>    +    if (!snc_mode) {
>>> +        snc_mode = get_snc_mode();
>>> +        if (snc_mode > 1)
>>
>>
>>  From what I can tell this is the only place the global is used and this can just be:
>>          if (get_snc_mode() > 1)
> 
> I wanted to print the message below only on the first call to run_single_test() and then
> print relevant warnings at the very end of each test. I thought that was your intention
> when we discussed what messages are supposed to be printed and when in v2 of this series.
> 
> Do you think it would be better to just print this message at the start of each test?

Yes. If there is a problem with a test the user could be expected to start tracing back
messages printed from beginning of failing test.

> Or should I make "snc_mode" into local static inside run_single_test()? Or maybe add
> a second local static variable into get_snc_mode() that would control whether or not
> the message should be printed?

I do not see where more local static variables may be needed.

Reinette

