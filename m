Return-Path: <linux-kselftest+bounces-18128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE797C826
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988471F2179F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198519ABB7;
	Thu, 19 Sep 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QHe4IO+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0E335A7;
	Thu, 19 Sep 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742664; cv=fail; b=TKJLjsVKtm1ku/F63XoJbAtUBN0lirddlJMI+l/Z7OtkiRA3uFBVvXcHDTI06oSYxTpU13O8fQDtYkYizTe+m7RrDGvH0o1O1AWDRBQ9QCOgNPybbV9Jj4qQdie9u8bz3S/CTalHIvXkBvD9lhCddkK+fpJpUb3/32CkMaIpRzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742664; c=relaxed/simple;
	bh=NFt2mjNZYXTMYGrAw3+OxmaV3J30royZjOwpYz207hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3iyuoTNeiVZYYmkQRmN5e1+tLgYImF2lDcRVcbM/DW+9qW5fREjMOfn3plpp+y7M/YDe3/GAYWBddT8JW3l16KzITCmZ7IMw2hs6vaQVWhtv/gB+fo+Knzr9mgFng9DfOQvtXs243kqxoTqRFCnqrUeA5HVSiykFygx0cDcEBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QHe4IO+g; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igq77FJ9XJiwz2wQ6ubc5LFmevQN+Y6UIIqk/bNyYTGa6Towo6+G0CE8OIK/Uh5tpXG6mSFquBunPkEVJWlentZaMD3ZESmZho2Ns1MAinUhadLxpxJHfZAL6WiBbpIHA7jmB8rvFujoOn0BbIniaWO4WrvIaC098co1PLDiDg/o5fOxlZbtZe9w/psT3yrBATMesr0E/ueNa+tmgWyY334JEd0Zxx25U/F5n2XHySsBvWRgTtIKd0ZbflJ1BsOYlQmleb7W/MzDDgnkuLry3RBT2ko7rtNQFDqtSWJIFfgignSQuaiWYgay75IEJK5d/5b7RRW+a93mCmDTbmbhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuwLYHXSGNNYTXlop6yu8fw7EVRXlK002eZNcbtWWBc=;
 b=Z/G7T/AGvt3g8CjaK3c+Rabz2TJX6EZMoCafjIvEyvqqQyIZMGcgviY3qMMs+eWEFcGp/MurAdI8C6W4a4z9iapcIQtFQHc2jCVzrv0L9nxcYYfmmfJPw0mW0Ha/H32S6etcBBV5w2g5PT1JobyrxOIvWailcNcDbnTKD7P0NLg/73CbuTHkQ0l6U/ZxmKI2t7PYkV5WFSKj3wDlc3gYL+64lmGpjua2c0Yn/0arAYLN4Jugo9/+MxBe0z7YUPGUXlK1kYjiRqfyMO4f4bBSsGdlhP2UWCJStEGYEGvxjM2rkq+5X7yUQsy6iJQJXbbLJrUH7qYymri0voZ24HnqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuwLYHXSGNNYTXlop6yu8fw7EVRXlK002eZNcbtWWBc=;
 b=QHe4IO+gXJpMBBNzFLp5MUYrjICI50ad7/6aF7kH+NYHT20rLwKKdqMr/pV8PVwW2DbRpXi5F3lmzBKyQa0SIS/zrCg0O0f6fmfolXro+HkH/zSVKvW+h2dzDyBoL3Uk+D7RKdnj8rdFCAyEOdEBgD61PlnKSAEW4ENlJ5kaIKOVgFqqNWD0DsF6698QHqc0WONeu9v3a1hCFCwWjQ1Z8YOWJP/z2us64dqgxN7TR7izd+vIxVP7h9b5buPFe0jB2Z+g4v5JsYWbTWHKezHjCANXvwmweGjq4eqHI/VwnTKET8hSGEZQLDuVQW9GGBBEJVh0nzSFyeoszgDFPGmlmw==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 10:44:17 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%6]) with mapi id 15.20.7962.027; Thu, 19 Sep 2024
 10:44:11 +0000
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
Thread-Index: AQHbCOSaqY6jyq2GfkWTIKzaGCAXv7JcHLYAgAE51PCAAB3OAIABevAg
Date: Thu, 19 Sep 2024 10:44:11 +0000
Message-ID:
 <DM6PR11MB42363E9DC481B09277369B5A83632@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <5c8779db-31c4-4b93-986a-bd489720fa4b@lunn.ch>
 <DM6PR11MB4236AE79E97B4CBBA1A9812F83622@DM6PR11MB4236.namprd11.prod.outlook.com>
 <0d6c225e-358b-401e-a4aa-a1f7ea0f2652@lunn.ch>
In-Reply-To: <0d6c225e-358b-401e-a4aa-a1f7ea0f2652@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|IA0PR11MB7282:EE_
x-ms-office365-filtering-correlation-id: 10a987bd-8ea2-4beb-da21-08dcd897ff1b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NXELm9sCa+FpDtmQQtUA1bFT3sPHw4fHO0zS4eHJCtUod6aNLnTLytS3YJT6?=
 =?us-ascii?Q?1rV5JbW5tVOjUUukMHzkdDg9g0YDWsQHc42tt7tqAh69JGHkMC07fXkpkjWH?=
 =?us-ascii?Q?1KhOGGvVVw1w+XG9Nh0+p6X0RDU1MZQvBe6b2Zo5puWJiJi3Q7qAjwQaumcK?=
 =?us-ascii?Q?mWp2r3r94eU4+UFGrCjG4qSk0K1FeLMZfxuc9VKQl+9j0HwgYxKzaooWYwwA?=
 =?us-ascii?Q?wrikk4qgH53NwTKZI0i9wkz+OpPznvgHlDb91cSISF+M4Nha5jHL2m2qo6bt?=
 =?us-ascii?Q?3cCTBOUITLyQK92JeonOcHr+LQbCxjErrocHuVgRvMUa8Thu44hFsetaldjP?=
 =?us-ascii?Q?KIq2Z/bHvafHLdjvylUpzhtzxFuhxlXdpcLK6bvbFQNWXQHt36cCY1hHGZOl?=
 =?us-ascii?Q?ErKNJGVVUbhaW8un1fHUsTz5bqMU/sJrqjYb591/q/Zcc/QEjjQHzDOcwlGy?=
 =?us-ascii?Q?CszUV6UKe8n4fRRpE8aOQEdWCC+re9Gslsshs5LL4oV9oHQE8tctSgANkbkA?=
 =?us-ascii?Q?ocyk9UCA1zigkn1ajswxyBzcdqXXwFp9Sne71rrwhswv1DzOiB4J1tzSiCeO?=
 =?us-ascii?Q?Xf8SLI76g4UXhS3XhJWVvv6nrJNAWu28scP3vtwBfB/BwanKs3msWkOZ2YHA?=
 =?us-ascii?Q?CsS6X3JM3TkRpsUsjMxRZsPFKC+T0O2rI2OT5ZGH57AyRdVk0Kt4cNjbzCd2?=
 =?us-ascii?Q?LKr/Cu+dXwxXH5k4L59PYa2mJFxXBruL8q14wR0lCTfHhu3/m2+l/1tuwAmF?=
 =?us-ascii?Q?COQpsyOPgtKP6ZwNz5PPX07XUMZVXhZmNV3vFlzJzKaSxhePBZa9Ob2zqHXP?=
 =?us-ascii?Q?w7D0yTmI17q9LPb6SD1AyvZFezy56KjHHA9A4eS4c/6tcrP4mrrFgaz2nnpr?=
 =?us-ascii?Q?kg/qKwGmytSEcn0Y7/rKwMllQFsf2bEly48IxBL0Li8YwcjM0ewPYB/4IOgc?=
 =?us-ascii?Q?03X8zZQolKzPUgeUt4ehyIN/Q+jY5AJlxevl7/1V2fq4+L3wN8+yYyvJmAXD?=
 =?us-ascii?Q?bv/eF+INV4+JP+rUsZl7W/QM2eYBRxiLaUDOh0iJ2fIFqIvIelbrxP7aPplB?=
 =?us-ascii?Q?01Z+IGeTmrit0JAfjeu0WJ7rik/5V0XYiLUejttBzdj8n6pI9TlRDZ4VQnFi?=
 =?us-ascii?Q?0fvA1Q+8b/UWFJVR+T25w9kwqMFsqXiHt2ZZ7lgciHwp0Z3icNiMSa/6BwVC?=
 =?us-ascii?Q?8kBVowsle2Kyterggg1Ekzd4dkfk2SX/K58yXoW7N3hm9192yJJV2g8iKzGu?=
 =?us-ascii?Q?uSxdIFUZH7iBEv6AJ3OGPzi2U8oiDOcqMGnG7GXsaKtzZeJCB9Vaay8oeOmy?=
 =?us-ascii?Q?8gy/orZEa8LODtzg/OYR8nzJxbPc+ZV62iot26pvBM+3o6WcG1WbftGWJNfC?=
 =?us-ascii?Q?XRkqYQsRd3JuAnx9NAfrOQam5NGqtj7NdJ1VpQgRUSPSufHf7Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qjcIGOGX+U+kv8n5vdfFEs1xNvoKNqCgWpJIS1IOXzGsg5v2Xb8zPgG+pcZE?=
 =?us-ascii?Q?VJT8zOpiyoM6bdHViKy33FL6fONOMQaNUuQCKHIoNmIRWqbDHa5I5BV/uS3L?=
 =?us-ascii?Q?ZZogc9iKHrQuC81jofUyci41zkwHNNbVZAFZMgrgGXsPdtm30tNZjJDRFGz7?=
 =?us-ascii?Q?oLznIDFEdPYtC0xo3cMVaYoXoAJzqD1NAxgP8ue62I2SO6OFlk+fLFiNcA1N?=
 =?us-ascii?Q?U4qfdSCTgZrhGFcHkvqtrbzz56+z4X94/7jcjVlMqEF4tPlePoGeh0HqyRBI?=
 =?us-ascii?Q?t4gtm60hTox8X62GKHDTX4nxJmmK64IXF5phSiST/PyZSURKErtaD5VS/Qsn?=
 =?us-ascii?Q?6B/Xs+QWrpxmt2GsVx9FqviRKjONd6N7tMbcZ5l+P7J0mJXHJtv8Fxcl1pUd?=
 =?us-ascii?Q?ekB5i8eR1jo+o3bhXq1ExBgRXVNl5pxXaVxeoZ7Tz/ZIyWFOUJUNZZorGN8N?=
 =?us-ascii?Q?A5LRz4FzTrKkzaQVXQm/bmX/kcHBfE4Q1G28FT+mjtZI1DjGZ2b7EgCoDtx1?=
 =?us-ascii?Q?db+BLKG6KbzhB83e41joYJFpHUnwTCrVgZF4W1emTPBZvxpS4zfSjQIo3sN5?=
 =?us-ascii?Q?3xSrhFINsoyjmw0J48ltTvuWy91pPPRYtLQoVFDTxv6nGiNb9m503KBJAzPd?=
 =?us-ascii?Q?W66cQnnZlg/jfKl+DCq1CRUJzgFn7uUAf84xO1BdP4Lk/gRrR8LijkFar7lT?=
 =?us-ascii?Q?P2fcouG8eDweahFwY6mGZMryKBvG8jqzKmMFgLtbemIypLoWA02LjM4rIC12?=
 =?us-ascii?Q?D6eYShjS45mb2VR5zGl/CAOgRMx/FIf3lAjm/L9j8YrEJymWyAQkR1F+m8ih?=
 =?us-ascii?Q?o3LNyiyMG/wDhcf8SZX0iqgANRZtCmWXr+dqQ9CiT7wKM998Lq4WJ1H0Z5E7?=
 =?us-ascii?Q?lQ/+5lHXwrnb1Q3YHKtX49QK8GZSVA11NiPqAE7hjx1B2c3cROqIqb6NumO2?=
 =?us-ascii?Q?91dm23VT9o0C486fE5vOVOebsMST34Fk8DyOWxEsFxZ1B4Vb7dISb78hQn+z?=
 =?us-ascii?Q?+nv8FbEbInuOAl7Ic+DSez9CfvBxptkWV4ZlYDt4kfw6sGBz0BXA4BuGNI94?=
 =?us-ascii?Q?XR4ntD0GRG1GGy3JNsh6h2Uy+PQp0fR9eLS7h5ipehTPG3mbfWTPo1xEtm++?=
 =?us-ascii?Q?JPCSNrdvOas3y8v3SrzwwfBygvmv7sjDU/lAPjKh5x20DpZgArhcrxiwqv3+?=
 =?us-ascii?Q?XC/9TzR2M9QQb9L3nu10gSW9ZN9EiuoJYozxLX9AraHw6Xs94dFwoxcf/T6f?=
 =?us-ascii?Q?6Z+1/aWKHhsmQVgh//oY81lZ+EG/OKFgnnlFdYc0DVPmBbcJuzWF4WEPOSO2?=
 =?us-ascii?Q?myU7UMSRQ88wRx2RPtiteAncCGHSVsSWvVgE0s2Fcg2R7yCgeKQ1iVCAIzzL?=
 =?us-ascii?Q?BuWaQeqXtPQqPRhJaKKTFsxdKmoU5uHBNfBsOOmhLk0+zAzuc4yjYoYVJ/Lt?=
 =?us-ascii?Q?NScFfbV/mVCmm0xM4k0Tohjs3MxTL5wPiTh6SvLCEdg9WKKaW3aQZBTM1vLU?=
 =?us-ascii?Q?4NxXuxw6DiGrBQiAazKI96lcTaxOHENDeK/oXuNkkeJre/qWdGHSLuWN11tM?=
 =?us-ascii?Q?wyyQe22ak/b3t/97HXmUwR3e3ul2+ycOAyqyfWFa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a987bd-8ea2-4beb-da21-08dcd897ff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 10:44:11.1088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kWg83KIqb6fp+e2qh9Wv+PapoZDdz8hOTrMxPNq56LxJDiE8SA2ETR2HOCMJIWiV1IRsVM6FzbwBpjjSxFHW5jg4244RBIJi67D5o4PqeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282

Hello Andrew,

Thank you for the suggestion.

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > Since you have batteries included python:
> > >
> > > ethtool --json enp2s0
> > > [sudo] password for andrew:
> > > [ {
> > >         "ifname": "enp2s0",
> > >         "supported-ports": [ "TP","MII" ],
> > >         "supported-link-modes": [
> > > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000b
> > > aseT/
> > > Full" ],
> > >         "supported-pause-frame-use": "Symmetric Receive-only",
> > >         "supports-auto-negotiation": true,
> > >         "supported-fec-modes": [ ],
> > >         "advertised-link-modes": [
> > > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000b
> > > aseT/
> > > Full" ],
> > >         "advertised-pause-frame-use": "Symmetric Receive-only",
> > >         "advertised-auto-negotiation": true,
> > >         "advertised-fec-modes": [ ],
> > >         "auto-negotiation": false,
> > >         "master-slave-cfg": "preferred slave",
> > >         "master-slave-status": "unknown",
> > >         "port": "Twisted Pair",
> > >         "phyad": 0,
> > >         "transceiver": "external",
> > >         "supports-wake-on": "pumbg",
> > >         "wake-on": "d",
> > >         "link-detected": false
> > >     } ]
> > >
> > > You can use a json library to do all the parsing for you.
> >
> > I tried running the --json option with the ethtool ("ethtool --json enp=
9s0"),
> however I am not getting the above output.
> > Instead it always throws "ethtool: bad command line argument(s)"
> > I am figuring out what might be missing (or any suggestions would be
> helpful).
>=20
> Are you using real ethtool, or busybox? What version of ethtool? I'm usin=
g
> 6.10, but it looks like JSON support was added somewhere around 5.10.

I have been using ethtool 6.7, updating to ethtool 6.10 solved the problem.

