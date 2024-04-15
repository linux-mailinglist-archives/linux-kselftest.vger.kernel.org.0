Return-Path: <linux-kselftest+bounces-8010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A78A597A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755AA1F23949
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7113666E;
	Mon, 15 Apr 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8TUpQGz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185E1E877;
	Mon, 15 Apr 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203945; cv=fail; b=BDV5P44gmzd2AC+dl+VFeTMuYV23OiVLM9AqA5P8msVViE+VGvG0+OXf54A7uwq+8QJhoAOViJMpaHj4cda3op7m2VwubZl1foptp+5ULf43qUHNSFZcoI1VEhDRiBRGzbXhKK/6WB3X23dgcKj/W8kIZ2FNeXxunm50RmZqmV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203945; c=relaxed/simple;
	bh=qJjzSLIN/ZlSO5Ini7QlGJE5HUzGuEDx0aGUMMZKrXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jBz0ZfaoEjyktB6fuoAncCdUYl9nvRf1z7+LqGrILCBJGCYkd3DoYgxerj5+6V33SBD/UG6Wb0s+MTuCrv3BTGTuXOo7d2Kcbmvn7Ppxm1W2b+4UZ5Vk02jBjsBm4BmMzaJxvNMBUKbnM9ArDqsa2Yq5nzS7M5nfIaswD9WYyZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8TUpQGz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713203944; x=1744739944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJjzSLIN/ZlSO5Ini7QlGJE5HUzGuEDx0aGUMMZKrXQ=;
  b=W8TUpQGzFEF+xT+yYXmyMDIgfL+mGx8GTVsYrwdZYk8jjN7g7bVlWAAO
   jPn5CzYhtqazNBRpURGJX/Oo9rkh2DEO1U/HetL0SHA5SQNI1qwL3kW12
   5pVD+3PUnQtvYCq1DhOsZnxPO8t0WbDNF3w8FD+sDL2hsaRiM6qD2OHrO
   y6N0QU+RO3OdE5W1txuFHg8dj+w7xz3u4RD97ZbMtQNymnvU671dJkYcA
   EFyqamj4H1JTve4MDBBs13oa0kQegO2kjKzzDyRA+UP6vdPv+ZXGF7xqM
   UZu8m800NKIxOHX/uXGjHHH6+mKxaQ2Q0Vm3RtbG+vwUD1OuwV10PC45e
   Q==;
X-CSE-ConnectionGUID: w1GyVOtFQsOoB7oMnpkfBA==
X-CSE-MsgGUID: uAdkpCejRVirkRYW4Qlj/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="20000557"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="20000557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:59:03 -0700
X-CSE-ConnectionGUID: ocxAKWR/TbGRcScbB+Kjzw==
X-CSE-MsgGUID: Wv3iKpOuQweSeqWmZdIdPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22085601"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 10:59:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:59:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:59:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 10:59:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd7j5eN8ATshp9SCCZRKpqAzZ+4vM+yc+RLHV2qqF29cR+3Pi3kbuOpY2WcagY9DrI4lZpXtheb54b4c/Bw3tZWZ6Noa6q2uq5zLnMAbLaQAT2Fizq4maVZOBkMhpbl8jKjN8IVQKTi4I8/82B8LjdpTntRVnzh8hkzPGY9nwNxlu6v2LVfMyPeVhEHXcaMy4ysulDdG26T/1jnb6cfo+8xyOX6QBUFh/ctASBZqg9F3YddoBjLsgPHRxQhXx9tIkY3YD9/zC23uE4JkaYDnPrHneSZ19+oUYCbtrMSZ3MZVobG3x12DmXzyYTFgvqnljDpT6G79c0VRM7D3eDUugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bayyVvfLEsNfZG668RnTadlkUrSTh5kh25058YPAfp8=;
 b=UGhWAZcrxxOT9+9pT1fYmRDsyVQaXT1wMRBvhjQU4zl0oH39U6E7wWGhCVEEDHt82iMBQhWUk4U0CdoP1vXSdIvYJ1l7tI+mkbLFmf8iCz4qmSz2utepifoQ1ST7MpG2xei3/irTh0cXxV0uNq0GFtzW1UsC6lbVXslbyJHZ2SWB9qcBKAmH8L9GTed/ptK+7o2g4H/mEz0TA+iay8Grn5JvsaBsbmuTU/8GCYvmsWa5ArPgEqmzC76QB0xOPrrfvaIoLEVFAgLJFkjgTHy8j1Wp5AfNwXumUQYyXdC+SYWBI/GJQwGzGaHHeDx88W6w2dxrBPBK9wynKrO0TAJFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 17:58:58 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e%5]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 17:58:58 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Topic: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Index: AQHaWe9kopIyr6Xnd0e+7GE2THFZGrFqB8DQ
Date: Mon, 15 Apr 2024 17:58:58 +0000
Message-ID: <SA1PR11MB67345E7BB7842141DA2560F5A8092@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH8PR11MB7072:EE_
x-ms-office365-filtering-correlation-id: fa883ae7-ee72-40e7-3121-08dc5d75b9b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: onsjLcsCfryFmNzWIhq5tSI76lm1ffV6/5JkjITv4JERewKqcDyZqMk5TTGKdlslnpN0Z/B6gIKZuc4+eyqiFP1ZV2pZp+LHUAKlckk8I1HNGhFqWEAmHwiIniGDI9QW3pRAtKYG+c4kKNggPTfOAUAMar87Bv5oA+OP1U0QIJmDI6MrLAT+i9fNKAbleM6RlSNkzo/dvil2u4Y4x7z/9w8iQCz47vQY8YNS6Q60vUo/3qUQRgC/axukrmyb+GO06g/6xTGdE7tSR/RF266BVtAjwYP6yYGapot3Q44zYDDZrDonSSMKJvPqolGE9G2t9SfjeKdyDVREqPI1+9zJnA4jdlFeXx+/RnDSILmZt42FaqKaaHpbTUOB0bFSsnZ66u7iTLJxMqHnl/7ndU1ZW1jr8A1bgdO2U4K6ULhfEGuzTX+Wmy628+s+ITa3031x7/EkACVmGw2q9Ecpry3sUR9HdVhVezfHc6cSgTJ0umaXumvxFndolhxbXDn/3+JWK9b7oEwpaTjWWFE7bpAOGHnu1e6hJKxC/MrHjwDxnybKsJGkoIhEJMCXa2ZPDeb8Yg9HKF7YhN2a7weMunhBLBSiZIy4rHwiurcBuz4+EZo8F4cLo9ea+fcjWwu4SU0jKhBvD2ZwFRejmepdxZXIdCNmMLdvRCv41YBmfoYfNvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28ArDaKD9Ub2tUp/CraM0039hTUh0ogJfFCtLjkv4he64FjPR5RkJuprD6sY?=
 =?us-ascii?Q?r4tbkKfQt5JU5DjXPZEo5loSwqCkBh7fuQVoGC7AfzNXuWoSRkF/I9u0c+JD?=
 =?us-ascii?Q?VwkdhakX0Zc3RkTPuaSVclWRSiE1s/ySkoaOcl80xHZO3dDzXogrwDDXqERe?=
 =?us-ascii?Q?a+LDEp9+oOUfEpEp62Mywnhw+anJFQ2ppgjLrQhS7Pvq802eyve+GqxHKDvr?=
 =?us-ascii?Q?W0XtQZGnhSLcTufA1OgjcVAOCpsoy42XhvRknVHCN6xH3FFBDvv9vBppxgp8?=
 =?us-ascii?Q?GY1uHKoe7BW6n65ZWUyUv9Y6kBQr4vuTo7Mjr85K0ugDI+inQv9D3dI3Q4XC?=
 =?us-ascii?Q?bi/4i3kcwFej7FoJkNN/uS8BQkL6kjwMLwya7dn61cNsWuD7VNeB1QleY1w1?=
 =?us-ascii?Q?tDiezM0a6gGe8UI1tEzzcgV2S8HXD5Phs8jXbcIm5Zkn6m+JR5XLQWMnvcxW?=
 =?us-ascii?Q?h/g4P2lQ83DakFq67KSwhNJi0JXthYqf1xIG2JDNe9rcsk5TOBSwF/3xfgGK?=
 =?us-ascii?Q?TyMoDpWafcUqpfbDnG6thtk0NSm87bOvGzLL9vQrEKfhzaqh8Cs9n8++XdB8?=
 =?us-ascii?Q?yf1a+yPetWEznuvVJUhLEhT0wJ95OGN1FeDCOmnkViXaedYzTmK05SlV7ipc?=
 =?us-ascii?Q?8J44XxZewFdqHmrErM/CdgU8/ySeA9nk01FeZ9wLIlmY+KrS5zpM5U+rEVnk?=
 =?us-ascii?Q?4HpQohqMKVRjUqX26/L5QpaHaU71Z/PCihPEKtIHQ8IS+LPRyJcIWq1GdWjD?=
 =?us-ascii?Q?lhwAmG/qftQBl5up5jkPcQ4wogqEzdkMLOVmG0UEMchW0Kv9VfowFlFVMDaf?=
 =?us-ascii?Q?+hkqPtbU//e0tMdiF2q1Qvm700sO4ijJuQAosbxsSHbiXvmmxvjK/+r9uimn?=
 =?us-ascii?Q?TZJSSn/6PcUcYCe+Cxs1yTknuMIWG0LE8eCDnFAJJQsO1loglVJY12E8Ify9?=
 =?us-ascii?Q?BpqoB7GY5zRKOSkR2JFDqHto9KaDM5pgNEGHCTNswboZgHFVxd3y1sBFhg0+?=
 =?us-ascii?Q?osvp+mlM2OWJajZdwREiN8aPV7x4VUfHcIZR9up3TGBUkIrp/NT+MNaMfabU?=
 =?us-ascii?Q?Pv/Qg9Do+H9Z2VMEX+Jh0SNBO1IVvbei8pZWjh2xk0P1yKi/eXyKKwp1bfZ4?=
 =?us-ascii?Q?NJbwbIgWC0cqDfh5F+7a6/ORPDGc5BR2OTvLgNaHgW+v0rW2Eai6G7EAPmdV?=
 =?us-ascii?Q?Hpk/PnXjeqzKFdJR6vIWPYLuH3gBOiC1e/zR1NXZ3P3KsAXLZvfKwZB+7si1?=
 =?us-ascii?Q?3j9WW9uNGeysxQ1lU659rb0wSMY/QGYHIgGZyrHs5L/gf0REB0TOvzJvISmc?=
 =?us-ascii?Q?slZIng1/tIvbfhrzCTrh57uqR60BTNcrqiEmsM1Zfi212EmqVWct8LMpP3s1?=
 =?us-ascii?Q?+KZU7KPRKXYpQDTi1DdjfbEuD1TxW7Wtran1zeSS5Kcau0oe/Qp/Em5hSbm6?=
 =?us-ascii?Q?bzUY42PaDdbzdwoZ1J2o5GHsAbUHdHFtjQXZhvuZV75M2l2QRXbZuzyewVJk?=
 =?us-ascii?Q?q+lVAilRv1L80KyhsZBMC69vVpcix68D6huEnnBe5v1DC0SlqqlELluZwSB7?=
 =?us-ascii?Q?j0Of0tayGCLO/bwNtdQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa883ae7-ee72-40e7-3121-08dc5d75b9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 17:58:58.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2+gtSZaYhr7dolW5D58zash0z6owxLFBSL2im96308Q1MtxQUOzkJxuwGj5eMPEqtj+1DiVfqkp39cv7+HVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com

> This patch set enables the Intel flexible return and event delivery
> (FRED) architecture with KVM VMX to allow guests to utilize FRED.
>=20

<snip>

>=20
> Intel VMX architecture is extended to run FRED guests, and the major chan=
ges
> are:
>=20
> 1) New VMCS fields for FRED context management, which includes two new
> event data VMCS fields, eight new guest FRED context VMCS fields and eigh=
t new
> host FRED context VMCS fields.
>=20
> 2) VMX nested-exception support for proper virtualization of stack levels
> introduced with FRED architecture.
>=20

<snip>

>=20
> Patch 1-2 are cleanups to VMX basic and misc MSRs, which were sent out ea=
rlier
> as a preparation for FRED changes:
> https://lore.kernel.org/kvm/20240206182032.1596-1-xin3.li@intel.com/T/#u

Obviously I will drop the 2 clean patches in the next iteration.

> Patch 3-15 add FRED support to VMX.
> Patch 16-21 add FRED support to nested VMX.
> Patch 22 exposes FRED and its baseline features to KVM guests.
> Patch 23-25 add FRED selftests.

Please help to review and comment on the FRED KVM/VMX patches.

Thanks!
    Xin

