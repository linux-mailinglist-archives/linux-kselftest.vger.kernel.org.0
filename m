Return-Path: <linux-kselftest+bounces-1147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572C8058A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386A41C2087D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0868EA8;
	Tue,  5 Dec 2023 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmM8m+Iw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BEBF;
	Tue,  5 Dec 2023 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701790105; x=1733326105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PN0ZliOTVA6XSn5K8PWFra8kcRkgHxVuDL7nqBV8yW0=;
  b=SmM8m+IwAI59HQ35nTJPjyodl9IWSfL+54p6QICv28zDAP3lUuLvf+xg
   a4uvkhiIKVKDmfBNIzBsDVhirIQB4pF4DXKmI1+dSB+9ioWICi+97ot1v
   kYEVIz0lrWIpxKyyIeY5kY3KOQzIhPu2/PSIBbP7oaZBel3j1VP/nYyVs
   qLFf7YyfegAjgcXalGtZJM565Avh6lU2n56V4wWvgeZS018tqdp9XLQFb
   LlJp+v5fBAI35CDnvnqgaUZbyka2PiteVC5U/ljKCWbSuXg7JrD7+Pljb
   3aSq+vp3YMaMOWPvEFAgoAGJGEm4YWV1lEyAuJaqR+U+8K9M5Wzna3s2f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="384312594"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="384312594"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944294166"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="944294166"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 07:28:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 07:28:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 07:28:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 07:28:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNOb6z6SLNGbcDj1MiNFTl+EF58ecwAoj5hj/p4SfHAJDMDFQT9StXw25wnJMvxy8eFI4O7pc73F42HAnnEVPNTP92+dqvYgQK8J7yACwczSkfcoklavdhb5F6Ncvmw3pxjrN76wN5/Oxfjz0cjPjI+Y8VwtW8SYEXukB+vR0Dhyj4uGlVjlyQTQu3blGk2u14EyIsiwg3kcgWJX7i9LSq5gXViVx+4S0Waqsj/K7lv0BeFKTNBof7q0qm9oCm4y4rABiEN9mjDAdvMxZhiRZVZ+jLH8X5xXeRYaT1kWSqMIHuWQnVG6R5c07F/CuKtM6vRh5yeHFSDfW3Rf6kDWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN0ZliOTVA6XSn5K8PWFra8kcRkgHxVuDL7nqBV8yW0=;
 b=ZSuUS2P0YJcbjT9tJg5m1Ul/Si1oWZqphNJvry8muAfRmWV6SNTpVzO0umLkvfW3M1T0kVZJ1bzIqLsFJUmKZfIuY/QAo9tqMRqfySG71nP6x+mLGFwIpKbHA/yWBB3iWYiBwhAUZUngcVf6G+qyVAz/AsYYxvmARC1cUCGApo5fyht1dWAff9s32+0anURCSD6ASnAcepT5lpglWiM5IIW6R7vrahpBSKudq3R0TLXyRmHSpTmFJro0abNKuJEgpE3XL5lIK372Gr4RjJP+Ouqxu7Jt9wzNlG0RUaaIfq5/lK4Z+8vnsi3qzRONOaKrwQ+ooMrLRAwWlXLGHpHZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 15:28:15 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 15:28:14 +0000
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
Thread-Index: AQHaJB8y3IJpv0o6sk+7VcjRfinq5bCUhocAgALJsHCAAewHgIABi3dQgAAGLACAAAhW8A==
Date: Tue, 5 Dec 2023 15:28:14 +0000
Message-ID: <PH0PR11MB5830AF989CBE622085C2175ED885A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
 <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
 <PH0PR11MB5830F08AC202C42501D986C0D887A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <656de8eb14c24_2e983e29435@willemb.c.googlers.com.notmuch>
 <PH0PR11MB58305C7D394FD264F1634819D885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <656f39d668439_3dd6422949e@willemb.c.googlers.com.notmuch>
In-Reply-To: <656f39d668439_3dd6422949e@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|MN6PR11MB8145:EE_
x-ms-office365-filtering-correlation-id: 518a0103-2e22-41a8-2b08-08dbf5a6cc55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zH9SupDpJ+6WLHstF69PMKZLzohPKjOYZNlgc/MISG+5bt2T3279hCz/31ktCk7FA8Wp/V0lH5WhUROkuZafq+A3TROCw+UTRAsd3kehS0YyAk2Rzb0F7hdzvtTvjVr/B1S8VBsKNxo1t0SsldLIiW/VvxSvYSFeQPssYjlQqGKAAGetoCtm4wHhO1xJGIP6U2vYIDcsyEon3hP4SZjNcyCVH6LOpFGHgdK7+h6859esolfINgzOJR9vZ+Vq0tYCDLo/vvFYnQChwLxDzh82jRfPJUzjm/HpNGzkArZ8AWLaO9lNWren0rmNp2OGWAXbcy+GTUGv/xDA/21LWBOwBcucOsl5GfcqYVpDyE/4XwtGGcavfFtjn++uW2v6uiADt4n4LzuKHqrAvfroMcvFha2UMuFaNTZef8mdZSh2hLCCiY13QKpdwqczFQCCZYzIR9BpP/ogBOMv/lSZaX0QyvA1Ejm8p0fDtJBI3+p94J1N/NnqMMfFQoBmXiFi499mD8/RQEIbyDip0xskkilxClTCePvolzQxJ653iKPmCcIzje73wRlaujPTGCpbvKHOVdALmAtKu8ko7YBHoUjJQxoN4fe0yjfVxT1TX6aecuduN/r6jYxuGVLdsghLqs1e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(5660300002)(71200400001)(53546011)(52536014)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(8936002)(4326008)(8676002)(6506007)(7696005)(76116006)(110136005)(86362001)(921008)(55016003)(38070700009)(82960400001)(83380400001)(122000001)(38100700002)(41300700001)(33656002)(7416002)(7406005)(2906002)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTVXbnh2dkZLWnRHaXdicVpaSVdiZzZ4SEFZSXpKTEFVNjgwZ1hQdis2R1NI?=
 =?utf-8?B?dWIvWGJ0YnZpWE9MbzZDR1YzaGVKZFhvMXkzSDZrOHc3L25UZFFBUHNzQXVO?=
 =?utf-8?B?VGNSQ0V3WGM4UmtkUmhpdlJLM3Z5MXN2a0k0M25ybk5WL3hhWk5ySGtXZEdp?=
 =?utf-8?B?dkNvUzcvaTEvdU0wcWl1aHRyU056cWZpUEhOUVR5amFYSnpMbmVKWG5TRnp0?=
 =?utf-8?B?YjdZTHZpUXN6S2ZFbExBbTltNDFhRm9qcjFCaGNQS3JpQlRIWHJ3WjFkV08v?=
 =?utf-8?B?dWYxNTdNMFo3UW5RMXIrVTRTWTV5Lzl4YzIzMG5BS2REY2RNTVZFL0lQYXh3?=
 =?utf-8?B?UVkvaEo2WlNNTDRaczkxL1RVMXJFUHRzTmpYakVmMXd2UEhlQTNtOFZrRi84?=
 =?utf-8?B?ZDV2NmQrSmJ6V2JhYmo3ZHpqQVJlM1Joc0M5cEdWb2lqT01XUFNIMFlKNzFJ?=
 =?utf-8?B?cktSWmZXZWcxY3BCQnpxNFJPVm5udkhiS1hYNkoyeGpncDVFVVVGcTUrTWxh?=
 =?utf-8?B?Nm9YOHlHV3ZnbTd5ZVZKdVpnOWJMR2JpaUVGMFgyRXZMSjBZdGE2TVlid1gr?=
 =?utf-8?B?Y1VRSmt2VENwbDhUK1hkOWxMYVNSTldqZ2RRWjhSTU40azhjTmNrbkphN0Na?=
 =?utf-8?B?akdxVVBPUGtRc2NqV3JNUHJGTGtWR1d4RVcwdDlvcU9nV001OVFkc2Jud1pp?=
 =?utf-8?B?b2hESkttZGVNMVJQd2tqSFJjSjRFbjh0NFR1MW1Xakx4TDdRaEJjcS9GMmF6?=
 =?utf-8?B?cGpuK0RJUENZUU5zbFE2bmd2eFVhTGJLbWlPd0RiNTdQTnlpakFKeUtqdmpo?=
 =?utf-8?B?WG5jZE8vN3gyMUpFMDV3dEtVY3dVUStaYURjZmNDMG1SN0x4dHk4NElmSTda?=
 =?utf-8?B?Rkd2OGZRUUhaaHhXYTZZdlcyOGNiVTRwUVV5MVFDS2R3ajBBcXJKNnJueTl6?=
 =?utf-8?B?bVFCeHdUR1RhdXhuV1B4VmxJeHNBczJ6eVYxV01kc0E4Y0VnQUpFUlVoK3ph?=
 =?utf-8?B?bWRaR2Rqbk1ZNk01emhoL2JYUlduUHZxOHYyWnBJeUpMUGIxVVdsajFJejBW?=
 =?utf-8?B?N0c3M2JKRXFwc1pnZWJ4enFtQld1NDhXSGM2UHhuNHFZckpmbWtlMmIyZWNR?=
 =?utf-8?B?NXZOZmlNWHpUNEQ3ajFBYTNtM2lBVFREZEZEaXk4aUFBUmQrYkVROHl5R1JD?=
 =?utf-8?B?cDZtbEtnNms3TFlmRFRHWm53bVRLV1dDcW1UaUNqZkY3OVBaOHNmUE1vZnlt?=
 =?utf-8?B?UjJ1a1pzZUgzV09IQzg4QUdjeTlVS3Nxb0xMQ2xib1dQOTlkTytvMnRaN3Vi?=
 =?utf-8?B?d3VVMU5FbjBnVTczNzFMWnVJTk5Xa1VDOHk5dTJOalFmekRSekdET24yajdU?=
 =?utf-8?B?ZmhTWHRkQXZoWktDMllOUjV0RVBIeWpDRDQwY1krWnplN1RPWlliMWppanJG?=
 =?utf-8?B?SGNMNGtxSE02bXZKaEZ6YUZMbmVCelp2REl5WVg3WGRZU1h5SGdoQUVwdDFh?=
 =?utf-8?B?cmVoNHBmanhpQUlFL2RIdVFLN25reE1uSTQra25mcldvWjdENW1HanZQdjBh?=
 =?utf-8?B?eG11YitCL3JqdzNSV1gzdTJ3Q09VSlkveHI0NHZ3UWxraEQwVmJtS2xNNHA2?=
 =?utf-8?B?aGt1MDRoalNwdnI2azFGTHFvVXRhQk1QdHZBdWxFYThDQkhGQ25ja256Z0d5?=
 =?utf-8?B?RTM1emVleFp0ckF5V1JpUWVvVGxVcGJBMTNuMW1OUlVGK1Bqa0MrbmtoLzFz?=
 =?utf-8?B?UmMxbG1BQUFORFFYdWJiQmVJWEljSFhuKy9pcEF6MDRpanplTUNacFFFeEtG?=
 =?utf-8?B?c1dJbzNKUzRCQytZN3pRMHRLZm4vanpMcEFvd2ZqUFJYWHl3RXFLeG1YMkxS?=
 =?utf-8?B?Z2dzeXdvUmUySU5PSW9DanBmbzc0bVB0VWh6Wk9zTU5TaDlyb0w5UVR4TVhL?=
 =?utf-8?B?WHhWNzdQUnpoa1JmWkdibXhyZ0taaEFTaDBiSUlIMUI3Nlc4SThkVHJzY3l3?=
 =?utf-8?B?NW9rQVVmeDhWRXFEb0pybStyVWlhUjU5RUxuK1dGQ2d6TXJaVTlKVU9ua3N0?=
 =?utf-8?B?VWVXQWlzQ3k2QWJDN1pUNlFmaHpWTndvUzBRdU9wNTFnTUpRMXlEWnlIRVpu?=
 =?utf-8?B?bjhIblh6dDhGT0pZZTNFVWJMbHZ6bXN1L3BtQWVSU1UweTdXb3hCcFVDTDU5?=
 =?utf-8?B?V2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a0103-2e22-41a8-2b08-08dbf5a6cc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 15:28:14.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pfq3B3uXGUXdIvOrsGBozksAg3Z8MNgjRBut77Rb150qVrhA+SFURRSw/RrJSefCWvYdPH/cxMmJktnIox4hXHQrtAp4dBRV8d0rgJJv7CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com

T24gVHVlc2RheSwgRGVjZW1iZXIgNSwgMjAyMyAxMDo1NSBQTSwgV2lsbGVtIGRlIEJydWlqbiB3
cm90ZToNCj5Tb25nLCBZb29uZyBTaWFuZyB3cm90ZToNCj4+IE9uIE1vbmRheSwgRGVjZW1iZXIg
NCwgMjAyMyAxMDo1OCBQTSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToNCj4+ID5Tb25nLCBZb29u
ZyBTaWFuZyB3cm90ZToNCj4+ID4+IE9uIEZyaWRheSwgRGVjZW1iZXIgMSwgMjAyMyAxMTowMiBQ
TSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4+ID4+ID5PbiAxMi8xLzIzIDA3OjI0
LCBTb25nIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4gPj4gPj4gVGhpcyBwYXRjaCBlbmFibGVzIHR4
dGltZSBzdXBwb3J0IHRvIFhEUCB6ZXJvIGNvcHkgdmlhIFhEUCBUeA0KPj4gPj4gPj4gbWV0YWRh
dGEgZnJhbWV3b3JrLg0KPj4gPj4gPj4NCj4+ID4+ID4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgWW9v
bmcgU2lhbmc8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+PiA+PiA+PiAtLS0NCj4+ID4+
ID4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjLmggICAgICB8
ICAyICsrDQo+PiA+PiA+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hY19tYWluLmMgfCAxMyArKysrKysrKysrKysrDQo+PiA+PiA+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPj4gPj4gPg0KPj4gPj4gPkkgdGhpbmsgd2UgbmVlZCB0byBz
ZWUgb3RoZXIgZHJpdmVycyB1c2luZyB0aGlzIG5ldyBmZWF0dXJlIHRvIGV2YWx1YXRlDQo+PiA+
PiA+aWYgQVBJIGlzIHNhbmUuDQo+PiA+PiA+DQo+PiA+PiA+SSBzdWdnZXN0IGltcGxlbWVudGlu
ZyB0aGlzIGZvciBpZ2MgZHJpdmVyIChjaGlwIGkyMjUpIGFuZCBhbHNvIGZvciBpZ2INCj4+ID4+
ID4oaTIxMCBjaGlwKSB0aGF0IGJvdGggc3VwcG9ydCB0aGlzIGtpbmQgb2YgTGF1bmNoVGltZSBm
ZWF0dXJlIGluIEhXLg0KPj4gPj4gPg0KPj4gPj4gPlRoZSBBUEkgYW5kIHN0bW1hYyBkcml2ZXIg
dGFrZXMgYSB1NjQgYXMgdGltZS4NCj4+ID4+ID5JJ20gd29uZGVyaW5nIGhvdyB0aGlzIGFwcGxp
ZXMgdG8gaTIxMCB0aGF0WzFdIGhhdmUgMjUtYml0IGZvcg0KPj4gPj4gPkxhdW5jaFRpbWUgKHdp
dGggMzIgbmFub3NlYyBncmFudWxhcml0eSkgbGltaXRpbmcgTGF1bmNoVGltZSBtYXggMC41DQo+
PiA+PiA+c2Vjb25kIGludG8gdGhlIGZ1dHVyZS4NCj4+ID4+ID5BbmQgaTIyNSB0aGF0IFsxXSBo
YXZlIDMwLWJpdCBtYXggMSBzZWNvbmQgaW50byB0aGUgZnV0dXJlLg0KPj4gPj4gPg0KPj4gPj4g
Pg0KPj4gPj4gPlsxXQ0KPj4gPj4gPmh0dHBzOi8vZ2l0aHViLmNvbS94ZHAtcHJvamVjdC94ZHAt
DQo+PiA+PiA+cHJvamVjdC9ibG9iL21hc3Rlci9hcmVhcy90c24vY29kZTAxX2ZvbGxvd19xZGlz
Y19UU05fb2ZmbG9hZC5vcmcNCj4+ID4+DQo+PiA+PiBJIGFtIHVzaW5nIHU2NCBmb3IgbGF1bmNo
IHRpbWUgYmVjYXVzZSBleGlzdGluZyBFRFQgZnJhbWV3b3JrIGlzIHVzaW5nIGl0Lg0KPj4gPj4g
UmVmZXIgdG8gc3RydWN0IHNrX2J1ZmYgYmVsb3cuIEJvdGggdTY0IGFuZCBrdGltZV90IGNhbiBi
ZSB1c2VkIGFzIGxhdW5jaCB0aW1lLg0KPj4gPj4gSSBjaG9vc2UgdTY0IGJlY2F1c2Uga3RpbWVf
dCBvZnRlbiByZXF1aXJlcyBhZGRpdGlvbmFsIHR5cGUgY29udmVyc2lvbiBhbmQNCj4+ID4+IHdl
IGRpZG4ndCBleHBlY3QgbmVnYXRpdmUgdmFsdWUgb2YgdGltZS4NCj4+ID4+DQo+PiA+PiBpbmNs
dWRlL2xpbnV4L3NrYnVmZi5oLTc0NC0gKiAgIEB0c3RhbXA6IFRpbWUgd2UgYXJyaXZlZC9sZWZ0
DQo+PiA+PiBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjc0NS0gKiAgIEBza2JfbXN0YW1wX25zOiAo
YWthIEB0c3RhbXApIGVhcmxpZXN0DQo+ZGVwYXJ0dXJlDQo+PiA+dGltZTsgc3RhcnQgcG9pbnQN
Cj4+ID4+IGluY2x1ZGUvbGludXgvc2tidWZmLmgtNzQ2LSAqICAgICAgICAgICBmb3IgcmV0cmFu
c21pdCB0aW1lcg0KPj4gPj4gLS0NCj4+ID4+IGluY2x1ZGUvbGludXgvc2tidWZmLmgtODgwLSAg
ICAgdW5pb24gew0KPj4gPj4gaW5jbHVkZS9saW51eC9za2J1ZmYuaC04ODEtICAgICAgICAgICAg
IGt0aW1lX3QgICAgICAgICB0c3RhbXA7DQo+PiA+PiBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjg4
Mi0gICAgICAgICAgICAgdTY0ICAgICAgICAgICAgIHNrYl9tc3RhbXBfbnM7IC8qIGVhcmxpZXN0
DQo+ZGVwYXJ0dXJlDQo+PiA+dGltZSAqLw0KPj4gPj4gaW5jbHVkZS9saW51eC9za2J1ZmYuaC04
ODMtICAgICB9Ow0KPj4gPj4NCj4+ID4+IHRzdGFtcC9za2JfbXN0YW1wX25zIGFyZSB1c2VkIGJ5
IHZhcmlvdXMgZHJpdmVycyBmb3IgbGF1bmNoIHRpbWUgc3VwcG9ydA0KPj4gPj4gb24gbm9ybWFs
IHBhY2tldCwgc28gSSB0aGluayB1NjQgc2hvdWxkIGJlICJmcmllbmRseSIgdG8gYWxsIHRoZSBk
cml2ZXJzLiBGb3IgYW4NCj4+ID4+IGV4YW1wbGUsIGlnYyBkcml2ZXIgd2lsbCB0YWtlIGxhdW5j
aCB0aW1lIGZyb20gdHN0YW1wIGFuZCByZWNhbGN1bGF0ZSBpdA0KPj4gPj4gYWNjb3JkaW5nbHkg
KGkyMjUgZXhwZWN0IHVzZXIgdG8gcHJvZ3JhbSAiZGVsdGEgdGltZSIgaW5zdGVhZCBvZiAidGlt
ZSIgaW50bw0KPj4gPj4gSFcgcmVnaXN0ZXIpLg0KPj4gPj4NCj4+ID4+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jLTE2MDItIHR4dGltZSA9IHNrYi0+dHN0YW1wOw0K
Pj4gPj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMtMTYwMy0gc2ti
LT50c3RhbXAgPSBrdGltZV9zZXQoMCwgMCk7DQo+PiA+PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZ2MvaWdjX21haW4uYzoxNjA0LSBsYXVuY2hfdGltZSA9DQo+PiA+aWdjX3R4X2xhdW5j
aHRpbWUodHhfcmluZywgdHh0aW1lLCAmZmlyc3RfZmxhZywgJmluc2VydF9lbXB0eSk7DQo+PiA+
Pg0KPj4gPj4gRG8geW91IHRoaW5rIHRoaXMgaXMgZW5vdWdoIHRvIHNheSB0aGUgQVBJIGlzIHNh
bmU/DQo+PiA+DQo+PiA+dTY0IG5zZWMgc291bmRzIHNhbmUgdG8gYmUuIEl0IG11c3QgYmUgbWFk
ZSBleHBsaWNpdCB3aXRoIGNsb2NrIHNvdXJjZQ0KPj4gPml0IGlzIGFnYWluc3QuDQo+PiA+DQo+
Pg0KPj4gVGhlIHU2NCBsYXVuY2ggdGltZSBzaG91bGQgYmFzZSBvbiBOSUMgUFRQIGhhcmR3YXJl
IGNsb2NrIChQSEMpLg0KPj4gSSB3aWxsIGFkZCBkb2N1bWVudGF0aW9uIHNheWluZyB3aGljaCBj
bG9jayBzb3VyY2UgaXQgaXMgYWdhaW5zdA0KPg0KPkl0J3Mgbm90IHRoYXQgb2J2aW91cyB0byBt
ZSB0aGF0IHRoYXQgaXMgdGhlIHJpZ2h0IGFuZCBvbmx5IGNob2ljZS4NCj5TZWUgYmVsb3cuDQo+
DQo+PiA+U29tZSBhcHBsaWNhdGlvbnMgY291bGQgd2FudCB0byBkbyB0aGUgY29udmVyc2lvbiBm
cm9tIGEgY2xvY2sgc291cmNlDQo+PiA+dG8gcmF3IE5JQyBjeWNsZSBjb3VudGVyIGluIHVzZXJz
cGFjZSBvciBCUEYgYW5kIHByb2dyYW0gdGhlIHJhdw0KPj4gPnZhbHVlLiBTbyBpdCBtYXkgYmUg
d29ydGh3aGlsZSB0byBhZGQgYW4gY2xvY2sgc291cmNlIGFyZ3VtZW50IC0tIGV2ZW4NCj4+ID5p
ZiBpbml0aWFsbHkgb25seSBDTE9DS19NT05PVE9OSUMgaXMgc3VwcG9ydGVkLg0KPj4NCj4+IFNv
cnJ5LCBub3Qgc28gdW5kZXJzdGFuZCB5b3VyIHN1Z2dlc3Rpb24gb24gYWRkaW5nIGNsb2NrIHNv
dXJjZSBhcmd1bWVudC4NCj4+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBhZGQgY2xvY2sgc291cmNl
IGZvciB0aGUgc2VsZnRlc3QgeGRwX2h3X21ldGFkYXRhIGFwcHM/DQo+PiBJTUhPLCBubyBuZWVk
IHRvIGFkZCBjbG9jayBzb3VyY2UgYXMgdGhlIGNsb2NrIHNvdXJjZSBmb3IgbGF1bmNoIHRpbWUN
Cj4+IHNob3VsZCBhbHdheXMgYmFzZSBvbiBOSUMgUEhDLg0KPg0KPlRoaXMgaXMgbm90IGhvdyBG
USBhbmQgRVRGIHFkaXNjcyBwYXNzIHRpbWVzdGFtcHMgdG8gZHJpdmVycyB0b2RheS4NCj4NCj5U
aG9zZSBhcmUgaW4gQ0xPQ0tfTU9OT1RPTklDIG9yIENMT0NLX1RBSS4gVGhlIGRyaXZlciBpcyBl
eHBlY3RlZCB0bw0KPmNvbnZlcnQgZnJvbSB0aGF0IHRvIGl0cyBkZXNjcmlwdG9yIGZvcm1hdCwg
Ym90aCB0byB0aGUgcmVkdWNlZCBiaXQNCj53aWR0aCBhbmQgdGhlIE5JQyBQSEMuDQo+DQo+U2Vl
IGFsc28gZm9yIGluc3RhbmNlIGhvdyBzY2hfZXRmIGhhcyBhbiBleHBsaWNpdCBxLT5jbG9ja19p
ZCBtYXRjaCwNCj5hbmQgU09fVFhUSU1FIGFkZGVkIGFuIHNrX2Nsb2NrX2lkIGZvciB0aGUgc2Ft
ZSBwdXJwb3NlOiB0byBhZ3JlZSBvbg0KPndoaWNoIGNsb2NrIHNvdXJjZSBpcyBiZWluZyB1c2Vk
Lg0KDQpJIHNlZS4gVGhhbmsgZm9yIHRoZSBleHBsYW5hdGlvbi4gSSB3aWxsIHRyeSB0byBhZGQg
Y2xvY2sgc291cmNlIGFyZ3VtZW50cw0KSW4gbmV4dCB2ZXJzaW9uLg0K

