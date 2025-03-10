Return-Path: <linux-kselftest+bounces-28590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66857A58DB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 09:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A703A55E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9B22259C;
	Mon, 10 Mar 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hfNSFGT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E1222590;
	Mon, 10 Mar 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594112; cv=fail; b=LPqbQsN73p/M0tnemEJdOIkz4f+VurCUHPdYnMmRR+EmnBPaKtLWZU9NUlI+5R19WAp6WRlHY1DOeSiza6S4HUepO5hcuwWBGexGq7B1CuZhqU0CX72zAa5/H0iwUPUSjKXxx+3z0gcWi7uVnpruRex5jyF+dH+hB0eHy+JbBv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594112; c=relaxed/simple;
	bh=BlkBKGzSHdtR96xinqV6CvVw3WJlAMKT5c4navcYRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4MULAjLSIx9QwDdon6ekA6w+UuWRX3FO7lBaBcS8LeI2+MdpaozZ3HaPXyZZSay0mJ511f97geze1jyU59q1diJMBted7jlbLEVLM7+sNauCfy9+gjk1sK1CFE2SpK51s07zPjMoSLtp21TmlX+XW3c2smJcm3rZmRMLhbm/w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hfNSFGT2; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0a2UoOTa2OC592vvn3mfQ8ju+LO+nYmV1q3vKgvRdYjizqQq06n+BPszwG3dnwh2iBDd+K+bZGSd/UEHt7QJRLZ+nz+wmHg+ZS55ctbcgX2LQkfI4/5QSYWTP8qOpMX+XCvES0y7ZI3GA3LnnDDuKxvRRNiQf7Sb36RyygxjA3aFYGggwZqMI/i/PNmA4VOaVvaDd//qHJkfAeOD8FdDHI+u5DBnTqMeXLfWCQRtN9hnari8sCVzoB0Fw6HBy8UULm+4V1JhYsZw/rvhYX1vfzTQkKhUoop5dmmr65JFgethBBAMw7pqAhCrkRhAauZ/Ql5SN4o8E4OaqZhp8xJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbINRmbcwy51FdI1fP3lOhlwdn06qliFaiz3cCxyaRU=;
 b=YebFXS9l+7Fqyzr7VM4yq45ESOmesxZXeZt2GgCo1AK3xC0lnaXlQ/+ZDAIWVmxaefmjWSNjgRJ7wfAK4PiK8UWZAVnZ7avp5WjZZ7u8wKeeVT/Jg7rPWuMGSQzSE/pPApk8AKnceF4jUtdA53+jS/ykYU25UzgGHOZZRhU0dkfnD229s/Sw7ywp34zWaZL9LE8Y/u3gcMNFDJwXayYRK5mBuzQ4dVJIYSO6rL+rSxtg7RAPUqwiXxVyxOtECoNiZ7VTkMtTk5MNI397SUuZF+s7+ex58T0xBb6HCKrit/M8TTbBIN3MeRmxNUKDs7yIeBELcbYRofOHcNeNnPAk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbINRmbcwy51FdI1fP3lOhlwdn06qliFaiz3cCxyaRU=;
 b=hfNSFGT282d6S/uKgjZObSn9TjtGphTMUtb4nWUqNK9Y6HF2+NT7zplCpC75cdY6Ybb7+UCcV0nVqKXOmEqqsB0d9XYGDz9HDkhZrqHLkgpQShxgMZLT/CJIIksjG3EGRu+ztwsrGvU0u+r5JHH2JYLp8M8CqYQFJLtgr6wNYEpvobjCGLoHknH7cxw84Sfn2TArM9bqNqV62dw5xJtoAdlq4a9yj3sVGfNEr/j75RQHAWQQJgZZQgUTuTn4A9AFF6A4TYOiRxleoVUq92U7qh9tSqmSf9jRqgN01+vwmY0W/4TsupeRXNtQjxSmMAkPT6omFH7NhFeHUhqTfIyPgQ==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by DB8PR10MB3798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:08:27 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f25:24f8:9a0e:3430]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f25:24f8:9a0e:3430%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 08:08:27 +0000
From: "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v12 5/5] igc: Add launch time support to XDP ZC
Thread-Topic: [PATCH bpf-next v12 5/5] igc: Add launch time support to XDP ZC
Thread-Index: AQHbgFYjDDsvmh2P3kix+y3ANQFC5rNnwgkggAAVioCABE328A==
Date: Mon, 10 Mar 2025 08:08:27 +0000
Message-ID:
 <AS1PR10MB56759C0DC193825B6BCC41D0EBD62@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <20250216093430.957880-1-yoong.siang.song@intel.com>
 <20250216093430.957880-6-yoong.siang.song@intel.com>
 <AS1PR10MB5675D13A436CB20FFE5E1082EBD52@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <PH0PR11MB58302B9F3C23B4BBEB7BAACCD8D52@PH0PR11MB5830.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB58302B9F3C23B4BBEB7BAACCD8D52@PH0PR11MB5830.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=32c776a1-e37e-408e-8746-b3b86ed4e75a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-07T13:03:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|DB8PR10MB3798:EE_
x-ms-office365-filtering-correlation-id: 2cc79952-654f-4934-65be-08dd5faabcc8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?uW9Dd1ePzf/aKJhtSFxvChgGEBSZFFSrJ4LiLOHPVZh05kC4vjQ9+4DXlP?=
 =?iso-8859-2?Q?8Grj3CCV3MsSu1Rlui+0LwzuZl1FGnkFNh7brRVwxlZeJToufRL74z5HsK?=
 =?iso-8859-2?Q?6o2A/6nqYOJ6a8cKl2IovluzYBVHliMNMhE5YsMdvLRJsHxXEj8nKGgfIW?=
 =?iso-8859-2?Q?nWMw+l30NP///GVJX3F2j9Z90xLwVFEhsIrv3kRNZzLqmD9UFPfRPbTahq?=
 =?iso-8859-2?Q?FLHePEZvt8fi3ob5ufGj3s1Hme1ZEjHwsMkCdDxYhHaheM1QD0E2u/xnFG?=
 =?iso-8859-2?Q?ARF0YoqU5IK4Y7+/DwQYt60JoEMHp44tQJdxraWsQkFf4/xMCAivMD4VZ4?=
 =?iso-8859-2?Q?He/Jg6mw/sG0PcXzPNKmTQBwPCHmzUXcceDz5Av3jGcycwOfRKux0nGf8a?=
 =?iso-8859-2?Q?RqwTOTWV60HUGQB/P4tcihugo6jNhOYZEW1XPADO7TLC9GXURrT4t5ol/7?=
 =?iso-8859-2?Q?n0pcroiFPRD3wBWtSAHElsl28lKMPu3EvakgLE1LNVpzOojkGy30Qf4RKK?=
 =?iso-8859-2?Q?l8YFhNYH8B9KClAuxj85vGeHDDYESqbi40zW6ZWpNar5xNuyAYWIaxe6Fn?=
 =?iso-8859-2?Q?WTBQcsPwZHz4aIYORgZfkR0nz8ro1Ovdg5MUSwU4WOW9bOFV+v6JPZlIpC?=
 =?iso-8859-2?Q?S+oI+Zuoo3PsKStIRTxQUw7UJvGWvpu50ucfGdTVBSbwWdIr7icUIxkiSN?=
 =?iso-8859-2?Q?cdpLS8k4Pu87gnrQu8x7J99pzQlJWsIgCc6gp8/7ACGBWo42ctlCTqIHQL?=
 =?iso-8859-2?Q?awmroed3/Yys7HsJ3Oql9Mq5PhFBAxJ56LWTFwuR71cCW94GOdQ+iHHe9r?=
 =?iso-8859-2?Q?26DuuIK6IpGbtZP9yYJAeU07Vz4PBR8mdrzXYz58UU9Q7l3MncTLozpwQQ?=
 =?iso-8859-2?Q?iAVHBFmYlxvokWGdChBVsAqs2URecR6uK6OTT+6h/wdNpG4MIgjmPa9scx?=
 =?iso-8859-2?Q?Ckn0CpJGpZgiMLh3P5BvyPC1XqQzPM0Z3lXkYUS5XhJfgOVyqb7FtfNQdb?=
 =?iso-8859-2?Q?ks8kTIaKkzSMdhvdxt/B4EUWnog8Ot+5lOwLGIFYdvh+kTfICOPFV+05Hr?=
 =?iso-8859-2?Q?BqxEWIRQucB5L64GxQeha0zBW6U7lomzHZL1sKiDuv5qqWNlJ94CGyawug?=
 =?iso-8859-2?Q?0F03+1+HU5fOP6DYbS1yNefeNbF5455C2YZI9uDCTepDEe15P1S0VIkgi3?=
 =?iso-8859-2?Q?GsimEhrRtdDZIi1CU2mIUnje4oP/ZH0lgcONj/HN7UcbH5jTv1WO+PPHKf?=
 =?iso-8859-2?Q?YIexPGsNNZ7fETD18rK9guZEJNYMW1WmGgmDRlrOHtNDSPHaTYjk6NRQg+?=
 =?iso-8859-2?Q?9iyJsu8ftyf/O//cbRT3FSLdRMm7vybhamvk3xR7352nPYgT7KupsgDh6J?=
 =?iso-8859-2?Q?CUR8IiyL64Mb23lyiASQeqaUjUCFC/wd02ESSp7ty8hDtnpf7vQW2hi8oK?=
 =?iso-8859-2?Q?dMapuDYx27GAojcIzj8RdhbE4VoXNa4sHaB2YlKOSM2smciQjeeKszkKC3?=
 =?iso-8859-2?Q?BVBU9FA3CEDHVJL0VOnA54KbNo0HDK7rljnfL00FRfag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Sf78rHGPTWbNM6QFTy8ZgusX+RNd3pn+0LhZHey1BdvAGlFBXsk2shsHW6?=
 =?iso-8859-2?Q?6tYj4GUwUYRX3v00r8Hhw1LWBSyzS99QqNwPR/sgQSmCVJDKBEeuj/1NA2?=
 =?iso-8859-2?Q?08kjQaBLzBb+C7O6aEvV8qdSeurjfoDBOyCcbzfKJMb/1VXric9KzlhP2O?=
 =?iso-8859-2?Q?+muf9gKsVwe7dmob8IzkJixXgSX0xuWsZpm4fJSOGZYHWkA1d5ZRSlgO+T?=
 =?iso-8859-2?Q?Q2Xh+e7/GOF8tICNpi9bDJuGl0GXtVgV4qwilej+KMItlTqwEh4pJ6tFzX?=
 =?iso-8859-2?Q?Z3aLy6l6p27ik+gIcFdi7Win3PqkkbjnP87PNXj+yUIVt5+xfbBoXiUh1Q?=
 =?iso-8859-2?Q?nGU7iQ4fYzsIezlXVKhSnaLtY/3QJ0FxyFUiDbkSVV6dmrZvsyN6Ps+QQy?=
 =?iso-8859-2?Q?N/R0IxUCABuq8hDcVcN3ZkFUHaGEdEzO2xi1BHnYlDAtzIAL+9ZWNZFJIs?=
 =?iso-8859-2?Q?bDq7e5UESGgaQkB/X669O2NiR0K2X9UGybnkMI8Qqe8OpRtK+iaaZpLo63?=
 =?iso-8859-2?Q?TezLTnsCG9Qc8J0ACNRtxqBw48ePXUylha2688bNMIe8cL9jMGfPE8oWtH?=
 =?iso-8859-2?Q?QWwYmmANoTtWUgZUt6zOZGV4sKXwAclbiPbObMDjNlOPXO8HiifKMaYEMn?=
 =?iso-8859-2?Q?qjG/TuGi198Atba6H0lpNzJZux9hy3smYZDdl52FsQHY3ndKiTWud/oc/C?=
 =?iso-8859-2?Q?HfqDDuJ+dk/dHEIDfTGT7HhNDYgaSrHSnAhp7daLkHDlh4WtqNcSEKZ9+H?=
 =?iso-8859-2?Q?dSRMiJO/5OdSvIG0gMTH9FkNInw3nVSY0qUBKHToQ3+dyCyLSeRdmc4wx/?=
 =?iso-8859-2?Q?M5MstAdKA8zN1QguMid0xX3aZD9MQ6eFiseFgAAGhOwDOUm81LNN6BD7VV?=
 =?iso-8859-2?Q?tAz5nAtc0i3FZQR0Itpk8KEBLN1v6MYXOOJVywGMElxtl38ZhoOmJ+ua7C?=
 =?iso-8859-2?Q?2jnFA8G0uFrs3GNmzEJaHvoSwhempzIZiaIo8X3kJjilzcOeXUnde03S5j?=
 =?iso-8859-2?Q?1WPFyVLbAh8LXGbYrj8Zlqd/ZZZ32gvg4Wuiri1VfQ1M4Zyv2uAaNZ8u1O?=
 =?iso-8859-2?Q?2NrxE3i8duoSJQ3mRqkzoEQKN9dHcOWWmoUuPeIkb2xwrqOGH7hvK4gJ+f?=
 =?iso-8859-2?Q?2T1TE4ZxQvc22gUY1XwZHXDt9ZPyWdNc6Z46DfZcejg57eXkhW2trjvgwM?=
 =?iso-8859-2?Q?3aPg3DaQknxWy9+8D0Ito6/lp/ySLvqo0/JphOrAKeahTmBcWUj4i9Rb5B?=
 =?iso-8859-2?Q?rmqjw2j2uFm/Lmu8KwKX+zAwkWbR9LKpIQbrO1xaepP40Zo+j4LVHzPiuL?=
 =?iso-8859-2?Q?kakBxwdCjzRjiqxyIszQim5ynJ9GEpXgyuYCcfuuWy3VJE28Mdjehv5y2G?=
 =?iso-8859-2?Q?ddAxo3I22FLghCH49c2nwX2TevMmkhNWCbTN8qpEiwcxfLteEfzeYfrEbf?=
 =?iso-8859-2?Q?RiTk0PIMzFEzJNRdClV0BlJ1pQISFkUVCw2ouQZk/FjjgxIMUcBEJLFDbN?=
 =?iso-8859-2?Q?b+RWmw6ak3pL/XzdQtN/OmZheKMy8+nBM/VhGUjHkR00Ov6KmyZHxR1vEM?=
 =?iso-8859-2?Q?Ed4BYYV+3RSQyhNfhO8N7bpO3w58fEy5j9H8e8kwn2ycYqIQhv3ytfSnrc?=
 =?iso-8859-2?Q?r5z53Mrkr+Di6Lfb+cKlEAz86Dr4AEoYkg?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc79952-654f-4934-65be-08dd5faabcc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 08:08:27.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3mkHyDjeaRUS41r2drwNe0uliPIoPYVCy0wV2xLMnO5k1rDei00VTkxGVovLASv0BC58DOMSJ7G+++LauOAW7++MEpArJU7D9UKuLg2Uqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3798

> -----Original Message-----
> From: Song, Yoong Siang <yoong.siang.song@intel.com>
> Sent: Friday, March 7, 2025 3:21 PM
>=20
> On Friday, March 7, 2025 9:25 PM, Bouska, Zdenek
> <zdenek.bouska@siemens.com> wrote:
>=20
> [...]
>=20
> >> @@ -2996,7 +3035,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ri=
ng)
> >>  	ntu =3D ring->next_to_use;
> >>  	budget =3D igc_desc_unused(ring);
> >>
> >> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> >> +	/* Packets with launch time require one data descriptor and one cont=
ext
> >> +	 * descriptor. When the launch time falls into the next Qbv cycle, w=
e
> >> +	 * may need to insert an empty packet, which requires two more
> >> +	 * descriptors. Therefore, to be safe, we always ensure we have at l=
east
> >> +	 * 4 descriptors available.
> >> +	 */
> >> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >=3D 4) {
> >
> >I think that here is a bug: some frames could be missed if budget < 4.
> >I was able to reproduce it by sending 100000x 60 B frames with minimal I=
PG
> >(672 ns between starts of frames) on 1Gbit/s. Always 1026 frames were no=
t sent
> >and were missing a AF_XDP competition. Interesting was that then even wh=
en I
> >sent more
> >frames for hours it still was 1026 frames not sent and missing competiti=
on.
> >
> >Bug seems to be fixed when I change this line to:
> >
> >	while (budget >=3D 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
> >
> >Do you think this is a good fix?
> >
> >I think this bug is also in original code base, but I was only able to r=
eproduce
> >it with launch time.
> >
>=20
> Thank you for pointing out this issue and for providing a detailed
> explanation of your findings. I personally agree with your proposed fix
> that make sure there is enough budget in the driver, before go peek the x=
sk
> descriptor. Do you plan to submit bug fix patch to iwl-net?
>=20

Yes, I plan to submit bug fix patch.

Best regards,
Zdenek Bouska

--
Siemens, s.r.o
Foundational Technologies

