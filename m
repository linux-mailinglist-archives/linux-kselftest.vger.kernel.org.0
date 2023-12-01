Return-Path: <linux-kselftest+bounces-962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D65800C68
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50EE1C20F54
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB43AC1A;
	Fri,  1 Dec 2023 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUIWb+vp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C3A6;
	Fri,  1 Dec 2023 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701438194; x=1732974194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XBlab6cUP0UzblnQ1S/5MOz/UggsWJmt5+Nkuwg6rog=;
  b=hUIWb+vpz8cwZiCRc6dZqmCi8iDUWjGE/VAratQ98F0hJUhQdHQTCN12
   Da6Yd/bj9T+QOfZbWYn7qN7ENzNYp9wuxa1fL/4OjgidpDvJsFnJe73SQ
   Ndt3nLM7rF8FOXsZQlzDYKXFgZcHf2o7SpPs+jR4rFYnHIsb8W7NVhP68
   oq3mcHGIv+dGMB8EtgI4qtbfFUVIkxd4fvCz9OvZOMSt+/sHST64BESRF
   U848ev/UtEtEsa4LAOD5cRswrvlqNebibpYrdhW6LNw4qWistkn5s9kaS
   kIBcZKB6jfmXk2B21KArnQtrgU5rNNx3A21nC+jNZ1M9Kq1uJE/rMPAbb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396302287"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="396302287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 05:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798731580"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="798731580"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 05:43:09 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 05:43:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 05:43:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 05:43:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjyhLFvAwEZHltes+HyTxqivPCckLhnD7/yfX9Ob0YBoKsYk7ZfKrK9rnhY9gYkwJ+NPeu8S7Bxonbbd9Wd6NJSmmswraNmG4brN5annfqgblyykwNpp9fpFt/dR30THZqtBqQnFUP9WV3kkrtMDEkXzu5NdD90BVEsfCqH8/HCCCl58Jp59vTQtHfL2GTxZ49rXYu3KOstih2bvmYhTsudn/MWsLjmOstcIcyl95QQsF2M/oxjoRrQHe4yKjYJ/q1G+FlygpWxCWYxCBA5fi7z559PlI1i7NjcHZvpP2DzeshH+hUbYErFLr3xNzMVF+hGujvrDqv6MpO+/TBzjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBlab6cUP0UzblnQ1S/5MOz/UggsWJmt5+Nkuwg6rog=;
 b=lo455dBYxBHsXGsxzFV6T4kbGpPGA1FINzT2I+QZMN/AZeWqlo7cyGZw2jhhLRlIzvpPA33RkQTy2HADwtZqFFNziEZ2UF9SffbY8y+cqMvlFNMK2qGRSiuXPG9oY/BuFPJe4gEqNf4RG2QiMNNDWqr86yo11jgSYFlnGNCofy5P6xieYPyge70idJMQlQMH7PHwfVABh3w/lMohrq125kDzT6WMSdK0qpPdd/xcmcm0qxZpKkJGGvokLUQShHUyyrujWyLAk2EvO2RYkp74sLP7XlCRMfkC72vNlOC1mwjOgv5pqpAUVP9XaZCcBUJAznArm5ZDgLsm8d+6oMhhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CH0PR11MB5379.namprd11.prod.outlook.com (2603:10b6:610:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:43:07 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 13:43:07 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Mykola
 Lysenko" <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
Thread-Topic: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
Thread-Index: AQHaJB8W7iUch8mtVUCDEJ1OnRle9bCUPv4AgAAvtGA=
Date: Fri, 1 Dec 2023 13:43:07 +0000
Message-ID: <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
In-Reply-To: <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CH0PR11MB5379:EE_
x-ms-office365-filtering-correlation-id: 835c06d4-d99d-4f1d-49f6-08dbf273736e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bnZS0az6aI0NVCStd90yEaDKJvqG8afoY2V8p4JNGimXpyRktmumw0OuJj21J/tNRKhqSRNDlg3IO6iTx86XMZoOlhPTuj6NTpIqTfNlZoXNw5moAeu0KPM6bPxZQbUpunlAZ8SY1+eCRLO6gJXg81tI2gOLpE6CqdQ/VFhWqpC3YpPWhFGDs8KhKtRinZDw/0LhX9PFQ9MDf24izKv8Sgf0Wf4BLnk+cUKr9oaD0qKkTk79zY0khfl4huuZ5T2EeHwKwsUz+Zsf9FNBnj7JDnxqHol1EApEhozv4igcTf2stDyXIJ1vwwg93q9eyRCjoxLtebP7A4RvjPe7qpE3Ko0pVERxxE1qxPkSzPPMUljsMUNGdX/EO2aIDbYgagG45w88RTnpFxbwBmvLFzWHZMJI0TkfK9ibCKcbsTfY1FIT60Pru5/UNlQTlLT5lpHSihJVzNmZqDm3cPCIfzXcdb4QkiEXOQyjBW1cYOj7eRtbJmZc3BQ6refXVcSVCdE2ysDbZspPj2KKUoGLTeMiw2TlMWFL78VPf/3iG4RUb3W6d7qigDQoM64S1C9xK+bD/4Krfd58ocaAihzaoxPvdmQWKMTyMrOMpDIJAajxBea1bArcBNUrqpMOsegU4sXRxu9NkivHkGPVGPcSDkMfFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(4326008)(52536014)(8676002)(8936002)(55016003)(26005)(110136005)(316002)(41300700001)(54906003)(76116006)(66476007)(64756008)(66556008)(66446008)(66946007)(5660300002)(7416002)(7406005)(9686003)(53546011)(6506007)(7696005)(83380400001)(38100700002)(82960400001)(122000001)(86362001)(921008)(33656002)(71200400001)(478600001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC9zZkJIMVIrYlMrSlJZTUJsVU1vRUxrV0JWeW9qNmNWekxmQk4vemNHZUw1?=
 =?utf-8?B?Ym9kQlY4LzZTQ2Q5NWhLdnBKM0YyRzh3aVZwT0EyV24yeGZKOGVRV2REV2k5?=
 =?utf-8?B?UmlTN3NZYk1pRTkwSkV5QUxFcVlORDF4VVZKZ094Z21oT0Z2c1psNXR4UzVu?=
 =?utf-8?B?cnF0RDZDWVkxQlNYVkJHTGVUMmpWaGQ2YTB0Yi8wcElDVVBOYXYvWlJYTVlD?=
 =?utf-8?B?T1JoYklkNlBxSStnN3krZ0FOczlqdkNYRFNyc2pTaElidCt6YS95cC8zeEQ4?=
 =?utf-8?B?VWtITGxkZDdxQkdUdGtjZGhBV2pCRzBkajY3b1Bqc2p4RnRMWWtqWlBXdFhn?=
 =?utf-8?B?QXd1eDlFbTBDNzJELzdyYmovM3N6V1BaelF5VFhzNWRLTUkyNW5jRXRTcmhT?=
 =?utf-8?B?YUFXT0JVUlhlQUVFb0kvM3hqRmpOMFRxeE4xUENUK0huUUhIVU10VU9YZ2t0?=
 =?utf-8?B?ME40UnNKMTBDbzl5eXd5b0YyOFdoM1R2NllSQ0dIdW90TzR4cGZwcTk2V0hp?=
 =?utf-8?B?Ui9Vd0lvbXdJdExENDcrS3VwTmIwRmtnNklNSWJJNHhNaVlXZmFBNHpySHE3?=
 =?utf-8?B?OXZUZ2FSa0dWZjNoVHhmV0Q4MUtnSHdzK3NFVlJzSmVwaFRueGt0QUFMZnJ4?=
 =?utf-8?B?V01GbHFLeGNiRUJSVTlYanB0Y1ExSHlHd3VoV0ZBK3FNNzhpUnlDTTBJSXlN?=
 =?utf-8?B?TVYyTmNGWXNJdkpvdDJ4K1hNL3cycGF4a3J1ZmsxZTBXQlVzY0dhR0xwRjdX?=
 =?utf-8?B?QVFLZjBPQmRNdXkyY1JTR1RuWjgyTXVxTml1MU4vc0YyL3Erb050ZDIyempC?=
 =?utf-8?B?Tm4zd2V3SmIrbEE3MGp5NXNLQ1lWVEtSa0xoRjJzV1ZGcXhYSWZ6YmFYSDhV?=
 =?utf-8?B?LzM5cnk2T2ZEQ2grSkllNGFPZmlrYzcyNTY2YnJBQWlkbGpMckx3VFcrYXlr?=
 =?utf-8?B?Mm1FazlNZURBcjM2MzJTdTExdjd0T0M4clVLZ2NYRDJrYSt2ZXU1WUNBTFZv?=
 =?utf-8?B?SDQ0UXphNEJtSHkrcGVXc1k5SkppeEprcjBBQ3YrTjdRbTBFaFFYVWoyYzZk?=
 =?utf-8?B?cE5tUGZQUERheFNLWHRDVEh0NGsxdm93dXJRS2ZxSEV0dXgrTjVEaFM1VzVC?=
 =?utf-8?B?dU1sL21YOUJ2dC8vMkVOVWJOVy9sTE0wY1lHWDBZd01USUljR0VneGlPd1kv?=
 =?utf-8?B?b2R0ZEU5S1FISWROdE9WbUN3TEpabW12aFpBSzdneTV3OWw1clBvNkNkZkhC?=
 =?utf-8?B?Q0tDN2VXVC9qZXpJcHJJZHl5ejFBcm1WQjBtc2JCTFJpamFqNmxRNDhGQlRi?=
 =?utf-8?B?dzdRV1dDWjE3Mm5oeXMwcEtTd0NubDFOYnY3dnByckNyc3FYK3NjQnFGVDNZ?=
 =?utf-8?B?VHZJZUFHMndzQUh5c3M5d0VLSWNFMkcreTdhZ0dCank3UDF1dzQ1Ti9IZGI2?=
 =?utf-8?B?YWlPNHdrQWM2WUdMRk01NWVhMkEwZFF3Uko0c1dGZnluWkVtU3pvMTBTRmlS?=
 =?utf-8?B?QlJpdlYvai92Mjk5azNYRGtLdC9MOGs0RXU0bnQ1V0FZeDU4RitDUWhDOG1H?=
 =?utf-8?B?MVl0dWxUYkdnQzJQNHI3SXFqTHZlM0ZjU3d5dUhIeTIyUCtpd1B2OEZ3RndY?=
 =?utf-8?B?TlE2cWJqaDd1dEw2OFM1Z0FBQkNXdTFIUUhJZnlIZitPS2pXczE3MGxHT005?=
 =?utf-8?B?Z1dEaFQ0TGdsaGV1S25paFRoTW91K01VV2x2NDF6NCsvSHF2aUhpNDFHMSt2?=
 =?utf-8?B?bGQ3SzZXTUVVS2F4S2V2RTlLWGhpNENkVDJuaWN3ZVRMWEZXQVorQ2pzUUtx?=
 =?utf-8?B?YkZZZVk4Tk5ZTXNrYkgzVzFEVi8rOUZxbU5oVTRQRlJYZVJ3M0J6RHd3dUR2?=
 =?utf-8?B?ekNPd2JsTmhyeUZFZjBhQU91d3NabHZUQUdiSXdVRUl6SlhxVnprcEVLVGZP?=
 =?utf-8?B?MnJSMHIvMlU3dHpBRVJxcU1ZbUFZVlBSRVZZbGR6dzRZMERmTk1kbnp5TWF1?=
 =?utf-8?B?MXd4U0U4UWw2YVlQSFdWY1lxZS9SbEs4VmdjRzhCMlFvTjlTcVF6bWtpVm9R?=
 =?utf-8?B?ajZVanJwaXBtMFdNRGZWd1Y0bDZsbFMzTGFsbUVoblNGT3NPS0RXVXhEY2xn?=
 =?utf-8?B?VUJMbWlwclFMOXNKYVFLd0hPMHI5aWFUd0F2T1BxUXdUQmJOQng0UEpwUWQv?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c06d4-d99d-4f1d-49f6-08dbf273736e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 13:43:07.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTHtJtvo9PzdK2KByLb8dnkXya/VJPsyHIF0l5CDB71kcRg9dkJdqpCKsfxNd5OMRXenX7I80eLdNWSVbEZwf2wqVChM2c7bHfpXvnhCdRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5379
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBEZWNlbWJlciAxLCAyMDIzIDY6NDYgUE0sIEplc3BlciBEYW5nYWFyZCBCcm91
ZXIgPGhhd2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+T24gMTIvMS8yMyAwNzoyNCwgU29uZyBZb29u
ZyBTaWFuZyB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGV4cGFuZHMgWERQIFRYIG1ldGFkYXRhIGZy
YW1ld29yayB0byBpbmNsdWRlIEVURiBIVyBvZmZsb2FkLg0KPj4NCj4+IENoYW5nZXMgc2luY2Ug
djE6DQo+PiAtIHJlbmFtZSBUaW1lLUJhc2VkIFNjaGVkdWxpbmcgKFRCUykgdG8gRWFybGllc3Qg
VHhUaW1lIEZpcnN0IChFVEYpDQo+PiAtIHJlbmFtZSBsYXVuY2gtdGltZSB0byB0eHRpbWUNCj4+
DQo+DQo+SSBzdHJvbmdseSBkaXNhZ3JlZSB3aXRoIHRoaXMgcmVuYW1pbmcgKHNvcnJ5IHRvIGRp
c2FncmVlIHdpdGggV2lsbGVtKS4NCj4NCj5UaGUgaTIxMCBhbmQgaTIyNSBjaGlwcyBjYWxsIHRo
aXMgTGF1bmNoVGltZSBpbiB0aGVpciBwcm9ncmFtbWVycw0KPmRhdGFzaGVldHMsIGFuZCBldmVu
IGluIHRoZSBkcml2ZXIgY29kZVsxXS4NCj4NCj5Vc2luZyB0aGlzICJ0eHRpbWUiIG5hbWUgaW4g
dGhlIGNvZGUgaXMgYWxzbyBjb25mdXNpbmcsIGJlY2F1c2UgaG93IGNhbg0KPnBlb3BsZSByZWFk
aW5nIHRoZSBjb2RlIGtub3cgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbjoNCj4gIC0gdG1vX3JlcXVl
c3RfdGltZXN0YW1wIGFuZCB0bW9fcmVxdWVzdF90eHRpbWUNCj4NCg0KSGkgSmVzcGVyIGFuZCBX
aWxsZW0sDQoNCkhvdyBhYm91dCB1c2luZyAibGF1bmNoX3RpbWUiIGZvciB0aGUgZmxhZy92YXJp
YWJsZSBhbmQNCiJFYXJsaWVzdCBUeFRpbWUgRmlyc3QiIGZvciB0aGUgZGVzY3JpcHRpb24vY29t
bWVudHM/ICANCg0KVGhhbmtzICYgUmVnYXJkcw0KU2lhbmcNCg0KPg0KPlsxXQ0KPmh0dHBzOi8v
Z2l0aHViLmNvbS94ZHAtcHJvamVjdC94ZHAtDQo+cHJvamVjdC9ibG9iL21hc3Rlci9hcmVhcy90
c24vY29kZTAxX2ZvbGxvd19xZGlzY19UU05fb2ZmbG9hZC5vcmcNCj4NCj4+IHYxOg0KPmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvY292ZXIvMjAyMzExMzAx
NjIwMjguODUyMDA2LTEtDQo+eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20vDQo+Pg0KPj4gU29u
ZyBZb29uZyBTaWFuZyAoMyk6DQo+PiAgICB4c2s6IGFkZCBFVEYgc3VwcG9ydCB0byBYRFAgVHgg
bWV0YWRhdGENCj4+ICAgIG5ldDogc3RtbWFjOiBBZGQgdHh0aW1lIHN1cHBvcnQgdG8gWERQIFpD
DQo+PiAgICBzZWxmdGVzdHMvYnBmOiBBZGQgdHh0aW1lIHRvIHhkcF9od19tZXRhZGF0YQ0KPj4N
Cj4+ICAgRG9jdW1lbnRhdGlvbi9uZXRsaW5rL3NwZWNzL25ldGRldi55YW1sICAgICAgICB8ICA0
ICsrKysNCj4+ICAgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3hzay10eC1tZXRhZGF0YS5yc3Qg
ICB8ICA1ICsrKysrDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hYy5oICAgfCAgMiArKw0KPj4gICAuLi4vbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hY19tYWluLmMgIHwgMTMgKysrKysrKysrKysrKw0KPj4gICBpbmNsdWRlL25ldC94ZHBfc29j
ay5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+PiAgIGluY2x1ZGUv
bmV0L3hkcF9zb2NrX2Rydi5oICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIGluY2x1
ZGUvdWFwaS9saW51eC9pZl94ZHAuaCAgICAgICAgICAgICAgICAgICAgfCAgOSArKysrKysrKysN
Cj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L25ldGRldi5oICAgICAgICAgICAgICAgICAgICB8ICAz
ICsrKw0KPj4gICBuZXQvY29yZS9uZXRkZXYtZ2VubC5jICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgKysNCj4+ICAgbmV0L3hkcC94c2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzICsrKw0KPj4gICB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvaWZfeGRwLmggICAg
ICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+PiAgIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9u
ZXRkZXYuaCAgICAgICAgICAgICAgfCAgMyArKysNCj4+ICAgdG9vbHMvbmV0L3lubC9nZW5lcmF0
ZWQvbmV0ZGV2LXVzZXIuYyAgICAgICAgICB8ICAxICsNCj4+ICAgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL3hkcF9od19tZXRhZGF0YS5jICB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPj4g
ICAxNCBmaWxlcyBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K

