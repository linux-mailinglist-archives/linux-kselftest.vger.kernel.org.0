Return-Path: <linux-kselftest+bounces-28488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A37A568D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 14:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD6E16E3F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5788219A91;
	Fri,  7 Mar 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KSvPqt8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B082116FA;
	Fri,  7 Mar 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353924; cv=fail; b=LUHx1pRrJX2yTwCVrW1Y87twfF+oGzs5rLO2iF3JtcbcjRuPrG0WxcSeG2os+L3kq5kIUcpCNtv8bQlweQ+YfcOI4moGow+w65PRWI730hbaNRVvrrq8Sul2NpVYOuVRcFJLxxbRQZJ/IjcxBf0hUX9j0tSfGGlqWCotO54nrDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353924; c=relaxed/simple;
	bh=qaA/+W9KHh9evva7evxzLsgUq6YwNpABTw/Kg3MCEew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGQDJdDMcX6/ofDYn0sdoznjxdTejCyITB8FnN/r7WUURF7sz3B4emFXOfjC4iHmxPq9pkfwz9xeiZRIkvjw/v2QXIjwbHBdqywZMhbMqmI5Fx6VvLPUirAc4LWHfa3ECcid5QBGGDxq7YN+vv7mM4mbx8SvQFZmr9azTN7wVSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KSvPqt8J; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddtYiv6/h/lmMhnVU0z1qskgQcBZANF/5hIUTPHV1A5BNHQiFsSUQcm/JCMW94pkp89XhPCzgsyq9DPQBfFbXQgsJcUCTXS/zlIOytiBt+jJvl3vZuCSa5UApWhY4BhnvJFANJXaEjfwUwKktiKmky92WjZBzcUhbcIuAJnKMJ7i1kxFcrGIB0OKGZYftctKRTpZlq7Ofcti5+jQURf5jRSm451wPua5+ALV2CWYu8mL9msd/pywkP3CuTRBXTxCR7ij3MRYNSrkpJKIbCQiO7YB7p62lBJkZSWIpqgkdMLxwEqLHjJ2dX3xIpruZuBkNxrf/xIjWOzjAcCDLX0f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQN/r15dthGxH1FzVbudiAFQYtwY/Z8lyon8nwHWzqI=;
 b=H8CZuzoxPQajp41ln050AgBXwBEk37LHJygaYoU8pN72IuAUuPTsYi3+9o5dah9FrbS8WDXfDDhukhXQQLYpq/OOEJfboapK2C28ukBfOasTVqb1bcCut+DjkOVtybB4+ERy9lXhobyyunKOWzoCxZOmIpqZ7FVB9zp46NE5DkkrPPJDBFgHn6pFMGXKKdaWlyqXYy/yd21YBxy3VfKdOhvnlZkYjbxUeQU4ggk/4ey70vOva5HdLotda1K0/W67a4Okdjt2r+zn0zPnbJhA6RZH9OwRwcUnV0zdEtS6WuBgSoF97rIKef7Dt8om5l51WagFc4M9WB/wfrpttuwhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQN/r15dthGxH1FzVbudiAFQYtwY/Z8lyon8nwHWzqI=;
 b=KSvPqt8JzeqbjwdoQq91/u8SsOpPjY+HcqXHzDwlT3ahNVr33EI7JcmS36SdLIMConvYEdmC8wl4F6PFuxY2PxjQA0++XeougWwW2J3F+/6cO3hY88GrU2Uw+IJqyEpMhDhl5hxWbvc7Mbblmk1NuAYkJMG8pFnHAYcJVzV/u5NLM4HAjh6aEKbbsW+VN3jrhMHWTqNCvSNM2EsVilcymA3Sl5kJ0ZtJ1jmidT5ycomqDF1/+xaLvneAOcYZXfKhxUqRtalw86Ujgdi7O/UL/NCcgi2orMecEiQRHog8I0zR8w86Mb8kR6+7Mmzbf2WsNSzKzgvaS1hbxGBcYoueig==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by AM0PR10MB3537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 13:25:17 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f25:24f8:9a0e:3430]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f25:24f8:9a0e:3430%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:25:17 +0000
From: "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Joe Damato
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
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
Thread-Index: AQHbgFYjDDsvmh2P3kix+y3ANQFC5rNnwgkg
Date: Fri, 7 Mar 2025 13:25:17 +0000
Message-ID:
 <AS1PR10MB5675D13A436CB20FFE5E1082EBD52@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <20250216093430.957880-1-yoong.siang.song@intel.com>
 <20250216093430.957880-6-yoong.siang.song@intel.com>
In-Reply-To: <20250216093430.957880-6-yoong.siang.song@intel.com>
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
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|AM0PR10MB3537:EE_
x-ms-office365-filtering-correlation-id: 11cb110c-981e-48c3-fad9-08dd5d7b807c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?KS/5xw6dMbdf7p54A2GoKqkx52Hc9JbkzMcQ80iy6dvqlcMeR9siYXkP3p?=
 =?iso-8859-2?Q?qq7v08N3UG/ZGMLQSAaMZFLyer2y+2TkYnj0rWCPEVSZydvVu4LsBeFi9f?=
 =?iso-8859-2?Q?Ku9B66I67uM6pXF94wLSIMhYvlIKMXSwgX2afSF9ehmYfuV1M3ImV3tFt5?=
 =?iso-8859-2?Q?r7NUnkts8aVnZtbZG6suml2x7w/1/yZmFiV8fAjq/68IHdmDT1odABHxUY?=
 =?iso-8859-2?Q?cUQ4NBBF7iMFmxGY/0s0oDu7pIYvyNaEuiJsdoyWkMGeZlu/nG/F1aye0i?=
 =?iso-8859-2?Q?oxrdYZhjAKb1uLi/NF1F4qgjiEFTA8Z6UuO+7U8rDkmM+m7GXp0AeDafFl?=
 =?iso-8859-2?Q?S8zPUjwt5n4d8zr7WktmOvlg9iss+r37b/z/ZLW66+0M018//BKArayPlv?=
 =?iso-8859-2?Q?WRHQH4bUsSUO4dVhcaDpEd3/968O0A0+PtLZAbh8HWKmxAtcfH5P4QtZGA?=
 =?iso-8859-2?Q?ustjIBCqDv/A7k4KkA9MlOEZ2IR0C2j7OmEVuPjU6mkngjnL8ZljcJP8k8?=
 =?iso-8859-2?Q?arCvQbigoKlqmu0+ZSYJ6B5oMKav1yUyXSWX0K1pmKg9oN8ZZ6bp7WiOHi?=
 =?iso-8859-2?Q?ADaUtXjLkUWr+bWyCK8yrTB3z6i+vOehlV6p6oRNkPmd9PmxUoFgQX/km2?=
 =?iso-8859-2?Q?pyt+m/Emmb8LQpoS5d38y9Wk03yJ6gt27a7W/GqL1w/VGsWYHaBvqyNGoy?=
 =?iso-8859-2?Q?U24jXAoIBRGksNKYDqQv/xdCwwGe1wcpHaXFhEn5azL3ZI5MRotyqtn+dA?=
 =?iso-8859-2?Q?CwlglD3YRpFNmr3wycLoK+3cHdaLMsgZCg0Qbq2+0QLBgdWh4i2UCAIoOw?=
 =?iso-8859-2?Q?Zfqh0vRLsVE59neSjsPhuQ4gX/NOdnvtFtiDDjItL813fVRiCNw2LiUR9Q?=
 =?iso-8859-2?Q?AhXSLy74lfoM5BKP/HUJezb+fCejqPpRzHCVBNyO2Ur+itT/pgXFS2X3aF?=
 =?iso-8859-2?Q?wZ821RBE9GhAIZ7O0x6Ir6zDp3vyx356MaQGJN0e6iPt8MAEqawCWnFfgV?=
 =?iso-8859-2?Q?qQ5c0Detvrvk5nhfz2XjVWYbctE00pg8sws3N/YIq/tjOD5UemDdQ0eCUb?=
 =?iso-8859-2?Q?P9inma4YwcM5dXU/MzXmGf97QkXrVFCXzgoU/svyeywqkqQT7sMGEr3Yrt?=
 =?iso-8859-2?Q?yyLSpyCnryg2GoBZRmXCdKEgSZA2qEz/t2xMW/s6xcY4pvmU8+MAQVeBFM?=
 =?iso-8859-2?Q?aEFeX6tT4ewmeh06QuoXg9UdodTytwgOLU52poIvBfJ6usxATkgm3KgU/Z?=
 =?iso-8859-2?Q?p1GfUBNd6Y8b7PRi+bNKd3Qugy48La6Pn/xGEaNWubTmdKcQB4QEcFHWoO?=
 =?iso-8859-2?Q?Y9+qBuwOtiFln1M5YaTIGZXJJjEE6X8SBSAVxKGiSQKyGwz22IPzyD4fWH?=
 =?iso-8859-2?Q?kESNANb7ubla5qxbIdB8wvH5UJ7aisvUd0zaMN36p5L7+CpJO/ci3sm3fT?=
 =?iso-8859-2?Q?FqVmDu6k4DgBL4eKRETrbNUep4uiWH3jaXB38QmizgDJyrhFs3Fgjlej8d?=
 =?iso-8859-2?Q?ii5DKvY4qja/GeyAtu/Uk9I9Sv+6bpUpwUjn01BD/R3Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?lZcX9HN8HYH52De5PGk6RlCmWgRLKN4pQLnI5njNsy9Nt9KWrnkfTk2wrN?=
 =?iso-8859-2?Q?AeWCMuGidUzxCPUaIbRditzj4Mvue5vmB/kcoWAWQ6mFsmBBYLis5eLQkJ?=
 =?iso-8859-2?Q?6SYylidB32LxEzazjGXrujVNhcQCiJ/WsQO/2Tbk7AGMDD+rSI+o6o4L5Q?=
 =?iso-8859-2?Q?uOIHDKVLT79kHrH6oDyOGgtMINAEK3IlBgj+FR7k0SA+E43zHqbjYBE3MG?=
 =?iso-8859-2?Q?MQgE9Fm5p2aJXbKmxV46RPvBktKarGmbTSRRrijQN7CcPXZrsi6Z1frbtu?=
 =?iso-8859-2?Q?7d5mCYM717+xp8+KSugkXJYYuQoAbuwH05Hn2e61aGH7qIzvntdWADxCWm?=
 =?iso-8859-2?Q?b95QgAL7m7ie7IUoD4dt1tnxqaZrsHQb1xWkxKtaH0Wkwt3u2Eu+WRjOwg?=
 =?iso-8859-2?Q?4HFgFzSQoKxdqur/ZqXiy/9DjZogvhoKX4FYkrXDYXYeytnwfW4EcsfjOt?=
 =?iso-8859-2?Q?D1EzvvvIMnGfWG+qHO1CQ9fis1wOYf9DLfXBXuhpBZhbK1P9a80JjS84NN?=
 =?iso-8859-2?Q?DwIDXzNsnbprT79x5aMCOfAj+aAjouppyAVohrZ2orXNYPzcbvi5lv4cbd?=
 =?iso-8859-2?Q?Cj0YEjnLXtScuDffLsrsplgnYMjViYlWBG0jVY13sFPsVV9Emu8/f2/gDC?=
 =?iso-8859-2?Q?TxGwhmzxiJfzCnoKBq8AT1F18dPuqwwyuFTlW929jbo/Lk9RPuoy/Ww1yD?=
 =?iso-8859-2?Q?bbxQUwhC6pqFNwclljoTIPySMhOckeXzJ4mKxAoPCABgRdL3B1OaiMeESP?=
 =?iso-8859-2?Q?XHHUMgUHa343FqL58/09oH77m5zh3H9de2fpa3AhoVkB8VhpTu5b6+Rhn6?=
 =?iso-8859-2?Q?VEdVB4sbECHKIBcr03XNKs+VgdaoG6BjfmrB8kV9mn/4RV+ZVCT5lvIdkW?=
 =?iso-8859-2?Q?P3BhcrIVGhUlziqqxQi1DdVYlWcj7d5imB/u/I/uKRrpUoiHZZfSCU51/7?=
 =?iso-8859-2?Q?ipXe1gz6Sf9rMlrRFtpaBMR16t6cMvpo7sRt1f39T6x0BDUY5xTXV1OW4v?=
 =?iso-8859-2?Q?IIagMAzvNgVaWYXFDoK2y0t65MTkKQ4t6KTyfd9dz3BHq2fn3zwNk96+ZK?=
 =?iso-8859-2?Q?BHs4j/gg8G1/ktUAua4WQAFYdv/oVpCrwGPwkFvfF4sMwR0FCfF73zYH+0?=
 =?iso-8859-2?Q?tr7bS5qMlgr53LLhdLIBWZOKMeScHlBblNgbScn4NB1B6KTepC1rWppV/M?=
 =?iso-8859-2?Q?8aM6V6dohQ+yKPVmQjBtwHXlXKpa9HfmdAs7kxuWUz+nXDp0jP/maJdJ+8?=
 =?iso-8859-2?Q?oM4XAJr9GvJ70R6SijPrNdSlogscjprxMw5jSncoM2d/2Do661y6f3R4ki?=
 =?iso-8859-2?Q?NtXegiQBzvD7bQ2XD/q381y+oeRcu+/QdmCfb978q3CdR/eFR/YDP5o2w5?=
 =?iso-8859-2?Q?RSWygovtCjZAngOBZiHg5Yz6UiKn4Xp+696OOxKkXs9K1FWi3ueL1o0zia?=
 =?iso-8859-2?Q?rELxIPatuxlQatRTUE7ZA/3TcjeG8X9VwUq18nGmPLO/BATh3cW+xLyIIG?=
 =?iso-8859-2?Q?Wf8jx4O8kowtkFlXByNF8Af95VoMTz+WI2zFwmjgTwsxgBFrpRa07wu9J+?=
 =?iso-8859-2?Q?WYQoFchFYwpC9NOPFEkz1y3dLsqTNLKu+Jx+FOCdN2RISGag0XgPGAsdqE?=
 =?iso-8859-2?Q?yPerr5lV2v0hBmSTyMoIJyMhsMUouPOox2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb110c-981e-48c3-fad9-08dd5d7b807c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 13:25:17.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gZzK1dMVlKDnV6ECaMZC7lxPUAc+2TqTOPS0W+sJCqwV9375Ufm1Yg9Lsye3gn0HO/A4yNkG9KKhuRSnzG9x+ggZ9PW+2J35AIpKJCd9L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3537

> -----Original Message-----
> From: Song Yoong Siang <yoong.siang.song@intel.com>
>=20
> Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
> metadata framework.
>=20
> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metada=
ta
> on Intel I225-LM Ethernet controller. Below are the test steps and result=
.
>=20
> Test 1: Send a single packet with the launch time set to 1 s in the futur=
e.
>=20
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
>=20
> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 90=
91
>    of the DUT.
>=20
> Result:
> When the launch time is set to 1 s in the future, the delta between the
> launch time and the transmit hardware timestamp is 0.016 us, as shown in
> printout of the xdp_hw_metadata application below.
>   0x562ff5dc8880: rx_desc[4]->addr=3D84110 addr=3D84110 comp_addr=3D84110=
 EoP
>   rx_hash: 0xE343384 with RSS type:0x1
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to User RX-time sec:0.0002 (183.103 usec)
>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>                  delta to User RX-time sec:0.0001 (80.309 usec)
>   No rx_vlan_tci or rx_vlan_proto, err=3D-95
>   0x562ff5dc8880: ping-pong with csum=3D561c (want c7dd)
>                   csum_start=3D34 csum_offset=3D6
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>   0x562ff5dc8880: complete tx idx=3D4 addr=3D4018
>   HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
>                     delta to HW TX-complete-time sec:0.0000 (0.016 usec)
>   HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
>                          delta to User TX-complete-time sec:0.0000
>                          (32.546 usec)
>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>                  delta to User TX-complete-time sec:0.9999
>                  (999929.768 usec)
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to HW TX-complete-time sec:1.0000 (1000000.016 usec=
)
>   0x562ff5dc8880: complete rx idx=3D132 addr=3D84110
>=20
> Test 2: Send 1000 packets with a 10 ms interval and the launch time set t=
o
>         500 us in the future.
>=20
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
>      /dev/shm/result.log
>=20
> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
>    VLAN priority 1 to port 9091 of the DUT.
>=20
> Result:
> When the launch time is set to 500 us in the future, the average delta
> between the launch time and the transmit hardware timestamp is 0.016 us,
> as shown in the analysis of /dev/shm/result.log below. The XDP launch tim=
e
> works correctly in sending 1000 packets continuously.
>   Min delta: 0.005 us
>   Avr delta: 0.016 us
>   Max delta: 0.031 us
>   Total packets forwarded: 1000
>=20
> Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 61 ++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/=
intel/igc/igc.h
> index b8111ad9a9a8..cd1d7b6c1782 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -579,6 +579,7 @@ struct igc_metadata_request {
>  	struct xsk_tx_metadata *meta;
>  	struct igc_ring *tx_ring;
>  	u32 cmd_type;
> +	u16 used_desc;
>  };
>=20
>  struct igc_q_vector {
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1bfa71545e37..3044392e8ded 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2971,9 +2971,48 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
>  	return *(u64 *)_priv;
>  }
>=20
> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
> +{
> +	struct igc_metadata_request *meta_req =3D _priv;
> +	struct igc_ring *tx_ring =3D meta_req->tx_ring;
> +	__le32 launch_time_offset;
> +	bool insert_empty =3D false;
> +	bool first_flag =3D false;
> +	u16 used_desc =3D 0;
> +
> +	if (!tx_ring->launchtime_enable)
> +		return;
> +
> +	launch_time_offset =3D igc_tx_launchtime(tx_ring,
> +					       ns_to_ktime(launch_time),
> +					       &first_flag, &insert_empty);
> +	if (insert_empty) {
> +		/* Disregard the launch time request if the required empty frame
> +		 * fails to be inserted.
> +		 */
> +		if (igc_insert_empty_frame(tx_ring))
> +			return;
> +
> +		meta_req->tx_buffer =3D
> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +		/* Inserting an empty packet requires two descriptors:
> +		 * one data descriptor and one context descriptor.
> +		 */
> +		used_desc +=3D 2;
> +	}
> +
> +	/* Use one context descriptor to specify launch time and first flag. */
> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> +	used_desc +=3D 1;
> +
> +	/* Update the number of used descriptors in this request */
> +	meta_req->used_desc +=3D used_desc;
> +}
> +
>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops =3D {
>  	.tmo_request_timestamp		=3D igc_xsk_request_timestamp,
>  	.tmo_fill_timestamp		=3D igc_xsk_fill_timestamp,
> +	.tmo_request_launch_time	=3D igc_xsk_request_launch_time,
>  };
>=20
>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
> @@ -2996,7 +3035,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	ntu =3D ring->next_to_use;
>  	budget =3D igc_desc_unused(ring);
>=20
> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> +	/* Packets with launch time require one data descriptor and one context
> +	 * descriptor. When the launch time falls into the next Qbv cycle, we
> +	 * may need to insert an empty packet, which requires two more
> +	 * descriptors. Therefore, to be safe, we always ensure we have at leas=
t
> +	 * 4 descriptors available.
> +	 */
> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >=3D 4) {

I think that here is a bug: some frames could be missed if budget < 4.
I was able to reproduce it by sending 100000x 60 B frames with minimal IPG
(672 ns between starts of frames) on 1Gbit/s. Always 1026 frames were not s=
ent
and were missing a AF_XDP competition. Interesting was that then even when =
I sent more
frames for hours it still was 1026 frames not sent and missing competition.

Bug seems to be fixed when I change this line to:

	while (budget >=3D 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {

Do you think this is a good fix?

I think this bug is also in original code base, but I was only able to repr=
oduce
it with launch time.

>  		struct igc_metadata_request meta_req;
>  		struct xsk_tx_metadata *meta =3D NULL;
>  		struct igc_tx_buffer *bi;
> @@ -3017,9 +3062,19 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		meta_req.tx_ring =3D ring;
>  		meta_req.tx_buffer =3D bi;
>  		meta_req.meta =3D meta;
> +		meta_req.used_desc =3D 0;
>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>  					&meta_req);
>=20
> +		/* xsk_tx_metadata_request() may have updated next_to_use */
> +		ntu =3D ring->next_to_use;
> +
> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
> +		bi =3D meta_req.tx_buffer;
> +
> +		/* xsk_tx_metadata_request() may use a few descriptors */
> +		budget -=3D meta_req.used_desc;
> +
>  		tx_desc =3D IGC_TX_DESC(ring, ntu);
>  		tx_desc->read.cmd_type_len =3D cpu_to_le32(meta_req.cmd_type);
>  		tx_desc->read.olinfo_status =3D cpu_to_le32(olinfo_status);
> @@ -3037,9 +3092,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		ntu++;
>  		if (ntu =3D=3D ring->count)
>  			ntu =3D 0;
> +
> +		ring->next_to_use =3D ntu;
> +		budget--;
>  	}
>=20
> -	ring->next_to_use =3D ntu;
>  	if (tx_desc) {
>  		igc_flush_tx_descriptors(ring);
>  		xsk_tx_release(pool);
> --
> 2.34.1

Best regards,
Zdenek Bouska

--
Siemens, s.r.o
Foundational Technologies

