Return-Path: <linux-kselftest+bounces-49287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B3D39641
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286D8307CED3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC033E37B;
	Sun, 18 Jan 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MFvYz1Kr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B333B6FD;
	Sun, 18 Jan 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744536; cv=fail; b=oiLiNhDrInPWpyWEPYOVXzUxazpJWBgIC19x3gICqU7W/158PaJ+jDiu3C53nLdFbQ3imPUN/ckp8raUmnQdc9AGvq7hVXXfpMYAZdR90HkY0SBVBwWaO43S3DqvGLBLaI0dyAOJyA57hg4oyTJOPDQMeannTho0VDU/c/pEuu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744536; c=relaxed/simple;
	bh=kwTj+cC1ImylTysqkQBARjqHnqBFbS+W0TRtQJoBON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8B6R/xVVTml+RD3RRJUQoILJq+RHKG8uEr2+FoxT8ULHh1J/9tp6VqtCWGjtBXf08vmQkmxZNt2WqHtteB6EKjKLnbr8k80vZvaT6u4xweUtNpeOsa8xrDFNScUDTruaxas6aViMwpuExzQL9WUqKjB0A3gAxAMDl3r3R/juYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MFvYz1Kr; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR2UKhGPzC0gMB/JHNC6TKaGnNYjgRXn76/uGQAEKidzF7rOI4HsitsDOLaapVH4AtAy/U4AYvII+kMaULXpRjDUwfk0NjBjMpladbSaR8sKlaFMX7kJCfbfJ3WyIM/BuOv/cXMSfdXH8ZEgf0+3HzVuPmo7ohDWuoc5P6eZSpNPOpelA9GzeAEMgUkp4jREEkCjaJgKLUIaGRVzuGr0SwnappytSZ1MWd4GretxWKlG/TG87Zr5BJ4X4JcfEi/zFEeJVGWFONcHaL2WqPbwkB2Sd4wxiImlOJl4re8l/YjvwGf8VEm9E/XXKbfD4kedXHRQX36S1jSObNcFIxXAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opAz+LXhmx1PYsHGKzojBw1JU4OeCZF78pzymrm8Q+w=;
 b=Ew6VjBTMXSavvyD5NAHmTiYZZUB+Zio/VqQJe/EB+1P9pOKo70AzLl6Kw6+CBdRe4ijIXbTXCFiL0z5mQan76z+sDOOH4cuG/NXvd9+91SGoGmWODkNc0i+zm1sZjfSZx+9TPBpAlqkFH5O0aG8ZrqaXmg3V2zuGGaCDRVOfFAcy9R28Zxjyfcg+UzIaf+CrPEVNgXzUjHN0n4Ee1IJK0wIDQLYBxXcy8CavbyqazsvprTPj91wsYUb27e7r0V40g4GZJDWP0VDQUj+eVpIT/pAx5RDJO092jCwV428gVN/NcDstz3aEu8ctBhMBA+4WIj4NwOJyo3ELc2w4nGRixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opAz+LXhmx1PYsHGKzojBw1JU4OeCZF78pzymrm8Q+w=;
 b=MFvYz1KrL3xT0yi/ysz7y3nrMbnzNNqdQJfy0cj9W5pEqLmiHAu2g8oyQXamTgof62JXhiIs9vSHb5bTuNxO8hnhcocZ568ycQvkP0SkbbVlZS4GkiYM3GSkikrTlXDb1LF5z7VmBmIbS96blfOHnVnq7oIIburyO+nqpppY4xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:06 +0000
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
Subject: [RFC PATCH v4 17/38] NTB: ntb_transport: Dynamically determine qp count
Date: Sun, 18 Jan 2026 22:54:19 +0900
Message-ID: <20260118135440.1958279-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 71651e2f-516c-4ada-d8c7-08de56992f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9AcFuN2gCDMs6EcWCEtIkG9zXH/d4pexT5CzZ9KyUQ7Q/R4wigWzk8L7LpYv?=
 =?us-ascii?Q?Wdx0/LUgxAtwihzrTOAZQLz0E5/2IGekFhibE9T/64hzt9iPejvQ+IvVYhCJ?=
 =?us-ascii?Q?/XQOzCOHcQfbQRrsI5ICjItM8uxC6g25c+tSZxYeRReEG4eT6l8vGh1cZILB?=
 =?us-ascii?Q?iIaq0I78wldmEMsAdmaA8nJd5SrNYFFOyGfsUxLGa3/OuzY9vvzx1rIgF8IR?=
 =?us-ascii?Q?dR7V/5t1kdLehUsYcM1BZvQkX8BNIvH4oFghZCWwNUUSmWw4V1Zynpsh1bbx?=
 =?us-ascii?Q?imt8MxHg99b74cW+W5Zmr9SjbpO7JAzRXBSKhQAESnNcPyFTL/yDHcgJjrOs?=
 =?us-ascii?Q?DtSYZaWcnyL7kbOVH2iGEpxqH9szZfDe+RsYh5eIctdUAQe+OQfKbskZTmj9?=
 =?us-ascii?Q?MiHBr62+y3pw6eZrIqq87qUaVbC9bezlJYlZsxQ1a8SL1gMCSKEkIHLbm/ao?=
 =?us-ascii?Q?oHsDbyxf1s177V43jZUJFD8Qh6CdDj74TAch/z/OgE4/HQRCPeJZf8dsRgcF?=
 =?us-ascii?Q?v4sr+yaxQ4cKcsuUB8ZBZvomwzQZlJx3fojas/r3Suo9kSsmXJjWyqYTr7dL?=
 =?us-ascii?Q?I/gSpupGuGDQaNPfuVsUf0UAfL07TlwuiaLbK1NYIa0ZRLVSTwkeerFw9vIJ?=
 =?us-ascii?Q?vJD6jEaAp3uGQsYt2JlaR9wTm2zf6ym8MKKKwMVOs2QvXOiNc7U0xbOhC5Wi?=
 =?us-ascii?Q?JS/P+BIj72b0HYTBxfW8gq3WWqobAVUMPoRFDWeEAcUvVzXDL6A4m4pKsCYh?=
 =?us-ascii?Q?/8TOmrlYDBZ9TM5QEjSvAs123sd+SfwuhbAE8WKwSyEgm+gaky9JpszYZDLX?=
 =?us-ascii?Q?qGlvEuE+diV09oaB4qKB6a52PIcrWbObiM9mgZk0Rivf2ekgllA/4na4WuSK?=
 =?us-ascii?Q?WhtBWXt0OApCX5CnapN534MwdZLXRnmZo96WgdaQHkS9Vlr9c0ncGkqkNO1s?=
 =?us-ascii?Q?3KJuDYKk2jeXIjCpUODOvso8OlJWVAGZbvxlZtUhzDyfZ42hgbgzGqimcn1y?=
 =?us-ascii?Q?+lfG56IeLrqu6BNZMx+8/BNlBpOYPFJETyNOEb6BcA11sw3qsRveeDPcTQ/7?=
 =?us-ascii?Q?XoBEVozBwKNQuncbfH1c3D8hgL+4TK2awwHT6zzPu7WqK/dixdr7ijilwae3?=
 =?us-ascii?Q?x0JzixHOcnGX0NUhMQXZh7t3Cf8cCuO2icDMQ2AjOL5RqoU0iAoE3geu5cWA?=
 =?us-ascii?Q?Nbrx11phMOhbVV0huxCvmW2NYsZkbcnIaRBobzdhAzkvqgXZ+nSHRtNy5umq?=
 =?us-ascii?Q?L2PHAHftpRXyR+riaFth+utRIWGSBAvyTYTLr7VuFP4+JxtZcibOO3qYEb6v?=
 =?us-ascii?Q?XlPI+/nJ8ptCeUEk6wuyAYzBlvTCn1gdj1hfwmRgoGO1kpTAftLySbEDcH4Y?=
 =?us-ascii?Q?0pwzvEr0SzIPohj9v1lbNv2eARkfsi5DKb47UoX01IpuB2zPmlkY7gAIDpLE?=
 =?us-ascii?Q?PUurN7K9y7wnkjXIlyI+161Fuo3++NVkH7Ns07PNBikxVh9WEFjD1G8Ownzb?=
 =?us-ascii?Q?T4NHLRunjvr3CWsHwJSLxiL4JTC4fUsSvoiwlH6pyfS2q1uaNsANJowCHJ6C?=
 =?us-ascii?Q?tJmRPS7yO7pZSA8+hVggiguqodnzgFHTw9vkIXm79/evvvmzod0eMp3Zdq1P?=
 =?us-ascii?Q?oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTdvvSBN3GjkY5ub4S/hd0HVerrzWoSI38adzTmMcwoXBm/JtsoKHMY03K1v?=
 =?us-ascii?Q?+4bZopFUzwtVMbiN0p1uqcUe1XYWIfmrmT//B1YzlGCFdo2mTAWkeZgkT4ex?=
 =?us-ascii?Q?1koGZy1GKP/yNfzFe4y6pnucE64XankT6u7e0ngoS2pUDaLGwf2/MClyTsEE?=
 =?us-ascii?Q?xmXVMMKfusZvYsPB3JJ/M3q/4TNO7fvyIy9QoXgi4Sni/eTGp1PY5U+ic8QL?=
 =?us-ascii?Q?Ve10jN1Egh8+z9K2Rd2nVXgugyhAWcfRsP1VUQckmaEznXkIy75hcQN0OZna?=
 =?us-ascii?Q?48QPzM4Rtal04QgNJVUeHnFabz+k+z8JiYwMSrxevkAnEgcWfLnAAyqk7ayZ?=
 =?us-ascii?Q?iVj60jrHBuSMeQA4yG6AsSJlm8bOFMW0M905yobAfTojblnSzfHAftz85sox?=
 =?us-ascii?Q?uY/AXaRtEaigGfwXriv6MFeUzV8m8rFiXbNroL1S9du4x4EEzpdchfW00WQi?=
 =?us-ascii?Q?5M87Pap6IJ53xrFcVcRqDgMcjWbRQyGAiQ9jvNiD3fjx7HX0ghZX2fCoq0lI?=
 =?us-ascii?Q?CbAsnzSlTwgUmJB6TvSDKhNBj3juvaBlzj2mFSS195NbInlMAJzA950Kd+Fd?=
 =?us-ascii?Q?fH+aPFYqXfloKsful6ySUJwE0cO7+EdNbdTAQK8S1TZdiRe7nsn2qN9rIdhV?=
 =?us-ascii?Q?N2m2mvU3Ell/hnq4o5i95kxq/QL1QGweJAjO7BSB7KfXXtTX74XfaqZaLd1e?=
 =?us-ascii?Q?uxAK+hrcFkadoPzCsaWl5TXsEJCXxtsGXH+++vcUiQWgGCLOV7TS7RS9rIbT?=
 =?us-ascii?Q?FIIAFfx5Chl4gykDaI7bsi8SqkMotBS/rVlTAnW/4X25fw1y3gk/j+VOj8Em?=
 =?us-ascii?Q?x2FCfTP1Tg3vjj1msC8RMwy+QB5yodJqMggGZ1o5cgZEI/qNYND+l8tMlWW3?=
 =?us-ascii?Q?STMEmzatgIsNntMDPtU7XeoCiizE/nhI3bdxmUP8i147NLfyu9BUGnmIpo48?=
 =?us-ascii?Q?+bTuW7jilYVJ3jI4caNBp3CY5E665QOrb5RD5NT/QP6z7BSiYV5gBmD/Zj+r?=
 =?us-ascii?Q?LX5kGzKuE8IykZoYm3GEWkbSErOl2+zSeNYz2w6r0cdNSk8HbzQSRgH1AB1O?=
 =?us-ascii?Q?mU9CCsxcZ1BLBLWjUGcwUIF0A0ljehDMJjLfr+LVJUmRl6wPwyZ8PcTngb92?=
 =?us-ascii?Q?yTFMzRO3YZnH3Um9u98TGsXPoC+fjlPyaREu2acK+k9qL+oC1fxMN3LIaDQO?=
 =?us-ascii?Q?kt9TRlX3a6xzabVakvTTKUaxul8cE0drG4wBaoM/6NoOIwgGRA/v3otqSBXF?=
 =?us-ascii?Q?WjONlgG+KL+mST40ZAmKmp6LHwTbVuISvK1obz/oZK3TAX/5V/Y19EAmv50E?=
 =?us-ascii?Q?uH5jJ/hf6/Ro0wvJSrcfjbqn5bvdOEnZe8kAaRJLjrWLiluNbiFLFyazSaZW?=
 =?us-ascii?Q?kt9bImb/YocKRSSwIeSVylCJgHsHtFmIY2v5nF4pSOrrNpUeX6CSf5IXAD+O?=
 =?us-ascii?Q?qpA5e5vdUADxRxMxLf9Y5Yo0MopltIzOs60jKGRuY5SwCKK5kQAyxMlaH2Oh?=
 =?us-ascii?Q?bGiTKWhx1HVsP+HhxuPyrbFB7gvyzBpI+r2hnhLcR0RSQb2okKnN2Yq0VL/N?=
 =?us-ascii?Q?aXIPNj95sjNPvzn9RdL3FZUqbrp/UYhX0icWKuQZmrAIHeIFGirg6YFNcVyr?=
 =?us-ascii?Q?ZEqYtKmco8QBYUqXy7mqktwEoVUPpeVTLsDWYAPL0N4RKi4j7647BPKpZ7a6?=
 =?us-ascii?Q?ET1E8q5YGC8+z4cLzaZLWl+nhHvxb1lCDFzWMPu9PQvUfglno8Fnr/kh+BZP?=
 =?us-ascii?Q?QWIPxHc2B32ACC1KhfYE6FLwfpmYoi6Z/OcMywH3dhmy8Qnsj06b?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 71651e2f-516c-4ada-d8c7-08de56992f89
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:06.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxnWWCPxuOwOtzqdh3CaedBqKHPyB80gswPr9qPhP0UFM6wmHdrA2BtfUDMKVcgYnogkv6gh9yPGCx9MWqzN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

One MW can host multiple queue pairs, so stop limiting qp_count to the
number of MWs.

Now that both TX and RX MW sizing are done in the same place, the MW
layout is derived from a single code path on both host and endpoint, so
the layout cannot diverge between the two sides.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 57a21f2daac6..6ed680d0470f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1022,7 +1022,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 		container_of(work, struct ntb_transport_ctx, link_work.work);
 	struct ntb_dev *ndev = nt->ndev;
 	struct pci_dev *pdev = ndev->pdev;
+	struct ntb_transport_qp *qp;
 	resource_size_t size;
+	u64 qp_bitmap_free;
 	u32 val;
 	int rc = 0, i, spad;
 
@@ -1070,8 +1072,28 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(ndev, NUM_QPS);
 	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
-	if (val != nt->qp_count)
+	if (val == 0) {
 		goto out;
+	} else if (val < nt->qp_count) {
+		/*
+		 * Clamp local qp_count to peer-advertised NUM_QPS to avoid
+		 * mismatched queues.
+		 */
+		qp_bitmap_free = nt->qp_bitmap_free;
+		for (i = val; i < nt->qp_count; i++) {
+			qp = &nt->qp_vec[i];
+			ntb_transport_free_queue(qp);
+			debugfs_remove_recursive(qp->debugfs_dir);
+
+			/* Do not expose the queue any longer */
+			nt->qp_bitmap &= ~BIT_ULL(i);
+			nt->qp_bitmap_free &= ~BIT_ULL(i);
+		}
+		dev_warn(&pdev->dev,
+			 "Local number of qps is reduced: %d->%d (%#llx->%#llx)\n",
+			 nt->qp_count, val, qp_bitmap_free, nt->qp_bitmap_free);
+		nt->qp_count = val;
+	}
 
 	val = ntb_spad_read(ndev, NUM_MWS);
 	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
@@ -1300,8 +1322,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	if (max_num_clients && max_num_clients < qp_count)
 		qp_count = max_num_clients;
-	else if (nt->mw_count < qp_count)
-		qp_count = nt->mw_count;
 
 	qp_bitmap &= BIT_ULL(qp_count) - 1;
 
-- 
2.51.0


