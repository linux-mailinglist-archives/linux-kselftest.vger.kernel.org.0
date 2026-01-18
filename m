Return-Path: <linux-kselftest+bounces-49285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1FD396C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECE6309B75A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB733E373;
	Sun, 18 Jan 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lPg7Yxnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102F33B6DA;
	Sun, 18 Jan 2026 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744534; cv=fail; b=qVWm8nmdX8zE7S80CJkdl4fd71NrIQaqyjUap/M9pKN9mriQmU15zh41nGfObvI2vf5w7pVLmFkhUtM/+CPdeCJwJ7oQT7JEJgpvJzj1bSvjQLsHms3TRuXzmuCkD9k65QT0qadE1A+xriQypm2JFZKJXa2nPyO6wN0YB5j7elc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744534; c=relaxed/simple;
	bh=yOgg90bn+TbyK+EkOgU6sgdcXqycSB3wkAswnG18YrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUS2/cX0hKjbW7eMKp5qYAnE4f8DhniuJ+DFNF5g/FejUVlDU8WiWAddp32kSRJBWU6gvfSu03lMdgFpLUtW7h5CIrqVIgh+qw5JT+NIZQgntCMjisK95yPhO0J256YcfJyj+V8Opl/VYj5Sro2z702WIBaXRlpIlcUmEEQQaa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lPg7Yxnx; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLOZd/kkuoIPCxdozL534tDAaiziT471W9hlHNnxgIQ1xXqS1zRVjBXkmib9/1XVUpLXJs85kyJ9n3wTZVdzNLe1qtNXj06+KGJPp+IzJCtkBilNIAM1hi2gYPZbjL+6fOfrl+sMgdazj/UJh+Domw6qMFjnpQpMTKVX+xl+hZ9H0R+7l5NJjuZJ5CoDzqemvzuWxauaORnC4Eu/zuaYjnaJlXYVHynltWs+7TeW97aoQG5FncBRGESdd3jUCzJ5fhELcc1Kc7USTYSUAx+eDIUsWBIGldY2/iMJo1Ltd0ybb0fKBLCuIOhIlehkUw7Rqomtm0gF2Bn6x2OnjWFSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPI+aEiG+02KSiVUSxI06CQ1pW3rO8Rq2croOS4o0e0=;
 b=qS1/ZxNgRPCHbNZCHc7O+umGycF0sialXRMl/bNvboTW7iUYZb/dmpY1QAwFjwKtPItm4G0ONc2GKYRdn0olTDEIVHqunbrZhQQHwr4h77KIbLjrPGWAXyEHFex+K6h091XKhyNMbCZMPBvbe/bJYVosl4W3WNYJggxfdb44R4HVRtVHaVgPSzTvZSQVpNW1YxgRPy9ndRIhqJAFYwIb3RkHQP/zpQtvrFPAVMXc+BKfzF1K9f8tdv1XUZCMiIVbLuZqeqqxqNSxYfJlCWzvfTrw9eNwUKZlYGNWr8E1alP5GK6gphXu3EAyBu/PXkdyQ00/mXOyDLHXIU7NQ7gOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPI+aEiG+02KSiVUSxI06CQ1pW3rO8Rq2croOS4o0e0=;
 b=lPg7YxnxDubwcZBMJy9dRlzJ8/KlfOzdm+vvDrXFlnGxsGR97gAKhQI01TvanWoDroxoSMiIr+a/CTLIe9QyX/UNx1kRiFDd6p+mNGLRB1+3S02/dZIN4uOS1rSmmDi1p9qNrytDyIG6j35UqyhsDe1IIHF7suh/KetG9Rc6KAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:12 +0000
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
Subject: [RFC PATCH v4 24/38] NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
Date: Sun, 18 Jan 2026 22:54:26 +0900
Message-ID: <20260118135440.1958279-25-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: a85bb668-09ae-42dd-4b3e-08de56993329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBlK2djq2RmOhkDHD3pyUVdRCRwraffekNsOQLZHJQBpGTx7k9ZGIlW1LpqH?=
 =?us-ascii?Q?q07EITLi8uAx2UpBZUCoG4Zw3xw4qvDOYXTLAYD7JqCA7xf0tvsJv6lzUA89?=
 =?us-ascii?Q?b7TL585Lk6civDry5SgAEcbB/9W5DA6sWxYG6Ca0kfUPiLd/D8Rw84BoqMUN?=
 =?us-ascii?Q?bAu9BRj/G/UQgS07H6u5vJ68Hx9A0OToCKcA7F303VH3V8vl3vrWm76USJun?=
 =?us-ascii?Q?gMCIZuDvAyUEuDUHqUs0kvAO4Ig7iosTZr+if2Q7X5nYPtqi8YWXktaqLW6b?=
 =?us-ascii?Q?2KJ9oLyASTT5cU41t8HHZzv8Lvh9cLEIv7GvIVhVEUb9jXpUprjOUKb6D3dn?=
 =?us-ascii?Q?d3aKVsH27JWaEPhjc6Pn+hDDCkiEGfg/qjUbUsAlAt7njzLyImytGgbvgnZV?=
 =?us-ascii?Q?wgwcsHcl5QMmz28bmejS1f3TFo1575m11bhxDAkGQ4MBUiEjabznDM5pjW4S?=
 =?us-ascii?Q?OPuhRHH487vVgLTAxi96tiJ0VeqKSnpSZTAi1GuINN+HfV/3cMWdHYG70NxI?=
 =?us-ascii?Q?jTsil+fW4ZS6K+g5B9iWkY46MtxTQJMZtX4FVVELgBrSCGctW5nUcGZZzUXO?=
 =?us-ascii?Q?7R14LAq2174va6pphVTf1MsjMZpqwQYG4/ErNPb7/UUWGWsun7Abb+J6j+9M?=
 =?us-ascii?Q?ZTUSysogy8FK5zcWh4OuY4QJXTN+uQN10SsDV+BgVMnVfI0YZkCt7f7uFV34?=
 =?us-ascii?Q?1qj8LWrLHUKt+JgigQAum7xdgb7OWCxu7l8ywVthoJICGlwwKUrQfJe03kJT?=
 =?us-ascii?Q?YDcE3OleGWn/swWfTCOEryBA8BN5f8yAX0c1BSukbjFncJTszC1pEzJCCbba?=
 =?us-ascii?Q?lyVEFDkv2R66KNVM80xCY/I2/IgdlWccQOSvQxXCtMVmln90zNYeqaMWl+iT?=
 =?us-ascii?Q?FBtPwMtqilhHPulMr/jWgw+JsEVLhV9jhkA8fl0QcqmnSwJFWjHCsODRk6Xg?=
 =?us-ascii?Q?q86c6iWXY4CWybaGvjxNj2FPDHqV+JR1IZT13wbnkt642x2EJe3a7zHr7wgQ?=
 =?us-ascii?Q?JpUcXb4zoo/2bK6AnUVkZ2wpstHTojV3E7GqTmDHz1LnxzAh+JuQyluOBof4?=
 =?us-ascii?Q?Km6zYSBgCWXnxDt9MY5iGJleDTpLbjiAe8UzgBTJn53aneNNaQ1yH+12UU+7?=
 =?us-ascii?Q?fXZhtfAbw0P3F8fGNGXMVGWCbxECvIDh2oyR4kKdTRxgJojqjt7KxwcJZetF?=
 =?us-ascii?Q?7qWxYsmFr9n8pE6LkR40mxDXa4uKTRBChxEbQnTZoNekBORac39G48R4+fwF?=
 =?us-ascii?Q?aKz7lkpRx6PcIh+ydB2hDzrAkB3H2dLMcfmyXpQ2p/TOu9JS192PLviwU3qr?=
 =?us-ascii?Q?hrtLehdeR4cJsfhxd6jBh2utxWI4TIJkfbfTe4V7XIEtsgsDrCh3Ng4+uapp?=
 =?us-ascii?Q?CcUxOoBQ29z2F51tyl7bPbm8kapOGK/vBtvSZGzPS6RYguHu/jmj+/1mhkjD?=
 =?us-ascii?Q?dDgdifozRALC74aNYAdm7QHZVi6Ie3bkBuQc9HF1AVX40f0UFajlCqr+Jzqe?=
 =?us-ascii?Q?9W2DInD8jm43KvLTdwHB3qsfO+OeG3WD9a0GkstGvWTdQz2ZoWFsSiLuE0Co?=
 =?us-ascii?Q?R0LWqjBMrulWvNP/x5p8hxbMMQqv5t3QXtetVBOwhAWw1JEmF7e0mJeOYOrI?=
 =?us-ascii?Q?eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WC3sl1ujWLaKCMyj0oHLl6gXOgz020b7/he7x59lvMH7VPqKtwaB4ifpqIRs?=
 =?us-ascii?Q?TaTnVPB4rcCnnUapPrr7KbhR+2byhtT3ylQEh0n0G+s5PWicMSS7JVnR5zad?=
 =?us-ascii?Q?2NyMbwLpvvCF96DyG60s8YWwJWdPD7tWTcVsxHispBe1Ptwv36YpV/xwZjmj?=
 =?us-ascii?Q?84UsKwUKKHzHhQPlFkGvUA1PQ0cRzgBP27EemO+mpjHiTlMrKK5p5VE2p/At?=
 =?us-ascii?Q?wpVAp7V6uuTSJHdl5t06RRdpeEzDf+qadSE0vvhHMQTMHWrKJyrLFDXzWKfO?=
 =?us-ascii?Q?9UuFrwFfvgJCClM0x0sCmbMaiUje/gf6TBOtYK+e0NoehYJrehh7MdASxOop?=
 =?us-ascii?Q?/gvrz9YDPojjDracZ/ewiUOjuhctAWgaBDZnu2/26KAs7YhOycXyGkCrIekH?=
 =?us-ascii?Q?1fmSawiPVea7eMNd4s+6rpsyFMWaC/jQ/ckUF/UZDL5414Vez2f5NmbBFFET?=
 =?us-ascii?Q?Rcc4tRU/pFjsxH0zwMTAqDPynnMQvDx3aLgWFEnjd78FRr9pNlduDqoOS0h5?=
 =?us-ascii?Q?4GSujNPPI+LjS+oxWHvahzZ6SCef63Ble1SQ6vMftOU+XwLWnKKjmVuIgqTi?=
 =?us-ascii?Q?7DgbuEouZrMH4sn2ypZpV9reE/8vHTVnarDnc4se5SsZjx3HwntNyO30mT/F?=
 =?us-ascii?Q?4ns3P3NfSJ8qBoBj5F9zpZIbUFbvcmxRES+pX2eEn5HGXivjrm4PCbwyS7pf?=
 =?us-ascii?Q?xhlJPsa+KFOGaHZNEE1advhJH5BrQsuNeWlZvGqmmJ/hhpAVvisEtDGw83Da?=
 =?us-ascii?Q?Ym52RBgR1zbQRzZRxPZkQDPIYkrCo6emHnIVZu8G3QXB8f4+IAsBJYy8bgsD?=
 =?us-ascii?Q?U3jbbV7dlaZ1FR7J8KwJLVgl5bUcdyFH0yVJwJLZTl3ny5Y3/OaprRwDipjB?=
 =?us-ascii?Q?WlhqLIOs+DYnFluqTZ4LhxdXfT1zXEqRzBxn7xBVl1lFbl/qvSsbaiRL6NYK?=
 =?us-ascii?Q?bEg4c+GOu4cH9RTbgSilzNhuBveV0V7i3RTipXFfbH0gVnDijw5OVrH0Zltj?=
 =?us-ascii?Q?1S6CCTHQ1tsz9u38x2EFqRhi9T3nEX+NUDEKyX/2983pWh4QCW0S96NUnlPa?=
 =?us-ascii?Q?HVxg63MjG28fl1jXUntOTQ1QHoAsv57K5spKQq2uendaNCY6bFYwnat5A0Gk?=
 =?us-ascii?Q?vg/Xg+zxBpmCM6McrDk9Q1WZmuF5goW9X+qjnmm3nXHhoRiZ3coDG33UdLK0?=
 =?us-ascii?Q?FH8aJjabPnSTbREleRUc8HYprdVuwT3nXhtFJXap7HHIeXaLSQ3SXu4beOQz?=
 =?us-ascii?Q?mVIRjGsHb7e51QqHu606Fp0BF2shYctbKxonnPyLl1gVWMQF3NObtEodHEy6?=
 =?us-ascii?Q?t7lpBbUGb3PGPSLyXNsRZzAN4sxZq1GV0ESHa1qPgFwn26lOd9duHAmnBBaV?=
 =?us-ascii?Q?1n1BzaDmptHl1LgK7ByKHeNwB75wKeq40KRkmjVE3cvzpokby1F4YGoM97+M?=
 =?us-ascii?Q?o8+echj+woPeSUuJBtgIQZCXVlZ9nnEHtCV2NWIvAI/4gvmLLSn2ObPUDda2?=
 =?us-ascii?Q?ZwxVVtF2QkATUlxmVAi4BIs7WTCi9Kn22kQ9Al1WolMjkLpatasG6+pu5Joj?=
 =?us-ascii?Q?xEBaCh1qYQI/7+F8yKQoKkf5Yf5xs3ILfrdvub2xsTHv+In72r9wSBtXk3iT?=
 =?us-ascii?Q?ac1iLCUxED2Ppy6NBT+b5dJQ0ws080i1RCmZ4CiM7uU6Mem4RVg+e0mBaK7J?=
 =?us-ascii?Q?kAkA0U3k2K5lPw9VaLAyeOqML9OKQMk1MazeHU55SCzuNI0aHuut/gVfgYA2?=
 =?us-ascii?Q?dl3RW3oC8KApqwOBTZ25ELDc2lzODWv6hqlyPjkK7c1AchiMr7K1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a85bb668-09ae-42dd-4b3e-08de56993329
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:12.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G1Q2K07jYdU+kMAvZQHLRDBa1ujWtIPZx5nlMNrpwaUoYEfc2dLkLbjzivFBFihjV2vwxoE4+o7fBIijTukXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Some backends may need to program BAR subrange mappings, and due to
pci_epc_set_bar() submap API constraint, the entire BAR layout needs to
be provided when calling the function. Since one MW that is to be
programmed by ntb_set_mw() can be the last piece that allows us to call
pci_epc_set_bar() for the BAR, calling it only after link-up can race
with post-link-up setup on the host.

Invoke ntb_set_mw() before the link-up handshake so the MW translation
is established early and the post-link-up setup can run without relying
on late MW programming. Since ntb_set_mw() can re-setup the MW when it
turns out that the size differs, it's safe to do so.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index 2129fa7a22d8..185d73f8ea93 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -977,6 +977,10 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 		spad = MW0_SZ_LOW + (i * 2);
 		ntb_peer_spad_write(ndev, PIDX, spad, lower_32_bits(size));
+
+		rc = ntb_set_mw(nt, i, size);
+		if (rc)
+			goto out;
 	}
 
 	ntb_peer_spad_write(ndev, PIDX, NUM_MWS, nt->mw_count);
@@ -1032,6 +1036,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 		dev_dbg(&pdev->dev, "Remote MW%d size = %#llx\n", i, val64);
 
+		/* If it turns out that the size differs, reconfigure it */
 		rc = ntb_set_mw(nt, i, val64);
 		if (rc)
 			goto out1;
-- 
2.51.0


