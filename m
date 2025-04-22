Return-Path: <linux-kselftest+bounces-31327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AAA97189
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE83BD643
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDD28F52C;
	Tue, 22 Apr 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="J+BfwCN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA331E87B;
	Tue, 22 Apr 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336943; cv=fail; b=Ghs0PsQwxS17RrVXQuqc+mSPNg4p9oO7wC7QBHQQ85CdUiS6hdr683UoA7uG7cv6XVr0AITiHnVQcFPi7D+n/1majHhX6jA3But52pUL8H2hPtLvrH0mdeSn8xDwAaJZ28KjK7lj05Aj9FRx76mqoilGe1FKeUcTn+gwisWPuIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336943; c=relaxed/simple;
	bh=8/ASIU3KM+LZm92LE18ycTLyBwwEKOVtH4mOymLbab4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOglBl0AsJyeVq0ZInhn5WBzePKXXr0OCUE6Dgiu5JFZ0uKDgMe4AeCEVjVdgD1t+YcNWlcnoJUk8AZiJ8zu1Zup3tix7y3hcwlhrjL5kjKQF+3iKCuOteetO7YflE63702DlhjWj8AwdcIpCc79fFiQ7CuoZ4YTtxqfwPH0vSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=J+BfwCN5; arc=fail smtp.client-ip=40.107.103.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKQdtVarYr9Veh0lwEc7mdQY4aai2tMGHtW19KmWNf/2WqhBCXEEkQGLwUQTxtA9uPXf+urqRXjBNmv1jCbK2cKTf8qj5KfmaUYkXzn+iYVZ1GPU3lOTMF62M7XD6Tom/+vfu3m/OjC6Q0qsAH2yljXeojn6dxiy75KLWeIplMNDwRcNBsj01unMjME3055W7b0YHVR6i5IIgKd/pHUft+HKaGIqMNnZmB/8rtMR/3YOo2uZYN/ojyhRqbClYHKLCRZ4Kcdb59tuJiFqebYs60K70qTGQHkfoSJuM7YikN6e0xVU29bHqpbAfGNfKFKsEeg0oVAjw9dbNVqA2U/hMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtqRh/6WDqqho1RumDGGM981CMQlcx74OqpeQvNlE/U=;
 b=uiDhIgMhFDUIsp8eizGlhwEba+lXXYf5GMOZDpwERA538qa42jXbYK1vVJ16pxBghbWPv6WbOwXUVGihrlu6YnjqmUq0UWR3+FNIVjU/hvKeJhyd7f6tuTGs114WdLe+UtA1/OZ0jJ7npk/EHO1opoi2rU/ACzYSphz4HOc0XGCLWwPT4mB3GjcwBB1RlLZwr17Ek4YOffDbcw5v3QzgJsplLJaNEfzVSDZ0XS0YRpvXBDuLIqq1wPNk0QjYfvYwTAjefiTtIguowm6kU9m7CMH909NEFgbRX7DErYGSFSzYd1jNzxf8PvcpD8fFOrMBVBY6vwI0jFHqTVnmKywTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtqRh/6WDqqho1RumDGGM981CMQlcx74OqpeQvNlE/U=;
 b=J+BfwCN5+uHmwSRjs+IUiFmYMwp/lPJAhW8s7y+qJAOJTgQPm2YqYBntDF9CubEpY124lx+Jd8QSpKdDmd4rIcVTHod4csQT3PxnaEK5aMfdKMsjTeh0c1l9gTVJ5rSJoYorauRqbMBo4mUNF+IB3jp3ZtF2nw0cxMUcz50VSphPFzozLug6lXCYiVzIczVIGN5RlWCPcLMDnT4cKCtT+xbiBdJ8Ud/xdu9KQ34q/24wePTCzLhe1GQbZkvdREk4g5CSBslmOunIQMTRHkxIkTE4yH/mmre7mEa35Y8xngnfA+i1BICb6/noAVunk2Gy0461LG2D8bBLE96la1TWng==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB9460.eurprd07.prod.outlook.com (2603:10a6:800:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 15:48:57 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 15:48:56 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Simon Horman <horms@kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 10/15] tcp: accecn: AccECN option send control
Thread-Topic: [PATCH v4 net-next 10/15] tcp: accecn: AccECN option send
 control
Thread-Index: AQHbr+yhs+WfGX7w90WDBRxaoQG0zbOpsFKAgAAONQCABh1fQA==
Date: Tue, 22 Apr 2025 15:48:56 +0000
Message-ID:
 <PAXPR07MB798470401703ACBD26148633A3BB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
 <20250417230029.21905-11-chia-yu.chang@nokia-bell-labs.com>
 <20250418173407.GC2676982@horms.kernel.org>
 <20250418182458.GD2676982@horms.kernel.org>
In-Reply-To: <20250418182458.GD2676982@horms.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB9460:EE_
x-ms-office365-filtering-correlation-id: 80fa1b48-7109-4ee1-7888-08dd81b53104
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yvsjdWILpCq4ZhRYofWeqISL21h8eM2zu/guuI9CWTNzH7m7bitoa2LsO7?=
 =?iso-8859-1?Q?RaXxrNUH4TolYfsslYoD/bpHICwDGfdWgPGRTxwNkJxQzNdNjLOQZmFNtS?=
 =?iso-8859-1?Q?xmydSdnpfAqnmTO9EEwJD5pKZvSVlKG52E09Aa0kXGKnTukJ5/jSJRmj+7?=
 =?iso-8859-1?Q?ITmOy4xBWJMme70/GFTj3bM1uf66ekOfI7fipMKCRnLRZIFMpuCoUSMALp?=
 =?iso-8859-1?Q?6wCN+bIMTfV8PCxGF3fsdSY/jQscZCmEBh27ga+4neHow7sTls62zJpCEW?=
 =?iso-8859-1?Q?7smLuXqYNoS0YP7xFW/kdzIGTZQNURySDk0xiM5Udipn/kLb24FgFHVF91?=
 =?iso-8859-1?Q?GY0obSu0i3Yr2JqsRu8e2WXH4GP+PEL2H7XGy0ERhqspKS+nwE+hWDhOF1?=
 =?iso-8859-1?Q?3dD8wUAJuN38fJfS67YrTDh4lfmvFYRcTJFBUE6UDud2MPkX8hdVy+zTFA?=
 =?iso-8859-1?Q?BX6VV8d0AXsK9vgEMPs+eD55yeFWiaLWW1EVCe3rLGNP3I6OpfDDw9+W4O?=
 =?iso-8859-1?Q?xbwgex6Kw9errA0nLkdm/rDSVidf2HwPLQSFqqIk7eYM6i7nOw1/jgY62n?=
 =?iso-8859-1?Q?Ul7oxCdp74MPDPAZSzDSLUWspjOYw/DFAlxbpBI7KVXPM3Xtazb3MKlD6j?=
 =?iso-8859-1?Q?XWwcwtvhaQpZM/EvlWWJOg3jpYcY6CYorR+VbR6d0RN3TrUKZQIHzzuOLV?=
 =?iso-8859-1?Q?kDT7yN033ZZTyMWEhXRQ8Ds76oqI99d2dHDhSRULVR+nZqOwoWveRFxROs?=
 =?iso-8859-1?Q?KXIQI/1XO0o80SZJ9EQZ/OeQvp6WH8y1vGScM8z7ah1AUFazkTU7CeVaYF?=
 =?iso-8859-1?Q?hjdMhYfQIQ504wCZNIkSgd30hd2j2MsJbE2qMMiGXHK1wpyo7q7gPrDDYs?=
 =?iso-8859-1?Q?xHbN5UuNrMQxpoNzoj+/0wDN0DZY7Y2oIstZ3Y6REV4+qzRdGqRd/MRJSc?=
 =?iso-8859-1?Q?g/6HfOTLFPwQVK67qu54FBaLxxNeX6SC+yYPh52zuWh5Lfxz88o8yJs5uB?=
 =?iso-8859-1?Q?bKC0mVEhOLg0lYUMX+f34RBCWalzVsP2+Z+Ycm0IZF2A7VQ81QsB2YrfLe?=
 =?iso-8859-1?Q?JYIz5KyBgXhDv57vejoUTV1vQDfpP8zoiiwCHKJoQq7yfG4JJVDp4/14Ra?=
 =?iso-8859-1?Q?a3TMkN8mDDLiVVBXXtbOPxvstbDDC+WFKGrxttZ74BG+Ll/hdiYZa4YM2q?=
 =?iso-8859-1?Q?hnMZJOUYFVmpheB0OQK4+YVo+NFcBAmktoiB+fDa4OnrJMG6a94Fo8i64m?=
 =?iso-8859-1?Q?z+cROPXPlwBW3ycavmeAiWrnLc2QumPsbk4ajLnoEPU6vBkH8UJMWKJ5UQ?=
 =?iso-8859-1?Q?PAb6CdPzJ0AElQqxUM05CZCd613HEVqC9FgzFbxGKiYWUIzPKmpVN58iD0?=
 =?iso-8859-1?Q?dBmd5VEpfhjCG4g8w7G3qeGQ3qOIyqQDfz28zYHtteqFIzGW0fhvUWLfam?=
 =?iso-8859-1?Q?hvM5JdTT47LyHSlH9VhISKTQ62Hi+77vqs2xmRIEYRXPM/5lMXmxZ0oM+p?=
 =?iso-8859-1?Q?5nKxjzqZjZcYTNgSg84yl6vw/QtNDpshj5O0kQHFT6exMBlZQdg/m656zC?=
 =?iso-8859-1?Q?R1iEdGo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yHsjaBXlGHzHOFNKiWQpB61D2zHWU7JEnAz6C6Zicv+OOdzaneAPRY7c1i?=
 =?iso-8859-1?Q?aLMUyWXLvyBL9634BaLNgQ9TfF3ogsZRvXqd59pj7CT3w1sxl+Ylb98FQ1?=
 =?iso-8859-1?Q?K+PgrI48ZMO73fylNvRxeKWya/lkUz1DpqcPSQKvl5r6wUjJ4AYJP9vbTe?=
 =?iso-8859-1?Q?5jqpzRTt3GStv64JWeUAXqEX7CMQzY3mEfMx6/DFVvlS0xiJiWmfw3DrKO?=
 =?iso-8859-1?Q?WszYE+C48DtklPSZQiwUuAiIJQxLIlZ7sftOR1Mk6L01QDADUVDw3ek0Sm?=
 =?iso-8859-1?Q?Al/fW+b3ZI6gVBHfGCWrLq0njlTTPbu1oBlwKawRrc6cci6MGR6NzVG60q?=
 =?iso-8859-1?Q?T5vkzrDjQ3YdHd3s3RfmoML2aKM5tTwicGgdg5euNOerfTzNBAReVgUSY+?=
 =?iso-8859-1?Q?rHnTPAwgYaJDn/rr96qQuz5l2RFIVnXS9x+raMX905l5EgR4jRPe87WRlP?=
 =?iso-8859-1?Q?SzRpMhlT7hP9G7I5zknOU83u/3OTI2vib+4rD0UVTohM0mZ6Mnz3j/StP7?=
 =?iso-8859-1?Q?aW7lGjc5HjNyqtav9qBzmvA5bOkm1l9tAPoCsCd7BhbeV+xJKXkYFybNsk?=
 =?iso-8859-1?Q?CpxsQikomoxRBLm5pm/M/loiZ01HzuryFCKKH/nDc6rOQOhvKKs0iAe2U+?=
 =?iso-8859-1?Q?2ZEYzux2RVjGN/KAltfVf9mPvGsspVK1vOeUTDQ1nFZR4iTIpyCMU6/7iK?=
 =?iso-8859-1?Q?rx8AJcbgsOheCj1OHUeqFcTwQpJIBKemQ9Tngsrmep4cBPlxfAztVHbNHs?=
 =?iso-8859-1?Q?AHb2WQ9VrhQotX2aXttUcQtmA5pH43L8WmKjfI1mPdzrGs245EZysYPM3n?=
 =?iso-8859-1?Q?OjjxqcsRvFTXLlZS+WzR8F38i9vaOjGFtAg83O6yhm657G6V6dz4VMr+6i?=
 =?iso-8859-1?Q?udeVpNoElSbMIPY/gCwnWESiEtvWqOQ/F6SMGECegHDzuP5HocWAFdqN1i?=
 =?iso-8859-1?Q?xrpB1ZS5HiWJj/lw4IZZGs9FOzSOM1ZLXFfIVgIB/rBK/RmajuyDw4Y8cQ?=
 =?iso-8859-1?Q?fqGH9TYlZ9+Kqh+nYpeQwC8Z1qcVoTx/xqnjd6ZkDhYnriPUL2ILeRq0h7?=
 =?iso-8859-1?Q?tO5qVne08/8rnZyF2k8LtVG3dcJA6Kn6DE6OjSFjBskBc7HS9k8w1Pn0X0?=
 =?iso-8859-1?Q?GIRErkZRwlxZaLLw3Zrksu+IGkjfRpIpWWBT/RZIDi23tn1N+9yGzcRJYj?=
 =?iso-8859-1?Q?xNU6W08e6803DaXoXswfW/d9ELgQwE+FJfrfjeK7Nk/SoGW/aJ0SR207pR?=
 =?iso-8859-1?Q?BKFvFBBx1WdINIe30u5GNTlkb5Cu6xHMZibnWBzLeLm8P8ok8tSlcKINGX?=
 =?iso-8859-1?Q?MTqWyIW2zAwun0VKhcHhv2qnm2UgWHwNI/BVeH2hzDEw2yptU6OR1hY/T6?=
 =?iso-8859-1?Q?OD2x1dggTqhlyKhQ4lVwmWN48S8aZ+Ncp+GppUcMDZ0odpQ9aMC0vAU9Mr?=
 =?iso-8859-1?Q?qBfBVz4MaXYRQOXEo/eAkir4x8RlQE8nX9a3ZP6jUqRNUl9Rt02/tJnefs?=
 =?iso-8859-1?Q?tWRs6/E6UHvrDlwhlYH0poXweoV6iemxqiH1O7K0aytKvv12qX7kKOvNT2?=
 =?iso-8859-1?Q?IcC6S2l3q69VLkYB6fOQYAPm3UvkY44a8K4AEzdXCunYer1BsrHvRMJOgK?=
 =?iso-8859-1?Q?M/rXwc/QHgqWLKvpeZkoHw3QXYlY/J5phk7RkkxWZIGFqIBeATA2COpg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fa1b48-7109-4ee1-7888-08dd81b53104
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 15:48:56.7710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtR40RWYtSVCf9qq1Voh1i+XjL4Abr9CRcl6qbM9xySZbUmSMB1D/kL+RgbIqOVBbgCblNdxVc4Uu29LmLQ2SLrXJe39Vvrgt5qkgxOWHul3tMeBJ/iaiZjSyfG0GOQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9460

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>=20
> Sent: Friday, April 18, 2025 8:25 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vg=
er.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; ku=
ba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@r=
esnulli.us; davem@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch=
; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@ker=
nel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.c=
om; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.com; mirja.kuehlewi=
nd@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcas=
t.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v4 net-next 10/15] tcp: accecn: AccECN option send co=
ntrol
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Fri, Apr 18, 2025 at 06:34:07PM +0100, Simon Horman wrote:
> > On Fri, Apr 18, 2025 at 01:00:24AM +0200, chia-yu.chang@nokia-bell-labs=
.com wrote:
> > > From: Ilpo J=E4rvinen <ij@kernel.org>
> > >
> > > Instead of sending the option in every ACK, limit sending to those=20
> > > ACKs where the option is necessary:
> > > - Handshake
> > > - "Change-triggered ACK" + the ACK following it. The
> > >   2nd ACK is necessary to unambiguously indicate which
> > >   of the ECN byte counters in increasing. The first
> > >   ACK has two counters increasing due to the ecnfield
> > >   edge.
> > > - ACKs with CE to allow CEP delta validations to take
> > >   advantage of the option.
> > > - Force option to be sent every at least once per 2^22
> > >   bytes. The check is done using the bit edges of the
> > >   byte counters (avoids need for extra variables).
> > > - AccECN option beacon to send a few times per RTT even if
> > >   nothing in the ECN state requires that. The default is 3
> > >   times per RTT, and its period can be set via
> > >   sysctl_tcp_ecn_option_beacon.
> > >
> > > Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> > > Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > ---
> > >  include/linux/tcp.h        |  3 +++
> > >  include/net/netns/ipv4.h   |  1 +
> > >  include/net/tcp.h          |  1 +
> > >  net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
> > >  net/ipv4/tcp.c             |  5 ++++-
> > >  net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
> > >  net/ipv4/tcp_ipv4.c        |  1 +
> > >  net/ipv4/tcp_minisocks.c   |  2 ++
> > >  net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++------=
--
> > >  9 files changed, 90 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/tcp.h b/include/linux/tcp.h index=20
> > > 0e032d9631ac..9619524d8901 100644
> > > --- a/include/linux/tcp.h
> > > +++ b/include/linux/tcp.h
> > > @@ -309,7 +309,10 @@ struct tcp_sock {
> > >     u8      received_ce_pending:4, /* Not yet transmit cnt of receive=
d_ce */
> > >             unused2:4;
> > >     u8      accecn_minlen:2,/* Minimum length of AccECN option sent *=
/
> > > +           prev_ecnfield:2,/* ECN bits from the previous segment */
> > > +           accecn_opt_demand:2,/* Demand AccECN option for n next=20
> > > + ACKs */
> > >             est_ecnfield:2;/* ECN field for AccECN delivered=20
> > > estimates */
> > > +   u64     accecn_opt_tstamp;      /* Last AccECN option sent timest=
amp */
> > >     u32     app_limited;    /* limited until "delivered" reaches this=
 val */
> > >     u32     rcv_wnd;        /* Current receiver window              *=
/
> > >  /*
> >
> > ...
> >
> > > @@ -5113,7 +5116,7 @@ static void __init tcp_struct_check(void)
> > >     /* 32bit arches with 8byte alignment on u64 fields might need pad=
ding
> > >      * before tcp_clock_cache.
> > >      */
> > > -   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx,=
 122 + 6);
> > > +   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock,=20
> > > + tcp_sock_write_txrx, 130 + 6);
> >
> > Hi,
> >
> > While this seems find on x86_64, x86_32 and arm64, it does not seem=20
> > correct on ARM (32-bit).
> >
> > This is because the existing two byte hole after est_ecnfield grows to=
=20
> > 6 bytes. I assume this is because of alignment requirements.
> > But in any case, the result is that the overall group size increases=20
> > by 12 bytes rather than 8.
> >
> > I believe that you can avoid the hole growing, and thus limit the=20
> > overall increase in size of the group to 12 bytes, by placing=20
> > accecn_opt_tstamp elsewhere, e.g. after app_limited rather than before =
it.
> >
> > You can exercise this by cross compiling for ARM and examining the=20
> > structure layout using pahole.
> >
> > Cross compilers available from [1] should be able to do that something=
=20
> > like this:
> >
> > PATH=3D".../gcc-14.2.0-nolibc/arm-linux-gnueabi/bin:$PATH"
> > export ARCH=3Darm
> > export CROSS_COMPILE=3Darm-linux-gnueabi-
> >
> > make allmodconfig
> > echo "CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy" >> .config yes "" =
|=20
> > make oldconfig
> >
> > make net/ipv4/tcp.o
>=20
> Sorry, I omitted the invocation of pahole.
>=20
> pahole net/ipv4/tcp.o
>=20
> > [1]=20
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmir=
r
> > ors.edge.kernel.org%2Fpub%2Ftools%2Fcrosstool%2Ffiles%2Fbin%2Fx86_64%2
> > F14.2.0%2F&data=3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7Cd00e2=
9
> > 455c5a42475ae408dd7ea658e2%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%
> > 7C638805975110989177%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI
> > lYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> > 0%7C%7C%7C&sdata=3DjYRGDvf%2Bx7lGuSxtgGfredGRNZYDdmlxpiUnwQr4ICQ%3D&res=
e
> > rved=3D0
>=20
> --
> pw-bot: changes-requested

Hi Simon,

	Thanks for the tip, I just fixed it based on pahole results and resubmit v=
5.

BRs,
Chia-Yu

