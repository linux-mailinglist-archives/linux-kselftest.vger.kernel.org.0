Return-Path: <linux-kselftest+bounces-17471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A7970E11
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2278282D4D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8E1AD3F1;
	Mon,  9 Sep 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r47b26rD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F406335A7;
	Mon,  9 Sep 2024 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864181; cv=fail; b=n3MYAY3CTtDBqZOcyJslQh9wpng9CzJEhdSH34t7l0d1astatOQhRyTdYuf1j/Bdy9DzZpQee8YHrD5dyYUyD9HNUKwHcym6pFIthHIzNwtlUbhBBI0LvSZQZieI2IX+8Qif7dT2QGKvVV//80cgZyZRCrAY40aAy4OORNtlYUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864181; c=relaxed/simple;
	bh=98Qp7cr+jAzGNYL3JRHLIz95uNZH9V+A9Gl0rSUQOLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pT99QEL+riY8cm6hXwcUWOQRZJqhBynKP1adNHXbHZmHlZmCx0hvh6AQVTqjfVd0G75HNgA8hb+Yrndx0d41/eX1lJA5w7pcEMBGqmY80F9p8Bz2SedRX7MQggUfKQQPPbqnl3fj9h0gYuDwQ5OmuvwP94H+z/eWsw3XAswgBS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r47b26rD; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w++bn8K2ZEEJ3m0idiqRCaTmM1xBkfGn9LkU7PV6WITADc9sTssW6G04R3UrsYIlHHy45T+gDrgK8rAXA4cZDZkKIHQ3X88Z/cRH1C+nLrIWnHkUliJW88djaFHqEJTSEfkQSyMhmszRk4JvGbsYIjiKcRMfYko5DSxhaGNH0DeQcPykrO0WogqZjR/xN7glfjfv8lwYIngrIn8CKlLJlsyjI1ZMT3Sz/736L4LLDoLxQE44cvyPUEToylHnYiBDj8rJatiVy+Rrr69XALPHJfIdtZBxTdyo0zgkH9cQgT5DD3shnu+/B453dulGY9EIGEEmJcf8QYgpMb3EsitvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuigXt/0JdwQKnWBUR6AtnnGA98cXRxPe6xnzFVC+Y0=;
 b=EP3KrZD/JL84xQfydHkT1o19XNaPs2O2ZjUdac4wx4q4r3tkSSwkzIsXOhkN4e9lJ5/uYIoWaiXipQMea7gVCETfExKbHuVXtjUL61+7Svx254nRmm+CtHHJ0VWtnjeW+21bOuSueW7+fbWSDoHulsaA5CyAXCPW7HwzL001WiRaorxdhxW5PSPx7nhliVHxppXdUN76O+NcqOhQfVjLxg2cGygeakcMttNYjDASRfsoG2GuGQXnxoVYp5B26Ww6uCeuXi77IGvbh2JeflUV5i/H844uDe432rmO1EYMIo2JBon76ty+ypBvF8JE0b8DMmNhbVMqkqVOF4WoMEUqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuigXt/0JdwQKnWBUR6AtnnGA98cXRxPe6xnzFVC+Y0=;
 b=r47b26rDVPuXZUFMcHvcTIS3X/Dmd2dN1uLi7AdBnEmNPv4I8Elx8fmA1lChxv7F27xdbLV9v8AxqgKgcziSza06NYnRFfPmR5iH+zXprlTjfIYmi/PfWvHv0JondPz03frUBZQS65ddUxQY+OegmDFkeeEUvKsPU49YIV89cl/YpG5/9nBkLCezIP4H8s3h67ssZQQ8BAEaHVkn3Zv32R4UWxZElhlL2iDRYrrOIjPUQ+IjPBoiHHpZXKzQeJe/E4vXMQ+BXbKTiUr0l5EW6Aph0xrKyGRH9I/6ydiAEjq+B02bVFRwwsrbhVpP/yNeywiApAjTwGdTZC5mntwocA==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 06:42:55 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 06:42:54 +0000
From: <Mohan.Prasad@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<shuah@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: RE: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Thread-Topic: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Thread-Index: AQHa/olXajpx37qPH0O72SAJQKbczrJHGf0AgAM4JXCAAFvCAIAEWMvg
Date: Mon, 9 Sep 2024 06:42:54 +0000
Message-ID:
 <DM6PR11MB4236A76EB9FF90303153A83083992@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
 <DM6PR11MB4236D1B92E9FDF1A4640DA68839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
 <96e017b8-3702-4b39-a44f-91c8b4ebec89@lunn.ch>
In-Reply-To: <96e017b8-3702-4b39-a44f-91c8b4ebec89@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|PH8PR11MB7000:EE_
x-ms-office365-filtering-correlation-id: 4f551111-4c8a-47b9-e1e6-08dcd09aa237
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?laT7bZAGEa+z/Nim7sru6CUmjhP9lCCdId0Z9aCXmNVF/AtDmVmc2+H+z+vh?=
 =?us-ascii?Q?8l6eapRielCzFyLrhdVFX/iiDnwVI1ZsK4VHO/+xXJLt1w1G83WMjidG7Qxb?=
 =?us-ascii?Q?Ks5lDDzzwX9Fnmukv7bsR8iPf0sCmw4y3SlGxBjZ4dunibbvQjZ3gxqOUF7B?=
 =?us-ascii?Q?ca+Z8TEx3U1qjHLun1kma1NMoXHgw1W3s+tQmmKlLvMtQgS2+9pqzKke7j4v?=
 =?us-ascii?Q?u8uqfhkN/JSYfEc2tfRBGVXFq0P4FxyAe+Q7PzqhYuyBfwVh4K+LinOvK58j?=
 =?us-ascii?Q?zeLCc2hHbDc1dhynjOGVXruFJRVQsSKfFsmwZuFbpf1HCndKQPJwufv4LasP?=
 =?us-ascii?Q?B1Ho3A22m0eSNbRhXcnJbvTwXGFwCzpX2+W8apnCUny7Lyo9OdguyMGo5a0c?=
 =?us-ascii?Q?0PHT5hZmZQ1qqNupnK1u1jfYABWhLmDjRNa5CA06JFSgiqRPn/1XGrK193dU?=
 =?us-ascii?Q?g1GdXLpM5QIhG73Y2atz5F3/mnRYud+D+t/QTdLSpVMvDlV63kxi5JmwRVqJ?=
 =?us-ascii?Q?N2txcZ+hYFvTs3+RRJGGP34Ju2wTVhsQRrQIyKv8dBxeM8nMjMfVikTHUoyt?=
 =?us-ascii?Q?c/mCNKkgcHbdjOaVUUGSM9HKYTHnDpqSTd4ex1sP5Bi9QFnJXlI2kiJFGuwb?=
 =?us-ascii?Q?/zvLr8X/QbGqUFKN+myhPTkjAdGJP+ur+nQig+PL7Twi+UUuel7O+AtxTVfj?=
 =?us-ascii?Q?pGwWAmrOQNA2tzsGT6jgF2ZhWdkpBiLZU+aCpEQtb8dl5IjSCTaQwTx4HfMp?=
 =?us-ascii?Q?W6XUlUy8jB48/zbUTHjXqGbEtDLonWetmKsKOgMM+xfjOqla6BPnJ9a+FaIx?=
 =?us-ascii?Q?aFQONR46/3MNObsDyDz4pkNwSmPTMYdW1TScHgMmDLDCoceeM3TyTq2LMxyD?=
 =?us-ascii?Q?vwIT/4Mgc+ubT6yJdsN3BvmKP+uN6OQD39e1/IxuH0IeNzeFMTaL4dXgrDrj?=
 =?us-ascii?Q?pA01CpIqnNQhWmihB8PemAGLt56GOuX+rvJ6Llt/hYfcDmiIjpn6zEtyrjKw?=
 =?us-ascii?Q?uZUhuQj814Yp8hlKans19Czdi/TH3irbC6FeI+XwcZhkIi0I+F1O1KTdxbsS?=
 =?us-ascii?Q?Zvr9jDJonAHIu/GmF9f0mVpHgYdd2H+HvNw6i3VpLQRsOwCA4nne+rQsjtk4?=
 =?us-ascii?Q?Fp2ktZNODEjBTxpJicfOAXlbyIeOS7GebKWc6u6LyloMLLUigWo3oy6TM1oU?=
 =?us-ascii?Q?KRDPYLOwlWn0KNXVRv2jNIFSv+WqsEVjmQAv4Jk8UgOMRjl0TLg6tEo4DBhl?=
 =?us-ascii?Q?8LdjHKJ/yGmbPQcySV7rz41SrBAXUIDAKfFiBp75S4FQ/x/jkBNBlbyZqBtd?=
 =?us-ascii?Q?iyOx/x1D82Sf8Z3DOy4gAfhCijNkBZ152DhBafuh5jLEstiVle+xxlwfZhtz?=
 =?us-ascii?Q?z/KWjXUnKtcXpuc88W1KOVmsp3Om/myi/NKOZh8hxpKPrk99pg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gS21XZMJfd9Wwe2WBPYPrIM1W+N7dwX4jNvrZwox1YL8yh3X9AyF5gUVZsO0?=
 =?us-ascii?Q?vmmPQMXK96E+iqwq+qAezire7OYS3LiRlrtELM0PZSf/yr8wHQ+EeytahJMs?=
 =?us-ascii?Q?iviE27OHCQ8GRVvf7w6kE6wFU1XaAiWwQs6/1PVeT/oMVJngR3KLjjfY5KFh?=
 =?us-ascii?Q?kP/CJ9iFnlTn4LkzWwNZTfXF5khxgXLRdIqtvEqnWUY9k+0THQzCnhK/Q1wX?=
 =?us-ascii?Q?VlwzXm1dY4LYiGdzYIMKeWL51l03/qhobideMYEFn38l2TALGhk8MFiQVkq0?=
 =?us-ascii?Q?lkNRJtlsMeifW9qJfSrFYrUjohHapjjs+tY61HTQTYQy5q49c9I2jhngBL6z?=
 =?us-ascii?Q?aQ1RRXZWgiwbJ6ZR74JMvpJuS8/VFlhuuXLdznYLidgzMcC5MBcK+P4nl4im?=
 =?us-ascii?Q?iF7ZNIZQ97eoXKpHnVaUmeiulKZC5C4MzPxh8bBFexyas4nORga5aTEwWFp7?=
 =?us-ascii?Q?vabKwYNNPR1xFNGpAHvPT9hMEwao0L7fMit7JM9CdyUmN0rL/2NXnn82poDh?=
 =?us-ascii?Q?j688i08MptBTwp7lj4s16PcuORfIcNk+XhG9n8Rsgb3Y37WIuGmyBcQ3HU3B?=
 =?us-ascii?Q?e7P1f4o80zXTQSex9n4FA4+RcHlbUevuIh61hWL7Y0yM6MmqhM3Y60rZ2jC3?=
 =?us-ascii?Q?SOntVpRRg0r0/IfyvlVjZxibRTe5O7N/lDL0HcnQhk74o+OnBFDR+r60ybxg?=
 =?us-ascii?Q?fXtTsFi4KkO3W3oDY7v3dxQGjGAuKD00nyCyjjp4ZYpUADeUrLsuj4VIYDze?=
 =?us-ascii?Q?5gdETj3Wf38Pn0hEY2inxOr9cPfRNGwYeMFyxl0j1MdJtvb8kO37ag7fvxiX?=
 =?us-ascii?Q?Du8FKQ4S8Ykwr/rjsjXw+PIWA9tVBNMfz3G2o8mpnT0DF2O/wrLgV1zqj34X?=
 =?us-ascii?Q?aj6rRt9OXGcEaK4KbzL8b88dQEwbq/grh03g1D9VRU5JZJrksyhjOtmwC+c9?=
 =?us-ascii?Q?YnkRqDGOTr9aoAXb2DdUVPSSqiPLBniaEa094hF+klw9Qr9SknO7DKvcBS4t?=
 =?us-ascii?Q?c8/hyG3MV5zzC8VIF4FOQ1CpHePe9ovwU/jB+AJ7dci4UzLbJ8K0konBZcRY?=
 =?us-ascii?Q?e5qhaF1LndQKoxb4jgwPDEt8FoRldUvzxwkNb6qZOHfmiOJVPyk6Kt45eYVI?=
 =?us-ascii?Q?+f+CuvKwxKcEQZMEis0wLsu0feeJPnGxTIr27XEBilPN/sW5W+eLeg+pCa3R?=
 =?us-ascii?Q?CYwX2sjFEaDJZL+WWRWOU7xDkL5MZEigcK8gpJ6IaA11B2X3jOfDYxdndzVI?=
 =?us-ascii?Q?x/QNiPFJ5BPUByaQLdP7sQy9ajfSsO8CaH/gknQz7C3PWoac29bEFyTNjR+P?=
 =?us-ascii?Q?Fc8xyD1hEaQNVNUZEK4oLr3vrxhYBze3ZdhhpAIN/3Ez8cnN23jY1pUQPzXV?=
 =?us-ascii?Q?oB3/LJVjQr1raKYdZ/CjmzdBDj57kYXgwN5J4gO7Ih2ROGxINxee8qY8LGzG?=
 =?us-ascii?Q?fVJjiMiKskhoRsRoDI0ohARJUUBKf4hHkvm9+uT3zNY7Op9j8tKFy4cynxa8?=
 =?us-ascii?Q?AZpDuFxN6zqsLzYbI3jiAIMKEtmvDT4CLmF7nbpyCaZH65iF9g2Ld8bfa9ym?=
 =?us-ascii?Q?k1vO7C9hIEsI1YfNQergcUBEsQkC/3EsxVnuUcaf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f551111-4c8a-47b9-e1e6-08dcd09aa237
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 06:42:54.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uToPCbIR1nvvxCASnA6Ub6KelIR+zAnznGFWCKXOgkcfznjZxRnaKVbevRsnd40gu6jqZTbdXXM8oY7kYT3AEjNHKqT04S2PSdR2dpVD6NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000

Hello Andrew,

Thank you very much for the feedback and the brief explanation.

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, Sep 06, 2024 at 06:45:53AM +0000, Mohan.Prasad@microchip.com
> wrote:
> > Hello Andrew,
> >
> > Thank you for your review comments.
> >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > On Wed, Sep 04, 2024 at 03:45:46AM +0530, Mohan Prasad J wrote:
> > > > This series of patches are for testing the lan743x network driver.
> > > > Testing comprises autonegotiation, speed, duplex and throughput
> checks.
> > > > Tools such as ethtool, iperf3 are used in the testing process.
> > > > Performance test is done for TCP streams at different speeds.
> > >
> > > What is specific to lan743x? Why won't the autoneg test work for any
> > > interface which says it supports autoneg? Is duplex somehow special
> > > on the lan743x?
> > >
> > > Where possible, please try to make these tests generic, usable on
> > > any NIC. Or clearly document why they cannot be generic.
> > >
> >
> > As suggested, I will change the testcases to generic form and document
> them accordingly in the next version.
>=20
> Great.
>=20
> How much time do you have?
>=20
> ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP    MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Link partner advertised link modes:  10baseT/Half 10baseT/Full
>                                              100baseT/Half 100baseT/Full
>                                              1000baseT/Full
>=20
> You can see that both the local device and the peer support auto-neg. You
> can see what link modes both the local and peer supports. The local devic=
e
> has 1000BaseT/Half where the peer does not, which is reasonably common.
> So you could use this as a basis for the test, ensurer 5 link modes do pa=
ss
> auto-neg, and one fails.
>=20
> If you can, please try to avoid hard coding any link modes. There will be=
 some
> data centre NICs with a lowest speed to 10GBaseX, for example.
> There are some automotive devices with 10BaseT-1L which does not support
> autp-neg etc. It would be nice if the test could be used on any interface=
 and
> the test will decide itself what can be tested, or if it should skip ever=
ything?
>=20
> And by the way, thanks for working on tests. We need more people like you
> contributing to them.
>=20

I am currently working on this and would rework as soon as possible.
The feedback that you provided is highly helpful and I will remodel the imp=
lementation with these points in mind.
Hopefully you can see that in the next version.

>         Andrew

