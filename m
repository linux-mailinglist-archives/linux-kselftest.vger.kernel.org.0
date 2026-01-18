Return-Path: <linux-kselftest+bounces-49271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B870D395D5
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007AB303806E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFF3375CD;
	Sun, 18 Jan 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZzfyE1cd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB0335066;
	Sun, 18 Jan 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744516; cv=fail; b=WmkCWijAm6PS9PdO6A6ejMlrrCuhYKkECT+A+KW91EZfT9a/MmX4sfFxdhzVPDZ5BTM95QROyOrbk0Ozj+6cDZNbC2xwIy1fjJBzB046uhNdnj3EeEN1kSVVLVZ/aKV8H+oJfA0ObYXs9u/CS6t4GWMCoGGFIxiHG5jlH6bycpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744516; c=relaxed/simple;
	bh=TwA7jYa8EdOldPUFqQXn8qY8Gc/AzIrQtEiPCOic/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l50pH7id9swZU+MuTsSIhORjT77ImiCHXnMgxuD5JFqc/shW8TkqcClHxrPTLlSD3KoCrx7qbt5Y8hFbw2ikdapq8Y6IIpzp+jUVPQpvVOD1pYJIuD8OlG/uDCTCfX7rLRUXr/iIxPAjgTec9fHfh7XNEhu/nEzANurRr3QucEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZzfyE1cd; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIzDA+SKgLM1/N32MUPGqbh1iRaX0538RYWXzLPV24YvLf95OiycGxroGEMSoe7m4D8Ku3l0cbXu0QxchOyO1sazyDx9DRL7GA7/WS87RwF0iIGM3We33nwpo9JgYTcDwllUKh+KydjigYkESouztDcO5hVtgyasTgMBR5NJv1Dq+CJqrXuZ5O0hgJI/KuFEMrAsGyJLCJmxajwlSE+mVEcGUTSi3b3/Wu+JplP2DHvLO+lpEBOv7bofyoSV1oBC5Wg7uvA9jDAq+7awlgvJrVRy3YH+oSZdpMdrsMgU3hP+/3UlPvUpYERAadY5RraAz36SbauiB4JVdGkGreKyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByMAQyC4BUFQ3GyYv0jpEj7XT0XIdZJsc0QSXRyfyhw=;
 b=Z3P4NRA63BsVHq/P3gkE509ude1DOmpmY9yPhJF+yZ4nQ9cb/8NH1LDCicn4PrGm3+FZjpz7N2/Kx5IBopwWtnUXIlbdMn2NUpzbQD4QFV3HdaZslFULefX3WAvrOm213TgTNmzB41Od+VKT269wqgiWTxx8d69c5wzPU0cGzVoPacIkpWTk61SXeYbNDsFzE1Vg/VITaujGDU88AHqNR2OEr3M0p1jUlA6A2WL4zAg1kAKJF8K/lQABX3+z1VHjD+uuYIJKw4eXEIw+hoXuzXAPANpX7bw+gK3LZGpktPItuEe9ie1uqRHPtHrrfuPC6QHwFKTVsXNZmI4twq/1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByMAQyC4BUFQ3GyYv0jpEj7XT0XIdZJsc0QSXRyfyhw=;
 b=ZzfyE1cd6en957vHHL6fLoCR+YKApr2uawu3xscJBE9u9YVzqn+Ss5AwzWdQ8NI+xjh1Bjhkoftptx2wJ1iO72wVRnbZHM2OeSMgsZOS7Gag+cq44+bUmw6IbkBt3uEFmXoXDyWtDokT5gk6BPN52rEqNaXHMGQqtLlUeMtoO2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:57 +0000
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
Subject: [RFC PATCH v4 07/38] NTB: epf: Reserve a subset of MSI vectors for non-NTB users
Date: Sun, 18 Jan 2026 22:54:09 +0900
Message-ID: <20260118135440.1958279-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a809a1-5d41-442b-c7a7-08de56992a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+5PB6YLGQCUF+7B5NJoTbYLU2o5eSbA/lTOXASh6bpZLubtSqOnGo6QAo/A?=
 =?us-ascii?Q?8mt7RRAk60S1vwDGTLHFl7v9yRD1iIkwXfn41WdTWSHNxjjKeOiUtUrDaYAS?=
 =?us-ascii?Q?G1b+0NjGW68LNWd62IzFHVNOjkGhouVxgTKA0V2fbjuR2Muox5JeL1kvlm10?=
 =?us-ascii?Q?Q4O59Phs+YtB1p3lj1F+U2Qd6iLoFVe1xA4GXCtr4wHIu9PMosxdOYV4Hd9S?=
 =?us-ascii?Q?tRkYAPN1NqsjkAS2vzfVYEKc5hwIuSBev7bHlou3Wlr49WTfvlIULkDAjIBY?=
 =?us-ascii?Q?XheXOOoUGvisLixFQk9zPdrE1czCs08x9n7GC5wHjIMZsw0M5TlPer6xyA+5?=
 =?us-ascii?Q?Oy6yHNakHbOJLhWdB5jHiQZr0XBh99KFcbWgEPVlgnxJrLyH2BDd5d3Kf7OV?=
 =?us-ascii?Q?HQkgALz/4efCgeShUNiTNI1qtA2/3TxzAoHUno5qwTobjVZtZVf9ckcrPxCz?=
 =?us-ascii?Q?zUKhRtM2CRAYP2dQdcaLDhM09EuuXcUAl7XaI1FH3//mIXFTttKa4BX/OTa/?=
 =?us-ascii?Q?Ukn4xkMwnqVZD8VT3dN6uMsTFtWFUwn4MxWy+h1k7ZGDpcljXzoJQexb/tIw?=
 =?us-ascii?Q?oznDbhMcgGWhFDbfsTGOcKPEiFlOMzD+/DBZ/3iNWxagFP86WJtQQvgmL9kZ?=
 =?us-ascii?Q?AC/SQ102cEhS+1AT8xYNyMfNJ7dzJqsl1NhUwp14aHXBFuZ8u13kZiAQvw6H?=
 =?us-ascii?Q?lqj01gb95HfYydbv38J0HUkPOEkes6YCioRnds2d4a6Kn6kkTdTjy8cnZQIw?=
 =?us-ascii?Q?ni7ZHVNLIQI5F9Ccx9CJnB00om0JfElZjybKf7GqKBVRsww7iWgs8PpFzOmR?=
 =?us-ascii?Q?99aonRnDBUEkQh+xaLiLCLMPbHLbxH6E9RMpgrat+GVbeTJVslpdbTu7aCNQ?=
 =?us-ascii?Q?IkKVpswwgMw9csV+Dpac0b2YI9zaXO9WHA+vsP0WTew2aCbuKdDwDY7iygPk?=
 =?us-ascii?Q?U5M/VIZoUG1bCX2JCMeW2FlLHfDPKSqcHRiB/foqkgdYYYkhh054+bu1yXlX?=
 =?us-ascii?Q?Iyu1quF7mq+kvKzmGUxOgVNy1dIH3MZLKEeXlktOkMhHtBgqk+LkJpfZBvzb?=
 =?us-ascii?Q?NrGIfIzg9kmZIlW7uY6B3K9QVa37skU64MYVWyo5+mpZ4JYMg6wHh6x4TC/y?=
 =?us-ascii?Q?cx9YpiV2ycmsvAvXtTWBTuoW67JyCQ6guD2Bl0tFxap6ILGHjFG031jHrNeN?=
 =?us-ascii?Q?TG4rMJS7ZeKc7ltwBy0YRmvDlPDc9XTN/MjubrvBjeUJrA02OeTVW9KJbEc7?=
 =?us-ascii?Q?c2TUwA318qsqP1Kf3DgfoVqBH5SnwtgtObwsIQAeMz11Fdbw0UmpTpekEWlk?=
 =?us-ascii?Q?jb7F6CpwPZpGCK/2Ah3MIXX3s/WF9GG7NMuEVrZn/y0udPQ4CyZBCHxA/eue?=
 =?us-ascii?Q?rcOeoh+C+xL9jImL8ZXVjVjfpO27EOSdySJsc/ldWXeSxPNpiZZY+v2xGJoN?=
 =?us-ascii?Q?FMxPU7qXNbeS5QywZ+zVXwklhuzR26BKVwqdAvn9uWU16ApGoW7bTHmbTvOk?=
 =?us-ascii?Q?YmyEy9B4DmOmQKJeNLlJuLHEMMVjwWOxD3Tx/e6zEAYJ7aFlFPsDiXn7u+AD?=
 =?us-ascii?Q?Id9x9i3SHy8sDIRVvP8XMSCrlXMj9270PLkv1vyS67mNnofKdxoqL+LvMvqI?=
 =?us-ascii?Q?Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RapIuY1lCgonio4mc1V7+AIkxwCg1sYvOZmEHCQqg3GK5poYI4JlhP+FkNGF?=
 =?us-ascii?Q?G7KExEog11uG+zeYrZUnfX3bPihJeAv5ahgUSG9Q+rAFKhp/dMxBWAZpOO3M?=
 =?us-ascii?Q?OCuluarMhcV4YK++2Y0bZiyAVNaOL3dmkBoqtx9vQQpr7ZeqpaXhPXFd8ceE?=
 =?us-ascii?Q?amSWHkOIQ13YjP+ssdKBqmqW2gNKbDx5T4eQLUWnmW09U6IWgr6dXQKMG8aD?=
 =?us-ascii?Q?s8J0s/XcxjxDd4s1btJa05OHG/SZvvFXyL/7nSZSvNepuXKZVWQjWpqadaPz?=
 =?us-ascii?Q?8CxICkuTnP8I1c8G7+6ZZxHBjUNShf+PGMNFp6Cuwu1wAAZVRcCIfWsyntBV?=
 =?us-ascii?Q?+w7Fea57dJiIOBVoFeyfDmw6Y/+S9iRZOgmg2+MwrqGhFVkSDgQQ8X3Vbz3o?=
 =?us-ascii?Q?l/qyiGANf4FiMd7iWq8vLJ7daMocpWCZNnCi9aFaF3S/OaCi0DY2OuGsoX+X?=
 =?us-ascii?Q?QWdsM6KjSwBp8vqD4erlxcX5VQ+oaOJ4VCOR7YwoFMyIOoOjqpzIQ/7kfsue?=
 =?us-ascii?Q?+qft32BUh2XxVGySuu0zrsLZgrEhUu9MkEXaMWtO+F0154cCjEyax7NiT+ty?=
 =?us-ascii?Q?aS9rtHhW3l2B1S6ZsifQ482sXTCn4i+Ein4V68fcWXhk6O6UbxB0Wnn+3qXU?=
 =?us-ascii?Q?HcRxChN0u4149PW2W6DsjZ/8PH4SbpufNHqKPLXjt7oJ5CgLOj1iB8fzhBvk?=
 =?us-ascii?Q?nTHTbfHL7ltwouiZtyxvqgnXU13ZrD6gCIsMMojYQJTCF/Ny+RVFxmrz6LAe?=
 =?us-ascii?Q?qO/JQ3frqVCOppOsHkYkJEXXvNlbv4g1gCAW/nO+U15JMi4ZC0MVJ+snM9Oa?=
 =?us-ascii?Q?aPo6iqawh6A4khmOwu1i1c3rxRb+ORH2jW6rpJgj+fh6ARBm+4DA7sd4SnQe?=
 =?us-ascii?Q?NviaWNly67X+4IDXqYhInW39gk5h/FmTQZ5rmrZBd6+HQXLzKB6795snwfw4?=
 =?us-ascii?Q?EzspQIaAjZxn9fyNKAf3lFzLAc5mMACc1u1vJGr8WrnKMGRRrYbGvi7AjmzH?=
 =?us-ascii?Q?XTRsFf65pn+Bl4iSRZ4g82Bghv8icr7JvOUXfm5XkuRWc2EVTkJDorNu2pyD?=
 =?us-ascii?Q?qaYnOOkqtOU3d4gCQOk0kGmq4z/sFKF0eYANtGazbNuUyYos4EMQv3Tw7ndY?=
 =?us-ascii?Q?NPDrZ5n6rhYnImy5CLVTKlV8hfjDzn7YJewglpFONA50isII9QNHIfK+j0TP?=
 =?us-ascii?Q?YZ49abkyh3VfJI+Zn0H9wnHCPxN4kADmskLZwqfJWVgia2ysgyo0L5gbRV5u?=
 =?us-ascii?Q?tOe9q25vDIFs5M0QKSvEv0DNRyzdYzYyxw2IFMJ137mvWMtuCRi5sUgNYf5c?=
 =?us-ascii?Q?sMDDIzJFgRZCD8h3ZK8Jdyc7Jo5GBWsZRWKLkozSYVJ3GnGPTTvHqplaJcR6?=
 =?us-ascii?Q?D0fTvnaIDSmpmScylEi7j2Jkgqr14CTTVG2NRQMz9StHRMe38bil5cT9alJD?=
 =?us-ascii?Q?rt8xpXfN5tZGfJgk5cTipi9Z+RMuATdxVg11aB/awLxxwhnSsx0UhPaW+Z1q?=
 =?us-ascii?Q?KjOrNaEzEmUo9VniVOJ/fZRarnxFLMNWsNEeupxyjW15dZ5qhdlZAAl+Swp1?=
 =?us-ascii?Q?KRoh3CJbdECp2ssbBMoTMdk5WeoanBgWjwUqSIAbD2lK8ayxm/PyyBTyWI0t?=
 =?us-ascii?Q?wx9ua23U+UX4Gc0+w8uGxJnTC4xEYMVftfF53G7SoZTXSVZMnztR0vvu8vtc?=
 =?us-ascii?Q?AaX+vgpHixxCaIz1ApscYWJnld3PNBVJf1SFDgGK4WUCaEaIFqpwcJ6Q6THr?=
 =?us-ascii?Q?BPKn17urbo3A1YH4NIR/L/Ow1dPjsJlILHY/Z5e7GWUJDQJH24tb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a809a1-5d41-442b-c7a7-08de56992a9d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:57.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAd8dAMKl5LCXKFUvKxBpnnCoK4B6KTLui6rU31t5kQYicvE38Cgl6MMx1Qv6eCTXy512GZMxWhNh4mRKGu7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

The ntb_hw_epf driver currently uses all MSI/MSI-X vectors allocated for
the endpoint as doorbell interrupts. On SoCs that also run other
functions on the same PCIe controller (e.g. DesignWare eDMA), we need to
reserve some vectors for those other consumers.

Introduce NTB_EPF_IRQ_RESERVE and track the total number of allocated
vectors in ntb_epf_dev's 'num_irqs' field. Use only (num_irqs -
NTB_EPF_IRQ_RESERVE) vectors for NTB doorbells and free all num_irqs
vectors in the teardown path, so that the remaining vectors can be used
by other endpoint functions such as the integrated DesignWare eDMA.

This makes it possible to share the PCIe controller MSI space between
NTB and other on-chip IP blocks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 36 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 4b3fa996219a..dbb5bebe63a5 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -54,6 +54,7 @@
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
+#define NTB_EPF_IRQ_RESERVE	8
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
@@ -92,6 +93,9 @@ struct ntb_epf_dev {
 	unsigned int spad_count;
 	unsigned int db_count;
 
+	unsigned int num_irqs;
+	unsigned int num_ntb_irqs;
+
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
 	void __iomem *peer_spad_reg;
@@ -345,7 +349,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	u32 argument = MSIX_ENABLE;
 	int irq;
 	int ret;
-	int i;
+	int i = 0;
 
 	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
@@ -359,33 +363,40 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	ndev->num_irqs = irq;
+	irq -= NTB_EPF_IRQ_RESERVE;
+	if (irq <= 0) {
+		dev_err(dev, "Not enough irqs allocated\n");
+		ret = -ENOSPC;
+		goto err_out;
+	}
+	ndev->num_ntb_irqs = irq;
+
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
-			goto err_request_irq;
+			goto err_out;
 		}
 	}
 
-	ndev->db_count = irq - 1;
+	ndev->db_count = irq;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
-		goto err_configure_db;
+		goto err_out;
 	}
 
 	return 0;
 
-err_configure_db:
-	for (i = 0; i < ndev->db_count + 1; i++)
+err_out:
+	while (i-- > 0)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 
-err_request_irq:
 	pci_free_irq_vectors(pdev);
-
 	return ret;
 }
 
@@ -502,7 +513,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 	u32 db_offset;
 	u32 db_data;
 
-	if (interrupt_num > ndev->db_count) {
+	if (interrupt_num >= ndev->db_count) {
 		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
 			interrupt_num, ndev->db_count);
 		return -EINVAL;
@@ -512,6 +523,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 
 	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
 	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+
 	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
 	       db_offset);
 
@@ -595,8 +607,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-			       NTB_EPF_MAX_DB_COUNT + 1);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
@@ -704,7 +716,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 
 	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
 
-	for (i = 0; i < ndev->db_count + 1; i++)
+	for (i = 0; i < ndev->num_ntb_irqs; i++)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.51.0


