Return-Path: <linux-kselftest+bounces-24585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C8FA12835
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0791C1615F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1E19005D;
	Wed, 15 Jan 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM3YYsJP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA314A60C;
	Wed, 15 Jan 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957272; cv=fail; b=fM6yDuMSyrx/0bfboLhVWLAB/v+VdGXhZnDua3bXQJ/KiJBVajykYR5Pk/0pSzqQMF7g3YA/XEgqJV2c6CPJhggJBUzMGfGhwySTh1sz1J2+HLA727luPN3dusgm8j387OfUStlBeb8EW5Ysi0qK8/xwsGITUrwFmU2eM5XSCk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957272; c=relaxed/simple;
	bh=l+mKUTX4XgjVtZeOzn12fckpu4Qs2uK2E88AM5LntjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NMFPN/oQ1sXCj8TFlhcuVol73J3BuecSz0NLKAtiXIjiJqiv60CeQE+Gzt2gIv1NsIL9263H0SYtHyV/l4L4Pkcjwghvhr/48G5l9V0/XTVkTJAz8/4WXUX/k8rFdE4IIc5GblHOACvGaYNbcxbYW18MewX+dI2lT8IsM4buKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM3YYsJP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736957271; x=1768493271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l+mKUTX4XgjVtZeOzn12fckpu4Qs2uK2E88AM5LntjU=;
  b=QM3YYsJPB1ycAvV0jhBrejZezOsOwmacEzg+hpTltH08y0HPk/8kPLTI
   2eX6X+AVb2KnBzkLNw6FWThIPfakbN1UFcJkV6JGMWLlojSPuKV2Exn8i
   cGwjRLNHuoe2SA0G5YEJZqBPT8ypg8cnWlMZy5ssRIecg8mDxNeyLfGYh
   ZzDQ5ObBdZdl4BlIaqEhxT0shmk1WVyWomJgFDXUN48pohdcJtjixBRJn
   0XQs809cTGBTYAq8htOP1hJozXLfbRqR36zDLAOKMRhB/uR95pwxmobYm
   mvTCo8j/TmsfWCODUzxw8YILBBo5evl4QDoH1J0hEtojMMytub6BuZD7Q
   g==;
X-CSE-ConnectionGUID: 95g8kKWwSt6onYBZjDifXQ==
X-CSE-MsgGUID: b0qOSM2GQay10gmc/8DaSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="40111879"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="40111879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:07:50 -0800
X-CSE-ConnectionGUID: vBHhzdA3SrSPVN6WbXmRjQ==
X-CSE-MsgGUID: Kp6HWIEdTL2SmyW5xa4F1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110167419"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 08:07:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 08:07:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 08:07:45 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 08:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA6fqowfaKOEPcge0wZuRAc8bE3DUDqHPergtzpQxYJVGZlZgRHe4H1pQw61fCZTgfv5dfX5DCPHoI+NfUpMzMYYO+z69y8j9EkAjyRZm2t4AB6HzML6eESaM7t30ZCEu7GRRl/AJBhSXSVQzCV4k9r5bgC+z4Xlq0/xMNNtf2vIWkrG28Zi8QohKioDZFDV8orIg/Pq0k8qK1DU7Ei+2of/garj9NdK+0p+/PwdmrD9gA2nHFe2IXl8G8ldauP8nMtfod97HGbkW3kRoSLOA69tpFowMz3Dcu1KbnI1u7Y/PmQzuAQvmf84YzUWLK0qgt/3/50D+B4YwRKs6FoCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+mKUTX4XgjVtZeOzn12fckpu4Qs2uK2E88AM5LntjU=;
 b=Vx8G7m9W2nxWhsZlWWw07Pnd2Eqsxje2ZS5Ko9JJkQBKAkmakHmQPUnbuIi5yTiXPZLP57x/Ko8GYfe+UpRUy8UTtdhrdnNHMMXTFAHDYUdTynBcRMKRjjGJMep/dmIOR/phU3C22LlYS3ICH5YIG+wpd3g8k5ocxP/o+G0nur4XoXMgPVVN5BOmTBQJlc6rzYv0hpyMsb5fyJTzl2fk0Y1FI925fA7E24pxxxpKe0YT/qGj4otSXZicJExoIe9C237g2PS9fv+Fg70WVqepYnoG0tO3XlZe6ZoAopeFZjg7ify9GJHoiVm34hI+RGlwesJCCmXnVYaq0drkWz9+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 16:07:29 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:07:29 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "Damato, Joe" <jdamato@fastly.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Mina
 Almasry" <almasrymina@google.com>, Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v5 2/4] selftests/bpf: Add launch time request to
 xdp_hw_metadata
Thread-Topic: [PATCH bpf-next v5 2/4] selftests/bpf: Add launch time request
 to xdp_hw_metadata
Thread-Index: AQHbZpj4tA6LH2vFfkKKBd9KW6OKwrMX7isAgAASx8A=
Date: Wed, 15 Jan 2025 16:07:28 +0000
Message-ID: <PH0PR11MB58300DA3845D1E3F788C4FC8D8192@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250114152718.120588-1-yoong.siang.song@intel.com>
 <20250114152718.120588-3-yoong.siang.song@intel.com>
 <e273b1f1-868f-440e-b226-84b493ef7ee2@iogearbox.net>
In-Reply-To: <e273b1f1-868f-440e-b226-84b493ef7ee2@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CH0PR11MB5233:EE_
x-ms-office365-filtering-correlation-id: c4a7fdc5-0ad5-4eb4-9ab0-08dd357eb5d5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YlBaYXo4V1dUR0s0dkl6NG9SN29TNitpdFlsY0JSdDg4Qi9CK0ptVERFa3U2?=
 =?utf-8?B?QTlPZ0ZUc2crbXlQNVl4OXVlWHRjMHY2ZFh1cDNpQUlKNmRtL0d0ekJIQjFX?=
 =?utf-8?B?RUFMYW5qUGhTUlRrcFlJak9tcTRHbEgvM0VBc2pXTVRrbDh3akRrKzk3czFO?=
 =?utf-8?B?LzdxSFRQck1Qd2VuYnkvQTBIclhyczNYa3ZoOWdyMDRIbHFxWkVQaFBaWWVp?=
 =?utf-8?B?WDVuUTBYRnQ5STN5dlNwcitaVmVTdUtCTFBDMnRyNVRFemN6U05CVHZJNGt6?=
 =?utf-8?B?ZEtyRE9xUEVzOFhlWHJXY2ZUcUpOR01seEVNRnI0TUtXM2llQ1FoWmkxbndw?=
 =?utf-8?B?QnpEV1RmS0NnMkdNK1VoS24zYTlMZnRGKzkwR3E4OG9EZ0xWd2l4RlpsY1cx?=
 =?utf-8?B?UFo5Q0FrU0ppV1A0NjZ4UTdLMGs5aHJ6bWFtSHpLZ2lDRHVYV0ljaG5XWlJM?=
 =?utf-8?B?ZHo5WWFPSndRdDVPOXltbHpsK1ZmdytibkR2QkR1ejNkQnF5T0tqQXg3Z0t3?=
 =?utf-8?B?d1NOV0dYcVFXQVpyR1k3UmhnMnI3K2RMOHFENFhEYitMMHNKUW9iM3NRTWVp?=
 =?utf-8?B?QXJSRVVyTGZvZjc5UzJrZWoxOTZKZ0F2WmtITkw3WTM2MTdwWXlsR211Qms2?=
 =?utf-8?B?eUorMGhFV2xlbnZKdzh3UmtseUhTY2h3clU2T2RJeTllMGhJL3VzdWd5MVNL?=
 =?utf-8?B?cGIxYzJhUnM0VTBMU3VrY0pTaUdaOGFGRkRrNk1Qb0IrdjdqQmE2cEFVclcx?=
 =?utf-8?B?Lzg2ZFZzaVBBVGY5TjQ5enZLczlDVTg5OEdDakVHeGpvQzFOb2NpTDdScHUr?=
 =?utf-8?B?NDlDYXdOcDJFcGswVnF2ZlJVcVlaWVJZTWszeUluUUUxVXFob0xYT2pidXc1?=
 =?utf-8?B?VXVEUFBkb3pXREorS2V1d1ZwR0gzdVljeWJET0g0L1Y1R05iREo0NTZZSVhW?=
 =?utf-8?B?czlOS3diMS9QRE85ZFN4R1EwT1JPL3Y2dEo0M3k5Y2drUDVBN0VINlp3Nzht?=
 =?utf-8?B?ZEFVQXhJRUdNTGZLTkdLcFVlRVd5SkxvZjdPRE8xWjFSNWZvTE94RXFJL1Z5?=
 =?utf-8?B?WUI2TlZCM084U3ZYRVRBb0wvYlh5dDdZanFmZlZ3alovNDFsdzJOSTVvaHhE?=
 =?utf-8?B?YXN1eFFxTTZOb29lcEdKMXN1eWNiekJRc3pMS00xRis5dmdsVVlQNm9NeDRR?=
 =?utf-8?B?RTF0UzF3RWJFbU5lcG53clU0VEY2VUpzQ0pXakYyY3R2UERNVGMwQVAzdmtv?=
 =?utf-8?B?dGUxdCtUUEZJcElDWUoyaEdxb1hVYWZtQktPU2ZER1FnV091NDNuYXZZUVhO?=
 =?utf-8?B?UEtEV2NKajlNSzc4RTNNVjZEMmYyT2Z2c0lxZWp4ZjVTbFVnY1ZmUTJpMmhV?=
 =?utf-8?B?YTZsNFNHYXJSK2xKR0xRT3FOd1NFdGE2VTQ3QTdLcUVzN1dPQ1d1VmtMbHda?=
 =?utf-8?B?L25kRGFZVHdBWEJRMWV2SXFxTEJVKzJ5ZThOMXBPcWVzTHlSUjZ4ZjNXZ3dp?=
 =?utf-8?B?RW55NmRnUDF2M3VNVUFiOTF6eVQwZ1hPcGNNeGQrVTc1Tit0VFVXUnIrTkRx?=
 =?utf-8?B?Mm11eGZkR0wyOVRSZEVQTmFldmdVK0JKcnRPNTBURDVRRUFia1JHMDBJUmdS?=
 =?utf-8?B?YTAvRTNUUEUrQmVtT0h3TzgwczBUSEgvTmRvTjU1YUwrMW5lT0g4bngyWGtZ?=
 =?utf-8?B?cnkra0x2QVhnYXNlMG9lcUtQU3JLZS9ZeForTGFLMjBDRW9tQzNub1RNbUJO?=
 =?utf-8?B?blFpU0FFNnllWmhYZ2E1YkVQUFFKaTk0WmhEdkZiM2s5cHRGSHQxT003ZVF0?=
 =?utf-8?B?eitGNlY1N0lsbDZURjZmcklmVy9zUmFUUDM2UlpBM2RJODJOMzR6MmdzK2pJ?=
 =?utf-8?B?N2ZxMkQ0c3dUOWQyWmJIaUV6c0xPWjEvMFhNcmh0TTdaSTNWdzlLSER4Mzc5?=
 =?utf-8?B?MjA5a3R5eS9CbXZTblU5K2ZhcG9SYkRILytyR0ExbUJ1WUlKcURqSFpaTGNw?=
 =?utf-8?B?Z2hQeTZ1UUhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFI4KzhUb0xHVWxJL1Nkb2swSzk5K21tVzd6eGxHd3ExRGYrdEJBVHVWb3dx?=
 =?utf-8?B?OTFGRitlTENJOTNyaEdiZExtL3VzQlY3bUlxUkEwWE16eE5Qc2ZjWDF4SENY?=
 =?utf-8?B?akI0MnRwaU1GelQxM2xBOHdtbGdiVHN4QlQ4VVc5SlpmTnNmb0Frd2ZUWjND?=
 =?utf-8?B?U3o2Ylo1TGI2U0FUSHREOGdMYVpIdGppMFFEbFR3dTlkb0Eyd0JXZEFrZVhq?=
 =?utf-8?B?RUNlM3luSjduVWtWTGkydmxWTjhzMDFWOHppT3JQaWloSG5menJTNDYyU0M3?=
 =?utf-8?B?Vm0vZFQ3R2kvejBEUm9aN2pUa3RKWGEvRXdtRDh5cVEyTDl0YStXTHZMMnpF?=
 =?utf-8?B?RWZOeVRBYzVpcndPcW5HU0FGdlF3dzdGTjVpTXFsSEZvZUk0bzlnRzhPbEdM?=
 =?utf-8?B?WE83ZkxDdndPcFZkeGZXelVxOGRESDFScm5kRzBOU3dQaEtHMFRPOVNnQUxQ?=
 =?utf-8?B?S3lqVi9UM290anQwdjFMTWJxUXFLZ05VOTB1dnhtMFhuSGptR1Q3WVZTZWgz?=
 =?utf-8?B?WlZEaXBFNythbmYwTWxOTjB4R2pKRmF5Qk0wSmxTc3crNVNhMExyRWx4MU9q?=
 =?utf-8?B?RlRPTEdvLy9DOXhPRjY4bHhCMkNWa3hxNnNRNjROK2plbkQzRWtPbzRYaEZQ?=
 =?utf-8?B?UERmYVQ1UTIwNC9MSUhWNDJDSm1UT3hJTzd6UW1pTkZ3TUJ6L3huL3FDSGk3?=
 =?utf-8?B?M2tEN3prMDU3akROL1k2UHc2SGNjcklrbHZwci9wcnRCeGhFakpuMnFMVWty?=
 =?utf-8?B?bDdpM1VEclphTjZ5d25Nd2R5b0k3K3RCbngzclcyNkFhQ0loOCtTT3Q1QTdl?=
 =?utf-8?B?Rm1mOGtLdkFiaE1zWTBjSE50L1lzcGxhR3RsK1NPbytoajgxRW9vaDNWTFlG?=
 =?utf-8?B?Q3pzNndmU1hjZmFnbnJnZ1VjSkI1aHBFZEZTTlNkV2RHbmtreFpRV3cwbHA3?=
 =?utf-8?B?RWUwTloxS1ZjUlB1OXlWMjQrdU9LNG1LZXJLZllBRHdnREdSRW1HTEVOdG43?=
 =?utf-8?B?Uy9rZ085UkVVdHdqcjhFa2NKa3haVHZEN0lHK3Q3bGk1NVdtRHg0OEwrVGpp?=
 =?utf-8?B?V1RhTmhiSDEzWDdqRm5vMVdwWERRZWs2aWh2RzRDODFHMzRubWtCOVFpY0tJ?=
 =?utf-8?B?NDY4WWcwQzhhbTJ1Nno4ZXdnTGVzT2x2OStEbVlrbDB5OHBNVHdPN2pZUGJ3?=
 =?utf-8?B?SFJlM2JLY3pyZlJ0YkI0elJOWDR2aHhuRHJPcHoxWGRsM0ROVzJXU1RVRjlp?=
 =?utf-8?B?RFoxNnlybk1lYzlxVTl5bGlnREdacVpFSEs1N2RULzdibC9TRlFEVjBGVjJr?=
 =?utf-8?B?b0hHdTN1d1pKN3pWd1JCQStNd05nRUwrRXJpSDgzZXF6OEl6RjJhdmlzaFNr?=
 =?utf-8?B?UWhsTDdsK3hQSGpkZ2ZKQjRNQ1NvNWozVEpTbVlSaUYxTzBGYkVWelpUVmpR?=
 =?utf-8?B?THdINisxT3ZSSHJxbVBKKzN0bWlJZlEwYXRaWDdJNUJJWWpjWUhIS08rSUdB?=
 =?utf-8?B?bzZ1R1A2QzMwZmtuMTM4MU1YeG1kRmlUajhldWYyNkVRcVlXdXpGdzdVZE5r?=
 =?utf-8?B?UkpWdmR4T09TeXMxbjdSc3RBemQ1bXVPV04rR3Rza2dqRzJDMEFGY1Q3L2ZB?=
 =?utf-8?B?QWhXaU5kTnErUmhSYndXNVVHdmNpYithVVpYSFprdmtnN2cybXZLQ0R5RjNP?=
 =?utf-8?B?M05uYlhTZVFGYW1TcjlKZXJzeXhzSWtsNVN3Y2VJRmtPazYxUFRrSU5kWGs4?=
 =?utf-8?B?NXhiTG9lUGVzNmlJWGpHUHRhRDcrSnk0NVVBaCtwY2FQM2g0UzlSQXB0Uk9U?=
 =?utf-8?B?ZGh2M0g4STFlc3A5Sm9va05sR2JqSlRNb0RvcW5UVnVySGJhN2N1SWJINWpv?=
 =?utf-8?B?bUxiOUUyNVJ6VjJjc2lOc3Z3SjVUaStFaE1Rc0ZkYzBUb2ZCaGhzTXJKK0ww?=
 =?utf-8?B?OUYrQWFJdzZZMEY0WkRTOGlXSVAvaDErMC9scU1MWTk4dFlXUi9YMm92bXBH?=
 =?utf-8?B?bFJNNDU5SGNFbk4xeVJRUzNJd0ptSDM0dnY5aTAwTVg1K3hMaC9LZUo0OUhh?=
 =?utf-8?B?R0xBeWU1RmJZZiswUHNzSldzZjQ5eXVnZ0Zoa0hCY2JMZTVrUUtpVzlkb2FT?=
 =?utf-8?B?UzdJVlBoUHdGWXJBelR5NlhWNnNCMVM2R1ZQdHl6MDdLbStSSEJjZTBIVDVz?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7fdc5-0ad5-4eb4-9ab0-08dd357eb5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 16:07:28.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YDbExcS/3Z4mCkTF3uftPI+QAT3s5DmUa5RROSuIMQh2+/51TsruHOu+yzb9VmsxOmXNSUA6KMLnpPTYOW0CBPR7Z9prC8uV/88xjACZDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDE1LCAyMDI1IDEwOjU3IFBNLCBEYW5pZWwgQm9ya21hbm4g
PGRhbmllbEBpb2dlYXJib3gubmV0PiB3cm90ZToNCj5PbiAxLzE0LzI1IDQ6MjcgUE0sIFNvbmcg
WW9vbmcgU2lhbmcgd3JvdGU6DQo+Wy4uLl0NCj4+ICsJLyogQWRkIG1xcHJpbyBxZGlzYyB3aXRo
IFRDIGFuZCBoYXJkd2FyZSBxdWV1ZSBvbmUtdG8tb25lIG1hcHBpbmcgKi8NCj4+ICsJY2hhciBt
YXBbMjU2XSA9IHswfTsNCj4+ICsJY2hhciBxdWV1ZXNbMjU2XSA9IHswfTsNCj4+ICsNCj4+ICsJ
Zm9yIChpID0gMDsgaSA8IHJ4cTsgaSsrKSB7DQo+PiArCQljaGFyIGJ1Zls4XTsNCj4+ICsNCj4+
ICsJCXNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICIlZCAiLCBpKTsNCj4+ICsJCXN0cmNhdCht
YXAsIGJ1Zik7DQo+PiArDQo+PiArCQlzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAiMUAlZCAi
LCBpKTsNCj4+ICsJCXN0cmNhdChxdWV1ZXMsIGJ1Zik7DQo+PiArCX0NCj4+ICsJcnVuX2NvbW1h
bmQoInN1ZG8gdGMgcWRpc2MgYWRkIGRldiAlcyBoYW5kbGUgODAwMTogcGFyZW50IHJvb3QgbXFw
cmlvDQo+bnVtX3RjICVkIG1hcCAlcyBxdWV1ZXMgJXMgaHcgMCIsDQo+PiArCQkgICAgaWZuYW1l
LCByeHEsIG1hcCwgcXVldWVzKTsNCj4NCj5GeWksIGFib3ZlIHRyaWdnZXJzIHNlbGZ0ZXN0IGJ1
aWxkIGVycm9yczoNCj4NCj4gICB4ZHBfaHdfbWV0YWRhdGEuYzogSW4gZnVuY3Rpb24g4oCYbWFp
buKAmToNCj4gICB4ZHBfaHdfbWV0YWRhdGEuYzo3NjM6NDU6IGVycm9yOiDigJglZOKAmSBkaXJl
Y3RpdmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQNCj53cml0aW5nIGJldHdlZW4gMSBhbmQgMTAg
Ynl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDggWy1XZXJyb3I9Zm9ybWF0LQ0KPnRydW5jYXRp
b249XQ0KPiAgICAgNzYzIHwgICAgICAgICAgICAgICAgIHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1
ZiksICIlZCAiLCBpKTsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn4NCj4gICAgIFRFU1QtT0JKIFt0ZXN0X3Byb2dzXSBhcmdfcGFyc2lu
Zy50ZXN0Lm8NCj4gICB4ZHBfaHdfbWV0YWRhdGEuYzo3NjM6NDQ6IG5vdGU6IGRpcmVjdGl2ZSBh
cmd1bWVudCBpbiB0aGUgcmFuZ2UgWzAsDQo+MjE0NzQ4MzY0Nl0NCj4gICAgIDc2MyB8ICAgICAg
ICAgICAgICAgICBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAiJWQgIiwgaSk7DQo+ICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn4NCj4g
ICB4ZHBfaHdfbWV0YWRhdGEuYzo3NjM6MTc6IG5vdGU6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBi
ZXR3ZWVuIDMgYW5kIDEyIGJ5dGVzIGludG8NCj5hIGRlc3RpbmF0aW9uIG9mIHNpemUgOA0KPiAg
ICAgNzYzIHwgICAgICAgICAgICAgICAgIHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICIlZCAi
LCBpKTsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gICB4ZHBfaHdfbWV0YWRhdGEuYzo3NjY6NDc6IGVycm9yOiDigJgl
ZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQNCj53cml0aW5nIGJldHdlZW4g
MSBhbmQgMTAgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDYgWy1XZXJyb3I9Zm9ybWF0LQ0K
PnRydW5jYXRpb249XQ0KPiAgICAgNzY2IHwgICAgICAgICAgICAgICAgIHNucHJpbnRmKGJ1Ziwg
c2l6ZW9mKGJ1ZiksICIxQCVkICIsIGkpOw0KPiAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+DQo+ICAgeGRwX2h3X21ldGFkYXRhLmM6NzY2
OjQ0OiBub3RlOiBkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFswLA0KPjIxNDc0ODM2
NDZdDQo+ICAgICA3NjYgfCAgICAgICAgICAgICAgICAgc25wcmludGYoYnVmLCBzaXplb2YoYnVm
KSwgIjFAJWQgIiwgaSk7DQo+ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fg0KPiAgIHhkcF9od19tZXRhZGF0YS5jOjc2NjoxNzogbm90
ZTog4oCYc25wcmludGbigJkgb3V0cHV0IGJldHdlZW4gNSBhbmQgMTQgYnl0ZXMgaW50bw0KPmEg
ZGVzdGluYXRpb24gb2Ygc2l6ZSA4DQo+ICAgICA3NjYgfCAgICAgICAgICAgICAgICAgc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgIjFAJWQgIiwgaSk7DQo+ICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KVGhhbmtzIGZv
ciBwb2ludGluZyB0aGlzIG91dC4NCkJ0dywgZG8geW91IGtub3cgd2hpY2ggYnVpbGQgY29tbWFu
ZCB3aWxsIHRyaWdnZXIgdGhlc2UgZXJyb3JzPw0KSSBhbSB1c2luZyAibWFrZSAtQyB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYiIGJ1dCBjYW5ub3QNCnJlcHJvZHVjZSB0aGUgYnVpbGQgZXJy
b3IuDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQo=

