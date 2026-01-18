Return-Path: <linux-kselftest+bounces-49296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C14D39691
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B9030BCC37
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019135503F;
	Sun, 18 Jan 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pgYFtkcf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1032ABC1;
	Sun, 18 Jan 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744558; cv=fail; b=hX8zdOf1z9jh/RF080dhL9A6Zdkwt3yLmNj6zDIosSWj5ChkRRr+ljzijOtDKLwYNOBnEiiB5EzrFpf8krCEv5JlCL4k7XIRwfQ+6+fWlpRBvEhuHd3lE3Tx0iZNURhK8XtiCggRQeNGZPBlB3ZcSUS8MW3qoEgE5KNTeT0DuyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744558; c=relaxed/simple;
	bh=cZ2JJkfKFpXl/G0PAJ10K0P1Awpv3h068rBss1hejWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFv8JqrHGCAJQkfdCy/uz6E7kJWGqc/hQpCG7A9ONq3QNpib5lVWGuwRZWsZv2lSWKmzRFn1qWP9wnuOa/D8YlqQu+Y5QFY1st52Uhti1XcXTn6gPDhC10QwwCbBto6sY9Q1ROa7d4Od0yrngMF3II5GrPn5CGtTBMbjUUVMndI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pgYFtkcf; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqpo2yALyw6nB1C7MYozanfSPfx7iCzvb8+nhZrSAyy3wZpZm1KKlWnT7KbCxbsfv1uUQ4QqGc2oavXZeKuxlZHAnV5cX5dmyHx4Cwus800L596PhIAUYLP4Oj413rgcTLX7fDnWfj9pBJJlW8WnJIkC0Ji2Pq6LCmpikDLB58LYuIs8OcCXnEpi7sMAat01XX93yq2g7RsaC/cq34uLJ9/rHoPftc0MTePuEmSrYBFhhcSNe22Opn0mLZDFuDJpZmD3Bnl7n93R90heFcKvEmbNKVOeWK+ISn7o9HgMCJx1hoIn2Q85yGQDTZo6i/flIqDbUFBamZoZijcJOPI9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPQC6GKHCO0g1ghaGvFsv/Elck1FNfi9IH8YOyIzrP0=;
 b=N2dqAH/65EjbGnIDqNMyEr5Mf/yo12OoIyE2D9NrzRPTXxLE9woCrKPuRKIRoPCdtzZVKXFOp339UOzQXswZm/7Hhy05DAg/TYoOkLJFSvg8jOxIHxplId90Uo+uxF/R6oOBxp+cajE7iycIoYFpAG+pGhE67F/TDmD3vwdHaXJPJk7VBEJpGQDV/MsLIoALo29nj8O4zFzZ66Uhz/wQMykvy8f5Q3xn/zJZ9PYN/a2Br8JsqHlRgFEavRytwA3ocTkRLFnilG9zuhIF/a1j4KrUpirl0vABKphLC4t7ZNeqblUjPa0mCfJnMugTvT/bqAVZqHeNeV/O0gFxqDR8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPQC6GKHCO0g1ghaGvFsv/Elck1FNfi9IH8YOyIzrP0=;
 b=pgYFtkcfyGJ203hz1BmfT/vfXL9kshAl6M3y0uXA7I7cw4VA9VYA+dONoq6n7QOUovsdT/PZmdN8I3RxHszIGkfLi23vTlXFVT7qsukSifEb7DiCTfzq2sBpdb2pldwUpG8wJPNFmb7mzkXZylkdt7rd4xj/QmElN+mY6I76lpk=
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
Subject: [RFC PATCH v4 32/38] NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car
Date: Sun, 18 Jan 2026 22:54:34 +0900
Message-ID: <20260118135440.1958279-33-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0091.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: e71d1154-427b-4810-cc71-08de569936e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5PcQXJUgJajNPYBUEwwVsdlXq1zLwvoftsERsW5E2eQjP9S0SvtaxNoPT+Z?=
 =?us-ascii?Q?+GQYF9DEdVWSkxdwr2D6mpwJOe4MNc869Cei06apELljhp3FDQBh0/n4Hl0T?=
 =?us-ascii?Q?nX/MrYck8V2eroBx8cj4wluBiwBJQ41EgeHw+a7IMJiEU2tVPP6yY8dy/KtN?=
 =?us-ascii?Q?7nU/CCXs4q1t/TcvERaQsSNfQIsodbwRmTBH9JYZufja8PN89uSWvSEwa0xS?=
 =?us-ascii?Q?uaKWzDWc+aeFkunz6jmdb+HbDKng1MMNMdDcH8HEvHUc14wqN4lyhFNhCS1g?=
 =?us-ascii?Q?rq5JwvxScD7FS1e9yF2pFE71GtLs6I+/OPcTH+8tCKDXKijiaeZ92zt49Hc/?=
 =?us-ascii?Q?6ujQTJykcgUU/3IthcRNg5uAEiyaYoNiRwsCAauU1jDe8cohKFQdDrT+5afH?=
 =?us-ascii?Q?B6D3jlchoyMXeae9tr4V16vXPdOQ+yV4NkYIVRcYMJtIf+UnQOFb64Lj4mOk?=
 =?us-ascii?Q?XibHzciIRbAA8ocJ9qwMImdrE1a7qilNJ+zELJvgt1F8FgelWWa2uZUbyP2l?=
 =?us-ascii?Q?N32PKltwHy7T8CtDVcw/slkbNryT/EzweHdwT5sjgbp5RClQeGdMWQoLO05x?=
 =?us-ascii?Q?4FXeGbjXjdvmC3JJoqVi6kkUsfAgaUUOokf2jIWNHSKj/njRl4+bitpvT9qJ?=
 =?us-ascii?Q?geS4Ar++tZ2PRLpTynmR4IxTuN7ifvJ+jnxiaY+BI5fpLg/fBU7MglmQZDzj?=
 =?us-ascii?Q?Utylmk7RIHEA1jCTv57L8VRjlCl2ek/G4DdXIMMeUn6cMjmi/j3Qv147Y6pz?=
 =?us-ascii?Q?oIBcvfd5Mpj3uKJ403uf1gx2MPZ3GdpYslHfgnpUscQPYb2wLEN7V/MczyDP?=
 =?us-ascii?Q?Xp1TocCIdnM5DqqnPHx7bwfl3WKN2AyI1qRZcQlnoe7zHB9sH/CRvjd9nhPa?=
 =?us-ascii?Q?F6pb3/gw3ypsDqUgKbfJf9N2anl5CsyvcpJ4m0Gt4SZigbm20PjzLTMalmpD?=
 =?us-ascii?Q?os3I4RPNAdAWstn+tMQdNq3XY0mKEgblFP0waS8ZkNCYJqXiCQ2lcImHvDsh?=
 =?us-ascii?Q?zQtFyI2psfKHeA6SVvMLYbEouUteA7paHieE2FIE5CEYulIJJDqrEFIrt1q1?=
 =?us-ascii?Q?KwDaM/OsJnyLDEQzXLotfHp6oiF2l4MUAjKskwNWx+eKwWvSSSCc+t9Z41I1?=
 =?us-ascii?Q?9HzUqz2sejm3iWdyZougzNQZSKqe7zRXaDGsWveDanDzwD5S8En0eOQ20rNH?=
 =?us-ascii?Q?2EI6a9gawowkcU6afTuOgj1gkOE5g7Ow3E+a1kCiM3XU1vDnkxFzp2OVdX7K?=
 =?us-ascii?Q?5k68bzs87DreahLielySMNpB4PbUYOKTa0PrpJm3lTykf7cDgUj8zK0OigcG?=
 =?us-ascii?Q?8e/MW5NoucYnWYjCZKR7rh7/hD5PBufhTR9zD7kWeXX3lL1CiP7YKlHoUekL?=
 =?us-ascii?Q?/oFYxfXWvX/OJCl1yZCxwwMV8ybu+U5o2icNN601boQIwl3DKFL/Bt27i3jJ?=
 =?us-ascii?Q?pTit/i04bHqvCFlaBTvI1c0dsB5Q0Va3Wa+i2BuGzbpVNKtm5pZ2T9OLXSqt?=
 =?us-ascii?Q?jKuqEs3wQwTtwSs9/a4hCJi/a9+CiHBn1BwKty+ZVzZ95JHgDvg2Yv9Gh4RW?=
 =?us-ascii?Q?8Khc4nhelRvYmf+1QVqdwhhrve0KP+CkvpqikCYgSdaJpdA4xySjPq30yJpu?=
 =?us-ascii?Q?hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRV2HiZzXKSUg1accKBC8Dn9UTLlK5j5WxK2qCxhpsvvD8UZ9X5t4NvSLNJ3?=
 =?us-ascii?Q?pKRkcV73ooCAjbK953tV2ndPDCCm5y7UeFU3TyuyfcNEIB3bTq2ozDhmECtq?=
 =?us-ascii?Q?sR/7s0sh2Gurr57z6KUdE34ji46f3a6FSg73VC0hz9WXX5SSFJW5+Bmat3SC?=
 =?us-ascii?Q?Km2mkhc1I8vMk8ZRjdUwMWzKlxyi+KcF5e1TwB9C83HmnCdI4sKMkPs6ZQHF?=
 =?us-ascii?Q?HDFYVTO36eQNGgJvMxLXeIbswyWUScJUlhjumkQYXve2XbFoBBRq/xVF6HjU?=
 =?us-ascii?Q?8SB/lKLkF6dnkfrqseOFK/HC+RRZb4tf0VPrNArOn4330aypbhc5BxR6KkOJ?=
 =?us-ascii?Q?fcOdKByB18XiWF7nkQrNP5e+kkHiCtO+3YqK0T3lwEwKq4Mzqa8lJnIBBSCK?=
 =?us-ascii?Q?6FL3q1sFXjkKAk7s9WQqFdZeo5OxthZ383dkRRkIRKp7YdesD0qhafy0lr1w?=
 =?us-ascii?Q?pacN7IU7CHXcAdKOo0UxH9+PRWXaaSVPtFegkugFfEQh4ZKh6kxUIVtk+LK6?=
 =?us-ascii?Q?CbOKodMCHv1pfF+Xqq1lu1pfSLGgxMxvwTAjahATbIbUw/wGVYwwW3G4SUya?=
 =?us-ascii?Q?sL5wZaZg2tyWsKsbCGXfAahGEIUkO5KKEJbasDZE6sDeXXXsgz5FhJ7yDhRp?=
 =?us-ascii?Q?lSMqRlkv+27Vc6SqVhOWe6whCq/MudPHGExGBezxznYYi/Afq1DigBr8RyRC?=
 =?us-ascii?Q?2SUpRdxEVGobxZI5nJS3VUHxFQ2LChCGj3eyeihNZldeBRyzkce/3D1Qp1Ue?=
 =?us-ascii?Q?ID7Ou52jvG9Zk+RuhZWJJSDH8qBqsMGuh4/l4JnP3wc/+ddxUdY7rDYfSmwJ?=
 =?us-ascii?Q?7lxDy800rYyWv/cs+NuVLxz7Xmzq0Ey6EOIpO2dz4taQsSPj1IIIfjFQU1I7?=
 =?us-ascii?Q?9iJfdQ2EuuaVfCU6TPN/i7i58z+laF6FcPup2ecyXl6Jq7/u9w/tDGggjsvI?=
 =?us-ascii?Q?0SuDtgqH6m97QLTK8TXNfnFuKCWHZBkqAUfbRU5U+PMdHuusUX+CZG56S8qc?=
 =?us-ascii?Q?W84rEAyPTDPVIGwsVkzPgYFsnh2VmThi+q25itQznUDIg4+2XpcdP6KmGBIY?=
 =?us-ascii?Q?5bna4qdoU14A5yhWlYjviCE1gH9cem+mj2eyH/uKwfR/tcZBw5LZRAUGXqXR?=
 =?us-ascii?Q?1U2OHRktQBjh25fk4Nn4uyVRNSg/xLiG9c9ovORuI3dnjknlTV7RtFZWHP/e?=
 =?us-ascii?Q?Jdk73/kP9iLTeShe8gBdcPzS1yHKXr/Oxi8R0YE3bu+hokrAU6hN8w9jL1W4?=
 =?us-ascii?Q?EsoJsdUGdkduBNgcp2vv+uzbePgjRzfYKbfkV3YU+i9Vj0VxXcPgrVjTbQJk?=
 =?us-ascii?Q?11tIkuyPF8MmmzIk5/al/LtVJ4PWZ+DLW65nIW2MtpTkIOvi54Ft8NwzFvrC?=
 =?us-ascii?Q?FFvjkmh9Osg5XxD8mQ50X2+mRT3weSW9t+Hw/10o5jRo/zE+GxpSDaEHgd+C?=
 =?us-ascii?Q?fkWi9IufB2d5QcP+B8glwOMnyDtsA+hWnuromGYzgiQpB9/3zfbVb0W7PL0T?=
 =?us-ascii?Q?nwvxBAcT3pR6MjAswRIll1RMfhYa5Egt17CqyTRqnB2HUGZFukxAGkQhQaEz?=
 =?us-ascii?Q?+do1U/ZFqCFUJTPZMIM7APfatBcdRaRZuSiv3/8AKMgTeRTrzabzbJK9Ttma?=
 =?us-ascii?Q?MIxrv4ITG+RDrI37n609I5m8UQMkBRHUhALHh8DM7fUAJw/C3T00fL/Ysh7y?=
 =?us-ascii?Q?hRb2q3apw8TpLlabtZv/PwX0kRb6uVnV+sH/KAoEGeFgE5IzcWoT1aqPGrqq?=
 =?us-ascii?Q?DWwC3QcLlBjeTcuvF5/9D0R3DuvLD1uI/GZNtIhmbT7HozhccQ7O?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e71d1154-427b-4810-cc71-08de569936e3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:18.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ody4ayLFw+6bf8zx3C7APHx3wEE/ySi5/fK6+3tsM63RYTVHarMUhXB3VKUlYBmz/5BxAsMD+rdAwgVC0pa8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

To enable remote eDMA mode on NTB transport, one additional memory
window is required. Since a single BAR can now be split into multiple
memory windows, add MW2 to BAR2 on R-Car.

For pci_epf_vntb configfs settings, users who want to use MW2 (e.g. to
enable remote eDMA mode for NTB transport as mentioned above) may
configure as follows:

  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
  $ echo 0x20000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 2cefe46d2520..007c93e34398 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -843,7 +843,7 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_PEER_SPAD]	= BAR_0,
 	[BAR_DB]	= BAR_4,
 	[BAR_MW1]	= BAR_2,
-	[BAR_MW2]	= NO_BAR,
+	[BAR_MW2]	= BAR_2,
 	[BAR_MW3]	= NO_BAR,
 	[BAR_MW4]	= NO_BAR,
 };
-- 
2.51.0


