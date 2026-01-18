Return-Path: <linux-kselftest+bounces-49300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADDD396FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04C99312990F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804DD3590BA;
	Sun, 18 Jan 2026 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JcWvAA/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021096.outbound.protection.outlook.com [52.101.125.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED1355803;
	Sun, 18 Jan 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744562; cv=fail; b=XN7OcHIPDb3ElxImJhnj2w/4Wydybtdw0AfprVbcwxbu2/qbnDnrA/+UpaPeH8cmVnDtdpRH0LvBUWDN79G3iWqqfIHkQP0q4EEKKNLIA/QX5imxItMFgflkziQ5BpIMxoEWzBPfu9zSOSAv9vcTRvr83CbebMF/9w6A2okCyRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744562; c=relaxed/simple;
	bh=MVwPZuZYEpSG3ra6ABX3PUl45GDo33m41PSL4rh0d3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7Eccx/dPijK1++AdkubUOha47311fyEFF8rk7x+rC5igUFDKgmWOZQFNOMu4DXV8I+2GjavtxZY291Px8+waKs41pNmMGQ4CIjyJIAwPT6X06Cao5u5ynVN73oNYnHB0J1xQ09Tixi0rJZU1uuX1xwjWdA7x4LfVM/G9ySDxy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JcWvAA/5; arc=fail smtp.client-ip=52.101.125.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7FRzkpzf4LIXqA5Kb/TCHXiDQ/+UVCKxXvB6U1RpDdjOY0d6LzmQptSIAIgj35sZGBUuEafmeH1DPxp6JyxL3v7pq6XYLAFXAExyN6b17KXhRhZCkG9LSN2ei/oLQy9rVukEF4Txfsh0X+XU6HuExWdhvCWtXjo+F9UIrDcqBwwgNfgvQ4YOvAvwC0aFxW+lz25XXFTpiC5p0nTNp8WN3qKpkWpXidncETKaON8+CyBriCr6eLlSQh6sHXoiOnZkra7Hee2s5yZ1bEallZ7MM7ar5jczHkM72Wocui4EvhyFO3kwbFIungKGam8i5J8cfBTif0gSy30Pwfa1uS0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfi79sfUOdAnx8ZsNbiXW15ZQ35ni+Hpcru6fYrwKvo=;
 b=V0X/lFzEP5sx+ZgfQfR1dzt4C2P2tjxfMcUDu9PibS6cQFHpx3XapDA1uUUCPh/UxyNO4KGxeA117ONUqoKPIzdHvOhFEq7cgymZcE73J3eq1Z7flkC94lwfhVOA0raJOazjyPaTblb85wDDf6Hrt6Dfq+9x/8VIQPVIifWoHO7Z6jvO18wYcNqg55SOWPurXmXTp2J9jnIEV6OLV7cXWyRWhVN0I6NpthucyNeoskA6hWNX+WpMZWEM6yxqk5yBgryK049z6WvkI4TjQVtZkYdI4aGZdhyfYWmZ0+HHXKpxdBaLm7lxXwqkJO+yzDrrPYAmlY7gZHVDlClI209q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfi79sfUOdAnx8ZsNbiXW15ZQ35ni+Hpcru6fYrwKvo=;
 b=JcWvAA/5Mv2nY+iK8Ri1mTy9WIFYsNmFONzHG5t/OxhajLnY0TL5tn3RYZqakOQSYxysPNnA1s1R+Vh4ReXm60+J+x8URW1DsUKsFOtfupmO5TY+TBrPdAdHqxOxwfHz40Wb17ya3yRPNsqXmZ6YGNhjyL1F3vR40+TDfi4yhiA=
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
Subject: [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
Date: Sun, 18 Jan 2026 22:54:38 +0900
Message-ID: <20260118135440.1958279-37-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: ebca2904-09bd-4ee8-2e98-08de569938cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AhJFMcH+imY+eGvaqFOizAbPT6NkaBsKQeV4IkXXHU9Jui5tDXYEFqJ26PVR?=
 =?us-ascii?Q?PoLUKIq9qWI6kM+tvupLbsebtsT8yqOhzfGtoKmdp/UQZhk9siten9bPVF85?=
 =?us-ascii?Q?A7Jsk+JTBwHUl8TrsOgCC9ILQH29C0TCqK3dAYi83/GhH5QSPaeHbIJReJEB?=
 =?us-ascii?Q?ku/Ko4AUpNVj4lt07QKhhD/WHvZPUPQwN4Ncuv+GM2BSvpf5QLJwQV+i5TnM?=
 =?us-ascii?Q?vliuC8D1fX4ZxJdt3m+mn8yHWyNiJH54zQiA8iRzwuQa5DoUbxso9OHdz+Al?=
 =?us-ascii?Q?Z1SEoGDvnZvhE/pvDaxL+RaSiT2JTIoH/md0SGhXZqaQS2TLTcHwchk/NlqE?=
 =?us-ascii?Q?x/No9oTChURfCD3LCYb2isHRIceaEfEqjzvSJPNDmbOBfxHHHnqt9INfi+A3?=
 =?us-ascii?Q?wAuORlq4+GgqIoF103P3FVZ/jolwN8Ituf7wrN+F5WO0nXzDjFWETkt0o+5J?=
 =?us-ascii?Q?jIOpO/yKzriXdjhgzaiQqFR+PS5Dy3pryd0AsJouTYfoNtFLbma18AgCQrtF?=
 =?us-ascii?Q?sjgpoCGocSBz1ic6stZTKv2WKo73H1MUE+r/j2fQGuFrR+JPVqrYep2sY1Vs?=
 =?us-ascii?Q?5gLBlZDP92b1A8pjCQptdT+kfqOdhR186RJuVWIyeznil8AlcZLZui0/QYWY?=
 =?us-ascii?Q?Dd4vOuQ74v62o0OaeQTrLjKoQNdTQUQQwU4bnZJl5zoasOIGB7erw0pInFJ8?=
 =?us-ascii?Q?aKg6c8NC+57738nk/ow/3l78cbvH3OZpurUY1yzv6jLSAIUBBNRdf3udvalB?=
 =?us-ascii?Q?wYPTGrydvT/TL3nc5rxPM/U2cb+wSmQwl3dcI2MPsvzAeKBARgvEfYRDl61l?=
 =?us-ascii?Q?vAfacBwAlBZiy39FR8pm8lO5pqgisihuUa/orfsjNFIzMEqAMCap4/sQoyP7?=
 =?us-ascii?Q?7gQHAoXvQu8uSN633HARqZ+JggYZBmYfWVpOE2lBjepjeKhg5oWQwi9Xghc6?=
 =?us-ascii?Q?IMzcgdD4eL0z0GEW2vsdqIlJ1qVItrectvW/HjLjsrIouI0V2bDGMsBoHRr7?=
 =?us-ascii?Q?m/7sd90d1RGbC99al9cte5waTOF9dyzB0UTJY9gijqHVfIA8FdrR1HhDNu2R?=
 =?us-ascii?Q?ORVswRbZIcghDEFNhJbDPMltsa2q0WcPI6gLnIQIjrp593LLdFARUaE511yH?=
 =?us-ascii?Q?0G4sVsxfwHg23uHRKgt/wIbPdCSc9gW45rBFGPvgTwxbYLUyClEgXAH1W/AN?=
 =?us-ascii?Q?ZwBJDbDagy7+PkVblkAZJYGU/gXhNv0FUjjNLQh1+4dlGWDU3OA6oAWHYzMZ?=
 =?us-ascii?Q?92hIME5lDspEockHh6jnzl8DpCJCdfIv6ujO0Nc0YhiOhztbYDNzIwTkupAv?=
 =?us-ascii?Q?1t1nYDYvc/tX3JLb+qb/Itgi1jsBTtaU7kaAJv0quhbSYsi5bRyRPeYzTqbz?=
 =?us-ascii?Q?3C+kB+2xDU13LxxxppLTs4wCqexO9V9vYaO4QhNuTgBehebTFKWwXMClybyG?=
 =?us-ascii?Q?ypDWEktNwa2hVeh2ZcAkIQEhTVtNyUKQIURQ4noVzRg8iIunON6QKQ/QgQAe?=
 =?us-ascii?Q?s/S6Mvi2e8BWkp4Q4zwi9o1TctEOngXmvC+w/CKKq4s+LhtouuCGSM8lJOYm?=
 =?us-ascii?Q?Br3ctw4jvs8bR2m/S+nnTQY9uQh8sV8JuKbPUJ2q9uAxvOaIEzzWA7AY0XX4?=
 =?us-ascii?Q?tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020)(18082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0cYtpIMPX8FahMFdeWMbiQ6ekLFdY8Cl15mHd5oQ79g21/yBVYi88QeprUb?=
 =?us-ascii?Q?i5mVIFGKKkhF5vvrld3i2AHgriwfnzSMtTBPtA8p5FbqKnpkHcf+oUwN9uYI?=
 =?us-ascii?Q?3oBhaX15DQcpkaf7nhNji+pUUHFY8Di9VFN7NZnZ25/50/9oMOerzbgJbft8?=
 =?us-ascii?Q?jKMDKk9v4YWTD7BXdcbp19ZJpda/l9pQxWXoFL/HPyBehx858kjfC6qQ8YNM?=
 =?us-ascii?Q?56lksjtiChl2SDdNtNDHlN9LvZsnS/9JQ0GPEihl+LFlQYeyJMnkkJ40hcVi?=
 =?us-ascii?Q?BM4cDXEQy9daRBYtt4dVRZXWf+R10/GAE7Y9Pfc1b4zbUaIn2erl6uQwkffO?=
 =?us-ascii?Q?NNcrhaWYUTlk72c1FHU+km2UJlcsC4fOaGz192TBG71MhW8NC1Fs7BrwSly2?=
 =?us-ascii?Q?h/v+uPm4hexsY79F2QsG06Ap+hcsw6d4uU4TiqkCasuZvI9mcjUpBG0Lm1Kt?=
 =?us-ascii?Q?KnUgtkOznDrkVFP2xehAgiedcTwEGUM1LMoCVOxBwVdhvAPbHAfA1JFIJe+W?=
 =?us-ascii?Q?hfRZYrC3dYMbO9LT1AXRbL1d8w6M4Ugtd6HXiNHf76MMxm5Kyim0Wx8+DPWi?=
 =?us-ascii?Q?EJjBgwLymenSZtskU/Arh2e8KljQMP0gGdjyd5yUVE4Lt5XuRrBBM2RU4w83?=
 =?us-ascii?Q?lU/HeOAmuI3IzuqHInO6Xl1JaFpuZoLaVaRAyEj0kY1NaI5dd+RAykwBUYt3?=
 =?us-ascii?Q?yFsKJ/PTjhwHW4ZP3/yHP8HmCqDOcpGNKpVD5XG0T0AfskZ7+7spDqT3YiQf?=
 =?us-ascii?Q?sHotkN0h6ELzLJ1SG/ecW7X9zIfEvpP9FzjbrDt4OlljteKcnGuiVAuO4fi+?=
 =?us-ascii?Q?MJsvgehYtaVbdNlx8p+6BO2u0sg/o4R4Rp2HcC/lM8yz4Kq21po13yXsVn6q?=
 =?us-ascii?Q?33gjFx/21YRvd7Z+d2UCwpg6CaMcto6Wgr/NPkmnaQqC4+y+Vp4sqiwxAFR0?=
 =?us-ascii?Q?KE5LYe2fjqIbv6ZM9vhjNzJte8r4/fscxzqoX9DU38rybIJQyCnsAGHtHoH4?=
 =?us-ascii?Q?ee/Pdx67r5frgN6uIxRzfPXbwYjrpd4FFd7KXbZachKLKc71QZU+LeFjC8Xi?=
 =?us-ascii?Q?e4g4zyIBtnx/GwCqQ5jBVxlSUys7pGIxw5zEmVsw9AiqmZtxJ40qRg311fzq?=
 =?us-ascii?Q?+5Lb2mDXxt8SHkLRTN7nulmrBOCjJOE/tdFAGAy9z1ghe6fElfl3hHGnP1JS?=
 =?us-ascii?Q?mym95TJSwvvh8x6OkOnD/5k0dhgn5c0d+9PzbJ8GjxhFECMYZkMSdHW3Ubia?=
 =?us-ascii?Q?HxMb8obEeL2Py/qZJCdIqZpdDsCW/WO0CbiR32d2JIGrHIXV+Uk9M3EAfSMw?=
 =?us-ascii?Q?EP2JOv9V50hl+TP+LfoL4aAvySWySGFjERjQJtFQk41HJn6ODU05pMdDr3ym?=
 =?us-ascii?Q?sVHp6nE+kDUGsi29svocndXH6Ew6OmCeR2SlMKPoc5M1HpvjkMJAYHNkMxy6?=
 =?us-ascii?Q?j4hscWJ4ormnoYwx0Qlc0I+uJqsenQO1qapBP40Ewkpro6z+Z9BkI1Xj1Q6I?=
 =?us-ascii?Q?56gcugOL7IK/oOsT1Nqv/Tt2TN3VQBdsIlMbetmuNkr2ZcycZHkLZaPazpmZ?=
 =?us-ascii?Q?/0fyaXWA3i/q8F2BUqcLZ6mddUfPnP+PifBGzHYtzuVGWlpyV5UIXhA/48AZ?=
 =?us-ascii?Q?AWxXlW6BRJ+EcA+cE79L8e0yz88zgHM/WcSgoCWh+W68EtQbSJyS/HyUAPfB?=
 =?us-ascii?Q?hDA1/0kMbpwXiwoJ0endU8Jq+K9MqqxFhMsScY0PXliuFZjDx/TaFJUj3Ur1?=
 =?us-ascii?Q?cQU1qSdqbzuIIws+bmK0fTh3JQWlYPpbyeffZUjtZoV2Y0Bh5XYC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ebca2904-09bd-4ee8-2e98-08de569938cf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:21.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANluYPIADkgQVRSKbXOWBr+J66hZDmvsbsjx+rjm3OqidfSYEC2ZguPsf6BBqrkro/O0GIIhJhHMzXCTzpPW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Some DesignWare-based endpoints integrate an eDMA engine that can be
programmed by the host via MMIO. The upcoming NTB transport remote-eDMA
backend relies on this capability, but there is currently no upstream
test coverage for the end-to-end control and data path.

Extend pci-epf-test with an optional remote eDMA test backend (built when
CONFIG_DW_EDMA is enabled).

- Reserve a spare BAR and expose a small 'pcitest_edma_info' header at
  BAR offset 0. The header carries a magic/version and describes the
  endpoint eDMA register window, per-direction linked-list (LL)
  locations and an endpoint test buffer.
- Map the eDMA registers and LL locations into that BAR using BAR
  subrange mappings (address-match inbound iATU).

To run this extra testing, two new endpoint commands are added:
  * COMMAND_REMOTE_EDMA_SETUP
  * COMMAND_REMOTE_EDMA_CHECKSUM

When the former command is received, the endpoint prepares for the
remote eDMA transfer. The CHECKSUM command is useful for Host-to-EP
transfer testing, as the endpoint side is not expected to receive the
DMA completion interrupt directly. Instead, the host asks the endpoint
to compute a CRC32 over the transferred data.

This backend is exercised by the host-side pci_endpoint_test driver via a
new UAPI flag.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 477 ++++++++++++++++++
 1 file changed, 477 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e560c3becebb..eea10bddcd2a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
@@ -33,6 +34,8 @@
 #define COMMAND_COPY			BIT(5)
 #define COMMAND_ENABLE_DOORBELL		BIT(6)
 #define COMMAND_DISABLE_DOORBELL	BIT(7)
+#define COMMAND_REMOTE_EDMA_SETUP	BIT(8)
+#define COMMAND_REMOTE_EDMA_CHECKSUM	BIT(9)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -48,6 +51,10 @@
 #define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
 #define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
 #define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
+#define STATUS_REMOTE_EDMA_SETUP_SUCCESS	BIT(14)
+#define STATUS_REMOTE_EDMA_SETUP_FAIL		BIT(15)
+#define STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS	BIT(16)
+#define STATUS_REMOTE_EDMA_CHECKSUM_FAIL	BIT(17)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -77,6 +84,9 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+
+	/* For extended tests that rely on vendor-specific features */
+	void *data;
 };
 
 struct pci_epf_test_reg {
@@ -117,6 +127,454 @@ static enum pci_barno pci_epf_test_next_free_bar(struct pci_epf_test *epf_test)
 	return bar;
 }
 
+#if IS_REACHABLE(CONFIG_DW_EDMA)
+#include <linux/dma/edma.h>
+
+#define PCITEST_EDMA_INFO_MAGIC		0x414d4445U /* 'EDMA' */
+#define PCITEST_EDMA_INFO_VERSION	0x00010000U
+#define PCITEST_EDMA_TEST_BUF_SIZE	(1024 * 1024)
+
+struct pci_epf_test_edma {
+	/* Remote eDMA test resources */
+	bool			enabled;
+	enum pci_barno		bar;
+	void			*info;
+	size_t			total_size;
+	void			*test_buf;
+	dma_addr_t		test_buf_phys;
+	size_t			test_buf_size;
+
+	/* DW eDMA specifics */
+	phys_addr_t		reg_phys;
+	size_t			reg_submap_sz;
+	unsigned long		reg_iova;
+	size_t			reg_iova_sz;
+	phys_addr_t		ll_rd_phys;
+	size_t			ll_rd_sz_aligned;
+	phys_addr_t		ll_wr_phys;
+	size_t			ll_wr_sz_aligned;
+};
+
+struct pcitest_edma_info {
+	__le32 magic;
+	__le32 version;
+
+	__le32 reg_off;
+	__le32 reg_size;
+
+	__le64 ll_rd_phys;
+	__le32 ll_rd_off;
+	__le32 ll_rd_size;
+
+	__le64 ll_wr_phys;
+	__le32 ll_wr_off;
+	__le32 ll_wr_size;
+
+	__le64 test_buf_phys;
+	__le32 test_buf_size;
+};
+
+static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
+					 enum pci_barno barno)
+{
+	struct pci_epf_test_edma *edma = test->data;
+
+	if (!edma)
+		return false;
+
+	return barno == edma->bar;
+}
+
+static void pci_epf_test_clear_submaps(struct pci_epf_bar *bar)
+{
+	kfree(bar->submap);
+	bar->submap = NULL;
+	bar->num_submap = 0;
+}
+
+static int pci_epf_test_add_submap(struct pci_epf_bar *bar, phys_addr_t phys,
+				   size_t size)
+{
+	struct pci_epf_bar_submap *submap, *new;
+
+	new = krealloc_array(bar->submap, bar->num_submap + 1, sizeof(*new),
+			     GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	bar->submap = new;
+	submap = &bar->submap[bar->num_submap];
+	submap->phys_addr = phys;
+	submap->size = size;
+	bar->num_submap++;
+
+	return 0;
+}
+
+static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
+{
+	struct pci_epf_test_edma *edma = test->data;
+	struct pci_epf *epf = test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = epc->dev.parent;
+	struct iommu_domain *dom;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+
+	if (!edma)
+		return;
+
+	barno = edma->bar;
+	if (barno == NO_BAR)
+		return;
+
+	bar = &epf->bar[barno];
+
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom && edma->reg_iova_sz) {
+		iommu_unmap(dom, edma->reg_iova, edma->reg_iova_sz);
+		edma->reg_iova = 0;
+		edma->reg_iova_sz = 0;
+	}
+
+	if (edma->test_buf) {
+		dma_free_coherent(dev, edma->test_buf_size,
+				  edma->test_buf,
+				  edma->test_buf_phys);
+		edma->test_buf = NULL;
+		edma->test_buf_phys = 0;
+		edma->test_buf_size = 0;
+	}
+
+	if (edma->info) {
+		pci_epf_free_space(epf, edma->info, barno, PRIMARY_INTERFACE);
+		edma->info = NULL;
+	}
+
+	pci_epf_test_clear_submaps(bar);
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, bar);
+
+	edma->bar = NO_BAR;
+	edma->enabled = false;
+}
+
+static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
+{
+	const struct pci_epc_features *epc_features = test->epc_features;
+	struct pci_epf_test_edma *edma;
+	struct pci_epf *epf = test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pcitest_edma_info *info;
+	struct device *dev = epc->dev.parent;
+	struct dw_edma_region region;
+	struct iommu_domain *dom;
+	size_t reg_sz_aligned, ll_rd_sz_aligned, ll_wr_sz_aligned;
+	phys_addr_t phys, ll_rd_phys, ll_wr_phys;
+	size_t ll_rd_size, ll_wr_size;
+	resource_size_t reg_size;
+	unsigned long iova;
+	size_t off, size;
+	int ret;
+
+	if (!test->dma_chan_tx || !test->dma_chan_rx)
+		return -ENODEV;
+
+	edma = devm_kzalloc(&epf->dev, sizeof(*edma), GFP_KERNEL);
+	if (!edma)
+		return -ENOMEM;
+	test->data = edma;
+
+	edma->bar = pci_epf_test_next_free_bar(test);
+	if (edma->bar == NO_BAR) {
+		dev_err(&epf->dev, "No spare BAR for remote eDMA (remote eDMA disabled)\n");
+		ret = -ENOSPC;
+		goto err;
+	}
+
+	ret = dw_edma_get_reg_window(epc, &edma->reg_phys, &reg_size);
+	if (ret) {
+		dev_err(dev, "failed to get edma reg window: %d\n", ret);
+		goto err;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom) {
+		phys = edma->reg_phys & PAGE_MASK;
+		size = PAGE_ALIGN(reg_size + edma->reg_phys - phys);
+		iova = phys;
+
+		ret = iommu_map(dom, iova, phys, size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO,
+				GFP_KERNEL);
+		if (ret) {
+			dev_err(dev, "failed to direct map eDMA reg: %d\n", ret);
+			goto err;
+		}
+		edma->reg_iova = iova;
+		edma->reg_iova_sz = size;
+	}
+
+	/* Get LL location addresses and sizes */
+	ret = dw_edma_chan_get_ll_region(test->dma_chan_rx, &region);
+	if (ret) {
+		dev_err(dev, "failed to get edma ll region for rx: %d\n", ret);
+		goto err;
+	}
+	ll_rd_phys = region.paddr;
+	ll_rd_size = region.sz;
+
+	ret = dw_edma_chan_get_ll_region(test->dma_chan_tx, &region);
+	if (ret) {
+		dev_err(dev, "failed to get edma ll region for tx: %d\n", ret);
+		goto err;
+	}
+	ll_wr_phys = region.paddr;
+	ll_wr_size = region.sz;
+
+	edma->test_buf_size = PCITEST_EDMA_TEST_BUF_SIZE;
+	edma->test_buf = dma_alloc_coherent(dev, edma->test_buf_size,
+					    &edma->test_buf_phys, GFP_KERNEL);
+	if (!edma->test_buf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	reg_sz_aligned = PAGE_ALIGN(reg_size);
+	ll_rd_sz_aligned = PAGE_ALIGN(ll_rd_size);
+	ll_wr_sz_aligned = PAGE_ALIGN(ll_wr_size);
+	edma->total_size = PAGE_SIZE + reg_sz_aligned + ll_rd_sz_aligned +
+			   ll_wr_sz_aligned;
+	size = roundup_pow_of_two(edma->total_size);
+
+	info = pci_epf_alloc_space(epf, size, edma->bar,
+				   epc_features, PRIMARY_INTERFACE);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memset(info, 0, size);
+
+	off = PAGE_SIZE;
+	info->magic = cpu_to_le32(PCITEST_EDMA_INFO_MAGIC);
+	info->version = cpu_to_le32(PCITEST_EDMA_INFO_VERSION);
+
+	info->reg_off = cpu_to_le32(off);
+	info->reg_size = cpu_to_le32(reg_size);
+	off += reg_sz_aligned;
+
+	info->ll_rd_phys = cpu_to_le64(ll_rd_phys);
+	info->ll_rd_off = cpu_to_le32(off);
+	info->ll_rd_size = cpu_to_le32(ll_rd_size);
+	off += ll_rd_sz_aligned;
+
+	info->ll_wr_phys = cpu_to_le64(ll_wr_phys);
+	info->ll_wr_off = cpu_to_le32(off);
+	info->ll_wr_size = cpu_to_le32(ll_wr_size);
+	off += ll_wr_sz_aligned;
+
+	info->test_buf_phys = cpu_to_le64(edma->test_buf_phys);
+	info->test_buf_size = cpu_to_le32(edma->test_buf_size);
+
+	edma->info = info;
+	edma->reg_submap_sz = reg_sz_aligned;
+	edma->ll_rd_phys = ll_rd_phys;
+	edma->ll_wr_phys = ll_wr_phys;
+	edma->ll_rd_sz_aligned = ll_rd_sz_aligned;
+	edma->ll_wr_sz_aligned = ll_wr_sz_aligned;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+			      &epf->bar[edma->bar]);
+	if (ret) {
+		dev_err(dev,
+			"failed to init BAR%d for remote eDMA: %d\n",
+			edma->bar, ret);
+		goto err;
+	}
+	dev_info(dev, "BAR%d initialized for remote eDMA\n", edma->bar);
+
+	return 0;
+
+err:
+	pci_epf_test_clean_remote_edma(test);
+	devm_kfree(&epf->dev, edma);
+	test->data = NULL;
+	return ret;
+}
+
+static int pci_epf_test_map_remote_edma(struct pci_epf_test *test)
+{
+	struct pci_epf_test_edma *edma = test->data;
+	struct pcitest_edma_info *info;
+	struct pci_epf *epf = test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	struct device *dev = epc->dev.parent;
+	int ret;
+
+	if (!edma)
+		return -ENODEV;
+
+	info = edma->info;
+	barno = edma->bar;
+
+	if (barno == NO_BAR)
+		return -ENOSPC;
+	if (!info || !edma->test_buf)
+		return -ENODEV;
+
+	bar = &epf->bar[barno];
+	pci_epf_test_clear_submaps(bar);
+
+	ret = pci_epf_test_add_submap(bar, bar->phys_addr, PAGE_SIZE);
+	if (ret)
+		return ret;
+
+	ret = pci_epf_test_add_submap(bar, edma->reg_phys, edma->reg_submap_sz);
+	if (ret)
+		goto err_submap;
+
+	ret = pci_epf_test_add_submap(bar, edma->ll_rd_phys,
+				      edma->ll_rd_sz_aligned);
+	if (ret)
+		goto err_submap;
+
+	ret = pci_epf_test_add_submap(bar, edma->ll_wr_phys,
+				      edma->ll_wr_sz_aligned);
+	if (ret)
+		goto err_submap;
+
+	if (bar->size > edma->total_size) {
+		ret = pci_epf_test_add_submap(bar, 0,
+					      bar->size - edma->total_size);
+		if (ret)
+			goto err_submap;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
+	if (ret) {
+		dev_err(dev, "failed to map BAR%d: %d\n", barno, ret);
+		goto err_submap;
+	}
+
+	/*
+	 * Endpoint-local interrupts must be ignored even if the host fails to
+	 * mask them.
+	 */
+	ret = dw_edma_chan_irq_config(test->dma_chan_tx, DW_EDMA_CH_IRQ_REMOTE);
+	if (ret) {
+		dev_err(dev, "failed to set irq mode for tx channel: %d\n",
+			ret);
+		goto err_bar;
+	}
+	ret = dw_edma_chan_irq_config(test->dma_chan_rx, DW_EDMA_CH_IRQ_REMOTE);
+	if (ret) {
+		dev_err(dev, "failed to set irq mode for rx channel: %d\n",
+			ret);
+		goto err_bar;
+	}
+
+	return 0;
+err_bar:
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[barno]);
+err_submap:
+	pci_epf_test_clear_submaps(bar);
+	return ret;
+}
+
+static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
+					   struct pci_epf_test_reg *reg)
+{
+	struct pci_epf_test_edma *edma = epf_test->data;
+	size_t size = le32_to_cpu(reg->size);
+	void *buf;
+	int ret;
+
+	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
+		reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
+		return;
+	}
+
+	buf = edma->test_buf;
+
+	if (!edma->enabled) {
+		/* NB. Currently DW eDMA is the only supported backend */
+		ret = pci_epf_test_map_remote_edma(epf_test);
+		if (ret) {
+			WRITE_ONCE(reg->status,
+				   cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL));
+			return;
+		}
+		edma->enabled = true;
+	}
+
+	/* Populate the test buffer with random data */
+	get_random_bytes(buf, size);
+	reg->checksum = cpu_to_le32(crc32_le(~0, buf, size));
+
+	WRITE_ONCE(reg->status, cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_SUCCESS));
+}
+
+static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
+					      struct pci_epf_test_reg *reg)
+{
+	struct pci_epf_test_edma *edma = epf_test->data;
+	u32 status = le32_to_cpu(reg->status);
+	size_t size;
+	void *addr;
+	u32 crc32;
+
+	size = le32_to_cpu(reg->size);
+	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
+		status |= STATUS_REMOTE_EDMA_CHECKSUM_FAIL;
+		reg->status = cpu_to_le32(status);
+		return;
+	}
+
+	addr = edma->test_buf;
+	crc32 = crc32_le(~0, addr, size);
+	status |= STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS;
+
+	reg->checksum = cpu_to_le32(crc32);
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
+{
+	dw_edma_chan_irq_config(chan, DW_EDMA_CH_IRQ_DEFAULT);
+}
+#else
+static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
+					 enum pci_barno barno)
+{
+	return false;
+}
+
+static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
+{
+}
+
+static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
+{
+	return -EOPNOTSUPP;
+}
+
+static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
+					   struct pci_epf_test_reg *reg)
+{
+	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
+}
+
+static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
+					      struct pci_epf_test_reg *reg)
+{
+	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_CHECKSUM_FAIL);
+}
+
+static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
+{
+}
+#endif
+
 static void pci_epf_test_dma_callback(void *param)
 {
 	struct pci_epf_test *epf_test = param;
@@ -168,6 +626,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
+	pci_epf_test_reset_dma_chan(chan);
+
 	if (epf_test->dma_private) {
 		sconf.direction = dir;
 		if (dir == DMA_MEM_TO_DEV)
@@ -870,6 +1330,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_disable_doorbell(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_REMOTE_EDMA_SETUP:
+		pci_epf_test_remote_edma_setup(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_REMOTE_EDMA_CHECKSUM:
+		pci_epf_test_remote_edma_checksum(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -961,6 +1429,10 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	if (ret)
 		epf_test->dma_supported = false;
 
+	ret = pci_epf_test_init_remote_edma(epf_test);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "Remote eDMA setup failed\n");
+
 	if (epf->vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
 		if (ret) {
@@ -1007,6 +1479,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
+	pci_epf_test_clean_remote_edma(epf_test);
 	pci_epf_test_clean_dma_chan(epf_test);
 	pci_epf_test_clear_bar(epf);
 }
@@ -1076,6 +1549,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == test_reg_bar)
 			continue;
 
+		if (pci_epf_test_bar_is_reserved(epf_test, bar))
+			continue;
+
 		if (epc_features->bar[bar].type == BAR_FIXED)
 			test_reg_size = epc_features->bar[bar].fixed_size;
 		else
@@ -1146,6 +1622,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	if (epc->init_complete) {
+		pci_epf_test_clean_remote_edma(epf_test);
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
-- 
2.51.0


