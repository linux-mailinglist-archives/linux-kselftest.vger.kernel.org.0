Return-Path: <linux-kselftest+bounces-44489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB2DC233B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 05:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BCEC4E2275
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75C289811;
	Fri, 31 Oct 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJs2gxgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2338F50F;
	Fri, 31 Oct 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883317; cv=fail; b=V40pjGp6Bve1RqUTrQHRmUnxx/LMRRqJtbpnPEuic7X0K1+urKRTlPXrmw/4sZo7+9rDjN96jLhk82erRdpYDTkr49NK7WwjU1pSq9sG4LgCDZ4YaM4lqLSV0DyEhveW5TWDXcCMcYaNGRDfCWrTwV23CkOPn1bFsxypL3gRAyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883317; c=relaxed/simple;
	bh=5KHx3AFS+5JWjKSYo+uz9GK2BiQrakEUT70ZYOi16uY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlUXYXVuqbgIwheALYglZefYLM9zp22sDsW83VqKilqvd2Hni+Mgz3TQF/EXAQUtg9Yd6AUH4aWxRNk0wJinZHWOjvq7AIl6EZgy8yQdizniAia6nk4H0qVEInyyfHyTIBh2lI5VQyk0Z20jCK/cXDqYeI0n0b3tcRLOUbs+MZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJs2gxgZ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761883316; x=1793419316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KHx3AFS+5JWjKSYo+uz9GK2BiQrakEUT70ZYOi16uY=;
  b=FJs2gxgZcV6MC6BkT4AysH39pW7IYzqOAwGYyIZoBEZNwApfnyQcDX2G
   uSerPcFOiYY3EaPz0Txg+9Aw4WC/HU1CIV5rhoosc8dzaJSw8E7PnfL8i
   GxSDGIKtT3QtOa6h2emEGVOe/3FxwsK/0M3zkG5InxLpLwf7Ms2Ih3huA
   XQC3y4gMnI8BMCFTnlbPTU8YJAvwn7iMPlorjCvsmNDZwm1hZ/9nbrqyo
   NjFL2QGp9E0KxUiYcL0CKa2mI5U5d7rjVwfiJfyqbBkTj14AN38a9JFWk
   rhHxb9sUKr5ng7k2ajdvzKvDt/WVra4BevuLcT7qLArIA7XAUK0fV9lMr
   Q==;
X-CSE-ConnectionGUID: J3ovz5utT8e9nXLK6oqqnA==
X-CSE-MsgGUID: wSQPWwC4RqG10YQVS+YnRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75487492"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75487492"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 21:01:55 -0700
X-CSE-ConnectionGUID: J9EkIGgtQLmCZDG2sdHKaw==
X-CSE-MsgGUID: kKBWUHdXTBmsV46SJV3tOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="209696997"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 21:01:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 21:01:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 21:01:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 21:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5I9nMVfQL+gyRTat2FnztWe+L1eZ+TkJrmtzH7ZR1zKfDxwejZhM5OJPyM3Hhef+IGo2+dbHx6OfoctKgZPPR3VtQg0BBzd9cHM7oWVBmuMoG/uFMQhpL6SVEDlEwjU4z+nsIzZ1rlilHiKmMU64hE7193x9eDZFD8WQU+LJcfqagPag74ffKkTQIdo9FdisJvkHGdIDhrDfyGnjqowXWzOTsgYqjanYbAcg0U8KWuZ/kMe0CcBnYJB8J7OcpuZYYGiL7px8U20XlRcYsYNsf7q//NlYAZ3VEuEoK3rnVly2FR3YM/TyhQ04vZ/GsNUxrG6RidkMuHsdzXSfHvwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf1LRW3z/spwVygfFAZ19XeMk4D5h3Q8GFoNeqi/6vA=;
 b=bgOkB0v/r6bBnfBYFN8m5bQfevUh+5VqzuvVg5Ddl5NwNh+2rYEQV0loIJF8erIBbAjfXC8jCg0A5SCVUORJnHX7zAvlFvPBzQW4t8OKcRl09a1Z2OrSrPyLOzJ+tfsYvPIA6hLNLFGN8K/w8/yNlf8JwA6Md4ISpsxUccAc0ZyY1Cm2C3jnH54n0Av2pDeO6nCRcmHRstwxnHhUps5TKBZaRuVKxM2Dc4idRAL2qubOySIyAWBuhWGkKJ4xlEJKDudNexYj7ARmHnp8QXfKSrvgIY05VnkIPn1kuSFGr99m57sP9xe33P0+Yns3SkWtv+Dn0/ANuYOOXp2NOeFdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 04:01:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 04:01:51 +0000
Message-ID: <b472012a-8a37-442a-bbd8-72d05fde53c1@intel.com>
Date: Thu, 30 Oct 2025 21:01:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/23] KVM: selftests: Define structs to pass
 parameters to TDX boot code
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
 <20251028212052.200523-9-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-9-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8c8430-7647-4a7f-41bd-08de183238c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjhBWjFDMDFpekxtYllmMUhxRmd3YWlGdnZFeVpNeGVLUEFlaEhjK2gySHh1?=
 =?utf-8?B?OEp1d0YyQjJTUTVsRlRDR3dOZFZIczM3N2hrQVA0emFPTGp2N1h5ZUVxS1l0?=
 =?utf-8?B?VlhjVllrcG4rUzZMUDlDeHo1YThTaEIxeVN5SWljOVJYN1ZaT0JFL2trNDhS?=
 =?utf-8?B?bndkV3o3RHNKVjVDMjNLNEVrTmhQVlg3THI4aFl1WitwRFFjczRrZk5KN3Z2?=
 =?utf-8?B?dWZLQzBzaW9FL3BUWnRnZHpLWHhaaWlFK1hOZ3ZJU0xldENwVW05Rm1XQXd2?=
 =?utf-8?B?SXhKcjdFQ2ZEMFZHbGdpSlhLTDN0UjVNdEZ5Y2FUOWxPLy9xS1JjNEFFcm8x?=
 =?utf-8?B?RHBhTmlseHE2WXB4VWpra3dtWGdtb0hDMXJWNzcwRm5TZytnWE9pUUd3NkZG?=
 =?utf-8?B?dXowei9kV0xabGVQLzJsZEx5VUZJMmQ0QUt6bGw0d3d5cU0vc2N4VHk2eW84?=
 =?utf-8?B?T2YybGpPeStaWjVJQ1Q1M0tiZmlmazByQXRGL2FKeEdNaFdNaTJQM2JMb2xH?=
 =?utf-8?B?RW1pNXhMbjgxSFNOemszd1RIbzNvZjhnb1E2a2lLaGRDMTBxbGF4dm9JRlYz?=
 =?utf-8?B?c2N4SExsTGVzczFsVU10cEhBbU5HSlRZNjRVa3diWnlxdUJGUTE2T25YRmc1?=
 =?utf-8?B?V3MrMmg5RlJDbWNQbE42UFRoRnJJTHdtSDdBak1vUGxFM0t3TWFXWmNPWlJT?=
 =?utf-8?B?K3ZXMUg0RUx6K0VxMUozaWZpMzZmWFRFcTEyKzRrdTVzMUgzQm1EL2xIRW9m?=
 =?utf-8?B?RUxzU3hUdmhoZzV3WjVFSS9Pb2x0V0FkNXdySSt3SFpHU2lkb1FmTXJoeTE4?=
 =?utf-8?B?QmVyazZKSkFST0w1aXAvQzlnMmpWN3ZyVG9jclkvZVNuOVBuc3pLcmd0UnM4?=
 =?utf-8?B?cjJwZVRXK3Z6TlRnTXJkbTQyR3M1Q2x3bjgzRU5vT0JmeTNXSTZ4Vk1rZ1Vl?=
 =?utf-8?B?RDErQnhzWDFTbmZ0amdjRUZpRnNpZjlZb0o4OXhieVNtcXNnRzRJZ0JRemhz?=
 =?utf-8?B?aUpBUEZ1dTRBV3hnenBBZ3ArWUpKWnIzRVU0cjBFemU0S214TkRUVVpvWU81?=
 =?utf-8?B?c2psQU9ZdU1Sb2hiaXJwL09WUmY4bUgvUkV3TkExQTVnbUcvWmNsMm5EcS9K?=
 =?utf-8?B?Q3Y1OFdqQVRaUHJoWTdZQUV1VVRicTZnL1JSaTc3WFpoZEU5aWhUNTRxY3FY?=
 =?utf-8?B?VnlrRjRCZjlqVkcyQ2JkcnR6andMU2NlcU1LQUZQMWt5c3VlL1A4Qm9XbEU5?=
 =?utf-8?B?VW53K0dwSkNrYW9xUEpwcElXQmV6NHpKSkRYRndJQ1R4QmkzaDU0SmxqZDRX?=
 =?utf-8?B?dTZkbHhjZlZjMm9JT0FWaEZYemsyaDBFb3BiM1BrNkRWd29BN1BURDV5ak9J?=
 =?utf-8?B?Q0g3aUNHOGgvWXVTaStBNTdxL04yZHpCZDhldEkvdFQ0VzhWZ25FUDNNV014?=
 =?utf-8?B?b0xjN3ZRNmphL2g2U0VKb1pya0dkQlRjeGtPTThza0hYWEJmc2RiR2kwdjVC?=
 =?utf-8?B?RloxTkJtM0dzM3laWDA1R3dsRis1MGcvYlVmWEN5VVFnbkxvcjdRbmp6TEU2?=
 =?utf-8?B?TTh5bkprUVdGTTZjTHBvT0dCeHg1WmJJcENnSlhLaHYwVlpma1BwQ25xais5?=
 =?utf-8?B?OVFTQjUxVm9QWkY0eE1lVEl1SFpjWW9BQ1MzMzNlYmZnalo5dGNKTldHMVRa?=
 =?utf-8?B?OXMrb0taMzE4UU9jaTI0RHN3dCtXdVQ4V3pXOVlLUWQ0WWwyVnhycTUyNm0w?=
 =?utf-8?B?MDZDQUQ4SDF3V0hrMStEQkZuWHNxZnUxWDJkNy85MnN4emJnRmhkQklzS1Az?=
 =?utf-8?B?V2hXUlBPKzloakQwRnpzUHNPRUNCSDUwUnhSaHgyRWlHOGozWVJtempnaURR?=
 =?utf-8?B?TG1BV0c2QTZXbnFTNlFVQ0VhTFZKNElqYllWa0hHb0hobkxyZ1N1R0xZdk5n?=
 =?utf-8?B?eGtFYlpEK3JZTHJnN0JGRWo3V1RrMzA4QzJCYXdTWGV2Z1BmOG9HUG9pcnhl?=
 =?utf-8?Q?LBvbLKWW+5/uKeTo4pBP3m1TnmKBnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpGd0UwaytNZEFUMTYzZWo2RU5qblZ2NUV0d3d4K3E5ODhYa1VxTkJJaXgz?=
 =?utf-8?B?U0g3OG5ZS08xWDB1WldNekpYemdVY0VzQU5xSWJGVHVPWWVZK3Z6THlOSHVQ?=
 =?utf-8?B?eTdQd1lYY3YvSXJSaHdKd0hTMnBON2g1U2JPZ3VpcitBOVhVR3M3UUh0K0hB?=
 =?utf-8?B?MzNMUmJoYmphVDJUamhNdFZQZmdPckpGQ2JJNDl2UlgvYTZNa2FKdnJBOXVj?=
 =?utf-8?B?SEFYTGhoQmdCTC9rMkFkVFJ1MFFDbzBLWDB5bXhNeVQ0MHRubDdEdjZhL2s1?=
 =?utf-8?B?WElaaUlMUS9zaDdGZURJZE1pWHMyTFJlY1llYnVZYStVa3FhclNPT2NNODVQ?=
 =?utf-8?B?Nkd4d0MxQWkxUytrWklSSVpYcXlUSjB1QlhiZkJLYVErYSsvd2ZiWndrU1lH?=
 =?utf-8?B?N2JJZHBHT2VMY1J0UXZZeldmeEhnN1Z2SVhDYWhBR0o3WXVjRm4zdkUxcGps?=
 =?utf-8?B?dTg3Q1RqZEkyRHBrYjg4QTU0aEVmWm5mNFhxWG5weTVuM2xQOThDUlphTTJD?=
 =?utf-8?B?ZTUwSVRSTzlSZXJrZEZnSWFnRTJjQjBTOXlFVjlzckhTRlFiZ2xsL0ltSmR6?=
 =?utf-8?B?bjVudHZkOXRuMHBjbDVZbiszU2lyelpueXZHOEtBM2dHR2JGNjN1RDIva0dz?=
 =?utf-8?B?ZEJ3bTVRbFpDQ0hvUExNK3NIaXQ2UEVpZFU4dXZIejhuVVM0Vk1WUU1DMk1J?=
 =?utf-8?B?YjBuZ210REo0aEdqZDNRNkxIc2lFSGQ5Q09FQkFLM1pnOXYwRXVWR3N2VFZF?=
 =?utf-8?B?WWo1TnR2d0JubUM2c0FyT2xKZURhbzZmSUU5eURzYnlUUHNMZitRUng5eVZk?=
 =?utf-8?B?VzYrVzNRekk2NXNRVG1PVWRrOHVyRzhjREQycXFaYlR1L2JDZHhHNFJJUGFH?=
 =?utf-8?B?Vks5dDRueW9LK1FyMHZEZjk5UTcrcjc0aUp5cVdyZldaVGVsZEFweU1PbXhW?=
 =?utf-8?B?WTRGMmZBZWRyUHF4YnQ0QjRPa1dvU2ZUN0luZmFsUGY0U0RBbFp3WUdhS1Ri?=
 =?utf-8?B?ZFBlY3M2UWxMa0NkbFFGeDZpSWFYaGcreTR0UG0zOEVWWXgzdWlyVk9EcS9L?=
 =?utf-8?B?b3YxaDNjSXpDMmM4Q25IVXZ5RjNaeGVhaytEVG5Sbi8rbmFPR3dkajIyYmRp?=
 =?utf-8?B?cmE1Y0R6VjE4bnhMUlFZL3BwTGI3dDFvbkNyRXB4TmR3UXRDSXJxbkJCanJv?=
 =?utf-8?B?bjJKYTVNdlgzSjErVlNMQVdsTTFndEo2NmpVd2RyWlc2TFlJTGtDTHJhNU92?=
 =?utf-8?B?TkJKUVZiQmFPV2hMNVBMSU5OWFFsakwwUGJEWnFMM0ZlL3dnWXhMRjRMUTFO?=
 =?utf-8?B?ZVppelVMbC9GTmhOVkFKaFN6OG5qb3dIYXRmb1o4aFB5bTFFUklvM0g2aUpW?=
 =?utf-8?B?ZGlqR1pYaTk2bW4rVEJBRDZkVjYxdUpiZnFWOHovWDZCYXV4Q1ZzaW1PVG9z?=
 =?utf-8?B?Q1htbHBicmVvWXJINXRSTUlPMTkrZ1RsZTJ2QUVPalZzL1NvMGZwSFdiVTRq?=
 =?utf-8?B?eHdGMEp5Wlh6UmdPTUIzSzUwQk5PNXpGZ3YvZlpPeGJQalJXeC9ja2JtaHMw?=
 =?utf-8?B?cytNV2VtUHV3T1lrUDgzQldsSEpWdjhuVDlLS09FRGdNOC9JS0RyVldjc2Ra?=
 =?utf-8?B?eWNpUWpZZkl2UnkvVWxHVXlHRFFGU0pkNm0rS0pIRGlWK3V0c0ZwVFd1YXFy?=
 =?utf-8?B?dWc3VkdiSFA3SVB0d1QxcjNjMy93NDdQUWdoSStiamswOHlhUmtJWUhMTE1q?=
 =?utf-8?B?ZE8xTUh1WTgvVys5c2lNbzZzUTladzJYT3IzVUphemlRQk5STXNsT2RCMllG?=
 =?utf-8?B?Z29COXEzelM1Ynp2VTlyUEZYNlFveWVEK2wvTDByWWxPVFo0bU5WVy95aWJM?=
 =?utf-8?B?WU1EZ2NlbEE1cWxBWDA2TUdqemFxT2FVOHQzSFprM0dmdGFLenVyM3JlTG1i?=
 =?utf-8?B?RlQ5VVJubjlDNzlEdHc1K2psTFM4aGM2NjNQRGVIZXZrdUZPTTdQZ1MrdkNS?=
 =?utf-8?B?NGNLcENCZ3FxN0QyR3Yzb013a1N1akZDdDU1Z3V5Mm5Nc1BNaGc5QjZ5NHFn?=
 =?utf-8?B?ejBkeithQVhKRTByK0RrWU5iWXErN05UZ0tQY3JXcU1lYndYcHgzakxBK2ZK?=
 =?utf-8?B?T1VqVnBMdElxR0ZIRHk3MmVuRDFCbGtldHZDVk83T3grMVlKVnMxRTdQREVG?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8c8430-7647-4a7f-41bd-08de183238c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 04:01:51.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCHNA1PP6bDcC6mk2doINWumhgc62ZMdC/1MjIVwJX+X+ZU6s9Lf0gOydmZBKeDHa3VoALTAHbzbuN866GWd5sQHpR/PeNRSe7l2SLcXXy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com

Hi Sagi,

subject nit: Define -> Declare

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> TDX registers are inaccessible to KVM. Therefore we need a different

Avoid impersonating code by using "we".

> mechanism to load boot parameters for TDX code. TDX boot code will read
> the registers values from memory and set the registers manually.

Above seems to be a mix of context and summary of change. It looks like
the changelogs of this series need to be reworked to meet the KVM requirements
documented in "Changelog" section of  Documentation/process/maintainer-kvm-x86.rst
highlighted by Sean.

> 
> This patch defines the data structures used to communicate between c

Avoid using "this patch" - it is redundant.

> code and the TDX assembly boot code which will be added in a later
> patch.
> 
> Use kbuild.h to expose the offsets into the structs from c code to
> assembly code.

Reinette

