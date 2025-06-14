Return-Path: <linux-kselftest+bounces-35017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC4AD9E4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C603B2A38
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17431148830;
	Sat, 14 Jun 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pGyikRJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69C2F32;
	Sat, 14 Jun 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749917858; cv=fail; b=jFGRFFC8oGXvF/ntWBwobVYEqBjBMGoVb4Ky4DgmImBWXNdvkVk5pGxaQMimWNYqFjTuh9iarLwHhlGiLSfJsaNZoPk8Rjfzoz3B9OVvLQnDyxH9sFmvomzrc/GkHZ1CsEqvyh/sVd5t5deRSfKHI3Vhmy3gM0t02oRHcz/FrOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749917858; c=relaxed/simple;
	bh=vLo/frPaaRslSy+9XOkjuqXXFgHsRdRFmKX71+bEJpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wdsx6zUyvD/JayALr5miyR3c9+50uX0hQGLfFquKM/zFAmKo6gr0TPSFCnyGMz7NE627Q2xulT7Eu4jTwfD9C0gQFRa6AKwi+g8gCrv7aB4sI9fh4nPXj2QBRZz6csDUiahabq1stZaw7y+Dgu9Q5QbZwPAzQ648erDN83g5q1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pGyikRJS; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNWyhM2TdTZeX9ED7s2IvyzzDmNwBM2/6ByzYufvWNea0x7i1YSXbrz6a0XqiK7qLR9DSerr95O+u9dC04/ERzxNlCcI2rBblWd/o4EMHcFcSfkQUUdZGFgG2dJCex6VrkXClwdsZRaK0JEPkpkjaw8T4wPwsq2eQktyWKyPNs1936x9gyz3u57/3qs1H3eAIl3BecK6n2F8vu9trSUL8g8wQh1fGxRY1JQkBp7yoZCvw1YKVtHjTGGqd0VDBScJrCLWoek9cEi1dCKXzY5JEUcyx0OjK0O8DXeXo6VN7b+6dzjdowNrJBnv58AwYFhm6tKRkyXUlqMdsd45Ymx/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQGyrfjVqsyKBHt7OHhI3TvEX5dGkA2BNvRqIK/64qk=;
 b=ofmJzJqUNzWdbWi0AwZTklthT6wzvLYg0sYSx0KppOq/ZS45xROY+mWcuXtRaI9JvpI2YIGRwNYKuiZr9JWHis7yYuHmKTb4jC+7xTB7xvkYnmyltM27IoBx0Xq9ttwQ/cVaabUtPLdCX7Ex0WBuHGWxT2+E99u/M6lD3Z0K/n3H3L1dPh9qZCNz8jlqBxtNh/hzEOUlIDX9FWlI2NMU/B1R/lhVgH+Xzep4TPMaFs+lvfINV/ye0Un2Vgr+h0DhQaMjdaMZIXluhNcGwEvuhDzQHVVGTce9nmv0Z+GrzEen87acFiHThJU9OGoEnwvToCyftGF+CMqk1nEOfozMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQGyrfjVqsyKBHt7OHhI3TvEX5dGkA2BNvRqIK/64qk=;
 b=pGyikRJSHRVsSemLrypsYwLKQE7D3ZpOtozHbdFdcucRA69/jH+BfeLsRgAJVOvBtzPiEoSouXPiZ9UYWNYG8EWA+D4FL5paMtYJxJGi/05ze0W8Fs4r4hjNWDmZ6yG1j9fFU72M+Blxmlg+sfh5m3Kspnw09CDWuF3WPNPrOOiVOlDAjz8DwJ/aUFf7MnIqnz+vYSGx67F4YoY5Aj1laBKL1mxirrd5cfc73g+vrDDiGBvC+IPkFir4gLahCWfuLtUIudgYr8nt7YXcKNJjbDUGGvo4qisqmT02/skJPKY93vs3QIB7jMu2z7bwF9RWieMuLSPTOlepEuTS+qNSzA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB8988.eurprd07.prod.outlook.com (2603:10a6:150:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Sat, 14 Jun
 2025 16:17:31 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8835.027; Sat, 14 Jun 2025
 16:17:31 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "xandfury@gmail.com" <xandfury@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
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
Subject: RE: [PATCH v18 net-next 5/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v18 net-next 5/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHb3Hkb3uA7EiO6tki4mPNsahtnl7QByXgAgAEMjsA=
Date: Sat, 14 Jun 2025 16:17:31 +0000
Message-ID:
 <PAXPR07MB7984E1E864613BCFB9F9BE45A376A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
	<20250613153725.7983-6-chia-yu.chang@nokia-bell-labs.com>
 <20250613171352.310a7594@kernel.org>
In-Reply-To: <20250613171352.310a7594@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB8988:EE_
x-ms-office365-filtering-correlation-id: d2e5157e-a7e5-48f8-bc72-08ddab5ef6eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?St0BgXfsjrEWOXsaYiWU6fPmGpsVE3rjlv0oa7nJWgUATgHEmKxYVNWcurx3?=
 =?us-ascii?Q?RfKeFL3UEunfwJUPxaiVbezQdxexlQVRRiilgR6ndTOXNU8VA8MHdr2FGR4p?=
 =?us-ascii?Q?ZZUihbd5jfAjLPd/msOXFzgpkzWJq9eD/PxnLjoCkZUOhMd3OI2jiPok1KdD?=
 =?us-ascii?Q?H+VlKv8rEJugdciu7sw0V98pVb26MllXPKvyIY6JhZVzOW0WWE6mQFUMk6zX?=
 =?us-ascii?Q?vgepO8u64cZBPTnO6lcnR4KfEipC0vL2dUQbZXe5eXPCn0x//KKYteEViDbJ?=
 =?us-ascii?Q?xpDhbuZt2mnf0z6j1luH5uz9bBE2cqtbYSgYUxK3NsqAnJjIpN34lT0o+EMw?=
 =?us-ascii?Q?p4gGhZ4L9/ztpTR3xkjuzKjXVLh9le7HKHK3IyHrQL1AqlrcpUiTZ1Osd4Ed?=
 =?us-ascii?Q?x0XmHmaKt5FF/84vc46ThMb4Hb1mSGRzXanUUMUb0mLxXwD/v/5VimfLnI91?=
 =?us-ascii?Q?rC3RlJrRUJ85ooDUxMRA9o0tGhSOUdeCaXRE3aET4SQ+z1GA2AHgamOB4O11?=
 =?us-ascii?Q?lwlqOnGMpCUQlqVejH8/hKifJEddp3M4Zv85d5U19MsluUQt951usHUnoLCM?=
 =?us-ascii?Q?3MErQr8plIjum6lmOQVWUN0kZWusbr4Ugdcx10Zj+j+ADF6W1NYKKas9IREA?=
 =?us-ascii?Q?QDAUAHLWAbTm0snvBPA0RxYgBAyzgNaERvaCPHVwBUWHgDFxHR3tyyFaxduG?=
 =?us-ascii?Q?uSs6hT493MLOusS2GcAbQ+A3RunkCJm00khGICfDnio8Je2knLhszmyoG8yP?=
 =?us-ascii?Q?GDG+GrOHHXV1PQOohch4RNYZGaLCHmbcWjVjnNyruR3KRh6ojQ4eplFCSYpR?=
 =?us-ascii?Q?sov/gw784WyjSnmXTDqACevqgPTBF7H63oG2ZY4xZ2nHH7xvr6Z5U4RwGyNX?=
 =?us-ascii?Q?zxLsgIFkLgKQQBno438Ftsb+8BCg4+tupXvgOxoJXHab8f/sUSZb8UyizbUl?=
 =?us-ascii?Q?10qKZdw49ZaH3u9tbokq1+d7J3Ei8xFqkL5W43FxLqWElsz3Twp78MSTrbBW?=
 =?us-ascii?Q?Fh46DGDYj5ZHzKyOucAe85fTkAAf97OZdSjTPO11p2KlFx3W3FFkq8Wgbsq7?=
 =?us-ascii?Q?kZxHXJwY0GWeSLEiaJM5ejntj1nlIjp59hahx7+ajIh3BlqjjU0KO45PV+yf?=
 =?us-ascii?Q?oNIh53N+iKWaJv84uCdN5ghvgfc3mSu4IqqaAbV864v6J9blTjwPEzc337/Q?=
 =?us-ascii?Q?B+WMlp02e49vsTSfhNhDRJvu/9kDSJf18EgyJmmbN9rjGh7lD7Smeb5zmNr1?=
 =?us-ascii?Q?HJsPCIzyOBmELznc6zl8kOwy2J+OaTe1zczzF9r/bCEOTojB9vypJVXxnPCu?=
 =?us-ascii?Q?b1IVgsPb5YDRA9qXGb5qOT84lrx3l6j7brMdr7YTSn3Sv0OMuHN8BeUnKyWA?=
 =?us-ascii?Q?D2VpuzKn/cQ0Jvoz2U5mRF7cTJLKtSCrYG+1A5nAG6kGrxrTlulS0OQ8O/kO?=
 =?us-ascii?Q?zZA8xRbdbf3H+PdMn56uOHkaskqTTzHBNmknlcBSp+LQdAC9lIIzLxOOO34r?=
 =?us-ascii?Q?zsSQOcwol2Fub1I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ej2hU39BN4+BteYaypAzdBO0Am40rjtbIDz+rkSsuOb4u8+goKkfobcAYSzd?=
 =?us-ascii?Q?8pByAcvpLaTuB+l8CWkyx1tMvP52kCUEzbq5ArLBwfvY/zmmM4awnCvndUNH?=
 =?us-ascii?Q?cZjP/Eu+yiPHqRUvfVmavnpTrCImk8O9E2H1UDg4cStXNdU85gJs3P7wyiZ8?=
 =?us-ascii?Q?K1Ja6A+IL3lD6x69p/SuT8I1/ByQ4AmpBQh0GmccnjnwpIxVAkkfQOepaZ8b?=
 =?us-ascii?Q?ZZApMXzQq7aM0JppCk44fpFonuYPXRT536CLIsL7ypHWcFuODRJCLJvp/Rtk?=
 =?us-ascii?Q?Rj1bfGkUCXki8na3mTECOK6S+HRVf/biLm1Atnz2jsy4Y4iCd3EPd19FoMFA?=
 =?us-ascii?Q?Tq97KGaU7d+/6CwCZgloS8xsA6Lo6nJ9731BqlO8felH+vvH14bfwxFtRRwZ?=
 =?us-ascii?Q?+heI/DsuCM2zfSwQx+MXKAlte60axxjIrl9ew3VD4oCe7MLU1r6v8dC085js?=
 =?us-ascii?Q?t8DFNZFCNUt7PebyRVsbXHJmZh73Zu4xy1Ck/zoGyd0KUaHM9IURhq058z2j?=
 =?us-ascii?Q?NH2uGKoBEaH/X79XGACSNMuvQuGpIn42UXTSXy4kY7yPWlYbr2hm/aAzhZv6?=
 =?us-ascii?Q?O5s0/djGoTh7NvAUis70tCKIG4s1dePjJLTOGTXlnlM7q4ag3Hw0a86RgsJx?=
 =?us-ascii?Q?/E16EbXXUM5hvdbKmGOEl7Sm0nGjhzLJS1E1Ni4h5OtFZHrUXysj32w68nQ+?=
 =?us-ascii?Q?F60yZry0J4p5Lg6Ns3R61ePQcMique4MEnlVy52pdzQSRIYROXNpILCGRaF0?=
 =?us-ascii?Q?+p0iifBRlmW59YQKyhgZqxcExdVvrC48X3qqS3+Yq5m+cKB8uw1ma7R1iqm1?=
 =?us-ascii?Q?6lyYa4kAGmQQN6b5DGaL4QtkeW+i9nzQOK+Sue3TskkkPDWK+tXCazXvd5Fz?=
 =?us-ascii?Q?TZJCeTXUgbSWqu80qLA7b1qPvdyINnkzIsb48ZNyqWSMzkABtJX1o58pKSwM?=
 =?us-ascii?Q?r0n714MRi+yKUl0dhnbzLH7ml2SCRxCNvddh2CP1Q+ikJ7AJEhRoE168YLzs?=
 =?us-ascii?Q?KVc/kHZjxnFQ5Z5xFB/7Gjoy6kp9Org3RouHvIN/48xA4D1g9c6l2POSHTx8?=
 =?us-ascii?Q?lfp+Wwk2wJAiWlerqe9VgxVA9wu+2JrSsFuviMa9fjFM7QfXO9G7F9qkOEB+?=
 =?us-ascii?Q?nim4+eEYoGJ2wvuI/+JXEUky8USuHQKL3u9Xfmw7dUKSfJUK9+j3BhhwnUB/?=
 =?us-ascii?Q?euaj10OXouicXTSZ6DPPUJqTBXLZ1iJMjNoyJbbRmELLPUI8JWvLHu6hoaiI?=
 =?us-ascii?Q?AOEJp0kowWCjc/8+1qjeEzSIk9XtVKWz9kY7Vo94h2ni+TEuoEXIe/87x0z6?=
 =?us-ascii?Q?uT0EbkjvXEHxIDGGNGcEDvH7X+FUk8lOLo1XaJePHXEFDpCaIgZ2CpoB+e6f?=
 =?us-ascii?Q?lF/e1csQj0wFDM7a0+foKJ2lN+S8HC6ckdp/jKEN31guXTWzT4jfurm+EGxT?=
 =?us-ascii?Q?MGLJ51Z1VuLGqKj3ibhxJ18GPUbIzWO5NrtE1nT0BK8Coj9rT6FU8+WHRKr5?=
 =?us-ascii?Q?1ZUfHJ+9kPo4S7G/VSz7XTPx0bo4Bt17zGK2M3RjG9ELdVDSgjjK3RnXtV/Q?=
 =?us-ascii?Q?xbLPvdrflUZnZAAYCwiUSSnCqHaVfESd+eB5EZ2Urul7YlcwSlPbm1KBewas?=
 =?us-ascii?Q?Vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e5157e-a7e5-48f8-bc72-08ddab5ef6eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 16:17:31.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8nc6Hy61F1d8Do3cfxdtsEsqdWnKB6+yL2tONjv7YhBVKFdZwZIbNmUpml01VKEgUEO5IoJcnEOjIalwP9veLuKu5Fy1Rz4QVakEuHetFWiUuM1GO9MbIw4zoZA5Hd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8988

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Saturday, June 14, 2025 2:14 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: horms@kernel.org; donald.hunter@gmail.com; xandfury@gmail.com; netdev=
@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com;=
 stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; da=
vem@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; ast@fiberby.=
net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.or=
g; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_s=
chepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@er=
icsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.=
at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v18 net-next 5/5] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Fri, 13 Jun 2025 17:37:25 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > +        name: step-packets
> > +        type: flag
> > +        doc: L4S Step marking threshold unit in packets (otherwise is =
in microseconds)
> > +      -
> > +        name: min-qlen-step
> > +        type: u32
> > +        doc: Packets enqueued to the L-queue can apply the step thresh=
old when the queue length of L-queue is larger than this value. (0 is recom=
mended)
> > +      -
> > +        name: coupling
> > +        type: u8
> > +        doc: Probability coupling factor between Classic and L4S (2 is=
 recommended)
> > +      -
> > +        name: drop-overload
> > +        type: u8
> > +        doc: Control the overload strategy (drop to preserve latency o=
r let the queue overflow)
> > +        enum: dualpi2-drop-overload
> > +      -
> > +        name: drop-early
> > +        type: u8
> > +        doc: Decide where the Classic packets are PI-based dropped or =
marked
> > +        enum: dualpi2-drop-early
>=20
> please wrap the long lines. yamllint is your friend
> --
> pw-bot: cr

Hello,

I mis-submit again old v18 to the mailing list before submitting new v19.
Would it be possible to remove (or just ignore) the error submitted v18? Th=
anks.

Best regards,
Chia-Yu

