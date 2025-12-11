Return-Path: <linux-kselftest+bounces-47416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67FCB663E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD86C30019D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5643128CA;
	Thu, 11 Dec 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="I+8jMHGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1176156C6A;
	Thu, 11 Dec 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468453; cv=fail; b=eqWdGJbZrxUETVuxok+axVCBwYYpz6OgIBKfA7x+C+TEtELJ4NVfrol0Ir7w58bOfYkFeFFWPTVoE5EcnKKecL/vbSeNKh08PX4c0LJ6j1OQrrJndnEFBHf/CyuASvlJmppkqLN2NZKOES1NNGFzRmDNO8DyrIAaZ3Wqip+RIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468453; c=relaxed/simple;
	bh=L7NCXfAtatyGbUo2e6GPUB18o6lKHtaFoLTrkms9GRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAuzou3v5DS5h188oTdR0aTrQXMI+2Bc/ac4U78OYpy1/v2gf36Cd6qknlUoWAIEI+rXF0Qg2xNzPNSLivezgps4yc+StJ0aUIvCXnC8CElcclo52vzLWHMoHN0DB2g888LTm1lO8P41jYaVsI4xYltbfpmuVM1jg+76NqwbsnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=I+8jMHGk; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJhs24E7Fs1XFNR1MIxfl4Pond1tL1AWtBcWgBHwrEsIxoXoqiUIG8VAaD3OJ+JcNrORrSni+4pQTqiXX5grvxumds8ZArHItRAYE7aJPrPURNJcxqJ/Upey3r3Lj7ULI/skp4v8CXKXe8Iz8XgzVqxSHpzup/sq7ZRTiv3ARPc36mRQRoBIAAtS3OeCFVdlWKISstq5PTrEn8IGmc/qzXQlksyKaZfcm7ExwaRoMxuc9AwoGCtCYQcsubl7KNDQgECvV0iOzFJ9YTgqoVjv2b2dn2sCSeJQcsjCI6wGjGZjNMY5n7PY3mPSv3InaAZKdy9xJcimOTNEhVS7zRPxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7NCXfAtatyGbUo2e6GPUB18o6lKHtaFoLTrkms9GRU=;
 b=Bv2wqUZg3FT55mvWcr0949HXTj6yoxDyyeK+mMlm0dVqEuaQFyFzJBWp0jF6gdASLRblcOlz/Y/1K/qMHT4Xpnnhb6+Czd2e93gaV+2KUVZ9n2UtMnBTfKaUNQRXLUqFM0k0Y+MEiang0VFuzhW+win0gJfk0rqwwYsNZAkCcACwGjJGs5VqCyWDBGiT6M2ldImaCHxLCd2h4NPJRESeZT/d9zIOFQ3tiyKgIOZ79TvXqJWbGS21rTZMzt5jSmmJqtIcjuklRRvMU7aDqfb6pH0BY5q/qEvjT/wmLAacWGLE0zUuTac+w73rw3YSfZqQvhpIq0yBU5rXbmej75npLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7NCXfAtatyGbUo2e6GPUB18o6lKHtaFoLTrkms9GRU=;
 b=I+8jMHGklg1QsBFLTtQMjRzseEdAilIpjnkx3UnKiQyNzdjdTPYjJ+WcaL3jHM8JOqFthGnJWBnyN5+b8Tz/kckJN6S4pzfS4AbPZs3zC9/bKrCD4b952gAFJil0ISrEuYgfII+Ajx4LKBrhqlBhSaXRxQ7sndvcwXfQF1qMwqRdP+eVAb/sfQouGDmjXtTzKwywiZ2KomXs8b65QiYHrp5HB8y0uNQGrZxS6s2Itp9M0xhFLRZKOM8CFuJ/tVliG090RAmgfo6RRwDmSqj7Qf3qSQGqxmY4RDf/djkX9QgLjxBKi1VB1OIICvGStu9kSvgwaAs6JkQMDi3zfx020Q==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DBAPR07MB6599.eurprd07.prod.outlook.com (2603:10a6:10:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 15:54:03 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:54:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Topic: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Index: AQHcYuDnAkZQ3dLXvUiWBzqJfhG5VLUNaB+AgAK+PQCADICa8A==
Date: Thu, 11 Dec 2025 15:54:03 +0000
Message-ID:
 <PAXPR07MB7984E9187E12AA253F3C2DF7A3A1A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
 <20251201150509.6cd9fefc@kernel.org>
 <CADVnQynFTrWf_waxGPH6VVPSZapSuxUb6LFdFUGj0NfiADAa7Q@mail.gmail.com>
In-Reply-To:
 <CADVnQynFTrWf_waxGPH6VVPSZapSuxUb6LFdFUGj0NfiADAa7Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DBAPR07MB6599:EE_
x-ms-office365-filtering-correlation-id: 2c80e46e-8ce2-4fb6-8ff2-08de38cd81e6
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmk1Ym84T3pGUlBrNklnRi9GTk9NTnFDdkFTeFZYWXBPMk5WRkFMQis0SFlo?=
 =?utf-8?B?bjdaYjN1ZXdIb3djb3J1L1pIVWdmQndwd1U4T0c4TWdOblcxaHBYMk9lRHlD?=
 =?utf-8?B?TllZbzBaTHcwSk5RWUpjcGZGZlkrMmJjbC93NmRPYnFEMmloTkRQTXpsbTYx?=
 =?utf-8?B?OWdFWVhWdTVvU2VpZUNXSy9FSHJRMEZvY1NRSDF1ZU9FOTlpc1E0M2pWYWZP?=
 =?utf-8?B?VG1qamJKeXJPcG4wWmw4b2R5KzFpemllaWZkTS9EOGYya2FPL2lRdG5Eam12?=
 =?utf-8?B?RDJCd1loNlV5ZjRzQnhldEhTYXJCVklwQUV0UWxCOTkxQ1U2WWIyQzhVVEJU?=
 =?utf-8?B?WGlMWVYwUE53YzFkcWFZUkU5V0tIb2Jud1ZjLzhPb01Hb1M4ZVY0VmZzeUl0?=
 =?utf-8?B?TU1EYXFSdU5OUGhIc3VKK3Y4ZWdjSytRa3Q5cVgwQ3hOWlhBZHBXbk5vUXRS?=
 =?utf-8?B?bXF6UkVCZDdsSWpERVM0SlN3N3Q4ekhiQkQ5VWZRQ1pOT2o1ejBrWkZ5TFRM?=
 =?utf-8?B?SUNVY3plQWZMZlI0bG03NUhpcmNKSCtKVGMwcWxKaDRvR0I2M1d6SmNrY0hk?=
 =?utf-8?B?Nit4ODVVLzBGazZUV2Zua1l0eHpIN1V3TGdDemVMNlRFV1hrTkJWSjNOR2Zm?=
 =?utf-8?B?RWgybXdHYmY3YUd3WUlUV0FiL2RnQzdaTHZmTzJna3Rac3pmOTVaR0ZwUGZB?=
 =?utf-8?B?akZ3K0V6U0tYUEl1bVpjMkxWeXd2RHF4ZHQva2I1a1hUY2ZyQjlDbUxheGZ5?=
 =?utf-8?B?MkRYN2ZaWFphK203d3VKQU5pTys3UzVNM0d1VjVORjZ2Sit1a1pENXFnUEdn?=
 =?utf-8?B?L0FWbjlwWUQrZk8zTVV5MWN2UnEyamZRT0R4eGIyZ1FvNjkwS1EvclRjK3Fo?=
 =?utf-8?B?Q0k2b2FoNlh2ZDZYMDJTRGw5eTNnQUpmZ1hQdFBsWXI3LzN2a2FGQ09VQ2Rs?=
 =?utf-8?B?Tll2QmJuejdBcG1ab2pBZHBlVTF4SnRleUp1WW1HZ1RRSk4xTDliQ0VQY1ZG?=
 =?utf-8?B?cldCTHhiSjFxVWJPSGhDcmdrWUVyTUw1MGErdEcxYkxIVCtzcDRyUVJhK2ls?=
 =?utf-8?B?dUExMSsyY3MzRmdHY2F1bDlEUFduWkZ5Y1djdk5yd1IrTXBDWDJ4ZGpmMS9M?=
 =?utf-8?B?OENjQU54TlV3MWNIbllkRkNkaGc4dFh1SnFxeTFUNXpIeFpYVVM3R0tCclZa?=
 =?utf-8?B?cEFuWHdUS0lPK1NUN25rYWFEWWh3cUx1UDFPSGZlRWwrZEhpaHlWVHFsdjYx?=
 =?utf-8?B?ckdCS1luTkhVS1RPR2RBanBZL0hjM1RGaW9aYUlmQTRQN21ERmkxejFlL0hn?=
 =?utf-8?B?UUE4RGhlVS9IbXBaQkdFT1pGNElwL0k3TTV1TnlTYUNNNStIZGVsamp4ZXFW?=
 =?utf-8?B?Mjg2Zm9ybEdlak5YNXM4VG03endSVG5wdHlXSnl0VGljQms0K094d0RPS2lY?=
 =?utf-8?B?UndISE9ZSUlKS0hqWHk5NERTeThTMndzT0JuSG5MRHVNSnIzd0Nzbkd4eFBn?=
 =?utf-8?B?U1JXV2ROd1U3Y2Y2UEE2QUpSMncybVo2bXgwLzNGM2xRSUk4Um44N0tMNlRw?=
 =?utf-8?B?SFpNTTZsb1hBckp4aGNRTjVMaUYyeEd1bXZpZk10VFdNNEZCZFVOSWZmOUZl?=
 =?utf-8?B?VW5zVWFKR3ozYjBCYnJoZkNFQmJ1dzU0ZnhLdkFaYmpKR0k0dmtYNEszUzRw?=
 =?utf-8?B?clJ2a1RLNXNiczBsajJadjRCU2w3UHE5MTBPcC9tVlczbVMzWFozSnhzU3VW?=
 =?utf-8?B?TW9kcWFNaCtGbnp2b3h1QnJOL0lCWDhGVElaTXNObndMbllUVDcrKzVBTFpR?=
 =?utf-8?B?Vm1EalZad0JWM2pmYUVPd2xhSTB3a2hTQlNOaFhRMTlpeWRMcDZBMGFQemE4?=
 =?utf-8?B?TFZHTEQvT3ZIcGhXZk5MeVQ1K3NRRzFob3UwdlNWcHJ5eUk5eTkzTitEakFl?=
 =?utf-8?B?bUVWZklESEdBZmlYV2JNUGh1Uk9SeEE0c2c2REdmTTU1ek9zTXRHOW9JanV1?=
 =?utf-8?B?ZUQvbDdzb21jSDM3MVJWWWV2UVUrcGNkM3h3Vno0U3JidmxYaEN1Smh2M29X?=
 =?utf-8?Q?subhJp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEQzQTVRMlpCZTZ0c044WkFKVkhEM0ViSFB4UDgwRllaZ05WeDF1ZS94ZnNN?=
 =?utf-8?B?akpwc1FJTEdDczR0K09sZmFGN2tyYUxFVHZqUkh0MnlDUldPRGlxTFNldk83?=
 =?utf-8?B?OG1oVmFjYi9kZUYxUWQ4WU5reXRRbGUvSUFYTUwzYXkzRm8xaWxERUhIZVEz?=
 =?utf-8?B?VjIyQkd0c0hKTy92UER4K0RKelo2M2o2WloxaHE3ZDFYY3hWNWV5bmRFZFND?=
 =?utf-8?B?V25BUm8wd2ZXQlFGd0pHZTNnNWtsaTNJUGxLQ09HSE1od1B1V3UxbVlGcCt4?=
 =?utf-8?B?Nk9mOTZ3TW5uWWhUZjFZK3RqQlF2b3UxYUdob0txa0REYWNMcUtPNy82YU13?=
 =?utf-8?B?dFFwTjBUQWNNVkVEaGdMdzhTMzh6Nkl2WmRsODlaZkhDZmM3OG9aUDlCVm5s?=
 =?utf-8?B?citTeWlUeUpaeVAzOWMvR1dIeXFZSTNsc3FsWUg4dW5hTGhMVE5HMDNEc3JT?=
 =?utf-8?B?WG96RE1mcUVKYUJBTGh0OFhVOWp3YWZicDYyeU4rK0lFRUNaalpwNHozL25v?=
 =?utf-8?B?NWZMVlFsYUFKaXA5R1UyWnZqY1ZjNFk3MmRCeVZOU0ZVQ1lJcnluT1BZcWVz?=
 =?utf-8?B?dnFlWDhuQ0xoR09JR0Q4UWVNaGx4Qkt2VkE4SngvQS9QN2t3YWE0dzQza3lJ?=
 =?utf-8?B?bzlKMmt2bnZhMXV6SkNHNmIxc2ZHQ045NHEzOXlKT3libnZHa3doOURoUHNt?=
 =?utf-8?B?MzhKRHNTVkVUU2RKZzFwaFA1T3NQNFJqUHlNRzRGNDZIL1o2U3BnNFRVUVRm?=
 =?utf-8?B?Q0s5azNMZkZxc29CSU5JKzQrOUVpOW90M0d6cmdYc0ppUmpMWm4zK3lJNmpk?=
 =?utf-8?B?ZSs4VmFnRFFCT2tJM2gxbmw5SHM3Mm9ycU0zZExFTXczUk9sMEliM0JWN2NE?=
 =?utf-8?B?UFRRTS9zNnJNVVJGRnlzYVpabmFkUER3U3N0ZElWWVNaQ2xqLzUyYXJ4bWcw?=
 =?utf-8?B?d2UxcUJzU29mMHVhYkRRak43WlFNUmRZM3JmMGJicm1ZekhXOVIrbUNHMVl0?=
 =?utf-8?B?MXpLd1Y1V2s2YW1Fd0hFRVlqOE9JbHRpZjMxejlnSkx3a0ZGbjVESTMvdVNv?=
 =?utf-8?B?MVNvdDJlU0YzY0YydVJaMjNLMnFWSjJNNkRmYUpWbkhmczFmQk9ZODFHdEJ4?=
 =?utf-8?B?emNGck5oYUVKVXdUai9JUWpBSHBaL1NPMlJ5SWRpc1NiRUFXTDBkdlVNNkRN?=
 =?utf-8?B?QVZrUjV0ZUU0WkFIeFM0Rko4b3JpVkxUUERpV3E4RVJzemZWVE13S0VJa2Js?=
 =?utf-8?B?NU5yaFZ1Q0tiQUtZbXIyTHhqVlM3NUgreHg4OXFIU2FVcVpwbHY4L0lHUDVO?=
 =?utf-8?B?ZmdXRDJ3VDRiQkd3SEhPZ1p3eHV3NksreTdiWVBkQmFIR2ZkN29Xb1ZFWlRH?=
 =?utf-8?B?Y2ZYOURHYk95dHlMWThwWmdUTTFxSkRocm1QaGd3QmdINmlnQmVQSE50ZGpC?=
 =?utf-8?B?Yko1U0Y3bFBMcWFmb1g1elNsNHNQSlN2b3NKbEwydkZiNG42bkN2WndRRy9n?=
 =?utf-8?B?TGlubmlmOEd3RjQrTFRRUkl6WmNqOWN3cE5VOXlhZ01zWHVDSS9vWW5ZSnY1?=
 =?utf-8?B?aHhNTGhLQjVFZXVUNTBFRjE4RThET2pYZnRKaUpSWTZKZHRvVUdKZ01kMW1x?=
 =?utf-8?B?QldwQ1I5amQ4eDZZNDY2RFFTUGV6UWE5N1huWWdiUG1wZmJuZDdtOWZVVE9t?=
 =?utf-8?B?ZXlsZ3NhQmExaTFZWnMvMTA1VlZDMHU4NHRoZGdwR2M3d0hCUldGb3VYM24w?=
 =?utf-8?B?NlY1aXk4V0cyS2RFdTI4WmZyczAvSEJObnBNa0cxMnI3QTYzY2xmM1IzQUo0?=
 =?utf-8?B?T1FYaDlXWXFPMjZDQVdKUld5MHlBQmRiT2lvVU13MDZyeGNpM1c1S0hvRjk2?=
 =?utf-8?B?R2wzbmd1VlBzT3RGT0RSQTlqSmlYbU53ajVIV1VEWXJZNW1Nb2dzeUlRSkhE?=
 =?utf-8?B?MFpiRjlGd05GRmVtWEZyUjdqdDBxUkU4QThqV0luc2o0ZmtscjJ6N0tvYnlF?=
 =?utf-8?B?NGlkMUFJN3BNUlRWZzdMSUJCa3pXMnpJL3pxYjYvVDZVQXczTHozWEp3N2ZK?=
 =?utf-8?B?SjdiQUJKc3I4Rm50VEtsL2VIWlFzVFRUYmVia2c4bXBTQVlPYnJBeHRzM2VB?=
 =?utf-8?B?NFhLYU1CcEQ5NUF1anREZEdsdkF4SVNFY3FiR3g1Q1FWdEwxOXYxMlRvRDdP?=
 =?utf-8?B?R0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c80e46e-8ce2-4fb6-8ff2-08de38cd81e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 15:54:03.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPM3JXIgZuLNSmjw5mNP1Vbz8WqHGR6lJ7wbjo394eMSSZYq5cf+vxgC0t5gCWPs1QhLT1I25qhLMD8ACtnBmTWzIVa4GRpzN6JPUXhUEMk0t0+zuz8M7VQxSpJvaZit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6599

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAzLCAyMDI1IDU6
NTkgUE0NCj4gVG86IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBDaGlh
LVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT47IHBh
YmVuaUByZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOyBwYXJhdkBudmlkaWEuY29tOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9y
ZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1v
amF0YXR1LmNvbTsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdt
YWlsLmNvbTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25l
dGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBs
aXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZn
ZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxr
b2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5j
b207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVy
aWNzc29uLmNvbTsgY2hlc2hpcmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0
OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBw
bGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IG5ldC1uZXh0IDAwLzEzXSBBY2NFQ04g
cHJvdG9jb2wgY2FzZSBoYW5kbGluZyBzZXJpZXMNCj4NCj4NCj4gQ0FVVElPTjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+DQo+DQo+DQo+IE9uIE1vbiwgRGVjIDEsIDIwMjUgYXQg
NjowNeKAr1BNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gTW9uLCAgMSBEZWMgMjAyNSAxNzozNzo0NyArMDEwMCBjaGlhLXl1LmNoYW5nQG5va2lh
LWJlbGwtbGFicy5jb20NCj4gPiB3cm90ZToNCj4gPiA+IFBsZXNhZSBmaW5kIHRoZSB2NyBBY2NF
Q04gY2FzZSBoYW5kbGluZyBwYXRjaCBzZXJpZXMsIHdoaWNoIGNvdmVycw0KPiA+ID4gc2V2ZXJh
bCBleGNwZXRpb25hbCBjYXNlIGhhbmRsaW5nIG9mIEFjY3VyYXRlIEVDTiBzcGVjIChSRkM5NzY4
KSwNCj4gPiA+IGFkZHMgbmV3IGlkZW50aWZpZXJzIHRvIGJlIHVzZWQgYnkgQ0MgbW9kdWxlcywg
YWRkcyBlY25fZGVsdGEgaW50bw0KPiA+ID4gcmF0ZV9zYW1wbGUsIGFuZCBrZWVwcyB0aGUgQUNF
IGNvdW50ZXIgZm9yIGNvbXB1dGF0aW9uLCBldGMuDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBz
ZXJpZXMgaXMgcGFydCBvZiB0aGUgZnVsbCBBY2NFQ04gcGF0Y2ggc2VyaWVzLCB3aGljaCBpcw0K
PiA+ID4gYXZhaWxhYmxlIGF0DQo+ID4gPiBodHRwczovL2dpLw0KPiA+ID4gdGh1Yi5jb20lMkZM
NFNUZWFtJTJGbGludXgtbmV0LW5leHQlMkZjb21taXRzJTJGdXBzdHJlYW1fbDRzdGVhbSUyRiYN
Cj4gPiA+IGRhdGE9MDUlN0MwMiU3Q2NoaWEteXUuY2hhbmclNDBub2tpYS1iZWxsLWxhYnMuY29t
JTdDMzE5NDkzMjYwOTBkNDUxDQo+ID4gPiA4MjY0NzA4ZGUzMjhkM2NlZiU3QzVkNDcxNzUxOTY3
NTQyOGQ5MTdiNzBmNDRmOTYzMGIwJTdDMCU3QzAlN0M2MzkwMA0KPiA+ID4gMzc3OTM0NjQyMTIw
OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2kN
Cj4gPiA+IEl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRV
SWpveWZRJTNEJTNEJTdDMCU3DQo+ID4gPiBDJTdDJTdDJnNkYXRhPUolMkZSNURaSjFYRnBZOXJS
bFpPeWdDaFRzcEVFbTY4elluYUExWlZZSGhyYyUzRCZyZXNlcg0KPiA+ID4gdmVkPTANCj4NCj4g
SGkgQ2hpYS1ZdSwNCj4NCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHlvdSBzdGlsbCBoYXZl
IGEgc2V0IG9mIHBhY2tldGRyaWxsIHRlc3RzIHlvdSBoYXZlIGJlZW4gdXNpbmcgdG8gdGVzdCB0
aGlzIEFjY0VDTiBwYXRjaCBzZXJpZXMuIEZvciB0aGUgTGludXggbmV0d29ya2luZyBzdGFjaywg
dGhlIHJlY2VudCBiZXN0IHByYWN0aWNlIGZvciBhIHNpZ25pZmljYW50IHBhdGNoIHNlcmllcyBs
aWtlIHRoaXMgaXMgdG8gYWRkIHBhY2tldGRyaWxsIHRlc3RzIHRvIHRoZSB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvIGRpcmVjdG9yeSBhcyBhIHNlcGFyYXRlIGNvbW1p
dCBpbiB0aGUgcGF0Y2ggc2VyaWVzLg0KPg0KPiBGb3IgYSByZWNlbnQgZXhhbXBsZSwgc2VlOg0K
Pg0KPiAgIHNlbGZ0ZXN0OiBwYWNrZXRkcmlsbDogQWRkIG1heCBSVE8gdGVzdCBmb3IgU1lOK0FD
Sy4NCj4gICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9u
ZXRkZXYvbmV0LW5leHQuZ2l0L2NvbW1pdC8/aWQ9ZmZjNTZjOTA4MTllODZkM2E4YzRlZmY2Zjgz
MTMxN2QxYzE0NzZiNg0KPg0KPiBXaGVuIHlvdSBuZXh0IHBvc3QgdGhlIEFjY0VDTiBwYXRjaCBz
ZXJpZXMgZm9yIHJldmlldywgY2FuIHlvdSBwbGVhc2UgaW5jbHVkZSBhIHBhdGNoIGF0IHRoZSBl
bmQgb2YgdGhlIHNlcmllcyB0aGF0IHBvc3RzIHlvdXIgcGFja2V0ZHJpbGwgdGVzdHMgaW4gdGhl
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wYWNrZXRkcmlsbC8gZGlyZWN0b3J5PyBJbiB0
aGUgY29tbWl0IGRlc2NyaXB0aW9uIGZvciB0aGF0IHBhdGNoLCBwbGVhc2UgaW5jbHVkZSBhIG1l
bnRpb24gb2YgdGhlIHBhY2tldGRyaWxsIFNIQTEgeW91IGFyZSB1c2luZyBhbmQgYSBsaW5rIHRv
IHRoZSBwYWNrZXRkcmlsbCBicmFuY2ggeW91IGFyZSB1c2luZywgc29tZXdoZXJlIG9uIGdpdGh1
YiBvciBzaW1pbGFyLiBUaGVuIEkgd2lsbCBsb29rIGludG8gbWVyZ2luZyBhbnkgcGFja2V0ZHJp
bGwgdG9vbCBjaGFuZ2VzIHRoYXQgeW91IGFyZSBkZXBlbmRpbmcgb24sIGlmIHRoZXJlIGFyZSBw
YWNrZXRkcmlsbCBjb21taXRzIHRoYXQgeW91IGRlcGVuZCBvbiB0aGF0IEkgaGF2ZSBub3QgbWVy
Z2VkIGludG8gcGFja2V0ZHJpbGwgeWV0Lg0KPg0KPiBUaGFua3MhDQo+IG5lYWwNCg0KSGkgTmVh
bCwNCg0KU3VyZSwgSSB3aWxsIGluY2x1ZGUgcGFja2V0ZHJpbGwgaW4gYSBzZXBhcmF0ZWQgcGF0
Y2guDQpCdXQgZG8geW91IGtub3cgd2hlbiBuZXQtbmV4dCB3aWxsIGJlIG9wZW4gZm9yIHN1Ym1p
c3Npb24/IFRoYW5rcy4NCg0KQ2hpYS1ZdQ0K

