Return-Path: <linux-kselftest+bounces-31308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4ECA97116
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5251B605B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5497290082;
	Tue, 22 Apr 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZFmLgE4u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF220B81D;
	Tue, 22 Apr 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335846; cv=fail; b=UB1hqb0jNNXzbaz7+YRtE3RU0YGEUrMOHQNgUbQsdnNw/pU9Osz6Nwpyiy3GXqB9GTHPBbImb3xpXuLQ5Dh2mgCRwI2xLpjv7vNOuq/QHQDU+HIqD/aFJxsydAoSd3CuRxNGasOYijnLvxKS3zcyITLo3gIChmZbPNLoAhj5pNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335846; c=relaxed/simple;
	bh=JFJAKOeiKTUjzQ52VCC8PZ+Jw6m2zSzUvauDBxZlN2U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TMvugxq7IY3s5rejPd+dRbUT72iSuTZaXDUgFgHtNLSV67lbYz8LKOZZJ5xu+nU3yeDbnux2h1QiZ6masebQ7G83SJt5OA2jCDZob48rLVP11uBkeHhbwa3q7hMtMB2O3S9UjNVWUtaToRRwsJ+6dC/d3ts8an9RsbGJnXeIPoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZFmLgE4u; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr0G2+rst9wTOz9JwzMBvyAaddlEK+Y3ehj/lqOn4o3ISX1+SdNNWkBVW/VMJ4h6FR5DQ9lHi0TckxZfE+WZcR9YBaC4bl0U5dcBAJnQ+X8PHxKkgxv20L4hZAjzVctQmGgkNTLOVxsvjdwSOKldZJXXxfKmuo+xfOrG6JWGCX6NtWKH1wQgAC0X6y7il8rRwiCeq09qmfjZRgRL0bOtTtpIj7lUroYgRf1meOIRVMXGrseCdTS7msPEDf6U1D9DK2FUdHsxX8FjpjPR34vK/Y3JROcw9HJ1MMKMRftTL+duITzgeIKh6g3YiyXgR0JRSkebXLpgqhV2+Jhn6OYVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9mp5O1mMxEBjclbizuA2oPLZO6T6QvaH7/Ie0rbwYU=;
 b=j4zEKTgA2WpAssAK6e9hmo9cuQzMDgxK0NMfvQlMM/Mr5NQolMv1tsZBINB94To2mUVJSdXCIxkC4A5YIhdpKRYyblL9jNFkk+nyh/67cvL8XAlsxbVA9p2TYhyi4YCs1ZR1aI8XGuIWcxc/3FXru+C+QKEyintmOdb/GzH13L/WKFka4Cl4vcnJczm4xY/xR+XpXx6slGiziVLMQHCLkfKJcWjaqRWIFu/CCWy0+ySmEdg+dmM0ogHI2aQmkuDWkSVGTkzIb4LKTijDEY4KKulVgPWDZ2OkmfABpiQpnnioR7lNMRVgMgM+LU9/DkDv955n+1GsYHQCtQcrwq6tAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9mp5O1mMxEBjclbizuA2oPLZO6T6QvaH7/Ie0rbwYU=;
 b=ZFmLgE4uualiVZJAn2cE3NJS6Ka9VHPTchOftoOitpKAob/NAhaeeJZ/2bCn63obtLY23pZQijpn5oEKkfdNNKGT8qA0oU9I9Bs+OAtHAV+2q/MqKiwHD+ZheG5HaI6h4izQA0mL9BCebZOXBIRYZ7rOgiNpav1qoObg7UcWXBoa6A3wgnUNiKt0Q981rj2oXGnxaAipoRrurwjXexamuYZYtUjKfAaS7vVi8avR4EZBjJKtrin6baYYDHPm4+zgyDe4QK7ERrPF0GrbiwHc6uzj87C3Ap1QAwhkV+Xp1m/KpU8rVTfhEhA444GtSqpGaSW9UtjOdyxKO1QFXFBvcw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9834.eurprd07.prod.outlook.com (2603:10a6:10:4c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:30:41 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 15:30:41 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v11 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v11 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHbrgQOc0I0QUUxPk+CSKc25euXPbOvfMoAgABdnRA=
Date: Tue, 22 Apr 2025 15:30:41 +0000
Message-ID:
 <PAXPR07MB7984496F9F0C2136B220D47CA3BB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-2-chia-yu.chang@nokia-bell-labs.com>
 <949655cd-4690-4513-a24e-7f1e035425b0@redhat.com>
In-Reply-To: <949655cd-4690-4513-a24e-7f1e035425b0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9834:EE_
x-ms-office365-filtering-correlation-id: 8847ebd3-20fa-47f6-9460-08dd81b2a3e5
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RuGocPR1bxH30ECbV2aW038JSku5Nwgo0PyxlJdEtJaRfzibiF2IC1X8Uxwm?=
 =?us-ascii?Q?bVAlzs+HH1/pdk9jEnQxb8TTx1EQkJAj+02vYlPlRX41o3wZ4M4itDlhfjsa?=
 =?us-ascii?Q?V3xGeQyrFB6tj1sSnn0HV+nZf2PQQS36Qv+JOTPFe09Z6iaqiIILgC1U24uN?=
 =?us-ascii?Q?Ba3N//dkh0A7o5ammmX9pWswgc11j+Bmwi4HnfpMGOK+hczhcWzylYk5djIM?=
 =?us-ascii?Q?HkxvEiI2bFmweYwwVkOHN48v+E5HgViXf25pR0Rh3rp5r3yDTBttOqiPZbQ8?=
 =?us-ascii?Q?wAOiizX8kZYUfaCGWL59ufFLDVV7MNvwp4Uf4746Rlz+Ts23xnxF3VbtdnfZ?=
 =?us-ascii?Q?Lk+MoP64E6XwcVLBn+xHnZUq8JtLiMY/sS8a/AV2f/WSxM/tbioj/3pJIt8I?=
 =?us-ascii?Q?k5QtW7rh2R4ssJsp3aYJhkEmvofXIQwtkCL8lWjfPYglFJzyaRVZKKqmNvTi?=
 =?us-ascii?Q?tSxSRlee+hxdSvxWHvL4Z+2E2CKPSSmtm5eKhrSPFU/c8ZfECOq3FhEGCxLb?=
 =?us-ascii?Q?/vUzaoteq5GChMIQgEC/5/U1NBghEq90PfAn1LXhVxS3B3dbSNq/MxghEi12?=
 =?us-ascii?Q?aZmYffHf040vGBgC/Hunstp3yntjtn5TBxJLlWTw2go6pYMVftAds8v5myNA?=
 =?us-ascii?Q?fxGcBaIezmuuogOsakjJLhInZd3r74wlvzV2F6lkgazbSFyos96N3nbZmhMu?=
 =?us-ascii?Q?OVDTDsz2IfxKnmoRWFEeQUKTBtIKehVKmb57ALV8JrCEWGsR52H030rusKH4?=
 =?us-ascii?Q?DGYfVeL2jZ+9bnI0GTe6Oi8C8P5+LJFAA3cH6pwga2eAU06eTlQNulQyojNJ?=
 =?us-ascii?Q?M3x02kFi1vFCz5OrAH4YK4qBTOdZ0NQRLeWow0MGwCakUhtjF3QF2odRigiv?=
 =?us-ascii?Q?ousQx81dLtoD2C6fWQUCdXFCYQykN3AFkFYlthEMaC8yDHIWB2TDPwB/YDhu?=
 =?us-ascii?Q?2HN9CAMoxaH3U2d3wpXuU0Lye08fGAW6q3wVwdcc3aI8vAvcoi+x3+VgA3lH?=
 =?us-ascii?Q?81hbyg0KpD0qCr6+rEmch2zUdAhqG64WZvaPQv7ogpudz1uGA5FaZf3er5z3?=
 =?us-ascii?Q?RGImEavWzwRexzS55eeTfTRNkS4ha8n+rcGfeDsN4WyDBsJ7mU9qhV0MaAtp?=
 =?us-ascii?Q?MK+54YhOWAufX+3L3oJAUq1gapmYvfhVxqvwK+uCf0VV4ZhEVTjSOlfo7JUa?=
 =?us-ascii?Q?/5T3pXuNjWwDknnjdXPQO4F+zFSt1LSGTLW0fEcHVJT+9aV1usqfFRdMf/Qs?=
 =?us-ascii?Q?mgn6dJi9kVvCyaEnRdPptIhJ/860FwojBFcgdRWr9WHCEf4MLCEi777UQzxc?=
 =?us-ascii?Q?MFOEg5DSkkgwmzhE/Oz49i22v/+A1OZUDh3Ye6p591Scjp1NkZuyXK1cfEdn?=
 =?us-ascii?Q?i7v3HUBVKVV50vqzqosQ7mvwFUnmhoxW8GQS5FBSpADx+FbCQhpvwlPYHTun?=
 =?us-ascii?Q?sssxBYgGm1TYVl4YnneEoAGs3tt4PZMz7psYITO9SAigK6bkHhDwZAKN89ai?=
 =?us-ascii?Q?t5k/sk2Q4AQRCB/1sHbRorWkqh4dg0s3VudF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TSV94ByycaN1Ohuf0y79ujMIUI6wFbU3FScocUs7qfenni1Pht/UFBfO0szz?=
 =?us-ascii?Q?hDJjSOITPNA1Rzogg4UI7Sr6OG1NEsdRfBNGjJgjmWxaGm1E57Nf7yP0g2Un?=
 =?us-ascii?Q?VADleIqdEgDUqdKrTfJ1aKRRlzAPb5VF+7PG7550amN1zevWWdUXRKyAnTj7?=
 =?us-ascii?Q?zk19EmZ1LJBrJR2vKKScAH9jdQQqRyAzvkZe8vZEElftABx6Q5o901KfkaX7?=
 =?us-ascii?Q?xzX6fwQKA1xZ9b/A88UWqLgtvHOnRoSDQ5Z9fW//vafINkWRlkJhiy6Skdvw?=
 =?us-ascii?Q?cfh3+PhdL/cSsFjKLeV0AOsVf0QIYcF0EcwaWwWERKLlR7/e4nUnBCMZbTC9?=
 =?us-ascii?Q?7sP5nmpVOIFbNuNp+t93SMmdbb1ABXEpbyjcX+chYaseFXjLaR7r/ap7Wg98?=
 =?us-ascii?Q?yiiWGBRjwJyxm9SaTEHpbwcuTPUDyHqAo1inIaWq3dP/GOfn0VmqPQZUOjOw?=
 =?us-ascii?Q?L98FFc4ldxf+dOi4pPGgH+NwU/0XJ87bwSlA9yARMQkyZ+stQL2O/hbCeWVG?=
 =?us-ascii?Q?gjr7VOJg0PoKuuUD+yB7CkJvuytgDJPdNFIay4EU9WOTUbUWmn5KTfknY8S2?=
 =?us-ascii?Q?i26RZN3I92aQTfDpZ4sFTs7aeBdZaLIMXN3Fqx81AsrxMYotkpEioTgefqeu?=
 =?us-ascii?Q?SB/gYMQ4cl0X8CRc50l3erRNBrYXpdBAyNXYupZmiUdtOiL0uD90Gx4/byjN?=
 =?us-ascii?Q?OTbMWV6b7OABPa3XTCCx9mT0/fUMRcVv+DD2zJVl9VNdqXAgVEGY3CO/CwfY?=
 =?us-ascii?Q?f2XDHtqiIfLuPF469MRYBdwdRdXRfMs+4NoIKNyE+KagvNIBLSkY93ahX6rc?=
 =?us-ascii?Q?Jpw85TLhEfHUZbUFhLPMUw5WNbrmgVnU31NTC3ELCVU4zst2zUsVSdALOAqF?=
 =?us-ascii?Q?0HMOEZxK0+TGzfLcBMY5Sre/AMhYDXJksEtehZBt2SyqrznnJNyO1JMGxOLn?=
 =?us-ascii?Q?zuBick9VDfVYVwmM/Dm8pJbHjLdPU3K5vvE/7a3kTG55DU8rgpMMRcrH7X4Z?=
 =?us-ascii?Q?+JjNZ0+mbqFK9fN/5NuFdaJngMmFgk3XyRcllzOUsqTJvsiY+/+Bfxl/54hW?=
 =?us-ascii?Q?ZWQvKMetGdZ5yK6YiRoZkza7ohxIUNVCCcdQSaKLfVTtr7xsKuabajpShR5W?=
 =?us-ascii?Q?mWwAhrOvZEGrXeJQ717komCnhWhum+PA9zwwqgrvQj+0NnApKDgmXehohQwC?=
 =?us-ascii?Q?cdY76AhnwCIQ6fc7tLX9vgxKk4jkiuTey/05gAAfUa1N+RQKqF1amHgJhKqx?=
 =?us-ascii?Q?Yjo0bZ32TuSZd1jJ7XMMsjdNce9W9sz7Wc2JN1DTGZDGz5YAI1JE+oULXwIr?=
 =?us-ascii?Q?mWAWQ7k9/edxgph6ZYmpjCQqMPFY1MA2is/sG+FEsyL15i9+fbgd+t/7WAhU?=
 =?us-ascii?Q?nLSBH+1gUwayJdLU1RS/8FAiZFiKskiRMi5lpGsKH7B3ZTbIDzyNiWQgBamw?=
 =?us-ascii?Q?wxG9MnE6G1b1ih1BF3YlHVvcSXQ+DVZnG2YJeWwgIqQYBruVEO+kd5kHkEzv?=
 =?us-ascii?Q?duoGwm57Z+5a9vtYijv8VfE+zZWHe8B3azjcJVszCT3yX4JstjOAuc9JjB6p?=
 =?us-ascii?Q?8bljbzL2Lrw7WtHbegGsyZamxqc2yDP/Fwz42Ib/pbZssUhauf8wilyQGCCX?=
 =?us-ascii?Q?4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8847ebd3-20fa-47f6-9460-08dd81b2a3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 15:30:41.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzK1CXfUhkEgAkBvr/HofEVe98xNAOqNuJkSh+k/mSwL9lpNe1WM+tXeqEWbB8dmpme8J1Ms1FwbqLXB3aTmE7h0vQSlQ6+B8BKJzlZNsHPmgNlMjFpqJj++OT8vjtxv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9834

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, April 22, 2025 11:54 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; xandfury@g=
mail.com; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; ku=
ba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@r=
esnulli.us; davem@davemloft.net; edumazet@google.com; horms@kernel.org; and=
rew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; =
ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell=
-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.c=
om; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jaso=
n_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v11 net-next 1/5] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Introduce the specification of tc qdisc DualPI2 stats and attributes,=20
> > which is the reference implementation of IETF RFC9332 DualQ Coupled=20
> > AQM
> > (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > different
> > queues: low latency queue (L-queue) and classic queue (C-queue).
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  Documentation/netlink/specs/tc.yaml | 144=20
> > ++++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/tc.yaml=20
> > b/Documentation/netlink/specs/tc.yaml
> > index aacccea5dfe4..0fb971935285 100644
> > --- a/Documentation/netlink/specs/tc.yaml
> > +++ b/Documentation/netlink/specs/tc.yaml
> > @@ -816,6 +816,58 @@ definitions:
> >        -
> >          name: drop-overmemory
> >          type: u32
> > +  -
> > +    name: tc-dualpi2-xstats
> > +    type: struct
> > +    members:
> > +      -
> > +        name: prob
> > +        type: u32
> > +        doc: Current probability
> > +      -
> > +        name: delay_c
> > +        type: u32
> > +        doc: Current C-queue delay in microseconds
> > +      -
> > +        name: delay_l
> > +        type: u32
> > +        doc: Current L-queue delay in microseconds
> > +      -
> > +        name: pkts_in_c
> > +        type: u32
> > +        doc: Number of packets enqueued in the C-queue
> > +      -
> > +        name: pkts_in_l
> > +        type: u32
> > +        doc: Number of packets enqueued in the L-queue
> > +      -
> > +        name: maxq
> > +        type: u32
> > +        doc: Maximum number of packets seen by the DualPI2
> > +      -
> > +        name: ecn_mark
> > +        type: u32
> > +        doc: All packets marked with ecn
> > +      -
> > +        name: step_mark
> > +        type: u32
> > +        doc: Only packets marked with ecn due to L-queue step AQM
> > +      -
> > +        name: credit
> > +        type: s32
> > +        doc: Current credit value for WRR
> > +      -
> > +        name: memory_used
> > +        type: u32
> > +        doc: Memory used in bytes by the DualPI2
> > +      -
> > +        name: max_memory_used
> > +        type: u32
>=20
> Here and in other numeric fields you should probably want to use 'uint'
> type, that will allow either 32 or 64 bits integers depending on the actu=
al value and will make possible overflows harder.

Hi Paolo,

OK, I will replace all u32 and u8 into uint, and s32 into int.

>=20
> > +        doc: Maximum memory used in bytes by the DualPI2
> > +      -
> > +        name: memory_limit
> > +        type: u32
> > +        doc: Memory limit in bytes
> >    -
> >      name: tc-fq-pie-xstats
> >      type: struct
> > @@ -2299,6 +2351,92 @@ attribute-sets:
> >        -
> >          name: quantum
> >          type: u32
> > +  -
> > +    name: tc-dualpi2-attrs
> > +    attributes:
> > +      -
> > +        name: limit
> > +        type: u32
> > +        doc: Limit of total number of packets in queue
> > +      -
> > +        name: memlimit
> > +        type: u32
> > +        doc: Memory limit of total number of packets in queue
> > +      -
> > +        name: target
> > +        type: u32
> > +        doc: Classic target delay in microseconds
> > +      -
> > +        name: tupdate
> > +        type: u32
> > +        doc: Drop probability update interval time in microseconds
> > +      -
> > +        name: alpha
> > +        type: u32
> > +        doc: Integral gain factor in Hz for PI controller
> > +      -
> > +        name: beta
> > +        type: u32
> > +        doc: Proportional gain factor in Hz for PI controller
> > +      -
> > +        name: step_thresh
> > +        type: u32
> > +        doc: L4S step marking threshold in microseconds or in packet (=
see step_packets)
> > +      -
> > +        name: step_packets
> > +        type: flags
> > +        doc: L4S Step marking threshold unit
> > +        entries:
> > +        - microseconds
> > +        - packets
> > +      -
> > +        name: min_qlen_step
> > +        type: u32
> > +        doc: Pacekts enqueued to the L-queue can apply the step=20
> > + threshold when the queue length of L-queue is larger than this=20
> > + value. (0 is recommended)
>=20
> Typo above, should likely be 'Packets'
>=20
> /P

Thanks, this will be fixed in the next version.

BRs,
Chia-Yu

