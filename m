Return-Path: <linux-kselftest+bounces-22631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7849DEB5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18AFB2178D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67319884C;
	Fri, 29 Nov 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DG/5ifVu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DG/5ifVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B319AD23;
	Fri, 29 Nov 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899457; cv=fail; b=jj8gB/zlFnVgfSBHjBF+VQBLhNKFPToygTBcnAmZNkrhQb06Sjgd5troXqk/desa3nKJxQGzJ1TCsTBBNQIIe5+LA37De+oNWEs5fusjYHRtBl6XkvJcE+w+qKYd2FDLFXYPXYpCJZmvmjI9DG069l91heYA3vAmic2LIr1173c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899457; c=relaxed/simple;
	bh=s2R4KFQeaAYXPti7KIVUflpoj9UT4S/WKIlGlroQIYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJlSGLfQeUrJmeoQac1ai7PS3kDu3eRrENA4sWQlhwE23j3Wlp7dJAbsdfyKLrmnuQ/7JGWPxxMnS3WzJjYZ9Lrbua4ieEnkNzecNgdrIW+lZZlswvUWl7njR/F1Ua2P6GmoY6fsk75QYUh3Fzfvn4q7EC5Vn1DvNqNLq9497Wc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DG/5ifVu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DG/5ifVu; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rf1Yhg49N8R7zWcKHDOBxRTBGNi8ENhrT8VlDaNTtKUHhFVooA5c1mqoeEE+j1xqnYhsnTMltLxqW5Ry1Y2sYJhPK8dPyjEBLm4KIYX50VqWoBNeT41sD+RnR6A5vFetmbDKZPfwM1faACyO49nVBB+GVNnH2gFl/VBq8XFHFxA+vm5hD3yqfuMvZ/qLQ5uyK1jO4qGM8fYf9fUv/iPBoSb4RHFyhLIb9KHdLD/e70qW8qqnz9b3HV8oPobrgYK49RjSRPj7UMkRaDSTtxX+y6REZN9rBuVJ1B2Vtf3hR18iHNxK5O8uITfB20nV1UJalDRYOSo1AfuqLh+aM3jqKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QfIFbonTbs+nsWtJOu15qxsWO7H2nMoi0YpW7zqHCs=;
 b=ljHVsQHFImOVYyvybEWLt9PSRWRAD9374fr/z/LuP9a6MSSp5A4EksB5jClObIZj0GVyDHmzFu9TXGmtismTzIfeaEXPLa1OTot7PhUzdEuqUgc34sfnA42iyp5IUsSMCfnGFWlcNXqOTDV+M4ZPjkQt8BYEZEmJL7lXoh6CXf9RI29ommL5Pg9drZYKpIPjDtzVK+1PsZjn2CvRN7+FIU/XLgUQH748rqMM5qyJRFDxWtkl90UXCDE+aokCXg6Dup96nPhGT2fFxopIeG+Jrg4hlwIZGtBc0ZiDA4IFALCEvFFrmJ5svz1REcOHO/tUPUJilUblaHLmRRwkQ51n5A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QfIFbonTbs+nsWtJOu15qxsWO7H2nMoi0YpW7zqHCs=;
 b=DG/5ifVugy11QhE+WQT3Hx7RzFJPg5CeMrZwycCSyS7FYb+JCgHuTxrRusoQ8yKk/NIfbueIYmaZ+Bmy32SBZ9b31198BWe8N3mA6xYM72wzoUXcBYBmqNGgnp9PhdsafZJaI8M6BmTWhjB8PHY3AEu8WqycAMCp/RHlDMj87UU=
Received: from AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::19)
 by PA4PR08MB7460.eurprd08.prod.outlook.com (2603:10a6:102:2a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 16:57:27 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::65) by AS4PR10CA0019.outlook.office365.com
 (2603:10a6:20b:5d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 16:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Fri, 29 Nov 2024 16:57:26 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Fri, 29 Nov 2024 16:57:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 46951dbec2869e85
X-TessianGatewayMetadata: hrCQKPaKz07kbPL3ovTOh3lSpdxpgK7YEgHxd5nBp7tiuSG+z0Q/N/FUrP+7mVtesy1pGe2K7VyNo3EfmJKnAO1Crj2+OdJtna+c+F5N0NauhkE2Jrth3yFq7qADwHrmGNuZJJOD7PrkdKHw5nfClQ==
X-CR-MTA-TID: 64aa7808
Received: from L39ac5c077430.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 00EA4E27-6BB2-4AFD-B4B3-37377AE03B95.1;
	Fri, 29 Nov 2024 16:57:19 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L39ac5c077430.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 29 Nov 2024 16:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezj5wp9o3/5DBKmfvc42Ha85oxQVubi+TH/3rDRt3OgyAbgKNCH6TSEQQ+YR8AynfixbFJrFCl7Bdwuluw6Pmle8+ez1y/9EdLjdS9l4EKV9hUxat9uZgmzj8073A8Eo8eKz75ag0HJeVR+GoCeZKU1P9cyyJA1B9BzIWxRPdgkQ7TD9pvFOmC3voHOt/wKuetmI0UmYaxpTeMSTjzl1L48rPzKerqpQ0q+/ZDx3i7nbf1j6UlZtOVebpY5txD8Nb8CQoFa0gDqvSVRDutcJdXjE7fheG9vWeWBQjp4XEM1Af0CR1giTOPgdoYDYB52gDCgCZh6TmBERGXwZgZVDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QfIFbonTbs+nsWtJOu15qxsWO7H2nMoi0YpW7zqHCs=;
 b=pkRf49RabRgFGPGuAsrjMb3Zrl/tRvp3mxvWxNRUs6ERHXdF1h7TGQYF/PycbfPIA78tw7Ck1FpbfkvBzT5BUHd5Zusj1Ob/bxCWaudMKFJD4O48bX4utQqnImnrH8zwvIFTDaCIG2W6fke0zbHTXtxy1rKA1LpO8D7wUK6uECLwghJ9FUaPH/CknPY5kwzeuzOyVKQUAPe1TQlARIuWT8CbNrO6FBsy3rdocDzN8JPn4Yx0ef2Go4W6u23JUY1Fcodq5V3s8gxT8glH++OQvm5RFfZfHhelj7k7yK2jCk5LAqSqZQOtmz1E2nvuMPOciZYwG0+QCtvHweU2tFVTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QfIFbonTbs+nsWtJOu15qxsWO7H2nMoi0YpW7zqHCs=;
 b=DG/5ifVugy11QhE+WQT3Hx7RzFJPg5CeMrZwycCSyS7FYb+JCgHuTxrRusoQ8yKk/NIfbueIYmaZ+Bmy32SBZ9b31198BWe8N3mA6xYM72wzoUXcBYBmqNGgnp9PhdsafZJaI8M6BmTWhjB8PHY3AEu8WqycAMCp/RHlDMj87UU=
Received: from DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) by AS4PR08MB7629.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 16:57:13 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::f3) by DUZPR01CA0267.outlook.office365.com
 (2603:10a6:10:4b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 16:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 16:57:12 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 16:57:11 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 16:57:10 +0000
Received: from arm.com (10.1.35.24) by mail.arm.com (10.251.24.32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Nov 2024 16:57:10 +0000
Date: Fri, 29 Nov 2024 16:57:08 +0000
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
Subject: Re: [PATCH RFT v12 4/8] fork: Add shadow stack support to clone3()
Message-ID: <Z0nyZDNn0rcgkKBJ@arm.com>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
 <20241031-clone3-shadow-stack-v12-4-7183eb8bee17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031-clone3-shadow-stack-v12-4-7183eb8bee17@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU6PEPF0000B61C:EE_|AS4PR08MB7629:EE_|AM2PEPF0001C715:EE_|PA4PR08MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a8cf1b-8f2b-4534-7e13-08dd1096e757
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Hx5Q1Zo8YiffzghbzdNkJIZ4FYDksVGTCfCyH/1qjZ4nANFx7k/BzxHZIzK4?=
 =?us-ascii?Q?H8YKCXV4qJZopbdLlE0iZ54CaFYxkLUKQVi6QVrAn23KpUgYlbGFY2yHvcSz?=
 =?us-ascii?Q?AjVVeymEYWR2CAM69ORZsBPfWV1CA2eAdb7w6fj9h8QDLxvHPs6qJ2HHu06k?=
 =?us-ascii?Q?1C87i3h2Pu3gyNC3M1ShyfMg6JbUO8Htluzj423tsOrbddgSgPFKVMokRAzU?=
 =?us-ascii?Q?JG18lSj+NHJXUBVkrRM7cE4UuceCFMs2MDcHj9nJH03XTW1J9Ss23rvQrNkD?=
 =?us-ascii?Q?ysIdHdQ3bYyCp8PSDQAmTTzQklWmtPtw/jpRvz62yykvewW3EVk+4+ZdMSbO?=
 =?us-ascii?Q?FnNuidDzacseD/e+arn60ZGKM3QKtch6WnPDz5YbLxbPyB6bRbRV9H4Edv5y?=
 =?us-ascii?Q?3Lyxu6nYu6yflBuzSfoLml+Vk2yIfsztRHtCS3Kqjp83Vz7Al0fCdWaVRofz?=
 =?us-ascii?Q?+5tliPn5nwGdEUfheHBuZ0NC6R70RyKH3tPNFFTYINOnf5qNwuocVcrewqiT?=
 =?us-ascii?Q?rbT7NgVe1TYHwSyV2G3TkIuqBRAh2T1bLvlaR+i44JhkQFwGP6VqlpuBltcl?=
 =?us-ascii?Q?JxhSTF29Y94du83qpbcNE4kTJEYqiG0iVagkuk/yi0Ge/dVbSzWWrWyfg8o6?=
 =?us-ascii?Q?fC+mJlBGv5QL/utc83pCHFT7FN3RLTiDnDGYGlbtc1dg++IdZXHfl5dZaP3K?=
 =?us-ascii?Q?3u6lc47uBhwIXbfqhJ23GBc6Djpw02LriyanO2FpDJSfv54WbZtdsnxuggY6?=
 =?us-ascii?Q?YsitRiPf1tjVHmZpJQbph28lO4yCzfyOjrvXTzX/1qTxKo2/OeFeAYqAo+ij?=
 =?us-ascii?Q?Loc0b+JUriG9EFoZJPXmPhsEKTszJFFu3FWVnaUIENYfpgj9c9jx5FUKVQ/4?=
 =?us-ascii?Q?0tZLxq6TEdmaBEj6M10QkBftcZNxJoRFZmN4QQQYbqX3sKxGqWmfoJafp7Vy?=
 =?us-ascii?Q?8jzHoK4fmDhUJHWdIO/uMDjx6PWuxDvdyqzU3vIpBLm0gZnq5nHreIQWmJZO?=
 =?us-ascii?Q?u/PF5jtgjlJR8blBgohZzgiPyH8I39zDOM0zu057abijQePHaqCyB++7uJqZ?=
 =?us-ascii?Q?Qv5YOVt0nEZVMMWDXnQ5xJcm5NhU9K8YnAVCLJDt6WZWrNtxf4wTRI4EFPdI?=
 =?us-ascii?Q?H/Hmmuv194Mlz9r3fnmgh5h0K8R0amKJ2EEnjT2IlHwmaXm5AI9F9xrb3ACz?=
 =?us-ascii?Q?CqcdSL0wwyea7MDtN09ycDWOoTkLK2M7++RoYEQHOazhivSuMkUGc8HKYcHb?=
 =?us-ascii?Q?ve8j+feKq42bxSmQbTFl0gRVW3Jf+9bGTjFqnzD3YKSLesfGIJGJL0znpYAf?=
 =?us-ascii?Q?9trX3SRoIQhSfxsv40LD8YrnaUoSQZISK/3ithq2vRk1MSFhQdBkaCdunSB0?=
 =?us-ascii?Q?f/OUG0URwtx6ZqDlS8vsxCwxQW/llJcNXBM5MMQ8GxObGPanXZnp7qF641Hm?=
 =?us-ascii?Q?J4D55HTSGfSikAZAAjammuUIJwHmPUcF?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7629
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:4b9::10];domain=DUZPR01CA0267.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d0115b03-bd8d-4abf-2960-08dd1096df07
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|82310400026|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OKcHjpFFAQYY6MXgQe2zKjAKmYspgtdYigij5rPmygIaLrasL3/uggcEUdpf?=
 =?us-ascii?Q?BnlghZ1HSroJ61NWajo9HoC65YaM0EYQhtQexe9wSSWv0aHQsrJMvi+oXDkV?=
 =?us-ascii?Q?x8qNkdlpf4qvHkWeDRtCXt6PVtSYLrLQSFHmMJHvf7jDqsRGVLHu0zJ07iYO?=
 =?us-ascii?Q?/TaAaStU5NZwiQO7F0GHBoaZ8W/RlEUI1c+8FvO/jDBrJfImo9k6QcMnd/rr?=
 =?us-ascii?Q?ggFUofgsuDVuNLdNwh8RPHCvvXVoIwje4sFHFjItyv6pOYnciKtF8KV1m+Vx?=
 =?us-ascii?Q?CW/YA/yVJSuYgrZssFzSB6+FPsX+341it27PadRalpxCW+F4UjYWmCD5A/rJ?=
 =?us-ascii?Q?Pw810KXsh0h09vhud2uooywOs87vsoYQ9T/3A+MM7JIJgfkd0KrlOnmYB0/C?=
 =?us-ascii?Q?NnuFXxJC2f8xJtk/ZDyFfVV5/rnKnga4VE8v5X4g22TQh0zR3dxdSUNAMsGT?=
 =?us-ascii?Q?T1/ykLWFAuNQghgA2CbzOafOuhoeE0ygYk+BGiaIZ/4IfwoCSEe8KbnaAldu?=
 =?us-ascii?Q?fZSQg3ntR3QhkHKDypAYmEZPzVaEUUL+jVwdh3Ej2J2lJDQn69ZLZOLffub0?=
 =?us-ascii?Q?4Hn0xVUJbRnQtSrbF3lm3dumcq5xQ58P/llryMqBxQ2+8RGuAe4P5IMdYTmk?=
 =?us-ascii?Q?ybgOuYOh4cNQ+NRjCfjDFwg5K9wzAB30tlzpxuqlT5xdQKn5C/lht4LC51bT?=
 =?us-ascii?Q?Ay6UC6LjkyqLTVO4wBjbD2pnOSjtNHk+wMrC+ZtLLT4E8GSuXIN+d1Kg30a8?=
 =?us-ascii?Q?jNVzzm4x7DRht7P+BTtKWtAOIKqrK6rwdPrIJ8jht2yJ268sPe382wL/hT6a?=
 =?us-ascii?Q?llpL7Kgq9qFKVDamMv87v5wmnRDkOFFDgYYvTazIDHxqe0teSrDlJcwrtbXi?=
 =?us-ascii?Q?5FfaILPgZA1Pe1gyTx3aqZay50rsBYRG5FHSpafo3LMM4eP+gddxezI7BYUY?=
 =?us-ascii?Q?MkToGxPaCvDeCDawpMc4Afmn79CUsWqdiGwjUEbEQ3DDd2rxMw1LWod3dQ8i?=
 =?us-ascii?Q?2cJvMZNZezeW9jUsjVSahd5sv5oBucImk59M4tJuEOSjU/iLmjy6YX3I1GGl?=
 =?us-ascii?Q?NujbiWDuRGwjmpv/juCHeWJo3HuZh2OjdWG3NLuqhALmH8G/Qj/vKwOHUzMD?=
 =?us-ascii?Q?p8wbyS22KLU9vowL7/+fQhRyPZHhyMQHBNJY8cmfR0uJHK42h5Y3I+37Chnb?=
 =?us-ascii?Q?xWXp8ZhYg2Z+rq6ZaZFOBGvOkrqFqC+ub+8VZIomQtzXxhqxA3vX/o7N/dc+?=
 =?us-ascii?Q?ISBPRrK2QRKbUfCrS9ubyykQEvBiUvhcSkVbRVppxv4M08gDWMrCp6h3L0El?=
 =?us-ascii?Q?kZcTQbIVu20n2FiQhH9M+4K2gDjPV1V6nBTflCkETr7jx7Wtxc09emReXfox?=
 =?us-ascii?Q?6qIU0cnoBSnrTWEiE/75EC7thTikBFxQQ8V4IYjDvhlhJzbxw/A62MUH7mft?=
 =?us-ascii?Q?9M5l0w8Yh6Al7weIecIlg/i84kfUlvqF?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 16:57:26.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a8cf1b-8f2b-4534-7e13-08dd1096e757
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7460

On Thu, Oct 31, 2024 at 07:25:05PM +0000, Mark Brown wrote:
> Unlike with the normal stack there is no API for configuring the the shadow
> stack for a new thread, instead the kernel will dynamically allocate a new
> shadow stack with the same size as the normal stack. This appears to be due
> to the shadow stack series having been in development since before the more
> extensible clone3() was added rather than anything more deliberate.
> 
> Add a paramter to clone3() specifying the shadow stack pointer to use
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
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>

> @@ -101,12 +103,14 @@ struct clone_args {
>  	__aligned_u64 set_tid;
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
> +	__aligned_u64 shadow_stack_pointer;
>  };
>  #endif
>  
> -#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> -#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
> -#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
> +#define CLONE_ARGS_SIZE_VER0  64 /* sizeof first published struct */
> +#define CLONE_ARGS_SIZE_VER1  80 /* sizeof second published struct */
> +#define CLONE_ARGS_SIZE_VER2  88 /* sizeof third published struct */
> +#define CLONE_ARGS_SIZE_VER3  96 /* sizeof fourth published struct */

Acked.

Kind regards,
Yury


