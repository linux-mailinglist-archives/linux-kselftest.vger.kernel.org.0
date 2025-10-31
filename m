Return-Path: <linux-kselftest+bounces-44482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00479C2332F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C5A1A27290
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E927AC28;
	Fri, 31 Oct 2025 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqQr/D1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CB1A9FBF;
	Fri, 31 Oct 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882165; cv=fail; b=FKpv0kgHsmoTJCfyTJV4H3bjdxnmF2smPRQaLcoANg2bTHOLLM2cq5XrPfHRqe6Vgfk4XUW9It82uq+9toD4xrVldCUUM6cFTFeE2dBYxyYh2ZorrLldfDmwS8HWLGRsT5Mgpofn8hEVC93w9IC83/95O0KjKqWw3NsKFX26StU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882165; c=relaxed/simple;
	bh=O9DzFqPraRXi9Z1XCLDfqHmNtjFKeFo0InHZ5iSVGlc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMZnBG1CA75zB95t9ZeJcKI7e39KKYwi5ee1Qaoc7AMVHJwXTgx8J1XAsNgeBLBoPiDFns5sjkjQ4i0wMCx6izsWkNIlPtswwoR+f6hkd++CAtsTgMgAhu12QRHCOaxVpJs/+9lklTGrxFTVKHhAiqzSSRs0yNoubgovW0ReHcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqQr/D1r; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882163; x=1793418163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O9DzFqPraRXi9Z1XCLDfqHmNtjFKeFo0InHZ5iSVGlc=;
  b=ZqQr/D1rOanPKS05INfIy5JcpFXXyP+n9e4VJ/aEg5y8l925dBASyfOX
   42+iOa7GPhIuzLWovh6XeHLGGUovfqldSQ+v8SmAiFhRfoxlvsLjbzqd2
   rQO7ybXRTIe5RHPjcx7lJLjRQ5tw6onbXeunXMr1/kAo11KN9XpmID+zh
   Nl7xDwvMtc8nmhEkOKyr3eQfs8GzcQX5GY45lh0NX+IyUtoyhbQ09sGN+
   xVVHyCw+PPYEhj/vm/Y2eBkGxUgrmqAufPiwmwVlguW9HHLn6IZV782D9
   ZJlnnu9Ukc8vIj2hoFFA+VkCREznEc88CtFHTAPyRk1J+9dUjnBU2MzRD
   Q==;
X-CSE-ConnectionGUID: RFIeIj6NTBCk2uvLE32Yjw==
X-CSE-MsgGUID: zeufKR6lQA25Dx0eEqRs1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75486354"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75486354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:42:42 -0700
X-CSE-ConnectionGUID: mNBoEb80S0GumtuhVKtWww==
X-CSE-MsgGUID: uWAHBftcTDOMQpyb5VtfAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="209693399"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:42:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:42:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:42:42 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwuECiBTz56f7NnM54BI7H42V7GCGdlpux8E6tLuULhse2FS0pg+DQHkFhafBfvancLrS9s1sV7cHl5YW0cBHdgKR5pU0u2p4GnJHHXm5YvVc9XVXnN7967zXXexM59SaDQClCBukzXqiK/NshDMpXXMOxLbcXPqjGpKb5cPOLR7KQtlp2SuQVXzA6+zcKeoMUNDB60qAdWGy6nrqcWwPc/nI/oQtqTKaQg1jlBdR/nk0qQeUIZcc6TStuQ/nNVkTtdHrwmz+7EoTXmWKncaqAQo+oaLYca1KdbRu/eozAijnp9c9BmYda0EMkRgyPnbuCS1Agz6GFiJeT1aKUIZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/adQM+zJKCkyuCy3yw/y8RUSPhtktdqLfXiNNsYgqmo=;
 b=RmFT+zXjwDwauJCQ2fDsXgfteCYjlyYC629GbSqbqqQdyvbOqqdKoiTWKu2RUBarrgIxRPpEEJMMopkfjYbA7PI5P7CkbvukzwGJtWCDTdrlNqKzhhB9UcfMEdNPC90aJsac29gveMmh5Nvi1cxTLcsMFHJKf600S3eH4wQNNTMGJSjez3qTkSx24XITSuYm9i6sUbg536mnVZNCuMY2RMwp0Ky+ONd/bJNvCQ+X4w30jwuttPD+MQjDu7hKnYFP3QBmN7Hru8k/UCPtCM2o8uhUTRkGLxeZAwjaRbKAFqqP4nkv5Q3UXlkDOeoOn2rutlKqLbw47jWIKRtFM/Hf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:42:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:42:38 +0000
Message-ID: <c31b08ef-19de-4fae-80b2-20c5adcbc5e5@intel.com>
Date: Thu, 30 Oct 2025 20:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] KVM: selftests: Add macros so simplify creating
 VM shapes for non-default types
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
 <20251028212052.200523-2-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-2-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: d0617f2d-09f2-4eee-6aca-08de182f89bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0J1SEo4TGwrM1hHUzIxSytLNTYyVm8raStrSytKN0ZVMjRpYWowcGpQYm5T?=
 =?utf-8?B?NEQ0STN6WGJRZlFsdVRJTEdaU2E1TVpyMnNvTDRUMXFSTHREZHlGcHYrQ01v?=
 =?utf-8?B?dzY3aGR3b2xNVDdrNE5VT3dRYktpQmlZYmJLQzF0ckR5MnprWnNBRi9jWkVZ?=
 =?utf-8?B?R3hVYm9MM0loWUZlNG1MVHhMMG9CNm0vRWg0NWh0OW9JaUhnM0NNZkFjaFVX?=
 =?utf-8?B?S3I4b1FQVUJpVENwQ2FBUmo0dUcrYzg1N1JsZVpmdm53RkhvbW9PdVVWMEtF?=
 =?utf-8?B?K2FSWU9rbnk2MlVxT3NUTFE5Zm9uakxHTHU3L1dwTEU1SVJSTVUwT1hCTkZX?=
 =?utf-8?B?SXgwNDZoWDdBNTFoYkFxM1hScml1VGlYeE1yb01ZS1NwakhlTVozMnhtV3M4?=
 =?utf-8?B?cnVOb2ZGY0ZlV09pRndGdE54akF3RGhHMkU2b2czdFQ3Y090ZWtiaWlIc2Zu?=
 =?utf-8?B?RWxwTERMYjUzbXZTczlRYWV1aHpPVE1tMThaelM5aDhYclNIVWc4NENJS1RV?=
 =?utf-8?B?VDRBczByR05CdGd1WGtja2hGS0pvZHhkQlpQU09aZ05iSXpxVWZkRlhxTnR0?=
 =?utf-8?B?cmZvQzlPQ3Q5YWdaekowSWM0MDJmNUk5cUZtZlRIMzBDc2RCYlZtc1lSNFZI?=
 =?utf-8?B?b3ppQ2pNZHBVR1E5dTZ1UDgySFB6TGhUOHBxRmpRQzJ5emhIdllRSi90WGtw?=
 =?utf-8?B?YXBaekRodjVVbm1pYWpxeUJrT29SakNlSStkQmUwOFRHSXJpN3I2SzFBbTFN?=
 =?utf-8?B?czJGQ2Q3MS8zdndlYkRCWjduUG04cFNmWWtzZzJ4NGlBM0NVUFFBYk53MUlp?=
 =?utf-8?B?cG5ZWEdNRW5DNzROUTZZbkZ5SEtjeUFZbVppRTRLemZpNkw1ZDlpV01JWXg1?=
 =?utf-8?B?NDhsK2Z1SHRKREx3ZnBSbndIWGg3ZXNsaURyNTRCb2dXVnRtTll4bjZWQmJE?=
 =?utf-8?B?WU9XRE1TUlFYWnA0TGIyRFI5NWkxbTNNVjNRcHRlMUwvbktzTHpDdTNRcDBT?=
 =?utf-8?B?a1prOC9FeTYxMUIwa0d6ZWVUMXlZUE1PUlFmQnZ3djVjVjZDdHd4eEU1Sld6?=
 =?utf-8?B?R0ZEQURhYlo4MG5pK0htdzR4b3AxbTBCQWtrSjkrUlBiZmVIZDlyNVRya0sz?=
 =?utf-8?B?eFNFUHNrd0VsaHRvTkRtRzhIZDhxeHZoYzliTXFYQXpNYzM3VTZicXlDNW96?=
 =?utf-8?B?NjNtZHlTQzErYzFDemRMWWRzMTQ0ZHh4YVlRS1dxdHdjbjhFWW5pWjZOcGVY?=
 =?utf-8?B?Vjk5SHJzVXFSYUNpNHNaUHBCa2plSFNkRnFTaU9penNLZXBwek1uNzVRTnVu?=
 =?utf-8?B?bUZWcVRaR0VOYzhXMG5KdzZxdDkrcWt5WEg3c0Fka1BFQlBKaCtsa3V5OTY1?=
 =?utf-8?B?b29pNEVpT1pEVzR4TTd2VUVncjJGUndGMUd6TlBaTERJUExNNnZoMkNSeUVs?=
 =?utf-8?B?NmwwbkR2cUxXYWlVZzlBVjZkdEczZE1FN2lyTGNCbEFBbTF1VXo0YklkSERY?=
 =?utf-8?B?NCtzVnRCOWQ3Y2RSNTBNeklqSG52WlNNdGFlcUJRamNzL2R6cUk3Y2hMdTdz?=
 =?utf-8?B?NTJyMEl4a0pnclF2eDVLVklVQzVNdUlNOUNXeFgyRjNGUGRoVlE3WkRjb20w?=
 =?utf-8?B?RUg5YVUzN0ZUaFlNY1pSQ3pRbFZZVFhBVnZXUmxZdk15QlgycE1VaEtEb1Yv?=
 =?utf-8?B?VlowVEg1NDI2QndhMVJ5MEVRT05YSGhPY2RLNWhmMytOSmJNRnpPOGpPSXRF?=
 =?utf-8?B?WmR4MWlSRTNCeldZYTdPTDFNZDFhSTZoV2w0aTA1V1h6V2thM2xodXo1c3Z2?=
 =?utf-8?B?cDd2VDRWWWJ1bTYyTjdydXpZbVYxYjIzZ3NNbmhncTBtWFN1M2pnSm5ZNXZT?=
 =?utf-8?B?Q3Z0cStnOWE2NkpWY3lJQXZuR0NhUVpNZ0cyUE8xQXBrYTEzZlVWNHY3RUtJ?=
 =?utf-8?B?ZElkYS85S1lsVzlyQUp0KzRGUWE2YStaSDZtSk84UGRxMEhpbFhZeHlUNTM2?=
 =?utf-8?Q?hecL1ajp+nfEKcr3e5UpFlWZZ85nak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejQxVUtTc2ZJNmV1b3dsa2xkejk0R1NqcXJMQ0NGVmd1TkpVekEwZDBLTlpu?=
 =?utf-8?B?Qm5YUS8vM1dTTCtRUkp6VnUvNnJaeUhqNERXa2VxYkJ6Sk5oVGFra08rNGFi?=
 =?utf-8?B?cHBDWW9Wd3duQVdScW1qN0NLNWtjNURrY28vV3BIY2pFTFIyVzM3MSs5TExH?=
 =?utf-8?B?RVBtUXZ5RnI1My9YSUR4blRyOFJJMjJacFFIWGFrVHFRQ2hkajFtUmZ2ZStY?=
 =?utf-8?B?U2xRU3dOYkhsdWVUeEphZFppVXhHUXVtbEdpV0g5U1NpaVdZY3Uzb2RGSWhh?=
 =?utf-8?B?Nk9CMk5QZWRGWGdyS245djRLMnVTd3VvRzBqVEtzQVJyR3NFVWpYcTlVTGdo?=
 =?utf-8?B?UC9ESGlTaHB4dlBsN0xBNHhiWSszYVNDNk5yK2FhVG5LMFJEWGQwdG5oRGti?=
 =?utf-8?B?QjVnSnhPSnRoUXRYVlVxeUI0Rmp1T3Y5Y0RlQlhPVDBxQW9JYkdWRFNCVkkw?=
 =?utf-8?B?cXlWZTQ2K3c3MXBmRHQwWFM5VVpWaDJtL0JBN1RnZnJDVDg3dkVoUzZ6eTQz?=
 =?utf-8?B?QitEb01ETlZhQlNENUZPUWtJeUZRMnE5TnFMTHlTbEpsZ3VPSnZsYnNBalRo?=
 =?utf-8?B?ZnlPU21rMWt6N0o3SnlzVWxVb3hJc3ZQYmpKeDYrSS81NDJFOUszQ0xaMGRK?=
 =?utf-8?B?TTQySjA1VFh5RHZER0lRYWZKRjV2NEw5cWZLUmNoQXFHMnJML1N6UXF0NTZC?=
 =?utf-8?B?cTk3dHNhalU2dlZzb0UyY2N3SFBGbjlRanliT2xJUlZ0YU50OE1KSGoydVZN?=
 =?utf-8?B?NURySExUZFp5Snk5ZnlTVUlxbTFTY3ZGbzJwYVBmVzltSnlwTklEU1NEb0Jr?=
 =?utf-8?B?UzhRN3M3Y1FmL2x4bVhxTGpMTjRQdDR4YXVYRlY1MlVka3VHUmJLUTRieTdO?=
 =?utf-8?B?Qnl2d1N5MlZTT2cwWmM4aVdCYTBUQXRkem94eUQyZVlaN2t4RnlFRXRhNWRQ?=
 =?utf-8?B?V3d3SVAyelVlRDJUY2ZObjlsVVBXdWRBTHBLT1hldUE4ZzFVZmJzRWlSOXlZ?=
 =?utf-8?B?VjkvM2xNcTZWWWpIb1NYMXFzemxCQzd6eHdlWE83SU1vbE1XcFNEblFQNFNu?=
 =?utf-8?B?MFd2Y1BIWnhGVFBzSHZlRjZQV0FGcEhSQUlqakI1RmZkeGlZU0xhZGduT3NK?=
 =?utf-8?B?OUpoSEFmOHIxM2xxSWR4V2hmQjFCZm42YUJoZE0wdUU5Zmk3YVRFdU80VUNM?=
 =?utf-8?B?aWwvckdRd3h2cG44TXljUU1tTXVGeDJYWmV0a0FDZHNsaXlkWEZ4cW1Jd1Bh?=
 =?utf-8?B?THF4WlllWUlrUUE1YUt0bC9Qcm1INnUyODRYU2NoNHd0dGFEdzBNUzJSSTFC?=
 =?utf-8?B?SjQzeEFGSS9vcjZKRVM2RCtxWnI0K3ZkVDFER1duSkhRQmU0UVJWOGk5M0kw?=
 =?utf-8?B?ZVUzZTVWRkw2TS9wOG5WeklxQnYyaUU4QXBWRmFjcmN5U095cTV3clZLejBa?=
 =?utf-8?B?Q0RWdUJIcE9KeHdYNXNJMEtpQ2JYVUpiS3YyZUxVbEFra3IySUtSVWluYnNZ?=
 =?utf-8?B?V092cXFlMFFHQnBQcHF5cWZGRDlZc2JSZTBmRFdSSERBcnBvS1Rla0RZL1RL?=
 =?utf-8?B?WHBPejZsRlh0eFU0aDNrSHc3SVlpMUhmYmVzaldUQWdobG9PdmZRSXBMKzZ0?=
 =?utf-8?B?QWd4SkRRTFR0Q1NBaEFjdnhwRXV5UmVZYllLQXNqTTJ2RFEwb09PcjNHeTZo?=
 =?utf-8?B?cVBZWnU1Nkg0eW1tWWlhN0ZUa3JsYytIOHgrWjAxT3BXdjRDdXdhUWRaenhV?=
 =?utf-8?B?TXpIMGF4RHhoTjdMc0ExazJKeDVMYTYwclhpcGFKRTdkWEx6My9FOFhSLzFG?=
 =?utf-8?B?QkhEdnREUFJUU2tCM0dET2Z3a1FWajdHbU8yVTJzT2dOc1lHN1ZPOVcrdFJI?=
 =?utf-8?B?cFIvb3ZaenJ1bHNLZmduNFNkWHY2Q3Z0ZzJleVBDZVlnZGRCMVYzc2ZRMU5Y?=
 =?utf-8?B?Si9BZ0U3S3o4R042bmNBLytWdkE5dVg5NTBFK0NmN203ZWd2OEUrckUvdWNw?=
 =?utf-8?B?dkx3bjdGbzl6YmVaMFVGWFM2YW1jeGh1dTJQVEV1ZTRxWHF6bTlUVVo1ZnEx?=
 =?utf-8?B?OFpqVk94aWFOSG40SWhFck9xWTBCVmNuaHNmSHRVTEJTS21vYXl5eUUyNWMr?=
 =?utf-8?B?cnlmdXNtczJZcDBZZFlZV1g3aGVST0piM0xGVHdvcll4ZDJveU5TdVpBVWt5?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0617f2d-09f2-4eee-6aca-08de182f89bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:42:38.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwVu+LGyaEP1NkYyMmp8S6ZgvZmkS8G8+1xdbNAdmMkCf5JyD+4lUoa2fO91yt5snm2Vmo6rpZIU2aNqFgpHBmC+W8OUuHc/HZSzVgwrAk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com

Hi Sagi,

Typo in subject: "so simplify" -> "to simplify"?

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index d3f3e455c031..310ec2b8afb7 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -209,6 +209,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
>  	shape;					\
>  })
>  
> +#define __VM_TYPE(__mode, __type)		\
> +({						\
> +	struct vm_shape shape = {		\
> +		.mode = (__mode),		\
> +		.type = (__type)		\
> +	};					\
> +						\
> +	shape;					\
> +})
> +
> +#define VM_TYPE(__type)				\
> +	__VM_TYPE(VM_MODE_DEFAULT, __type)
> +
> +

Avoid multiple blank lines.

Reinette


