Return-Path: <linux-kselftest+bounces-32933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE343AB6D6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085211693C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97527A905;
	Wed, 14 May 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dKYQg/qf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF0191F98;
	Wed, 14 May 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230811; cv=fail; b=mIMzHFOohD3WWOdCs8YShkWLqra/W4Pe7xktKxv3PBGsC5yNEVKseKrbrBIxwYWFJ9FOErsoDTYP4XEpcwTNmK6gjuaBx1KKcXPLzPVpRvL1SRyHfAI+tt7bPSgui7/XxRNT9BJH9NL2r0dUHwUhVXzfAKej6l9yraL6fsMaNMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230811; c=relaxed/simple;
	bh=VTm0A3pbBpZF9aun0HD9B+T44gI9RyxEiooTsl8r0EE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9kj9JfQNG16PRiKpHhJi+5B7RKbu92BUqfvgzDHQmXRnm2eZIso4FE470tCpK83A2OzZyaCNb5xRnrc6tnj1xUI5KYLifEHJCDzVqYEg00bsL27yvu421bdOm75+18RfxEzl9rmCAR42zMC6t5QEuWLAnQHMkTMhCurURdDRFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dKYQg/qf; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri75fyfMWYuH+LRDoxry0UBIIARb3Tyy9booIU0X50rgGaP+q89j5iKAmAHoa2PQkPyGdqKXLf9ezBgvBowm7VH25lKT/Hi1xh98qI7pchdCT8ZJc6bOCyZVJVjafS7FNlyMyKP98Y1OGaM8r6zOIG3V3LwMZPsE6HiSWyVj8C+DErpTcc2Wn4jv+TWUl6B0tkSxC6XTYXw61+MBkno5jBfWf7lkJPPne7o74O06Opn+ad7V3iFZLJ00UX1dq5SDwtwpJZzpOz7xTn4rMGhWzH46J6ZIQTAjOBd5QxUaK9TDzhC0NFXvpIS3QsuqBat/kLRAy9AwuBQrKYvUX4VP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTm0A3pbBpZF9aun0HD9B+T44gI9RyxEiooTsl8r0EE=;
 b=rT9R0i/UWIZ9ma7yroqnjU0vq98YXcu36Q8GFTBvZKIOS8phGvpU7Q/6TTgCD2bCHoknobCly1G1Yvug8umfXbW6Gz41ZZjg4jJQ1yf4Gcb9547wzasMiGinbVeRAtSxYVUmuYSzDTO5D4yd30ZeNG5axGbG5E9ekVfO1A6t6HK6Qwvqhr+FvbJsKvAB29nJEAc37yDhkefnBRFC9bZduNKyxro9VcAn7rxb4GrkntcfTfDw/cC3vYD/qmYH4hDZxS/tU1tGdbmOsQexXk65nBFSJIs21dDWvLG5rVJHfA33OWYnXIaQ30c52CySkB1Z2I22QH6BCZOs2FRiTr1fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTm0A3pbBpZF9aun0HD9B+T44gI9RyxEiooTsl8r0EE=;
 b=dKYQg/qfCGrzs4gVvXRORa1RLy+5XjSZYCK+Uc8YqLzhpXnh0hP/ejpXLPkWYhK/mqX2BCVBTz3b+7mpmJiKJOfcbk8uXeTLIR7qG7DZVtU0sycUFh4Fmt+0oWPneUPvbgzr+EUbt+39tuoLrJtMvy4sFH7CQXlVgGax2luQ6QRnkfYsSUMS3m3wK6x0QGcEnfuOEm68d98TZJJGyWeqoK7lmMui5YTTVXFfMTcd7yQJt1K3Ye+yohZN21OihfWAP2JtKMhUp/AxMcV2iW1MZW+2QoWxGMX636TxZ1eP52/AgsVCKsjMcyk+bs7BDV9ZCqAofV1JgsrjnZdmvzLmCQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9127.eurprd07.prod.outlook.com (2603:10a6:10:3d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:53:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 13:53:24 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
CC: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v6 net-next 04/15] tcp: AccECN core
Thread-Topic: [PATCH v6 net-next 04/15] tcp: AccECN core
Thread-Index: AQHbwSfzSQ7n1pzvbkip+fVATyp5NbPQmv0AgAGEbAA=
Date: Wed, 14 May 2025 13:53:23 +0000
Message-ID:
 <PAXPR07MB7984C02A5B910446670F056AA391A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
 <39e06f51-621a-4d17-a4dd-17287e260e18@redhat.com>
In-Reply-To: <39e06f51-621a-4d17-a4dd-17287e260e18@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9127:EE_
x-ms-office365-filtering-correlation-id: 6dcd35bf-4e70-4185-bbd7-08dd92eeb1d1
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk5GMXJEZ2RWMnVrY0pNbTFTL2JDVmxkMXhZRnp1RkUzWEhVMTVaMTU3MG1K?=
 =?utf-8?B?N3I4aHo4VE5hbmhKSFNESStINjBWNUsvdlNTM1FhY2NRc2pYUlZYS2J6aU5N?=
 =?utf-8?B?dlVpVE9FaU1MZ2RVS015aTUyQXVFUW9BcGNsY0FzVkFUOVUxWFNaOFN6T2Fk?=
 =?utf-8?B?U05KT1FHbUtKcmxKMEJPRjhLcmhyTDdiVjVqc0QvT3B6am42bjJ3QmNSZmtn?=
 =?utf-8?B?ckh6NHZ3YisyWGN1cnZNQVJybDNxU0puTGZKSnVQbDZmL09mWUpoUGE1WllS?=
 =?utf-8?B?S0lIQ2F2Y0xlYmQyZ2FlVnVYNzVJTzV1Umdza2JBVjZaTE5FZUxrVDdlWWJM?=
 =?utf-8?B?ZHgrOEVvTXBiMzh5T2RsZUpoRlI1WUlZdGdZaGZGZHFGYTRWQ0d2KzR6UnVx?=
 =?utf-8?B?enAzTjdKYTRja2N1WUhNVlcvZ1FZMDRwUUxiNGlvNzBQNEozQlZqVTd4ekVC?=
 =?utf-8?B?aXhUdkc2MkYrTFp4UVN5UWNxcWNoWHFKM2ttNHdWK0tGejlGRVJXTEpQRXMx?=
 =?utf-8?B?dklQZHBER3ZjZ2gvdSs1Z25WQVFyMGVCR3BOOGpBeWhUSVlXbHdvcmNPV3lN?=
 =?utf-8?B?SGtiNmZYSXlRNGE4Yjk4L2FTSGcxTUE1WFc5R3hJS1FtVFlOSDVtT01Zb1dj?=
 =?utf-8?B?cUsrSEhZd2liWXdmUXVTWTh1S0ZHSVhQUFVBSzRFZkpLMjFtK3VVS2xkcllB?=
 =?utf-8?B?RzdMTDhQVmRxRE5jVFl5Zlo1YU1YSk9IS2NWeHQ0MGJMazdGcEZCV0pGU2Qx?=
 =?utf-8?B?RjJSNDd5UE9TbC9BdWJKNmhObW5qNk5NU1BnMjBoRGFMNStwcFA2c3VEaDRx?=
 =?utf-8?B?bGgwZjJhWTRpL2VFU2hkK3J4VFpqekNralRMSlFzcm85WlN5a1ZiNnppSVpQ?=
 =?utf-8?B?dDMxU3VMZ1VHWU0zTkk1M0x1bVVyd3dlbkVyU2NHU3UyS3M3dmZBL3EvMjJ0?=
 =?utf-8?B?UFplNFJyY1N3SkRzRE05TTE2UjhESmFFMnd0QUs0ZGROclpiY0tBM2FQdURH?=
 =?utf-8?B?dVkvUk9qOUphL21SSjgrM0l4ZGxQYlB2U3ZuYVN0ZU41L1l6WkQ4YjRLZ29Y?=
 =?utf-8?B?Kzd2aGJXcmxpSDgyYzZoMDNXN1dlOXB3Y0RRVHVxci9ISEJuRDg1NVlHQ0Zl?=
 =?utf-8?B?ZTk3bzhvYXJ3MTkrMGMyNXl4b1o3a2dlZEswRUhSOHJLTW1QWjVLVE8wbS9H?=
 =?utf-8?B?eE5MekIyNmhsUi9vTmNUaEovNElaRHVTZW8yakVIMDhqS1lQRHJhbWNlTXB2?=
 =?utf-8?B?cHlSSllnRnJXREI3OHRPeGQ0QWhYRVhsZFo4UHBNR0Z3RzlFNFIzS1NmMktv?=
 =?utf-8?B?WEJUVFNoRnBaS1RQekNPSVdSR0c1VTZUbzdjUTRGZkZSOWpxQXl2aWVvdyt2?=
 =?utf-8?B?MDl6OUtYdm5MQXRtc3ExTG9WLy90Mm50ZFgvSGgvdnBjNks3UWFZeDA2NEZK?=
 =?utf-8?B?MHNOcVptOWRJUUZDeHltTUtjcmtQM1JIUDZRL2plc3QxNzNPRlphWlppa0ow?=
 =?utf-8?B?Y3lCUURSU05kYklQTmJ2ZVZ0aEdSTm9wRTlTN2tmK1YySVlBMXFSYnluQ1U1?=
 =?utf-8?B?NEt0c05Tek12b1NrZXZSSkt0WDErclMyM3oyS3BFbGZRbXdGeDdZMGIyTkZS?=
 =?utf-8?B?TnJxd0pINzE3RU1RK1dremlDQmNNMUJBNHp0cEt4eHJXVjFBUE82RzF5MFBh?=
 =?utf-8?B?SG9walVKSmNHQk5MUG5FbGZ0b1NvNlNxT2dLVDJRUWhFVS9hR1BZL2JMbVg4?=
 =?utf-8?B?NUVrcDdDeVpLVE5XNXg2d2IxM0k3TGI0MlBFRFQvdnhSZDNLQ1pJUU05SG9M?=
 =?utf-8?B?MmJzOUtwakExa0t5dHpOelFzY1hxYVArZWpNcmZMczlpUDUyTmJITkd2NzZ5?=
 =?utf-8?B?ZFplV294b2owR2d5OWhLNFFrNVJPMUo3eWN3Wm1LQ3N0ejVTZkljRkEwY05l?=
 =?utf-8?Q?JUozeHrvIoP0tIzzWfY0MOhcgfIWFpIU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFdOOUFRKzd0ZmtFL0M2dXVMejZJK0Vuc05remhHWWRmSWNaZ05YL0NxNkZN?=
 =?utf-8?B?UkxNWjU4ZngweUFoRktJYWwyVklpYWZmQXJpMVlyUUF2eUEyN3Y3QkRQcUNk?=
 =?utf-8?B?ajN4SEhVZEMxTjlCcjhwbkRYaitHRC9vbmg5YXVpZTltNUhVaTdHS1dCY3hi?=
 =?utf-8?B?Zmtnc2FEbDQvbG5ZNzM5R2dZcWhKazR0dWgwQ1BFY0YrSjcyQ0N3OEJLV1E3?=
 =?utf-8?B?cE9kckh0b0pzbkpMNVZ5VDVrZlVFcW1KdG8xRnVmZzl6eHp6aHJLeC9iSlQ3?=
 =?utf-8?B?ZW4xczNueHRYc1A5aGlXaFBmQ2tYNVJ1d2trdjVUdHJsM3ZaSTZwb3M1aTFY?=
 =?utf-8?B?QXFsNEZiaklERjR4YkRuU0F5YWg4ZVprMzNrNWVIcjh2endlcDFQRjdtVFhi?=
 =?utf-8?B?M3diQTkreEh4QnA4aUh1TFM3WGJKV0hVRHJnYWh0ajZEVDJNQWgrRVBCYUxv?=
 =?utf-8?B?aUVuTlZ0cnBVajRTYm9qbDM4aStLcHJCZTIwQXhPU0JFZXZIM3dmb0U2OEhX?=
 =?utf-8?B?NTBCaUtzckdvTnk4bnpnUXpzK0JkQndKUjdyUURtbGxGWlNLTnkrVzZiM2FH?=
 =?utf-8?B?Z0x4UWZ0dHRidE1Kb3AybmFQUVgxbW84QXBzVUdkVzk0QWJXbkJCUDN1TDJ5?=
 =?utf-8?B?MTJ0NkllbDcrUFY5c0Y1ckppMnVPekc0UGdOa1c0THNJVG9zMUJNVTFBNHIx?=
 =?utf-8?B?aGNHa3dLNm9TeDdpRzdBblJXc2JYL0k2OHVpMnI4MU01RUxwYzRUU1RJSHBK?=
 =?utf-8?B?UUZCWDErK09mbVdqMWNNWWUxU2ZDSEVBb0ZxSVpyS0hzeG9sZ1lQQ3hNUytV?=
 =?utf-8?B?V1h3Zko0QmFRbUtrZG1BMmxFM0puUUZFVlNFcUFXWXI5LzdZajliUzNxcFFx?=
 =?utf-8?B?YTZHcGlrT1hFYjRyR3M5NlNvRHRMKzhrVTBUdTZEYlh3VXVQa241dG5mdWJR?=
 =?utf-8?B?c1AwZWNscm1NZDc4SXBrdnIwWFJTOTljbWcyemswS1EvM012Mmp0ckJDUXRH?=
 =?utf-8?B?eVlobEhVTXMvYUtaSzQwWXdkRmhwNHlGMmRPV3Vqb1phVk5MRnJ0VjJHb3FM?=
 =?utf-8?B?WXNuakN5VzZidm84KzNUak5rYnpvZDUyVkJrOVFQM3lnRHNscmtEZDgva2h3?=
 =?utf-8?B?Y3ZCRGsyOCtmSHRTYnZmR1puNUYrY1VOb216N2phdDdBY09IZ2VJWGFNeWlu?=
 =?utf-8?B?M1FrQXQ0eW5BanlhYUFFbjJLV0RCT2k0djErenVSWFJoYk01UkFSb21ydUxa?=
 =?utf-8?B?eWpCOFJXNFdydkdkTFdlUk9jbktQVk5xbHR6dFUrblFNbmlUMHpRRDVlVG8y?=
 =?utf-8?B?MEtMZ2VzRndrNUpRVUtrc3EwOFJFbkNQbGdKZEFFaWppSjZDczJaWHRMdndl?=
 =?utf-8?B?aklnRjI2SHVlL004U282Wmo4VGxqQ1FEVWlza2lraWVZYWs4M2JzZ25UV1NQ?=
 =?utf-8?B?S1N3SWxEcHMvdU03ajJZMHRYUCtjRzdib0M3VENHSkRXT1RRczBKNUY0eDJ4?=
 =?utf-8?B?c0sra1R6L01KOGJuazZDS3dhOEJvZzUxSG9mM0lwQXJNRkFpQVhuRDFBZmp3?=
 =?utf-8?B?cUFkSy9ncVFCQmowRjVYRDRoNTlockhhZnhjZTZzbktMUzRUTk1ybWN1Z3J5?=
 =?utf-8?B?MTFSMTUveWN6RTdBM0ZWb3FkUDgyRU9DYkNSY3FJWnNpN0Q0aWlmYkNZbXRy?=
 =?utf-8?B?MFJ1eERLbkZia3E2RHFvMEk5TnFmVUlBVkpTbVlOWnJDaldScS9yNVg0WFNN?=
 =?utf-8?B?eGxESzZlLzZER1lRS214aDZ6SUFhRWROSjJQNnVoNlNzekhvOUNoMXdoWGxW?=
 =?utf-8?B?dzdjY3I1Q1ovd2lLNWhkZ0ZMc3pFMU0zSmpubDZkRUduei95cktYeVFhbUQ4?=
 =?utf-8?B?c3BpeFZkLzQ2QWY4VXZoa0J3TzBBYWpFVUUvZmI4dHkvN2hRSkU4YVRpL0Zl?=
 =?utf-8?B?aXdjSFhmWkl3YUE0MGwrWnZYOU9BTzZFcm5Ya1BGMlNuek9ONUhIR2JDM0hO?=
 =?utf-8?B?NWxra3UxRkorNnVjN2g4R1B5QUt4YXpkMlRESG9hZEZoU3c2bHVMcCsraWF0?=
 =?utf-8?B?SVRFbnArbE9Ld1hwc2RQbUlYQXE4Z2crSC9WSWhZblBsWGJVMnAxVmUvYTBY?=
 =?utf-8?B?N29pdlFtSXo1WUFjQzZhV25QZmFVcUVrMTJ2c3hoNzkzUnpneGZpakprVkVn?=
 =?utf-8?B?L1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcd35bf-4e70-4185-bbd7-08dd92eeb1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 13:53:23.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANBp02ZvJc1zExpFxA3P/8n0bHnYJpCfK7hoYzwOo0xbKHedXYHAOEokDrnoodOMvLsKKf1rXcmYDD5Wl2EDsS/3h6xIF/5pAd4Tbq83y+qjPLl0O64qYW5Ntm5GUBXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9127

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTMsIDIwMjUgMzo1NSBQTQ0KPiBU
bzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6b24u
Y29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRh
aHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVs
bGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGFuZHJldytu
ZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsg
bGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2
Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2Vu
IERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNv
bT47IGcud2hpdGUgPGcud2hpdGVAY2FibGVsYWJzLmNvbT47IGluZ2VtYXIucy5qb2hhbnNzb25A
ZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBw
bGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRo
aV9nb2VsIDx2aWRoaV9nb2VsQGFwcGxlLmNvbT4NCj4gQ2M6IE9saXZpZXIgVGlsbWFucyAoTm9r
aWEpIDxvbGl2aWVyLnRpbG1hbnNAbm9raWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2
IG5ldC1uZXh0IDA0LzE1XSB0Y3A6IEFjY0VDTiBjb3JlDQo+IA0KPiANCj4gQ0FVVElPTjogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNr
aW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQg
Zm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIDUvOS8yNSAxMTox
OCBQTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+IEBAIC01
MDk4LDcgKzUxMDAsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgdGNwX3N0cnVjdF9jaGVjayh2b2lk
KQ0KPiA+ICAgICAgIC8qIDMyYml0IGFyY2hlcyB3aXRoIDhieXRlIGFsaWdubWVudCBvbiB1NjQg
ZmllbGRzIG1pZ2h0IG5lZWQgcGFkZGluZw0KPiA+ICAgICAgICAqIGJlZm9yZSB0Y3BfY2xvY2tf
Y2FjaGUuDQo+ID4gICAgICAgICovDQo+ID4gLSAgICAgQ0FDSEVMSU5FX0FTU0VSVF9HUk9VUF9T
SVpFKHN0cnVjdCB0Y3Bfc29jaywgdGNwX3NvY2tfd3JpdGVfdHhyeCwgOTIgKyA0KTsNCj4gPiAr
ICAgICBDQUNIRUxJTkVfQVNTRVJUX0dST1VQX1NJWkUoc3RydWN0IHRjcF9zb2NrLCANCj4gPiAr
IHRjcF9zb2NrX3dyaXRlX3R4cngsIDk2ICsgNCk7DQo+IA0KPiBUaGlzIGxvb2tzIGluY29uc2lz
dGVudCB3aXRoIHRoZSBwYWhvbGUgb3V0cHV0IGluIHRoZSBjb21taXQgbWVzc2FnZSAodGhlIGdy
b3VwcyBsb29rcyA5NSBieXRlcyB3aWRlLCBjb21wcmlzaW5nIHRoZSBob2xlcykNCg0KSGkgUGFv
bG8sDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KSW5kZWVkLCB0aGUgZ3JvdXAgc2l6ZSBz
aGFsbCBiZSB1cGRhdGVkIGJlZm9yZSBhZGRpbmcgQWNjRUNOIGNoYW5nZXMgYmFzZWQgb24gcGFo
b2xlIHJlc3VsdHMuDQpBbmQgSSB3aWxsIGZpeCBpbiAjMywgIzQsICM2IGZvciB0Y3Bfc29ja193
cml0ZV90eHJ4LCAjMyBmb3IgdGNwX3NvY2tfd3JpdGVfdHgsIGFuZCAjMTAgZm9yIHRjcF9zb2Nr
X3dyaXRlX3J4Lg0KIA0KPiBbLi4uXQ0KPiA+IEBAIC0zODIsMTEgKzM5MywxNyBAQCBzdGF0aWMg
dm9pZCB0Y3BfZWNuX3NlbmQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgDQo+ID4gc2tfYnVmZiAq
c2tiLCAgew0KPiA+ICAgICAgIHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOw0KPiA+
DQo+ID4gLSAgICAgaWYgKHRjcF9lY25fbW9kZV9yZmMzMTY4KHRwKSkgew0KPiA+ICsgICAgIGlm
ICghdGNwX2Vjbl9tb2RlX2FueSh0cCkpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4g
Kw0KPiA+ICsgICAgIElORVRfRUNOX3htaXQoc2spOw0KPiA+ICsgICAgIGlmICh0Y3BfZWNuX21v
ZGVfYWNjZWNuKHRwKSkgew0KPiA+ICsgICAgICAgICAgICAgdGNwX2FjY2Vjbl9zZXRfYWNlKHRo
LCB0cCk7DQo+ID4gKyAgICAgICAgICAgICBza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlIHw9IFNL
Ql9HU09fVENQX0FDQ0VDTjsNCj4gPiArICAgICB9IGVsc2Ugew0KPiA+ICAgICAgICAgICAgICAg
LyogTm90LXJldHJhbnNtaXR0ZWQgZGF0YSBzZWdtZW50OiBzZXQgRUNUIGFuZCBpbmplY3QgQ1dS
LiAqLw0KPiA+ICAgICAgICAgICAgICAgaWYgKHNrYi0+bGVuICE9IHRjcF9oZWFkZXJfbGVuICYm
DQo+ID4gICAgICAgICAgICAgICAgICAgIWJlZm9yZShUQ1BfU0tCX0NCKHNrYiktPnNlcSwgdHAt
PnNuZF9ueHQpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIElORVRfRUNOX3htaXQoc2sp
Ow0KPiANCj4gVGhlIGFib3ZlIGNodW5rIGFwcGFyZW50bHkgY2hhbmdlcyB0aGUgY3VycmVudCBi
ZWhhdmlvdXIgZm9yICF0Y3BfZWNuX21vZGVfYWNjZWNuKCksIHVuY29uZGl0aW9uYWxseSBzZXR0
aW5nIEVDTiwgd2hpbGUgYmVmb3JlIEVDTiB3YXMgc2V0IG9ubHkgZm9yIG5vbiByZXRyYW5zIHNl
Z21lbnRzLg0KPiANCj4gL1ANCg0KVGhpcyB3aWxsIGJlIGZpeGVkIGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNCkNoaWEtWXUNCg==

