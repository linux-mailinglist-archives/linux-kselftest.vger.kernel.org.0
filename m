Return-Path: <linux-kselftest+bounces-44363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE9C1DA2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 00:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56C1403885
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B12E6CD4;
	Wed, 29 Oct 2025 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5gr0QeH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E71D5147;
	Wed, 29 Oct 2025 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778920; cv=fail; b=r8ty3Zvjsw22msT7D4suIGtXzlVVKfU7JXhFlPNoK+rFRe5Oqwj+VIcGqXR1PQoGB5c0nnkxFQ/Sy+7vSiH6zxWCI34m6nvg8C5i/OKpM9vHZvzlPSMoQCPN1FssUh8nLpVoYtSV2WDTLDyqHp/5kzyCpiLT8pkj5bgK4mhkOkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778920; c=relaxed/simple;
	bh=HKb13JV0tG/aJDyMLY6jBsA9ebCrFqujdskaKtlRS1E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qz9A9ZYnQjC6X40i9p3VoHQHfg1m0DwIQl0osA8GBbE0sXAXsQHVRnNLyAf9w1wpIIbUV/p6NdkUcI2ERROq2RYHt38c1dTnI+8x6lx8exIN/gezBXx8tCBSHFtp0z/YOIMZHVsIyfpphFGonAqF4ESuRyHyPh7o0RzL8QrXvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5gr0QeH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761778919; x=1793314919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HKb13JV0tG/aJDyMLY6jBsA9ebCrFqujdskaKtlRS1E=;
  b=a5gr0QeHt8JtaSGPBxPRkdu1Mb63tCe13ADA4DBKI2Bjgw5WusRGgWqX
   MwnPvMQz/0YMhwJbxUj3wrzP1+3adU+wpDXV1kSDrvyRxeNCq2mwC/eCp
   Hgpv06YS/DyJpFthR4gZgdUTxgHFcv1utTPkpLY7Ajvn4UEkJ0AhjcC4d
   KJ5HKeJAydGVKdI7mnluxhNpsYP8nPNGeHVcID204DKU9PClX8zh6Hg7J
   v75B9JIiAkHL1HY52lB4x5YeEHT+CMiI4LQCGkqoUzSp0sobvtEa5lYNS
   EO9iKHor7vCNBimhA3MwXVrJ9LpoKlN+yRcg+BNImIrdpWrk2YOl1qrS0
   Q==;
X-CSE-ConnectionGUID: XgESGgpOT3C+DPqFg1HCvA==
X-CSE-MsgGUID: sGDJvzyMSvGN7tBSRpou1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64062180"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64062180"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:01:58 -0700
X-CSE-ConnectionGUID: VkUUlzi9QlCeMKwniwcghA==
X-CSE-MsgGUID: PhomRnReTPaQqz+Je0EPCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185488733"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:01:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:01:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 16:01:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYgN1VukQ17DAGIgBT2IX8a6Xj/bDpFftLMy6wBbLn5z2MT5dlw+jxCB7sGCUkOgTMTdz0X4Mf0bcAf6HsphND+xsvYzTqSlvd9qmSvjBS9UfL0Dn/EpAFpghmiXB8XFeE0gB1k0Fiabd3gN5C/G25WbaWJhDo85i1DTrS6p9v710syguf1+Ekimy13KGf4G4z7rBzfXidVSpQxPlA/CSA68ymWpHyhuJpF2lAgFGx1+8R2tTGuzwKNldG23ZElLeLVjEjGvKw2dVDttpRDrRtt6uiVtJzIPU61pn79MJezInAS24Rn5a0zqg5JHdylUoVk1WSQDMwRBCW9iO5NGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeTfzcRj95s3XyVBYZJ9ewr03d/VxMRSDb2SFBo4dGs=;
 b=wwpxAGZ9ft7wGJAQNihjU71YVzpupitN4nZvdKN9JqIWLq92h5MiAreDXAz27qah2I3VqB03MPY71XvrQObdgiq3nJcZd/k2L88tXz3I5ekaj2dnKWrQCydoEY0m4U4EyQmeERBiIdR9dNK3OMpdxxv3fk4fy/uvB+SP3TEbAUPvFso8IKL3wi05+vy5u4m7+acPDhLoWsHAEBJDs84A3DU+iCkMOiOjrpncAxQyUuL68vqjOqNaI91pblBA7hmQnW/b/3voDNvz/iQB7IgnZwxB2c/6o1lMUyHKp7Ap5tV4fXMZOuJmYY0lqVvIdQl9ySlGaqEex7UgVews4OwO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 23:01:49 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%5]) with mapi id 15.20.9228.015; Wed, 29 Oct 2025
 23:01:49 +0000
Message-ID: <c08af988-45c7-4b8d-a4b4-ffb20736e2be@intel.com>
Date: Wed, 29 Oct 2025 16:01:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/23] KVM: selftests: Add helper to initialize TDX VM
To: Ira Weiny <ira.weiny@intel.com>, Sagi Shahar <sagis@google.com>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Shuah Khan" <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, "Erdem Aktas" <erdemaktas@google.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-13-sagis@google.com>
 <6902844729ad2_21ab5210055@iweiny-mobl.notmuch>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6902844729ad2_21ab5210055@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e9c6b7-aa0f-4349-038d-08de173f2475
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzFhblcwRHB1RlgrUUxjWjc1VDFUUG8zQmRIanE2MnpUZWFHTG9ERm52ZFNM?=
 =?utf-8?B?S05TVE1XYlFrV2JKdTc1MGp5WjRWenQ4UkRwM0dDeVRJbFUvWENpanBsV3JO?=
 =?utf-8?B?ejZzYUFmU3JYRUJWMWZNS0ZFcENpSkVWeENZZm9pOFM0aStORHFrMzBvM0pu?=
 =?utf-8?B?TUxQTW5mOURERmw0RjBLUFNpSWFiOEl4NnRpVGVIanJyblYrU2ZIcnlQMUtL?=
 =?utf-8?B?cVJKeEg5S1ErdkZ4dGZDNklxTTBYVHlrWXRWSXUvMU9MekdJMm53MUVvejkv?=
 =?utf-8?B?VGNNcHRBQTltT1h3TExONjd5SnlhRHRsUHJCYXRPYXBWbmFUbEZlc2c4Tmph?=
 =?utf-8?B?V0Q5aVFFcXFaQ0NoRzQrZm5CY3YwTkFkKy8ySWxaeFZCYjBueGtmczVpMmtN?=
 =?utf-8?B?REw4QzJBbjFHdlhzLzRtU3IxZVNZeEJzZFVkMng5TVJWeDJmazZrRVNlZHV5?=
 =?utf-8?B?Y25UWTIrVm1EYTYvaGJ1Y1dQaUptLzJEVWd4WTRlb2M4YWxyOFpObG9ZT1Zu?=
 =?utf-8?B?cWJHS0JRbklVT3pZMFcvZDFwR1l3N2Y2UlY0elQzUDFCT0RhZjVWdmdiV285?=
 =?utf-8?B?dGUvbGRCSVZrZnFwWHlaNmplZm9COTFMUk1XSllkQ3JOVk4xL3NHbXNrZWNt?=
 =?utf-8?B?UFRCaktwY2pSR0NpYkYzeG1VMjhqTkpqV3BTS3RjYVFEb3BuUjFJQStvbm81?=
 =?utf-8?B?R0lGeE8waUpYTlF2RTlUUXFvZTg2RXFkcEhKZEtNaHBJbktzbE5sb1JaWTZI?=
 =?utf-8?B?TEdYbjMxNW1KNFpERFByL1Ard2xEbGFXY3h5a2VRZStOcHZ2UkJqNWJ4d09R?=
 =?utf-8?B?UGt4ZytaWGh0ZFA3dk9qSmpRdjhFdm50UHdIVDZJMFJvNmtTUFo5NXNvMkJY?=
 =?utf-8?B?Vkcrc0FidVlkMnVLOFF5N21ZZlY0bTRSbWJyeVd1VklPZFJCMG83bFhxNjlS?=
 =?utf-8?B?MDA3ckRFVlE5T3JERjR3SkcyLzU2QWVPV2UrNXNWVnRQQ25CY2piUUJHRWtU?=
 =?utf-8?B?cVpjUk9yZDUwZWR0cTVDRUpJS0l4TUJpbG03b2d3N0pBSStpM3M2S3J5QkV3?=
 =?utf-8?B?SE9nVlJmdnJpZnNoMTRxTGUrNkxFa3JzL3ZJSnlodlNJdThQaVpoZ1ZibU81?=
 =?utf-8?B?cjlpeFNPMzU4d1QyejdQSzJyK3JNYW43QnBydHJxZlVEcTNjTHVmdkplOE1R?=
 =?utf-8?B?c0xLS0lDaUc1ZjRxUHd3WlBGZS9vVGdiZ01BUmhsamtZUDdNVFI5cGoya2RP?=
 =?utf-8?B?R0lQVEl2a3MwbGhGZ3VkdEdhUnBteVNJMXYrajA5MW1sRkVYK3dpRW5xb0c4?=
 =?utf-8?B?bE1yeitTUTl2ajhaVVkyUEhFZXRqbWh1eXVDZ3hMRjR0ZGhFcUZ3ZzZFYzRo?=
 =?utf-8?B?S2xucm9uclBrL0dsQ2FIV0hmd1NFY3dKSjY3SHRJWUdGL01ieVBsZ1N2QU1I?=
 =?utf-8?B?ZDZZbm9TRmdBU1FBZVMrdW4rQnBrQ0hFUnFXd3JTRzRzMFZ5eERPQno3Z0lT?=
 =?utf-8?B?WDNwN1Iyb2twMmtSTUtaZjdiaXE1Mk9QMUdaQjlIa28wV2gwdllxZnVoRUNt?=
 =?utf-8?B?SUVvNmFqZFA1eG8zbmptdWgzVnZqYVVNWEk4UGZHM0tmRFlSbENsT1pxbWF1?=
 =?utf-8?B?ZjZlTXdsa2lwVjcrVkpzUzdGRGtVTHVocnlYUlVIbW5HMUdjcjlEMHh3Y0p0?=
 =?utf-8?B?ZnFnSjNYTUNtWG1DS0k1em1peSt6dU5MampOeUtnRkhYOXRmRXJvZ0cvS1NP?=
 =?utf-8?B?bDV2b1U5djhqUDIxRVZuc2phOTdBYlljblUvcHBhanUydWRSRCthcnAxL1Bu?=
 =?utf-8?B?TzRrR3ZLeSt0VnhjUC9tMGhVVjdjaU1FcGZCMUNQR0p2NThlbE10WmpQUTVB?=
 =?utf-8?B?NEg0alN0TzB1WVlpOGRkM2dlS1Y1U1g1dWRmOTgzSnhLenlJUUtIRFMxZUpJ?=
 =?utf-8?B?R1N4WFU2VEtXWkVraUxXRjYzU3dYc1QyUkt5elJWOGNHZGZ0T09pb1lhYWIr?=
 =?utf-8?Q?PRDn9sRcny6l/xvSDs2Hvj/UXB7cbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRyUXp2Tk0xWGVKb1VRWFdYRU5TaFllSmxPUklISFJrdGRQNktYNkJOMk14?=
 =?utf-8?B?SWZwZmFDalh6U1JUZVkrOWJjSFluYkE2ZE95SDVQR09kWFBUU2Uwc2xBbUda?=
 =?utf-8?B?YUZmanBrV01Zb2NNT0p5aDJoM2QwbzF3OGFlcUZJa2l6a2lwazZ4ZmRqcm5V?=
 =?utf-8?B?MUp2enJ6VS9MOUx2QXVqazJseHBCeDRNdmdrckp4QWUvelpZekJUdVQ0emxa?=
 =?utf-8?B?clVYOE04dVJSQmxESWpIdjhWUEh2TTNiT1A1MERlaGVHVTVkV1JJdjJFcEh4?=
 =?utf-8?B?cmJHKzRHZm9aZFh2MitqMzlwa0JIWXFvR1JkaDh0YWkwYTY2bkdiZmdNbVdS?=
 =?utf-8?B?b0t2WGwyZ0cvbUM0UmhqeXhIVFNzMldqWUpKMExzVm53VEdiVnZQMHhEekhV?=
 =?utf-8?B?YlEzUkRYc010cnc0dTB0eDNkNWhyNFJRYXc5RkYxeFpvaFBWSVNJRTk3NEQw?=
 =?utf-8?B?M1BiUS90TGJYeE15U2dVNEVMQWxmREFsLzd6a0V6QkpwakxFMVBCWDRyemg5?=
 =?utf-8?B?RVA1Z1A2NXpuVTRtQVVnbW1FbzV2MmNjTWhKS1dNb1p0T204eEJIZVZYcnYy?=
 =?utf-8?B?VHd4Tmk5K1dyaFYvZDlheDNSUERYSGx1b0swdjVnU0JwTGpEeTlvdjFtZDVT?=
 =?utf-8?B?bWE0MWkweTNFQkpEanZTTlNRa0doK2ZKVko4dFhRTktzMUtsRTBjS1ljQXFJ?=
 =?utf-8?B?cnFkNnNZa3IrcEZDU0RSZ3k4dVd6Ly9QY1ZudFBvQnRRbUZ0bnNBOW5RTVRP?=
 =?utf-8?B?U2tuQmM2N0srZ0lsRWlDbmFYN0FJRGFyelgzRUJNLzExMU1zT05GYkVWU2JL?=
 =?utf-8?B?Q3hMbm5LSG8zbHZNVDUvWlQ5d3Erb2xrcUE4V24vNHQwRlRKL29tUVhxeHZG?=
 =?utf-8?B?RStYUTJDc0kwOTJCMXpDekl0WmFKdFNqVEx6Z1l0dytXMkVabzN6MXhWMUg1?=
 =?utf-8?B?RGlTSVBydjNWbkgrSGhqTlVLWmJNVXkzS2s2TUpTaTJYYXpFb0tZK0QzS0lw?=
 =?utf-8?B?MFBaM2FDSWxveW5wSktpbXJCT2p3YnlodjBEN0RtMkZZeWZ1RnlHUVR6ZXdF?=
 =?utf-8?B?a24xT2lNQlpReUdtWjVDNUpQVUFCQmxYRzd3WVNORG11T0drQlU4R3hHL1B6?=
 =?utf-8?B?clJxWUFZdGJsQlFIMjlEZGJJcUlMbUtzdENacGl3YWVOb0MwWUVLLzE0WHl6?=
 =?utf-8?B?NDR6d0lYVnlnay9wd1lDM0xJWWxOTzFBZ2xPc2hpOXpkVTY2R3VjeEVpWHdx?=
 =?utf-8?B?bkJ3b0UvMXJNYnY1bkl6RDhrV3pBZFRxZW8vME8yZ2hYTW1ZQytnYjlDYjdO?=
 =?utf-8?B?b1dvVVRtcHluUjNodS93UGhSdU9TdWJRWlNSZ1ZOOEtkdm5jUkpGcUlRaTJz?=
 =?utf-8?B?QUFnR251U1RETXdpc09FSlZnU3ZMS3A3MkVzKzQvUFM3dW1WUU8rNGpDZmRO?=
 =?utf-8?B?SCsxV0FsWVJUMzZnUUovbmwxWS9Rd3hwV003YVBlWHR2OVJFcG1KanZNMHgw?=
 =?utf-8?B?ZWZoR2lrTnBIWTUzTmlXbkNocnhFYVBqTDJWdUw0UkJ4SW1pSVA4UG9hRGx2?=
 =?utf-8?B?dU5OdFZiTXlqOUVIa3lFdmlMamttRU55d29odTNoOGxqWW1WaktsNE1SK2ZR?=
 =?utf-8?B?d3dhYXRBVXdkYTF4anp2WTRzUHJWdzQ0Nll1OXR0emRpbFA3ZWJEMTlmTys2?=
 =?utf-8?B?WGtnR2JsRGdCekE3eHhHMDFBSU5sWlNkcFhqNm1abXlYNmhvZ2syaGF5Q2Vt?=
 =?utf-8?B?LytqYTRQLzBKMWJ3YlVOWFgxejZqOE4vUnBKKzBEUTdmY2IvZjFobTBRL2xa?=
 =?utf-8?B?VEh1aEFrdm1PRTRSZXFLSWxuVitvL1FnOVp5d2dzWStoZHhtOURneEhVYVBl?=
 =?utf-8?B?bjNsNXVaZzN2RTNmb3BWR0s3STQwQ08zcG90U3VaMk5GNUdmVVBzdThheWtW?=
 =?utf-8?B?bW1RTHlKVys3bnlHTlJ4bkJNUXRzTWsvNFFqYjhualRUVmxYd25FNlRWS3JK?=
 =?utf-8?B?WWg2NzgrNEVXdi9DTXdWYmRqdVcwN25CTUN6eUJEYlpIN2g3RzJJM2IySTcy?=
 =?utf-8?B?dVdCSTVHSTlYczRKQUZEOElWOTl4TmtIQmd2K2x2ZFRETURhWkdBek9sTXgw?=
 =?utf-8?B?bGpoa3NsMUU1NG5BT2xFTysxT1NOb3ZwUFhidmVGRWlwNlNOTFllcllRb01G?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9c6b7-aa0f-4349-038d-08de173f2475
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 23:01:49.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJqtuVJNHqgz5gKCutnOlEYr8gCf4y3N5rwMxNVDr0p6iPlZaj2Omokmy3jz/8fD7C8hxe85If73FqFyXo8Pk8nNepFCuJWapfUkb01rTwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com



On 10/29/25 2:16 PM, Ira Weiny wrote:
> 
>> +
>> +#define vm_tdx_vm_ioctl(vm, cmd, flags, arg)				\
>> +({									\
>> +	int ret = __vm_tdx_vm_ioctl(vm, cmd, flags, arg);		\
>> +									\
>> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
>> +})
>> +
>> +#define __vm_tdx_vcpu_ioctl(vcpu, cmd, metadata, arg)			\
> 
> NIT: Why not just call 'metadata', 'flags'?
> 

Making this change would make the code easier to read by being consistent
with caller here as well as with kernel terms. If making this change please
consider its callers also, for example the "metadata" local variable of
tdx_init_mem_region() introduced in patch #14. Naming it flags would then also
be consistent with this change as well as how the flag is used in the kernel.

Reinette

