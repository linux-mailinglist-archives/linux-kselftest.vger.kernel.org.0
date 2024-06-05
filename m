Return-Path: <linux-kselftest+bounces-11264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B778FD958
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CB1C21A26
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3615F409;
	Wed,  5 Jun 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXfH6csG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5F1373;
	Wed,  5 Jun 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623893; cv=fail; b=LcqYVhWOPshlrfno5TAQzNNnILXD/LPq8V8FFrnH4mo8C7jt9RfK9W1gDT7HchRpIftW6jyZgQUugyZs+nkN27wMgv05u+ANsn57jL8ryeDqQoq+5uw1e7nDXLbxnmW2HxSDImK91OpylgfsI+1REmCgOdn4tbGUij89dmzQZWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623893; c=relaxed/simple;
	bh=sl657yYcW+DXoLVlE0ezyS6RDGQ+CusLwJrSfIAm7t0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lg58h8vtIRRlY2E8ZAREIChbqab7N92x3rMYgy5qdb40Qq8XcOx1k6ErCX0KkVwuyyd3QRxqq2+z85tDcYb3C0DPTdzoZpWT5eNsCv388eWTWgCFiQibNl+C2vEniM/UzAWSfQIj+M56hBqpGEvSZVwJ43Ko7t3/yosLRH4I23o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXfH6csG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717623892; x=1749159892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sl657yYcW+DXoLVlE0ezyS6RDGQ+CusLwJrSfIAm7t0=;
  b=PXfH6csG0IccRKLIiYJvIhAHhDdWlB9WtrhaU9JSJApLzlMngS8fahi3
   1ngsTVjzQxBmfNV1ouV5TjBl/iPXGEA60K3i9cS1FNEl70U8C03dHhKbW
   0A4Yh7mTLbWpmZUMwuhGpP1+TfJCRlEEQcs7BRQC8S7mpMSyteW6uiACx
   RZZQHvBIvcOuiAYE8Vm2+KorFx4Gnsj5bTGv5vXkIAAinsvpqQjWN3RlK
   VV+2GIjrdLWvqYwrr6yMx4rgI0IH0aYGv3H+YNg7aFmOccyD75lgeuzXO
   BnmvYS+ZoVsuSu7RxmIaiA4pN/Kr+1bhFItQGEyzL85Fkbu5Psjqvdd/z
   Q==;
X-CSE-ConnectionGUID: NFlFB2/aRCGOuwotM5Z4Gw==
X-CSE-MsgGUID: FsmCKXwuQeuehIkvCZkJAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="39662755"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="39662755"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:44:51 -0700
X-CSE-ConnectionGUID: 2gqKuBwGQtyR59FnoRiUfA==
X-CSE-MsgGUID: ByMIx8YMSZSRdez7Aw+mLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42693047"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 14:44:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 14:44:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 14:44:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 14:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPcSiQ9Jma2hbHZYSd5yBq9tHbZu24WcJR8XnG9asJc5xlZZYxD3voljew/m66AciiRiqODyhmiwn/3mY7iIW/QfSC288lDDH2AHzuf/58SALlp8xZeFUiZqw7kSvCSOv+EsEpaBl9vzniLD/CRsgOwgc5s5vqhT9GGmar+kwxmZrhf3rY4p6f5ra+8+MtDgmceaUimlQy1VIb2ukJelYdj4rtjKmNlC7r67v5zzs0oJYTa/BYupzrr9qy2cumK7Y0i4mnrTXN/f9MeFRfglTUpTrhIRkkHQtmOt8l6pekXVdt0BlsrOCYJhhg/fdB2maNuJ5CUBz0UJU2TXqRCaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl657yYcW+DXoLVlE0ezyS6RDGQ+CusLwJrSfIAm7t0=;
 b=GqTqLmClV8rGX/MVpTWxc1tw0S8uaS8h82BkQoazIh0+OxNvBssdS75uQcrONmh/gRw5u9vKFhrr091tHwauXUOuaYQtVpTR5phAz0uLWNI3Ebz24GRFWBvP1QKeAmUNC6roHRm41ZIRQG/d3M1VrM6aJ6IgDobq4V4wSY+SiAObXw5bt2MVT7VLMHh4hDndy+dDa1GxRgvFY4WQG7Z4/jtDBDTcDQuGyd4DVAE2pFdH0Ft0ICagRNs9GBWxjiMljkT9VPcj4kDGHlQrSUp28sQn7BPqGQNZMv9hCJPrSfB6vKlhPenAkYPoJdWsAo1XGCJDU6zLnLXmedKTd5CB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 21:44:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 21:44:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sagis@google.com" <sagis@google.com>
CC: "Aktas, Erdem" <erdemaktas@google.com>, "vipinsh@google.com"
	<vipinsh@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Afranji,
 Ryan" <afranji@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "runanwang@google.com" <runanwang@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"pgonda@google.com" <pgonda@google.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Topic: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Index: AQHaLTxo7g1LHBoyE0m0HNgVI+vn07G6lI+AgAAZvQCAAAF0AIAAAN4AgAAGnACAAAQQAIAACmaAgAADAIA=
Date: Wed, 5 Jun 2024 21:44:45 +0000
Message-ID: <262ee73f23445fea7129a784ff3d6bc4294c25c0.camel@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
	 <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
	 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
	 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
	 <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
	 <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
	 <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
	 <CAAhR5DF=wAVsshyX-JqcPhhrVp8rEF11uJkB-OSEUM-B-oEZoQ@mail.gmail.com>
In-Reply-To: <CAAhR5DF=wAVsshyX-JqcPhhrVp8rEF11uJkB-OSEUM-B-oEZoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: 417407c3-e277-4059-4d29-08dc85a8b779
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QzdLQkZwejN0M1c4ZlFNM1h3STlrbTQ3a2d3V1NoZXZ1eUZFQVNLWGkxbmh3?=
 =?utf-8?B?Qjc2Y0VQS0d6ejlSODJhcEszRVB6d092Z3kwTk1NZzlEdlJzZElTUFFPUGtJ?=
 =?utf-8?B?dzlTYnNneTU3Y1dMeElYcHgydnk5TzF3emRaVklzQWlMY2ZpaXlVbi9SV1g0?=
 =?utf-8?B?MGtDOGNqdGtVWlErelpWNlA2U055aVVsckFqNzFnMVFTbVowN0Yrc0R4R0pC?=
 =?utf-8?B?N29uT1pVeHJlTjd2TDIvRWJ3VHIvdlhZckNOSG15azNQOXZmSXB4ZGlZRXFH?=
 =?utf-8?B?ZUJSR0pyMjlJRnNJd09FaFRxLzMvM2dLQzJ5TDcvNVB2WGlpZlVyQzZhOVJD?=
 =?utf-8?B?NTVtUGtJRVJBR08wME4vcEF5SE5lSXZSRHhIMm9tWnB3eXRlMlBMTXpYcUdw?=
 =?utf-8?B?RVFYaGczcWpFYjZZTi94U2RBUEdTSnkwckJWTGlmUkQ0UWM0NHlyV2d6d2Z6?=
 =?utf-8?B?dkZNYWpJRHBXM2RpUlFzVkp3dzR1cE80eTdnb0srdXVYeWtXbm9NNDBhSlp2?=
 =?utf-8?B?aW5QQW1BWEh4UWczckRGeWJtTm1rZFdXaGlXSHBFd0EyK0t4dHo0NHdFdXlw?=
 =?utf-8?B?V056RFRtQ014SnhaeUdMTTZxUTB4ckJ2UHI1RjE2M0VsT1l6ZDhHdk1NWVRE?=
 =?utf-8?B?bU9QODJhcWlDbFNoNXZWNm9YeUJqSWRucUo2V1JJUTlRVVNoNUNFaXZDSkFR?=
 =?utf-8?B?REtBaytYcjIrdk8rNDNKVnZRdVkwNEhqRFJHWmE5TGtMRkVSUXRlRHE5WnNh?=
 =?utf-8?B?MVBQT0NkNXl4SGdhRVJPQWJVTzVQM3pvUWtOVldCNHYrQmNPTUl3MGx4NmlB?=
 =?utf-8?B?VU8rUVdpd3pyaENqU01IZWMyUnVVZjFSZm5WaGRDSEJPSjlQY3ZtVEdrNmU1?=
 =?utf-8?B?U2tEellLZmdaTlRRekxVUnFVVnZJS0hWOElLbUxxQ1d1Rk1Bc2N1YndqbVFL?=
 =?utf-8?B?cC9iZENBbmpRWCtmaWVMMmNnYU5mbTdsZ2FXc1BhdnhpRm9wQjZPcnBWdlFp?=
 =?utf-8?B?MUVjYWIzb0RLSWlWTWQyd3FIYXFCUnhsUDBYN3lEUGZNMXdVbUppS21ramtJ?=
 =?utf-8?B?VU52VEkwZFdYM0lVU0FjMmY3dXNlb0ZxeUpXc0RycGcyYzI2WmdJOXVZWU9t?=
 =?utf-8?B?RHhJVWF6UUhlN0tXNTNtSGdGN3JMYXQ3MVZ6WjUrSWJCVURIektrUGxheUhU?=
 =?utf-8?B?RmV1MVZuVENpSGNvSmVQdjVxNHB3aFZTMUlOd3psT1FYVmN2dlFFcXhhcUln?=
 =?utf-8?B?aG9kUDVVc2RhN1FYSWFtUVRuOVBERG10UjcwVEdFU0dTZzg0d2FkWFBnZFo4?=
 =?utf-8?B?L0Raemk4YlRETUsrVzdDaGJzdlJkcnA0U2g3WlNkNEoyOEZWcWxrd2JSeGRE?=
 =?utf-8?B?VENUcjRmUGxyM0h0NUs0Y21adnF4b3F4bkZnUzRCc1NGeGxBaWxTOVhQQ2NL?=
 =?utf-8?B?eVVEYWpwQ3pOOFNkSkxKRlNJMUJ4bFU0T0g0L2tEejBlWjBQM1l0dFVPZEhx?=
 =?utf-8?B?MG9tdmVzMmJDTHp5WUU0ZmR0a2prbUZXVnovQnVGMU8yQklQa25yRHErTW1v?=
 =?utf-8?B?TG5JbHVJWlJwWmhzWTVhUzQwR3c0L0hzZGJMNnZxUVQ3a1FiaCtRbWM4a0wx?=
 =?utf-8?B?VGV6ZVR2ZVhxYWVzNHhQMGc3cUdlTHNkbThJYXJrbWduQUxtYUM1YW13dVRS?=
 =?utf-8?B?ZW9RV3FqWXc0NUtybjZFNm9WSTUyRWZzenRTeGIyaFBsTkhMZ3JRajBWc0Rl?=
 =?utf-8?B?YWVDNW1hMmVSbW1RL2s4QW0vQlVZUTVUbVZSVldvL3VIZkVuWDRIRDlqR08v?=
 =?utf-8?B?T0IzcEFIS3hURzNvVnFWdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVNTZE5hM3hENWZid0tvUlBjT0s5Y1A4dEUwTGtPTEx5VjhZdVRjL1pHdCto?=
 =?utf-8?B?ZktMbFEyS3h4YzFKbFdsamZHV21sUkNna3I4UVBZVDFRdlJIcDNkTkFEM0RN?=
 =?utf-8?B?Z1VCdUNyU015MTRaRi9kL3BBZ1lqSjN2R3lEM0pzY1FVNVdhQWNZeU1RMldH?=
 =?utf-8?B?Yyt5TUZ1TXE5ZXhYcE1wcEVpMXNHcWdJaWlhTTZTM1RQTlZFZXhzeHp1UlFs?=
 =?utf-8?B?b1ljT0ZyZm5TOU5vZVV0UDdpRzZQalFlTHV4dEhjOEJiM01zZ1luL2F6U1BV?=
 =?utf-8?B?VWt1dWdMWndwU3ZxQjA2cElFWk55Q1ZpYnNWNU1sbVdvUE5NdW51L2E5TlZJ?=
 =?utf-8?B?c2lTQW9XMFg4Vnl5VkZrakRLbDc4UEVrdkJEMHFTQnNVQ0d4NnV4OFFlek1G?=
 =?utf-8?B?U3oyRk1OcXBxeWRwcHlDY2RuK0RLVHdaZzZ1TUVlYWVYb3VtcGlqQWd1L0ZG?=
 =?utf-8?B?Q29WcytCVHJ1c1ZsTmZ2NkxjQ1grNGJ1VVNyUkx2bUtkTVdwZ3Nuem9mQ0xS?=
 =?utf-8?B?aHo4ZE9vbTZ5Z2pnb2YvdjNsVnN4dExXMHlmK0dRUHJVaXNQL1ovQndyZUZ6?=
 =?utf-8?B?Q2hZbnVIT2pRY0FTV3ZQNC9SZnFHYTJYVEh2VnliWFhEcFR5RkxxNUxEK0sw?=
 =?utf-8?B?dnVta0tESHFIbEhHcWJzRnQ0TlNYeUdLU0JlWW9hK2VXZlpWdE9idk5pdFBW?=
 =?utf-8?B?SENSdkIvekdVSE8rd3dVdVZ4YnozZ1llQW14QW5IMWRYS1d3M2ZHMW5aVEho?=
 =?utf-8?B?bHlsTWlsOVBsRzZHS21FOEUrZUtNYk5LdWtiT3ZqQVZrRVhWTlkxdlQyZmlt?=
 =?utf-8?B?ZlpvVytUNkpnbE9oYVFlVDFNUHF6QnRyTC9lbXlRaW8rSjlySFpFQkJZOE9k?=
 =?utf-8?B?bFAxSXhDak9CM3cwbFBZbk1iZTFaN2VZU2gyZnUvSVh5VWp0VzdTZnE5ZkN5?=
 =?utf-8?B?Z1RnblBMZERoYWlXbnNXQy9EbmVMQnBIbVNOaEIwS3VUT3ZWZjhUQ2VMWElH?=
 =?utf-8?B?eDlzNlR6U2UvdEU5NjBjN0RocUUvMmdqYThFVHJDNlc2YjRka1ZkOGUyY1Nv?=
 =?utf-8?B?bExqdkt3R2NQeUowUGc0Y1FHNHl0a2ZqeGRKK3ZHK0VtMkd0T2wvQ3Ava1M4?=
 =?utf-8?B?czFJUkNpZmlZK1MySzgrUGpMZlVqYWVLVVlVdEdGcFZNTmozNEpUYnBLa09j?=
 =?utf-8?B?MnpydnpCZGpneVlmYy8yZ3A1bEw3cDhaRG80V2MwNGVCN0d6elpaOG1MWWNL?=
 =?utf-8?B?RU1YRFFaK0lVNmJxZG5SeGhZb1h2YU1JWXU2RHdlUExJWHEzYWFNT2VDRnNk?=
 =?utf-8?B?M3AvbDJ4VnFUc3gyOEYwWGdyVVhuRnR4MlZuRzhpclRRSmQ2L0FDRHpMRnh6?=
 =?utf-8?B?L2tiVnk5YjlMUUhWMUZRSlorSzB2UzJJV2ZpVGJkdG9CUXczQkRmUkFIampD?=
 =?utf-8?B?eXZ5SlU3Z25WcUprMVdLS3BLWHhUTjVvNGhMeFhoeWNDUTlIa1BzVmNyY0c0?=
 =?utf-8?B?enBMbHgyelFZZXdqQzU3MitkL3QzN2x6dGRJY2NqcTJjZzEyQUdYV0U0aUN1?=
 =?utf-8?B?WTVDcHpGaldSREZaU09Ub01Mei9kMmxHWE5HZStheHV0QWdNeUR4NmtPZk54?=
 =?utf-8?B?NDVKYUxZUDRLeTk5WE15TFJFZWhWMTFmRnBWY3VMUEd2bXhBbnJWMklRMHYz?=
 =?utf-8?B?QWZBbElGM21hczQveEZrZ2RIbis1V1BTMFBwYk1mbExFWS9qZWlDZXltcG9U?=
 =?utf-8?B?SWRUZ0tFaWV0aU9adkY3NG5TQkNMVmxTR3hFRmlrVU5MS3dPY1ViY0tsTmUx?=
 =?utf-8?B?QmpsNGRpSDc4cUh3OGgxQitiUEFKeUNpR1I1d1RmVnd1NzNNakNQcE1VVzJu?=
 =?utf-8?B?NndMeW1QcDNvUkxSaGprV2xQM0RhZU1TQ2gwVnRYTFFwVTQrVS9tN00vVUp2?=
 =?utf-8?B?YTd2R3dLK3Y2TmJYN2wwNFVpZFp2VENZcC84YUhNN016cmxPWkg4WlVIcnhv?=
 =?utf-8?B?QkE3Rk9EVzVCNkJiTGFDMVpoN0kwWnVtK01lM1N1T0I5V2lLQlhTRk5STGVm?=
 =?utf-8?B?akYrVGNOK01DbTRuNmQ1cDJPbU8zbjdTLy85LzQ4YjNrNkx0RzZwaUtUQ1hO?=
 =?utf-8?B?NjVGa3lGKzRWMzFLRCtCN3M4anFzbFpRK04ydHRGYldhcFI1eWo0dnpnMzZP?=
 =?utf-8?Q?5H5oMBQZfWeqUJTkzMIcJBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A581FE9A5A5BD45BF62A173C8A9487D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417407c3-e277-4059-4d29-08dc85a8b779
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 21:44:45.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCDATpumIga5YEcA6mOSpxIqc95gSFFKXvEeOVWZkVoUcyz9/RCDaoPD4ctsQUQxwU2z0h1eoEPm9b2TZPHFpofZUwFoYvypYK+GrcEdnhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA2LTA1IGF0IDE2OjM0IC0wNTAwLCBTYWdpIFNoYWhhciB3cm90ZToNCj4g
PiBXZSBkb24ndCBjdXJyZW50bHkgaGF2ZSBwbGFucyB0byBwb3N0IGEgd2hvbGUgfjEzMCBwYXRj
aCBzZXJpZXMuIEluc3RlYWQgd2UNCj4gPiBwbGFuDQo+ID4gdG8gcG9zdCBzdWJzZWN0aW9ucyBv
dXQgb2YgdGhlIHNlcmllcyBhcyB0aGV5IHNsb3dseSBtb3ZlIGludG8gYSBtYWludGFpbmVyDQo+
ID4gYnJhbmNoLg0KPiANCj4gU28gdGhpcyBtZWFucyB0aGF0IHdlIHdvbid0IGJlIGFibGUgdG8g
cG9zdCBhbiB1cGRhdGVkIHZlcnNpb24gb2YgdGhlDQo+IHNlbGZ0ZXN0cyBmb3IgYSB3aGlsZSB1
bmxlc3Mgd2UgbG9jayBpdCB0byB0aGUgVjE5IHBhdGNoc2V0IHdoaWNoIGlzDQo+IGJhc2VkIG9u
IHY2LjgtcmM1DQo+IERvIHlvdSBoYXZlIGFuIGVzdGltYXRlIG9uIHdoZW4gdGhlIFREWCBwYXRj
aGVzIGdldCB0byB0aGUgcG9pbnQgd2hlcmUNCj4gdGhleSBjb3VsZCBzdXBwb3J0IHRoZSBiYXNp
YyBsaWZlY3ljbGUgc2VsZnRlc3Q/DQoNCkkgZG9uJ3QgdW5kZXJzdGFuZC4gVGhlIE1NVSBwcmVw
IHNlcmllcyBwb3N0aW5ncyBjb21lIHdpdGggYSBmdWxsIGJyYW5jaCBpbg0KZ2l0aHViIHRoYXQg
Y2FuIGJvb3QgYSBURC4gV2hhdCBpcyBkaWZmZXJlbnQgaWYgd2UgcG9zdCB0aGUgb3RoZXIgY29t
bWl0cyBhcw0KcGF0Y2hlcyB2cyBqdXN0IGxpbmtpbmcgdG8gdGhlbSBpbiBnaXRodWI/IFRoZSBz
ZWxmdGVzdHMgd29uJ3QgYmUgdXBzdHJlYW1lZA0KYWhlYWQgb2YgdGhlIGJhc2UgVERYIHN1cHBv
cnQgYW55d2F5LCByaWdodD8NCg0KPiA+IA0KPiA+IFdlIGFyZSB0cnlpbmcgdG8gdXNlIHRoZSBz
ZWxmdGVzdHMgYXMgcGFydCBvZiB0aGUgZGV2ZWxvcG1lbnQgb2YgdGhlIGJhc2UNCj4gPiBURFgN
Cj4gPiBiYXNlIHNlcmllcy4gU28gd2UgbmVlZCB0byBiZSBhYmxlIHRvIHJ1biB0aGVtIG9uIGRl
dmVsb3BtZW50IGJyYW5jaGVzIHRvDQo+ID4gY2F0Y2gNCj4gPiByZWdyZXNzaW9ucyBhbmQgc3Vj
aC4gRm9yIHRoaXMgcHVycG9zZSwgd2Ugd291bGRuJ3QgbmVlZCB1cGRhdGVzIHRvIGJlDQo+ID4g
cG9zdGVkIHRvDQo+ID4gdGhlIG1haWxpbmcgbGlzdC4gSXQgcHJvYmFibHkgbmVlZHMgZWl0aGVy
IHNvbWUgc29ydCBvZiBjby1kZXZlbG9wbWVudCwgb3INCj4gPiBvdGhlcndpc2Ugd2Ugd2lsbCBu
ZWVkIHRvIG1haW50YWluIGFuIGludGVybmFsIGZvcmsgb2YgdGhlIHNlbGZ0ZXN0cy4NCj4gPiAN
Cj4gPiBXZSBhbHNvIG5lZWQgdG8gYWRkIHNvbWUgc3BlY2lmaWMgdGVzdHMgdGhhdCBjYW4gY292
ZXIgZ2FwcyBpbiBvdXIgY3VycmVudA0KPiA+IHRlc3RpbmcuIFByb2JhYmx5IHdlIGNvdWxkIGNv
bnRyaWJ1dGUgdGhvc2UgYmFjayB0byB0aGUgc2VyaWVzLg0KPiA+IA0KPiA+IFdoYXQgZG8geW91
IHRoaW5rPw0KPiANCj4gSSB3aWxsIHRha2UgYSBsb29rIGF0IHJlYmFzaW5nIHRoZSBzZWxmdGVz
dHMgb24gdG9wIG9mIHRoZSBJbnRlbA0KPiBkZXZlbG9wbWVudCBicmFuY2ggYW5kIEkgY2FuIHBv
c3QgaXQgb24gb3VyIGdpdGh1YiBicmFuY2guIFdlIGNhbiB0YWxrDQo+IGFib3V0IGNvLWRldmVs
b3BtZW50IG9mZmxpbmUuIFdlIGFscmVhZHkgaGF2ZSBzb21lIGNvZGUgdGhhdCB3YXMNCj4gc3Vn
Z2VzdGVkIGJ5IElzYWt1IGFzIHBhcnQgb2Ygb3VyIHRlc3RzLg0KDQpUaGF0IHdvdWxkIGJlIGdy
ZWF0LCB0aGFua3MuDQo=

