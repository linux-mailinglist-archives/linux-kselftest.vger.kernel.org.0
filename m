Return-Path: <linux-kselftest+bounces-49277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6AD395F4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4F43053A29
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1B3396F0;
	Sun, 18 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pzuPeAse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08678337109;
	Sun, 18 Jan 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744523; cv=fail; b=LMRiHohisZAtHaCi+3YyLNHvdSKLrxyGkX29umaIRFKNXTlqOIGBhoHCa8Tgk/qoFha0xCzu2bGYVveeudccpyb15WVCNLuna7Hfv9t+jVwrNNTr6M+vA3CBvurDqIbnqWziBAhT52zbp9ozYSUtydSXqUmxhO6Unwjzvlb8hX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744523; c=relaxed/simple;
	bh=AthnnlCSny2A5GQEusolaT2l+6Xgfevjjru/6zRGDvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfhrmimNVLz+Tsq262cb2tOOL0U+9ish/VgqZ3afY33yoJOaXw8pU4XFpt6e4ibNYsENOXs/WSvZ53rJ33zzl/G3LojNXySTXlVOhM7zMjogFdvEJ3HWZAQ78SzMb9ki0LspRIcQAqugNX6ZAj+vjPEFf9ehkKKbOgDwHzQRfPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pzuPeAse; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+0SeGGIhUEfZmItnNw4itsXbyJfrlseZYwu3ea3j32eYkbPvKYprrbTmWnEmWQmzE/Vwp6K/PMhGB4ckjtRLEbA/OfmjFWf303vGyqJnwgcc+/pbPTHS/wjh7OW9/lVY7JN/kh1HnSbWOMlLa7mxY5fcKSRWph/1uKnMkay1vytUi7j/+demC7YnLh/j27Gly0TdNvMe1hAWzOaP0lOpY9j32khEc31t0554WuT2FXpTjRwKvQAHNODIttze519Ma2tsZhHvznIb5J8xa098XyRe46LaaKprgrMi03HUS4fFDeK15A9ZyLXTG46kyd4oNIuNCTauZc7cd37Wwagbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u73dlqpDq29oLuvQHiiZb0Tp7TeyOVoMFS8z6lJtl2g=;
 b=M2xZOm+NReuZNt9cXqEq25k8OmuM/OouBjFooKPNpvq9TmJXAZQdoFUiMFmNC6qIE+G/yWrlcUz+u+1SrxV9eHtO6kr+pbEp7WpxP+uNBKgsJ2BNjrho36axTOlWhkcnOeciJRx22CPti666DNYgAGadxIFYd1YurtzooH/SZI3bGxq4sA5ht4d/P0Pn9hHD2f4J8zhm1Hiv4j7I4Irj+W+67b1pCIGH2DdjdGD7mfXUVZAAFc1NcYk3DTuBp6YX7Wo2omEXG8V2qTAQ+j7/x2HVDFMKGgh7FF5tM3VyzcGHZqWKjlPlF2kn1i9dCMCuYTD7oWVVfkCZ073SfkDAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u73dlqpDq29oLuvQHiiZb0Tp7TeyOVoMFS8z6lJtl2g=;
 b=pzuPeAsesVsDbkzn6HVOkuLLX7j1veG0dQuQQN1yiKf1bqlgnKGLJQLKWBIBip/JV3TNdVJtavLl5dxsfP6mncSvvDMucEYxkD85eMwjBHWuoK7mmtEODBZU6CWnv/2xinZe8pnAfNCDZ4h93yA6HDwE3MzpWIq49dROhgK4RyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:01 +0000
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
Subject: [RFC PATCH v4 12/38] NTB: core: Add driver_override support for NTB devices
Date: Sun, 18 Jan 2026 22:54:14 +0900
Message-ID: <20260118135440.1958279-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: a299fabd-418f-45ee-d3f3-08de56992d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W/RNiu502YQa1ompJ4UOTIQaJ2PuREJlDdZpIXYxr7AYamz4/84/dN5ObEYc?=
 =?us-ascii?Q?FJMXRMzWepyOQzVRlwX6syfaKMW+cnL677uJSzGluayntoxcIGFqgCyUn79H?=
 =?us-ascii?Q?cOfu70r3QmY84p3MtWhWgGseW+fMsMFK+yZM7+8jlKWACeAjVxSfHV08nl2e?=
 =?us-ascii?Q?OQT9VYZ5liawAdum6Vy/7uXHS8tmE6O4o/H9ek+etM2Fo1IvRpCqe+72aT05?=
 =?us-ascii?Q?vECqAiWjrOWum1NHH0EaLOiu8/wApgT1Zmbpk4JwobJnZU2pE77/bgG6hKqi?=
 =?us-ascii?Q?s++J8xI1HiFs8YLogxIkDWZ7Xhu258VhwiTFYNdKvDva0MS0STlr5XIiHQ8w?=
 =?us-ascii?Q?ht0oLHYpOELNLF7yqdeeTmGNYeXrqhOvIqvRfgeN28BJW/y6Mjsqef0+MXZm?=
 =?us-ascii?Q?1cAL+ItRAlX3Z4n60Kmhys9SkcFuOfMIiJ/YP9bMwLMoxtmS7AiJmIHe6Ov6?=
 =?us-ascii?Q?w1Ve4+yBwZTO818dzDNJYrKTF07yZkTOBqOVFRcrkaXdE3nDyXOK5WJ6R/Oj?=
 =?us-ascii?Q?fisQSYQiJoVm5adFNbCGg8f8zfcIV1bBgjzkZhTaHCtU6VTo0sWDtlM3EvTj?=
 =?us-ascii?Q?Oxo+NUlNZ8qU/GhAfHxnBNzPYMMHrwQTJFbNM+9+GxgjQdA+msnpozjrJchC?=
 =?us-ascii?Q?Rx4SRsjwN8Fa/o3C7YELEJVpkUxo5bZpkf4FbEPgXe2aD+s1ljqZT73kznEG?=
 =?us-ascii?Q?oYbA5XBoWI7XZy5VPbfJMW0DqHcM/4wrc1KEKD1pZEVCOPvU3SiNsCWoACsD?=
 =?us-ascii?Q?sPly04AbnvGt/W70X/leAQjN/EAJcd2IGdCbWkx0lRP6jO6nZo3rr0Y2efrz?=
 =?us-ascii?Q?lMq5qoyQDKBp+q4U5mqxesMFJC79wKyjldt5dNBUJZpnht74uOa/NIC129FA?=
 =?us-ascii?Q?+W/+6JWAd3hWtLhpLv6lz8VkOxWCej+/Qde48h7QFsDxZ4U5unpduyae0tFb?=
 =?us-ascii?Q?oMhfLE5kvOmIxfWrruvoHeYVzgd5iA1nFIy4VChkETshA92Cvz+rxxn4GLrG?=
 =?us-ascii?Q?4rnc1fkNZPQSjczVy6eKPFYhKQFuC+XZF2NcGQuUdFZS2GxotlaR63DHJjA0?=
 =?us-ascii?Q?b5XkxTJtXMrtJ7J/3O0y3VcMGiJC4Ol8NQiOVAYLoxzgz4GyK+gMr6i2G1Yn?=
 =?us-ascii?Q?ier/PXBRzVqFvd9PYY6QQGlgWBWzQc3IPER+e70VZDlk19S8/iueCebvRlAZ?=
 =?us-ascii?Q?CTlrAuA5pc1ctaOersARiJWMiEsc91ffLwlnI9RC+Tj4T9/R9kltm1BQaPNq?=
 =?us-ascii?Q?9YQ251vO7eJaW6Xp0GRCUJLNtnHdSbk68f0k/nvtU/W4NgzwJnDIoY6Mf6Iy?=
 =?us-ascii?Q?3Sba5HkTdam3R6ONQuo4IkjU67dA4+VwZphGBqqCZJmKpz9aBqivHeRbdMEY?=
 =?us-ascii?Q?R0pYb4ISv1m5i0calpugUUq5GP4G2mxBiQYehckB2chJKn5kV9vyaLqQcMOq?=
 =?us-ascii?Q?fyUxzhr1FVRSi4/ZtJW7yevJn0HGVZgy1SDII6S6l6UgPhO4JuYQvnQVkSHH?=
 =?us-ascii?Q?TMpytWTEHGUFy3kK4Frz5hUiXCVuco0BAeKqTYKugJYS/zutff6BPMnZDDPG?=
 =?us-ascii?Q?X1Rl1s5npjquaw+3D4UTaTmOOU1r7IeM5E/cO0XlQ4rTH6u4K2EY1060wF+W?=
 =?us-ascii?Q?QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Om/ivGc38KtIJ3A5+J3HaptfZ5E2+NmIbxyRzAxjTathN8yVWXPkGSkqrpm5?=
 =?us-ascii?Q?XwPFTsOthaQVm1wnkq7bhVkJbO4wxtnvpRMam38/Ujf381gl0Sa5eqw5JvaB?=
 =?us-ascii?Q?SmPndroTmEuRnErk65j/iMXEwfyezzaN9dVOpi23Pz/xnMgHuqKmt8DwNrcf?=
 =?us-ascii?Q?XB/gln0l7IB8Y80qmDTGuSe0REeoLDdslGMbiMRRJxQm4JJRnyOyxvib52aA?=
 =?us-ascii?Q?lts3TlFJo8ARBAJY9PUe3xvwJtZhQdscQ1Ffvr4qOlo3x4XlKOjpe3vCoApK?=
 =?us-ascii?Q?cAC06JE18UABkMAI7UJQGU98PbRNL+1SgEgDT2NHnxAGEFttmkYgXcxUQhxC?=
 =?us-ascii?Q?FEnJq9FEbRquZjw3xXYIvSN08E/9x0sk0Fy+EJGYqk3RmB0Le0uZiNlZDwiE?=
 =?us-ascii?Q?wLZSEi7SC92sn/c3Xq1UKS1II9oaUr+vQky5F6h6pY+cWUkNNv/f+GC52Mof?=
 =?us-ascii?Q?ib773U+Gw0VWIyAkflMPeeKQJtgCan5YxxfMjHYz1nCo1gVfWzeA8LsES1L8?=
 =?us-ascii?Q?i5Rr4Mv8I0cMZaIWV1DIsQj+CxkOotsMtgrtfmWynMMxR1odwn0PSPKNvZaa?=
 =?us-ascii?Q?0LtvVIZ/o3GGkwtLgzt0fo9mQ9tSnksA4omTWtIT4bQiPsCpmCQFiRjYsyoQ?=
 =?us-ascii?Q?4WU6HENRoIdxPP/NIskAbolWpY/g3bRJ/9WUICT5j3rneCP2xbQBkOIhXwRo?=
 =?us-ascii?Q?NPH+4BTU/p3/VRzSQuwLqik/6/dRwMNI5I/+YUSnV0amhoRVUMY8YVE5ihZn?=
 =?us-ascii?Q?LAw66sTitLQIXLklpyvIPLaK5dqB3Cwd8W07GTeBuZcTGiow0zT5stoNjYgD?=
 =?us-ascii?Q?r4y4HkAXGoippNDVfSTEVUzfhbbrjudfyuY++F0mUImf0LdZVITaek5P42U5?=
 =?us-ascii?Q?7a93kixoSiRYoo7jArxmwRCjbytA6P3bvkwbTB/iXcpUK0IWsndC7eWbAqir?=
 =?us-ascii?Q?gnE8nNmu0QIoDJ1uJY6l1cmVjPA+fcht86dRt+KEXXxNoo+2C/jEkX8b74uI?=
 =?us-ascii?Q?wz3ndUXtFt3DFK+Yo8yKhs0Cj+yW9unfqWOFzkV+Lf15VRlmQQIH3PO33j+m?=
 =?us-ascii?Q?gxBel3izEAo5CTkXCDa/sVIznGXV0efBtKQKuZTyiohCCiDt6hkrwfLqLEKX?=
 =?us-ascii?Q?vPRA2a3UnM5dY3i8uL78uCNXpqr3CRVUdpmawzJhZoXVPOk3HEwkllDyAMq8?=
 =?us-ascii?Q?1nMwhxL/Ls0LUhOhNPHSo8+rmg/Fhr/qzTwBjXwANsR2emSyScT7hVseT62E?=
 =?us-ascii?Q?kfq+a/Ql5+ldbqa7rCtrpYLDoRO3GBXAldW395U2owuVxobVo/HnvAbS4xy7?=
 =?us-ascii?Q?Tnuuk9TsHf4eaEQs9Ywt4deFKdrOlCgH4Yfs2LkNwpoFKgINuR+KkPOv6XVH?=
 =?us-ascii?Q?a43o4HXugP22cUbUnceW0nY01qpffGYxLqv49jROhgbna35Z/mWhLtiJ3/K/?=
 =?us-ascii?Q?Rw4EOGEtHpkFUTKpAKgoY9aLYpGrG90Rx3NS49y2LY91vURnTCdQlyPf/7+f?=
 =?us-ascii?Q?xfKBce4wIVK6LlDPXKtg8lO5fuzvjOiGcZKveezdkVHGLRLA5+BQsyaJkXa9?=
 =?us-ascii?Q?mcwCnP0tZyexvFYQcmNVLeVr1Z1Yt4wMmZcJvn3ZvjhziOacmi7T1Z6pRVg7?=
 =?us-ascii?Q?kUjDaiWjkAjAj37mWNrprXD0qOooKqf2i+9+WKziT1+dXtBWfOiArKxAJoMc?=
 =?us-ascii?Q?+WYoTQVlWDqz/gTarSTLi1Tj5Cbwh2O3mY/xuM7PNcLVSg7P5wGgbaS0F62a?=
 =?us-ascii?Q?u6mcHoU2PMM/WApM3Z7PxvKZR1wrDF1b4Q0DcD2KaSnQEC4Iw5lo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a299fabd-418f-45ee-d3f3-08de56992d04
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:01.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdQ7jLsZlxFLvX4MedeluLVtXjWK3aXOlEHwtYzJCTfNNmeLz21yNbyJ12FSqklrjMfh8rwEGGkqVpbumg8NGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

When multiple NTB client drivers are available, selecting which driver
should bind to a given NTB device becomes necessary. The NTB bus match
logic currently has no way to force a specific driver.

Add a standard driver_override sysfs attribute to NTB devices and honor
it in the bus match callback. Also export ntb_bus_reprobe() so newly
loaded drivers can trigger probing of currently unbound NTB devices.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/core.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ntb.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index ed6f4adc6130..404fa1433fab 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -56,6 +56,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <linux/ntb.h>
 #include <linux/pci.h>
@@ -298,10 +299,77 @@ static void ntb_dev_release(struct device *dev)
 	complete(&ntb->released);
 }
 
+static int ntb_bus_reprobe_one(struct device *dev, void *data)
+{
+	if (!dev->driver)
+		return device_attach(dev);
+	return 0;
+}
+
+void ntb_bus_reprobe(void)
+{
+	bus_for_each_dev(&ntb_bus, NULL, NULL, ntb_bus_reprobe_one);
+}
+EXPORT_SYMBOL_GPL(ntb_bus_reprobe);
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct ntb_dev *ntb = dev_ntb(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", ntb->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct ntb_dev *ntb = dev_ntb(dev);
+	int ret;
+
+	ret = driver_set_override(dev, &ntb->driver_override, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *ntb_attrs[] = {
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+
+static const struct attribute_group ntb_group = {
+	.attrs = ntb_attrs,
+};
+__ATTRIBUTE_GROUPS(ntb);
+
+static int ntb_match(struct device *dev, const struct device_driver *drv)
+{
+	struct ntb_dev *ntb = dev_ntb(dev);
+
+	/*
+	 * If driver_override is set, only allow binding to the named driver.
+	 * Otherwise keep the historical behavior (match all clients).
+	 */
+	if (ntb->driver_override)
+		return sysfs_streq(ntb->driver_override, drv->name);
+
+	return 1;
+}
+
 static const struct bus_type ntb_bus = {
 	.name = "ntb",
+	.match = ntb_match,
 	.probe = ntb_probe,
 	.remove = ntb_remove,
+	.dev_groups = ntb_groups,
 };
 
 static int __init ntb_driver_init(void)
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 7ac8cb13e90d..d0115b0bb14b 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -431,6 +431,7 @@ struct ntb_client {
  * @ops:		See &ntb_dev_ops.
  * @ctx:		See &ntb_ctx_ops.
  * @ctx_ops:		See &ntb_ctx_ops.
+ * @driver_override:	Driver name to force a match.
  */
 struct ntb_dev {
 	struct device			dev;
@@ -439,6 +440,7 @@ struct ntb_dev {
 	const struct ntb_dev_ops	*ops;
 	void				*ctx;
 	const struct ntb_ctx_ops	*ctx_ops;
+	const char			*driver_override;
 
 	/* private: */
 
@@ -1770,4 +1772,6 @@ static inline int ntbm_msi_request_irq(struct ntb_dev *ntb,
 					     dev_id, msi_desc);
 }
 
+void ntb_bus_reprobe(void);
+
 #endif
-- 
2.51.0


