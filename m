Return-Path: <linux-kselftest+bounces-1140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9218057A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584681F2173A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81F5D8FA;
	Tue,  5 Dec 2023 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjqocZkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDD1B3;
	Tue,  5 Dec 2023 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701787418; x=1733323418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2UGO64/TKU1y+jVPuWZMbdNxXeq7w/QiSBLabURT1UQ=;
  b=AjqocZkjfhkH7m9yNW36OgEJlYIbF107401qlB3lyzNbtMFcRMZGBruy
   /71cP0gdLDfo3Dt1l0pdcmElQoibf/GLRuQRYVRdaBEWrAwZAC0AU7XYN
   SOybLvXgrOIjaRgCFxhGKtxoRRP1rXZKw4RtKL/tcg10hN2YxFVtBqP6J
   cIHuTwK8xWCqxaExh4RAiURj837Iy98rcYXgNsYuHymvpo0ERW37QYQdw
   N38vfsoohRKNzs8moHbNlYR7dqIdYMqnVkpAaz5s2Peftw3QQZwfkJEfv
   q6aHDFbkfPqUOrLlvHARBcghiVrtnJOYiZwi7z16dDdoJkys4H9vlqMiY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7247817"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7247817"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888957767"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="888957767"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 06:43:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:43:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:43:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 06:43:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 06:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apx8ehq9i9fUM3SK6jhfO/O4CICeAYffak/JhFKbTE1C7mM3GWQwzCpvWbLsXq2FauV3FmTrtLW2KYV+VHZz3q4srC3FnIqbPtLAOLFVMbSwyVIgZfd1JAvg/bzdnB+TosFRKFVL6Kt/xSiCC1ek330YiYY0bf2AlLiZQ5IvuqJ9gM3CUXa1tKjiB1p+4w6lPQvypeB+X0eikHadNLusvXY5UaYEkpDy8ngM40DCpAo6CGKcQRhufKFyTuf+yfGibTpD7Ef7SK0tURIw1johs8isr3tOpOYzNRyzxzA/1JCC+OTaGsrGfBAARf+HCYj2BMk38u/jcAIWgnYuGagjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UGO64/TKU1y+jVPuWZMbdNxXeq7w/QiSBLabURT1UQ=;
 b=MQp/+AyELo1aOeyXeO3S+3p0ADlVRTw4hmspXKFN3/smdHi7bCFIWM2dkA3ikGLABUxdt1R5nEf6d0yEyVLyVNNHpJMF8lxG0CUIcGph2sL+QplkbzjHpbxGko+QGt4V/fGAW7rm1kfOcifpO1sNydqD1ns54C0J53MswCI7as8oGjW4kn8Fc2ZQ1YlFpeQ0rDbrISD2K1FXvUszfqWWJwwq7gdPjssH6XqmHqbk07vdS63S1JFAxb4XtljfLt0YqYplOGxLpJF8b0D6zCCPoatmhorqRqN0dlRAEAwENl4Vyz9Ow4T374/GUfliXrCjHNjiqwCO5SNfvib2TTo8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:43:31 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:43:31 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Topel
	<bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
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
Subject: RE: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP ZC
Thread-Topic: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP
 ZC
Thread-Index: AQHaJB8y3IJpv0o6sk+7VcjRfinq5bCUhocAgALJsHCAAewHgIABi3dQ
Date: Tue, 5 Dec 2023 14:43:31 +0000
Message-ID: <PH0PR11MB58305C7D394FD264F1634819D885A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
 <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
 <PH0PR11MB5830F08AC202C42501D986C0D887A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <656de8eb14c24_2e983e29435@willemb.c.googlers.com.notmuch>
In-Reply-To: <656de8eb14c24_2e983e29435@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS7PR11MB7783:EE_
x-ms-office365-filtering-correlation-id: f275083c-0dab-430f-53a8-08dbf5a08d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eB146ooX5W9ZpE1g9+IzjfP3eANOdxx/1VP0P3XPKExLsyl3OaqXh9HjZEJbTxlVVxos4gyotx9Y4JqaoNXPiWOdfkUNPwDWe9UraJeqEIIzGdcikwMZ6LbEF/SNFg0BtPOg3hO45BiMzQ5h6BU9/If9Xq6AkEqZqnMQ3/6w4OufPNBxeWJU2AGLCVOudiSqis9hftNY/y4SwNZQjoJLxeyZqVDE84CoKcpuj3bywZrdvxse1O0zeN3MXK4udUQrQcrVf6O6aaLkywQ2ikadK0eQm42rr6PNm85bVM4Pliic4NtXkpu0njnZPlMzPB7IFzl1pLGhW1bWOg7vODcR9EcDTUravz/xbkegVpCPv4Ec7LcVgJYpMLDbv5qYxlqYNeJ05VcuegLfTFzdQ0LWwyw5Cpf+zyf1fu2HW7MYMlyj0QK8vr+MxQhv87FcthcupLnKoDHJevWIlWX12Zp8ns5/20j2KGwB5cCTmKrvxqtBrWinGcpXMH6ybYbRqrgFOUIKCkvuzkb5fsGHmYnFfLpNa+LGhnomXtmXMQI0c8G0grvaTQGegSONoSyNQKXgEWaVuBTVLraJHZvpt238JPIxm1g8yj5EztyMaIJB/GJYHanyCoJdRtjMkGg0JZXT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(54906003)(33656002)(316002)(76116006)(66446008)(64756008)(66476007)(66556008)(110136005)(66946007)(478600001)(71200400001)(5660300002)(7406005)(7416002)(38070700009)(2906002)(8676002)(52536014)(4326008)(8936002)(921008)(86362001)(82960400001)(83380400001)(55016003)(38100700002)(26005)(41300700001)(122000001)(6506007)(53546011)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2JaMUwybGtORVhWbmJRZFN0WTFrcVBVRGVxd1NORERjNCtxdWpVdXJPcEtm?=
 =?utf-8?B?WW8vZ3lIREQ0ZElsY01SN2I2dzczWjI1UVBsZ3hacER2cU81Z1F1NkJYK25n?=
 =?utf-8?B?K1VBMzBXVnhwd3Zwd2tKYVliejZwQVd0MStnU29HRklMd2dNSVpSS0ZmRnRO?=
 =?utf-8?B?SHVoWkhJMjk1azFvcDA4S3ZCMHExanlFTHhYNjczbU8wTWVES01aazR1ek1Q?=
 =?utf-8?B?Y2Y0Tnd3cG5tVWdWL0d4NnIxb3lTdW5HQ0E1T2ZpRTN5UlBDaVFvYTJJd1JF?=
 =?utf-8?B?VWZNaXZuOGtZWC9tdXRjd3hPbElqalpnQXFKNnhXOS9JT3JWTGoxZE1aQ3Bq?=
 =?utf-8?B?Wkdla0RjT1pZNlhJZWlGZWNXN1lGaDhyUk1PcnNQNWZEektSMVQ2YnNSMnk4?=
 =?utf-8?B?bHZHVFVLaFcyZ3Y3cWRVWDhqWnNhb2FIMDJXVnM2NFNkN3NqQzNIS3VQbng2?=
 =?utf-8?B?dE40ckU2aFNzSUVXNXRiQTFMRW51ZkFtK0h0cTFVRXF1My9VTFZDaUdhTXQ2?=
 =?utf-8?B?VVpVWWtnSWl5UUZxZVY1UVlmajlHUVdYYzIyR3JQaUZoRDJwQlhvVVM2Um9y?=
 =?utf-8?B?dWRBSTZJREpEMlZyQkhsWnd2OUMzM0pjcXJsYjBvU291N3NEK0JCdmVQT3JT?=
 =?utf-8?B?dWZtRE9XK28wU2NzRk81bUtVL2U2cThDaEFtVzdIbytvZlNXVW1DU3hCNER3?=
 =?utf-8?B?RGtjZm1NRlQ5d0xVWXR0K3VBbFRKQjBaYWRlUjdNRVdpRks5VlhhQkxwRXNy?=
 =?utf-8?B?eWw1LzJlUHRTcHlheW5CT1BPQXg0NC9GNjhQVU9ZK3p6MmtERWFUazc0eTNy?=
 =?utf-8?B?SEgyRlphTkxweFl2UVdPaVhZUkZVZ1ZlVHdnT01xeW8wYzBmbmZqRWtsamhi?=
 =?utf-8?B?TXRTSXdrcjB0MFFRWUp0cjMwZ1pTMlpXckVTVU1FSGdaREtlM0xqMm9OVmVh?=
 =?utf-8?B?bTJjYzdodThvdmZqM2kyS1hKMi9rWkp4VFZPZk16VzY2bGR2dmdZZWRtb2xB?=
 =?utf-8?B?UlpMK0M0Q1V5dkt2aG9WZEdwWFgvUjNiWDQvbUNQajh5NGxSQzJzTll2TGFO?=
 =?utf-8?B?U2Z5VG1HZmgySlVCYU5WSE9hQjNwdjBvOC9Pcm9qTE9RNmEvUmo2WC9ZRktz?=
 =?utf-8?B?c1Z6L1QzVlc4cXQyNFJEVHFBenB4UEJ5bnJkMldyRWwyQjlQVGR6REtUV1Bn?=
 =?utf-8?B?UzM3cXpabEczakFiTWhKdnZBdVFoOFhKU3hkcXRWay9QQTFNaE96dXlKZ0Vy?=
 =?utf-8?B?aGdXYlRqV0ZqMUt0VmVYUnZEbG9pNE1EU1FUWE9qTGI3dE5xbnYwZENhUDlI?=
 =?utf-8?B?TCtVMTV4RWxDWlJaNkQvTDVoTDY0UzVwZXRDeGRqcDhHMFZaWmVFQ3l0YVR5?=
 =?utf-8?B?bE5ZWkYrdDI2bm1uODloMGZEUGhNVDRic05BNkV4YnNnQlJzTEhqTXZ1WTFj?=
 =?utf-8?B?YUFMVkNucGkzeHJSNlI5Vk9UNVQ3YTZtYmszU3p5MnlDL1FRbzdGYjVPSlYz?=
 =?utf-8?B?b3BBUlcwUFVkcVQwcWVMeTRRQ0JtdTBIaEk3OVUrQjlwcW81ZUliSmVRV1VX?=
 =?utf-8?B?UFZCR2xYSVBnaXJ0VVZqODNJc2gva0poN0ZkQzZlS0psdllxYTFEMHFZV0c2?=
 =?utf-8?B?dU85NWNzR0IxT3g4aDJyU3BOVE1jbms2Y25SY24vYkI1TDZwNlZCZDZWc1VM?=
 =?utf-8?B?ZlBPaS9IUlZYb2dFMGljd21xN3JXUDRiMUMwRmlaeVQ0ckNoWGNnUjRhRHBr?=
 =?utf-8?B?WDZyaW9ySlRweXYyNkVUWEVWNjNVdzUyTVBtSUdMalozVFVFSzdXWWVTaFgy?=
 =?utf-8?B?NW45L2Zmb1Jvald5TE40ZXRQUm9YM3NVYlMxRjVWQ1VwMFBuN25xV3RoWGx1?=
 =?utf-8?B?ai9kaUFrYXg5eWlZVjgrMTB0cDFvUkZ2RVAydWtFdS9PZko0T2NQL0RMVVFs?=
 =?utf-8?B?bWhidlllMlIrT1NWVnUrWXE2YVFTVEQramNJQWpuWmt0TFJNYWc2djJYN0Z5?=
 =?utf-8?B?TUZNTUFuQUFuU01lSHVJZ1ZnWmliNnJvVlVjTFE5c3Y5V2RwMklwOWk3VDVJ?=
 =?utf-8?B?TENmdlcramhIRVFxc0dreDNSelF5K0hUcGQ4d1lVcnZ3NElKRCtiN2d0RlRz?=
 =?utf-8?B?Zi8vSE5Tbk1OYU4xV24walJsYkRKc3hsaytuWTNVckNwNGVYRGhiS2JzM2da?=
 =?utf-8?B?a0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f275083c-0dab-430f-53a8-08dbf5a08d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 14:43:31.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUP9lNVWNHec81oKlKUWkWX+Y8gV3NCgoK65bDA+IhbiIwx7P6IXlcqMcc/ef6/oU53hnSmPd/g0IUWkfrtPzmlsCiIz2F1yuuk05gxTz/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com

T24gTW9uZGF5LCBEZWNlbWJlciA0LCAyMDIzIDEwOjU4IFBNLCBXaWxsZW0gZGUgQnJ1aWpuIHdy
b3RlOg0KPlNvbmcsIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4gT24gRnJpZGF5LCBEZWNlbWJlciAx
LCAyMDIzIDExOjAyIFBNLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPj4gPk9uIDEy
LzEvMjMgMDc6MjQsIFNvbmcgWW9vbmcgU2lhbmcgd3JvdGU6DQo+PiA+PiBUaGlzIHBhdGNoIGVu
YWJsZXMgdHh0aW1lIHN1cHBvcnQgdG8gWERQIHplcm8gY29weSB2aWEgWERQIFR4DQo+PiA+PiBt
ZXRhZGF0YSBmcmFtZXdvcmsuDQo+PiA+Pg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogU29uZyBZb29u
ZyBTaWFuZzx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+ID4+IC0tLQ0KPj4gPj4gICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWMuaCAgICAgIHwgIDIgKysN
Cj4+ID4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4u
YyB8IDEzICsrKysrKysrKysrKysNCj4+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspDQo+PiA+DQo+PiA+SSB0aGluayB3ZSBuZWVkIHRvIHNlZSBvdGhlciBkcml2ZXJzIHVz
aW5nIHRoaXMgbmV3IGZlYXR1cmUgdG8gZXZhbHVhdGUNCj4+ID5pZiBBUEkgaXMgc2FuZS4NCj4+
ID4NCj4+ID5JIHN1Z2dlc3QgaW1wbGVtZW50aW5nIHRoaXMgZm9yIGlnYyBkcml2ZXIgKGNoaXAg
aTIyNSkgYW5kIGFsc28gZm9yIGlnYg0KPj4gPihpMjEwIGNoaXApIHRoYXQgYm90aCBzdXBwb3J0
IHRoaXMga2luZCBvZiBMYXVuY2hUaW1lIGZlYXR1cmUgaW4gSFcuDQo+PiA+DQo+PiA+VGhlIEFQ
SSBhbmQgc3RtbWFjIGRyaXZlciB0YWtlcyBhIHU2NCBhcyB0aW1lLg0KPj4gPkknbSB3b25kZXJp
bmcgaG93IHRoaXMgYXBwbGllcyB0byBpMjEwIHRoYXRbMV0gaGF2ZSAyNS1iaXQgZm9yDQo+PiA+
TGF1bmNoVGltZSAod2l0aCAzMiBuYW5vc2VjIGdyYW51bGFyaXR5KSBsaW1pdGluZyBMYXVuY2hU
aW1lIG1heCAwLjUNCj4+ID5zZWNvbmQgaW50byB0aGUgZnV0dXJlLg0KPj4gPkFuZCBpMjI1IHRo
YXQgWzFdIGhhdmUgMzAtYml0IG1heCAxIHNlY29uZCBpbnRvIHRoZSBmdXR1cmUuDQo+PiA+DQo+
PiA+DQo+PiA+WzFdDQo+PiA+aHR0cHM6Ly9naXRodWIuY29tL3hkcC1wcm9qZWN0L3hkcC0NCj4+
ID5wcm9qZWN0L2Jsb2IvbWFzdGVyL2FyZWFzL3Rzbi9jb2RlMDFfZm9sbG93X3FkaXNjX1RTTl9v
ZmZsb2FkLm9yZw0KPj4NCj4+IEkgYW0gdXNpbmcgdTY0IGZvciBsYXVuY2ggdGltZSBiZWNhdXNl
IGV4aXN0aW5nIEVEVCBmcmFtZXdvcmsgaXMgdXNpbmcgaXQuDQo+PiBSZWZlciB0byBzdHJ1Y3Qg
c2tfYnVmZiBiZWxvdy4gQm90aCB1NjQgYW5kIGt0aW1lX3QgY2FuIGJlIHVzZWQgYXMgbGF1bmNo
IHRpbWUuDQo+PiBJIGNob29zZSB1NjQgYmVjYXVzZSBrdGltZV90IG9mdGVuIHJlcXVpcmVzIGFk
ZGl0aW9uYWwgdHlwZSBjb252ZXJzaW9uIGFuZA0KPj4gd2UgZGlkbid0IGV4cGVjdCBuZWdhdGl2
ZSB2YWx1ZSBvZiB0aW1lLg0KPj4NCj4+IGluY2x1ZGUvbGludXgvc2tidWZmLmgtNzQ0LSAqICAg
QHRzdGFtcDogVGltZSB3ZSBhcnJpdmVkL2xlZnQNCj4+IGluY2x1ZGUvbGludXgvc2tidWZmLmg6
NzQ1LSAqICAgQHNrYl9tc3RhbXBfbnM6IChha2EgQHRzdGFtcCkgZWFybGllc3QgZGVwYXJ0dXJl
DQo+dGltZTsgc3RhcnQgcG9pbnQNCj4+IGluY2x1ZGUvbGludXgvc2tidWZmLmgtNzQ2LSAqICAg
ICAgICAgICBmb3IgcmV0cmFuc21pdCB0aW1lcg0KPj4gLS0NCj4+IGluY2x1ZGUvbGludXgvc2ti
dWZmLmgtODgwLSAgICAgdW5pb24gew0KPj4gaW5jbHVkZS9saW51eC9za2J1ZmYuaC04ODEtICAg
ICAgICAgICAgIGt0aW1lX3QgICAgICAgICB0c3RhbXA7DQo+PiBpbmNsdWRlL2xpbnV4L3NrYnVm
Zi5oOjg4Mi0gICAgICAgICAgICAgdTY0ICAgICAgICAgICAgIHNrYl9tc3RhbXBfbnM7IC8qIGVh
cmxpZXN0IGRlcGFydHVyZQ0KPnRpbWUgKi8NCj4+IGluY2x1ZGUvbGludXgvc2tidWZmLmgtODgz
LSAgICAgfTsNCj4+DQo+PiB0c3RhbXAvc2tiX21zdGFtcF9ucyBhcmUgdXNlZCBieSB2YXJpb3Vz
IGRyaXZlcnMgZm9yIGxhdW5jaCB0aW1lIHN1cHBvcnQNCj4+IG9uIG5vcm1hbCBwYWNrZXQsIHNv
IEkgdGhpbmsgdTY0IHNob3VsZCBiZSAiZnJpZW5kbHkiIHRvIGFsbCB0aGUgZHJpdmVycy4gRm9y
IGFuDQo+PiBleGFtcGxlLCBpZ2MgZHJpdmVyIHdpbGwgdGFrZSBsYXVuY2ggdGltZSBmcm9tIHRz
dGFtcCBhbmQgcmVjYWxjdWxhdGUgaXQNCj4+IGFjY29yZGluZ2x5IChpMjI1IGV4cGVjdCB1c2Vy
IHRvIHByb2dyYW0gImRlbHRhIHRpbWUiIGluc3RlYWQgb2YgInRpbWUiIGludG8NCj4+IEhXIHJl
Z2lzdGVyKS4NCj4+DQo+PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4u
Yy0xNjAyLSB0eHRpbWUgPSBza2ItPnRzdGFtcDsNCj4+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lnYy9pZ2NfbWFpbi5jLTE2MDMtIHNrYi0+dHN0YW1wID0ga3RpbWVfc2V0KDAsIDApOw0K
Pj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmM6MTYwNC0gbGF1bmNo
X3RpbWUgPQ0KPmlnY190eF9sYXVuY2h0aW1lKHR4X3JpbmcsIHR4dGltZSwgJmZpcnN0X2ZsYWcs
ICZpbnNlcnRfZW1wdHkpOw0KPj4NCj4+IERvIHlvdSB0aGluayB0aGlzIGlzIGVub3VnaCB0byBz
YXkgdGhlIEFQSSBpcyBzYW5lPw0KPg0KPnU2NCBuc2VjIHNvdW5kcyBzYW5lIHRvIGJlLiBJdCBt
dXN0IGJlIG1hZGUgZXhwbGljaXQgd2l0aCBjbG9jayBzb3VyY2UNCj5pdCBpcyBhZ2FpbnN0Lg0K
Pg0KDQpUaGUgdTY0IGxhdW5jaCB0aW1lIHNob3VsZCBiYXNlIG9uIE5JQyBQVFAgaGFyZHdhcmUg
Y2xvY2sgKFBIQykuDQpJIHdpbGwgYWRkIGRvY3VtZW50YXRpb24gc2F5aW5nIHdoaWNoIGNsb2Nr
IHNvdXJjZSBpdCBpcyBhZ2FpbnN0DQoNCj5Tb21lIGFwcGxpY2F0aW9ucyBjb3VsZCB3YW50IHRv
IGRvIHRoZSBjb252ZXJzaW9uIGZyb20gYSBjbG9jayBzb3VyY2UNCj50byByYXcgTklDIGN5Y2xl
IGNvdW50ZXIgaW4gdXNlcnNwYWNlIG9yIEJQRiBhbmQgcHJvZ3JhbSB0aGUgcmF3DQo+dmFsdWUu
IFNvIGl0IG1heSBiZSB3b3J0aHdoaWxlIHRvIGFkZCBhbiBjbG9jayBzb3VyY2UgYXJndW1lbnQg
LS0gZXZlbg0KPmlmIGluaXRpYWxseSBvbmx5IENMT0NLX01PTk9UT05JQyBpcyBzdXBwb3J0ZWQu
DQoNClNvcnJ5LCBub3Qgc28gdW5kZXJzdGFuZCB5b3VyIHN1Z2dlc3Rpb24gb24gYWRkaW5nIGNs
b2NrIHNvdXJjZSBhcmd1bWVudC4NCkFyZSB5b3Ugc3VnZ2VzdGluZyB0byBhZGQgY2xvY2sgc291
cmNlIGZvciB0aGUgc2VsZnRlc3QgeGRwX2h3X21ldGFkYXRhIGFwcHM/DQpJTUhPLCBubyBuZWVk
IHRvIGFkZCBjbG9jayBzb3VyY2UgYXMgdGhlIGNsb2NrIHNvdXJjZSBmb3IgbGF1bmNoIHRpbWUN
CnNob3VsZCBhbHdheXMgYmFzZSBvbiBOSUMgUEhDLg0KDQo+DQo+U2VlIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL25ldC9zb190eHRpbWUuc2ggZm9yIGhvdyB0aGUgRlEgYW5kIEVURg0KPnFkaXNj
cyBhbHJlYWR5IGRpc2FncmVlIG9uIHRoZSBjbG9jayBzb3VyY2UgdGhhdCB0aGV5IHVzZS4NCj4N
Cg0KDQogDQo=

