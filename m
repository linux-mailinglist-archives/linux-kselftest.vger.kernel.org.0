Return-Path: <linux-kselftest+bounces-22797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC69E2FDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5332166EA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F01FE444;
	Tue,  3 Dec 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTPaMPoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD61EF0B6;
	Tue,  3 Dec 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268669; cv=fail; b=s6Qv2aHoV9TF53EB5ENgUPF9U02NNrf5XZQ32GHA8H/OOowwi5220GHyR7SOf4ZkY3nZvJBpX2ijgm/qvDb+fkqLi1aaBbaWOUPJgCWr8NLMIIen+xKMDi8CrIRnOTxyX2HA++Dhxdn+VCQGC3XEEZC0HlC1FiiYsocGFxkpf/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268669; c=relaxed/simple;
	bh=B6TLlBghC4ZK/4zB8l7+twCV0NQDXfzMmmGcpF7QTJ0=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ar3epouOsEVgyLntIONrvso0tA+qfzeF6q3+ZhT7K2vggklDIEBU5sVre0ycHJ3A6gvfUQD9tmuPZ3C6u0kCydVcELAsTMfuwR9M7Vh6tyypJLzZZ4agFHVMjT3Nh+Er+7jGg1UDOPanfKbtWrGmTotZuHAuzlHuJSTz/hLtF24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTPaMPoI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733268668; x=1764804668;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B6TLlBghC4ZK/4zB8l7+twCV0NQDXfzMmmGcpF7QTJ0=;
  b=HTPaMPoIM5ZcCHw66nsvwBKe0DyLCrgTPyIhG6jBD69eApEWCfeAdsph
   +3AutShr1BZuJgIdq2trE9jbKkB1/gphguzXpzTUQQ0ijooP328QW/gG8
   0lzs6kOLMZQ3rT3OAEX8kyx+DSyxZvzarZ+5JuIRujtKsCmHkYRjQYfW4
   LhxQdiMUioAivwoQR4d+Fa1SxyHOAOncLFggI52bRQrulk3e9HLOUSQbb
   yer5DUHdhbCsyC6HNkS5a909SzOPRxzoWrIlZu5PrUW7ABJ4ECdPzW+Dl
   HRZjTYENgQ8AMksYywcr4wikXaGPjjoACFa1OIf+dXT3G9xRrIhi7zi3H
   g==;
X-CSE-ConnectionGUID: xEjUDKK2RAi+14sVzAKMag==
X-CSE-MsgGUID: gf4d18mKQ9ibIdHPf7RZGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44174065"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44174065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:31:06 -0800
X-CSE-ConnectionGUID: ZGeOpEgCSJWGU7wC/GQuCQ==
X-CSE-MsgGUID: WPfdsLyYT5eRb88LxTy3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93446388"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 15:31:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 15:31:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 15:31:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 15:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL7LEh3/Rb17d3MwxadbVABOOA+gDOpFxTyAwdvy5NM0VxYdVvcO+LE1jvpfl2RCqqdKNgLOo6xcY9B4MnhVVb5X7i2nU1kh6fual5K7IbYw5HSsRW20fkAAjUukwT0LzzBCmn6nLqqVSh//0yWWuG59CyW3yCYQ/iKD9UIfVeNCnQitJhPtPX2Xp9wDyfGN6DZu6S7QNEZrLv5sbMFmn5ZDZKK9CfzFlGdJ2pVAYzMr5rqoFlIQKvdU0hIEThYf5LDw5N2v9VMVEyZ6Zayt6lEcMGdsDOTtb2yudOZ5xDSa4XqsW6z+ej8296T90cDddmXAIUkcZY6yAai1FkAzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b5NClFpwz/D3Y++hZT9h1ARV7pTzzw2C3PqR0Uu8bQ=;
 b=qupbUEVKuHu/KvuVY/+IySQWfWb0D4tNONrHhjkFRJ1xJWmXkd4MMnadU1VTRUVxUPIErGZnRMB6HI/bqUmP0z16DtW8a2tHYF4n7D0jj0DYq74ouQcV8vatvk9miIH2HR8fQ2fK8Ki0NrpAuddKZk6Rdd6pPDVhQPXF9O2EnmrgPFp7BlOIPFcxWNsWBBzt+ulqZTQ5ntwS9mSNteRXsFKM2p6/9BQ5JJXbhzOOLvMNUBtZJyIM1b+2OqVnZLcqS9gPxL1MidSLxMKV5SiG8bjQv8QchYLs7jCgLS+3fEbpZ2tpbxwvYeP2OWy7FJSj5JTCf4Mj7M4G90C4a2Myow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 3 Dec
 2024 23:30:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:30:58 +0000
Message-ID: <d89e6cbc-c0fa-40de-99f0-34a3095ee296@intel.com>
Date: Tue, 3 Dec 2024 15:30:56 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v6 2/2] selftests/resctrl: Discover SNC kernel support and
 adjust messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
 <6b0fee7f5d97f8140442a73ecdd50429cd697938.1733136454.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
In-Reply-To: <6b0fee7f5d97f8140442a73ecdd50429cd697938.1733136454.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2db130-ef1c-497d-ff70-08dd13f28a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWtWYXdmUWQ1NTFLYkdLYlR1bnFZMkRJRkRkMStGZ09OZWZ3TG11dTVEODBa?=
 =?utf-8?B?ZmVibTJaL2R6akh4aS90VGlKZHUzMVlzaSsxN1NNdlFWYmdadTJlTjA0UDda?=
 =?utf-8?B?WnR0dWNzVEptb0NzQ0k4SlU3d1hOUU1lbWlnR1g3QjRvMndDeEFWTzQ5eXU2?=
 =?utf-8?B?TUFsWHd5Y3B1K3A1TGpKczVBSHNqNXZBUnhIQnFFT0xYbDdDOGo4cnAyLy8v?=
 =?utf-8?B?d3lzYUthbDI4STc3NTF1b1JmNVNWSnIzcVVEODFDY2ZTYzlvZlUrZlFZZGdD?=
 =?utf-8?B?a0RMVlhMekFrZkxGVWI1SExVaHNpRGd1UW1zNDdrKzl3L2xOYU96bmlnU01J?=
 =?utf-8?B?b05JTFJJT0VuZVlFa1piNEMwbW94SXc0SmRYcVZkZTBkWVlOTHhDQ0JnbExm?=
 =?utf-8?B?NjF5WTYwMHBSNU9hZVpWSGxpeS84b2MzMWpOTVVES0F5NVFFUFVtR3UvSUNP?=
 =?utf-8?B?TGxncXNybmo3UEVSUHMySGJ2NUx6UUxHTng5K2xINU42YUl3OEN5S1V6emwy?=
 =?utf-8?B?NjBNekd2eWVJaWtHVWZLREw5K1ZtM29RblhqcjBZbkNJS3dGSDhnVndDVVU5?=
 =?utf-8?B?YitjbC8wcVY3T2lHODBWeFpabjNqWWtZZGpRNTg5T3MycDA1T1hwN3U4UnRo?=
 =?utf-8?B?ZG56NTl0YlNWMm1FeHVPNEU4NzZyd1pNQUU5emM4TWNzYVRxMkYrS0VpSVE3?=
 =?utf-8?B?MWhMWXEvaFQyVXJRS1BQMHdkbmtaYU1iZ1VNcWQvTlJYeGFrWXQ0VDFOR01q?=
 =?utf-8?B?bERzYTNTN00zaitPRWt3dmgyMCt1SFI1UkZONys1YnhDSnJoNStoZ21QMFJw?=
 =?utf-8?B?REV2UmwwKzlmRzd0bGR3c3dQNExrMG11U1Eya3VJQkQ3dVZHY1l1OHMvNFZi?=
 =?utf-8?B?RlAvQ1ZwSGxGZUFOWG5YeEt5Y2tFeHFheGZYZnliSVFSdmE4eStWS3lQMEw3?=
 =?utf-8?B?QkFzbC9rMlhBaG9GQmt1R2xsSXBmOHhVS3l5R29ET25BNzVOb1NZZHQ1VUhK?=
 =?utf-8?B?Q0tTcDdyZGpmOFcySHVadGYyQ1M1aFBkNkt2SFFVY2YwNW1lYm41dUJjNXhn?=
 =?utf-8?B?NWlSS0ZNbHp0T1lsbENKODF4aWVnbC9uR005NklmamFIaUI0SmdNWCtjaUNw?=
 =?utf-8?B?ajkySWVGalVXemVFRSsxeDl4bXJyajNKYTUrTERtVkZJdnBhWE5PRlVlUmFU?=
 =?utf-8?B?dVg2cDBnY3V4ZmdwZTZETFBWUGJjMWZnNW4raVM4WUZvZHRkQzRPTDV1R25t?=
 =?utf-8?B?Sm9mRm9QZTB1ejlaT2oyeEkxU3pEajBKMGE1eVlGTWNXeEc5bVQ3WVNlbVI1?=
 =?utf-8?B?dVF1MXZvd2QydDZUYUxYSG1xZC8wTUM2U1Z6NmVWRDcwRWlMT1Z5d2ZsU2Yr?=
 =?utf-8?B?SGw0YnhlRUJYdFVQT1lzUDhaSTNGWkk3WEhxL2tpT21oUmFVZVZwQk1lR2Qy?=
 =?utf-8?B?cHRHaktZdk1DbWVjL1dTUWh5SXUxTTJrYWNCOHFwNHJ6bUdUeEY4bUJ5S1gy?=
 =?utf-8?B?SkRKSGNMQVNocW5ZaEIyaGg2Tis0UE5CQVIvcUlIaHpHZXJySDdENEMzbU5x?=
 =?utf-8?B?SEo0TFdmVWU5L1BpMmlRZU9pY1VVemxqQ3h3Q21NNzhMaDA2Nkc0MnB3REFz?=
 =?utf-8?B?TXU3dUxYSTFTNFpHZWRvcEZwZFJ5TzNtdm5aYXN2R1JoSjV4Rm4xN3QvZmow?=
 =?utf-8?B?T0RxQmFGZy9yVVFXdnkya1lSMTZ1eXlZcG5JR2V1V2tYQ3UyZEovZU93OGgx?=
 =?utf-8?B?S0VSOHR4a21vK0xyZ2ZlWTRRWHh2cHhLVUNHeWhCL3I3TUZOR21KcEYrcVlN?=
 =?utf-8?B?ZThhK0poODNLN1RJNVRGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xWR1dhWC9BMUlBN0lRM1F6VnE0a2tKOS9wcjRQSHl5Wm9Jc3diRGR2cTJw?=
 =?utf-8?B?b2JSb3g4ZkN1anZ3STBRbENaL0I0Z29RL20vRm14RlpsWng0c1F4REt6N0Mw?=
 =?utf-8?B?ZXFhNEZMQjltSzJwYjRzaGdTazV0aG95Nmg4NGs1allkdkRjYXVvY2E0b09L?=
 =?utf-8?B?SkpZeHFYQjlyaGxnTFl6R1dVYi8yZXRZcXV0MEc3Y1RLUndualRPUVR3dnRD?=
 =?utf-8?B?TVl6bTdMbU9IUlVsV01MVEN1VG5Id3hIbm5UNElPMkY4R3ZDOWlwYW5Ya1BJ?=
 =?utf-8?B?TCtVcW53Q1p2UStTSFc4L2FrLzdSeFRjV1lZanlOTDR6ZExMbURhLzVSc3VY?=
 =?utf-8?B?OEhMQ1IycWZjM094RkRrRkl0S09aOC9mMmw2TGN0RThodDdtK2xDaGRqZ3lW?=
 =?utf-8?B?Uk1nM2pQRXpVemFXYkJBdGkrYkNKRFZHQjBPZ0V0a3IzU2NzTG1xdkVCZTl1?=
 =?utf-8?B?bFpVTTM3YUc5Qmc1WFZobW9aTUpyckpPNVhLakFRejRwc1JOSFJjSGtYSU5s?=
 =?utf-8?B?U2JCVDEwR0h6anliWXpRWTgxMW5tVDdGQnJDK0VkdDlkZksybG8zaElJbVJ6?=
 =?utf-8?B?ejRyZEJNSmJianBNNVVDdFFOQTdnb2NmbVpzRVFDNHFFMWxybGdZMGdpUWNG?=
 =?utf-8?B?cGNBVkh2cnZNOWMySUlSRU5udUhtajY2MDgwOXBpQmQ4Unlpa00vdy9hK3ZF?=
 =?utf-8?B?UkVHcXZJbWZ5Rit0VWxiQ3ZkSmxVY2FBWk1pTFhTUm1GeFlqK2VDQU1ndTVC?=
 =?utf-8?B?SnB3WGlLbzFYclNvb2NBMDRiZ3lwNGQ2cGJuQlIyS2lFd3IxbmhaMDRLSXlz?=
 =?utf-8?B?WW1KMGsrTjdkZFlyNWtiRGNYR2syQzh4cmMvck9RNisyZ1RzN2RLWmw5a3Ex?=
 =?utf-8?B?Sk8weSswUlB3dU9JV0V5d0tyMCt0bDJ0eFBMVG0yN29Ic201UW5RTWdjMGZr?=
 =?utf-8?B?Z3pnUTJkVS81TjNmYlNDV2lYK0hkRWZzS20vVmNUUHl1aTVWdnhOTzhOYkxR?=
 =?utf-8?B?a0pkNjhiM0RzMWlucmUvZ0JTMUcybnRVSmdFSE5odElBd2hjdWRWQnkrblhO?=
 =?utf-8?B?V1JuY0hMY1VHa1F6ZUlwWVFJOExiYnpPZ1JuZVhoL2xJc0MyL2czc0xiNDRW?=
 =?utf-8?B?dmtGUWdISVVnczZ6UG5wTkIrSzBZR2xUMkFLTVE1ZUlrVFdCK2EycTgwOFlX?=
 =?utf-8?B?VnBTSGRaMndsa1NQVWs1aFdUTHNNclZ4UzFKWDVLaFUzSW1JZTJGbmFEcUx1?=
 =?utf-8?B?WjlNMkxQUVpkVFhlUk9RQ25ZWDAxNW5pbmw0Z3RFd2kzeVRWMm02b1VvTis3?=
 =?utf-8?B?ZzFHL1E2UlEyampXdzVuN3FXOHhMbXM3clNTU2R3eVkzK0JIZUhxSmdIYWEy?=
 =?utf-8?B?WjNSUWFlS0h3UHh4Q0RBeE5XTjlEYnBscG0xV09wR0hxWExJTlhwOGp5eDNv?=
 =?utf-8?B?R2ZYTmd2dUNLNEd5UEN4ZXI1eENIMnFWOEFrcEZUTzNMaCtQRE1BZ1FTZWpB?=
 =?utf-8?B?QWZIakc4NVRYWGJpTng5TFlPQ3pRWHRnbTFpaGNBdTFSWUo1VGlUVGRHMlY0?=
 =?utf-8?B?by9zMVluQWs5VmJCL3hML2dSYzVTQ3pLVW9LdVNJMGdKdmx6NE5iT3F6VEU4?=
 =?utf-8?B?cGlyTHVPUTBid2xpQUlESVpaVTFUOVJBenl1MS9PRmdJOXBnczVqT2RSbjh3?=
 =?utf-8?B?cWRSQ1BzUUJ3TG9yZUFGaVRkejN0RVRYVHBUVWlLL29JTHFEcWYyRU9YeFNV?=
 =?utf-8?B?VEZqaE9ZMHdPY2xrMENNZkdKek1sT0NXejU3bis0QU1WbjFDVUFDc00rci9s?=
 =?utf-8?B?bHFvYjhZV0ZYSTRhTEJpTlVIQ0VsYzB2cUNiSzlyZmtndEFuVXRHR0U2RmR4?=
 =?utf-8?B?ZEk2SnRtUi9ZazRBaCs2UkhaWFQ3QmdFKzBFTU5zWU9OMUtaRzc3TElWNkMz?=
 =?utf-8?B?aFkvSzVrZy9KOG5UL0ZBQ00vQ25lQ3I3aTJuN2lkY1ZwY0V1MUsyaGs2dHF5?=
 =?utf-8?B?dzZtcUJTRkxoWVh6U05xTkRXWGVBdXYwMkVzcGpqaUFmNmZVT0krS1NvZ1hz?=
 =?utf-8?B?bUNnMDlZQ0MvYXNRMjBITWs0WGtJdjJsUmtPVEpzZnhFRVRlNm9sa0FsWjgw?=
 =?utf-8?B?WjBtWlhyOWxHdGpaUHlabkhQUXN6TlZEUmo0SjE3T2Y5a3pTSk1MYUNyNGEy?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2db130-ef1c-497d-ff70-08dd13f28a8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:30:58.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxLNbTDyEL5d+t5bJ6Zn19SeNqnVWfXOIcGvJk8IpY7PLrPljyuBnSQgX/NLyNxPX6gZ4X4bvlrBjqwsUGwPR7NaHHRZF2DNmcUiPMGsX8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/2/24 3:08 AM, Maciej Wieczor-Retman wrote:

> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 50561993d37c..d0a5c0f78397 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -949,3 +949,35 @@ unsigned int count_bits(unsigned long n)
>  
>  	return count;
>  }
> +
> +/**
> + * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
> + * SNC resctrl support on the kernel side.
> + *
> + * Return: 0 if not supported, 1 if SNC is disabled or SNC discovery is
> + * unreliable or SNC is both enabled and supported.
> + */
> +int snc_kernel_support(void)
> +{
> +	char node_path[PATH_MAX];
> +	struct stat statbuf;
> +	int ret;
> +
> +	ret = snc_nodes_per_l3_cache();
> +	/*
> +	 * If SNC is disabled then its kernel support isn't important. If SNC
> +	 * got disabled because the discovery process was unreliable the
> +	 * snc_unreliable variable was set. It can be used to verify the SNC
> +	 * discovery reliability elsewhere in the selftest.
> +	 */
> +	if (ret == 1)
> +		return ret;
> +
> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
> +		 "mon_L3_00/mon_sub_L3_00");

The patch looks good. I am curious why the string constants are split in two and not,
for example, a single constant of "mon_data/mon_L3_00/mon_sub_L3_00"?

> +
> +	if (!stat(node_path, &statbuf))
> +		return 1;
> +
> +	return 0;
> +}

Reinette

