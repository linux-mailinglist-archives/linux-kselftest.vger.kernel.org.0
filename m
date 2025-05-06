Return-Path: <linux-kselftest+bounces-32488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DAAABDA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCB91C23310
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91021773D;
	Tue,  6 May 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lcn4c54a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7E1474B8;
	Tue,  6 May 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521312; cv=fail; b=s/7NPzw97ak44+9Bua7S39AR6WQ/94KAmSnnTX9xglnUQK82BapJn5Heei/5wLCTP8mMUCj/bEHsgWXURl7COBQX1Wd//2SIeUHWYwvLwYctyvSuhKFJBzzarXeeGZMYnawccprn+nF27MxAbhDzi53kdhoMLU2MUeOab2mozFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521312; c=relaxed/simple;
	bh=NLUrJqwK1UA3Qg8PRGn2C3oDw+QocsJMqhd9INvSuzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZIw7O4ayDpbLkkQg3q8wNixRkDM6sLYV5fIqaEh/fK0C+rIGLL4hDN/wrvp5C8IA7ngS6ZurmqHyFZMYeLpho+6zDCCnKREvOl/YdSUuAo8HfnCFh0N5ibcnooIucTSu13xT3eBlL+VrJ18FwVW+zwAuuZh23KkhL8D2ibgoQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lcn4c54a; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/P13XgGNQ1Gf5RLuREBhpNH0tszATf7bF6E/zSLSoqYwC/CiluhAodKNkJrIz3ezKX03CqYb2YFNl1VGNTX7G9c4Gaa5sSYrNOUKCTuKi0Bt6G23ZK3vMchsQoFiE3EsSuoSIuCZhCe4Pa2O0cBtvzgFsWeSwKXiiKox3zBcY/s3qF9QXTSSaj0VKs8JDedMx3Bu50ERGANVCAXmCv++UgvbXzieZ7Q65o4g9EUH8uEMy3W5SweANgC5pIwsH69Uguk06i2PDkYjg3pjaic7TmmLCO8Bi7qtfAu+yKqrQM3mOVJ4lt6kfc16ruI10SdJ7EMI2nQM74qY2Pn55m27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXZD4nhTsmI9B5tFslYwNzF1te07CeDw6v1T8OaVVu8=;
 b=Za0u0ZtShRjr4LoWTK72YXVZjk9sNmdlO9GV64vV/7Mmb+MWyaVDYPuMX9tT7Li16pYVKBUcgBTnjbKvJEZQqajEDGhPcAatIy4KhA3Q8hCymnmLDskhIkRLDyCUmXLng/xNJnjVSeCzp4Xte+9hBIl7g3NC6UrE0TBJEZuaCAYMCAKfJkcsIQrNpHrK5Z9b3Zz5yGoNbp0j0g58zBV00LLtqg7BoEwgCEAIcKPUBNiReShh19oYvYVAAsfcXiAV606Kd/i24m4sQB754GUXiCC6W+eW+/gUO3AkNCNvF9/xZB4fI5wcJPjSxUfGqPg27DxG84/XUtqvt0+8xjwAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZD4nhTsmI9B5tFslYwNzF1te07CeDw6v1T8OaVVu8=;
 b=lcn4c54akxi/wpXr/Eoy2tAprAZPlVZ121jOEGqfTP7Z+5pHzyjBuRWBCbA9v/zKM9QWUDtgeoDeYlV6KoIApVX4qUg2F3UqF/BgHri9hNiM+PApbvFzTJZehYRSi/caD+D8JEHnOhGPMzuWWQkDn0dtmEq21Jxs8GlPUVKsbjt0FYjlH/R+wtOAfazIL5yfLGdrh5B9NrRWAV9oBme7GtICb5P1oD4uwZf1fNJ0Zck1MCqgI3DUWh8WMMzVbmIqG8VfZMNOBCBv+oYBbg+ML2/+7hVxnOVTZryDlCN8V9e3iqkqz7zA1ug1JGiY4UDmBbUYrRevzLFwo8vKMvnHIA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7221.eurprd07.prod.outlook.com (2603:10a6:20b:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 08:48:26 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:48:26 +0000
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
Subject: RE: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
Thread-Topic: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
Thread-Index: AQHbs5yh5wwW2EQTG0akChyjaqs5wbO6lC2AgAol6oCAAKOEYA==
Date: Tue, 6 May 2025 08:48:26 +0000
Message-ID:
 <PAXPR07MB79841A27EC04E89136330942A3892@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com>
 <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com>
 <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org>
In-Reply-To: <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7221:EE_
x-ms-office365-filtering-correlation-id: d89c4de6-1297-4305-975e-08dd8c7ac47a
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xmEfuYymdkDquSHj8p3s9Iay+xaVfmxXNvrsPAHjlBHLVHG/2wTQnptoca?=
 =?iso-8859-1?Q?wnF5g8czqHgL3Uh0/Ob48cDlyiSnqEer6imiT5NUeoBN1gg50K0Hc+ZFNO?=
 =?iso-8859-1?Q?ZJ/BPH0KezleqvdO1EJLh6QFkjtzQPr4sCaK+Hu9lpQlcMrhKyJ0slY4jr?=
 =?iso-8859-1?Q?jriAhwVWGH5onkstbDTAPF3GJFdrewj7sOzo3EMaMWxLULm2k6VGbjmP6E?=
 =?iso-8859-1?Q?c2auzDvKXsPR3LdeqVlPw0feIPapn+7+b0H86uG/qxt/u4nc4P2jBC4GB0?=
 =?iso-8859-1?Q?6eFHpmJS/38RQfQ5WXVHiBNbDqgExmhrCdKB5pTfEfktqww+iBW12bXMNC?=
 =?iso-8859-1?Q?XOdRwluNUiR/qh1vDrunemWPgx9OfcjNirjMjX9be5RrUdwULKZHlFtAtl?=
 =?iso-8859-1?Q?ge8Ambpnj8y7FL5GRrv3gK4oAf/AiJPlOE3r+bOmh48TrY1GbD63VxLw1u?=
 =?iso-8859-1?Q?aENtuvXMYRkb/TInAkecUlxl1U7glYiqYJUxI8g3+ClvYtI7NwcMOsmxrX?=
 =?iso-8859-1?Q?XOrVM1cIxPFQzZRwpgNysSYNFQHcPKbKHW1GmKfSZNcsrbyHaI9mGxeJeG?=
 =?iso-8859-1?Q?ASIyoWuBMP48gK3jlbX6YS3pOXqlM2sMY93Y7QSpVL1LximVx6pNDwrfVP?=
 =?iso-8859-1?Q?0zuyTQt+EBkb393yAam4aqH4Al3m3ntmyakXl5ayn8Sq0TTKAdu95QzXaF?=
 =?iso-8859-1?Q?ihobkIRHk+OtDme2ZuSwRi0y9e1L0MHc4VeVOHTSBEpuNBx/4yrtljQfBZ?=
 =?iso-8859-1?Q?UomLSGPWf382oJIBQYxWL2aPoJ43qCVNvGc42+wryvnzyQ/Cs27iIPAZfD?=
 =?iso-8859-1?Q?5MgjGmVeGmlo2i3YKJvJwIj5VHqqqKgJn5Wayo1RyXtIiyRc5Cdmb7H3eK?=
 =?iso-8859-1?Q?ZmdD+fDXmYcELijAhjxG3kxvGOxmPd+nRDaNrDhs+spKmDGO5zUAs8Z1+W?=
 =?iso-8859-1?Q?7kMx3qZ8rHJgZ9nAyT23tRwwaWnO1yRWiwpIWCSwBJ/XtvRrx238sfh1Fj?=
 =?iso-8859-1?Q?QgN/fioE9lkDM5h7vD/Lwxr+qNgLgCByGjyDnlrEvo31SJcUFBZLr1SC3k?=
 =?iso-8859-1?Q?G+axJckNR/4jOmHzhDbTcDklQpy/7rpJz303UbaDtadBxVd101zxkm9TI7?=
 =?iso-8859-1?Q?zi/u2X7EdnEcLFSfcwFzwNqhtzbX2rSFZKZJZXFyFOe8xxa9PqODsy9CTr?=
 =?iso-8859-1?Q?TUsW29sIfzYEXXnRGuIWdx49SKmt0BRFYTgzRiJLMDQDFfmVw8cLIpjCIk?=
 =?iso-8859-1?Q?AQJskWsQOJQ/2fyuhpWm20OcLKzevL5OmWpkQBz4wWmyCoxRBOYVOFGrsu?=
 =?iso-8859-1?Q?OHNjc24EJ44wWvh1d1RslRlgXmu2mUdcq0FBNXQ2RBhIhxOs93OZ+qVqut?=
 =?iso-8859-1?Q?IjOWFyGKsZOHGYEiTprjwcUfWnc1CYVEytp80tGi5o92RzaDoIvoDiQIdn?=
 =?iso-8859-1?Q?YP9o8tmL0pxBvfQGeBaCAEgpJ/mOWLcvy5jVMEp/yUvxJHdEJioJb3PcvU?=
 =?iso-8859-1?Q?8a1qi6fq3ZERsSGi1Lzmd5cPF4Z4+psDvWa6V2brUEa3smDFxlquvB9YKs?=
 =?iso-8859-1?Q?aMkLa2M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8flL/O5YgIfOifxdwaalnFj5vwtWjDA0RuJuM0j2C9wD0N3AanGzs6TWJV?=
 =?iso-8859-1?Q?JAK63YcLYHd3RboPK6v9B3eiLa9m6NSt7mFi255zQ+5x0R5DDuwUvHDWPN?=
 =?iso-8859-1?Q?9ymgUPihM8qi1t1Ajgm/Tmejbw01jgTrHzAlqBGXEqKDzECZ/M6QADR441?=
 =?iso-8859-1?Q?Jo0SKpnXoNh0/ia9/Xlb24eaYSYZXztWYqoyw6TNM/AXXzK3uAUwLgv154?=
 =?iso-8859-1?Q?+MOMz3bSnJLun1jSeyJvCd/+D8m5E16XvJ+Wsf47CVpgxOLquTtfRPk7/+?=
 =?iso-8859-1?Q?Alnb/lvsUlh7sLSZ4nPZ8xRddgQb0uhhC+qbCV4yNYZchiS93ZDric1mLg?=
 =?iso-8859-1?Q?EjDuCSPW5hs1Xdbegt9SX41HwZQwiO/ywd2DXsCI1Lh2n7QYgiqTZqSs4g?=
 =?iso-8859-1?Q?p3P4R5JrOUo2iqHizvg/kcfL0kTKgpnS+/Drfu1GhjX5kOlkHN2jokm0S1?=
 =?iso-8859-1?Q?mwPFwPuPKAzeUKCoFjAe17acx0PTuQH8yEHAUiFhaK4tBn5w210iLmIkGp?=
 =?iso-8859-1?Q?esD0KDvgO2FkIJIfojZ1hJA77Fzi0XI8tD015fRT1B63A2EAw9Fr8znq5G?=
 =?iso-8859-1?Q?8tDhvNG24RLOBeik8LrxoA0ztQT4HRkqisulO4YUKknpOPuvvW0fqBgaRI?=
 =?iso-8859-1?Q?Ls7GPq8g2mZXijmStSYzfR2KNLa5u3EhMUG97yHK7Yc1Fwv95U/XZ/pINn?=
 =?iso-8859-1?Q?lwpprwW5rpfeKES1TE3CxJgl2J2zsSpA1w8uvnhm2senPXuPcOBVmH/MU+?=
 =?iso-8859-1?Q?MSxzo3+qYsK3zvS+9YoDasF6KWc10UNMqof6nYrU/i66uOdIgMyRQ0UznV?=
 =?iso-8859-1?Q?c96hMwFYHkS6AGqSM0GtZwoEwz5ykBcG4iFxQDYfQJ2mXU/AcjPuyZDRIJ?=
 =?iso-8859-1?Q?p6b00LgmT0j9K6mgxEgIO4xRtwL42QANRUtlZ8Cn1MFN87gZrSvqASKSw9?=
 =?iso-8859-1?Q?e6W/UAXaK33mhkQLTcxTnUT/M0nCbkDuY8KpBt7Gxzz9gz8CCSP7ere9Cu?=
 =?iso-8859-1?Q?tmVcdJBID/Z0MmnJiFJZENUBwADqt8UAp+VFtEd65Divebiy4RWvZ5fGGK?=
 =?iso-8859-1?Q?P7GgPfXFglCylYys1qc4ArA6BF6yZNPvZiUBghsE2WI1reQUfh8uVQDrqx?=
 =?iso-8859-1?Q?4CXZN/E6PUhuHv5/Pc8Voxu0yqVjvlHqtp7BAJqT7sxEa5m5j2xkmB7XdT?=
 =?iso-8859-1?Q?Bl9LUmsUG2J1HHUZWspsxbVBLjnNa0suQe4xv4RTX1wNjbMEOFnjZKMhsp?=
 =?iso-8859-1?Q?NKWJoaq3lxmpVQ4y/7BZfDik2tGmZQl1UdIDc0yBhYrndj5jmyNZCwdbco?=
 =?iso-8859-1?Q?5gdG5Xnf4q7pAAnJYY23KZxa+2AJJIgfEepj6lnmkSqCurgEV00bSGE/6e?=
 =?iso-8859-1?Q?BuSEYJoeZFPzz7s9io9GLRailGXXXP3DZpwpguCSw+kOYu0tJD0hsdmVeK?=
 =?iso-8859-1?Q?r2JFzxjot8yhgvdyleJNTmPt5J453g018uu8IVtP60tDba9yli+8jOlCss?=
 =?iso-8859-1?Q?ASxpGtnDlPdA+2a36GeFWQZmUOsTFf+SVI664y23yf7rCNbUaJYJkuJNi+?=
 =?iso-8859-1?Q?JS2I+CQwNrk7+ceBNxxdwQiROTdEnK2HmYuiQoEzN+ngNsvik3LSwrNSY8?=
 =?iso-8859-1?Q?Ps+Gil21q4mNieZ37mhvvYGbWu/Vg5AAYrnl/sDYOeh9gRA3xn8HMbnx6Q?=
 =?iso-8859-1?Q?TQgKB3LSjxD7VVjPlcc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d89c4de6-1297-4305-975e-08dd8c7ac47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:48:26.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5cPC3ZAneXLzISqA4Pc+KplmG4Pr7735pRcAT84M/VJzgY10QvnsvK0x4SP7crx8CFxCZOoIcmqd6cy2wt175FRJh7144THUjSAOQptUUq65X8gZhgtELoDhwV3vo3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7221

> -----Original Message-----
> From: Ilpo J=E4rvinen <ij@kernel.org>=20
> Sent: Tuesday, May 6, 2025 12:54 AM
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
> Subject: Re: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
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
> > > @@ -302,10 +303,13 @@ struct tcp_sock {
> > >     u32     snd_up;         /* Urgent pointer               */
> > >     u32     delivered;      /* Total data packets delivered incl. rex=
mits */
> > >     u32     delivered_ce;   /* Like the above but only ECE marked pac=
kets */
> > > +   u32     delivered_ecn_bytes[3];
> >
> > This new fields do not belong to this cacheline group. I'm unsure they=
=20
> > belong to fast-path at all. Also u32 will wrap-around very soon.
> >
> > [...]
> > > diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h=20
> > > index dc8fdc80e16b..74ac8a5d2e00 100644
> > > --- a/include/uapi/linux/tcp.h
> > > +++ b/include/uapi/linux/tcp.h
> > > @@ -298,6 +298,13 @@ struct tcp_info {
> > >     __u32   tcpi_snd_wnd;        /* peer's advertised receive window =
after
> > >                                   * scaling (bytes)
> > >                                   */
> > > +   __u32   tcpi_received_ce;    /* # of CE marks received */
> > > +   __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
> > > +   __u32   tcpi_delivered_e0_bytes;
> > > +   __u32   tcpi_delivered_ce_bytes;
> > > +   __u32   tcpi_received_e1_bytes;
> > > +   __u32   tcpi_received_e0_bytes;
> > > +   __u32   tcpi_received_ce_bytes;
> >
> > This will break uAPI: new fields must be addded at the end, or must=20
> > fill existing holes. Also u32 set in stone in uAPI for a byte counter=20
> > looks way too small.
> >
> > > @@ -5100,7 +5113,7 @@ static void __init tcp_struct_check(void)
> > >     /* 32bit arches with 8byte alignment on u64 fields might need pad=
ding
> > >      * before tcp_clock_cache.
> > >      */
> > > -   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx,=
 109 + 7);
> > > +   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock,=20
> > > + tcp_sock_write_txrx, 122 + 6);
> >
> > The above means an additional cacheline in fast-path WRT the current=20
> > status. IMHO should be avoided.
> >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c index=20
> > > 5bd7fc9bcf66..41e45b9aff3f 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -70,6 +70,7 @@
> > >  #include <linux/sysctl.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/prefetch.h>
> > > +#include <linux/bitops.h>
> > >  #include <net/dst.h>
> > >  #include <net/tcp.h>
> > >  #include <net/proto_memory.h>
> > > @@ -499,6 +500,144 @@ static bool tcp_ecn_rcv_ecn_echo(const struct t=
cp_sock *tp, const struct tcphdr
> > >     return false;
> > >  }
> > >
> > > +/* Maps IP ECN field ECT/CE code point to AccECN option field=20
> > > +number, given
> > > + * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(=
0).
> > > + */
> > > +static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield) {
> > > +   switch (ecnfield) {
> > > +   case INET_ECN_NOT_ECT:
> > > +           return 0;       /* AccECN does not send counts of NOT_ECT=
 */
> > > +   case INET_ECN_ECT_1:
> > > +           return 1;
> > > +   case INET_ECN_CE:
> > > +           return 2;
> > > +   case INET_ECN_ECT_0:
> > > +           return 3;
> > > +   default:
> > > +           WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> >
> > No WARN_ONCE() above please: either the 'ecnfield' data is masked vs=20
> > INET_ECN_MASK and the WARN_ONCE should not be possible or a remote=20
> > sender can deterministically trigger a WARN() which nowadays will in=20
> > turn raise a CVE...
> >
> > [...]
> > > +static u32 tcp_accecn_field_init_offset(u8 ecnfield) {
> > > +   switch (ecnfield) {
> > > +   case INET_ECN_NOT_ECT:
> > > +           return 0;       /* AccECN does not send counts of NOT_ECT=
 */
> > > +   case INET_ECN_ECT_1:
> > > +           return TCP_ACCECN_E1B_INIT_OFFSET;
> > > +   case INET_ECN_CE:
> > > +           return TCP_ACCECN_CEB_INIT_OFFSET;
> > > +   case INET_ECN_ECT_0:
> > > +           return TCP_ACCECN_E0B_INIT_OFFSET;
> > > +   default:
> > > +           WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> >
> > Same as above.
> >
> > > +   }
> > > +   return 0;
> > > +}
> > > +
> > > +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */=20
> > > +static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int opt=
field,
> > > +                                               bool order) {
> > > +   u8 tmp;
> > > +
> > > +   optfield =3D order ? 2 - optfield : optfield;
> > > +   tmp =3D optfield + 2;
> > > +
> > > +   return (tmp + (tmp >> 2)) & INET_ECN_MASK; }
> > > +
> > > +/* Handles AccECN option ECT and CE 24-bit byte counters update=20
> > > +into
> > > + * the u32 value in tcp_sock. As we're processing TCP options, it=20
> > > +is
> > > + * safe to access from - 1.
> > > + */
> > > +static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32=20
> > > +init_offset) {
> > > +   u32 truncated =3D (get_unaligned_be32(from - 1) - init_offset) &
> > > +                   0xFFFFFFU;
> > > +   u32 delta =3D (truncated - *cnt) & 0xFFFFFFU;
> > > +
> > > +   /* If delta has the highest bit set (24th bit) indicating
> > > +    * negative, sign extend to correct an estimation using
> > > +    * sign_extend32(delta, 24 - 1)
> > > +    */
> > > +   delta =3D sign_extend32(delta, 23);
> > > +   *cnt +=3D delta;
> > > +   return (s32)delta;
> > > +}
> > > +
> > > +/* Returns true if the byte counters can be used */ static bool=20
> > > +tcp_accecn_process_option(struct tcp_sock *tp,
> > > +                                 const struct sk_buff *skb,
> > > +                                 u32 delivered_bytes, int flag) {
> > > +   u8 estimate_ecnfield =3D tp->est_ecnfield;
> > > +   bool ambiguous_ecn_bytes_incr =3D false;
> > > +   bool first_changed =3D false;
> > > +   unsigned int optlen;
> > > +   unsigned char *ptr;
>=20
> u8 would we more appropriate type for binary data.

Hi Ilpo,

Not sure I understand your point, could you elaborate which binary data you=
 think shall use u8?

>=20
> > > +   bool order1, res;
> > > +   unsigned int i;
> > > +
> > > +   if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> > > +           if (estimate_ecnfield) {
> > > +                   u8 ecnfield =3D estimate_ecnfield - 1;
> > > +
> > > +                   tp->delivered_ecn_bytes[ecnfield] +=3D delivered_=
bytes;
> > > +                   return true;
> > > +           }
> > > +           return false;
> > > +   }
> > > +
> > > +   ptr =3D skb_transport_header(skb) + tp->rx_opt.accecn;
> > > +   optlen =3D ptr[1] - 2;
> >
> > This assumes optlen is greater then 2, but I don't see the relevant=20
> > check.
>=20
> The options parser should check that, please see the "silly options"
> check.
>=20
> > Are tcp options present at all?
>=20
> There is !tp->rx_opt.accecn check above which should ensure we're process=
ing only AccECN Option that is present.
>=20
> > > +   WARN_ON_ONCE(ptr[0] !=3D TCPOPT_ACCECN0 && ptr[0] !=3D=20
> > > + TCPOPT_ACCECN1);
> >
> > Please, don't warn for arbitrary wrong data sent from the peer.
>=20
> If there isn't AccECN option at ptr, there's bug elsewhere in the code (i=
n the option parse code). So this is an internal sanity check that
> tp->rx_opt.accecn points to AccECN option for real like it should.
>=20
> If you still want that removed, no problem but it's should not be arbitra=
ry data at this point because the options parsing code should have validate=
d this condition already, thus WARN_ON_ONCE() seemed appropriate to me.

Indeed, then I will keep this for next version, but can be adjust once rece=
iving further feedback.

>=20
> > > +   order1 =3D (ptr[0] =3D=3D TCPOPT_ACCECN1);
> > > +   ptr +=3D 2;
> > > +
> > > +   res =3D !!estimate_ecnfield;
> > > +   for (i =3D 0; i < 3; i++) {
> > > +           if (optlen >=3D TCPOLEN_ACCECN_PERFIELD) {
>=20
> It's easy to reverse logic here and use continue, which buys one level of=
 indentation.

Sure, thanks for explicit suggestion, will do.

Chia-Yu

>=20
> > > +                   u32 init_offset;
> > > +                   u8 ecnfield;
> > > +                   s32 delta;
> > > +                   u32 *cnt;
> > > +
> > > +                   ecnfield =3D tcp_accecn_optfield_to_ecnfield(i, o=
rder1);
> > > +                   init_offset =3D tcp_accecn_field_init_offset(ecnf=
ield);
> > > +                   cnt =3D &tp->delivered_ecn_bytes[ecnfield - 1];
> > > +                   delta =3D tcp_update_ecn_bytes(cnt, ptr, init_off=
set);
> > > +                   if (delta) {
> > > +                           if (delta < 0) {
> > > +                                   res =3D false;
> > > +                                   ambiguous_ecn_bytes_incr =3D true=
;
> > > +                           }
> > > +                           if (ecnfield !=3D estimate_ecnfield) {
> > > +                                   if (!first_changed) {
> > > +                                           tp->est_ecnfield =3D ecnf=
ield;
> > > +                                           first_changed =3D true;
> > > +                                   } else {
> > > +                                           res =3D false;
> > > +                                           ambiguous_ecn_bytes_incr =
=3D true;
> > > +                                   }
> >
> > At least 2 indentation levels above the maximum readable.
> >
> > [...]
> > > @@ -4378,6 +4524,7 @@ void tcp_parse_options(const struct net *net,
> > >
> > >     ptr =3D (const unsigned char *)(th + 1);
> > >     opt_rx->saw_tstamp =3D 0;
> > > +   opt_rx->accecn =3D 0;
> > >     opt_rx->saw_unknown =3D 0;
> >
> > It would be good to be able to zero both 'accecn' and 'saw_unknown'=20
> > with a single statement.
> >
> > [...]
> > > @@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th,=
 struct tcp_sock *tp,
> > >             *ptr++ =3D htonl(opts->tsecr);
> > >     }
> > >
> > > +   if (OPTION_ACCECN & options) {
> > > +           const u8 ect0_idx =3D INET_ECN_ECT_0 - 1;
> > > +           const u8 ect1_idx =3D INET_ECN_ECT_1 - 1;
> > > +           const u8 ce_idx =3D INET_ECN_CE - 1;
> > > +           u32 e0b;
> > > +           u32 e1b;
> > > +           u32 ceb;
> > > +           u8 len;
> > > +
> > > +           e0b =3D opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_O=
FFSET;
> > > +           e1b =3D opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_O=
FFSET;
> > > +           ceb =3D opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFF=
SET;
> > > +           len =3D TCPOLEN_ACCECN_BASE +
> > > +                 opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> > > +
> > > +           if (opts->num_accecn_fields =3D=3D 2) {
> > > +                   *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> > > +                                  ((e1b >> 8) & 0xffff));
> > > +                   *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> > > +                                  (ceb & 0xffffff));
> > > +           } else if (opts->num_accecn_fields =3D=3D 1) {
> > > +                   *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> > > +                                  ((e1b >> 8) & 0xffff));
> > > +                   leftover_bytes =3D ((e1b & 0xff) << 8) |
> > > +                                    TCPOPT_NOP;
> > > +                   leftover_size =3D 1;
> > > +           } else if (opts->num_accecn_fields =3D=3D 0) {
> > > +                   leftover_bytes =3D (TCPOPT_ACCECN1 << 8) | len;
> > > +                   leftover_size =3D 2;
> > > +           } else if (opts->num_accecn_fields =3D=3D 3) {
> > > +                   *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> > > +                                  ((e1b >> 8) & 0xffff));
> > > +                   *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> > > +                                  (ceb & 0xffffff));
> > > +                   *ptr++ =3D htonl(((e0b & 0xffffff) << 8) |
> > > +                                  TCPOPT_NOP);
> >
> > The above chunck and the contents of patch 7 must be in the same patch.
> > This split makes the review even harder.
> >
> > [...]
> > > @@ -1117,6 +1235,17 @@ static unsigned int tcp_established_options(st=
ruct sock *sk, struct sk_buff *skb
> > >             opts->num_sack_blocks =3D 0;
> > >     }
> > >
> > > +   if (tcp_ecn_mode_accecn(tp) &&
> > > +       sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> > > +           int saving =3D opts->num_sack_blocks > 0 ? 2 : 0;
> > > +           int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >
> > AFACS the above means tcp_options_fit_accecn() must clear any already=20
> > set options, but apparently it does not do so. Have you tested with=20
> > something adding largish options like mptcp?
>=20
> This "fitting" for AccEcn option is not to make room for the option but t=
o check if AccECN option fits and in what length, and how it can take advan=
tage of some nop bytes when available to save option space.
>=20
> --
>  i.


