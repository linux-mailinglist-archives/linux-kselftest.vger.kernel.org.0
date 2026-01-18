Return-Path: <linux-kselftest+bounces-49297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D632D396A4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4B8A30FA4DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F435580C;
	Sun, 18 Jan 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IuuBvnAd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021096.outbound.protection.outlook.com [52.101.125.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55E350A2F;
	Sun, 18 Jan 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744558; cv=fail; b=V1PJJMevKpot3oqPfUHRPIYjOwjW+xuh8pWNwEchGTU4CYlIFPA1NIyIYiIJ2rIFVp5ok/AdFTfLnN7JL5lm8jtNcyaKwg27PTQKv/6hw3NWtbnyBVkNpFCxt1WLoFxMWWD/2nOo1Ck9oDqQHu+7fWjNBauAIWVZDXJJg7e9LbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744558; c=relaxed/simple;
	bh=UuXGLZP37ij+tRp0htfcTkXjgDsuQT9RGFOc7U0xI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRtJYmj9lOYy7Vyk8U/DAzdg+ZrW7F6viUDB14S+CITyx1SyFEbxgCyNy0o0zADIPIeRg0rf1k24Haqa7ekak99aF7T9FZUjmoaz2hHpeAy/NKnXHfu3hHsqKW0i1xTJ/9GsxkLltResRQdP+ppUNl4CG7MYZX4UkHeAVJ3SMIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IuuBvnAd; arc=fail smtp.client-ip=52.101.125.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Yfb6YL6P0wazQc5cyhfNaEQifSw9QbhAKmgnN6Zo4Oq4GFAHVHDTMMzdB0Tv43f1ZCYMGFuRGQDQTjqeaic09CKy2JVPVxsJTJwRgVVGbRxKHUYi6yHaLw7cAWYceheYWFDQag0pmnOzDbApQxhN+zPadtDMDoypZRQvhWVp1twKUSOBQiy0XwC4ZrII8fZj8nTA2Rc7yMKnkbeTY6M9AOFvp2XFvkE/X6yU4n3XZZkA86OHiHAGuxgG3rL6kJWh0KurVHW2kxZuVKpw6UdvQtPW00b+CNvuideZorohnMQ1V1AEaEEX5HEfeQvO/Cy5ZIv7ta1WINGtuLrRLWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc0ZovYMMNE566/oX/46iFpesbOPkOjEHJvHSPWx/os=;
 b=nPhungfL7HXOIGyKn+EVqWHUqk0Bk70F4t9FoZaA4eABcr+QWsdXcGf/WzCFnm2/5HRPWy1r/mtvhpZfn75Ili/61c4OCJeTTOn8S/3w6zfsLzgiT5AjtbONSh/+BJbAj2MwGig5gRTwlh++XigaMMLoE40RJaJZ035DYsKu87AU3tyonYSVQ8AuG/FpT3JZK70VvPO6eiNs49TQ9HsId3og84hGUN7imqzOIDos1JFRgqAWEcbuR3klO2qd7TnC/KKhszslBVfND+T/32QeqvLvbUBlqS01gnbdh2DK19NwopFMEvcaAm9SDtVzFlZyPfRci1CW0o0sSGjdsjaWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc0ZovYMMNE566/oX/46iFpesbOPkOjEHJvHSPWx/os=;
 b=IuuBvnAdAPcVjwWIQUdB21d/Q/UAUBylapaDXPoRLPFJduYaLcGMFpwFrsqnp54GWmLEd3tJeT+H5VzCI1/dLR7lNhay/NEiFhXtuzFtkAOU1FgvgahLWYzddOUovZEcNbjgKnD1LPeCuWNNcz/4IB2YLcdmh3L/hyY0fQ9N5nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:47 +0000
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
Subject: [RFC PATCH v4 33/38] Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
Date: Sun, 18 Jan 2026 22:54:35 +0900
Message-ID: <20260118135440.1958279-34-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 9148de71-5f3b-4919-09b6-08de5699377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rF5wSoIVziqj7UiAw5yTEWoRiHOYfHfyIlHlwyz/80pl2xlCFIUllu4j2FpB?=
 =?us-ascii?Q?V0RPe+uFZ2Q5MCc5+x1Oc2deLQn5dlwOoYTnCib/WQf+nz5AGnweZZ5vDPPr?=
 =?us-ascii?Q?wG8WbDfcULFg/3PjBiJ4CZf6en483omlcz1C9xCPF8re0UXyLrzu9qqK/kr4?=
 =?us-ascii?Q?OPhPNXkQCBaU6+5D471DcqiEe++rYU13GJ3QfNujNaFgv7kgEOG4IVNvvlJr?=
 =?us-ascii?Q?SHc1Uc9kcFXu07HHJFczSufosLCT7U9G7PP9CN71VlR5YptxJsGqRTxi0qMh?=
 =?us-ascii?Q?OMMXk1fNY7qCucxwk6scyBNMUNx9i7nVGQbe+ckIMuLgjOKf3UwQ97W0cW9q?=
 =?us-ascii?Q?e1L4UAepRknc/PLzMARoz9nT2JhU6WpGFarKRtbGV3Z+wHFynNdc9DFmkm9y?=
 =?us-ascii?Q?VJ3qE/ELgyQFzwyCghZiqDPGoxtQ29a01hvBtavwtTYZb058KtHrgqZ7qunk?=
 =?us-ascii?Q?VhEbhBp9PyayvY84OqRDnCwUR5kBKlky7yhZkcaqSREAcC+2euG+BLrzaTMv?=
 =?us-ascii?Q?yf0kTeMd0Ur9xh+KQG5mZoaNPu5qGQbvsY8sMnqJs9ZLfTEBPRWZojvIiuTS?=
 =?us-ascii?Q?p/Fxkd8OGleZr8fhay21ytaVubgcF02vxMUHTgwDy43SXbTZ5+HMTkuTCiIn?=
 =?us-ascii?Q?RJGgM/xnz/u+D5yViWk7iYkQVxE0txs0zxDGlgvcxEUj6UlrxnSit466wdqa?=
 =?us-ascii?Q?ya/2jQRul8vl7i0KvxswyvK6l6YJWIuUr2FApK4Rr3UdOlmIql6xMEmMIMC7?=
 =?us-ascii?Q?tg4syY/L9iuLwj/+xm+71izYOIt+hO9RjBKq4dTiKEkWenewYhsjCFq24RMO?=
 =?us-ascii?Q?UA7V5nA1vSMrrjA2LeGZbol2oXp83ZLCj/R5iNXckprwE3wFmvCeJTq1yyNR?=
 =?us-ascii?Q?XrtLm2H/a5fCGMBJv0t8OgNVqF2RZmp1gwrFMgyaUbcWyhs1M3174iYR7y0I?=
 =?us-ascii?Q?6EnfLYj/c60/P+wMOgvoDc70e7KimHtKXro7hc0z75OIqZr356zjfYenkhUD?=
 =?us-ascii?Q?OEK8bPH2UGzkD7ZmbuobJcYv6ZHE1753t3sy1aeC/Pm+OQp5qFfduTVhxCwj?=
 =?us-ascii?Q?rb5yU2WzgMpcX4BmaWVymYB6s94ykyvHJNZFxhD459rIEtac9atl7zFw93dJ?=
 =?us-ascii?Q?gC5FUNpqxK//j8PSorXyCYWKkn0Dcgolhn3rguw/4QeOtUpcg0nmi6oaKN43?=
 =?us-ascii?Q?atE+CPcOBMCeNIcO6OC1h3dYiw4dvWVeLom+qdsx64EJhT60GoPGXmhZGV2z?=
 =?us-ascii?Q?RyHiLU9QAuX7bGSwTnJ2ptmrycbLwuOksUUbplb0sLU/tz09ifO8GGf4vd5Q?=
 =?us-ascii?Q?7ETkNEsr2NYMfdvvKT3/Kyj+ZnDijgY+dd8tpAFa1dtAqtTNT216hBZq3mFp?=
 =?us-ascii?Q?s2ClFHj19CPWGoMEmHeC7gwKP1MC2ZAvCjLinjFy41zDZpnrp72Hr2MZoiDU?=
 =?us-ascii?Q?ddcsjHsU2NccY8/PjmWZ3F+qJ0S5E19/1GSFRITM4Mq0qbzYxZS1UDjCV2CD?=
 =?us-ascii?Q?nDTAy2gOxtJPIh4ZFYc/KkysF9+zuQ5wNXV5vU+vn1jSXuxfvpjVucx7Kl+i?=
 =?us-ascii?Q?xsvFRmZ15gH+zeKEj1w9tM4hVHNHkjtxFcpcKOOQGOmDkZ28ArTxcavvUzej?=
 =?us-ascii?Q?SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JFZNuyOWk30FYP3X2M1z/ArRg6Q5bLbXqDDVqvalzUuwDpY2jFlKLA1boMxz?=
 =?us-ascii?Q?V+F4T9TcXNjSbL0XHGvEIeu83pcKJ+7zZlLJQyop+K/l/VzcggptIk3Wzau8?=
 =?us-ascii?Q?qHfYOUEBif0VYjma//NvQ7H/5ZbcA5uaS+hJ6bepvphp3mwWMVRlT7daCXQd?=
 =?us-ascii?Q?bTIHEU2+AZLG6s6cUVSFWDHxNiZIMnFY8zeyznupOLPhe4WPYxCfa7We1LtZ?=
 =?us-ascii?Q?2i2cdFJHfXTVYn0wBqFI6TvemXZDcTLQqKDBY1jhOlR5hHtw0cabM4qsYfAK?=
 =?us-ascii?Q?mAXp9cN3vWhwtYx6tQevdzpVPq1LZ5XjCKK/9DiA/VtutZeKkmFnKIQeGv2e?=
 =?us-ascii?Q?W+cimL1ZBJBZxXMXVvKlYzMSQLztPeDEmfUohpqxSjljkkBlqu0Niq987xUa?=
 =?us-ascii?Q?Gj+6YM7NA7THnQ0hRbzIIsF9Vgd1eOHOnORU20gLDquZTRfeVn0CEj7gE9rB?=
 =?us-ascii?Q?8QeyL0zO3FvyO5MM3jemNWIk+qO+M/8iSdg181hD+0YWeZTVhNh3vLdxh1nD?=
 =?us-ascii?Q?Ol3xUPbFB2uzlJjE7sM1wEfu+gvgnQuFbiWqDgi4741L6eg1OBAReZ7F8KPO?=
 =?us-ascii?Q?bZQgGv4FH+6c/Y4JTc7KHyMWBs2e5S4Vt4GfIn+UxdlXHl4LUGGKRcGyKv91?=
 =?us-ascii?Q?zHg6+2yYMi3I56bEhhx3MrcXVHT/s544P/OAD9Dq3IEIo35SrtFSE7bcd97G?=
 =?us-ascii?Q?j8X0SX3HpaZcK4vXDeTHVUwgukjeTwbiD3vChpyGz6sUlyj/8O4hsEe9hnvk?=
 =?us-ascii?Q?G17BUae0N5TvPTCR/BA7DYUUL3ALkks7Ge54BIaYyo7k+Ns4wg6J3mSIEsas?=
 =?us-ascii?Q?WnzE2135COP5bIe2JX2+JYx3Wh4AdIgB7ZvjdP2TnLGcWA7pX/RbqS8e0n4Q?=
 =?us-ascii?Q?QOnEgsBjie9Kie9KXOmO0gjvPOyV0tzAhahz49G2hIQnJMh6u+HgoEkXicJw?=
 =?us-ascii?Q?9uS3OSRMkAtoO5LU26ZijtuOod41f5N3OaUQzTq7oyfQXmY/DKp3CAv6FdPG?=
 =?us-ascii?Q?9NMApr1ExBsvqnw3R4u1MkLjv4lMfh61UoJd2q2JOm+4BQiwQr3+nQeYSZGw?=
 =?us-ascii?Q?1UeUArcCDop9I7NEHrFWzCeZJa7ZNEXr4hj+Nkatqz9ELGLYhAT3j0oM+Cmd?=
 =?us-ascii?Q?WfEbjrDrze6n6odsA0XRoMTTBghNc4Iva9wDQFQdxboubIvNMIzRTsZIWfM5?=
 =?us-ascii?Q?UnoAGUVVoAt+gAjUiNZZD/o6oZvMPlQ6xnpQAjjLcxhK35XaDtFKF29WCpWl?=
 =?us-ascii?Q?ofWRAVJhfdtsTv+ukGK+qSMWlbOamxiSHVB6RlH0C+igVSsp5D2kptXY+ywX?=
 =?us-ascii?Q?cO5mQx5FhKFH2oir+yiT8kpM45NAk0pfaUmdVQs4Ui8iVYdXgzYVXkSq6FTX?=
 =?us-ascii?Q?h7QqtFDvjlAh/gi8G+DV+qVVxGjMtNflt6Y4sTjIk2fsGEf3buEjqtg5biNP?=
 =?us-ascii?Q?uib+78vFqFRicMPCbngVOy4mPCDFrjr8BH5oUTJd1Lvh0l9p1NfuUp3j9oI3?=
 =?us-ascii?Q?mxvuy5mwacExinVYJ4LgoxlVBBpXswaZiMNx13q272WPyHeeHcMCYnrZpqJS?=
 =?us-ascii?Q?KCiQXY1jkIu4OdoBUHDXPOiLF6Vsxri2+YZVewVsHyPOB+KS+LaHmrlnKzJM?=
 =?us-ascii?Q?OMWKPMxF+0glQuFdGaOP8FkXCb3ft8K/BaNw0uDNWKBkWtWJ4fKk+8ntsaJa?=
 =?us-ascii?Q?go+MVk2K6dWIsr3PVBD66Zrmi2TO/RDV+MtaC0c0/GVcfr5+8Ipuyl85/X5x?=
 =?us-ascii?Q?y6mLKHk3xnjZb43kXszDpJFwSoJy19zTfFYCNwapdjFJtuFq+Fvs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148de71-5f3b-4919-09b6-08de5699377f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:19.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaChMWr9KA/D8dufZYhQFIobSagIl0nsfETjIp+amqtyufwWp0NkXvSAXeH7UHpguhKE8cpTNbCn/a0fGYssnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Add a concrete example showing how to pack multiple memory windows into
a single BAR by using 'mwN_bar' and 'mwN_offset'.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..097826f946a9 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  mw1         mw2         mw3         mw4         num_mws      vntb_pid
+	db_bar    mw1_bar     mw2_bar     mw3_bar     mw4_bar     spad_count   vntb_vid
+	db_count  mw1_offset  mw2_offset  mw3_offset  mw4_offset  vbus_number
 
 A sample configuration for NTB function is given below::
 
@@ -111,6 +111,19 @@ A sample configuration for virtual NTB driver for virtual PCI bus::
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
 	# echo 0x10 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
 
+When BAR resources are tight but you still need to create many memory
+windows, you can pack multiple windows into a single BAR by setting
+``mwN_bar`` to the same BAR number and using ``mwN_offset`` to place each
+MW within that BAR. Offsets are in bytes and the resulting regions must not
+overlap and must exactly fit within the BAR size. This may fail depending
+on the underlying EPC capabilities::
+
+	# echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
+	# echo 0x20000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
+	# echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
+
 Binding pci-epf-vntb Device to EP Controller
 --------------------------------------------
 
-- 
2.51.0


