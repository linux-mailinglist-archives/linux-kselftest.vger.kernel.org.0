Return-Path: <linux-kselftest+bounces-42487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE024BA45B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A77AC222
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE741F1505;
	Fri, 26 Sep 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TPsQUdbV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TPsQUdbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83929202F7B;
	Fri, 26 Sep 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899323; cv=fail; b=UcbUVhF2HPOVbZXkAwLOJD9fdE/ZlPj96V65MnVLQxYqw9rXap0GgPHNyXKlpRhH6nqNBNFBPupXHq6Zp3YDwdIkKepGAMNxiNPNh1sfOjYHEmHD2xVrcKZ+orFJHevjcn19zNfO9cWBrsqs20390dCjW8ULp8VOxEXJqdZnhJ0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899323; c=relaxed/simple;
	bh=4mP3ZU8dYEMDgVYeCkQKQhS0V58wGK1pwu9uaprDcO0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI6Sm5YshFTdwctfdOsy67ho1V9icxXHOwUTgrwr3XZE+TmwRrLhGrdPU8hjWuoqIdaGeQsR0p0XFkldqSFqdw899QlrvncjKThbyC7rm8RhYYwfI/uza96jJe0M+Qgf89Vtd1etXXp82lrm9wS7pQ8WMDdGLNDdIMH8n8HydNA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TPsQUdbV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TPsQUdbV; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uhfXpGMQRjpOiPE/PmNcSpdO2x5Xitg4RygdFVdSE3mh0NDv4XaqDg+ZF3u0Zj2uiHB+UzyOqNw9UYHzHSSUh9c5yZLhiATx29ehvE/8U4JMr19eSlnxRpxHi+tqyBw6BIBOtcCEKIeRBDVCvFh6NR61mn403101wd+gtiewWb05PZEvbHkClguKZyMlTEHtpCokZG9DlFWepXUISZaSAUSDCRB+R8a3zi6DH7B8sigtrvIstUaLyXUTHGGrdNSEhIqK2csFN9CbgKvttexDn3PZxk/oOzp3jM8VDWKVpVyRF6SOjs5lva2W77R45hb5aFexCLY9ymK1tJKclsrb2g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT4RwZCir3YUoTsQ66bI9f5cauCsEbiwQKIHxM7RgBs=;
 b=KW0KBglabJgPwR5v3cpT75C5SpRGVKsMmTqbNMAv/Bf5FsM9xvtz7H39ydQ8WZQH3dnjJ3ZWK16rNdYlUozV5DkgPbmUZXvdRg0bQ6ATfiU+ApzbaHCz6LpzNUwFPqumDFpKs2rCycIiDlVUgYSQBR8vYPEClvvBRMuG+owa06cbj0s8vOtTqM+Ny70DU2a5XfyPDBS0dwYBWh16nmORjVvI4FCdQerDk6SOi/OyVqaeLC+T182wWPI65prVX1pQ4TkzkYqomZG8BFLoHlBa3neaxLa7d8ZCNphNf5yWdTvFqVjd28uVUUQ0K8UtUOa3bUkogE2piinkBZnjsMfOvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT4RwZCir3YUoTsQ66bI9f5cauCsEbiwQKIHxM7RgBs=;
 b=TPsQUdbVl/lJ8XrQfjuDhgPPBISaeafuPUE5XdVY1zw/lTmEAEAU339TfJQXqQ71pjoyvP81jMOU4KyelpVripP7CvEXmfTrN5aCCg66h/mLNYFfEkFu+2wxORZciFrXVF4C25zHUouNe3fOJ2+GW7h1KZvO6F+En+vZYu6m2kU=
Received: from DU2PR04CA0234.eurprd04.prod.outlook.com (2603:10a6:10:2b1::29)
 by GV2PR08MB11444.eurprd08.prod.outlook.com (2603:10a6:150:2c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:08:37 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::15) by DU2PR04CA0234.outlook.office365.com
 (2603:10a6:10:2b1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 15:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via
 Frontend Transport; Fri, 26 Sep 2025 15:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQl+ptmmG14nPNMs7ssTAgOq8Tq51gcgrdY4NOnzLL0p6xB2gOc/FSw80eLU3R2linrDcFgP3DBn2NjuodFGyQr6tnMz9om+1VVrHP0EIPkr9zr7AXNK5tTDw3rB/Y/DeNcU6u3IMB1SAWLMOLhZe19d2JcI/yKrG3lXEJ/VFuf8Nj0YsArZTZVjCdoVL3j30dJNVXx9w7S+JyS8myVefjjzzrrVFFozFZJq/n5KcQYq3eyrBuFOFswodozF9heS/gupQlQKuAPRjjrNFBrZu0wkgs2neTY4F4SINjOwNvWCZUKmFUAdOpGdxrcjBvGcw4s+0SUgUxegFrAsZJhGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT4RwZCir3YUoTsQ66bI9f5cauCsEbiwQKIHxM7RgBs=;
 b=OVve4XFXiO4pbwnRxomqAHvjlel0BBVbKXC+dPCq35KgPKdAuoYqN1Clr37jK41h8aJV/XQMZbJPhG7JFMneEaiAIoC8+7UMgRwDwMOBQ6M3+7a7/Wevg31afgmXfREuVSrI5xmt8f3D/OT4SCeK/MyAS7HtqBW49hnO4DOktpIbLuCm3CrVbsH4qnmU8tVQevXPHaavdu4RAlcPC57ivqIORpHPvjsbEABUzI4jlJfcwadBYq/QEB71SXRoBNegQAf9Gog8Eq1NqViEvGL2ni7Fz3En4TOuSwxYLgelxLxn9PQLpulSkXYBDWXtte43wwKO5ui1JdpibZzmeKFs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT4RwZCir3YUoTsQ66bI9f5cauCsEbiwQKIHxM7RgBs=;
 b=TPsQUdbVl/lJ8XrQfjuDhgPPBISaeafuPUE5XdVY1zw/lTmEAEAU339TfJQXqQ71pjoyvP81jMOU4KyelpVripP7CvEXmfTrN5aCCg66h/mLNYFfEkFu+2wxORZciFrXVF4C25zHUouNe3fOJ2+GW7h1KZvO6F+En+vZYu6m2kU=
Received: from AM0PR10CA0129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::46)
 by VI1PR08MB5518.eurprd08.prod.outlook.com (2603:10a6:803:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 15:08:03 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:208:e6:cafe::1c) by AM0PR10CA0129.outlook.office365.com
 (2603:10a6:208:e6::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 15:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 15:08:02 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Fri, 26 Sep
 2025 15:08:00 +0000
Received: from arm.com (10.1.26.145) by mail.arm.com (10.240.25.138) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27 via Frontend
 Transport; Fri, 26 Sep 2025 15:07:59 +0000
Date: Fri, 26 Sep 2025 16:07:58 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "adhemerval.zanella@linaro.org"
	<adhemerval.zanella@linaro.org>, "nsz@port70.net" <nsz@port70.net>,
	"dalias@libc.org" <dalias@libc.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "wilco.dijkstra@arm.com"
	<wilco.dijkstra@arm.com>, "jeffxu@google.com" <jeffxu@google.com>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <aNasTpkYm8n1AHZ7@arm.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM3PEPF0000A798:EE_|VI1PR08MB5518:EE_|DU6PEPF00009527:EE_|GV2PR08MB11444:EE_
X-MS-Office365-Filtering-Correlation-Id: eb060965-2d22-4695-d8c6-08ddfd0e9126
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|34020700016|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?h+Uj7kwP7JSvoWv3N9dS1SgrrxE3YE39pcc5+OyQ5gvdMWTzuottGuWVFDsT?=
 =?us-ascii?Q?3n5wwa8u5Ln2DD44045nSRw0Knv7SfePHZkeGm3XBY842XsCR51xP0l4Zols?=
 =?us-ascii?Q?oDNaDf+MIdnsqk1EBFKZLdC3C20nQJCGT+gJUkQPejGwUR76lNE7xZJQb0ah?=
 =?us-ascii?Q?4DYM7Vl8KxuG5lNC5eGgSqt96TrfT6jhqjHoYDqjtUbkPux08yvSja0JSTaK?=
 =?us-ascii?Q?tuPcM4V66AT97YEIOPr+gs2HUwQxTtuKuXoPo/wXnNkrQlIyGPXj7EoOq1bO?=
 =?us-ascii?Q?G2ZZ58Ry9iGkto3lhWakrezMwuHn6Gqyrq26p80ufsbD1XANMnZ5AYLfUdOn?=
 =?us-ascii?Q?nXqMqe4LpBgzshpxUTddhVuqXbquqPzw8XE973KIMK1bye0JUTDEBk7qRcR8?=
 =?us-ascii?Q?7a/VtUxzylJoZoB4A7bCJm4siwPE895fXgrY1Aisva5drq1eEBEEQzepsal5?=
 =?us-ascii?Q?EHUsLvPRdcGvYQQOOEnnpfO/41v3K3+fBOcvDit7DG4P1lLbDKeLmyn8CWMf?=
 =?us-ascii?Q?KeIKNEuFbCB0soUb8frvilL29NGH+8gKQ8yNs7pciv+/PP9M8FRmwJ/XlqQF?=
 =?us-ascii?Q?/tzxtWModRYcTtKj0tmi5lvO2QWArRCrxm811s/FLi9GOSyXuzsqYuFo71LA?=
 =?us-ascii?Q?CJFJEoSPPKlJA474zINrsyI9VsBYV9JLFNFkqWjxCSfUK1f6wcKB0VuCg5Ec?=
 =?us-ascii?Q?w29cCk3GXmWv/Rvc/fADj6UIXO61dMGhEUIAVx838Nem1uptIheIGHhpA2C6?=
 =?us-ascii?Q?FiXoskJimpHjqiyaukbFSuHkZEbIAhlHg6AqICWXlrrH5u289i8PrgK+Tn+v?=
 =?us-ascii?Q?Mlf3wptte/X5RNjPfeBoRm65ux/zCk2+r02bljPgCnKg/C2mtaePdyMoEyfp?=
 =?us-ascii?Q?vBshYcSlEP/WnQPa7uyO7ke5yzgQHA470xHtyDLPcvaXnz0Z0l9whHvP6Z3p?=
 =?us-ascii?Q?aUtpGOeynCVryxNvd0Zd9WdrFRMkKJ9vxSLb2rnh+t3X2fOgqxvgMumK2XWq?=
 =?us-ascii?Q?Ds5dNA4tJ84TMU1oslYx8M+q+/RKiF67jK+m/mt+LzdM5xzstgEJiu2VEU+7?=
 =?us-ascii?Q?cgc1eYBtAUm3sx31aRqfXcZYTMAql1/PYuWvs1f2i3C+5lmQSTvti559Hrpd?=
 =?us-ascii?Q?wAryh0AM4ZXnkgztgxwkZSNRiw/yViA2aclxRoADetyZ7EsY8kJnBP1BPxHC?=
 =?us-ascii?Q?FBUh4IwwoC8Gr46RoiZ5j0iFS6poX02NKj5HSn2D7g0z8hvifjqDsCkMP8gL?=
 =?us-ascii?Q?M3T+QVkH/iTcCqd+r4/gTlQ+tkywN5Q5qoVcPJNPq7iP+/OPThIp8H63iJ2f?=
 =?us-ascii?Q?+ujp4KiWVwM10lxm2djt3fsSGs5uNI4o1ubIeiuvr7GnsQjQ/Lw314MIvZWG?=
 =?us-ascii?Q?Oo2R+B5COef+/R/aB5d7DQfiMlHwophBo/DTC7tnolKiV5sp2qP/lNRBojT+?=
 =?us-ascii?Q?DpB28JkD1P0GyeCm/44j/FInTPW6aPZ1DVYBHbvS2EvZkhkbTHe1+PB1GP1v?=
 =?us-ascii?Q?P3PPBW1lsyUD5nWG5Z/AAWPB0prybRlqWXv7?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	beee762c-e76c-46d2-ac07-08ddfd0e7d50
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eFV6IzVtM16N6Qm6psTePer/mzMUleEqYvMz9RzyFydJ2dv61WEp26dOHG9m?=
 =?us-ascii?Q?Nq7R7XFg7fGxXvyN5xaCu9nwu4lig+yhC18TPl9iG1N00fS0WsgSUPy5Zho0?=
 =?us-ascii?Q?8FgmVU24TTxwJ/1sjfiOTvH15R1Hgqn4MIAECziKKXJXJNW3zCXQTmblt4it?=
 =?us-ascii?Q?SFRCU8gUJpWF4JavOUFo0ibl6aP13G5rTepTXrp+AHIiEUhETGpFJbhRwapb?=
 =?us-ascii?Q?aj4Jxhmi1B4XuJPivsovl0OEDh6hbLLCPUheCs0LPPAsWc5gW0YYPbovUXCe?=
 =?us-ascii?Q?vMLQErSx4egIaG7GNKmJzOJL43mbPIe5QrejU8p0Jo3+l/C8f1KR0WlF+LZ6?=
 =?us-ascii?Q?1+hk4dVy+D2Iq8Hv7zHeGRmJs0xSjioCZ63FusKRxKeJ2fy5QhlnD1hpzzNA?=
 =?us-ascii?Q?3xFy1jHVul2RdQNrtxbWf7JzfaJsmWIUhFxiSpbRy9L4ggLc0S5qgtfriyDG?=
 =?us-ascii?Q?pN8f8jp2ARV2fj8u61mCHWKu7e6dMfDhuNe+GIqVeMo17LTSEMIV0eBeeNxi?=
 =?us-ascii?Q?mqU8ofKY/sRnCFj+wCNbfH1FCTJWXDPBg7nVESEodTzAHl2i+GfmRbp8EY4p?=
 =?us-ascii?Q?+JwHcKyzJZI1VpM/N5y8qr/NQnWGJCxVsXiVYiMVxRyf+VmSlOKYQF4prG2n?=
 =?us-ascii?Q?ND6VULI41qGXaScoWSrZgPiUyQjqqNrhbOuaXxLu+ClTcJk8abHVcyBdQWaE?=
 =?us-ascii?Q?pg+53amAydNoAskW9gLydUV4c6402prBAtxp7M2No8VrThDYNz4ZnKl4welR?=
 =?us-ascii?Q?J8IVI771h2A23SVpSmk1siejdO9m5KPlKKLd84K/pAQMFPj6zy0UJ4HHdg0H?=
 =?us-ascii?Q?r6kF/rOIjUguB4b3B1Fun3f3QesPKPOLmkSX/2jMsrDsnbLl0ZFcCQo9C6Gg?=
 =?us-ascii?Q?XfBVs42W/FrsidMy0No3KMhhalccPfOg+MZYW1sSzOQ8WMx8hcmvwXpRlEzi?=
 =?us-ascii?Q?5qo5YQ5oRVuX+PCM0dPbk0cdLNa3ajydhVUGE4hVJNI1QVbdPENJazTTMRfs?=
 =?us-ascii?Q?W+EM7n1xmLdRKy9s8vZ/ckZGHFzPJLVW5p+nxCs3vKzIIf3PKKxeV8wzD9YA?=
 =?us-ascii?Q?fFVW048DKTSClIux1B+eGAzZwYtIQBU81fJ8R7tFZ5hA1RFxq1A+T+h3wbTn?=
 =?us-ascii?Q?6P2qZHENs0jl1UCJlQnGmd7MmOy6YxlAqfBmzpOpXU3cIbdZI8CGPoW53h1q?=
 =?us-ascii?Q?xeEy4xiq3TCyySUFfqKCG02xyPbHwdETSzZuBUGMVV2iLTstkL10Ani730LC?=
 =?us-ascii?Q?91CIdQu2BM4Q1sIZwE5ROeMyOanNOX/VEl5ZieOIW/f48X5Rf9FwpUaP6dwZ?=
 =?us-ascii?Q?Ikx00IuFFiMMjEuBc4/nEdc0eLe+7fq6S8KprUBN32QlDWXthzkJiKLouOBZ?=
 =?us-ascii?Q?VdZV9eyxV9b1SBv7rAqJAdZ6D2B26oxI71clCwixzfo6BCHSl3X6fyomp6do?=
 =?us-ascii?Q?rEZp7wb0ugeYem+D/FKRq22GyT1RvrtRo83d0zdEzmQyWbWeTc6eZfh0vmmA?=
 =?us-ascii?Q?9xb33YLsaMPYlYaOIOzFI/kwiYIJaXT/xAJgr/4pMFGfFcWpYNKDIu4NAiD3?=
 =?us-ascii?Q?p6Al24CUYu580b7DR/U=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:08:36.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb060965-2d22-4695-d8c6-08ddfd0e9126
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11444

Hi,

On Thu, Sep 25, 2025 at 08:40:56PM +0000, Edgecombe, Rick P wrote:
> On Sun, 2025-09-21 at 14:21 +0100, Mark Brown wrote:
> > During the discussion of the clone3() support for shadow stacks concerns
> > were raised from the glibc side that since it is not possible to reuse
> > the allocated shadow stack[1]. This means that the benefit of being able
> > ...
> >
> Security-wise, it seems reasonable that if you are leaving a shadow stack, that
> you could leave a token behind. But for the userspace scheme to back up the SSP
> by doing a longjmp() or similar I have some doubts. IIRC there were some cross
> stack edge cases that we never figured out how to handle.
> 
> As far as re-using allocated shadow stacks, there is always the option to enable
> WRSS (or similar) to write the shadow stack as well as longjmp at will.
> 
> I think we should see a fuller solution from the glibc side before adding new
> kernel features like this. (apologies if I missed it).

What do you mean by "a fuller solution from the glibc side"? A solution
for re-using shadow stacks? Right now Glibc cannot do anything about
shadow stacks for new threads because clone3 interface doesn't allow it.

Thanks,
Yury


