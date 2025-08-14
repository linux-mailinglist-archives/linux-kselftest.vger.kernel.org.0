Return-Path: <linux-kselftest+bounces-38928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C215B259C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552737AD727
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252251E3DCF;
	Thu, 14 Aug 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pbg8gvsE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC372FF65E;
	Thu, 14 Aug 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141632; cv=fail; b=NVg0Vm6a13i6Ct1ikFaJOnazhhsXV03wgMOQHjXTnVkCXWpNPzGM/RxUNYMSGeAALDmtLeqHPd8Ebdcde2yz4BSpn9ymOdJLVyku59++6l/D/lgMhag8lPQbpQYHBdGfHbOR/MbhpF3UlNLrRbOlnWfy0m3bpLH/9Qg8NjPedAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141632; c=relaxed/simple;
	bh=yvWULiMM3nT+upz6MqjBaJD9lxVbOaFURW9Odw4T/vk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7+igky8v8Mqmcin6W54QO7fp0bJNakTE5CDNKL8m7WWVKmJRR+WrDdtOllkpnkSY8XbCcqJbiknrup1DafjoNtr4gB7x/UxR8EaiDwuZdFQ9f2ijLg2EAu6jVU47h57+g2gQQHWMF8JMw5GklYU9KEPp8qZFC/RTYVCBhebRec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pbg8gvsE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755141630; x=1786677630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yvWULiMM3nT+upz6MqjBaJD9lxVbOaFURW9Odw4T/vk=;
  b=Pbg8gvsEvg1sgt7sTmXdNkdVaV8pI3N0dl61Z/vS+Bo7y12TkKT2iZk+
   +eUT9Vh05FCrDzK4KZsckDiuBrgF5H9BYf5zhEdTknK+JWgn/O/zafCE+
   3Kkh5UNe3m7TqcPQLGoinpx5YXiBpsq/0y6WM4VdFPYZYTawyDatIOylf
   vpz6R5iuI4n+51VGXbeFVg4InGPa+J3o7YNjYcnJGu+pbomc7trmCiVSj
   lUwxTsIG0vibRSHk4soA6ge5RC1IuQOnWDs2zjcCiPb6/mofTpL3T2baD
   iH+KUwDZipeUm0KBz9CjfVSdVzOQg/tdw9UEk44ABcpJ0kIDN3sx22NXC
   A==;
X-CSE-ConnectionGUID: goBT2jHJRoSyPCwBWSGxVA==
X-CSE-MsgGUID: TkyxZwFTTsmlrkT6CNUARw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="75021359"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="75021359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:20:29 -0700
X-CSE-ConnectionGUID: zpzObA0bRdyRJbEkhkjBbw==
X-CSE-MsgGUID: y8HmO/h5QP+Jp37XPXv0Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165827518"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:20:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 20:20:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 20:20:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 20:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR42FzA/ZohG1MvR47mF8MZcKkmfIpeLx6p0yMMq9Ew8bZy35XUF9YKpsDOQuFSh/xejsA0j48sgk9F2PWr1kepoTewUhy932lHU37KNcHreIiqhWJDByt9Jiz6gVL1s6vUjL/HouaBFT2nfNvAi7LUqyyVkWwg/WnZpSnOXltcAZ3NLm1E17d28AVYKla5w1UB/16cGpUV8pMh0Ym9VPo5ThDWU4qgiFZpdtbgGbvy9QHs/euTJ8MpPPds2L91q2V08ovMKsV2wJR+tyFRsDRKQhXBMEUSTf1jLCUPJaW4VyHFbTUm2Lw+Y9tyWaiouhIARb38W1ngWiU5aye75UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svivPCqguUzZ3u8jdWs67BZP823otBt92w3JYAjwJeQ=;
 b=vZ901tJFo8ph+HYJlqV4fioWQQlx382fru/iEa1BBqCE5Ad5IVEzJLI1SdjWy9QMvnYM/JH/oU+SEwOiGS/8dSvYnxl7HI3onnkZkXjl52n7bBA7wQe7s4QxSkrvZDhXMC7pLnIZIM//yErLnUdQBues3sYilyax9QV2RYUS3VGzVk+IdCvkulVJCIq83OFWu1Uawzwfl9MDpnVzPeFZ5CPMxEoIaSbS1ju76JvzEpbXsn++6MD+pS2WCJJFNh0gi2JuSKNVJnZaAGMSNBxHiolHEoVljONAmJCKik0LzlxfnSwXNv42qfR8C+LWEgp1yCtee+JGIUSr8gWNNRi9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ2PR11MB8298.namprd11.prod.outlook.com (2603:10b6:a03:545::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 03:20:26 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 03:20:25 +0000
Message-ID: <4fa12f71-74df-4d62-9844-60125b85f677@intel.com>
Date: Thu, 14 Aug 2025 11:20:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/30] KVM: selftests: TDX: Add basic TDX CPUID test
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-13-sagis@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250807201628.1185915-13-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SJ2PR11MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: aceacd59-e244-4c20-ceae-08dddae182c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXh4VE1lYWNRNEVSSzAyVUMvclQ0cklKWFpWVWhHaXBaQzA2ZHR6eXhwQVdw?=
 =?utf-8?B?UDVQakQzN083TXRyZ3orOUUyeFBiemdLT1l2VGx6bjV4SkhiZ2NEYVdycXlC?=
 =?utf-8?B?cW1PZE8vU2lTUFMweXc5d2tCTmZYcGdVOGNFclc2ek5XeGF4dVNJbFB0bHVs?=
 =?utf-8?B?Q1Jiek5zekZGREZUWDBBN1pmbEZwQnBMR2hYQlg3Rkt3VnpEVC9GcDIrNjh2?=
 =?utf-8?B?ajBkK2pPT3cxV3laL1d0TU5mQ0Y4ZjBib3k2eXlPTmxkbU9nRGU3NGNLWVZ0?=
 =?utf-8?B?RUpyWWNKRStEN016ME9SdEFFa2ZSOWxkbjhFcGxRODlpdUFwaUl0aWhveE81?=
 =?utf-8?B?YnJnNzlnU2RXQWM4UDN5bW43Q1ZUSG5GclZlbzdweGhNR3hJWStOMktLWEdz?=
 =?utf-8?B?Y3dheEZZV01pRDZrdXNYQkdNRGJkTzlsYTREMmpxYjY5cXhiRG5mZEh4K0wr?=
 =?utf-8?B?N3pDaGU4dzNsTGt6b3h6SnRpYXNnbFI4MWUyR21Ra1BKaHNvRCtVbEg1UjM1?=
 =?utf-8?B?cjNYRjJaZURHbmdGYlBnRHEzUG5XNXpGUDdpeERiZlc2NlFTaTdJLzFsNWxv?=
 =?utf-8?B?UWx1c1JNM1RsYmN0Vk1LVU1QaWhrZllvTmY1ZFpXTFZldmE1N09IbmkzQnZW?=
 =?utf-8?B?bHpDdVBSWDlrTEJlMkxQdTd4Y0dsaUtYOEI4VWVHS0poSUFWOUdPWDk5SzF6?=
 =?utf-8?B?ekovd1BvVkFkK2NQYnB2L29ML0ZjdVNwcEl0MldsTDJ6bmFYRHBRbzBPQ2NI?=
 =?utf-8?B?VVhsc016YXRqS09rdlpicUVsL2ladTlxdWYyZ0RUdE51cFhIMUhDVmZUYnVk?=
 =?utf-8?B?bnBaYjN3RGhieEhWN2tDUlRjcTd1TzRmZGp4d0IrU0kyaWtUVHJxQlcwMGk4?=
 =?utf-8?B?WWJiUUxhaWxrcGN3YnlLUy90M1FtZTBidVJ2cXFXSFl2by9xeEpVN2k0UlpN?=
 =?utf-8?B?RFg1eHNjT3A2M3NWVldvVjFWc3JKdkxTc3hBMWtFYVExMFJ5N2RwTEZ4R1Z3?=
 =?utf-8?B?b2hMbTBSTmVOZWFJMy9kK3VCVXgwcEY5aklsQk0vcCs5SlJ1cmdUamt6TnVm?=
 =?utf-8?B?Vk13cElwUGpkdE5KbW9BdnQ3WVh3RllTSWZKajNaaTlpZHA2T0U3WnlLcWQ5?=
 =?utf-8?B?ODFOc0c5L2xETkUxbkdWV0NqdnRkZkJUcFpkdGxMcDlsQlY1RDFUMzQvK3J1?=
 =?utf-8?B?VjFMNTY3eWpRcngyNzJyald6QWV4YkViQ012Vmwzd1VJME4zS09lTmw3ak9Q?=
 =?utf-8?B?MDlzd21UZStiL1Q5RTNRcU14SGRNZkM4eW5pK2F6TmN3K3hHR2hhWjAyR1hl?=
 =?utf-8?B?RWl3UEhybldBWmxMNnY4aEdIZG95SnNSZFIrcmFZVFZWYmZSRThIWEdGVzk3?=
 =?utf-8?B?NktoZU9ldGY1RTRrUjlRblREeGx1SWVlV1NoMHVFVHVTVXdLZDlVcWc1bkdG?=
 =?utf-8?B?M2E1RXZGN1VvYlVUanEwdGVNR2JoTEpLZnltZVdoOThzMWJyelZSTlRFdTVC?=
 =?utf-8?B?L1hyOGNrRDJOT2JvR2FCZ3hOdnhpTWJuTWtZc2QvM3BVVnhFc1JoSEtXSDZv?=
 =?utf-8?B?N1ZSOUxrdWllK0c2NlJXTURYMzk4TTY5NjMwWmdSTUt0OHI4cEJzamhUQVVG?=
 =?utf-8?B?MkRzNDQwZG1mejhUVlU2QlArcVBhRVdSeEtHbkRReXZZZ2tJdjhjYnpyenJI?=
 =?utf-8?B?R3Y0eko3SUFZWmI3NTdHL2VySFBTaUhOamQvL2FUYnVtZGI1UGkyMmJsYTVU?=
 =?utf-8?B?ZHhOYjgxQURmYUY4L0puVXVpVXlCdFNiWEpXZmlQUW13Y1lOSVk0OTlURzVa?=
 =?utf-8?B?NFdqdVJJZHVySUYzRFpJOC9xZGNPMm1CSWJPOG02UW91V01FejFjWk5iZ0ds?=
 =?utf-8?B?cDRwazVUbjIrMVYwbFFEajUwODR5NU0rYk50TFdobk10dDhiZWZqNGNLR1dD?=
 =?utf-8?B?QkpIUHd6OVJpTnp2MGRJYXpLWGlReEYyM3JSdFRuenVpR2RNQ2hVWE9zNjJj?=
 =?utf-8?B?cElndjE1NC9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZJVGFMNG1UWCt6c0packdUZko5ajE3NGVlcE5mdVEzQW9iZXFxRERSazlF?=
 =?utf-8?B?Yzd5VXdHdW9lRFpydmRqZ1BBbThzV2lKalhERHdJNWE5T0dJSzR0d3hNV3Bo?=
 =?utf-8?B?WThnYVZNeFBIazhSQlpOZ29rMWpUUldBRGlRWnA1SjFTaDh5Z2YzOFNvd3dp?=
 =?utf-8?B?UGVKemtiQ1BGN3dxbGNYWC9oRWEyVnNkaFdDUHlBS0d4blQ3cjdmZVdrbkdk?=
 =?utf-8?B?Qy9HcVVaYmV3b0NMSUN1cGE5aGliK3hyN1VTQjllZ2IxclZjQkgzeTVySk1t?=
 =?utf-8?B?Uk92dmtUdHVvcElUMnR3SERtVG1nc3ppSU5TamJYNVErQzNZMkpGVEtEM2w4?=
 =?utf-8?B?N2ZWQVJYck0wT0ExTFNCcndNQkcvSkpKOGtCV29ETS9JaGJ0dmVOYVVGVzJp?=
 =?utf-8?B?djkzdTBGN2FweENtUWtkS3MyNUc0d1BMbW9nWTBSYnlCLzRVSkF3aU1kT3lX?=
 =?utf-8?B?c3Q4UkoxbktXWmtVYXhTUzZDR1oxMkpzSWZJRXJGWEt0YjFmYklvK2tPWnAr?=
 =?utf-8?B?ZWpXdU5aTWtVR1RlL0htb1lxWXkzTjNBeGw5dm9IQ0hYS3pPMHpTaDNDdzM0?=
 =?utf-8?B?OElIQVFnQ3RNNmRpZlFNMnhTQjBGczJpNGZESGhvcnZ1bU9NcWRtb004K3Mz?=
 =?utf-8?B?ZHdQZzFrMkFIbG05eFE5UlRYQUdoVm5HQ1ZPSXo4bHlyYW9wTWpzdzdWVVo3?=
 =?utf-8?B?WTVTN3RzNVVXTE85MFdmK2VVWlV1b216WFZiTXJ4WUVUNVdIbkRNY2NtUy9a?=
 =?utf-8?B?RmFKcHpNd0NQNFZpbHBzMlpCVjZ2RS9OaG9weFQyN2ZCeHNPM3NhSzI5MXNW?=
 =?utf-8?B?anBhcVQydE0rS0d0MUlJQ1J1T3UvQXZuUUtvZncyRVE0V1VhSUlBMTdEN0Uz?=
 =?utf-8?B?Umg0YmdqNWFsZTFobEJNSVRaRjVSZGYzaDNSRnVVUEpSNzJDZDFPUnpxbkhk?=
 =?utf-8?B?QmlJWlluMWRzVkpUeFJZalhvd2drOXRYcmdyRUFncEI3L3gxbityMzVrMTBZ?=
 =?utf-8?B?SWNFME4xREV5YnpYa1RvWmZoaUt2Z1RXYjlGaHcraWhFMnIvR1I0UnVaUkFn?=
 =?utf-8?B?OHJDREJIbEUzVGlBNEVUbWtoOGRxQnkxZzdLZFNZbmlTRDIveXVLK3NvbU12?=
 =?utf-8?B?cjljTkVMaWR2UTNGK2p5NmF5WmlhUmVNeUVQQVJHQUkyOHh2OFcwdmF1R0Vz?=
 =?utf-8?B?TkdsdWdZcnVoYVpna29NNDNGUlFwWDBDRVMyQW1IdmQwYnd5TTJNT0tSTTRj?=
 =?utf-8?B?cUlmSExiWjJwdDc4NG9MeWtZOWlXc3NGd0xnNzljcC9NaHFPd2U0bExkaGxz?=
 =?utf-8?B?NGFVWDY4VWxKMWVSekhHbEl2MUNxTmErQ3VjYzYwRlFFeW16ek84bXdDNUpq?=
 =?utf-8?B?aDAwdk0rTXFvT2J0L21CRnBmOUFXRWtOMmczUmNoMzFPZ0hXcW9XbldFQ2po?=
 =?utf-8?B?QW1xdU1iRVdnZjBFMTZzLzZWSG01MnBGeEs0bWRqNDZEeWFJdXRDTi96MDg3?=
 =?utf-8?B?aExOYVg2SUF1bjBMLytyYUd0QTBaVjg4ai9LYUFwU1EvM3htc01jeDY2c1JD?=
 =?utf-8?B?Q0NTdlQ1ZnB3THYrUXhacVV0bk5YTGhQVWJ6T0RWUGxZbXJBaVkvVEU5cUdl?=
 =?utf-8?B?NFp6UUVpNG0rSG1XZXVFc0NhNHJQbjE1c1Y5aXNlVDVYSEQzZ1RxMU0xUlI4?=
 =?utf-8?B?N0YzVjBKWWlrQ3dVTTlaUUJnbVpZOHRCeGZKRHpSMXlHKzluamtKY3JmQ0VL?=
 =?utf-8?B?MFdvREVWU0Q5OEtReGlLTHVLRnJIQ2lIeUVtOU5yOXZaMUJCNzZBY1YxTEgx?=
 =?utf-8?B?eVlPRXFpR1lwcjZJZVZ6TjNtTldhTG5QbndoRUV3L1NldTd2T0FqZEtUSkVw?=
 =?utf-8?B?NjFUNVZsWkl2V3V4MVVDdzJ6NHd1cDAzYzcxQlVjUHZheG0zeGlTb0ZTY1VO?=
 =?utf-8?B?eDhRNFFRV2ZqMnZTenpLNG5DOW5MQSt3a05mcEVwZXI4OXFMQUNmTVY4b1FX?=
 =?utf-8?B?amZIT1VrU3RkWmdHOVY3V1ljVCtjVmg5bWlIYVVlRHB3QXNSM2I3RHVYQlpU?=
 =?utf-8?B?b0l3eS8veUIzeTZoSFpwUk9HSHF2MVFlOW5aTm5QKzZWeUtyT1JwRWhWcVEv?=
 =?utf-8?B?S1hzRjEzUnpVa1NOTHVTZUNwcHcxdDljT2l4TU0yTlJkQng3VG9ic3dFN3Vv?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aceacd59-e244-4c20-ceae-08dddae182c3
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:20:25.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvT6H2904ZUFer9C3QTfyR9nCjkRHOcgymAsRwSG6C4/FZ8JQnVrZByfxkkKvNTha8sUXYe/nC68Bic8bHoc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8298
X-OriginatorOrg: intel.com



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> The test reads CPUID values from inside a TD VM and compare them
> to expected values.
> 
> The test targets CPUID values which are virtualized as "As Configured",
> "As Configured (if Native)", "Calculated", "Fixed" and "Native"
> according to the TDX spec.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/test_util.h | 15 +++
>  .../selftests/kvm/lib/x86/tdx/test_util.c     | 20 ++++
>  tools/testing/selftests/kvm/x86/tdx_vm_test.c | 98 ++++++++++++++++++-
>  3 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> index cf11955d56d6..2af6e810ef78 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> @@ -9,6 +9,9 @@
>  #define TDX_TEST_SUCCESS_PORT 0x30
>  #define TDX_TEST_SUCCESS_SIZE 4
>  
> +#define TDX_TEST_REPORT_PORT 0x31
> +#define TDX_TEST_REPORT_SIZE 4
> +
>  /* Port I/O direction */
>  #define PORT_READ	0
>  #define PORT_WRITE	1
> @@ -77,4 +80,16 @@ void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>   */
>  void tdx_assert_error(uint64_t error);
>  
> +/*
> + * Report a 32 bit value from the guest to user space using TDG.VP.VMCALL
> + * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
> + */
> +uint64_t tdx_test_report_to_user_space(uint32_t data);
> +
> +/*
> + * Read a 32 bit value from the guest in user space, sent using
> + * tdx_test_report_to_user_space().
> + */
> +uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu);
> +
>  #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> index 4ccc5298ba25..f9bde114a8bc 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> @@ -104,3 +104,23 @@ void tdx_assert_error(uint64_t error)
>  	if (error)
>  		tdx_test_fatal(error);
>  }
> +
> +uint64_t tdx_test_report_to_user_space(uint32_t data)
> +{
> +	/* Upcast data to match tdg_vp_vmcall_instruction_io() signature */
> +	uint64_t data_64 = data;
> +
> +	return tdg_vp_vmcall_instruction_io(TDX_TEST_REPORT_PORT,
> +					    TDX_TEST_REPORT_SIZE, PORT_WRITE,
> +					    &data_64);
> +}
> +
> +uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu)
> +{
> +	uint32_t res;
> +
> +	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, 4, PORT_WRITE);
> +	res = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	return res;
> +}
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index 97330e28f236..bbdcca358d71 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -3,6 +3,7 @@
>  #include <signal.h>
>  
>  #include "kvm_util.h"
> +#include "processor.h"
>  #include "tdx/tdcall.h"
>  #include "tdx/tdx.h"
>  #include "tdx/tdx_util.h"
> @@ -146,6 +147,99 @@ void verify_td_ioexit(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +/*
> + * Verifies CPUID functionality by reading CPUID values in guest. The guest
> + * will then send the values to userspace using an IO write to be checked
> + * against the expected values.
> + */
> +void guest_code_cpuid(void)
> +{
> +	uint32_t ebx, ecx;
> +	uint64_t err;
> +
> +	/* Read CPUID leaf 0x1 */
> +	asm volatile ("cpuid"
> +		      : "=b" (ebx), "=c" (ecx)
> +		      : "a" (0x1)
> +		      : "edx");
> +
> +	err = tdx_test_report_to_user_space(ebx);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_to_user_space(ecx);
> +	tdx_assert_error(err);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_td_cpuid(void)
> +{
> +	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
> +	const struct kvm_cpuid_entry2 *cpuid_entry;
> +	uint32_t guest_clflush_line_size;
> +	uint32_t guest_initial_apic_id;
> +	uint32_t guest_sse3_enabled;
> +	uint32_t guest_fma_enabled;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	uint32_t ebx, ecx;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD CPUID:\n");
> +
> +	/* Wait for guest to report ebx value */
> +	tdx_run(vcpu);
> +	ebx = tdx_test_read_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report either ecx value or error */
> +	tdx_run(vcpu);
> +	ecx = tdx_test_read_report_from_guest(vcpu);
> +
> +	/* Wait for guest to complete execution */
> +	tdx_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	/* Verify the CPUID values received from the guest. */
> +	printf("\t ... Verifying CPUID values from guest\n");
> +
> +	/* Get KVM CPUIDs for reference */
> +	cpuid_entry = vcpu_get_cpuid_entry(vcpu, 1);
> +	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
> +
> +	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
> +
> +	guest_sse3_enabled = ecx & 0x1;  // Native

It seems the CPUID virtualization types in this series are based on some old
TDX module spec. The SSE3 has become fixed1 in current public 1.5 base spec.

> +	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
> +	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
> +	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
> +	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
> +
> +	TEST_ASSERT_EQ(guest_sse3_enabled, 1);
> +	TEST_ASSERT_EQ(guest_clflush_line_size, 8);
> +	TEST_ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
> +
> +	/* TODO: This only tests the native value. To properly test
> +	 * "As Configured (if Native)" this value needs override in the
> +	 * TD params.
> +	 */
> +	TEST_ASSERT_EQ(guest_fma_enabled, (cpuid_entry->ecx >> 12) & 0x1);

FMA is configured by XFAM[2]. If we choose this feature, need to set init_vm->xfam
which has not been used to configure features in this series yet.

> +
> +	/* TODO: guest_initial_apic_id is calculated based on the number of
> +	 * vCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
> +	 * and allocated sequentially on each successful TDH.VP.INIT"
> +	 * To test non-trivial values either use a TD with multiple vCPUs
> +	 * or pick a different calculated value.
> +	 */
> +	TEST_ASSERT_EQ(guest_initial_apic_id, 0);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> @@ -153,13 +247,15 @@ int main(int argc, char **argv)
>  	if (!is_tdx_enabled())
>  		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>  
> -	ksft_set_plan(3);
> +	ksft_set_plan(4);
>  	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>  			 "verify_td_lifecycle\n");
>  	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
>  			 "verify_report_fatal_error\n");
>  	ksft_test_result(!run_in_new_process(&verify_td_ioexit),
>  			 "verify_td_ioexit\n");
> +	ksft_test_result(!run_in_new_process(&verify_td_cpuid),
> +			 "verify_td_cpuid\n");
>  
>  	ksft_finished();
>  	return 0;


