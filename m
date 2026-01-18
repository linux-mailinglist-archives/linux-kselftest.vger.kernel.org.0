Return-Path: <linux-kselftest+bounces-49282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F5D3964F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48A513087783
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD733438D;
	Sun, 18 Jan 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZAzBlEJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103B33985D;
	Sun, 18 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744529; cv=fail; b=rLd+0/FQhhm5K9w3W5h8+MhoAWmy0Z3+12VdAe0MEtueaBSEMSLltmoLcI/IbmxS0fdOBXUQxObWvc2CrHJqbEcAtGcuxPRRSDPy4Y2p2Fpe+nl0qVcNsj9826PLnYN5K/vETVud36HGU2zy3QunO+Ny4jFnZ2OMBmtul9mN1E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744529; c=relaxed/simple;
	bh=eHGcYnWMpcWNmyGmtbJ/eO054IqGulp9YUAaUu1nVys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8UYuc+uL6tXo3jUY0Jsu0Mey2D7AFgf7iNQVNQdeeFg+RMOtOjR2eEZiF6fNY8s4jW7SuvROMY2030peulasx7tZAT2RsqODSxVRUCf7vGw/XP2AHVPJmJW6e3TvWRSkEuLgw28mz6nBuVObM8ejnygbaDaL0LYMpV8nIPqBU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZAzBlEJp; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnYQZv/mYk63FYVqWqKEsIp4wX0skGUkJZHSqhLu9YzSIBDPXbka1+cCEvbhMrzssv52465Om0JKXsL4+jbK97F5JJbYo+a6qhpqpHFOnPQfEDT0VQ1c4gtoREXPWGoqg7iaiAo0BRmP6AMWrgv7xUrLF8xemLaUFfiK5AdTN+Jfxhq5j3qAPQyZEZOel/StJmXznYfSBPCJeVyWCUBgu9O/nDtIKfpT7f1EQO+mQa25tm7Hq5hfOL07QvePRMIiIghLDKrIdD18F5pDDxRqa4P7OvIeYhe99LmOVR+/LFOZR9zbbAQGn+kypR23VDcHsKtHheK6Qhmi48uo41M64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bLtGOX8Lun2IgVbLvWj4aDug4JHPUcxjdb61TUfzUo=;
 b=VFC6ATrLSe67pzpA+uGcyxM+7NKR3xPehPHnxPqFGmUctqpS4RnfEJKamnrpzgwsIF+phiPq8O3iQ3tHCBepSX/8Rejttuy4HKnDN1YsYcCPArhSv548am5o3GY/nlo7RAFZcQXiFQBln1JfzJvYW9TThY/FaqFCiw10gZVf9afoApypMYJ3HgbXvUFA74J4utyt90FgLEuP/2sutUbNyJW5/9QJOTYYYWGlp83upoJPwmXQyG4BFYry/U6eUd/BsGylMc6G+RkWqfyjc78YHekkMqds6KQ7UWsKo+nZlk053PJSrenqhcnL7DfQq7TWE7Ik5VfiZswuZPfuUwdYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bLtGOX8Lun2IgVbLvWj4aDug4JHPUcxjdb61TUfzUo=;
 b=ZAzBlEJp0wE/ut5ZJL5+DW9SfN9Zpj6flLTotVEO0/Mfb3QqV0hU/dlp+jbBimFQNZwiTFN6K2OHxjm+/HyDvBK9uCji0Nb6MhamZ2DK5ii2F9pDH6jpp2JDi17RaBKE+P3ot8IMc2pQbA8FvmmtZLde9rraQjpKKCEUfa2/86w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:03 +0000
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
Subject: [RFC PATCH v4 14/38] PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
Date: Sun, 18 Jan 2026 22:54:16 +0900
Message-ID: <20260118135440.1958279-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0200.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 47380bdd-fe32-47b0-f3f6-08de56992e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cWdCnXNB2WIuqV54k7xcdPWoa8BmYKR4NKJX+SiBpmeCeBagappl2JDvMC4B?=
 =?us-ascii?Q?riDovuHZDCOyV9f/XN7xSJgY08k7g2mYT6SIsGjpLyxo8Fwy/yFjQF4uvGch?=
 =?us-ascii?Q?OpV8jSklbnJVFqw/JsEVj2XpGC6gxTOHpAPb1wuwGl/4qcMI28pwDpATGJ5M?=
 =?us-ascii?Q?T7qelHxjGXuemUPsi1I+Kvp5lNGbbNGzgqCpbgXPI/Kjs3QRzLv7IOwriZ/X?=
 =?us-ascii?Q?FilG8aMlmS73RoUqhHcv75o7bj98oWIQ+h/4gFmZhztbo/UN37ov5BSJZSX/?=
 =?us-ascii?Q?Qsi4en3s4HQPbczwQ9tq/q1q20YOw4A8uTNUmY7HzIYUSHuo9L2kXBfrCqVu?=
 =?us-ascii?Q?eausAm5hxQINj+acxeQMYRsN/yxJEeEUENGf698vZfGd1QVzPjFMNcLKyhQS?=
 =?us-ascii?Q?6SQ3JCmXrplkmiCEamOsanzJCHOFlUjZrbHJQF44j+Rp0/S9SpQgdelOrXBA?=
 =?us-ascii?Q?Qvaaaoqm0QvcKiP31bpsqfa8JEyizVMm/xpUTsCxG0VSrb7XPDcBr9itlEAl?=
 =?us-ascii?Q?HVIUcABrYv9znlSn5fs/gRp3r1IT8VhDzV6td8ZgQT3eX7QTtAKYDPFpL1Nl?=
 =?us-ascii?Q?RvfNgJPx5CsfDVoRNdvWnUv3w5woZLK6Jvl0IP5nlCPuiRZMkwwSbca5zE22?=
 =?us-ascii?Q?3BOcPGE2+q8l2r+PIHk5F99w7zY7YrVSsRnSsQRJp4HMUoLlHadfT6P9OI95?=
 =?us-ascii?Q?+yC4SXQ6asu50uC4KkIXf+zm5RV5JXURVI640dYoIdpTIxk8o22rtsituWXX?=
 =?us-ascii?Q?0CDbxXIjmnyE/f5gX3Rq8S/Fvz/WxN/reLIuMa0VeuiFZ44xoQZ62GlB5ePX?=
 =?us-ascii?Q?Qt5at2vp+owsT1a+0t38ebJStw0PEg37wqL333TOyuN9yWmAHp0W6OsZ0svk?=
 =?us-ascii?Q?yvZAWdWeoukU5fZQGzFenYBtTRkl6vruHi1k0t6OGAaD7UozLkMVtrB0afEy?=
 =?us-ascii?Q?HAspFNk3V8zQ8mu+7vXMU1VECn1Tqzgndp3d8kQriLJqBsqm5bMFONRFUMNa?=
 =?us-ascii?Q?wQvOGZkJEdOSdBXoiliqdngBYvYZfkSNaSaSVvjT/a1pDPcvfqKSokkjV5Z2?=
 =?us-ascii?Q?WbBJreliWfMbEGmo3nRV7Y497PgHjIISn/WZe0mys8hIX5Jk0jeDpeuXnaE4?=
 =?us-ascii?Q?VWmuwCxald8Txmm3u9KQJnmylPJ6eDBp26p5dfrvHksnBf1mqhboIfowYoLJ?=
 =?us-ascii?Q?2mqHAL/KfgO9qZuPmysvHcR1bz0+Lt9cllgPZ3Y4OOKEibKgqNezfyaBc2+2?=
 =?us-ascii?Q?UKbDa6V8ewxrT23cXqtmBZk12vshXqIK35UzRhfdvVn53xw0bMNQcQ+Mxjv+?=
 =?us-ascii?Q?t40GwEEnO3x7idEfwAQ00EYIq6kq3Q+r8IaDJSLGAQKqc6zXIe+Gf/R3s8mj?=
 =?us-ascii?Q?HFYl7rLKuYXQ8lPip56/uU8PxhNAbFFED6FogcieMj6uFwAIHKezWrO6Kh6d?=
 =?us-ascii?Q?V+pyRqXa08mZCJLRHPcl+uKtMUClowRGRJXl2da55yl7lrNDNJd6h6otrroD?=
 =?us-ascii?Q?94Q4ndNem7LnoAr3kCC3gp706ce+Kw6GX34tg/xjfZpNUPxCUSnaW51anraE?=
 =?us-ascii?Q?oyQgEFhvP1cdcf/WlVJ1zAA4FSO6hWMIm3IgQZUS5Nxj8DekV07Bos1vRJDM?=
 =?us-ascii?Q?tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ySeIfLgUKlbiEBtL3IA4P4PaVZsszhDMO3gBmGfdtF9XZ+aJ/1QJYNvEbutY?=
 =?us-ascii?Q?yvU11eYQ91xui9CIxspDeuxq0YBgy8k1hrdo8xCk5ReiFCEel2EasnoBxvVN?=
 =?us-ascii?Q?bd4cgVjlSelf+AHYYf5X713GrP0utHlbvi5/IWohhWoyEoTZlAygE8JhEYij?=
 =?us-ascii?Q?38aIza5GTqMlNpg7GKHDtZ6HtI7IvQfpkEXrE4u2B4KXlZSNDN6n00SRVLmQ?=
 =?us-ascii?Q?fRZHtDAFvXn9uC/KA9y+QGCrAieGWuiGJsQkUY5wh2LMGeoJ0yqDPchPNx3B?=
 =?us-ascii?Q?7m6i+zuHwuVDEve8G4s52YW1pgGaYVG/CH/pOWrQ0yCZTZcY9zF+urDDjz4c?=
 =?us-ascii?Q?h5Y8sGABszpoVdt6ve4OJRneh+4IhTg+y2D2hxtjMiSblyLwCAXbMU2wqHq4?=
 =?us-ascii?Q?WgC8Msg6TSb7nFZQV9mUbqHKqVl1bdv//GK8mcwf/IMIgrpUNqO4x2SpJG6a?=
 =?us-ascii?Q?8gt60sw7AHCc5mJzzo3WZ7RhBQ8UiD30aQ0/I6oAXVQY3zzBJxCMz4U/38Xh?=
 =?us-ascii?Q?bemFzI/y+8yGMZet2bpa/NS5VQ4as90Hy87hS33pUCx6uO3ydZdGbLjm/IuD?=
 =?us-ascii?Q?mzQtj0ztKgbryvxvp3akaEfJ4xgz0dDGhRvKTfb1ra9oImW51HJjYMEeefT6?=
 =?us-ascii?Q?H+lAtI6GwJ3uxNgsEuio7VhEkb9te+rHmgMZw5OLJ2tanNrYsmPrYJuu8dk9?=
 =?us-ascii?Q?OzIldMYdNW7NCGrjYroXuBYl2w5TqbvKg/N2jXm21WT6BJY1fiXD78WCNGsR?=
 =?us-ascii?Q?mVAgW8EA/QdoBtg+kfhhYqB2sgSPem/tz1gdH9tWbRipnYVRc8ztYqp2zFHR?=
 =?us-ascii?Q?cQzZdh3D6qWToAoVJbHh4jV32W4KGPcZWFObWlFQF8Q7qIVadE3SqbRwnViB?=
 =?us-ascii?Q?NXHM4MPXJTFi7Ge9zfdPuJAH+gUe/oWfpC+C2zXEOoVedCdGCApPiufKaEna?=
 =?us-ascii?Q?0mrJc7UAPul2W7n42AhmVfYaleRuZKAtrQvvSNSKMdSzFw/FNENmvyOuUjDv?=
 =?us-ascii?Q?K1r+G4ExPHmC2SVK5bHP1on+isr2PBdEF6oLOjasY2gBd5z7D04LIFWNOmNL?=
 =?us-ascii?Q?3N79woLFouRP+L1pMaI1J2roh9kF49Z2oZPp43ugItxxqhcXS/kaU0J1UfJ/?=
 =?us-ascii?Q?jctYnqzqunIanEaTyA4pU86+3zY+GPo6jYQrhR6Ck8fS0zsGcg7i4IfGlJqy?=
 =?us-ascii?Q?8WisSqilAZxOuxezf+n0gW4KcjwzMO4+nQ0bpNkI/bpxp3eUtxOcbOadim+5?=
 =?us-ascii?Q?NoA1rtm4Zk0BTsp8x4+pZ3PqFeBeou4lws8vuBGG082iCRRNDmFnQwMnPkG7?=
 =?us-ascii?Q?o2HPCxmqXKnesC6S5zfeFr9D+vqS0ZJ5sS/Pv9aOo9ivPzcrq+3MRuWC42cc?=
 =?us-ascii?Q?u0C6sHzaA+A2GNZpg2VojPPsgce3YsMDdzXfwIlSW06anHSpBZBMDy1Rwpmu?=
 =?us-ascii?Q?0pwcnw5ztpCurRGnM4/J+A4wsLTenwuWh4BoQ5H/sKEGr5ndzJb2zM0oSuy2?=
 =?us-ascii?Q?nUBvSOAvpOhZA3bc9Gj2McEd35hjl1hx25daQyP9IlGurnNK1gom0tr0O09M?=
 =?us-ascii?Q?TjYSnAIABEQ3miciiZDuttmril1MbMVl9PaBzx3yfNjSDwB1mNhTXONDQZ6q?=
 =?us-ascii?Q?OXLjbFPGyHkx3kbhPBe3tHt0X9nIDfVVNN5zB8USGdq9Na1d5QUzQbmNnn2+?=
 =?us-ascii?Q?ZvlBYMzQXC2L+gn6LMOJX5yrcVWRIStRc5pK5mpc5CXfEsMvE586YXCl9d3n?=
 =?us-ascii?Q?9LZyePcBkOR6NdIPSCVFJCszz/64XUJHIrT5hF0/9yg8YT7MWYDg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 47380bdd-fe32-47b0-f3f6-08de56992e22
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:03.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRPBkqQOMrWax/nZ4IeEwpBq1XU9anoV4HrfPCIeK9WIg9wlVcK6obRgU2JOCgeP3m4YHeAbkqVXVnCRZcd7Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Implement the new get_private_data() operation for the EPF vNTB driver
to expose its associated EPC device to NTB subsystems.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 98128c2c5079..9fbc27000f77 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1747,6 +1747,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static void *vntb_epf_get_private_data(struct ntb_dev *ndev)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (!ntb || !ntb->epf)
+		return NULL;
+	return ntb->epf->epc;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
 	.mw_count		= vntb_epf_mw_count,
 	.spad_count		= vntb_epf_spad_count,
@@ -1771,6 +1780,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_private_data	= vntb_epf_get_private_data,
 };
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.51.0


