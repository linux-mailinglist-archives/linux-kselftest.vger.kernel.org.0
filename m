Return-Path: <linux-kselftest+bounces-44483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB16C23338
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF6A1A285B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08727E077;
	Fri, 31 Oct 2025 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxrjxGlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5227A12C;
	Fri, 31 Oct 2025 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882194; cv=fail; b=DpttOag89ZE+7kAZRfq0KZBje1kT83A6yu/fIE35IK8oV5PAuyiyHcU74AomezgWAEq7dxR6YUwCLTYeZ/MPc4H2oLSApPiqtTajXH5s86F+W3O4b5QJqtGSxdwa3V3VeHXZnOUiyDUWTJzDA8LLqzOenWHDaQQoGCmkodeeEmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882194; c=relaxed/simple;
	bh=S3cKOSkkq8nhz63J1td3UqlvcT288d/kXtJEYdMWFzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGs59wfnaubYQ20dNCOuQykAj4KMsHmKi56dplpVg0K0JfsqW7SS6L82hRrhm49zecSckoExzWKrUEp30i+bDpl3ExgZj4vgXKKeRSfiX1KLqXX+XaL6R4xS0c0qYHh+m21CZDwyB5TLf8lIvCEXBEV4vXe09q3Tt44qkjdyuWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxrjxGlC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882193; x=1793418193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S3cKOSkkq8nhz63J1td3UqlvcT288d/kXtJEYdMWFzY=;
  b=VxrjxGlCPM6hoQb/Hm7DF3MlZE2UcuYiBtdHJUazvXPMQsjpF5bszm0Z
   sJ18ZMOsYu+/QTrfijsPszerH2VsIjrQPuuWfFaZ4WFXwiblwEsPWf4I+
   +XkwTlImHM572/I+ibfyOcfFa2hNK51VotYMoDBcznoDCujntOD4kKm0X
   NYh0z5Hsw0vRzU3YXz7eS4ddbRDJm20KF2QANl9dhtwOPvqcxXjMyAyyR
   fZv84BLM/8yrCyeLs0beNGBDMZ+J3PdFxIuLma3ZrDCMBPpk+qShGRxWq
   3jD4pDBgSsHtUe9GoGrQOZLgcougs6WuQrunL0ohnKNt9QOGrNKsjQmS2
   Q==;
X-CSE-ConnectionGUID: 29YasO3VRLmJkSEBfQsNKA==
X-CSE-MsgGUID: pcwwOiEqTo2IvkBCM0Y83Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64069047"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64069047"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:43:10 -0700
X-CSE-ConnectionGUID: 2Fo8aVMqRViYLcnJ6FBhHA==
X-CSE-MsgGUID: BAGFH/8YRjq+Dog/VIxvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186230086"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:43:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:43:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:43:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdX0/U4jDv/VnB7TqoS2CTrp3KSPBFCsaDWfhQ5a7e7w3qX+VdHYXVzPAlwvANYNHnaRFcRWuRWH1C1/vQ+vo8s45iD8D51/gE8qJO3lebHqw8HnPZqSl0UXwDdTcv+X7ABXgB/hvpiTjcqyJU8eG3iC4u4ou+pxZHCvmhex7ZT655L1ZCa+5DRiXCI4EopFxd7H0WDzlAvzs7pRC+GW1nNxGpJzJZcar+BiAgQMDlEgzK7ZC5lAmvxUTzzMe2w5x+Qe4z4g2N+bn0YQbe5KsuH2i4xxI9+mXAH4jdPJj6/0pwKYZQF8V8TGP6xo2lsBlbMyKfgLN9Xc+JjRYJRI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHE6WJK9bQG6fF6XEC4qS2ObSnHkMe2LBg09wmSdVQQ=;
 b=OjxtS1ovhv5cFPYmiDxEX43cbzKdIe7FJoapqMizSv0kW94K1LyL38LpUuldHR0mEITI+FSFSXGfUmkXF0wI5SZq30H+FFIOyf97WwGdiHWU8hgaPsLv2I/stq0ATxyfYcwAl802rO3LdEAEuoVXyVYDAFxzCsrRC9j/J0mzVFbcK4s+lSwfQEE7/mfYoWw6rREoDYZhxrahmVlSvR22i6TiVW3xNJOyRp6l5/8A0Op+ZJT3T1mVMgfNKzLxRvAUDkLaBw1eLAh0mcGMQRAHoMjmgFFoyteeZE6oQHLOMgvE/9Y0nAcQ8bSIWug5bTmrkXsrJpIyD6V9sPytKtZ9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:43:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:43:06 +0000
Message-ID: <681ae106-85ee-4f6a-b0c5-37555f53df87@intel.com>
Date: Thu, 30 Oct 2025 20:43:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/23] KVM: selftests: Expose functions to get default
 sregs values
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-4-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-4-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:303:87::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9a00ce-9420-4431-f35b-08de182f9a58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmVWRVNHTHZKVGxibHJqMThVeUkzV25YQjhJMUd5YmZ0d3lpVnludlZpZEYx?=
 =?utf-8?B?U00rTFQ5VUxuNUVYa01NbTA1RGIrd2dCMUVzSkhwVzU5SHhRT3VORHFhUTNQ?=
 =?utf-8?B?YUc4ZjRWa3ExMTl4L042amVYUGQ1RWRna20rWjROYnFqV1FZbDQ5bGwzeTV2?=
 =?utf-8?B?RXNBVm91TzZvTXkrUFpoZDA5VnJFN05qNDhFZUI1Tk5GY241ekhvbjlxdVlS?=
 =?utf-8?B?Mkl6Rksyd0UzS1h5OEJnMVMzRTAwVzZqc3BCRm90UlMzWC9neGtFUG1pY0E3?=
 =?utf-8?B?WEJ5WEJkODUxdUoyVDVoUGtFRjNFMTRFQVVxalRZQm10SG02b0ZEL2MwbUgx?=
 =?utf-8?B?ZWE2dlZrSFNCNzlHVmR0ZkFuYUNwalRSSk8xZ25PbGxBU3QwYUtZd3B3bm9O?=
 =?utf-8?B?TXlpM2RHR01nUmhRT1NqazVrRlNMY0NwOUxZZ0x5ZnVyTHJNWVlDT083TUFE?=
 =?utf-8?B?aEJjQjZvb0JXTDEyckFGY1hIUmcxQXBjbXJDSFBsTmRuQlUzVHc5MStiWUVt?=
 =?utf-8?B?bC9oVElLT0pYQlA1VTZna3ZEaTV0L1UvODVoRTIwQTVtazN1RnpZOFVLb1BY?=
 =?utf-8?B?UlNKa2NGUExoV05wUTBWUm5sZmFxQ1lSdHZDKy9QVkVXMEcwZTU5cWhBQUxB?=
 =?utf-8?B?SUlObWg1ZElmeUlJS1FUeXRzYkU3cFBMU1VnNzM1K21wUFpkN0RaYlJ5MDhq?=
 =?utf-8?B?a3NTZG02cWsyY2tMaE82VmlCeDUvMlpKd1lVbXBHZ09aL1U2UU5xUThuWVBj?=
 =?utf-8?B?eGZVZ2JwQmtZTnFwRnBLclI4c0phbWdDRzZNZ000Rlp3OFd1YVdJeGRadnUy?=
 =?utf-8?B?QWo1MUd6N08rVU1LblplT2J5L0VGYy9VeGtoMUE5eEdNMmNRNEZvV25nYXFX?=
 =?utf-8?B?MFhtbFMrQ3oyN3Q2WUJNKysyRU51LzNCZnNNcjJHUmd2dDFYNmNRSU5rcWhj?=
 =?utf-8?B?RFBCNnQ0emNKaW92MnYxZW5oTTZvZ2pzZGt6T3pVTXp4MVRidE8wQkJJaEYx?=
 =?utf-8?B?M0hVaUFRWTJJbGJ2TjhIV2Z1QXFRUERRUzEreVBSVHF1SU9VYnN2WFZjeGtH?=
 =?utf-8?B?ZWlMNERIaWNSRGxrdWVTTlVid2kyL2xSdS9wWFVjelRKek5WK0VVRld4UmhS?=
 =?utf-8?B?a2dNVVVwLzQzbVBNT2VoWGp3YlNDUWtWZUNWS043aVEya1BWM3NIeER0Z0Vk?=
 =?utf-8?B?MEl3NndwU0h6RTEvTHcrZ1NQc3lLeGRwUnFhUm9jcmhqeEVsWm5IbTFPbFBu?=
 =?utf-8?B?OUlHdWJnenBNOE8ySERvR2U0TEd4ZWZRUDlnYzJiU1lCN3RKZHI2c2hjS3lO?=
 =?utf-8?B?UXJMNmtjeDRhZVhYYTB6YXBmS2NiM0svU0JyVTN0QnU4K0hwM1ZIZ3RoQ3Y1?=
 =?utf-8?B?cW9qVlJlZStaVHhJNmRQcjdWQzJzeFhMaHYwMnJpZmNocDlmRXJZMUxrdS94?=
 =?utf-8?B?bWxyWXR1YjFzY0VvSG1Fc2xhMXlJamFoL2I2Uzd5SlVZMi85Qk51Y0szUkx0?=
 =?utf-8?B?MUxCYnpQbmZGaUxOSHJvbm82ekpRbEk4aFI3bWdPaUJDZWZSc2JMNFhLRCt4?=
 =?utf-8?B?NGluWHdtR2ZvSG5vVXAxOE83SFlCRkVIMThXa1BtL2tWSVVtRVRkOWhjSW5r?=
 =?utf-8?B?K1NmK3ZuMjBSd0JLUnIySmJ5K1I0dTNWSW52Zlp4c1JzcVBuYSt3VytQZUtl?=
 =?utf-8?B?ZWg3RzBKR0JyVi9XMnVVSUhIRW0vamo3cVYyS2JFVnlqaWdpbUR2OEhkQ3pZ?=
 =?utf-8?B?YU00dzhpK2tRQVZEOFZ4M2RqWDVraGcydG9oeFc2VzRFeDlZa2s5N0FpbGdr?=
 =?utf-8?B?UzU1V1N1UGMvNzJTTU5PNnV6RnZJQzkyaDFLeVkyWmNkTGxQc0VwdVRiWnFU?=
 =?utf-8?B?dlI3eWMzMG4xWFVIc05Lb0pRVEgxd2hPRXdaMXNld2tETFdpK2VqaGRVMXBS?=
 =?utf-8?B?cFczNGptNXhIVjdvR1FYWTRReERrSWtpUEo3QXhDQVZvOGZyd2pydE1Hemw1?=
 =?utf-8?Q?fb/88gwVWPV+ikZ5BIs2cHHjYhvv/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FaMU11MzVPdmhoOWZqcEplbHBvbk5MekNlMC9Hb0VJd1pvVEJzYitzc0l5?=
 =?utf-8?B?N1c3NXA1VzFMbndRTTQ4UjEwdHZCN081VngwQUNxYjJMbWZoeXVhbUx3QWdY?=
 =?utf-8?B?c21MRFFTRURWTDNvWnQ4OU5OZ2ZZMVBSa3pOdnJyZnBKVUtnRS9XOU1uMkVZ?=
 =?utf-8?B?VnRrY0RxcmZvL2I4azZwQ2lCdXZMNWd2a1dYcEZycnd1eTZRUWxkWXhPOE1S?=
 =?utf-8?B?MzIxc1RPY0V5cFdxTEF3RCtjV2F6VlR2SjA2NFI5bG1pYmxTVXFUY0lGQ1ZG?=
 =?utf-8?B?S0xRdERoblNWV0tRekoxczJBVjByYXZyaUNkZmNvb2FwZUpuSkViQVQyM2xn?=
 =?utf-8?B?QVJkRDB4OHR5MHFUVmVQNFhsNFVZV3VyU1IxQ0dhVzhncTBqYmJmL3pvWFVU?=
 =?utf-8?B?dlJ2THFuQXA2U3Z2eS9SQ25CWlI3WEE5VUFwNVVUY0Z0bmpja1hRbDlDSTkw?=
 =?utf-8?B?SHV6eWp3ZFd2dVhMSVJUYlBVcHZmYzNtSUZDZWJXcHZkN3k2U3plVWVHaWY5?=
 =?utf-8?B?Y2l5QXdTRE45aXdsQzlkdVdab1JWRklWbjRLNkhHZTZnRU01T2pabitnS05i?=
 =?utf-8?B?VjAyVXNtTzUvdWJPRHg2SndweitKZnpZZnBhMzlaWjd2WTFxS1NMcFhlUmo2?=
 =?utf-8?B?MWlnN3hpTzhYVks3NERQcENJd2M5bFJ5cXhhWEtWdDlpcEFPT2p3MmR5STJQ?=
 =?utf-8?B?WE1CZVVXOVR3dmVGcW5CZGUxRk1zejV5TS9lNmxXQ21RWFFrZ2xaYVdFY2k5?=
 =?utf-8?B?MlIxWnQ0dEdIbFQzWFNnWHY5MnVWREYzOGJRZGdiYUliMzg4S2QzZEdqb1dk?=
 =?utf-8?B?OGRRSG1CSHd0dXVGZ2lINGxvQ3VuMGIrZ2NYeUdtejVhUDZ0M0ZMNWV1Y2x4?=
 =?utf-8?B?SmtDbXEwWVdZbGtmNktYc1YwL3FQMHcvYVFyUWNoejVreXYvOEJOOUlwNE5y?=
 =?utf-8?B?d294TU5qOHJsTzJsWmRmY05KY1hhWE9GSVBRSHpsbzJlczRZYzllZEpVVmts?=
 =?utf-8?B?UGQxUHNld2hRWWdyMTUrclhmZFcyVWt2N2FUY0QrSkxvWDZzM1NOcjlUazBL?=
 =?utf-8?B?STdwNWhCekUwTytSK2s0N3drcmNpMzdRTTZwTk5vSHRHeG5oakx4NjdnWTJo?=
 =?utf-8?B?eFZleWpHOXVoVEhSdjdmV3JIWEhYUUZaMDdQNjBzYXdkUUF3Qnc2YVIweWp5?=
 =?utf-8?B?SGJCY3cvV1puY2ZKc2EydURuQ29PemxjTk14bS9NNFhmWVhCZURONFVMV3dQ?=
 =?utf-8?B?bGJTT3ZEVHpScnpNWWZoaVdndnZQRWJ5QWRtb0E0eGpPSDNiTVE3ZTFKRUZ5?=
 =?utf-8?B?MXBxdUFtZUJzbVY1RjBsK3RMVmIvR2pmcUhicWtURmQ1dlNUZktNT0FRZzZB?=
 =?utf-8?B?ZC9DQWo4RlRSeVlUR3RmK0ozSk90NTRlV3QrVjdJdDlxWHZ5UGlWdk94TzZT?=
 =?utf-8?B?SGYyREtRNGg5TEJDVklBb3JxcEhBT0VYY01xeTlWZHFnblRNNU5uK200K1o1?=
 =?utf-8?B?NXJVYkpZdXd2aHlrNUVNSSsvSUJRbkpEbUVEeXdVVE80U0pMQWhXV1liNmJG?=
 =?utf-8?B?S0pOTGZPNHpHOHhycm5NQ0Z3OUEwenRLRUQ2NUpkV3d4OFNHaFh2UzZvRkZv?=
 =?utf-8?B?R2tNdEZuc1lDakQyd3VBVXdVUzd5N0NiTTVTNUkwbmRWREhVSTExMHpPUkhE?=
 =?utf-8?B?TThJYUV4RStKY3FlYkU4QXpyVFVQblA0cXArN1YwRTh6TWhLZms1UlVPbkEv?=
 =?utf-8?B?ZEhXVDcwZE5FbElRcWRia2xmZ3d2alE0emx1VldQRFFhNElBRzN2ckxuS2FB?=
 =?utf-8?B?SEVMalZOTCsvVS9MRGFhTk0yRlhkQjJ2SzkvZk83SWliNndEQXZ2UkxxTWRq?=
 =?utf-8?B?TVFwQW10aW9BTzJqNmx2RGFOc2VMQjRKZ04wdDg1alA3RHRzZXp3cEVQNytP?=
 =?utf-8?B?cU5mWmZ4d0U5Wkl5Qi84SFJkOUl4U0hVMmcyeEpuZlZuZXFDVFJoVVdWRGJj?=
 =?utf-8?B?bUh1UHFLbjh6Z3FlMmkvOVRWS2l2Qkx1YjJlZUVSS3k0NitxRzJnUkZuLzh5?=
 =?utf-8?B?Y0g2MDh1RzdKUG9UWG9DZ2l6OGVMYmpqNlQ4S2dkOGVJQ1hjRktELzRwQVpu?=
 =?utf-8?B?OVBGK1lKTVg5L0dOZ2dvLzc3dzYwWG1QVjZZaEo2ZmJtbjZwS1RxQ2s0MERN?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9a00ce-9420-4431-f35b-08de182f9a58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:43:06.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/xC4RB3ypZ6Jvx3aTaQl0FSMOOnbWM3tGD1JISMM2xNS8fqOj/QmK7XvN039k97Z3PoatlVCUzxbjTid1s5fDIII0seswIYZRpr0S/3GwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/processor.h     | 33 +++++++++++++++++++
>  .../testing/selftests/kvm/lib/x86/processor.c | 12 +++----
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index dd21e11e1908..9caeb3de7df6 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -27,6 +27,10 @@ extern uint64_t guest_tsc_khz;
>  #define MAX_NR_CPUID_ENTRIES 100
>  #endif
>  
> +#ifndef NUM_INTERRUPTS
> +#define NUM_INTERRUPTS 256
> +#endif
> +

Can this duplicate snippet now be dropped from
tools/testing/selftests/kvm/lib/x86/processor.c ?

Reinette


