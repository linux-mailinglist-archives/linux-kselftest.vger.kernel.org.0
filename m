Return-Path: <linux-kselftest+bounces-1025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B7802233
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 10:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A06B20A87
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0425848C;
	Sun,  3 Dec 2023 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/7jJrDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECFE8;
	Sun,  3 Dec 2023 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701595019; x=1733131019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RYUxdbYAZYv8PLnuyIA4cPv2ALCED1RS35pZU900Ic8=;
  b=l/7jJrDv2d6E11HLYGIrkzb7kjg46qT2tmXF/G350CFuHBT1BdoSeAQZ
   RYkOizolwMhd4VWtcHnZK5GhzuKc0QHozQPUYhg3aK/JeC6UrBhzXs1uS
   ShRywued7zmqf4iA8KIQzHJtOWLiINMveLOoMwNL4KWiFg97ajX6xYMJb
   bImKm3bBHY+w67D97iYO2Z/CqI4bgqpzTornKwaahNGi93Av22akFY4QM
   YIBG33GYuy+YX8AQEqickKjzT2h5s0hvBbzBZRiqW1uFJybVPedPhXPen
   2l/1JvLd/HVuwYO7i4c/6PqtrGvB4HiNn6Tsed2gOmzmRjxwfBf4g1jk5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="384039368"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="384039368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 01:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="804580241"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="804580241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 01:16:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 01:16:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 01:16:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 01:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUhbQRWLcxsar8FPltmj8NUfJIKLuhjHAag6yRDsUbhyfsZw11LMEakBfRapHmuRKbLQxJAFGOspIHb4P/uAdzgdEFDiHgUbvuO3unPwPOJk380mTaGMf4SvKC9jcA+eSU3J9ovIP0ReCpPInRhqjcjzEd3is13YX9O+8XhMaaf7gNwaiJ4jyJhhrAqYz28ikpy/+swypT/6WalcLfYG/mO0f3xIoeFZ9PFU5MkwxEslwJfyGBja9NkV7yF+rBF6iVzfMH4yRmLyuDm101LEa2AgAnSEZq7zoZfWOKjEWAQWf0BG8mbrAh+El7W2RcLSFwb3slBdjHGWGulA3Fe5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYUxdbYAZYv8PLnuyIA4cPv2ALCED1RS35pZU900Ic8=;
 b=DJ4bzeVZtnkkpJfWa8Vc0ou2iVzOxERFPFQWn1O3Cb1r26SpfaMblcU56aoMkpXrzckFFZtLNO82US3p03uFLWPd+7lzeIkCiWAbXM9hsXYbKen4DnS2e9h6N/NRJT2zqFndQiF2fL4iKKEKUX6xHxj613y9pyF23BPwcDtfB/QPxO+/jlrIP6mvSsL0NyS7aHEwy6O5M8NmZTon1dxePs6+pGegmQSyAYX9rE/MFB7vYT+YYqirpo0WaNgQI3p4ko+G7L5C4cwyNotLbkx4i+s/SWEXL2TDOS/Orx+6f8wyED8UQ8EysF6MIMxixyf1KXD7HTn2XCaqjdkf0jkt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 09:16:56 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.028; Sun, 3 Dec 2023
 09:16:55 +0000
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
 Abreu" <joabreu@synopsys.com>, Andre Fredette <afredette@redhat.com>
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
Thread-Index: AQHaJB8W7iUch8mtVUCDEJ1OnRle9bCUPv4AgAAvtGCAABnBgIAACHYAgAF66QCAAT2Q8A==
Date: Sun, 3 Dec 2023 09:16:55 +0000
Message-ID: <PH0PR11MB5830F6B01E7F06A5337E214AD887A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
 <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <6569f71bad00d_138af5294d@willemb.c.googlers.com.notmuch>
 <179a4581-f7df-4eb1-ab67-8d65f856a2fe@kernel.org>
 <656b3c0ebb103_1a6a2c2947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <656b3c0ebb103_1a6a2c2947d@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CH0PR11MB8235:EE_
x-ms-office365-filtering-correlation-id: 92d15ead-8a27-44f4-48d0-08dbf3e0986f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsAISheooq+lPeNddO3JLcyISUtvLhDlsLHP9XdOVNnSZMLVlwf32bmIN4kVthHwNltpPuow6NwcXHdLZPNat+ohYBwq6h/hxwghdb8oIzVaCpOEXjlNB00dfXJIKwC7U49VxNOR0VPf5vG+J2Ox9eWkT3acpXOHL4EFWXKr0Z+3n1UFn90Xd+H+R+3lRjMzLpNyb2wqP5kvbI84ie27/Na1vp4LVRKt/1oI5KBxHFZG6ux8f2UHxQ+NMWag28c5rW9Yb/e3bMqaKPmtTW4waNsYAbl+uOaRMfGMRAy7vTyoROPUZkMEOUPxJTy8kP22p+n+bYHYyMU+R3FtOn4MAJXquYBKkOgYofwbSuwblUqz9li5FxJ36euggJeSose1kAXwNoG4Dkz2Z5u17EWFcSKoUn3bqvgmJAVD5x8RYVlqSV9woP+a6GOaeY3HsBD9Ucf3r9uHwVrhQpzAF3DfzpgmbnoaW6w4gCgdDnDCxwyNEonEIMrR02G2i7XaMyzE/y2iWzW9BR5RNazA3bnwHGuJkTOUvmerK8DCpKjJHyNC6NwhMxTvInNt1Ht/pCc/zXY9hX3+uSud52KlDKfCMcfRHvRJRYrgrf9fq5URDRXnFf+6BGNOym8iG+Z4kTnI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66446008)(66476007)(64756008)(66556008)(110136005)(76116006)(54906003)(55016003)(316002)(66946007)(5660300002)(4326008)(52536014)(8936002)(8676002)(7406005)(7416002)(71200400001)(38100700002)(83380400001)(122000001)(86362001)(966005)(478600001)(2906002)(26005)(33656002)(6506007)(9686003)(921008)(53546011)(82960400001)(41300700001)(38070700009)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNqUGkrUnVUUGx5T2ljeHpaRnpyVzF6R1dkNWZhSVptRUg1V05uQnpsdmFz?=
 =?utf-8?B?M0U5VjZiY1JxVmpOSFBwdG8vazU1YnNFTStMZGhZeXloU0lYSExVU0EwbTIy?=
 =?utf-8?B?VVhkNm82RjFRaUJDV29mN2R4N3JqOG9ZMjVQaEVQSmZYczdQRy9KcGRZRFVi?=
 =?utf-8?B?VGZVM2lnWVV2dG10bHpIZTdVajNuOE1UdWl0N21ySWFHenc1ZnVic2luTllX?=
 =?utf-8?B?Nklnb0FnS2FsQ1ZKQ3VheDkwRDFWWlkxeHBaK0t2Qm8rNkxhM2lXRHF5S1Vr?=
 =?utf-8?B?eXcxdkpxMjdRZVQxakVnTG9KU2E5U1AyRlp2MEhjWFluanpYNTFkYWxDUDFL?=
 =?utf-8?B?ZlBMei80L0tnbDQ3U21maGxiLzd0K3dpOEdzZzB5N0hFWWllYVlkcXczM3hF?=
 =?utf-8?B?bDArVWhMR1NnYnhFL2xqak1VYlVzU2lyUWRaRWk3WjYrN0dwTnAxczgrTkdK?=
 =?utf-8?B?blNjOFV4SnVUMlAzcS8wcWFMNm5FeGZrYmd3YmFxZUxSbStkeVorcFhxTURs?=
 =?utf-8?B?SWhmSDFXcUpRMXpUS3ZQaTdlZkUva2NsRFNqWjJ2dXA4NGpVaVNsMnArdDVX?=
 =?utf-8?B?UkpaRHVuMHUyN0l4RGF2bXdsbkNvVGtPbkgvVFFQWEhlMVg5ZXF4ckV0UkpV?=
 =?utf-8?B?TkdtVm9TSG9iYzJFbGI2bnNHaWtRNEVNU21uMk5iR2xXazVLeVBnUzVGR0J2?=
 =?utf-8?B?RWRpcG1iQ2JNa1N1Z21HQnNTV0c2eUs1UHRCZWI0ZWRzTWVSTDFGOGppODFk?=
 =?utf-8?B?c3Y2UTNmSGJFbWlHeWxxSDVtT2gxcWNpcU8rQXFhQ3Y4SzFSSXEyZG9abEw0?=
 =?utf-8?B?VTZvZS80ckxmcGJZZ29nRTlRbjJqSWF0V0RRYVhkREQ5R1pMYkVqUXdNUzB0?=
 =?utf-8?B?eEFKNGpOM2U2QzhHTTg5dzB6OWV3a1BPRitSRnpkMENtWFFONEdBd0ZRMkpz?=
 =?utf-8?B?L01IbjBON0FOOFVZYVpXbVhjaVc3bmdxajRKZDJEeFNlbXowTGlqeENaVGo2?=
 =?utf-8?B?cVd5R05oRnZTUDB5aHFlSjZac0ZTVysxNmVDcjlJazBBc0ZuZHdQK01EWnIw?=
 =?utf-8?B?OEEyZk9FVGZmaENYWkM5OU91ZHNEMzBoa1ZGalFsNXhRVCt2enV3N0VhQTRi?=
 =?utf-8?B?WUpDRUdWKzBhbzEwdnNLdGg3UXZTTnVFNS82TGNoR3RKdzVUV3AvNmZua2xk?=
 =?utf-8?B?VWFTRWVycFo0cHgyc0JqQWRhbDFjMWg1RG9tQVFQeVhWNjh5dWg4c1o0enBt?=
 =?utf-8?B?ZnJyWXBWdm9DbHIrUWkzY1c5SmlBUjVJdHkzbFU0S0RxbFdvRG0wMWtaa1dR?=
 =?utf-8?B?Z2J2UlA0dzJ2RmFTYUNsZW4vU2FrN2ZFeEdQbVlSb25RMjNYZWM5TjBBRjBR?=
 =?utf-8?B?c2FiV2gxeUNzWlZFMi9KQm1CQUorUXlUYURYNUhjTUxWOEtPVnNPQWhJMXFj?=
 =?utf-8?B?aWVSWTRURzQxU2xLbmJJSWsyeVpBQnVuOElMYWN1U2F3a2c1MHE5WDVLUnJ4?=
 =?utf-8?B?cFhKbzdBR3ZHdVVUNERJemtsTXJvSnBZZVZ1OU5PaXVRcm5BcStVUDNVZGxZ?=
 =?utf-8?B?bXZjejE5dHBGbjhFMlJteERaYm96RG5xSmdNdDVseWtzYnVCVDFyUnZmazFl?=
 =?utf-8?B?V3BIWUlZWU5NeWFkSE00UWhpUEdlNFVxQWR1ZHFMenhJQ2lEZHFnZTE2dU8v?=
 =?utf-8?B?N3VPekQ2MHU4RG8wdTJKT2RDQ0cydk5ZTmpnV2E5YTQzNG5xNjZxaTYzcm1J?=
 =?utf-8?B?SEpMb2FYcFhrNXovaGtpa2E0aTRJUlc3d1UyZWkzb1JzWXV1NjRKOTd3ZVZK?=
 =?utf-8?B?VlVIVTRFUmZ2UHcrVnBpMGc4RkJEVkpsaHY1ZXZUeXBGMnJTUTJBdmhkSXhm?=
 =?utf-8?B?OXFTRlNkbDRmMU05NlRsUmcyeUFMLzllb2FjdWZmTmdtcTZibnl2TlZvNU9j?=
 =?utf-8?B?Zm5SL1RhSldIbHpzVldBeDdyZzYrUjZZZW4wSzhBbEM3cjdObnFRSG16Sk9Z?=
 =?utf-8?B?RlRPbU5HZHdUNmNZSEhBQXVLV3k3SW5ETVNrOFVpeitab1ZQL2hCZ1NrNHlt?=
 =?utf-8?B?dGt6TkVhRnBSNXA4THM5ditUcXhaSmRnLzh2WUZ3d3ZJY2xJcDFBcGZLNU05?=
 =?utf-8?B?MTlUd3JCVEtzN0NOUi9aZE9IMFhnSFFtZ3dRelpTeCsyMllDWnFJZGxFck5T?=
 =?utf-8?B?TXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d15ead-8a27-44f4-48d0-08dbf3e0986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2023 09:16:55.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGEwmoJZZddXbNCeF7T/PiFilikxQRps56y5MMn9XdTJyyzEL/WuIji7kGNhIUVnZ4b7QUJ6G5fual/vUuKI1Jxynpfa/Uy5Z6jyv3TK6hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
X-OriginatorOrg: intel.com

T24gU2F0dXJkYXksIERlY2VtYmVyIDIsIDIwMjMgMTA6MTYgUE0sIFdpbGxlbSBkZSBCcnVpam4g
d3JvdGU6DQo+SmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMTIv
MS8yMyAxNjowOSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToNCj4+ID4gU29uZywgWW9vbmcgU2lh
bmcgd3JvdGU6DQo+PiA+PiBPbiBGcmlkYXksIERlY2VtYmVyIDEsIDIwMjMgNjo0NiBQTSwgSmVz
cGVyIERhbmdhYXJkIEJyb3Vlcg0KPjxoYXdrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gPj4+IE9u
IDEyLzEvMjMgMDc6MjQsIFNvbmcgWW9vbmcgU2lhbmcgd3JvdGU6DQo+PiA+Pj4+IFRoaXMgc2Vy
aWVzIGV4cGFuZHMgWERQIFRYIG1ldGFkYXRhIGZyYW1ld29yayB0byBpbmNsdWRlIEVURiBIVyBv
ZmZsb2FkLg0KPj4gPj4+Pg0KPj4gPj4+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4gPj4+PiAtIHJl
bmFtZSBUaW1lLUJhc2VkIFNjaGVkdWxpbmcgKFRCUykgdG8gRWFybGllc3QgVHhUaW1lIEZpcnN0
IChFVEYpDQo+PiA+Pj4+IC0gcmVuYW1lIGxhdW5jaC10aW1lIHRvIHR4dGltZQ0KPj4gPj4+Pg0K
Pj4gPj4+DQo+PiA+Pj4gSSBzdHJvbmdseSBkaXNhZ3JlZSB3aXRoIHRoaXMgcmVuYW1pbmcgKHNv
cnJ5IHRvIGRpc2FncmVlIHdpdGggV2lsbGVtKS4NCj4+ID4+Pg0KPj4gPj4+IFRoZSBpMjEwIGFu
ZCBpMjI1IGNoaXBzIGNhbGwgdGhpcyBMYXVuY2hUaW1lIGluIHRoZWlyIHByb2dyYW1tZXJzDQo+
PiA+Pj4gZGF0YXNoZWV0cywgYW5kIGV2ZW4gaW4gdGhlIGRyaXZlciBjb2RlWzFdLg0KPj4gPj4+
DQo+PiA+Pj4gVXNpbmcgdGhpcyAidHh0aW1lIiBuYW1lIGluIHRoZSBjb2RlIGlzIGFsc28gY29u
ZnVzaW5nLCBiZWNhdXNlIGhvdyBjYW4NCj4+ID4+PiBwZW9wbGUgcmVhZGluZyB0aGUgY29kZSBr
bm93IHRoZSBkaWZmZXJlbmNlIGJldHdlZW46DQo+PiA+Pj4gICAtIHRtb19yZXF1ZXN0X3RpbWVz
dGFtcCBhbmQgdG1vX3JlcXVlc3RfdHh0aW1lDQo+PiA+Pj4NCj4+ID4+DQo+PiA+PiBIaSBKZXNw
ZXIgYW5kIFdpbGxlbSwNCj4+ID4+DQo+PiA+PiBIb3cgYWJvdXQgdXNpbmcgImxhdW5jaF90aW1l
IiBmb3IgdGhlIGZsYWcvdmFyaWFibGUgYW5kDQo+PiA+PiAiRWFybGllc3QgVHhUaW1lIEZpcnN0
IiBmb3IgdGhlIGRlc2NyaXB0aW9uL2NvbW1lbnRzPw0KPj4gPg0KPj4NCj4+IEkgZG9uJ3QgZm9s
bG93IHdoeSB5b3UgYXJlIGNhbGxpbmcgdGhlIGZlYXR1cmU6DQo+PiAgIC0gIkVhcmxpZXN0IFR4
VGltZSBGaXJzdCIgKEVURikuDQo+PiAgIC0gQUZBSUsgdGhpcyBqdXN0IHJlZmVyZW5jZSBhbiBx
ZGlzYyBuYW1lICh0aGF0IG1vc3QgZG9uJ3Qga25vdyBleGlzdHMpDQo+Pg0KPj4NCj4+ID4gSSBk
b24ndCBwYXJ0aWN1bGFybHkgY2FyZSB3aGljaCB0ZXJtIHdlIHVzZSwgYXMgbG9uZyBhcyB3ZSdy
ZQ0KPj4gPiBjb25zaXN0ZW50LiBFc3BlY2lhbGx5LCBkb24ndCBrZWVwIGludHJvZHVjaW5nIG5l
dyBzeW5vbnltcy4NCj4+ID4NCj4+ID4gVGhlIGZhY3QgdGhhdCBvbmUgaGFwcGVucyB0byBiZSBv
bmUgdmVuZG9yJ3MgbWFya2V0aW5nIHRlcm0gZG9lcyBub3QNCj4+ID4gbWFrZSBpdCBwcmVmZXJh
YmxlLCBJTUhPLiBPbiB0aGUgY29udHJhcnkuDQo+PiA+DQo+Pg0KPj4gVGhlc2Uga2luZCBvZiBo
YXJkd2FyZSBmZWF0dXJlcyBhcmUgZGVmaW5lZCBhcyBwYXJ0IG9mIFRpbWUgU2Vuc2l0aXZlDQo+
PiBOZXR3b3JraW5nIChUU04pLg0KPj4gSSBiZWxpZXZlIHRoZXNlIFRTTiBmZWF0dXJlcyBhcmUg
ZGVmaW5lZCBhcyBwYXJ0IG9mIElFRUUgODAyLjFRYnYgKDIwMTUpDQo+PiBhbmQgYWNjb3JkaW5n
IHRvIFdpa2lwZWRpYVsyXSBpbmNvcnBvcmF0ZWQgaW50byBJRUVFIDgwMi4xUS4NCj4+DQo+PiBb
Ml0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvVGltZS1TZW5zaXRpdmVfTmV0d29ya2lu
Zw0KPj4NCj4+DQo+PiA+IFNPX1RYVElNRSBpcyBpbiB0aGUgQUJJLCBhbmQgRURUIGhhcyBiZWVu
IHVzZWQgcHVibGljbHkgaW4ga2VybmVsDQo+PiA+IHBhdGNoZXMgYW5kIGNvbmZlcmVuY2UgdGFs
a3MsIGUuZy4sIFZhbiBKYWNvYnNvbidzIE5ldGRldiAweDEyDQo+PiA+IGtleW5vdGUuIFRob3Nl
IGFyZSB2ZW5kb3IgYWdub3N0aWMgY29tbW9ubHkgdXNlZCB0ZXJtcy4NCj4+ID4NCj4+DQo+PiBJ
IGFncmVlIHRoYXQgRURUIChFYXJsaWVzdCBEZXBhcnR1cmUgVGltZSkgaGF2ZSBiZWNvbWUgYSB0
aGluZyBhbmQgdGVybQ0KPj4gaW4gb3VyIGNvbW11bml0eS4NCj4+IFdlIGNvdWxkIGFzc29jaWF0
ZSB0aGlzIGZlYXR1cmUgd2l0aCB0aGlzLg0KPj4gSSBkbyBmZWFyIHdoYXQgaGFyZHdhcmUgYmVo
YXZpb3Igd2lsbCBiZSBpdCBpZiBJIGUuZy4gYXNrIGl0IHRvIHNlbmQgYQ0KPj4gcGFja2V0IDIg
c2VjIGluIHRoZSBmdXR1cmUgb24gaTIyNSB3aGljaCBtYXggc3VwcG9ydCAxIHNlYy4NCj4+IFdp
bGwgaGFyZHdhcmUgc2VuZCBpdCBhdCAxIHNlYz8NCj4+IEJlY2F1c2UgdGhlbiBJJ20gdmlvbGF0
aW5nIHRoZSAqRWFybGllc3QqIERlcGFydHVyZSBUaW1lLg0KPg0KPlRoYXQgc2hvdWxkIGRlZmlu
aXRlbHkgbm90IGhhcHBlbi4gQXQgbGVhc3Qgbm90IG9uIGEgZGV2aWNlIHRoYXQNCj5pbXBsZW1l
bnRzIEVEVCBzZW1hbnRpY3MuDQo+DQo+VGhpcyByZWxhdGVzIHRvIEpha3ViJ3MgcXVlc3Rpb24g
aW4gdGhlIHByZXZpb3VzIHRocmVhZCBvbiB3aGV0aGVyDQo+dGhpcyBtZWNoYW5pc20gYWxsb3dz
IG91dC1vZi1vcmRlciB0cmFuc21pc3Npb24gb3IgbWFpbnRhaW5zIEZJRk8NCj5iZWhhdmlvci4g
VGhhdCByZWFsbHkgaXMgZGV2aWNlIHNwZWNpZmljLg0KPg0KPk9sZGVyIGRldmljZXMgb25seSBz
dXBwb3J0IHRoaXMgZm9yIGxvdyByYXRlIChQVFApIGFuZCB3aXRoIGEgc21hbGwNCj5maXhlZCBu
dW1iZXIgb2Ygb3V0c3RhbmRpbmcgcmVxdWVzdHMuIEZvciBwYWNpbmcgb2ZmbG9hZCwgZGV2aWNl
cyBuZWVkDQo+dG8gc3VwcG9ydCB1cCB0byBsaW5lcmF0ZSBhbmQgb3V0LW9mLW9yZGVyLg0KPg0K
PkkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0byBlbmZvcmNlIGVpdGhlciBpbiBzb2Z0d2FyZSwgYXMg
dGhlIGhhcmR3YXJlDQo+aXMgYWxyZWFkeSBvdXQgdGhlcmUuIEJ1dCBpdCB3b3VsZCBiZSBnb29k
IGlmIGRyaXZlcnMgY2FuIHNvbWVob3cNCj5sYWJlbCB0aGVzZSBjYXBhYmlsaXRpZXMuIEluY2x1
ZGluZyBwcm9ncmFtbWFibGUgaG9yaXpvbi4NCj4NCj5JdCBpcyB1cCB0byB0aGUgcWRpc2MgdG8g
ZW5zdXJlIHRoYXQgaXQgZG9lcyBub3QgcGFzcyBwYWNrZXRzIHRvIHRoZQ0KPmRldmljZSBiZXlv
bmQgaXRzIGhvcml6b24uDQo+DQo+RVRGIGFuZCBGUSBhbHJlYWR5IGhhdmUgYSBjb25jZXB0IG9m
IGhvcml6b24uIEFuZCBhIHdheSB0byBxdWV1ZQ0KPmVycm9ycyBmb3IgcGFja2V0cyBvdXQgb2Yg
Ym91bmQgKFNPX0VFX0NPREVfVFhUSU1FXy4uKS4NCj4NCj4+DQo+PiA+IEJ1dCBhcyBsb25nIGFz
IExhdW5jaCBUaW1lIGlzIG5vdCBhbiBJbnRlbCBvbmx5IHRyYWRlbWFyaywgZmluZSB0bw0KPj4g
PiBzZWxlY3QgdGhhdC4NCj4+DQo+PiBUaGUgSUVFRSA4MDIuMVFidiBpcyBzb21ldGltZXMgY2Fs
bGVkIFRpbWUtQXdhcmUgU2hhcGVyIChUQVMpLCBidXQgSQ0KPj4gZG9uJ3QgbGlrZSB0byBmb3Ig
dXMgdG8gbmFtZSB0aGlzIGFmdGVyIHRoaXMuICBUaGlzIGZlYXR1cmVzIGlzIHNpbXBseQ0KPj4g
dGFraW5nIGFkdmFudGFnZSBvZiBleHBvc2luZyBvbmUgb2YgdGhlIGhhcmR3YXJlIGJ1aWxkaW5n
IGJsb2Nrcw0KPj4gKGNvbnRyb2xsaW5nL3NldHRpbmcgcGFja2V0ICJsYXVuY2ggdGltZSIpIHRo
YXQgY2FuIGJlIHVzZWQgZm9yDQo+PiBpbXBsZW1lbnRpbmcgYSBUQVMuDQo+Pg0KPj4gSSBsaWtl
IHRoZSBuYW1lICJsYXVuY2ggdGltZSIgYmVjYXVzZSBpdCBkb2Vzbid0IGdldCBlYXNpbHkgY29u
ZnVzZWQNCj4+IHdpdGggb3RoZXIgdGltZXN0YW1wcywgYW5kIGludHVpdGl2ZWx5IGRlc2NyaWJl
cyBwYWNrZXQgd2lsbCBiZSBzZW5kIGF0DQo+PiBhIHNwZWNpZmljIHRpbWUgKGxpa2VseSBpbiBm
dXR1cmUpLg0KPj4NCj4+IC0tSmVzcGVyDQo+DQo+VW5kZXJzdG9vZCBvbiB5b3VyIHBvaW50IHRo
YXQgdHh0aW1lIGFuZCB0eF90aW1lc3RhbXAgYXJlIHRvbyBzaW1pbGFyLg0KPkFzIHNhaWQsIEkg
ZG9uJ3QgY2FyZSBzdHJvbmdseS4gTGF1bmNoIHRpbWUgc291bmRzIGZpbmUgdG8gbWUuIE90aGVy
cw0KPmNhbiBzcGVhayB1cCBpZiB0aGV5IGRpc2FncmVlLg0KPg0KPkkgdGFrZSBsYXVuY2ggdGlt
ZSBhcyBhIGxlc3Mgc3RyaWN0IHRoYW4gRURUOiBpdCBpcyBhIHJlcXVlc3QgdG8gc2VuZA0KPmF0
IGEgY2VydGFpbiB0aW1lLCB3aXRoIG5vIHN0cmljdCBkZWZpbml0aW9uIG9uIHVuY2VydGFpbnR5
LiBXaGlsZSBFRFQNCj5tb3JlIHN0cmljdGx5IGVuc3VyZXMgdGhhdCBhIHBhY2tldCBpcyBub3Qg
c2VudCBiZWZvcmUgdGhlIHRpbWVzdGFtcC4NCg0KVGhhbmtzIGZvciB0aGUgZGVlcCBkaXNjdXNz
aW9uIGFuZCBpbmZvcm1hdGlvbi4gSSBhZ3JlZSB3aXRoIGxhdW5jaCB0aW1lIHRvby4NCkkgd2ls
bCBzdWJtaXQgdjMgd2l0aCBsYXVuY2ggdGltZSBzbyB0aGF0IG90aGVycyBjYW4gcmV2aWV3IG9u
IHRoZQ0KbmV3IG5hbWluZyBhbmQgcHJvdmlkZSB0aGVpciBmZWVkYmFjay4gDQo=

