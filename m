Return-Path: <linux-kselftest+bounces-21122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8948F9B663C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4921C209CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1E1F4727;
	Wed, 30 Oct 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FUD5SGOR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FUD5SGOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52551E7C12;
	Wed, 30 Oct 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299326; cv=fail; b=c6yocrABHCuRswmwPu76ip6NvIxHf+pUwQFY8UH3J2fQSOF4pI3nxCoFX9o6QKLuj1gNKk8Ts3rH5iilf0qfi1KynRxEdvrhGgI5/a+Sz9xjxbRquTc6FSckp84qGh0YyWviviSFFArFso7QjlFowiXP0+7yjjl1klgugOgAIlc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299326; c=relaxed/simple;
	bh=iZEnt8HxjXDouIGHeV46n1XPh34w3ITmR1rtH4qPgu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4zpj3qPmr47OwBClyACftXqK8ovqAiT834Kfufcw+2plc9jn3VU+di7Bv97kFbgjubSjozJPUQffSdBc2BI19JI5SsLBLwbWHSifu9XDMaa/BkZ5hJsqzd/eBKI99FuHHiuffcDcKyuO/ygqLhpDJJNiGFkkAFe0nXk8Se/rLI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FUD5SGOR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FUD5SGOR; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TKSpYOOlAB2K3O+XzlMeaq9yVH7t2WZpzeu1NY790KNce8v2h7gpYu+Mt6nyBOLnHLtk2ZsJirCJ8r0aE4mhCJY+s24gY1s4rPPBbv4qHvq+wTeL7QV9PoLWJd/Zy0LJ4tK0NJwrp791ngSF1MYLdCgYs+eYzdzv4NpOFMT+/C/Gw52kDfbczfaqHHLezYJjLbofLx7s1kjNm8Xh9am0LVMKk0vuxvyVH2y7unbLH6eSZjLqMVdshsfdgtZeyMazljhKIyqoOZJmcnXybm48tksrH+DhIzJE3OydJh7vIRho/vajskdyGSaJj9KVWUbsLKFPvrJY3XWphW/ejUqBqg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOoeFSRMmvV/bLyUqkFGmW+yr8sINZZ5RmHKf0w/VUY=;
 b=hAPpbt2V36cr2GtMuEvd/ZXrQtdqGCBEuAXFASz6qi9zXiO2ghMh/wNSUk/U8mjlLiKOXcREHyKjfCdRR68W79KhaE31zi2m0nU2KjNuzZNFV8MvNhtzznqGOT0E6P4sMsTMp0mOeZlKaYfqXfEqDuUWRgp+lpa+T7CU3a9EuAUbFm3ALyjkN362p+236Hs2uoR19qFRonZfZGxQr2PCadOQf2HgN7TyYfvi2W2hzIjvYhj70DkGHa8VmWRE5l1wZTpDd+60HEdGCMgKqWkjYMIQNESKOVQIrJ+MhZUm576CT8wBn02I1TeqP9lwovzV1VRwlN8ALgjNjY4CTkPfyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOoeFSRMmvV/bLyUqkFGmW+yr8sINZZ5RmHKf0w/VUY=;
 b=FUD5SGORTDkETi/QBQ7QIPlmYtSWL5li+BFgpLN1DR16ts2u1BHACmFpvy2S6+4IVdEEiPwivYau88vXWsLik6fmnLFscF3wkniETfHE8JTni/416RXyITLRHHt/Ob1d4TRT5LYqNIdtaSxXZQ0ZZ0uhWNNAY1xp0vZHc3TuWYw=
Received: from AM6P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::30)
 by GV1PR08MB7779.eurprd08.prod.outlook.com (2603:10a6:150:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 14:41:55 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:209:83:cafe::1c) by AM6P192CA0017.outlook.office365.com
 (2603:10a6:209:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 14:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Wed, 30 Oct 2024 14:41:54 +0000
Received: ("Tessian outbound 373849c2df5a:v490"); Wed, 30 Oct 2024 14:41:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ef26de1dba8d737e
X-TessianGatewayMetadata: tDP04WpmrMRGBpcHCJfOgHahJGhQoxuEBhngoeWTOJ1RWqx+kP7lLOE48SxfDt0QDhBwMWPznhNI9Gv57v2iQaLyXH/raykyRwyViWjXL4w/QGXQHiih8N9XF8JGuCLXXoFhlBi1vq7CODY0jZ7V4g==
X-CR-MTA-TID: 64aa7808
Received: from L501b5dd3a0fa.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C70D1A51-A05C-4EED-B237-74650FA6D698.1;
	Wed, 30 Oct 2024 14:41:46 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L501b5dd3a0fa.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 30 Oct 2024 14:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+mQMuHC82U09CHW+hbBk6A9puRO9IQvQRczZi9XQ+FPS9I0g7KEV16jfrS0NlSxE8wtZyHi7SgpnkFe7dnmPWTk7XSJxqLxkl4p8j/fS1HEVUz2s575IUi7Uw5f5jH6lind/Sl2BDRMKUFTbBK8qm6hIKAxcgPRfgPhUgaFhqoJ+HoM98oJJK5++kQ2CD0QuTleMRN6K23sAD+sjyEYeG+QkJRSb8fOQSRjZhXoL8mK39UOd0laLjuXehBbktsbhbFtvDfkPiubFDQIwhU7+jrK+bcEl35OM3D6mYRv7l2u4EVC+7CmuteS23bbcjpAYN/NMja91nAux3RYiLjMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOoeFSRMmvV/bLyUqkFGmW+yr8sINZZ5RmHKf0w/VUY=;
 b=lO3hF90w0vsd8LSEZdokVAHXqe2MmOLw5EXpG9AqdxgWsvMMxSvwlEY1k5PKnVGIJWzGjb/e0KFhgV6o5P3/UY02NeUt0FHG91ITNkM4F5mDz64u4oPAmRRdYJrSZa4putZEFUZBJrvmrd5IAiRI2Uc3MeP2HJiYxuAfHb+UJ9cp6CgJjSMgKAue9u6yYsspGkRgT5WAo75cEbjVxbVG0ZhkVZ247oxT4sbSsLP2GILtiXgmXa4M6Y3aeJsOpdIs/YbGiJzd6W9u5UL0z+lC6KyGrRA7WVpJOITxVCIyA9d9XhGMePkST2WVxDrV7TOBcnaX8sebx3SxD/Qd1YmRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOoeFSRMmvV/bLyUqkFGmW+yr8sINZZ5RmHKf0w/VUY=;
 b=FUD5SGORTDkETi/QBQ7QIPlmYtSWL5li+BFgpLN1DR16ts2u1BHACmFpvy2S6+4IVdEEiPwivYau88vXWsLik6fmnLFscF3wkniETfHE8JTni/416RXyITLRHHt/Ob1d4TRT5LYqNIdtaSxXZQ0ZZ0uhWNNAY1xp0vZHc3TuWYw=
Received: from AS8PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:20b:312::33)
 by AM9PR08MB6130.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 14:41:43 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:312:cafe::19) by AS8PR04CA0058.outlook.office365.com
 (2603:10a6:20b:312::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Wed, 30 Oct 2024 14:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 14:41:43 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 14:41:04 +0000
Received: from arm.com (10.1.35.33) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 14:41:03 +0000
Date: Wed, 30 Oct 2024 14:41:02 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
	<debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu"
	<hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <jannh@google.com>, Wilco Dijkstra
	<wilco.dijkstra@arm.com>, <linux-kselftest@vger.kernel.org>,
	<linux-api@vger.kernel.org>, Kees Cook <kees@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v11 0/8] fork: Support shadow stacks in clone3()
Message-ID: <ZyJFfngdWBXidczc@arm.com>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
 <9843cdfb-6cc6-40b1-94b3-768c48351945@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9843cdfb-6cc6-40b1-94b3-768c48351945@sirena.org.uk>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM2PEPF0001C711:EE_|AM9PR08MB6130:EE_|AM2PEPF0001C70E:EE_|GV1PR08MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6a908f-355d-49be-a175-08dcf8f0ffc8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?qTwLu1Kh36K1SuLQ3J2uI6yZd3LVvyBp/nTJmuz71P0XtxiYxy96xmTPFR3G?=
 =?us-ascii?Q?oNWIRKgPrb90zcb5c06CRnIT7GUE5LWkft3IRJwAgt21/CWK/ww+szu4QoMo?=
 =?us-ascii?Q?TpDITheLLU73QtJvxrGuRqrVmdAbUhCywF8EtNHmsRmv7siQMi/0owlp8wrk?=
 =?us-ascii?Q?O3kwDxfEexvQTba0f3EiAahOLru5DBgbQ7x5R53t8PEnv0RC3zYz8l66MOPr?=
 =?us-ascii?Q?ug9CRgNPfe6BTIYCPSnO7cVtO9qudFlx7UV7tegGPth6vN1kbMtpCDz5NuDu?=
 =?us-ascii?Q?+rnnOAGRsLylo6boMRwsxynu/ANZ5Tsqa2OgFQaNgR9/jrI2/Wjo/jdxS9sM?=
 =?us-ascii?Q?zSJfvB2gW7JjijGzJwcttTtz7ySSd1MP4/Ra/ea++vDcdlxmVF1dyku067jM?=
 =?us-ascii?Q?iigOZoMaIuI221+Ytae/bU2VLu+Bk9PZvIzhHtmo43ydq5Rp5hh5pQ3TwuLG?=
 =?us-ascii?Q?cGfh/qnsia2x1Kv8WA2vzTWVorP3M6UyPncJkpzd+RvEY5n+o16wGNPFUuzq?=
 =?us-ascii?Q?DOT9VBX27An52MNb3PYn/SfGAm+HL694NwQjgDHEHpLrZgTLhzAG+TD/6sif?=
 =?us-ascii?Q?VmYQZ0LYFK6sr192KxNUs6Mr9pQ6iylAAfKg/mMrserZlQsQVz3HZXO9vsiS?=
 =?us-ascii?Q?z4Auqt0MCSKsRYst7Alqa7+RM1qDtIkWNKFgVgqHZ1TUcSSm/ezeUOLk12oS?=
 =?us-ascii?Q?vHusCH9IlulaX1ni4XBNHYFi3LnPXHvO1iZyfOzoH3JQJ1kvUUJjEpvqG2Ii?=
 =?us-ascii?Q?6vhDxq/jsrDzjxm1voJCQJO3GxkCTwg2CW3s5gLLfg9mnad8IExdCSv7jV2N?=
 =?us-ascii?Q?+cep4SZwKXH3yV/UI0i0VzZucb67pnyF89PhE9lK/yWESvztU+OvvmiZYxsK?=
 =?us-ascii?Q?Tkz9woVq42NbTiA1K8zEp5v9htNrn3+NXfBXGCyzxCjBhxAu6zFDls5v2kCY?=
 =?us-ascii?Q?eLLyIzaN8ZOBBodhCrEboJY1sHvrggky+BRpmlSfxnBLptxnICX74nMMQiT+?=
 =?us-ascii?Q?MZDquXEkylup/QjU8WbM7Pt+AkifU7po4lz0GhCU2WAoxSoVvAAw8vOS3tyX?=
 =?us-ascii?Q?C15tw6nSRzOe0VlFRMTvqn07KLiWTMhF1D5sKpas7yYFd9qGiBVUjx+V7y5j?=
 =?us-ascii?Q?BZIBpTNYJNntKzTxzcEEruVKX/AXXR3RQ7hrJfs3mvX4VmnbxO6ilmBJig2e?=
 =?us-ascii?Q?tYf7iIBDv7I2cH5fTcKEeDGJAWIssUCklPGhXsO9hTAqLdkYwtltebPTW2H5?=
 =?us-ascii?Q?XIAS1sXo1qYYKu5/bhSKrHM4/GNO3mYdtscCskTgfbzP4yfaGHFozLswt/ID?=
 =?us-ascii?Q?oOpxs1mQ5GLZc/PkWYgVIhK1hq5wHiFgZm2V8YUSVwagnL1s23BTzA6wvGWW?=
 =?us-ascii?Q?LFbhN1kPT7xgfD55mvYS2/sLChflNPm5Ieg7Db4L/cbQ2mPjgw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6130
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:312::33];domain=AS8PR04CA0058.eurprd04.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	16c54dd8-69d9-4663-fd15-08dcf8f0f8df
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kz4Y51/iWqpBfdkSQ1fj3n5Q94KLWFShTz00HjwopfICSgDX+vlp/iEHuC87?=
 =?us-ascii?Q?6zFzhjKhPe1hetmN1AZOi4NOiuwsEKUmm6BOXb8E6WClb/NbjcGmZQcgTAF3?=
 =?us-ascii?Q?v03mSdCP+7WSrz091/HckrBoeMuFV90u/UjpCK4imdGNLmc3LJHn3yCYDckW?=
 =?us-ascii?Q?kOuxKHWhywhR1xqB9/texoggMeJnyeM/GUXoRTbc8nwAeVHDpUjl63/pWE/7?=
 =?us-ascii?Q?FACmykq8b9RCjMCUs+nFTDsd6+TbLkV1lRKC0eu+SNIa+ldwZj6N9QLgSj9W?=
 =?us-ascii?Q?aXLqDFN7xS3PDXMllI0ARSqs+OuUIXx1oaIoBlmjS1Ps/UsiPYaIdy7xpL1K?=
 =?us-ascii?Q?rHGvoJpPMjriBJ4nFDc3a9i7HHoLNw5PAXv1obJ80lPv8wVM9qR4T/tfXTyi?=
 =?us-ascii?Q?XZsYPQS5Z2kTrOCYo+yM22jkC3vi2Qt4V2jS1dGL1Dwwmh7enPcvomnlY7R4?=
 =?us-ascii?Q?Lxu3XroDfdwM0wlZt5OyVaz5AJzDwMl6s00VdpiKKB3OEkEElP4xigMtBjNz?=
 =?us-ascii?Q?csojcw+4H4GeA4ioMJJn2ff3SY2y4pPAge4TmETF3FNrgaRBHNr9lVbPJhmI?=
 =?us-ascii?Q?lXweyh0QAsr6jCQRKGT6RVJQ/j3SMEH0raLStiJd7IinGI4kgNy6/OQ9aCw1?=
 =?us-ascii?Q?85jiepuENFpP0lvIEdrfDHYwDa0bB9LU5YcgNt3mrMOgPEjj1e1M104qQcc3?=
 =?us-ascii?Q?Io8C0AMuoqnOyAltgw0a6B+EnhvAxB0OzG2abC/KJCf0IpoutQ/rhbk5RHRo?=
 =?us-ascii?Q?q51lKE5PNrAzOHo218m5HdZ60xwqElElOV+k1h7abqGKC96HX72344Oy/Wle?=
 =?us-ascii?Q?Uz0nyvQGuKdskVDHT1q2O67KO+BEu7oH2b+dDgDDUrT2/ZiN8gQqnNBjsHHq?=
 =?us-ascii?Q?HH2WtErorPjVn7DpnAbc4XsPc0NgN3w4fGIefXwvIZCPxCOGlfk8o/WVfA3E?=
 =?us-ascii?Q?TrlQ8IXnkeSr8GcpCQI0hzgtTLkF+D4Ig25WIUCKf+m50rIHIjUStkFJq49o?=
 =?us-ascii?Q?/IDhQXtTjHiIqEZXPF9PjEs2V6Zjn5YO6IHVZBBnmxuSp9lVI1GP7kgjE6T3?=
 =?us-ascii?Q?lnpJDMg6RL5H/v00EitOfMc62/ABzBNWog12esQvzdxVqRLE9sTdnKFp9Y9B?=
 =?us-ascii?Q?8LNd5zXqNqYHqPbpx0AuVpHY9wido5K90wAQzphm/aSmO2vt93IixUK/gpUF?=
 =?us-ascii?Q?GZ1PNo77rueMj67Mw6zp0iOWau8Uka1E58AIAxjlBSQLBZfdcp3zezolA+6o?=
 =?us-ascii?Q?8GrI2diy+fUGNH1dp/xG4MMYONUklxMpl7OAcLYsSUusiCjdSnArNQYxksQZ?=
 =?us-ascii?Q?AlQvsjCXv0PRsprSutD7DACyh1ZTRIdBhy+7qpRUAqFiqOyUUPV5+DbgyOJJ?=
 =?us-ascii?Q?wnfF1vbqkB5PYlmHmQjER0UWYoLOSokjpO+KEFkX1tsAwfd6Iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:41:54.6164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a908f-355d-49be-a175-08dcf8f0ffc8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7779

On Wed, Oct 30, 2024 at 02:08:59PM +0000, Mark Brown wrote:
> On Sat, Oct 05, 2024 at 11:31:27AM +0100, Mark Brown wrote:
> > The kernel has recently added support for shadow stacks, currently
> > x86 only using their CET feature but both arm64 and RISC-V have
> > equivalent features (GCS and Zicfiss respectively), I am actively
> > working on GCS[1].  With shadow stacks the hardware maintains an
> > additional stack containing only the return addresses for branch
> > instructions which is not generally writeable by userspace and ensures
> > that any returns are to the recorded addresses.  This provides some
> > protection against ROP attacks and making it easier to collect call
> > stacks.  These shadow stacks are allocated in the address space of the
> > userspace process.
> 
> Does anyone have any thoughts on this?  I reworked things to specify the
> address for the shadow stack pointer rather than the extent of the stack
> as Rick and Yuri suggested, otherwise the only change from the prior
> version was rebasing onto the arm64 GCS support since that's queued in
> -next.  I think the only substantial question is picking the ABI for
> specifying the shadow stack.

I will need more time to review this as both my primary and shadow stacks
are full with other work. At a glance, I cannot offer any informed opinion
for choosing ABI atm. Apologies for the delay.

Kind regards,
Yury


