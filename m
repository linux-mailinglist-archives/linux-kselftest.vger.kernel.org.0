Return-Path: <linux-kselftest+bounces-49272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35AD395DC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECA6303A001
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDD337B92;
	Sun, 18 Jan 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="D1sMSOYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020076.outbound.protection.outlook.com [52.101.229.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF17334C2D;
	Sun, 18 Jan 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744516; cv=fail; b=q+YNM2wDGT0Q+PQbbuuvSmEZDi4l8Bsx1xEfu8d6P6iRnD1QvauoyNVjJMuv14LbJCo1liePkfH2mmsctzI4O9CAaq78czAR/blKboZV2c3p51z81V7V4xlSlkis5PrXLSTztXkQd2TQ2+tbZrX2S7cS9WCU7VW1X9BtqcLhlp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744516; c=relaxed/simple;
	bh=j3v/oCrCieCIMH3ghUYx0Es65h8tq+lZ4jZvw5nIk/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slaEN/rYM32jL/T4tM/6bXZw7TphM/d/+xKORaYzzl58frx4KFyd/3U5HBobQl23qju42rl2yJzm+j/ByqsjMKNGotumZ97OcX/nXgqvTyo+a9ZRD6PPVcyLi+mvS2mr8QYREYe+mKoGub2u8Yo/hcUa2es95q3iNyUuEtdJSoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=D1sMSOYo; arc=fail smtp.client-ip=52.101.229.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn8GgfgCvXN2OgoRex1DBYDWvp0hdFp5xQ9jRtM5ja3la7akTdtl9Y5vUmyJ+dAlm38W1LrOFzZuNTogQ1J2EqhoWIR8PZgPJtcxRM6/PIgnI4IDayPAvp+Q8+cipcPWkYPpAj/78BCVFd02Hj8UmNQLCldNy6vbWO/yYi4yi2HXlXGKp+9LJYDOjm3QJFzofF3h71rOmMSlZolz3qDGF9baCQqLMB83JxE/FfYv/lvYndguk+6iMsdBECxRrNFqQc2PGWdYk4W+VFgeLptsJBcBZFuYEox8dhY0O5+3EJuSarFOurnPppDQjG8652IWsP/yUcIKNWYvoNDW92/2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPH1ItS4tEnUncYycsAP50Ucy9MlDzeZ2R3I57PWSdc=;
 b=RZ5kNupW9ZfZnBfFYp7RiNMHG3SWb7LWl23HPOB94DC9kofYk2+8OV8b2DU+DjSQVhn/++PUZDGKnN5QiKsmDvZTxSdDjpogN+sduWpH7/vxKpz/RGjAV58kUgDtHLivrJuFtylxpEyxVk8E9FaQYUzo5cWhqV8OWOut+iscMRYwceva/Fj/SSY6wfTplw4G4hlLP3KoqGzBOMBVAADr6mtF6wf82ddB45bnPoOzBsrGT3jK7J5yfwTqc7+m0LrOCRXHJ2Durarayid/RzHSH2YG6/5UQkHJ6DXO7Dq0/74xISDHVbNdIL3jz7/Vhpk7JpzlDu5AT57gsPq2IZNkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPH1ItS4tEnUncYycsAP50Ucy9MlDzeZ2R3I57PWSdc=;
 b=D1sMSOYoP7uxJ2p6ByoCiBpJNEZeMKAW3tpmwPS8Szzd7j0Al9ZOraIIlwEtjcx/uuDNOyXiPu7YWoCqITRZr0Li1MQjIr9bpSe0ysCNh4OyYUAL31Er1iao8MFs6+iHLd8bAp6OXQA9sozisEh50x2SwvK0N6xEaf0dOU0843s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:59 +0000
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
Subject: [RFC PATCH v4 09/38] NTB: core: Add mw_set_trans_ranges() for subrange programming
Date: Sun, 18 Jan 2026 22:54:11 +0900
Message-ID: <20260118135440.1958279-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bd0cda-dc0c-4132-188e-08de56992b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzpEOy2u4UUcQu5x6VURIyTSaRB3qKllqPXtD3tsP5soXBDwUpzyDY+iDitW?=
 =?us-ascii?Q?NdJeyUUCvqa8dE7I8ZwjAU9Ij7MrFJUoHHKQ3nFCYHRwT2aYrk05uY0ZJcL3?=
 =?us-ascii?Q?1KcRvHmQ9r8s/nhXK+QrHtJ6+B85VUTA6gmHw1V8ctbP185HbsjaDMnt3vo3?=
 =?us-ascii?Q?EkUG599LuPTL1LJjfKDXDzWxaWzo1gvL2BwjwbPGzQK9uPRFeRkI6LpeYiyI?=
 =?us-ascii?Q?X5J53JFmNR7eEPl8wtlWjhiRrVqBPEk9UD92lGnRl0GIZAjPWkERdw5zSFNe?=
 =?us-ascii?Q?l29jMrEBfoCx1bEjV+WJDjRNz+kkYWnjD0q5OxE0q8jOMZH93PZpCwWUCags?=
 =?us-ascii?Q?C8tA3Wp4XuZyeSK9oxXIzScO/ZjjrOQByVbfyuOYSs1w03SH5FX0yW6Td+Cs?=
 =?us-ascii?Q?6rgoOvBLpJH2KSW95gg6pETlVXqWqoE1EPLV/U0oprhkrYBeLFV3e80GSvMm?=
 =?us-ascii?Q?0F+rNk1gAFAlPB13FO48wSBnoOglWXdd8Lh3bGuju3cNyj3Jwn7BmH1HcHeB?=
 =?us-ascii?Q?7yDHG/3RuZhYmKwfQi6Dz245mDFhjpjPBQ4E0gxBHcohBRJew4697BpL37zj?=
 =?us-ascii?Q?qwUQ1KYRj2cSwfR7QT0o0jCZfTwkLpCIy3NMAplvXR2RLL/O/UDfysFWiF/S?=
 =?us-ascii?Q?5OcGdiNbJ/Qui+oPIJju9cBFdZFgDKIPkjuFmI86LFXwkU9gAWl/19Q0D8XD?=
 =?us-ascii?Q?qVjBAbSWz/H8ZWkvTPAOSKsQecUy3hpl9gEqjZ4VZ1Fm/HTZ5bPjP8U2cs0h?=
 =?us-ascii?Q?QxJR7+Pvy7BHKQPFR2UiIotOPCx8FkHqUXoN3kVu1b2ExpZKE3MxUCODLE3N?=
 =?us-ascii?Q?ISfbXTHusytd8D5tBuEpBGvnAccmOuEwR328tzws6xxbCmEfLmPsweAo2Dnp?=
 =?us-ascii?Q?AhBkkjcz9RUXZr87TCUz/0I5QAPZOGwFPYOMfB4ZpLfPok1iwYVcjdurON66?=
 =?us-ascii?Q?eU16YLY2cszShESVKHsLy9JaU3l3UODAp7kIQ2312VwMXL8LD9JD666AL00U?=
 =?us-ascii?Q?b5k3XQhxz0fvzaTufsiFkBWmrBuF+x/rVEGW1te1YYP4ObxPlDdY0HGSUUH4?=
 =?us-ascii?Q?5UR5WUh3hmUO+2ANH/Zh1xkHe5+c4iBcJDyMdEZJUH4SMUTyo0zuh+WTO5kt?=
 =?us-ascii?Q?Tnbdwvjzt9vZ36XV5sGrtUGPBt1PnoS8bCyqYOU25emNliCJXk1rGVtbLwk9?=
 =?us-ascii?Q?knHd69o6LnOtkWUjqOR3HMVWHzGqTZti7zvRSCnJiLo5FpqPYvZZylI8bzPy?=
 =?us-ascii?Q?ZEkxleRcRPHrITeV1aqlT0fUIbmdYQcCJ1AO2MMoM+nPcmIRyG/A0bpnsHCr?=
 =?us-ascii?Q?hq/LTV7HqnH7/KB8ne9LOxYM9nFhIHKOswa/6bYUtklr8EEV290BWUGhPcNa?=
 =?us-ascii?Q?/PisThjLlgF+QBpR150mixnfCW5tMVkE4oOJdOSfOQ3D8hUCuksboTjNY2UO?=
 =?us-ascii?Q?ytFEf2ip1opHTxujS5NaQD6VZWt99rm5SpSbROECgnxTYnW3Np43AtryglI5?=
 =?us-ascii?Q?dovIp9PdsxuIvIjSSJBO3doEoMs3mi4+Ts8BMIOd7CcHla5MplMkLE0L/z/R?=
 =?us-ascii?Q?5aLFkZ8c35jTwYjQJ7cYzGG8lrTtb1c99Qv/hjE2iPU7vwnDEcN28UyXncME?=
 =?us-ascii?Q?0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/FVsohvKkQvgKtTmhJ2/f+UIXL3ZLKcEKo6HCWxTet7rxWNgGlQjIu2YlyH?=
 =?us-ascii?Q?zQOA1Or6dZiCRCwUE0z7bLYueY5rmgNuHEEZPoQr96OHDvbhTeZgKH0Zd0KP?=
 =?us-ascii?Q?fuJh1d7gP3t3YUYSNXbHUmxJ/KgiUOYtqnL9nim+27o/Or9MA9RhmJL35dD4?=
 =?us-ascii?Q?pteM+isUwPrkLsmTfuNxs3RThBJmIUq5JLDlmXy6pRQdc27IWs+syk0lhv+/?=
 =?us-ascii?Q?NWbIaxITvzGdc4/8Q30yh+Mz0Kskw99fNzWvQ+UTjawCopNGgSA7kDnoQEGy?=
 =?us-ascii?Q?XOnnu9WP1Po3zARl3X4en4O75QlWnNvNDtJAOKjQ5Ad4bSe2T93KcMUsc6+2?=
 =?us-ascii?Q?aJBu4VYkiQI3v+83sktbmQQzsDmmu2JtGXRTbqXZjRNzd2FikC+YPRSUS0Ad?=
 =?us-ascii?Q?XKzzbbOplHY9vSNv9sg+aKddr+ifEFKfTKDuwJPasZt2kYnRRKDesvMGPiz4?=
 =?us-ascii?Q?NsnY1T4U4JUFA2yLbFpAE8U2eR8rGbm3xGeDuKVDcIBit+V7hBG4YtmLVJoK?=
 =?us-ascii?Q?5f6ZOHseUEzUpw68UfXnKDHu66g9+FWwvzbyUNs8siBiQEF3Qvh7Rs31FdkZ?=
 =?us-ascii?Q?xmjxosH/V9isT9QNZWBaNX5YOWTklwsN2NIMxDucVhQD9Z9p1SQH+aqd4ALh?=
 =?us-ascii?Q?jq3yF4QQL9RCjAyd6YFm2ecyIJuJ3pFYT9Rnq60xhBtMFI9FaUeETka25YtC?=
 =?us-ascii?Q?ChKd7HXc+MdNwSqMSWaOAp1hkWyyS/G32MrbetFSwjJGRFJlAL83wY2Is/1F?=
 =?us-ascii?Q?KLx5WQ+4X0aS1ZEjfVBnGdqid7pXDMP4vS4eqN/quZZHuQ21KZvIe0O5zYbV?=
 =?us-ascii?Q?fWFt+YfbWDLlhiTgBN62go7vwRniCMm+haf3mwOavXitDwe4K7TiAyC4QRte?=
 =?us-ascii?Q?CenB64+VIK3HUXL4PKk3njdM3n851YLPgCk/bLY8AxON59LCmp9Am8soG3ZZ?=
 =?us-ascii?Q?pSHSnxossUb/zbSZLKHpx7URqytjLpW4XuVsHDdf5tPStOdU2vUvytp1zkFa?=
 =?us-ascii?Q?YE22CzlEv+Vt/78/cUfv5jLlTc0fzbUJd3uYkfKkUe+GzceIfsXe6HlX0WOo?=
 =?us-ascii?Q?YhjzUgPFo6nv28r7z1+CutF6h7bDEvtAPFnCAbe1Kt85qslXK11P1YbKUtz4?=
 =?us-ascii?Q?cG0mBcL1JqlUwBMu+WBrYhTnABqgDl8A3cYoGSqT/Zo7f8rxDX2Lt737Obf3?=
 =?us-ascii?Q?6gNA2QDNLcBxOCop+littRmd4OJUOS6jwKNxdycySRkIksgU6vFEAzs+Sb6F?=
 =?us-ascii?Q?GWYbK7hx4ZSkhhq9GZQlmtE654gqvtq5nYdM0bV+NNF69lrsWHYD1rUJ5VkA?=
 =?us-ascii?Q?euxChzZQwIvswe6qARan2aXT8oIPwDfs1da+dq0vsqa5NzwQQQMTnOcyttjB?=
 =?us-ascii?Q?UMPSqFnMHT6bgPjDlkabNbswwj4CJOZUdq5Dza0fipgiFPQNPEmFMrtgGbol?=
 =?us-ascii?Q?Fbvot7Bnrw0DzdjSpnR3pril5fUO3Hvzt+tR6sGzFDEQE5jTmCYQiSrigABH?=
 =?us-ascii?Q?Mpjz701SMkd5GTqvhQod/smpFzOMSBamwQllLkz8DDLximvAFd1+L4To+ecZ?=
 =?us-ascii?Q?9Q/99L2MpJis18iKMaupHKw1l7vfu0AzJB1sOADBmj3z1isDt7yt7UXns9uK?=
 =?us-ascii?Q?Pb7+Zbv+5iO8dWH0WKUMxhU2tbovl1NyC3UpFs22rWIzSoqwQyENCdntdhW8?=
 =?us-ascii?Q?bY5a+OlB+1Dw6x6HsRjbBliAjI+AirwQZH8CxkvLy0NY/qdfIHLMKgPbXFO9?=
 =?us-ascii?Q?QBFhWA/C7OMuZmEio8+qsigpmxg2lhnombLP2ihIHAfzn2RhHMFW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bd0cda-dc0c-4132-188e-08de56992b98
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:59.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXIlt0n92TCfclsbezcgkKIhO6oxE6MrlrMc9c+16dEJXQ+fydSHxOC2Bssek0ER1g5rVtmKF1M9pKvSVOA+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

At the BAR level, multiple MWs may be packed into a single BAR. In
addition, a single MW may itself be subdivided into multiple address
subranges, each of which can be mapped independently by the underlying
NTB hardware.

Introduce an optional ntb_dev_ops callback, .mw_set_trans_ranges(), to
describe and program such layouts explicitly. The helper allows an NTB
driver to provide, for each MW, a list of contiguous subranges that
together cover the MW address space.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8ff9d663096b..84908753f446 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -206,6 +206,11 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 		1;
 }
 
+struct ntb_mw_subrange {
+	dma_addr_t	addr;
+	resource_size_t	size;
+};
+
 /**
  * struct ntb_dev_ops - ntb device operations
  * @port_number:	See ntb_port_number().
@@ -218,6 +223,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @mw_count:		See ntb_mw_count().
  * @mw_get_align:	See ntb_mw_get_align().
  * @mw_set_trans:	See ntb_mw_set_trans().
+ * @mw_set_trans_ranges:See ntb_mw_set_trans_ranges().
  * @mw_clear_trans:	See ntb_mw_clear_trans().
  * @peer_mw_count:	See ntb_peer_mw_count().
  * @peer_mw_get_addr:	See ntb_peer_mw_get_addr().
@@ -276,6 +282,9 @@ struct ntb_dev_ops {
 			    resource_size_t *size_max);
 	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
 			    dma_addr_t addr, resource_size_t size);
+	int (*mw_set_trans_ranges)(struct ntb_dev *ntb, int pidx, int widx,
+				   unsigned int num_ranges,
+				   const struct ntb_mw_subrange *ranges);
 	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
 	int (*peer_mw_count)(struct ntb_dev *ntb);
 	int (*peer_mw_get_addr)(struct ntb_dev *ntb, int widx,
@@ -350,6 +359,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->mw_get_align			&&
 		(ops->mw_set_trans			||
 		 ops->peer_mw_set_trans)		&&
+		/* ops->mw_set_trans_ranges		&& */
 		/* ops->mw_clear_trans			&& */
 		ops->peer_mw_count			&&
 		ops->peer_mw_get_addr			&&
@@ -860,6 +870,42 @@ static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size);
 }
 
+/**
+ * ntb_mw_set_trans_ranges() - set the translations of an inbound memory
+ *                             window, composed of multiple subranges.
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @num_ranges:	The number of ranges described by @ranges array.
+ * @ranges:	Array of subranges. The subranges are interpreted in ascending
+ *		window offset order (i.e. ranges[0] maps the first part of the MW,
+ *		ranges[1] the next part, ...).
+ *
+ * Return: Zero on success, otherwise an error number. If the driver does
+ *         not implement the callback, return -EOPNOTSUPP.
+ */
+static inline int ntb_mw_set_trans_ranges(struct ntb_dev *ntb, int pidx, int widx,
+					  unsigned int num_ranges,
+					  const struct ntb_mw_subrange *ranges)
+{
+	if (!num_ranges || !ranges)
+		return -EINVAL;
+
+	if (ntb->ops->mw_set_trans_ranges)
+		return ntb->ops->mw_set_trans_ranges(ntb, pidx, widx,
+						     num_ranges, ranges);
+
+	/*
+	 * Fallback for drivers that only support the legacy single-range
+	 * translation API.
+	 */
+	if (num_ranges == 1)
+		return ntb_mw_set_trans(ntb, pidx, widx,
+					ranges[0].addr, ranges[0].size);
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * ntb_mw_clear_trans() - clear the translation address of an inbound memory
  *                        window
-- 
2.51.0


