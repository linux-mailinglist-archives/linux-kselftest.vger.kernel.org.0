Return-Path: <linux-kselftest+bounces-42628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3901BACB27
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B83AF4E1C47
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86825CC42;
	Tue, 30 Sep 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jtDuKGxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8925A359;
	Tue, 30 Sep 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232098; cv=fail; b=lCyxsCfINap1OCb7v2tDZR+fgqZTSLSyb8T2YgWcyV0HmOCVNw3uJ/gYbux/7GEF1l1eaC0tZ8EuevgzNA5c2Gyf7ozu0+6L9EQ5H9J3KSCHb9Bs6hxSVvLk/0/mxS/6n9jOQJaFWm0KzkydzP/RHddmjYaBS60CO5qbDyWd6Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232098; c=relaxed/simple;
	bh=BRbawmjdCdVnul4M6wxIZCda8bw9T9ju0+DNZwBETAA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULdXf+bjsNztFI+97ojpFFuNagWYoceLtpMfTygxUtJcwhUKJVDywL6AOHsusCIlCPH+Y9YFYbXq6WQ2DBDJaJtrBo+PCJWEz8D/ktFZRF1y6Dj7ZrCZs9/al+sSMF06wGo1WZ4VVTFNp3xDklBWXeFB3ykb/OdgD3W2LqhZNQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jtDuKGxp; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsVEyrmNrgJzgQMVvtUg0P7j6FW+G/+tdxd/+QZYzMBaaNLWnh9ga2V312FVQpnKb72tLmM43e5mpE2R0uaJy0jE0jrSyi+8Z3tI1B1og6V1R5bhaM/fKcWKCy8FqfM5+uq4SxnzCyp8NSfMxULxFbAG/WMteEciY011l2OqjIpuy5Pz7ocB0u/UeUbQotfjKOjgX5/bPj0jap4FHw/TLl2WEy3lYvbWxrYovJxDiWCvcUnWZAGrGYKYcakXsGztDfHdw/TUEj3NpDw+JONsMTpNm/2t04qzTMtXwM7y5REqs6ta3MjAPJYq+nS6r2LKD8hgUS8tqN9S4OnP3vem3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRbawmjdCdVnul4M6wxIZCda8bw9T9ju0+DNZwBETAA=;
 b=WdGJBcGZfQZgVf/+CI3uQzra543vqTD0RZsAnKtSULrt61yHsJ5iRs58V0F564RFwUHXveEiReKIviM8Pqo+VIyUBSDeJYLswYACN3t/iyx2k4Hl6F87m9SvifJiiXemfwmEe9WgoEXV6vGAlcXVn4o3KE75IoTDFFaqu8/9MWZcOGYYyXQJuv5YwC7v5Vg+SSnDjwNCZSj0Ol0XxAK9jOD9vTDH4WnQFlFMMTYA/bwKMNvW83y7ARtietmi/i3jZLtaoDhjz9w6Yhcku5waiBqEHFkLvtZIbNwS7meDfwPoxwjeNDWWPlyUuHuHw94a2eEvTGX4fMLu3qtBrrdQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRbawmjdCdVnul4M6wxIZCda8bw9T9ju0+DNZwBETAA=;
 b=jtDuKGxpuJ98lv9j+vUCjtyKoVrEpt6WXTgNywKW/bT2aeiDmB1tY8yTSrVxAFC73ilkOO76kPw1KWpcOIlFGOApn8j7WtD9gg1iD1VuvYf4votfk/VP4mb/mfBFQGp+thoOz3kkk1kRMLn5fCOFKB0DDadQhYbjtUSVmTxfMe13nyX1I6asNtgyE1UMC0OSJR1NImCo0piEHV2QYxK3i4pB+TdeP0bzkEjm5EG2DvOWqwE7XufX+G2+eF/m/8gKCLQ2KRTZMQ+A7WiATvb3fvKHAlb2ATopSQDWgkXTliP9zBbfutM9B5b3xRmcNYuA61rJqe5//a6QtJ3NkiMXdg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM9PR07MB7795.eurprd07.prod.outlook.com (2603:10a6:20b:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 11:34:52 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:34:52 +0000
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
Subject: RE: [PATCH v3 net-next 00/12] AccECN protocol case handling series
Thread-Topic: [PATCH v3 net-next 00/12] AccECN protocol case handling series
Thread-Index: AQHcL4t0/dHZGRl6+k61HV5EZO6Z67SrlIOAgAAIlGA=
Date: Tue, 30 Sep 2025 11:34:52 +0000
Message-ID:
 <PAXPR07MB798402AC2BE729A075AC63ADA31AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
 <49f887d8-a34d-4154-af94-84a3f77700e1@redhat.com>
In-Reply-To: <49f887d8-a34d-4154-af94-84a3f77700e1@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM9PR07MB7795:EE_
x-ms-office365-filtering-correlation-id: 9cc50953-d17b-4864-8d5d-08de00155f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TvQazAcv/B1RopH2RseDMqDYW0oyz8Nn7gMUZF2v1MD7j9e+IXpcSdGol+gr?=
 =?us-ascii?Q?IWw+kVYfj3G8+2pXDQK+LjzbDJhpTND3LB1V/isSboI10CjDijUzjSpnMHPy?=
 =?us-ascii?Q?j9g0EVWPOW6qXNh3tDSnBJPlY0hMoOYSGy681YGTkUPTDsxHQfptM6qUJ0jz?=
 =?us-ascii?Q?bdw3N/5cQncZ2ohjhYjjl5EMHsGqHwRBU6K+p4fwpMJDZmbVzFlBQ8JzGDzy?=
 =?us-ascii?Q?I6jvrZ5E+TkFcLehQ/DnTJLbO7YwPcWuEtgKBBmFSJl3YCmgbntK5+yioK9M?=
 =?us-ascii?Q?CIeg+4HwbPMN6wS3gklsbSg0eM/CvWQpRDxrbgBIr0X6t2GZqGxUdfXP4Q82?=
 =?us-ascii?Q?VXR6nQxHSEMlbynjs9QYzEpHWd6TrMYRhUCyewpfgkbxeKrVRhFgDB993I62?=
 =?us-ascii?Q?n9MFuj8IPd+lBupz8+e3wUPLbgeEqcCJpO7GE2He2wooOjYRw+Halbtz4Nev?=
 =?us-ascii?Q?Ztyd9Dc0YCpxWNmT8Q6j2rKys1geAOMRLwZ8h15uxel1WPt144ql2ydvP1em?=
 =?us-ascii?Q?hNVUIvdPAo64eXLCsQtV7r9LwQdapjUy3lwuuwXJ3DD8o9Q306W5Rc70zWh0?=
 =?us-ascii?Q?l3tnKJC+H9OKGBW+c9/oLoZXFKM9wtHNK+ldzPtJ8RPJb9ZAMDsBnJIXY6lQ?=
 =?us-ascii?Q?ok1PdUUjM3XnlzCJiDdoXxxpyZA6SiBL1Z8guV/m9VwBMI9sfeUcDmFAN8JD?=
 =?us-ascii?Q?5+YwBrQis3yYJz4jhEvBnXIwl1mkz6nt8f3O8n3pppn92sDxUs05tm2PsO8x?=
 =?us-ascii?Q?HPTXBQneRLYU799RLpI1Ckwf7hjpzpbT3uMw8SqPh2km1K+nZfQBb1qB6bsE?=
 =?us-ascii?Q?9JMCjxt8p0FKXGPzMYaZWUSxINLGakvrdMBZB4coHO0/LgYgTAZRj3Zsnrj2?=
 =?us-ascii?Q?obIBEEqlLj9iMGuy4UlJo4+3evaU0mbk62hyPp8CsPeDNnYGYcdWOPlZ9gfg?=
 =?us-ascii?Q?NrBgrQke5ib2qGZ/4wDr6CEkinaqN+wNK8VWppti1hLv5Kep5yxVTUkdc+GP?=
 =?us-ascii?Q?kQCM8rZ/akF6iMCmsdZM+tKTIZyfssaepkOE8NRaIoZwoqLAN5ws6pjlkrYQ?=
 =?us-ascii?Q?GasbRi9uQZdutR9zFfcyzjgGX2TBeHqTB/peEZS4xr5hRIzgrsvSaeoMBBb1?=
 =?us-ascii?Q?gA8wR809bMuZu1f3Vd/LVL6WAHFfTRUJVK7HXOobH5Mt8QbvJhddhx/JTqf2?=
 =?us-ascii?Q?5mg5+iOBuxztBim6SmJlZRjSzw3y7PBh9wrB5ZCi4sKaj9CZoolM7jK3w1Sh?=
 =?us-ascii?Q?jzKdmG2zYR4uELodFQkolb4UTgDU4HJrsp17Q+Ecms7yvTpGvf/1BqW/acPj?=
 =?us-ascii?Q?CS964x2314D3oHR0QxXWDpxnjg04qJzBJBdeinkvIRGo+V9qfCP3S+1Kb865?=
 =?us-ascii?Q?qCgb6MWVJ3eMGprxWpVc5pZUR9rIjm53Ibdc63yEaAzZBQ5R6kotPkVwNxad?=
 =?us-ascii?Q?a0z9vFqn3hv2LmFw0R1WPlS+qzWGNSSb0WQpxgQn/dzsUbUyuMbffchTbrM7?=
 =?us-ascii?Q?lH7t9GaoUL4KQ31wrAVWMlx3X5+DhYplfPQQY9OgEuDG7ApwEAXtTU+bqg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FKinTTJ9g+pRX4hKul5Cu56wKsDMVccuSEo8WOhdaTdje080poKiINnb3yfH?=
 =?us-ascii?Q?6e0kT4UZjp1u6H5eXK7p3b5UTupru7Rn45diKcTfaSyD5tvPYfin5AeYD3Hs?=
 =?us-ascii?Q?9hBF6zpFV6b4DT1XwXq1u7TUthfWhq2rJSo3LaerTcXvudxThriNyFR3mI+t?=
 =?us-ascii?Q?+a3Zk4vlcAQ4AludIaKdKrmuAq3V8v4tyQXYgIYaZzFBGuDp9Xb3UETgOdBO?=
 =?us-ascii?Q?gEWg8QO+Qu+6Q7GUHXrDHUbq1phvUoabrG0PyCDLvGqG0QPT3Bj0+fhuIE37?=
 =?us-ascii?Q?AQIQDYHuBSQQv/iV7gU8fH755ufSXjaTWh/m1l6y7dzIojhvzL+nJ+1xOW7O?=
 =?us-ascii?Q?VV41KfrZjxZcqu0Iwted7RMrN7ZvLIkCyI42uLvJ/LL84BcRmK2ttilfy4y7?=
 =?us-ascii?Q?jUMEYoP38CHGmajKzdoPvv9GcmzLJq4EWXreH35dTpPvVBJfGdeEdivNy3cg?=
 =?us-ascii?Q?rzub4EZMI1p30/SQugqmH+7xEixRoH4V8TxJiRFFn45ABv1K1b+84JdI9eZD?=
 =?us-ascii?Q?0CXUpdn4T7pobmIzyB1bPHqCRLmbGJB++1sMCegmkD22SeFvRZd4R0KdESdt?=
 =?us-ascii?Q?+//z8C6MNLl/d5iEv5cyj4LHnuV7OnsNybWL1+K1B9eQdI+bPsQ/w93CNXKC?=
 =?us-ascii?Q?ny3w76APK7pmZEFEkc9C3ksBinkGZZRVhmn770VeG+/7hFe7tWy0PSYUvGHq?=
 =?us-ascii?Q?0oQHgUvXrB5Ya6SnIqku/uophgAuW+dKYPos6eCgRR10KUldBeIKb41R7rD8?=
 =?us-ascii?Q?UfPT64OALJw4eUEH+DU8r2vztISsN549upF/nrERFND1BSe/6ft8xmb1G72H?=
 =?us-ascii?Q?uD4ET4ktMIORTYSbcLTjEi6bkUyPhNAJ9a1aJmfQI9Sohgm06XphLv4zRP/0?=
 =?us-ascii?Q?eSL9rxPYN+g3SFABY9uO1fPR+V+Yu5mCSqpmsPUBxLIVzY1XKvjZYv8jEuGY?=
 =?us-ascii?Q?qzo15szw3mr9NHPQT90Zs17IIuONwUdXJ5sxAjy6o6FbSKoChpxqbRxUbDvk?=
 =?us-ascii?Q?4IrOSpTYDD4fv7WViyUHY/OFLiC0cAgO5yNxRKH7bdFb7EKaZ3IiX+tOA6p9?=
 =?us-ascii?Q?uQAm2stliUInAHH9/bvgGOsMW1lmTVvR5Z+I9F6Skb1T8TboZP6OnQt/4agY?=
 =?us-ascii?Q?C9HL++GAJHROcWB8ANT0aN0dEyujXfrPKNSv95sXqeEY50BAkrxJV5jewWOi?=
 =?us-ascii?Q?heLrfyyAOCBviwzyhWfEDMmUJBG5zsxNiQ4EQF6Pzi0XbSHkSNSNTdogfOqe?=
 =?us-ascii?Q?4DNGNQOnWZCBogb7qjYfwojJcTeprt7ErcuPx5hkI+fRNX7FEvsjOau3KRy0?=
 =?us-ascii?Q?EFBZn2UWHauxKB7UkbFdoXWk7eR0Yv7nZWGfU2vB8uyvKvqzOAidcwtiWgxh?=
 =?us-ascii?Q?tPsNe/yn4pOplmi4EuZpHUaEUMFG+W3IrwC2bczC7pLlroHSWy1+86D9MIgZ?=
 =?us-ascii?Q?O2tnwiRBybxqOQxwb0oP5qOn+TBB/4jK8YVAfEr+dBZBGEBcu2Ee4xRIujue?=
 =?us-ascii?Q?G9okubtGdJny5u4PZcKL6qO9uuyS5AEDB8ReQ4NceFXP5ZXWH/yESCVRYW4l?=
 =?us-ascii?Q?HjMnnD8i0bYnP05i60bel2/DrDvZLBCNFpZmSkYJkWkySqHTVQBlZeNVSGXE?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc50953-d17b-4864-8d5d-08de00155f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 11:34:52.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvNBmGTew151H81p97/hwx/l/v8HEFj3kCfgfWlIzWBA5p1COxwxZ/br23nJYn+oiBpkH/IiIgRh/L3OMYmQBrO2Nw6vOfuNZQ36+Xr5miqG3bqpfU50SVxDA4DUtYqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7795

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, September 30, 2025 1:03 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsa=
hern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel=
.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@netwo=
rkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.=
net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuha=
ngbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kern=
el.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@no=
kia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com=
; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_=
Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v3 net-next 00/12] AccECN protocol case handling seri=
es
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> Hello,
>=20
> On 9/27/25 10:47 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> > Plesae find the v2 AccECN case handling patch series, which covers=20
> > several excpetional case handling of Accurate ECN spec (RFC9768), adds=
=20
> > new identifiers to be used by CC modules, adds ecn_delta into=20
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is=20
> > available at
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FL4STeam%2Flinux-net-next%2Fcommits%2Fupstream_l4steam%2F&data
> > =3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7C228d6b16774840cfc5b2=
0
> > 8de0010f394%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C6389482699719
> > 97461%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> > a=3DUai2aLfUVJuJC3NWu8R2rGQ78XWYFsjEnVZo6u%2BSqaU%3D&reserved=3D0
>=20
> This is a quite large series, touching core part bits of the stack, and w=
e are very late in the cycle - finalizing the net-next PR right now.
>=20
> Let's defer it to the next cycle, thanks!
>=20
> Paolo

No problem, thanks for notification and we will ocntinue for the next cycle=
.

Chia-Yu


