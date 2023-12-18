Return-Path: <linux-kselftest+bounces-2126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0B81651B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 03:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0E1F21265
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8923D7;
	Mon, 18 Dec 2023 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH1a1UrN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DB63A3;
	Mon, 18 Dec 2023 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702868062; x=1734404062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tSR/AvoVEdj2XZLdhCdg5j6TmxnAOcDrrM/4y8eltVc=;
  b=VH1a1UrNdlZRZWyYRNgZntdF/Bl0+nthg/zJB+Qh0ei2ZkktFmQfuLAH
   TmuX5hdb7d6V2H4B8u3t5JtzaWkqfdg43KJw4v7s246w1jaJ8KoSWZTNC
   EkOge2Ae0XF4gHbK9lFUaZpSo8KB0SRqZ0qbzPsBIWppy6OkiX5TjBaFl
   CSZH1o79orZKN/VApaPVikC5z7KS9RvvafR9oc+qtvWO4+6lPMwu5ww1V
   coCZSdX0t77p7oTUz76v9lcbMHiZ6T+SYkZ2m8fNrBhSC4kfIXSeULj+n
   //M2xRiN79K8JBMXfbUDiuAkG5cP6nnGzanYAMsQuopwopUCplLoeedng
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2656567"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2656567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 18:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809657323"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="809657323"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 18:54:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 18:54:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 18:54:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 18:54:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHyHI7uj/hWq/7oTif2L3xzZYtaqyofmqyDLB7IHRoowwi3p6rA5Pt3QA1KCMfl1DObse/rmGeBQqgQqiOie+S9Fz95obA3CKePvG72XdHgDGlX24+NCrGBVsLiw3HJhIhiNcGmvQLdVFuq/Ni32CnZ6Xs763hCuiKFjVbCVSXIMtJo+ypVRmcvU2YWmzvvmXAeQQtpHvueZfRNJrutPSKfyNjy9DLOuEz5xA1KHKUdMuZp6yDMYzlDcxJU+j6D6txM9821DMdCJo3VvK7XcoontDwl3gDRSvpXTCQDuO/4AdcxMIDz1ArKZeIWqcyuNRvcKSWUTWEQHQYRNWvu3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSR/AvoVEdj2XZLdhCdg5j6TmxnAOcDrrM/4y8eltVc=;
 b=P6OHwTi4BxnhC8I9kfEjME813Ocrec8hyBZxAiZhoxmHZXW6zq7+eWgDLUeOydu2q+hkQXYvwvG8IVLtm9D9PwUnPvzkAO/Z5pL1GJBLZERplEAd9LqZYGHQIk3FHje1N2OFill3pkmn+KUW2UqTYvlKTi81EzF6/ntFz3nIX+Mk7tjAhB3peCHJsWPAWaG32t5Px6Aj2v9pZPPgUaa4yxCPM/SSTupnMkvht4DWMCGESBcruyXKULvL4BGFVmuWWGB5CJgX/BYg3IA4h9FNw8+NsEl/aHf0Yycpb8957wYBwXGjyOblO2p3cbqzFYnW3hjaIEuVYGZcMCvayiDW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by BL1PR11MB5528.namprd11.prod.outlook.com (2603:10b6:208:314::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 02:54:11 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 02:54:11 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@google.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Topel
	<bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Mykola
 Lysenko" <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
Thread-Topic: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
Thread-Index: AQHaJgkYSPZeueih5k2aEmsHgya5rrCY72kAgABIIgCAAZaQsIAABuWAgAAbtICAAA4BAIAAGr0AgADyX4CAAJaigIARxG9A
Date: Mon, 18 Dec 2023 02:54:11 +0000
Message-ID: <PH0PR11MB58304128E1F6FCE3A2F0D0C2D890A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
 <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
 <ZW98UW033wCy9vI-@google.com>
 <CAJ8uoz3_XqavGt1DyFoQAuKS8Faa1Lc85b2t+whc-f6GN1Pvzw@mail.gmail.com>
 <ZXDGHThTynXbSTJG@google.com>
In-Reply-To: <ZXDGHThTynXbSTJG@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|BL1PR11MB5528:EE_
x-ms-office365-filtering-correlation-id: 2dc24c3e-3f04-4476-5ae2-08dbff749ced
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msQ9AkAvZ4o9AjqMN+K20FY56YKiuccYBpY5I5ye+l4g/k+EvdaLIjfN3Txg2EWUYdRHoqRijpLsIjFywhw0ceR9RkwgdHgm9cxF1ywD3kCBCLnqo+CH7UCccEWeKRI0rXnQdgtdOwmNaLnYgDm18B8byRdWMlGbZaGpN1XjsW+BNOxVYeXQozDOrL1a0S+kvjxsA5n3SQr/sPw575AGeZjywdAGB1ssy/kWk72/YVGxYCj4HU3DtzZFfqxvosWr1IV6R1iFcYlxzOR/3m4QSvtatU5auRy13htGw0MDgK/68RszBxehx6OtTi0c9FAQsxb7YqLFyinJQSTqs8wRDIK3kUSvRjI7b70ZEsfCvYpXObCQDR7Q7x9HS2pnBq0FA4VrrVWAfjQd0Fh6JgZNX3LhGwhkppgXbMXLMlgk/PyIVna9/NNZiKyEwXu6mr+VSFYaLRyl/gKQVmhaUdLLUcGEApbI7Fuo2sX5WScr7pmXhpQQ0J8rLkJ8KKRbqTI1GV7WWSCQU7V4iqd1CMr2dyqzoJZX0eTqNr82rO37LWUBRun+oD05Mj41PCZb41Bkbs/Iq1LDs9GNXuDXaxppX3AcT0klaJSKGIgZO1iutn8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(26005)(122000001)(38100700002)(8676002)(5660300002)(316002)(66946007)(4326008)(52536014)(41300700001)(4744005)(7406005)(7416002)(2906002)(478600001)(966005)(6506007)(7696005)(9686003)(8936002)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(33656002)(86362001)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1E4cGRIcC9XSzBHbFdob0ZIdTZXWkN4Njdod1ZLeCt3NGFLZDJIbVIwN1BF?=
 =?utf-8?B?a09mY0QrT0srZXMwUExZTjV0UTdCbUNSc2V5bnRmMTRzWFNqQjBDS3lpL1Bz?=
 =?utf-8?B?TUQvODNUT2VJWG5mRzZsMUh0aWxhOURZaVpyeGVDVEFGbmJQUkZOWFA5bFd4?=
 =?utf-8?B?VDhSc3JGK25LdTZXNjIxKzRkODFDbkR4eDBvMFpqbnBFcytEYXV0NVdaMllY?=
 =?utf-8?B?NEQ5Mm0vaFhDeXRDcEJESndRaFFTa1F4c2FvV2kzTXlhY21jbERPbGxpUjV0?=
 =?utf-8?B?MFo1bW11NFVtUHIzTkdDbjk1d0JNS2pNYkRsQjZIS3JpK1A4V1hQRlZBWGc3?=
 =?utf-8?B?QlFQKzQxeW1oWHJ6MVdLVTFGZXNLOEV1WDZYOEY4WUoyVVBxMUlMRldWRm95?=
 =?utf-8?B?RDE5MVBWc3Q2NlR4dkdhNVIxMHFlcWJCWGE2by9nWHhVN0ZNVTFVNE5qRUhu?=
 =?utf-8?B?b21DV0RBMjQ4T0tOM0NHY3RNcS9TOU10cStOMlNuTkx5RGljT2xSNE1MMTFh?=
 =?utf-8?B?dnl1YjRGd2lkcWdRL3VOY3ZxSnFpQklTYjdyVnVseGJ2cnpZN2RYeTFwOHBC?=
 =?utf-8?B?dDN4enlWZHBjdGphWEJWUVo5WCtKd2UxNFY0bnJ2bkVVK0lydXoxelVyZXB3?=
 =?utf-8?B?aC92ZnV4Z1hqdUN4ajF1cXlPZ2pZSm1JbFVxWnROQ0lCQS9xdVpHZnFxMnpL?=
 =?utf-8?B?MkFYV3R0ZXhnOUtvaXYxVjAzTDRSWmFmUmJqdzlIRURhUzhnOXo4cm5jSHlX?=
 =?utf-8?B?REpFTUdJMDhPeXVaUTcwSUxZZXFjU0lvdGxCL2M4QTYzaEFwaWkzNG0zZDlJ?=
 =?utf-8?B?ejQ5dkV6S3p2RmUrbFQwMnVVRHpUSVlIWit5bW9iUFZRSCswY2ptazVwYUQw?=
 =?utf-8?B?dUFLZ1FIaVV0YW1PN05GclhzRGV3WHVpNDRoK0FtemhyU0NwSWJhMnBEZ1c1?=
 =?utf-8?B?cWExL2lYUk9ydTU1WHFtcHFzbXF4UmJWM0MzcEtSN0d1ZkV6M0xNQ1N2YTlR?=
 =?utf-8?B?eFMvWEdBQUZ3bzJtQkp2c0xOc2ZjR1ZaWVNCVUpMMTRSZEkyRWt4OFVFTXB4?=
 =?utf-8?B?NC9zb1MrRXhtZ1VxODZNNnFzOWlSZUJ5dVJmdjB5aW9HdWN4S2x3MEoyUnJI?=
 =?utf-8?B?K0QxNG5YeEUvcTV2R0JWWGhMSXpSNkQxbStKMi80MDlqN1V0WFBIYUlOL2dl?=
 =?utf-8?B?bmF0cEZhZ3hlb2VEbkpHWUpJSUwrNEdHZ0ZORXJud1l6ZHNkNGVjNDArWlFI?=
 =?utf-8?B?WW5ld05WSDloVlBiMVpDbTFmWlJBbnVUS3E4S0dnaFhpbENtYTlKVTIwTWE1?=
 =?utf-8?B?WnBmOHdrSmJlMzBpNkJzQVF0Q1cxem5CUkZ0T0FEMDFFZGsvbncwTXRzMXQ1?=
 =?utf-8?B?TUFzWkRRSm56dG1VYndBUEVNZFdtblNVUWczZ1JFRXJaT2NxUldiZUc3eENv?=
 =?utf-8?B?MVZtS0c2VW1RWkdpOEJIc0ROd1NmNlhscWFzekYxSzBUSVRtR2tNMnJEY0o4?=
 =?utf-8?B?V0pxZ09QZlJKa0U0WDVDclA2TjJucVlDblB6dmJCVGtNRkRDcnBmOC8zaGdx?=
 =?utf-8?B?S0JqbTVxR0lCbldBV21MMFdERG10K2Zob2lEdWdHZkNUUXJwNGl6NGRqQ1Vi?=
 =?utf-8?B?eERYazZXc3ZXKy9ZWTlTTG1Wamt0WUdKcWkyVy9pUlNUczZhOEs3TElVTXNM?=
 =?utf-8?B?WDRYMW5kR3lXSjNWTDNKQy9TTzZaR3Vqemp3eWNNQ21PUi9WRkN6MWVRaDFE?=
 =?utf-8?B?ck1tbU94c1VLQ084dHArclEyWUc1UWJsRkcwa3NUb2N2SGlSQ01CSEZvRlpv?=
 =?utf-8?B?dWsvcUcrSjU3eUR2TTVkbzhjZDRKQWhvY0JlWlY2bG1lSTg5YkVRYklhTm9H?=
 =?utf-8?B?RHBkSlpHR2NNM3dScFk4YnZKR2RKZmxlSlpYZFVrTDJ5c2U4VUR6T3pmUUMz?=
 =?utf-8?B?R0lWOUQvWjdOMzNnQytOU1ovYnVtNDRGTERXdUNwMFRWQ05VUWhnb1J3MS9L?=
 =?utf-8?B?Q3VCOUVjMENUQW00Y0Rha0dwS2VVeEJXeXV0QnBvUFNCeEYyVnExNzBrYis5?=
 =?utf-8?B?K1hlT3M2a1FMTGdhT1pLNG1sb3owNlRmeFhyV0hLMlJFWm5uQjFsWElCZFRh?=
 =?utf-8?B?SGxyWExoZ2xxZE4wODNVcXFiVU5WcXgyTzRwYWdpaFd4eUhjS29OUFBHRHdx?=
 =?utf-8?B?dmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc24c3e-3f04-4476-5ae2-08dbff749ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 02:54:11.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAZ1gjs/f3qvlP+T5hjsBukXGP+z5cBuzDkmyLQ9ZT2AFZRSP5H09gNds8E4u/+djERgWtlpSVVadDWstjwCpY58PLnj1z0mIT+w+/TcnNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5528
X-OriginatorOrg: intel.com

SGkgYWxsLA0KDQpGeWksIEkgc3VibWl0dGVkIGEgcGF0Y2ggWzFdIHRvIGVuYWJsZSB0eCBtZXRh
ZGF0YSBmb3IgaWdjIGRyaXZlciBhcyBhIHByZXBhcmF0aW9uIHRvIGFkZCBsYXVuY2ggdGltZSB0
byBpdC4NCkFmdGVyIHRoZSBwYXRjaCBpcyBhY2NlcHRlZCwgSSB3aWxsIGluY2x1ZGUgaWdjIGRy
aXZlciBpbiBuZXh0IHZlcnNpb24gb2YgbGF1bmNoIHRpbWUgcGF0Y2ggc2V0Lg0KDQpbMV0gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDIzMTIx
NTE2MjE1OC45NTE5MjUtMS15b29uZy5zaWFuZy5zb25nQGludGVsLmNvbS8NCg0KVGhhbmtzICYg
UmVnYXJkcw0KU2lhbmcNCg==

