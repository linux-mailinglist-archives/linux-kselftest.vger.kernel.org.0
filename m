Return-Path: <linux-kselftest+bounces-1146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31024805890
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520A41C20FD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8068EA2;
	Tue,  5 Dec 2023 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXReQ16+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADF9B;
	Tue,  5 Dec 2023 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701789909; x=1733325909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DhRtKpPiz+QZ1ZlkCbU59C6V5uUHVGpOk+nwuwgwKOc=;
  b=NXReQ16+neFzvoIhAUmBH/BiToacFtEBKsZ9M2KZ3Po6p3qjR2P+n6aw
   8ZWHB6Nyax27eA0aqaXDMiq8w/O9fDh1xY163oo+OnMu33iAsGA49OtPl
   k8ch+msT7HzGszNdUSxYDnUgHuKFLSXqBZ7EnAm24V5IzNysaMSLNYcUm
   GREbvn7gOZcygLX2DQjphKvWWcTWytG6o2/CDLMZ7KEjDb9ZhFUSaWzz4
   EKed+nWY2g4MhimxQrspudpzfVV0f+IvdIDI9ZaBR/Da/qMymvfWIEOQv
   qWhN9yhJi15X2YXYdhp+iC9h66dqj+atRBfUQO9LfJNgywiFSAyovnlXn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460394681"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="460394681"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774662715"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="774662715"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 07:25:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 07:25:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 07:25:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 07:25:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 07:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFlg1c6B0jCXPxcS0ynU8M6BXO0gJTdNrBngqCr2jDPy1Sa3bgA3vTH1oXuk+yn4Ey1mtKzHiWAtz+KmzFogExO5Ep1shp5iphxPjY0yuBCzenxs3Zx1uh0cBf8T6DcnSNw5rokHoOy1Ue6dTXMhl+in0R+5ZIq8ZUmCWiU6dKoZ3y+PL8Ij1c6PruKpAFBjcyX3kOm86lIA+k3VqpWvI17RGuUt/8oH/qzfKMdPRfXb4V4eAF9ZtR2hel/2btLKqlo3fw2AvU0L3aaLPWx5zJo9furP2vNt+B29jvugrh4JqGSAe0PnwPEtDlbVhlAXPiMwHe4bcBYTi3FkG8hF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhRtKpPiz+QZ1ZlkCbU59C6V5uUHVGpOk+nwuwgwKOc=;
 b=g/3LulbvcWlZxnakpXr5RBSY2ZrOekHM/qm45YQQ8wv2CBYq93PJ6yCL6Yss7v1DU7E4y+ojVsJ95bON5SL2P38A4T5nKZ9zZxAGCj4knk9FZyPXMMNuKETTVqkKuhzAZ9ey4jTiLlCL67UvW76vCLKMpHIjGZiUQuZ8t6fz1uJYag9GHTxDhViqgZXrx0S0KqT/ZAa2GVvOWwq6m2MOINRkmhE8hTKBvj/gXwBo10G3aCvbfgY6wh2fvkLq+fDVMaoG19u6aQwVycJZLh+Hdbf6Exb2bPDj+WfBgYxOR8bNtwFWnqyN5xeK+KKUlA0stGhar/4HkpSzOf0TunM4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 15:25:02 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 15:25:02 +0000
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
Subject: RE: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to
 XDP ZC
Thread-Topic: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to
 XDP ZC
Thread-Index: AQHaJgkYSPZeueih5k2aEmsHgya5rrCY72kAgABIIgCAAZaQsA==
Date: Tue, 5 Dec 2023 15:25:02 +0000
Message-ID: <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
In-Reply-To: <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DM8PR11MB5608:EE_
x-ms-office365-filtering-correlation-id: 6fa6148a-bbaf-476b-e725-08dbf5a65a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7/GOPvnqE9KM4qR4xJVcVy2arIPs5gU1tKF9goT0AzjzvbfutcDAy7vBM6G/RYeEOe5LJtDesnq8qUrczdwFT+B9tTJDSemYdphoFtWotnCGjsIApdgxEycbzIx0MRRLOyw8cVz/Ty30sz7a2tu0HCU4hZAuq6aBfZTdrG+oM7ElcelfF8N6GYVtF+Qstp+7S/EdIR9p0Eq9NBGUnhKmUknp+ZYNWFPJU757YIg6bnL13k2OHpAEbxlshLQ26mWqpwAf5n7jtUA9mfvM1BdrzWaJMuTbbUvwwTRF1fMp9nhc/niLu0qIKlRfzttBm6qfHscBpYMhkI51lXpLieJbNyZ0yXWPraFr61u7oUcA/BslHKWShBqW+lwUHp7Drz+Ap5r+HuKBHXBxdH36WbdnJVyeQ5XeNCYrTSQmU2cNpYEkWonbk4ObpVLD2z38Dgqt4lD6H9t0kh/qYBWL3RMXoYiYJ0okD0WK70ZZBrWoCsYHWywnfn0Ala39o2YJkS3YEthXZfDiDG4Z98Twuw4Lb3hEntEDwa+Bnf2JQx/vkW1gYnDUBWBhBHRgOaZeQ3f1IRQ8iMmOlEMkr8WqSymFtIDyR8wofDG6O5amga6UWQV7C/SinZJ4p+6wTSwb1wz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(71200400001)(7696005)(478600001)(38100700002)(122000001)(82960400001)(83380400001)(53546011)(9686003)(6506007)(33656002)(7406005)(8676002)(4326008)(2906002)(921008)(5660300002)(7416002)(8936002)(41300700001)(52536014)(86362001)(38070700009)(64756008)(54906003)(66446008)(66476007)(66556008)(76116006)(66946007)(110136005)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnk5RmtYQTdNMEJxcU9pSUxhclZuRXpFMzdXRVVtQ3REOVVFWStNZWM5M3Zn?=
 =?utf-8?B?czUzQkxkOVpVdjduazFWek4vNjZxU29IWUxsLzBaUm9pdUFwSFR5YWp3NDlq?=
 =?utf-8?B?MlZXbVlRd0Z1VUliRkpacVFGeU50bHYvM2ZTajhaZVYyQm1xZDNkejRJNHFZ?=
 =?utf-8?B?ZGkyblZRY1duRzhHcUJoMWdMb0YzVlpwVHZvNTd5MUlhSUw0Mms2VEpQK1hq?=
 =?utf-8?B?Snh4QlMwZnpmaE53VExMZVpXQWpJTnJ3WXRFM2N2TjM5cU56eTAwT08yQXBm?=
 =?utf-8?B?aWI0YStIZnViL0xZb281cUhvZit4aU1GbFl5TEVid08yM2xDNmVtaWNPQVRZ?=
 =?utf-8?B?UnpuckE3V1JVNU8xN1JVUG9ydGRyK3BEQlFyRzRsMzZBam1QMFhMZHg5RklN?=
 =?utf-8?B?elkwdktmL2E0WXlDdGdwYTJ6WkVKNGVodWU2YytmdXp2Y0NlZmlmQlhJQjVK?=
 =?utf-8?B?cFBWOWd4K0Vxd1lueVJyU2kwV2NOOFNSdjZ1azVlV2xVMzJkSlJiU1RldFhS?=
 =?utf-8?B?M01VVnpsVThLYlZrVXBCOTBTTHloZy9BQ21NNVY4ZDV6NFRUWWN5M1JZbU1O?=
 =?utf-8?B?d3pEYXJSNGJLbDdRdTJob1dLUVBpckhFUnVRZ1ltQXFSdHZueEdaU21aTVpk?=
 =?utf-8?B?Y25PQU9qOWR2RzNzVGZ3UllsNG5Cd2NDSmxnZ3RlSG0vR3BYcThLc3FmL3RP?=
 =?utf-8?B?dzBmQnVHdzNEdTZhUHdBdHVIL291TmdmaW1DcUgvVW5HVmZobklEdkVtTVJ4?=
 =?utf-8?B?WkUrUUZKN21TR0x0NXpKZmpuaFFaeE4zZjlCSEJWTWkzcEZDdFBvQ3doekJW?=
 =?utf-8?B?bkw2WkZ5UzRpNXVud1Ztc0ZzZGJqVURaNGJoQUpualREU0J6cHVTRXFPdDZl?=
 =?utf-8?B?a3pldG1yS0x0b2V1OG5qTm9pcUNqaktmWFd2V01TY3NBVksxcHlxblZtaERz?=
 =?utf-8?B?dEJ3NXd3dVVLOFJadzR4RTFhMkIzTm4vZlFFU3M3NDc1bEhLTDRnWjBLbVJz?=
 =?utf-8?B?N0dxQXdBa24rVDdBSHpqbWRJaCtUV2YxMWJRbVR5NW5TKzJzTlZ2cE8wcTJl?=
 =?utf-8?B?OXdyWVlDSk5UWG01UnhCSU1RNW5ieWo1b3lYMEdYRDNZUEdKdW5uakhaY3Ev?=
 =?utf-8?B?S0x5QjJXd1dQd3FrRnZqQ0pYUTc0Y0R2RkhjSnpOZHBRL05lZzd6YTJ0aGpp?=
 =?utf-8?B?dHlWWitFemdBR2k5VWZNMUFxYWpUQU0rWm5BTU44bkRCeG81TThZdFRBU0Zk?=
 =?utf-8?B?NVlRei9GWmVnWGFSeUlITG8wOVdXdjQ0a1JmcTlwTHY2cnJheDVudno1RGg4?=
 =?utf-8?B?R0puYmRJMS9hVSt5SzdRK2F3dFBibWNFUzUzK3NtUTVEeVp6WGRteUwwelpU?=
 =?utf-8?B?WWFpSUJMQk0zZ1UzWmVPMmN2K3pWeUJobktUSHdJcmE1RnJZOTVPL2J6WFJa?=
 =?utf-8?B?ZlRUbWhQN3p1ZFBDMmtZeUdrVG9TMXoyM2c1NTFEV1BBekhxTGxlZnNIaFFw?=
 =?utf-8?B?Rk5USzlYNDg1OFk5c0xJTXdEWkhSYWlzNnFFSzMrdWxYVlFPaXJUZFBJbW9P?=
 =?utf-8?B?dDJOUStMZC83OGU3c2h3K1htOTdtZFB2L2w3Ym1lc0Q0SG10eXo2cUc2bXZE?=
 =?utf-8?B?SmFhZUI0bUFHRk1oVkFxbmFUZVMwbnlXL0RCN3VvdVlmVHVvUjRJSVJoaVhO?=
 =?utf-8?B?aTNCME9uWkVza29Bdk5jbFMxUm5uNmRrUC9EWHNmSU9oalF5WkpzTWdKSXBp?=
 =?utf-8?B?TVhZdC9PdFhLNHJ4N3VVNU5VVmlHU0tjSEE2aUo2am9uRWNIaHB4amtHT0sr?=
 =?utf-8?B?ZXdad1ZvRlMrSEdPczI4cVRpZHBmdTkwWTdpNy9vRWQyamhrYytydmVhOFda?=
 =?utf-8?B?ZGllOXArbXNVZ25wZHpTU29XMkZ5K2g0bmZTaWNFZjAvS25MSTZ2NmpYZzds?=
 =?utf-8?B?OFlBdWQrMnhUZStBaUNYUFViOGtVMUhZVm1jSnNqeDlzbE0yM3JidjFKcWMv?=
 =?utf-8?B?RHkvMmNmbDJQZlVPN0wrL0dyem9Ma3FkZ0FnaS9mSGo3TFV4NnNnbUhrUmhn?=
 =?utf-8?B?VmdBZTIrWHZwalgyY3ZkN0Q0RHVEaElDRHNqVEdka0pubU82OUNQZHFzcmhJ?=
 =?utf-8?B?cTBCTmJycHdvNXlLNldTTGwrcitaRm1QRmZvNHppZGlXcU9OWThzMkhzS21s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa6148a-bbaf-476b-e725-08dbf5a65a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 15:25:02.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eu2b6BJWBKIcaru4ChO6wWAgB6L9G+2DWMOkME+YpKesjcISmL7nmBWNkk2lqe5E3iGli8I9QA/pIVTR2RdZnwgtYX4DtaDKYcoCG+ih9gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-OriginatorOrg: intel.com

T24gTW9uZGF5LCBEZWNlbWJlciA0LCAyMDIzIDEwOjU1IFBNLCBXaWxsZW0gZGUgQnJ1aWpuIHdy
b3RlOg0KPkplc3BlciBEYW5nYWFyZCBCcm91ZXIgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEyLzMv
MjMgMTc6NTEsIFNvbmcgWW9vbmcgU2lhbmcgd3JvdGU6DQo+PiA+IFRoaXMgcGF0Y2ggZW5hYmxl
cyBMYXVuY2ggVGltZSAoVGltZS1CYXNlZCBTY2hlZHVsaW5nKSBzdXBwb3J0IHRvIFhEUCB6ZXJv
DQo+PiA+IGNvcHkgdmlhIFhEUCBUeCBtZXRhZGF0YSBmcmFtZXdvcmsuDQo+PiA+DQo+PiA+IFNp
Z25lZC1vZmYtYnk6IFNvbmcgWW9vbmcgU2lhbmc8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+
DQo+PiA+IC0tLQ0KPj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hYy5oICAgICAgfCAgMiArKw0KPj4NCj4+IEFzIHJlcXVlc3RlZCBiZWZvcmUsIEkgdGhpbmsg
d2UgbmVlZCB0byBzZWUgYW5vdGhlciBkcml2ZXIgaW1wbGVtZW50aW5nDQo+PiB0aGlzLg0KPj4N
Cj4+IEkgcHJvcG9zZSBkcml2ZXIgaWdjIGFuZCBjaGlwIGkyMjUuDQoNClN1cmUuIEkgd2lsbCBp
bmNsdWRlIGlnYyBwYXRjaGVzIGluIG5leHQgdmVyc2lvbi4NCg0KPj4NCj4+IFRoZSBpbnRlcmVz
dGluZyB0aGluZyBmb3IgbWUgaXMgdG8gc2VlIGhvdyB0aGUgTGF1bmNoVGltZSBtYXggMSBzZWNv
bmQNCj4+IGludG8gdGhlIGZ1dHVyZVsxXSBpcyBoYW5kbGVkIGNvZGUgd2lzZS4gT25lIHN1Z2dl
c3Rpb24gaXMgdG8gYWRkIGENCj4+IHNlY3Rpb24gdG8gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5n
L3hzay10eC1tZXRhZGF0YS5yc3QgcGVyIGRyaXZlciB0aGF0DQo+PiBtZW50aW9ucy9kb2N1bWVu
dHMgdGhlc2UgZGlmZmVyZW50IGhhcmR3YXJlIGxpbWl0YXRpb25zLiAgSXQgaXMgbmF0dXJhbA0K
Pj4gdGhhdCBkaWZmZXJlbnQgdHlwZXMgb2YgaGFyZHdhcmUgaGF2ZSBsaW1pdGF0aW9ucy4gIFRo
aXMgaXMgYSBjbG9zZS10bw0KPj4gaGFyZHdhcmUtbGV2ZWwgYWJzdHJhY3Rpb24vQVBJLCBhbmQg
SU1ITyBhcyBsb25nIGFzIHdlIGRvY3VtZW50IHRoZQ0KPj4gbGltaXRhdGlvbnMgd2UgY2FuIGV4
cG9zZSB0aGlzIEFQSSB3aXRob3V0IHRvbyBtYW55IGxpbWl0YXRpb25zIGZvciBtb3JlDQo+PiBj
YXBhYmxlIGhhcmR3YXJlLg0KDQpTdXJlLiBJIHdpbGwgdHJ5IHRvIGFkZCBoYXJkd2FyZSBsaW1p
dGF0aW9ucyBpbiBkb2N1bWVudGF0aW9uLiANCg0KPg0KPkkgd291bGQgYXNzdW1lIHRoYXQgdGhl
IGtmdW5jIHdpbGwgZmFpbCB3aGVuIGEgdmFsdWUgaXMgcGFzc2VkIHRoYXQNCj5jYW5ub3QgYmUg
cHJvZ3JhbW1lZC4NCj4NCg0KSW4gY3VycmVudCBkZXNpZ24sIHRoZSB4c2tfdHhfbWV0YWRhdGFf
cmVxdWVzdCgpIGRpbnQgZ290IHJldHVybiB2YWx1ZS4gDQpTbyB1c2VyIHdvbid0IGtub3cgaWYg
dGhlaXIgcmVxdWVzdCBpcyBmYWlsLiANCkl0IGlzIGNvbXBsZXggdG8gaW5mb3JtIHVzZXIgd2hp
Y2ggcmVxdWVzdCBpcyBmYWlsaW5nLiANClRoZXJlZm9yZSwgSU1ITywgaXQgaXMgZ29vZCB0aGF0
IHdlIGxldCBkcml2ZXIgaGFuZGxlIHRoZSBlcnJvciBzaWxlbnRseS4gDQoNCj5XaGF0IGlzIGJl
aW5nIGltcGxlbWVudGVkIGhlcmUgYWxyZWFkeSBleGlzdHMgZm9yIHFkaXNjcy4gVGhlIEZRDQo+
cWRpc2MgdGFrZXMgYSBob3Jpem9uIGF0dHJpYnV0ZSBhbmQNCj4NCj4gICAgIg0KPiAgICB3aGVu
IGEgcGFja2V0IGlzIGJleW9uZCB0aGUgaG9yaXpvbg0KPiAgICAgICAgYXQgZW5xdWV1ZSgpIHRp
bWU6DQo+ICAgICAgICAtIGVpdGhlciBkcm9wIHRoZSBwYWNrZXQgKGRlZmF1bHQgcG9saWN5KQ0K
PiAgICAgICAgLSBvciBjYXAgaXRzIGRlbGl2ZXJ5IHRpbWUgdG8gdGhlIGhvcml6b24uDQo+ICAg
ICINCj4gICAgY29tbWl0IDM5ZDAxMDUwNGU2YiAoIm5ldF9zY2hlZDogc2NoX2ZxOiBhZGQgaG9y
aXpvbiBhdHRyaWJ1dGUiKQ0KPg0KPkhhdmluZyB0aGUgYWRtaW4gbWFudWFsbHkgY29uZmlndXJl
IHRoaXMgb24gdGhlIHFkaXNjIGJhc2VkIG9uDQo+b2ZmLWxpbmUga25vd2xlZGdlIG9mIHRoZSBk
ZXZpY2UgaXMgbW9yZSBmcmFnaWxlIHRoYW4gaWYgdGhlIGRldmljZQ0KPndvdWxkIHNvbWVob3cg
c2lnbmFsIGl0cyBsaW1pdCB0byB0aGUgc3RhY2suDQo+DQo+QnV0IEkgZG9uJ3QgdGhpbmsgd2Ug
c2hvdWxkIGFkZCBlbmZvcmNlbWVudCBvZiB0aGF0IGFzIGEgcmVxdWlyZW1lbnQNCj5mb3IgdGhp
cyB4ZHAgZXh0ZW5zaW9uIG9mIHBhY2luZy4NCg==

