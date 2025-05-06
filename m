Return-Path: <linux-kselftest+bounces-32489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4CAABDC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB33B7A9AF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D4266577;
	Tue,  6 May 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e0XUcLXG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CA263F5E;
	Tue,  6 May 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521419; cv=fail; b=iznwDBnFKjug7Y0jTz2t2im5Kj7e4+AaJGO3/ON6Gp1AW13g0w56cBntjeXECXbt6U1se6tyhfM5wvY0TGrSAcTl1fwGle5yqQfRw7EWplP0P9WhS446M6fmdIpyek4EVvbABimpTK0qAnamXJ4+IgrKcXYnAgHwAyBzLnLfKDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521419; c=relaxed/simple;
	bh=uritm2N7apIO7y+7yn8RVT9zes/pVO6E0cHLZB92iFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muygNcXS2yXPL8E+mEZFmdTUFseT3FnflBIyC6iUTa1O/RAlC4hiwtXBCVaiO3gGMhvoyw0sZrg0djMLnLZUSkblgX8t4NHhtE22H7VWG+2/90SzEvivuFZHdBzCGcXq2tLlu5wR7SZ+W7Ygm52BbKy6LoT4uaaTErcv0Nao7xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e0XUcLXG; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJajPfcqWEo9m7J3uH0aMNYFsZ+vaP4TUy5WDZoy1IoZ7C2xvKjcOhgv30GMhXITpf2vKF71I7xkQiTeKNP9syrsFbU2s2RrvzhG25/rKPwm1VMnorMIENr/NsCyTJ/ZHCNRMQxPp9jKO2HmlM59228x1Mm4fBWpSyubgLBOR8o6zauyQXw1OprsVrciuz6iUwZvqob3Aj5tDUYlFhqNDEi9+BFjQ6tPdDm2i44aDKVpx2djmCYSbKfRiHLwD9dbm0xzvRzw03cu/7WrHZ7jGQyHwsxZ/tlu+KjTo8tFj/Vpf5EBiE9FM5v07rRn84MV/4sFx8r76EUw4RxkVi7VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQnFmiunZi7a4P5FvsknDDH7UIOP5/B4vrdbH+aZGJw=;
 b=H0MAAafth9/U7K3a48ok2iC9itGekkIkxqlETz6o9S3XkxxFFV89MvPRFzlNVeQNK6Lx8YG+yBhVfKYLDeWepyg9LsuhVcEXcu0dvHA3TFsFy6cMijK91iwHg7WHDxM4A5TX+ew8bo/TIZlI/KMayv0nx8uiHrwmlzqm9kXgTbOzouYViMShlVd+wISyTtz3KzzqCvgfpp2eCnygTDDpcEL1H+QTud5fycWPZR9RAXK1RjYFLYXXmpycxFbqoin82NymNaTcTzuNHGu9pso7t2iGllh0leHkOiwufVB0gXOzedJDGWuSXPQCEB0F8bQdPRTUfwebuRGjWMg8Jc/0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQnFmiunZi7a4P5FvsknDDH7UIOP5/B4vrdbH+aZGJw=;
 b=e0XUcLXG+/bJBddkBrEI8wVO4fDFGY7XBv7lPc0FU8ZTIsD/pDp8inOOCLgX9Qax/sCoFU+M2YnipGOon14vvIJTGnRkWjQQ/4kYXQJbCTgfUJ0ir613n31mvtztTIsaI9Dih92uY2Q9w0eWHs2RtzS7uHQlQAW/gl9kdDO0p4imFuTBq40aGrRvCQCTnBoDRb9Lckh6twEBUSQ8uemkPpr6ye6SLkGocl2Os9D28r6N9svifLfYfj2onBhbIkNx/slBNM+I+795q5buRoP+nRGdY6yhH5AawK2Bo9dj2TFJRNxhAMJVHdZdm4Xgfr8y9iigR3u0ydlykLao87Qucg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7687.eurprd07.prod.outlook.com (2603:10a6:20b:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 08:50:12 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:50:12 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ij@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into
 option padding
Thread-Topic: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into
 option padding
Thread-Index: AQHbs5ycdfnhoVLCj0ONxaa0n8wp/LO6g7OAgAo6rYCAAJgVUA==
Date: Tue, 6 May 2025 08:50:12 +0000
Message-ID:
 <PAXPR07MB7984EEDF3882EA1F4708270AA3892@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
 <2067a9f7-eba4-476d-a095-3d6301e14830@redhat.com>
 <7e64bedf-2da2-2deb-2712-f338474720e7@kernel.org>
In-Reply-To: <7e64bedf-2da2-2deb-2712-f338474720e7@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7687:EE_
x-ms-office365-filtering-correlation-id: c40d1bd4-5bae-4187-9084-08dd8c7b03a8
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zJgvlo/V3y3t3W1i1emd163AH24Z49Z/dmKdeIAiEDf6MiI1rB1flLpZ/y?=
 =?iso-8859-1?Q?/ksVfBkb1+44wvDPFmrlnIJ3oK5iKTw1EW/Z/Wz98TcUl10vE94888adR2?=
 =?iso-8859-1?Q?E8WlRQUvdmIU0zLAPGvgXPZXhEbIXqFsnWvygBJmVxTrjrHih+q4uw8rTI?=
 =?iso-8859-1?Q?sYycK0Bqm1E7yT4/P/UAvawJ1/ZajFIFEjPO2JdtYw1NnvDXhVMP/jfid2?=
 =?iso-8859-1?Q?Err0jnxaogYzRrRe3TcUZvJ+niXSryhAQRhZjohTzVPbsEyDxIBQGPkSyV?=
 =?iso-8859-1?Q?A3XP7f8sxSJKw6919MnSY0ANlZgE/1Qh4vVFLx/Gkrb4sZvCjnXy+cvs21?=
 =?iso-8859-1?Q?CNjvnbTnILsHN2ZfvoROOFkRz3rPIrAVpnbg5JK1rURY023x8slOwcwpuj?=
 =?iso-8859-1?Q?5TCJIQlm+oYNXpTjjk0l9IyCj8+/wbPdp0akK4ZR9cDj5eg9Mp0FL5wAnj?=
 =?iso-8859-1?Q?GZDBKg2DSK4ECrYUk0ZLmAzRtDVPzfD/FvqRnRwI3+h/qn/gP07Ha4ohLI?=
 =?iso-8859-1?Q?hT+/G8JkIY0xQCyCyy9v8FEQBPjIzRQoAuBcNlgVTxCN2cx6HXYhucMlK5?=
 =?iso-8859-1?Q?Qd8eZuJjaS20Y3O2QrFc4Gx8iLxautGLzzEVvASTnq5geDMMQk7hnyaJAb?=
 =?iso-8859-1?Q?X6PQAQxDlTD7Ve9r+CUp67oMd1QBuQKGyViDpKyJ/M8FfH5WpTVobmCVbh?=
 =?iso-8859-1?Q?nLtJK/EfsPWRt1+YIeSwhoQFXZwLWDBAx/gkpV3xWjgiywVbl4ucGIZSgG?=
 =?iso-8859-1?Q?wDsg95rLkaR4TFT1UJzJReSAm/UuUITdYMM6TJGSFYFfAzCqzVifmscdRg?=
 =?iso-8859-1?Q?evVsfmftq/VGuMP8CfGWbq/La9Xx1jMo6dl5Kk7Opuxsr8ntGIcqA4dPjG?=
 =?iso-8859-1?Q?l1J3H28KSJdAfsLM+z5lIlJJ2imNBl1YVWaaxTEU9p9M5wixxunVN26fP5?=
 =?iso-8859-1?Q?f9v+uelrvJB2b7wWryORJeviIW4UoZS3FdcECZM2dT/CRkudYJzeZWp1Rb?=
 =?iso-8859-1?Q?+m1TG1oCW59U5Yh4r3TJlNFOIErdeCi+UXIeRzODSAJQvv9WczP6kY2tC4?=
 =?iso-8859-1?Q?Eae8CXu/l5e7ncwlF02HN7LT2BDaKTD7xV9j5UXsDD7QekSd680VuJTG6W?=
 =?iso-8859-1?Q?kdt9Z0QgVg2B+4YZmhMh/lnuE+oG0Zz4dvyAg9elpYnAWNgkQGVtRbwXAs?=
 =?iso-8859-1?Q?Jq7Fda+49iqDxDKDV5vp43VAwzxLw4LLO6wG/H0hH38ghDng/5DAPBIGSG?=
 =?iso-8859-1?Q?S5CIcQ93/S1sWOXH8ZzSPApMvbnQlZqPFKhlTyJRHPS5YmU9l3BqMGLKXB?=
 =?iso-8859-1?Q?vcnHxwXwKrWKgFWU8+hOFxjOyprdLNYc23UjiRJLKD3BPTv7Mr1ayBdRB8?=
 =?iso-8859-1?Q?l0V4sqptCpMcN0mqkUbAPVA02FKmeoCZi/GNRQcvg/a9UqbsQ6oH/0Nf0I?=
 =?iso-8859-1?Q?3v2ulWgy2ATc415mfDwChGE8PGj/4PWGDd1ohag1pl3YFhbpuVqczv8Kbd?=
 =?iso-8859-1?Q?Z5UcUmp25j9bqcwhqmcE07+85z8zgNK8iNDqAc5d16c+5D7bBscTrQVHL6?=
 =?iso-8859-1?Q?BjEnqqw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?niHPa6LYfN6HjVbDFC/tpnpdmLtDpTgJcc+7JQveelRoBLajb3M5zRqhSU?=
 =?iso-8859-1?Q?BwU/1Y2MUzqzgW2bnSwAM83s8jTZQ4hUzJNn7HzH3jI6VFnLtlZBvyWSpf?=
 =?iso-8859-1?Q?pTWQ7SjhbDKueNsjCwbp3jf0J3E885ArXZ/xsaLB9Y0U70w1Q8x0G9IXyd?=
 =?iso-8859-1?Q?aDcMegpVY0UiuhiVxHv7UcsffuSER7WY4HfwV+prTTF8OcVt6cI7HZq8Ho?=
 =?iso-8859-1?Q?Nz3/+j4XNkE4O8vH4OtITjuDY8UluYlAWpH9aDJSv1jrb3nbZT2xlZ+7Ab?=
 =?iso-8859-1?Q?5uurcmGm8/5ggmVREHOp5NFrc5LUN1ZfPJLkyQtRE1Rdu0ouUqxyFEjwcn?=
 =?iso-8859-1?Q?0j5duxh9JTSF6ieaFLZ3e14aHU+Bp8UIUB4LdOyBOktD/+y1PTY+tcubYt?=
 =?iso-8859-1?Q?zsTD+gvIhvcABWrRrw55BZPWmQdPY0tBwxRBm2gcTDBBI320JO8hiHUnjg?=
 =?iso-8859-1?Q?e+pORHUGF6l16UjxpsfEDLqseQ+ys5hKAXk9j90d4Z3AZlG4HtpfNSlkfM?=
 =?iso-8859-1?Q?W6C++2A+xZ0HuIZLSDqDhCCFfazX+Z7SS6l1gwPgo3x2Pk9ecs3xPbs4aQ?=
 =?iso-8859-1?Q?cX3WFVOwqKPIR2Zp8btIwrFMBc4tgXlYtG/A4t1ejMACZWvYETisBL5sYE?=
 =?iso-8859-1?Q?H2LwaWRHU78dhgZSCG72NjQn/99fZTJOaFjKq8KtRlMwJHC5PfjDg0w4m4?=
 =?iso-8859-1?Q?9aPQWiDs7MPZ3Eup7b6gXipWPEMiJJtyYxivsXtqNjx/A3goAS/KhVBj1K?=
 =?iso-8859-1?Q?r8gWn7frObRjtlhkWlEqPGuR7rSj33MGFW4Or50p1v/XDZlJ67+LFcJKCy?=
 =?iso-8859-1?Q?dTtSR2NGzvj9kj9rmRdqGHK5298n3QxrcUb/9+OHRhtA9yDAcIWHqx323C?=
 =?iso-8859-1?Q?VDncbgaqcfnvpXc3dEwr9M1JXPz5hSl+xQ5C4Cla5hRZqln8JgeGSEdYhv?=
 =?iso-8859-1?Q?jgJWXRPrr4Gnt5Iwpnsf0SNmowCIbUTTeR6Tj4lxnPs2N66IFq/mH/nQgz?=
 =?iso-8859-1?Q?oLXfBo6HHvGXGBwSulZ3jVR45MDlQjKmm7lN9AFguAWf25LM+euFgsFzBT?=
 =?iso-8859-1?Q?nZNqOXjGoVVVfsos63Nq/Fo5LUBm3WsrZYqRXR+7IYP3H7V1+Zfs+ybdvc?=
 =?iso-8859-1?Q?S0lCBUjADSyYR8LuBevZfysopVeshqlWrAW2SwuW6QkAnp+WSmtVAA4YPq?=
 =?iso-8859-1?Q?9KMIhlio6kKHAKspUsi/idOH3MkgllIDuSXCsoTldIEt8m8Sp/UR4gweqz?=
 =?iso-8859-1?Q?04bQCcrlFQ9vpY0EoZYJrbZ+8OxDFt518zltEXuX40p9FDPkxpGZPMB4bO?=
 =?iso-8859-1?Q?Rf32edx9oDR3i7Rpj5R64ozLy76bhBfTYi2iCU6SMo3A8AEIuWoDHFsIR6?=
 =?iso-8859-1?Q?Lm+D/5Ta6GvgFQ4/7jJLCs+gV96cBc8+HgbjOM/jFEmGHdqsFQ5c+duhZV?=
 =?iso-8859-1?Q?h8o6cmxXQ1/bcQhnI+hpfHFrCRnyt46PJZg/HV5ZlzXJ8ZS0RFfC8ESsS5?=
 =?iso-8859-1?Q?bOvwDOsSGIzfJVxvUra0r+OFPiJ06uyjSMsKK62w82ejWPgQMP6itUNms2?=
 =?iso-8859-1?Q?gZPW+Gq6pkyqHje5dLYhj374Sq2TOA/VQ20QsVUqcVzSfvG/rN70dRVknP?=
 =?iso-8859-1?Q?qm9sE2sJlewrSKNm9wSkY4iqG57xy4LWXcpDStb7xylH86MeZjPBu9eV0d?=
 =?iso-8859-1?Q?JZ5SgtM0H8scr6MAGD0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c40d1bd4-5bae-4187-9084-08dd8c7b03a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:50:12.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZyd8BJbUqc9gg1MPPIq7OBYjOuoPMC2NGYLgwHDq/ihe+ih0XhyATC1Fe/XYEl9RupU1F5EE+mI8bX73SxbzK3Tgj7kSX4VyD15Kxezz6LC0zpr5s+RoUy/XdjqlEnr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7687

> -----Original Message-----
> From: Ilpo J=E4rvinen <ij@kernel.org>=20
> Sent: Tuesday, May 6, 2025 1:10 AM
> To: Paolo Abeni <pabeni@redhat.com>
> Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@kern=
el.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@=
vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; st=
ephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem=
@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; donald.hunter@g=
mail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-ks=
elftest@vger.kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <ko=
en.de_schepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingem=
ar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.=
com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@ap=
ple.com>
> Subject: Re: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into=
 option padding
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Tue, 29 Apr 2025, Paolo Abeni wrote:
>=20
> > On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > > @@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_=
sock *tp,
> > >     return ptr;
> > >  }
> > >
> > > +#define NOP_LEFTOVER       ((TCPOPT_NOP << 8) | TCPOPT_NOP)
> > > +
> > >  /* Write previously computed TCP options to the packet.
> > >   *
> > >   * Beware: Something in the Internet is very sensitive to the=20
> > > ordering of @@ -727,8 +729,10 @@ static void tcp_options_write(struct=
 tcphdr *th, struct tcp_sock *tp,
> > >                           struct tcp_out_options *opts,
> > >                           struct tcp_key *key)  {
> > > +   u16 leftover_bytes =3D NOP_LEFTOVER;      /* replace next NOPs if=
 avail */
> > >     __be32 *ptr =3D (__be32 *)(th + 1);
> > >     u16 options =3D opts->options;    /* mungable copy */
> > > +   int leftover_size =3D 2;
> > >
> > >     if (tcp_key_is_md5(key)) {
> > >             *ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) =
|=20
> > > @@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th=
, struct tcp_sock *tp,
> > >     }
> > >
> > >     if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> > > -           *ptr++ =3D htonl((TCPOPT_NOP << 24) |
> > > -                          (TCPOPT_NOP << 16) |
> > > +           *ptr++ =3D htonl((leftover_bytes << 16) |
> > >                            (TCPOPT_SACK_PERM << 8) |
> > >                            TCPOLEN_SACK_PERM);
> > > +           leftover_bytes =3D NOP_LEFTOVER;
> >
> > Why? isn't leftover_bytes already =3D=3D NOP_LEFTOVER?
> >
> > >     }
> > >
> > >     if (unlikely(OPTION_WSCALE & options)) {
> > > -           *ptr++ =3D htonl((TCPOPT_NOP << 24) |
> > > +           u8 highbyte =3D TCPOPT_NOP;
> > > +
> > > +           if (unlikely(leftover_size =3D=3D 1))
> >
> > How can the above conditional be true?
> >
> > > +                   highbyte =3D leftover_bytes >> 8;
> > > +           *ptr++ =3D htonl((highbyte << 24) |
> > >                            (TCPOPT_WINDOW << 16) |
> > >                            (TCPOLEN_WINDOW << 8) |
> > >                            opts->ws);
> > > +           leftover_bytes =3D NOP_LEFTOVER;
> >
> > Why? isn't leftover_bytes already =3D=3D NOP_LEFTOVER?
> >
> > >     }
> > >
> > >     if (unlikely(opts->num_sack_blocks)) { @@ -781,8 +790,7 @@=20
> > > static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> > >                     tp->duplicate_sack : tp->selective_acks;
> > >             int this_sack;
> > >
> > > -           *ptr++ =3D htonl((TCPOPT_NOP  << 24) |
> > > -                          (TCPOPT_NOP  << 16) |
> > > +           *ptr++ =3D htonl((leftover_bytes << 16) |
> > >                            (TCPOPT_SACK <<  8) |
> > >                            (TCPOLEN_SACK_BASE + (opts->num_sack_block=
s *
> > >                                                 =20
> > > TCPOLEN_SACK_PERBLOCK))); @@ -794,6 +802,10 @@ static void tcp_option=
s_write(struct tcphdr *th, struct tcp_sock *tp,
> > >             }
> > >
> > >             tp->rx_opt.dsack =3D 0;
> > > +   } else if (unlikely(leftover_bytes !=3D NOP_LEFTOVER)) {
> >
> > I really feel like I'm missing some code chunk, but I don't see any=20
> > possible value for leftover_bytes other than NOP_LEFTOVER
>=20
> Hi,
>=20
> I split it this way to keep the generic part of the leftover mechanism in=
 own patch separate from AccECN option change itself (as you did later disc=
over). This is among the most convoluted parts in the entire AccECN patch s=
eries so it seemed wise to split it as small as I could. Having those non-s=
ensical looking assigns here were to avoid code churn in the latter patch. =
The changelog could have stated that clearly though (my fault from years ba=
ck).
>=20
>=20
> --
>  i.

Hi Ilpo,

Thanks for further clarifications, and I will add more comments in this pat=
ch.

Chia-Yu

