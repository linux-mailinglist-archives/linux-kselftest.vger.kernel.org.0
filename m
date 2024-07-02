Return-Path: <linux-kselftest+bounces-13087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4C924B7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39A5291F3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2B1DA306;
	Tue,  2 Jul 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LR15vOp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17051DA302;
	Tue,  2 Jul 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958830; cv=fail; b=Jk1CDNpJCAS7Kplswl8LewRLC/JDD0c9TkYRZovWCCUN4j5XoQd25g4H3EGQneLIUZJZyxKApo7brz/8wzTqJ91+HvA503nMrg+N0mdwreX8TUh8iMkaW5FbZSXoLICPk5Lq+NtJaFFL2+fCgMd8mbgIJbhX189f1HkpehGRYmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958830; c=relaxed/simple;
	bh=JW2kLXFRo6z8O63AvhLzmSSKAYI6vutVCp/oXjnFbOs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cv7MDhCo0nn8uHsxU1fg1VkB7HQHDRknv0PdTzshzqp7xygN4Jllu+vaq6n4QUOveiFyGXGd6lgtT3DvxouMEA6HnNpYIzihJVNo+ksG4hahibHICv2Q0li7mkbVWnus0qL6debQiADgdkHkrThVsIFHxmjGLF0DEV5sg/Ba4jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LR15vOp2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958829; x=1751494829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JW2kLXFRo6z8O63AvhLzmSSKAYI6vutVCp/oXjnFbOs=;
  b=LR15vOp2jaO4x1jDTOKvW+2v1o4Dr8m8C5qKPhUJ0D9FKkbPqDmTsz6b
   cnOBoc12SbPXXjBEgHXIFzbptp8tcnUZHwY0m62fHt3vNincBVlxtf7xN
   H0xPlax+PnX3cUrX6McCRljLOjHMeUr0o840YPirY98UZp+eMPyvcg/0V
   qNlhdfltM0mgmr3uiinyaQsCxmNZxgrh86GVGtCosebNXg87NmEqhcfgg
   5oFduAzRP/HRPnzYg7TnXUIh+aWH19MszFjTIa26IszHGT8Gjbor+LtbC
   36WvuASWZ1HcjRAOWCy5cAaK1OmbQ7RsmSZmrjRv9bAunLKdd7dmkga8C
   w==;
X-CSE-ConnectionGUID: W/2miQB2Q8WAfsX1PrjuFw==
X-CSE-MsgGUID: cpmvTd0sQcSl83rYDFMX5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17298165"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17298165"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:20:29 -0700
X-CSE-ConnectionGUID: CilwbdNQSZ2OpyDlTTk7NQ==
X-CSE-MsgGUID: TU9GHdoERfie9qKdFRHXoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46032035"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 15:20:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:20:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:20:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 15:20:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8qC/ESPBWT72pTSyAHB4e8uXVQym2VjrdbFx+sPbHlEBeGmUovrdEPJQDV/64Hx3ThIbfegZQkCcNhsjSx/niWjhOEM1pQWAbJ3i+lc1Am7ZvuTzJI84u8uz4UapoqEGOH1Kz/K3fl5gy/z4tXB31Du12jFTv98gD/neHYJO5AS5CwLOEjpCnK4ODeFmAIB/XeDuPR1/wrqbiTn7InqpF/okzQteFQNLiTPyGjui6EVDB3N2WC0GUGMtSrqFoupwlewRi9QlUW5bm79iblFhwhw+0S3SaVMuWMb0uAIr/RyDwvgYShb2AT3y1JENkIyRLIbN05+bdpCkcBhmsf4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uql8cxF6ordwWErd5ljA2hqBWhXcNcrm9h9H7rXbAI=;
 b=i48cXRG4X/CEW7jNBdndTxVY61Ta8Adormh7vhHafmv9phCHyoytcp7cnpauoshg5RkP6mEasPKGzzeNfjkHBJJfp0ngwgmcmVJcaQdB3r95PojhbBLICNdeGLTCfOlfld6o8V7HJNT++D896BIyh/2QiLwRvl02brwSGVj+k+CkSqfBTbFIKf+YPfORTO3eOZfrh94aYLQXaY2b2ZvypZsyCwTnBchhhBYH8BFdWJ4uXWe9UOCWS0R+1GbWcS6Tl+yE23ZP+QJG2usCnpwu9GCS2djLX5M1vTVu6LreKji4WIIQr+tKrpYMmarBJZ33AtC+0X86VrU7+G096YHDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 22:20:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:20:24 +0000
Message-ID: <c4e4d913-2bdb-4451-be7d-0fee80ae0c66@intel.com>
Date: Tue, 2 Jul 2024 15:20:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <1e6ed2bbbc7716a1606865b8e890afdfcea7ca1d.1719842207.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1e6ed2bbbc7716a1606865b8e890afdfcea7ca1d.1719842207.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf38e1c-290b-4629-c042-08dc9ae52b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmpqQ3dHaldRZ2RGNlp4ci9oRTZ0blk2WUg3L0JOcWs5UFFlLzJBT1lUOGw1?=
 =?utf-8?B?RkJtUENmVGdCWVZvL1dDQ0FHc0hNeEh6ekZyWURzUXFMNUJiWkk2RnQ0ZGJh?=
 =?utf-8?B?dktoRURZeXQxOGZxQ1dDTUJEQ3krYVVJK2I3R1lqTktDV0NRRUl0em9DbXpE?=
 =?utf-8?B?QzdIL0VoNGpPUHpxdnN2SDArVWtxYVEvTitCQk1Xa3hJMXhrY1pjMEFsd29u?=
 =?utf-8?B?d0hCL0I4VGswVzZra25lcUZOR0Ywb2N2bzR3dEtOeWYyeG9ybm5tUmNGY0tq?=
 =?utf-8?B?SlVHb2o4QlczME0rTkdiOUt4MDV1c3Bkb3hyUWo5bWhWc214TzZoblVGa3FW?=
 =?utf-8?B?YUIwNUR4eXZ1M3F5a1BESWtiWnlrOFNkeG1nay9oa3c0Sm80eWUwQ283NDVP?=
 =?utf-8?B?Nzh6SEh5Q3JhOG1XazR4ZGJEeFdLQndFZmxpOWRLUEdRVXVvRVVyeWsrbXdi?=
 =?utf-8?B?RVF3RGE4TXVZRHB4ZURBWFFYYjdRWXB0M29BM3FZU09aZDZrbmJIb1IveW9X?=
 =?utf-8?B?ZGo5VUNZT3NxbURBU2tvUXg2UW8vMWE0UUlSZ3Z6YS9ER1YybldoVnM1NjZi?=
 =?utf-8?B?U1NrSzFYT3l5dHFsMXo1eFZzMFJ2Mk9ER0F0UGwxM2xIU2g5Z3FNc3AxaSs4?=
 =?utf-8?B?Tzdkc1FEbU43U1lzQUd2UzhXL0owRXg2M0ozMkVZeEtyVXUzaHZNZFliRThE?=
 =?utf-8?B?VGptWVFsdXJ4WVNiTzVrWFRJN3FFQUFXTExxZGZrZTZSd2lRTGFDL2VOU0tW?=
 =?utf-8?B?TWV1Rkp0SWtMenhXT3g0V3FHWWszZU5EMW1tTTNLdjhJWVVQS2N6dEVJRm5o?=
 =?utf-8?B?UEU3MkJpcmtydmV5N0phRjVoY3Qxb3MwQWFRNVVES1RnUkROS3BobE10OUVv?=
 =?utf-8?B?UzE3VFowNzBDMzdYUUlpdzdxZ2xEYWZ0RXM0bXh1NU9USktybHdtbWJ2TC94?=
 =?utf-8?B?MWdyTi8zamFlN1ZFZGJ6RUp2L2o0MVJjR2U5bUxtMTJzdXVhNDdVczl4ZU1j?=
 =?utf-8?B?R1o3eDh3UWlxNE05NHJRemlOR3VtNkpuMTRrR1c0L3UzWVdFSmF5OEVWNmNP?=
 =?utf-8?B?eHdmSmh3ZklxWHdwQ0RPVlFNMXFWWnRWVklZRTR1cjh5ck5WWmZpUzRkYTh5?=
 =?utf-8?B?Y1ZmR3UvOXk3dldUWFJoaGdOWjhVc2YwYzB3bVR2K0ZOSitJMXkwSitvVUk0?=
 =?utf-8?B?aXlpTXoxYXorelJmckhhRlFNZXVDS0UrSVRMOTlpdU04WVRlSUFVcUl2TUZP?=
 =?utf-8?B?aDBwRGdiMWhIbnM2M1hxRGViV2hJTThXZWluKzc3azMzYi9oclZFQkNWQkJx?=
 =?utf-8?B?RHFpdnJMSkpOZDljSzBkU295eVRqQ29IUGtYdG5jaXlDN0RCWEp1VmZiZGdW?=
 =?utf-8?B?RGhjazU3bjkxL0h4NGd3Q2ZHdytreDk1UHRrL2tOQ0g4cE1iWW9LZ2FYVGRi?=
 =?utf-8?B?cEppVzhZeHJBMmlEZGE4YTZOY2tWZjNSMisvWmMwdXBkY3ZkNERqRXpNaTBz?=
 =?utf-8?B?SFk5OGV4dmFuSXhlYStjdnhhSTk3S0ZaWnEyS1RxWXlUZy9EbDM5SHhCZGhi?=
 =?utf-8?B?TmdFNFFIdnplWjVHUXd6U3RNMGxGRzg2SGRWbmhmcndrcFRWSmNVVHRGemZK?=
 =?utf-8?B?ZFF4L3ltQ0VZaWY1M0RHeDYzSWZJL1JKK2Fpdkh0VjI4YkwyZi81ZE51MXdt?=
 =?utf-8?B?Q2JjYzVSZVlKYVlRejRmc2hwZGpCSWlJZ2dsaFpxZ3daRW1kYXlNRlpwSmQ5?=
 =?utf-8?B?ZGpPcDZjU3FQNUwvaTZoV2VlUGRkdjRWQzNkSGwyazUzL3FhRjVoNVRKaWw0?=
 =?utf-8?B?SURCVFlMc2JyUnVwQ3IzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElIMHFoSFpodk16eStnRUR4dEYrNEd2WVB0bHpRcjErZ0dLNVdkTEo4SjB1?=
 =?utf-8?B?NC9SNmVOMDg1QWN2OHpHVmh2RFk3SW5nQ2t5NmJhc2NVTmgvZkRHZWh0Y3dv?=
 =?utf-8?B?L2ZJdmM1ZHRSWmY4UzBOK1owOUoyYlo3RGtLTWUwWlUvMzVPaHlOQTE2NldO?=
 =?utf-8?B?MXpmL1RLLzhSSUxQSEgvdGVhNXJVRmRKNEl6N2tmdkNwMWdrQ2N0Q0ZZVW9W?=
 =?utf-8?B?UWNHU0JBd1R5OE1ETkZuam5ZY09pYjB1V0dZa0ZPelFvdGdSeWJoemVxdVlB?=
 =?utf-8?B?OTNlSVpPYURzTmNHOTZCTXNYWVJKbWFneUI1Y2dRTiszUHdiekNBdGpEU3Q2?=
 =?utf-8?B?eEJNUnR2L003U1Q0emZERW5JaDlKV2c3VjNhNTc4ZVUyVCt2aTBuVDhjQ210?=
 =?utf-8?B?S3dMSEo0QVc4Uk5ackNmTVNpb1Q4NVhpaVlWRTM2TGcvd1VIMGVSSXFoYkZS?=
 =?utf-8?B?emVlUEM3WWJiREkzRVdBNkdZaTVsSDUzdnh2eDd4dE9vb1ZRdHAxbjhuM2pJ?=
 =?utf-8?B?N3R5Skh3U0t4bnd4RDJqZ3lzZDQ2SDBvaVdabjhJTHFLdXloWlRMWmVNQ1FL?=
 =?utf-8?B?Z09kb0tKRGRiLzFJUnZCMEdycDB6SDhZczlaRXZBRzdLLytMeWlKZlEvTitY?=
 =?utf-8?B?V3dQK215cXZPeGlHVlZNTXhDNmF6MTBIUloxTkFBS3BqNlM3am9nYnF1STg0?=
 =?utf-8?B?M2NCV2dGblJPVDJtOGlFWmk4TTNZRnMyVkRnNElpYXVrdHJwTGZKZVBPVjU2?=
 =?utf-8?B?Vy85bWhHeVlkdzFGWmw3R2V5UDIzbGVzVkY5akFlUE5ocFRXKzdPQ2NtcXRr?=
 =?utf-8?B?SmhKVnJNaTFGc01lL2tucXBwczF1RDhnR3dJajZQTXlsTFI1V2VxQ2l3cW5B?=
 =?utf-8?B?OCtnclFDUVlsU1owRzlEQnhaYXBzZHFpeWg4MFlGcDF4QnRIYmp5cHhsYWZ4?=
 =?utf-8?B?c3NuMXF6YlBrRnJ2Rm1PUlliZTJVdjFteVZ4eEdBcGZzb1lBUEpRWXE2bGhC?=
 =?utf-8?B?UUdUWEdkcE1kNjZyRnA2M1dMQlR6bm01M0E1UEgydUt1eXk1VUhuMjQ4V2Zj?=
 =?utf-8?B?aUlkdVlRTzExazhLdVl1eHcwM09TcTlucWx1VXZqa3lVeGRONlU3VU81Q3RI?=
 =?utf-8?B?VCtkeWEyMk1iMWl2MmNqaGhpUGVsd2ZSVE43NFJUN3ZmeTJyT084MXlUU251?=
 =?utf-8?B?L1hJeVJ2Q25BZUV1NzRsdWdhVWJQbVZwTVp4TEpjSHVDc1ZkUGM3bVlPcW5a?=
 =?utf-8?B?SURWU01EdC8xT3F4c0JjNStFMVRpYWZLU0FWWGViLzgwTzRHTHZBSXFzdkRh?=
 =?utf-8?B?SVVRenQ2Q0laNGFwUHovbmJqaGdEc0I0enlsUmVEYk9vNmQ4eXd0bDVHL1gw?=
 =?utf-8?B?OUNNRXpGQ3NMakxMYzhmNHU5d1VFaHR6QlM1c2hlSzhaZG84MUZjUy9GSFo4?=
 =?utf-8?B?MnhXWGxDOGNaRTNLa2FuZDBmeEVNT292eVNoVVNWa2pmcXk1REMyempTVytj?=
 =?utf-8?B?Mll6Zlp6VnkvSkNuZDQyRTR6TVBTd1E2TlZMZDU0ZlA3TGp0NVlIVklxSGVB?=
 =?utf-8?B?WWFQSWhGTFVXVlNOeXFCbTkzWVJCRUw1ZjBKbFJtY0NQZEswWTNGQmIyUXp1?=
 =?utf-8?B?NkxJb1U1aTNkUnlXSTl2K0ZaSXVtSVZHQ3ZpbGNwYmRUTGNld2xlYXFLSXpD?=
 =?utf-8?B?WGdRZU1KelBibi8wMGhubDBaSUpaclRLMXdHR1lmSXFtMkxQZis0aE9ibTJ1?=
 =?utf-8?B?L2ZtQ0RVNStjOC9pMjFrRTlORHpSQkJuVmM3bytKY2hBRWovK0VMVlFib3pp?=
 =?utf-8?B?aFBWZVFLSy91ZHl5SU8xZWJmcDB1d0JsRll6alFoamdjZkQvUGltMGVrbS9G?=
 =?utf-8?B?ZnZ4SkZTMitJQkNqS2Rub2UzTmdpTjZCVUhpOFpkc0hxRFlxZjcrUk1LZ2pR?=
 =?utf-8?B?a0VqMFo0Nm5VUGxBR2FvREFLZ2J0LzU5bjI5RjdLRXh5dVV0VGFPNHBKQ3dZ?=
 =?utf-8?B?UHpQKytabkg3ZlZ0L3A2SVo0K2NMSXF2VWlUTnIwTXhWdnRZaUhtenZKcmRU?=
 =?utf-8?B?Ym8rakxpRlVIN0NSbHlzbGZkY2R0TDRkQlBJTW1zbjZpS3B2QjRpTm5ZSkNh?=
 =?utf-8?B?UlJvWkpQS3AxeTk2Vnh0dThKT0VtZEM1NzA0K1RjdWVvTjIvbzhWV0JlVlRC?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf38e1c-290b-4629-c042-08dc9ae52b7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:20:24.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT3fFdlCfzWWZFQTSnWAIE+BrqaEis3HuaFWH5C58KPowSb52kAEYiK11l/q46XS1i0tG4AeLfjwx5a5ja5p0YS00QX3tAGLCpdSOIbRk/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
...
> +int snc_nodes_per_l3_cache(void)
> +{
> +	int node_cpus, cache_cpus, i, ret = 1;
> +
> +	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +	if (!node_cpus || !cache_cpus) {
> +		ksft_print_msg("Could not determine Sub-NUMA Cluster mode!\n");

nit: could you please check this series and remove exclamation marks from the messages
printed to user space? Just stating the error should be sufficient.

Reinette

