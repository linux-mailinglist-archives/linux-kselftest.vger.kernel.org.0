Return-Path: <linux-kselftest+bounces-32669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C1AB01B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D530C5020C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E8278E62;
	Thu,  8 May 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b="PLpN3u8r";
	dkim=pass (1024-bit key) header.d=boeing.onmicrosoft.com header.i=@boeing.onmicrosoft.com header.b="CEqYj55V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ewa-mbsout-02.mbs.boeing.net (ewa-mbsout-02.mbs.boeing.net [130.76.20.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B220D4E2
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=130.76.20.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726420; cv=fail; b=BVaFKlTNBb35OnDfs4/z+ZiHMyk/KBItMvgL9tXE7PUy4tQfthWliiyyH46xjd63fX6o/wTp1YjFPuz2KrBFlZYUhVqHvmQyUgigjel9LP5ixG9x6irqZtb0diZ9IHuI0kuIU4P9eVhNZLo42GWny1fUmUdXGOQbCga7HRKaGtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726420; c=relaxed/simple;
	bh=bpglIud6RKwSB+7zdoBww8Tocx4GlnR2+NcaRBlFQAc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mJVeeVvAsccDIGjeRTnszv6eM4IZ98NUNElGlnR228EDkO78zJTAnzsDHiJne7VM1NHGh7ePgIS2zvcLBf77Ovx5pg6OE7A2N5afzrAnV/y2ulRFXIk6eoETecSnnWnHcu9tGiClYJiNPJAbhrFlNC1rHDPteAlXdp0In0RvICM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com; spf=pass smtp.mailfrom=boeing.com; dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b=PLpN3u8r; dkim=pass (1024-bit key) header.d=boeing.onmicrosoft.com header.i=@boeing.onmicrosoft.com header.b=CEqYj55V; arc=fail smtp.client-ip=130.76.20.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boeing.com
Received: from localhost (localhost [127.0.0.1])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 548Hklda064940;
	Thu, 8 May 2025 10:46:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1746726408;
	bh=KrzNTtNELCLohOf5KCdsi6PjhlKk+Ar03cK9MzYRaeE=;
	h=From:To:CC:Subject:Date:From;
	b=PLpN3u8rMzm2m6gf7XNhkaWV2HkuTC08jF6OtA7HqUt6yNzpc3cnRdLRhjek0x7fU
	 CfBVGl70oLrTTNzSpKjfYWzPl37o7s6dAP8XYF/ZY3FRQ6JXENulr45x/LLndLxxQY
	 iYbXMdv5XhuJpoweXS0zb8CfxCoUrI+G7OdQXwEQ2QOsxaPtwwYgSXdHrP1Bz9O1Q7
	 l2/FSjzrRt/z2mwZqKLPv30Mo6yWwIvbLbWDt0QmuR5aSIs5/1ct0BtXimITfMg50Q
	 ys3Z5x0pqTUOd3GZuquinnDxadMT2MLNJSd4qYOxAlBU6AiAembtl6cVPHeqXV0T4o
	 2+913/PFqbUeA==
Received: from XCH16-08-05.nos.boeing.com (xch16-08-05.nos.boeing.com [137.137.111.44])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 548HkhYu064886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-kselftest@vger.kernel.org>; Thu, 8 May 2025 10:46:44 -0700
Received: from XCH16-07-02.nos.boeing.com (137.137.111.35) by
 XCH16-08-05.nos.boeing.com (137.137.111.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 10:46:42 -0700
Received: from XCH19-EDGE-Q01.nos.boeing.com (130.76.23.13) by
 XCH16-07-02.nos.boeing.com (137.137.111.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44 via Frontend Transport; Thu, 8 May 2025 10:46:42 -0700
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.180)
 by boeing.com (130.76.23.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 May
 2025 10:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=xr6uer92UtwSdd9QBVLwRwWJtxeS9MjfxNy4a821uoPTtVd+IEMXuQaLcFPzOlUnE1QTelBmQNPZ30tB7yd8thMi5sK8kYBEF4GnsW3yvt/9P3sPM6LP5qIjRGzzlRtBV7XJo5OjgWPuCK6WkxdgDwpjHS55quRN7e2XPD1noxaxIhwSbC6Vpr1yd7rUw/02vGrKh0goRrw8EUOqw2g+wWsSMmMPrhYri2EYxQOzalVNjDkIV/crdzDzX4oSUEBGBq/LQh9BAB68d96X/p6YjeV0qqOeAq6khCTgs0HRj6fpRrYMK6xcMGXpDi5ep2sukVY1g+/M5Sbjwdc5hyC3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrzNTtNELCLohOf5KCdsi6PjhlKk+Ar03cK9MzYRaeE=;
 b=HJyuLB+rsUpEWrRXSWZoI9BgJmvromSZ9PHfpm+CJyquUQCdrTDgaAiAxKrijwwm2UrY+65YWHwmciwK0APv53gqCc7/KuovRlcmZ3ChsEVKWlgGwRyqf4NZ54BUmkw+Nh8tfkj67cFo/auPYRYb4+Vv6c/4yGtHfatNCWLDytKq37L8QznnVnJFtw3syjy3BaJZ/Hg++bpfYW1ACT3nY8i+o6TwYyb5iXWOPlsWH/y6vWn2iAE/npBSEejSyHPpW64G3ElHDgBMtUfn+3lLYMV+SrA356/ueeKqfQThrZqv0JgRKmLV1tLsqkaTko7RKR3MyjOmqGRIF5kx4ug3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boeing.com; dmarc=pass action=none header.from=boeing.com;
 dkim=pass header.d=boeing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boeing.onmicrosoft.com; s=selector1-boeing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrzNTtNELCLohOf5KCdsi6PjhlKk+Ar03cK9MzYRaeE=;
 b=CEqYj55VefQBCKkmEGmQNJ8CXF5g7ZCvWleBmWAIKjjBTNqdoIMQ48+ybWW/pvPx8d9kBcxqH5XikySuddoiIYwoNIqQIEcS3xng25jr4B3UKjklw4jnYBCZxBR1yioNqwgciHE9KHrUcQKTDYMdCeZutg4xjoNl/F/PoT55CS4=
Received: from BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:19c::7)
 by PH3P110MB1812.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.36; Thu, 8 May
 2025 17:46:06 +0000
Received: from BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
 ([fe80::34e0:4442:7be9:6519]) by BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
 ([fe80::34e0:4442:7be9:6519%4]) with mapi id 15.20.8699.035; Thu, 8 May 2025
 17:46:06 +0000
From: "Weber (US), Matthew L" <matthew.l.weber3@boeing.com>
To: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC: "Oppelt (US), Andrew J" <andrew.j.oppelt@boeing.com>,
        "Whitehead (US),
 Matthew A" <matthew.a.whitehead@boeing.com>
Subject: KUnit for Userspace
Thread-Topic: KUnit for Userspace
Thread-Index: AdvAPxDnGX8n94G6RSC9EXGCWFwYNw==
Date: Thu, 8 May 2025 17:46:06 +0000
Message-ID: <BN0P110MB2067B35A6EEC0BD0C567E0D0F38BA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boeing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB2067:EE_|PH3P110MB1812:EE_
x-ms-office365-filtering-correlation-id: b77a7939-11cf-4f26-8af0-08dd8e58359a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xQmVkEo389NbRcMilL+33gWg+CMdeLjoK7pnOCI0qX4iT7nJjV7P5D/+RPcQ?=
 =?us-ascii?Q?C8bk7HZ8LXZ4/+qxWu5kn6EWdZsX9ndOFxI+Bk99++JO+eMWJFdH0siSZBEl?=
 =?us-ascii?Q?0gFv+bkP9nH7MMJDmPKpH+vKCSBavxcxI6RvZeAhE/wElOrLYCi2PDx4MdIC?=
 =?us-ascii?Q?K8/L3plNV7E5R0jjchQuDxvCucrud/wTJvOAqxoDK5o904JunSCgOpNyWUL0?=
 =?us-ascii?Q?QjoZp4cSbNnPIKpenlPsiW+hlZCVSLQYF/EB3FWXxDF80rD2gXdFQYwkVjxx?=
 =?us-ascii?Q?m8ID/g5XWejRCglv7akbxZDZf7S25NBv/emC3JrDpQF8uOGv8pLRylArRGwV?=
 =?us-ascii?Q?cQTnO7DZe2XN43fkdsj6t1rgjXizP4qhwFidJJZ1JAmwxACgr15tL9NUI55L?=
 =?us-ascii?Q?5EhXb8VRqdYMUDdkNcTFWhEzETT3y2p0inZ+STxT3yu2DvbszO748O6fF0LF?=
 =?us-ascii?Q?6PEwX4Vkdz8Mfx5tq80KA+BZ/jniq3rGeNFHO2vyr/aO0vCCuYgDjztnwKK7?=
 =?us-ascii?Q?wu2WjyCM6Qc6L2uYkSplTN86w7QRktp8x41qD7Tvbp80iOWCF/pj7pg1qRYP?=
 =?us-ascii?Q?bqWbxcd4n77rOejw2hPRa1E1WTpWhPktjVCf194hpbv3d58mOskBkjldBzb+?=
 =?us-ascii?Q?Y5E2i3X0dvVU5xAIMvhdZFvhG4duoUeLTAJhOeZFT601nmUf5d5uRAHMf32Q?=
 =?us-ascii?Q?RnHG04uEcMpvnd/zISjYtPgOCn7Cb46pLmNIugbpNkpF4oYMdWFGUSRBkw3f?=
 =?us-ascii?Q?BJMXJOu9ozXApb6YbU/hCcuyyTF4zzfPKvm2sBLTdGti7F4ffoVj2MoTFghj?=
 =?us-ascii?Q?U2NCDJuEhCjNgpGUSZQ+on4sNf4xxbGTo1agJux3h6/K6YGW2bfJlVYLbFhL?=
 =?us-ascii?Q?E/5R4zsjt/rqimH5RtqeQ2iqrtUA+/mHn+nTJPsaT781YmXshGMt2xkUM3/B?=
 =?us-ascii?Q?VSsFFl2qeZkwi2WJousTsrfEooEoWSyD9rInSfVrvARhGLibNtZQJGqFq8E8?=
 =?us-ascii?Q?4mJhgmuqYQNCojGaa+KzACaquVRzCnRXLd7T1MK8CmPHrB3o9TylkbScVbUb?=
 =?us-ascii?Q?ROOlIGDFbNdAUG1rZiIy92urNHaJ16xRZzETEETIC2g1/6zKmZoaeJCEjrxi?=
 =?us-ascii?Q?/2PDVPeD3RaEOG1s2h4pWJPnE/4QxzQXHq2fXMLGMyK5j0UfKoYuIygydnGM?=
 =?us-ascii?Q?FFHiZhJBsje+DVj+W4+9Fr7N4Ue7aHbB9kmKROxLRVIvgR6cnLskiZM/pcSk?=
 =?us-ascii?Q?h2dev1jOd2fx3tpopSn5Hl5RxWkLcvwiF1+wQl9cbUZpVwGVhbj3/mraGMe9?=
 =?us-ascii?Q?oO+AB81Ea8oZueZtKJd1neuQQaFYMGorTV2HxozaPO2yfNsXOR5FDB9uxDwp?=
 =?us-ascii?Q?xzbzh5oGoPuOwKTgfKBBPhHrHk9XJx2LlZguPI0cb1QVtCpPXwpz5q0boV7q?=
 =?us-ascii?Q?WwEPPjpYxVU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E6u3k+4sH0yYuvWLBv5sJ0ZjxKY8oB8XE/CbmQzDtrGmVpN2zKt4En8glDLe?=
 =?us-ascii?Q?QfTyy7/yQYD8hNKIk7R5XbZA/gLFr6E1XGHm4+t0wyUb3/4bRlZZ7B5VFB/1?=
 =?us-ascii?Q?ppncZgnKXFncUg5F3MTOjEHkm6idFfDf9gJ/i/iKfpYWtr/hmF0ZHV4B6HsH?=
 =?us-ascii?Q?x2e1HXCw30uYCz6D55AemYACtf+oN9jUzrHyur9KRIs0mlo528L43phuOQAd?=
 =?us-ascii?Q?RTCLalsWXnx4AqdQ/VYm/nwa2f44zV4oQ4L2yz1pRNMMj4lKI0AvEmzoVFiS?=
 =?us-ascii?Q?+vDKqMfdoe/tCnfQCI8EKTqUSvjJw3V2WYgieBHTrkepjYdOxmrk+mVbeZRQ?=
 =?us-ascii?Q?MPhQClpAPLDDz76hMkf4DhAWPQY4HQfEF69DlmZ0TCNCx5YnYrTbqbCa6PUS?=
 =?us-ascii?Q?yx36xyN/VIdGFHhg9KuMK/HZeCwMK2DblzXzHyWck/15grXEdVGicyiTLxCU?=
 =?us-ascii?Q?bv0AWDBbcAumhyFcw8rm9D4Rzn1gnJ2c/J9uw2l1YxMkUXSZ3Gn/iTp+0309?=
 =?us-ascii?Q?G2TKgigl1kFDHmCSXSgRkRl41BSXlJAJC+gy7oRqXKSxmDULKH/ZyXOq96g7?=
 =?us-ascii?Q?FouFEC9mEM6WwkAEcCNXg7IsP3EP0t/RFHxmiDYLPRWmR7loQHSpLT1HHqhw?=
 =?us-ascii?Q?9M/sA0M1GAVCiYO3Kw3y6XnuqEiN0Gm5JYQFxeLHsNkvYlHEXxFM6NYls8Xi?=
 =?us-ascii?Q?B3uIf8CBc6ximWJp/PostltxqIdPXMh90/Kc4b2f211DkhTs8LfwRBCD5wat?=
 =?us-ascii?Q?7c8l4sEgNU2iCTztneQcyBnlXGGGnvx5jJpwpRe0cDG4SZewpymxYbQySmNg?=
 =?us-ascii?Q?YZvdPGPzZ1NoPHWWR4cfZ4OUtG5mTDsWLZVhnC0QgDi/0ENx1EgeadH0778P?=
 =?us-ascii?Q?OgnlqSzc957q5co62zy7x6LHRZiy6R/SMVxDVC80rr3ZhzOe28gBOcz8zfN3?=
 =?us-ascii?Q?F46q+hQmizYxReTHPXI6LlgEzECe0KE9ul2YjMT0F7gaR7ZcUjiKTGBZF0NP?=
 =?us-ascii?Q?eX0Tuhl5tNtT3+90QOozWuPmLGO+IqvABYnJJ/G6rvdnCbkwDshOFSIugJoa?=
 =?us-ascii?Q?7xoeit+SATO05jwTToW553+wjxT91imzeUqCecxP0PUjLES6kv9X4ezgf6w5?=
 =?us-ascii?Q?n+agux/SKRsBXbuNQbRzHG04+TrGEvJ6grX32q1SB/eStnEeWfNCawC5bBmU?=
 =?us-ascii?Q?kZjw0dk+q2J5mMV8eax8Svs+0i8sXH6Lfia9IKH6XjnbXXUlV2lkXAvBgMI5?=
 =?us-ascii?Q?j/psNUKXEuiUMFM/xjGi9nCujdB/8L9eCUklTBwdQr0xmUKddti2eSChb8BP?=
 =?us-ascii?Q?Ferep4r58TRtwQrfy0auWprVAk5dqQKPdBRtj1doQCk1gx+3hIwPNndB0i/L?=
 =?us-ascii?Q?qAntFkSKPO1wMUpG/xTPxJBmgl+qMupmGw5pc5IAB6Rxo2gxw/pkFHOo0AV0?=
 =?us-ascii?Q?9yGFHzzrWBRFdZ7ylZIcTDngN3gsVxnlnaGWQ2fGW+KDiKbC0C1TBJAAwRu4?=
 =?us-ascii?Q?bqISjUHNbLqu9xgDjZG4jd8XH/oFbQ2/LiO5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b77a7939-11cf-4f26-8af0-08dd8e58359a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 17:46:06.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcf48bba-4d6f-4dee-a0d2-7df59cc36629
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3P110MB1812
X-OriginatorOrg: boeing.com
X-TM-AS-GCONF: 00

Greetings,

We're looking to start doing test development for portions of kernel code "=
standalone" mocked out and would like to do it in userspace.  Are there any=
 existing patch sets we could review or help extend to define this concept?=
  We have checked out David Gow's LPC talk [1] from last year that did poin=
t out a few patch series that hinted at userspace kunit.


Regards,
Matt

[1] https://lpc.events/event/18/contributions/1790/attachments/1400/3007/LP=
C2024_%20KUnit%20for%20Userspace.pdf#:~:text=3DA%20Unit%20Testing%20framewo=
rk%20for%20the%20Linux,mode%2C%20and%20can%20call%20arbitrary%20kernel%20fu=
nctions

