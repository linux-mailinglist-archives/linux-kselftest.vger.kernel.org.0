Return-Path: <linux-kselftest+bounces-41595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3164B59637
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD6D3B391A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCF29B8E0;
	Tue, 16 Sep 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LPcouTH+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LPcouTH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAE3A1D2;
	Tue, 16 Sep 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025843; cv=fail; b=Aa83KeU9pTn+ZkhHQkx4XuqKR5V7p/aFHCrdoZa18TjLsptm46et0FECDkbJ98SWZi+WwR09QRfx17WZx1scjX3aEiCqAFw8dNGbSdagypHGNAmapUMBupqvfmyt294XZy3J3MBpEZcsIwPYf7zKTZRZBCU9lLLNiWuQJ7EOolA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025843; c=relaxed/simple;
	bh=8yf7eQdW2PcS27GksATreXO7C6jIy7ETI5LxFQgh9kI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+3P8LujbFktrfgLBZbEDclb9mvEPauXtF6MJ6wnde33idD0V5/E6WGDZ3Qp+UzzsQqUlC9MTPYiPqf8TdsxVxYzpDawB7NoNyhbeSpVLzRLem4xaxPeapvna5IBlnwMdJ+CXEoBzy0bbc24M7pp4IY7v9pjhopJgOeNJOhCY2M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LPcouTH+; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LPcouTH+; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=su6N6ouelmNfuPxCp2AI7FCrPLI9NAdid6MnIgLJ78iPigq5Nl4ZLIOZTv1ZSc8LuwLHvEVrqFWoxsLN6tunRNFip7rRoGf8pdrgf3uL9sLP5tuGX798EXFqozSkAzakvthDBcFuowPCGZmZQizdkdEPSnCS71Z6v0a7unTMQUUisIC3Konv/kmtKlpZNEZPZrThNkiHT3fisTDjaxDROrZCMXT+Z8L0EoFNkNOcCPk/L6lLNCl0CLYqFFkmg7tZOUjahYvNd5QO5fDDIO19XqV1nb5llp9NSx1Oae/iih7mKeXtiVXdkAUQjm8q/ha8+GYtTuJ/6w3Zu//vHjiVBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jeK/9mtzaZ5BmNtTW113bO9Jo3qyjSJT6i9hdwFra4=;
 b=ceqhg/38JP27H770SBfsn2pBL8PtsgdOdfYFyMCdKDvDu0qOZgQblySz573r2kfh54KfACHH1U4CE82bziTOU0Ae1BQDbbHu93Sdri00H59ZbxtbOYr9bEZHyUbwhY44CL6iMW1QTonJgnZQ7kSNt+Wk0Nm3XPBq1CrJe4Qd+rIIRdyOuA6h3a2UdIPZlr6uNVXDn0NJ7GCqWqID+uBKYQ58GDxfX+5sX94NgpBzgkLjNgKKjQ1MOsasjp0znqAf41uKkvr1YHyG0rj1V0LcGCtuPj3PmcTGfAE4dqk8/AO+t0vDMPi/lUSdLeycUfl7rNFIrbd0hnvs3nmUAyblPw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jeK/9mtzaZ5BmNtTW113bO9Jo3qyjSJT6i9hdwFra4=;
 b=LPcouTH+9nG/f9XGl/kgpoHPxXeh9EU6rnaYwxAxGfQ3mr32QiEASG+oAmnS5xoUGGwZ1HN72GoDiI3k7WwpMdNLpZtp/wN4CjOsK9FtIQBk4eAdifMab6XFA47TVrS2WqsBqt+rBEwNCiC2ttI/7ENTIHqkvr1RZ8pQmPV1urM=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by AS8PR08MB9388.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ab::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 16 Sep
 2025 12:30:35 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::c5) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 12:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 12:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2Ayz5sFETx6bgt3c6sUz3cz9ijgTFJU2Kp4K77sWmum98EJSXf9lyBnL0o+rwEgt+agi9olocNxFuwkMJsMYOn6wUjqku4O1R794l1IsDgwZDWluQuUOaYk5M7zJQpstST7PmwxNYGK9mM22oln4L7vjESkJXbHIGxzotrvrs3KlnLDodiScjipes88bm5GEgT9sU0Rf4vHFUydDl+9Wwo9pf60cg+zUWYgmYFakPteQyxDhzCn61h+C38AYJiyfzfennS9DCiMvN5dKVGZMeqUrpuOp++2LDIjd2FXxzCghtz+gt/p7eMZsm2RulBS50l+U5WjG41SryGx9Cdu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jeK/9mtzaZ5BmNtTW113bO9Jo3qyjSJT6i9hdwFra4=;
 b=ddFzfPQXRMg152+NW2/ZtJj0hTz8afHH63l4LLHUfOMQoClRNAOjwvDvXWQen8kQ2fgqXEGAXZex3oDekJ7EtKol3nt8siifYjyEjt3apZ1i7knfxkh8UoXd0zQl8GDZx/3NiZCOKQM7wQ/4YYl9PGoZKVPUIZrTmqghbxG3P8wEzTy5M6EfTebF3nQhCm/XkLuBZYV0Opwxh4zWBtGBOLh/wHvqN5Jk/CJlN33axZ7RCZnPm6KCGqH8xDNkNtFRJLXUQDrsffAcQv2STPxBw9JhY6fbRsR954pxGH6ipq36fmRI412QyzEwEcGgoDhnP+8WKK47jgpLPRswFrjDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jeK/9mtzaZ5BmNtTW113bO9Jo3qyjSJT6i9hdwFra4=;
 b=LPcouTH+9nG/f9XGl/kgpoHPxXeh9EU6rnaYwxAxGfQ3mr32QiEASG+oAmnS5xoUGGwZ1HN72GoDiI3k7WwpMdNLpZtp/wN4CjOsK9FtIQBk4eAdifMab6XFA47TVrS2WqsBqt+rBEwNCiC2ttI/7ENTIHqkvr1RZ8pQmPV1urM=
Received: from AS4P189CA0032.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::18)
 by VI0PR08MB10428.eurprd08.prod.outlook.com (2603:10a6:800:1b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 12:29:59 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::ce) by AS4P189CA0032.outlook.office365.com
 (2603:10a6:20b:5dd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 12:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.0 via Frontend Transport; Tue, 16 Sep 2025 12:29:59 +0000
Received: from AZ-NEU-EXJ02.Arm.com (10.240.25.139) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 12:29:50 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EXJ02.Arm.com
 (10.240.25.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.27; Tue, 16 Sep
 2025 12:29:49 +0000
Received: from arm.com (10.1.33.140) by mail.arm.com (10.240.25.134) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Sep 2025 12:29:49 +0000
Date: Tue, 16 Sep 2025 13:29:48 +0100
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
	Will Deacon <will@kernel.org>, <jannh@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Wilco Dijkstra <wilco.dijkstra@arm.com>,
	<linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH v21 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aMlYPB6JPYYpvgOO@arm.com>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
 <20250916-clone3-shadow-stack-v21-4-910493527013@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916-clone3-shadow-stack-v21-4-910493527013@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F98:EE_|VI0PR08MB10428:EE_|DU2PEPF00028D11:EE_|AS8PR08MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c1eeea-f906-4ec9-1c8d-08ddf51cd478
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?A2A5RzOsCPvCDy87Oa+Oapy4LCFrY31XJrUDuS9iJ1K4qAUT8pNgIxC+CtiV?=
 =?us-ascii?Q?XyYYFf6K0lPUbD71QxbF3Mu3Ug+e9OrCn32W5i3j23MlszvXHHSMFWQSGJ7F?=
 =?us-ascii?Q?5vo8FZT8IJTF4Xf5tjvlDHiZQZ5vydYvD0qJU56zKKWLKKkNBq+22fegDgUr?=
 =?us-ascii?Q?tGAc8Q/9OopKKx5C41Vqwp6J9DFJFW0TsKe9n1vVFBr+a/GnIAn6tUTm3ntA?=
 =?us-ascii?Q?tbWnu/eIDsn/ZEV2U2PmozvTC1kt08PrbvyihlPh8AEvIYafVv54riVp3APG?=
 =?us-ascii?Q?Cof9Smy72WX2JjEfqgPjx/IzxVpl7mXTDAiONb/LRHnkWPZSkdEK+i/9Q9M/?=
 =?us-ascii?Q?yODvjt18UQYhQ+r+cZQZttXj0YSahOtQup0Gp2/obr+6lj6P7oRfnVvQOMqS?=
 =?us-ascii?Q?tteDCmXHTvSHHoRUDd2lJSK8qeaPTs2P5Q8YZ8IUFG3HOB9Md0+zAiPx7/ud?=
 =?us-ascii?Q?8Id+Jd8IYs+oizcN69/JFe12tRyxvdkvO92KJG2SjsHKj0xooAiRVJnaRVr+?=
 =?us-ascii?Q?+IdnKcay5kDuu4q+9/be2xebklZiWulUh17A6XCxvdEXU7LvZ8o2gPiwZfxg?=
 =?us-ascii?Q?2lsVjbYaeOTZ7gr1Ppuyeik0zgDjjqJrxFE3MAq8h8SHPhOu6eCd0KTDSMZv?=
 =?us-ascii?Q?8Bvm9kIyXMZ4iWAI323dyJK9XUUhG6+56Sa2FWxN0dbVXjDzFn/U3+STdAKp?=
 =?us-ascii?Q?tIYb3SbOgq/3JzA2PmIYyMQ+mdCl6GLWu1GITd6eV3sVjkt7Mpl+DHzbMoFv?=
 =?us-ascii?Q?4mLQyMVDk283HeCzFosV6BDOp4u4484lZk8gtQ1VLD3Il7wl8eeHQJaXtvch?=
 =?us-ascii?Q?Ts432pbbAnYJXBl/8wlQzAxcpAPR3u5Bacv1StOKiLYS0TcaOjMC1bX52Zwy?=
 =?us-ascii?Q?4HaBTmEvWrO2tKGyMi8YAxh1pDZv05Uv55gZ5crwlo73XAG+zejZap34fMuw?=
 =?us-ascii?Q?qwJjL49n/Lim9B1QCH0c75HbywS4hbfemORw8I561gFDtkNiWFin71CtOvtW?=
 =?us-ascii?Q?j7kfkhvbD+CEDz9EbaVmUTV1cWFihqIqn5Q3SJKNrvyxmpiXGyHYpDtQA6qD?=
 =?us-ascii?Q?xMkhMQqGvZSF2DGfP/n9gQUnhBwIzhAyH+Dyxa7sTJTgVIkgoBDRePSYjD85?=
 =?us-ascii?Q?sJlpmIx90b3J2uURhl7K/levMZmRAcAaXnXGy9ee8OZ84GZwmCGSKw5Wb6xG?=
 =?us-ascii?Q?zUnj0YKvN/87GpuLFGDADagFvZJ0iepepgGOQMdJoj3Em+LYZBQYJ/whJnxc?=
 =?us-ascii?Q?xU0yfvJ9rJCnxAkgfEXmbtncjHwQgvxTFmoszwotaS7RzaOwcnIagWnsCyeM?=
 =?us-ascii?Q?7IoKQp4drFHL/QEA3NBZcxKG/mhfIPKJ+xq/VuwvAv8B6gtQuJ3NJHjD6z0p?=
 =?us-ascii?Q?9RbFc3OTX5ir1zQoDzhpOQKVx6jbSFvkFeNjrB/LECXg3LJ6ZrVL9PfmpUlY?=
 =?us-ascii?Q?+69qJAU1ZJyMq8OhHnyv7YDFYENc7vjVsMuQsw2TdqmwfuErPhygOA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10428
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4649acbf-9d43-42fa-9af4-08ddf51cc059
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|35042699022|1800799024|376014|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wJPbT4DWbn03/1Kl5UbMNCkhk3JxxxontdLkzqRqgzEUvxrpM9SVjqJ2deo?=
 =?us-ascii?Q?/Pn/7eoy3iYsLkcV6omrjFf8GfO3Xvjv/idM3CQ6R8kA5vZGTbSAGSDYL2V/?=
 =?us-ascii?Q?kG6YRkBoq2RQz2U/y+1vuJtVgbYKopXR6a8apKnbN+6HqfYPIhhjtjHqy7Gj?=
 =?us-ascii?Q?dWKcThL3XOHsF++5GwJz03/Z08Rj1uYxRFtzTUoxFvJW52r8Xn7XH99FR5/8?=
 =?us-ascii?Q?3cGk+r4HAxnp1XQpDCV4EWd2oPCutBNboa/SLZU6ktVkkUs3/FN81UkHKZso?=
 =?us-ascii?Q?SiCeRGmFJAY5Yz0jBhlXcjfOzbJwvgE1uUcAwn4Vda/yZgFVZFAO4L1wJYW0?=
 =?us-ascii?Q?k64ek7G5GgbZ/sKbDVCW7/T1ZG3tPYLtEJE47dPGQukyNYavfHlcUzE6t2wf?=
 =?us-ascii?Q?FRulftAGKFdRWg94hKVy/qf2/w1LhPIw7fdYT04eC6UMjPTwqEVmtgZqc1Y8?=
 =?us-ascii?Q?eme2tFBhtUmfhJuUkEVT5pqA8IemLlDqGAvLfhVKQ+TRqJJdapFZUqAHmuX4?=
 =?us-ascii?Q?3E6BCFFRwpXQfEsLXwMtm4suNrTBN/AhDFWM4fxvUtCCrkpCrc/+MRZGrG0j?=
 =?us-ascii?Q?wghr6GyPaxcYZME94O3h9VeL2Le9ltKk5lHNgIkXtAj+62XTmh2Ajjexudbl?=
 =?us-ascii?Q?UnrViviurS4YN5o5VLeL3B6bZZXraYOYEN6NtRkgdHhdqcmr4KAWJnCaomwg?=
 =?us-ascii?Q?/fwb8AXrJmKIJSEEw4m3dhv3YQj9A6stPE04u28+xtVOaETLIPk7uynR8z8J?=
 =?us-ascii?Q?4bGKdlJ6x+HfDiV/VcSrFogi1DxED0fAywjm1hwT4qeq9VXJ6SmGF4kUv1XE?=
 =?us-ascii?Q?nVGHaBwS1Q43P1In+L8j03Fv4BqNKeCTZbg0r2+vD8FB4wP2NUSI1aDrV6m/?=
 =?us-ascii?Q?YV50XsH2pSO0GRj5KtfJCg4GVs9BFNeUhR9rqwkTgEKWZicRq2PIeh+KiXQK?=
 =?us-ascii?Q?oRwZsykLnJETO1ty518yPDEdzi78Jjybt2rUzCy5XQ5ZwGiWGRQtjxY+qu/T?=
 =?us-ascii?Q?qLPwjpvspleVfDnRH3zF7xQrJx8ou8M29l3/9GoK2Bv7Srnf/+IxCDm253oc?=
 =?us-ascii?Q?XR+EwcIVjgArastX6yRIVyuMSBH4mxg3KO6HmXd/EpPOy1nTfsXGMf/v0FCB?=
 =?us-ascii?Q?ELB1rwKoXOWeZj/H11R9xmOyZP36WaEceNiGLBQt7ezQvs0SFp8nzYxwJ1uL?=
 =?us-ascii?Q?RIJEtjeM+qx4IVaN2KlbkKUeDQJ5hJHMFskTGW7Qov2TAnMnGyQu6ownaeH+?=
 =?us-ascii?Q?IwsvL58Ba7r23ET37Xu4tm9FADyi6D9jFnCNckuBZ/zAZQFH6kYolIGP1/0r?=
 =?us-ascii?Q?q1PuP6SNm96RpCN299gmKD8kWUaOBLhrEY5numUBs0b62RXHQA2HGOBftECp?=
 =?us-ascii?Q?8H/sCGkRb7bT4/BGoxrZPTT+Gxs8pN04jmANFsJ9wo+MIKXvXmurJxy+6RSj?=
 =?us-ascii?Q?w6ur9cPRD8xEhqdZD4f9gN30BzEhxAPxx1FqayWHJdzLclYEPvqWVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(35042699022)(1800799024)(376014)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:30:32.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c1eeea-f906-4ec9-1c8d-08ddf51cd478
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9388

On Tue, Sep 16, 2025 at 12:12:09AM +0100, Mark Brown wrote:
> Unlike with the normal stack there is no API for configuring the shadow
> stack for a new thread, instead the kernel will dynamically allocate a
> new shadow stack with the same size as the normal stack. This appears to
> be due to the shadow stack series having been in development since
> before the more extensible clone3() was added rather than anything more
> deliberate.
> 
> Add a parameter to clone3() specifying a shadow stack pointer to use
> for the new thread, this is inconsistent with the way we specify the
> normal stack but during review concerns were expressed about having to
> identify where the shadow stack pointer should be placed especially in
> cases where the shadow stack has been previously active.  If no shadow
> stack is specified then the existing implicit allocation behaviour is
> maintained.
> 
> ...
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
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

I've tested this version together with my Glibc patches [1]. No issues
to report.

Tested-by: Yury Khrustalev <yury.khrustalev@arm.com>

[1]: https://inbox.sourceware.org/libc-alpha/20250916122757.2341920-1-yury.khrustalev@arm.com/

> ---
>  arch/arm64/mm/gcs.c              | 47 +++++++++++++++++++-
>  arch/x86/include/asm/shstk.h     | 11 +++--
>  arch/x86/kernel/process.c        |  2 +-
>  arch/x86/kernel/shstk.c          | 53 ++++++++++++++++++++---
>  include/asm-generic/cacheflush.h | 11 +++++
>  include/linux/sched/task.h       | 17 ++++++++
>  include/uapi/linux/sched.h       |  9 ++--
>  kernel/fork.c                    | 93 ++++++++++++++++++++++++++++++++++------
>  8 files changed, 217 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index 3abcbf9adb5c..fd1d5a6655de 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -43,8 +43,23 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
>  {
>  	unsigned long addr, size;
>  
> -	if (!system_supports_gcs())
> +	if (!system_supports_gcs()) {
> +		if (args->shstk_token)
> +			return -EINVAL;
> +
>  		return 0;
> +	}
> +
> +	/*
> +	 * If the user specified a GCS then use it, otherwise fall
> +	 * back to a default allocation strategy. Validation is done
> +	 * in arch_shstk_validate_clone().
> +	 */
> +	if (args->shstk_token) {
> +		tsk->thread.gcs_base = 0;
> +		tsk->thread.gcs_size = 0;
> +		return 0;
> +	}
>  
>  	if (!task_gcs_el0_enabled(tsk))
>  		return 0;
> @@ -68,6 +83,36 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
>  	return 0;
>  }
>  
> +static bool gcs_consume_token(struct vm_area_struct *vma, struct page *page,
> +			      unsigned long user_addr)
> +{
> +	u64 expected = GCS_CAP(user_addr);
> +	u64 *token = page_address(page) + offset_in_page(user_addr);
> +
> +	if (!cmpxchg_to_user_page(vma, page, user_addr, token, expected, 0))
> +		return false;
> +	set_page_dirty_lock(page);
> +
> +	return true;
> +}
> +
> +int arch_shstk_validate_clone(struct task_struct *tsk,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args)
> +{
> +	unsigned long gcspr_el0;
> +	int ret = 0;
> +
> +	gcspr_el0 = args->shstk_token;
> +	if (!gcs_consume_token(vma, page, gcspr_el0))
> +		return -EINVAL;
> +
> +	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
> +
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>  {
>  	unsigned long alloc_size;
> diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
> index 0f50e0125943..827e983430aa 100644
> --- a/arch/x86/include/asm/shstk.h
> +++ b/arch/x86/include/asm/shstk.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  
>  struct task_struct;
> +struct kernel_clone_args;
>  struct ksignal;
>  
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
> @@ -16,8 +17,8 @@ struct thread_shstk {
>  
>  long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
>  void reset_thread_features(void);
> -unsigned long shstk_alloc_thread_stack(struct task_struct *p, u64 clone_flags,
> -				       unsigned long stack_size);
> +unsigned long shstk_alloc_thread_stack(struct task_struct *p,
> +				       const struct kernel_clone_args *args);
>  void shstk_free(struct task_struct *p);
>  int setup_signal_shadow_stack(struct ksignal *ksig);
>  int restore_signal_shadow_stack(void);
> @@ -28,8 +29,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
>  			       unsigned long arg2) { return -EINVAL; }
>  static inline void reset_thread_features(void) {}
>  static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
> -						     u64 clone_flags,
> -						     unsigned long stack_size) { return 0; }
> +						     const struct kernel_clone_args *args)
> +{
> +	return 0;
> +}
>  static inline void shstk_free(struct task_struct *p) {}
>  static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
>  static inline int restore_signal_shadow_stack(void) { return 0; }
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index e3a3987b0c4f..e8c8447cc0fd 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -209,7 +209,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
>  	 * update it.
>  	 */
> -	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
> +	new_ssp = shstk_alloc_thread_stack(p, args);
>  	if (IS_ERR_VALUE(new_ssp))
>  		return PTR_ERR((void *)new_ssp);
>  
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 5eba6c5a6775..56893523b6f2 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -191,18 +191,61 @@ void reset_thread_features(void)
>  	current->thread.features_locked = 0;
>  }
>  
> -unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, u64 clone_flags,
> -				       unsigned long stack_size)
> +int arch_shstk_validate_clone(struct task_struct *t,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args)
> +{
> +	void *maddr = page_address(page);
> +	unsigned long token;
> +	int offset;
> +	u64 expected;
> +
> +	/*
> +	 * kernel_clone_args() verification assures token address is 8
> +	 * byte aligned.
> +	 */
> +	token = args->shstk_token;
> +	expected = (token + SS_FRAME_SIZE) | BIT(0);
> +	offset = offset_in_page(token);
> +
> +	if (!cmpxchg_to_user_page(vma, page, token, (unsigned long *)(maddr + offset),
> +				  expected, 0))
> +		return -EINVAL;
> +	set_page_dirty_lock(page);
> +
> +	return 0;
> +}
> +
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +				       const struct kernel_clone_args *args)
>  {
>  	struct thread_shstk *shstk = &tsk->thread.shstk;
> +	u64 clone_flags = args->flags;
>  	unsigned long addr, size;
>  
>  	/*
>  	 * If shadow stack is not enabled on the new thread, skip any
> -	 * switch to a new shadow stack.
> +	 * implicit switch to a new shadow stack and reject attempts to
> +	 * explicitly specify one.
>  	 */
> -	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
> +		if (args->shstk_token)
> +			return (unsigned long)ERR_PTR(-EINVAL);
> +
>  		return 0;
> +	}
> +
> +	/*
> +	 * If the user specified a shadow stack then use it, otherwise
> +	 * fall back to a default allocation strategy. Validation is
> +	 * done in arch_shstk_validate_clone().
> +	 */
> +	if (args->shstk_token) {
> +		shstk->base = 0;
> +		shstk->size = 0;
> +		return args->shstk_token + 8;
> +	}
>  
>  	/*
>  	 * For CLONE_VFORK the child will share the parents shadow stack.
> @@ -222,7 +265,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, u64 clone_flags,
>  	if (!(clone_flags & CLONE_VM))
>  		return 0;
>  
> -	size = adjust_shstk_size(stack_size);
> +	size = adjust_shstk_size(args->stack_size);
>  	addr = alloc_shstk(0, size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index 7ee8a179d103..96cc0c7a5c90 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -124,4 +124,15 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  	} while (0)
>  #endif
>  
> +#ifndef cmpxchg_to_user_page
> +#define cmpxchg_to_user_page(vma, page, vaddr, ptr, old, new)  \
> +({							  \
> +	bool ret;						  \
> +								  \
> +	ret = try_cmpxchg(ptr, &old, new);			  \
> +	flush_icache_user_page(vma, page, vaddr, sizeof(*ptr));	  \
> +	ret;							  \
> +})
> +#endif
> +
>  #endif /* _ASM_GENERIC_CACHEFLUSH_H */
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 34d6a0e108c3..96fb485ff2dd 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -16,6 +16,7 @@ struct task_struct;
>  struct rusage;
>  union thread_union;
>  struct css_set;
> +struct vm_area_struct;
>  
>  /* All the bits taken by the old clone syscall. */
>  #define CLONE_LEGACY_FLAGS 0xffffffffULL
> @@ -44,6 +45,7 @@ struct kernel_clone_args {
>  	struct cgroup *cgrp;
>  	struct css_set *cset;
>  	unsigned int kill_seq;
> +	unsigned long shstk_token;
>  };
>  
>  /*
> @@ -226,4 +228,19 @@ static inline void task_unlock(struct task_struct *p)
>  
>  DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
>  
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> +int arch_shstk_validate_clone(struct task_struct *p,
> +			      struct vm_area_struct *vma,
> +			      struct page *page,
> +			      struct kernel_clone_args *args);
> +#else
> +static inline int arch_shstk_validate_clone(struct task_struct *p,
> +					    struct vm_area_struct *vma,
> +					    struct page *page,
> +					    struct kernel_clone_args *args)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_SCHED_TASK_H */
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 359a14cc76a4..7e18e7b3df3a 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -84,6 +84,7 @@
>   *                kernel's limit of nested PID namespaces.
>   * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
>   *                a file descriptor for the cgroup.
> + * @shstk_token:  Pointer to shadow stack token at top of stack.
>   *
>   * The structure is versioned by size and thus extensible.
>   * New struct members must go at the end of the struct and
> @@ -101,12 +102,14 @@ struct clone_args {
>  	__aligned_u64 set_tid;
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
> +	__aligned_u64 shstk_token;
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
>  
>  /*
>   * Scheduling policies
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d6e1fb11eff9..0dbfc8828e08 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1907,6 +1907,51 @@ static bool need_futex_hash_allocate_default(u64 clone_flags)
>  	return true;
>  }
>  
> +static int shstk_validate_clone(struct task_struct *p,
> +				struct kernel_clone_args *args)
> +{
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	unsigned long addr;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
> +		return 0;
> +
> +	if (!args->shstk_token)
> +		return 0;
> +
> +	mm = get_task_mm(p);
> +	if (!mm)
> +		return -EFAULT;
> +
> +	mmap_read_lock(mm);
> +
> +	addr = untagged_addr_remote(mm, args->shstk_token);
> +	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
> +					&vma);
> +	if (IS_ERR(page)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (!(vma->vm_flags & VM_SHADOW_STACK) ||
> +	    !(vma->vm_flags & VM_WRITE)) {
> +		ret = -EFAULT;
> +		goto out_page;
> +	}
> +
> +	ret = arch_shstk_validate_clone(p, vma, page, args);
> +
> +out_page:
> +	put_page(page);
> +out:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	return ret;
> +}
> +
>  /*
>   * This creates a new process as a copy of the old one,
>   * but does not actually start it yet.
> @@ -2182,6 +2227,9 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_namespaces;
>  	retval = copy_thread(p, args);
> +	if (retval)
> +		goto bad_fork_cleanup_io;
> +	retval = shstk_validate_clone(p, args);
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> @@ -2763,7 +2811,9 @@ static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		     CLONE_ARGS_SIZE_VER1);
>  	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
>  		     CLONE_ARGS_SIZE_VER2);
> -	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
> +	BUILD_BUG_ON(offsetofend(struct clone_args, shstk_token) !=
> +		     CLONE_ARGS_SIZE_VER3);
> +	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
>  
>  	if (unlikely(usize > PAGE_SIZE))
>  		return -E2BIG;
> @@ -2796,16 +2846,17 @@ static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		return -EINVAL;
>  
>  	*kargs = (struct kernel_clone_args){
> -		.flags		= args.flags,
> -		.pidfd		= u64_to_user_ptr(args.pidfd),
> -		.child_tid	= u64_to_user_ptr(args.child_tid),
> -		.parent_tid	= u64_to_user_ptr(args.parent_tid),
> -		.exit_signal	= args.exit_signal,
> -		.stack		= args.stack,
> -		.stack_size	= args.stack_size,
> -		.tls		= args.tls,
> -		.set_tid_size	= args.set_tid_size,
> -		.cgroup		= args.cgroup,
> +		.flags			= args.flags,
> +		.pidfd			= u64_to_user_ptr(args.pidfd),
> +		.child_tid		= u64_to_user_ptr(args.child_tid),
> +		.parent_tid		= u64_to_user_ptr(args.parent_tid),
> +		.exit_signal		= args.exit_signal,
> +		.stack			= args.stack,
> +		.stack_size		= args.stack_size,
> +		.tls			= args.tls,
> +		.set_tid_size		= args.set_tid_size,
> +		.cgroup			= args.cgroup,
> +		.shstk_token		= args.shstk_token,
>  	};
>  
>  	if (args.set_tid &&
> @@ -2846,6 +2897,24 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
>  	return true;
>  }
>  
> +/**
> + * clone3_shadow_stack_valid - check and prepare shadow stack
> + * @kargs: kernel clone args
> + *
> + * Verify that shadow stacks are only enabled if supported.
> + */
> +static inline bool clone3_shadow_stack_valid(struct kernel_clone_args *kargs)
> +{
> +	if (!kargs->shstk_token)
> +		return true;
> +
> +	if (!IS_ALIGNED(kargs->shstk_token, sizeof(void *)))
> +		return false;
> +
> +	/* Fail if the kernel wasn't built with shadow stacks */
> +	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);
> +}
> +
>  static bool clone3_args_valid(struct kernel_clone_args *kargs)
>  {
>  	/* Verify that no unknown flags are passed along. */
> @@ -2868,7 +2937,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
>  	    kargs->exit_signal)
>  		return false;
>  
> -	if (!clone3_stack_valid(kargs))
> +	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
>  		return false;
>  
>  	return true;
> 
> -- 
> 2.47.2
> 

