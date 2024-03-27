Return-Path: <linux-kselftest+bounces-6697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FA88D867
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193F91F29F82
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1202C842;
	Wed, 27 Mar 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbk82XST"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8152577D;
	Wed, 27 Mar 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526929; cv=fail; b=mvpl02T14mjVr60Q6NKXDI3I7jJYepBY6YFdB7sDLztpN8lk8YV5DDACy/wCD/fJFzWYQOrIaL2qb+I9SDU+qFW6544zknxZDQK18OwGsPZS5B77wnycQy5iHHoD9bviRcwyAJxbuAaB1B+oD1+HB68Vfa26t0DNfcVBCxfhLSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526929; c=relaxed/simple;
	bh=RRIV3wi86ZlXOF1puYMEU7WHhpFLqR5fas1DdYGLnaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryHYbTWeGbdjcr5vU7yaZgACLYfSUoOxBNFlm31iimo/QwforLaN1dRvaQd2pf+Miojvk7TrQkAh55J60WqLU1sg+rfWWBuYqim/jWHDRYBDZ8RPKktzRflqOxUizmX52PLphucVqf8yT1/SYXrQkZajZE8/IUINYJ3cD/IXkq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbk82XST; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711526927; x=1743062927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RRIV3wi86ZlXOF1puYMEU7WHhpFLqR5fas1DdYGLnaY=;
  b=lbk82XSTVHm+yd569Ao8/An8CmK53UM8knDUP/PLHEGAQvaR/u7OORT0
   sZK9nb1wp0/NXz8j/aLKvp66lLOB+5dj4F3FDpBd9xoOuU5f47aBW4Zvw
   BdmVrW0g+EpplOIDCbCo50XUBj5SdWkcTYysPgcOw1FiYtr6VDA6OV1mc
   jpFMGMCswtcQH1FE+54qaDg5hYv+Vk8vKduvtrHyvWF7hjvsadUe7AhoJ
   EKnMBtJXhuCqTC8AkRvow4ibkQ4zyZD9C60qwptvO9P7FybKrECSGvg9J
   Br9EXAuKexAdxRZGhCPrPNT+WerVR/IxGP/zH+FxiTUMjPLc8vnjWmWaJ
   Q==;
X-CSE-ConnectionGUID: OXlfNMr9RcKvaaXbXJEIvg==
X-CSE-MsgGUID: CsJGng1NTUmLo0ZWcA+vgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17243136"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17243136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="53689822"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 01:08:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 01:08:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 01:08:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 01:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCQFPQNursDzcWmA0XS1Ft6jb1KRvWB9mzU0A5KeYQJ9zqTbOhZrWG1yHCaQ7KlXha/dcJV/JqYsJ2Rw3rmFtC437skxrmRVU0YAqI20+nsXyi64diRfuJfnxfYshY1jsqc34P70B1E2QiGK1mkXLk/z4a+MRK0Pv9zUqYIWWCZDAEP7WXMRPlx/yA4+e602grPpZoWq5RmjYfRIDdupyKToTuDJb9LkU1tM9kfX1zbJsgT3sNTNBmXiV2f9yK4Wz3vnBMT7OnJsQ28ohs5vx01aMoww6MjbCrH03NOrrbtu9m2vRRH8n3zZF8YdYtruMINYpKOEDUmJrJKXF0JVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRIV3wi86ZlXOF1puYMEU7WHhpFLqR5fas1DdYGLnaY=;
 b=QGq/7hCPtnY6/HMxoVyMgGvYe3PfdLQ48a9cW74dthmCy8Cp+sP7sCqHb+yovlsTi7qbwGD15XoapiYmuKCL9EP8uMgDx325aHd34gHOeRpi7aZXNBdpIpu/K8Ky/RjGkGy0cARVwtZCAKlZzvtOFZ6U+rkYZBTOPsd3GuME19Lo+aEWudtQlvRcIrjtX79RzAqksN2KU027GTp6+2dnmTvo939w3dFHB/e/M69eXuNl9886OfPxDdTubduQGHAyHyopIUY9GgYK0zAkmdFHHLH9lcdEcpvdPUJq+3pHAt7SGKu6ZbH1RVIqfJvtA20fm0fiIPbcP2Iq3B9G3kX6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH2PR11MB4389.namprd11.prod.outlook.com (2603:10b6:610:3f::12)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 08:08:15 +0000
Received: from CH2PR11MB4389.namprd11.prod.outlook.com
 ([fe80::bd78:42ab:54b9:cb55]) by CH2PR11MB4389.namprd11.prod.outlook.com
 ([fe80::bd78:42ab:54b9:cb55%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:08:15 +0000
From: "Kang, Shan" <shan.kang@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Topic: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Index: AQHaWe9+YQ2u9nsIxEqzfOSig2UEzrFLiiqA
Date: Wed, 27 Mar 2024 08:08:14 +0000
Message-ID: <608b37dbc59a80d32719c8fde8b6979a2b839e10.camel@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR11MB4389:EE_|MW4PR11MB5823:EE_
x-ms-office365-filtering-correlation-id: f280a485-7af5-4efe-e280-08dc4e350da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyrpVW21TmwpOaXik+uuVd+ayVl0HlOEtDu9GSK7UGHFEvJTTavLJXZ+WGrzGzM1avDR36DkhWjf8kVquuzi32wVgVtH87lB+CmmDFJqmjCQZP8haEzhCWTkP3Vzyzc5IGlErs32EWBJgq+dTrP3Gb1TOmUiOUiVS1p+XGwSNzCNjjZexfGrNVVe0ynpRJZfW8vFn6opVkELGw+VKcoN6ogU1wKtAv77K7P+e70EmhEvxml4QrkdJl2dR0vEhhKKQokdzlvWLHAutn24jJ3AZXhpX6Z7B1h7VwCcTfyNssxz+3WnjozYfyUXPnZ0pCy1K+lwAPOd4Zeu1i59MbuYOxBpxOaJVnd2FcAVLbOF6vBnPvMHLkdGmO37JMJSXtgXhTND4AGsBWm+1Y7cB1+bG+jPWb9Pl5y6PtNH9DMY5MrgHekkh5GaMkcVIm6kzAAkpjg0IaknTEP0Lta7z1/AIwylfguUjxJ3EtZMli7E+15z9hy2Li8sDBr5TBa4JEA3MHq25MCD+O75BIsSd5qzysj7u4+OiVqtcnQGrWquqgg1D6FIjjDuNKtT8CRUAkPjlFQSqYEVSqrsN6SPrZwnmacAgEjw8XNu4NuCkIsorAnEYRQ6sK2LuNZOVOcWwW12srf5vNzXg3gKRHCQKtLm26BebM87Sq+JErMMeNLJHyOjASnp6yWdLs6OAQ08xlIS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4389.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtzMmFnL3F4OENlWGZPQWFKTnFrNE5tUFJJUitFTUlOeGZORnhYWEU5VGJw?=
 =?utf-8?B?L0J2aXZoVTdzdm03Y0pVeitkSWNERXg1M3FEV1R4SWJXSHVDVnJrR1Jrai8x?=
 =?utf-8?B?Q3A0Zld3cGdpQU1FMWxFUVNpTWFiTUtSMzk0MnhjN0NRcUFvSGxkSDdiUUxh?=
 =?utf-8?B?NjlmNTdXdHF2SVhKMFE5d0RoMHdTeGdtVVFIRjgwNjFENFkwai90OHY4a1RE?=
 =?utf-8?B?R0ZwWUFTUkxvQ3dYWkZrNnRJaHRvai9RNEIzNFZWK0VTZCtqeHl0bmluWWlw?=
 =?utf-8?B?UHJva3J6RmhhcUhpQjJMUjVha2crZmdaWHM1U04rMDRRZnlsTW91K0VNNFpn?=
 =?utf-8?B?TldoY3N0OVZEZHFXMlY4U3pIWGtZZWJGbHhWYkw4NElYZ2ZIam42UUJkYmZo?=
 =?utf-8?B?NklXTHlPdHVZSGg2THMwNGVLcmRCZkVkZ1JDTmhuUnJuVTdXUFp4WTR3bERY?=
 =?utf-8?B?UFgrQm1zZm5DOWg2bm1Wa2pXbmUzNVp3Y1g0WlhnWTk0MkxMUU8waFVjTWV3?=
 =?utf-8?B?ck9RVnlxSFFvL0xQQndqNHVMRWhWNXFoanF1WXlnSHE5Z2IzVnVVSFFFOVBV?=
 =?utf-8?B?bmhsMC91YVk1QlViZUJtaWRVb2R3Q29NY05hamlaS2Z1WVFyTnV5MWJGTUtM?=
 =?utf-8?B?L0hXUzY2UGQ3NEdTc21EMHZ0K3dNTkVodDVvWk9SVG5WRDFqM0R5Wm1hd2dh?=
 =?utf-8?B?WDBkbjRhK3RFSGtEdTJ3RmpIa0kycXVucDhyaFNJTTFTeVBLdEd5UXpQMVM4?=
 =?utf-8?B?NFZ2MUh1dit0Q3IvSFdDNHJFNlVIWDhiYXpDRGMyWEdhTjRuYXozWVhqNm40?=
 =?utf-8?B?MGtCM3BDV1VGNWhmSEdiWkdCYkEzOHJWeklFMkJ1TTRZdTRzRzhDMlhtNTJU?=
 =?utf-8?B?aDNiUHAwNUQreDQ0NDJwRjFSYy82enhSVlJLU1FOQ2RxKzFlMnhnVVlLbGZn?=
 =?utf-8?B?TE4ySTJIU2FIQ3pnblRpZ1F2RlF5bmpldVN2cXNZempDeStObXJyc0JwdkUv?=
 =?utf-8?B?WDZvaUt4c0FmNlE2SzltYmJ1TDR0ZmZDclk5V3RrTEhVZkxLSlg0aXBaK0pp?=
 =?utf-8?B?Wk0wRW54MWpZSmpka082U29Qb1djYVZXcVBiL292T2tEUXZPaWhBa2E0V1ln?=
 =?utf-8?B?SXhiNTFaQzlMTHRaY1pXZkIrSUhTdkdoajAzNU0xOXk1SFNYeTBzWVVEanMr?=
 =?utf-8?B?ZTZaOEJDN0htWlVPQVlQalFWZDBIR21vREhmWHJkNUhpM09IbUNZUjFBaEVi?=
 =?utf-8?B?dTdpNTQ0VmlSbGd2bkVoODlqVU1XN0tvV1Zuc3grRlRvUWJTUkkvenVVd0t2?=
 =?utf-8?B?K2lxY3VRYmVac0RZTndPeXRVUGhHUnlyNHdhNnRJUXhLd0FNVXdzN2VqbHdU?=
 =?utf-8?B?NWZpakh0OHh0MmxieS9kVkNFWGR0cTVqclF1RU9qVlZ2OEdXVWR2QUJNS0R1?=
 =?utf-8?B?UlEzT0NPTGo4RUNxYUk2MEpKTjBXMDluK1JWY3REaHJEQ1IwVVo2YXBDMlgy?=
 =?utf-8?B?V1FSS2VtOWVoZ01GVjRzTURhVjdKVUpWL0FXWmxzUll5Tm9tNVNuQjlRaExH?=
 =?utf-8?B?bkJzYmlXelVvZ0NrMm4zY0JudG56Qk80QjBsWUVNOUtDbytzdW1RdmRwYWtZ?=
 =?utf-8?B?WG1iWUNiZnZsS2FKZUtVQXM5eEk2a0RuVjc0dVlhZzhtVkFiSHpnUHZFTUlD?=
 =?utf-8?B?WU5pOU1MdGJlQWU3TFZMKytnS2pYYSsxbDJjZERHYkFYbUZCVTVVTndBeWJX?=
 =?utf-8?B?R053VElPWktGSlY1YUwvT3FqNlN3aWViQlo4Zmc5VUdKSUJPWlpKc1ZlbHd1?=
 =?utf-8?B?Zko4QXc2UEhmbDlPR1dzRFZMZ2RoeGhGKyt6WHQ4ZmV6dlN0MGNlRkZQVnJU?=
 =?utf-8?B?M2JRTXZsZVVKd2x1YXhqSlZaYmNKdUdNTm1WN3Z4K3lZcHV4QU5USzdnSldh?=
 =?utf-8?B?Q3ZIVVQyejRDSjEvbysyUmw2L1R4UXl2cWRHMlpSeVpjaHRReWJucUlZU2kx?=
 =?utf-8?B?VnJIMUxvT04xSnNnMlk3T3Q5THI1OVBHM1VzaFdKSFI3MUZsQmp6ZkMxc24x?=
 =?utf-8?B?MzRVdlV0aERJSlhYaTlEUGxKRlFRRERYUXZ6bk9iV3VQTU9tUkRCVWl0OVl3?=
 =?utf-8?Q?WjUsr12twNsT3QWUWpz8cZlWs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54062E01E23DB24C9CBDEE4D64EFE960@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4389.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f280a485-7af5-4efe-e280-08dc4e350da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:08:14.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGdK+UGlyhG2tPjEoPaVc1zM4V47dfvLzDiYE7aNz9yYWmrq33wiVkl8nPNdzmMfSlgQF3A25OaEeHuHU0vmiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDA5OjI2IC0wODAwLCBYaW4gTGkgd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggc2V0IGVuYWJsZXMgdGhlIEludGVsIGZsZXhpYmxlIHJldHVybiBhbmQgZXZlbnQgZGVs
aXZlcnkNCj4gKEZSRUQpIGFyY2hpdGVjdHVyZSB3aXRoIEtWTSBWTVggdG8gYWxsb3cgZ3Vlc3Rz
IHRvIHV0aWxpemUgRlJFRC4NCj4gDQpXZSB0ZXN0ZWQgdGhpcyBGUkVEIEtWTSBwYXRjaCBzZXQg
b24gYSA3dGggSW50ZWwoUikgQ29yZShUTSkgQ1BVIGFuZCB0aGUgSW50ZWwgDQpTaW1pY3PCriBT
aW11bGF0b3Igd2l0aCB0aGUgZm9sbG93aW5nIGZvdXIgY29uZmlndXJhdGlvbnM6DQoNClRoZSBm
aXJzdCBjb25maWcgaXMgdGhlIGJhc2VsaW5lIG9uIGJhcmUgbWV0YWwuDQpUaGUgc2Vjb25kIGNv
bmZpZyBpcyB0aGUgYmFzZWxpbmUgb24gSW50ZWwgU2ltaWNzwq4gU2ltdWxhdG9yLg0KVGhlIHRo
aXJkIGNvbmZpZyBlbmFibGVzIGhvc3QgRlJFRCwgYnV0IGRpc2FibGVzIGd1ZXN0IEZSRUQuDQpU
aGUgbGFzdCBjb25maWcgZW5hYmxlcyBib3RoIGhvc3QgYW5kIGd1ZXN0IEZSRUQuDQoNCkZvbGxv
d2luZyBhcmUgdGhlIEtzZWxmdGVzdCByZXN1bHRzIG9uIEtWTSBndWVzdHMuDQoNCistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0t
LS0tLS0rLS0tLS0tLSsNCnwgICAgICAgICAgICAgICAgICBDb25maWcgICAgICAgICAgICAgICAg
ICAgICB8ICBQYXNzIHwgIEZhaWwgfCAgU2tpcCB8ICBIYW5nIHwNCistLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0t
LS0tLSsNCnx0aGUgN3RoIEludGVsKFIpIENvcmUoVE0pIENQVSAgICAgICAgICAgICAgICB8ICAg
ICAgIHwgICAgICAgfCAgICAgICB8ICAgICAgIHwNCnwgIEwwOiA2LjguMC1yYzMrIHcvIEZSRUQg
bmF0aXZlL0tWTSBwYXRjaCBzZXR8ICAxNzc1IHwgIDUyNiAgfCAgMzMyICB8ICAgNiAgIHwNCnwg
IEwxOiA2LjguMC1yYzMrICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgICAg
ICAgfCAgICAgICB8ICAgICAgIHwNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSsNCnxJbnRlbCBTaW1p
Y3PCriBTaW11bGF0b3Igdy9vIEZSRUQgbW9kZWwgICAgICAgfCAgICAgICB8ICAgICAgIHwgICAg
ICAgfCAgICAgICB8DQp8ICBMMDogNi44LjAtcmMzKyB3LyBGUkVEIG5hdGl2ZS9LVk0gcGF0Y2gg
c2V0fCAgMTc3MCB8ICA1MjYgIHwgIDMzMSAgfCAgIDEyICB8DQp8ICBMMTogNi44LjAtcmMzKyB3
LyBGUkVEIG5hdGl2ZS9LVk0gcGF0Y2ggc2V0fCAgICAgICB8ICAgICAgIHwgICAgICAgfCAgICAg
ICB8DQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rDQp8SW50ZWwgU2ltaWNzwq4gU2ltdWxhdG9yIHcv
IEZSRUQgbW9kZWwgICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICAgIHwgICAgICAgfA0KfCAg
TDA6IDYuOC4wLXJjMysgdy8gRlJFRCBuYXRpdmUvS1ZNIHBhdGNoIHNldHwgIDE3NzAgfCAgNTI2
ICB8ICAzMzEgIHwgICAxMiAgfA0KfCAgTDE6IDYuOC4wLXJjMysgdy8gRlJFRCBuYXRpdmUvS1ZN
IHBhdGNoIHNldHwgICAgICAgfCAgICAgICB8ICAgICAgIHwgICAgICAgfA0KfCAgICAgICAgIGJ1
dCBGUkVEIGRpc2FibGVkICAgICAgICAgICAgICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICAg
IHwgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSstLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKw0KfEludGVsIFNpbWljc8KuIFNpbXVs
YXRvciB3LyBGUkVEIG1vZGVsICAgICAgICB8ICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICAg
IHwNCnwgIEwwOiA2LjguMC1yYzMrIHcvIEZSRUQgbmF0aXZlL0tWTSBwYXRjaCBzZXR8ICAxNzY5
IHwgIDUyOCAgfCAgMzMwICB8ICAgMTIgIHwNCnwgIEwxOiA2LjguMC1yYzMrIHcvIEZSRUQgbmF0
aXZlL0tWTSBwYXRjaCBzZXR8ICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICAgIHwNCistLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0t
Ky0tLS0tLS0rLS0tLS0tLSsNCg0KRmlyc3Qgb2YgYWxsIHdlIGRvbid0IHNlZSBhbnkgbWFqb3Ig
aXNzdWUuIE9uZSBtYWpvciBkaWZmZXJlbmNlcyBjb21lIGZyb20NCnBlcmYgdGVzdHMuIEFub3Ro
ZXIgdmFyaWFuY2VzIGFyZSBmcm9tIHRpbWVyIHRlc3RzIGR1ZSB0byBJbnRlbCBTaW1pY3PCrg0K
ZW11bGF0b3IncyBzbG93bmVzcy4NCg0KVGhlIHRlc3RzICJ4ODY6c3lzcmV0X3JpcF82NCIgYW5k
ICJ4ODY6c2lncmV0dXJuXzMyIiBmYWlsIG9uIHRoZSBsYXN0IGNvbmZpZywNCmJlY2F1c2UgdGhl
eSBhcmUgbm90IHZhbGlkIHRlc3RzIGZvciBGUkVEOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIzMDIyMDAzMDk1OS4xMTkyMjItMS1hbW1hcmZhaXppMkBnbnV3ZWViLm9yZy9ULyN1
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNzA2MDUyMjMxLjIxODMtMS14aW4z
LmxpQGludGVsLmNvbS8NCg0KTkI6IFNvbWUgdGVzdHMgcGFzcyBvbiBJbnRlbCBTaW1pY3PCriBl
bXVsYXRvciwgYnV0IG5vdCBiYXJlIG1ldGFsLiBJZiBuZWVkZWQsDQp3ZSBjYW4gc2hhcmUgdGhl
IGRhdGEuDQoNCldlIGNvbmR1Y3RlZCBsb2NhbCBsaXZlIG1pZ3JhdGlvbiB0ZXN0cyB3aXRoIExL
R1MvRlJFRC9XUk1TUk5TIGVuYWJsZWQvZGlzYWJsZWQNCm9uIEludGVsIFNpbWljc8KuIFNpbXVs
YXRvciwgYW5kIHNlZSBubyBwcm9ibGVtcy4NCg0KV2UgYWxzbyB0ZXN0ZWQgS1ZNIEtzZWxmdGVz
dCBvbiBhIG5lc3RlZCBGUkVEIEtWTSBndWVzdCwgNDggb3V0IG9mIDgzIGNhc2VzDQpwYXNzZWQg
YW5kIHRoZSByZXN0IGNhc2VzIGZhaWxlZCBkdWUgdG8gdGhlIHNsb3duZXNzIG9mIEludGVsIFNp
bWljc8KuIGVtdWxhdG9yLg0KDQpEZXRhaWxlZCByZXBvcnQgdXBvbiByZXF1ZXN0Lg0K

