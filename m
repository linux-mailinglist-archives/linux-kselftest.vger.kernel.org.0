Return-Path: <linux-kselftest+bounces-925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93767FFFD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 01:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077CB1C20EB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A017CD;
	Fri,  1 Dec 2023 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNGa5SV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB4210DF;
	Thu, 30 Nov 2023 16:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701388938; x=1732924938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f+m8fq+ECjOKrfR3VMXpKFS5tDoo4ZMHKSfbcDtvmy4=;
  b=DNGa5SV/c+hd0Nwokd5LNNJebpZFziC0WjeUaRkxab0L76biNU6LFk16
   4ZAzww6OpF/3A+RuWFRkASu/oBAnoTuBu1MdkAwEcDdoudT28Llz7eDMc
   kZr+qwAD8hS8JKEr8tellpAf1A/dnYgi0AQsGLP22AZKtidSB0j0XSPCP
   hv3crE0y+KlVKjKrGYyhVKgdoZD7A2VVv2663UW6ceH1N9rqr6/iXclzg
   ncWZEdykP7Im7OjxpXiySNubYidv9UiXjD8jJuLXawC0QfkOvpbak5v6F
   SzoT8FiXkYcGqymFJNWIvpueZkkkxBfhbYwOg/wJXt/cF55OQ/WV7cEj8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396215384"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="396215384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:02:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="762923099"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="762923099"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 16:02:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 16:02:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 16:02:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 16:02:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 16:02:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA4cIQG0x4PCFCHBmARvjTWyziy8uevFMywf0s7nVLDEzUpwGoKuKDctdvGN0BiDaPMhv1hQ8t/f6utwZNBBztgANGHjpJlQMX2k9CJx/G9mkpQrr9+QanwpvyMjQMUidHm97n/YYmotA8zeIvPsilNytGjltx7NZ06LMq8WVN5RECKRkYOlNL6+3/3DXgtszlmPJDGCrsjIMyinWgURQGkVNgIqbihQYbXsJBcri5xcO/VYL1F9r+mNh1LJNdJvLTRsFUdb9uvacRIT3VwBV0/Lz+jbe01/ncp6CAG7ZuLBgDlzP+eQqQhP11sHDXSX5sc+Aygqp6S2OOlB+b28mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+m8fq+ECjOKrfR3VMXpKFS5tDoo4ZMHKSfbcDtvmy4=;
 b=Iax5PzGy/OJg1cBtCCpaE2WMssWveJAS/cZvz0idtvM73YYhSOMMqPXdFvLXBk+L1tc7GAnva2xmm1EOl5iQlFOe1cl6t19gZx1IC/wy98/EQCT3YD6wSaEDemtmasa8pOg1DcgDGqxZDMRGzZnCTnZsc9nK+E22+F53VhW1ZJft9ERJ+baXGN8cA4046C3JdmVjVjldw3KKnm0fmm/MhzcLDFYmBs5srPCvmdkLRJPj7bt5DMZm39URPExCYNPI2AXu4tUk0jRhsP/QDuAhsa6I2v6gjxQRFKUJ1P20K7N3Da2urLy/KDygf34GSk2qRsr127+d0OWShOKM6cRbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by BN9PR11MB5404.namprd11.prod.outlook.com (2603:10b6:408:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:02:14 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 00:02:14 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Willem de
 Bruijn" <willemb@google.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Thread-Topic: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Thread-Index: AQHaI6lNhMbclA0v6kGITaNu3vmUTbCTUEQAgAA6CiA=
Date: Fri, 1 Dec 2023 00:02:13 +0000
Message-ID: <PH0PR11MB5830FE1DAF09BDBAD59A1A9AD881A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
 <20231130162028.852006-2-yoong.siang.song@intel.com>
 <6568f07418508_fbb8229478@willemb.c.googlers.com.notmuch>
In-Reply-To: <6568f07418508_fbb8229478@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|BN9PR11MB5404:EE_
x-ms-office365-filtering-correlation-id: 0d3d2632-58ce-4d10-9fb6-08dbf200c60a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H60uFX4qCVv1PAmohp8co7gA7m7Sv4kkvu5EZce8w+95gd5AIy3B23vyrE4Bjj+OwznQ/iVlcnjQ9KYWudbd2Wcu8Y3fDD1IPEBoFEgyuMuIDEOSVdY/6pWIDKT5Vy77/TkLl4C5mGDfsf3es0K8TitSChyB1ir1JbU5flbzURZt5cFX243qz81LT1qnQ6p9slDz55W/C3jZM6dYeu32murZZb1GfXPqw8gLLvCSnMeLTrlgsDGpDNNRFu5CNkhWU3xabxS3Fazvll7ZzMZGiTkNPogQ0XoY1gN3m4LIaBG3el3tvyE88lRj/rII/RluCwK8JmZnqnyzUnX3wZrlb8uSq6gFqoHcVOfzq+NuMEqCVXrfvDZ5+6CM9KTp5q5NKwYbEFjDwvLXd/D0ZZuLdRYKSAI55U+2Py2FHBAcWguToig93kzcRRnoc+iEZvafIVZU4HLOB+MrTd8eNo+KJ+mz8/8VZHD5gsNlw3VI0YJc1sQKhHJPQt2CJOdLwwcnwICBuBTYVA9DbEpHBHnjI7u5DIoWPbb92ZRVDoMpFmm1NXBKVrWOlaUFbEJuuIVgf2EI3uAlyyYPjvdut0i1OaNL2NJofsksKNlmYr1fAXhhTgbSrHxwl37T3vjYHylR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(71200400001)(26005)(6506007)(53546011)(76116006)(66556008)(7696005)(52536014)(5660300002)(9686003)(7416002)(7406005)(41300700001)(478600001)(64756008)(66476007)(8676002)(8936002)(66446008)(110136005)(54906003)(4326008)(66946007)(2906002)(316002)(122000001)(38070700009)(38100700002)(82960400001)(86362001)(33656002)(921008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHcxSE1NcW56ZG9DUUtYUS9pUGppOGVKTWdEY2ZqQmZCbm1pQ3JaWFZHZE5u?=
 =?utf-8?B?SFFHbzEzVzlSNlBWTzU0TkNNNytmT00vZ2pYU1ZWUTNEV0YyeVV1ZlN0c1Rj?=
 =?utf-8?B?RTU2bFdkZXpzajNIeE91ZVpYRisyRjcxVkIxcFpWYlNvQkpONHVYT2kxVHZy?=
 =?utf-8?B?T0ozNWhOTExwMWJ1S0JBWjhNUTRGOVRuUWhnTGRIU2JycktHVzkyUW1icUZC?=
 =?utf-8?B?OE13eThyNXQ5WitZckQxWEE1SDJ3LzlGd3RzcWtHV1JBNm9nTlFKVU4raTZh?=
 =?utf-8?B?cGZ5NlV4YTE0R1Qwa1ZJdU9oWmVzVEw5dkh4NGJKd2JJeVk4Y1pRYUs1TVBm?=
 =?utf-8?B?MlNSTGYrSEhFT1FDejBhSXdwNWpBQ0ptaE5JVk91NmV2N3BTNDRVY25MeEY1?=
 =?utf-8?B?QjdRQjBsc0JDT2pWV0JNQzB4YmViaUE4ZVFPYzBCakVuZVhBeU1EQ2haT1FT?=
 =?utf-8?B?NkdvM1htbVljRUVOSnpndVVxTzdvZjEwRXYrc0ExcWdycDk3L0ZoSTlkUnNo?=
 =?utf-8?B?VGtNZ21waUdVZ1NuQzU1THRTVGVYRVVxVks4dGsrOTNDTG9DUW1ZRGlob0sw?=
 =?utf-8?B?Ykp3c1Z4NGxGbUsvZGJtckdsQVhNR1pjZTRmRkh1TWd4TjZmaDJVS0M5K28r?=
 =?utf-8?B?WTJVM09ndm5CM1B0K29Kb2dhdGtNa0NlaE82T0sxVDRZYVJTbjdQemhnRllh?=
 =?utf-8?B?Zk9JSkdVUm14VzdmQUoxbVlHQ0xzNHdUQ2lHVHhCU2Nma3NDVEtFWUQ1ckNZ?=
 =?utf-8?B?LzRCWEt1VzcvWDhmNWFvbEhvUkJ2TjZ3K3drOUdOdWNxVnUxbXlXNlVlWGV1?=
 =?utf-8?B?NkdERlNhMU5HRjhQT1ZjZERhaGN1Tno1V3N4V2lsUFptdEVlR3R0ZTZpN1pH?=
 =?utf-8?B?d3R3ajZDUmtzVVd1TkNuVEswbEFjLzhFTDZZSm90WFNmSW50TURPV3N4aXZI?=
 =?utf-8?B?d05jMVpVVGU4RnlndllYeGNLMVY2ZWJDbC9GZ3Q2a2VqMkVwNlFhcjI1N2Nx?=
 =?utf-8?B?dGVMUUV2K0xaVTFseGV0RHpIaldwV2RKUktxaE9GdGRWZElKMEE0eFFvMmg1?=
 =?utf-8?B?SDN3L2c2OWQwZ3h3Z3B1Wk1PTjczc3RocE96WGpQbCs1RDJuMis0emUwQWJy?=
 =?utf-8?B?UXZLeGkxSE9WWU9vU01RalhxbXdWYzkrVUNRenQrcytGVW40RUlHY3JRWEY4?=
 =?utf-8?B?SHZCUnFuRnRUSy84ZklER2FtaWdTRXp6dW44ZktFR3c2QVI0UUJjMDdsWldF?=
 =?utf-8?B?SXMzeFJiblpEb0c4STZwLzRnRmplY3VNMnVtSjhVL2w2WXZBaGVQZTFTSlcv?=
 =?utf-8?B?ZCtibmpvQXFOMGtWRlI2R1FsQnBKT3hvUGNGU2pNbnVSc2gxVTNGaWRndi9I?=
 =?utf-8?B?eFpkV1UwZmNMUkpSWTJHUlR0SWdLMnQwbDRlOHpWemMvdnJkUi9mVHl2bnBk?=
 =?utf-8?B?RWx6WnRHZFdIaWpyTEdvbEt2c0ZidjNxaVp1S1JxeEhzSUFzcm1FakJxbkRj?=
 =?utf-8?B?dk9CVHBTdXRWVFVvUWpwQWd1ZS8yaVNIWERMTEY5ZDcyb2tIYXg0NHNBam10?=
 =?utf-8?B?eFNwWGtKL3dWQmNrd3Bra3JkazRGcTUvaFdDK28xY0RzTzNxb0sxUUkyenFK?=
 =?utf-8?B?eHllaVYrQ2t6UmQ0VDcwQWZxWkZoN0ZubUZyNGV5VWRka1M0K1h6bXBSN2N3?=
 =?utf-8?B?YUxESzl2REVWQVhsSnh6K0FnbVBwaVdtK0N4M1RxSktjbDNhKzlvZlFPTVk1?=
 =?utf-8?B?SWRyNENocVFmRkNscnJ3Y3VvQ3I5SEVYVEZlNzVISWliWVBrbnloU0RzZzds?=
 =?utf-8?B?WEM5MnA2S1J0YlhlMFh3Z0xicFp5eVJIeDBxR0tTaVZKaW5OT2FwbG9taUtY?=
 =?utf-8?B?TzFrMGUwdEZIVno1ZEdxcUhCZ2xVRjA0VGtsdFhEaFdMSmpBUXdPU0RZMXBJ?=
 =?utf-8?B?ZVk0ckIwOUVBN1BQWHdNekgrVTZLc1pESXl4Z1EveG1hYllFeXZyemZjTUN4?=
 =?utf-8?B?R01Id2U2R1B4dFpMUDZwT1QzYTdaaFVkUGRxd3g0VDI1NVhGNEs0elAxOStR?=
 =?utf-8?B?eHpmenhBWXpGNThQZW5jb3BIWVU5VEVhL0RBOExjc2NMMHRtTkErV0Fxa09C?=
 =?utf-8?B?MHlsT1JZdTdLT09uNWp6aTVBRUQ4c0dqZVlSMWdqVEUvaE1QM3pNbWRQdWFa?=
 =?utf-8?B?NGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3d2632-58ce-4d10-9fb6-08dbf200c60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 00:02:13.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SL2F1kVbt22kvB5Ulk2hea0m8Yw5tVfmw1SL2ltWNaP6tAj3hGrgkLkfPLFsy7Dj/FQlBGO0D4vWIhurRS22fYjPncvbWP6wqGBYsG/vug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5404
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBEZWNlbWJlciAxLCAyMDIzIDQ6MjkgQU0sIFdpbGxlbSBkZSBCcnVpam4gd3Jv
dGU6DQo+U29uZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggZXh0ZW5kcyB0aGUg
WERQIFR4IG1ldGFkYXRhIGZyYW1ld29yayB0byBpbmNsdWRlIFRpbWUtQmFzZWQNCj4+IFNjaGVk
dWxpbmcgKFRCUykgc3VwcG9ydCB3aGVyZSB0aGUgTklDIHdpbGwgc2NoZWR1bGUgYSBwYWNrZXQg
Zm9yDQo+PiB0cmFuc21pc3Npb24gYXQgYSBwcmUtZGV0ZXJtaW5lZCB0aW1lIGNhbGxlZCBsYXVu
Y2ggdGltZS4gVGhlIHZhbHVlIG9mDQo+PiBsYXVuY2ggdGltZSBpcyBjb21tdW5pY2F0ZWQgZnJv
bSB1c2VyIHNwYWNlIHRvIEV0aGVybmV0IGRyaXZlciB2aWENCj4+IGxhdW5jaF90aW1lIGZpZWxk
IG9mIHN0cnVjdCB4c2tfdHhfbWV0YWRhdGEuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBTdGFuaXNs
YXYgRm9taWNoZXYgPHNkZkBnb29nbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU29uZyBZb29u
ZyBTaWFuZyA8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBEb2N1bWVu
dGF0aW9uL25ldGxpbmsvc3BlY3MvbmV0ZGV2LnlhbWwgICAgICB8ICA0ICsrKysNCj4+ICBEb2N1
bWVudGF0aW9uL25ldHdvcmtpbmcveHNrLXR4LW1ldGFkYXRhLnJzdCB8ICA1ICsrKysrDQo+PiAg
aW5jbHVkZS9uZXQveGRwX3NvY2suaCAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysr
KysrDQo+PiAgaW5jbHVkZS9uZXQveGRwX3NvY2tfZHJ2LmggICAgICAgICAgICAgICAgICAgfCAg
MSArDQo+PiAgaW5jbHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oICAgICAgICAgICAgICAgICAgfCAg
OSArKysrKysrKysNCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvbmV0ZGV2LmggICAgICAgICAgICAg
ICAgICB8ICAzICsrKw0KPj4gIG5ldC9jb3JlL25ldGRldi1nZW5sLmMgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDIgKysNCj4+ICBuZXQveGRwL3hzay5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzICsrKw0KPj4gIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl94ZHAuaCAg
ICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+PiAgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L25l
dGRldi5oICAgICAgICAgICAgfCAgMyArKysNCj4+ICB0b29scy9uZXQveW5sL2dlbmVyYXRlZC9u
ZXRkZXYtdXNlci5jICAgICAgICB8ICAxICsNCj4+ICAxMSBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0bGluay9zcGVj
cy9uZXRkZXYueWFtbA0KPmIvRG9jdW1lbnRhdGlvbi9uZXRsaW5rL3NwZWNzL25ldGRldi55YW1s
DQo+PiBpbmRleCAwMDQzOWJjYmQyZTMuLmE2MDI3NzZiYmZiNCAxMDA2NDQNCj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9uZXRsaW5rL3NwZWNzL25ldGRldi55YW1sDQo+PiBAQCAtNjYsNiArNjYsMTAgQEAgZGVm
aW5pdGlvbnM6DQo+PiAgICAgICAgICBuYW1lOiB0eC1jaGVja3N1bQ0KPj4gICAgICAgICAgZG9j
Og0KPj4gICAgICAgICAgICBMMyBjaGVja3N1bSBIVyBvZmZsb2FkIGlzIHN1cHBvcnRlZCBieSB0
aGUgZHJpdmVyLg0KPj4gKyAgICAgIC0NCj4+ICsgICAgICAgIG5hbWU6IGxhdW5jaC10aW1lDQo+
PiArICAgICAgICBkb2M6DQo+PiArICAgICAgICAgIEhXIFRpbWUtQmFzZWQgU2NoZWR1bGluZyAo
VEJTKSBpcyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4NCj4NCj5DYW4gd2UgYXZvaWQgaW50cm9k
dWNpbmcgYW5vdGhlciB0ZXJtPyBXZSBhbHJlYWR5IGhhdmUgdG9vIG1hbnk6DQo+bGF1bmNodGlt
ZSwgZWFybGllc3QgZGVsaXZlcnkgdGltZSAoRURUKSwgU09fVFhUSU1FLA0KPnBhY2luZyBvZmZs
b2FkLCBlYXJsaWVzdCB0eHRpbWUgZmlyc3QgKEVURikuDQo+DQoNClN1cmUuIEkgd2lsbCBjaGFu
Z2UgVEJTIHRvIEVURiBpbiBteSBWMiBzbyB0aGF0IGl0IGlzIGFsaWduZWQgd2l0aCBldGYgY29t
bWFuZCBpbiB0YyBhcHBsaWNhdGlvbi4gDQo=

