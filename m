Return-Path: <linux-kselftest+bounces-34096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04AFAC989A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 02:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D2B9E5E74
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EA4C92;
	Sat, 31 May 2025 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNX+znx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC528FF;
	Sat, 31 May 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748650527; cv=fail; b=LQVOfYZm8TGcsxT44JUag6NJc6N3eAMxBR8iYSMYw+5bz7u7ZPiyC9YL0XAXme3dF0rrZY/TE+xEw5Qoyg0rQWvz/hdscKKNXtcndhm03H6hKBmjVFCP6ZZ1/ubgU0YADlLvmpVdI4BEhDZAWpIzaNgD0OIEb18//GBxZDY0lgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748650527; c=relaxed/simple;
	bh=s0IyvXYrNgM/AW/PGmikeIIQPiIM/3ZO1RRCxAPdMyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/2n6Zj7g/cGx0Q8lZWOHJlxJffnwhxAvKkuXFEd+GfH+mQ69UcjeUAE4F+udLsqIjQpDrxZQRJaWxITLCAeUo8NykmeVxjJhrVm2BbbY6wi/3bU8A2RwFsmIbUbeyrJBFlet0mZ47OkmMifmCEyNLsiA9ySmWEtMZ/K0gspeCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNX+znx5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748650525; x=1780186525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s0IyvXYrNgM/AW/PGmikeIIQPiIM/3ZO1RRCxAPdMyA=;
  b=dNX+znx5WtTtKa9vHeoCYJG8pCG97bvlRTJgKt4Zyy4Pbr37kHMrZTAl
   P+ExN2DntLcIQ+YzPER3f1DVty/T/OyjwlT+DVQNtcEzsJjNlXAJjx8zk
   8nr3h2hFEG4RQaW+/uF5l7QeHhSUm3gaFGJ7OXrxE9TAPgHzBwZuFwBqA
   tr84UlnZ2LeLyvrd4HcNRCc0xpwxStbWQutS4PaQNdTNHhKRGCGFAXRng
   pmO/edIFZSBc06nBDLdwCHunxle0j2lYx+1QKVOffW21D6HyfqYqfKB+X
   AYh1yXv7NANONwWWM0JHaGBjwi7B6nLn4XzMjq9OzvsKpIQjTHnOcOOK2
   w==;
X-CSE-ConnectionGUID: u9qeDUo8TOOdBXjog8hJSA==
X-CSE-MsgGUID: OmlxxoRCQ3WINeZRUO0pqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50851488"
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="50851488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 17:15:21 -0700
X-CSE-ConnectionGUID: GIbDHBPyRaysk4cPyGB6MQ==
X-CSE-MsgGUID: HRzoH6rMQiGf6MwrAcFKRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="167198903"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 17:15:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 17:15:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 17:15:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 17:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koDsB6KDhBVWqyPkjMiC/WlSwe5NmmqAjr2fEll9NWNe6TeBkm4roTDD/WgoqQaLFlpKFyRZW4yr04CTWlafIUIhL3FE8dbEw1LYIwEYHtnkeHkzeNBGrEHeeLb0ZHPsVwg7mFLdXe693r1rVxfqZMKESivuIku9eb4RS7I8uAELwYQF4e0fqdNtRyN+C/V86id2E2fTqRdqI+wyprIA8ksFMI8stjzc8vmlAxIOw+PaEA8Nl5gz71Iwwsqk06A5ulP4JW4uLOWi6/8xNU0NtdmHfe76IxQNWPvHTgnGfsQgB6j+ND3+oxI6d9QgY4x6xvYrOnAd8RmTorlmY4B5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNhceUk75rXGzzpE9gysovv87urg/r4sGJKOGYOl9r4=;
 b=oPQgC0cWif/Ja4tyi1yH3+9vk+eQm0mMRj6+hNKgv0LS08joMuuqYG1o9FWpKVKBECOIbf/6yVC1VKdbJ5RkCttFb/W6tO1XhSD8JjQkq0dCr6ucQ0g8uvpWT5PCrT93Qc4ifP8KdMEa1MNKP1tSwwePpYD9SVtxHA87l4BgOrZ7AcrtzkZYSZDufih+JlGWlTTg/QqPhMpXSM985tVywaNbrNxA0eOEvW5NPAcJKLV3lQn2mRcfa2wSDTJlJhf+Z8dpY/vT9iUi++2K6Yus+u8utdaM2MTxazoFTPzPeCYp3HnN+Ro8VY6dYdaffQDwPEZnywBTyutsHQf4GY2KGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Sat, 31 May
 2025 00:14:29 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%4]) with mapi id 15.20.8769.025; Sat, 31 May 2025
 00:14:29 +0000
Message-ID: <cd6bffc0-2d11-4f2f-be82-0f4504fb26d2@intel.com>
Date: Fri, 30 May 2025 17:14:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftests/x86: Add a test to detect infinite
 sigtrap handler loop
To: "Xin Li (Intel)" <xin@zytor.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <andrew.cooper3@citrix.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20250530230707.2528916-1-xin@zytor.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250530230707.2528916-1-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc7a125-519b-44eb-38e1-08dd9fd81c4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXQvajNRa25PTnRwNWlSV3AraGQ1SFU0cHBFdkFvcml4ZnFZVVJaQmh2eXY3?=
 =?utf-8?B?Z0w0ZmRXZit0cXlPR2cySUxzeFhwZDhhbWJSWW5yVzMwelNWeHhOczJQOVhJ?=
 =?utf-8?B?QmVpUXRRUDJ3bndJcFpYMThGNE5xTEk3cDg2NEY4WFBzY3p0VDIvSkwzbXds?=
 =?utf-8?B?SUdGNHd6N2R3cVg0UlQ0SC9yenhqUEFBa3d6RDRxTkR2ZEQzVzlHWTFSZ200?=
 =?utf-8?B?OWpkTXJDbGsxTkY2ZGw3bXFiU3IraWl6ZHBjd0I4Z3lZbXdab3RqRjlrcEN6?=
 =?utf-8?B?T0JyeExISFgrdG4yK1JiVnJHbTZMaS9hbTlNNUtNaWp3VTRQS3JKQ3k2RnBt?=
 =?utf-8?B?YTNhMURUdGVCV285SEhFZ3lQUVZGWng2RU53RUh1UmpGRFZzczhUVVpMbHU2?=
 =?utf-8?B?SVRCYlR0WFZoL3kvRkxhQ3MyZlVhd2dlMWVUWWUyYklvVHFCNGJ3Y2JsTGNF?=
 =?utf-8?B?ajFPMndPak41TTVtWTdYQm5aY2l0cEw3WWxWRlpyRWVrMjRiMHBVL0hNWUpC?=
 =?utf-8?B?OFEydGFmdEtqdm5HQmxyRis2aENVcXpsRXo5cGV5eXcxUE1mS3ZhcmdQL0Fj?=
 =?utf-8?B?cGxDbEtoNGd6MW1Md3JCTmpMVWttSFZHYytJM0dMdEpPajFKNXRDQ2M2eWE0?=
 =?utf-8?B?cEc5RTE3SVA3aHd4TnBzdE1GOTYvU1BvUWx1MGd0bGpIdWtlMTVwV09yRzZB?=
 =?utf-8?B?SjU3MFpmZk5hVytjUndBY1Q3Vm5zV0QxK0N0MC96N0lYZnN4Y3g5ZUlLVElN?=
 =?utf-8?B?R05LWVc5LzAxR2s2bGdGakNYTEdCN3llWHNLeWFmUENxUE91U0dJb1RESisz?=
 =?utf-8?B?TTRSWURDNGN5U0JHSnpGZGV6UVgxYjJES2p3TFAxaCt4TG14RjBkMEpUQk1T?=
 =?utf-8?B?ZWlmM3lPUFdYYkREYnFGQ3lFaFBzQ25tMXlPbHp6QXN1TnVSSkdOMmFmQ2Fj?=
 =?utf-8?B?eUpoYUxvcnUyT3l6RkFnQTNrSno3bzhjWXdmd1hsR3RpVzBrUHRkVThGUkF0?=
 =?utf-8?B?UXZqSWc4ZnFnakxBVHMyaGgvVkdHTXhhcE1oQmtUdytYcUl5eVRiL0pMVHJq?=
 =?utf-8?B?OVVGZTNXaXRNUkZua0oyNkJ0ZjZlSVc2SDhTMFY2UjhVdnRHYkhoY3MwVEVR?=
 =?utf-8?B?d0tzRExNNUVieUFGSEpPL3puZVFRREQyNTZUZi9lam9RNTJGUlJNcEg3Q05x?=
 =?utf-8?B?bVQyZ3lqWVRPWkw0MGRmOUpFYjF6NDBqR0VhdkVWbENhamtMWWp0M2JYV0tT?=
 =?utf-8?B?cEFDcXZVeVo3RVlKS25sUXp4Z2drMjFlQUdHVHFGRWZINHUzV3NPYi9YbThP?=
 =?utf-8?B?dUlhMDhtR1dXcXU5RnAzN1AzY25jdnl2dXJibEpOV0Q4TlpnQ2dzMHU5c3Bn?=
 =?utf-8?B?TTJxUDZXcEptcWNoOEJmL00ycFB3ejc0aWVpbGNUMGIyUVBxZldDSTJsRXFU?=
 =?utf-8?B?ME5UdEY3K1Z6ZXl2N0UrNUFvT09RbkhTQ3ZFMEhkN2ZCOFl4R2lYYlpSdVhJ?=
 =?utf-8?B?Yk9OQ0ZlRXFBcjlwTVZCcmtqUXp2RFFkR1VpdEVLWU5xNEt0V29DZGV5TVI5?=
 =?utf-8?B?Z3B2ZkpNb3JyZnZ0aGJMNjNubzVrZnBiWEJnU3hleE9oNTJVc3U0MXpuZC9I?=
 =?utf-8?B?UlVKZmY2bk8ySTJ1YUN1Q3JnZVBDS20wa3k1VENRZ3lJTmFHdjhWTkpKWjlj?=
 =?utf-8?B?M1F5OVNqeFFhaXdjYU1JTG9WZElETURSNkhONXkvZnVXRWJOc1U3U0daa1pi?=
 =?utf-8?B?anZCY2pNTXBDa3VnbitZamRIOEF1SHhGWG4zMU0rYngvQklvQ0svUHlDdTFt?=
 =?utf-8?B?ZmZnQklnbXpHTWhaV2dFSCtvdlBJNW14eVdaeFJ2Z3dNU0NhcHJhTnBuY2tx?=
 =?utf-8?B?RmNTQXdPVW5mZVl6ZS9zNjVQZFRnTG82TjNnYWRNZlBjVzllTzQzZFpUVitS?=
 =?utf-8?Q?0XPqnZ6ek+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZVaU9yNm96SGtZaWttQWRWQ215UnNlRkJGUktLZDY5UWZWWmJmYldtd1BQ?=
 =?utf-8?B?c3A0NEQrK2hTYzRaOUFRUDkvM09VdTg1NVJ4VmNKOGVhMStxb2ZCK0ZSdFdV?=
 =?utf-8?B?NlRJOFJ0Z2ErbE1UZ1B2QmIxVy9SVnJ4bHRBc1VsRlFLdDBoZlhKQWhpWVJH?=
 =?utf-8?B?THMwekcwOFJ3SzBvaGwwZnArbWlGZDZHTmsxUTZudS9ielhxc2lIOVBOK2xi?=
 =?utf-8?B?M1YwNHFnSGN3NDJFcFBodVNUTjhGU3VDcXg2QmtCaXVhdThYRjN3RmQ0L0kw?=
 =?utf-8?B?bzVQaUpjR09MakhkREF6U2JML05jWE1aOGFVN0JFYXdJT3BMV1djZEdCWlpE?=
 =?utf-8?B?Sm9VakZpUU1OS3JVRnZqalRSVjFGUXJzeTB2UDBYcytZeW5qbkJ0QmcwVnpv?=
 =?utf-8?B?QytFTmNiS0F6UVVkK2dsTkxJUk1tK0x3NHA0Q0JNZTdHTTM0bUNuNGkxYlBC?=
 =?utf-8?B?OGl5b3NiSWd5OTJpVTNIaVVZU2lDTWczZ2tkNFlTbjYwUXBoZ0thMjcyUVNj?=
 =?utf-8?B?MjZkUmNZZEFYTkw2QnpjclBsUnZOOXk0aE05YkdubnRVTVFCd3h1bXI4c1Fn?=
 =?utf-8?B?ZE9BakZzTnJmaS9aWUZPVndIeWRseGFTV3d1Rm1lQ3ZzNWxRd0xyVWpNdmIx?=
 =?utf-8?B?MzhwWjBlWVJMM2lwNzhhMGttdllYS1o0S0ZQR0tvb1laMUJtVzdMRkt6VUc4?=
 =?utf-8?B?WjJHVXpFdmJFM3dSSzNrMWNJWGJSanFxUXlHWVpvenBmT29zSk9zU1JWcThz?=
 =?utf-8?B?VHpnczJBb2xYKytTdURRb0VuMzJCVGNyVHRoajg3Zjh5QVExaUcrT1pJYWxJ?=
 =?utf-8?B?Qm9NUHRaS25XTFQ0SVo3N0xsS0x6MFpON0hVVkljTmwvOTU1ekFSQUNRYWtJ?=
 =?utf-8?B?VjhUWWFTYUlIdzFIeEUxY3NnVHBvUS9jVXhmVmlIVExRWW1mbWdBU3VHbzNp?=
 =?utf-8?B?UGUrWHlQaDN6dDBqcVF0Ym05ZExjRWwvZGh1TzdEUTZaOFE3VU1Uc3VvNGhv?=
 =?utf-8?B?TFdLdUQxNkZULzlVUnFCYjlTQkhwZ25GdEZKdnRMT0F4NDEwZk5nbjRwOFpX?=
 =?utf-8?B?emhIVUt1MFl2RXBPakx2QWZCVHdYSnVGU2Q4d1pMK0srdGhLeVR2L1dEb0J2?=
 =?utf-8?B?VVBIdEtKdmhNN3UzNHNRVXJUelpXWDhtMlBDT093MXFWYzdUZVVJV0Z2ZWV1?=
 =?utf-8?B?SFhhSHd1WXFienc4YWpVOU5XZUZsRG9rSms5bFdRdXFKazRFNXBPOUgxT3Vn?=
 =?utf-8?B?OEVpekdJdmM1eWxDQ0Rac3ZqaWJoQTJMbG1zV1JQaUVqakZPSHAwbHhoMWdp?=
 =?utf-8?B?d0trdmNGZDFaRHhBdXZOUGZGM2pJRkd0d042YWt6LzN1VFhjRitjM0JPemlW?=
 =?utf-8?B?YmMyOUVVRUx2alZDVlJQTlAzOTdpWjQzNlpNVkNianJKc2pUZFVFcGZ5M0k0?=
 =?utf-8?B?aXJuQmJQQjA2MXpjaU82aFhYMk5iRUVnRFg0S0xsNThhcHJDMHNBM0RQVmR5?=
 =?utf-8?B?RFI5bzhKbE56QThNNzFpZy9YY3NvR0IxRGNkNEI3aGRPR0x0RlgzYVNNdVNN?=
 =?utf-8?B?aHg4aDJGcVlzZWFQOCtVN1JjSjUxUlNVU2xuYUVETVJBRjUzbjBGbDVDbnFs?=
 =?utf-8?B?OW5EMW11SjZFbGNGMmJuMmEzbTFsbngxSzNiYi82RDUvWXdjRFk4dDk2TFhs?=
 =?utf-8?B?QlgrMnNFU1RDbTd3RFpjcmVJdjMyWVBDUExvVHVDZzZCRHAzZnZTQnZSWDNZ?=
 =?utf-8?B?Kzd1STJ2TDdpUm0rQnFmdFVTUDUyR0NpTnB5MHZUWXQ4bEZyY0NGSDdvOVl6?=
 =?utf-8?B?ZHR0a0s3dlE3bXFxWmhDMzFBTGNDOG1LbWxWT2VHdHRnQk1wREU3S0Z6a2tP?=
 =?utf-8?B?eXJ6aHZ0dkFkRnRxdzE1VzQwRGlHN2lNemdOUVNSckltaUp2OGVNUXhhRm9P?=
 =?utf-8?B?T2t0NDlQUGF0ZEJTSzRSQ1hpYVRjUlYyWk94b1UyaVNnZlF6YUVXc3JkN3RJ?=
 =?utf-8?B?NjUzZHQ1cVlIa0g4WlBJeEJWRWhlempjMTVuZ3NWRnNhbVI1Z1RGeGFOa1Vn?=
 =?utf-8?B?Y1ROSW5jNHZPK3pFNTFFWm8rMExUekJZUXl3d3c2YlNDeHI1MWNhdHo2NlRa?=
 =?utf-8?Q?vyEjnoPsb353VH5uGdCMEV4Op?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc7a125-519b-44eb-38e1-08dd9fd81c4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 00:14:29.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rst5cLKLmZWsCLsAGM5QJyxTOnOmw2IPXTggyaiPWVAhSd3CACWxo1VDb0gx4X6GJM0FgxenBhdvw+1ODCunXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com

On 5/30/2025 4:07 PM, Xin Li (Intel) wrote:
> When FRED is enabled, if the Trap Flag (TF) is set without an external
> debugger attached, it can lead to an infinite loop in the SIGTRAP
> handler.  To avoid this, the software event flag in the augmented SS
> must be cleared, ensuring that no single-step trap remains pending when
> ERETU completes.
> 
> This test checks for that specific scenario—verifying whether the kernel
> correctly prevents an infinite SIGTRAP loop in this edge case.
> 

It isn't clear from the commit message whether the test is specific to
FRED or a generic one.

> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  tools/testing/selftests/x86/Makefile          |  2 +-
>  .../selftests/x86/test_sigtrap_handler.c      | 80 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/test_sigtrap_handler.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index f703fcfe9f7c..c486fd88ebb1 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
>  
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
> -			test_vsyscall mov_ss_trap \
> +			test_vsyscall mov_ss_trap test_sigtrap_handler \
>  			syscall_arg_fault fsgsbase_restore sigaltstack
>  TARGETS_C_BOTHBITS += nx_stack
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
> diff --git a/tools/testing/selftests/x86/test_sigtrap_handler.c b/tools/testing/selftests/x86/test_sigtrap_handler.c
> new file mode 100644
> index 000000000000..9c5c2cf0cf88
> --- /dev/null
> +++ b/tools/testing/selftests/x86/test_sigtrap_handler.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Curious about your use of GPL-2.0-or-later?

All the files in this directory use GPL-2.0-only or GPL-2.0.

> +/*
> + *  Copyright (C) 2025 Intel Corporation
> + */
> +#define _GNU_SOURCE
> +
> +#include <err.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ucontext.h>
> +
> +#ifdef __x86_64__
> +# define REG_IP REG_RIP
> +#else
> +# define REG_IP REG_EIP
> +#endif
> +
> +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), int flags)
> +{
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = handler;
> +	sa.sa_flags = SA_SIGINFO | flags;
> +	sigemptyset(&sa.sa_mask);
> +
> +	if (sigaction(sig, &sa, 0))
> +		err(1, "sigaction");
> +
> +	return;
> +}
> +
> +static unsigned int loop_count_on_same_ip;
> +
> +static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
> +{
> +	ucontext_t *ctx = (ucontext_t *)ctx_void;
> +	static unsigned long last_trap_ip;
> +
> +	if (last_trap_ip == ctx->uc_mcontext.gregs[REG_IP]) {
> +		printf("trapped on %016lx\n", last_trap_ip);
> +
> +		if (++loop_count_on_same_ip > 10) {
> +			printf("trap loop detected, test failed\n");
> +			exit(2);
> +		}

Most of the x86 selftests use the ksft_exit_fail_msg(), ksft_print_msg()
or [RUN, FAIL, OK] style for error messages and other informational prints.


> +
> +		return;
> +	}
> +
> +	loop_count_on_same_ip = 0;
> +	last_trap_ip = ctx->uc_mcontext.gregs[REG_IP];
> +	printf("trapped on %016lx\n", last_trap_ip);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	sethandler(SIGTRAP, sigtrap, 0);
> +

I would suggest a comment here to explain what the following assembly
code is supposed to do. It isn't obvious from a cursory look.

> +	asm volatile(
> +#ifdef __x86_64__
> +		/* Avoid clobbering the redzone */
> +		"sub $128, %rsp\n\t"
> +#endif
> +		"push $0x302\n\t"
> +		"popf\n\t"
> +		"nop\n\t"
> +		"nop\n\t"
> +		"push $0x202\n\t"
> +		"popf\n\t"
> +#ifdef __x86_64__
> +		"add $128, %rsp\n\t"
> +#endif
> +	);
> +
> +	printf("test passed\n");
> +	return 0;
> +}
> 
> base-commit: 485d11d84a2452ac16466cc7ae041c93d38929bc


