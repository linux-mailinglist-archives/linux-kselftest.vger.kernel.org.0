Return-Path: <linux-kselftest+bounces-49424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6971D3BAB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7E83026F2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D802FCBE3;
	Mon, 19 Jan 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SCSNWMfv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SCSNWMfv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7728489B;
	Mon, 19 Jan 2026 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861144; cv=fail; b=rOuNaGxkP37pGPIldzgufuxE2SxxzlQToLLZnhsL9gS+7M+lCp24n2CJ/DtXs1kPP+l1HaNW4weJRMc6bcA8ulgray2wmYvVwdKFQRrwG6rhisBMRDPV3Gl4RweiGJ4pCBiiOiBnkZ9ytqVgQ7eabxsUWDpPGccV55LEs4styW0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861144; c=relaxed/simple;
	bh=KCxaRUTw6nmaRDc7ZibPl5wkjAA/HXO7NKmNNi0+jBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GJvtNl8lgvfDrMtFoPkFiyvNOYVm9/KWgkhuotoIg49Yk2ZOmmdQor75hABY8OYHduWgchy5329VSZuA4hmmcbX8f91E9brF8/JMZkNV1OCM5Of5NFQfon3VtigLcg8lqLyQYwLRniiBGKyeJce5j/qGvQcw0b4Mslyp4cQoljk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SCSNWMfv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SCSNWMfv; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kT5HGlvd/ZREC/0QfpAyvELi12l5Pso3T45EWmmEFUvsZWIv7Q0+USgKPjZy51x7x8SvzuOBP8/6glYzvyywBXPFes0rpx/8EmEzaI78i1nhuggLj9iYdLOw/XHPsB8PpKTviIISedhQNmrXJYj+a1zlKSbh2G5L+PZsC+PGcR57P8/X6EOwJDEoXDRL7/lb8o9A17r+0L101LTGW0KaAp3z28/lVf2HfO6hrRjK6UCReBV5lQXM9sUsj4TBoUve0NfDnC24Gclk6xUc0B51cf55I5ggkhFD9ACHxP0qknFaIKfYE21xVqx/gfA+WqNPMrI8EzyVahQiyr4Et7tnew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btOT3zliRUWHQ6mRDmrEXMZ+mdGCfyLUy5UYH2ERk7M=;
 b=U1bDo+sY6ofsggQ+cSM/l1aaAbDl6K2qqE+U5AVFf/oUCNu2YPzW4IPpnvAbdO4NjMWnzy8MnOs7661V24JPqC7rnQkEKR8LGa9vM1w5xs0Eu+6ve3+sg8F7kOOWPplc6ja5x4MP21TGeyMXxgZfQwewDRSGrwjI3eU/EXN7W/EClb3Rmgg8MPApn93DWvzN3ZnJPO7B3OQwWgkC35jnpecCW4i/UpdDXNWa/bActgbJTVaaUuHAN7z8IJMI52oJgI+3K8svI4oNRwWIqRbleXyGTOXlJydaPO5I/MiK3q/SKjPIXIsalI1lY5l5BCtHz2nPLOSjs4m1SLqNgef81w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btOT3zliRUWHQ6mRDmrEXMZ+mdGCfyLUy5UYH2ERk7M=;
 b=SCSNWMfv3/cKllbPOVCr6KNwzCGAvyJL1Ch+d8gA8fgZ45ThklvSE75u8C5E9IEppjfVSOF4/t97bct4pSLa4zxNQXnVfY6nv4CL7nNbyrjuQLylyr0fiinrEB7XETcceDqMLIw6UPIVh6qNvnIkmtp6xJTGv174Xk8aYdIKE/c=
Received: from AS4P192CA0027.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::17)
 by DB9PR08MB8358.eurprd08.prod.outlook.com (2603:10a6:10:3da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:18:55 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::15) by AS4P192CA0027.outlook.office365.com
 (2603:10a6:20b:5e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Mon,
 19 Jan 2026 22:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 22:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbxjsj56EuSBOyAZk27ynq7GB5KK11AuwdvB650yeEBxRx//vKxUFy18okCxZeNAAbKb4T+UrwRbzhuNNsaYDcjMw8IVt9jXcoLG//4BvlKdnewjJgHUzYATOsRjfKZleG/y+8bdkeBFc7xyEMcCiClBtin0EUSP7TepUdwTddLmckyvIdXc6eo5RxvxwxirzWIokAavbm2GNdCvHlGYSKaqKVOPYuRKwd5/6KbOvKI0qz7n6yMF6k//UEKyzY5XnNsn+tf7t0Bkb8jCubT46z58thxioIcTORaLMV4sev2ZPXjPmUN+5QYC4fni4buYee7/exZ2hXqxjr3bmwnXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btOT3zliRUWHQ6mRDmrEXMZ+mdGCfyLUy5UYH2ERk7M=;
 b=Dljn8+rRVIiiDE7IL3OBB/5FwjrFJsTbEpCxB+ZkBZh1qt9iB1qQJRac02P6Aeiu2DY5BZteN+CnptY9bYt+Af7RqTplBoAjZQVKsAAROucRn10dGPPQmszKmRkMZ8u6ox3PG6ztY8pkFGA/4dr60EW0rNZJs3x6ov4dNStBQvVrVBzxk0Sx78SSHq7NPDJlP9xzUB7QG9FN528E2JN+i4Nvc+m6BBENwQtTdvxoIPynWfg+FGMNZ0MSi/7jjcT2oWvYcSPVitfGwItKfCXDXAtZLKy+x9Pr+mfXEFCOjvaB7vVEDNljbR/3AiCOx0r8ROzK/0MnY1fkPPluX1wUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btOT3zliRUWHQ6mRDmrEXMZ+mdGCfyLUy5UYH2ERk7M=;
 b=SCSNWMfv3/cKllbPOVCr6KNwzCGAvyJL1Ch+d8gA8fgZ45ThklvSE75u8C5E9IEppjfVSOF4/t97bct4pSLa4zxNQXnVfY6nv4CL7nNbyrjuQLylyr0fiinrEB7XETcceDqMLIw6UPIVh6qNvnIkmtp6xJTGv174Xk8aYdIKE/c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAXPR08MB6687.eurprd08.prod.outlook.com
 (2603:10a6:102:132::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:17:51 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 22:17:50 +0000
Date: Mon, 19 Jan 2026 22:17:47 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, maz@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 6/9] arm64: futex: support futex with FEAT_LSUI
Message-ID: <aW6tix/GeqgXpTUN@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-7-yeoreum.yun@arm.com>
 <aW5dzb0ldp8u8Rdm@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5dzb0ldp8u8Rdm@willie-the-truck>
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAXPR08MB6687:EE_|AM3PEPF00009BA2:EE_|DB9PR08MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4560f5df-295a-43f8-e7a3-08de57a8bbbd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jCZaHQlXuvgPIJPrC23Z4x054FG7zk1fr9+hJ2qyyovQS2X42xNFUFTHRanY?=
 =?us-ascii?Q?buylLatPf6w+yYKmvaOdpixcumlJD3FdAGBy8deG7UU1vB8egLWTPPwjbN5z?=
 =?us-ascii?Q?b5Wu9u9Sg5kwSEk0PIE8I1goG7/Wxcz5xDzaLlPvF4q1s293a8+pmGEfC2PQ?=
 =?us-ascii?Q?aRSgoo5NRs44m8hCNE0Tl/piykmrJhOEiR5etQYGwvyZcsWwFlR5gKe9rfZ3?=
 =?us-ascii?Q?bRjTNFsPa3DwA3lz48PVWJ6Cc0Gb+sMOjpO4y6s1S29BwFvPAmjtEoTyl0CS?=
 =?us-ascii?Q?CNteqs96D5y4rwfVTki/NMZrXcYlzZKnz/5mn50YV5dl2gJQ6rLgnTupgfKf?=
 =?us-ascii?Q?drZyttJZ/2Fd/aTccttc6TqD84hN7oTK0oBdzI7BShAYuUhAodlsc/I6C05l?=
 =?us-ascii?Q?gD7I4cwKOakqHJARHJv1cUXtFugSTMFrZ+PXQV4P+HkBngWw5A605A1+yft+?=
 =?us-ascii?Q?LAtDx23VLA6rWLbCVxl0+BmR4OHT9KGaEkKWhz8Pq2nwKwRzLWRj789yjZzl?=
 =?us-ascii?Q?T/fCfKJcj85ayZPsf0NRKGXE8jo6nNl1uO8S2oqDtEVAzhb/s1eGJZVdkqPP?=
 =?us-ascii?Q?DPCBnFzRD3D6oOo10V37PxZmcpJ9HJPcSONA4nIwIQRiGHQ7wRLjTez9IhGz?=
 =?us-ascii?Q?Ps92kaz1Mi5OTg3B8+PHxfukwAHfNGfeboP6RPaoikiU2h8TLWrW5QoAhgkb?=
 =?us-ascii?Q?4S04Z+Q50L4HpR62O3CMvK0usbggnHsmwm/gxFHL8AN+KKXZ1J7Vykiy+V+0?=
 =?us-ascii?Q?xba3J78hLh+ZU2XygXT8HHQP0C4BHT5GHbUWa4b49mZ6T4Qwjj3HuBwTAxob?=
 =?us-ascii?Q?cr0GGPyd6X4zP/wmwkrWzX+wVQfCb0i7U1ltw32SR/8aBuCpKbVpJDjL8nce?=
 =?us-ascii?Q?RJ0gd78QG7NsGNQpncNC9eB5PviImZ+K0kr565YEANUfnquPRmeMIj801oeV?=
 =?us-ascii?Q?NijMrQBtP2Pbq1BeRAILto++uyXRWNLk/bF2I9930HP7xDKdcwvDWn7in3C3?=
 =?us-ascii?Q?6LyKfSK9Hv0qbKhfNExUv+Jz11cRjHIdAw0/4KHTmIH3xYIGZ2kxV2tMRcvC?=
 =?us-ascii?Q?F65hB3GsuXQJ73z/gCru9bw3mIV/SZY4KO/GsOt8fHzBLDQ2VMWIjmDLIcia?=
 =?us-ascii?Q?KV2Dhqx/15I+EK4JFKzWO59UlqlyRhJMhGQjsLPumhOoNukr83GFitCDM+U+?=
 =?us-ascii?Q?uc7NuAE4m8Es78b5S7dmsNgvxt5kZ6x8tct11Aor+rWmRjcUdzEW0fV+sgMK?=
 =?us-ascii?Q?WC7pb1d7WdzpQdeg+YiImcEJfmW7hxBZaolkw3dR52Kytn1IEacQVf3PfioZ?=
 =?us-ascii?Q?dB6AxzW8w8mbkhCAGDeSi4tTOfHTEbstf/bqLc5aNl+fe768tUqdaglReEXL?=
 =?us-ascii?Q?x04ge/Ph+kk6G79QEPF/yeZ8EX74VkHuGgfv9cxyNwu5UMok56BEelNIOoWp?=
 =?us-ascii?Q?EA9Z2nTY55x50eOZj+/zxX6yEtNXVclIpg5iJzG9/CLVRdxunD0g8Nl0BPzJ?=
 =?us-ascii?Q?8RfpREwcpPpv3agt3xtyYYWV0hxYuTYiPKfhnvH2PCWw7AO8fL8EguaHa4E3?=
 =?us-ascii?Q?v07RznneqKnl4fJgSdQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6687
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e97168a5-84ea-45cd-7e67-08de57a89563
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|35042699022|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9r0UmfVSjE/CJjiaCwr26kyhIV7U/HKC63Ohd6aSF3Qevt2I9uh9Bsyxssl?=
 =?us-ascii?Q?hAIRqFLTfUhrFf/r4UWWxxFsVKPFjplnK84eQUMdSJwBdi5O1qxq9T8FIw4b?=
 =?us-ascii?Q?gzgYHb6JbIMGaViRAQoKaGdyZX2BzsXU0daDdeZYf32bsBhFS1O+X5IPGoNQ?=
 =?us-ascii?Q?aNZ12kN3ig9LQA/QAYQgeTDLYs4aAF1m5+H8Jmia5IaF3wfMSFSXxlJVQCg5?=
 =?us-ascii?Q?pKId5mzgnHg20Nj9zlbLLVCl1rRpFNCJDjRcUByLv8IfrDx8sVVZf6Xwg0NT?=
 =?us-ascii?Q?cZm08Fy7gtWhCGFxlgWwRHyYG6gj0x8Tt/Ch9v0JPB4yVoRvkOjMfLIGGzdi?=
 =?us-ascii?Q?YifYIci2o1Ex3buyzuiJ7EjcBxmrrrGfB/PrQgVbVGK0EYlKodRFakLxRL7X?=
 =?us-ascii?Q?AxiYTgI0scHgeDHFMJi2hZvg9LGOibzCAkhAZ3K1KIQaTRmpDRIpp54Rtgzw?=
 =?us-ascii?Q?FpWvbyrbl3gOlMDq8aTjyzkbjaeBuYxw3bKh6eL/QHJGhrFVUpUU0qKghryR?=
 =?us-ascii?Q?a21ARVnTCEodDbqKNHusLabaW3r2W7gNuJy2wg5WIhwCrofU4o+4Xs8aBj41?=
 =?us-ascii?Q?Z9BfN+vpX8d6ba2+RmWXVaZaJ4pys2b2OLCAelJVyiLBkOym9fNUfHcAPla9?=
 =?us-ascii?Q?C5iB28HtFr4+bGDFl02pt5CDuf3fPBCfWy6FBclYAO9yY10o35mu54Wv1Yal?=
 =?us-ascii?Q?UnhF7tZ7kt6pbS87kli360hA123QWHcYUVw/GEtpB7e6mDGhdJALq+uocRml?=
 =?us-ascii?Q?n/SUy9+gOHycTnuiN0wXsIMQSSy9aGwlnkjpkSlz0RkLmmrAsnUKVuxhdZ2M?=
 =?us-ascii?Q?c//CSNhOe2DJ3647dEcDiMNKBfbOoCKPZxnIsGkfw7Lo8Eq8sUzvZ08BatP/?=
 =?us-ascii?Q?V2H4OTbU+7bfzkUK/zvdqnLHVLn241bSve0fRM+Ks36OIZ4BZ+BPN0x93hK+?=
 =?us-ascii?Q?1ltz3UrOoMc1lT5SxriNh8xJ2UJ+UuUtitEzPtr4R+zR+re3D9Nq9CHti/PC?=
 =?us-ascii?Q?DL415EQsD3mpnLdhmIKAPHmbRSL9HeuJyOK++55y9FKra6bU+BP4KuPCFbZs?=
 =?us-ascii?Q?YaYvTYI6GGl/7HabRTRoBhqFqGgmy1VOmtNy+uLkALAL4qFOE2KEnFzn26ds?=
 =?us-ascii?Q?8wh4zsXQUABxoL35pZH98fokixA6RNRXKzrm/169h1Cqnt6VmQOGmthk9WCo?=
 =?us-ascii?Q?Jr0J2421JW1B4POONlcJJonmrM3Mqx7vf/HzGNJyQ3wjyEP9FJj3ixpcZ6zG?=
 =?us-ascii?Q?RqFt/3X5yHLIdpbpM8CJBbXM1s3UfILeqdtMm2lc/iei6XrFJr5fVST3G7WH?=
 =?us-ascii?Q?WTYS5Yj9K4+8ezMEoxoP8fFrNTtlwS51kstv2q34YH/eQKLoZS6ZYnkc7Pj7?=
 =?us-ascii?Q?lSoXsQtDlZnSPr6PrBhLO+txjI/+qI0oPfc4b+JWid55FpULGpgQikXCVdKt?=
 =?us-ascii?Q?g3ZVxUNsFoacDH7RyfkWLIONehkUWvxJdXz8M7OgYZI3iTWQfzYPNRgIOVzU?=
 =?us-ascii?Q?MMMVwUuRGZhCD+jUe/LG1MZQJpSubV4dmkxZgBWZtHVn+/GEW/JsA91YkBLM?=
 =?us-ascii?Q?80KVy+IXnleuAYWY5Z4G5Yz1hwth1WR/Mf4I+YoM49+EuuMOKxz5nuzKprjg?=
 =?us-ascii?Q?yGnvBeJ2950JqPS9JqYHDQyULh1j263/1ZeOo/5y08EfXhV0NXUlxWs1Txzp?=
 =?us-ascii?Q?vUnw8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:18:54.8190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4560f5df-295a-43f8-e7a3-08de57a8bbbd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8358

Hi Will,

> On Sun, Dec 14, 2025 at 11:22:45AM +0000, Yeoreum Yun wrote:
> > Current futex atomic operations are implemented with ll/sc instructions
> > and clearing PSTATE.PAN.
> >
> > Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
> > also atomic operation for user memory access in kernel it doesn't need
> > to clear PSTATE.PAN bit anymore.
> >
> > With theses instructions some of futex atomic operations don't need to
> > be implmented with ldxr/stlxr pair instead can be implmented with
> > one atomic operation supplied by FEAT_LSUI.
> >
> > However, some of futex atomic operation don't have matched
> > instructuion i.e) eor or cmpxchg with word size.
> > For those operation, uses cas{al}t to implement them.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/futex.h | 180 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 178 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> > index f8cb674bdb3f..6778ff7e1c0e 100644
> > --- a/arch/arm64/include/asm/futex.h
> > +++ b/arch/arm64/include/asm/futex.h
> > @@ -9,6 +9,8 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/stringify.h>
> >
> > +#include <asm/alternative.h>
> > +#include <asm/alternative-macros.h>
> >  #include <asm/errno.h>
> >
> >  #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
> > @@ -86,11 +88,185 @@ __llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> >  	return ret;
> >  }
> >
> > +#ifdef CONFIG_AS_HAS_LSUI
> > +
> > +/*
> > + * When the LSUI feature is present, the CPU also implements PAN, because
> > + * FEAT_PAN has been mandatory since Armv8.1. Therefore, there is no need to
> > + * call uaccess_ttbr0_enable()/uaccess_ttbr0_disable() around each LSUI
> > + * operation.
> > + */
>
> I'd prefer not to rely on these sorts of properties because:
>
>   - CPU bugs happen all the time
>   - Virtualisation and idreg overrides mean illegal feature combinations
>     can show up
>   - The architects sometimes change their mind
>
> So let's either drop the assumption that we have PAN if LSUI *or* actually
> test that someplace during feature initialisation.

Thanks for detail explain. I'll drop the my silly assumption and
call the uaccess_ttbr0_enable()/disable() then.

>
> > +
> > +#define __LSUI_PREAMBLE	".arch_extension lsui\n"
> > +
> > +#define LSUI_FUTEX_ATOMIC_OP(op, asm_op, mb)				\
> > +static __always_inline int						\
> > +__lsui_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
> > +{									\
> > +	int ret = 0;							\
> > +	int oldval;							\
> > +									\
> > +	asm volatile("// __lsui_futex_atomic_" #op "\n"			\
> > +	__LSUI_PREAMBLE							\
> > +"1:	" #asm_op #mb "	%w3, %w2, %1\n"					\
>
> What's the point in separating the barrier suffix from the rest of the
> instruction mnemonic? All the callers use -AL.

Agree. I'll remove this.

>
> > +"2:\n"									\
> > +	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
> > +	: "+r" (ret), "+Q" (*uaddr), "=r" (oldval)			\
> > +	: "r" (oparg)							\
> > +	: "memory");							\
> > +									\
> > +	if (!ret)							\
> > +		*oval = oldval;						\
> > +									\
> > +	return ret;							\
> > +}
> > +
> > +LSUI_FUTEX_ATOMIC_OP(add, ldtadd, al)
> > +LSUI_FUTEX_ATOMIC_OP(or, ldtset, al)
> > +LSUI_FUTEX_ATOMIC_OP(andnot, ldtclr, al)
> > +LSUI_FUTEX_ATOMIC_OP(set, swpt, al)
> > +
> > +static __always_inline int
> > +__lsui_cmpxchg64(u64 __user *uaddr, u64 *oldval, u64 newval)
> > +{
> > +	int ret = 0;
> > +
> > +	asm volatile("// __lsui_cmpxchg64\n"
> > +	__LSUI_PREAMBLE
> > +"1:	casalt	%x2, %x3, %1\n"
>
>
> How bizarre, they changed the order of the AL and T compared to SWPTAL.
> Fair enough...
>
> Also, I don't think you need the 'x' prefix on the 64-bit variables.

Right. I'll remove useless prefix.

>
> > +"2:\n"
> > +	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
> > +	: "+r" (ret), "+Q" (*uaddr), "+r" (*oldval)
> > +	: "r" (newval)
> > +	: "memory");
>
> Don't you need to update *oldval here if the CAS didn't fault?

No. if CAS doesn't make fault the oldval update already.

>
> > +
> > +	return ret;
> > +}
> > +
> > +static __always_inline int
> > +__lsui_cmpxchg32(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> > +{
> > +	u64 __user *uaddr64;
> > +	bool futex_on_lo;
> > +	int ret = -EAGAIN, i;
> > +	u32 other, orig_other;
> > +	union {
> > +		struct futex_on_lo {
> > +			u32 val;
> > +			u32 other;
> > +		} lo_futex;
> > +
> > +		struct futex_on_hi {
> > +			u32 other;
> > +			u32 val;
> > +		} hi_futex;
> > +
> > +		u64 raw;
> > +	} oval64, orig64, nval64;
> > +
> > +	uaddr64 = (u64 __user *) PTR_ALIGN_DOWN(uaddr, sizeof(u64));
> > +	futex_on_lo = (IS_ALIGNED((unsigned long)uaddr, sizeof(u64)) ==
> > +			IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN));
>
> Just make LSUI depend on !CPU_BIG_ENDIAN in Kconfig. The latter already
> depends on BROKEN and so we'll probably drop it soon anyway. There's
> certainly no need to care about it for new features and it should simplify
> the code you have here if you can assume little-endian.

Thanks. then I'll enable LSUI feature only !CPU_BIG_ENDIAN.

>
> > +
> > +	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
> > +		if (get_user(oval64.raw, uaddr64))
> > +			return -EFAULT;
>
> Since oldval is passed to us as an argument, can we get away with a
> 32-bit get_user() here?

It's not a probelm. but is there any sigificant difference?

>
> > +
> > +		nval64.raw = oval64.raw;
> > +
> > +		if (futex_on_lo) {
> > +			oval64.lo_futex.val = oldval;
> > +			nval64.lo_futex.val = newval;
> > +		} else {
> > +			oval64.hi_futex.val = oldval;
> > +			nval64.hi_futex.val = newval;
> > +		}
> > +
> > +		orig64.raw = oval64.raw;
> > +
> > +		if (__lsui_cmpxchg64(uaddr64, &oval64.raw, nval64.raw))
> > +			return -EFAULT;
> > +
> > +		if (futex_on_lo) {
> > +			oldval = oval64.lo_futex.val;
> > +			other = oval64.lo_futex.other;
> > +			orig_other = orig64.lo_futex.other;
> > +		} else {
> > +			oldval = oval64.hi_futex.val;
> > +			other = oval64.hi_futex.other;
> > +			orig_other = orig64.hi_futex.other;
> > +		}
> > +
> > +		if (other == orig_other) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!ret)
> > +		*oval = oldval;
>
> Shouldn't we set *oval to the value we got back from the CAS?

Since it's a "success" case, the CAS return and oldval must be the same.
That's why it doesn't matter to use got back from the CAS.
Otherwise, it returns error and *oval doesn't matter for
futex_atomic_cmpxchg_inatomic().

>
> > +
> > +	return ret;
> > +}
> > +
> > +static __always_inline int
> > +__lsui_futex_atomic_and(int oparg, u32 __user *uaddr, int *oval)
> > +{
> > +	return __lsui_futex_atomic_andnot(~oparg, uaddr, oval);
>
> Please a comment about the bitwise negation of oparg here as we're undoing
> the one from the caller.

I see. Thanks!

>
> > +}
> > +
> > +static __always_inline int
> > +__lsui_futex_atomic_eor(int oparg, u32 __user *uaddr, int *oval)
> > +{
> > +	u32 oldval, newval, val;
> > +	int ret, i;
> > +
> > +	/*
> > +	 * there are no ldteor/stteor instructions...
> > +	 */
> > +	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
> > +		if (get_user(oldval, uaddr))
> > +			return -EFAULT;
> > +
> > +		newval = oldval ^ oparg;
> > +
> > +		ret = __lsui_cmpxchg32(uaddr, oldval, newval, &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (val == oldval) {
> > +			*oval = val;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EAGAIN;
> > +}
> > +
> > +static __always_inline int
> > +__lsui_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> > +{
> > +	return __lsui_cmpxchg32(uaddr, oldval, newval, oval);
> > +}
> > +
> > +#define __lsui_llsc_body(op, ...)					\
> > +({									\
> > +	alternative_has_cap_likely(ARM64_HAS_LSUI) ?			\
>
> This doesn't seem like it should be the "likely" case just yet?

Okay. I'll change with "unlikely"

--
Sincerely,
Yeoreum Yun

