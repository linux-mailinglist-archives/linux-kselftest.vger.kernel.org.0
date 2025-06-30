Return-Path: <linux-kselftest+bounces-36111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09AAEE262
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA75163E26
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0928DF3A;
	Mon, 30 Jun 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dSg5uLnk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EC42AA4;
	Mon, 30 Jun 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297278; cv=fail; b=ikujSpVaO5MjPBlv8hj+nx6tWxVJfb4dRJo9ByIcMis9mSR9kgOoc8/z9w+y5vzF0JBnRmJXFyoNUmOnsObdkjq8oufrkpSad1X9RIHaZ/5BS8BIU9nZtgC1RLY+zzz+zfd4CjJqDIqLdkvCeWxmbg0AURrvCCcTTt7BBIXMeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297278; c=relaxed/simple;
	bh=cYo+Sj0vkhSG+tKuKGdNfxnXsHbgj59wtUYGnEXatos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1qkYwdAjTtUcHH/rL/AJmIOGeupLNt3pTaPJKuZLSeghDTuX9eFaBMjF1kyx6iQughNOsqQcmCzWo+58wYP9endqmgtr/kESthBw1sHCxMiJZ+ButgHViMUhzDCOd9Z8pbMUYx+cFxs8CZZz8c6VPxGKRD7x4qI2Ztr9F7DfJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dSg5uLnk; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JizuwP9QsloY5fcRmFZ1HEvnZhI+eNPYj68yZHC4W1PPOm+FJ2WOP6gg5wG73DbgR29awPoTuTZIff89mYCMLz0NjTlLTdQbt5OK1CK9O+UaQoSzXalzeeYtg5eiPFlIHXzdolivl9Qv/K+V3yj7O6Ecz89OGaA/gbApuei+1fu5BD3ZfbvZygwaUFdIkXem7z7Ff5haRuCW20n/jYlZxuB1feVgzCgwoCa5qkaJz55ciZapbaonsmUn5ZgpUGcVcE6ZJzLOBmgBTEXI3bxrbUfDgS5qlqOiwh3A2an0cWG6gWJ1o29NEnD9n0ltorjE+ZnRDABO+0fQeJiE0u0jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYo+Sj0vkhSG+tKuKGdNfxnXsHbgj59wtUYGnEXatos=;
 b=NA9UpU3Exiv/S+OPjiYhLBqGQ7sBMXF8kitn/OwVdTxW/ihaL7hdD82m1IpsvPIgPU2ZybkM3WrD6vG7wRIEJ3J1Ep7AYYX2Gza5dGM+4NQ5ViQST1x+0+w69Z1Rw4kqhN1D7R1ymytNkVnFEwUdOHe4cBwUKScYDxOJZpDMhnF4qwkUhcWQUSifw6JxvkMG6OjEzFaYjZh7xClvtFo4ZWXL68hYfoK3/9UJT9VD0GoxeHhd7T/RWIrN3aOPFtOFFP0frZWS07Dm9AIqX7BaHkboSuxMZ3HXXWI0knM8eeN0O5PilGVfduS8M/HlaeHyj5muciJ1qMRP7Fs/Ge/hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYo+Sj0vkhSG+tKuKGdNfxnXsHbgj59wtUYGnEXatos=;
 b=dSg5uLnk2D5XmxX3dDCsm7bCneLySSQSYOVAwvwCaQ/mKMRLeEeYeYTxVucYoX/IGyHk093OX1Kih8F63RBuddg7XwS6Drln8Hc1Yum/L0RfoBTwAgxAV4hgkx4ut6edWDlemvjeH+XVyjRWq7sYZa4vNyPJUeJ5ATQxWBF4jS98eSmzYJSQyX7xtMPAhdGJ5xlyf7HU7XZ01Ezk0Ft9jwI5yVb7ICmkiW2a1aD3as2mzJxDV9NevfrdmaaFJEK35QyRZctUuedk6Qu/K2j+rCGG/gpuCHC3FrwvNLBdh3JgtJttuSEO6U1xdhpMcEEWSkNZHom5D2upqjLWxHauFQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU2PR07MB9435.eurprd07.prod.outlook.com (2603:10a6:10:499::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 15:27:53 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 15:27:53 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
	<horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "stephen@networkplumber.org"
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
Subject: RE: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHb4uNqIs45AgjdskKJnV37K9wpJrQXrhYAgAMXXaCAAReHAIAAAq3g
Date: Mon, 30 Jun 2025 15:27:52 +0000
Message-ID:
 <PAXPR07MB7984777E0A2438D287B4A3DBA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
	<20250627161930.385554c0@kernel.org>
	<PAXPR07MB79842E86F802F227C79C05F6A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250630081222.528202d5@kernel.org>
In-Reply-To: <20250630081222.528202d5@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU2PR07MB9435:EE_
x-ms-office365-filtering-correlation-id: bae0b4a4-f602-49c6-9426-08ddb7eaae3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+lPVGS8bgfm2zr9hifPcGMMkHm6MFK4Ryif1C+gIBp80zK/54vAOMeUIsBGx?=
 =?us-ascii?Q?kKgiu1AzeYpMaFTyWSZaKf+0j080ierfa++qM+F3uXAoO9LwM2ZsyT8x33Hd?=
 =?us-ascii?Q?eLlrlzJHWVdnliRa6uNcQwQTOJyopp/NROZ+ZtAV9KDHoFC6dhHyTM0XlZ99?=
 =?us-ascii?Q?4WiAZkCHjzLz5Xt8/mt5Eu5ZytkfKWsPAV4oMGGM4Nm0zV3vdcTBDMT8Bk21?=
 =?us-ascii?Q?E5oMjY9ADf/JD7MRHIXN/ZZsR9P46B6CW3ntocZZ8YWn/UJJdVdhoGI+Miqv?=
 =?us-ascii?Q?ZRTJbhjLFLKJS/tfXuvTSGOVQEz521o/IKpP7MoIOV0nh3wyfn6M9Hpb26p5?=
 =?us-ascii?Q?iN2TDgghO6e1OV8khMVA+K4m+8exlj0y088tqgN9Jk7hlzx5xpkfiOidB80z?=
 =?us-ascii?Q?ajXJXdlLtSeGzDWge0lJqaPK/OzQG37QVNDPkJ9M0+t59LgDE9+pbBay9LQc?=
 =?us-ascii?Q?2yUeN3uL0OuCj4B1sq0+g70ztlli73Qbq/RDJ4LY6+kVyHiic1Z6PGd5Y8Xq?=
 =?us-ascii?Q?geia861W7vVjR403PJdgX1WQjBejZ7nRYER7MzA+ZHckVRtPpsGmrLTgEY2F?=
 =?us-ascii?Q?WQtZeFIY8nIcNmSh4KLz0E+h0sWCkD4bgKFHPuvqfcGJhCEhcjOOvl9xJASO?=
 =?us-ascii?Q?XQ4QefCaRPSmvW+oKqrjh24wVSSM8A7q0d2fytlbS6HcOaKmmKVyWaIn/cw3?=
 =?us-ascii?Q?AhvB+VLF1lcVL8uU861Smf3Al46GA+F1/Du5g6nK2Kqv7/bm75INmhMxXjqW?=
 =?us-ascii?Q?dcMkPhmheDPRDWOfWtCb+kUV+4wdIYEhWp+INZeT1frmLRM6H7Aq+O8mvAq+?=
 =?us-ascii?Q?YzWhChDg+7Ak8ZWuf+5IaW4R/wSLHGwwkQwNPj/enZoCfzU8/JkJnTB3djAo?=
 =?us-ascii?Q?xDaXz4CED2R6JLmW0zblUaJf3nXBOL6BMN4TAFD/rw07TfhSr7+PvgkQg116?=
 =?us-ascii?Q?YMZupHS8ZCPzdcWR8XspjE5lzsa6+euwCYmiF6+I5COSEnaaN1LZr8HGKBzD?=
 =?us-ascii?Q?eWV8PL9T806q/SkExlMnqIFcXPO1vrSZNshlkqvNZGZKAtQ/OMdclHbg0SBY?=
 =?us-ascii?Q?bLxBD9jpP24xWU9N+cu+F30il2mEi6p11erx7qMnSj0D8jE/o7E3jigcV40h?=
 =?us-ascii?Q?qrzxOsFsQubIPm1MVBjbXnuVRiLAGQFXrJBIgNmlpt1B08eBs85In/MpWmZ0?=
 =?us-ascii?Q?Z1M3D8PjNQG5YxAXE0mf/+kGvMwo7E1iWZCrdMb1QWJxnxub6lla042vY9i2?=
 =?us-ascii?Q?KnFLZUKA1pq1FTrhDOf1tIr2ko9f1muupTx3rxmjFVCc7Q2JN+7y+mXs+wiv?=
 =?us-ascii?Q?UZWrJLc/YxuZZx5+rkH74UsV9mJzgzKFRTsj3uij40a0cYI51MM/WCVlADnv?=
 =?us-ascii?Q?WCNgR1KpU/3wDjJaBwbtUDVmeYuAKdRg14EzX7UxRL2AF6auP3F9ScXITkwQ?=
 =?us-ascii?Q?fhSrqBmAAF4J2KOtdYbmuie6a+kfY1ZYDweYli4Jou3xvInaEgEiJEx0sQsn?=
 =?us-ascii?Q?H3LsDBwJ0Ix99kE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5tI+x9ibV0pk/J3M1i2tb9iVf6D/8Ov8mJCxPFVqvJYDucZAT/6DgGbrc483?=
 =?us-ascii?Q?YUwrqBHHY1oLvvpbPU60pcEaVmF05q/Z80tfCukxD55m7g9qu0wWS8/qrB7W?=
 =?us-ascii?Q?YtZIEApf77TtNDnJ5YaYFY7gU6HY7uLClTOdM1sQALE0c66tCuvsli81pu83?=
 =?us-ascii?Q?SEdyEjFVYNOcK0Gp007jlz2tRQH+4OesQnBcIPQaffxrXiHEQvRuWFejmiWG?=
 =?us-ascii?Q?+HaQArp2RjJpMkHFm4iQ0I8FNKUDw0i3HB7/BnKnQ4dJRxWFhv9QLlrRkHll?=
 =?us-ascii?Q?XykQCk/462VhdZzdYerTYAnKqBR2rafdOXPn0ZE+X+9WE2KDdfRqFy8ImaQB?=
 =?us-ascii?Q?BWb+Mp6YGglLo7HBi+wFs1wAkk8s3cU2m8UWt/TU5TQzqUoR0wYFFFPujEc5?=
 =?us-ascii?Q?8HpUhaARRr5n+SxZhQ3QtMSisn0lxFMWo/7TAIwAhQs2DNbuiEwT9ewO7/+5?=
 =?us-ascii?Q?T1iS14NSKMsuHh4QNgtEanYXx30g+Bbk//ZxugsV/MFzlE7lv5PtT0rkg9ie?=
 =?us-ascii?Q?pEMSkSWN0ejTjumIhR8Sp9gimPIcr0U+qAubwUpP5NMs/CPyGdLBBCtZi0au?=
 =?us-ascii?Q?DOYsqQBVjJkkNa6zSma09gXLBG7PPjwJceahEO4UI1ec8eE83LuAx2s2m1Sk?=
 =?us-ascii?Q?NoHaW/X3ivN8pONUCpMAbeDxqxqZuVkG9UJTqndHkntHoWQTI1tmeE37eo4J?=
 =?us-ascii?Q?c0y3/IyoXyF2m4FGxrnC/oK0dTsgox+vDMIio+rZANlRRaMX6S78+C+Fh9rK?=
 =?us-ascii?Q?nzOyqUYVDgjtfsQG4jrH+xaF2YYQHhdtBc0nbhS+EZVd1Jl1WoM+vJVA1J0I?=
 =?us-ascii?Q?9A6/CO4z+VY7Y2wN0D6EqZHXNuz8cUjXqtg1U68kstBJBiVG0EhsFM1j+7ZU?=
 =?us-ascii?Q?I+d33Ls0afcftmr3dNOvZQmU2Amd/Fe+qPLJXHYsXXGdUbvbVQf0np01ovNK?=
 =?us-ascii?Q?8pgNMnjejSieS05HW4PUQmV4Uliefcm5Fn85/NNNN/HUaQrjP8g9rkJgsjDV?=
 =?us-ascii?Q?pe8TzqBbhGHMw0nqeNePFf6LsUR5dtrGlRnQbmErNFXx1gXg/qxwE0WIYdvn?=
 =?us-ascii?Q?sBLDchn9qMGg+g9UTJJiHx1+vOs4z3I+uxWr98orYAdtEcgd70Fnmgz+ITj3?=
 =?us-ascii?Q?IU82+2qGH0jZ/v+ZBONmgbJ/HwgBCXqTPLHlV2WECXtIbyd8V6pDgSQqpDDe?=
 =?us-ascii?Q?dyCCm6VaTphuzFhF9PdEuxkudKe2pgEvp4CQuzEc8tPBCVyG/XT4CRyC8taT?=
 =?us-ascii?Q?8i3erDpQjyQCqdMjTyRqhxkrMdxvx8V35mSepRKW0dDqOTJYtjGOmQY/wPe2?=
 =?us-ascii?Q?r1ILu9W9sJiwWKbWRHOGgphbU5nfOioHd+ynjc92c2aJ26yja6ONkoi77MTe?=
 =?us-ascii?Q?ZX0GEUR1W2ckh0ppz9P7Yjq7Q4d/7cVS4DGj8m52ah0YWGrBHdM3OvASfQlq?=
 =?us-ascii?Q?FWihcIQbx8sCdSsObnUYxGeYrKp3ehVbxFimoCGa8JGZyh2GskjYrkjFwk44?=
 =?us-ascii?Q?EXzg5jecZAbDO+K9yePeHWuulsRRsesk0ujUVIwJbdkr3qp7KPK6XQ0JY6aG?=
 =?us-ascii?Q?ZBiU3vzyNu7QlarFIUWVNYHbmy16DB/4QdOtgz/BZpxFxS2sTRtDlpXgr+CY?=
 =?us-ascii?Q?mA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bae0b4a4-f602-49c6-9426-08ddb7eaae3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 15:27:52.9392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LMpP1N5sKF/2s03d9GtVZm8qxinpGFiPAF6eZ0myzjSrDVrJWo1XGKcSaH9R9DZIllUYn5V8n1VD/DKC4z5cebTIMMzfoje6pX61DQw+0GN7JibFGEbEX+H5sNusk/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9435

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Monday, June 30, 2025 5:12 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: alok.a.tiwari@oracle.com; pctammela@mojatatu.com; horms@kernel.org; d=
onald.hunter@gmail.com; xandfury@gmail.com; netdev@vger.kernel.org; dave.ta=
ht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; stephen@networkplumber.o=
rg; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.com=
; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwe=
ll@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.c=
om>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlew=
ind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comca=
st.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 29 Jun 2025 22:32:15 +0000 Chia-Yu Chang (Nokia) wrote:
> > I was thinking could we keep the same strucutre? As we already have=20
> > several rounds of review for both net-next and iproute2-next.
>=20
> Not a valid argument, uAPI is forever.

OK, then I will replace "step_thresh" (NLA_U32) and "step_in_packtes" (NLA_=
FLAG) with "step_pkt_thresh" (NLA_U32) and "step_time_thresh" (NLA_U32).

Does it make more sense yo you?

Chia-Yu

