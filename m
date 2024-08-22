Return-Path: <linux-kselftest+bounces-16108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320B295BBE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 18:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C121F266AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2B1CCEC9;
	Thu, 22 Aug 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqY7C3DZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9F282FC;
	Thu, 22 Aug 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343977; cv=fail; b=Q5tnIYmoe+/THfhw3AdIone0NPLgk/7eFweM58Z2cuXYLkKwGmCW9edLH4Ega8rWU9KQ64l6vxCUPnPR1dCR3y/SW/VSwm/7blMdZUX4ErYKM7F5B46tdpdnCNxPNv5dFGWpKQl2j/yqjbq0eIsuUNb2t1JXqJr1SNJVDhgDvT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343977; c=relaxed/simple;
	bh=MwbudElKlm03T6nyoxQG5pAunhedO0W4/Bbj3Zq3oek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kcLkW04NL9yfbkMBWmQbCmrQCY1T7Wq9o4EW/lvzxVc7/bJ9nxsdT7in+o/KJwM83IGheuQMmaCIwhMdU2jNxEpSuNncS7v9kQt9iy2RJrMtQWWTgVNqQJORwli13N43AXsZe38JMXxSYJRbvJxmJmQ3Gt1FPLr7+gpeBqmzArA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqY7C3DZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343976; x=1755879976;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MwbudElKlm03T6nyoxQG5pAunhedO0W4/Bbj3Zq3oek=;
  b=aqY7C3DZhYrA+d/mNaWnra5v6x/a6lkp0GYUdZXaUas54eIvea5XWwff
   4vntMn8GbhZYCGAmz+bPifqKhcbeO09zrGyXl60sJaMcWwQDqgJpYTFcc
   xVt+n/zFlAHV2gPOwed41EvDdfd3D7lKz5GtsonAVe+1KeQDinf1rl6id
   DluGwfp2uSfsWlFCwdQQyMoJAGTf3+SqykdptR9p6+IXJwPQt7YUF32hM
   8shHxTIJSlz5D1xpUwdkWKhRXbCZKOMODhQVFTTuGK8PVHeMIol/ehtcd
   td+HGrBZKgv8EfJvPFSvROMxfWh/xqpplshFtTTMGOy0qkCDRK1XkBjiz
   A==;
X-CSE-ConnectionGUID: jBQ5KlrkSXCcOcAPitrdNA==
X-CSE-MsgGUID: eZ16RfaETA2XxBqOkE/fvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40239682"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40239682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:26:15 -0700
X-CSE-ConnectionGUID: LhKrIJGuTmiJlNKGWNHHxw==
X-CSE-MsgGUID: onta5XqgT9iijO9kNZTfiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="84683972"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:26:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:26:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:26:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:26:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:26:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peIOymQAuxiQJ0BtaYt5tX9LQss4E9+nfJbH+GTc5CgHBUhbMEMJNXx/h8uwlGNJLxncslXYyL+nIK//wRbPgtur3+uPC4r3pfgOvgBxANrJIsS/vQ3yesGXQUHUmTBiE0365HJVL1GdChgs08E7BwseNfYYsqCQnLhvekZxqn3q3rltvv4V08DWDvCac6wjClp3VP+bNpz7Biaf62BRkuL1YNBbC/iIaoge4IA6d/ieQdJZLulVL/LnLxkSMuB/u1ih7Hh2dVgZeXZZ/FWGgAcwLsqrkSLmHsLzTVH++2IO5QdcyAcNlSirr+RO2KZXOGKx/50OXkD3p4jggqY4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCYkAuDqBzgdy+ip4qdnrcHtHCGt5A7A+8+MZUEpE+c=;
 b=bcz+8HZq5DdKy1pxKMQjGUFQmbx6wBwnkNfPuoqMqLcyyrLhhkdKfsT50hQfeiy9lWaGESGO7WyQA68T76biNmEJF/QbDdLz21ua0ET8tzfESVsLdvrR9gznTUNYEKJyaens3oKARXC3odzWvasmzBZelvhyJ2LoREI4705owXwci+W3T08KdN7Aj7C9mfOIbRfdk9zhR2Wu/TZR2VpwjVqn1knkRBQ4DGt6HP9CXoSoyk8GlcWSMd97uoDj7xhhffrfBkoRxKZ0aSs1ixk7jqkkiiBArsTq/aYcxu50IhaFUZWHTLVXX1hr+L5Y9gOz6x/I44CALjgPx9pEIgLJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 16:26:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:26:11 +0000
Message-ID: <a8313b8a-0f77-49de-b079-35c372f27c85@intel.com>
Date: Thu, 22 Aug 2024 09:26:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Generalize non-contiguous CAT
 check
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
 <20240822081114.4695-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240822081114.4695-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 1981ab7f-fee4-4a83-bc29-08dcc2c722a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnhRQWJjTFRVdUs1NHRFdS9CdWlkVEd3RnJNemFqQnlObHI0UjdQREdJZFpu?=
 =?utf-8?B?Z3BWVDAxR21rQkljdjlOOWN3cWE0WDBDYi9vNjN4bDliWERkVXRWWEpNWnBi?=
 =?utf-8?B?c0JTc28ydHg2RG1HVGl6QzcveTIyOG5VOVVPNks5NWFmN3JsZHBBV2pXaVRN?=
 =?utf-8?B?UVVzVDlpbDIvQW9iR1BKV3pYQWlVdCtBSWR0TGZ0U2QzWnpmKzMySmxPbmpY?=
 =?utf-8?B?d2IzeXk3NnBPUENPUnZYcXFMY0FLV0lLMEdFNWViVW9DVTB6eCtvQnpsakkr?=
 =?utf-8?B?OFdsbDRyeXFxSjlYOFp5dExEL3A0TkwrUnZzSmJDSzZUR1ZTa1RuTFA2TVVH?=
 =?utf-8?B?UVBHdWZUSDV6VHo3c1FvNDhBdE5YVGhidGNrZStyTG51Zlg0Y1NyKy9NR3Ix?=
 =?utf-8?B?VlB4VVovTHI2RiszaUF5MVFqYWVBYzh5Q1djaThmOGtEcFpVY2pieFlEUEV2?=
 =?utf-8?B?dmRhYkFtVllXMnNqL3htYTFEZzlTeFg4eUUwNFlSc280WEM5ZlJtaGM5b3l6?=
 =?utf-8?B?cU5oSVhJVGgrZ1pNNlNab3dSMUFUeWFrRE02VXFBQmRzSXFHSTJhUXNMcUlW?=
 =?utf-8?B?YisxNmpKaTRLOWpqb3E5QmNpclVEVjlWak53a3FQd3pFSnA1YWZrTzJ2ai8y?=
 =?utf-8?B?ek5tRGJSSzNuS2wwUjBJaGVxZFdFRnVIYkEvTlhZWDJ2SmIxekI1MndFKzZY?=
 =?utf-8?B?SG16c1k4RGtZSlBmcXRlV1ZHTU9MY1czYm9SUE5naUpoVmxtMkZpdlI5aFRX?=
 =?utf-8?B?UmY0R2g0QWlUdlNZUE96OEMvMDAyVm5hY3V2YmVNeDd3YW9XYXFaSGt0OHp0?=
 =?utf-8?B?OXI5U1F2RjlUTzBtRkZLSHkvSTY0dlc3bTlWVzdJWENzN1VtcWFxRUsrcFZy?=
 =?utf-8?B?eU1XYWtEZHNjTmxZQmdRQ21JMUpXQjdCT01MRHJDb1lLM1RINEpiTDQwd3Rz?=
 =?utf-8?B?N0VrRTg3R2Q0N1l2V3RhdmhmZEhxR0FYbUZFQ2Y3K1V3cnVkNEVtSVpjQWUr?=
 =?utf-8?B?VVlsUDFEVXY5ZExYTGJyWlFhdUYxcjE2cU9FZU5qYXpORjZ0VmVGcy96RmpO?=
 =?utf-8?B?L2xtM2ozN3pLMXYxajZLdkh2VHc0dTJFbEtIT1p6TVVLY09FR1lzUmY2UmpX?=
 =?utf-8?B?K0h4T1o2L3pzaUdIdEIrQnF2U2hteENtd3BLMU5jNm1zMDlaaG1CMjhkQW5O?=
 =?utf-8?B?QTI3Z0Q2ZU1Mam1Dck5ydi9FK0lvaUxHdzkycENTRytDNGR1NTBGa0luRXE5?=
 =?utf-8?B?b2VQOVM0dDNBNzgyKzYvUmo3NXA5NzFTVisyTkIvck1pMTBhVmNIZ3FDekZV?=
 =?utf-8?B?MDZUZ1cwNmloN0oxTERRWGZmazgrMExYcEtSYmxmWllVYkJHMVFnOUJ1RmpR?=
 =?utf-8?B?OEFuRUZON2EvM3RiS08wQ1lsbjh2WWsxN25HdDFmMVdlRVByMFFXTnVodDl5?=
 =?utf-8?B?MmtTQXYyZ3V5QU1KZU9tRDY5T0MxM2d2cmRMRmdWQ0pqajBxNlRvWVJNdTA2?=
 =?utf-8?B?a0dqQTd3K3huUjFvczlGUnplVjVRYXBnQWlLemVYZ0RKOFN4THNaWlFZdG9a?=
 =?utf-8?B?ZnU2dys1elR2SWJTb0NWdktidnFWMHhmdUg0OVdVQ3AyZGRvM2xEUzgvVjJr?=
 =?utf-8?B?YTluWGZmSzdLTnYrbE8ydlBzN3N2VnZMUENZRVJuSHlkc2pRNlBST0ZPaEFY?=
 =?utf-8?B?Rm5SWnhjdWQydFhja0NkRDZRc3ZsMDV5UWdZNWpNRko0WEMxTy8ybUNidmZV?=
 =?utf-8?B?WEVVenhJczQzc1hzK3NyLzFGbVg1akFITDlqT1Z0dXJERmRqckZ3Z3E2SG1U?=
 =?utf-8?B?QUtLcWYxZ3BvSTFieFJydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDY4SUMxMWFZWXoxb1NWelpzUTZ6WHVOL1ZIdHpBT3RTSmIrUS9jdG9kQjdT?=
 =?utf-8?B?MTNkeGVqZ3dKQjM2bjRSQzFXdVd1cWVXVUE4dDh4MFJJWGtaK0hyeUFZWUo2?=
 =?utf-8?B?V2FrRmpkNkRDWmxlaGd4ODl6L0ptUTI5OThiZFFSVll3YlI2c3J3QXRwYTl2?=
 =?utf-8?B?MG15V05uUC91bDZ6L3hNaUF3YnJXQlhFdkhOQzNNeEhpTEIxVUxqY0lpYXho?=
 =?utf-8?B?WjJ3cWZlMGpIK09VV2YxZVc0MWtOTVVOSVE5VWRxNHlmeGlsSzVVTm1VYXIx?=
 =?utf-8?B?ZFN1dmlVOTdwSlBDazdTR0dFTEk3eFFPSW1VRVlYMkFGT2loV3QxR291bGVo?=
 =?utf-8?B?NDhDQ3JoRVo0ZHgvd0VkSmlqNlJjZERUV2tNVUtpR2pJNHpBUlBLc2FRcWx5?=
 =?utf-8?B?UFR1d2dIZGZYeU1PRXV3THI3VnlXd20vVEJQSHlvUEE1ckI0Tk12N0VESEVi?=
 =?utf-8?B?RkpzWEZvTkg2dWV2SFpBUVRzUVJIcVhJbXpEUmt5WEd2S3BZRTY2SC85bENY?=
 =?utf-8?B?WllrMk9yUnpPc3N4MFhWd0FydnVVcXBDelZZUGRSUXpZazJqSVBLdjkrNFdG?=
 =?utf-8?B?Tk8rVUZaZ1NkYWt4aUUyb04wcEpiMFhhU0RwOTQrdGVPR3J3WnBCMWhCclJR?=
 =?utf-8?B?VWNDMGZjUHVlL21hNVQ4TS9memZEakFRM3UrSS95dFpMc1d5UFJSWHBTMmZr?=
 =?utf-8?B?cTJDYlpFSFJpVmh0VmtSaTY5UVBqZmkzSmRuNzlWcVdhcFl6NlFSV2hSNkQw?=
 =?utf-8?B?VlcramVTTEswcXpuMEZEcmhOUHRwLzAzR3lQbUtTdHR3eFgrcndkYlluVkpG?=
 =?utf-8?B?dGZjenZQLzVXNURiT1NSNzhkOTU0bG5FeDlycTdhNWJJREtLM2g1dmdKdzM5?=
 =?utf-8?B?bGlzTVRKVjVzNzRTampKTU5UVHFpUkxHOXpGWHZmdDg3ZUpuTGQzZ0R1WWpL?=
 =?utf-8?B?S3BCV0krRWpnNFJTeU5kUkRLR3FiNjlCdk90dWpueFRabDBTbFYxUVA2SUt3?=
 =?utf-8?B?Z3ViUkxRNVo3Z0JwSU1XaXd0TmlEQjJROG9SU3IxMGdBK3NLdVRoQUFUU2lZ?=
 =?utf-8?B?L2RmMjUyaWdwTkI2dkZkN1lhUndVZGhrTEFxdlh5TS9VNFUxWHNZcHBLakVw?=
 =?utf-8?B?K2QvM0x1dUtkZ2JnK25TcGVad3RVeThsRXoyd2NoWlhXOE1BMnI2MVloK0Nt?=
 =?utf-8?B?cFlWV0grQlZkcm4rd01Od1h3U1l6MjZhZE4zQ1BUQnBWS2tmNFFWMlFlOVk5?=
 =?utf-8?B?QkhvL1V2Z3hHTTE1YmtqSkFzVUgvWFFPcWtFMStwRmR4SDAvMEI1QWhzeWpE?=
 =?utf-8?B?aUxCUkhmT1JxUUc5bytkV09HNkhEd1lQMll5RjRFbWdNeWV1U3dMSndmNVBJ?=
 =?utf-8?B?emw3Rnl1bGNWaG5UR25HdEQ5OGl3akNaK0xCS0Uxd09KRkdRN2U2TVNpaGE0?=
 =?utf-8?B?OGk2bk5QMEtLL0h1ck44WTRlM0lmTjhIL3BhTmdzM2JJRUdtdU40VCs0c3hK?=
 =?utf-8?B?R0NEWDdveCt4QzhZS01rc3MzcE11VXhoSjJ1T2VKV2ZuQWxGSklXaEJuVkt1?=
 =?utf-8?B?YlUrVURpSkpNM2NvbEJ4RkNYbk1Ia290bG1tWWJlS0lveHZlS2RpYnhjV0hF?=
 =?utf-8?B?MXFVTHNQdnl0aEJVQzZmb1dRZXNvV2JScFd6ZGtUUDJhREg0cFg5RVZ4Ky9o?=
 =?utf-8?B?Y1NZQXBtT2NBcnI1OU8xTHRJcWFUU2VYQzdHamlrQzlPWXoybDhTTGVOcVpx?=
 =?utf-8?B?VlZDcmsrL3dGUHZtMkpwbno3WVhwNWJQaHJOaThuNk1HS0l6U3E1b3daK1ZQ?=
 =?utf-8?B?aGlucm95ZU1CcHBXVEhRMUM0U3BBMGhtcDIyTFo0aVdEcjhxNzdGbDlVUHhN?=
 =?utf-8?B?b3ZiTjA4SkNaMjJycnFSUzh1cCsraGYrRUtYbXA2MnRQd1hlcGhPbjlxRmgr?=
 =?utf-8?B?WGJnZE13dmJpTlNTSzE1Nkh4bHFvYTRucFhzaHZHalhaSFE3bTVVTVl1ekFL?=
 =?utf-8?B?eWFyazBBcmNUN3FoMTFlSlFNZ3Mxdll2KzV4OEtGUXhuZVVRMDBkZERLblpX?=
 =?utf-8?B?ZWhKVHhsRFV2TDlHbXVVWExEeVJKQmdnUllITzNKUTl0M2lIODIweVNjVmVp?=
 =?utf-8?B?N3UxRGRsVVh5RU1ZaXJjMkZLZUdOVnBkOWtWbWk4a0gvQmV4UEhDcFdJMUpV?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1981ab7f-fee4-4a83-bc29-08dcc2c722a0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:26:11.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zo4PSelQ7KIsq0B7eJvEymKzxX130xpWoj9wFhjk8I4SKR0rSrpJOcwzl/VghL6VaY80H9ycBQjhDFlMDj0hiswGtGDmDGZQsDA73xXgUPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/22/24 1:11 AM, Ilpo Järvinen wrote:
> arch_supports_noncont_cat() checks if vendor is ARCH_AMD and if that is
> not true, ARCH_INTEL is assumed which might not be true either because
> get_vendor() can also return zero if neither AMD nor Intel is detected.
> 
> Generalize the vendor check using switch/case logic and return false
> for unknown vendors.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

