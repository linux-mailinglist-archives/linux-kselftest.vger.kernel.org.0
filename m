Return-Path: <linux-kselftest+bounces-18103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EDD97BAEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E2283114
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C817E46E;
	Wed, 18 Sep 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tEajA30l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5CE17C9B8;
	Wed, 18 Sep 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655565; cv=fail; b=cxy/R9Jz93m6gcGqItKimpdeWC0I7WlukGtSH9JdizIbWCa46Bg3v943YFxkqaPcehbIQYoJpzIw09DVB4JlkP1KINgoFsI1X08FCb85t0Fy1MDv0cSARsPJc7TpDeCwz6/JxL9fJ9QWda5bKK8izYYN5DKiyPvqk7zvRcREy2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655565; c=relaxed/simple;
	bh=2WkumeZBmv3emv4gdp7b6WYyon9ilbIq7izvyHULXEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxIU5PRla3eEytHf/U0Si9PyMYsmSyvgUo9rfzDWSFgUI1k4xG0dbTvwbBKkFrEQIPzQVCYDJduWuHoxSexdthSBJSU4EP8kccYRUkSgcvJnmDn1zZ/M5UK004AnAg+gr6GtBSPOkpc4jcFC5dbNH3mLPfIcSfv9BYPbjdAiny0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tEajA30l; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/nNJJt5seDa1dET+1Y0S7+FI9nOh809v92wC6rUJmWgNKYhM/TA3yIpifeOnxp9N5CeDhfhg3lY8IHQU08uBfFrP6AJ9/Ubl8YrgjyG+up040O/5z+cldMlxglVVOYzUY10ZHzo+J4b0ONcensV51JzQSt+fKxeTEGeyTbp1dbkY6zxEAjVNPIqlsQtT07AXNOaLYmd5e7st/g2NfHk+iN6EN6iVW4abjZnDATXr0t9iBCsV0EhYC7OLyUt3n6REbZjhnL8rGgHpjbGqfqtqRKL7JBijTqUYFhTA2D+eKgxe7dWO7BKm8xok8J9MsA5rDJI9XJTQ3nB5Xo3jsKEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y4Bx58Jc6VWxq6CCsCKLKNJuHkGIu85ln3M9X90AUI=;
 b=xfPEiCeo1LMohBEzB1oWzj+YDW4nT5Yc0Hp7uJ37t/kUDyW0ysNjxHBlECFIvfS2DKWZt3PLkBjCJnfWkk/i7vHWlpPdateTrSl/lLzJ/NEqdGUOiA4b48/H0waHlLXtKavEOVowr0rprIYM3V9h7OH5VwOpxMBN/5MHkem+9encGHL1G6yHJGWcx6ESZSnM/MoMIvQDBULd4Tp1ibdpWfMqFX0+hwZVUI/OphTwVtykdOP7Bek9WxUy045oqI2xhPCf2RwMNCZCb1AaZNFjN7QiN/770SlE870QANDu82VXNE+A2n65m9XRZllz8E/f5EguAWO73m7Tx2vC9DdRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y4Bx58Jc6VWxq6CCsCKLKNJuHkGIu85ln3M9X90AUI=;
 b=tEajA30l1AORSYGliO+8eyYH2LjuRSmzXNgqUTo0YSHv/nvsf7bcfFFtJZ9wYML+eZ5Cmwn/AeHRYQMwIPntF7dOAeto+EitYj70M1ns19UvLfO3OfPu0ug12KUh9/Pj8FURPNoEMtcHLfXx3ZMVrwChUzWViq3UlveHlNBwEJ0zrOm+6QfWyEFy1MGfJPpF1zE8N/JuT4++JnOacyEqgVcWccaaqCq5H0I83xaifKEOcyNJU5ZMio6v5MAZEl4l9FLaM6SpH2ZCGkE24q+jgykNN1YLCtsNkpWlu+9QDhkhh/HNOv29SxBSjLnVgWYjLtDJXArWYACFfVLsOxOS2A==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 10:32:41 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 10:32:41 +0000
From: <Mohan.Prasad@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <willemb@google.com>
Subject: RE: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Thread-Topic: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Thread-Index: AQHbCOSaqY6jyq2GfkWTIKzaGCAXv7JcIDIAgAE5nAA=
Date: Wed, 18 Sep 2024 10:32:40 +0000
Message-ID:
 <DM6PR11MB4236FE8CEF8EC610B2525EF283622@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <0dd4130e-b06e-42e1-8f36-2589c18c4762@lunn.ch>
In-Reply-To: <0dd4130e-b06e-42e1-8f36-2589c18c4762@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|DS7PR11MB6077:EE_
x-ms-office365-filtering-correlation-id: 7e582f5f-72dd-4a8f-6bce-08dcd7cd395e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XvBEvK/mfXjEMH349ac75qWhbRCiMKtxkIS+7EUgjcPuVw4zkuHLjKpkMgDJ?=
 =?us-ascii?Q?Vxlbje9zatJEqv9JGL/gOqIEZfQyliDx3g4N5T46JDubFJfnwN9TfwWPubRO?=
 =?us-ascii?Q?IS9PHQv/4laPZ8JMdFyaKlTRF/PLHuZMWMtTRqKZHSR5ZBEYb5K1uee4slG3?=
 =?us-ascii?Q?wNMBr3IJlV8DMCWW1nyAYaQl48Rh93jzl7XxF28QkT5KsUmKdZVDQeYy+/Eq?=
 =?us-ascii?Q?ed4aX179gd5rIRBwPe0+dBeTOtS6KHg5LppSmVlSf5mp49k8mWfV7d4qygzp?=
 =?us-ascii?Q?3skodsSsq8nX8+PJdZjqap0gvy+Ew6v9+8x9zLZXh4Mq8vLV4cnlh4cnOHmt?=
 =?us-ascii?Q?kaWFkzXrhqB5hRbUkEKPLuith0BnXZuy/OaQYt2I/iX1IRK1LCzd+5EvzIE9?=
 =?us-ascii?Q?wESU9JFQC6vbFpu5LZB72evvRXrXeHq/LOf/Nj26fHFfJStntn8nEltuN6Jf?=
 =?us-ascii?Q?c/JddEFLR1WInYr22TuMXcnO+UCNYWE5Fnmr9+4CClsy6Ce9z8es0Sn3DeJf?=
 =?us-ascii?Q?3y5s3D43n2VA+0Nuc07otUq0oiIWyluTmsEwNCw6Xx69m1DdBfSnJVmI46SC?=
 =?us-ascii?Q?p6NNFt8HQNXTBr1soFtztRVuaCfjtjXosm6XaRT89BQNs1R1Bw1F+vxG/weF?=
 =?us-ascii?Q?Y1Pin3bXQDEVDpemS3YzmNiqXGKkUDkEQK2jdK0kxCUTi0NN/o/ifqCWIuYS?=
 =?us-ascii?Q?vDJ73J5yu4jzr7PCdUUESk5F4BiaZxxwDFHdWh8H6RO89RAvADzpkdRDjC5x?=
 =?us-ascii?Q?YFDKv1S6EN5xyUnQA+WL1gkwkGdm10xZKvRXgRe1rIa+fzP6RlshU5sthR1a?=
 =?us-ascii?Q?LKbsKn23pVyrICJ0xjCR4U4gYs3UaUwwsQCsdrPT+MqxDjNO41YBJlM55u77?=
 =?us-ascii?Q?oK/9VaB9+VH65zrWvoAj4YcwVO7CQ0umSv/3IPtpBfHslB2fbPRowGTG7pDC?=
 =?us-ascii?Q?SILfa5uX6JhtHtozXivRbQkgL9QlZC6fTfNIkGWZ7QvBzuoSD7TkQGqjH8ja?=
 =?us-ascii?Q?19gYURh9v1s28WZyfTDd6CdOAz35H8TJJMTHUvwNWUuz5jC15hOMO/O/6H+P?=
 =?us-ascii?Q?nTYaIYH9FxsXO+Qe18EhMahhanYZVqoPPat8bh/aQwHlklwesOgF7Hrdk5uv?=
 =?us-ascii?Q?YXCY+WBGfG96ZMNma7JPkuIsLpyUcwPt3Yi+D0xdXxYkHOXcJoTr4D4hTl8W?=
 =?us-ascii?Q?Ljxz54UKq/xZsbXW0fIioCaNBCNeNtu1k9MWMdw1EOEEUxqnHzR5Z+KiFGSb?=
 =?us-ascii?Q?fPeVIWfcjA8dc5GhhIRo5Rv0IlaiE8wqM0IkqNGuE5ypORg1YkqqR+uK7Ik2?=
 =?us-ascii?Q?qLSdBxjAabf1DOu0pSETGpRVZkHl/4Hkpw5S3EOxDNs2zSwSuFK+8rpE5Lpn?=
 =?us-ascii?Q?B6scSX0p0ASwwfe/EWqXbPjEN7/GXgSFxkWkrqUQ+FBBZ7B7SA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zHLCFmrQ42KW/+no7njuwcPKeB3qY1O+AUuWAtMMxUIM8kYwqHToHZSoLLbW?=
 =?us-ascii?Q?UUgb3n5TjyWIQv15e+X/BWo8TrRPcJyBZ0rZlNqtKVpSuKGalgf3fcGcmdzU?=
 =?us-ascii?Q?HX0VjWahZRZ3P8L/qH5qZ6fBNE+1F6K4QrtV9E8nUxKKPZI7re6jD5ViCnaL?=
 =?us-ascii?Q?xxbFWqtsKOZ6rQuq/pO1pXxAh+jOyKsf1OXRowpcYwNZOKu8FAhU5KeLwDkz?=
 =?us-ascii?Q?zto5qI3ym1PJuSSpcJhvdnAEMzYe3gCueIcdHC6eMq7bNcH1x1qbEiTcT6s6?=
 =?us-ascii?Q?bpE2m0tZxFtA3SN4FtiU25m2cl3eQruKUxT5UFTdZeAeEQ44iNP1e+X4qEil?=
 =?us-ascii?Q?EH15GSYNylavCPWNrppbV5FsOmgffpXCMrwe5v8Pa8eHeD6zdAeLMsnso6+u?=
 =?us-ascii?Q?bjtxCXG2ANpUggL2WPatsKa5ERQ9K83IkdOBiAtAp9DeZ5u+YKZp4Tg3Fiyb?=
 =?us-ascii?Q?63YBDo25Q9C8z6w9bUBiIvhsDdVqXi6XbhWEHZyeMN682JZZXVeesqqkUGr+?=
 =?us-ascii?Q?zymCyLC//wYDDFViwtOpW4oTm1NsxYaJKzbByWKmdvvTLsSG0N9CiFyCkx5V?=
 =?us-ascii?Q?rs4UeLcTGzNnSngMYcI5PZikvU1I40wD2NMvK1WayHQHYy+aw0NovKZRpwVY?=
 =?us-ascii?Q?O2moURUMm+WLVFxbKeGuHMjmXyOTX6R6phpDMdFSMPm71ICCze1W1vgAu00R?=
 =?us-ascii?Q?Mz2e7xQ2emtUTLrlPoV/TFIPc716WZK2wMaprzpy1FUXYVWnxSjNx5wkYNIB?=
 =?us-ascii?Q?Nax+zHGm7QsxjNuxGN17TTQVVtIEDeIEE4lBMZhitkXT+qfuQZzG0WPjnSKW?=
 =?us-ascii?Q?wnmmojWLu725s8S0yomdsg906i8/1b9aTd1++AUkUV3zezvUiuGHTIAcDymS?=
 =?us-ascii?Q?etabhj4dXIqP/TerKbD0u3f/1451gPj/g9hRwgEeD/BEoqPuKN3lRNuMW/Je?=
 =?us-ascii?Q?bB1TP/OWOvW93OepTrsO6W0yz6FPrko1X9ISrhkBaQw9FxlmH49RJoJ8iTme?=
 =?us-ascii?Q?y5ucWASo/aYlE+7QlPfz+38RaUZLMtN2CwznojtwdS5jYQ+X0m3Pad54+Kos?=
 =?us-ascii?Q?XgQQg2e+3qyApOGyxyRhwRTachDePxq4fvUO92R3rafSG5Xg3DN91E8lFQWN?=
 =?us-ascii?Q?jK0S3Ky0h/eTtkFHtb4Sqr0cretPFuw/49avfHhIgGiS75Xd+Z9fO1I7Td4F?=
 =?us-ascii?Q?Cv0XH47UG7r3kz5WR4a86AyIZ32H+qI7X3XdbQnpd3bnZoIkFitD4eKoj+v2?=
 =?us-ascii?Q?6uP+w1C0x94gSxEGR00GwC/SHvnxoP7myQsqbBV6esiXxYFZs5YPujfRQYKE?=
 =?us-ascii?Q?2zJ98pyKmShLBDO02neAYc8dph0L3J0HGv+e4bRenMHr2DCvg4ISMEYO2DzE?=
 =?us-ascii?Q?Dg0+tuN2/z23qhAI6j3HitDfm0uvHeCVmfmENehpkHilDj0etsKM5fy6DrdY?=
 =?us-ascii?Q?xsa7/A7L4V570i6+s3vkGfdIRWDwz3vv7o+LACclYkuKg5eM6vfT9n/BoXEc?=
 =?us-ascii?Q?MeKJ0Al9zbZERVI7t1sCSauyqTZS7ZUdx1lRJDFYPVH6soUgScmXc1mQw9K+?=
 =?us-ascii?Q?duN2fnopsH7asYHBqXpGnAxym3+QsOD6uX9kMy9+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e582f5f-72dd-4a8f-6bce-08dcd7cd395e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 10:32:41.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewQ67qanV/2q8Smq1bZWJxDuDaUdbmr7t/zAjT8NPgNSnWg2+ucXZ2cwDD3tLeVm2I5v36ST0YoEtvYm3OsWhhxOEiWzSHmBvkUxK47AReY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077

Hi Andrew,

Thanks for the review comments.

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +def verify_link_up(ifname: str) -> None:
> > +    """Verify whether the link is up"""
> > +    with open(f"/sys/class/net/{ifname}/operstate", "r") as fp:
> > +        link_state =3D fp.read().strip()
> > +
> > +    if link_state =3D=3D "down":
> > +        raise KsftSkipEx(f"Link state of interface {ifname} is DOWN")
> > +
> > +def set_autonegotiation_state(ifname: str, state: str) -> None:
> > +    content =3D get_ethtool_content(ifname, "Supported link modes:")
> > +    speeds, duplex_modes =3D get_speed_duplex(content)
> > +    speed =3D speeds[0]
> > +    duplex =3D duplex_modes[0]
> > +    if not speed or not duplex:
> > +        KsftSkipEx("No speed or duplex modes found")
> > +    """Set the autonegotiation state for the interface"""
> > +    process =3D ethtool(f"-s {ifname} speed {speed} duplex {duplex}
> > +autoneg {state}")
>=20
> > +def verify_autonegotiation(ifname: str, expected_state: str) -> None:
> > +    verify_link_up(ifname)
> > +    """Verifying the autonegotiation state"""
> > +    output =3D get_ethtool_content(ifname, "Auto-negotiation:")
> > +    actual_state =3D output[0]
> > +
> > +    ksft_eq(actual_state, expected_state)
> > +
> > +def test_link_modes(cfg) -> None:
> > +    global common_link_modes
> > +    link_modes =3D get_ethtool_content(cfg.ifname, "Supported link mod=
es:")
> > +    partner_link_modes =3D get_ethtool_content(cfg.ifname, "Link
> > +partner advertised link modes:")
> > +
> > +    if link_modes and partner_link_modes:
> > +        for idx1 in range(len(link_modes)):
> > +            for idx2 in range(len(partner_link_modes)):
> > +                if link_modes[idx1] =3D=3D partner_link_modes[idx2]:
> > +                    common_link_modes.append(link_modes[idx1])
> > +                    break
> > +    else:
> > +        raise KsftFailEx("No link modes available")
> > +
> > +def test_autonegotiation(cfg) -> None:
> > +    autoneg =3D get_ethtool_content(cfg.ifname, "Supports auto-
> negotiation:")
> > +    if autoneg[0] =3D=3D "Yes":
> > +        for state in ["off", "on"]:
> > +            set_autonegotiation_state(cfg.ifname, state)
> > +            time.sleep(sleep_time)
> > +            verify_autonegotiation(cfg.ifname, state)
>=20
> If i'm understanding this correctly, you test with autoneg off, and expec=
t the
> link to come up. That only works reliably if the link peer also has auton=
eg off,
> and is using the same speed/duplex.
>=20
> What i guess is happening in your test setup is that the link peer is fai=
ling
> autoneg and defaulting to 10/Half. But i don't think that is guaranteed b=
y
> 802.3. There are also a small number of devices which no longer support
> 10/Half, they are likely to default to something higher. This is especial=
ly true
> for datacenter NICs, they may start at 10G and go up from there.
>=20
> So i don't think this is a valid test. To really test autoneg off, you ne=
ed to
> configure both ends of the link.

I will change the implementation to configure both the ends of the link app=
ropriately in the next version.

