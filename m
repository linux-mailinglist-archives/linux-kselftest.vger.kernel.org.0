Return-Path: <linux-kselftest+bounces-43122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EDBD8B7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2F3B4F9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3152F28F0;
	Tue, 14 Oct 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U61sEmKt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cgUXFiBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9B2EAD10;
	Tue, 14 Oct 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437186; cv=fail; b=qjT9P1UXMjEeWErneUbV7viOq3jQCPOu3GDgoUIBdMCDjqzcBvlXmAd0AfdU/trjj2Gi+p5tP8TZLHSXhCLm4Hf5tSRVQyV4+LLW0dgUM/NRYKp9ohfyn4hbtobjB4buniw1p6hkjMpVhtH/khHQlbJg5dxTMdLhcli8Zfdlp/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437186; c=relaxed/simple;
	bh=8YocU2mFYl2S4tusY65AhAh6irNV5cEWbFBKVpz6ShY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2cL2QDTuqLn7NZEehO3fCivmtZ6fdTYXFaRZnWlKpsTCXMVl/lMo/g0Fa85iOfWhYooEc3G/4KsAEmR5zbGB/+sv2iU+Av8ybE6CCjaSK8nvZPiczNKvAtSsazjej+5chBLf9K52ehx4yc0dMhbB+ZA4FYaRRLIDLPy6d8f7jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U61sEmKt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cgUXFiBb; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760437184; x=1791973184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8YocU2mFYl2S4tusY65AhAh6irNV5cEWbFBKVpz6ShY=;
  b=U61sEmKtCGIxzc5zrGuUdk7o529lca9D+0iCmXe37HM2YtPVj7uq8vbk
   wEvPHBdEb3wKdK1N8hVMeZgerU2doyk/fWU+Me56osoVZfJw5QaF1XPV9
   NTzXwhQ/9nztf4oNjKXqPFR4aAPifgloMsxlRlHCgf9m7/B2/MJrIx6U+
   h/uWvQ0eq4rLOknrj4b2oJJaw1Feylb0JzKGJATchi2DDArBxuC6LhNGq
   tP+Ulaegqv47CSs+eY2r1tfl5mA4xY9hjdgK+0Ma9BkhV8aDL1wtNui6X
   M8NAZhbKg18RuxhulR7HFHv7c05fNPExtdABx63aJugXmXCYDn9JP2/Kx
   Q==;
X-CSE-ConnectionGUID: 3h3VArqDR+WC+EBTv4NDCw==
X-CSE-MsgGUID: 9cuUcsrJTAKs9+TxUfJitQ==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="134409112"
Received: from mail-northcentralusazon11012040.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 18:19:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAfmJ6xGPAeFNux3zzq+wqIZAdMBng+f/WbaY6MUH8iw23hp54g021eELlRJvfoZLsu4NXAz1TFgNHnuMeziwAaCYf5ZovcMIxN0s2OYxI2Jkgjx4w7BBXe57M87A/bIJhqqv+zi0xXYi3Vq6KE1uUfZ1/AJbc16c9gWGshN95Ef5p8Kxx9slKnlsfe8f/6wHTZrmOPjQOEpc+Id8b/t0pvPDP9NGJBuSUtL83T4kajV3uCkO1YYbeT0IB/akjHL3MT5oK1QJOCs3TTiWFbrWLI8RKLhIAlvmZxoYpfNidyP/ZOuOGA5E+4DgdVux0mgGGpz4Ze9VSvLJ3Z6jG6DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YocU2mFYl2S4tusY65AhAh6irNV5cEWbFBKVpz6ShY=;
 b=oU4/IZdndP6njSEKYG7clHUrbUmOJNQBH/rPVZXeXzgzi7OV0HgjJQQ5u6PpVFiU0RCOnLItN5+EksA1c2XoOvpHNXSr9zdzYKgXSHGi36hnMuNQovE4yqW3NIGMxC3GNE928fI2yBkfr0NyFzTJoGB6Q5VaNXXQuwWSNNLKpITQaHNg/eCIu5yBajtQ4pnd8esU6MZgJnTIe6Frbx/7l95uHjOxlVU5YzRCMnD6Y+25KDrCCAQBSY884Q0JnOF/lYnSyCSVZUIGXrV0Y8Ha/l7tYR4AV73atVlY19LGMJ8kthomyf0Im9KtEDprWfyMEI7jMsRcCLsISRJrOWRVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YocU2mFYl2S4tusY65AhAh6irNV5cEWbFBKVpz6ShY=;
 b=cgUXFiBbjQGhBBc+AcNRtqE/8uJ7h0ELhD9+qKGn0NLqp6clwgog1z14bAUU1wcM23RayOh6XmdMBtq3oMOyqNsC7wQqH+JB0QwGUt+ZIPeGBWzwqb93/seisvr5Jpt1ToZMv4itAFEX7bcuHsmAeJHaxlBZaVRSphhDnIEMwgU=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH0PR04MB7174.namprd04.prod.outlook.com (2603:10b6:510:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 10:19:33 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:19:32 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "shuah@kernel.org"
	<shuah@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 1/2] net/tls: support setting the maximum
 payload size
Thread-Topic: [PATCH net-next v5 1/2] net/tls: support setting the maximum
 payload size
Thread-Index: AQHcPMoKd3BQId17u0WsWja3lDuxtbTBbnqA
Date: Tue, 14 Oct 2025 10:19:32 +0000
Message-ID: <bb9d7860505a852b6349581e266f53c9752df7ad.camel@wdc.com>
References: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
In-Reply-To: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH0PR04MB7174:EE_
x-ms-office365-filtering-correlation-id: 5a1ab415-8437-459c-e3ca-08de0b0b2b1a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzJMRFEyQjBocHdxK01YUW5KWlNaVllVNlhxOUNsWW5jTTdKVlgzSGlNc2dw?=
 =?utf-8?B?RWJKRmNwN3FIRzEvVVQvV2hNcnBkMEkxaVo5QjkwS2lQQ3J1cTlncmJUcGdw?=
 =?utf-8?B?Mk51QUZONUphbmNOTzNZL1BQSTIwL1ZFU0dOTS9pTG85L1ZwVDRpZlorSjJT?=
 =?utf-8?B?eGdmUjFjQ0ZqYTBOc2ZIakJ4d3k1dXIybVh6bk83M094MWppNElqb1MrVFV0?=
 =?utf-8?B?NU1zeFZiaWI0OUV2M2pETEh1dWRxUDFzd09aNGtUbUxzM1lrclJreVlmeDE0?=
 =?utf-8?B?cUF5WE01U1QxRHAxeUdTVXdTY0taYTczMktoTDFwWXhqY1daR3NFcU1ldGwx?=
 =?utf-8?B?RkhHS2pOeDB4ZlhIV2czaTIrOG9UZm5pRG5ZQXpMK3JOZk5BbHVodExYRXdS?=
 =?utf-8?B?b0dualJRWHVPbk1taEhJWmZCNVBrVWhiM0x2SVBwYkNxd1ZyTWg2UFpFK0p3?=
 =?utf-8?B?UkxpaHpLWXp3c1JSOXBXaS9OWFhiczVSRFpYeGR0R2RKa1FvR3dOdGRCTzRu?=
 =?utf-8?B?cWNoR3NjN2tVQnJIQXo3TVhqSEhDMWYvRWxONnZVa0lsUVJPRFU2TSt4SWdC?=
 =?utf-8?B?dXl3SG8xcU9iQmZWWXlqV2hERDRUM21JZURPYVZaemo5aGZlOUprRWY5dHh3?=
 =?utf-8?B?NThFNGl0VHZuM05PUFZZajgralZqL3lOd1ZJemc3d1NmUG12WnBHSEdtTzFh?=
 =?utf-8?B?K1lyYVBZNWM2WXdNOWtMdm15STJDVnA5b3VkRDJTR0E5ZXlIbEUvS095RGto?=
 =?utf-8?B?VjhXbFRaWm5kSll6SVhqMnhJVWxoSitVeklPVmdMR0hNVzlLK3BzVTZmd21B?=
 =?utf-8?B?Y1JNdzF2RkRLYzV1c1F1Z0tHbGFHVGs2RkZ0TC9UMW5zUkcycmRtWDd0QWNu?=
 =?utf-8?B?Q0E4aHVjdmRkSFlYcjBaeTNKT1JvdlpHamFicXA1RmlJa0hjNmZPS0x5Q1BZ?=
 =?utf-8?B?OVZqSXlUWkpTSUV5aVJsQlRIcmgxTlJqenJWVTdMb0puaG9qRFBieTAwNDB1?=
 =?utf-8?B?cEkrcmxnV2pmU2YzSmdsbTMxTEtSN2Mva2FTc0VyK3I0V1JKY0x4MDA0ei9q?=
 =?utf-8?B?Y1FROW5kR3h1Y3VBdEFYeTJYdWtWMkJEVWpNOE1pUnV5dGc3QmVYWmdnblVr?=
 =?utf-8?B?MVV6eUlMa3ZMOHdJc09QSHpiVDUyeUQ0RlJkRWxwWDlTVGdhMHNxeVFGNUtu?=
 =?utf-8?B?WElTMzJJVlJ0b3g5dTQvcU14Tm5UMjRjM3JuWmlFL0wzM213WUduMURLaldD?=
 =?utf-8?B?Y1htUHdabWZwZEdOT2o5NWdiZzFWUnFseW9rc2IzWmdvTXR4VEdMQkxjZEM4?=
 =?utf-8?B?NTBkUjNlZW9kNG1La1daRE9PSndKK0MrSzVEUUtmMGVXT1BueDExanRZa1dR?=
 =?utf-8?B?bmg4ZFVwSlhyREhRNnRuVDZjalJOdno3aHh0ODhnSDdsdUgwQlRjbUpKWnA2?=
 =?utf-8?B?NVphSGU5RWdMSG0rckl5NC9sQkhzSW51NXNlckFWNlNlYzc0OU9vMFVMWWRk?=
 =?utf-8?B?bDFvNHlVUlNlMmorL0F0M3hsS3Blek9neWF5T1dXZFdLRGhPbjdMR3NTTktk?=
 =?utf-8?B?R3dqR0VWaFFZWjdadWk2MnE0T2RweDdFWitQdm5iSTF5SmovVWk2R2o4TDFw?=
 =?utf-8?B?WWtzdnNjMnRMYVdITGlVZi9mZXRWcUFNdU9od21GQUd5VjZ0VDdSODA5NWdX?=
 =?utf-8?B?c09vT29lM2s0M2U0LzJkQVlEZW94cXBSV092U2ZnZ0c5dzRMQjJnNy9nai9q?=
 =?utf-8?B?cFdaa1ptRnV4c1VHTDg1SCtxS3VBR3ZQSjV6N0tFelo4c1MzcXVWcWVaRVgy?=
 =?utf-8?B?VFQvdjBPaHJwdEkvclJueEpxTmlnRk83ck5tT3dlVkdVSjBHcDAzVFJ0TUpW?=
 =?utf-8?B?WFc5Z3pkMWRQemNSclgzNnRMTWplM051U0pRemt2cVB1ZzZPOS9JcTlhY2h6?=
 =?utf-8?B?WW1lMURKK3JCRkZZWlZwK0xRNXNpQy9RQXBxcWFlSEtnbnQrSTVpUFhhU0FI?=
 =?utf-8?B?OGdDWVZMZ3U5WGNZd2RraThqSTNYbjA4dm5adHNXY1pUd1pGMnhnWTV0aUNS?=
 =?utf-8?Q?f/5PaD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjVubnp1cDc2Z1ZLUkgrdWFlZjJuNTF4cWNjV25tSDd6bjdaUGJFdGF6dUxI?=
 =?utf-8?B?MHd3Wm9GL1E2UnQ0SmM2c0hDeTlBZm96OUVjUUNUNUtZaUFjWFV4WEFaemR4?=
 =?utf-8?B?dDFLWFJONUdwdVpDTklMVmVQOGtSbTlXOGdFN3ZkYlB5aFFGcFRIbzhKV2R1?=
 =?utf-8?B?UnE2dmRRQSs0eEhOb1Evc2NscHA5dmFBRmVMWjdwVEo3LzdobG1EUm5rVUxX?=
 =?utf-8?B?TmNXa1BGRlI2T1JJZ1oyWWJBdGlwZWN1TG1IZkJDWEswR2tTbk9hazVmQTFp?=
 =?utf-8?B?ZUdTT2Y2MlpJc1NhdE1zbWJ5WGQ5K0t2b2RKYnBDYU5FTW8rQ0pvMmJ6QXhn?=
 =?utf-8?B?RWFnaTNMTDJzeUV1Vm1BT0szc3dnUU5vRndpVFJPMElzMUxSWlZFZ2tyTnEr?=
 =?utf-8?B?WDY2S0hBekY0c2JQOStJR00vRTZJQzRUbEJiKzBkOU5KY0JZMnE1djdBWEdo?=
 =?utf-8?B?OFgzaU9Oa1NyKzFva0V5dGYxUHpndi9mL0M4RzdBcHZEdEtiSThZYk5YczJK?=
 =?utf-8?B?NDk2Zm5wYjlRNEVDUXdJM3BzUURPcmpJMjJiaFVLMHNyRlBZRjRrTWhBRlVM?=
 =?utf-8?B?TzFOWmY1MVozOTNTOXdUdWU0ZitEcTNlWCt5VFlVYlZvZGFSQlZXYUsvdlRZ?=
 =?utf-8?B?VVF0b3RsQUFPYW1yc2wxQlppUkVSWnFEUFIxUjIrazk1K2JIeDUycTBZeldB?=
 =?utf-8?B?alprWi91TDZQcEMrWmtXMnZINnRiR0FmcDJ6OHhjVllid2p6bjdiVGNnQmFN?=
 =?utf-8?B?elNoT0hObVdUL3RWRythWGlRRnkvdW5CQ1dTTGVqczNkNkdBTmVDN29GdlJs?=
 =?utf-8?B?MzNXWCsyb1d3UVRQVXNaV3IxcmFnSS81WDNGR1pmZTNkOThscVJGRVNVK0RE?=
 =?utf-8?B?MEptN0FkdlA2eTNZTURMNk43M2Q1YXVJZ2lFeHF2ODNmRHdTZmxIemk5elhO?=
 =?utf-8?B?dWRMVkl1UWswZFZKbFQ3SUc2UHA1UFZxczN3eVRXK1VhTDYzVVd2aFF2SWly?=
 =?utf-8?B?NUV5YjFlZ3FFZnZqWkJNWkRCZDdMNVJqMkJsQ2t6NGtsdHFtOEhMN1FFTWpF?=
 =?utf-8?B?Wkl1VmlqUUpUamZnOXo4YW5XWmJGUmVpelNPZnd1c2dwMzRtRk95T25tVzRi?=
 =?utf-8?B?bnJTS1RkSkZiNEwvWEgwYnpkRE9palpyWkRodEl2TzVxY0JhNE5Zb0JCd1E2?=
 =?utf-8?B?K2NNUEFwemFFK1JLVFhvRXJMNjVveXJ4V3YxUlkwR3RuQlRNd29MdEFmbE9H?=
 =?utf-8?B?bDRGOHR5azZKbGFhUmJRbmpJVzVhWXhRNWRFSU9nZW9aZ3Zlb1BHWU9MMjU0?=
 =?utf-8?B?MzFkcEt3Y2hTZGVMci9XZldsZFd5WFhJT28vUnF4M3pWMUg3dXpwRGlzSHVZ?=
 =?utf-8?B?UXhyOEFCMER5NVJRRWh3dWJTS0lBSG1nR2QySWFVL2JLRTIyeDhWVUgzdllX?=
 =?utf-8?B?T1pNcktpNXlDODBJUzE5RS9iTy8vSWJZTStvRnZ3YVVIYlBIZUFydFBjRGpN?=
 =?utf-8?B?Tzgyd1NEUThmdFkzSVpyVm1zQzI3ZExUQXRqVkdFWS9OOHR0QUxqTisvVTFx?=
 =?utf-8?B?ZHBWakRrRnJOQWg1Qk1zVEtWQ3RKUE81SHNQWldwYXRWRVRVTVdIeU04ejUv?=
 =?utf-8?B?TFo3U01qUGhXRC9kSHgreDFtSHdYM0d1dkV0Q1Y2Z2NPelp1MTJWVUxTNmVx?=
 =?utf-8?B?cHk0RjNaZm1Xa3h1UEY1bFpsZDNkRkJaOWRlQ2dnNnM2YitxajAvUW80RVZ4?=
 =?utf-8?B?VFVpMWRYdFdFem51Y3Q4WXVxZjIrVDUxWklHTWd4ZDlqOHdBRnh3dENsRmdP?=
 =?utf-8?B?NVJJZmRFNGZXU2JuUTdiUURIQXJnVWtVQnMvcFlKTEZMVEE3SXY0Vi93YWRL?=
 =?utf-8?B?Zmw3cmdhNlFIU3hYNDR4UER5THl4aE8rVzFaMUFSdWFKTlpFU3BMNWtiUGc5?=
 =?utf-8?B?b2x1L2s3Q2JlYjU4bzJyK0V5OWNQSEVNVmRVYmthczlPSGV3a0ZCMkFGR0p3?=
 =?utf-8?B?d3VUMW9jYzE0bXVCZmdhNVVISW9vTmRNb0c0cDIyb1BrbEgxMGE1NWhDZzJC?=
 =?utf-8?B?b3JqYi9YT0IrZWswRFg4MWxTZU5wRzlyZnh2Mnd6MUpYdXRBSWhidWtuV1o5?=
 =?utf-8?B?N2JwQ29aNzUrZlNINTliN3NlTmVDamZuYzlJNFIwV0NjdE9heHY2R0RuVk9Q?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E21265B60D362F43989B8EEB6F124EA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3UeZOvqBYPk2RUWahnBlAtyCmEZmDdXe8qmR3rSV8OfI2UiOu9tl00yscyhMcXVjgTi6fdQ/Ds6FmADkMevvOMlYJ9U183hp5XPI3FGoHNQrDGbovCHtSDCOPp2t8fZttI3eclaH644f+MjUrZ8y+RCwJiInA/U+eFeUnNVoSca6qwe1TSVS6nw8MOzPueLXqlb4S9Viwrspuwr+brwrOkkrmTwty7A/t+tMNY/QeRnGRdYG8KUqewXzFYmWbYzZGqK9TIa7gAKgsl0pB0RmebyfMg+oyQJrI/gF0Fwvfh8hqeIsELrgFdmF83qWEOr1lP9rBlz8Xo9cA9XVFEjIxBtgICHJ0sg2DRTR/QyvLhgVnSihP05uXEvI4D254wrC1ATx5ij88jlVY9qxNEyaXYs4FTYs+EkUBw9vp1FaC4RM5f4L1GyzXvinKu3szRJSn0RiQHpuSuO5IdMN2mXAEvVajKYZvSn9/6L5SHHlMJbdswqChcs3zDBsPHDeKA6KX4LZO1jjsZuHMviBXPkbLp1mA0OKw7d4wxJEyTzOmwBmhxnWNQ3J7a8GuBn/myxk7n9lEx6GsA+BpLDIRFmFkIy05SUq/twpfT4+O0Lx71kVDz8uPzlqitsK5vGIr03/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1ab415-8437-459c-e3ca-08de0b0b2b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 10:19:32.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8U6Rt7088E0yE+RUi+Z2yKWFJG00wKV9jBX4rq7Zk2sampprjnjCSDpUHnz17nHzErVJVym6AiuqlySGedWMYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7174

T24gVHVlLCAyMDI1LTEwLTE0IGF0IDE1OjE4ICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQo+ICtzdGF0aWMgaW50IGRvX3Rsc19zZXRzb2Nrb3B0X3R4X3BheWxvYWRfbGVuKHN0cnVjdCBz
b2NrICpzaywNCj4gc29ja3B0cl90IG9wdHZhbCwNCj4gKwkJCQkJwqDCoMKgIHVuc2lnbmVkIGlu
dCBvcHRsZW4pDQo+ICt7DQo+ICsJc3RydWN0IHRsc19jb250ZXh0ICpjdHggPSB0bHNfZ2V0X2N0
eChzayk7DQo+ICsJc3RydWN0IHRsc19zd19jb250ZXh0X3R4ICpzd19jdHggPSB0bHNfc3dfY3R4
X3R4KGN0eCk7DQo+ICsJdTE2IHZhbHVlOw0KPiArDQo+ICsJaWYgKHN3X2N0eC0+b3Blbl9yZWMp
DQo+ICsJCXJldHVybiAtRUJVU1k7DQpMb29rcyBsaWtlIHN5emJvdCBmb3VuZCBhIGJ1ZyBoZXJl
LCBzd19jdHggY2FuIGJlIE5VTEwuIFdpbGwgZml4dXAgZm9yDQpWNS4NCg0KV2lsZnJlZA0K

