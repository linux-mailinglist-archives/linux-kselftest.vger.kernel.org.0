Return-Path: <linux-kselftest+bounces-44357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1CC1D556
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1024E1E95
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F5314B6C;
	Wed, 29 Oct 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nul5N0hV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019B313E21;
	Wed, 29 Oct 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771712; cv=fail; b=k/xVBZ6RSk2T/dGIoBr7lKmRQmjqFQHELKDYg9gj/YgxhkcPJyc2tR5Fjz+AXJTuMzfj341Xs8T6ZhzPYtHeT4SAFERFPS29AUmP71p8hpPb5s46iDZpGau781vzYE1k4zCplkB34BTh+hu+oAcSHomQm7o/JXlJHCSeEoAMw4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771712; c=relaxed/simple;
	bh=ab44MQ9zV7qKEWYsITLWMcaQwpiEToc8x8kRf/o43mo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sozBeYY4cxR/C2Q+uU6zf3Ob5ruzNbcbEHbbkxCluw8eQguJ1S74phT4s6pjQCQWlKh6HdQQcwwtirL15WuiZH0U3LZURDFWFTK0Udx5KhYZcdZ8fxxy+Iz1Pr4Jp3emjgj2tHT2WFihY5RFMK1p8X1np84NwYdQ3LZXIndYzMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nul5N0hV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771710; x=1793307710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ab44MQ9zV7qKEWYsITLWMcaQwpiEToc8x8kRf/o43mo=;
  b=nul5N0hV48HgxC2fFy/WhSouHeyL54P6pF5R8QRcyFdvHGE2WkkShTzs
   TaC9sHD4llOGIqPKXDIRVTuXJUkMF6fOOuIfHd0En45/pGhFvpI3aO5Rq
   XI+lGOfy21CZh7Ws2gYSmy1EouPUjtxFMIJ0h1hXOGQsnUoi2dFzmNVEI
   unek0+cyd40ujfrpXbWpmQVpDCqFvXrduI8dibJgLFLMeX29YIbr+56MI
   SAl3m3x88gPjww2RaV1bDm+okDZHBHWVjXHSdVujNHeDeN+E0nfPndOvE
   sIhxGPcn09wsnMNkhNMh9COCT3MRYj9yHaM7JInNIB/WxQYHDXhoCLc/D
   g==;
X-CSE-ConnectionGUID: KPWyS7GvSXGjTasYJzDICw==
X-CSE-MsgGUID: rrABQ3QGSaqYmQohpW2FIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67767122"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="67767122"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:01:49 -0700
X-CSE-ConnectionGUID: TkdPtSHzQ8Sg90qs9n28+g==
X-CSE-MsgGUID: 11QA8rX7RC+zxtGiKTYa/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="209357468"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:01:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:01:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 14:01:34 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULKUaJkF8b3z82iKzrzGE9A86rkVU6XISoOtWJ53IvTBRDpY8Bcf2jbs0scFMCq8RRZi72rt7it7jlL3I5yJDL4vXNF4FIkQjsHlVlUfO8dyiAw6BrIKLUX7m+7NZCV0j8uzCpn40B+7zZWowwdx5asCSR80lw7s+tvO6uBFGQxlD/sv68Ayxegfeld+9BxwgV0CkccsJRF9S8CUL+EKAcw0uyn1fI1JBYP5MniBps71jbwjnEt7JyondYVcgMtJR/Qix17n3IyZteecEZqG3ragdGEdyJDYzVVrGjtccjhV0UOYEvVd1jzOkCKwX1AeC9kQCXJY5anXYUTXR5IAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hDYJCQEWsJR7+sasaLKipIPUX7OvLr1sVXS3YxBNcw=;
 b=bcRrAe4keKVucZJF2i3g3UgT5MsaXaJFmdimVKSvf5YraQG4H77/Hig/R7K/nEMCjEdL3T68nELwhzmgvJ6P5881fmbiAo5c4FbM2m+PuEjylRU2w52cdGV5HyQtaMeIoj+x1ZMrStjP+fPLa1BaKjNU/OmxZDplm/lYydHMNN7foxFYfrQAhEZf/eKmk3PWcVIFN+kVg6gWms9iUSSKAKUZnA8MS4K4agm20xCHt9GLg7PT4JRFSRpK9N3V+uLev5501egUhPSrlPvWknY6YGdI1bFseU4mwfthU2NJSs+wV9CyDhyUH+3D6eXZ3jMZiv1mHwgiGDVYq661Wdi44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by PH8PR11MB8038.namprd11.prod.outlook.com (2603:10b6:510:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 21:01:31 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%5]) with mapi id 15.20.9228.015; Wed, 29 Oct 2025
 21:01:31 +0000
Message-ID: <59e5d267-5ab3-40bc-9ddc-3c778b1347de@intel.com>
Date: Wed, 29 Oct 2025 14:01:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/23] KVM: selftests: Set up TDX boot parameters
 region
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
 <20251028212052.200523-12-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-12-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|PH8PR11MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a15d2d-f706-4058-a480-08de172e5605
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmkrN09Fb0s2WFlDcFFDbjJzTzJkaHdnYzFQaVRkYWpJYzVjZ3ovQVVkbmxK?=
 =?utf-8?B?MFlVSmJIQ2ppeG5EZko3L0hRVEFwZnR1clJ1SGZneGVnOEVqNnVTNXQyVUEz?=
 =?utf-8?B?QkxPSWdYZHFKZ3I4NUZZVVZtMURUNXJic0xiTkRUM2g4NXRaOXE1QjBSdjFx?=
 =?utf-8?B?VlQwK1BGbVlmaE1ZdmJMRnhmek55Mk5HVEV0aTBWbjQ1Z0FFREU0cWsxdE5y?=
 =?utf-8?B?RG1TVlVIYmkva3hyZTQ2TjhEKzZGNURWeVB6cGo3ckxKVzVZOXQ3U0Y1Zkh0?=
 =?utf-8?B?cTR6dnVpQ21NZXhKdFArdzJDRXJhSW1hUFJLUi9WbU5lRitKWGwzVkNXWlhO?=
 =?utf-8?B?bEhvQVlIYzlyOVhlY0RqUlVqMisyZnJQRURRRmk3ZXFhT3BIWFFzcDJTZFJi?=
 =?utf-8?B?Q2hxUUJJbE1qbEMweEY2SWcrTThSSGxXWVZsT3ZjdGtlUnBvVitmOUY0SnNh?=
 =?utf-8?B?MXZYazBJdDR4eHFWM3ptNVRQTGN5eGhpall3Mk11Vkl2TytqaFFuRjlmYUZk?=
 =?utf-8?B?NURqS2dHRk9xTUJocHVFZmdPOUlGYlhsbnZCM3Rid1kxbHNoTEVpcnY4Y2hK?=
 =?utf-8?B?cWV5Y2pENmVwLzlRVk00THh6MVhISE16U1d3TzVIUFNBUmc5Q2RtbzhHTC9v?=
 =?utf-8?B?elY0TTRTNmNCT0twUTdrbjNFSTZuT3FmRkdOQmRNLzR4dHRPeFNzUVpuTmY1?=
 =?utf-8?B?VGFldGZqTnBQMHZZandVcHRFRzZOWm9NZTB3Ui9XejJhNlM2REpMU3NUWTB6?=
 =?utf-8?B?eWVJL0JYUEgwMmhyV0hoRGVnYW1WU1YyUHRwOTdBaFc5M2crVVhmR2pIakR1?=
 =?utf-8?B?VTZ6cjFuczVSNEF2WVhhRDJGcEtlTGZ1cWZ4WlBkNWVSek5IZFM1dk9waUFq?=
 =?utf-8?B?amlTN2NJZi9EcE1ScXhWY2Nkcm5iNVJFYmY2ZVp5RkRDR1RGQVdFMHQxMDJQ?=
 =?utf-8?B?L1VBZW1tZDFtOW1SYzFVeUxPUlk0OVhsNitFVUNsREVuVVhOZ0d4K2x2YU9i?=
 =?utf-8?B?dTdmWUQzUWo3Nkp6ejlCekZzU2QxcVkwTUhJMjF4NEVnU2tWZFp6UkJjdWJp?=
 =?utf-8?B?ZE5ld3hGdEVsMnFqUTk1d3Z6UGZWMDJoa0laR2dUTXdycVhqOEpDRG1jN3dm?=
 =?utf-8?B?YjNqWmh6bmE0WmZ2YjZVemU4WWtlMHhpazU2V1lvSWxaeTlFWTd1RXRZa2Ja?=
 =?utf-8?B?d2pTS2ZLb3VFQjU2c3d3WXg0T2hOLzIvOG1GN1NhVWJDcUkwY25oRnpMYmND?=
 =?utf-8?B?RU41cmxNSUwrd1NBc3NtOUFnbm9WZHlUUW95UHd1WDN5aUcrQVZmYjVUeEdR?=
 =?utf-8?B?bjlHVjRUZENvaDRIWFNwcXIyaGZHcTYxYnFGWWVXRmswOERWRmt1NkVpSmFH?=
 =?utf-8?B?aDExcDhjM1M2Y0ozcVAxWlNTbHErQTk2bnY0T2loN1EyYXgrSE5oWjFwcHh2?=
 =?utf-8?B?M0dVdS8xTnliMUwrR0NmNURpM00yd1Rualhsd29KdGlHSVJ4Y2JwektvTWlo?=
 =?utf-8?B?OTc3RlFabElzTDl6dnhUVnFDWGlBZmRtR2NteUJEZFUwazRRSzZIMzEwUXFh?=
 =?utf-8?B?Kzk4aThUVWh3NGxvSUhlMjlodG1KQ1h3SlV4NlZZcG9nanVYZk11RFZwd0NE?=
 =?utf-8?B?bHZ6TG1nS09sYWY4dlh2RzZNM2JpL0ZzVU9wNmZlMVphYi9GYkFOcU1QeEsw?=
 =?utf-8?B?bnkyQ2gwVmZORDc5TG5rNHJDYnBrd2cvLy95alljd3RNdUhXdTNWNjRIMTRZ?=
 =?utf-8?B?dllSQldpSjFxU2cvYVFPeFdJa2hGNkxZOC9SYzhldVhXRDFzemRKdmxKZHpu?=
 =?utf-8?B?bStYaEo0NXVNSFNOTUJ3VGxFY1U4OVJtbkprTkZyaGVLNzJLZFRaNVU2US9O?=
 =?utf-8?B?VEwwUDVBbWZtL3JTRjZURjBWdXlWUStDbWxTcEw4dG1UcWNNWnZHYngwU1Iv?=
 =?utf-8?B?T1NncEYwV3ZydktzUEppQVVTVWx0VlBuOHFKNmEyOTNhQ1N0N3VwZ3h2ZFhn?=
 =?utf-8?Q?4TquOce+FU6F6hWIGh6+E4xdCZ3F/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNWNHlwV1hiMC9wZndWNFU1UENqMVVLZDMxdHNPc21ESU9NTFE0Ujd2MjAw?=
 =?utf-8?B?VjJaRW1rbG45dkpEdld0Ni9sNkpIZVlqVjNPRG5LcGlxQzQ5RWx0U0RSc0Zl?=
 =?utf-8?B?SmRQN2ROL2xuaVJ4M1Vkc2IyRjV0eVI3Y2hNY2U5b2tJYVlyazNSY3dxUU44?=
 =?utf-8?B?d2s5bnMzQ3RhOE55NW83WHlDd1dvemUyaWpvZ3luNEY2TnR1YnNIT1VHYzlr?=
 =?utf-8?B?RlJxSzFBbFZLRTlFTHRndWdlc2xOSVhFMCtwOGpsSkZZVU1nNUNTbDRBTDBi?=
 =?utf-8?B?Q05FamxjRlpCNEVJYVF4R2Y4TmlEb2tBSWFuOEpKMWJqaFdKZjUzRE4vcXZQ?=
 =?utf-8?B?MjJ1MitodUZMSTdycGwxSU1XMHk1K0dEMnA5endQTEdOMjNPZlc5bk9GZ1Ir?=
 =?utf-8?B?b0t3ZjhRMzhUNGlEK3E2VjlpRU00UzVTSUVUakQwMkdhR1dJM2c4TXlQLy94?=
 =?utf-8?B?a0tRYmtXQ29OLzdMdGJUWTVTL3FvbUQ4cWhGa2kycmgyZ2pmRFVudGQwNHFF?=
 =?utf-8?B?TU9hZzRIbzF6a0x4RUVDc0ZWbkFXK0J2MXhXRW00RFlWM2xFRlZjVWJObmlB?=
 =?utf-8?B?Z1FsalFvVk9GcTFDSHkwcWhpU0tnN0I3TnhMN2ZsdkNJelR2STZhY0tkRmZP?=
 =?utf-8?B?b290SGNZbit6cDBDaFVITDIxNnJUbUlxRC9Sak5UZFEyQWg2V3g5V2xqR0tG?=
 =?utf-8?B?SDRJczNwZXltQzRuRXZkODB4emFDR2JkdGxwc1pJMnFrQ2JmQnVKdDY2RWtV?=
 =?utf-8?B?NnovNWJJZDAzMTZWSTNab0RkWVJ2VmFGeDZlN21lS243a3BDOUtwNEdaeDQ0?=
 =?utf-8?B?M2syY0ZSaDVKR0d5ckZXNTdnQk5VSnpUSHcyT05WZUdUWDNGalFCTThEQzRY?=
 =?utf-8?B?VHUvckNXemk3WFJya255cGptTzFnZlVvMjh5SXExdjNSQTZnaHlvT0FsNVkz?=
 =?utf-8?B?blh2RGtZT281RkEyaVJxSi9Ra0Nrdnl1WTB0eC9iSERYNGM0bDJzTFNSWWpS?=
 =?utf-8?B?RkFZVktib25MSjhGUkJVWnhRWkw5Y2VQd3liMUsyNEVXejBCV2ZjK3ZlS1Ur?=
 =?utf-8?B?eG1DWnBGdVRlemtkekVEa3dDMlE1OFZlQjZUVDlrVHVENitFYWN5eG1NaTJt?=
 =?utf-8?B?Qk5wRWlBQjhPb2Q3c25WQzAyTTQvOWk0UHorL1kyWXR2elhxRnBQODVrMGZw?=
 =?utf-8?B?UDdVOFJiUUc3a2x5UUxoQmhyNm5kUThIeDlBd3IvbHprNFpJbWhqWnhJbkNh?=
 =?utf-8?B?T2tUOEhPcytaWk8vdHJPSTR3VEFVK0tESDNDL3JKc3NYbmtISmlZQ3NhL3BL?=
 =?utf-8?B?QUZqeXcrVEUyZk1ZTTdjOXFMWVU3cnFxZHJ2d0tzY2dvc3RPZkx5c3dFRXpr?=
 =?utf-8?B?SXVYNTVkYkkzdXVpejNVeW1sWVI0SDVEWGNwcTdEZVFEZWI3Sy96V1VjOFZG?=
 =?utf-8?B?Ui96TG53N0J4WW11akk0ck0zbnBlVktOcHR2SDhUT3dNdzlSUWpCRjJHUk56?=
 =?utf-8?B?bXFITmhvZGlhUGZXcitWWnMxc0xWM0YwTnlKTkxTWE9xb3JjNzRDanUxT0Ft?=
 =?utf-8?B?NFZYZ1AyUDBWY0w5YTRlVVFZWGlodFhNNXNuTi90bm52YjlyWW1yajNENFNz?=
 =?utf-8?B?NXpiNkpheXA3dzl6V3FvZzNwbjQ5QXluRjFLTmt4NHdqYzF1alBET0pMek81?=
 =?utf-8?B?NERERHRhM1VDK3hib1dDUE51K01SUEhLSktZeUxHL3YrMWJCTWJNYjN5Rk1y?=
 =?utf-8?B?enN6NnkrZm1yWHBocnVBdnpwaUJzM0x3Q1NIbW9QS0lpUlMvL3d2RDZhcWhw?=
 =?utf-8?B?S3VwWDZEaUsySE9aRUhCa3ltT0hsaWFVRkl0bEdld0pHcWVzeWhyRGxNMzJj?=
 =?utf-8?B?ODZSZURKWTJFaGUwT0VkZDB1RjdLdzVhalJPQXBwWGsvbTN1ZE0xNlpGQWt5?=
 =?utf-8?B?SU5BVnUxeWRwT2txOG11VHc1QkNReW92Sk9ZOHdFTTFoMzRZSTFWU0wxbmwr?=
 =?utf-8?B?RzZ1b0I4UThGa05hUDJvVFE4elNjWkNESGZ4Q01mc084M09IRWMzbzRqbExG?=
 =?utf-8?B?NnNjRVJaRWFBd0RWM3VPbm1scDkrLzlKRVJQc0NTUFBVcGRCU0N2VkJvYWEv?=
 =?utf-8?B?d2plV2tHam80b2RSNnhlTjB1Qk03cTREOVVTRTlWbXVTOXo4L0dqaXNGUnVW?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a15d2d-f706-4058-a480-08de172e5605
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:01:31.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hT8O9Bl0NmkW55mNf5Ihhe/ewPX9k40AtFQxdGOSsh8kazZnKwzYA+GI/M44orRD0oKA0aC2JQgtTeaMWEFUrFnB8/jJhG7i51Q2QRpluIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8038
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> 
> ---------------------------------------------

A couple of patches in this series have this separator above that is not
recognized (the familiar "---"). This results in the separator self and the
changes below that follows it (everything until valid separator "---") to be
included as changelog when the patch is applied.


> 
> Changes from v10:
>  * Removed code for setting up X86_CR4_OSXMMEXCPT bit. At least for now
>    it is not needed and the test pass without it.
> ---

Reinette

