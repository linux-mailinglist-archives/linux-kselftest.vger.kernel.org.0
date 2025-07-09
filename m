Return-Path: <linux-kselftest+bounces-36794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C84AFE245
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F03F582B4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1B23B62D;
	Wed,  9 Jul 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AZf/pGdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE423B615;
	Wed,  9 Jul 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049035; cv=fail; b=D+ZpvZ2jVbqFAllEzR1M0HEzCk5pBBF8tw5IJuCQfOexIbp7Su2mmhbXPUFaXvI0/8Q1m18XKtNrnR3rnDM/E0ZvPnOUyeYOjmcryqHxnDo34g++2zbZ7ZCifsFVg+0fNDMUDaYumxq/n2JZo4fUEXSTdUAxSuthDDMka0wSMJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049035; c=relaxed/simple;
	bh=h/HZd0FDRbgodq04m8xqWTK1DHBGoPmvd8UUw+WgkbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HDPjk+hWcGc3zVkKPjikE4XwvNNHgrA1xBczczSTUte/GVkBXdiB7sHmckoP6pBWJy2Oq21q/f7NXjD/3VffOKJ85J89mZQP4lfE7cLSWqOXb49jtjc625bfZq+T1s7yhq8zA+Y89p2z3YMLoSso77CQyh4+FTt5tueAaDGz2cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AZf/pGdb; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjcwwdIGKAyCCI7DsrYGWRlVM7umQQaXh2YPp5AKyyH87P2LLjTn8duDEHJq238u8dHSOJcrIUhWfngjYLYhw4FIAAisjDkM1DI7ccw8ylm1hgrvAsum3pVrIndo5SnMDwB1glzTwRwFU6RM5rj1YZwML8fAXW4X8dfNQbPv1O+q3/ZUcXhHXu6dKX1eVSI2IPmS/oLuiFypBU25kYav7FA2PIWpkjUi1847OHpHuFqUbUba7EdYmguDyYyH2/2GwHOdo0warztcI+b8n/xkoYOj5MFSX1hHwcX9OVgGxtnQCz70e8mMHDqU932qmAkgpuPMyZt+bBSJOPhIzpfAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FCP26dn2G0fNgBcfeFvWocemVAEwBSSYlN5YmLrdMc=;
 b=o4C1EHzmbAMMRtNAOrmdkOeX9p3gWs3JZRlNtmPuz4YSCn8XAe9+2679ji60Gs2tNgqJxwnfyewzIX+jszcNL9qc2O4irrHX7/P0K7jtL3Fhsr/JxiRmnaUd2HOvVkVy+ahYjqekFLJ2fFwyTPpzjnRY8nSotQfp9IOvcqrNU6cvvIvb7xH+0xtvj+27EeenBQq0zsU0Sj/9VZvgRnK7EMCS/EKea5I/HTahBfzYdgNWax7HCrpbgDACU8KLg2Vz9Q9t6HoqcqiOWI38j+s/Eyop2Gx8P/yPvrot4Bi5TMhDiXmX3WDdHRtge41Leht46VEdrgsNlAKrYvtI4Vhfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FCP26dn2G0fNgBcfeFvWocemVAEwBSSYlN5YmLrdMc=;
 b=AZf/pGdbAuk5IzIh6wDOoLNTrh+38BcIqX/JLsMT3DBqMJHGqAF6ymIE1ThjBckg/DcikKfe5vceROmCscSIiyKu5yukamd3DjM3QYwsnyAVM5x581l4Z4RmppY9QCX9l08kf0goIMWpQNsf/FW84DvDjukSron84Xsmfn6Ixt+QNduoD/OV+k2QTAKkAw7kWkRSzUfMalzkhMDcgm1OHqc/q1JYJzqZNmxckNIDLb90KhTi13A/k+IK+NRoAJZItaFWxlxF90aeLT3pI1e5oecpVq07X4y/qX1CelDrW91G9XETsR2lFjihGDwKIRD76DXKSX6B9jcCoxRBvONC3A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA4PR07MB7119.eurprd07.prod.outlook.com (2603:10a6:102:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 08:17:09 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 08:17:09 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
	<pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
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
Subject: RE: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb6wFfiA0/kvNCkESHJ9jIHTxQzrQoEEmAgACltMCAAEViAIAAghHw
Date: Wed, 9 Jul 2025 08:17:08 +0000
Message-ID:
 <PAXPR07MB7984DEEC5D4DEF626359C2ECA349A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
	<20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
	<13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
	<PAXPR07MB798488E0305080CE891E8286A34EA@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250708173038.46d25979@kernel.org>
In-Reply-To: <20250708173038.46d25979@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA4PR07MB7119:EE_
x-ms-office365-filtering-correlation-id: 38f847f9-8cdd-4c6f-b580-08ddbec0ffb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iKVRT1/DLsb717VFq9/2FZBUP4TeSO2n12sMRnV3aPPHx/VKZn6Ji828xZjI?=
 =?us-ascii?Q?Pmb2DqFZWxu0yBZPFxIkvtuIxo1FGtbX8CPTmvjrXB7zfd+NHssFvgT8orRe?=
 =?us-ascii?Q?XCRUocWa5WBmZUeojJmnY4NK6/nZlD3ZuwvbbFycBqxavqQ40kBZmrQfkIAB?=
 =?us-ascii?Q?CLrduxrIzdCIhVP7SOU6rlr1Kkn9W2LMZMUqAfAs+Z3M/4v03fVTGKBmWPXa?=
 =?us-ascii?Q?UQubRz9KGtocCIKQ1/XBJBl3H7WvTHXbWzNLosfxRpb/MjSWellR1Qo8eWNW?=
 =?us-ascii?Q?4g+yhvYMXliRf2BpD/XDI2UuftGiIYnw2JxarIVDCkHepY8O09Wg1uWGZFO3?=
 =?us-ascii?Q?BvhlaenYLCJ3cIPFmOXpWZSkrFWfGqZQVjhL3yExxQGHVKX0aDZjQsQw2gZu?=
 =?us-ascii?Q?gk5i6zl7RCAovvGHPp+cwWoXU3WkEr4o6z0XInu40LhOd1rFWHjuLH5DIfQk?=
 =?us-ascii?Q?zbrbNgfV/iNzKh5oj2BWN5Q8ZEkrlJfUVx4OLrwL0sBR7uEkcxwbI2MfDI6W?=
 =?us-ascii?Q?TZERHpfC9VDFHVvbDWQhVpWQn4VokZidH0zyNveeMzreDa52QIpSv9QE5Vr3?=
 =?us-ascii?Q?wC7G5LvZtI5wZnN9SQCog8dMg4Vk+P/LDfKO7/32rEJoFQyT5UFwP3sjuMle?=
 =?us-ascii?Q?BwBt1rSyHvvrKMC1F92D7dKy+GC+Epng0kS3wfYVSaLDzSkLHRkPC6yVlFkE?=
 =?us-ascii?Q?8TKs/+pHOxXNJKEUrkJkdzX+d8oKr5czmt9Vw8XUB/PleEKp06NnPxls7SUl?=
 =?us-ascii?Q?kMc0Idu8xO3+9ucL68AWKfz9ca7sUkETUHQ/wk7KkWXwi14fxK2IDRpTY2aL?=
 =?us-ascii?Q?Bwat5UHTcn23DywqolBlXg6lJc/Wee3fJSV3i7UzIiM+EQ8Zz1Q9NNcgdXGO?=
 =?us-ascii?Q?EWZ7uP/Vdzn09kI6sKhQdh3ZgEAfGBqxCmjQp2nKkfXyj+jzpdr/KVfhCVy8?=
 =?us-ascii?Q?FmESKm4yV0ev/NOIhpjYQc1b/+Ey6JK/Fx9FVE5WHf/MVdJ4bV/0ykAJxc/J?=
 =?us-ascii?Q?vnRvV3GpINYU/n6KOOFkCCzjZ+kqDJ9hgIf/jxVFHOaGeoQL8FxT+lpC4pcp?=
 =?us-ascii?Q?3xmueWUYhG3HQxvQzlWFb0uBIBSNu+r/f8eJNeXEPDNNC/dHfyB44cdwYz6/?=
 =?us-ascii?Q?kMm5OS1h9ZpSrE17mlTNQIOmD7Qki9iX59gVPXAFiRpo8he/w1c7ekBkFCRj?=
 =?us-ascii?Q?bMOO6mmvdYCnDuI6qqFxAMZsW5O3djRFQQYLihONtb4za5BbvkiFuAI1LIxw?=
 =?us-ascii?Q?RxYT1nBykhjmWmKsOiFlnlwm0Z9mznq/HC0VKwsRW/T0tQbNSz+LSzRkUkAc?=
 =?us-ascii?Q?HJtvvqiXfe7qjOENA18vARfKTCjoQE6yHDjZkpXD26DFHMtCVx2AeV9sLWzE?=
 =?us-ascii?Q?vDDSbwWHvtQXfexBsaQnyiGDvqU55gkEOpULJE3pJhoQq+7iOtWMorOGqKLo?=
 =?us-ascii?Q?aUyeZxRxuQHqjgIfBRLtjoNRVHJZiefnZS4NaYYQooWdYIM+C1ESvMjCAR2S?=
 =?us-ascii?Q?cy85zTWYq7O0OWU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y4sFuZfmMFSWp/xtjlSIC9N4iWH/sEIB8rorB4kT4BTNsmVbmyeW6HpEmyhu?=
 =?us-ascii?Q?cWcD/ty89fmdpDZZOkhyGmW8fQ7VJ35nYmt9u7UgjQAuNv1Y0n+njVpupemq?=
 =?us-ascii?Q?qvmzEKbd/wkfJ1wiE/Z3vfcSMtYd+oB7MU0/vk1752qJHI5OaeZozMrb6dDG?=
 =?us-ascii?Q?L7hjdID78qiNiHD5HWpX8h4Zs6l0Gzypy7pOTv+7vxJ8Qf5JvzleUXaOF65W?=
 =?us-ascii?Q?3W5P+TxLZ60Y7a+xIuGoW2hoIPIcVxHfAj7dQUBIPI7aRuV/lNJItTZKnQSB?=
 =?us-ascii?Q?zmr2qxb3q+B/MTiCTKL6vLvjqrs6XgPUCex4/ogMhqMzhUkuKnxDdCFW6OZI?=
 =?us-ascii?Q?yE8wMxYde7M9yf/KqXyTAA8B1sSHvNW5aO8QBwk91sHrQjov3jR6s77L9uyg?=
 =?us-ascii?Q?6XiS5Oe7tc8VSqbnryKDzsLwv3O1/EVVVpUllgcgwgYVK1nfr+Vij3GrLd1o?=
 =?us-ascii?Q?xuyhqyDl37SQcn7opsgodrFLaHZoZnLNnsn7hEqCKn4ABS/bXdt90I9Fc7+U?=
 =?us-ascii?Q?qoZkQWah/CVktzEd4Nw1TGQV1nWdZeCktx5ZxVVR5Mq9vxuDYOrZYqyZt5Yr?=
 =?us-ascii?Q?Z82zGosd38VbdJYfCUzh+89KHj/lIUjE3egndQ6PPRIFhYxhI+Ks91dqtLFJ?=
 =?us-ascii?Q?IytZv28LMvtsKCYhvXubs/jzATw2e+zbCHHI3BnvDFMmnHxQYiEWZs0dsnb+?=
 =?us-ascii?Q?Oxc2lrfiQ1MNb3K84qXUsrvwQYh0dLo6X3+VrouwoTUCdy5rThFF99WSODLm?=
 =?us-ascii?Q?oxN9fWkXgI4FgyAbd+OWzr5F0rCf9w/pQb0J0D6ZFYE0XqhvF1ITFgYKIZis?=
 =?us-ascii?Q?g2q7R0WKlWOkeM2TD3mio4yz+52x8fcuw9runVUikqhcY72Zzgdtj+aGQS/E?=
 =?us-ascii?Q?MXoYlcGtgKzpGSVsuMyZR3LsO5hyjs8jH/WT8d4XJl50uonQGroc4F/4++49?=
 =?us-ascii?Q?jr4wVywHWJpWrqed65x2hAo78hz7IJ4SBpuSs8Z9g7f8mZUneoXhKDiKRKgk?=
 =?us-ascii?Q?j6+t63LTBpASXiBFHYOKDGQjGPOPlGIIqNgBp+IohbCrDWVXEAVGhkkrhWjz?=
 =?us-ascii?Q?Ha1VKYlYD/3hx7kqqRSc5acAwR+5WHC6hHMwyUlbgaDrZlNSC/50uDmCQ2U1?=
 =?us-ascii?Q?+bIoqjjfdPLovUfaozO3Zerubqzws79UYspKs9cCsBMxVBWF4bx9DIrS8436?=
 =?us-ascii?Q?EZ5r3/Ls8eD7Hbuv4W3MmxQH+SXPgCUJO1vOUdRTb/8RYa0cr6hGogHE3DZQ?=
 =?us-ascii?Q?oPyaQeQ/LrMddfLJ1PbVl6aDuk69JvIklXFPy8QkBhkPzYktzryDqtTCp42p?=
 =?us-ascii?Q?MzzsTusLWs1x6R7TBYSx97t24zEEMJmGAmHzQIyqGgduLjpUkNooyxAuOzHM?=
 =?us-ascii?Q?eWwvimdE/Jrj6vT+HHAK/KAsBmMkuslzeOaq+9axrORd/Nd5XtSPpMaa6Kct?=
 =?us-ascii?Q?Fn9ApM2iG/7VGmuLu7mePnLRmzvoga9hlv+RGwjjphfy52hm7wI/NShMwcrk?=
 =?us-ascii?Q?xwiLSvjAehyliq3EVFHd3Qjq/0zNZATMFTLa+y3PooGHJ7zs5qjLwO4iPn+0?=
 =?us-ascii?Q?xsUkWC59bixTIF1vyzhpLwT34j3oHKIb1fr2cOFtyDPKWMhR3l3v5De5P5rK?=
 =?us-ascii?Q?YQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f847f9-8cdd-4c6f-b580-08ddbec0ffb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 08:17:08.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz69Kw9Z3Bz6Q22rs6/SD/dl5l1hTdrAXwRfdMSC52qRyYHG6Fu37rHZyr8ulLbqziwRLwK5YVPdBQN6t9GSnfNOTDasfzd2GfEkj67UhpTvuozMvK/gSXNPFdru851C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7119

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Wednesday, July 9, 2025 2:31 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: Paolo Abeni <pabeni@redhat.com>; alok.a.tiwari@oracle.com; pctammela@=
mojatatu.com; horms@kernel.org; donald.hunter@gmail.com; xandfury@gmail.com=
; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; stephen@ne=
tworkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemlo=
ft.net; edumazet@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhan=
gbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kerne=
l.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nok=
ia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com;=
 mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_L=
ivingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v21 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Tue, 8 Jul 2025 20:22:23 +0000 Chia-Yu Chang (Nokia) wrote:
> > The original patch looks like below, and I see the option is mandatory=
=20
> > otherwise it will return -EINVAL.
> >
> > Is this what you mean in your comments or you mean other things?
> >
> > +       if (!opt) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are reuqire=
d");
> > +               return -EINVAL;
> > +       }
>=20
> To speed this up a bit across timezones -- I'm pretty sure what Paolo mea=
ns is that you reject the situation where user provides no [TCA_OPTIONS] at=
 the netlink level. But if the user provides an empty one its fine.
>=20
> So normal config looks something like eg (indent means nesting):
>=20
> [TCA_KIND]
> [TCA_OPTIONS]
>   [TCA_DUALPI2_LIMIT]
>   [TCA_DUALPI2_TARGET]
>=20
> If there is no TCA_OPTIONS you'd error out:
>=20
> [TCA_KIND]
>=20
> But if TCA_OPTIONS is empty you dont:
>=20
> [TCA_KIND]
> [TCA_OPTIONS]
>=20
> Just return 0 instead of an error if TCA_OPTIONS is not there.

Thanks for clarification, then I will add one extra "int opt_flag =3D 0" an=
d set the flag (e.g., opt_flag +=3D 1 << TCA_DUALPI2_LIMIT).

At the end will return an error message if no flag is set, like below examp=
le:

if (!opt_flag) {
        sch_tree_unlock(sch);
        NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are empty");
        return -EINVAL;
}

Or is there any other suggested ways to do it, please let me know, thanks.

