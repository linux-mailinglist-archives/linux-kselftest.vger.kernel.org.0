Return-Path: <linux-kselftest+bounces-36336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0911AF5BBF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5571C43FB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A130AAC7;
	Wed,  2 Jul 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k0yROz7v";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k0yROz7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA93093D8;
	Wed,  2 Jul 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467993; cv=fail; b=RPgNKyK3ywg8C/RFLJlZgkzYEfcm1ve9NVmQ+7XX46PE4EN/0DSsOkJfxdikqMw1S+FjDrCZTzWXfOXCT/TNBcTtldloLuAm+U03HnwUZ3OekPuAhef0p8n4k0RkpGpBDVNahvfqH9ter80wsztjN/ewIBkm1BcVtQXmlEstT2k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467993; c=relaxed/simple;
	bh=AS3umu1l7izy3O1gQz0SirCqM7iNkw46fwQJGhj7GPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rceJZ4BVE3OLsI4RiJuzauhB3Wjy8Vl6qq5zbH7JQjd9dwU6xnL6roGFR2eCcE9pM9RERPmyq+JXjRYeDLYLDXPN/BYDcpnq9RmGLsyYmCzQVc099u3IMRO1gOtGUfnVfz7BkAV2z+ShXbBBfzumEdxrXUIf+gj8ZImgfCSI+Ws=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k0yROz7v; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k0yROz7v; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MjYeWGnq9Z4GVHyJhkLX6KG6p5wb5zcXIAcqJcsctqPDStMnfqBELW5Wsib865UGURn5Mg1uFdrE8Cl75goM5U0Z7XLMv1YpiOJQ4DcvPF186eK4etpV+Lr35o0fMKKJDGaDHqmjN5f6XQ2fP22M0qn/fSAShNTBJVx9Maiu0XP55UuVFbuOaS9t4IjW/ZASiD08MJpbUmS/twDNwwhBsvJeRhVlLtJJG08VHeyG2ErTiZxhyG6JeX4aeTg7YaWBY9qXsoJpeAuhy7M5XW+++0/8984EIdZrvdJgjjCLqRJZX7CMly7zMbfe8QcYSi0GniHq02Uj7gSzuIjSSU6efw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWo6t5TIyJ1Moh+6j+79WM0AdL4CcfT8YqHa0XLdeFA=;
 b=gQvSheQC9huVbxj0kkptqHSS6Qjn9duV3t0ewfD5hLxNNbue9rIoNj0AGQltl/fsdhTfnCfjEMQfH7H852kXqNYQioQ7Nbwx1BhI8ZQdroXmQq1hpjlPJQN3kfJrgWagEkxK+VMBgboX/vfQZ+h9GAkZfcQLfybQq8Tj/UpgKCuZWbnFP72WAwlnvnlZXZUd9qpWMoS82lHFTTajrqo+oDTjfeeG+0CJuj9OekBAo5UBUI+j3Mg/3eqLmgjcxXq8YFM1RR03PX0q1LvlQJkzvoDuMqPD7DwBkk9eVOUfvCQ1+A0fbk7zapTV4a0MEHo1w3n2TJ6hvo68XZYd8yFBTg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWo6t5TIyJ1Moh+6j+79WM0AdL4CcfT8YqHa0XLdeFA=;
 b=k0yROz7vsrvbrczXNgqztRL1jPf2T7PxYOsoyfnyRY2XgOWqxE1VfLoU9ZUkocBV4IECpXgYfTjjsMDnX+YKM5IUxWYm6WLinYYHd+o/hyEdv4ow9r88O6aaHwvCwpdj00sar56DAxTQfEaPdrqm68cx1rhg/E2OMcVkAKBuy2M=
Received: from AS4P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::10)
 by DB9PR08MB6554.eurprd08.prod.outlook.com (2603:10a6:10:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 14:53:04 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::d2) by AS4P190CA0016.outlook.office365.com
 (2603:10a6:20b:5d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 14:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 14:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nopNWRXX6MEJ1Aw6qkdf24lCEnoqjkmL8NeEO2x/sxw4I+DMzPz18Dsh87G46M1Btdh8x3LTxPchv7fF+zMm6cICsZvrCOc8jxLjBTlh3MrChe8hvk8WywQmb31Lu60MAFPlTZLGGXMWGiq+iGpqoXNE/aNNBwg/Ms72/kYG5rOwShzfxZu3lGypg+V+FjWIucWBqJ2VDDHGDL+Om4zPb0BO9NkyvbyDtLGdNhdZREkpuwCVHT0EVHrI2F+oDyIA8w0a1kmLZUdQWxiq9aBmyUwaZ0JPoU+jI0GZH7CGqvHsEq6l6enum3YT97bbX+Q6fzlrv14whRqDbLxGmSsSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWo6t5TIyJ1Moh+6j+79WM0AdL4CcfT8YqHa0XLdeFA=;
 b=dA8nqRaHZCmryYaa0CcfuGAwk9d3LclUbLHPgHe/FfVIP+6LgjnqQBkTpD1CYqD/DtJN8UhcMZH/1swlPrQ2ZzK20BXz2X45/8T8Z1OR4yi9sOluMu/Bji1L5TUNwSro/pCN6XwkeOV3d3Bh15wodpVHScKIq95EePvXRTrhQQVB8wzc/psUR43qNMxeWLv+RC8bxJu1WNptHZ3CmSwt5m/4jp+v8vMTOxzo+tEFcauZQ3LsGWaqFqm0R0mHI4JszxRZOTBouV3NRiAinCWOABPU7Q0iwukDwlmeyJMiHf7UPtqx7jIToq0FfvyY3qbVNKIM8Irn6Wi/AGfO5GT/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWo6t5TIyJ1Moh+6j+79WM0AdL4CcfT8YqHa0XLdeFA=;
 b=k0yROz7vsrvbrczXNgqztRL1jPf2T7PxYOsoyfnyRY2XgOWqxE1VfLoU9ZUkocBV4IECpXgYfTjjsMDnX+YKM5IUxWYm6WLinYYHd+o/hyEdv4ow9r88O6aaHwvCwpdj00sar56DAxTQfEaPdrqm68cx1rhg/E2OMcVkAKBuy2M=
Received: from PA7P264CA0484.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::24)
 by AM9PR08MB6145.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 14:52:29 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:102:3dc:cafe::56) by PA7P264CA0484.outlook.office365.com
 (2603:10a6:102:3dc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 14:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 14:52:28 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 14:52:20 +0000
Received: from arm.com (10.1.28.159) by mail.arm.com (10.240.25.133) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 14:52:19 +0000
Date: Wed, 2 Jul 2025 15:52:17 +0100
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
	Will Deacon <will@kernel.org>, <jannh@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Wilco Dijkstra <wilco.dijkstra@arm.com>,
	<linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH v18 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aGVHoUQjJQBHREEJ@arm.com>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
 <20250702-clone3-shadow-stack-v18-4-7965d2b694db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702-clone3-shadow-stack-v18-4-7965d2b694db@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF000001B1:EE_|AM9PR08MB6145:EE_|AM1PEPF000252DB:EE_|DB9PR08MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc3daaa-9da3-4e2b-fcf3-08ddb978255a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?COQKvQs+k+EmLSH5HY5hB6rderh9EG9UJ2DIIeJx6tTuE+Q93XvrtssKagIt?=
 =?us-ascii?Q?njQCTVOU6hRSo2Er2GwWf/q0fWNmN9uSn53v0aKGGZzh+dUklCBhbrAnqm+5?=
 =?us-ascii?Q?/p70zhrqHFH5J2M+t1+DnKdX7KvZOmOnAO4eTcxdOK9tMHns5FVwg6m+Duv/?=
 =?us-ascii?Q?XxTRbEQvw71cwAioUJxArSIBx0wxFC4eP7Rzbah5GHh4NEImQ1D5ni+8gZbi?=
 =?us-ascii?Q?nMn+gHygiJs08Bxtik+gRBljy5ElQ/05KN9O57lvuS/ELc8Do7WIJUZ8PqnW?=
 =?us-ascii?Q?MuayrPOcV8L16XlDUE5xVh7k1Mv5Kbw/Z/prt+BKcMnG7QRpEoI8GbeE51cb?=
 =?us-ascii?Q?H/Ce5uY5me1k88v6RvR2O6JM0euDIv8VF9e8hdYhQ3Vrf4SG/zZuDq6gTfyf?=
 =?us-ascii?Q?W9dnxZ4n9mSQ8bkf6hBHJ1eL4MsLLhLNQhYCOaIMdQsL/S6cRCzaWl8lG02A?=
 =?us-ascii?Q?vTo0Pjq0X+zrSoRVAd23kn3QrrLiR6TY/DDOJRC35/tNeOP+5p+u10FeDqew?=
 =?us-ascii?Q?tftmiUftyC4En9cKKsALmQjbSGqdgnncxYx3AA8ZdwJbAI5+jes77eLiu9Bj?=
 =?us-ascii?Q?7TOb3k0fJBkTBP+5gQkM7+SkB3SpIQoRe/NLL12tgx6qNa5KRqZH5sdEJJaj?=
 =?us-ascii?Q?wZNZtBAN9UgUEAE56e9hYzQ9YL998kRaLw6aSNVB9FqMJ5IUt0CWH25MC+R5?=
 =?us-ascii?Q?nzLrSoq7LQee1iMFtUjP/8ifu3WWaECW3pgXa0oHPVGOmKWD+tD5LodFLDVB?=
 =?us-ascii?Q?sZ5u3dQ2BIvRqJPN7nSG3WLyb9HP+J94uyLYlI8PbBdGzhO6n9PAQ2SpZOgF?=
 =?us-ascii?Q?ItBWgEhGZypLz/sneWVKKWwNFSWPWu4paGXxUSOdEQiChJ/1ydT6PlI0++2H?=
 =?us-ascii?Q?pvXDjuUd+OQu1uqDrCKTzY+uUA9zxDQ4dRVBMdseJeamXX34IVYVvfA4UNer?=
 =?us-ascii?Q?nF4H48XICfTQBlbD9kexJBmQucSB26rxuNGC00sKz0Sdkfm4k9C7f0ymGjmu?=
 =?us-ascii?Q?aAYXmVvTAwmTDn6pHcJMGSPqVgyaNrC+/hofWJP6OxIMPeWU7/tjK7H8KQyo?=
 =?us-ascii?Q?fyRwA6dFlOzn+ChXJWCII0k2SytRvm75H/TJ/CG0u6iI0axGZiIzaep8L8F+?=
 =?us-ascii?Q?HGO/EmhHMl+nlJ8jzRTSQjy/foHy3nUVR4aJwdvqRqK+9svYV7EhEfRmAaH4?=
 =?us-ascii?Q?yOx0WYBs9MEMzUQ+zLP00016twk32RuwoI6588gv6V8HttbA0lTD9gBFjT6O?=
 =?us-ascii?Q?iwB9XZNV9CmBMgS7otnzWL1RBNMphof99jSjljiQ+wZQ0CuL82m6NpFJS6S4?=
 =?us-ascii?Q?fSxh8DwZ3WEZ0ROZdvdUxjLbwCmvHg64GjUQBVcDTLDLicgvYdCsQeayXnmM?=
 =?us-ascii?Q?sNBPVNOTSkQabcZX1s7I/TShKcO2RoHSk1hOh2EUoNPlIm1v5DYafpCc3xU8?=
 =?us-ascii?Q?DASpokce8l0XKGckuWJVDOLAAwIAJucVNhmfmCM1uG3pqaugZCxq4W4I5C8m?=
 =?us-ascii?Q?jlxYVmY0DGLOLIY0Dh0N/gXpmqYH6kVL1Li6?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6145
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d7b1225b-3f04-44f1-2f78-08ddb97810ee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|7416014|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K+Qbz0UXikpbztqhsHfov4mnpt7LFgEB6cMgmjRbE0YTUS/FsAY7iuUi3xRk?=
 =?us-ascii?Q?gr43TTpqjNf4edNembvj/EYuDfvEkvGqSTdfx7kLks+aAjQPsv5u5LGukyDF?=
 =?us-ascii?Q?+WpWDMOTdIfEJjxGXtguUn3mYFS9mhV8zeDfavSswPSZpVVqR7+hHCUi0LgI?=
 =?us-ascii?Q?vVeXgMD1EPTiq63MG03aongo7ehpwrrG1XgpGP7r8Ig52qUmLcVNc0NvyPzv?=
 =?us-ascii?Q?fIAQNHEmHpTzVP5VNODOmsewn1poH5GqdrC8HGQ+aj3hvbj1DwVbb1zbZffT?=
 =?us-ascii?Q?mIpM4Pv0O7MAGEgLWBpmczJ5wiALsWQ35ZrerGxkbsgu6DDMDtzRagw8r50I?=
 =?us-ascii?Q?oPI6x3wT/UtgJEYev2f9x8cMBNBZLAzWb4COL/lUPR7DFBwkZG+yG7g3PpEe?=
 =?us-ascii?Q?6dOQ+bWS+8cVk78NASjlAa4mub/n7tcjBF6VrIdyKH2AWIy+UzZfyNKSXJNz?=
 =?us-ascii?Q?eSxPcUgGiMuJSDuAdfpALVK5AlJzKzBdQz6SsW3V+38ZeaTGx9ohU2TH5F4b?=
 =?us-ascii?Q?DTraYkFujcBXEbvd+V4fYkBFPG043TahNYr/YhTcMITLllvrykP0/79B+SPu?=
 =?us-ascii?Q?jpwNoJ2K1R3Cn5YkJ00G2KxYK2ycYuEgJrKPtYASyj2dKmMnmyLJ9IQTxq65?=
 =?us-ascii?Q?d73soMbDhI1eByG1LXG19jENV6hKHz9EMrqPt2aUt3DGFLYiY9V0oGKSEkRb?=
 =?us-ascii?Q?V0JlrOvsuzukPl1pDg0ZRO7qpqrmNA8+rYmd82fFSunBXFZlgyF9Das3dJup?=
 =?us-ascii?Q?DHlN8lD3WgslxRJVqpq1/LDlZ4DXue/nfYTitjncKEsvxU256+PrnBFIkO+p?=
 =?us-ascii?Q?0dSNnfC7X+rziWAcn7qI2D9HP4VBq0pjH4u151RKGjUngVOteB20X+cQ67MC?=
 =?us-ascii?Q?AS+twdMD2klFeFHqCxk3UlCLmOSYZPjwrVV469FTxyxaQPLY9ld1nM39lzNd?=
 =?us-ascii?Q?4ogrCzhfDGn/WnOkKzPqUuL0dko9ri5Vt/ipsNUGFJqbAGFVtQOmphogt2Ds?=
 =?us-ascii?Q?aw8OlAKXOELyCrdFPhbV5cIUiQPsYdQ6qnd6pL2jaQLpf0R4zJFnEZPLekf6?=
 =?us-ascii?Q?NbInQJj4bSeJHwcl3tQ2WgOe8KNC8jZlEbVT5PMnVEhXC2tm2ehEhXWqOxwC?=
 =?us-ascii?Q?qlAq7GO64cx5M562QNsN10YZhAPZ+BuqlSZzCdD7emss7C/bd8Ts8r9kSv95?=
 =?us-ascii?Q?8VaCUkh28Y2leMZXdeoQGeTbZIlatLtUabT7oUf8+E+87f3VPpio+5loyPTc?=
 =?us-ascii?Q?62awWUWWv1kGTGDZYDeJZCkJzhjssA9FZIk6tEcKnPNkNm7/XzjBgNQTs95A?=
 =?us-ascii?Q?A140sJ+RdSGO3H8pY1v6vERJ1UOiPlc4eDjLFbIdHOC4vOgWOhw+fg++intO?=
 =?us-ascii?Q?1vwys2P7dC6iPFJpRtfAIrsog7uTRk65rOo4+sZmwEtz36u6tjnCawESIU4z?=
 =?us-ascii?Q?M2AqWoqUu19VOGtFs9gXHhIKkQ5M6hCL633GJWZz22TR74GvNof6iYHUTsgv?=
 =?us-ascii?Q?6+LCARyTowy5qUPwAxqEJdGqnQZHo0Ov1U4e?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(7416014)(36860700013)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:53:02.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc3daaa-9da3-4e2b-fcf3-08ddb978255a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6554

On Wed, Jul 02, 2025 at 11:39:09AM +0100, Mark Brown wrote:
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
> If a shadow stack pointer is specified then it is required to have an
> architecture defined token placed on the stack, this will be consumed by
> the new task, the shadow stack is specified by pointing to this token.  If
> no valid token is present then this will be reported with -EINVAL.  This
> token prevents new threads being created pointing at the shadow stack of
> an existing running thread.  On architectures with support for userspace
> pivoting of shadow stacks it is expected that the same format and placement
> of tokens will be used, this is the case for arm64 and x86.
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
> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested on a fast model with a WIP Glibc patch that uses extended version
of struct clone_args. No issues found, Glibc tests pass.

I used dummy syscall to detect support for shadow stack token in struct
clone_args.

Tested-by: Yury Khrustalev <yury.khrustalev@arm.com>

Kind regards,
Yury


