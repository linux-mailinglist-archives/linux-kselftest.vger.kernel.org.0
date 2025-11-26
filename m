Return-Path: <linux-kselftest+bounces-46489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53EC88BB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 09:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB903A7FFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3731A06A;
	Wed, 26 Nov 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KamogAc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D11219A86;
	Wed, 26 Nov 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146909; cv=fail; b=T9dnMDXiX/+BngoT8vHpsvfw/iua6y+8+pQSG9VQfLQrsxUe+KqyhHm6YsP4ByyM1cGS7yL4DMcb0A3ltb2czGh1cHZvGMBpr+Rd+HrWTrlGLxMo7ajq+Li32zA9DcR8nT9YMm6Lx/ua3GI/SWH+Zlb3F/BJJPW5mfHnEPYgfNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146909; c=relaxed/simple;
	bh=AlC8LZ5nBXsYQuxkaN0l3gFxATGznds+rAqqWQtSiZE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3/0i1TzlNnJ9GkE056ShdizzAABV9cUeCDd5iqA5/TjoqpBcfNGqgKifeKaeXF7ZoO9/+miZtt3S3nd0k4zUDku+vQNKZDyXKjAknGt5n8JYhSuHVrEjOoOdQk/3S7PsSTbpaqUvK2gJL5hKyw75GPGMZqciSBPMDXkr+WWLDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KamogAc7; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1nzHjZaoyUlUUiIcaUA4wMvM8K4BWwvJNnx4NjOZOd7D36wE2oGiXLBuLoXfybJhAgwJ1aiSRrCcLJ3G+lJUch5xJbk0J1IlovS3MGmU4gAYQyCEShm+TmcXCa3oUSuQkKklxiBn2NfdCkI7oyb0Lp38gfaAR3vcQcnOwszy9BR6zC7mlJ3UwcyFFMdAA3lb3PVMCWAlbnVzPqiCL31Az0s+nW1rVfSgqQg3GUMhurM2a4PtXhH72k56mzxRGmv3DblhqJB2MeeOqjkP/2UBLako+RPuCBq08YIJ0+GWmPPPVYUjd5dclZYDe8PPf4UuIBhlRkBPGzK3QQm02PUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlmdXZk8A6/wRl9V/E8qQNu2oslO0h1ox6QCl0tm8dE=;
 b=jxHezE2i1V//3eNBJdLmb4k+m5zAKapcRJ3qKKsQu/4LBuC/aVIzp9Fyp1NxXBT69MLuzL/pe5KOyEn6Cls6Lfvgx6NFIqWt/DFPYK4fZYtOkSlrUb8NebCaZ+32ORX0m8mf8vi0QE5WRwPVlkJb0I0+Q1mOBOROQXaacE7MNPqSdDbtlqCGD2O4F2edJG9Nel20Bvu2X2bpqvqRtIPDGiAFRUgTYSrlTv18Khkc1t6dvfZHibob3V9qxEDhilR2MGg7PXDTlrcsenE5em7wnqlfhepVH5iqyHJWmWtAfZmjIbGitPE+slT6HOyWOe7deZZ6DfcIEf+Gajaby0tACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlmdXZk8A6/wRl9V/E8qQNu2oslO0h1ox6QCl0tm8dE=;
 b=KamogAc7qL2AYQK7BBTUHtSnChCubj7U4RMLUzWUl91TlvdQfJRolGplO4MoG+jAVimkip9lEaOXEQ3Xa1YV702yZttO1OGLw67W7X/RBbS417fIC5oEpOTW599RbBJbssBrswEUVfYfXDWasSOTF/GZqm6ZuMzXMNAhmAR08LG1i6qajJE4ZBfCeMLq9HG5m71FdvXiZDbdMF1AVZ75QDa1W8eDIrCIGbmjzLIpBfFoxLP4wpnmqhlxqs8VAlVkphPsyTgqjTdpw3m2m7JfZzj1jZJ7WG8iuMNY0BWvTYEW5VJ5CIZqWCAcz0a5SFmsuEieLYTkZJ07bo61+0xyQA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB11106.eurprd07.prod.outlook.com (2603:10a6:102:512::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 08:48:21 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:48:20 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
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
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Topic: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Index: AQHcVTY/Vojp0P94/0mOC8z6JaaJb7T4W/UAgAFx7lCAAAltAIAAAXMAgArOEwA=
Date: Wed, 26 Nov 2025 08:48:20 +0000
Message-ID:
 <PAXPR07MB7984B864D41591CC30684028A3DEA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
 <PAXPR07MB79840A45F8DCE6A6956ABEC2A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To:
 <PAXPR07MB79840A45F8DCE6A6956ABEC2A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB11106:EE_
x-ms-office365-filtering-correlation-id: ebac6dfb-af1a-4d02-2b04-08de2cc88d06
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dTLpC871UgLZBybZsfIm4U/pXsOVz/rmMd47FL66cPy72MX/77vD33csGqxh?=
 =?us-ascii?Q?CpZAG8GDr16SwKz/3IP8WWGuzg+YPHwqTvWnJyCZjHo9mStRyn9vY39lgPD0?=
 =?us-ascii?Q?TCak1FaMzEyd7HG3jtBpdb8X4R3HiN6v6r4b2/LDkNkBFyssCZkz1eOQu6Q4?=
 =?us-ascii?Q?2tZ7zm8PeV7/WLEF2LQvtmCZiZa7Mri6C1JNU1S8d+0Q/oWmPbvwYYJczdfM?=
 =?us-ascii?Q?hWZsS1D5EQ5y8o50rn9Bnkni0a4bvbPLcsHmzKEsxumiRxgTTqOcRuzl6vJR?=
 =?us-ascii?Q?iDeVb14mOVc7HU8XwZOGigpH8amhiieblw4KIBIsEdIa7yvpe6w+Oo38Ddo/?=
 =?us-ascii?Q?8r/R4DE+9Ch2k2A3Igte6RuBhBMeD9vxZykWAqtwMYxVcmBuv/zrkUjzM87I?=
 =?us-ascii?Q?1/NRDQBy4nOu0MXKX+tr/7p79FRUQlNCP2QZoIVuWWFngbqhncwtfgNAKWSL?=
 =?us-ascii?Q?4dkthLKYoPYYBP7GufDcB/OeRlroLhVEH/CYq9x4kH5D3BjxCc396PXmNHwY?=
 =?us-ascii?Q?GcSWAXUUhfaesptRRwWJBbI/ZVPKrFpVvfCTUmPm9iaW+3nm0EXPccjfbhJ5?=
 =?us-ascii?Q?RZDRizO4T5UVrZ+oIV+6U2eYWzgm+lFQjFQ9XUOB1TdT3E4AbBqLhj5Iy5M5?=
 =?us-ascii?Q?kw7J4o5hUC84D5Yr4X0/nO5E0ktEz/979WkYkD82FW/I7+uvj8NT0A8L/CTF?=
 =?us-ascii?Q?QBnlH4ws0RuZd/60Vu1uj0N5c1VQYLX+dmZdbMH80vHXo1nffIJ3xU+A02K7?=
 =?us-ascii?Q?3SWh+T1NyY7+IG1dnVKNFPmKd+s1q+QT+LITbRXvYOt/sK0YojnEwZGSvxil?=
 =?us-ascii?Q?mz/Ra76TZ8GUeamMs+ClnGsYSVNNBl/2u5TbKDLXBKgtkqW7FZk0V5SPvvgN?=
 =?us-ascii?Q?I5B5YJeL9BUxYJci/iwA9XbCm1X2jCcKtLr7ETUCijDIjaUDCfEk7/9GeMuF?=
 =?us-ascii?Q?zxEnj0twO9Qg95TPerwaGE6zotMkOdlM/kz6bFUvQLPLhpbRjYuGjbVFx/fl?=
 =?us-ascii?Q?bxV3nOCnxnOUuMpzx2ozWaJxBVTj63F+iNsm3iCHjhlc1RJEoqGhMzD+I2Ld?=
 =?us-ascii?Q?7HSd+HZinfK/SnjdsG7PJTjwAqkBgz5vLAShnCF8wQtqJaCesjGIETQjQTmt?=
 =?us-ascii?Q?HNFp4qtW63lKV+uQ9h17uMD5gPagbUBOD+HK0uuA//1BWmzOgF5+3qO0gibY?=
 =?us-ascii?Q?7eqqE05Jb8s8e1Qkf7QSxU6wW4LZ+r5MM8ACr/mkPMddiaQ7eL8BDR/YzfZv?=
 =?us-ascii?Q?D0IMiXTcNcbBNNy7s/4f8QcUS+mlSKpNzseATJ614vIHz2wHi/9WV5TdVbGe?=
 =?us-ascii?Q?JBtHFiEt3FOsahVF8tPQATopyFwpokTvXjPWMjPaVEMLoGdkfwvjH4RejGIq?=
 =?us-ascii?Q?eO6shfjOVKJlo/Z8mfz5KLgkrqotFC6EhreAsuMW1uy1lEPhukanv+WtMPze?=
 =?us-ascii?Q?C+fvxMVC1sy1ZFsAg/tsVIzI++upgPlAfPCXgHTbzwqizNSRnKpIzDlvTkUs?=
 =?us-ascii?Q?57VPTp3QYtZ23+ICswupzZLs33T9qgyg4tPJrXrZeKEtqwVBR9VCP3NoUA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F0XOb3IU6IV5Xg+LlNq21YB1mG09BzaD9J5AKKVt0jCV4zZFEYKBISk0wU8e?=
 =?us-ascii?Q?IH90GtNaHM/FScplTQCSHXjQBjs2+BZeM+TtDvWaZYB+CY94Hq9YKdVie3+q?=
 =?us-ascii?Q?aGlmYPsScRkobeG8ufbSiP4HuGfklh6Bm8O+pg6IiVDXK9mZ4cWiFpwBAxaC?=
 =?us-ascii?Q?Hy/aIH6QhkEY+b8235jB/0sqGWA6fS8Y9kDby1NaVwRg1mQsEAYW7AdnOlY/?=
 =?us-ascii?Q?pn61lF+30qyJZ5VxD4TzOTG4ObM1PksqGeCrXmaHDrGHhHM5gzOInK4ugEqs?=
 =?us-ascii?Q?6BhCfv/AQ5wGFLBCUePLsZA1SuQdTw+77Axet6bCSZUWXr708FrU46g3Makg?=
 =?us-ascii?Q?tnZsQjXg+J1QxcFX9PZRG9m+cHGrheRc52QQTgF8oN5cTsvgKOcQrxzaV1Y+?=
 =?us-ascii?Q?g7TQNfsebGWsicO9TSS88CtReezFH/nz7KARsdh3Jsw6qFnH814vCY8TfvmE?=
 =?us-ascii?Q?yA4u7HB4mWLCn6nXSVBVM7pCJvf0pG4xyi1qpeLwaAcsHPvIiiBkmt2YJ3lN?=
 =?us-ascii?Q?yaZPSwzpkobj4GfWblkP08nigq/FQH5GaYRkQe2W77JOJ2350MOkNpqHdlNG?=
 =?us-ascii?Q?4iXU/wWrB+fxV8xp925A/+QIRPoYtJGgK6tOeqAxM+o7yGTV2mPiRlz8rcBf?=
 =?us-ascii?Q?dQ4CoU8DyCI6Sx6TiFycgLiwv56gM+K+yoh7LTGgZiab1giQNvPDhg8dLKJp?=
 =?us-ascii?Q?f4IpMIe1ZWLLtDSIRAqQ2FtEAsJt8ErqZ+C9osQ3cZ19wn83zNT2aKlyrfTQ?=
 =?us-ascii?Q?SCAkjdg/KheEeGZIEeiJepfVr8CQaxj7R8B+5TU5QpH4Wv3ugIlVXnpdZtOm?=
 =?us-ascii?Q?73Jd5Rs4+ageLpTdATSV+ylTNib1WfhiEWU8IzaaY6jlKCCcX8ZHuBsQFiNT?=
 =?us-ascii?Q?OSyagO76GYmRzhlXZxr6wnoxqpRADRABgoUeuJa1IxPwShHPuDqasaucAJnN?=
 =?us-ascii?Q?i7tMXDZVUlNlZQlo3I8RrYJv980DZG9Cv+siK0eHqxN1dZGFp3eMsTe6/9R3?=
 =?us-ascii?Q?PetqUIMPeNpd07fwRAxt+Qu6DD37MA6YW1pn2naYT7hfkEmqqML9tNDQGhah?=
 =?us-ascii?Q?5HoP8k/FkqIuswLI+4POrYqwyEwow5wgNm59aUOG/PbcyRkFXWz7I6jaV8/O?=
 =?us-ascii?Q?7urx8l+ERCIdDrHYOheUjdfBLpECZ6JJ/7AEYfMGFJKnY+E1/HR/ggg787m5?=
 =?us-ascii?Q?S/d7Gw5z08j2eC3Pt+I3Bzb3aBCTzIgfI+rmapWNovOOWG0L0Gn5DO9Rn9tJ?=
 =?us-ascii?Q?y/vA/cHee1Hz8LtVZnDvCnV/ias0EqxvT62NQPC72COzVWhdZlj5nvW+szom?=
 =?us-ascii?Q?wFCtjj9NVboJCpLGDVpkoxePKMAzJCSEDvfiV9ecpeICe9Q85L4bWjLmKDuR?=
 =?us-ascii?Q?CE8QFsjanCCi4zaCQOglpPG9gTm5/uhuM525r8vUYqTKtyBCN0oGvuQECRkK?=
 =?us-ascii?Q?5OMki5A//ku0C2BzUU0v4Fy+d+H8xeP8aoTfELktx3bS+z4r9nZkIGMB83NL?=
 =?us-ascii?Q?5GShVNL+6zKs/i3ML39MY6s3oBRNujNwdMGxkimIzQKJtSV4GoiAT9tVRTb0?=
 =?us-ascii?Q?yLSe61E5sElhICiRSFFUrsRvTdIyvFJHOi4GPnXWBH4noeftaihSfOD11BHy?=
 =?us-ascii?Q?FA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac6dfb-af1a-4d02-2b04-08de2cc88d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:48:20.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +t1KNgv06/Kk7Hwy2IXtFK7VldaXeA+TCtAR/cHO3UAyMBr7/mCpcDGJYyjE2blm/1x8G7vzHgyrKMNFApHcXixeonYvl6YHDsa2KKXxfE6O1A1iVq0dagIkDgPfdI9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB11106

> -----Original Message-----
> From: Chia-Yu Chang (Nokia)=20
> Sent: Wednesday, November 19, 2025 12:22 PM
> To: 'Paolo Abeni' <pabeni@redhat.com>; edumazet@google.com; parav@nvidia.=
com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@k=
ernel.org; kuniyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; =
dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplum=
ber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; a=
ndrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@=
gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org=
; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-be=
ll-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirj=
a.kuehlewind@ericsson.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; J=
ason_Livingood@comcast.com; Vidhi Goel <vidhi_goel@apple.com>
> Subject: RE: [PATCH v6 net-next 03/14] net: update commnets for SKB_GSO_T=
CP_ECN and SKB_GSO_TCP_ACCECN
>=20
> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>=20
> > Sent: Wednesday, November 19, 2025 11:40 AM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet=
@google.com; parav@nvidia.com; linux-doc@vger.kernel.org; corbet@lwn.net; h=
orms@kernel.org; dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org=
; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kerne=
l.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.=
us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; as=
t@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger=
.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) =
<koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire <cheshire@app=
le.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel <vidhi_goe=
l@apple.com>
> > Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for SKB_GSO=
_TCP_ECN and SKB_GSO_TCP_ACCECN
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
> > > I was thinking to totally remove ECN from Rx path,
> >=20
> > ??? do you mean you intend to remove the existing virtio_net ECN suppor=
t? I guess/hope I misread the above.
> >=20
> > Note that removing features from virtio_net is an extreme pain at best,=
 and more probably simply impossible - see the UFO removal history.
> >=20
> > Please clarify, thanks!
> >=20
> > Paolo
>=20
> This ECN flag on RX path shall not be used in Rx path for forwarding scen=
ario. But it can still be used on Tx path in virtio_net.
>=20
> And on RX path, new ACCECN flag shall be used to avoid breaking CWR flag =
for latter GSO Tx in forwarding scenario.
>=20
> Let me borrow an example from Ilpo:
>=20
> SKB_GSO_TCP_ECN will not replicate the same TCP header flags in a forward=
ing scenario:
> Segment 1 CWR set
> Segment 2 CWR set
>=20
> GRO rx and GSO tx with SKB_GSO_TCP_ECN, after forwarding outputs these se=
gments:
> Segment 1 CWR set
> Segment 2 CWR cleared
>=20
> Thus, the ACE field in Segment 2 no longer contains the same value as it =
was sent with.
>=20
>=20
> So, maybe a table below better represent this?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |               |   SKB_GSO_TCP_ECN    |     SKB_GSO_TCP_ACCECN    |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |               | The 1st TCP segment  |   The TCP segment uses    |
> |    Tx path    | has CWR set and      |  the CWR flag as part of  |
> |               | suqsequent segments  |  ACE signal, and the CWR  |
> |               | have CWR cleared.    |   flag is not modified.   |
> +---------------+----------------------+---------------------------+
> |    Rx path    | Shall not be used to |  Used to indicate latter  |
> | of forwarding | avoid potential ACE  |  GSO Tx NOT to clear CWR  |
> |    scenario   |  signal corruption.  | flag from the 2nd segment |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>=20
>=20
> Chia-Yu

Hi Paolo,

I was thinking to move this patch to a latter series in which we would like=
 to add ACCECN flags for virtio_net and replace some existing SKB_GSO_TCP_E=
CN of RX path.

Hope this is ok for you.


For instance , in mlx5e_shampo_update_ipv4_tcp_hdr() of drivers/net/etherne=
t/mellanox/mlx5/core/en_rx.c, SKB_GSO_TCP_ECN is still being used for RX no=
w.

But this needs to be either changed into SKB_GSO_TCP_ACCECN or totally remo=
ved to avoid potential CWR corruption.

For virtio_net RX path, our planned change is to check wither ACCECN is bei=
ng set first and then translate from VIRTIO_NET_HDR_GSO_ACCECN to SKB_GSO_T=
CP_ACCECN.

And if VIRTIO_NET_HDR_GSO_ACCECN is not set but VIRTIO_NET_HDR_GSO_ECN is s=
et, then VIRTIO_NET_HDR_GSO_ECN will be translated into SKB_GSO_TCP_ECN.

Chia-Yu

