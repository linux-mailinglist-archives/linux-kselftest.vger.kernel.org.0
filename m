Return-Path: <linux-kselftest+bounces-6069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006F875919
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E272858B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7913AA2F;
	Thu,  7 Mar 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UShJ4tHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAF64AAA;
	Thu,  7 Mar 2024 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846081; cv=fail; b=hKGw7u5Na91GL9zNiFuKewosjX+VtLgIFoO5tXlEiGWLaZ5PGuWTsnzmDz0NWeypG1wMc3mLn23yruqpS8FM9ZCfScQrbi0c+TWzAGI5KmGU6epVgN5mDGyf58UO3dgrgMYMgqEE7ZiVPvjEJlJI8xpgg3nzSo0Gigm1gW5ltT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846081; c=relaxed/simple;
	bh=qvQ0rIWipOKuL+O4x5/sU3khSjAJ7i0JC91m6Xd87MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7d+ry1cXUjmb0xkhmIG3jB0MtI0Cf/Pbnt7iU1mhct76V8mab5cLapANuvi9/ukbQ0UmAfxVyUkSWqZOxvIpYIyhuTwUFkhp45Hjz8bbEd0vwMs36MYjsHIiAsC/PnDx62Yjm29dv2AC1S2wQXR/3iew1mFUfGNa5XNw8eeuQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UShJ4tHY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709846079; x=1741382079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvQ0rIWipOKuL+O4x5/sU3khSjAJ7i0JC91m6Xd87MU=;
  b=UShJ4tHYoghkU9GFkBx8emnr+J9VrePixrIrpHfoZ8bQZ2Sdn6prTSFN
   szKNCCglxrXcDJAUENNsyXGfAw1b/ogaafOczPwYw6GBllgr7MjEvhbhn
   cCRamK49QmMljpg/dqZGJhcfoJAKOWcIY4LeTsKZYRaGTKYh6Lp1SdNcZ
   yN+igOjeBVj3WfEeK+T0gvohe5rZq6fn96M/DiR8Vs16XeYNB09cW2ijV
   FCSPgqKTgm2d6zcRVwEYPOD790e0OF0hgBi0HzUbDy/vBjUh9fOH7aIvi
   ng5hU0rw8DJhrtwZ3a8FCLlqjAPW2ZTa5XWmKpVjAToeZBJXr/uERbc9c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4422842"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4422842"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 13:14:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="41219431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 13:14:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 13:14:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 13:14:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 13:14:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 13:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvYFiPA3H0niZMvwjv2noVE8bNqErrhjcB+tOt0uJNx7qDi8hgqJmkuCyZh8KkHo+eitlv0URG6VgPH6WpxESkovLSLL8gGPZGJeCqm64vQY9/Cp+CkDPOxAMmjEArlKeu4jvJ2BeAEqnAZx3EFrJmdy2j71WGOPrTa/DaTybNvLbk7czJdlyOxQ+cF0ttOlwab6T5Nv4upEJW7THCETDMpx+33G554zP/kRqM9wSEoVSLYWBKx+/ETpPSg/61Ah9xaJmL6rL6yAb60L1HD/MpJHXdCpltC7r4d2ezCUSSUL2D4Ug1Jbp+pfQcn4Q/Cf3WoLN7yZWirTk8H9e6bldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvQ0rIWipOKuL+O4x5/sU3khSjAJ7i0JC91m6Xd87MU=;
 b=IrDSmLCl0OQj4/Kldfgrhoca6tzflw1zDTyvVMnmKtsUv//HPslY910uD/qFOHIXKe8KF+CKff6RtuyOtsuW+OtxpCgEyMgYVpuwwui8p9Xd9hwzJKmiFssWj2JHYjLdkb2JK94uHcd8mFEhROKOjhWzrztvkK2A4hC0LC4OdUcc/09/XlTI65gDXnRcGz2KXXzuBd9vf8sne2K0LEUDLmONxZZbqw8BKARYI+aKDlOGxGWe+rMdaqQ9raQHUUY+hV7ss+qnYFbzAILcRpWswB5ghfk94rnWysLpWUNkS3gH1oH+aEMp2G5qrP5+D3+uWqcIjwqaG21AT3bleUoRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 7 Mar
 2024 21:14:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 21:14:35 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarA
Date: Thu, 7 Mar 2024 21:14:35 +0000
Message-ID: <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
In-Reply-To: <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7993:EE_
x-ms-office365-filtering-correlation-id: 6708558d-1917-4344-fc49-08dc3eeb973e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFBMwIyuTR+ASpnOySJKf6YfpomEvLdh8p+C/DlpDIWqG0NVXdD5gdQ4DMjcsjgCcERix9Q8Gtc4ybomsdS+Zb11CnxNSEBwO5bRlWPi7ilfUniwS7UB9THeUSo07pgfIDkkaDY52poWPXDqiBXs0UMXahH1kHQ1CNzyr9tm5mE8+NGMk5ExJocsduTwzX48i6o9QnlXwdvOfTVEfLDKqXbmQ15LmWtB/fO7AYBHe5GrDr45zv5sN22yfYBUvmPm/q+Tr9G+wgnFV6mZS0RjAjvF52iegF56JPRVlifIQhZyrkZZFVo0lTNnh/73Mu4xfesV5pDEmU/FhSIiYMu4VpEXhp6KWWO02qxMJqIZ6v1a8NNDaRi3HTB2DZmuvurXFt5XodfXTZhLleETOIIKnhaG4+gNvYxtLK01DR9eRJWr7XEuBwPnJP0QfPiyMVGV6wnuY0CJ6L3bgOd82hiAl+n2yS8POz1OERaD4CN3hSfXfxL71Y/924WLDqzAF6/HustbaERAANJ6SQJ1vrb8TE96thDQdA+mVQa5+ytsoIU3AHs/FrqSuPy645XN3orMFefLIQEKgdLkO+4o8BMF1QHrs4kyGXhaZ9/AyFRylbH30VTZl14YQDgBTBXU9lfbPtubYpTa+JwEkctord3ZsXeeiwvzEF2kXG0DRmfs5r1PMUz7NIMqzoPf4Ex2luecY30wdMg1jTx/QXtJHP1avtNfcxu0DLHrSunJpI8FugM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FJTlhpbk1jOXB6K3BGYlpReFcxV3hWZm5QT1hPcTdVY00raFdRWHFuaCtP?=
 =?utf-8?B?RU14MEpqYXQ4NVJmWUl3QW1QQTBLUS9iYWJFL3RxYlBYT09wZ0E4NjlLZHky?=
 =?utf-8?B?cFNuTi90R216clJsdndhOGdETG8vNExIWWVpaGhYSGZ1V08wWHhWWXNmQjVZ?=
 =?utf-8?B?MTZPMDJaQ0d2Ri9PWndOQko5cmhacDc5SEhINTEyYTFUbFFIUVFKSEM5czEx?=
 =?utf-8?B?TmszdlNhMUFDMnNxNnVwYWNadkhra3lLTTAzOWM0RmdZd2MzMUpmMlR3RWtT?=
 =?utf-8?B?TktNanJ3UmJodnhJNUtsbWhKVUJITW5mRVl5RmNlWGgwNngrTlhwNEN6Ti83?=
 =?utf-8?B?T0FqNWs3N0RnQm5sWS85MTVQbmwzOFBIeXdLcUxMdXJhYUwxN3dYUFhXOVp0?=
 =?utf-8?B?MVlpOS9sUDhHbkhoSC9hZnVyWGhuUzBLWUJzS1p3MmJBNXNWWTZaZkcxUmpm?=
 =?utf-8?B?RFBEQkZKdmVPOFEwbVJvRzMwQ01Ed3hRK1NUZGdPRmVFbHBZeWFPNktZaG9w?=
 =?utf-8?B?bVEzQ1o5L0gyZE8wL3RBcW9nZ05qNkw1eXdGOSt6LzJqVExuYkRWbGIvRHBv?=
 =?utf-8?B?aHhaejZqZEdDQnl2eFhPWk55L1krbmZ4NU5hdXBJeWJlaW52Qk9CZkZVOHRz?=
 =?utf-8?B?M2k4NmxxcXhIeVNZYTlhbnVXZzVqZmg1VVJmVElKeU9pa0dueEhRc3EyZDE0?=
 =?utf-8?B?R2pLRy8vaDVkTS91ejk4ZVZLanBseGpNeWk4QmR3aWtPY0xhcUY4NGF6bGEr?=
 =?utf-8?B?ZzZCN2pXS0toVDNYWisxKzF1cjZjbzBzZDlmYlRoQ3owZDcyRHRVYkZyRnN3?=
 =?utf-8?B?ZTVncXVDNjV3d3JqeU9OempLcm51UGZVam93NzdYN0xDaWRSaFBwZXF6UXJR?=
 =?utf-8?B?emNmWFU4STNPdXRuVjZLV1JLU3dxdTVhUUFWSVdDb1pHSEdhTnBXenlNb00x?=
 =?utf-8?B?a0JDcW16aTkwV2tQM01HTlF3VDB0NE9uS2ExU3VpMmd6M0cyQmJTU0tGc2wz?=
 =?utf-8?B?VUtva3FiMkx6T3dyS01RZTNLSnpMVlhydUdySitUU0RGNjZHNWk4L20wbzlS?=
 =?utf-8?B?SHpUK0o2b0lQUlAvWUc2RENHZmxVclIvQ0ZDR1QyeWlGaHZIYU5KYnE1NVRv?=
 =?utf-8?B?OXNpbGtnTmQrM1F0RGlNK0F4VWF1b2VVb2ZCZjhRbmxXZVhBY2E5cmxzMkkx?=
 =?utf-8?B?TEJxUGdTVk9ZQ3ArdnA2d1o0Q3F0NzNFM2p2SDNVeGYrcE8vWGRVLzUvbXpR?=
 =?utf-8?B?Zk94MktaZThEUy9zcm1SRnVkeVpUMlVwTXJMK0FkTDNBYjNlR3kyODJEbXdz?=
 =?utf-8?B?VVlkV2hFejkwS1dqWEU5ckJhVEw1eDdRQnExUHNNUlZsV0VKQXU5dUZpUVgy?=
 =?utf-8?B?S2NWYkMrUmxkM2VaUGhBOWVvL1I4dE5UNkR0NDQzWE1tUVh0VGQrbW9PSjly?=
 =?utf-8?B?aGNIaUNVL2MxckRiWGl1dXpJVWxvMUs5V1BqYWRCcmwxWlA2cTNreE1NeE5v?=
 =?utf-8?B?L1FvSldCZ3ZHK1lKZ0ZCMmNqRC9rYTZZdmJTeWw3TnVXUkY4TkxxRldZMHA5?=
 =?utf-8?B?STVGakd4UllydVNKRjJuYkJEQisyUWVUVm91YXBhd240dVU1OWJTNE40Rmx4?=
 =?utf-8?B?OGZ6bW05M2hoWkoxbnNZN2p3TkkwRGl5L3NmNGc1dFJEa0VWVTFid29Qdnl1?=
 =?utf-8?B?RU9rQmU2UEFRdjA1d25mbFllbEZENzA0ejRVSWZVeHh3T3hxaStncUtkd21Z?=
 =?utf-8?B?eUM1S1lBaVVRVVZ5bVlWam8vQmV0VU1CSmNuUGJqZFNFVThmY09VbWtNNnMz?=
 =?utf-8?B?VC9VT1o4UU1uVThnUTN3aGxJQTMvV05Cc2lDYlhNUkF2VEpnMmRBN2l1QzIv?=
 =?utf-8?B?Sk9PRU1lT3VoelFjRG53bnVBS1EweGdKaDhRRktJUUVUcG5oM1JZWnp6UDhR?=
 =?utf-8?B?cWhqblpuUldsSHkwQjdyR0l1K2JsbGZTWjlyaW1vUytYd3RTWExzQSs4bkRv?=
 =?utf-8?B?Qzc3SWRrYTFCM0pTdXlXSE8wb0s4US9qMjB5UkduSzBTUE5PVHVhbEQ5cnlR?=
 =?utf-8?B?aUxucEJlT01TTGhJMGxGUmpQaTkvdnFuSFBHNkl3OXJWVG9oTE9IdWRoQkJK?=
 =?utf-8?Q?HRfS9nWM5VIdtos8D9RyguaSJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6708558d-1917-4344-fc49-08dc3eeb973e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 21:14:35.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRb/cQjxb6LoaaDuNrU4NiTwrsEOV4vXcinPPtA+o/7/Jcco3L+Rnf1gUBGaPok5NNDGoD8NUhYwUpLVcV8HKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

PiBUaGlua2luZyBhYm91dCBpdCBldmVuIGRpZmZlcmVudGx5LiBUaGUgZ29hbCBpcyB0byBnaXZl
IGluZm9ybWF0aW9uDQo+IHRvIHVzZXJzcGFjZSBzbyB3ZSBuZWVkIHRvIHRoaW5rIGFib3V0IHdo
YXQgd291bGQgaGVscCB1c2VyIHNwYWNlPw0KPiBGb3IgZXhhbXBsZSwgd2hhdCBpZiB0aGVyZSBp
cyBhIGZpbGUgaW4gaW5mbyB0aGF0IHNob3dzIA0KPiB3aGljaCBDUFVzIGFyZSBhc3NvY2lhdGVk
IHdpdGggZWFjaCBkb21haW4/DQoNClJlaW5ldHRlLA0KDQpJbnRlcmVzdGluZyBpZGVhLiBUaGF0
IHdvdWxkIHNhdmUgdXNlcnMgZnJvbSBoYXZpbmcgdG8gY2hhc2UgdGhyb3VnaA0KL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1Ki9jYWNoZS9pbmRleD8vKiB0byBmaWd1cmUgb3V0IHdoYXQgdGhl
IGRvbWFpbg0KbnVtYmVycyBpbiBzY2hlbWF0YSBmaWxlcyBhbmQgdGhlIG1vbl9kYXRhL21vbl9M
M19YWCB2YWx1ZXMgbWVhbi4NCg0KTWF5IGJlIGV4dHJhIHVzZWZ1bCBmb3IgQVJNIHdoaWNoIHNl
ZW1zIHRvIGhhdmUgYmlnIHJhbmRvbS1sb29raW5nIG51bWJlcnMNCmZvciBkb21haW5zIHRoYXQg
Y2FtZSBvdXQgb2YgQUNQSSB0YWJsZXMuDQoNCkZvciBTTkMgaXQgd291bGQgZ2V0IHRoZSB1c2Vy
IGRpcmVjdGx5IHRvIHdoYXQgdGhleSBwcm9iYWJseSBjYXJlIGFib3V0DQood2hpY2ggQ1BVcyBh
cmUgaW4gd2hpY2ggZG9tYWluKS4NCg0KU28gc29tZXRoaW5nIGxpa2UgdGhpcyBmb3IgYW4gU05D
IDIgc3lzdGVtOg0KDQokIGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MMy9jcHVzDQowOiAwLTM1
LDcyLTEwNw0KMTogMzYtNzEsMTA4LTE0Mw0KDQokIGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9M
M19NT04vY3B1cw0KMDogMC0xNyw3Mi04OQ0KMTogMTgtMzUsOTAtMTA3DQoyOiAzNi01MywxMDgt
MTI1DQozOiA1NC03MSwxMjYtMTQzDQoNClttYXliZSB0aGVyZSBpcyBhIGJldHRlciBuYW1lIHRo
YW4gImNwdXMiIGZvciB0aGlzIGZpbGU/XQ0KDQotVG9ueQ0K

