Return-Path: <linux-kselftest+bounces-11904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018390804B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE05B283DE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 00:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4031854;
	Fri, 14 Jun 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWvgPd0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343D19D882;
	Fri, 14 Jun 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326375; cv=fail; b=EpTbDFx+dEyObApD69sJ3g4Ld8i3iC3TiF6ipUH8CpGMwBaU0tWpxtj3WVQPmyZTVhbcOk4tOYxuxQn3qh42vVHs1EebNafcGBBPzxa4wkkO+ItvKFUX98A9z1xgQ1yaIPwqcWYA/Q1ivSIBuFIFnZ07NvIoNkCvllYIh8KW3xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326375; c=relaxed/simple;
	bh=sY09CXy59S9UcZhgMxh93YO+vxpW4wxt+jElSYBRXE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlB/L2jGMW+vU0uy/LLuS3u4Ha+yXE5l+ajrYupoXHNn4gv44mF+ZCknZfRdWe5J3gv/86foYMMm0Y695+WWzK/2W2HFSp31SdlpyMeghyEyeCIZ9u6vGjhgbZ2bBzI8mYWrI37Jjq0QIdRQnChZ14/Z17YCy3tWqi7j/Mm8J84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWvgPd0f; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326373; x=1749862373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sY09CXy59S9UcZhgMxh93YO+vxpW4wxt+jElSYBRXE0=;
  b=aWvgPd0f8c+AsXbck9TicpUiRhdlo0reXm+ZRm3MHsccKToLfQaQQJpz
   jnW8Pklev25FM/81xZ/TWuvBzmgt5IaynwDXOhuvJOmdSnCJRqEupqhoe
   kZYMBZ3f5oQGnDVdD7AEqTI3B/Ywy2vk/WgFepUEPTAQHt/n+CiF0dHIV
   Hr9vQZPKIcweLRYoaS6FFu3IahL8sfki6rkDcPBLyqTBN6d7jzw1mXrP2
   z8kSCNtBaWboKvcj6NIyT95v1x/HjgxaLxI0ASJrsBbvLsdRpbdfANZPm
   fia5A8qbUNDFCl7+rqB3uNCOWg7OgtF0Ii1GPsj6AI2uF8ayss6qUYJCj
   g==;
X-CSE-ConnectionGUID: LVeQMt1cQkGSchiEtUCJnw==
X-CSE-MsgGUID: KvvA0fFoRh6vfvslTBN+vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14979216"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="14979216"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:52:52 -0700
X-CSE-ConnectionGUID: HWfD96oVQL2cuFXNCzVhwg==
X-CSE-MsgGUID: EJHxq2sGRcyzsAlMfh45aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71113649"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:52:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:52:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:52:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:52:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USj+BJV6K7GcqagPYgZAMsfj68/sqUxsvKJgj76Uxzumle4WAQi24L2BaG6hThg8wFI2RVTnqmknEWaJbocuhDCB4Lu/b9Z7IOjXkQcYaAxqWfyHy2N0CklhtBSyAEJvW724M/D8xLZj6u7os5VJvJDTUNLnocHZEy4KkOGuJfbTbjB/EBk4p3AAePmPQDzDgaO4ya86N/+sFdCykMVV2cTeQH3MWPY4eVYyI9v9aHi5HRVr8PKd3PVh8dCpSRhsvsDwBCrMgOdtzCxlm2CXrC4lpCFNswLp3/c88XgS0c5Ttkwvp+uUEXuWpc0BboSo6s7gm1ya+g+wBOyoVXWH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY09CXy59S9UcZhgMxh93YO+vxpW4wxt+jElSYBRXE0=;
 b=ReEuOl6f4ESV8RihoNl/ZTJwtXAtRr0srxsMyT01KAhKHGTN6RVOCpvjD6UvE1FhG/NJNChSIK0mBazuYB5sRjp7cSlhTQTcykbiVP8FSShI+EeixZH/t0I5jeIgmrU5v4yh9ybgXIXCV8JAEklK5hp0IFcFruPjslAo4ZgBNEOhYDGanlIPyhiaZpl5ennlErcW31L4ieYTQhW2ekuNwcZiSo0cbZfX9tLgIgSxCC55GJE0EZuIg3O52a3FD/15gvqTgD9AsDqCnqho4JP/OFqncQR7YEYI8p1VS0ftmjkLpmKFu4arfS1fuEsn2zZDR4n7MTxkX99O5vIuWr/DXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 00:52:49 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 00:52:49 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>, "Kang, Shan"
	<shan.kang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "Shankar, Ravi
 V" <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Topic: [PATCH v2 00/25] Enable FRED with KVM VMX
Thread-Index: AQHaWe9kopIyr6Xnd0e+7GE2THFZGrFLh/YAgHtF3ICAAGfpUA==
Date: Fri, 14 Jun 2024 00:52:48 +0000
Message-ID: <SA1PR11MB6734049C386E936AFBC058E0A8C22@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <608b37dbc59a80d32719c8fde8b6979a2b839e10.camel@intel.com>
 <Zms8lRn20MGVVN9h@google.com>
In-Reply-To: <Zms8lRn20MGVVN9h@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS7PR11MB6294:EE_
x-ms-office365-filtering-correlation-id: c716d38e-8188-4005-7689-08dc8c0c5007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?cEt0L3pmWE1udS9PZkxpUGdoWkZXQitjNDFKUndqTzZaSGc1UzlaeldqaVVH?=
 =?utf-8?B?YVZPcGVVWFVLTi9UQitaMFZQOTNselZnNyt6UU1VQTJqdzIrWkZKV1p6VEti?=
 =?utf-8?B?ZGpRK0pMMzRneGVpdmlJaXRJTldETjQyUkdBOFJCTDJRR2k0RmlwS2VjMFBT?=
 =?utf-8?B?WHZ2UnNaVVVFYnl0bXV2SXpZU3dZN3pBR2k5R2xlU2tydVpna2hLRXBZenlI?=
 =?utf-8?B?YlFYM1J0V3h4WnIzcnEyNFhDSzZpcHk2Vk9Ud2I1VVZyVXJNekZGOW5CbUFM?=
 =?utf-8?B?dytMTkxzcHJhUityWkZwR3VvWkI5QnZxMDVoY3hkMXBkZFdXcFU2Z1pWWkI0?=
 =?utf-8?B?VTRUODAyaGxkWXEzOUxULzZXUjRjNWNMK1VBOGFFRVpGT243MDMxL1JrRDZ4?=
 =?utf-8?B?Y0gxaExCcStieWUrbWlBbE9yUmlBUGorZU9POEFIWk4vQnMycU1JZEVraW1a?=
 =?utf-8?B?UXpqVlM5TTFJM2tpdkhtTWdhRURHT1FXZkEwS282bkRYd3FxMjdZTmFra3F2?=
 =?utf-8?B?djJMQzY5MUFIYi9uV3BsRUJXQzZuaGtOdVV0c00yTHdIcjZEZGRFamJ1Umc2?=
 =?utf-8?B?a2o3aUNpY3dCeGpJbUFiRTJBemtJeXVBWFUwV0hYR2FrRTh0TnlQNTlUa2tD?=
 =?utf-8?B?WE1LdHY0dTlTcjNRaTlDcGJubUJDYkQ1WGRwdjZaYi81MEhCb1lWeDltanpu?=
 =?utf-8?B?d21kSmlpMHdoQVdXNHpJblVuNkoyNUEraWlTUVQyMmVKNEZPeEVneDNCQUdj?=
 =?utf-8?B?bEZaT0Z5R1B5RmJqT0Ntaktxa3RuYzhZcFNPcGwzZmNYZDBoQzFvc2V6Y2Yz?=
 =?utf-8?B?ZjRsMCt3UUtQWE5pc2hheEpadzNTV0JIWlFQSVAxcU1QNjFuUFJZTVdkNE9D?=
 =?utf-8?B?NGw1N0s0Mk16aUc0anAvR0dCMFdIWjNZTFE4aXIwTzljcXE5c3p3TE9ZUGJh?=
 =?utf-8?B?TzJRM3RXWTc3b1RrZjBOektjY0hpUzdoS3EwdFo5eVRGc3NBVmdsRlU4OFJY?=
 =?utf-8?B?S2V2SkZHVjBQR0Z6YXAxT3I2R3FvZEJSNTRkQm84V0tSSlB1cDNZUDVEc3B6?=
 =?utf-8?B?dmJLK0Jxa0J3ZjFHTEVjbVQ5cFNlMlRBUndjU1lTZDFTR3ZiNDdGS3NTMjY1?=
 =?utf-8?B?TEhZVFcvanJJcUlZaEs2ZldQbml2R1ZXeUwzR2wwLzRUMWYwUEdreU5Pem9q?=
 =?utf-8?B?Q1k0SUEwb0U2SFAvRUtmSVRja01hT0p1aHdraERZWkpZSEE2a3RtbmRpbEVh?=
 =?utf-8?B?Q3JGT1RRZ2pER0p6aTcyM0lNdXVrTXdRRGV6M1FwZEhLZTh1Szh6MlpjQ2Rw?=
 =?utf-8?B?Qit6V3I5K3ViVHZ0Ky9KaFBQT0FNY0JWT0hKWmpEQTN2MWlReXhkZ3hpWGlT?=
 =?utf-8?B?b0tyRzBJdHVPNWl0bDhEK0duRHd3bmMzaEhodTg5djg3VUY0NTZvbit4aTU1?=
 =?utf-8?B?bEVxdk1FMzl0eXc0U2Z6elBDKzZmZm41QlFBRFJRNHFxZDY2STVZRUk5UU5P?=
 =?utf-8?B?bjRwSnVzVDN1aEE1bDZHTGdNb0thZHl1N0J0dk54N0taVzJYSFl6UU5BdEVH?=
 =?utf-8?B?b0FRV1p0dEQ0VSs1MG1Xck5sYUZkem80bkNhSGEvSGNjR2pRaXVxR3dNWm5k?=
 =?utf-8?B?Sk50VW1VZEQ4TEJzaTZKbHZKQkFnZ21jMkRpRU5nSTg2WUxGZ2k4NCtISEF6?=
 =?utf-8?B?TDI5bEw1S0VlRUFjTytsY3pSek9qaW5xV0tpV0tFbGJpamFaQ3FJdUh5Yy9D?=
 =?utf-8?B?WWI2YkJLb2Nha2RaM1BPdTFJS3JXNE5tc2I3VDVNOEJueWtBQXZoMEJSc0Fh?=
 =?utf-8?Q?PdRnjNS/gotzQdie20ljkEdi5bqn3RcfrE580=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdZUFJMWWM3bWdLUWtEWkdaOHNTdkhna1ZyYmVldlkyUnM1WTltUGd5VU1Z?=
 =?utf-8?B?OXFOTzQ5K2xEV3JMc1dRSlAxVkZpUVVsajdJQ3NCaU50cXBGbzFMRDdobXl5?=
 =?utf-8?B?ZDY3eG9vbWoxejNVNVBKUkxaSVhGWWQ2aUtuSmh1dTlZVFNCQzVkZTNkamJY?=
 =?utf-8?B?TW9TRmtIaUxwREFNcGE2Si8xQWl3Z1NhRmpqdkxpaGVDSkJNc0lWZTZKdFY0?=
 =?utf-8?B?UmdDNlAxUXo3d2k4VERCVFFhdHJnZWwwWjNuOWVjTVdlaEh6SmJWVlRNdEE2?=
 =?utf-8?B?bzduK0pXOVowbWlXWnBQbE9YMElyOGxoVkNwZHVrdUdNK3gvVEM2Yzl4U3M0?=
 =?utf-8?B?aTJhck05Q0ZBMTZFNDFKYW9nYnVBM3dhdDFwc0w1U2dWSjRSelZ0WDJVMlNv?=
 =?utf-8?B?Qm1od1ZZSDhqeDVJV1pab2FibnhNQS9jOEQ5TnZac0tzUmtFTkNsRzBUWjdk?=
 =?utf-8?B?VDVkRURPN0NKSlNVT3l0eUhrV2JuclFoRGtFREx6YXI4VFNDZzFRR2NqcFcr?=
 =?utf-8?B?ZEFuSEt0dTNIbTdjdnhiczdGNFRhMklWRngzYlVwVXpXcTVLMUUrUUVUQkUv?=
 =?utf-8?B?VWxpTzVFcE9jdWl1MldaSEJwNUR3U016aW1YNEtzRUF5TGhvMmJTekc0eEl1?=
 =?utf-8?B?c3o1YlVaVVRQUnlZVG1HZHR2QndYZkNyR2pDQ3JSN2cvVU5tQkhnUDg2cCs1?=
 =?utf-8?B?dFprWStMVXRWd2xxNExiazBtY2I2ZDY5THBWSkJMdUdPbzVWdVFodjA1Nnpz?=
 =?utf-8?B?ZjZseWdUL3dxNG9sN2VuYkZBT1RtdnVIZ0R4Z0wyeGtNVVF0NThuem93VGE5?=
 =?utf-8?B?blJKWVJUVVZQOWpoTTJzUVEyMXBpUmtMK2FvQnRlMnlLNjFoV3VBYXMzQ21M?=
 =?utf-8?B?WVZjNHhva0Z1bDZORGROWmVVT2wrYXZVWlk4c0NKYTNBVUx5VkkxVWtadHhC?=
 =?utf-8?B?QkI2VHZJWURoMzI1dUFadW5DY0dTVUx2RFZmTUM4cmZLN1lpSG54dFRuL2hL?=
 =?utf-8?B?Vnd6U3FXS3M0TVBicDdZTE9hOGdTVTdua0VOa2U4WXRPVjZZWGNVMHZrV0hG?=
 =?utf-8?B?azl4NS81amIxa2E1RG91bjhZdTFVM1VqUlRUUENsNEtkbFN2bVZadEo3L01M?=
 =?utf-8?B?b25jQ3U2UThDYXpSUW9BTVFTb3JmaWdmeXVwQVBiWkI0dkFoTjB3bXdhSVVZ?=
 =?utf-8?B?NkxoV3hYbWVWa2twbGtsdkxaeFFBNUVjSVZ5cWJMRzRpdEx0L0VnVUpFc09X?=
 =?utf-8?B?V3NmK2w3MWd6dTNvYy9GTnJVOURUZWhTb3ptMVp0bkRjWlp0cEcrM3Q2UGZO?=
 =?utf-8?B?QW9XOUdqVnNqdnZYWStqbER1UkNPYWxGc2FWTmpkWThXeGhYdk53TU03Qmxu?=
 =?utf-8?B?N3VBZTdHZWlIN1htTUFZWC9DYWlhczV5MXg0YjNQWWxNWW01Y1BQZWpORlp2?=
 =?utf-8?B?YVpPRm93TDFGSW9aYUVNbFdvVDdXd1BjRVlaM2VKZVUvejhUa1ZvdmtadGJ3?=
 =?utf-8?B?ZmgxNEgwU1FMRXFNVkJKSEVROVY1Sy9hVWZ1TnoyMXhPMWZwcmY3RHBNVlFr?=
 =?utf-8?B?M2duOHIrdkpqU2Vsd0hhUmM2NW9ibUZqdGZuNlhvaGQyTlBTdjMzMEwrMGRX?=
 =?utf-8?B?S2JndDhPVmE2cWh6cGorU0pPN2VBY1A1MmROTHpKZVI2ME1YTG1nc080YXZ3?=
 =?utf-8?B?REZpWEhkeHlEb0hobWpsRFR5SHhyczIxc0luS1pQc1Y3Q3dqUGpQb3Fycmhq?=
 =?utf-8?B?U3BaQ1N4SGladm44MHFpV1EvZC9sbXE4bVViRjZPNklRdm9NZHhpS2pJN1pV?=
 =?utf-8?B?TVl3NXV5b21vbzdZd0ZFU2txdVh2eVVYaG94TTQreTRTOHBwZ3ZMWlRweENE?=
 =?utf-8?B?WGprbmQraWJmblhVcC9Ga1VLWjVaaTZBSVBpS0JzQ3FheHFKK3VDL2pUSk5Z?=
 =?utf-8?B?MGpnNktWVzlLeTIrS2NKQkRmSEhZTkVHNEVzQlVUc3I4Z01XREM5cUhoeURG?=
 =?utf-8?B?RUFFeXNwRDNqTmFSQ0RYbytEQk5IS1UwYy8wZUJkVWpzL2piUVIwdlZNaTJj?=
 =?utf-8?B?TlNjL2I0L2ZvODM2SzUvV1J1WDR3Z3Zsdmpkb3VxZjk5clVNQ1I0enMrbHNn?=
 =?utf-8?Q?gZWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c716d38e-8188-4005-7689-08dc8c0c5007
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 00:52:48.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwdm/SfYBIb9cox7jevqvUpAw2nKPfAOE/Vy7zybbD/VF81Av7/ZdbLpckyXts4jxAPGhHWyOodg1RHeTlEQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com

PiBPbiBXZWQsIE1hciAyNywgMjAyNCwgU2hhbiBLYW5nIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAy
NC0wMi0wNyBhdCAwOToyNiAtMDgwMCwgWGluIExpIHdyb3RlOg0KPiA+ID4gVGhpcyBwYXRjaCBz
ZXQgZW5hYmxlcyB0aGUgSW50ZWwgZmxleGlibGUgcmV0dXJuIGFuZCBldmVudCBkZWxpdmVyeQ0K
PiA+ID4gKEZSRUQpIGFyY2hpdGVjdHVyZSB3aXRoIEtWTSBWTVggdG8gYWxsb3cgZ3Vlc3RzIHRv
IHV0aWxpemUgRlJFRC4NCj4gPiA+DQo+ID4gV2UgdGVzdGVkIHRoaXMgRlJFRCBLVk0gcGF0Y2gg
c2V0IG9uIGEgN3RoIEludGVsKFIpIENvcmUoVE0pIENQVSBhbmQNCj4gPiB0aGUgSW50ZWwgU2lt
aWNzwq4gU2ltdWxhdG9yIHdpdGggdGhlIGZvbGxvd2luZyBmb3VyIGNvbmZpZ3VyYXRpb25zOg0K
PiANCj4gVGhhdCBsaWtlbHkgcHJvdmlkZXMgY292ZXJhZ2UgZm9yIHRoZSBoYXBweSBjYXNlcywg
YnV0IEkgZG91YnQgaXQgcHJvdmlkZXMgbmVnYXRpdmUNCj4gdGVzdGluZywgZS5nLiBmb3IgVk0t
RW50ZXIgY29uc2lzdGVuY3kgY2hlY2tzLiAgS1ZNLVVuaXQtVGVzdHMgYXJlIGN1cnJlbnRseSB0
aGUNCj4gYmVzdCBjaG9pY2UgZm9yIGNvbmNpc3RlbmN5IGNoZWNrcyAodW5mb3J0dW5hdGVseSku
DQo+IA0KPiBBbmQgZ2l2ZW4gdGhlIGluc2FuaXR5IG9mIGV2ZW50IHJlLWluamVjdGlvbiwgS1ZN
IHNlbGZ0ZXN0cyBuZWVkcyBhIGRlZGljYXRlZCB0ZXN0DQo+IGZvciB0aGF0LCBhbmQgYW5vdGhl
ciBmb3IgdGhlIGludGVyYWN0aW9ucyB3aXRoIG5WTVgsIGUuZy4gYSBsYQ0KPiBzdm1fbmVzdGVk
X3NvZnRfaW5qZWN0X3Rlc3QuYy4NCj4gDQo+IEkgaGF2ZW4ndCBsb29rZWQgdG9vIGNsb3NlbHkg
YXQgdGhlIHNlbGZ0ZXN0IHRoYXQncyBhbHJlYWR5IHByb3ZpZGVkLCBidXQgbXkNCj4gc3VzcGlj
aW9uIGlzIHRoYXQgd2UnbGwgd2FudCBtdWx0aXBsZSB0ZXN0cywgb3IgYWx0ZXJuYXRpdmVseSBv
bmUgdGVzdCB0aGF0IHVzZXMNCj4gS1ZNX09ORV9WQ1BVX1RFU1RfU1VJVEUoKS4NCg0KV2hhdCBh
Ym91dCBwb3N0aW5nIHRoZSBGUkVEIHNlbGZ0ZXN0cyBpbiBhbm90aGVyIG5ldyBwYXRjaCBzZXQ/
DQoNClRoYW5rcyENCiAgICBYaW4NCg==

