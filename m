Return-Path: <linux-kselftest+bounces-37363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1834B06218
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9634A6F33
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F11E3DE5;
	Tue, 15 Jul 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="q2NZ/OTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6C2CA9;
	Tue, 15 Jul 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590980; cv=fail; b=dzmt0H0uiLepXx8WGQIMJfQ2wuANBWcIX9VKAPcv3THa+wA2pc41rbZuxGhMUe1+EnWj+CLSWhI9jnA5qnL1dIw/Zo2vd7e/XspGCdAE7nwL8IFgKmrJI6gVvGdQuHt2uWBmCeYa9jDezfxP9pbxVwEQex8Xh61ejejP5DBNKn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590980; c=relaxed/simple;
	bh=5QiQJsxTCaf0GVwoBzXTDxTMXHy6jAITeagKqbnLS8I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DaYYOFV30Y8d8K3tJc6EoeY2HlNYDngnkC8oNe/QdkmKuWCpwExXaRkROnS+POrHj6yzJKqLYyuOR69Qjx+S90CW+qojsUQlltSf2gXDSnEk565Bpaw4a2NWHcwaeRACcnowyXJ2QPbzBmi6DAUK+fGaoWb0Cb/uYaxcuMSdKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=q2NZ/OTR; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw1DagfYbPYmkO6RStQzMjgilE9QMTP0e6NK7VcbXC+HWj3UMi2nVKFxdGzwUF5peNJE94aV3sRHYowv7aH9VCueVNrn2zbPtzPrGdzc4pvan/hSFzLRQ7KUrIUmHodASJdn/QfmiVZY7FTFtReuCAgLYPhjusbtOfNzsXOjvYEbUqnpDtVN2pnxPs0lBe02NIEaZ/+NRw+SVj/TjZrfN7LzSWydOYYnXOxdZAVGtYC9J2WORjuVU1XxYVnpDHV6S8kvhl8sAl01qroq8+wuosX0JB5Hle66L0Vugc59wGOwXzNsehRpfIByYUhY+LR6Or5FhvWc+1jEMYCV2jqp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QiQJsxTCaf0GVwoBzXTDxTMXHy6jAITeagKqbnLS8I=;
 b=TtGYfqCFHb+1k01yIgW+u3TsIKVaea3xBZZ2X30Ggv4Y1fOn0hWpMahNlg62fAlzs2U/udPQCre+DyNFJNl1djKY3UVR7lS3r3m9nKtCXGielYhM8wzXIinCkz4vWRgb2var3k62mA0CjoujyOx5nUxgZ4bAFVbSMWan47HsPlnytuL9YSQyAi/0cBVQc9WTg5dVUHsMn4cZeJ8ccSGTOSI5fvviz0RBnyuxrTO/lY6rKdsMmhhnMh/HSTuUDRkMUfuegQvcv27uNqiyRGnd0j5J+G82ifAjN/I9itVgUBIhu1sni+l9h3p9+mCecnLyk/xwkNvnVy1/EEnbCjXwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QiQJsxTCaf0GVwoBzXTDxTMXHy6jAITeagKqbnLS8I=;
 b=q2NZ/OTRgClPVqOfVDdum252WcB5Ca0RHY/e2zZ4y7meOfQZw6zEN2oplj055DiGqHH27E1tYYJEErSA4Cq8IsUrEBNidEsE/IurSX+T8ZtmayZx2b2uf6rra6ynAkcUiSY+nvcCfP0flauBd8Da3aCYTp4NiYebYEja6/tGAkDJHDnpaG2+s3IbDusU2IB/o9bnuxLJcDZpqHFrlJa9QGCHMsSn5Ox39qy3YsKiXOnbUdA5Z9S4M0fMbT8mJStm0ymD8D+nxfPpHqP1S/dwMz/sUsGJ5jA+RYV20wyyM0d+pWBAs1qd5YqJrayYnRZyN9m60odTH479wpfb6w5pbg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU4PR07MB10369.eurprd07.prod.outlook.com (2603:10a6:10:5d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 14:49:34 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:49:34 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v12 net-next 11/15] tcp: accecn: AccECN option
Thread-Topic: [PATCH v12 net-next 11/15] tcp: accecn: AccECN option
Thread-Index: AQHb7MFmSv5XpkIhCEaAxbp2c18Hf7QxvrMAgAGXFwA=
Date: Tue, 15 Jul 2025 14:49:34 +0000
Message-ID:
 <PAXPR07MB7984F66EB2AD576D2385C351A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-12-chia-yu.chang@nokia-bell-labs.com>
 <0ddc5daf-adb4-4d97-9e8e-e60fdf9a007f@redhat.com>
In-Reply-To: <0ddc5daf-adb4-4d97-9e8e-e60fdf9a007f@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU4PR07MB10369:EE_
x-ms-office365-filtering-correlation-id: 9c705e07-7b23-4315-bee5-08ddc3aed06e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTJNQWRPOEtuYVBOMmJnK0FoU3dOeDlTV1dsR3V3ZDFLaGIxRXVpSWo0Z2JU?=
 =?utf-8?B?K3NEZ29FalZoNGhnMys1ajhmay9uMXR2VjRhYXRuWkNvRXc1NTg2OHVVWVpZ?=
 =?utf-8?B?eFlyMUVVa1lNVGJGWUxieHIzL0pmTFhGaVlyTFF3bEJ5UjZiVFFwVXkxS0ha?=
 =?utf-8?B?akx3ZU1QWnZiNTM0S2lJRWtuSFBWV0cxVCszV2plWng0NHIzQUtoS0tlUUFn?=
 =?utf-8?B?Q3Z5Y3B2MEg1SEFBdENSME80SUliMldkODcvdHp6bUwyY083OWxCOXIvQStP?=
 =?utf-8?B?TDdzcjRITHdVN2pOOHRlaHNNMlNiem42bHlEQWljY0h4OEhjQktUVkdvN2RH?=
 =?utf-8?B?Qmswbm1Eem96WHQvZW0zdzlQb1BaZnFMZkxuZS93am9tOTUvbmI0VlNzc1c0?=
 =?utf-8?B?a3cxSzF5TjgzcGkxM2w2RmQ0Q2l1UEZPVlhJWFJ6U0pTL3BFdmdoUzQvNTNE?=
 =?utf-8?B?SGdhQ2ZuU2UxWHRsbU5RQ0YwbW40QVpxVjJkNkVPRzY1Q2hhOWdXUHZlS21Q?=
 =?utf-8?B?Vi9mRy9tR0FyMHp1UGNaYjkyQ2RHRHA5VEU4OU93K3N2SEhLV08wR2VYMjk4?=
 =?utf-8?B?TWFwcGtTSmFDbHVTRnVCNHhISHRONEMvbWYvb3R5aVg5U1h2c0pON25kMS9P?=
 =?utf-8?B?TVBFUkdYT0s2RFpDb2R5dHQzOEhuODFDbzRJbzJtWmExcGxPTDd1UlVoMHli?=
 =?utf-8?B?ZUpRaG5Xb3Jmb3pISGZ1aXVkYmlZRVRvL0JvR3hUVlNGTy82TDVqZW4vUkw5?=
 =?utf-8?B?QVU5UURveWJCZVhQWmNFbEgwK1RxdVE0dkp2czkrZG9zVm5mOGkwT1djTWw1?=
 =?utf-8?B?R3R1Mlo2ZXZ5QmxxU1JmQURIZXRUeG5hanErWFUzMHh2cCtSeTN4TlB5Smgx?=
 =?utf-8?B?QXowNW1Zd2F2TFhJVVlkNDUxV3hZdjBkT0ZpTTVyY0JxNnA5REx0OFlvRjZY?=
 =?utf-8?B?bWFxUVl1UEc5MU9VWmt2eU9OZVZ0ZHlZendWQTFrUXNoQ1dzeFI2NklzK29r?=
 =?utf-8?B?dkhac1BwM0VZMzBkc1N1WFlHOHNNUWtTNE9iZTh1YlBFR0R4dU1kdkFEYjY4?=
 =?utf-8?B?WEMvZUV6eThGRzQvYXhZOFM3cXVNdFVJL3FLcGZhNk82MkYrNE1LMk5UMUtZ?=
 =?utf-8?B?WWNISkpUT2hCbVg0Qm05eC83UzZOWWVTaE5sbERDTnNCQjMwejUvWG9oT2Nx?=
 =?utf-8?B?WmVDSWwzTzl5SDFFSnBMRC94eHZxclZWUkxReEEvdWV0cmhoSmtRNFhaSWU0?=
 =?utf-8?B?d0R3MHRFSlFyM3MvUTkwVW9RT092VzVDdXRVai9xbngxYVRtVkpPSHM2TUxy?=
 =?utf-8?B?dUtFMFBnMVZZMWwyN3c1UWkrdjhvSGYyUWtYbVNjZTdvejkyaDhIYlJMQjNo?=
 =?utf-8?B?RFErMnBGdUJxN0JoUEpFTlJ2ZnhuUzYxN3Y4K09ZN0tiVExOM29qckVYVW9M?=
 =?utf-8?B?b0FVVmN6bU1icTQybkpJYitQTXJUODlvMlNndjB0cWowVVZKamJkdWVJWkZx?=
 =?utf-8?B?S0djblFjWTA1NzlydGVnY2FmZnYrSkl2NjBsOU1XTjFDY0crOCtDeWFnYzcv?=
 =?utf-8?B?bDFDVUFpWkpIdEFWL3cvMGh1eUFxV1VQS2UvYWxlYzNpTkhOK0J0T0xVZG9v?=
 =?utf-8?B?VllldWtSUjdIUlBwMGR0d3RWSjg1N1dtTjM4a2d5MjRBWjF6ci9tVm03aldI?=
 =?utf-8?B?amt3M1ppaFJJTFlOcmQ3eVZkVTM2ZEN3c0VaVUVDbU5BMTFFSlJ3MTR0bVhx?=
 =?utf-8?B?UWJwdHZUNWZGUnB2OE1xQkw3SWhRODdMR3h4RWlTY2hnL0JXNHphajN6K0Vm?=
 =?utf-8?B?dkkrUkp0OWJlRW8wWk1kTHcwUUxOQjZZdWxnSmV4QlQ5TXZXaSt1NnhCdlZu?=
 =?utf-8?B?eEoxVVVqLzNGVHkxekNhd3dVTVpWTHRNWXprZnQ2OTJaQUdPbXlZK2FlbXE5?=
 =?utf-8?B?dzZYbjZRUVU4ME52WEhmYWQyWHl2azZ1QU5SaVlWTUxpdGV2N1JGRmRrZ0Mw?=
 =?utf-8?B?YUROL09lL1Ryd3BtQkhlaEgvb3NUS205M0lnMlhrVnBtZEVBbmJJL09WblRy?=
 =?utf-8?Q?Yj9O0L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWN2N1JGYm9nOTRkanRBRE5ubjBjcWVvSTBjcTRGa2ZMcnlvMlREVTNuMVFn?=
 =?utf-8?B?MHQyTGl6RW9hNDJSVXc4Yk1KSHhJcTBoRDVOb3I5RXJIZW5FbThjQ3lUQ2xo?=
 =?utf-8?B?SExnZWdIcjNzTkQrU3VpMFU4QnUxZDJCQ1lKU3BHdkhVRU1Zdk5YLzR6TTFG?=
 =?utf-8?B?QWxtVFhPWkFBbFhUbkR1OVplK3FKcFBIZ0M1cHVQTUJJN2VtZ2Rra21Id09H?=
 =?utf-8?B?TGVUWDVPSWprZCtJNjlFMTlWQ2pLMldTTjBKdXoxUW82aEh4WTJ2NXpBajM4?=
 =?utf-8?B?dng3QjFjWDJKMXpqQktuK3JlODJnaTFPSXZLaW03NWowS0l6MUFRVW9Fa0Uy?=
 =?utf-8?B?MXZycUNROXIzNm52dnlqNThOOUxhNWxsRGFYaVdXTERnclNQbEFwUWZobFUr?=
 =?utf-8?B?WUxKbzE4d3VRL1RJdHJxd1VxQTdBSGJ6OThMWUhMMm53WXhSMmFKNloxRlRu?=
 =?utf-8?B?d0JaZDVZUXZES3kvNDNrcTNLRWJVcXFYVnFFODVURTd5V2FUWXpRUVhyUi9h?=
 =?utf-8?B?QjJnUHRJOHg3UGljMHltamZHWjVYRWQ1RFJLL3RCb1Vkcy9jZjYwd3hnY2Zo?=
 =?utf-8?B?S0FSNnE2aFRUWHJOVExWTW1OT2xlbmhsRHRKWXAyTHR2aTR1ellxR0FPMDRi?=
 =?utf-8?B?YzR6ZXRUMm5waGNUaGhvSjV1K3A4bVN2VGdqK1QwalhPYzkvS3JYU0xScmFT?=
 =?utf-8?B?VWF2TFhpYnZ4NTdGemdGaW1wQTNmdkZqNysvdi9yTXU3Z212Yy8zVGI1SHd3?=
 =?utf-8?B?MGptNUxxb2xzcXZ5M29pLzA2QzY2RFNyUkwreVNwYTc2UFR2ZittNDRFamdr?=
 =?utf-8?B?ZGh1M0Rod1lCQ1AzUXRnbmZZR2NnSHBFbDkzMVpZRmVVWlZReEJHMHV3RFZs?=
 =?utf-8?B?VENabUNIQlhTNUtZeDJNRGxqMXFoNzljTGJzeHpCR1NOWGZ1T2piSjlXNG1U?=
 =?utf-8?B?Rm1RNkh3RG5zNk1kU2pkRDZlSEhEZ2UyV1pxSVNEVnlSTkptbGZUcGJsUDVa?=
 =?utf-8?B?TjJvYTEycTlvWDBvajFtNXNxZkcvaUExRDg4ZTd0UmxWdDNSMEZEbmNCVzFT?=
 =?utf-8?B?Q2JLZmlqWXA4dEVzTlJObStLbW53NHp2U0p1MEw5SG10c0MxbDk2Q2tEdDFM?=
 =?utf-8?B?TDhpWWo1Ly95RGp4VlhFODk5SDNQQ2dzN2xPZm85V0pvTjhSQkJ4UUQ2VlJZ?=
 =?utf-8?B?d2JDV1hKQnF5UVJiSGRsVjJPcDlqT25CY3lpb3NsL25oY1BUc28vVmdqb0FB?=
 =?utf-8?B?dW5zckxuSW0zRHYvMjB4dDdlaWcwNHAzS1RrQWpINCsvV2p3TUVadFhQYzBL?=
 =?utf-8?B?WEt6MUJ5blZKeXBYYzM1NDBmZWp1NWY1Z09GdHhRc1Ridit2Q0dqcXFObG8w?=
 =?utf-8?B?K2ZneUx6UDdLZm9zNlo1TnJvWWtMOFY1QlRKditqSFB2VitzUnluNkM0ckN4?=
 =?utf-8?B?M0Q2ZUxzdkFtbXRpK041am0xZWZ3VmlyRjdnZUNYUGErcXNxR2NaKzZmTWVL?=
 =?utf-8?B?d3pxZnNGcG1MT0xBZjAwY1hLQ05QTHpiMTJ6MEhaVlQxMVZMbzdpbUE0L3NZ?=
 =?utf-8?B?Y2lVekdEZzlITXR0VXJoc04rRk9COHVFa2VhN2pyTnZ3eXhpdEtqVlBzT015?=
 =?utf-8?B?dlZPcitrNms0eVhXS09KMU1rWXk0d2UxK0VKOGZDc1pXakxZcnh6S2pWcWUy?=
 =?utf-8?B?QWRCcTNvcUFmWi9PcEV3dE5kS2xTTFRYTCtMZUtCODRxV2xmVUFia3p3VzRW?=
 =?utf-8?B?emVvOTZBN0ErQUlrZWk0NSthMGJKaWk1WTVVSUpqNk9lMjNBOTM2clA0Z3JK?=
 =?utf-8?B?RDEzVktuZWlnSEJPVmFTZjNrcWdDUlF6TDBUOFVudnZlNFI3NG9icDBHNlhD?=
 =?utf-8?B?QUZ1SVk2dmdjSFRkK0o5MXlDaitLL01UTUlkTmYxZUkyOXY5SmRwbmRPbmh3?=
 =?utf-8?B?RUI4ODBCMnpyaWZiRDgwbnBTcXhVTk8zNkZHYzdPdlMvN014TGFJaTdJM3h2?=
 =?utf-8?B?QUdZU3NLcEE1TFpJUkY0YlNKYkxMNVRmZ2l3L0E1YVU3Ync5K2t1N214eUdG?=
 =?utf-8?B?RUxXT3ZTdDZBZWF1RERrdFNIVmE3Qm8xNFhpWkIzNEhNaHhuUE5uNWs3TzdY?=
 =?utf-8?B?cCtsdi9ySU1rMktoNTY3eGhnSzh4UXpSZ0J2WTBhci8wM1VkRUQxRjc1S1hm?=
 =?utf-8?Q?xXej+Une4JYkG5e5DB7KKL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c705e07-7b23-4315-bee5-08ddc3aed06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 14:49:34.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFwWsIZv1XKzvKFtvY4zCG2ukO+AVxJHr8yPeLq0v8dttoIQ6X2aqSwHJ2tS6cuQEpoD2dqv5rPw49wQqV1DRY1+kJ1Pn1eDuGvGxishaMXvYHqz5IsSILWWR5jEKbg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10369

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBNb25kYXksIEp1bHkgMTQsIDIwMjUgNDozMiBQTQ0KPiBU
bzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+OyBlZHVtYXpldEBnb29nbGUuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3Ji
ZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVA
YW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
ZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJp
QHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21h
aWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3Jn
OyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAo
Tm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNh
YmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVo
bGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsg
SmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMiBuZXQtbmV4dCAxMS8xNV0gdGNwOiBhY2NlY246IEFjY0VDTiBv
cHRpb24NCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2ht
ZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4N
Cj4gDQo+IA0KPiANCj4gT24gNy80LzI1IDEwOjUzIEFNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20gd3JvdGU6DQpbLi4uXQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBIYW5kbGVz
IEFjY0VDTiBvcHRpb24gRUNUIGFuZCBDRSAyNC1iaXQgYnl0ZSBjb3VudGVycyB1cGRhdGUgaW50
bw0KPiA+ICsgKiB0aGUgdTMyIHZhbHVlIGluIHRjcF9zb2NrLiBBcyB3ZSdyZSBwcm9jZXNzaW5n
IFRDUCBvcHRpb25zLCBpdCBpcw0KPiA+ICsgKiBzYWZlIHRvIGFjY2VzcyBmcm9tIC0gMS4NCj4g
PiArICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgczMyIHRjcF91cGRhdGVfZWNuX2J5dGVzKHUzMiAq
Y250LCBjb25zdCBjaGFyICpmcm9tLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1MzIgaW5pdF9vZmZzZXQpIHsNCj4gPiArICAgICB1MzIgdHJ1bmNhdGVkID0gKGdl
dF91bmFsaWduZWRfYmUzMihmcm9tIC0gMSkgLSBpbml0X29mZnNldCkgJg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAweEZGRkZGRlU7DQo+ID4gKyAgICAgdTMyIGRlbHRhID0gKHRydW5jYXRl
ZCAtICpjbnQpICYgMHhGRkZGRkZVOw0KPiA+ICsNCj4gPiArICAgICAvKiBJZiBkZWx0YSBoYXMg
dGhlIGhpZ2hlc3QgYml0IHNldCAoMjR0aCBiaXQpIGluZGljYXRpbmcNCj4gPiArICAgICAgKiBu
ZWdhdGl2ZSwgc2lnbiBleHRlbmQgdG8gY29ycmVjdCBhbiBlc3RpbWF0aW9uIHVzaW5nDQo+ID4g
KyAgICAgICogc2lnbl9leHRlbmQzMihkZWx0YSwgMjQgLSAxKQ0KPiA+ICsgICAgICAqLw0KPiA+
ICsgICAgIGRlbHRhID0gc2lnbl9leHRlbmQzMihkZWx0YSwgMjMpOw0KPiANCj4gSSdtIHVuZGVy
IHRoZSBpbXByZXNzaW9uIHRoYXQgZGVsdGEgY291bGQgYmUgc2ltcGx5Og0KPiANCj4gICAgICAg
ICBkZWx0YSA9ICh0cnVuY2F0ZWQgLSAqY250KQ0KPiANCj4gV2hhdCBhbSBJIG1pc3Npbmc/DQoN
CkhpIFBhb2xvLA0KDQpJIHRoaW5rIHRoaXMgY29kZSBpcyBuZWNlc3NhcnkgdG8gZW5zdXJlIGRl
bHRhIHdpbGwgbm90IGEgc3VwZXIgbGFyZ2UgdmFsdWUgaW4gY2FzZSBvZiB3cmFwIGFkb3VuZC4N
Cg0KRm9yIGluc3RhbmNlLCBpZiB0cnVuY2F0ZWQgPSAweDAwMDAwMDFGIGFuZCAqY250ID0gMHgw
MEZGRkZGRiwgdGhlbiAodHJ1bmNhdGVkIC0gKmNudCkgPSAweEZGMDAwMDIwDQoNCkJ1dCBzaWdu
X2V4dGVuZDMyKCgodHJ1bmNhdGVkIC0gKmNudCkgJiAweEZGRkZGRlUsIDIzKSA9IDB4MDAwMDAw
MjAsIHdoaWNoIHNoYWxsIGJlIGNvcnJyZWN0Lg0KDQpBbm90aGVyIGV4YW1wbGUsIGlmIHRydW5j
YXRlZCA9IDB4MDAwMDAwMUYgYW5kICpjbnQgPSAweDAwMDAwMDNGLCB0aGVuICh0cnVuY2F0ZWQg
LSAqY250KSA9IDB4RkZGRkZGRTANCg0KQW5kIHNpZ25fZXh0ZW5kMzIoKCh0cnVuY2F0ZWQgLSAq
Y250KSAmIDB4RkZGRkZGVSwgMjMpID0gMHhGRkZGRkZFMC4NCg0KSW4gdGhpcyBsYXR0ZXIgZXhh
bXBsZSwgYm90aCBhcmUgY29ycmVjdC4NCg0KWy4uLl0NCj4gPiBhL25ldC9pcHY0L3RjcF9vdXRw
dXQuYyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYyBpbmRleCANCj4gPiBkOThhMWExN2ViNTIuLjIx
NjlmZDI4NTk0ZSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiAr
KysgYi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiBAQCAtMzg1LDYgKzM4NSw3IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCB0Y3BfdXJnX21vZGUoY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCkNCj4g
PiAgI2RlZmluZSBPUFRJT05fU01DICAgICAgICAgICBCSVQoOSkNCj4gPiAgI2RlZmluZSBPUFRJ
T05fTVBUQ1AgICAgICAgICBCSVQoMTApDQo+ID4gICNkZWZpbmUgT1BUSU9OX0FPICAgICAgICAg
ICAgQklUKDExKQ0KPiA+ICsjZGVmaW5lIE9QVElPTl9BQ0NFQ04gICAgICAgICAgICAgICAgQklU
KDEyKQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHNtY19vcHRpb25zX3dyaXRlKF9fYmUzMiAqcHRy
LCB1MTYgKm9wdGlvbnMpICB7IEBAIC00MDYsNiANCj4gPiArNDA3LDggQEAgc3RydWN0IHRjcF9v
dXRfb3B0aW9ucyB7DQo+ID4gICAgICAgdTE2IG1zczsgICAgICAgICAgICAgICAgLyogMCB0byBk
aXNhYmxlICovDQo+ID4gICAgICAgdTggd3M7ICAgICAgICAgICAgICAgICAgLyogd2luZG93IHNj
YWxlLCAwIHRvIGRpc2FibGUgKi8NCj4gPiAgICAgICB1OCBudW1fc2Fja19ibG9ja3M7ICAgICAv
KiBudW1iZXIgb2YgU0FDSyBibG9ja3MgdG8gaW5jbHVkZSAqLw0KPiA+ICsgICAgIHU4IG51bV9h
Y2NlY25fZmllbGRzOjcsIC8qIG51bWJlciBvZiBBY2NFQ04gZmllbGRzIG5lZWRlZCAqLw0KPiA+
ICsgICAgICAgIHVzZV9zeW5hY2tfZWNuX2J5dGVzOjE7IC8qIFVzZSBzeW5hY2tfZWNuX2J5dGVz
IG9yIG5vdCAqLw0KPiA+ICAgICAgIHU4IGhhc2hfc2l6ZTsgICAgICAgICAgIC8qIGJ5dGVzIGlu
IGhhc2hfbG9jYXRpb24gKi8NCj4gPiAgICAgICB1OCBicGZfb3B0X2xlbjsgICAgICAgICAvKiBs
ZW5ndGggb2YgQlBGIGhkciBvcHRpb24gKi8NCj4gPiAgICAgICBfX3U4ICpoYXNoX2xvY2F0aW9u
OyAgICAvKiB0ZW1wb3JhcnkgcG9pbnRlciwgb3ZlcmxvYWRlZCAqLw0KPiA+IEBAIC02MjEsNiAr
NjI0LDggQEAgc3RhdGljIHZvaWQgdGNwX29wdGlvbnNfd3JpdGUoc3RydWN0IHRjcGhkciAqdGgs
IHN0cnVjdCB0Y3Bfc29jayAqdHAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB0Y3Bfb3V0X29wdGlvbnMgKm9wdHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCB0Y3Bfa2V5ICprZXkpICB7DQo+ID4gKyAgICAgdTggbGVmdG92ZXJfaGlnaGJ5
dGUgPSBUQ1BPUFRfTk9QOyAvKiByZXBsYWNlIDFzdCBOT1AgaWYgYXZhaWwgKi8NCj4gPiArICAg
ICB1OCBsZWZ0b3Zlcl9sb3dieXRlID0gVENQT1BUX05PUDsgIC8qIHJlcGxhY2UgMm5kIE5PUCBp
biANCj4gPiArIHN1Y2Nlc3Npb24gKi8NCj4gPiAgICAgICBfX2JlMzIgKnB0ciA9IChfX2JlMzIg
KikodGggKyAxKTsNCj4gPiAgICAgICB1MTYgb3B0aW9ucyA9IG9wdHMtPm9wdGlvbnM7ICAgIC8q
IG11bmdhYmxlIGNvcHkgKi8NCj4gPg0KPiA+IEBAIC02NTYsMTUgKzY2MSw3OSBAQCBzdGF0aWMg
dm9pZCB0Y3Bfb3B0aW9uc193cml0ZShzdHJ1Y3QgdGNwaGRyICp0aCwgc3RydWN0IHRjcF9zb2Nr
ICp0cCwNCj4gPiAgICAgICAgICAgICAgICpwdHIrKyA9IGh0b25sKG9wdHMtPnRzZWNyKTsNCj4g
PiAgICAgICB9DQo+ID4NCj4gPiArICAgICBpZiAoT1BUSU9OX0FDQ0VDTiAmIG9wdGlvbnMpIHsN
Cj4gPiArICAgICAgICAgICAgIC8qIEluaXRpYWwgdmFsdWVzIGZvciBBY2NFQ04gb3B0aW9uLCBv
cmRlcmVkIGlzIGJhc2VkIG9uIEVDTiBmaWVsZCBiaXRzDQo+ID4gKyAgICAgICAgICAgICAgKiBz
aW1pbGFyIHRvIHJlY2VpdmVkX2Vjbl9ieXRlcy4gVXNlZCBmb3IgU1lOL0FDSyBBY2NFQ04gb3B0
aW9uLg0KPiA+ICsgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICBzdGF0aWMgdTMy
IHN5bmFja19lY25fYnl0ZXNbM10gPSB7IDAsIDAsIDAgfTsNCj4gDQo+IEkgdGhpbmsgdGhpcyBk
b2VzIG5vdCBhZGRyZXNzIEVyaWMncyBjb25jZXJuIG9uIHY5IFdSVCBnbG9iYWwgdmFyaWFibGUs
IGFzIGV2ZXJ5IENQVSB3aWxsIHN0aWxsIHRvdWNoIHRoZSBzYW1lIG1lbW9yeSB3aGlsZSBhY2Nl
c3NpbmcgdGhlIGFib3ZlIGFycmF5Lg0KPiANCj4gPiArICAgICAgICAgICAgIGNvbnN0IHU4IGVj
dDBfaWR4ID0gSU5FVF9FQ05fRUNUXzAgLSAxOw0KPiA+ICsgICAgICAgICAgICAgY29uc3QgdTgg
ZWN0MV9pZHggPSBJTkVUX0VDTl9FQ1RfMSAtIDE7DQo+ID4gKyAgICAgICAgICAgICBjb25zdCB1
OCBjZV9pZHggPSBJTkVUX0VDTl9DRSAtIDE7DQo+ID4gKyAgICAgICAgICAgICB1MzIgZTBiOw0K
PiA+ICsgICAgICAgICAgICAgdTMyIGUxYjsNCj4gPiArICAgICAgICAgICAgIHUzMiBjZWI7DQo+
ID4gKyAgICAgICAgICAgICB1OCBsZW47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgaWYgKG9w
dHMtPnVzZV9zeW5hY2tfZWNuX2J5dGVzKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGUw
YiA9IHN5bmFja19lY25fYnl0ZXNbZWN0MF9pZHhdICsgVENQX0FDQ0VDTl9FMEJfSU5JVF9PRkZT
RVQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGUxYiA9IHN5bmFja19lY25fYnl0ZXNbZWN0
MV9pZHhdICsgVENQX0FDQ0VDTl9FMUJfSU5JVF9PRkZTRVQ7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGNlYiA9IHN5bmFja19lY25fYnl0ZXNbY2VfaWR4XSArIA0KPiA+ICsgVENQX0FDQ0VD
Tl9DRUJfSU5JVF9PRkZTRVQ7DQo+IA0KPiBPbiB0aGUgZmxpcCBzaWRlIEkgZG9uJ3Qgc2VlIHN1
Y2ggYXJyYXkgbW9kaWZpZWQgaGVyZSwgbm90IGluIGxhdGVyIHBhdGNoZXM/IT8gSWYgc28geW91
IGNvdWxkIG1ha2UgaXQgY29uc3QgYW5kIGEgZ2xvYmFsIHZhcmlhYmxlIHdvdWxkIGJlIG9rLg0K
DQpTdXJlLCBJIHdpbGwgbWFrZSBpdCBhcyBzdGF0aWMgY29uc3QgZ2xvYmFsIHZhcmlhYmxlLCB3
aGljaCBJIGhvcGUgdGhpcyBpcyBvayBmb3IgeW91Lg0KDQoNCj4gPiArLyogQ2FsY3VsYXRlcyBo
b3cgbG9uZyBBY2NFQ04gb3B0aW9uIHdpbGwgZml0IHRvIEByZW1haW5pbmcgb3B0aW9uIHNwYWNl
Lg0KPiA+ICsgKg0KPiA+ICsgKiBBY2NFQ04gb3B0aW9uIGNhbiBzb21ldGltZXMgcmVwbGFjZSBO
T1BzIHVzZWQgZm9yIGFsaWdubWVudCBvZiANCj4gPiArb3RoZXINCj4gPiArICogVENQIG9wdGlv
bnMgKHVwIHRvIEBtYXhfY29tYmluZV9zYXZpbmcgYXZhaWxhYmxlKS4NCj4gPiArICoNCj4gPiAr
ICogT25seSBzb2x1dGlvbnMgd2l0aCBhdCBsZWFzdCBAcmVxdWlyZWQgQWNjRUNOIGZpZWxkcyBh
cmUgYWNjZXB0ZWQuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybnM6IFRoZSBzaXplIG9mIHRoZSBB
Y2NFQ04gb3B0aW9uIGV4Y2x1ZGluZyBzcGFjZSByZXB1cnBvc2VkIA0KPiA+ICtmcm9tDQo+ID4g
KyAqIHRoZSBhbGlnbm1lbnQgb2YgdGhlIG90aGVyIG9wdGlvbnMuDQo+ID4gKyAqLw0KPiA+ICtz
dGF0aWMgaW50IHRjcF9vcHRpb25zX2ZpdF9hY2NlY24oc3RydWN0IHRjcF9vdXRfb3B0aW9ucyAq
b3B0cywgaW50IHJlcXVpcmVkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IHJlbWFpbmluZykgew0KPiA+ICsgICAgIGludCBzaXplID0gVENQX0FDQ0VDTl9NQVhTSVpF
Ow0KPiA+ICsgICAgIGludCBtYXhfY29tYmluZV9zYXZpbmc7DQo+ID4gKw0KPiA+ICsgICAgIGlm
IChvcHRzLT51c2Vfc3luYWNrX2Vjbl9ieXRlcykNCj4gPiArICAgICAgICAgICAgIG1heF9jb21i
aW5lX3NhdmluZyA9IHRjcF9zeW5hY2tfb3B0aW9uc19jb21iaW5lX3NhdmluZyhvcHRzKTsNCj4g
PiArICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICBtYXhfY29tYmluZV9zYXZpbmcgPSBvcHRz
LT5udW1fc2Fja19ibG9ja3MgPiAwID8gMiA6IDA7DQo+ID4gKyAgICAgb3B0cy0+bnVtX2FjY2Vj
bl9maWVsZHMgPSBUQ1BfQUNDRUNOX05VTUZJRUxEUzsNCj4gPiArICAgICB3aGlsZSAob3B0cy0+
bnVtX2FjY2Vjbl9maWVsZHMgPj0gcmVxdWlyZWQpIHsNCj4gPiArICAgICAgICAgICAgIGludCBs
ZWZ0b3Zlcl9zaXplID0gc2l6ZSAmIDB4MzsNCj4gPiArICAgICAgICAgICAgIC8qIFBhZCB0byBk
d29yZCBpZiBjYW5ub3QgY29tYmluZSAqLw0KPiA+ICsgICAgICAgICAgICAgaWYgKGxlZnRvdmVy
X3NpemUgPiBtYXhfY29tYmluZV9zYXZpbmcpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGxl
ZnRvdmVyX3NpemUgPSAtKCg0IC0gbGVmdG92ZXJfc2l6ZSkgJiAweDMpOw0KPiANCj4gSSAqdGhp
bmsqIHRoYXQgd2l0aCB0aGUgYWJvdmUgeW91IG1lYW4gc29tZXRoaW5nIGFsaWtlOg0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZSA9IEFMSUdOKHNpemUsIDQpOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBsZWZ0b3Zlcl9zaXplID0gMA0KPiANCj4gPw0KPiANCj4gVGhlIHVz
ZWQgY29kZSBsb29rcyBxdWl0ZSBvYnNjdXJlIHRvIG1lLg0KPiANCj4gL1ANCg0KSW5kZWVkLCBJ
IHdpbGwgbWFrZSBiZWxvdyBjaGFuZ2VzIGluIHRoZSBuZXh0IHZlcnNpb24gYnkgdXNpbmcgQUxJ
R04oKSBhbmQgQUxJR05fRE9XTigpDQoNCkhlcmUgdGhlIGFpbSBpcyB0byBwYWQgdXAgKGlmIG1h
eF9jb21iaW5lX3NhdmluZyBpcyBub3QgZW5vdWdoKSBvciB0cmltIGRvd24gKGlmIG1heF9jb21i
aW5lIHNhdmluZyBpcyBlbm91Z2gpIHRvIERXT1JELg0KDQpBbmQgdGhlIGZpbmFsIHJldHVybiBz
aXplIHdpbGwgYmUgdGhlIHRoZSBhIG11bHRpcGxlIG9mIERXT1JELg0KDQpXb3VsZCBpdCBiZSBt
b3JlIHJlYWRhYmxlPw0KDQovKiBQYWQgdG8gRFdPUkQgaWYgY2Fubm90IGNvbWJpbmUuIEFsaWdu
X3NpemUgcmVwcmVzZW50cw0KICogdGhlIGZpbmFsIHNpemUgdG8gYmUgdXNlZCBieSBBY2NFQ04g
b3B0aW9ucy4NCiAqICs9PT09PT0rPT09PT09PT09PT09PSs9PT09PT09PT09PT09PT09PT09PSs9
PT09PT09PT09PT0rDQogKiB8IHNpemUgfCBzaXplIGV4Y2VlZCB8IG1heF9jb21iaW5lX3Nhdmlu
ZyB8IGFsaWduX3NpemUgfA0KICogfCAgICAgIHwgICAgRFdPUkQgICAgfCAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgIHwNCiAqICs9PT09PT0rPT09PT09PT09PT09PSs9PT09PT09PT09
PT09PT09PT09PSs9PT09PT09PT09PT0rDQogKiB8ICAgMiAgfCAgICAgICAyICAgICB8ICAgICAg
ICAgPCAyICAgICAgICB8ICAgICAgNCAgICAgfA0KICogfCAgIDIgIHwgICAgICAgMiAgICAgfCAg
ICAgICAgID49MiAgICAgICAgfCAgICAgIDAgICAgIHwNCiAqIHwgICA1ICB8ICAgICAgIDEgICAg
IHwgICAgICAgICA8IDEgICAgICAgIHwgICAgICA4ICAgICB8DQogKiB8ICAgNSAgfCAgICAgICAx
ICAgICB8ICAgICAgICAgPj0xICAgICAgICB8ICAgICAgNCAgICAgfA0KICogfCAgIDggIHwgICAg
ICAgMCAgICAgfCAgICAgICAgIEFueSAgICAgICAgfCAgICAgIDggICAgIHwNCiAqIHwgIDExICB8
ICAgICAgIDMgICAgIHwgICAgICAgICA8IDMgICAgICAgIHwgICAgIDEyICAgICB8DQogKiB8ICAx
MSAgfCAgICAgICAzICAgICB8ICAgICAgICAgPj0zICAgICAgICB8ICAgICAgOCAgICAgfA0KICog
Kz09PT09PSs9PT09PT09PT09PT09Kz09PT09PT09PT09PT09PT09PT09Kz09PT09PT09PT09PSsN
CiAqLw0KaWYgKChzaXplICYgMHgzKSA+IG1heF9jb21iaW5lX3NhdmluZykNCiAgICAgICAgYWxp
Z25fc2l6ZSA9IEFMSUdOKHNpemUsIDQpOw0KZWxzZQ0KICAgICAgICBhbGlnbl9zaXplID0gQUxJ
R05fRE9XTihzaXplLCA0KTsNCg0KaWYgKHJlbWFpbmluZyA+PSBhbGlnbl9zaXplKSB7DQogICAg
ICAgIHNpemUgPSBhbGlnbl9zaXplOw0KICAgICAgICBicmVhazsNCn0NCg==

