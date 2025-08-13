Return-Path: <linux-kselftest+bounces-38859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34FB24C5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E190172566
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5432D8DAA;
	Wed, 13 Aug 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BG/FvpEX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616781A23A0;
	Wed, 13 Aug 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096162; cv=fail; b=mGGvwid3u9M59tU6I4SrV91ZXkvzA+qyjd709kx7ttVSzAezlFjf59z8hkFrzJpQsvhPgI32QxzDMQAjr+YOMUiKDwqacnDLZ90L3I+u0x1CPdJw7FZ2SpTCKiNN60n/Je7KTbOA1SL+VrSH/XoLNWhzzPmNsy28doYJszQ45WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096162; c=relaxed/simple;
	bh=xkkJvRVLCZRwYWK2Q1mpMr93YhsEGoQLUksP6ywfxhE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGalLy+VV08lVZHfQwsuZWS+/EwGfZP/1VAl0BWjE2SnPQKlyPM8jKw5HQyz+qhHnGMlNFZ+gfxTuaY/gYV2NrKa+vv6ki+MLcO7bj25CZgTmnmcD6lF8+B4j66gaxbA0VueVyqEEAy+LPhTSJttDmr+pM22e+duoWy2bSauHuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BG/FvpEX; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755096161; x=1786632161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xkkJvRVLCZRwYWK2Q1mpMr93YhsEGoQLUksP6ywfxhE=;
  b=BG/FvpEX/K4UdZS7uaDHHQ6LXjOHfTBpdrQeqW4SYKw231kKaB2SWezM
   84DXryn+QIdu+aJPLec8yyiSYVcMZK9OviygxZbXHycn+EwJ/X/cMNqup
   Ygu6DC6LQjSq3u3hQ3Vf+6qROkzTKOG/T5wj045cDZD82HTWxIY7Wht7t
   9cRrlt3qZhCYIT3a8bIdhQGTF8jDDhfjt7V55s64Rx7LVDUV35kWv6Fnf
   l9DKKn0Acywlx0DrHSENncWjCqDMIj9wgKv/dvN9YVo1tF2a+GXkQvdto
   44XCtrpQAnH1WTstfO+x8vBpFmNyeFw80if3z4px/5Hw482IUOR+p1xMp
   A==;
X-CSE-ConnectionGUID: 4QohncRvTliJwC3BMiYaHA==
X-CSE-MsgGUID: n/pvDXFLQE2AaUK2/4nhOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79966444"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="79966444"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:42:40 -0700
X-CSE-ConnectionGUID: WauQqCpTTXK0R20/mbagcA==
X-CSE-MsgGUID: BfnGSA1uRyyjhAT4RUgVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="190196228"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:42:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 07:42:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 07:42:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.74)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 07:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1TvXy+4YuZ5Xu5NSoRMEaLbNcLv692Z93TnXKMXJVFwo2KSs2uTLlPujXbyZ/y+BfEU5t7J7DNOTD/rG/kanPtqamoWPr+h/GFiVgO+N175z8bkrA4gAH6s16eoROko1g8m8dn1/A59i5TAkBmmysdz+lV4r2i9ELoKpBumeVqUhWO4LN7Tf6hHSGxxaYd2SXRxjtT3TB/r5d5AEugc5rzv5biZs1l8TJPrQvgMQ03RgLkjGRiZKMbvuPyw3xkcuuynSi+YezERneFEP3OzS4JpaokIYAacBJO7U3Zv4M2jgITPfwDBUy+kYb5cWkyS33RWME0FZYP1I/iuH60b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmGIms5MYfnExMXci2pczuRl82BplXknWWTN1QOsmBw=;
 b=kjwl0DV6eXRAJKAIvXsG7Wg3Q75ZPoMW5tZlmPtHQUT+tya2Q+bbCUr9ABCOm5w7kTIf0JzCLjRos89wx8swQQR4h2z/0rGG/6LC/P/5Qqf3pzpzuH1nb5pF+O5OVH/qadJ+BwW0Yd08Mfese7+IjnOTHjaKfE0bo7wV6Mw+HUp/gXJ25WN5h7nZ9+tpe9vhafDFiV0lqm2bWMimVlP1+bzBCI6UydPM0iq1HxxVx4UwpzllGWsJczh9H2efb+cdE/ZAGnCmHaHKYqBd2fLqtP7TS8hX0ZdTSr8i2jjHpnJYZ9ONcxH4ZP4EpG/kiK8Cb9SVYRODOu4aiZfF9YmAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 14:42:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:42:36 +0000
Message-ID: <bec79c4a-499d-4f82-bfea-05746d4085e9@intel.com>
Date: Wed, 13 Aug 2025 07:42:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/30] KVM: selftests: TDX: Update
 load_td_memory_region() for VM memory backed by guest memfd
To: Binbin Wu <binbin.wu@linux.intel.com>, Sean Christopherson
	<seanjc@google.com>, Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, "Ryan
 Afranji" <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, "Pratik R.
 Sampat" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-9-sagis@google.com> <aJpTMVV-F0z8iyb4@google.com>
 <4b938a0a-a4ef-42c9-aef5-c931f2ad8aa0@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4b938a0a-a4ef-42c9-aef5-c931f2ad8aa0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a36a2f9-fb3c-4689-abb9-08ddda77a526
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1RIRDE0UUVCVzFBb0xhWDhzb05VL1lUMXNsZDNaakZoN1Q5MGorcE5uQXlp?=
 =?utf-8?B?RTZNR2FDQ1lyanNNTDIrSkdUSDRkQ2Z6U1diMEsyNHcvWDN5cW5RQlIwODl6?=
 =?utf-8?B?djQrVkpHb1pWTTJyS2pScFJHNFY5Lys1SEZZR2Rkb3VrcXlNMWIwQk5hQnFS?=
 =?utf-8?B?aEJ4LzNjRkM0eEYwZUx6cUd3c3JPZkdGa3NyQ1NyNEdZQXZsUmdDL3BtNHpQ?=
 =?utf-8?B?ZWlZQVhJYytXTzhSdG1WcEhOQ3FrdjV3WnVsNVlJcXFLd1I1RjNaRWRyV3li?=
 =?utf-8?B?RzRSNHVJZE9OdmVBZkx3S2VGMXQvMzlUamN6dXhRcEFBZHpjeU45ZkJzS21X?=
 =?utf-8?B?R09iLzByOFF5eWppWTczanlzbDUzTVJaQ1VMWkVaUDg1NkVLdVMyWWRuVGlq?=
 =?utf-8?B?cmlNazdMTWRUdFdYZUpkdDdJZUczd0RnNTRzQ2dKY1pkK1ViMFo0ZnJqVThR?=
 =?utf-8?B?cXVBak43NFRNQy9MWnFLQWplVUpDQzhxaFZyWGNyNFkyazdjN04xUXM5MjNK?=
 =?utf-8?B?RldoR3E0Ky8xc3pKdlA2VGFiY0Jsb2NocjFnL0xOOGlDSkQ1YS9aQUVnSjdX?=
 =?utf-8?B?NnBBd2hkQmE1end0VDg1UnFLVWpia2FzT3c3d1VhK0pZUC9YcnZrU0x1WnRT?=
 =?utf-8?B?QkhzYld0ZEF4aGFXd1JiY3gzcWQrZzJ0S0JadlVZblNHSk1aaUNuMVRYWWlo?=
 =?utf-8?B?K1dpY0lmcy9nL2RmWjVPSTZGRDFMb1JIVVFUeWlJcUZzS2tqQ2hOdFl5b29I?=
 =?utf-8?B?cklPeDI2RFlBWlJHUG1NRVpCWGhadCtEamZnQlBYZFRLVHZkNlc5NHUxNFZw?=
 =?utf-8?B?dXp3NzlGcUszd0R3WmdnTnNTLzI0Ukh2cmhGd0hUL1VRQkJmbVJLVSt4djEx?=
 =?utf-8?B?SkxqOC9QOHNkMjN2NFY1K2s5N0pZMmVqVEUvdHVRNWtMRG0rSlM5YzlqTFlr?=
 =?utf-8?B?Tlk1UzBlQmpRWitianQyRlcrN28rNmZ1Rk8ycm93ZHVrSC9NWkFpWnBDQTVv?=
 =?utf-8?B?L1ByZThTK1pBT3VlYTBMTVZibFIxKzNkTHJxb09sSG8rbDJtTTR3OHJmTXA0?=
 =?utf-8?B?U3VDZkJDeW5yQjFyYkJXSUNsalBQUWJEeitsbkl5Tk1KQ0M5ZDdpZWd5eVdP?=
 =?utf-8?B?bVYvbVpMMlZFUk9UMno2TGpTcCt1RnFFUHV0dDhPWEIwUVowRU1CSi9nQnFF?=
 =?utf-8?B?N1JSZWZEVXZma3p6M3NHVUllSFFnOW5SRU90SUhMejhjWUZObjBOb3Q3V0Vt?=
 =?utf-8?B?U2dtWFRmdjM5ekUrdW9qS1lSNWtheVoxQzBaeUZPdk95Mjk0c1hldEQ3SFFF?=
 =?utf-8?B?QkRCSk5SNnJmdm1paTFjc3BvTzJFajdKS2c3VVIvTnFhTVJOd2FGc0J3enR2?=
 =?utf-8?B?UVF3WVZmUnl2aEdMOWJDV3lwQkcvaVVMTUtRSytyRldyVDJMM0NoOEhnWHpi?=
 =?utf-8?B?SXRIcVFuSVVXaTUwTWJIeVVqTXBTNFkwQncyVnBubi9nM1ZuN1lVVWExN1Y1?=
 =?utf-8?B?bVYyL0VXSTYxYUgwRkdaZEhTd1ZvdDRudlhKRmNXTU9MVkJPMFhsNjR6eHVS?=
 =?utf-8?B?eDB1OHhUbE1ZdjlqTnIzSDNoVW44eDY3R3lkRnRudytDVHZ2M0JsUWo5ZmlL?=
 =?utf-8?B?YURacXJrVGdBdlVQdUVCanYrQ2k4ZHJZNllNK3hPaVVuOFBwb3BqMDF2TXFx?=
 =?utf-8?B?N0xRUVF2OHM0WVpkSUwwM3A1cGZOMmpkZ1NPaFVwZ0xwNFJKU21LNHZjYklY?=
 =?utf-8?B?S21UaGhqWG0vWnlyazQwMktWaTRzYVJhRUNiZ3E0bTgzbWJRRkVmUnZoZ2Fp?=
 =?utf-8?B?NnZ3dE1xc3FlZFZTbUJuRnBzV25ValpSeWFiTHNTRi80bkRDeFNsdTNGbENa?=
 =?utf-8?B?VWoxd25zVVZHLytZVDdNS0l5STBxRDllN0RYNFhPaHhpeXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhyT1hpZm1aWHhwQngvSFFhT2J4bXZPSDVkcVltUS9lNGpIblZ0NmpuT294?=
 =?utf-8?B?RlA2b2ZaN0hla2xHM1ZRL0RHUkQxeGo3b1hCcnFreGZGN3EzYWs3ZzMyQmxO?=
 =?utf-8?B?WkxRNVFPWFpxWDg3R1QvSTlCOHNlcU1ITDh3d1g0bkNsbkpydk9WTUhEOGpH?=
 =?utf-8?B?ZFRKL2lHR214V0lhYzI2Z1h6bFBwUHh0SzRZZy9JTE1la0locTRmM013bngz?=
 =?utf-8?B?ZUkvdUJFV1hyL1NIV0hVWDRyYzdkekhJeFdhRHdmWDRPQUVBeGo1MTdISGV4?=
 =?utf-8?B?N0FjdXc3VVhxWXZObDN1VENHSnZKSFNqbmZQK3Fla0daUVBYVjhvSWQ2OWpW?=
 =?utf-8?B?Si92ZGhNWmIvcnhlS1lNM05xb2dva0JZQzM1KzdjZ1I5VTA1REdqZjQzZEE3?=
 =?utf-8?B?RjV6Wk9FeUpRUUsxeVp3d3RONUtySUhsVWdDRjFHVjdjNTR2SHVDNkFCeUZP?=
 =?utf-8?B?N05mS0lOSy85OFV1OFQ0cFFrZTNJSTB1cE9QVFFRTnhyeEdYVEF2dkRoMVc4?=
 =?utf-8?B?YTd3QTFkTE5LT2NBZTZRNGQ4WVM2Y25BcG8yeHpXak9rakNwUDhDNEg5ckJI?=
 =?utf-8?B?N0s5SUhpM3hXSWx3eFF2cVNqL1Vxd3lram5ndTVVTG01S1RCM0lSL2pCN3FX?=
 =?utf-8?B?T0J5RFhYNmhhWHRMMnpxU3ExK2hXSU5qSW1PcmVFNTJUaWs4am5OVnVnK1dk?=
 =?utf-8?B?RExFWUo3cklOOHhpU2lzaVdxSEUzTG9sSnQ4WnUzNExrWDlFVDBrN25TY1p6?=
 =?utf-8?B?VE9kNURhcHNIYXltNjNua3NJa1BWeWk4N3FVQW1QeVQzdWlKbG5BWFV6NzBn?=
 =?utf-8?B?VmFzR1QxbXdweTdwZFBLaUZTZHltaWdqaUJhSnNTcTNSZGU4TlhNaE1Lb2VL?=
 =?utf-8?B?N3dlV0l3ZGRRK0lBNExxdnByYnIydmdOWVREVGIzdEJFaFlNVzdFRUhEU09z?=
 =?utf-8?B?S0FDV0ZlUjlYazNsOXpkc1VaYXZUejM1eVlHVXM1SGpFME1iUjJEYlRmbXJH?=
 =?utf-8?B?Q1ByNkVmcnZiMG5odWVhR2kxWmFlQ2tzM3N4WTJ5aGRRVU13RVhIUHNMWGp1?=
 =?utf-8?B?R3lBVTBNbThjcFg3ZkM2b29YR2ZxMmxQYkNnb1dpekhpMU9JSlgxQjh2b0Fi?=
 =?utf-8?B?a0RRMGllRlJzcnNiaHdjc3lyTk8waVQ3NHRVb3p6Rjl4R05OWndjNlc1NVRP?=
 =?utf-8?B?SlBxMXB1dVYyUkhOVWxqbzNUWGZ0VWI5VWlhSTZhRmJYQWVsTXJ0ZHJXRUdM?=
 =?utf-8?B?d0xKS2tBSElqY0JGYnd3UXFyTUtMS3c4YVRNancyRzJDWmhQbmI3QmVPR3Fa?=
 =?utf-8?B?TGRYWFM0bXcrVG1ydzNtOHhzVnZIYU94a0NPR1hqTWdDRnRKc2dNdDFIVDRX?=
 =?utf-8?B?K2hueFlyUWJEcHBIcFFiY2tLdWN5RXlqYWtUQTNmQzEzbUtrZURqdEgvWEgr?=
 =?utf-8?B?S2k5d2xGVVRSend3R2xtOTJ4UnpiTHhub1Q2bXlZNlRsaFlwUFRoZmFZcjlP?=
 =?utf-8?B?TC9QQlhRSGQvTkJMSnA2WHREZ25adkxXKyt0NC9tZjA2dW1SYUo0ZWRaZkVR?=
 =?utf-8?B?RHZuUXVnU3RQZUlrS2MyRVBwWTNXYzZyaytmSlhCVnFOYnVpYk8yS1FuR21R?=
 =?utf-8?B?Q3pRbzBPc0FYa01VcWJqZGJVOWlONVVmS3VRRm9JQVVjQkMxWDB0aWJZRHNr?=
 =?utf-8?B?NXMyNXcwRnd6S25ubXdvVFVYZ1JtaTMvRlYwMWUydlVGM0Y2TTVMOTRXekZq?=
 =?utf-8?B?bGI0aHVTbjZhSW8xSUFBN0dmRWV4aktVMHNWRmRsb0hnRTVSdW02S2lMejNL?=
 =?utf-8?B?T0FTZ2w5d3E5aGpTNFljaUJ6TW80QjRmNU9CUlovdEYvdW5Gdnc0bUZlTzhq?=
 =?utf-8?B?bytqQWhPTktpaXFvbWJaUHFzYW1sWHdhOXhVK3ZHU3dVaXRtb3pJSlBVYVgv?=
 =?utf-8?B?Y05TaDczVWQ2Ym5mai9EVy9nRmVDUEhHdmVsSjVoOU14MzdtTFY1VHhLMEJE?=
 =?utf-8?B?SGFMOHNaRUZobFdONFhnV0JrQ0tzOTNRTUpHOUZUUXR4U2Mvc1lrWTlsSHhR?=
 =?utf-8?B?TXJpYTFJNytyOFpidjJqck9GYy9MSzlCamxTMWpBOTdjSldCNnR4RjRKQmx0?=
 =?utf-8?B?eXpoWkVDREE3UUNUZkZueXZQSlhOSGpiUzJXR1BIZDJ3WkFtdGptWUdNSWRq?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a36a2f9-fb3c-4689-abb9-08ddda77a526
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:42:36.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaAgTOv27eb3xRB+xq2UgBTP7pgG4Atpv7xQ5x3XUL1k+BKRVWh8O5WlzcjRNaGrTvWR/GrfOdbEkSiWB9kP1yfJW0FtAnElesZc61Knb5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com

Hi Binbin,

On 8/13/25 2:23 AM, Binbin Wu wrote:
> 
> 
> On 8/12/2025 4:31 AM, Sean Christopherson wrote:
>> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> [...]
>>> +
>>>   /*
>>>    * TD creation/setup/finalization
>>>    */
>>> @@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
>>>       if (!sparsebit_any_set(pages))
>>>           return;
>>>   +    if (region->region.guest_memfd != -1)
>>> +        register_encrypted_memory_region(vm, region);
>>> +
>>>       sparsebit_for_each_set_range(pages, i, j) {
>>>           const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>>>           const uint64_t offset =
>>>               (i - lowest_page_in_region) * vm->page_size;
>>>           const uint64_t hva = hva_base + offset;
>>>           const uint64_t gpa = gpa_base + offset;
>>> -        void *source_addr;
>>> +        void *source_addr = (void *)hva;
>>>             /*
>>>            * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
>>>            * Make a copy if there's only one backing memory source.
>>>            */
>>> -        source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
>>> -                   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> -        TEST_ASSERT(source_addr,
>>> -                "Could not allocate memory for loading memory region");
>>> -
>>> -        memcpy(source_addr, (void *)hva, size_to_load);
>>> +        if (region->region.guest_memfd == -1) {
>> Oh, here's the "if".
> 
> Is it still possible for "region->region.guest_memfd == -1" case?
> KVM_TDX_INIT_MEM_REGION can only work with guest memfd, right?
> 
This is still used and supports test "KVM: selftests: TDX: Test
LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD memslot" found in patch #30 that
was created to support the issue encountered when QEMU attaches an emulated
VGA device to a TD. More details available in the fix:
fbb4adadea55 ("KVM: x86: Make cpu_dirty_log_size a per-VM value")

Reinette

