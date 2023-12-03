Return-Path: <linux-kselftest+bounces-1026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A50802263
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4831FB20A39
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410BD8F5C;
	Sun,  3 Dec 2023 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJLK2RKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF5F2;
	Sun,  3 Dec 2023 02:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701598265; x=1733134265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OdMJyiw3DiY+G0Ay2wmzthMQTlDCu7QMZaNts/6fyjs=;
  b=dJLK2RKF7HF8vksNABcOoH/OODLPwAj6HL71/+g8LY/BrbbNeRoh9WVX
   A6rRtAwrEJua2b4gEtsVO7v5a6/di01VjdhbXdQPVuJO4770W2PFs3pQc
   9kh/Hjt+axIxK2DBG7OVAy7lI9Pu47/pL9L54Zs61CZF7yuBdSg8toiNb
   spo8CtQk0mzG+DZsU7k0/kJqq7scq1oHU0oZzgkl/oUS8IFCpjxPgl3G9
   bgXa1v6Z4i7pRatMIpFL7vCezZmQrs91N9az1+X8piPYU2sr8ukfkoaIh
   1wPZ5MrZLWxksfaWAh8ISMj8bgFubyIed4sOTcpyVVKdZA5q4mU1W8Okq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="492177"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="492177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 02:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="773955638"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="773955638"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 02:11:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 02:11:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 02:11:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 02:11:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 02:11:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERUqQpQbBVKdp05E7Xxo/Ku1C/OHFEMQEw7Hur+YrN6WeyK6N9Ymw2ZR9thgH8nCuJ7JhoFT29vqgBhSXsOkcZfX5mmz2aH0rpk7ZAMHfjplyoVWKJxLIv46YMMAqVR0XO1RGaGH6Hh/77bRPxxdMwlYEzRZKJ07CDtZtKP/qc9tA+gjg5059UMEKqrxbTUjiH48l/gPxli2kUWn6rpaCV0lMQUww6Y5wiqWo/OgOX3j7IwvUORrxnLlgLTRDNcynpKyPbheEutz2yhmesnOvfC2TNVlOlkbAsWsVR0CxHz52gXOzbXkF+4K22ZH2Cn4qrHtSHZPM95OGl+79Ocx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdMJyiw3DiY+G0Ay2wmzthMQTlDCu7QMZaNts/6fyjs=;
 b=YQEaRbivzGKKBPZOinZOLZqE9CodZsp9g4Qm5Tu1EuoAQs2t0OzHsWUtUYqqMOjH/pPcAmjkLzEJPf3j4WCMT2x7dmbv3c6OAcFwTsEAZAYINsOxXhSffR5qCKm2XvdgVsgJx3VjjhnWoFYml+ZYRLe6IqsO3Lzahj+6JHaZmBAFFaNpTFPBU4PxkK8MJ8DPu8ZfGn9sZH7X/bO+9oIBS/kToH44gK/NA1TeptMeyGS9zkWFxXSCwH3kDIWRElCNkHD7rbpKxWfzp4i7YI2zlWemnlcDXdW+rtUpAiX2Wf5uefM615nO8YVvLHmDAqAxgXQWRUQfligRZKU6Vm2+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 10:11:02 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7046.028; Sun, 3 Dec 2023
 10:11:01 +0000
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
Subject: RE: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP ZC
Thread-Topic: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP
 ZC
Thread-Index: AQHaJB8y3IJpv0o6sk+7VcjRfinq5bCUhocAgALJsHA=
Date: Sun, 3 Dec 2023 10:11:01 +0000
Message-ID: <PH0PR11MB5830F08AC202C42501D986C0D887A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
 <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
In-Reply-To: <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CYYPR11MB8308:EE_
x-ms-office365-filtering-correlation-id: a3e02dbd-7670-4bda-925d-08dbf3e8271e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNAK58wAnxPujgwIL1u3i2eivOO4cwH3ypMMYQHKtqt+/3R7s+198H/u+6A5Ve8XjAA/gFdSMfmkDt1UjtGTamtGLK/HeYeI2MXN90lkPogO9eTRoPFNJiR5bnfzLCFT59HmvMKf4T4eQoRFMHfAiCsJBECqc/OwcoRO2zg7fOYRhkbxWBtYEdXQD0UWQObo2Ba8fFAaOksvbhq711p+ik3TjqubP2rQK90r9kS0XBkZw2cigYezDMS1XhwFxjmCdNlaAL66szZcT3sWZWAsfYPWUyRYue/yahIlZr/mPcLGG3js4RZc8DFXx4QQj3191yuV7mdxPcQMjZ4dY4ktkKh0aQ9RQNlgdyuj2+3nhTMkCTVZjQGtzXSTtXKzgU8X6gvEb5uuOyVmW3mcPFYDiemgzYG7Ywow/b2e+RqD4i6pWUMfnA1q8gQP20LVkBkI52mvs2ZMqPCIgPLB66Sq1IDxKeLZ0en7t0TJFc4GEWnLQyU45CeL4GGrotQcBbHCdaqYlh2hphsx189vnadAf5mri3KAYeruCEMUH++9yrlNBM5mzJ4aa68Zmqalo6DjHa6mmsmtw9Wul0NXOLZ6BHfCqQ3UwLu7YshO2QqmyELgh2QS/kLja8b+khpAHeSv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38070700009)(55016003)(38100700002)(122000001)(921008)(7416002)(7406005)(33656002)(2906002)(5660300002)(82960400001)(53546011)(83380400001)(9686003)(6506007)(7696005)(71200400001)(26005)(76116006)(110136005)(478600001)(41300700001)(54906003)(64756008)(66446008)(66556008)(316002)(66946007)(4326008)(8676002)(8936002)(66476007)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXFYMWtpZGZIWWx1V0JvdTZ3R2VNbU1lZzloU1BqU2NUYzF5R3EwVHhNcjh2?=
 =?utf-8?B?TmZCelBaVno3bzNDVXZUL041aFJoNTJhYTVsUmpLRHdxa3paWDQ0eUM1SG1H?=
 =?utf-8?B?UTBESlhKbkkzRzNidHF4V096TWNqbHhibkwwTS9jcnZ2V2N0TE9hMkdEQk96?=
 =?utf-8?B?LzZhQUZNZmFtY3hnWWY3Q1JDRDluVmRUWGRxQUt0YzR0c28xbHozWEpuTVdG?=
 =?utf-8?B?VjJpZE9kL213VWlNc3FDNTVXYjgvQjJYVkN0a1pwdWhMV3ZFOFB0UENHMm9l?=
 =?utf-8?B?OUpqN0RCcjFKRzVxb1VSL1RrYWJxQ3MxdjRYOThRTk15eHZrV0JLeWc5SjBD?=
 =?utf-8?B?SStuVXJLYlhuSlIzMWgyM2ozelVjQjNGN2xXVjgwWk5QNUdSdEtCY0hYZER5?=
 =?utf-8?B?R01ocDVFbmZuV1dER09FeVNpS2trbzBjVlhia3V6cUpmTi9YOGttZUg2S3Iv?=
 =?utf-8?B?aGZYRE1qWE9QMEdxZEMxL1ZqRURuMXJnNzd2Rzdtc3R1UzRwTEVFa3gzTWVz?=
 =?utf-8?B?Ly9qWklEcFdKMGhMbCthdE43WTdTQ1BhSjJydGc5T213WXAzSXVlUk40cURn?=
 =?utf-8?B?cFUwOG5oT1FFa1pQL1ZsaG1rYlBaaGxITUFMaWRsT2MwdVprVHlCdStuaEhZ?=
 =?utf-8?B?WnRwOThFTVBQVTdPamFhSEpUKzlacHlGTlE5d002UkllSFRHMmt5ZzRUajF3?=
 =?utf-8?B?REdqTzk1cFRUb0g1cExOZ0crSDZEdEZoUXVkMlJjOE83Tm9HWGZNM2RZZGth?=
 =?utf-8?B?dTMxQjFkQTJ4WDFMQTRZQlAwYks3UkIxdTRDamN2cFVqaXA1dndzdmkzdVk4?=
 =?utf-8?B?a1NGeHJFcnczalpkUEtOY3ZNSlUzZWhybFl3dU1jdXNQRXhDRTEwbnpaS0VC?=
 =?utf-8?B?N2kyV3pEK2UyQlFoaVEyQTdhVmN2eXczWTJxOFhUZVJEaE1UNDZ5c1dhR094?=
 =?utf-8?B?R1lPSXR6ZXlIenF3MWI0R0lXK0xBUFl6NVc4ZkNQRzRZcVZnNFZqOC9Edm5H?=
 =?utf-8?B?YzJBZnpQOWt1UW10bUlyaHM4UW1WdmJxcHI0ZWF1bXpBbWhaRWNLQXBWSjN1?=
 =?utf-8?B?T1A4ZW0zUC9WMlVmMFgyb3o4TkNPMWlGSHprdjdPbmRUN1Zoc212REYzUUtH?=
 =?utf-8?B?bnd6OWhPa1NZdXFUVjhxQVFrUnRic1FMNUh4SlhSSnh0dm1aeVhRQ3B3T3NW?=
 =?utf-8?B?bmQ1dDRjS1ZodWJNcEhBOTZqVnFzaEw0bmgxWWJtVEIyUm80SDhIeXZMaEJn?=
 =?utf-8?B?Y2dDeEZyTnZNQVNxckNYd1I0QmZWdmNETFFUcjI1b0hHcGd0Lzl6MktKWCtn?=
 =?utf-8?B?Tld6ZGk4akdCNWg1L2NPNEd5TUxUN1NVVTJyZjNlaHNLa3RiMnpVdlpCMXFY?=
 =?utf-8?B?WkE3M2Q2Q3JnMnlsRlZSMlFPU2l3cjlYemdjaXpqVmdkTFNJTHBnWTd0ZVRu?=
 =?utf-8?B?NXJPNmpTY0dRZjllOVk2MXViWGZPWUZFQ2FaT2V0aHovNkJ4eC9Gb2prQ0Jt?=
 =?utf-8?B?cEVFYlN3bXFlRURseXpWMVhXQmlUTVhUai9PMVlnVndkdlZXeE81TTJaMlJT?=
 =?utf-8?B?OEZmamF4NWI5Uk5heE1TTUQyWSt2Mmd2ZXFiSzM5bGcza1hBTGMwYUl1L05U?=
 =?utf-8?B?V01vMUhINjFXOVZ6eXpVeGFhM202djF0RXZ0b1dTNGFKVEtoSkVEeGdkb1Jl?=
 =?utf-8?B?ZENGZVQrSzJVMXlxR0I3SmlBRnlsbmJpZlRzem1BaTg0cGZSMEhrcjhrU0h6?=
 =?utf-8?B?ZFVjWndwVy96WFU5Zkp3Vnc2UnhUMnNzeVhCMFVSTEpBVTM5U3FLK0ZpUERQ?=
 =?utf-8?B?VVp0dS9UUzVJV1lQNGlzZHBUcThKT0tObDdYNWhxMDlwd2Y4V3F2ZjJIbjJY?=
 =?utf-8?B?SVBGRHA5Y0dndTZ6a2JkbWQ2YWlZbzlrdlBoOXhRUVh1Z0R5TDNBTFc5UVRx?=
 =?utf-8?B?RnpYcTdRWGhUKzBndWZjb2c1aW9kdFE1R0doa1pGUGVaV0o0eW50anZVd3Mz?=
 =?utf-8?B?cjRTQThqVE05NlgzWHo5TTFiM3ZnbWJpVWF3QTBaZTNHcGE0Skg0c09Ocldr?=
 =?utf-8?B?Y3hPY1U2TVRmRG9ON2pwSitzbTRObVQwa2tkNU5ObUpXL2JGdko2QXc3NFhE?=
 =?utf-8?B?QVRTWTJKeWhWd0FWbnREMEROUzZyVU9GWitFZlpuZWpFeDYyY2FOWUgyeEZi?=
 =?utf-8?B?RUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e02dbd-7670-4bda-925d-08dbf3e8271e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2023 10:11:01.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NwPcGYcozQGrsV6ULlCeGbZPX/BJl/c8wUo74EWl/R+Qz1tUy612azWfUVELa7debrN8OJ85VtW15CXGbLfVBO5z94BMbibhWvEk2Yq5e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8308
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBEZWNlbWJlciAxLCAyMDIzIDExOjAyIFBNLCBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyIHdyb3RlOg0KPk9uIDEyLzEvMjMgMDc6MjQsIFNvbmcgWW9vbmcgU2lhbmcgd3JvdGU6DQo+
PiBUaGlzIHBhdGNoIGVuYWJsZXMgdHh0aW1lIHN1cHBvcnQgdG8gWERQIHplcm8gY29weSB2aWEg
WERQIFR4DQo+PiBtZXRhZGF0YSBmcmFtZXdvcmsuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU29u
ZyBZb29uZyBTaWFuZzx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWMuaCAgICAgIHwgIDIgKysN
Cj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYyB8
IDEzICsrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
DQo+DQo+SSB0aGluayB3ZSBuZWVkIHRvIHNlZSBvdGhlciBkcml2ZXJzIHVzaW5nIHRoaXMgbmV3
IGZlYXR1cmUgdG8gZXZhbHVhdGUNCj5pZiBBUEkgaXMgc2FuZS4NCj4NCj5JIHN1Z2dlc3QgaW1w
bGVtZW50aW5nIHRoaXMgZm9yIGlnYyBkcml2ZXIgKGNoaXAgaTIyNSkgYW5kIGFsc28gZm9yIGln
Yg0KPihpMjEwIGNoaXApIHRoYXQgYm90aCBzdXBwb3J0IHRoaXMga2luZCBvZiBMYXVuY2hUaW1l
IGZlYXR1cmUgaW4gSFcuDQo+DQo+VGhlIEFQSSBhbmQgc3RtbWFjIGRyaXZlciB0YWtlcyBhIHU2
NCBhcyB0aW1lLg0KPkknbSB3b25kZXJpbmcgaG93IHRoaXMgYXBwbGllcyB0byBpMjEwIHRoYXRb
MV0gaGF2ZSAyNS1iaXQgZm9yDQo+TGF1bmNoVGltZSAod2l0aCAzMiBuYW5vc2VjIGdyYW51bGFy
aXR5KSBsaW1pdGluZyBMYXVuY2hUaW1lIG1heCAwLjUNCj5zZWNvbmQgaW50byB0aGUgZnV0dXJl
Lg0KPkFuZCBpMjI1IHRoYXQgWzFdIGhhdmUgMzAtYml0IG1heCAxIHNlY29uZCBpbnRvIHRoZSBm
dXR1cmUuDQo+DQo+DQo+WzFdDQo+aHR0cHM6Ly9naXRodWIuY29tL3hkcC1wcm9qZWN0L3hkcC0N
Cj5wcm9qZWN0L2Jsb2IvbWFzdGVyL2FyZWFzL3Rzbi9jb2RlMDFfZm9sbG93X3FkaXNjX1RTTl9v
ZmZsb2FkLm9yZw0KDQpJIGFtIHVzaW5nIHU2NCBmb3IgbGF1bmNoIHRpbWUgYmVjYXVzZSBleGlz
dGluZyBFRFQgZnJhbWV3b3JrIGlzIHVzaW5nIGl0Lg0KUmVmZXIgdG8gc3RydWN0IHNrX2J1ZmYg
YmVsb3cuIEJvdGggdTY0IGFuZCBrdGltZV90IGNhbiBiZSB1c2VkIGFzIGxhdW5jaCB0aW1lLg0K
SSBjaG9vc2UgdTY0IGJlY2F1c2Uga3RpbWVfdCBvZnRlbiByZXF1aXJlcyBhZGRpdGlvbmFsIHR5
cGUgY29udmVyc2lvbiBhbmQNCndlIGRpZG4ndCBleHBlY3QgbmVnYXRpdmUgdmFsdWUgb2YgdGlt
ZS4NCg0KaW5jbHVkZS9saW51eC9za2J1ZmYuaC03NDQtICogICBAdHN0YW1wOiBUaW1lIHdlIGFy
cml2ZWQvbGVmdA0KaW5jbHVkZS9saW51eC9za2J1ZmYuaDo3NDUtICogICBAc2tiX21zdGFtcF9u
czogKGFrYSBAdHN0YW1wKSBlYXJsaWVzdCBkZXBhcnR1cmUgdGltZTsgc3RhcnQgcG9pbnQNCmlu
Y2x1ZGUvbGludXgvc2tidWZmLmgtNzQ2LSAqICAgICAgICAgICBmb3IgcmV0cmFuc21pdCB0aW1l
cg0KLS0NCmluY2x1ZGUvbGludXgvc2tidWZmLmgtODgwLSAgICAgdW5pb24gew0KaW5jbHVkZS9s
aW51eC9za2J1ZmYuaC04ODEtICAgICAgICAgICAgIGt0aW1lX3QgICAgICAgICB0c3RhbXA7DQpp
bmNsdWRlL2xpbnV4L3NrYnVmZi5oOjg4Mi0gICAgICAgICAgICAgdTY0ICAgICAgICAgICAgIHNr
Yl9tc3RhbXBfbnM7IC8qIGVhcmxpZXN0IGRlcGFydHVyZSB0aW1lICovDQppbmNsdWRlL2xpbnV4
L3NrYnVmZi5oLTg4My0gICAgIH07DQoNCnRzdGFtcC9za2JfbXN0YW1wX25zIGFyZSB1c2VkIGJ5
IHZhcmlvdXMgZHJpdmVycyBmb3IgbGF1bmNoIHRpbWUgc3VwcG9ydA0Kb24gbm9ybWFsIHBhY2tl
dCwgc28gSSB0aGluayB1NjQgc2hvdWxkIGJlICJmcmllbmRseSIgdG8gYWxsIHRoZSBkcml2ZXJz
LiBGb3IgYW4NCmV4YW1wbGUsIGlnYyBkcml2ZXIgd2lsbCB0YWtlIGxhdW5jaCB0aW1lIGZyb20g
dHN0YW1wIGFuZCByZWNhbGN1bGF0ZSBpdCANCmFjY29yZGluZ2x5IChpMjI1IGV4cGVjdCB1c2Vy
IHRvIHByb2dyYW0gImRlbHRhIHRpbWUiIGluc3RlYWQgb2YgInRpbWUiIGludG8NCkhXIHJlZ2lz
dGVyKS4NCg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMtMTYwMi0g
dHh0aW1lID0gc2tiLT50c3RhbXA7DQpkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdj
X21haW4uYy0xNjAzLSBza2ItPnRzdGFtcCA9IGt0aW1lX3NldCgwLCAwKTsNCmRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jOjE2MDQtIGxhdW5jaF90aW1lID0gaWdjX3R4
X2xhdW5jaHRpbWUodHhfcmluZywgdHh0aW1lLCAmZmlyc3RfZmxhZywgJmluc2VydF9lbXB0eSk7
DQoNCkRvIHlvdSB0aGluayB0aGlzIGlzIGVub3VnaCB0byBzYXkgdGhlIEFQSSBpcyBzYW5lPw0K
DQo=

