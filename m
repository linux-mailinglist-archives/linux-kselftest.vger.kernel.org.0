Return-Path: <linux-kselftest+bounces-34598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84AAD3C88
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FA9189BED8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBB2397B0;
	Tue, 10 Jun 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OrdH0yRP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OrdH0yRP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969D201034;
	Tue, 10 Jun 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568557; cv=fail; b=cnLkbsnIWVV8YvyHiLmPdSzvD6sZKAc/mzFQbext46euXXPU6xLhCNBn0XSLEVo9PVXSkVzzKbbTnhqocxZOx6YdQ5TJy2RRbTUYFBjAxCtoZXWqIl+WwnljZNcvYLwu8P7TPZ+EEq9ATfHSeu+2E7Yu44Bgwu7jJqTTEfuNxnc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568557; c=relaxed/simple;
	bh=aIE30cvn5rJgPT4gmya1iukzEpE8kiv0gjDJ08MrQbE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7G+wcsMRn4b/BF+JpobxfLPoWyQyDjj5ts7JiHLeY+Dviro42PUGBinelELixKxaGg3z5XKtlqr+9WB97sKUdWDhoAP9mUP4v4ejIWjbjcePd2S2TFpjq9crrFCHKMN7t0G5iqZK5w7bwV2P9ak0LsP0oATMU8swXBGBaeV7Ug=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OrdH0yRP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OrdH0yRP; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sYGlh5sd4EQEBdQ05sVeGojFijKdYDuVvT9CdJeTSoERxrub3y0dElI9NVD9+BkJzmoRJNKRXX/GwZBg+eWzq9ryYPOEtvzK3UIoi8Ms+gVwUz6rute2+c9ZCUg21WSaZcC2habwZcV68FvVSVy6vaHSRxKoBEH2hXWgrVaXfl9NPRUlMBO/SaqxsPqQNN+k65CYCFHxqAhcudrI8zZAH+WB0W44z0K9wWLjthZLNF10W/4P29dUGWwxx2B/cO7pdQxOPBPj7L8icn9TgbXY0XGjaqMVgoC+XMQO8Eegmw9IpYdm3x5UF35NNDebb5WugF2Tu8/fQor7Bi/piwqD9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRqPShcMNLDou9Yvp4fUXrUpY2XhMiDuey2uvb2SKZ8=;
 b=B61LHUAI3SkFY/OjEr+xw66dVhagkhlIr5ccRikCDpaoHbxEob8DhHYCvSWYgLb51D0n248urqGN+JxigZCpOMY76CXGkYB+wCNQUgJyXDCfzO/Crs4ONSQTr6IQsOuFcu9VmNH4pmWUT89VpFw6J44ZOLnr0aM7+eqrq2DWKk612njo8pxSFXm8WcLAyg+SVWnqTa8o4LyrA690AqbqYyTjmf1OuJ5rHrl5lja5eZy5y97xGa+YtkMDkcRHzFq+7rJWxwLMY5QOrmsjbb8DyI0v9bglSyWcrWr6iBk0kBipPPcukGzguv6Tx4eiRjstlrkLCb7OvW0mSQB7F6QEqA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=0 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRqPShcMNLDou9Yvp4fUXrUpY2XhMiDuey2uvb2SKZ8=;
 b=OrdH0yRPqqAdxEXtt8OYtclr1LXqZ5vNToSGtA+wRYiU5hsC0qCgcKTFPi70Zf5okxEB0ixDGtLBecTdE0ATQ5FdlOO8rbNzQdkx7eFwsMgQHEyy78MmhKkol1ydFntPIfXa5UstFC4DKAB7o867+VGgPWukNLfRgCKAR3A/4eM=
Received: from PR3PR09CA0004.eurprd09.prod.outlook.com (2603:10a6:102:b7::9)
 by GV1PR08MB8449.eurprd08.prod.outlook.com (2603:10a6:150:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 15:15:50 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:102:b7:cafe::13) by PR3PR09CA0004.outlook.office365.com
 (2603:10a6:102:b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 15:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on9z9PUzg8cUBZHD/n++ZLEkDkjhuwj+I8IjJ6CAiJOGCS/q0eUdbiQSuXwj3bjjukp5Fv+EO28S9y2Dvf3GH8pNsJMT08W4YjfArkkVuRPtbiWfWu/gpeGAg/PsJtDHtk+YmtEg6jxRgx51Orf5V3YBSEIO6DDhdW3Xeez4MGuj/b09tJms42b7myxl/lz50I2YcoKmIiMRaf882WCuqis+5dL1RlNYn8i5EQaBWIPwukVjWJsqQ1OQjlzbMNnhAFtDjWujtCkCml+ZdkYCR+dD8VUyKtyUXdH1g6RT4yrvC3/3jj4AWix1xUjm8NGAtzIJneFFJk22EGWaCasPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRqPShcMNLDou9Yvp4fUXrUpY2XhMiDuey2uvb2SKZ8=;
 b=KNb06vvW9RwKXnClFIy9DCVld2mmZEe85Iy0aZJZ+qeasVh5ZYmcQee51293wTGNnSsKR3eJCkVjSmV8RnDZRmCLa/03oMGalg9x3gO8GKUr16wVL2N47+LnTxkOFvp/TRZhPZz+n8u8H+8L6WhZc1NhKRTXG8D4qMnLrjwQrnaVTnIiafBn9q53FJh7tZ5aJKrsxZQS3lvqe0zZJKosu9kRyafzvhFhMebDV6VNNrwl/h+0bLMUAlPvCTMcwiT6BI4wQjMTS+ZRElQygNh0rY/pN3LZ7ROl/sM5NJZ3nSIKXis/AVjzj/z8VR1snK587LIvdL2ZNRCp7Jjgo3uHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRqPShcMNLDou9Yvp4fUXrUpY2XhMiDuey2uvb2SKZ8=;
 b=OrdH0yRPqqAdxEXtt8OYtclr1LXqZ5vNToSGtA+wRYiU5hsC0qCgcKTFPi70Zf5okxEB0ixDGtLBecTdE0ATQ5FdlOO8rbNzQdkx7eFwsMgQHEyy78MmhKkol1ydFntPIfXa5UstFC4DKAB7o867+VGgPWukNLfRgCKAR3A/4eM=
Received: from CWLP265CA0376.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::28)
 by AS8PR08MB7307.eurprd08.prod.outlook.com (2603:10a6:20b:442::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:15:14 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:401:5e:cafe::6b) by CWLP265CA0376.outlook.office365.com
 (2603:10a6:401:5e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:15:14 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:14:47 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:14:46 +0000
Received: from arm.com (10.1.37.41) by mail.arm.com (10.240.25.133) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Jun 2025 15:14:45 +0000
Date: Tue, 10 Jun 2025 16:14:44 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
	<debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu"
	<hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian
 Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <jannh@google.com>, Wilco Dijkstra
	<wilco.dijkstra@arm.com>, <linux-kselftest@vger.kernel.org>,
	<linux-api@vger.kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v17 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aEhL5JMD7yLYfTK0@arm.com>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
 <20250609-clone3-shadow-stack-v17-4-8840ed97ff6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609-clone3-shadow-stack-v17-4-8840ed97ff6f@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM1PEPF000252DB:EE_|AS8PR08MB7307:EE_|AM4PEPF00027A5F:EE_|GV1PR08MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c7f56c-70f0-48d7-9fa1-08dda831ae87
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?6yWKLiF9934zoJpNMA9zh1opH8BQKfNdZlfbwtBHqO5u7QFu32hP2dDyEaka?=
 =?us-ascii?Q?AaF6WP0hHPIFtV3Yhtq93jY6pv2SiBa+3APlE8l4LbmiiNwbXNe6yFsoWYTO?=
 =?us-ascii?Q?pAftT7Xi2Uwem8V9iHCerWTkYYec0u6m4Z7iMmWvhEt6SGKtuI4qPWQSyqD9?=
 =?us-ascii?Q?CXBB1EJ5zgxI3Bbark2OAdARNitm8J7ro8Jp+jMiJpoL8+t7jKkHy6kRTdxS?=
 =?us-ascii?Q?QYG+fw7CzQA17fSWl6BbidHlizGOTTSzIaA74pGNk3V2csl2g6Ni7u1Jw4t/?=
 =?us-ascii?Q?nOU7eRtvtRrnKHHjMWEHTzSs2W+vH3uWFozfxLLRIRkb5O0O1TTpt3MURJuD?=
 =?us-ascii?Q?AbihYT/66qSxQ0v2BCXwC5nZ607EuymtJd/oOui+q83AnW3hoTqsJ0fH7tlg?=
 =?us-ascii?Q?KO7nKH+8nxHHvhOCaGYRcj09ZilyExqab6ZgwiET1UgWAUVs42uVO98FLSm5?=
 =?us-ascii?Q?rDjFZUXJbZBcclDIsdTUYbvi1evKoaxZ/nc7FkJ5NRFIypseE5HI8X+P9jAC?=
 =?us-ascii?Q?bsOAPCZ5avUbjQxGpOVyvv1WVER5Jc9K3q6jGQonnAgz/t5bwdf4pf2ne+gu?=
 =?us-ascii?Q?cgaPPxsYfIuD8yU6CBuutSHC9I6fit+Z0/B6cnM3CbsdbkF479gM7yLlugjB?=
 =?us-ascii?Q?igFEst3nv4NbqonxRPZdavHA9DQEVJGqWmRG0/koefuWiWwt19/KDUmqRoF3?=
 =?us-ascii?Q?w98k9Lp/fkNLwv5uFTNGtksA/9/j6i1020YuRIEmtPEkfdhx+6vMc5niEMJI?=
 =?us-ascii?Q?drsQIwEDG3/tzmBg1UujJNlPCPoWNf5pRuacxMDM5VhRxjYS6yLOqSUhAfk2?=
 =?us-ascii?Q?1Uurz/81y4EKM6FzTuqWJNyor5cnZH0Znm6EQv2PlJLlBb3ybmMfz73OXlRH?=
 =?us-ascii?Q?3tXFsTNLhWQ3jzlW+BVTwfQ4wfp2mN1S9Wcjb55OX5vy7Z0w+YS9VHsIt3r9?=
 =?us-ascii?Q?flcNY4PQ1u4Vx1YDt1eGdnjFuIOJqNdxyrNdHK2hOq5tGA+uFEPkexb0hbvv?=
 =?us-ascii?Q?o/6mSbuDvUyXmlP85CMvfMp6kx+Dd7f0rAnGEvIQ8ikL0j8XlgHumcz+hCCN?=
 =?us-ascii?Q?LZR//BQzfPiW81FNPHpDzGJJEBupvo4Ek8cODWd4HTel9anttsEo3YhCTivp?=
 =?us-ascii?Q?NNBxu3lJujChMzQaYedKYQJZ7ZxqcRDIgSoc1kx2FeusTkZ3m3VgCTJUCi1L?=
 =?us-ascii?Q?3d/QoKoc1Ail67ygFGTy4LsdtzzGUQYkQkOnzdB7VoWrV5pXKxaGzNm91Q4n?=
 =?us-ascii?Q?8E/9R5R98OiHJK3r2WysLhPSfPIHlpdoRZut6FhYkNcJsM8Du4SdlbLrbhAT?=
 =?us-ascii?Q?q1hZi98IfuJkZMBrwBVeURfhncVHTpB5uKGJfJa3L5ZphNh7RkNYTvRM9EIB?=
 =?us-ascii?Q?P/4T5dXAO4iSS7Bc2h3qYXAm9mIc02rH1ra4ZQ3khGPHDnTOnn00Jyx2eQO+?=
 =?us-ascii?Q?jkGIlYKBjgcoWkMaUSG22ax3h+kbspteBPYPZUFbhR7XI4nOjNNOTA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7307
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fea66baa-732a-49e5-17b5-08dda83199db
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|82310400026|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsLVPq3e116sUWhHeRKhpC7fkSNNCjmiEeTFzzMpzyfui0pH+vrXcHJ+BmhJ?=
 =?us-ascii?Q?pJxChB7XTqJKmXsberxdZRxqiD+HSQIwhupYoteliObFBf4r6AGBI3fq9L2S?=
 =?us-ascii?Q?f09er+8bHs8zjaga5sQgOl3lUIgNwYHDN/nEUo149aD8YQKQHwAUz8BB07Lz?=
 =?us-ascii?Q?fvAPNHIv3r9jaDZ1fIQSLCtt9YWsNgM3LOaahEXKWaiLnqd4AMJEKOVN9Nht?=
 =?us-ascii?Q?7nAE5mKAdxzVHDBH1BWVWZ20ocO1zXK07e56kk111k9K3eZqz4BlykMm6bDo?=
 =?us-ascii?Q?fKSf1UM3VdceMa6pVolWCF4ZfGUkfLhsOKb1I5AzUsd4uZfaaSpangwEsVvB?=
 =?us-ascii?Q?AIRa37/SOpz7yzoAD2uHAnKtzp8FsPxstFoYFBsO+u8e3FBDQYq9P+1nMZPY?=
 =?us-ascii?Q?HwR8ITnI4rP0nmg2uZsw97jxkVEAh0/3V2EBf8TUWddBcNTLlWO4p3RXI0LT?=
 =?us-ascii?Q?ClWu8wDamRBnSKK2mdJMo9bgrrjf1ba0ICNzSaommr5DR+Bclas9mQRHEuJM?=
 =?us-ascii?Q?aZVEIAz+sNanGW9dIF5guv9aMCJggen4xvvcMMjI+cyZv+84frRcDr2iI3Nm?=
 =?us-ascii?Q?yXvyUhRaN3ajCkU6Sc4BwIzClqSQBQ1GuODDduy/5IBZWKSgPBrpg3kYGDBN?=
 =?us-ascii?Q?bAmb2nzxueTmQKntYLmyzTtIK5ac/1m2cl8b4ec5zXOeYdu/qUpozYsEXpDn?=
 =?us-ascii?Q?YmV4SwBRYAujZSm+R5GvOj8WQtX2BGYBx4iGYcJWNkHmn4cX9TRpyywLkbfX?=
 =?us-ascii?Q?DsfjwBuXbJd+BWl4CRnKHeN9+chs+5vcZQFf7JrUiRfQ/GvzF9P5lc/kJXdE?=
 =?us-ascii?Q?H9iTeGcHtB8u1DxKOROJHP5JlJDrCwJUbNXCGl4E9jCEphlfcB94HXgCBCRW?=
 =?us-ascii?Q?G9lOQwcWEAkVHhuah0pPNkGcaQRakcdYSjoxhy4zmdBx1FnFqGgX1P+i+fPG?=
 =?us-ascii?Q?NoJ6J7pmjap/PfkKkO+9cT717Vt3TLkvTxXj+qPDsOjjKcdo8OX9/xA1Nx3B?=
 =?us-ascii?Q?c3y1T5vv8OKXe6yTfRL46hO+V+mRBP3hK307km7Vq/E98K3HYxNYYG42VjWy?=
 =?us-ascii?Q?St6lMIbjO6seKsH+B8OPJ+gd9pIUfWE3SpNDJ30GrLQfSEoSZmdEI/TOLB+b?=
 =?us-ascii?Q?GVNFgZWo8OgVXKq9G/72Gv2jMYSP8ASvixAP/6Z2cCNEaG92Ua66F3TLClWk?=
 =?us-ascii?Q?229JKnq+1oA9l/CGZrDOf+VCYM6NpxxhoLiCWroWoDCr7OTDnx5kHNJ4peWc?=
 =?us-ascii?Q?l5A9OgaZ2jR9zQLq9uEjIT5uCnmyRkcjgu3u6rM/WMOlVOc+nugOay2LFKra?=
 =?us-ascii?Q?XgF0grk93zRXELPhTKKkOgsgqYpf73CCdijbfSNWgdE61Mhj6ggW7c55qqi3?=
 =?us-ascii?Q?UDTczq8dDZuA5WpPk3voqPhzp4sBKvYuniwlWEBnufib1+06bx6nCcY4GI+M?=
 =?us-ascii?Q?9rHXn528cYCOrJmWCtdsvRBetQ901xYVQiWkVQitI5d1WivN0jsJxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(82310400026)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:15:49.0426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c7f56c-70f0-48d7-9fa1-08dda831ae87
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8449

On Mon, Jun 09, 2025 at 01:54:05PM +0100, Mark Brown wrote:
> Unlike with the normal stack there is no API for configuring the shadow
> stack for a new thread, instead the kernel will dynamically allocate a
> new shadow stack with the same size as the normal stack. This appears to
> be due to the shadow stack series having been in development since
> before the more extensible clone3() was added rather than anything more
> deliberate.
> 
> Add a parameter to clone3() specifying the shadow stack pointer to use
> for the new thread, this is inconsistent with the way we specify the
> normal stack but during review concerns were expressed about having to
> identify where the shadow stack pointer should be placed especially in
> cases where the shadow stack has been previously active.  If no shadow
> stack is specified then the existing implicit allocation behaviour is
> maintained.
> 
> If a shadow stack pointer is specified then it is required to have an
> architecture defined token placed on the stack, this will be consumed by
> the new task.  If no valid token is present then this will be reported
> with -EINVAL.  This token prevents new threads being created pointing at
> the shadow stack of an existing running thread.
> 
> If the architecture does not support shadow stacks the shadow stack
> pointer must be not be specified, architectures that do support the
> feature are expected to enforce the same requirement on individual
> systems that lack shadow stack support.
> 
> Update the existing arm64 and x86 implementations to pay attention to
> the newly added arguments, in order to maintain compatibility we use the
> existing behaviour if no shadow stack is specified. Since we are now
> using more fields from the kernel_clone_args we pass that into the
> shadow stack code rather than individual fields.
> 
> Portions of the x86 architecture code were written by Rick Edgecombe.
> 
> Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>

LGTM. I've tested this change on the FVP model along with my Glibc patch
series [1] and confirm that it works fine. The Glibc patch is at RFC stage
and will require more work, but it's enough to test this series.

Tested-by: Yury Khrustalev <yury.khrustalev@arm.com>

[1]: https://inbox.sourceware.org/libc-alpha/20250610151320.885131-1-yury.khrustalev@arm.com/

Thanks,
Yury


