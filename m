Return-Path: <linux-kselftest+bounces-49270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E15D395CC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59BB2303BA84
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F633321B3;
	Sun, 18 Jan 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Vel3oa2V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020076.outbound.protection.outlook.com [52.101.229.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336133344A;
	Sun, 18 Jan 2026 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744511; cv=fail; b=Rnxot3h9QWjp35UKE5GfuRZ/ufyiG82GZigdqmqnghWDdQJ6Dy0GgnEMjFjHAOeJR0BXVKy9ViX/Z5NEAd8O1GnGmSSiB09Pg5fTp6deZ8DRDCNR6dOpojTqm5CZ50ymY9AGaZ694aS3+keWLb/RdfdY8QFM0P8kk56EcvFGg3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744511; c=relaxed/simple;
	bh=02yU1iirFBdmkkdC2a40SpIINzbunfoPIelspJGz/Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3H++ZQAq+ibPxpaVdouWILEHrXp5s8NxE3Hba7VlkVAqoDiVe1AMzYYEro3OiV8s3Eu1NjJ6WMh2MFcNqn8DCZ0kksXDYvf+ffenhTisAqnk6SoaftLumq4f40zsL96pGtlpAfNBnMyOzBi2W0GTf17B8pNNETzUpD/eyKwydg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Vel3oa2V; arc=fail smtp.client-ip=52.101.229.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU4I1S2z0sA96BkM3Bf5CDqgZdW99Z0gtIM2BwPfPAB/8YsEu+ciYh2aZULmf/+39+9PmeYrvDTQnkhnzvHG630Bu+ZK4yHmAVutiyw8m8f/ENmRqU6Z8V8jQ20bsjp0z4ZIkstcZ/O3IToDaso8iOH5SZEiD1wEVH09Kc5pHTDSN8/OMpvXeCiZqLweajsCiKkQqrJDzNN6cczqm1v5uH0TOSi6VT1X485GwKoAXNCrUMvuZbahLwewww43YQ69sWGlKB2jHflsA1iFpOqrphnk5HKRmIxMdEcLcLavHRk3rseqNsPbeeJ07oxVHtnfIjRt7/KnETN09s4uUmXVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka2n4UdZ4tW6wcwTwTrw24yknp1NSshf+yqmqy77S18=;
 b=F1LBbj7So5KjImV6PIEcUNPJ951rFICBgF3nhWlRd4FlZL/TzKGXgH6OB4KR/9nMbzebKpKrUilDO26teIFX10E4IHlJQBhIyBjCgzJydWd60fRxycWafQvW40M40Rpr+HDBCmYRgwKIzRBe3LZ0CrrFyOfsIhkReLjtbchzAflSnQiPZtiHp5ydP/YPAmPsInAj5wl0ZvYPnCQx1bctG/WMrG+GJPlOfkmCPk0eI+JCGmZQ834FoFopatosSCdzSQcRd+K5f9RcxfV+RUBmfLE/3OL4GPEd5rEHdikXQfonplGDmelsNeFRdE+coRk+dyvIOeXJKA4VeqDy1L9cSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka2n4UdZ4tW6wcwTwTrw24yknp1NSshf+yqmqy77S18=;
 b=Vel3oa2VdZG6NxYZHbdjCCZ6CMZc1tJZo8iIAI3ih717w7iaRuK2cmNWTyPNz2v6qfZ3TvMTwxuEjQLtyGMY65aLzovI8g+B4EmnciV4m7O3fcMe9fb3v3lsXMBhIq8ox9TeHrF9LXdnVg/5P1npZagXkTHJ3p5lA4SGYcbqL8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:55 +0000
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
Subject: [RFC PATCH v4 04/38] dmaengine: dw-edma: Add notify-only channels support
Date: Sun, 18 Jan 2026 22:54:06 +0900
Message-ID: <20260118135440.1958279-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0184.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc938a6-0001-4643-1408-08de5699290e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtULEGzxV1eqGxWmURv9UnFTi7+wUuhDTa3bohNs7q0Szvk2aKUh8OxKCsuJ?=
 =?us-ascii?Q?OfUheuP5bwNQ9TOVdYtbynvYVK/A0xZhMbRakt7MyxGFaipqaHne4oDhl0Yq?=
 =?us-ascii?Q?fAaovbtzGPSnwV1W4V+8zzV4t6pmF1Y5/cXL1n5nSVUBn6stBdrQ2Pvw/DaA?=
 =?us-ascii?Q?kB3xpcD4Vv0bKUBttX4iIQ6dYuYZ0n3zzdY1xOZ1nowrfXusdSZ5ZWGBJtOx?=
 =?us-ascii?Q?Ch8aG0a22nHShvEDg3wfdVdBnekWWiUtDHVNCNXHHUZ2wUAySI3etOkf8ZUl?=
 =?us-ascii?Q?7K4FNwusLu8zzl5BWlNtp90FMMIqglKVzmaO6aRQedfZ/nckOowvg5CQSZPo?=
 =?us-ascii?Q?iss08fH7NPRfPUEfO12NnQ7jp6+EtW900Nb7qUnuBy0yv9TqALnl7UCPaV0m?=
 =?us-ascii?Q?2a3WGCqzPBaJZHjY5KKy1XKA4+lqpXHA7nrzVGZjFmgC1tEuILnS+DIvYNhg?=
 =?us-ascii?Q?a/x4hFopbciDS7yPGsi6W8JNDv0a7iRte4ETS75llytcA94S+mwyYQ8uWG6S?=
 =?us-ascii?Q?wGxO6F6cGgKHF7TsDHKHj3SIR4ZL/sQie71nPwS14ZphYJu0ysn4GVpBhn5Z?=
 =?us-ascii?Q?ELN4zOphNvGpcha2+mlt5YGpZLaAj5BXloEKSCIijETlMpoMlq1/Hc7jZFsF?=
 =?us-ascii?Q?3L/Nb5XG2YhwzmwIT7bRsGozHiI8GEZXOZV7NNrzQghBuRdDiAtQ2GGuXGTE?=
 =?us-ascii?Q?9/3p/RbcskRg6myqTWncC0oaOr8hjNyqWeMrhrsKLrGd4lvFapM++/hhPi5Z?=
 =?us-ascii?Q?6t/wYGOjnClyM+VEuXGiD4HRJPtqwEm6i7moB3aazmPdMPSSSRiadM7r6kOo?=
 =?us-ascii?Q?DSoaekqM3656xwqdxUwuGv3SoN3zrCmmsTJaSD+V7tay48v+wLWWLNE5Ynja?=
 =?us-ascii?Q?xXjuzNhMaUOW3mGRkPMWBWQRKpV2hEO2F4Ucmuejvov3ox2RYcriS6wr4rJD?=
 =?us-ascii?Q?yUo1OGBRv/SkNFNZXRki/LlRUoy0TGmjuji07SdXtdnIHelYFiYezFqEt6LD?=
 =?us-ascii?Q?OQRno2gHNd9hA66VAUb0/o5DhLkCL9sFoeT8GoWwyHq7lNPCLlQzcWvtOs/t?=
 =?us-ascii?Q?/4erOo7jASvZmKjRFw/LaoDkYINiEJ4pMFJnIyEHq4eSJv3fdF5JBPAzbu8i?=
 =?us-ascii?Q?JkVYX1t7x5uMdlWaD7TF3i5Rq4ihY9PRtpl3QhX/F7uJ9mXtSvKYTFarCoPB?=
 =?us-ascii?Q?rUHGT+xuY3qC+iihZ8bibi2TKj9n362bl+oEyJvLG//wJsZBNGgkIHpZCVgz?=
 =?us-ascii?Q?KdOlBi092/Yfy4clF/N3F3w1GTfRuYIDJNZD4cq5TkLaBxcTiawMqix5oGmn?=
 =?us-ascii?Q?H06knAfJ0YA/RNALKVELD4ruusYNPVr2jW00qvNCerOOt82Nx5SgVqV4HWum?=
 =?us-ascii?Q?jbdgm4fKsGGStB/tVjtwH8xxRlR7LSXQAn2GQ0K7k7M21O4TVDKCW9zSfI9d?=
 =?us-ascii?Q?IbePdGjYiLAQ8uNYrZh03lT3F9UBUB46f092WwJDd1zvBgAb191tWhDdXTo9?=
 =?us-ascii?Q?OwzF3m7qLXO24LHdPajl7OL7tHCcKf02V+K8VIjwdR0JNfye+5m3KTG/ks5Y?=
 =?us-ascii?Q?8Dk4K61PehnXaPkzm+Ut5ayWxHc0gjzkzn+V2eo7FCW2YJbLCVgrjXEvOJ6z?=
 =?us-ascii?Q?0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkmnF4piaJMnCGGZkvgV/H5zDAom7KFytvMbjp6yBA81PmhJDnM4bN1Xxnf+?=
 =?us-ascii?Q?CWSYMTVVfYHA2oNi4/5iqYO0QYSar3vmlQ+dl3agTUr0c1hQKMAnxbF1g6/j?=
 =?us-ascii?Q?elqVIirwhb/Gsh7O5vxGZlCd8LAqZco2OKpV5xE1qW8OS8j1/qgznXHJSKc4?=
 =?us-ascii?Q?k4NrlAecRmVrDP5rCtoHajts4DF9CpEm9USkekY8cyQngyiCHMvlglcjE3Ym?=
 =?us-ascii?Q?nw8ALyrDEbH2MNSQ1bjpKPmwpYYR3aoYi7SYu7+aMmh3Fvk4NzBJTXlelF8T?=
 =?us-ascii?Q?+Jo2g0IJDpYgL84aBP+qQmAyUu4WMTUs3AeoMyGzAuKeXrpc7CwTP8GjD2+/?=
 =?us-ascii?Q?pnoBBQFFVtcVOXbWfL0O/zevW2SIJz7WjvTs07B9Nqy+hUpWF74XERVIGQpE?=
 =?us-ascii?Q?yb0oIttxH9YYYODJRJH4a8DLa0wyHSgjcKwL8nebSvXHC4jfQcHYBJ2Tv7Pa?=
 =?us-ascii?Q?NL8nFT839VqXE9dSmeM5lAp3lPpY7aHEzO4tw0P15ZphwQQ1mvI+8ZfUGV4w?=
 =?us-ascii?Q?XthG8mRhSEBFGk6hQrAepFxCOB9wV6mvpvXXk2o2KX8K6xkyr4YXIMDZvLtB?=
 =?us-ascii?Q?aHVy/ZI/zVRrKH8YJBpmgHIc8HkrVIKr6+2gdVfnjc01gYiWDDdtUgkZGycV?=
 =?us-ascii?Q?m+B9rwEmkXwv9hCbkLgn1W9cljAzOQLlhON6VXZA4i+5dV+Ytlcmj3IEkxHc?=
 =?us-ascii?Q?iv7l7LJoei2z7p+PuU6vBT4J5vHcSx3TQu2fNTdbS4GWh1X9w/mo0k/iJCCs?=
 =?us-ascii?Q?1vAn8OwyNHZp43xRXHJFZrQXfDKu1fnXBLOKUlyYwevtFHQlvHWAEsEYFzIa?=
 =?us-ascii?Q?Irtqw1urw/7Fr3cmY5HkCBq53Gtbh6oVOY9VUJB8GbYpNU7HbkxOv1kt0A1q?=
 =?us-ascii?Q?6rxHn0wG80WcDvumbWtt4BwSE53EqRoqL+zjXdE3sz9+u5hLy8r1G5kmq0Fd?=
 =?us-ascii?Q?oVSlFfoLH/BHuYgq9W6ti+sb7C2jeXmWcFHKhktFewVWJlIMxWEN4xvEX3Im?=
 =?us-ascii?Q?83qN7+k+Q6EPJSkV58AHDQtJAlbvyw75sS/JGMLvivd/6LJ2rkeBfrgbSxTs?=
 =?us-ascii?Q?EQfgDKJYrwrISDQztS8bUTuD+GslOFmiJprsGBGjdkqmiH6cUqjclc5sDkx/?=
 =?us-ascii?Q?bZo0MM7rR+drz2le6rbrdFHXAXZvZk+0aZBrAoNIlJhqYh1iamhyeMtuYnzP?=
 =?us-ascii?Q?n40zusFDUqoMtQ/7Y6645KoN65r+0jWoZCA/NHJM4ht+5N8okEzu997H6Wg0?=
 =?us-ascii?Q?UOWpDApXv54ea1ZvDBW1ipOh6teYQbNPiQj9PsCJt1mZ64mVW3cbIbBqWNZJ?=
 =?us-ascii?Q?r/cDrG08kswBWO5ebHaFlFqeWQ7fbkhnM9v0sLBYigeorUIBz5QJeCw0PLfa?=
 =?us-ascii?Q?jO2pjSaiKMq+Pq/4BKve+XkwhTkg5oBJPhrRIvt2V7PR+8dLQ6idEdxHfsIQ?=
 =?us-ascii?Q?k+6JSZ+810ExjXf6a1h+T3wscVt7x8cP7Hip4NKrLO+yAf/pe2md5F7wekfg?=
 =?us-ascii?Q?LC6GW3ww2tR5I0vIOuISTp4TjXGMDl0RshiJqinArLOrBaep7fr2fnAE/+kA?=
 =?us-ascii?Q?omrXDyH+TVKRdpzYqVIbHH6bVXaRPijqdpLfnKTOGayWa+W0xdR7hcSUw/PB?=
 =?us-ascii?Q?6wjOHdH/+cfp1GxyN8RV37xxjD2qs+6YJFJq8YP0vZXBBgIDF0wWwsj6HLnI?=
 =?us-ascii?Q?oIH2OqdQhX0kdTrkPP2y89d8QBJsu0WPm18kjmvi7mqK1GJTT3fow+cbADrO?=
 =?us-ascii?Q?Og4TUV245J4f3aWNYVnIG6wVzZwGY/YqPupMgTIwFyxea8tuS2In?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc938a6-0001-4643-1408-08de5699290e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:55.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIpZeppzgK7dd3E1OeIdlmJLbmcc1/1AiBbA/pLXBUtUOJ35SKVRsEXiiI3MWVZNbLt5KGq21cy4sedbWd9hMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Remote eDMA users may want to prepare descriptors on the remote side while
the local side only needs completion notifications (no cookie-based
accounting).

Provide a lightweight per-channel notification callback infrastructure.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 31 ++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
 include/linux/dma/edma.h           | 23 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 696b9f3ea378..0eb8fc1dcc34 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -611,6 +611,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
+	if (chan->notify_only) {
+		if (chan->notify_cb)
+			chan->notify_cb(&chan->vc.chan, chan->notify_cb_param);
+		/* no cookie on this side, just return */
+		return;
+	}
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
@@ -815,6 +822,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+		chan->notify_cb = NULL;
+		chan->notify_cb_param = NULL;
+		chan->notify_only = false;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
@@ -1178,6 +1188,27 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
 
+int dw_edma_chan_register_notify(struct dma_chan *dchan,
+				 void (*cb)(struct dma_chan *chan, void *user),
+				 void *user)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !dchan->device)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chan->notify_cb = cb;
+	chan->notify_cb_param = user;
+	chan->notify_only = !!cb;
+
+	return dw_edma_chan_irq_config(dchan, DW_EDMA_CH_IRQ_LOCAL);
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 11fe4532f0bf..f652d2e38843 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -84,6 +84,10 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	void (*notify_cb)(struct dma_chan *chan, void *user);
+	void *notify_cb_param;
+	bool notify_only;
+
 	struct delayed_work		poll_work;
 	spinlock_t			poll_lock;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 6f50165ac084..3c538246de07 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -138,6 +138,21 @@ int dw_edma_chan_irq_config(struct dma_chan *chan,
  * @chan: DMA channel obtained from dma_request_channel()
  */
 bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
+
+/**
+ * dw_edma_chan_register_notify - register local completion callback for a
+ *                                notification-only channel
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @cb:   callback invoked in hardirq context when LIE interrupt is raised
+ * @user: opaque pointer passed back to @cb
+ *
+ * Intended for channels where descriptors are prepared on the remote side and
+ * the local side only wants completion notifications. This forces LOCAL mode
+ * so that the local side receives LIE interrupts.
+ */
+int dw_edma_chan_register_notify(struct dma_chan *chan,
+				 void (*cb)(struct dma_chan *chan, void *user),
+				 void *user);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -159,6 +174,14 @@ static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
 {
 	return false;
 }
+
+static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
+					       void (*cb)(struct dma_chan *chan,
+							  void *user),
+					       void *user)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DW_EDMA */
 
 struct pci_epc;
-- 
2.51.0


