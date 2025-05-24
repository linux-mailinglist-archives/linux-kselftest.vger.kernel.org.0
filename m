Return-Path: <linux-kselftest+bounces-33731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F49AC2CC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 02:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4941BA5227
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9D1D5CE5;
	Sat, 24 May 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AQUgcWJt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2C41C71;
	Sat, 24 May 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748047858; cv=fail; b=qGbliBuhOOmKfWGHKpLFr7itgvKE3J+SewTS0//dyhnRUyjpUbnylqwI4goROkd6I3+QFLxKY3Vzks1hmWROsC01HYOrPX1P47Tdm65N9+mQ99u1ck3rZuRf01ziOgG1vQTitBXSb0qCFaOyWNz6huHOyFE+JAhCBPsljCQAYxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748047858; c=relaxed/simple;
	bh=SSd0/RYGPBy0phaw9HV79TAs39+dF3n4yRNjPeRMcsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E+5PkRSkon6N0SnHq0TxLSLjxUBEOdtLWlE6RUVknVoAaMqjeI4zb+BO2e8tiJLsQEr5btxaUj7DcPV9Qd9uzO1Ymy1iXLkFUTihROj1bvgWmIvzz6rMqMnrqW5ys/wqnkE6vLMgKgPkYc9et1rG1vstREDPw7u4bdWr9tjK8ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AQUgcWJt; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG/thDO52pxSocfES1nGXBzpLXjbcu1NIsvDvHBk16q8whcvlEJyDDA9VoKI9I3oCxUmP6HWmFEOrH1H8VGyhuh4VqkAtSXq9J67N+DJejwUo8PDNAWfXXJ67Xn4WEpg1QLGRLPTgMJjUOFG/kbXdt1ulX8DlQ2Non6zCb/QevZvKU8N9GCaHgrj1alocpjqUd8nz+oh5x0sG6hjJoXYqA1XXpNDhQ+A52DR0wyd2LWQ1EEp03FKFQ/Ti4kD3lJTDCgJhIHHQ1iAYv5YsDjTe1sLzQhKvUCqPYo7l6bo8zL0yqZ5z5+/sIPo4QVc6rzkjKFtzu/2W+RJVcnXsErZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biVENf7UAuXz8MX1jL6MzVx11gOyvCH2Lw8lApcmAkg=;
 b=UtX1jq6Hp1EoSgrz27lcJ+5E+/4sKpvgm3uuwJIX+u7RpaE9EFqQR85m1VET8XGlrai9d1DtzSaIr5KNgBIJc5uk2goPHKm0Zn0MjUfj5FhvdpOHf4rOFmjJUsnKly//pyx2KMMkbOyhiXiE4hM+5SLeSAWs1JSvi71ydrMNo9eofnAx5AEIBbqfNIjeBP6GkL0GyFF4TtI+v6GWTjFtnmiS5o6NkAd1qrFHo08TBKov0lrlpnMKmbaRq9Em+9PaLnPAsBVPSIHSxmR29OfTFu3VLwUP4THZ1QWcbswcN7sGmnnb8IahGJ2C8/IpZlOysYXX+82DMuDnwalyxe3rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biVENf7UAuXz8MX1jL6MzVx11gOyvCH2Lw8lApcmAkg=;
 b=AQUgcWJtPKTli3L/G+ugC4mXWzb+4ihASQ7kpjXKaXkP1XOGFymIOllSz3ZzViv/WsSRwVkP+BE46Jl0K52j2c6w6HeIjzH+cpQqd3mHvfbgdl6wFoXPhrDH10t6Go18MzqqReTzE+XcEn5TLIvIoD5xP7SvdMRNN/tZjqSNFUOBd2k34YnPjqukue2dXrT1mRTv2YTy9ZUcSdMXGFKrgrYpbaR2fjO1fZuUuact1f0L5Zg/1RkY+NmM8HVB9BXQDnLaBTdUn/Jzzw2e6AIY/6b5osLTGzDckYIPjVwWfPbbvFz5UTeYafm8ztje4CoQuFid9cFd6VVvNqIiEQRbOA==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by AS8PR07MB7991.eurprd07.prod.outlook.com (2603:10a6:20b:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sat, 24 May
 2025 00:50:52 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8699.022; Sat, 24 May 2025
 00:50:51 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
CC: Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>
Subject: RE: [PATCH v16 net-next 3/5] sched: Add enqueue/dequeue of dualpi2
 qdisc
Thread-Topic: [PATCH v16 net-next 3/5] sched: Add enqueue/dequeue of dualpi2
 qdisc
Thread-Index: AQHbxfXJ3sA7xE8RO0eNH1RtAFxwKrPbi8IAgAVlYaA=
Date: Sat, 24 May 2025 00:50:51 +0000
Message-ID:
 <AS8PR07MB7973072CDA18FB16109772C4A39BA@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
 <20250516000201.18008-4-chia-yu.chang@nokia-bell-labs.com>
 <8eae6bfd-c641-4fd4-9642-7fc038a974a2@redhat.com>
In-Reply-To: <8eae6bfd-c641-4fd4-9642-7fc038a974a2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|AS8PR07MB7991:EE_
x-ms-office365-filtering-correlation-id: 80052bec-0af7-4918-8854-08dd9a5d0847
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xVWIUGhSA52fEr2NLqas47Bcm2uDraCeNfkZZOBJRlP3XNctmDZx4W4DCU?=
 =?iso-8859-1?Q?NLP2vjGAzAXUU4IoXgkPspi5l7VAWymiz6/qdgqomOKcLTrrfLXgg977SX?=
 =?iso-8859-1?Q?qIRpVnPfAhtBNeOiD1IQmK8tccsW1bUNM1rx1WIsv+Ioo4VMMT3fiJqBG9?=
 =?iso-8859-1?Q?8FvuROxjHT6Jzq/GCiid1aT2zePKyJxEc6QehbnbkdtouVGKLetEdoML/H?=
 =?iso-8859-1?Q?hbHwLNTjIxkHk1pzVcKFpC8MbUzE7Mn7kz9xjKgqUlnyXbb6gMY/obUcCm?=
 =?iso-8859-1?Q?3QST4uwM3G1uX44Xug/YLVkXgSSMyezxUbv9WuaW2zO98NPKR5fIeoPqVz?=
 =?iso-8859-1?Q?wIKvrhNX/NLJM74dqtTlfIEhtSRc63BG107vlRCOYC18OKvjjLsaEUncBm?=
 =?iso-8859-1?Q?JzAScZzkXYvcoc9PuQxc8Rvx3RdWeiJYuXJhgA7RyeLPLZgwtAhnTN1Tuz?=
 =?iso-8859-1?Q?tP4ryM9Ulp9/bUXQpOTuVKn5SeJ6PURiYbeSJDi5V0mZR/mP7SoHB2YfDZ?=
 =?iso-8859-1?Q?p1a15xrdD3nroBpmiDAIi0ARcT69B6aEJh9gJzZH0P28tHWVhoCIJ6K7cZ?=
 =?iso-8859-1?Q?MG0Q+fa+UubYnZS59boD79Fl/1x5kha5CzId1huGOInksLyH6aLQY+cHX/?=
 =?iso-8859-1?Q?MvpWmnjsE5uV1qR9IExa/yYbtnA/ikQhgnptDOIjWIJcOa3YbY/SA03pkf?=
 =?iso-8859-1?Q?OWs+BWHlZn/e/k1i6Ol+05WHaKQjiyK44XZnCVCEozCcm43Plc1z4W56Px?=
 =?iso-8859-1?Q?WNESSGbMHLkVccrzu1BiMFUTchpGBMOtzIaBdz4bnXNzFCGoSvvKMzy3cE?=
 =?iso-8859-1?Q?w6ATmVZIYZKfCkz2TMf2I3IRIdPema9IFDWAoWbRtHKvQEP+Wl/oOzaFWF?=
 =?iso-8859-1?Q?hduAfWv/PMUYeig3f2jauLjeQTe+9xH0FTGgm56MJoESbb8Jc2ng/6Hcqi?=
 =?iso-8859-1?Q?c+BHuNEVK2AhT8Jp9isnAu1523Pt60IoyzemLTmXeDg7E8AnVNa5iKtCVP?=
 =?iso-8859-1?Q?oWdUHYpI+E3Jk62NjowcqErkhzt3p3pjM36R5cAJ9vH4usjCBfkG0XA6pC?=
 =?iso-8859-1?Q?Q2OGvQnIVMfcPQhHwm/2UKa77SY3fH9elQXNAKOfX9RCtJmpOMynSKXQWL?=
 =?iso-8859-1?Q?YHZ+1ap5fQMqI6HEqiPuo+A+C4W/SmWgLOQtDOnQ2EwTNeZCRCHy/LVwd0?=
 =?iso-8859-1?Q?teMMK/WxOiV5GD0ZC6K/fFfzMe1JJm6q87oJJHVQLA8I0FEMu6aOexHLV3?=
 =?iso-8859-1?Q?NlvjS/GlIPj7QeLbw8b7w2JLo1ChI7zk9GidghW1V3s+8eHYShZ3SoLGEV?=
 =?iso-8859-1?Q?QN4YFSMmEr+P0ORGEd0RWF/EGgZGo5/3ldzT+4R7l3V3C8X0cvgV9Xi+2u?=
 =?iso-8859-1?Q?KxlgMU63HWFY4PU46WjAL8G/qMI1aErKPBJgN3IAvre8O3I0KrilTBq7yC?=
 =?iso-8859-1?Q?AbV68b6t2X29/OfEbIWW9+Vey4HSXzGnGV/pj+C2zVZYWniamdtIH/226r?=
 =?iso-8859-1?Q?eDd2HuGojxL/WdqQTbXC4P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xqlxU6vsFhb5Yn85P6DyxUg6MZo2fQrbuLqU/YM4mUveJaPpfdMVFDE6XR?=
 =?iso-8859-1?Q?RnElz2Xc6AqrEGgpercAJE6JyOEyRYPCmEfGqlTw8pGkGPMpzJQNgmOEpo?=
 =?iso-8859-1?Q?Er3/mKEvcBMJOb7LttxBlLQY6Vq3+lpAvMWRVkpKDB7Sp/fMRCzSCc5txU?=
 =?iso-8859-1?Q?yjYSwmO7DpjZ2vtsD/OXuCE1N7YUTExhsvM+SlBIl/F2RXiZsFmMPcyoM/?=
 =?iso-8859-1?Q?Ph5Xfl97v7B2lUDPLD5hzKoQfEn+p6HStHuofFHvzquA3v6ruxGSI68VOO?=
 =?iso-8859-1?Q?MVrjPPTbChpxW8vlvhRB93wq0pEOpC5dpBQwmtulD6FKvpKWomf4ciJdRZ?=
 =?iso-8859-1?Q?Aq/DhtsP5k6QC7rrgHVPDqCaNX5FeuENlxNmv7URcYT62mjlhBJQBzDQOJ?=
 =?iso-8859-1?Q?l+VnsG936ekcjgjguyBG8h4zT1mp87Z99myBxnh5stKu4KYwKkPGq2voct?=
 =?iso-8859-1?Q?p5HE7FBAFEHbiYaRHd1hZ96pYemkvf7cGMhMxRs/QcB/Xs32ChMFO8LMUf?=
 =?iso-8859-1?Q?QCJv1kOYMSRnXP3alSa8egoDHGwcAcEq+GDqA+dORl+IjtYB+pgE1jSpqZ?=
 =?iso-8859-1?Q?vRmSmlwnGxEg2h1901i2PFHirhvCJE5Zzdcl8sDwYUwt2v7I+0Ec9uc5bF?=
 =?iso-8859-1?Q?jvfG4LjRPBrLGSSmHER3ob1E1rYm8YpTyHkvAb4N6Esm7Hwh7uKQJu4nSl?=
 =?iso-8859-1?Q?zqStH3O5z/9ybruTMT4b0ImAVgGrENodtoHvX1JVyrqUmBApF+kaxQm8Zh?=
 =?iso-8859-1?Q?cqnwHSU4sJ7o3g0zaf/YWkJH74GXRqlWFkqiKSh2m0qZ/ETZLfucggtNLO?=
 =?iso-8859-1?Q?+fp0HpNTQKOoPkAHiAPGy7PFcNc+LZR7IPajckprFfhR+1T/Cr2Nb5wtyX?=
 =?iso-8859-1?Q?oshJmTl7MFF7hKWMe/nUTlqGvY4sq3/n1niS+coPo5bUXtFGA6itu3bYQj?=
 =?iso-8859-1?Q?pPBm8thu+lW1frsMOmGZYAEJkEjFrjSEhz+EfJO5JhR40sPjSnyddwfA7t?=
 =?iso-8859-1?Q?d82YHm8+SbXeQIQ0jA7uXmc7U1PKXK2CuRc3ZrJDAh3IwbAlG7XLrnxC6f?=
 =?iso-8859-1?Q?l2mQtAZZu4I4k5XkQTsRFCygRjN7mipnUcK+cIqqpaSktHUPOu1Wabx2/4?=
 =?iso-8859-1?Q?Hn8/sWPFKJde7RHe359gbj9clvzD2ryg27XFuialWVSSKHVPa41DnVXVfN?=
 =?iso-8859-1?Q?6zwzeS6xiAwlw3ASN96fvmeE3hG/lpo6Fl8nJadQRto0Z1+C9eqstV+Fyy?=
 =?iso-8859-1?Q?w7HOPnieIZGb0iBCySCDtWX6vMoZBhLnvxkAVTOUN/pfcQFqwTHb2eBstb?=
 =?iso-8859-1?Q?PmKyYlFi1a3g3ZBfRtMQxKXbxI3v+wByy6N65uFvnICWngWXrlAYJPDPDP?=
 =?iso-8859-1?Q?oPBe8DY6jN/o4Kq3UsmYF3CXFWp1cMd5eH3dzu6gBBtApmmkQjHtAn6Mzp?=
 =?iso-8859-1?Q?h/ePWfCKdnAuWtbhgEvaMmJTDXaDceP2FcnP01T9UZPSAlBVSq1EuhxTMb?=
 =?iso-8859-1?Q?0BC+shOdog0YggxxlP1a0Z77YzY+ZDl2ecLJzIvhhOkV1NRBt8c4AT4Dvr?=
 =?iso-8859-1?Q?IetoamI1vU9lH/R5HPHfDNQbNKMEM/mfgMU2c2SBHX6GuL/XckmP3nTonE?=
 =?iso-8859-1?Q?1VlPZ5UhZuYPdjVJ6a/V6zxkIjiYZYYO9Qtkjdo2l23zFxISsNKu0R6w?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80052bec-0af7-4918-8854-08dd9a5d0847
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 00:50:51.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xb+U3sfVTY/V6Nwk5PfhbF1uz/DTaW9WBlub+VHr5TvE2VkDxmLR6S/BS83kae/drXMblz6S7Lml81ReIBAOTqtGrKN3TLI0WB2xa2VDI9FuVmzQVbcUzNZcRxEBndHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7991

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, May 20, 2025 3:34 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@kern=
el.org; donald.hunter@gmail.com; xandfury@gmail.com; netdev@vger.kernel.org=
; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkpl=
umber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net;=
 edumazet@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; =
ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell=
-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.c=
om; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jaso=
n_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Cc: Olga Albisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.t=
ilmans@nokia.com>; Henrik Steen <henrist@henrist.net>; Bob Briscoe <researc=
h@bobbriscoe.net>
> Subject: Re: [PATCH v16 net-next 3/5] sched: Add enqueue/dequeue of dualp=
i2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 5/16/25 2:01 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> >
> > DualPI2 provides L4S-type low latency & loss to traffic that uses a=20
> > scalable congestion controller (e.g. TCP-Prague, DCTCP) without=20
> > degrading the performance of 'classic' traffic (e.g. Reno, Cubic=20
> > etc.). It is to be the reference implementation of IETF RFC9332 DualQ=20
> > Coupled AQM (https://datatracker.ietf.org/doc/html/rfc9332).
> >
> > Note that creating two independent queues cannot meet the goal of
> > DualPI2 mentioned in RFC9332: "...to preserve fairness between=20
> > ECN-capable and non-ECN-capable traffic." Further, it could even lead=20
> > to starvation of Classic traffic, which is also inconsistent with the=20
> > requirements in RFC9332: "...although priority MUST be bounded in=20
> > order not to starve Classic traffic." DualPI2 is designed to maintain=20
> > approximate per-flow fairness on L-queue and C-queue by forming a=20
> > single qdisc using the coupling factor and scheduler between two=20
> > queues.
> >
> > The qdisc provides two queues called low latency and classic. It=20
> > classifies packets based on the ECN field in the IP headers. By=20
> > default it directs non-ECN and ECT(0) into the classic queue and
> > ECT(1) and CE into the low latency queue, as per the IETF spec.
> >
> > Each queue runs its own AQM:
> > * The classic AQM is called PI2, which is similar to the PIE AQM but
> >   more responsive and simpler. Classic traffic requires a decent
> >   target queue (default 15ms for Internet deployment) to fully
> >   utilize the link and to avoid high drop rates.
> > * The low latency AQM is, by default, a very shallow ECN marking
> >   threshold (1ms) similar to that used for DCTCP.
> >
> > The DualQ isolates the low queuing delay of the Low Latency queue from=
=20
> > the larger delay of the 'Classic' queue. However, from a bandwidth=20
> > perspective, flows in either queue will share out the link capacity as=
=20
> > if there was just a single queue. This bandwidth pooling effect is=20
> > achieved by coupling together the drop and ECN-marking probabilities=20
> > of the two AQMs.
> >
> > The PI2 AQM has two main parameters in addition to its target delay.
> > The integral gain factor alpha is used to slowly correct any=20
> > persistent standing queue error from the target delay, while the=20
> > proportional gain factor beta is used to quickly compensate for queue=20
> > changes (growth or shrinkage). Either alpha and beta are given as a=20
> > parameter, or they can be calculated by tc from alternative typical and=
 maximum RTT parameters.
> >
> > Internally, the output of a linear Proportional Integral (PI)=20
> > controller is used for both queues. This output is squared to=20
> > calculate the drop or ECN-marking probability of the classic queue.
> > This counterbalances the square-root rate equation of Reno/Cubic,=20
> > which is the trick that balances flow rates across the queues. For the=
=20
> > ECN-marking probability of the low latency queue, the output of the=20
> > base AQM is multiplied by a coupling factor. This determines the=20
> > balance between the flow rates in each queue. The default setting=20
> > makes the flow rates roughly equal, which should be generally=20
> > applicable.
> >
> > If DUALPI2 AQM has detected overload (due to excessive non-responsive=20
> > traffic in either queue), it will switch to signaling congestion=20
> > solely using drop, irrespective of the ECN field. Alternatively, it=20
> > can be configured to limit the drop probability and let the queue grow=
=20
> > and eventually overflow (like tail-drop).
> >
> > GSO splitting in DUALPI2 is configurable from userspace while the=20
> > default behavior is to split gso. When running DUALPI2 at unshaped=20
> > 10gigE with 4 download streams test, splitting gso apart results in=20
> > halving the latency with no loss in throughput:
> >
> > Summary of tcp_4down run 'no_split_gso':
> >                          avg         median      # data pts
> >  Ping (ms) ICMP   :       0.53      0.30 ms         350
> >  TCP download avg :    2326.86       N/A Mbits/s    350
> >  TCP download sum :    9307.42       N/A Mbits/s    350
> >  TCP download::1  :    2672.99   2568.73 Mbits/s    350
> >  TCP download::2  :    2586.96   2570.51 Mbits/s    350
> >  TCP download::3  :    1786.26   1798.82 Mbits/s    350
> >  TCP download::4  :    2261.21   2309.49 Mbits/s    350
> >
> > Summart of tcp_4down run 'split_gso':
> >                          avg          median      # data pts
> >  Ping (ms) ICMP   :       0.22      0.23 ms         350
> >  TCP download avg :    2335.02       N/A Mbits/s    350
> >  TCP download sum :    9340.09       N/A Mbits/s    350
> >  TCP download::1  :    2335.30   2334.22 Mbits/s    350
> >  TCP download::2  :    2334.72   2334.20 Mbits/s    350
> >  TCP download::3  :    2335.28   2334.58 Mbits/s    350
> >  TCP download::4  :    2334.79   2334.39 Mbits/s    350
> >
> > A similar result is observed when running DUALPI2 at unshaped 1gigE=20
> > with 1 download stream test:
> >
> > Summary of tcp_1down run 'no_split_gso':
> >                          avg         median      # data pts
> >  Ping (ms) ICMP :         1.13      1.25 ms         350
> >  TCP download   :       941.41    941.46 Mbits/s    350
> >
> > Summart of tcp_1down run 'split_gso':
> >                          avg         median      # data pts
> >  Ping (ms) ICMP :         0.51      0.55 ms         350
> >  TCP download   :       941.41    941.45 Mbits/s    350
> >
> > Additional details can be found in the draft:
> >   https://datatracker.ietf.org/doc/html/rfc9332
> >
> > Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> > Co-developed-by: Olga Albisser <olga@albisser.org>
> > Signed-off-by: Olga Albisser <olga@albisser.org>
> > Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> > Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> > Co-developed-by: Henrik Steen <henrist@henrist.net>
> > Signed-off-by: Henrik Steen <henrist@henrist.net>
> > Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> > Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> > Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > Acked-by: Dave Taht <dave.taht@gmail.com>
> > ---
> >  include/net/dropreason-core.h |   6 +
> >  net/sched/Kconfig             |  12 +
> >  net/sched/Makefile            |   1 +
> >  net/sched/sch_dualpi2.c       | 449 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 468 insertions(+)
> >
> > diff --git a/include/net/dropreason-core.h=20
> > b/include/net/dropreason-core.h index bea77934a235..faae9f416e54=20
> > 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -120,6 +120,7 @@
> >       FN(ARP_PVLAN_DISABLE)           \
> >       FN(MAC_IEEE_MAC_CONTROL)        \
> >       FN(BRIDGE_INGRESS_STP_STATE)    \
> > +     FN(DUALPI2_STEP_DROP)           \
> >       FNe(MAX)
> >
> >  /**
> > @@ -570,6 +571,11 @@ enum skb_drop_reason {
> >        * ingress bridge port does not allow frames to be forwarded.
> >        */
> >       SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
> > +     /**
> > +      * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
> > +      * threshold of DualPI2 qdisc.
> > +      */
> > +     SKB_DROP_REASON_DUALPI2_STEP_DROP,
> >       /**
> >        * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >        * shouldn't be used as a real 'reason' - only for tracing code=20
> > gen diff --git a/net/sched/Kconfig b/net/sched/Kconfig index=20
> > 9f0b3f943fca..dda66a3590d8 100644
> > --- a/net/sched/Kconfig
> > +++ b/net/sched/Kconfig
> > @@ -415,6 +415,18 @@ config NET_SCH_BPF
> >
> >         If unsure, say N.
> >
> > +config NET_SCH_DUALPI2
> > +     tristate "Dual Queue PI Square (DUALPI2) scheduler"
> > +     help
> > +       Say Y here if you want to use the Dual Queue Proportional Integ=
ral
> > +       Controller Improved with a Square scheduling algorithm.
> > +       For more information, please see=20
> > +https://tools.ietf.org/html/rfc9332
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called sch_dualpi2.
> > +
> > +       If unsure, say N.
> > +
> >  menuconfig NET_SCH_DEFAULT
> >       bool "Allow override default queue discipline"
> >       help
> > diff --git a/net/sched/Makefile b/net/sched/Makefile index=20
> > 904d784902d1..5078ea84e6ad 100644
> > --- a/net/sched/Makefile
> > +++ b/net/sched/Makefile
> > @@ -63,6 +63,7 @@ obj-$(CONFIG_NET_SCH_CBS)   +=3D sch_cbs.o
> >  obj-$(CONFIG_NET_SCH_ETF)    +=3D sch_etf.o
> >  obj-$(CONFIG_NET_SCH_TAPRIO) +=3D sch_taprio.o
> >  obj-$(CONFIG_NET_SCH_BPF)    +=3D bpf_qdisc.o
> > +obj-$(CONFIG_NET_SCH_DUALPI2)        +=3D sch_dualpi2.o
> >
> >  obj-$(CONFIG_NET_CLS_U32)    +=3D cls_u32.o
> >  obj-$(CONFIG_NET_CLS_ROUTE4) +=3D cls_route.o diff --git=20
> > a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c index=20
> > 97986c754e47..7ecd7502332c 100644
> > --- a/net/sched/sch_dualpi2.c
> > +++ b/net/sched/sch_dualpi2.c
> > @@ -113,8 +113,44 @@ struct dualpi2_sched_data {
> >       u32     step_marks;     /* ECN mark pkt counter due to step AQM *=
/
> >       u32     memory_used;    /* Memory used of both queues */
> >       u32     max_memory_used;/* Maximum used memory */
> > +
> > +     /* Deferred drop statistics */
> > +     u32     deferred_drops_cnt;     /* Packets dropped */
> > +     u32     deferred_drops_len;     /* Bytes dropped */
> > +};
> > +
> > +struct dualpi2_skb_cb {
> > +     u64 ts;                 /* Timestamp at enqueue */
> > +     u8 apply_step:1,        /* Can we apply the step threshold */
> > +        classified:2,        /* Packet classification results */
> > +        ect:2;               /* Packet ECT codepoint */
> > +};
> > +
> > +enum dualpi2_classification_results {
> > +     DUALPI2_C_CLASSIC       =3D 0,    /* C-queue */
> > +     DUALPI2_C_L4S           =3D 1,    /* L-queue (scale mark/classic =
drop) */
> > +     DUALPI2_C_LLLL          =3D 2,    /* L-queue (no drops/marks) */
> > +     __DUALPI2_C_MAX                 /* Keep last*/
> >  };
> >
> > +static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb) {
> > +     qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
> > +     return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data; }
> > +
> > +static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference) {
> > +     return reference - dualpi2_skb_cb(skb)->ts; }
> > +
> > +static u64 head_enqueue_time(struct Qdisc *q) {
> > +     struct sk_buff *skb =3D qdisc_peek_head(q);
> > +
> > +     return skb ? dualpi2_skb_cb(skb)->ts : 0; }
> > +
> >  static u32 dualpi2_scale_alpha_beta(u32 param)  {
> >       u64 tmp =3D ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING); @@=20
> > -136,6 +172,25 @@ static ktime_t next_pi2_timeout(struct dualpi2_sched_=
data *q)
> >       return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);  }
> >
> > +static bool skb_is_l4s(struct sk_buff *skb) {
> > +     return dualpi2_skb_cb(skb)->classified =3D=3D DUALPI2_C_L4S; }
> > +
> > +static bool skb_in_l_queue(struct sk_buff *skb) {
> > +     return dualpi2_skb_cb(skb)->classified !=3D DUALPI2_C_CLASSIC; }
> > +
> > +static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff=
=20
> > +*skb) {
> > +     if (INET_ECN_set_ce(skb)) {
> > +             q->ecn_mark++;
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >  static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q) =
=20
> > {
> >       q->c_protection_credit =3D q->c_protection_init; @@ -155,6=20
> > +210,398 @@ static void dualpi2_calculate_c_protection(struct Qdisc *sc=
h,
> >       dualpi2_reset_c_protection(q);
> >  }
> >
> > +static bool dualpi2_roll(u32 prob)
> > +{
> > +     return get_random_u32() <=3D prob; }
> > +
> > +/* Packets in the C-queue are subject to a marking probability pC,=20
> > +which is the
> > + * square of the internal PI probability (i.e., have an overall lower=
=20
> > +mark/drop
> > + * probability). If the qdisc is overloaded, ignore ECT values and onl=
y drop.
> > + *
> > + * Note that this marking scheme is also applied to L4S packets during=
 overload.
> > + * Return true if packet dropping is required in C queue  */ static=20
> > +bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
> > +                                 struct sk_buff *skb, u32 prob,
> > +                                 bool overload) {
> > +     if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
> > +             if (overload || dualpi2_skb_cb(skb)->ect =3D=3D INET_ECN_=
NOT_ECT)
> > +                     return true;
> > +             dualpi2_mark(q, skb);
> > +     }
> > +     return false;
> > +}
> > +
> > +/* Packets in the L-queue are subject to a marking probability pL=20
> > +given by the
> > + * internal PI probability scaled by the coupling factor.
> > + *
> > + * On overload (i.e., @local_l_prob is >=3D 100%):
> > + * - if the qdisc is configured to trade losses to preserve latency (i=
.e.,
> > + *   @q->drop_overload), apply classic drops first before marking.
> > + * - otherwise, preserve the "no loss" property of ECN at the cost of =
queueing
> > + *   delay, eventually resulting in taildrop behavior once sch->limit =
is
> > + *   reached.
> > + * Return true if packet dropping is required in L queue  */ static=20
> > +bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
> > +                                  struct sk_buff *skb,
> > +                                  u64 local_l_prob, u32 prob,
> > +                                  bool overload) {
> > +     if (overload) {
> > +             /* Apply classic drop */
> > +             if (!q->drop_overload ||
> > +                 !(dualpi2_roll(prob) && dualpi2_roll(prob)))
> > +                     goto mark;
> > +             return true;
> > +     }
> > +
> > +     /* We can safely cut the upper 32b as overload=3D=3Dfalse */
> > +     if (dualpi2_roll(local_l_prob)) {
> > +             /* Non-ECT packets could have classified as L4S by filter=
s. */
> > +             if (dualpi2_skb_cb(skb)->ect =3D=3D INET_ECN_NOT_ECT)
> > +                     return true;
> > +mark:
> > +             dualpi2_mark(q, skb);
> > +     }
> > +     return false;
> > +}
> > +
> > +/* Decide whether a given packet must be dropped (or marked if ECT),=20
> > +according
> > + * to the PI2 probability.
> > + *
> > + * Never mark/drop if we have a standing queue of less than 2 MTUs.
> > + */
> > +static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
> > +                   struct sk_buff *skb) {
> > +     u64 local_l_prob;
> > +     bool overload;
> > +     u32 prob;
> > +
> > +     if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
> > +             return false;
> > +
> > +     prob =3D READ_ONCE(q->pi2_prob);
> > +     local_l_prob =3D (u64)prob * q->coupling_factor;
> > +     overload =3D local_l_prob > MAX_PROB;
> > +
> > +     switch (dualpi2_skb_cb(skb)->classified) {
> > +     case DUALPI2_C_CLASSIC:
> > +             return dualpi2_classic_marking(q, skb, prob, overload);
> > +     case DUALPI2_C_L4S:
> > +             return dualpi2_scalable_marking(q, skb, local_l_prob, pro=
b,
> > +                                             overload);
> > +     default: /* DUALPI2_C_LLLL */
> > +             return false;
> > +     }
> > +}
> > +
> > +static void dualpi2_read_ect(struct sk_buff *skb) {
> > +     struct dualpi2_skb_cb *cb =3D dualpi2_skb_cb(skb);
> > +     int wlen =3D skb_network_offset(skb);
> > +
> > +     switch (skb_protocol(skb, true)) {
> > +     case htons(ETH_P_IP):
> > +             wlen +=3D sizeof(struct iphdr);
> > +             if (!pskb_may_pull(skb, wlen) ||
> > +                 skb_try_make_writable(skb, wlen))
> > +                     goto not_ecn;
> > +
> > +             cb->ect =3D ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK=
;
> > +             break;
> > +     case htons(ETH_P_IPV6):
> > +             wlen +=3D sizeof(struct ipv6hdr);
> > +             if (!pskb_may_pull(skb, wlen) ||
> > +                 skb_try_make_writable(skb, wlen))
> > +                     goto not_ecn;
> > +
> > +             cb->ect =3D ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MA=
SK;
> > +             break;
> > +     default:
> > +             goto not_ecn;
> > +     }
> > +     return;
> > +
> > +not_ecn:
> > +     /* Non pullable/writable packets can only be dropped hence are
> > +      * classified as not ECT.
> > +      */
> > +     cb->ect =3D INET_ECN_NOT_ECT;
> > +}
> > +
> > +static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
> > +                             struct sk_buff *skb) {
> > +     struct dualpi2_skb_cb *cb =3D dualpi2_skb_cb(skb);
> > +     struct tcf_result res;
> > +     struct tcf_proto *fl;
> > +     int result;
> > +
> > +     dualpi2_read_ect(skb);
> > +     if (cb->ect & q->ecn_mask) {
> > +             cb->classified =3D DUALPI2_C_L4S;
> > +             return NET_XMIT_SUCCESS;
> > +     }
> > +
> > +     if (TC_H_MAJ(skb->priority) =3D=3D q->sch->handle &&
> > +         TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
> > +             cb->classified =3D TC_H_MIN(skb->priority);
> > +             return NET_XMIT_SUCCESS;
> > +     }
> > +
> > +     fl =3D rcu_dereference_bh(q->tcf_filters);
> > +     if (!fl) {
> > +             cb->classified =3D DUALPI2_C_CLASSIC;
> > +             return NET_XMIT_SUCCESS;
> > +     }
> > +
> > +     result =3D tcf_classify(skb, NULL, fl, &res, false);
> > +     if (result >=3D 0) {
> > +#ifdef CONFIG_NET_CLS_ACT
> > +             switch (result) {
> > +             case TC_ACT_STOLEN:
> > +             case TC_ACT_QUEUED:
> > +             case TC_ACT_TRAP:
> > +                     return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> > +             case TC_ACT_SHOT:
> > +                     return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > +             }
> > +#endif
> > +             cb->classified =3D TC_H_MIN(res.classid) < __DUALPI2_C_MA=
X ?
> > +                     TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
> > +     }
> > +     return NET_XMIT_SUCCESS;
> > +}
> > +
> > +static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
> > +                            struct sk_buff **to_free) {
> > +     struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> > +     struct dualpi2_skb_cb *cb;
> > +
> > +     if (unlikely(qdisc_qlen(sch) >=3D sch->limit) ||
> > +         unlikely((u64)q->memory_used + skb->truesize > q->memory_limi=
t)) {
> > +             qdisc_qstats_overlimit(sch);
> > +             if (skb_in_l_queue(skb))
> > +                     qdisc_qstats_overlimit(q->l_queue);
> > +             return qdisc_drop_reason(skb, sch, to_free,
> > +                                      SKB_DROP_REASON_QDISC_OVERLIMIT)=
;
> > +     }
> > +
> > +     if (q->drop_early && must_drop(sch, q, skb)) {
> > +             qdisc_drop_reason(skb, sch, to_free,
> > +                               SKB_DROP_REASON_QDISC_OVERLIMIT);
>=20
> I think it's better to use a different drop reason here or it will be har=
d to distinguish between packets dropped here or above.
> Possibly SKB_DROP_REASON_QDISC_CONGESTED.
>=20
Hi Paolo,

Thanks for the feedback.
This will be changed into SKB_DROP_REASON_QDISC_CONGESTED as suggested.

> > +             return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > +     }
> > +
> > +     cb =3D dualpi2_skb_cb(skb);
> > +     cb->ts =3D ktime_get_ns();
> > +     q->memory_used +=3D skb->truesize;
> > +     if (q->memory_used > q->max_memory_used)
> > +             q->max_memory_used =3D q->memory_used;
> > +
> > +     if (qdisc_qlen(sch) > q->maxq)
> > +             q->maxq =3D qdisc_qlen(sch);
> > +
> > +     if (skb_in_l_queue(skb)) {
> > +             /* Only apply the step if a queue is building up */
> > +             dualpi2_skb_cb(skb)->apply_step =3D skb_is_l4s(skb) &&
> > +                     qdisc_qlen(q->l_queue) >=3D q->min_qlen_step;
> > +             /* Keep the overall qdisc stats consistent */
> > +             ++sch->q.qlen;
> > +             qdisc_qstats_backlog_inc(sch, skb);
> > +             ++q->packets_in_l;
> > +             if (!q->l_head_ts)
> > +                     q->l_head_ts =3D cb->ts;
>=20
> This chunck is very hard to read. Please insert a black line before the 2=
nd comment and consider introducing an helper to compute the 'apply_step' v=
alue.

A new helper function will be added to represent "qdisc_qlen(q->l_queue) >=
=3D q->min_qlen_step".

>=20
> > +             return qdisc_enqueue_tail(skb, q->l_queue);
> > +     }
> > +     ++q->packets_in_c;
> > +     if (!q->c_head_ts)
> > +             q->c_head_ts =3D cb->ts;
> > +     return qdisc_enqueue_tail(skb, sch); }
> > +
> > +/* By default, dualpi2 will split GSO skbs into independent skbs and=20
> > +enqueue
> > + * each of those individually. This yields the following benefits, at=
=20
> > +the
> > + * expense of CPU usage:
> > + * - Finer-grained AQM actions as the sub-packets of a burst no longer=
 share the
> > + *   same fate (e.g., the random mark/drop probability is applied indi=
vidually)
> > + * - Improved precision of the starvation protection/WRR scheduler at =
dequeue,
> > + *   as the size of the dequeued packets will be smaller.
> > + */
> > +static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sc=
h,
> > +                              struct sk_buff **to_free) {
> > +     struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> > +     int err;
> > +
> > +     err =3D dualpi2_skb_classify(q, skb);
> > +     if (err !=3D NET_XMIT_SUCCESS) {
> > +             if (err & __NET_XMIT_BYPASS)
> > +                     qdisc_qstats_drop(sch);
> > +             __qdisc_drop(skb, to_free);
> > +             return err;
> > +     }
> > +
> > +     if (q->split_gso && skb_is_gso(skb)) {
> > +             netdev_features_t features;
> > +             struct sk_buff *nskb, *next;
> > +             int cnt, byte_len, orig_len;
> > +             int err;
> > +
> > +             features =3D netif_skb_features(skb);
> > +             nskb =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> > +             if (IS_ERR_OR_NULL(nskb))
> > +                     return qdisc_drop(skb, sch, to_free);
> > +
> > +             cnt =3D 1;
> > +             byte_len =3D 0;
> > +             orig_len =3D qdisc_pkt_len(skb);
> > +             skb_list_walk_safe(nskb, nskb, next) {
> > +                     skb_mark_not_on_list(nskb);
> > +                     qdisc_skb_cb(nskb)->pkt_len =3D nskb->len;
> > +                     dualpi2_skb_cb(nskb)->classified =3D
> > +                             dualpi2_skb_cb(skb)->classified;
>=20
> Possibly just:
>                         *qdisc_skb_cb(nskb) =3D *dualpi2_skb_cb(skb);

However, I was thinking to keep the original code.
Because it clearly shows we got classified & ect values from dualpi2_skb_cb=
(skb), pkt_len value from nskb->len, and ts value in dualpi2_enqueue_skb().
I would add comments for that, hope this is clear.

>=20
> > +                     dualpi2_skb_cb(nskb)->ect =3D dualpi2_skb_cb(skb)=
->ect;
> > +                     err =3D dualpi2_enqueue_skb(nskb, sch, to_free);
> > +                     if (err =3D=3D NET_XMIT_SUCCESS) {
> > +                             /* Compute the backlog adjustment that ne=
eds
> > +                              * to be propagated in the qdisc tree to =
reflect
> > +                              * all new skbs successfully enqueued.
> > +                              */
> > +                             ++cnt;
> > +                             byte_len +=3D nskb->len;
> > +                     }
> > +             }
> > +             if (err =3D=3D NET_XMIT_SUCCESS) {
> > +                     /* The caller will add the original skb stats to =
its
> > +                      * backlog, compensate this.
> > +                      */
> > +                     --cnt;
> > +                     byte_len -=3D orig_len;
> > +             }
> > +             qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
> > +             consume_skb(skb);
> > +             return err;
>=20
> Using the return value from the last enqueue operation is IMHO inaccurate=
 and confusing. Instead you could return NET_XMIT_SUCCESS if at least a skb=
 is enqueued successfully, or possibly always unconditionally NET_XMIT_SUCC=
ESS (will simplify the code a bit)

Indeed, I will replace "if (err =3D=3D NET_XMIT_SUCCESS)" into "if (cnt > 1=
)". Then it corresponds to the former case you mentioned.

BRs,
Chia-Yu
>=20
> > +     }
> > +     return dualpi2_enqueue_skb(skb, sch, to_free); }
> > +
> > +/* Select the queue from which the next packet can be dequeued,=20
> > +ensuring that
> > + * neither queue can starve the other with a WRR scheduler.
> > + *
> > + * The sign of the WRR credit determines the next queue, while the=20
> > +size of
> > + * the dequeued packet determines the magnitude of the WRR credit=20
> > +change. If
> > + * either queue is empty, the WRR credit is kept unchanged.
> > + *
> > + * As the dequeued packet can be dropped later, the caller has to=20
> > +perform the
> > + * qdisc_bstats_update() calls.
> > + */
> > +static struct sk_buff *dequeue_packet(struct Qdisc *sch,
> > +                                   struct dualpi2_sched_data *q,
> > +                                   int *credit_change,
> > +                                   u64 now) {
> > +     struct sk_buff *skb =3D NULL;
> > +     int c_len;
> > +
> > +     *credit_change =3D 0;
> > +     c_len =3D qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> > +     if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection_credit <=
=3D 0)) {
> > +             skb =3D __qdisc_dequeue_head(&q->l_queue->q);
> > +             WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
> > +             if (c_len)
> > +                     *credit_change =3D q->c_protection_wc;
> > +             qdisc_qstats_backlog_dec(q->l_queue, skb);
>=20
> Please add an empty line here.
>=20
> > +             /* Keep the global queue size consistent */
> > +             --sch->q.qlen;
> > +             q->memory_used -=3D skb->truesize;
> > +     } else if (c_len) {
> > +             skb =3D __qdisc_dequeue_head(&sch->q);
> > +             WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
> > +             if (qdisc_qlen(q->l_queue))
> > +                     *credit_change =3D ~((s32)q->c_protection_wl) + 1=
;
> > +             q->memory_used -=3D skb->truesize;
> > +     } else {
> > +             dualpi2_reset_c_protection(q);
> > +             return NULL;
> > +     }
> > +     *credit_change *=3D qdisc_pkt_len(skb);
> > +     qdisc_qstats_backlog_dec(sch, skb);
> > +     return skb;
> > +}
> > +
> > +static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *s=
kb,
> > +                    u64 now)
> > +{
> > +     u64 qdelay =3D 0;
> > +
> > +     if (q->step_in_packets)
> > +             qdelay =3D qdisc_qlen(q->l_queue);
> > +     else
> > +             qdelay =3D dualpi2_sojourn_time(skb, now);
> > +
> > +     if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step_thresh) {
> > +             if (!dualpi2_skb_cb(skb)->ect)
> > +                     /* Drop this non-ECT packet */
> > +                     return 1;
>=20
> Please add brackets and an empty line:
>=20
>                 if (!dualpi2_skb_cb(skb)->ect) {
>                         /* Drop this non-ECT packet */
>                         return 1;
>                 }
>=20
>                 if (dualpi2_mark(q, skb))
>=20
>=20
> /P


