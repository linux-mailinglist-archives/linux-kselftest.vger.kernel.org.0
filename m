Return-Path: <linux-kselftest+bounces-49281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD768D39624
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0839030704FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007933C195;
	Sun, 18 Jan 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rbiW8xZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE833893A;
	Sun, 18 Jan 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744529; cv=fail; b=hR0DmZLoJ7ItC7Cg3I0MTNBOffv7xDDGcr9ositPBT3Vox9yqLBbraeGNctZqidEB4pl9M/XFNZKdKF3LgF5ndCWE8MTj3LNZhO2fXnR5L1km4/QUNacRUTTvm02FQGdXsd5YAvNsLXLUtBziQgCzLOpnyvMORuDZUA+FoKBnmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744529; c=relaxed/simple;
	bh=hZnvUiXPFpoURWd11hhYfbpdhpBdjpCw6fZ9szrG8vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRSTIP3OSth3Edvaq59djF0op93K/D0JYMTxwsr2Af9aBKDBlkHKCVkgwo+QYMuT1rwf+mKJ3sVOgPv2rGdXbrv6wPymCTU66EdExI7ifH6cbwGyh1+yB4GGVOVtXGGF4F2q/pfwjbFZLbKG1ItFpnKCd9q2N/zbas8NjWMIhUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rbiW8xZc; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWsYW3pVBXZkW4KPusK3nDAjMEG6Y7v4ypXEMbAZtyqosIu3aIoQSY7smqKaQh0K8mWGh8wh1k6MZmFE5ey6WBcooaxkvwuJSIqxNxxCTdsxGGR7CsiaHakQCEbPVmb4TD3OyUEqv7rGGrR5FVKSK8DhuHr395grxwT9qR1kWc+J6dq00Zp06+InlbqNp/gYsOFAW4JcAMxrwbxMudahrTsC9D3jFJ04xw28UCOSVFqnkLAqT873yllFNTXAkiuOutWqE7YkjLX43Fs/TGcCO09BQ/Lc4IWkHPWHYsrVE5JIChmjpz0SXLCtWRtPFFZTVXiLFoxvzD3Vf4byhnizSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCX2KUhrJp+BtZj3mlbTsAqjCXlkuwb3D0WhfoJgnEo=;
 b=by9mRXRrDLT4mxTvYxRCSJIZi6TG0UdIvslY2I+R55A8r4KFZ03XX1SX41OupXa5LRHb1e3IQ7o7K5NKjVmW17NSaqtXkdvkCqofRJpMI41Zjli6KiBkQhIWAyW8tsYTIJcKxKU/YLKkQMWe+wIem6mO49lTm3arBsE7vPuV2XFKAERg5s70beP0/RgueXHbGwIpOqj2BBqdZmuHCexj9MggWoMmQ8bR2TcQhVcCm6KrlGfqPEEngtqwT1ZaiRDNTloc4AygpKixK7XfeVzGK2htXo3jCUB0DSsYKt4Herc/J2/AXhk7pvn5cXpRKsAXmI53ihKwLhZYhJkz5ACrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCX2KUhrJp+BtZj3mlbTsAqjCXlkuwb3D0WhfoJgnEo=;
 b=rbiW8xZcW+TPryiXXQH+D3zeRNnxUwNJF12lpmq/uEmUor0BsPEwQSK86byp1VaBm4TiGKho+ghvv6PVdpKC7NhXhqCg5xrjtdh2oxVUkhDhbOvs0FfwLJ5MMymv/GXaVxCAou2bUrvtvNLvO9CEuvicX4pJjMZKuAZUx3SJhhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 19/38] NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
Date: Sun, 18 Jan 2026 22:54:21 +0900
Message-ID: <20260118135440.1958279-20-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed25f7c-2061-4a56-537a-08de5699306c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?188G+fTbX40aGr6B6vr84S6a4/2XuJ/cwWgunElI9WuzmzcNGvCec+v3PQV1?=
 =?us-ascii?Q?kGmjGJelxiewuuFyjfKghe7+LXW/nXr25YeZr11aQnq9JtDPlCHFSUk5ezHo?=
 =?us-ascii?Q?ZYzcbzyzVCrV6+C1n8QveU0oBSFt3s7zpdcoa7nk/Bppa2r+hbA1+4ic13qK?=
 =?us-ascii?Q?/QkmjrysvFCSKK4G8EjNC4z3gG1oOtJ1JJyQSL+xY/r5YQyC8jcvpjdEbtEb?=
 =?us-ascii?Q?ICx7Z9SBh6qZHc0xPO3Op4vP8bXcJbiTeYZCaaHdCb5SIyoWdzCNp4fg+K0M?=
 =?us-ascii?Q?qWDFdCmgj1KbEgBIzkbtturRwBJEN/uUGmusetT6ZPbhT6lmvI6nP0pWw8zF?=
 =?us-ascii?Q?Owput37td8RewBNkOfJQZyNJWIwvCJ6j9GsbRIiLQas5TzGZW0OXCniDkFHr?=
 =?us-ascii?Q?w4rPfWidW9/GKwYnRgweY+Q6PxcH2Vr0Ahl4AMmNga3Wqn8iuBo6GeljJXSw?=
 =?us-ascii?Q?gg19DY0vKKA9qHbm9AUPCuOhNaEe9R7eO55OXdxEcul9s1Jyef6XAOfyJJAq?=
 =?us-ascii?Q?+w7Jl96zo6w4+BW21wyC/Xj+mEDnDn7/wGGS1C/aZU71ryDdX3N59HGPK7+z?=
 =?us-ascii?Q?XZfbu5n72+FCww33N7G9EOu94hNWcAv0yqPGxsCiGz5IJle4spxq9+QJhQA6?=
 =?us-ascii?Q?A5BUsQ7FkLGBa/N9tKTHzt0QMXN58uOPzoan2ex9WNp9jj8loLj2r96wudTO?=
 =?us-ascii?Q?delzCpD3B6ln4bMeC3IwOm2COiQ1SpLku0y006iD/5gNfDEO5hfqNEik+nez?=
 =?us-ascii?Q?NCwmPQPYKlPhClSwogVSVu8896ndkGc5dzJvnR+/QZEAAs4CzJxeUxqE6jhT?=
 =?us-ascii?Q?KHX181kc6/dbhsQKqTLocAJeMbfq7mbb2YEk8pB7kQUwWvJxPJoH8q7j7Kng?=
 =?us-ascii?Q?rBx5p/oAnzG0ekfYa4fTmQSMwE14Sj/saBGh8cINgyIJv6Nuq4XQkCsu0p6L?=
 =?us-ascii?Q?m9IrJ+VDyj9/8b/TZY2UmiAf7U6Y/T8JToqDDBjWuOFEhUEig0yAfFdx8scv?=
 =?us-ascii?Q?9339rrS6G5EIevzAbL7C6WLWNym03whKg0zsoHd27flbadF9u0BKe3BJNGR9?=
 =?us-ascii?Q?9jFmXzr4BgNY6Qmez2L+OBoQNLq/N+CB9ok/ocMltcASJTAI1T2zs4Gci5IS?=
 =?us-ascii?Q?kbj12VfUT4Qsi34CHq75jvur+9u8+hQgxHE5p/87dXyF44iPg1XM6CiRDthq?=
 =?us-ascii?Q?3HR6P1WMCwUnw0PxAjGeiZXlxzgld7WCs+oBSULur+yiiogviw2wwEW1PNlk?=
 =?us-ascii?Q?hz2Pcr7Cy7Mz9aZHtAblClvIK+X2C+8oiNJD1G4iWafmr5F8A7t297Inn8F2?=
 =?us-ascii?Q?KjWCUsovosUI69rumx5UVtw8K9neBowBmSqKKTJpfE8JjTiHrJjjPErCZSlY?=
 =?us-ascii?Q?zi6z33Cl67AdU2YU4NapRiZYZ8xu2gdr6qHlnotRSetKs6+LkCObOOwF6Oj+?=
 =?us-ascii?Q?D/Uj1eff7e+An9Rs+0UteeIIdz52E2e3hXPOjLY9abCHe7K6KMjn7/wEqtvb?=
 =?us-ascii?Q?SX0/wALSvTZH9WEyMXht51sf02oqAZznV/uBXItgXu1vs3EtpLthvgidegiz?=
 =?us-ascii?Q?7ObFM/GantohRuSsMKHE1Dm+2AKUFzktxfQNoboygCzV1rD0VPLXwuff4RYv?=
 =?us-ascii?Q?gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bL6JYQXpTlW0tKqsxiNXtRLHCuOceHoUrrTlKMqGujusCbR3z3CgbSdfwLQ?=
 =?us-ascii?Q?T2+2lxGqjqiB5XC4XNLdzm9PZTbr7sX17sTXpAa0bqVxUtxZeuJz8CYu3zeP?=
 =?us-ascii?Q?7pBECj++lgdp3hKpH0NnhnmARTiT3CSJ2g8OCQlnuYTfHqLfw9ZURHGb0yG6?=
 =?us-ascii?Q?/fmhZ9np/8x+HOy7zdXc87gAfLdSczWE2FB0xjq0GZwuVuFJawONGTkhGR94?=
 =?us-ascii?Q?wsUralM3qav2tAzsdUfCnimvXu+0EBvH745laE95/p4quFyR43ebexy9MwyI?=
 =?us-ascii?Q?RT0hBSghbKAs2Irp/5btrmWpU5jjJGHVOFWB/5WwALw5K/+WiPdN/crWlcJv?=
 =?us-ascii?Q?KFPA2oEastICemhP1IghZbcweNGj9EVqyzdEd/Nf5d2vCvompfY33vOZ2i6Q?=
 =?us-ascii?Q?pYgK34nLJSfyob+I2I5Uh/R4XK+0a84W04eb84a18iBgLDJfwfvR4xGRYM95?=
 =?us-ascii?Q?uUbnOcehQ3RlKI/KYVnMltIUBeYPGXlEX5dz2lsZGUz2nbhiBViDHiTYm4dH?=
 =?us-ascii?Q?TIEqh5/KAB+7m9Cj3VNTmJkv1iHH4E3820OzNrlDf8eUgcvyhmz1h3S0TW7I?=
 =?us-ascii?Q?8lmXi7Xf5HME/Zhwh0ps3YvBON/eGXMDB8sFpFJVSTRkf+WnkqgjzXmeo84B?=
 =?us-ascii?Q?X+ZF7e+RpJzEmCH8SU9lxjKWZr0a+nMJET3q2XqaAlldHzujjRtS5F2RfJpp?=
 =?us-ascii?Q?kz7pLXN5AJ3KRgpbafaK1EFHFQenNu4/C8BBvfzl8I6x0SnDGR5DGOrhIqYI?=
 =?us-ascii?Q?ebNWZk1lJDRP2y/Q3Y28Mh/PoMoEvMeonsz+KkhJTe6CCgtll5QATcPuh+dE?=
 =?us-ascii?Q?BZ/OXrDHqrt1dun7J2WTB1/NCEIiuuRdDXIRow1GXeUSfDw/bM7Pmh+HW+0F?=
 =?us-ascii?Q?cQLEu8kMYNwDLww69gzKmSluJRxpQ7e5K+K5myAPUoXrvzHcygfDGHfcLSj0?=
 =?us-ascii?Q?26MJd70P+otDtq1J897efpSkbZjYk6aVyb5ONfbsju5+1puexsU7yxOGex0n?=
 =?us-ascii?Q?iTagXrX8WhUu8jsqWwtR8un0LbUviqdWMX/81TiN341RBn7JQmSwuXGRcVh2?=
 =?us-ascii?Q?cgqkOJ/ONWpRG8ZxbLeUS0DT1thsQRWbet5iMKC1VwTt7WrsqUO5tYFPE9i7?=
 =?us-ascii?Q?bRV2qQrgRjDOM9XPVZ+gUdwxqhlp5G9hMD1f8K1NWn+6u357Q/Z/JlIGFh0r?=
 =?us-ascii?Q?FDe+E5tEsgCiADcNz0wCv26T9nmpUHARihSzkfzCeyLJ8ue0hUwAAeQuIKpO?=
 =?us-ascii?Q?g6M3ak9ju9xtEwxBfZlJdbs7scXJsJMKiFm902yL+7lsF4Lm+Pzo2vtjiUbs?=
 =?us-ascii?Q?qJTXpVBXv1YXiCyQRMz1SkToesQts3tcCWZIlE/ADsWw3moeOHn6XiedfrU1?=
 =?us-ascii?Q?Cj74SlBKpuI1yp1dCxLkhkwRZ9Qy8BKnnEGfsIS+k0PZ/MUpn1F6rchPslZe?=
 =?us-ascii?Q?OWaQ/rr9cLM/QKrJzBA0FKU2D4DVxBVQkJE3LgCbbR3EbFOYEPLtkg6KVaZ3?=
 =?us-ascii?Q?MFYwzellfnrWdGhUIhvt23em4q8T8jLwrWy9eOk452cTUOBYyRRe74FFVSwp?=
 =?us-ascii?Q?TttOayvPKmHxCjrM6xx81XlQuT6ONOQuieVe8BKZf8TdHW8P4KM7b4FyRcQ5?=
 =?us-ascii?Q?7jJEoB3E2orV6ppsPzzYqMOjJ+fLT/V3rrJAYn1HixX9PTHtvUcwibn0m5Aw?=
 =?us-ascii?Q?fCTh5AE/2O8bjKSkAWHqk8/wQ8WOwfBY2u8j6VJGWgsC5OHZMiWTQOCRJ6TI?=
 =?us-ascii?Q?zAO5ouIKE+prVZPci/bgJe2q7C9KctO3xf3puDjYJB1D9kAW+B4p?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed25f7c-2061-4a56-537a-08de5699306c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:07.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAG7aBHMErXrpHdya/wuvfe7joqwwK/g8KqG1SSFtDQixEU/sVsFliIS8w0P6NRsXk9SJu/ZegZcTR6He7VUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Prepare for splitting the transport code into a reusable core library
and separate client modules. Rename the current implementation file to
ntb_transport_core.c to reflect its role and to keep follow-up diffs
reviewable.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Makefile                                  | 2 ++
 drivers/ntb/{ntb_transport.c => ntb_transport_core.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (100%)

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 3a6fa181ff99..9b66e5fafbc0 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 
 ntb-y			:= core.o
 ntb-$(CONFIG_NTB_MSI)	+= msi.o
+
+ntb_transport-y		:= ntb_transport_core.o
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport_core.c
similarity index 100%
rename from drivers/ntb/ntb_transport.c
rename to drivers/ntb/ntb_transport_core.c
-- 
2.51.0


