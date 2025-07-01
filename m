Return-Path: <linux-kselftest+bounces-36146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D145AEEDE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C133A6DC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF2205AD7;
	Tue,  1 Jul 2025 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RAEAstAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB3191493;
	Tue,  1 Jul 2025 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348518; cv=fail; b=ZBSDkpmSbHq0XFsJm+kynKYJJPRNcPbZ0hBG2g/kTx/Tx80tvsT/IRtJo3AlMPvW0616e22LxH4pNYqH6zG0d+iJ0rbrx2uqszNOAoDHPnGJjYE1Rbev40pSERaDLS5VTxj9YBk6m3Df8SRJOownhof69kjb5Ytvus9vVgvLdLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348518; c=relaxed/simple;
	bh=TcKpMKbYSRJVSJ5Dzd+4Jz6xbTR5XLnhTog66g/FsqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbfHhkRq2Pgx0HOC9vL8Kh0xKrprtmUZf9o6zT0QkKOV+RZuu5POOPoLiAK825jY81fKJEnCdRvmYds9dLeOhUAFGtMP0CWPmwkElrKI2E1Qp8e+eCkVjsrVkucdX8xtPO64G2SfDGqaooAnUmdxnVMqsoGaFDMnJw8pF/+QN/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RAEAstAH; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxuxvvxyQ1Cx2MUp9quLBQxMykYJmS1ww98M3j+UUjQcaTOpruSKYwWlPMmRWNxTwJYtMh4bzMGxM5uAeyM4sOGs9i8pubHlQy2aiTiP612p6wSkYyRGhUio5EOIv7uyNCT7lImwjsz/w3cvaqYKcoVyahBgF8k0gg7OCA1R5P4ByHiNxpkn/OhaDx4fKUdAtz6t6DMKXZlfTUXwh3RkN9Dmg43iQoX5ENok0zIyOaH2LD8Ug0CsdniMR2Z2DZnYdgGs1IMjdGne+pyiDR+V91+Vjdd/FKjijJWyMkCQ28lWdnsFR/AOekmobMHqbnVc61r2LLolY2Zr4X2Gav/R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hOWYywfiGzf4+upeWDAAQiN9mWSVuee90jFsvohlr0=;
 b=GxzqtoQ6GZ4dNUjLZevuFCW9f78sR71Qe1Vd4xSqgMhE3OpvDj+hT3IXpXJcXE3E6qph4cNpxRuhEbVd85EIhXA9a0BPADASwnm6HQxl/xwQcHmrZT6d6M8CNdrIkj7TFhvwoSPjBYh+oiM0lTROOXJg7dAgZMJ/H1mVJlFvHY9P3CDmYBygsBBGWofFsB48jaqww2vMShAOuOSKp8e7K3hO2QphXG0WZsoPbi1EHQwW+/F7ddZod5L/3ocZm9YUOh5FM1pmUzdbU+O0XyfaeZO+U1AB5vU/VGGRFSuSa52J7kSz/oW5p4vCTRMcvNjhPEy0wAhKls+0bkQSURMB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hOWYywfiGzf4+upeWDAAQiN9mWSVuee90jFsvohlr0=;
 b=RAEAstAHad7jnuhiYvlcvMPZmI+vzwXftjbIMQk2tqtZ1OFaCkzhaCk7YsFiU29bL7JRAKbywavRXcsVM8xM/AKyEhOG/i/w9peDca1WeT7qVOcRwKIDRZrgZtEihOyMX22j4tnRUVqY8GHrdv2yzkqnmwdJIA3s8GZex4mJV973005MBfLF5Y5VuUrSzbSZAJGHmEFrQw//Bl2Z2tohlpZukfuHPn4d2AUfknhwI8Gu8jqdfHFesrRlWr70UJLnW7EhqgXubUjHxJARrO9sLRm7L/3RTkaN/6kShIu1iWFxJzF/g/LNYwWp0yhi9pWVcKjRUO6HR8H3RaEhnekESA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS5PR07MB9745.eurprd07.prod.outlook.com (2603:10a6:20b:672::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 05:41:54 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Tue, 1 Jul 2025
 05:41:53 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
	<horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index:
 AQHb4uNmCaO8PxZhYUCrH1BBViihEbQXr6IAgAMajRCAARMzgIAABBIggAAPVgCAAAsGIIAAb+CAgABeDOA=
Date: Tue, 1 Jul 2025 05:41:53 +0000
Message-ID:
 <PAXPR07MB798432A7A8B078F2619EB8F8A341A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081349.4c9d7976@kernel.org>
	<PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630092316.031b29d8@kernel.org>
	<PAXPR07MB798410A4142386C43B2E0B1DA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250630164309.724b9ba1@kernel.org>
In-Reply-To: <20250630164309.724b9ba1@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS5PR07MB9745:EE_
x-ms-office365-filtering-correlation-id: d59dc805-bd9e-4b81-2b0e-08ddb861fbeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FOSIpK4XEg3oo0ndidBLhNK+J12tF5xhjyqp3olu6oiCzJnNAzO3fqD7K9PE?=
 =?us-ascii?Q?PX1FJ269HoxvAZxAzE9kjIxudo6CdFJWPV8hcl3+rWANZGL2JNO6PUWbUQjr?=
 =?us-ascii?Q?Y96WJZCAF8Oht7+6HwEDldnJp6HtQam2JC8dhjY/yDkmdJcy3dlj/4fNwzOi?=
 =?us-ascii?Q?0g0JSb9l8lNP4UeQJ8Ap51Buyl/C1SMltt/R9vbtDpOGM6g+pZ0sB3nIpkRV?=
 =?us-ascii?Q?w2QktLWS2YmiYoN4aK4enlWEUJpSe6nFcYCwvQhpS7/KxL86sja6lSCHrAkz?=
 =?us-ascii?Q?GOQVQEHctW/Tuz8yjSPcZoZBfIYOCMMC6m/IHifd+T95cuzjOMrQuOpUaVDb?=
 =?us-ascii?Q?qBWWUgynR1z+mmn0l81FuOYTP/fhQVqG95ASILS1E8PrL92bKWzHtfhBMhFQ?=
 =?us-ascii?Q?CqthYAr3uGRpQLTywK9R03D2nsYh5zhQFjATvFb8y+vT5bRvDQg4FxjPn5cf?=
 =?us-ascii?Q?oqnE0XsQ/xPzhYKCB5TUP6ONkwt0PI4PDWJE3uwlvypddYiT6zHU3oK9ufMO?=
 =?us-ascii?Q?924FEsCKtzgAmBGwo8opd5LXMMcPe3tdmG4c3fTHxQr5Nc6ERKs8sMCekLBV?=
 =?us-ascii?Q?L+C6wFD3Y+s6eWua9v8ehkY/jr4zXx//5kiSP7bvEBsit2YgGNwyPdtzhAzZ?=
 =?us-ascii?Q?atViDQMG5IPeAxESL8uk+VXMxgRNLqFshczG77CTDvzpKV+z3NwqtV/DIbUE?=
 =?us-ascii?Q?FFtZuhmXOwsv1WNr0jbCXcmZTSHioFAcqL4L1saU6zMgT83ckazEzMbNJRd7?=
 =?us-ascii?Q?2RFaKVIIonly38qD8DIy0xQcT69+YBBnt58KO4m24ptF3yWRkQQzZ/U3dRmB?=
 =?us-ascii?Q?tnH6FWStnsPGHvGv+OLjyovlTEESUQNWuSujEGkj/jHBUUlVFwWVlaKA/Jz6?=
 =?us-ascii?Q?GbpzRS5H9RY+k9P0Yc2hmtYoyDW6vuKHISmckzZKqgz9rTsxFr/j8f43vTkW?=
 =?us-ascii?Q?sOSDh1uQg8HFsD+GBpJGvIvtNxNh00bkLkekeNQRyv7bs8xI9qguCUkZl81R?=
 =?us-ascii?Q?kGTDz7L/uPJbPucDfEfbctzBqH6PgRcHVKUNNgHOvEGIcHrjS9iP28unGxsO?=
 =?us-ascii?Q?54jImmQCSLJuo/TevUyvifm/o5TNKKAUSHoLQ1M/JcmB/Aacrirw1KlEkqcQ?=
 =?us-ascii?Q?LdWS62mWtawwpeRXDIT2fuuQPoLDC67xZlikTe8UnGBYKmRY74436yUUIYsp?=
 =?us-ascii?Q?Pm3XMMdMcHD6SnRaF+WD8tM2xyIWdtEG/EpwYnXItuB4s4W5bM+WP2Uf0Nhg?=
 =?us-ascii?Q?CD+WIq7owR6SfXW8TkVWogfeSNhMTJtXxT4PGyM+R7fY+LXJRaB4b2nURE48?=
 =?us-ascii?Q?5reWxmvcykgGNAGJeAXR1mIAU5oXCsrujwrkLucqx4J0elIurj8JHIMdmYgf?=
 =?us-ascii?Q?5SPaxk1kLTILiirW0pmWCbFi2l/ktLe7ucYg+vLLOaIKnnxSsOMGwnq2Gugg?=
 =?us-ascii?Q?9y5TMQVHgO4S02vXvltbfVYQ064DHFYkRb5+YtSSPvD+JhRhn45Xqldgs1j6?=
 =?us-ascii?Q?H7dsslghcxdkqoo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pJvfeif2Co+xoht7sLJkFKM+bbms4O1a6nA8T3r2QLeOuoK1+yY3iNC6mnbg?=
 =?us-ascii?Q?4mSOfCCiBRUQxX2O7a9hVPDa0oX0tmmMj0qjXPNWmHlOj657HuDavMCjqcYo?=
 =?us-ascii?Q?c2dGplm4EyJG8Id4DX4xSxgnCSg8DD4ho70zYEgFmdGyQFBvXzh/oID5mEYd?=
 =?us-ascii?Q?8r6dAbNfM60P/S9uSFZA3SzL3HoO0LnPUMs27DpbPmt5hsgmPTI/5HEfsuxi?=
 =?us-ascii?Q?6FXj/5ZbT/tKFTBh292PO2edyGTjl+BHVaajv0G4csZk7oJACsNLAlZPaisM?=
 =?us-ascii?Q?dooyG4ReqvZk5ckuv2MoLK6OTGBkuBlTH9+5HM3BC5gTpmSeUIb7MjHXAer1?=
 =?us-ascii?Q?DWacVVhmbQhIIrYjyDGXpOhRwOtlVvjPTFFm4tJvJjPyQ1ySN0xHHCH5yTW0?=
 =?us-ascii?Q?Eo5ZMNAxgb1H0UttlDPrhlqM8kD8P7vayTHxnnStqB0ZOdeE5gvYiZG8f//I?=
 =?us-ascii?Q?1zNrmgrWGpJQa+m54NkgjAaD9N6FSaUMgBeeu2Coyjhov7OOl5NKDG1/Cypy?=
 =?us-ascii?Q?Yl4leX5LcdD3QFePwyWnMXA7f2c+1CUewPCMG+c/uB+R8yAvfzntP7HJZaf2?=
 =?us-ascii?Q?HTOCCZj0HIKjIc35UxdxAW2BG0gF2eCy5jFTzkKjprMicnCIK1FdX1hrQLV1?=
 =?us-ascii?Q?4NCyAfXv/sJ4FUwDcaWv1axRoSjPF5wwe61Nve6KnOpBUfdTXYXfkXtJew5R?=
 =?us-ascii?Q?XTemzFxk7tiIlANZOBi/LbNxWdMmP1abU3f9UBIjXkl45i5ckGnzzZv5hZFk?=
 =?us-ascii?Q?xefd5J1lsXgsJVntlAnviETotntJk8vk4zVM6AObzCPouXewDrcL77j9uPLl?=
 =?us-ascii?Q?WMYfUvfdUeYku625Jqxoh88fpm3JN8RoatEK3EuF1j6eo/euqEI1qVKQoa1E?=
 =?us-ascii?Q?PDuKBknIrgHaORGW/c5L2m8taOzU+rGp25ePwWYYeMqGG6oN/thdMYhZwB49?=
 =?us-ascii?Q?Z8ZXTi5Gbhe6VSO37vuvUkmXGM6Pp035qvk8yQozN5SgrYHNYN5GrScBJxBB?=
 =?us-ascii?Q?wOlqBfhFoeORolKkdqOE3paF/mGEcT0+k8slesEDychmF+gA62bhWvYLuzNw?=
 =?us-ascii?Q?Au4TBa0T4Bkdkfon7PY3JcLnoZBmoXS1YC9ClgXlG5ugzQAgob2vgQehH/jo?=
 =?us-ascii?Q?eRgMJqKsj+tbQMvcAJWXDQP6X9e+KAv2IHGqzlCDMW+XKbhmWJ+CpxZtPC3H?=
 =?us-ascii?Q?1BlQaDfobtrQZFsdNIFUXA/UJ/dszrluoBKh2eYkAiS3wuoceYFUSl9McyZP?=
 =?us-ascii?Q?v1ebx+8LP7Ss97KMiedPFanKSsV+uvkLKJncEP+tb9H+IpufXVWRtrjWUSRt?=
 =?us-ascii?Q?sRZ2g0ZcswkuSx+vRReiHYdVCnMR8rO6mw7dObYutDcDxvuexVBagf+haoOj?=
 =?us-ascii?Q?WaiYTVnxSyCCIVYAK41w1nbHPrSbJRM3rh36GCQtL2KXXOWu2qp5709HojUW?=
 =?us-ascii?Q?MfZXZvUhWCcAS1V4DK9a1hZZFdh4Z4GBr4pkTwwqGXYsLW2AaMiJJzuC+zT4?=
 =?us-ascii?Q?b450nKlKPmOgNZmeBLzaztLz7H2wxjHFo5iWtimAcrj+o5nmzg39PV2FVGn/?=
 =?us-ascii?Q?FXk4xlA0cGm0MMe1wqq/1xavbW64itXfPoS11YkNyUbcp2nRwAyhkl6JoM/U?=
 =?us-ascii?Q?cQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d59dc805-bd9e-4b81-2b0e-08ddb861fbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 05:41:53.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnUNY++9ykxh+wTDkUHVyqaiOTCZG9GNGfSt9cvNa3PMnqM7QLF6rq0c7NgIPPzvADLdhjwdKmDXzt+YQx8E1LK30hLhHzzUK1YkYHrxH+IBEdtwd8gIRXbC9H/RqMpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9745

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Tuesday, July 1, 2025 1:43 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: alok.a.tiwari@oracle.com; pctammela@mojatatu.com; horms@kernel.org; d=
onald.hunter@gmail.com; xandfury@gmail.com; netdev@vger.kernel.org; dave.ta=
ht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; stephen@networkplumber.o=
rg; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.com=
; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwe=
ll@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.c=
om>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlew=
ind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comca=
st.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Mon, 30 Jun 2025 17:04:56 +0000 Chia-Yu Chang (Nokia) wrote:
> > > > This still needs 2 WRITE_ONCE even "step_thresh" (NLA_U32) and=20
> > > > "step_in_packtes" (NLA_FLAG) are replaced with "step_pkt_thresh"
> > > > (NLA_U32) and "step_time_thresh" (NLA_U32) - which was proposed in=
=20
> > > > my another email.
> > >
> > > If you don't understand the question - ask for clarifications :/
> >
> > You are right.
> >
> > Could you elaborate on the orignal comment "And the block under which=20
> > I'm responding is performing two dependent writes, one to
> > ->step_in_packets and the other to ->step_thresh a change which is
> > definitely not atomic.."?
> >
> > I don't see we access the same atomic variable multiple times in a=20
> > single expression, the 2 WRITE_ONCE() are in different expressions.
> >
> > And, in the last WRITE_ONCE(), what we access are local variables:
> > "step_pkt" "step_th", will it create problem?
>=20
> Not really a problem, but what I'm saying is that I don't understand why =
all the writes are sprinkled with WRITE_ONCE(). You take
>=20
>         sch_tree_lock(sch);
>=20
> to block data path and the control path is under rtnl_lock. So why the WR=
ITE_ONCE()? WRITE_ONCE() is used to annotate writes which can be read concu=
rrently without holding relevant locks.

This follows series https://lore.kernel.org/netdev/20240415132054.3822230-1=
-edumazet@google.com/ to use READ_ONCE in dual2_dump() and WRITE_ONCE in du=
alpi2_change.

And because of one previous chnage request (https://lore.kernel.org/all/26f=
2f366-aa14-4879-978a-58d46f9d83a4@redhat.com/) to split single dualpi2.c in=
to 3 patches, so you can find them in the 2nd patch of this series.

What I can do is either move these WRITE_ONCE also to the next patch or mer=
ge these patches.

I would prefer the first approach to make it still 3 patches, any other sug=
gestion?

