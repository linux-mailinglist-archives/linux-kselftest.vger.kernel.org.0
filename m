Return-Path: <linux-kselftest+bounces-48987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E0D21C12
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 00:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC693020687
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B538BF61;
	Wed, 14 Jan 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Sui7eDMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015752FD685;
	Wed, 14 Jan 2026 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433176; cv=fail; b=uaG63VULUWINpXnrdcKwoT5YAhnR9KU8ZxJJ3A5KWGtvbu65xRRY0ZLceOur3PuzMD55T64RA2XZtkY+RoqilKZlCB3sn95nNMKZg5uPOSPZGqCITIYa3sF1Bgp+HKfzpVY8T6NMKjhyVpg5gpckKovL75wnau8wp7UTWU3DPy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433176; c=relaxed/simple;
	bh=yEXRwKaHoa53cfMVeeElLFo6/3PgZVSJvQD+URGbdos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBdKmSTC8Jcvnvhkw4Yd+myxYA+a8LVB9NLc4GdaWCRsY/C84sAKy0R5g2n/8Gv8hHwfQJ/FP5kF/8oqrT3ctRchPQ056ESzviGHucWrdqp33ROlM5CAn37HdBmI4uiIYT8y86ujCeV3Otrp7BaZcvJtUIkTdnJ0dI1UDtJrZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Sui7eDMW; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/8ygl29heSdE8kg8grX3mVFRWUgkD+OJWVcq/hqrgRhpqj46MhfHhMUvPYHGVlyJ4ENSyuf5+SsIRAw70X/tJasE91K7ZPb/C/ukoT4DoEREq3J5VET/tI8w8/14RcCapkPXuML1jisTeoTquS69Br2OopeAdVsOBDvvPv3aJpbo6HN/mFD6AhtIQMLirzZAyjKFZrnPKqviXzAqL5zu68i0AMegg7Kn4ZnsZBZGEKolmG4RdyswzU7VATOhkzgjSSaWtHFceBzhXiw5U0d5zIfhl1oRcaWdwTUjkdTujBYOUANZ1VVhYh5hlwxP1F+N4MTGQrw5VQa4qYUQ622dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEXRwKaHoa53cfMVeeElLFo6/3PgZVSJvQD+URGbdos=;
 b=f7xylWTUEC3XVPll63CxYjWgG0Rk/zlcsddxOaIcfDtVZiYC60RqECa+0I3O4a3B2Wn6tGrZL9Tt1l/EOfNHPWcEUKEsIlnHZSTWOd4O8nBA6VMDhLL5ltmZQEuYrSPfOdFKVCbud8QGgGZR5aDP8rxDu3T/jEbFR1h6E3F28kIbUbawRnmRKUD7+5wseSFlNLHIt7SiESpu99E57V1eRHBwjIK9QkRMIicx3KBG2vdH2Ag3TGK8getJ4LUbmqw2ytSOaP5jOpjROKUnRcrEvWKkgNeErJi4eDR0Hjlai4uLtv35fjdmEshKO5OJdn14ak1tJOmDG4TyU6mFaeVHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEXRwKaHoa53cfMVeeElLFo6/3PgZVSJvQD+URGbdos=;
 b=Sui7eDMW0UReyet6mY4QimAUSboriVvoP9gx1/9OzyW62bnAIFhi9apVdEu93PgL1K8UZ4in+PQEKSbS1U2+hnI+BHVCLsrwyxvv0jjbNm5LDBELaE0QQTbqL4fX7l3xmcCn9vievhtHwpdB44mJTUmPNPMrdMbDRn3QsFISm6RRdIX2uJgB19aUd0LrFJmhDIYRoTHS0sWE+7dSBol3BNnnhsofanDH6bP8C4Vt3s4LhW9YydUiHCDkRfhwkwihSfcMY77PG8GVMMqELdkfbYjqaZ6I1rg1B+cc37CDBPMJ/56uhMiD/9qu5TKUI+UXwtn7lg+YSCcbTKlkxtsPGQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PR3PR07MB6905.eurprd07.prod.outlook.com (2603:10a6:102:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 23:26:00 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 23:26:00 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
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
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Thread-Topic: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Thread-Index: AQHchXLvLZ9jpF/GoE2EiLZqr4hX4LVSS/cAgAAA3dA=
Date: Wed, 14 Jan 2026 23:25:59 +0000
Message-ID:
 <PAXPR07MB7984E23DB685074239202CA8A38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
 <20260114151346.734001ac@kernel.org>
In-Reply-To: <20260114151346.734001ac@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PR3PR07MB6905:EE_
x-ms-office365-filtering-correlation-id: 792d77b5-a32e-45c1-cea1-08de53c446d9
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PLlIw5pC/cXXFlnjXEzwnwya27xK+UKHvvFyq8goJvbCpZSXr7sg9E4KfnyQ?=
 =?us-ascii?Q?ZQuPDiPoD6vwXCGyWr/eASOu6TL/Xx6RBungEgvLQOXj5QGy2iEMa8aVUqwe?=
 =?us-ascii?Q?7MZFDdqN27J94Ewpk+nNp9CBOSvcSA3FQumj6vYAWIaGUgo4edUTuDt4cQuv?=
 =?us-ascii?Q?S5pTh+JlWOSkvvqboga0LrPBg1BQ3zsns3foURqb+605vFoOwGs8aikn5by3?=
 =?us-ascii?Q?VxCi0643QEvQN6OAxSNRj/9axdOdM4sLx7nlc/uG5GwmFJAZR75/EPTywT1q?=
 =?us-ascii?Q?A/CT5tYaG+5zzGMAV1KjW29SI6t3BtQIaVdvpmYJmmXFIMCIm/KmUlclP0wV?=
 =?us-ascii?Q?oPjg3J74OPLufKEQgIWVRaC034EBKWSEWOylyAi1RHksI7I+0sC1U4SVh4pI?=
 =?us-ascii?Q?XzTggJMAqRSk3t4NpJ3W7yvq+cLOak1Rhd8VkBDiy4G7/vZ/M0X3qZJc1fY+?=
 =?us-ascii?Q?N+3PqsaA1Bx+xXDzeAOg9DSw8mcLmuYaAhN1N+qcJE2y/jRkOPNAPgkDEUIO?=
 =?us-ascii?Q?E0xxGFKpeRetwQYwHJgDgSvqHU7VlFs3a7lKQbSmVrQ22XYFAuxh2XERrtFa?=
 =?us-ascii?Q?1CzyDhjpuc9AOVqwRbigrXSXQuqulyMgOzr3lHJPn19NVGLOoNAyGS4w6lRR?=
 =?us-ascii?Q?j8uakoNdUgC13P+wj8pc1xSitB+6pVfIstEGBCHdhvKqfGn6GIRECPi4lBKO?=
 =?us-ascii?Q?DLJyG4fQx20YXzsOTNR8q4tP0XvGKPZPSS9pWko41Cadlmar+9SIBMebDuXh?=
 =?us-ascii?Q?++yhT6cyT2qH1Rgks0tYk/3wZwe7iYFFThJZ0rAg0eU3HYVU3TaLzMim+6ZU?=
 =?us-ascii?Q?xfT4ApJ3h0axYd7ug+mDEMStbHbu6IpZmwUmY7LRRgypwLv38PmNBuHdPX0g?=
 =?us-ascii?Q?Ozp+wu/GdnV4OVPQwyTgT47Z4bMEOdum3nB8erNqEGV9xAzGPdGC63jm+1HI?=
 =?us-ascii?Q?FucXZfit0N3YlTaovPsvQ8Mtuu4kn32gTyb7LompKIKZiGDTJ7i0EIPQAVSG?=
 =?us-ascii?Q?5WOaYu+MiFb/6WivEyKwZhXtZtAvX65sH7IGgHopflkZDRw68sKM5Nvjj40d?=
 =?us-ascii?Q?s46O3DkfQEiWSoUNtj2/427OzMdcI1KrbwkqUa0iSzb6Ha0f+bIHcnXgDitK?=
 =?us-ascii?Q?TzBBmP5G4aXMZI8k1GyP8PNJNxzLJZ7xV1BnzDC91kvz8hVDklBfTBMqKYoN?=
 =?us-ascii?Q?iuTJsVAncl1T8Fs28GuW6nW8P1ih8jaPrhKSX8DS6NnzjuiJKqN13CD3yyK4?=
 =?us-ascii?Q?wShopZbOn1DA69O2yZvuDLqojrMiyEmzjC3qLcp0Ra0V5wKXiBwfolKSO5Qv?=
 =?us-ascii?Q?hCjoJFce0iQdxivccUvX8y7PC2RiPKaitjmEtg7qbu+jcWsQ7HkLJ6Nmu/Pp?=
 =?us-ascii?Q?EqthnBM4ZBjdCjD5YK08Z45bCuFBV2gpqMYioZvc9Nf7W4A81YEegZuzTpcy?=
 =?us-ascii?Q?1IrtSc1jFqJM0hAATgmEunDz9//hkBHkMD4zRnIt2tdSKEFzCML6WOt1/zF0?=
 =?us-ascii?Q?G8TQiLqzp9R3lZMn0JAtHTnep8e/0jbQg5W5TqGcY8C+TP4g5awKcb7f44/x?=
 =?us-ascii?Q?9oLHMtSl6zKOaJLSvNtYyNUoYVItlugWarmxBZC9DHg8BNbP5gUc1eDxbdQH?=
 =?us-ascii?Q?ssPIT4PUEy4mqoFR/RTfvUQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9NWkkwWQl9V5vFCrLJ/yuz5GUtDVsp0/JwyfVsuUmCTZ6s9gG5ejoofzwi9p?=
 =?us-ascii?Q?9EM3EMvKnZ3skBJW40r89FrZIuxK16NIAkyxuIJWbIiGkfHK3SOgf0sr+5nm?=
 =?us-ascii?Q?2Z4nXka/RPV6HC57pmUyYjI0QRIQpMLrOwf4qhYY3O7TizUqpRla4vTF5JNy?=
 =?us-ascii?Q?Fd0eSwVQcvM7pQaHIKLLh7Dt/w2aasmtiVX5+6hbo7k+abTT0gv+bI0oPMJc?=
 =?us-ascii?Q?hDEDeyCLXoxEyvxeGjyhYqobi/imy/nvScDi7/ZlfhT1khXf71c/tAKQobZ9?=
 =?us-ascii?Q?0zeLb4Z9u+veC/BjjyulSFUbeMlJ7IaM4BMam5cmjn/MCdn1GwUhAkUCECL5?=
 =?us-ascii?Q?a5ankqh47QLkifvpPcRYsW8USo9jktZZ/2qjR1FffNlyzPGO77jLvvYKTEjl?=
 =?us-ascii?Q?fd8jcgVLyk0VBq+Xa9mGwMiqXfYxqeA6y9yjEVnUA8PNIottOCycuvRWP0Q/?=
 =?us-ascii?Q?H+bK08Z1KEzc2G+pV16Gq1Ofh5jI9u17DDJNrK5zqIQ6x7VgfvX3ZbJUc16b?=
 =?us-ascii?Q?+K4NDWmTh/lM7QyjQqjrEsudUb5c67yvesHhefKyRUDC/msTUN1fkK6paAoD?=
 =?us-ascii?Q?0LFO4aF9GTKuBzMxQOGuYNXjv2lnBuHxMGk2mqVX/pgcrft1rqk9B48OHUgi?=
 =?us-ascii?Q?djVxfMOwgktEWrETDnKaqI0MUqOG8cNQ+ShqR/fFOpZQtvVk6iVgXBqaCJhM?=
 =?us-ascii?Q?GUbhzunlZUrsN4i8WE7O17T+8If2UhiTdkTmyG1QX2BeSzxSGv3dUddk+KXx?=
 =?us-ascii?Q?eBGuDT5L8f0qRTxGM0jf1vraN7/zkjokeljTZrVYXfYKv8XeVqZyE2ro3olb?=
 =?us-ascii?Q?bQPTNw/F87DhRDcisOfoIXiZhvRMNyGLCyasul4Ze0IoPJtTlaszeZmVdorZ?=
 =?us-ascii?Q?MORJLSt/UAPAHEAm6GEe6P5BVzwc6PJyPKJuEwXz+H6SDsAGBKWf+hcXT5JK?=
 =?us-ascii?Q?EqI5tcY5xeytmKqKnvP975vRX7pX2W5zbz3hOkh3Nv86ohLi70wIt25WSY0Q?=
 =?us-ascii?Q?DBdPJtGVhTwAfiykiZdj/Fuj24F7p7HNlfT05Pek7nwiHbLwGX/Widu9+Bfe?=
 =?us-ascii?Q?4qDijKUw1YMHXtEXPPjBW5xJZk/hVCO40tC9x7i68JppgWl2Mukakbf9b2nd?=
 =?us-ascii?Q?+6AZcomgNjWMQVlCRFWXonbNSbmmgQL+qGNe0kTHhnzgz40Yz517w7+/43ED?=
 =?us-ascii?Q?vEAdqidG9F0JV428q9RFqFubp0JmXrHRA7Oadj95GQakzjJnqosCQotvWhol?=
 =?us-ascii?Q?+uretQRqKMNuLeThDEctB4f+uXZz2Qloj88BJtTZ8FxJTWCUXHkdqVj0Peoh?=
 =?us-ascii?Q?3anX06VTJZB8vP8/zo5oHa4nMXYpBzsruHAHrBk9MWE/nKeoM0ZW+zZ1t13d?=
 =?us-ascii?Q?yRu1OEhoTMs5ACWGx2XlLCRydCroLK2Qe5ucYrisK+8uislSGlD74bHGcdbX?=
 =?us-ascii?Q?yXzeivgXBGHyNQCJQeTXDkJyjJ2qaEpuF04V7YbsSWR7viRgN64Arwu5SqZr?=
 =?us-ascii?Q?ixiHjU5z3S+8D0xHCMS/L3Au6wjb/x0xv/Ww2eO4XtZ4lfhGctx5zFB5lFBu?=
 =?us-ascii?Q?nFAGa+Y4uZEq8cmBz+0qcBLbl1HKoXDGG48PZmL43mJpkDixRQW4CoaAECrD?=
 =?us-ascii?Q?JFKTOe3jMkA3dMdhSl8elf6/UlQ0y9PWDVf91d4zvD6oOleDPkW37BCrhr0L?=
 =?us-ascii?Q?V9ON7Ryc39xI8IPVotMDng7ECcjQQUuJHYKHai4IuGtdP5AHZ/xbMEcGQrcC?=
 =?us-ascii?Q?SueDU4LFlz30deIrPnuDpaFQs+vbq/U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 792d77b5-a32e-45c1-cea1-08de53c446d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 23:26:00.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHqBXgfOQHHK+G4jVDUbHdDdRsUFaa1zta+SI+taEqT2jtJzmypuK+kfAm+lzrHQycb5X/HfPStq5ApWZbCjKzW3H1bpyU3WatZOS0WoXlLAvDUZ7XjU4rQZYJMz2HL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6905

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, January 15, 2026 12:14 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@v=
ger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniy=
u@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.=
com; jhs@mojatatu.com; stephen@networkplumber.org; xiyou.wangcong@gmail.com=
; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunt=
er@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linu=
x-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De S=
chepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.c=
om; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshi=
re <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi=
 Goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Wed, 14 Jan 2026 17:29:14 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Please find the v2 AccECN packetdrill selftest patch series, which=20
> > includes 58 test cases used to verify the functionality of Accurate=20
> > ECN spec (RFC9768) under a variety of conditions.
> >
> > The used packetdrill is commit=20
> > 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
> > of the branch:=20
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fminuscat%2Fpacketdrill_accecn&data=3D05%7C02%7Cchia-yu.chang%4=
0
> > nokia-bell-labs.com%7Cbe1f1184a6a5443ee1df08de53c293f4%7C5d47175196754
> > 28d917b70f44f9630b0%7C0%7C0%7C639040292324032411%7CUnknown%7CTWFpbGZsb
> > 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjo
> > iTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Di0bK%2BtTQnbohn0cLgDDlSh=
4
> > vHeaa8jLpka7rFy8vo18%3D&reserved=3D0
>=20
> Missing your own SoB on the patch, but also -- are these supposed to pass=
 without the kernel patches? Without going back to check Paolo's message my=
 understanding was that you'd repost this as patch 15 of the kernel series.
>=20
> On the packetdrill side -- is PR #61 the code we need merged?
> Doesn't seem like it. Could you please clean that part up and start the r=
eview process?

Thanks, I will add my own SoB in the next version.
This patch can NOT pass without the last kernel patch; shall I merge this s=
eries into that kernel series?
If yes, I will submit v8 on that series and add this patch as the last one.

On the packetdrill, the used packetdrill is commit 6f2116af6b7e1936a53e80ab=
31b77f74abda1aaa of the branch: https://github.com/minuscat/packetdrill_acc=
ecn
Shall I create PR? Or above info is ok for merging into packetdrill.
Thanks.

Chia-Yu

