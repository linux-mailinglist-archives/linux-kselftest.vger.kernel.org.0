Return-Path: <linux-kselftest+bounces-30521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4245A854F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0609A4F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553327E1CB;
	Fri, 11 Apr 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzYd2ovA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D81E8323;
	Fri, 11 Apr 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355202; cv=fail; b=dtKNYaxpiO7V/9QJxburGNmWbtT/rZyCK12PpCA71Mx3I82mX8pz8cJp9H10o5ZKOh/buZwFhbE1T+ddbfP2qaCtB15Eg7ctcZ9d+r3qMzvIhFLSYVOlQXlM313h2dQnt+wwxvxO1I6kK57WSAp8YlhHRoXdBNJWl6z15T6Ibc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355202; c=relaxed/simple;
	bh=P15uL7Ke4wrq6bctLkrx0Dl8a6dTCbiRK7qoS6Z7gc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNj6OnHpg4TYjcljMmoQeh7PGr6FmmKJpQFzpxu1RA9O8YSGiToQQZWvJCzSUFwP72WhHWiy6ZHF0xcRKf5UNFIjLjyuTixaoKD6Unpj57Uopg/05CyEMOrN3kxR9LTiPfxscjA7k2w2/PD14GEqekZ67/iVZUlxI02bV6CKp5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzYd2ovA; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjVJGtdFvEC2nEH/37W0zTIhqM6DSVNW3u64ttIV11SvREZ0kTnACnq7/Psz3G96gV0VlrQTafOkh6z6vlxbSwFTbST9iXvjAY3h5i+BOQD9iWtPf1TdYJqveIMx2zdvcZsPWxHF3cQSh4MVowzwN11oDJpdEACtoO3uzmfASnnNu3pUh9DmEASEHuX4q7l16opm7cw7wuzXfh+/UjMGD7hRrAjOiZWo68XRaSk2xqWiwEBBgH02CnpuSrsbQ7mu2t1hgLk5aHv9lGJVn0LyPFsErBQdcoNpqmTAhdLYXoM6IyttzWIQOfrHl6lwfWakG0HnZplr6IDz+Ln2sLHV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P15uL7Ke4wrq6bctLkrx0Dl8a6dTCbiRK7qoS6Z7gc0=;
 b=Cxj301w6qext7jNfFCHkZkz7MkhGlgBJx06oibNtglSJZKvUOI5Kng98ALD3VzwPbiU1Imee9R7MAyEvHXo5bjK+AA0TUkBDH5MQ6zdeZFeOV54bL9J1a8QZuXKdW4qAykdwnqBkpscyo3fikEZ8GfIv844XzAJ9lD/jWeBbRQpH2ndEpkYCkytNxfLxG6NiINsE+9OZutoW9b49WhoN+bUD5u1u6h02qoE4sAXYsIBWX2MKLrNFRLRF0U4nZL9JSGQS1Je3laEUR5/mHY5Xv2Mqsy1wBeN9A8H6iNFg08YNA1z22p/h7FRVyBzhi9sH/p2JlLM8+bTn9Hkiv6QhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P15uL7Ke4wrq6bctLkrx0Dl8a6dTCbiRK7qoS6Z7gc0=;
 b=rzYd2ovAdNCuQfAMc/2i5ceQVplTbdVoYPTWCZY7X+7I9qUxqMSO6udN8lWR/w5yErFlZmQ3BLV1UdW+GiOo6SEEw3X/E2ORt07p/Jus5e3GzXQZOr6l2/wNWOKHPTVzW7CEoQboxDGD+03u6vKwkHv/U1VJr4dDJSuWgzZAsdhXQqvEMElGbJDek42e/H2UUCVkcINMs42oEbCxINbDWkJFMjCxM6f21TdzDefu4+g+NKkXGgBoXmiA8W5kIB4tPWPx8WxMYalSUSl6g+JfcUfq5bLKwj/0UR3IcOJRltCdbJfnDbHoVKpsLQnSaiQEnwv7e8AI6420Sink7Ka+ng==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 07:06:34 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 07:06:34 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"bbhushan2@marvell.com" <bbhushan2@marvell.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hkelam@marvell.com" <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "jv@jvosburgh.net"
	<jv@jvosburgh.net>, "razor@blackwall.org" <razor@blackwall.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
	"ayush.sawal@chelsio.com" <ayush.sawal@chelsio.com>, Jianbo Liu
	<jianbol@nvidia.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>
Subject: Re: [PATCH net-next v2 6/6] bonding: Fix multiple long standing
 offload races
Thread-Topic: [PATCH net-next v2 6/6] bonding: Fix multiple long standing
 offload races
Thread-Index: AQHbqV2u53yuQAFXAU2ouudIrJu3qLOcOKQAgAHVIYA=
Date: Fri, 11 Apr 2025 07:06:34 +0000
Message-ID: <08b9f4c633070dca1ddf7409c94a9ee591666ef4.camel@nvidia.com>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
	 <20250409144133.2833606-7-cratiu@nvidia.com> <Z_c17jxZz-cQLjjm@fedora>
In-Reply-To: <Z_c17jxZz-cQLjjm@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|BL1PR12MB5754:EE_
x-ms-office365-filtering-correlation-id: 7c43d46b-5fae-4dd9-c729-08dd78c764d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3VrK1dtWWNGMERuWi9qVnhnZTJ3ZzRQY2FLNG1KNVZSNmxZYXNyR2pOQVdp?=
 =?utf-8?B?bmkxRWdmRDk5YTZKU2FBejN0eXJjTUY5YmVGcGlkbzJhRUJ3QmtTN1p4MmFT?=
 =?utf-8?B?QXdCQ3V0YkJiSjVMUzAva0ZQNU95Q0VXNS9majJnaHEzdi9Ba29YckNYRCt5?=
 =?utf-8?B?cDlaMU5zTm5CUmxPQldaSEtiUHlkYWdYOGM5bmNYZ3o2THVraGpvRk1admtP?=
 =?utf-8?B?QW9tRW5NSTNXUm5xYkpOcjliOVhENlo5c2J1dzg5eEVuMzZrUnpZcUxzemti?=
 =?utf-8?B?MjFCNzMrbkZ4bkNPc1Iwd3l5UVNqWVBGQktMSUtNMGZIZmMwaXRXZEF3d1N5?=
 =?utf-8?B?QWZNUVdLT0MzOC9qNEdRdndLVy9mZ05lUjYzakVMUHBPTnhTdUFOVTFTTmVa?=
 =?utf-8?B?ejFQcytMR0ZFMmFuMlRTVzZVanpaU0tNMElKVmhzRUhJUFJCL2JaZUZGNEw1?=
 =?utf-8?B?TGdHdFJSalZJM1ZnZ1pQNkxhcXY2YjJYNlppQ2x6MXd5cVlwcGJwYTN0a0lz?=
 =?utf-8?B?WVc4RTdKdlU5NjYrWVNpQW9WajUydDZRcjJ1cTh0ZmVOSnFVbC8zVkY4Qjdi?=
 =?utf-8?B?d0RzSDEyOGxrd1FvZkZwRVovUHR6Q2tRNW94OGZpOE8wZFdVNlFVMnoyRjlP?=
 =?utf-8?B?T1hWYjExMFdNQUhOc1dtV3h0MThZSHIvUW1zek55TlhVYU9RWVNUVkJXbVNC?=
 =?utf-8?B?bWVWWDc2eDNuUGI3bytPVnlzVWd2UzJQSHZSUkVQYXlrTWJxdkxpd1hST1Fo?=
 =?utf-8?B?RTUwbC9QUnpTL2ZUcm5xbnpmdWsxVnE5a0JIOUp1aGFwbkpvTnVrMGVwL1Zw?=
 =?utf-8?B?TTRHcHNxaFVpSm5OUnpidkc5MFZuNnQzRWFSRzlybUxiNlNpT0xQTC91b0ZV?=
 =?utf-8?B?QW9hV0hEMmNNTmVsOFJPTmczd2h3UzBwZ2pHVGhYMTFIdU1LNzVvWXN3U2ly?=
 =?utf-8?B?QXNmc2VndkFFZnVEek9qc1BWNVd2bFE5alBrR1VWZlQ1YTJlRDBJS1FBdERv?=
 =?utf-8?B?YkVrZXZCbHdQc21ocFFPRTdJcGJCeVYyYmFUZmROTnliTzlJU0F5bkVmZTZu?=
 =?utf-8?B?NjZ0R21MWGpkcC9WM2N3NFlMazAzYXdZL080UFo5TGpOd1IvYXl4cUQ4UXZy?=
 =?utf-8?B?QU1yejQ3L2w0QmFNWUFlb3lyNUtzY0t6Ynp3MUhKMkJtTGwxTUdvenJFZ1pz?=
 =?utf-8?B?eVBRRE9Wcy9paldOdmVKUGU1VXFZdGFjVUE0czZ5TEN0c0tnRXZlVjN6TjY2?=
 =?utf-8?B?UmVDdG5BNVVOTkMwUUJvOVhadHJnWkUwbjBSNEtvVXZ5MUU2clViMHpnaWpX?=
 =?utf-8?B?bWVqcDk2dzFxcWs5dlptb0hCMzgyNHIyb3JRYXpjRXdmZjFYSFY5bVVPNGpv?=
 =?utf-8?B?TGt0QWRzamc3a1l0OTZiMWc3cnRWN3FqbzBlVFVVZldNWk41M3Q5Wkgzdnhs?=
 =?utf-8?B?b2Nuei9nKzZ5aXlZYzdNOExxU3paaTI0VStPVE5rL00zTlM4aHBhMm5ic0dB?=
 =?utf-8?B?SnVSSE1YMFJ3ekNtdTQ5bHRtNGhtTDZrbDNNR0ErQkg2TWlGR2s5bGl4ODFT?=
 =?utf-8?B?U2UyTnVyVkc5UDQrWkVyeWVFZHF5YjgxZnhCZFJwQ0I3ZTQvNkw3bjQ0aGxw?=
 =?utf-8?B?Vk4wTG5ZR20xSEt1bkwwV1hQRTZiemZEbXJYZ3FaN3Zzbzk3SFBJNHNJWWhM?=
 =?utf-8?B?WVFHRW9uQ1huZ0JoTzVCOWh6RTVoL1ZucE1UcU1lMXBPd1N3Rm94MUwxV055?=
 =?utf-8?B?Y1F2Um1mbFdrNkw2U2RsUUxrcUcwUnRTN3ZkbExtei9GaTI4VjAxQ1graWtq?=
 =?utf-8?B?M1d6OWwyRzlzMTFYZ3dYMG5jZzlDNlNOMTFxM1g0MWE1V05lS1VGdUFuaENm?=
 =?utf-8?B?OVRpSklwUVFhWnJVV1JLOU9YQW1SVXEvT3Jac0lSS01mc0lLdG96WjN4VjhG?=
 =?utf-8?B?N2s2dkVMakwzd2dnczdYcVU0cDdOSnErZWdCZHhabU4xdUplZzlxOGFJMi9j?=
 =?utf-8?B?WFhLNlAzNHF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aERpMTM3NDN6M1VhL204WDRwQlVGQ0ZWN24xRk5Ta20wVXRES2pyY3dpYjBI?=
 =?utf-8?B?WXJDUkI1dzBJYklUajZCQUNGQlhodTFUYkN6a21YVWJHYm00UTZCT0FuS0Y5?=
 =?utf-8?B?K1BjSE9vUGlSL3l4TXdQdk82MERkNVBFZnFuTS9xRnYvY1piSXB6QWJWTGdj?=
 =?utf-8?B?bk1IaFJEcDNVdnJwQ0d6QUFZc0tqblJEU05XbXNTbDlMa25mZ3pBbDB2M01M?=
 =?utf-8?B?TFJLcXBsR3dkSVJMQi9NV0M1dXRyR2MzcnNwM21RYis0NTJJUTBlWG1CSW9k?=
 =?utf-8?B?YjgvR01kZ1dLWnFjY2NjMzloMFFrZWlaem9TaW9sb09LbXhvR2NqMFByMzAy?=
 =?utf-8?B?S3lYVDU3M1FlTkQweWYrY0FDQmJCSUpEendEM1RjU1FHbGtMU1pRYmI5VTM2?=
 =?utf-8?B?dDk3OXNtcmdRb2I1Mm00NGZKdDU2czcrNHUxYUJiUlJINlRRekltWHp3UzAr?=
 =?utf-8?B?a05kak1NZGw2VGhObmNCcUZ6bUJFTUxMeTFqcmdyOTZGM3ZMTDBFMk9xd2ZQ?=
 =?utf-8?B?VUkvVzJXalFmWHVIdW5kdFR1c1prQ2FQR05hczlweTZqSVEzbVRSN2RkUUNh?=
 =?utf-8?B?U2NXblVNTzU3MGZUL25ncDFqZ3RYNUljQ1M3WW5icFBkeCtxMlBlb3N3dERy?=
 =?utf-8?B?OXNDQ1A3TG9ucGhKUW1UdXN5TDc3VUtSVHlIZnBaKzVzU1RnQndDcnNTNVJ6?=
 =?utf-8?B?YUFlQmI5bU85QjRDZDdYZmdkaldZck9VWDM1UHJOOSs1NWpMY28rMTVuQXB6?=
 =?utf-8?B?UnMybW5Ub3NTbTRxQngwWkZJcnJYM09aSjBwV2ZBNmpvc1ZzK2tOdG51VTFJ?=
 =?utf-8?B?WlA0Q2pJb040SmxHOUdNOVNPbEdieHB5L21HRGVpbXhLa3NrUmlFVW5nSWVk?=
 =?utf-8?B?Smp3MDlvRzJObUI4RmhEYVZ5c0lNZUEvUUFONm5qZEZOdGFZcXFZanlvL21R?=
 =?utf-8?B?VjA5T2hka1JNWjlTWmFBQXZId0xuSGc0MWpSMjVzdVFTWjFPME03cFdOdFFY?=
 =?utf-8?B?UnB5Y2NuQktXcWxZUUdaTUFPcDNRRStGNlQxeC95TS9EL3RUU1B4enRTM3Zm?=
 =?utf-8?B?R09ZMG9MNlNxQ3pjNFZHcjdNaEpaVmRtQWpXVTdEV01UTjVrRStQckx6UDk3?=
 =?utf-8?B?RUM5QlhDeFRXZFJzRE9OcmVXUTlMaFRKQTNJNVI4eVh0ZGI5Vm9GYlRtYmJr?=
 =?utf-8?B?d0lvOTE4R2VVRkdyS3pqMms3cEJrdE8wVGNzb2pUUyt1dWtwRXE4Vm9MRnRm?=
 =?utf-8?B?VGFBcmovU0FQclFvZzJIaHhrd2hwdGhUd2tSam14c3JlcGR2bGJGbG00bTFy?=
 =?utf-8?B?RWFFNTdiUnJTQndlRFlBTnRxbWlKRXk3b0JjYzlyUTBoQUJGWjJmSzFJVTd4?=
 =?utf-8?B?c1pSOFVRVUp0dWU3TU44L04vS2p0b0c2aGVaYnl0K0E0K094SVlRSE1KWU5o?=
 =?utf-8?B?RlM4YThFN1dzZHhjcGR3V3ovbzU2bmUwbU9DMTVOd1pHZUh2bDVXM3N0OTVG?=
 =?utf-8?B?ZXBrUSt5d3AwTVFTeHBWZm5NdHJ5b1IwS0ZVbHk4cS9mWkg2WXJiN0F0L1dk?=
 =?utf-8?B?c0RpWWVqaXZkVWN2a0FDZlI4aWFtd2NqalJZMnczcTFsbGd1ZllSbGcvb1la?=
 =?utf-8?B?cjdhcWlXMzlldEVoL1VlblgyQmh6VmxaSDNRTk5zbHFPZEdIV2RieWd0K29C?=
 =?utf-8?B?M0gvcElWblJVMVZWSVRad25yU3NkRm55eGE1Q3lxdTFRemtrdll6N2dkYUZw?=
 =?utf-8?B?UHV1b1hQaUNldVpqdUE3OWZGSjY3ZlBZTlR3QzIxM09oYXh0NWtDNkxHVU9x?=
 =?utf-8?B?ZFVrd0Jma0RaVTFnMFE0dmwzNWpuYnZ2MEI0M3M5SjhvRlMvSmRyMEsyTHl5?=
 =?utf-8?B?S0Z5NDQ3dmVlYTBPTDE2WEUvVGFUR1UvRHlFWmdNTEFCRmE2UWw3K2ttSlln?=
 =?utf-8?B?TVh1SnlOcHB3MllhaG9DTnNYTmNVKzdkWFQvN1VPQWl6OE1HT3pSSzI4OHRP?=
 =?utf-8?B?V0ZZcktCcEZ1bFBURWl2R3o4SlVBVHhqajE5VlNOY2ZCSUZTSSt0TS9ad01C?=
 =?utf-8?B?RkpBSHdyYnZqWURnUWkwL1NablU4V1gzenBVVEZReGR2elJDdUhMTHZVdlNy?=
 =?utf-8?Q?Eg1RLa47oofYWWaEU0htvAG6a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <174A679A7243F24BB725F4CB8D2F9FC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43d46b-5fae-4dd9-c729-08dd78c764d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:06:34.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4CIYESMWWY6wzJdskWVBW8+I5RkFVK7g3svnXU3oG61CAIMXnhxHcIF9lpYQKKbwsmmdAqhbvWMjs8TvaxHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDAzOjA3ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
DQo+IFRoZSBib25kIGlzIG5vdCB1c2VkIGluIGJvbmRfaXBzZWNfZGVsX3NhKCkgYW55IG1vcmUu
IFlvdSBjYW4gcmVtb3ZlDQo+IGl0IHRvby4NCg0KUmlnaHQsIHdpbGwgZG8sIHRoYW5rcyBmb3Ig
cG9pbnRpbmcgaXQgb3V0Lg0KDQpDb3NtaW4uDQo=

