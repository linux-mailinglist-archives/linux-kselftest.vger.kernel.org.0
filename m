Return-Path: <linux-kselftest+bounces-44487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC591C23383
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB64E0634
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB2284B26;
	Fri, 31 Oct 2025 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1kobWJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2317A2F0;
	Fri, 31 Oct 2025 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882895; cv=fail; b=jPub30OFUNF8/lbVXWAF0pa22FcO20II5bTiqCy+2VgdqEcVwJ49YgjgEluKDEVj4EKlE/e5cogZJ1GKJU/e9BJr10rh6vpUvpuKt0P0TjpKLGPuQLc9xnbNDSvdIXQzZ0PEKV5zQT+jtA9a7SlwlMdgY+J9hsTTod+1te6o5yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882895; c=relaxed/simple;
	bh=p31+zhyUWih2Vq9QUrdCJL8kOQfn2EdiqcX2WSYVhyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2WVcSkRriOK7Q5tgpxzPNa7mBqtUIJ+jlgquUJsTOI0grZk+obSvjyXbUdYAFaIo+Wn24p2Wc0yH2x7dxWOGmF4kbBUGiLimHXL/EsXi0WuHZUbiU4ygrmLRjAub220lvjsBDobhG0QkNiIyc6bHmI7CbigpL58rALSxXWBGEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1kobWJO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882894; x=1793418894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p31+zhyUWih2Vq9QUrdCJL8kOQfn2EdiqcX2WSYVhyU=;
  b=L1kobWJOdHrwgMcRG5zqgINn0di365SJ9PowUbvOYIEuepJhy98J3eax
   /7Le5pzQczvdMzJOBdwGL8c8WwjuOWflLEplh00+hOkeZR1GI7Ce+xLUc
   SjYUVHNOz3J8L/dnOQsCHV5i7W0fMnw2GQIjnWK8GLf6y0F8H+mH1NOPt
   Th/269n2AHfB//VG/v8SEidEMl+jl+3BC2YGvQ3TI3K1BzIhIluBFwqcd
   LfkGfFR9duMp3c77awV5wHpYrscnw4MUGWViMPOWyxpV7slgDctawzFZl
   zlZmw2Rq8XZYpN7P0lJjQQcV4zTikRaVullYOvgwcMdf1xihsmoebWWoD
   Q==;
X-CSE-ConnectionGUID: bGEYomdeSvKIToD1yf3H8w==
X-CSE-MsgGUID: AffcmjOjRDOI71Y1YbL8IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64187355"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64187355"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:54:53 -0700
X-CSE-ConnectionGUID: rzPNaOORTKKKT+YZNAoP9A==
X-CSE-MsgGUID: ktUV82kLQd6p9aiqk9L/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="190479539"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:54:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:54:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:54:52 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+DtsvxtvDdu9Cp/IPgPkbv/bx1flrkf82jJ1BwQXouyoC/cQ08LckM3DuSQ+0mQqxqwlXd2cAdtNOp22jGE+CO1BQNRnR3FU9Bvgo9Y5gCgJwWUhRUweJJ5oCqlZf8updCXgB6eyB1vt9dNyScVPTfQbyNRVL3VZLGaTCWTGFoQxL2q4VvEA6mbx+HjkJ9Z8n17/l0jKp1LCKvEQ8WLmdirjLGUH360SnFue2txdvwpd3s6IMrIcBds6OkG9LyatxQb6bWE2ymgsdOWjJMdFPl1MQDgjvSYb5tg5dXhOk9dkd8vryKcOaLCf6pxf7NHZUGZ4lWJWsbZ7c2QRkeJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtSrln4sT1dpAncJFeYx3CgHudWeqiV6fuD78R71NXc=;
 b=CO0BmnGW/SO8lni0YIDg5gGrZvTOpRBpqgfgEekftLUPEngklDBhdwfKUqy2Z3on37CcEjEbhltRuJWzWbb8XTfkD1gGYlJqHuvwrCxu41IFu/4ZH1RrlvO/h1oBGjeaeRriTpMY5+g7967SSfxVf2jfM0SU3LjPSHBcEgtrjR3yeOcnKZ6QgGyTW/+8Zx09SIa+bF4Q3fcJ7selI80yUI0WFbuKVMLVaR9BscrBRlnuJxHxKsbeIbOjecEyhNiF+ygiW5ZffN4RurJJMiNGlfWsE/qaEKT45u1jHGH4LC4ZiWAGlpYwKNvQxpKqPCHyCkRcWhVdMBtRczPv2407ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:54:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:54:44 +0000
Message-ID: <17e6c403-fdc7-4360-992d-a2dd47a22699@intel.com>
Date: Thu, 30 Oct 2025 20:54:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/23] KVM: selftests: Expose segment definitons to
 assembly files
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
 <20251028212052.200523-7-sagis@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20251028212052.200523-7-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3a8826-0c27-49d1-4491-08de18313a00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3NhVHBaTy8wTUdDWDUzUFlidUhmcXpQaEo2dGk5dnVSbUFBeXNDZWkzMFVD?=
 =?utf-8?B?SEFEbmo1S2l4dm9rdWdKZ0hscXUwMit5bmVLNzBnNU9UTGdQdXh5a3FobU5G?=
 =?utf-8?B?cTFYQWdXOXk4SGNzYkVBMGdndHQ5d3lReXJlWGRVZldEcGVtdXFzaUMxUFBI?=
 =?utf-8?B?OGFrOGdieG1yT3BnRUVPb0FUMndKeERTQUZpOWkxVHhXNm52UEY2NFNlL3FB?=
 =?utf-8?B?aUE3SnJKVlNBdnN3Q25DTitUWThxNHpKSkZwNUgzWWM5UVlkU05kaEcrR1hk?=
 =?utf-8?B?U2diWC9JZVMzVkw5YWZnMk8vNy9ISTlVV1pUSUJYa3JOTFM4Y2pxUG11bHJV?=
 =?utf-8?B?U1lPYS9Nb1Y5eUw1OC9ja245OGVjaFhIR21OU3phR0hOblkvc01kNE4xWGhk?=
 =?utf-8?B?MGZzV1BvOVdLeTNva1dDck9GYzFXNGphdmpWbVlQZ0p4QVdoUTVBZmw2YmZC?=
 =?utf-8?B?MitIS2NOT1hxSDlkSnN5QUNIR0xsYng4R3FnSkVDOTZhWVF3bjROYzA3b3B0?=
 =?utf-8?B?NEY4cDVObnprMFFVNk5Rb2hKd0JuTWZ4a256dXV3aldnTkJuN0duQVFsN1ZS?=
 =?utf-8?B?V2dMT2JTeEhLYVNiZ0hONll5TXAwbEszQ1lseXRsY1kxNndqRlpFS1orVVVU?=
 =?utf-8?B?UFNIWFhPTjhBMmZVcG92MWNxMEtubHNOd3ZBeEZZYy84M211d2FYMithQUww?=
 =?utf-8?B?dWVIaGtwUENXNFNjU1VwTHJWT09JWFFQNVRQNzlqVXYrVWw0cWIxb0N6S1pm?=
 =?utf-8?B?Qi9ZR3ZldjlBM2NFRHEvaFZkcGFDeDZiR3JlZjlOMGJYRnJrek9yVTVocnlB?=
 =?utf-8?B?dURQMDVnS1ZERDBjeWlxaVhzMUlhN3FTNDZkb25rc3BWYmFQWXk2RGVLbWRa?=
 =?utf-8?B?bUttR09OM3lBTGVOZUFUOExySFFYWDJmSGI3cFh4YjQ3SFYwRnlPZS95VUhO?=
 =?utf-8?B?UkM1ZjBLWU5hMDZhQTNVMHJDRWhqbkV6QWEvWkhJNWVjcmRWUWlLa2pkclZt?=
 =?utf-8?B?MlVJa0ozWDdnRDJ2VGVza0trN3dhU1pVSFZEdkQxTG1OcDYyWXBrWVUvY0N1?=
 =?utf-8?B?WmlvN0FURmUrQllETUdVUVEwd2pmL09hMkFCd09HM2pCZGpXNGFTK2tid0Mr?=
 =?utf-8?B?NUxIdklYRzY1d1RGdEV4V0tvTEsva1RDTUhRQnBKUEdLaW5ha1AxNEEyN1J5?=
 =?utf-8?B?bHcrcjBqUlRJcy9pU0hQU3NpeTFBK1lpYUczNlNJUjJtbGlhRjVpNDVUUHNS?=
 =?utf-8?B?RWdFcVJHY2d6Z0lxUlRvY21vUFlCSUp6ZFk4dkxzNjlCSUgxUkVQWEhjdzlF?=
 =?utf-8?B?WjJDREJsVjJwbUpYMDh3ZmJhNTFKeVlWcno2YmFpQWJESzdSN1VVOEpkckRO?=
 =?utf-8?B?NFduNjFtbWFPSWhnRGF2aVBvb2tTQVdOL3F5ZFQwRVhQUFdzWlZxVFVMNGlH?=
 =?utf-8?B?bkVMUitHKzdmV3g3blhZcVNvL2VrTmUrSkVkOFFqeVFjblJ6NWJjdjN4Z2k5?=
 =?utf-8?B?cFM5Lzl2ajJuT0hIMlNTcTNDemplRFZyRGlFc2pIYWFmZGVvbnppY3lRenYx?=
 =?utf-8?B?NUExTjFkWmlLMTZTcjJFc1RKZnYwempHdWprYW5mZTBmSmQ2RWhocklGek9j?=
 =?utf-8?B?YVFpbUlEMTZzMnd3ZThkb3ZBNWpDM2E5bnBWUkV6SHMxcDVjL09GZEFoWlFU?=
 =?utf-8?B?WU5tYXk2UlJmQTVVd2I3S09ZQ05uODExYjFGNnBSMHVSTmN5a2lYZTNWNmQy?=
 =?utf-8?B?NlN5ZjFSNDZyQVl5MmZtS1NkcjBuQVFPVlQ3eEVFQmZ3cWt3d29lUWtYYVJG?=
 =?utf-8?B?WmcvTzZzRFdBelIxZ2srbWNSbjJ6ekxBdzZjd0hiN0xnWjNnZWdPT2lVZEU2?=
 =?utf-8?B?QjdKVlpVbUMyQUhJYXlXLzhCbGpSa1RkL21wTXdzL0RZWW1HTDViNWtLS3BC?=
 =?utf-8?B?b0VUSG1IR2kxUUtHU01aMTJSVnpBQzF4K0h1d0hKOUF5VUtIQVVnakVwOG9y?=
 =?utf-8?Q?7tOrbbmJCSfdkDG1DftfW51dTTBu0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RNM1J0Q1dsc1ZhSmRVWmM3dWR0TXVQY2krTWVaWUVDaFBuVmQ0Umh5ZUJG?=
 =?utf-8?B?MitJcHhqdTh0WDRNMnFvK09sNE9WckRSVUxGa2FsbHBGc3JmeFE1STdmcUxX?=
 =?utf-8?B?MzB6bEg3cGF1NkI1ZFJZaWhoTnllZFozQ3JqeHdCRnI1MlREUWRwcC9BWnNB?=
 =?utf-8?B?VGw1eXRYQzA5cGdtZ0p4L3pyeVAvVFlXcGFFRHZuMWlDQ3lVc2xsNVh3SWx2?=
 =?utf-8?B?ZWtNamd3QW9XZ2ZFNWgyK2JyL0FDcG1jdlgzQkYxUVhiMDkrUFVEQ1N6dDda?=
 =?utf-8?B?UmpFamt4UTBkNXdGell0Tnp3bk9TSzAvY2NDKzhlTkRrc25aZUQxVDVkWTgz?=
 =?utf-8?B?cUxxcENCd3dNR1hmKzZLdm8rS2pSY2hmRkNCZS9Cc25XQ2QvOVN6eGl0bXNh?=
 =?utf-8?B?VzIzRS9LUmNGWnNia0NQbVAzUFZFTXNEV0h0S2dieS95SHpPUmdhWmVRRENO?=
 =?utf-8?B?RTMvNlkvaVg1U3Vyejg0c3Y0eFBUSW9xaEpVZlhyNGdCbHQwSERsMVJmdEFu?=
 =?utf-8?B?TTduZENHb2pYa3NqdXZYN2d6bzRXcE5lSDlySUtwa1VLemtQMEI5NEgxR01Q?=
 =?utf-8?B?R2JJUkpvbytncE9waUp3alRGMCtNcy9yTG8zZTloWW83NmZyRWd5SkFya1F3?=
 =?utf-8?B?TW1WdUt2RVNsVHdUWUE5N3l3Zk42Mjc0aDFlS3pRNmx4RENoV0RrMGxTSlQ3?=
 =?utf-8?B?YVlRbjBVUGpRSTA1ajdnNExBSVVwQVdSR0o2NDJOUHAvaU5uUEFUYXlzNUxR?=
 =?utf-8?B?RmtjVnY2Umd4bFkyRitPamU4M0VBREkralcrZERnaVNMenJLZm9tOWNZbmtr?=
 =?utf-8?B?V1BvSzBDZVV4cW82MEZvbXozQXBRZE1KK3B4Z1h1cjI0WjJwamRocjcrLzVY?=
 =?utf-8?B?LzhkbHcxT1ZVenB3djBtYjlWdHI3SWFwdExscTZHZXZ6aWplWHhiNkdNcldr?=
 =?utf-8?B?Sms3TVV3ZHNJbStoMUJIdlFnS3ZJTmtUaEZ0NFR2ZStEanBJTXBRQVlQYTdU?=
 =?utf-8?B?T0dmTmhWOUlWcitiZUV2eU9oSUN4VHJsZUZTZ0ZVeVJWUGcyUGR4TTlzYTZv?=
 =?utf-8?B?UmQxUHJ2TFA0ZVoxSkw4ZElPVk5HOWt2bElXZnMrNXdSSnZHamdnQm5UOVpC?=
 =?utf-8?B?Vmc1TVVkdGtrWHQyTjY5ampJWDhQL2tyY2NnTWlaeWl2RHQ3djlTRG1nUXgx?=
 =?utf-8?B?RGg0MWtaOERBbFI0UTdibys1eU5mYUc4cGIzZG5TZ2JPdmNzckNUTURUaUl0?=
 =?utf-8?B?RG5XT0JDQTZDeDZzb0VrSFRUdDB0ZlVCUk5yeWZWUVM1LzBGRjVKdDBaUHk1?=
 =?utf-8?B?Z3BoeDJycTU5S1J0NStTUndmUDZTenU1YkN4UWtVWS9vNzYrVkQ3L3o0WXlN?=
 =?utf-8?B?bUROTUUyYXhnWXNWTmdzQmFmb3dYanUzS2YxaTZtOCsyU0p1WnhuZ0duZ0pU?=
 =?utf-8?B?VFhiSzBCWk44OHE2QTgrVUIrYTlTdVZmN2ZudHdwYW1FeDFUSmZ5NFZRbkRE?=
 =?utf-8?B?ZGVuUUkvUjZVakovcHR1a3RxNUtKclN3cFJTd0FIQ0YvVStoblA3RXBiK2Rw?=
 =?utf-8?B?a3dFNHpBWk10VTJWNGVDU2hzcm9CRmxsdkluQnVxUys0ei9QOXJUWE5wYUJL?=
 =?utf-8?B?SENvQjlwaGdhdFFVbWl3MEFSR3FsamZNZ3JXUjhlS2VSUEVxTXlGZHpwSjBn?=
 =?utf-8?B?OXoyZlpqa0N5bmR6WHhvYjBDV3NMVHlvYk5GeXVvNnora3RHQ1k2VS9MYThC?=
 =?utf-8?B?eFhJajhYckhhSlpUTWlQeXh3OWcwbG9pemxSUCtkblh3dE1udEVnNzJFK0pm?=
 =?utf-8?B?dFZ3UkR6RVhwd083WFl5eVdnc2ZndUVkK0xwdk9XWWxTdVAxSWYrUFRyNU9O?=
 =?utf-8?B?YTFjdkk3SU1LaGpOYlFGNVdmcmtQbTIvaWU3S0c4ZVYvOHIwL3RjdnRwUU9r?=
 =?utf-8?B?RkMwN3NWTUVyWHlCQkI1ZytodnZJU1lkSko3QjRSMXFKdnNsL3BtZU5DazFx?=
 =?utf-8?B?aFlhZE10T0F0ZGpTUXNXQ1k0Q2xmc29JeFdENnJGWHJmeGovSjFlcEFVQ0U1?=
 =?utf-8?B?WEIvcWg5Wk9YdjZtN1lCU2tPMTNTWmFyV2tsVVBhL0JWbkRSU2JFbWNsTnZu?=
 =?utf-8?B?aGEycEpoTmRwYWc5RVhZMW90QVZUbU9zRFRRS0dEVkpvUEJyL3BLUE95TW1M?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3a8826-0c27-49d1-4491-08de18313a00
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:54:44.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjR5xObN+lbu0Fz9NJs/tZINeVHgDMmAnQF3icBL6rqX47GYYjBXf1yzXmzl0dysF3o9a7uNuquxNZfoenfaOwtxZ4m9+xYq5yDTNHrwh7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

Hi Sagi,

typo in subject: definitons -> definitions

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> Move kernel segment definitions to a separate file which can be included
> from assembly files.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/processor_asm.h        | 12 ++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c      |  5 +----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> new file mode 100644
> index 000000000000..7e5386a85ca8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Used for storing defines used by both processor.c and assembly code.

I recommend replacing "processor.c" with "c" ... having filenames in
headers become stale quite fast. "Used for storing" could also be dropped
to keep it brief.

> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
> +#define SELFTEST_KVM_PROCESSOR_ASM_H
> +
> +#define KERNEL_CS	0x8
> +#define KERNEL_DS	0x10
> +#define KERNEL_TSS	0x18
> +
> +#endif  // SELFTEST_KVM_PROCESSOR_ASM_H

(use /* ... */ ... please consider for whole series.)

Reinette

