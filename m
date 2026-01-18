Return-Path: <linux-kselftest+bounces-49302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F23D396AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9123027D92
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340C359F98;
	Sun, 18 Jan 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jYlG2kU8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B13587AE;
	Sun, 18 Jan 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744564; cv=fail; b=IAAMD40L8cpp9WY3dLsHW7kIH1YMjPwYl6MtEUKxTvGqr8gQ7E/M8ZGVeMs3MhHpNVzDrRn/Ji5dO2MrrhZi5a99auO6cG69vzoHcPjzlPUBGtYoeDjpjqtQVvBLuo+nefSoCRAiYNvv3fob0d3/tR70FCtL35EdJ0DgSIG+XuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744564; c=relaxed/simple;
	bh=OFUkD4E+4Ukvxd4hwqTv1/sNXaCaoiCDWemyU+y7EwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HO4LnJFKPbMAC/KYcR/hNqW0qDx4NvmQdTpgLxelrzc/mdBup59SoqzWyWFnHNxdzLoaxyHGaQpiKBZmDe/lxCGpnd6G+R+lT+nwGByBqS0Hq9YgnwKvz/m1EscNGBZnoAlVajPZZWRScnkA6EBR7lmynCK3EL1QZQao73QOKYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jYlG2kU8; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Fza3Jgk3Zbjn6eMQpYzSSg9AkJS4KDLcPqJxLujCCyMWY/vpVemGOLexVe4N53Zvo5YSKna1OtAnUtlBSR4OW1+jfvBdDjCydIMynYZ8fC8vQzqYD8TtKGW7DZIYF9qvofZMoOJdFJmD4FusNJN8///RrKSjNIuQBGU9eB+O4mZXwxHpTzCEsB5UOjZFILy3jOTveGjcpY+UPsIDTD54arEI9OL+W7FpcM7T1UDGQnVhNXYVKTU0Sh1LJMMXdtmWiyMOUi1JfSZZCOHBf7cxY6vE3Dc2jpdElVt5THgQI0yXMHJ2W/3AW0BqCsK/DSlw2aPaNSh6wVP0xJb4irfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IV6mAImmdaQxF+HLb3oX6pkRkUuKqxuOTBnEtlk+FM=;
 b=ypQq0OSwKPd3ZB681Ag41xx55tApYREH5F3DbFVLJhout5zgJgL8hd9yEmmKEL60LrPzP0Wn1+AX07oZa0qCWi1LS31megbf3BgExb4rOhGq7Brh5gIkFGCkPrW2m0aqzGaNm86Mv+walZsAPpEAG9iDMvzhq+EWq7EwEBG769J6FNa1ih0Ph6KD01u04LUWmzT4JYCK3U9t9uDiRkmjiSFsK4sMJOnrVhCdcVS4mRNljv4mgBomRs8h11sG8zs9pC7JeQ9pTc40tL0OSRYl2aiCQ2QpLo32REA9CzM3xVXwxqUCKmarRCwTPPmErElQY+QsuSVwCzzOktVFVZomsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IV6mAImmdaQxF+HLb3oX6pkRkUuKqxuOTBnEtlk+FM=;
 b=jYlG2kU8SOpbhqlyI4wHu1V+ZTthZnLlqWehhP5yOhvWnJKu+aW7u8sIzs19ZHIrN/xUHkKq6nt5DH18iSjHAV1SfhG34SbaSPG4JavDvPxPXaoR29LcLuGTiWbXSJbx1QSadTtOmFkmskMX4hdhV8GuCoH5anDQK/RCXiscssY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:48 +0000
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
Subject: [RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage
Date: Sun, 18 Jan 2026 22:54:40 +0900
Message-ID: <20260118135440.1958279-39-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 093b9545-ef78-4b46-5f05-08de569939b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKHl/G6XrMVx8HQdRGmdRtj1cafNBKh6lGgli5JGvBJLomO9WhGHQE7Dw7GZ?=
 =?us-ascii?Q?2Sss5Dge94QrXweqHb0aDuOPNBgmwkhq8r048vWev3rIHzXzHwqqh8RQwvJ/?=
 =?us-ascii?Q?l2RfIsWpBEHPMsPjkcZ76oXcje/JWXMZSxeMymMspbZypZi+WQG7BTzhjSjl?=
 =?us-ascii?Q?xqJq4Fop2JfCqT4S00BLohlyZJFfThuK0YOIsOyRCZmiptQYasaRI6IsSk06?=
 =?us-ascii?Q?bbQs3etXp7E4TqfCvErTKJSgyB0hd6bE+A39NqMlZRzq4S63dnQtR6KUUWxg?=
 =?us-ascii?Q?zl4BG9HT+A9mqUxCtklcuUAbXWXDiixzzcTreHYxLaccatpilre7DOfenB8N?=
 =?us-ascii?Q?y1U/HliJw6i9YkWk5hjmhXBBIAy6CoqNXmzRL1mtDqI3snRQapBr4nTYtNpX?=
 =?us-ascii?Q?r3mx4atBzL1Vlqzf12JqMJux6OvUnwdYO8Fi8xvJDHFMLK5eqEtXVzq70XZd?=
 =?us-ascii?Q?Ki9yWYJXFLw28m/bmW29qAQAjzxyq3ib01Ja0eNW4AqUY7rFU5r82uzqkxP3?=
 =?us-ascii?Q?9OEckoIGrkYi5OBx0U5JJuyR1hYtZT1UpZ5Ftd2+UD7u5j/R1JEUqZvUoHxl?=
 =?us-ascii?Q?OWkdwj1UJfV349GXj5JQQKc+t9e/PSSknCW0a6ppSOQWe/kDigQO+GK0qa6k?=
 =?us-ascii?Q?cyNtNOBoulAqJv96cgJScanXHAjkxvjXQyP9A/8x5IZcXmtmXzUTk6aW9vGh?=
 =?us-ascii?Q?eJtnvjhlGAZ/9U1ZyYceLP+S48EPMIyU9kwUQUjAgUjKsSU6i1MYx1aTr/Wd?=
 =?us-ascii?Q?RHPdaU1CFhTp5dnyvOI3CbG53y0SDQMtt2u9DlxYg7UokZcM+tq1EZtOQiCA?=
 =?us-ascii?Q?ZApZB4hT/Gfi1TjaNl+pgGefFvCZfuzmndYW5Spfw96ck77muDgVI1BgM1id?=
 =?us-ascii?Q?9qiCho9oIUbPzEg+0kOqqR0mYaTM4UF6mkWXkgYkOFSWV4QZVy6PRJwQ+MWj?=
 =?us-ascii?Q?pfNJN9JW6UNjk1lwGW+28K6e1gzqOh2DC35uI8IJ3QCy8rHLZ8i6MsUIzvwt?=
 =?us-ascii?Q?FxiH6iIs61eCU6dKgf4DJbWPx/PyU1s2PKSIrbwNV9IIwBOfwtvhpGNF/dv9?=
 =?us-ascii?Q?mIUECwTXhaaBZxg50u2WiGRFTfOjGbHEdI2WL6KFCGktOBQ5NGh3qS+J7W6Q?=
 =?us-ascii?Q?CezrJjKu8n/LCGMEp/WLQB2rlmW2X1zBAA5XjShKHJpVx0bAejjZRXslDRhI?=
 =?us-ascii?Q?Cl6lcXAUI1gx96tVRPDNTTKSlpTL0jzCxiV1OheqMM/nP9dpTDokLmQxD507?=
 =?us-ascii?Q?tF3GNcD1f17PWVvyFixdNIbhElIlIBcZ4wYooYMElbc0jlQ9O41kqqyPOV8E?=
 =?us-ascii?Q?Q2+qMQOB71L6UAkHmbx5S5iWMk9AxqBw7gkix+5ltyToHxZ4n8nABjk9GiS3?=
 =?us-ascii?Q?JVlmCaZKfYqj6WQ0SRJAIl2x5lu15jioTKgGQeTr5GLhVOJkBP1PBzARHbnt?=
 =?us-ascii?Q?5k/jJ/Sr+yZ0fmdYPIpWbM/FrXE9kxmbqRir+Pks10cEcW+szSg3vqwoiO7M?=
 =?us-ascii?Q?6dKu8Z42pF3cdujS2hRUSA+LxQjmW8zEgusdKYcZh9YnTTSEhaEocM3rSNkl?=
 =?us-ascii?Q?ZWehaNw+/O1+ie7yDQpzZrnYEB723ZHGs++tptXVgTU0J/wiYQVfxpFmkwSO?=
 =?us-ascii?Q?NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUx5OEvjRGYKYdRUS+EAxmZCYwG9WmODx/NcW55oy5U9SnCrA0AMkSE4o2Di?=
 =?us-ascii?Q?9ZNqe2S8t7S3jC2GbYvtHJaBYSlHxaxGIhS22ASEGjL9SyBcl4QQuNDRy5Bo?=
 =?us-ascii?Q?9a66BKu7vx8Lc2XfZ2+MuKsxw9F1MLB6mcUKxhJ/9QaczN2COa30JoJWEsb/?=
 =?us-ascii?Q?Cdn9Jv9XbxVL8YyxbG9uPMrwfflbBHgLx9HR6nSLDZZB3+ky3WC3KlWorO5k?=
 =?us-ascii?Q?/80RLdlfj1OJsV0MSymIeBNTY/0/Ewa3ccxi4PJ5xJUjWMvMDn45EKZTmS0i?=
 =?us-ascii?Q?A4p1GTg0DZEUF9RtI5AYRDoga+gv98VVV15lU+VI0OukBdB80xYV2bqzZuaz?=
 =?us-ascii?Q?CB8Spo/D97cfQtplnDS1V8PoGomLDhwrS6mxKXOF6UI29tjMZcEKEehGgPby?=
 =?us-ascii?Q?5FQQ3+w5S4/6qOj2RqQ0qW44IKMOCJo9K/ce5t4WgasKS0mYD2LoUAK5IrhC?=
 =?us-ascii?Q?O6Nuh/gJ3/lIV15yIup65yQM50QfKD4jLLAcmkhOQeXEG235rlcYg8pVzEU9?=
 =?us-ascii?Q?wBEe4EMdlK73KkW2dYwSeuK3XvWDDaeKa9qP9lRqNlioMT7j9ddyxq5RGkmV?=
 =?us-ascii?Q?BvstqzgJMaMgisqqSsFDXwttMMXJKtEo72iUwMSyTr9EINA3NfgmKE9hzPXr?=
 =?us-ascii?Q?Y6kchCiSb1AzZ2w0a5Aosl0p2FE8LLv6TrTUm/IzEg+AmkV1++ohJYubkM1Q?=
 =?us-ascii?Q?T46NdF2y0yTkbgI/hOYXXmmCs2bxExu2RO17e5IFzDSZbp4jMRbypjWsJyXh?=
 =?us-ascii?Q?lxPhZglKmJSBCOuVllQGkYR4EUl0oiNk+vcF9qhUXSs3ff+0IohFQ37eyOxI?=
 =?us-ascii?Q?S8oPh8RPzzoG5F0/DJ2B4cFxYb4J4Jq64/I4OWShk+Kp26LtxFnO72q8fnb6?=
 =?us-ascii?Q?1HYJ3LTr69UHoQqaZIK7MT7x5gzQWqOQCoSTEeIxIpoX+hpvDnOsfL40Vx9+?=
 =?us-ascii?Q?1uI8+GMJtoPwDEhmMyusZjN0SErssNIcwPiplIUWEcR7vtpttUs065ue3kQr?=
 =?us-ascii?Q?fV4sCpoYV0XpUbe9du5S0NDpb/U/WXIgkq6iklr/3sg787WvpqH6apYqYxm3?=
 =?us-ascii?Q?n/Q3EekPpE8ZKAEN+48Hj++4uBG5PbHaaDIqMdHptzsgVXc1iX4yXNNcLFmx?=
 =?us-ascii?Q?shrTNlaCnSJADAhqSwYVM5C6QRy+euxyMgVVqe3ToX2JWB9eBL+omd0/z+I/?=
 =?us-ascii?Q?HWeWCUpSFCLWrgByqVLLwg/GKTH0/MrLihdBj46K+zbNr6APGnRv/Lpq/j2v?=
 =?us-ascii?Q?023qHZUgoQIvJwUaeF59LzKQttnIK5Ukn9E3yJasmKWc32+02ROyX2MuZwlh?=
 =?us-ascii?Q?/gMmCUf45nb4gl/RciG8HKL8w6HPfaPDaP/awFHZVPVcEyazqBAESImeno2m?=
 =?us-ascii?Q?GBLZxkmMPsVIq90Nb6rhRYhfbJhcMgcXQ55seqFYyQy0U+E9/kP3sH+UeVPo?=
 =?us-ascii?Q?SL/yjH/nehf4BEv6nyAKnZPcoFtFkeF8vduA1Ddcm+aY0H8BZlwIW9VPkMpa?=
 =?us-ascii?Q?jD/aYQgv6v/KNb4u30WSi0V1cqUFDasS56R1gG9JJFUbxVUB+s8ylskhac3s?=
 =?us-ascii?Q?tk3ZxbcyQYtsKai9NL0BL/eJErXrGb+gzwbgjUivR7k9rJRw7B+xg6AU3IgD?=
 =?us-ascii?Q?s53nv7xhH+4O3PFQUzTBXqIGs3EZ3uJX7/IDUCZqebnekJS/m4HUZRmaADK8?=
 =?us-ascii?Q?g7A1GPBZDe2usrHVdIvtz0vZmqct8beDPMH3j1jnjaCAODgN+kHeHy6IUhTg?=
 =?us-ascii?Q?GtGO5J5KH3384ErFm3ZkIpezuRQkxNQaZ52u5iwEOgpFOUX3SqYq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b9545-ef78-4b46-5f05-08de569939b2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:23.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPzcYAk0saVCN5s+E9WpisbOpmIzm0iV+mVuk40e2a2ieo127oPFM7lIygEVb5S3qidv4ZS0CAtfN3EJeBZsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Extend the pci_endpoint_test kselftest with a 'remote_edma' variant for
READ/WRITE tests. The variant sets PCITEST_FLAGS_USE_REMOTE_EDMA and
skips the test when the feature is not supported.

Also treat -EOPNOTSUPP from BAR tests as "BAR is reserved" and skip,
since the host driver may reserve a BAR for remote-eDMA metadata.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../selftests/pci_endpoint/pci_endpoint_test.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index 23aac6f97061..39593da3b40d 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -67,6 +67,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
 	pci_ep_ioctl(PCITEST_BAR, variant->barno);
 	if (ret == -ENODATA)
 		SKIP(return, "BAR is disabled");
+	if (ret == -EOPNOTSUPP)
+		SKIP(return, "BAR is reserved");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
@@ -165,16 +167,25 @@ FIXTURE_TEARDOWN(pci_ep_data_transfer)
 FIXTURE_VARIANT(pci_ep_data_transfer)
 {
 	bool use_dma;
+	bool use_remote_edma;
 };
 
 FIXTURE_VARIANT_ADD(pci_ep_data_transfer, memcpy)
 {
 	.use_dma = false,
+	.use_remote_edma = false,
 };
 
 FIXTURE_VARIANT_ADD(pci_ep_data_transfer, dma)
 {
 	.use_dma = true,
+	.use_remote_edma = false,
+};
+
+FIXTURE_VARIANT_ADD(pci_ep_data_transfer, remote_edma)
+{
+	.use_dma = false,
+	.use_remote_edma = true,
 };
 
 TEST_F(pci_ep_data_transfer, READ_TEST)
@@ -184,6 +195,8 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
+	if (variant->use_remote_edma)
+		param.flags = PCITEST_FLAGS_USE_REMOTE_EDMA;
 
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
@@ -203,6 +216,8 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
+	if (variant->use_remote_edma)
+		param.flags = PCITEST_FLAGS_USE_REMOTE_EDMA;
 
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
@@ -222,6 +237,8 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
+	if (variant->use_remote_edma)
+		SKIP(return, "Remote eDMA is not supported");
 
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
-- 
2.51.0


