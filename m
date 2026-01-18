Return-Path: <linux-kselftest+bounces-49268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC19D395B8
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 889D23015151
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B93346BC;
	Sun, 18 Jan 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tVv5t8Wi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74897332EBF;
	Sun, 18 Jan 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744510; cv=fail; b=KxIs0S9/wGRIU7mcmmmSyVuM59RerJ2byjss4ASRJqmt7Usd2tnODF+GVd49zbIb/ET4W7uujrd5XDbL0XC2zq9uLGxE3cKdB12IElqZwk0eIESHCzCMw5Fv4S9cXA5PynlWGDpru3322PVVtbB/BHOFs6X20ONoZo2QfwXsXRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744510; c=relaxed/simple;
	bh=a/zi6Ds54ieb3j0JNTggmcjp9C9wkNv8orPWEwfLHWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrEcAbIrQTDfJcVOGav9YSDp6JECHqc2PDYbQEQBj02jfvzRL9bORL/kUaFgWYoS2VApA3IOfg1M4W8wHfk39/C1RiF/b/CFzM1s/lhsi9Jd9zlY3s7M9Qx67fyY12zSgU5zMsb2uM9NHFcdCsmx2t2c2m1D5XSB+JYcXxpxqRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tVv5t8Wi; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzWk2R5u1mNwivIK8xSTColqiRY1RIYxNdgvc0/b9zCgPVh7033r2gBEshcqAs+7BSsZ2yZx/H7geHP6u/y5W7qUSmABYEluA3Qxe3scFQm4sJwY2N7lKwuasaasvy59VHR0k8tOcoY8ESTbP1vyEm+PQSeoECevUcWbzd+E7X+TP4a8HDQvU5QA6nse1cxdZnZnIFVSUOLWtaIKj0W6lvOmnjA4RvwAWh9Bj5zvsJigmLx0KlopNQJesPWPFqomC70obTDlyAdg+FS0Tlnvp8d4340qW+fZHcBzMrtCiJXiLI9RZ3LC9zOrFg39ZWUyrRzOOrKj+v2yu7aJGIrsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfhKDkTfysYYu20t6VYlSQ8jrEaA9ak7jaf4vV+c3c0=;
 b=Qz3xKn0xxmLfEuqiiGo4Nav2r1pER2D9btKSdp2R1FDSqTwd8iLW2ySsQ+xjt5Zbk89In0amBYwuE2yFu4W21khSapINp9e/WD3kxhiTQZOvbH76txsGUqWg+Arny/yBJKAvcXE3Xo/x5mxoCr0y2ZdII2i5PlGu6XF7ZJi8cPvavnTUdcB4jD/n7R4KD2w5BywI2VPH6mqliA2YNthUJ0/4zco5XuRsWJOBmDtFJT3Bm8Yokj01Q1Jz2F6qJ/dt00PDoO3O580frFbQAdRLFs5vKDh1ScjYhN6pqH7tAVI+rPFZh8VxV1LCm4KzsJ2Qw7Dj1FJOsI34eU5PI5kl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfhKDkTfysYYu20t6VYlSQ8jrEaA9ak7jaf4vV+c3c0=;
 b=tVv5t8Wi2thjmnVf9l59bju2pIaZ+1rH9oxyGYnLTpmX1K06wO5wWFsw1E7IKOXRMBYs5VDW7uXBQ+3BSaJoKtw9Z2kF1yDZzmqWE6UfKKzORRRsp5oL9j5BORcN/0kx4qN7RinhAi/ebidKaEq4w1mSUUEj8zmBNNF0oiQPrxU=
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
Subject: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query linked-list region
Date: Sun, 18 Jan 2026 22:54:07 +0900
Message-ID: <20260118135440.1958279-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: bb188734-c6e6-4330-4679-08de5699297a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8U8kGkJUuEB1g6skrrkprLW4MHG61xbVOgqoY1YQLqunH0O5WohINKsTQHY?=
 =?us-ascii?Q?Ghve2vY3ZTJQwWBMVoPAPj4PBVLnTDf357MSPGu1MKH9uAhVsUOarfNvne2D?=
 =?us-ascii?Q?90w32HMkir87YiDp4sJKmz3CuNnKWDkYz6E0tvGzWcRnel6U8DeSS300mlgk?=
 =?us-ascii?Q?VF86tLgRPoOBQ5UcqX6OVQ0j+H1ESZ7fGXQVPhBFwLUORSimHYEgumeCMLI/?=
 =?us-ascii?Q?QNnBe8YXgl4VAmeYRiCVZ6GcWeN0gAngFv3NoOu1FkFcp9RounAR9kZNeAlH?=
 =?us-ascii?Q?A/09KtoWEZLA+4c9FKf2n2SzYaHiKYZ4klxAenkgx4sQ7l7l55PetOLA9uxn?=
 =?us-ascii?Q?3OlVllB8y8EfOuc6z7w02Eb8vTssLL03QThCvpWG2wVk6lFp9Yg2fS6PxQjy?=
 =?us-ascii?Q?NH/owhgDY+HMn6m6ZolMuLEesttTM/6upPSu+R8DBSZi6jQYJBLJf8tfl6CX?=
 =?us-ascii?Q?dOFQLXtxNN0EKJgcZAXCV2b2lWQ51mYOc3cvMl71fRnPkMXWLTMZgK5ufX5W?=
 =?us-ascii?Q?olxbk9OwAd7ueAkrGmbmvmdqdRhbHTeGyNuT/jZqTtTYFPFNY6dcV62pnORR?=
 =?us-ascii?Q?1wOEDSQnIrBmmpfwiCjMzIKpY7eVxW391bILhZkLjh4E2152o0c/KX6q1/Qg?=
 =?us-ascii?Q?p22sK4ctN0F817hXP/jWm4ujTu8ulhuYOenq+F8KKgl7QCfktT5mlybViqCf?=
 =?us-ascii?Q?BUgokVW8nUQIdp67zLX4LMxds6CP/M1xSIta2xul+uVfeStrDsZc7qa/xRMM?=
 =?us-ascii?Q?rsNxwS0cAoio9bcw14KcLfwZvu40fJB4qQ5HmZhC/YAcGXqSsYZzHR9DZBEL?=
 =?us-ascii?Q?5yje4tu4LdB45hx06+YGFsw7eFUn4c9dRzdZJDLf6AFTw171BeZJTS47LReR?=
 =?us-ascii?Q?HlXaTnlbQKWaIo1Ut0v5Ad1AYMRF139bTWUFkE7mUauaZnZIHBhzjo8sFqnZ?=
 =?us-ascii?Q?LTfdzG9BO2ftwGw+7+erijjhTU7Mda2P15RDFHbgg6ROWWQ3kNvvJxO8Obb7?=
 =?us-ascii?Q?sQAB1uRsrOoBFmhq+R9Wjhv4MgnrRGo/xM77chkLoyAVgxD4zUt9Mo7hY56t?=
 =?us-ascii?Q?xvh8GbegSQB5SI5MvrLlr7XdgZtm+pHDih+HpYEOslVS9y463pYUuyXkgJAx?=
 =?us-ascii?Q?VCSHJJNeDCMejzWXSw3Y4Zdx0Rwx2dBXTy6M0wSU5ZmZ/BHHp7JoVkm07epF?=
 =?us-ascii?Q?313LBsk16Dr5SW2S28drR1/Zpheyzyl08742tmwTcvQaDzcpgXg5kLR8+CIV?=
 =?us-ascii?Q?hcbSMaB5lbmUkf98u0NfcPrIyugTZdKWeJmseBya4aJTriu6g6v+8AsZcCle?=
 =?us-ascii?Q?MNj7y1K+vy9I6iHkmaMUGAnunpMzuoFH+6LZjpYkLd1hWB475YerYZsJq1Qv?=
 =?us-ascii?Q?JXxVD6zl0JXswmDqSNx3p3MwuzrSx/pPveat+5RK6P7to+dfGlrYvAhFJy/l?=
 =?us-ascii?Q?O2ZP4pjRKxfVAb/6ObNoDpMA3mcF3rAZCC4BKVpfjiRiQVtGL9+4kNpf5D9r?=
 =?us-ascii?Q?WKe3uDS3A2zAi82f2kaGB4DVuW06LIGxDnkxdHF1yM388AtX6+KPsPk4ep9F?=
 =?us-ascii?Q?VaXf4V0KRsbT3+iVnOXrJ8SeOM3W/60l5GBB8McSc/eMulzzcvDM5GD4qGtP?=
 =?us-ascii?Q?Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tK4Ms913m7AQTDVEjVkeM+/E0V0jY3Xkk3u8HMgGbmrMRvkevzJtgkof46oa?=
 =?us-ascii?Q?4Pddb9j0cPRNZLYXLXfsqrUZn0VEfsjxmtFjU9cvcGw3KL7wxA4GpUSEArrr?=
 =?us-ascii?Q?Sy/JqM+rrRavhrfTpqtyrI8pX81aniCXBkH54VcgVfENx7ilvEbaEESjo2qc?=
 =?us-ascii?Q?pbuJ5ZKnfDNoY084VxXejGPtxgjPYWPgZ9Cuq8ccDuAj20BwXMjHMR8IJ2g1?=
 =?us-ascii?Q?ZNmD39dS/kYCguPMk/LilTvaHnJEcGZP6MGoNNTK2CW8iD6/mt7bBvT+tUwr?=
 =?us-ascii?Q?l1vA9TvjX4OShTXW51+7Lh2a9luHpAu16cC+Uu5V0L3pa4/OR8Zj+FQj2IMQ?=
 =?us-ascii?Q?qHcVTDgw9px2pv/JQ/1KomYAin7K+uXchi4iDrEpEg3I6YzaWMKnNI1lKOBh?=
 =?us-ascii?Q?3gf6LQal7FR0NrYXVo3qu9IXtGEiAg5QuyxIqsmmNwbhqmZyevLVzwrBkgWy?=
 =?us-ascii?Q?PcAVPHmRvsczmIfeIIL/tJmHS9t9ihZfltoKsiKmkqiJ3buOgN9wxElrQKRD?=
 =?us-ascii?Q?UuM9FoxsqwI3YFZWFoze1gbQmY3P5Viq6vSUR4KqOiX889OXZEOxQoajuB6u?=
 =?us-ascii?Q?Fs/E86r9+2VKiy+jdzoKZaHOZ5vfbi60kuW+ZMV8sE9a7xaoVrC/y1qkUGiD?=
 =?us-ascii?Q?sp4ohMQpbK/eClD6bHS7AN9+z8xWl0bNgn74mcOY8B68GGqGxyL9cwlhG/o9?=
 =?us-ascii?Q?WmJf0Qqu3FdJ3PLEZXkCOeWjSCnPzozDhrEk+p2i9fm2YZcp87wDGMsSTlGl?=
 =?us-ascii?Q?sf9tF5gfl+lSA0YFy5OecE4+pP5zLvgVTwxpX+23gT9O6xa67uLwPHZWacj5?=
 =?us-ascii?Q?fCRX3mhnwuK4wQQfDU0tP83yj0vUBqNktrtqjBFkAjDNWBlWMytcJCvurd1H?=
 =?us-ascii?Q?WTi4GxeDl51toHvtCZSRY1hLqdHXt36r+AfCvIwqZoe68Hqp2O9EbZPUesM0?=
 =?us-ascii?Q?YGNWLxKcJMn88PH0yszOpq+nbgFJpSXzjYkY3PUNEm0QW8KADEf8hz0R6ued?=
 =?us-ascii?Q?9a1k0k5yuC1HErImXsQQ1gxgpwgMImDNQ6lGLdhLgTKQzvXlnDpSH5LemYtn?=
 =?us-ascii?Q?jQb7rxZ38QnYoUFFoasIESOdTYTSjIeA+Nk9RDOmaQfD7HUSZKbeyxi0u1S+?=
 =?us-ascii?Q?GRIgi3tRHUY0prsoX4Lk+OBYb8MT7bWykHuZv7QXuWek6UJly2UZTk7BXar7?=
 =?us-ascii?Q?nbP1fUvdDf+6/MVNArVei/GaKWlg7ojaa5jIqsVQ2N67MC5VEnogmZdnsqp1?=
 =?us-ascii?Q?yu40arqJbLTq/SlprSlHJoesJ0bWRTzwjpDKfidCsLQtrnVJ5oSzKesmbxFM?=
 =?us-ascii?Q?5iQnCqz8fIaykBThka61fAHH657oVu0F9vYHlYglCoqFxN9SdO+PUR3eIRf1?=
 =?us-ascii?Q?mL9iOSHIFluYeEO85vpRsOWSdKq3WiHkStVsIRGwj3oA2+s91BmthK6unEXW?=
 =?us-ascii?Q?ouZJajRfs22f6+lqS0ba7ymsxZ9yKls/r6UvGWgNN4+x82iE6Aqw4Xve4IVs?=
 =?us-ascii?Q?kxmM1OH0yhbnq/f8fxhHaQpD9DAyEpCZN5NzFazZM7g+YvhOc9gla6ycbPUx?=
 =?us-ascii?Q?YN/2DDlJdH/z33H3E6wK5l8G6sXGBx+kqzp2IKCQYRRnqXHq0BjyHCNAIkp2?=
 =?us-ascii?Q?qw0DU1AJLGQT3CHUPBNDwmp6hdquveia2PHrVsK980IooBvyxXFJS1FKqO3Z?=
 =?us-ascii?Q?FRaqfc6bpom8zIBJ8ISKtzPk0jtu83lOApV2UpCbz01Q/q4twRmLfhVlZJbc?=
 =?us-ascii?Q?NPO0c11D+l6p/akUBBa9xm0ewKEbprA3eFti7z/Jpn3riEHtXwZN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bb188734-c6e6-4330-4679-08de5699297a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:55.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzVvBGkcXSURXKFZhh+eCLMvWDEPsDxyI+kByuYgFv5554E/rKF0XGTKjE8Ql7gh9CG+3aBDNGYKmoLr8Glt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

A remote eDMA provider may need to expose the linked-list (LL) memory
region that was configured by platform glue (typically at boot), so the
peer (host) can map it and operate the remote view of the controller.

Export dw_edma_chan_get_ll_region() to return the LL region associated
with a given dma_chan.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 ++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0eb8fc1dcc34..c4fb66a9b5f5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
 
+int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
+			       struct dw_edma_region *region)
+{
+	struct dw_edma_chip *chip;
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !region || !dchan->device)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chip = chan->dw->chip;
+	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
+		return -EINVAL;
+
+	if (chan->dir == EDMA_DIR_WRITE)
+		*region = chip->ll_region_wr[chan->id];
+	else
+		*region = chip->ll_region_rd[chan->id];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3c538246de07..c9ec426e27ec 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
 int dw_edma_chan_register_notify(struct dma_chan *chan,
 				 void (*cb)(struct dma_chan *chan, void *user),
 				 void *user);
+
+/**
+ * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
+ * @chan: the target DMA channel
+ * @region: output parameter returning the corresponding LL region
+ */
+int dw_edma_chan_get_ll_region(struct dma_chan *chan,
+			       struct dw_edma_region *region);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
 {
 	return -ENODEV;
 }
+
+static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
+					     struct dw_edma_region *region)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_DW_EDMA */
 
 struct pci_epc;
-- 
2.51.0


