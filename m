Return-Path: <linux-kselftest+bounces-49288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E833BD3966A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 947403044C1A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CF34251B;
	Sun, 18 Jan 2026 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vY/A+yd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC933B96B;
	Sun, 18 Jan 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744540; cv=fail; b=h5yrP56xZD0zB2+77pc4kUh701/SseGtaK1QmmBeNQ1K1EYcd+qLYzggtRIZ58+aR9RnP+ZcWOSjhKBugeFsxUCeeDBcRpOzwTa7CnP8ZRQY2jvqeVeR1NHDZ5yaNZYTwWBfMpgLO1Y6JrLNIzNRz7DJPJNKRH6IXmbMUfCzZNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744540; c=relaxed/simple;
	bh=AUZc9Sd0+8wnsa7emkOaSfwbFeUEWLv98Qsw7SfrK9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mC8GAD5mgGksVCJs08fwDcCsgD8BtmcE4gZRLAGLx7smOqK6sDLbzOxt1JKT60eVFPbfPxZ/3xF/fr2Tett96umIcPhj62XZwc8qPqmPbQO5NOPwvMQWZEpz/OrXO5mRMbBaJpaqc9KT+NGEQVTtoB3pQ8U3iYA4ijyYerc4Q2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vY/A+yd4; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7kh0l8nKJNHoxqkS8X7QmBO2N1JtKpQeHHkz2K1mIETqA2LtYs383xsviCZH7CJ2Rsg0lZTfX9uIzZSX/eaA6iuMAZPXvn+59XPedveTOoSyMW/iYck1smiKXe6K9RoBp28eUbvLjLxmi8d3Y6mZ43wZL5b9kZFc1SAK+0KnLQRzhmiUsKwewRPO0rJGYu//u3wYlybccrZrm2rdO8x/SZhs909judhTOwTCMbocG0EMRYJ9Oaantc5BF509eVrS8crrculHDNZyA068KK20yBrBaweSoIV2ZSu6k6ChwDKbHGMWkZCbibIhn27NNWYwdoOxyxPxaBSDUDdUyihMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi9kidn5SjYMzrrAWVSGO/PH7HtQ/UHb0liWW53Af3U=;
 b=tp+MDfuGWHIFQPaGPr7NW9mmnmaIi0VUi/9OSlIu8Fou4xgVht5HvKuLYyBCI3NOgZD6lhu1la5CzMyp3Hayyg3McLCgiJcmub2HDHlQzYJIn7I6XeTNGDh5feudUZAaFqKaGVGkngzYvsf2Wc+xu4kaOYT7so13b2qewDaREX8LT4FIE7Mjv6yRbzWiTZAiJLxem+l9wz5rtsTV8R1Uq5zf3xPiS3wiNIDjfbho5tQMfrU6k2RXMt0lW7LPUU9iUELsSC5aPydoyP3NFjGcSlZ0Mj+zr1D2PBpfb/cmK4S8EfS+dX0EC4qrAekMB/WLchh9C7RRRz0H+m7JSBHTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi9kidn5SjYMzrrAWVSGO/PH7HtQ/UHb0liWW53Af3U=;
 b=vY/A+yd4thoQsQZrFjQKg8FC9CPKvFWi6svSlREJ8iaEDnokwQLu7CmZmDq0rYh+/qRWLqLBtSKMZw1TwFmEu7RKILliUtKc+ZJz+OTyTrvYR9Sx3dEsCPOyEMI2PbtEO9uOD5pQQlb8+uihPiWnFEKIQ6SqY8PL5Pl/uazcgpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:11 +0000
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
Subject: [RFC PATCH v4 23/38] NTB: ntb_transport: Add transport backend infrastructure
Date: Sun, 18 Jan 2026 22:54:25 +0900
Message-ID: <20260118135440.1958279-24-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bb0ff4-bc72-4c46-0877-08de569932b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4tUSC5ee4Vc3mDuiqH+xpMQ4audLGpBJQB0jOlJayYdGhQ1XpuXl8RHXwSy?=
 =?us-ascii?Q?uE4ct//AjHTTIQTEbZjdp+wip383uDabdd92jixTqOXgtEi8U4v9o80V9iss?=
 =?us-ascii?Q?gYel6hBacH4QGznHmhEZQgCJI/100IR7Cbs/xF99b+QJJWRozqlLj5IrmALq?=
 =?us-ascii?Q?yjGRhUTJEKjkxJGinv0yNavO1BWZS6xW0cTtWb0Cp6cuJewIL1e5UFqtrBQo?=
 =?us-ascii?Q?IRE2cHVF93zJfrW+K4bjBPiPePYrpG+grKQK16GWZy+076suo8M65aEgrZXQ?=
 =?us-ascii?Q?8SDK6RH+6DxnTktxaCLq4SQECBShFsrLK9sxZ6VrmXJtISrHjF0RP/QGZHaO?=
 =?us-ascii?Q?7VLkeb3w6AneVYSbZ+n46+kd9scIT63XST31tUh98TASOD8jRuGJ9vpfIEkX?=
 =?us-ascii?Q?/55cviMSXJI0xbOAuOgk6AlfgY1CC0SO192mVDGcE5iSPdLaphjuikrNVoI2?=
 =?us-ascii?Q?OZzZ29bUUtrsEnvRPj9aa5bFWI4cuNyxloLZsBcP4pnRdBndh4xfo3c0weno?=
 =?us-ascii?Q?CKC5uMvXBQohivlhCWPju4tC8EPhu/eYxLOo2pxAGi1jVDSySpy/K5qujZzh?=
 =?us-ascii?Q?TyJGc1r7y1Hlp7UtQLY76sCmQzHWUw5rdN5KBdHAlHvUSJbiJER8CnRyuYt3?=
 =?us-ascii?Q?rQ6GjM7R26iv7FRfEGiux+Eqwubjhpm4SX2UfMnyzTwEsYCGlwFSWaSzMgbJ?=
 =?us-ascii?Q?ARgPdSOQ+5IwBYlvfkVrmR4wxYc69pgdBTbY7ZotAVoPNI3iwBK3R3AFFDrq?=
 =?us-ascii?Q?pz5QHOsrmjUmEXCJ4w/ubOTO6pNFqyCL+eMz1Xs/ffS55C+3rvIt4vPn13v/?=
 =?us-ascii?Q?kCKZLshgP4rnwqhLbx26uvdyVzFPt9OXJSTDKgAVbMmBoD9HmCRiQY22LzOV?=
 =?us-ascii?Q?V6xd1hUvnKY+PK6eqx/u0mlovg0TZpz84l9iTSzx03a8feDA4Ei5bTi9Ue9s?=
 =?us-ascii?Q?ACkUi3AAZL4RaovpSnsZRo5oi8dlYjok2OduFWTMXavPK2h9ciTHw4TMQwBY?=
 =?us-ascii?Q?KRt0cZSyo1tMN65IjophwBH1TGfOqdD731L4p2SAHkbbhjGaTBhQnWUOAabW?=
 =?us-ascii?Q?F23slqq/6XlAov7m9C9WDixTnaTq+9T/491UUXf5C5aF3I2r6SQk1nAwQGAu?=
 =?us-ascii?Q?lLg4NvonbZb3Jq+4gKmufwzQb4FpFpqOPBeF1WnyUBbrUWUsFCiuqnnAFW3Z?=
 =?us-ascii?Q?Vz93rI1V1Oczk4RJlFCzMJSnVWGAISY6FBhicOL9wEzGklRiCetW2fUFPYRr?=
 =?us-ascii?Q?awW5aTeuQqZy8ttNlZMN5uM2oHuhVTtJ8buFCXnwCWdaSjEU9uuLW4yzT7/Q?=
 =?us-ascii?Q?EhLAchBzhKv2ndS2qeJAJSANrxQBif54w9m1RBJq/M2yKWmpLaAn4NO4CGQi?=
 =?us-ascii?Q?AyJmiuQiM4xb4HrHJ9Df+5wPuLU7bCDFyh9Uf169QADZ3JmmffgMP0F035B3?=
 =?us-ascii?Q?1T5JMXdgxH5tRTJDSUMvgQPhQxERSwmlSMHP4tOlT8TZMa5OENkBHsto0kmz?=
 =?us-ascii?Q?tKHW8kebDlAFZXYDkENbCevNTwt29vcsg1FeLeyoqadzSdU8JRwhIwuD5vtz?=
 =?us-ascii?Q?z6A4Bd3hvptq8+BlZmB9uBUQPhy+RLbDdTsgP3WTPnEFt7iB7EgjX0RU8VKH?=
 =?us-ascii?Q?aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvEqanYOqRS4t5H2GYyJYF4u0GwnbkDjqN9nzfP5cRmuDxS0tJOQ+4aQIFlh?=
 =?us-ascii?Q?MYTOkvL3WJTLkbYct9mdfkK7f8TEYfrdN6U+RQ58IU3KxzSWYXxv8mRbytwp?=
 =?us-ascii?Q?cq1zmdRB8elKwDPym4YrBEL5zp6A9lpcV+nzcWlTHw1yy6UCZaebF4Q25Ncn?=
 =?us-ascii?Q?km1PmRo2DSy3DyRDx8k6aZI2qf2g2SBHF+Gx/VaBfXkI5u0wxcf+uKJLKUAZ?=
 =?us-ascii?Q?U8BNl+25sg8RW2rHKChZP1VhDp5+YUI8AUwQHUEE7sXPJnRWyZqBAku2Ke6E?=
 =?us-ascii?Q?ztZNRLDzBmBkL28C8MAANKFrVY1f3r/6RF4JD27TFeHTXvQ5APsYFNzaWcf+?=
 =?us-ascii?Q?fGGReg2ymjk4DzVElsAPLatktWdlxZmRx/kje7VVaBzEmTrap/HYLWzHDUMa?=
 =?us-ascii?Q?qjcW4NyK6x5kHGdtj2eztmL+FFCOR7YBD++LKOBl+VZ1w1ntreEvZVIVITzh?=
 =?us-ascii?Q?E33/CPMYhBIUoTqWp9Lv2vvDNBffOEaKwqpNn5mTKsZ5TnL+XLlf1ad4weJI?=
 =?us-ascii?Q?i+ZWox0RR/XCVEpIW1sOR/IQHOcIg7+xl4o/K6ffPUs6zTHMI8K12P3LQx0Z?=
 =?us-ascii?Q?kagfkDDWtxLHYRaKcakakYZC4umzRCc6ax2WlZflLZKXwm1+uGYs2MG431+0?=
 =?us-ascii?Q?g0z800h228waQxQ0SC/SfTdyl2dtJLg4ILG0Jpp/fE3XzhznowKHrwbnz/BB?=
 =?us-ascii?Q?AmNDGreufI2FKx41dS7QZ+IGhljAgmOJ6lclxsHTJ2lr38Ce3E95cm3J3PwA?=
 =?us-ascii?Q?Or8UbkV9YmhIv22LlBHotAUrkauAkt8qQe5lP5zVkEKRVMhzf7EdZhHlFNda?=
 =?us-ascii?Q?RH8EnJECa21Nf2rQSJ3cKSmsH/DqDzT2J8Vu5eGeg+mqk53LCcIa7t7KHqXV?=
 =?us-ascii?Q?CQf/nhvAYElf7L1mDvJDs1EyZInb6xPOmBKzx4JcEps6G/8twPs9XWZesn8Z?=
 =?us-ascii?Q?ON6lJ3IPddMeDqTSYVdAd5lSULIWzfX3ZE1ZmOt4PwJL+rd21ei6ZmrnZiin?=
 =?us-ascii?Q?OTnSgicERorlGRvxTuWtpc/zbkhfKMIC8QcZvOUX54/x2mJyrWiaVfpDp7nN?=
 =?us-ascii?Q?QvNeCjNOm6hVKE6EyW1QgrlKA33Pj4jW5GADsvuoHhCVRRzy2atZGn4dNHtc?=
 =?us-ascii?Q?GK4bZf7OPlFlIHocBNI1lvUDaN+o/qzbK/YU0nwRRixRMcTz9k8niaqsjDVK?=
 =?us-ascii?Q?1DeoFc3agZr7xEgbYLpGqQ2HXWPoxgxqf28rsvAuvJU2knnigStf7QuNWhTO?=
 =?us-ascii?Q?RUxxMhs4zyKEn0wjRWA4v87EEesHDBYBnm8AE7nSpOWcBMP0c8u3qG2ijWbd?=
 =?us-ascii?Q?6s5MZSn1YY2pCP/JLA7tEIscDMoL9kaCMROlhjEzlqKnSS3wsBq0LJTAAn4x?=
 =?us-ascii?Q?xG5ihlYqWvsGzC5ggmNM1QAsJZhYvcFwH+GFDdo/bbIVI+0ycDkKjKCtrBN1?=
 =?us-ascii?Q?szvAatBwM+Gs3kEpuRxDHzfAUOnrsVUUTFHsozF98MBJZuPVm2iqdY0YpFis?=
 =?us-ascii?Q?YVMf4DZxtjtZnJ9iAzD+uqC9D3JRfkZumCR73L2KqctxmMSUcPV0OkKW+ZrR?=
 =?us-ascii?Q?VGCYVKPNzVr9YEYFwoSo7S59F2gQmnST0oste+YyWQ2z826XQbrmg4zwGXOK?=
 =?us-ascii?Q?u1QFlWiFqlifC9u7BPQzm5iOfMchYsknfD30otFrsZ07e8gym+Gn68bDNVnS?=
 =?us-ascii?Q?+L8oeVI7CyrxbcVdxbQLNS60o9XmvbxiorYdF4Fe9FkfzCsKsduavNL5DbtD?=
 =?us-ascii?Q?ms9+Uc9YSSrFIyviBmttqojxX9ippxsxrrS0L5hifopga0cq+KMK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bb0ff4-bc72-4c46-0877-08de569932b0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:11.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4qWQU256nR5B/r/l6H/q7a/yp9o01scpib5KD3KBf4KtZ3+xOEmqI9znD0/4wz4V3ildLfQEuQ2MwQUd2DDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Introduce a backend abstraction layer so ntb_transport can support
multiple data-plane implementations without too much code duplication.

Add backend registration APIs, store the selected backend in the
transport context, and route key operations through backend hooks. Also
add per-entry/per-QP private pointers and move backend-specific debugfs
stats behind the backend ops callback.

Register the existing implementation as the default backend.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport_core.c     | 329 ++++++++++++++++++++++-----
 drivers/ntb/ntb_transport_internal.h |  80 +++++++
 2 files changed, 347 insertions(+), 62 deletions(-)

diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index 86181fe1eadd..2129fa7a22d8 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -77,6 +77,8 @@ MODULE_VERSION(NTB_TRANSPORT_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
+static LIST_HEAD(ntb_transport_backends);
+static DEFINE_MUTEX(ntb_transport_backend_lock);
 
 static struct dentry *nt_debugfs_dir;
 
@@ -300,15 +302,51 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+int ntb_transport_backend_register(struct ntb_transport_backend *b)
 {
-	struct ntb_transport_qp *qp = s->private;
+	struct ntb_transport_backend *tmp;
 
-	if (!qp || !qp->link_is_up)
-		return 0;
+	if (!b || !b->name || !b->ops)
+		return -EINVAL;
 
-	seq_puts(s, "\nNTB QP stats:\n\n");
+	mutex_lock(&ntb_transport_backend_lock);
+	list_for_each_entry(tmp, &ntb_transport_backends, node) {
+		if (!strcmp(tmp->name, b->name)) {
+			mutex_unlock(&ntb_transport_backend_lock);
+			return -EEXIST;
+		}
+	}
+	list_add_tail(&b->node, &ntb_transport_backends);
+	mutex_unlock(&ntb_transport_backend_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ntb_transport_backend_register);
+
+void ntb_transport_backend_unregister(struct ntb_transport_backend *b)
+{
+	if (!b)
+		return;
+	mutex_lock(&ntb_transport_backend_lock);
+	list_del_init(&b->node);
+	mutex_unlock(&ntb_transport_backend_lock);
+}
+EXPORT_SYMBOL_GPL(ntb_transport_backend_unregister);
+
+static struct ntb_transport_backend *ntb_transport_backend_find(const char *name)
+{
+	struct ntb_transport_backend *b;
+
+	list_for_each_entry(b, &ntb_transport_backends, node) {
+		if (!strcmp(b->name, name))
+			return b;
+	}
+
+	return NULL;
+}
 
+static void ntb_transport_default_debugfs_stats_show(struct seq_file *s,
+						     struct ntb_transport_qp *qp)
+{
 	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
 	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
 	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
@@ -338,6 +376,17 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+}
+
+static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+{
+	struct ntb_transport_qp *qp = s->private;
+
+	if (!qp || !qp->link_is_up)
+		return 0;
+
+	seq_puts(s, "\nNTB QP stats:\n\n");
+	qp->transport->backend->ops->debugfs_stats_show(s, qp);
 	seq_putc(s, '\n');
 
 	return 0;
@@ -395,8 +444,37 @@ struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
 }
 EXPORT_SYMBOL_GPL(ntb_list_mv);
 
-static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
-				     unsigned int qp_num)
+struct ntb_queue_entry *
+ntb_queue_entry_alloc(struct ntb_transport_ctx *nt, struct ntb_transport_qp *qp, int node)
+{
+	static struct ntb_queue_entry *entry;
+
+	entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
+	if (!entry)
+		return NULL;
+
+	if (nt->backend->ops->entry_priv_alloc) {
+		entry->priv = nt->backend->ops->entry_priv_alloc();
+		if (!entry->priv) {
+			kfree(entry);
+			return NULL;
+		}
+	}
+	return entry;
+}
+EXPORT_SYMBOL_GPL(ntb_queue_entry_alloc);
+
+static void
+ntb_queue_entry_free(struct ntb_transport_ctx *nt, struct ntb_queue_entry *entry)
+{
+	if (nt->backend->ops->entry_priv_free)
+		nt->backend->ops->entry_priv_free(entry->priv);
+
+	kfree(entry);
+}
+
+static int ntb_transport_default_setup_qp_mw(struct ntb_transport_ctx *nt,
+					     unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	struct ntb_transport_mw *mw;
@@ -467,7 +545,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	 */
 	node = dev_to_node(&ndev->dev);
 	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
+		entry = ntb_queue_entry_alloc(nt, qp, node);
 		if (!entry)
 			return -ENOMEM;
 
@@ -805,6 +883,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	u64 qp_bitmap_alloc;
 	unsigned int i, count;
 
+	if (nt->backend->ops->link_down)
+		nt->backend->ops->link_down(nt);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -866,6 +947,12 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	/* send the local info, in the opposite order of the way we read it */
 
+	if (nt->backend->ops->link_up_pre) {
+		rc = nt->backend->ops->link_up_pre(nt);
+		if (rc)
+			return;
+	}
+
 	if (nt->use_msi) {
 		rc = ntb_msi_setup_mws(ndev);
 		if (rc) {
@@ -952,10 +1039,16 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	nt->link_is_up = true;
 
+	if (nt->backend->ops->link_up_post) {
+		rc = nt->backend->ops->link_up_post(nt);
+		if (rc)
+			return;
+	}
+
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		ntb_transport_setup_qp_mw(nt, i);
+		nt->backend->ops->setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
 
 		if (qp->client_ready)
@@ -1012,8 +1105,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
-				    unsigned int qp_num)
+int ntb_transport_init_queue(struct ntb_transport_ctx *nt, unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
 
@@ -1057,6 +1149,69 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static unsigned int ntb_transport_default_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+}
+
+static int ntb_transport_default_rx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry)
+{
+	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+
+	return 0;
+}
+
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp);
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags);
+
+static const struct ntb_transport_backend_ops default_backend_ops = {
+	.setup_qp_mw = ntb_transport_default_setup_qp_mw,
+	.tx_free_entry = ntb_transport_default_tx_free_entry,
+	.tx_enqueue = ntb_transport_default_tx_enqueue,
+	.rx_enqueue = ntb_transport_default_rx_enqueue,
+	.rx_poll = ntb_transport_default_rx_poll,
+	.debugfs_stats_show = ntb_transport_default_debugfs_stats_show,
+};
+
+static struct ntb_transport_backend default_transport_backend = {
+	.name = "default",
+	.ops = &default_backend_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct ntb_transport_backend *
+ntb_transport_backend_get(const char *name)
+{
+	struct ntb_transport_backend *b;
+
+	if (!name || !name[0])
+		name = "default";
+
+	mutex_lock(&ntb_transport_backend_lock);
+	b = ntb_transport_backend_find(name);
+	if (b && !try_module_get(b->owner))
+		b = NULL;
+	mutex_unlock(&ntb_transport_backend_lock);
+
+	return b;
+}
+
+static void
+ntb_transport_backend_put(struct ntb_transport_backend *b)
+{
+	module_put(b->owner);
+}
+
 int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 			 bool use_msi, unsigned long max_mw_size,
 			 unsigned int transport_mtu,
@@ -1064,6 +1219,7 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 			 unsigned int copy_bytes, bool use_dma,
 			 unsigned int num_rx_entries)
 {
+	struct ntb_transport_backend *b;
 	struct ntb_transport_ctx *nt;
 	struct ntb_transport_mw *mw;
 	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
@@ -1101,6 +1257,20 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 	nt->use_dma = use_dma;
 	nt->num_rx_entries = num_rx_entries;
 
+	b = ntb_transport_backend_get(backend_name);
+	if (!b) {
+		rc = -EPROBE_DEFER;
+		goto err_free_ctx;
+	}
+
+	nt->backend = b;
+
+	if (b->ops->enable) {
+		rc = b->ops->enable(nt, &mw_count);
+		if (rc)
+			goto err_put_backend;
+	}
+
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
 	 * we will reserve the last MW for the MSI window.
@@ -1120,7 +1290,7 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 	if (spad_count < NTB_TRANSPORT_MIN_SPADS) {
 		nt->mw_count = 0;
 		rc = -EINVAL;
-		goto err;
+		goto err_disable_backend;
 	}
 
 	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
@@ -1132,7 +1302,7 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 				  GFP_KERNEL, node);
 	if (!nt->mw_vec) {
 		rc = -ENOMEM;
-		goto err;
+		goto err_disable_backend;
 	}
 
 	for (i = 0; i < mw_count; i++) {
@@ -1141,12 +1311,12 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 		rc = ntb_peer_mw_get_addr(ndev, i, &mw->phys_addr,
 					  &mw->phys_size);
 		if (rc)
-			goto err1;
+			goto err_free_mw_vec;
 
 		mw->vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
 		if (!mw->vbase) {
 			rc = -ENOMEM;
-			goto err1;
+			goto err_free_mw_vec;
 		}
 
 		mw->buff_size = 0;
@@ -1177,7 +1347,7 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 				  GFP_KERNEL, node);
 	if (!nt->qp_vec) {
 		rc = -ENOMEM;
-		goto err1;
+		goto err_free_mw_vec;
 	}
 
 	if (nt_debugfs_dir) {
@@ -1189,7 +1359,13 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 	for (i = 0; i < qp_count; i++) {
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
-			goto err2;
+			goto err_free_qp_vec;
+
+		if (b->ops->qp_init) {
+			rc = b->ops->qp_init(nt, i);
+			if (rc)
+				goto err_free_qp_vec;
+		}
 	}
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
@@ -1197,12 +1373,12 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 
 	rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
 	if (rc)
-		goto err2;
+		goto err_free_qp_vec;
 
 	INIT_LIST_HEAD(&nt->client_devs);
 	rc = ntb_bus_init(nt);
 	if (rc)
-		goto err3;
+		goto err_clear_ctx;
 
 	nt->link_is_up = false;
 	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
@@ -1210,17 +1386,22 @@ int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 
 	return 0;
 
-err3:
+err_clear_ctx:
 	ntb_clear_ctx(ndev);
-err2:
+err_free_qp_vec:
 	kfree(nt->qp_vec);
-err1:
+err_free_mw_vec:
 	while (i--) {
 		mw = &nt->mw_vec[i];
 		iounmap(mw->vbase);
 	}
 	kfree(nt->mw_vec);
-err:
+err_disable_backend:
+	if (b->ops->disable)
+		b->ops->disable(nt);
+err_put_backend:
+	module_put(nt->backend->owner);
+err_free_ctx:
 	kfree(nt);
 	return rc;
 }
@@ -1229,10 +1410,13 @@ EXPORT_SYMBOL_GPL(ntb_transport_attach);
 void ntb_transport_detach(struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt = ndev->ctx;
+	struct ntb_transport_backend *b;
 	struct ntb_transport_qp *qp;
 	u64 qp_bitmap_alloc;
 	int i;
 
+	WARN_ON_ONCE(!nt);
+
 	ntb_transport_link_cleanup(nt);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
@@ -1258,6 +1442,11 @@ void ntb_transport_detach(struct ntb_dev *ndev)
 		iounmap(nt->mw_vec[i].vbase);
 	}
 
+	b = nt->backend;
+	if (b && b->ops->disable)
+		b->ops->disable(nt);
+	ntb_transport_backend_put(b);
+
 	kfree(nt->qp_vec);
 	kfree(nt->mw_vec);
 	kfree(nt);
@@ -1513,14 +1702,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	return 0;
 }
 
-static void ntb_transport_rxc_db(unsigned long data)
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_qp *qp = (void *)data;
 	int rc, i;
 
-	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
-		__func__, qp->qp_num);
-
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
 	 */
@@ -1552,6 +1737,17 @@ static void ntb_transport_rxc_db(unsigned long data)
 	}
 }
 
+static void ntb_transport_rxc_db(unsigned long data)
+{
+	struct ntb_transport_qp *qp = (void *)data;
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
+		__func__, qp->qp_num);
+
+	nt->backend->ops->rx_poll(qp);
+}
+
 static void ntb_tx_copy_callback(void *data,
 				 const struct dmaengine_result *res)
 {
@@ -1721,9 +1917,18 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	qp->tx_memcpy++;
 }
 
-static int ntb_process_tx(struct ntb_transport_qp *qp,
-			  struct ntb_queue_entry *entry)
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags)
 {
+	entry->cb_data = cb;
+	entry->buf = data;
+	entry->len = len;
+	entry->flags = flags;
+	entry->errors = 0;
+	entry->tx_index = 0;
+
 	if (!ntb_transport_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
@@ -1750,6 +1955,7 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 static void ntb_send_link_down(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_queue_entry *entry;
 	int i, rc;
@@ -1769,12 +1975,7 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	if (!entry)
 		return;
 
-	entry->cb_data = NULL;
-	entry->buf = NULL;
-	entry->len = 0;
-	entry->flags = LINK_DOWN_FLAG;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend->ops->tx_enqueue(qp, entry, NULL, NULL, 0, LINK_DOWN_FLAG);
 	if (rc)
 		dev_err(&pdev->dev, "ntb: QP%d unable to send linkdown msg\n",
 			qp->qp_num);
@@ -1834,6 +2035,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 	nt->qp_bitmap_free &= ~qp_bit;
 
+	qp->qp_bit = qp_bit;
 	qp->cb_data = data;
 	qp->rx_handler = handlers->rx_handler;
 	qp->tx_handler = handlers->tx_handler;
@@ -1879,7 +2081,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		qp->rx_dma_chan ? "DMA" : "CPU");
 
 	for (i = 0; i < nt->num_rx_entries; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
+		entry = ntb_queue_entry_alloc(nt, qp, node);
 		if (!entry)
 			goto err1;
 
@@ -1890,7 +2092,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->rx_alloc_entry = nt->num_rx_entries;
 
 	for (i = 0; i < qp->tx_max_entry; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
+		entry = ntb_queue_entry_alloc(nt, qp, node);
 		if (!entry)
 			goto err2;
 
@@ -1908,11 +2110,11 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 err2:
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 err1:
 	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 	if (qp->tx_mw_dma_addr)
 		dma_unmap_resource(qp->tx_dma_chan->device->dev,
 				   qp->tx_mw_dma_addr, qp->tx_mw_size,
@@ -1935,6 +2137,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
  */
 void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt;
 	struct pci_dev *pdev;
 	struct ntb_queue_entry *entry;
 	u64 qp_bit;
@@ -1942,6 +2145,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
+	nt = qp->transport;
 	pdev = qp->ndev->pdev;
 
 	qp->active = false;
@@ -1988,26 +2192,29 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	cancel_delayed_work_sync(&qp->link_work);
 
+	if (nt->backend->ops->qp_free)
+		nt->backend->ops->qp_free(qp);
+
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
 	qp->event_handler = NULL;
 
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q))) {
 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_pend_q\n");
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 	}
 
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 	}
 
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
-		kfree(entry);
+		ntb_queue_entry_free(nt, entry);
 
 	qp->transport->qp_bitmap_free |= qp_bit;
 
@@ -2061,11 +2268,13 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_remove);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt;
 	struct ntb_queue_entry *entry;
 
 	if (!qp)
 		return -EINVAL;
 
+	nt = qp->transport;
 	entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q);
 	if (!entry)
 		return -ENOMEM;
@@ -2078,12 +2287,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->errors = 0;
 	entry->rx_index = 0;
 
-	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
-
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
-
-	return 0;
+	return nt->backend->ops->rx_enqueue(qp, entry);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 
@@ -2103,6 +2307,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct ntb_queue_entry *entry;
 	int rc;
 
@@ -2119,15 +2324,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 		return -EBUSY;
 	}
 
-	entry->cb_data = cb;
-	entry->buf = data;
-	entry->len = len;
-	entry->flags = 0;
-	entry->errors = 0;
-	entry->retries = 0;
-	entry->tx_index = 0;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend->ops->tx_enqueue(qp, entry, cb, data, len, 0);
 	if (rc)
 		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
 			     &qp->tx_free_q);
@@ -2249,10 +2446,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
-	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	struct ntb_transport_ctx *nt = qp->transport;
 
-	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+	return nt->backend->ops->tx_free_entry(qp);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
@@ -2293,6 +2489,13 @@ static int __init ntb_transport_init(void)
 
 	pr_info("%s, version %s\n", NTB_TRANSPORT_DESC, NTB_TRANSPORT_VER);
 
+	rc = ntb_transport_backend_register(&default_transport_backend);
+	if (rc) {
+		pr_err("%s: failed to register default transport backend\n",
+		       NTB_TRANSPORT_NAME);
+		return rc;
+	}
+
 	if (debugfs_initialized())
 		nt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
@@ -2300,6 +2503,7 @@ static int __init ntb_transport_init(void)
 	if (rc) {
 		bus_unregister(&ntb_transport_bus);
 		debugfs_remove_recursive(nt_debugfs_dir);
+		ntb_transport_backend_unregister(&default_transport_backend);
 	}
 	return rc;
 }
@@ -2309,5 +2513,6 @@ static void __exit ntb_transport_exit(void)
 {
 	bus_unregister(&ntb_transport_bus);
 	debugfs_remove_recursive(nt_debugfs_dir);
+	ntb_transport_backend_unregister(&default_transport_backend);
 }
 module_exit(ntb_transport_exit);
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
index 406033dbddb7..a7cc44c466ee 100644
--- a/drivers/ntb/ntb_transport_internal.h
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -33,6 +33,9 @@ struct ntb_queue_entry {
 		struct ntb_payload_header __iomem *tx_hdr;
 		struct ntb_payload_header *rx_hdr;
 	};
+
+	/* Backend-specific */
+	void *priv;
 };
 
 struct ntb_rx_info {
@@ -110,6 +113,9 @@ struct ntb_transport_qp {
 	int msi_irq;
 	struct ntb_msi_desc msi_desc;
 	struct ntb_msi_desc peer_msi_desc;
+
+	/* Backend-specific */
+	void *priv;
 };
 
 struct ntb_transport_mw {
@@ -124,12 +130,74 @@ struct ntb_transport_mw {
 	dma_addr_t dma_addr;
 };
 
+/**
+ * struct ntb_transport_backend_ops - ntb_transport backend operations
+ * @enable:             Optional. Initialize backend-specific state for the
+ *                      passed @nt context on ntb_transport_attach().
+ * @disable:            Optional. Tear down backend-specific state initialized
+ *                      by @enable. Called from ntb_transport_detach() and
+ *                      attach error paths.
+ * @qp_init:            Optional. Initialize per-QP backend-specific state for
+ *                      @qp_num.
+ * @qp_free:            Optional. Tear down per-QP backend-specific state
+ *                      initialized by @qp_init.
+ * @link_up_pre:        Optional. Called before the link-up handshake.
+ * @link_up_post:       Optional. Called after the link-up handshake.
+ * @link_down:          Optional. Called when tearing down an established link.
+ * @setup_qp_mw:        Required. Program MW layout and initialize QP mappings
+ *                      for @qp_num.
+ * @entry_priv_alloc:   Optional. Allocate backend-private per-entry data.
+ *                      The returned pointer is stored in entry->priv.
+ * @entry_priv_free:    Optional. Free per-entry private data allocated by
+ *                      @entry_priv_alloc.
+ * @tx_free_entry:      Required. Return the number of free TX entries available
+ *                      for enqueue on @qp.
+ * @tx_enqueue:         Required. Backend-specific implementation of
+ *                      ntb_transport_tx_enqueue().
+ * @rx_enqueue:         Required. Backend-specific implementation of
+ *                      ntb_transport_rx_enqueue().
+ * @rx_poll:            Required. Poll RX completions and/or push newly posted
+ *                      RX buffers.
+ * @debugfs_stats_show: Required. Emit backend-specific per-QP stats into @s.
+ */
+struct ntb_transport_backend_ops {
+	int (*enable)(struct ntb_transport_ctx *nt, unsigned int *mw_count);
+	void (*disable)(struct ntb_transport_ctx *nt);
+	int (*qp_init)(struct ntb_transport_ctx *nt, unsigned int qp_num);
+	void (*qp_free)(struct ntb_transport_qp *qp);
+	int (*link_up_pre)(struct ntb_transport_ctx *nt);
+	int (*link_up_post)(struct ntb_transport_ctx *nt);
+	void (*link_down)(struct ntb_transport_ctx *nt);
+	int (*setup_qp_mw)(struct ntb_transport_ctx *nt, unsigned int qp_num);
+	void *(*entry_priv_alloc)(void);
+	void (*entry_priv_free)(void *priv);
+	unsigned int (*tx_free_entry)(struct ntb_transport_qp *qp);
+	int (*tx_enqueue)(struct ntb_transport_qp *qp,
+			  struct ntb_queue_entry *entry,
+			  void *cb, void *data, unsigned int len,
+			  unsigned int flags);
+	int (*rx_enqueue)(struct ntb_transport_qp *qp,
+			  struct ntb_queue_entry *entry);
+	void (*rx_poll)(struct ntb_transport_qp *qp);
+	void (*debugfs_stats_show)(struct seq_file *s,
+				   struct ntb_transport_qp *qp);
+};
+
+struct ntb_transport_backend {
+	const char *name;
+	const struct ntb_transport_backend_ops *ops;
+	struct module *owner;
+	struct list_head node;
+};
+
 struct ntb_transport_ctx {
 	struct list_head entry;
 	struct list_head client_devs;
 
 	struct ntb_dev *ndev;
 
+	struct ntb_transport_backend *backend;
+
 	struct ntb_transport_mw *mw_vec;
 	struct ntb_transport_qp *qp_vec;
 	unsigned int mw_count;
@@ -157,6 +225,9 @@ struct ntb_transport_ctx {
 
 	/* Make sure workq of link event be executed serially */
 	struct mutex link_event_lock;
+
+	/* Backend-specific context */
+	void *priv;
 };
 
 enum {
@@ -169,7 +240,16 @@ void ntb_list_add(spinlock_t *lock, struct list_head *entry,
 struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list);
 struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
 				    struct list_head *to_list);
+struct ntb_queue_entry *ntb_queue_entry_alloc(struct ntb_transport_ctx *nt,
+					      struct ntb_transport_qp *qp,
+					      int node);
 void ntb_qp_link_down(struct ntb_transport_qp *qp);
+int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
+			     unsigned int qp_num);
+
+int ntb_transport_backend_register(struct ntb_transport_backend *b);
+void ntb_transport_backend_unregister(struct ntb_transport_backend *b);
+
 int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
 			 bool use_msi, unsigned long max_mw_size,
 			 unsigned int transport_mtu,
-- 
2.51.0


