Return-Path: <linux-kselftest+bounces-18971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484698F386
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2581F21447
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769C1A4F25;
	Thu,  3 Oct 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P5e+9sxV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P5e+9sxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D119C56A;
	Thu,  3 Oct 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971546; cv=fail; b=R6yf5ATfiCUr/V5Izc1wzH3MJGrurRAk8+a/8KXfzR+q85DDm12U2DwsiMRoyJNyqyIGnUmb5SypMfqR69MAadn9nA7H5HcRxpIuvsHpEdR1w28AJOGC1nZlvwzMg5QKv4sdHYvSkZ2rXkEQllIS9OQ9IjsoPflwp8I+qXoHE1g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971546; c=relaxed/simple;
	bh=DRHbuFs3koOnRbIn9LqHdCVf1inew5RD+C2N8FXkzbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ/QW+Y/FJh6a4/6cg4CEPm1dyJcC/66iK9NP3wpqd/C0KOWDrjkuXAWMMmNZSo/o+0UOOEulYVVKrOP87ng6UyEiEYkRQ9FeU5FkW2QG9Rl0zMrQb72JU5QZ0A6/Um3+PFf6zx7wcm9tHLQuMDc84MD/1n3u0G8JJmPfLV1Ejs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P5e+9sxV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P5e+9sxV; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=x6wbi6dFWj/piSslxnXvF0wcLqzO20oyLsmqanp7Cp+Q8Hm/PMwqBkNGfhjN7fpqzOAxGuukkph1Lq1UUMQmtiYRrtxjFCODmNwpRVME3ibdTcAY3k0K+j03tKjRQU++cQsGJmX/LCW1zvgQTc20y8HBJstt93r5AlNrjiSMHQAh3m189THATNEQeUdfxKKsVsOFGOccQwETKCrDyWYGbBgwHXXuSgerqWe4k3mA7MIHwazb8dcvxHe0U/Q1t2QdMe5eENxoc84EGfOXHAzQchmtgvsiacrAr3RfrOueNSrv1jQnSL5F1WMXm01xIMI0HjpLK9K+rGnaKEv5ZfPJng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m2f8PL/AP+NmwCf525MNtH3nk9m0PWr/ZKF7SNvxpI=;
 b=kat3tYyNji62pD9Q4bcybQ1XtngnCLihQXTsfDFzMqsbKGKxHcpEWilUx/WYBzffk4+g3IkqtYrnTHAZ/mmN0bXrScuFi5AiemOqYZG0SL5I8dBEJK/bT8CF6sv8tw12Ha226ItP6oCnH3dW8fIvrkAiUj/th70d2DE00ZIAwaA0FrcdYNW3JmkcmH2jQVnExnzBvQlDgTgJgH6Uf+dXfQZbHKHQXPYzRI2cuNllgKNBo5teyhXT6YNzLYVjCfEnQXLdtS4MIU4mAmXqlR0RaQqhNkp5h6mdtEHRbP14i8kR7+BjtxeDCOVBwdxpf9J7EWAmsorLu1qTRgYaDcleIw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m2f8PL/AP+NmwCf525MNtH3nk9m0PWr/ZKF7SNvxpI=;
 b=P5e+9sxV+OHCPNFXIe0WdwRci60o0hmdPcHzsaGeJUwEn8wIriQNtmEsp3m73buSwlq7zuDeK+JTvs7vd6n3v7tYSAMsmzUu/PhZO65fJZZR+oXIqCqjlCYoeedN2GV6e45seviLhkrxRctjkUshlIUn1u4lkjmiLQsW28ctU24=
Received: from DB8PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:10:100::30)
 by DU2PR08MB7326.eurprd08.prod.outlook.com (2603:10a6:10:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:05:36 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::78) by DB8PR06CA0017.outlook.office365.com
 (2603:10a6:10:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 16:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8026.11
 via Frontend Transport; Thu, 3 Oct 2024 16:05:35 +0000
Received: ("Tessian outbound 994fc319cf83:v473"); Thu, 03 Oct 2024 16:05:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f2c49d2eeaedaaf1
X-TessianGatewayMetadata: MC8CcoHwz6l/yzd4QZGC0nLEpT+oT/Sv4NM8Z2s5qSPVK1TtNbFrG3C3Onb5gAQKcyJISWYSE1Fk3w46BeVViPcqKEANSpDS+gLw3yYfHI3f3ZSrDYABRNTkL9ET1hUuTr5ngq6AiZuwQ4hiBRtt0A==
X-CR-MTA-TID: 64aa7808
Received: from L2764ad24b117.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CD7B311D-0464-41B5-A686-4A45BB4765E5.1;
	Thu, 03 Oct 2024 16:05:28 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2764ad24b117.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 03 Oct 2024 16:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8GwUDTy6iJIAMG44NVAA7S3D9l8a7sPCc3pICmHMMKel9m0S7gO27zrOR7qURmg57CCdEd9DFbVWAZYmt3yypJYuuoF+4En08DieEK+0Nf0OaRKxIoXphPHx9DULH2Eoi4AO78ueXOYfbJmTNWbJeJ74ySskHpxstRocnnTDRDrAyyQQMMGA5esCbK2NeoLSghowyfTDr4nf3i6pxszNMS5/YXOgbz9DQVAdacD2D/G/Jnw3HqwUg1wcVFs67kIYiUaOOQmwb79+8lLdYqsZMvbdIA2Fz92v6HDQXrQ2zJLMzAGZ41l4Rb/vizzZRhB8k7/d2e6toCC45hq6LKCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m2f8PL/AP+NmwCf525MNtH3nk9m0PWr/ZKF7SNvxpI=;
 b=BsYkyeLelDLwerl2WKH7r0r8RNwbT7WF1Qy4rGC4+1FMwYdgTmtxK5ou4LKBS0Fcm6B2XSVC26btb3ZB2WNaLUiR0xRMHIQDd1tFPb7qUe8mR8PvFFIeXG8g6DO64z/n2pKjSEsHgrj4L5+vlMD3GZ9Mjm1+7X+qyOxXCCZyS+shzHYssVVr4HX6Di+fzWJBzZYsPOoOhnQ40PckuAGF/D9GYlkvVzCcOFSskyvnUL4G8rPs9jgfhpoep4ILDkA9pRFtGDjjU7VrJ62GnXLtv0rG07w2dWEQUSil7tlsV24x/wyvR8wgsJqLSUktKQp7v+sVuAxWh1IRQVah5xHF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m2f8PL/AP+NmwCf525MNtH3nk9m0PWr/ZKF7SNvxpI=;
 b=P5e+9sxV+OHCPNFXIe0WdwRci60o0hmdPcHzsaGeJUwEn8wIriQNtmEsp3m73buSwlq7zuDeK+JTvs7vd6n3v7tYSAMsmzUu/PhZO65fJZZR+oXIqCqjlCYoeedN2GV6e45seviLhkrxRctjkUshlIUn1u4lkjmiLQsW28ctU24=
Received: from DU2PR04CA0312.eurprd04.prod.outlook.com (2603:10a6:10:2b5::17)
 by PAWPR08MB8935.eurprd08.prod.outlook.com (2603:10a6:102:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:05:23 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::34) by DU2PR04CA0312.outlook.office365.com
 (2603:10a6:10:2b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 16:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 3 Oct 2024 16:05:23 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 16:05:20 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 16:05:20 +0000
Received: from arm.com (10.1.26.195) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 16:05:19 +0000
Date: Thu, 3 Oct 2024 17:05:17 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Christian Brauner <brauner@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Florian Weimer
	<fweimer@redhat.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bsegall@google.com" <bsegall@google.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <Zv7AvSvcilHV1kSs@arm.com>
References: <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
 <20240927-springen-fortpflanzen-34a303373088@brauner>
 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
 <20241001-atheismus-stetig-4f6f3001715c@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001-atheismus-stetig-4f6f3001715c@brauner>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU2PEPF00028D13:EE_|PAWPR08MB8935:EE_|DU2PEPF00028D09:EE_|DU2PR08MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 64012d43-25fe-4612-6507-08dce3c53744
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?NMO4DBzmAfjeg+VsSGy+mPDXHB7Gha/RYFe0p9VcMWtPMR5kxawLXc0gEj7e?=
 =?us-ascii?Q?M10j1ecpgrPTfbw+ItOgGHFuYfhvn1czb0upHQbN5G6UyABXhtAXvCyTXfq1?=
 =?us-ascii?Q?3uG9REuJby0JwdJ+20QBCNLe1BJrCxLFLnPxbH9AmO6Pz7C8Q5YizywKmbU7?=
 =?us-ascii?Q?ajoJMJtzAXtFkGg/56tl9fm4pDlKfLfrtJIplkEtb5K2nCGI+wpNUeWQ0Bfx?=
 =?us-ascii?Q?EE54YQB+Yz/+dUn8DA6dU14GvJhEutPXk60yqGfYymY4DzwroP3meNIhrG9g?=
 =?us-ascii?Q?j13z4IwsbG8si+jCK9+hfC7kOTRE7MoVN9JujHC8f0h75Yho+IYwsn0vEZxT?=
 =?us-ascii?Q?dpiefk/J+igVGrHBrwj65J85n03KkISfoKP0FndRbcT/ZoVWt9A2B62Wt+Wg?=
 =?us-ascii?Q?BX+wRh3ynkloZkj97QydGWz1ciJIVTnxOb5/wTxuG598Sxb+yO0pm9lmgcnd?=
 =?us-ascii?Q?fB3F3lSC8hyXhZVTgAuMbw6O+kLBOAv1D288eRIL5VCnCoMStDHb6DmL0b8P?=
 =?us-ascii?Q?MEViLzh7Fy4CTONzpjE5xvC2NhQmkQ33C9uMgi3EjBqr7uAWNDubcP84FzMy?=
 =?us-ascii?Q?a/fEiGCakXq7Py5y37p8yxcFaFPBj5sQhYaUxRzd3HmhdGAEBxpw2KkzHqUH?=
 =?us-ascii?Q?rt9aKZEHu6hbiDTLr4T9h+5css15o2vu+1SBv8sjpnxBv2GMtX+DQkXEJc7C?=
 =?us-ascii?Q?OxctoHr+lPJ+X5PBAbZUCyEyMIp761yqnhvLUjtizIMb+Q1AkwqXJRYDDqul?=
 =?us-ascii?Q?ZYcwjMNL0Ss8EVk4D+D4r8T6uv39WomKvod1ayvtTKvkOvBqpSJ/+VPWoRWh?=
 =?us-ascii?Q?Blzt0bPx/QUaVzf87o3JFlnhoZT8wRNpDEptKmis1BgLgsImh+S5tPImHlup?=
 =?us-ascii?Q?4XY/elGXYxF1Ydqzsom7iWe19sSKcmFV75K04cGnC1kN2EtNve1/niWJ3TvJ?=
 =?us-ascii?Q?RL/IRdQdFnSDLBNLcQcTi+07wsuRnBn/Ip7uZH6MpG5BkjSouKXhU3f8HfmI?=
 =?us-ascii?Q?Nug1hkmfT9BcVu6AKjEZ1PVIYv5O2OPWqdV+IZHf4E3AkXlQeT5LK/lR5Y50?=
 =?us-ascii?Q?UfraVswB0FjuwU5j5k3h5+n3Z8QOJW3G52p8InRwroy2eINTq3YMXZOAVES3?=
 =?us-ascii?Q?SOymTpbOt6jukqIMWP/pBRAYPDeCjr3bSWYV9J89zHGM/kk4zk+vXhE6EMDL?=
 =?us-ascii?Q?dD9Hz5Lnc7rK319keFy+0TGLQXQE9nTzJ7uOg567iPiKmsM8Stob18Iec9Uk?=
 =?us-ascii?Q?GlMrday/AgBXd+cxr/gQtMcuPOkRdCtpGwK3UXnKd2l+5FjNJUwdROiyWDc9?=
 =?us-ascii?Q?EZ91e+EfihUbbQFp+o3SBYAZaI0EN0jcu+ZINTjhqn8Vi3WS+B4I6XBGZcS0?=
 =?us-ascii?Q?Ta2Y4xio88cN1j5pwB+5RYtWHKCm?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8935
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:2b5::17];domain=DU2PR04CA0312.eurprd04.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b86be9da-32a4-456a-6b6d-08dce3c53055
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KoDJPdtY8+28SetzvQqP0R6aInP457ktTaM9+ODkZHViDOOj1oTfLCLj4/5u?=
 =?us-ascii?Q?/svuIFJZNYd69zhNH75yNKXuIgb6nse+p5pWNbc+LqlLo0KEzlmdz1u5MX48?=
 =?us-ascii?Q?PSQyJq4lm+g8aLXT7FqiWvzjvalnM32ncMPlqphy5cLCVnssmp8M/fYOvLrx?=
 =?us-ascii?Q?ddpPqZaAloUtnozyDOkiPDGQzhl8mFSmalkt3qAuwN0EN+SGGo0p0IdTdWjl?=
 =?us-ascii?Q?B07T1b3oier38P3P4tTPowG9GwRiZHfsAnBCkWkDtv0EElDFU91JMU6yfdpA?=
 =?us-ascii?Q?OvAI4MJ5KGUXQs978ZuDGAtOEYO4NC34rhF96LiMaYe2LIk/f5RWV9OQwtdx?=
 =?us-ascii?Q?EVRybksAVKprDPco87HH/eH3+H1rQsYBdpBsRLmqRA3jemHD/V2F7SKVVm8g?=
 =?us-ascii?Q?d2PCxIR7SQpNsrtC7VRG1k+NNYLSde/PedFMO1/WZBsFa28fa/mMc4OPgL4H?=
 =?us-ascii?Q?sX+DrG6Smh3XIO67M18grl6hTssbPDMMv8l4tof6pQLxmQof8gYYOd+Jp7/V?=
 =?us-ascii?Q?ebe59mQBsOPXH7nT4cBNCkoM79+sd5lhnEO7SJe8FAauVVLIAZaE9jPhmbPF?=
 =?us-ascii?Q?lGgUrIRhnZZ8AUHZMKrIg+q1x3My28Ispy0ECkz1wBYovGcJgI3EsYileeU9?=
 =?us-ascii?Q?EJ+3HUqppRPURU72by3VjnmH8yz/MzOl+o4bFggG/oegDIHeTDBKQ0AiDPZa?=
 =?us-ascii?Q?RGhDFR9txuUGuRKHMAIDueE1PozQcJWtCQpjIreFjq5bHzvkxpdJ8fZhbjNx?=
 =?us-ascii?Q?wzJTIg9k+du3i/U/X5QgZOHifxEWnjkqEUjKvutEIXO70NaG8NS0znxQUTU7?=
 =?us-ascii?Q?WLDV6da9S0tw2pITq1ZWh29h1/TqHAB4UpL+eZ6geCjnMZzD5VJIyKaRLigU?=
 =?us-ascii?Q?3fbTcnvLY26X6oNVQ9/XLjcOXfvtxYR0MpEPj9YUuXsPTUxNu/TFdH6ONt5i?=
 =?us-ascii?Q?kzOxhvRBumZAFx9isf0nb7+Ul+wi4xjZtvrop2KT4rFNxnNuxCjwDnJXVvPD?=
 =?us-ascii?Q?owtSBcGCHB6YnhlMWbzCzET/Ju9lnPm3PHb0LomJPtPswUe3jzmZlO36ykQ6?=
 =?us-ascii?Q?kogyHnftoix/jiJwfnnf76ESz/IG3MOImcjk1LGwn+IcsUKRNLPYTjyDMPCR?=
 =?us-ascii?Q?pKGN8ngdYjxQEG5cf6I0Rce3Ixf1mL0jU6ynAnpNDV1QtHmNgbvkK9TRNfno?=
 =?us-ascii?Q?2pwQjk4mPLOKsr2qar9iykrlFbdPWqqO5XM9LIsNpEiz9P1n0DmQqeoz4xsK?=
 =?us-ascii?Q?r/+b+mETYlOtbpqgUWOqfDXiffHFyGd3b4oh3VucClHeQKMxgzxV2+28NSU1?=
 =?us-ascii?Q?P4/mC3/UY8idC3hTlbH++0D5p9BG8nPZRA03UcXxvYor49n8JeLhD8BQqgtT?=
 =?us-ascii?Q?3ItLNdoCr0jUlnHVYlTGr+7XWlgU?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:05:35.3809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64012d43-25fe-4612-6507-08dce3c53744
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7326

On Tue, Oct 01, 2024 at 05:12:38PM +0200, Christian Brauner wrote:
> > Thanks for the info!
> > 
> > > 
> > > My preference is to keep the api consistent and require a stack_size for
> > > shadow stacks as well.
> > 
> > Did you catch that a token can be at a different offsets location on the stack
> > depending on args passed to map_shadow_stack? So userspace will need something
> > like the code above, but that adjusts the 'shadow_stack_size' such that the
> > kernel looks for the token in the right place. It will be even weirder if
> > someone uses clone3 to switch to a stack that has already been used, and pivoted
> > off of, such that a token was left in the middle of the stack. In that case
> > userspace would have to come up with args disconnected from the actual size of
> > the shadow stack such that the kernel would be cajoled into looking for the
> > token in the right place.
> > 
> > A shadow stack size is more symmetric on the surface, but I'm not sure it will
> > be easier for userspace to handle. So I think we should just have a pointer to
> > the token. But it will be a usable implementation either way.
> 
> Maybe it's best to let glibc folks decide what is better/more ergonomic for them.

I agree that it would be better to just have a pointer to the token.

My preference would be to avoid having obscure additional arguments that may end up
having misleading name or bear some hidden functionality. If kernel is not going to
use stack size as such, then users should not have to provide it.

Thanks,
Yury

PS Apologies for delayed reply


