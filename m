Return-Path: <linux-kselftest+bounces-39124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D44B28864
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C185A8AC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E496246BB0;
	Fri, 15 Aug 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSGZiZWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA8188000;
	Fri, 15 Aug 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297551; cv=fail; b=pxOT6K3NQO6v1/EWzV0O7YA5lkqgWvWkXGdG6xwtduWy5ph0ySBlZeieRy7F7lv53xha78IwuaaapZdTyW7tgovxuJx0nnXRBNzfwms6w66Nvr4qQI+k2PyLxNzHCGSk4lUGygP5qWWShOeEWeyXanycdTXmCAxdlsMyAD5e5Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297551; c=relaxed/simple;
	bh=XdDb5NjHzMKAjMIWdknzmpweOO4Me65hP5I2YdtzdDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVLYGhTkMKnjpk/uZZmc1ve9z2/+GVx32EdMnGB78/rvUt4AaQ8yX6oQtqwzB7dnN/idSgN4E8vXB4aWmZGScop8EYr4aTv6OFmmnVm8WQRyj3/nBv18lO3NVzTdiw8lu4LHcZL4px6t2Sl4qKjv+ivGRbDSH+PwtuI+MFKzZuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSGZiZWf; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297549; x=1786833549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XdDb5NjHzMKAjMIWdknzmpweOO4Me65hP5I2YdtzdDQ=;
  b=CSGZiZWfxKMhbCX7XXsSaHzpix7NtVH/+krE1NgNTfRExqDLVB1SI+aj
   7E2RBskW95pp8oD25JfEWAaLH81aNZJ0FwSTlsSwlP/Xu5O5PHBYuC+Wi
   iRV9aUI1fAxvvGbCTq0AQXPw+Nbxu6RTQ7iUzWU4Dol99Q18Dc01pMH4C
   4N5PRCfB8tg7CYduYiYonpq8RNj0t1IptyLGRP5zLCaTSq+k8Yjlp5SQi
   ddxA0zhszv67Y3R8aXegUnbFsgPPpdIGLPyY/T5DNouTRNYCq62v1YnZ2
   6QLhE4z4ea0/PIq/FfqUu9ilvyKkqWotRSFTxFzzatgDslef4LnVSas1N
   w==;
X-CSE-ConnectionGUID: A+r/g/NGQ5GskzDr5D7KTg==
X-CSE-MsgGUID: ytKomxnERm+jCN7DzFi9wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="61433908"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61433908"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:39:08 -0700
X-CSE-ConnectionGUID: YbWGDJ5GQOeemE2nlphRBg==
X-CSE-MsgGUID: e2irC55YTMGX1QGE16PFoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171555219"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:39:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 15:39:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 15:39:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.44)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 15:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAwuhOV/P5nAL8d3iTYx4r5d4HZCzpm2jY6cC3kJolH5Q+TyKTqkwoQ+UeTJ86MPiLeVrj4KavE/SH5xhG536lpvJlTAAETy0OEVxvn+bDnkYS/9KW11QNmAhGa0No/jw05K7FmegW7bc7jGyVhj6y/Fod9jQBaxSgzxNYG/x2blYjQGEfrM9kDUyDfEpRF3ukvhXtY8utGxCj9FIYnzo1UFSKSjozjGXAFahYPXbcJGfTq0iZlaYA+zCBwddFM0rYDqXq5x2KiAcgLRcKq0A0yQKvVD6xgADGq0+4b29h38nipa96P77fFtMzL5XoQVhF+qO3OYhv/xdD4XJelQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdDb5NjHzMKAjMIWdknzmpweOO4Me65hP5I2YdtzdDQ=;
 b=eJkKPC5aDoV1bSdmwGAXV/MVHSc4FpnKnzpQbKg2bUDgHPhodqwi+3D6EC1Rl7UJ0/O7tfvD/Oewt9Ma4i3HF7wD/RWFbwy7jXBtT2n8RYNbBLjvOlIKiuLr9mhJkGCCq653YPEjiCFqtGI103Ll45nzZCs5JAeM6VcGtlNdB8gISIBmEmqk4Xlz5dxZzGrlKzVe86ezGuMTsQIGmoRaYMKGUfrqU+PLEijMaTwGas3To59J13Kr2qzhQsGg3hCISMskn40Kge83MasvsDWZr/EsX6rIIG9U1emdT6WhADYx7nfum6VthFHa5dbpihsNCxBkbihjZndlRt2GNalZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB8914.namprd11.prod.outlook.com (2603:10b6:208:56b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 22:39:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 22:39:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "kees@kernel.org"
	<kees@kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v18 0/8] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH v18 0/8] fork: Support shadow stacks in clone3()
Thread-Index: AQHb6z/oOOEmFTun/0yI/j7hjJ8Zk7RklEkA
Date: Fri, 15 Aug 2025 22:39:01 +0000
Message-ID: <6800ace8d3ccd486a4a13a84a4499c543c23df49.camel@intel.com>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
In-Reply-To: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB8914:EE_
x-ms-office365-filtering-correlation-id: df2e894d-ea14-4473-3c71-08dddc4c884e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YStkUEttanh2QUJFd29hMEJrRFVpM3VjcFZDNk5IZ05LQlRKV3ErWFRXU1Vv?=
 =?utf-8?B?RkRzRFRQVHN2bFc0ZW9JVkJJNHRkUzlidzFQWjZkZklTaDlLYlV4V1ZrcDVO?=
 =?utf-8?B?UzcrUVc1amJUNnRjUjlKV1lodEluZVF0VVZZbGNzaklVaUtWbnpVdFFpUFc5?=
 =?utf-8?B?YkZQUUFQSEE1M3FVemVBeUdVa2VBS0NxOGVBZDlMKy9IMWZDM0FGdmZadnk4?=
 =?utf-8?B?bkRRdkovRlhsVXBvTXNZekUxQW55UWVmM0pJVnRvbmxVTkU3QjA2ZkYzRWpl?=
 =?utf-8?B?MDdMM2UwNUJScllUVERmVHZjUDhmNnVWUHNJYzZUenU2Njk4WFVlYzRoUmJ0?=
 =?utf-8?B?VTQraURQQ2IxQmw0UDZDUDA3RC8xaDRZcDF5QmVodGNOL3ZmeTl3aTFHOVZh?=
 =?utf-8?B?Y2lGZUZvV3BHZkkyTWh5cmdDa214Z3BHMmsrWGdqK3FIYzdoTm5RSlFwRE5Q?=
 =?utf-8?B?UmM5dTBCOUtOOVhPVjQrYzNVSXc2aFlESW1ualltYUVxZGc3c0Z5NWs2NnVB?=
 =?utf-8?B?ZTI2bDBxTGh6U0gwSElxbWZCNzVGVHl1WXNYZ0ZIbjJRRTRadERIVk8zZzV5?=
 =?utf-8?B?Ky9JZmwzalBjTldjaVhycndiYzhJaExmYUZEZ0FaSTdSYWcyRXF2V0VWOEZZ?=
 =?utf-8?B?bmpoWnRERW9OaFQwNm1kUk9MYk8veDhoL21SbXNFTmQ1cUtRaFZOWGRwWGRa?=
 =?utf-8?B?MmM2QWEvVGNVUFJSMnlLekRBdkZGLzF3QmtNMWIrWWkvZUovMysyM015NTE3?=
 =?utf-8?B?Wmh2aE1QQ0dyR1ByK1pKWTBOcm1VS2sycjNUL3N6dHZubncza1pPR1V4RDZT?=
 =?utf-8?B?bXJmaFVwUy96M1RPcEwvOWhOL295K0YzV3Brd1BFeWs1U3VwekdpYjJZVTdJ?=
 =?utf-8?B?RnZXenVSK1p3dGJvbTVzeUlFb3FHbzZiR29WcmZWWUQ5Tk9NT2tNaEFzd3Rv?=
 =?utf-8?B?OTA5LytZeG9LTEVJT2I4eTNlU083MkJRVmhNQkFzRzRmcFBCUktiN3RFaVUy?=
 =?utf-8?B?WkI1TzU5RHk1RmhZVWxocmpqVDYwczQ1OXNsL1JJZGxpdTdBUzNRVWw2WFl1?=
 =?utf-8?B?TnZkNnYxbmlNMjJtWkZETk4vMWpxZnpiaHhZL0xOR3FLOEI3TE1WYURTaFBH?=
 =?utf-8?B?UENLazhKa01kVkp6bW05eW1PTkRJc09HbjFab0xVMXZCZjZZNTNCVHJXMVh1?=
 =?utf-8?B?SGE0ZGlyTnl4SkpDRlJHSVJqNUkwNVJZamx4RFk2OWxYNjZ5amhFODBTd28v?=
 =?utf-8?B?cjhuUXo5RXEzMFZFeFMzdnZicnBIV2ZCbjJTZkIwK0l6Y2FFK2orcjlBL21G?=
 =?utf-8?B?ek1YRkRDamNCWDBEVld2TmhkeC9kdWRvWUYrS0gvcUdVWVRwa2hKc2FNbkhZ?=
 =?utf-8?B?OVFoUDBodnVmNk51MnY4emtPSXc1UEIyMUNSMHd4b1o1TU1kZWw2cndlUFhm?=
 =?utf-8?B?RFk5NHkxVjQ2TzZ1Q1JDRmdhS2pUNHBYWExKZzFGa1VHRE1ZdzRwdHlSQkVL?=
 =?utf-8?B?a2R5YUR2SjBEQWlvZ29TWE1ZclVVQ0lObFo0VjFuVG16eTlzNmJ5L1dlU3FP?=
 =?utf-8?B?UU9XdFEwOGJsbm5zbDlIWmVHR1I2NHZmaVk5UU1uYWJRM3lKaHpTUVd1V3A1?=
 =?utf-8?B?dU9iSnMrL2s5UldNVEdtRWE5NmRBR2N1RmdaUEl1aHVWUkwyWXdmQ2dGSUZY?=
 =?utf-8?B?SFN4SStpbWtsdmFmVUY5amdNK2RJZHd2eXo0SmU4MEZURndyUFBJYkRrVERM?=
 =?utf-8?B?QmU4K0NITVgyamV6UVo2SFNiemt0RGVOa2s5R2cza2NvRDlMSGxoeFhOMGh2?=
 =?utf-8?B?QXpWL1V2dEhvdFI3QUNHenJkM3BRazhkZ0FVNER6OHo3dXkzbEcwc0VwSVJC?=
 =?utf-8?B?b1F6TlpOVXM2ZzlEcnNGbFFGMGhqWnMxaG5XdXoyaGZ0Z0FFUEVhUlB2c2lE?=
 =?utf-8?B?T0ROMVVJbDQ5WCt5V0NrWWtZRnJxSG9YRzhrNUEzUlpJVDQ3cnBxaUR5ck1l?=
 =?utf-8?B?dlFBMUZFamQrRkVFei9MbzNQbG5SZXdFQytOdVY4UHhldGpNNlIyRHdWVGds?=
 =?utf-8?Q?dP6bv3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0M3S25Ba2pGVGcrMFJWZ0lRMExGWUtPb2RRL2FDNE5YNUxTUllValhzVlJn?=
 =?utf-8?B?M1hWUVVlb1lKM1l3Q1F1Q3NNeVVVQmdXNTlQSU1HaVVRcnF0cU9LUnJ6WlNW?=
 =?utf-8?B?MVRUZlNTelBWdnpYMzU5a2RXRDVMY05jTC9Qd0YzODV2N09qRXdYU0E3dU84?=
 =?utf-8?B?MHJOVjFqQ2M3TDA5aHo0YURXbEV2eDBuWmMxMyt5Nnp3S250WFIrQ2dtT2xh?=
 =?utf-8?B?Uzh4UWVTallvbFJGajcwYm5nWUFVdmg4OU5uRnpCdDg4ZER2aUtuNmhNdWFS?=
 =?utf-8?B?SW1aMzlaMDZmeDFtTWxibE9jUTk4UEEzQnBzQTkxTFd3ZzZGRllCOTdqQ2t6?=
 =?utf-8?B?VXBuR0ZEanRxeStTNFM0Y0hqSHFVS1paR3lJWHVsYWZwMDdlWnlnUStCdXJa?=
 =?utf-8?B?NHZSSVowTmdxdERzdTAyMXoyd0k3WW55WUVwb2Y3bHppNmw0M1luU3V2aFZT?=
 =?utf-8?B?aUxSc2pRMTdTTlpzeDVEaTB0bkRDMmNLdS8yOGI4RVZpdWVJMDJmRHBwU0Vh?=
 =?utf-8?B?SFBVelpuM3ptanl0RzcrU3A4S01iblZIeUlQRWE4S0VHNnZCYnFDc3V0S0Y1?=
 =?utf-8?B?M242dU11bndKdlNGc2tBKzhvcTJaYjhIL3ZGM1c5K3ZlL0o1ak5qdmFiV2Qw?=
 =?utf-8?B?UGdHUXJ4OUhkYmhXNnZOc3lhR3d4RWpxZ290eUp2UXJIWWg1Q2ptZTI0cHZG?=
 =?utf-8?B?S0lBckRnamJnZkxGRjJPMjVDcXprZnBtY3FoV0paeldDbFlmNGdHWWUzYUdF?=
 =?utf-8?B?Qm90bCtmdXhmaWVvcWliTGc1MEU5N2Nic0VjRkNEVVRLVGNWaDl6NHF3eFZm?=
 =?utf-8?B?cDJJRGVxOVpOZTVpRGRHT2xCVTRuTXUrTTdxekVGYll1b3E3V2VTd2dKc1F4?=
 =?utf-8?B?am8yZDNwRFlvbmkzWU5lc2VYNmNVMG1wakZ5SFN4MEJoR2VpR1VGTXEzR2hq?=
 =?utf-8?B?WEJvRUtxbUtWZjkwT2pVTm1rdElJdHR0V2tYT21SNzM5TlNlckdqd3FTUXY3?=
 =?utf-8?B?M2VsckhNWk9EeVNLVUdQN3lLQ255eWkyT1FhbFZJaCtyU0ppLytFeW1kRUJP?=
 =?utf-8?B?WWpiR1VVT3lFQ3dhQ2NOa0NNTlEwU0tnOUE1bjhDUXNTUExJdlBSK2NNdk1F?=
 =?utf-8?B?RWxyUWcwNVFOSVNJaEtQVmkrZzRyTkdWeFA5bTJYTmIzTXREcFdNQmV1ZVZw?=
 =?utf-8?B?R1dtR1UrRzZSY21BTFRkY2FCb2xOYm15VVViL0NVVk41MjAwM1VYWjEvV2xs?=
 =?utf-8?B?eFF1S2JMaXg3cnFHTG95dFdTcUFQMUkzQU14L1lITjRoR3dHc0VjVWZVQW1u?=
 =?utf-8?B?OCtLMVlFeGpOQjFXUWw5bU1VcGxXSUpESmZPMW1YUFdhOHFGZ3pZeUFZSy9C?=
 =?utf-8?B?UC9LeHNkMTFXTE5wWWRpdU5Va2orWlpJc0I0YmdZZGhXaEkxcXJxeEE3U0Vy?=
 =?utf-8?B?T3lXOWF3Q0xscWhUMnp4c2JVaTd0Z3ZKR2QxQnd0Y1V2SUV3L1g3bG9SaXJN?=
 =?utf-8?B?TUQvZG5PU1hVWjRhUnlYaVFQYjAwMHZzVzBTcDZsM3hCQjhtckxMaGtRK3NM?=
 =?utf-8?B?S0xjdnprdjdiS0NpQ2ZNNmZrUlRvdi8vTVh3WWE5UXZlQWVGTG85amRoMFZ4?=
 =?utf-8?B?R1o0ODJoZjBVenVWSGh5dkNnTm5HY0MySFI5S0NPdDNVSUVvK3hIUERkT3VX?=
 =?utf-8?B?N0ZsRE8yc3Q3SzdXU1psc0dYWGh6QXdJeGt6dlk5ZURGTjFnZkp5Snduckhh?=
 =?utf-8?B?RjRFVFYrU3k4cnFnV1VlOTh2QWlYQUoxVVFaS0RyYlZ1LzZ6djVueHB3VklK?=
 =?utf-8?B?Q2dnN2ZaYkJtS3ZNZG1EK2JDVmxvY0JYZkt4aE1Ock9jcS95MkxYU3ZwM0gr?=
 =?utf-8?B?VWFkdFNLb0dqNkV6OXlzTHZMbUI5UVl1Z1J2UWxvaE0wODNJV3N3SlRhWVZO?=
 =?utf-8?B?VGN6N2JRNE5GcDR5K2JvVS9zZTUzdFVLNm5qM2V6SmRNMFkzT09ObW0zRUdy?=
 =?utf-8?B?djhBNXEwdjlZUmtxdk9nUzllT1dOYnIrcmRWeWRpVmMzR2ZraU1nWEtTQjIy?=
 =?utf-8?B?UzAyUmRUSHF3b2t0T0VvWXlzK0lJeEdqV3lZQTFIcjRjMUtkRHBHQkdaUUJx?=
 =?utf-8?B?WHlsK0ZPOU1vbWxNSEQrRTI0a0hVSVE0cEp3L01vS1RaalFRNEozUEpjNmh3?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528F39B31A75F94BA9D0EEABA60DB8B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2e894d-ea14-4473-3c71-08dddc4c884e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 22:39:01.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIVlkGXO02skBG9/0u2uOxRSAOFEqyR9/5s6Yc4JCaVQo44w84nP2leiwbdikuzigDhTAWIbeiZMmqYVfoSCxKuE3aQ1y7niWI/57Eohtsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8914
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA3LTAyIGF0IDExOjM5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBD
aGFuZ2VzIGluIHYxNjoNCj4gLSBSZWJhc2Ugb250byB2Ni4xNS1yYzIuDQo+IC0gUm9sbCBpbiBm
aXhlcyBmcm9tIHg4NiB0ZXN0aW5nIGZyb20gUmljayBFZGdlY29tYmUuDQo+IC0gUmV3b3JrIHNv
IHRoYXQgdGhlIGFyZ3VtZW50IGlzIHNoYWRvd19zdGFja190b2tlbi4NCj4gLSBMaW5rIHRvIHYx
NTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDQwOC1jbG9uZTMtc2hhZG93LXN0YWNr
LXYxNS0wLTNmYTI0NWM2ZTNiZUBrZXJuZWwub3JnDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuDQoN
ClRlc3RlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K

