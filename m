Return-Path: <linux-kselftest+bounces-38950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CAB2606C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FB41CC6662
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D22E7BB8;
	Thu, 14 Aug 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCCyuMjd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1292E11BF;
	Thu, 14 Aug 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162298; cv=fail; b=oRo5qffYu3qCr1IvE4k3tuGKMNWYufHJ7OG8e5mfOC0Uw+tbGE6HSsmdPmKoNYLlxbxh/XIwFkB2Mp3cOzi94bpfUlc8lv+7kuqwveA3FHFq6WiiI2UrkjgtnXuMj4dqWkpQkg0VYRW1cKtRUeVv3J7E4QYF74o0koprdpvo378=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162298; c=relaxed/simple;
	bh=ob5jBy4tqP9ipg0WbdssIH1R9LZMnaWXoEg1KeFAnIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8vsdCBGZxrXea3ORnvMcFFFsXji7BS4wJHnQ57/SZ51i4e1TpYOucPxiU26q3Kpx4/6ixG46vBUZCAPvNZ5CmJH67dgILjo0aF4OrqAFBLxaKIn3Z9BCRB53MGzSIwZ+a1cTkLqygiC4Y5qGPTTmtYbDdkY6MkZU/4iV3s4sbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCCyuMjd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755162296; x=1786698296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ob5jBy4tqP9ipg0WbdssIH1R9LZMnaWXoEg1KeFAnIo=;
  b=mCCyuMjdsgLiAXGMG1U8aeKF/7Nk7Bz04zFWfY8meHlUricoVWnBiU6M
   zDHvC0cm9P3cKEGVQI1wh6i7aOwlMQqClfn3f4lz9nAI3+F1Fk9+1+66f
   54WEWPjlvyBf+FUDqQ0KhG2NZ81/GU0cx8NbvtWhvZ58HdO2ebYCDw59g
   oG06MCMVzJr9YjX8Vu7ID6dgs18jkyKibHCpzT21fEHmnCRYP7AS53VKA
   Us448s9ywSlxlxOjm+WVFn5W6Ch5/xRgjfTBwcdQjiNXFP+bpigEhbxZL
   yhuTCAf1jo6RRbSAUmmPGwHl+Hqm0TSTE1QIGNPtQofaPslGFrTrSxpDA
   A==;
X-CSE-ConnectionGUID: SnGvHgI4SCSM2HInd/U6qw==
X-CSE-MsgGUID: jOuqwWq6Rl2zlabbPZoaFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="45050470"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45050470"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:04:55 -0700
X-CSE-ConnectionGUID: iWVlkljwRYyn8J+sDdXCiw==
X-CSE-MsgGUID: JM1rvWjdQtSJ/ffoiCBRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166972509"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:04:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:04:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 02:04:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/hjgBwIRcyioSQHh33roFE4OMPIhPy2+AluOzP2QvKA3wB3yvbS6t9/Ik1NNXWju5vGjCC4lNyfcxYtBDfV2jx8xOiVfWrma5es8ILOGIDKPFDh2Noqy/LJIwyFx9L/PEs0ZAb44fPquRymgirCkroTXZFgM8S3NfD9Bi2BIPq6zczr6G/LagI9h83sPVmLPUkBYerhQPttt6gRMaA1DWDAEdmdDjxE0ho1m02TKXS6ul1WLF/pw5r+T4xHENJxNRVdtUzYHkMNWmfODTk0ytnG8AMZkizarTr/b9s5oZOB9KXQh32bO6nooTaKS7lOCn3KT6MiUKH5OJjKUI4WQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9iD3FHAW63wmc44foEelXIHbuMKEM86Xow3CnNuwg8=;
 b=n/XLskatqnXaBIBU2A7hk6dLlxNIvU/aNJORMbnkQpnfFAPh8QIS5FxYrVcnChGnDCflAo7BwZuCC+2cTAatmJ4B0bwVgUp5NlxZU6AG8txkScJ1ZFRLJ0OAWZr8qUZaJA9AIhGKNHdc+zeGANLo5ndlCmtC2w4VwZbvIgi89FPGAN3iUQLIt4oce7gvCo0WT9WVi0QJoEUTmtIvSDuOC3hFbWTdp3Uf3se1naG/InFhuo4LMTYgYo79Y01fRFuVlOWquS9+2XGo4IKV7bRttb/CTKs5YCI6t2Gj8OnwXVmLCWEGn2Q/7yfgQIOTFjwcBhrYyQG6JouL57VxaGoKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 09:04:51 +0000
Received: from CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb]) by CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:04:51 +0000
Message-ID: <e0d0aa8b-7844-43dc-913d-ea0f302d3feb@intel.com>
Date: Thu, 14 Aug 2025 17:04:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/30] KVM: selftests: TDX: Add TDG.VP.INFO test
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
 <20250807201628.1185915-23-sagis@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250807201628.1185915-23-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To CYXPR11MB8729.namprd11.prod.outlook.com
 (2603:10b6:930:dc::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR11MB8729:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed0c756-1be2-4ed3-5aeb-08dddb11a05d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3JMbWtuMEVlZWdMbXRTclJoZ1BYRm83RDU4a0VpOTdYd3V3eS91cVRIVzFo?=
 =?utf-8?B?RXlqNHlxQUdSNHdFSzAwRGkxWDh0YWxWVEV2QTFkNytqeU5leHNMREVqSGg1?=
 =?utf-8?B?QVdqa1Vsbm5admk0WmVzOXVDMWJEeForMG5xd2p1dUVFdWZpV0RVeEFXWE5W?=
 =?utf-8?B?TFg5eXhlRkpPd2UrOHc1ZmZmd1ZYNnBoeEdaYUFZQjRGa1I3dDZvTDZxRTEz?=
 =?utf-8?B?STc1N3RYRHVPYXFuT2RxZ25kblI5UzJTQUp6UVhuL2MzbXp4K1gyYTY0QnpR?=
 =?utf-8?B?VjFEWEVNR3BiODZrZEtteXovdkRIVVRkZ09BOVYrUVQwVEJJQ2xUb0s3UU5M?=
 =?utf-8?B?Y1NDTmVJUXJmWDJtU0tGY3QxMW00N3NRTEoxMy9jOXFZMnQ0TWNJN080eTF0?=
 =?utf-8?B?enNTU1dyRjVSZWtXZVpCQ09JSldyQnB2N3JteFdza2JaYS9xc011a0JtaW9M?=
 =?utf-8?B?aHU3YUp4Ny8vWXdtUGlyeHp1L2dBcGRTc1hXZVEzUmlwR2VZYk05dE1QT2g3?=
 =?utf-8?B?Z1d5OGFKK1YvaEp6N3owV1ZQQmZndGtkU2kzQkVIOU5ycU5Uc2JVU0swSURO?=
 =?utf-8?B?eUlLYmkrN3BCRlIrWVpyUEMrYzBveFczeDlydHA0Z213eTJWVHY0a1hxbDhO?=
 =?utf-8?B?bzRCVGVsK28ySm1TY1RLR1dwVE1NS3Uybmt3cG4zc1J1TTN2N21QQmtGSld4?=
 =?utf-8?B?SVN5ZzhqdGdnS3YyOUxNMmx6T2JkNVRMRVNpWWpsSTlmeHBCK0tEZk0vZSs4?=
 =?utf-8?B?NWU2OEJjZ3VZY1VEQ1h2WEpFRU5OVmZ2RkZhWVYvTzYvZjU4ZVdad0FQbHV4?=
 =?utf-8?B?d3lqbUpYWkprNkNKOVRpNjJQc3Fqc0JSSXB1MU9SSUQwcm00YUgrOXFObklP?=
 =?utf-8?B?N01CenJiS1FBV3N4RjhxUGJybHZEZVVRaWcrZXZYK0lCWDh1TzZHTlZYcnRm?=
 =?utf-8?B?d0JVb1VuQmVac3lvejNWM0xUSVhsL3VkRHo4Qm5kU2ZlWVdPeDFGMjQ3WlVG?=
 =?utf-8?B?WkVBeXpML3BtUXd1UDhERGpHQitiZXJid25wSGU5a0ZUWHlBR2ZyRlJ2NTk4?=
 =?utf-8?B?NlFXWHpseHFidzZBZ3FTWGFLOEFlMjFGQkZ3aTR2NGYxWkJmb0xaRlU4RW45?=
 =?utf-8?B?cldOUFJabWYzUUlaSkVIQk9EemNYVHF6T3pKNnQ4YU9TKzF1VUZxcStDNUNZ?=
 =?utf-8?B?bGx4aGJTY2FGMFhrREwrTEttV0pBc3ZyaUloY1k3clZJZ044d0V2eElzVXpO?=
 =?utf-8?B?WVkzSythZEQ4dVlENVR4WmxWdTVvQkRibUt2b05sZS81UzVqaG9HL2tFbFp0?=
 =?utf-8?B?SjJBbVprcVN0N0F0eUZnaURJS250c1JQL2x1dFlGWkMvS0pCVStubmlwNkRl?=
 =?utf-8?B?RnUrQUI4STd6UzFWb0xYM0xVeTZSK0h0dnZ6bTRVQXZSZk5wazZ3NndkSmha?=
 =?utf-8?B?OG1jOXVyR05qQ1FnM1FpQ05Nb1RtK1lIN2hNZ1FRRzlDbEdFMm5YM1cvaDNV?=
 =?utf-8?B?N0NjLytTUjg1OFBwbUcyaEc0NmV6ajFGd0llaUYvTlZ6Zlc1dHVQK09IQnR3?=
 =?utf-8?B?cXM0UlpaQnNPZlhzY1p3YlRXQUhWYjVWalNZTHdTcWFvc3lSbWlXbzFPNzVk?=
 =?utf-8?B?MC9lelJXZVNZUU5tR1hBam9JNWwrNXBDdXlTMnhCdXRPRm81OXRnWllMT1dy?=
 =?utf-8?B?MGhKWTBPa0VYWk5OdVh3WDFDTUovUEsvRjJpV0hCTTEzTVBuL3UxSm1VTDNP?=
 =?utf-8?B?R3oyTjFlUjZnNjhpYWNrQWtCZURaaENFLzI3dDFUR1ZBVGdrWHErc2FrUDVV?=
 =?utf-8?B?ZVczYlpWb0psVUZPTXpTc0s3ak5wSFd2aTBRRzA4Q0RGeE41bkgra0VjRGhC?=
 =?utf-8?B?MTRVNGhXbVBWZGpYdmIxa3QvanhYczFoWVBibXowOUdPaXlMN2ZSbUhaRC9q?=
 =?utf-8?B?SGI3K3FKSVRrajIvZGFaMXdRUkRpamdLSFFNbkpFS2dJUlc0OUpKdFVBM3pN?=
 =?utf-8?B?QVZCYm15TlBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR11MB8729.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJDdlV1MytGS2xUbm8zNDU3NHZRbzJjS2FQWE9sckUzYis5WTVPMU9PZEZK?=
 =?utf-8?B?TCszNUw2aitmSlpRM2F5bGJTa09yMkpxSzUyWk1CYXRkcDlSb05iVi80aDZZ?=
 =?utf-8?B?RXBiM05wdUhWY2Z3WUNLemU2ZmJ6aGw3NitBd0Jxb1BBdHR6ZWxJQlFKbGU3?=
 =?utf-8?B?UEtoWWdwNmpEeVlYUUgrSFk4V0RuQ1d3Y0NCT05mTzJxMTNwNUJsRVB3Q285?=
 =?utf-8?B?NUk0RjJFT09Vb2lLdjdiZWUyNXdaZVYzMTd6NGZ2RWpiMEFibXJ4Vjd6THd1?=
 =?utf-8?B?TktOT0xEKy9kaDFwTjB3TGFQYzNKUEQzaGVnSjFhZUIwQzk3MHRNYWppU0w5?=
 =?utf-8?B?SDdySzNJMVlZcTJNaEtaT0NDK3lTSS9yanZKQnFNSmNiMnVuK2VucElzUXk4?=
 =?utf-8?B?UmtsZDYzaGFXK2JZa3RzMWl4STRaYXIva1FGSXYrc1hrL0RSeFpMNzMwMUhu?=
 =?utf-8?B?bkVPWENWQktoZ2kzMXlBaCsrUmJCTUZMbTBtL1VuZDhYZzFsYzM2MDVCbUw3?=
 =?utf-8?B?Z1RoSmJNNzdpVXJDWnlyTXY5VDdNcU5sUlJicmdBWTlTS0NpdjBaS2N4SlRq?=
 =?utf-8?B?aUlHUS9ObGxUTklEVFQwV2VYS2NFOURxNFVHTUJoV0R1SXhyY2dJdEUvOTlX?=
 =?utf-8?B?dmlFMjk4SWZ4MWZURnJzOHNOU2poUCtXNzVQN1lxQlV3NDRiRGRHUDFuQVNq?=
 =?utf-8?B?UFJoK2pFUzdWY0I5MzYxU2ljUy9RSWhqMUx5RU1SOUZuL2VGV0d1ZW43ZGFX?=
 =?utf-8?B?Qjk3US9YTDRUMkFwT1ByN0hMVUFnVUtjL3ArYlhPeGE2VEk0Ty9oSHQ3cXRt?=
 =?utf-8?B?ZDNmRk5JNWxINTRad0pMRCtLcVhlTE9LT2RWRmU2T0doR0RwblR0YzdtMWs0?=
 =?utf-8?B?SzZFVUxlUWM3MG9kcjhLWlBnVU1OMUlvQVBJaG54OXNia3hkdU96ZEY0UGQ1?=
 =?utf-8?B?UzBDOU1zZzlLbEVjcXc5cmMrZVFnSDJpTEp6c0VhTERyclNwSmk2a0hUNk1V?=
 =?utf-8?B?VVU3QldSNHg1aGd5ZmhnWlBvbTNSV1F6bTlQNHdiR0RVM0NMVVFyZlMvTlNm?=
 =?utf-8?B?NDhKSkFzNmduK2RwMmwwYzZqVVBYZ2xHMzN6Wjg0dzlMOE5UMXYyOUlRL3Zv?=
 =?utf-8?B?STFGcDNWNEkwVVo5U1BvazFoc0x4cGFHaHhZSGxFanU2dGRCdHpYSHVHTUNz?=
 =?utf-8?B?Ynh3YTlOMHhJK1d2TVBzN1A2TWZGSlhzMi9QUWZmMUpxSkVmTEoxWElWeVp5?=
 =?utf-8?B?Y2Nna0lRNm5OS1QzOHorVVkzNTVOdGxSMk5ZMG41SXZGUVZJY3NwYU93cUVr?=
 =?utf-8?B?bDVCTTQ0YjRrYjViMWRNZFlzVHFuUUtWOWhhUlN1VjVCQ2F5dkZJdldJaWhV?=
 =?utf-8?B?a2I2WnhwTzZYaVE1Rjd0dWRJaTFPbTZUYU1uazAvNU5pd2xmOTN0MXZKdEJp?=
 =?utf-8?B?cU12ZFF6T2xVVEFxbVJ5TVpBb3hvbU04cFlleUxZbU50RU9WNE51WjJLNXNR?=
 =?utf-8?B?T0ZldzE0VDBpR0s2QVpPVlM1akxvTVJKRU5ycy9GRFI4T1h6ek13bFRqRGhk?=
 =?utf-8?B?OThSTHFha1pzMmQyN0MxTy9QSGcrSjN4YzBCOTNtaFY1ZkJIZldtTUlKcWNB?=
 =?utf-8?B?RS9RaVJKRDlsaWlPZG9uNzlsa3VONzVYVXRTd1M4cW1yUmR6dTR2TjlrdGxj?=
 =?utf-8?B?UUp2WlBhUWNSeEw4ZXYvNnpKQmFYRi9seUVnWFA3UG5iVm54a0FSYzRmcStU?=
 =?utf-8?B?MHB0L21pMmJmcXp0R0FQU3BVbEo4cTFmUHpQRzR6bnkvZVBKQ0sxWmZSYjZL?=
 =?utf-8?B?MW52cFFWNWg2ZU1EOE94eWpBWEl1S0NqSE50NGo3T0xRa1VqeHFiMWE0RDdq?=
 =?utf-8?B?VlNhS0p1MGI4dHN1TDEwSmhDc2JkUXd4MFIzVmVmcUoxQ0lweUwvcEIzWWxC?=
 =?utf-8?B?TWpMUkRjSUFEbGwrSjlmZm9zUjdrcHZrbUZpUjEwVmk1bHMwWlRkdFBRdkNn?=
 =?utf-8?B?THpxWC93OFRraGJyQmRYTlBZN0hVTmNjMnorRzNzQm9VQm0vRW5xanF0czJR?=
 =?utf-8?B?VDNuZHV0dVdDNnIxaFVTVHpUY2syUmxqcVIwV0trYjZmSnVCQ1pMaXZnU1kz?=
 =?utf-8?B?ekZWajFyQ2N4REFCczZJc2h3aWpDenhRVXZyTXh5bzRKdExVWlJBbHkybUtN?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed0c756-1be2-4ed3-5aeb-08dddb11a05d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:04:51.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmsZVmBSUDH81K3XwtPNxkgDY4FfYgMFoRDEZ4q64+/2o/gu9qtWhAe8GLsPzWertu/14Ym9mTFNq1qPeAzlaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Roger Wang <runanwang@google.com>
> 
> Adds a test for TDG.VP.INFO.
> 
> Introduce __tdx_module_call() that does needed shuffling from function
> parameters to registers used by the TDCALL instruction that is used by the
> guest to communicate with the TDX module. The first function parameter is
> the leaf number indicating which guest side function should be run, for
> example, TDG.VP.INFO.
> 
> The guest uses new __tdx_module_call() to call TDG.VP.INFO to obtain TDX
> TD execution environment information from the TDX module. All returned
> registers are passed back to the host that verifies values for
> correctness.
> 
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Roger Wang <runanwang@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Duplicated SOB. Please change the order according to submmitting-patches.rst.
And check the whole series for such SOB issue.

> ---
>  .../selftests/kvm/include/x86/tdx/tdcall.h    |  19 +++
>  .../selftests/kvm/include/x86/tdx/tdx.h       |   5 +
>  .../selftests/kvm/lib/x86/tdx/tdcall.S        |  68 +++++++++
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  27 ++++
>  tools/testing/selftests/kvm/x86/tdx_vm_test.c | 133 +++++++++++++++++-
>  5 files changed, 251 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
> index e7440f7fe259..ab1a97a82fa9 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
> @@ -32,4 +32,23 @@ struct tdx_hypercall_args {
>  /* Used to request services from the VMM */
>  u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
>  
> +/*
> + * Used to gather the output registers values of the TDCALL and SEAMCALL

This series only uses this struct to gather values for TDCALL. Please remove
the "SEAMCALL" for accuracy.

> + * instructions when requesting services from the TDX module.
> + *
> + * This is a software only structure and not part of the TDX module/VMM ABI.
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};
> +
> +/* Used to communicate with the TDX module */
> +u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +		      struct tdx_module_output *out);
> +
>  #endif // SELFTESTS_TDX_TDCALL_H
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index 060158cb046b..801ca879664e 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -6,6 +6,8 @@
>  
>  #include "kvm_util.h"
>  
> +#define TDG_VP_INFO 1
> +
>  #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
>  #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>  
> @@ -31,5 +33,8 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
>  uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
>  					 uint32_t *ret_eax, uint32_t *ret_ebx,
>  					 uint32_t *ret_ecx, uint32_t *ret_edx);
> +uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
> +		     uint64_t *r8, uint64_t *r9,
> +		     uint64_t *r10, uint64_t *r11);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
> index b10769d1d557..c393a0fb35be 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
> @@ -91,5 +91,73 @@ __tdx_hypercall:
>  	pop %rbp
>  	ret
>  
> +#define TDX_MODULE_rcx 0 /* offsetof(struct tdx_module_output, rcx) */
> +#define TDX_MODULE_rdx 8 /* offsetof(struct tdx_module_output, rdx) */
> +#define TDX_MODULE_r8 16 /* offsetof(struct tdx_module_output, r8) */
> +#define TDX_MODULE_r9 24 /* offsetof(struct tdx_module_output, r9) */
> +#define TDX_MODULE_r10 32 /* offsetof(struct tdx_module_output, r10) */
> +#define TDX_MODULE_r11 40 /* offsetof(struct tdx_module_output, r11) */
> +
> +.globl __tdx_module_call
> +.type __tdx_module_call, @function
> +__tdx_module_call:
> +	/* Set up stack frame */
> +	push %rbp
> +	movq %rsp, %rbp
> +
> +	/* Callee-saved, so preserve it */
> +	push %r12
> +
> +	/*
> +	 * Push output pointer to stack.
> +	 * After the operation, it will be fetched into R12 register.
> +	 */
> +	push %r9
> +
> +	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
> +	/* Move Leaf ID to RAX */
> +	mov %rdi, %rax
> +	/* Move input 4 to R9 */
> +	mov %r8,  %r9
> +	/* Move input 3 to R8 */
> +	mov %rcx, %r8
> +	/* Move input 1 to RCX */
> +	mov %rsi, %rcx
> +	/* Leave input param 2 in RDX */
> +
> +	tdcall
> +
> +	/*
> +	 * Fetch output pointer from stack to R12 (It is used
> +	 * as temporary storage)
> +	 */
> +	pop %r12
> +
> +	/*
> +	 * Since this macro can be invoked with NULL as an output pointer,
> +	 * check if caller provided an output struct before storing output
> +	 * registers.
> +	 *
> +	 * Update output registers, even if the call failed (RAX != 0).
> +	 * Other registers may contain details of the failure.
> +	 */
> +	test %r12, %r12
> +	jz .Lno_output_struct
> +
> +	/* Copy result registers to output struct: */
> +	movq %rcx, TDX_MODULE_rcx(%r12)
> +	movq %rdx, TDX_MODULE_rdx(%r12)
> +	movq %r8,  TDX_MODULE_r8(%r12)
> +	movq %r9,  TDX_MODULE_r9(%r12)
> +	movq %r10, TDX_MODULE_r10(%r12)
> +	movq %r11, TDX_MODULE_r11(%r12)
> +
> +.Lno_output_struct:
> +	/* Restore the state of R12 register */
> +	pop %r12
> +
> +	pop %rbp
> +	ret
> +
>  /* Disable executable stack */
>  .section .note.GNU-stack,"",%progbits
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> index fb391483d2fa..ab6fd3d7ae4b 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -162,3 +162,30 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
>  
>  	return ret;
>  }
> +
> +uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
> +		     uint64_t *r8, uint64_t *r9,
> +		     uint64_t *r10, uint64_t *r11)
> +{
> +	struct tdx_module_output out;
> +	uint64_t ret;
> +
> +	memset(&out, 0, sizeof(struct tdx_module_output));
> +
> +	ret = __tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
> +
> +	if (rcx)
> +		*rcx = out.rcx;
> +	if (rdx)
> +		*rdx = out.rdx;
> +	if (r8)
> +		*r8 = out.r8;
> +	if (r9)
> +		*r9 = out.r9;
> +	if (r10)
> +		*r10 = out.r10;
> +	if (r11)
> +		*r11 = out.r11;
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index b6ef0348746c..82acc17a66ab 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -1038,6 +1038,135 @@ void verify_host_reading_private_mem(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +/*
> + * Do a TDG.VP.INFO call from the guest
> + */
> +void guest_tdcall_vp_info(void)
> +{
> +	uint64_t rcx, rdx, r8, r9, r10, r11;
> +	uint64_t err;
> +
> +	err = tdg_vp_info(&rcx, &rdx, &r8, &r9, &r10, &r11);
> +	tdx_assert_error(err);
> +
> +	/* return values to user space host */
> +	err = tdx_test_report_64bit_to_user_space(rcx);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(rdx);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r8);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r9);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r10);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r11);
> +	tdx_assert_error(err);
> +
> +	tdx_test_success();
> +}
> +
> +/*
> + * TDG.VP.INFO call from the guest. Verify the right values are returned
> + */
> +void verify_tdcall_vp_info(void)
> +{
> +	const struct kvm_cpuid_entry2 *cpuid_entry;
> +	uint32_t ret_num_vcpus, ret_max_vcpus;
> +	uint64_t rcx, rdx, r8, r9, r10, r11;
> +	const int num_vcpus = 2;
> +	struct kvm_vcpu *vcpus[num_vcpus];
> +	uint64_t attributes;
> +	struct kvm_vm *vm;
> +	int gpa_bits = -1;
> +	uint32_t i;
> +
> +	vm = td_create();
> +
> +#define TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT	BIT(28)
> +	/* Setting attributes parameter used by TDH.MNG.INIT to 0x10000000 */
> +	attributes = TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT;
> +
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, attributes);
> +
> +	for (i = 0; i < num_vcpus; i++)
> +		vcpus[i] = td_vcpu_add(vm, i, guest_tdcall_vp_info);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying TDG.VP.INFO call:\n");
> +
> +	/* Get KVM CPUIDs for reference */
> +
> +	for (i = 0; i < num_vcpus; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i];
> +
> +		cpuid_entry = vcpu_get_cpuid_entry(vcpu, 0x80000008);
> +		TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
> +		gpa_bits = (cpuid_entry->eax & GENMASK(23, 16)) >> 16;
> +		TEST_ASSERT_EQ((1UL << (gpa_bits - 1)), tdx_s_bit);
> +
> +		/* Wait for guest to report rcx value */
> +		tdx_run(vcpu);
> +		rcx = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report rdx value */
> +		tdx_run(vcpu);
> +		rdx = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r8 value */
> +		tdx_run(vcpu);
> +		r8 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r9 value */
> +		tdx_run(vcpu);
> +		r9 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r10 value */
> +		tdx_run(vcpu);
> +		r10 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r11 value */
> +		tdx_run(vcpu);
> +		r11 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		ret_num_vcpus = r8 & 0xFFFFFFFF;
> +		ret_max_vcpus = (r8 >> 32) & 0xFFFFFFFF;
> +
> +		/* first bits 5:0 of rcx represent the GPAW */
> +		TEST_ASSERT_EQ(rcx & 0x3F, gpa_bits);
> +		/* next 63:6 bits of rcx is reserved and must be 0 */
> +		TEST_ASSERT_EQ(rcx >> 6, 0);
> +		TEST_ASSERT_EQ(rdx, attributes);
> +		TEST_ASSERT_EQ(ret_num_vcpus, num_vcpus);
> +		TEST_ASSERT_EQ(ret_max_vcpus, vm_check_cap(vm, KVM_CAP_MAX_VCPUS));
> +		/* VCPU_INDEX = i */
> +		TEST_ASSERT_EQ(r9, i);

The format for r9 is
- 31:0
   VCPU_INDEX
- 62:32
   Reserved to 0

Maybe add the check for reserved bits as other registers


