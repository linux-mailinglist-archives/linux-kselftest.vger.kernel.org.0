Return-Path: <linux-kselftest+bounces-42565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23595BA836E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A690189667D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0CC24E4C3;
	Mon, 29 Sep 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8HqXq4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6D1E0E14;
	Mon, 29 Sep 2025 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129674; cv=fail; b=rjVATLEWxwYQjjOVG1xtKE8wZF9NcnPwofYEJGZ4Q536RrBcTHvvC6v58wX+IwOma0dcLJtnHPnXDloSwL7ie8RxHrmk3BdMVd4Ug0qYHKZ4+JcVOC3Upz+LpLq/gB9zaZBgEPGb5ikkY8Tmm26dZA62J/pb+nRTjb3Wt857YRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129674; c=relaxed/simple;
	bh=Zz9m0nwXV+zWdXFHA/PBUPFLIzFtYFkwF81RSr+OR8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsnQti9+P6dt+itRs0L6ogdBEPWQTQ+Kz25DXwteatREnEsO0cIvuGALaSR24DNl3URtRYC/7mzJS+U+uzkBkSV+RrXgw37QSVE2d2Pf5x6RPtLuFwp1noILuuh6pxp3T/w8HCuS/SnohmtLNLRMctSsVIJ3ObbN9Vby6yP1vx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8HqXq4K; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759129673; x=1790665673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=Zz9m0nwXV+zWdXFHA/PBUPFLIzFtYFkwF81RSr+OR8E=;
  b=M8HqXq4KZtHZLjwXFPCPlY0VKGTT+xW1qeGY9dMAL55EbVhj69swyUqK
   Chl6iEc9HZyLp+0a2Qa/KvZcMVbTSDkRPLY1mhBvb8tU+8LNNdIwTlhUT
   VfiC1Xcooi4w3wwpku2rIUGFs6pCS16BXzkgoUgJF+iHKHR2pUhBWok5Y
   GgmxYIHF9sU7jOyaILGFewZxaATQDy0a3WQlRn+wsmO7xQt7tbGZi5dJ9
   QnLnt69Vb7RScJKJNTzmYs0iAsbApXTvSoccfjczlgcVx5Som9IrXe3ic
   GxuwLSFczYAv3S2Pst3VTDo8sldv4P9pFtpI8U3GUSV92+MPg2MGECx4u
   w==;
X-CSE-ConnectionGUID: aVmsRk12QhalrkVMIGgs9w==
X-CSE-MsgGUID: tqEtTPmiSMWiGaB+CRfjBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="71611580"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="71611580"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 00:07:52 -0700
X-CSE-ConnectionGUID: GO/t/dHYQjyBPgA4W0z0XQ==
X-CSE-MsgGUID: aaBcPnl/SzOOZU6NIudYuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182456717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 00:07:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 00:07:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 00:07:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 00:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg+8hJUiUfn5+KVOK+4elxl7rxK2L9ATMt73hdJC0rEOZkRYuq6CoSjEL6CMdV8rxkKEFfKK7FWhjv3bC0Ao8eTpPRrY9ROwXqyUeO/fS+FZYKuSuLhtd1PUxxQSTRGTMwGLk4oRNJd5d+PLWxFDrWJ9sKZt9sRT5LZD9buAHLYaIzY8/mBEXKm+YNx8rV4nOg3QMyEjyssvjePiS57lm4dYEjf1b2ibW//1TvRJ6x5he8J01kHD1lZgPF3TgaKytMHLurtxH8rFD1IA2CtIFZNjocNJGCAMDqjaO4KfGgm3m14q8LkpQtftfsYDQzBtU0FKYBXkC2wqxcZqbDya8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFKvRvouOytjYp1bDRHwSPdoRXcUWLUE3WAQqEgc6aQ=;
 b=ygNaYLXZOhPu2XD+jaWWOcIl+lfMEr+ahVX8oucrxzdjtALO7VLHkIn09li+fEcPTtPXjQZGtLhlQxQErUyJ3n+17qePdkRdoFew9uTNyjPgoi4MFGpeZ85puNB5QmwZXEj160absUYsOaemw/b2im9Larh6ojz3C77MPVi55yr26XA1SmPx5ohXdpBWb7sM2YxK65ditZMluU6EbQceMHC59LEIE+aets1wb9BbFFXBLpn5TC1XeyclgZq0fgbXuVePJ3KG+7n3QlIZdPhlTYRzhTGbnFXfB/3Y9rohDZ6B8rVjb7P1kOt1XmqMsAzThbMpLwCVE3h/aWSJ/BQl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8285.namprd11.prod.outlook.com (2603:10b6:510:1c5::21)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 07:07:48 +0000
Received: from PH8PR11MB8285.namprd11.prod.outlook.com
 ([fe80::1d05:ba84:55db:df57]) by PH8PR11MB8285.namprd11.prod.outlook.com
 ([fe80::1d05:ba84:55db:df57%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 07:07:48 +0000
From: "Berg, Johannes" <johannes.berg@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	=?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>, David
 Gow <davidgow@google.com>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>
CC: shuah <shuah@kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
	<linux-kselftest@vger.kernel.org>, KUnit Development
	<kunit-dev@googlegroups.com>, Networking <netdev@vger.kernel.org>
Subject: RE: Error during building on next-20250926 - kunit.py run --alltests
 run
Thread-Topic: Error during building on next-20250926 - kunit.py run --alltests
 run
Thread-Index: AQHcMLyAy9OlNwyue0OJD1C/MNPMXbSpGm6AgACgMpA=
Date: Mon, 29 Sep 2025 07:07:48 +0000
Message-ID: <PH8PR11MB8285FB2BB207666DE9814F61E91BA@PH8PR11MB8285.namprd11.prod.outlook.com>
References: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
 <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
In-Reply-To: <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8285:EE_|PH7PR11MB6007:EE_
x-ms-office365-filtering-correlation-id: 2f20cfeb-94ff-4e1e-b0a3-08ddff26e5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Nlh4RWhKSkdTQXNYcXMycUZ0T01oQVExS1JzRG44N0pnTGFzK1NaR3dpWGpD?=
 =?utf-8?B?Yk5ONnl0dysrd0FXN0EzL1FnMjVFN1dvMWpZMk42L2lDUlZpV0hZRnVUZnhD?=
 =?utf-8?B?Tjd6ck5NZWk0eWpsYnUyeXI0VjM4RHc0ZysyamxVa093WnJTN1ZadlR0bmVE?=
 =?utf-8?B?YVhLU0QrMUJKSkRBa3YrS3BGbTlhY0ZTeDR2OHZsOVEwa3NJbHljMGgydklm?=
 =?utf-8?B?dWcvS1FmSHVNY0tBT1l5YlA1MVBBZHJMQkVBdlNsZXhmcGRlL0RSOTBnRUZs?=
 =?utf-8?B?dDZMOHNEd0tQdWRYcjZZQytZYWhEUUc0OUNmVjdkL2tjVmhwOVNCbFVzZ05x?=
 =?utf-8?B?SllqSEdEeXdvQVk3L1cxbzNQaGNFUWVZKy9HS0xvd3AvSFlzdzUrR3I1NFE5?=
 =?utf-8?B?a2hCVDlxMTJ0aCt1OXhJWXVuYzQvV0FUeFB0QUtBQzVlOEZrVXE0NkkyVFFt?=
 =?utf-8?B?eTFaRHVXWjFPWVZxVVBLTTRkMVF6amhVNnkzS1hGeVdHWHdpTUdtTUsvZUlh?=
 =?utf-8?B?Sm1sNmQ1WDlGYVhMYTUzaXNCYzF2VWF3dGJlRmpXS1NHRTdvK2lkNE1xV1Rk?=
 =?utf-8?B?MS9lYk1QdXRvU0EybVZiendxSDZyS05hdU9NQ1lkVTd6Ri9OY1VHWmhjTkZ2?=
 =?utf-8?B?dzQzcDUvUXcvSGJmcDJYTVFZb0NteG0yYko4QllpeGl5UEVlL0NwWW0xMkdw?=
 =?utf-8?B?TTVZL0ljZlp6a1g4RWUwa1A1cGEyZ2ZFaVFmRGZ1d2xYdVJuWmtoZGI3TkEv?=
 =?utf-8?B?UXVpZXZzMlNyRFVkSmlGUnpsVklrQWNkTFAxemU3c1I2NXFrdS9sdENqNnFz?=
 =?utf-8?B?UGZZK1o2dFE5Njk4YS9ITGdrYU91KzkvK2VEdVRYK1VrR0RuS2dkV1p3d0FR?=
 =?utf-8?B?UnZyZ3hQSEJ1MW4xT2JVN0c5OGdFcTVzZzVmSXovSW5ENUtsQUkxZzRBaVlQ?=
 =?utf-8?B?UCtySmJaS1loL2VDYXMrSStweHFnU1psekRTMVRWZVdsZ20vNWdkYWZibXli?=
 =?utf-8?B?VndQZCs5N0JQZlJva2lSblVsdkYzMVVlbk02dzlDdDRKcXdtOFVmVmRmN0Fi?=
 =?utf-8?B?ck1ORDhVUDhVTHZmR0VLVnp6Qm9mMGxPQ01wVG9UR3REa05kc0xNZm9vUHJ4?=
 =?utf-8?B?SGRIcUZuS0RFT0tnUGV5Zk5zbDl0c1F4M2hJVVRFSWo5eDE2MWY3SGpWalps?=
 =?utf-8?B?eXdGRW15WEgyZGlwVWg3VEVPVi9GWEhIN1BUa0JrYTFnSUhOMUZXblJtS3lO?=
 =?utf-8?B?cUc1UUozMk8xTUc0Z3I0b1U5WForbEZNVVpKaFFIdm80a05JeUNsUUxqNUR4?=
 =?utf-8?B?ZWhvbURZeUF5anUwN09zWndMbUJJaFVFTTdtbS9pMFFpOHpCaDJRQnM5SkZG?=
 =?utf-8?B?Zkt0YTVvbE1BSGY2TEtzamhoOTdHNnVzcC9wQmFzNkVCMFVMNlQrWEd1TnVH?=
 =?utf-8?B?eG9SZTlEeVJqL1F1UjF6a3MwZHIvaU5UUHo0OStCdUZ6cDZVNHU1bEVkanc5?=
 =?utf-8?B?S2ZJbHBVMmg3c2daL20yNFN6OU1FTWRmTUtSQjRoZ0RoU1FCRXZVL3VYMXlq?=
 =?utf-8?B?T3pBMmtzeHh2Sk5CTm92bkhWeWVnakhWTmFMb2UxRFo1S050dlk4V2Vab3lC?=
 =?utf-8?B?OHhTYWdWU1RRcUF2SUIxNUxWZlV5U2ltd2YxdVRqQzhqN25CcUNrQk4wajN0?=
 =?utf-8?B?K2hCVU1vcExMRU1ITFNkeEYwU1F6WC9mSE5wNkxQdTdsaVJ5VTRsdnozWEl4?=
 =?utf-8?B?UXNWNGlSREVOZ3laMktzYWFmT2dLVkZ5YWR3cmQyWGpnOG9VTm5GR01RWXh4?=
 =?utf-8?B?V2hHY28xTEZDZmZoTTdZOUgyRllUS3NpcmEwbXJJM2VaZmxJUkpBelViR21s?=
 =?utf-8?B?dHk2cUFwbkpJcDFDOXJSb2F0RnRFNVFoaGN0Mmk2ZHRObHR5LzVncnE5d0xO?=
 =?utf-8?B?RDlxU2FIN2dLQ1NyR05qZTV3SmNlN3M4NjV0QStudXdCZXZIZlUxUHEzbTUr?=
 =?utf-8?B?OGoxcFcxS0VtejdweFZJSFVTUmlCS3lCelVDTFVVWm5Naktvb0lDTWFXUHc2?=
 =?utf-8?Q?RoLpx6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZMdTlENklGc2oyQlpDYll6Vm53M01VTXRVeFdTRTJDcVlFdlNFaWxXWnJO?=
 =?utf-8?B?OEJSck80NkU5VDZjSEN1TXJNblFhYVR3UENUaVVPSzJoVkMvMU40bHpkUUlK?=
 =?utf-8?B?bW9JUFh4RE5DMncyVzFVS1Z2Ui9xbmQ1TGZ3RTZlSUpTemtuYmlnOUtOTnV4?=
 =?utf-8?B?bmFudDExNEpaSDhndVlyZG51MytSZEFKc1c1aVd2NHVURzJybWdzOS8zSzYw?=
 =?utf-8?B?RTE0bnRnZndBeXV2R0pMUkNwcE9ETFVzbURoU2lxRE1yTWdLR2ZQK1pBMVhL?=
 =?utf-8?B?SkZ6QThZL2Ezc05mQWVIaENZazFBY1F4RWUxbGRCeUVkK0RCS2pxZ2duRHB3?=
 =?utf-8?B?ZjlTemxXWFo3N2hvb1NNc3pOTmJjdW1XMEhUSWRpanZiUG8yRWpIYS9zbEcz?=
 =?utf-8?B?WXlBRDAwYWdxdEVTQURyQkZucFQxVmJJMFJTVko0N1FRZ1ZYZjJQUUM3RmRj?=
 =?utf-8?B?cU1BNDdsVjB3RUVaOG5VeGhVSFk2RmFXR0FaVHg4K3NJNE5DVFpTSm1TMTNH?=
 =?utf-8?B?UHVFVE9OTHdHTmE2SDgrOXA4S1ZpUTZLTGJQenlmNDVkeVVxeEdiWGJ0N2lT?=
 =?utf-8?B?cWdITjY4WkpKTk9aV0FwZzdPWjNNSGNIUnRSb0pXSk5ManNsdlh1M0JZZWUz?=
 =?utf-8?B?SkVreFd4cEEyL1UxZFFlMU5ZZndKZ01TZGpqckhxYXB1dTVXNUlGenR0eHJh?=
 =?utf-8?B?WEZOT0dYOHU5Z2lWc2pGNEFnSUtvWmRGQU9KdDhaT0ZEWTBaVy8wVzRPOGlw?=
 =?utf-8?B?SCtDWjNBeHlQdUFuQTFQVVVyd2ozblJxUm55NlFyMWJRK2hPZkY5MFFTcGJu?=
 =?utf-8?B?MUc1WERHSEZ1d2ZmUHZBenBpajBnMjJiL28yR2Y2dDBaNFhObXVLSUk1bU13?=
 =?utf-8?B?U3IzWDBORkd0OUU2SGN6RTZUQWt0TGcxaXlhMkZ2M3RkQzRWM1VIWlFjUWl3?=
 =?utf-8?B?M3djejczeUpOWThxRzJnbVZGaW5rb0h1MDNLZEhFL1JWTVJMWEdpQlhnc2ZN?=
 =?utf-8?B?WnR1aW1PZm9aVTJ5d3lWQ09ra01lcVRNZllpdUpkN0NvNkFCd2o4dkdBV0t4?=
 =?utf-8?B?aGVPVlJCWGwvZkJvZHpmdHFxcXEzb3d2bFZyQTN4WWNENnZlSW5sTm9VYnc2?=
 =?utf-8?B?SXBPZ3BQbS9Fa1ZtS0NNUm55VThQcVYzRnB6dGhqUTJmektkWllmRVFKZmhI?=
 =?utf-8?B?UWs2TWtoNkFhWUZlYVBUUFpOemVSVmxIWVhrRnZ4U1RRcTlEVzNYYUZZZ2RU?=
 =?utf-8?B?a2tCSkdJVGVkZW14YVRPVDFBOXcycFFuV0VQVUtNUnY4VXNKU1pjQW5JT2dv?=
 =?utf-8?B?eWdHR3MwZDY3ajdmUmFRNkU2WGd4Wkxmd0tIYTBDdDVoRGRDeFpPdVB1V25x?=
 =?utf-8?B?OWVXcXNNcUEybTdZL0VJTjFZa3JjSWYxV292U0RUaVVpYnJvTlFNZ0MrSkFN?=
 =?utf-8?B?dFRvMGxxRklpcjJPbk1TMURVNmdnRDlmSG5yR29MQ2JlU3lBVFlzbEZqaHZR?=
 =?utf-8?B?VDVrKys3ZzZVSUNSZTVpRmdKMHZsU3grREU3WVVUZnBpS1E3WTRRWk1ETXJG?=
 =?utf-8?B?TjcySUpmeEVmSmNjWEJ6eHZSdmp2eW44bGJiVVFHb1cxTWNleVo4M1lKYjRq?=
 =?utf-8?B?Y0VPYitUYUh3ZEk4aDFueS9UbGx0NXlJSlJKOG5iak9TTXpqTmwvR09lWkxm?=
 =?utf-8?B?dllHK0RKZFcrbG01RkZyMVN6UDFmSHVtc1d5YzBMUWNJTjQvaVpUYXI2dmpx?=
 =?utf-8?B?ZUxXMVhlNGlsRHpEMEYzSzVOOGh4K3U1MnFpamNLRW1YSUdwWHk2blp3dkRh?=
 =?utf-8?B?bHBpb2d0QUV1ZGVuM1pCU0lZWHFiT3RhWVZDNjU0aXI4TUhoWHc1cE9IRmcr?=
 =?utf-8?B?dlNKMzVQRWQ1bndiS2tmVjhXUS9MdEtzNWRIempUSHBLWWlMNEJ6c1lSR25D?=
 =?utf-8?B?T2VSTHROeUJ1NzJIZjBSSW1lYXh1VkFyNUJFV040ODM5M20wUGtUclBRNW4x?=
 =?utf-8?B?UFlucXkvTTIwZUFrZExNcmZSV2krR3NJSzhORFRpcTBKWHEwSE80ckVydlRk?=
 =?utf-8?B?QmxEOGIwM0xqSklWSTl4ZHh6Y1RJNU1oVXNMYjkzdkQybHlJeFBnTVZ5YXpx?=
 =?utf-8?Q?4ATlPVzeP6/q5vpckgxdZsvWr?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f20cfeb-94ff-4e1e-b0a3-08ddff26e5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 07:07:48.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyMN5cAWOyluM8tFcUfxMtF2VhsH/zeFoGaJk7OuXE/JBonbMkbmXSwQY8/VBx2qMvRWG1p/iAvT8cl8ATQ26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

K01pcmkNCg0KSGkgU2h1YWgsDQoNCj4gPiBJIGFtIHNlZWluZyB0aGUgZm9sbG93aW5nIGVycm9y
IGR1cmluZyAia3VuaXQucHkgcnVuIC0tYWxsdGVzdHMgcnVuIg0KPiA+IG5leHQtMjAyNTA5MjYu
DQo+ID4NCj4gPiAkIG1ha2UgYWxsIGNvbXBpbGVfY29tbWFuZHMuanNvbiBzY3JpcHRzX2dkYiBB
UkNIPXVtIE89Lmt1bml0DQo+ID4gLS1qb2JzPTE2DQo+ID4gRVJST1I6cm9vdDovdXNyL2Jpbi9s
ZDogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9kZXZpbmZvLm86IGlu
DQo+IGZ1bmN0aW9uIGBkZXZpbmZvX3BjaV9pZHNfY29uZmlnJzoNCj4gPiBkZXZpbmZvLmM6KC50
ZXh0KzB4MmQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpd2xfYnpfbWFjX2NmZycNCj4gPiBj
b2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMNCj4gPiBtYWtlWzNdOiAq
KiogWy4uL3NjcmlwdHMvTWFrZWZpbGUudm1saW51eDo3Mjogdm1saW51eC51bnN0cmlwcGVkXQ0K
PiA+IEVycm9yIDENCj4gPiBtYWtlWzJdOiAqKiogWy9saW51eC9saW51eF9uZXh0L01ha2VmaWxl
OjEyNDI6IHZtbGludXhdIEVycm9yIDINCj4gPiBtYWtlWzFdOiAqKiogWy9saW51eC9saW51eF9u
ZXh0L01ha2VmaWxlOjI0ODogX19zdWItbWFrZV0gRXJyb3IgMg0KPiA+IG1ha2U6ICoqKiBbTWFr
ZWZpbGU6MjQ4OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQoNClllYWgsIHJlYWxseSBteSBtaXN0YWtl
LCBJIGRpZG4ndCBjb25zaWRlciB3aGF0IGhhcHBlbnMgaW4gdGhlIHRlc3QgdGhlcmUgd2hlbiBp
d2x3aWZpIGlzIGJ1aWx0IGJ1dCB3aXRob3V0IENPTkZJR19JV0xNVk0gYW5kIENPTkZJR19JV0xN
TEQuDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIGFkZCB0aG9zZSB0byBhY3R1YWxseSBydW4gdGhlaXIg
a3VuaXQgdGVzdHMgdG9vLCB3aGljaCB3b3VsZCBmaXggdGhlIGJ1aWxkIGlzc3VlLCBhbmQgbWF5
YmUgZXZlbiBDT05GSUdfSVdMRFZNIHRvIGluY3JlYXNlIGNvdmVyYWdlIG9mIHRoZSB0ZXN0cyBp
biBpd2x3aWZpIGl0c2VsZi4gSSBjYW4gc2VuZCBhIHBhdGNoIGZvciB0aGF0Lg0KDQpBbGwgdGhh
dCBzYWlkLCB0aGUgcGF0Y2ggdGhhdCBicmVha3MgaXQgaXMgaW4gbGludXgtbmV4dCB2aWEgaXds
d2lmaS1uZXh0IGJ1dCBzZWVtcyB0byBhY3R1YWxseSBoYXZlIG1pc3NlZCB0aGUgY3V0b2ZmIGZv
ciA2LjE4LCBzbyB3ZSdyZSBnb29kIGZvciBub3cgYW5kIEkgc3VwcG9zZSBNaXJpIGNhbiBldmVu
IHNxdWFzaCB0aGUgYnVpbGQgZml4IGludG8gdGhhdCBsYXRlci4NCg0Kam9oYW5uZXMNCkludGVs
IERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1
NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5k
ZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5IFNjaG5laWRlcm1h
biwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9h
cmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNvbW1lcmNpYWwgUmVn
aXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


