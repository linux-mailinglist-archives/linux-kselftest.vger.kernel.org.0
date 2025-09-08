Return-Path: <linux-kselftest+bounces-40953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D686B493A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0BC7B259A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BEC259C9A;
	Mon,  8 Sep 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gdrd/kee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2481FF603;
	Mon,  8 Sep 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345742; cv=fail; b=u5Cnue/NX/565xTc0fnwIJ0jgDcVqZxgEBcOViiKtciOqISxYgJuZ/jugHIkKzwTsm0P1P4cGnXQtI9SvDOsDOH6ddaVqsb6/jXBD69DYWg0JA5U14jLUNfAfzHQChIqya80dWP1UQgxQFj8nV0J+beGSEa82oij3Ccrcd9c3q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345742; c=relaxed/simple;
	bh=IWoK6fj2bBlNrQ3sLNPXt0cMrYKhNOrlB9BOZ1skxBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RAnlNMGsHVYF/pWTOkaV+IIi73Emnc1gLHl/WKG8jqRijgMtTT3VfrDzzmea/Y8qdcaIJtkFmPkIym6lDBY41way/ZwQYpuknckaZsCK184O5CBI0eHZeSJOvHUYD8JRx4diPnRz+L2MyqSnJF6x2njmIM7oZ5AxOqZ6oDR+UTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gdrd/kee; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVNM9p9hyGXCk6S4IfEyp6Nn+/TK+dOr3HEpPKuePNsFldxfZe8B/55j2CdxXiHcc3PmukBgijYVEG7Sj/s3t84pkt4lfmUcmoLwxzl7OrXWoErz6dG98XT5QT57gnhmgt4CQeswSONPc2V1F2otJj5mDQd69MLQ7EVFtPp3MbDAaBRN6DbXDygU2BjnE35acmL/bNHlUf54wmlo6z/YoYYPfbQZct0KkhEColDQOQZFVeeQa0Cjuvu/lXnehWtxlO722fuOGKfxsziVSXFWq31UTJxYVVzEwR5g7Ld6oMLlMcY+L94sZnSWPgs6kJZFV+RkZMH/kuQiueHGI2FrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPKwm92VgmLLLbAlyq6OW6u/lo5FQEDm4yUhU+0QCpw=;
 b=EvfxLSPxDmc1Ya12Y2NtmIK8XXiHLzO4oWErI71AJA5zZnVq2yqQK0dHXAek3slqxqOOGcOw0rKSeQTcYAMyeslLP1gSntiHHdst9MEd8H4FLsWThBg7fVYPY5VciHMCWPD9x3n/E1mckCZDuWp9M0HM8MJJuSDieN9jfPqPg7dOk3zoHVxTweVHsc58+4Rjt9iGSjN+7ALFXib40epo5R/fB6ViCG6Uhqpwy7XHoDsjj0jMi5jlwUoECAaDB6sO7EssQEPZLE0uN7HfVxaK+7LtIpujB9ZwXJiB8iUccCvTS/ScJv1z6/FjGvpCSRWELP2uC7kd2LOYqTxuoCsvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPKwm92VgmLLLbAlyq6OW6u/lo5FQEDm4yUhU+0QCpw=;
 b=gdrd/kee2/p0SU7kiO7rzPhciN0DVwg815105M1X34NDo4Gq29W48Ys87/0/odvo4qCYCnxlE1BbxFjamz1xfUS4CtM7rHRKdHjMwH3BFFfF5V6HkS6nyz2X0ChfQJ4ryQ8qefyV6+w0ag87wM0qWjbluLyZy0+5AbCy2odozev1HOqp4CUQYpS4E1gqFdxqCbO6oJwHxDtrtR9Hu8DipdXHG5u8I5kuqU7hfRHo6KX7aDkteiJ3PXOrwheh4EI3pkyl6KXIWCm6oa6BMgksNBL/qCqV36YwQanDbWUKv3tcy+zBP0UKipZA+83uj0xas7n7j2XtEY5fOGfsjKPdXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10259.eurprd04.prod.outlook.com (2603:10a6:102:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 15:35:36 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 15:35:36 +0000
Date: Mon, 8 Sep 2025 11:35:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with
 platform MSI controller
Message-ID: <aL73vC/fMowq42AV@lizhi-Precision-Tower-5810>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
 <175311109182.25848.8880954995049551501.b4-ty@kernel.org>
 <aL7xc0aVi-olMAE-@flawful.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL7xc0aVi-olMAE-@flawful.org>
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa54a24-2a09-457f-13d1-08ddeeed5b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9SyLqwARTn4AX0JEMV7Ujf7t42cDCLZtNllgOhX+06f50BOtI59kB1cyiJS?=
 =?us-ascii?Q?yv7BoIfH7bS8oQS8gyMVQCgWuJF/d1iyqBgi8NUUzFM3R24pFpKDILod/ZyL?=
 =?us-ascii?Q?eef7iYtHki90GRgRQcOssWZ1GOKhynfoJ7FohJWHFK2qS7tS/0mmtfNt2632?=
 =?us-ascii?Q?Oazai9PY9OfDfZijoIJkA5tErKXnh9aDxTlnuoBdYQ6Yek/LaEVuZNurxPPi?=
 =?us-ascii?Q?VV+UUi7bNOQCT81sNhYMwzynJBuLJLX7RxTQbGKyD4N5/TIzd33HIE8+frTi?=
 =?us-ascii?Q?vlTFYkqJ/rrZv5j3HaaG6TLk79FyuZ8FO5YmHr+knHBubHFlDGK8fjteVMdO?=
 =?us-ascii?Q?VgT476OqcyxIMAd0JtsBOl7w2/duxJO/eJz0gavwuF9bVIqr1Kqw95tKcuvm?=
 =?us-ascii?Q?or5mRPjyYO29uuKOLvwnldcqeQdUOW2gkd2SW08rXA/SWf7RlJ0E0XnpV4MQ?=
 =?us-ascii?Q?7QMicww6ro/lT5yjs0SwFps67NbdvBbaaD5bmtdAcA2tOnyeNjnn0+uG61dW?=
 =?us-ascii?Q?H+sTLdud1BXfoF4KCAbDmhpOyAha26i0cUhIKwJV0bYCbABKRjSE3V81CCzc?=
 =?us-ascii?Q?7goKCMu7kjq03Yd2iwDnuVeIoCVXcLkAaJazkoiaMZzZ2p6HXUNqYfE6Nq5T?=
 =?us-ascii?Q?FClksnuCppQxqW+qir7VI1rfdGdmS3Sls8ty5yF5VcW2w4esPR+GYKxoCWl8?=
 =?us-ascii?Q?b2Czj/kXlwNq0F7iwdEBxZz50Sl4f4H37nnOK0CX/WomYnmN4g8UW4ZNter3?=
 =?us-ascii?Q?IpL4ko3566OIExtZzFNIC4vFZCIssBIvJe8DqVI3Y6KSfl8mq68VJopu+vxV?=
 =?us-ascii?Q?cLPNRitrWMperjm+Ha8W/IdVNbqxbXyLBSFGtbtByyg0iPu+3Sjo3pobMlyM?=
 =?us-ascii?Q?XGNJn/eF/9AFEk+LNgNfgiDKykE7cyCj/aGzAP376ulV13lsGQkftdGnlSY6?=
 =?us-ascii?Q?rWr6oRMENF2C8KpIHz8FbVKhGi3SyGudIDr4UNgBOyTa+pJclrmoiU+AuGbl?=
 =?us-ascii?Q?qT2ke1KpdakZOXIYC/iFML/MTBKkiL1m8C/kMXfQSKtgbDp9oyuogyH9XLji?=
 =?us-ascii?Q?ErRtmdMZAxua1HA7M6RYI/68k2V8byNMuh5feF9R8MQuOYYtSHZgixslpo/4?=
 =?us-ascii?Q?EMT5YrgbIMLcNjcGnwMbT5qgKpyN7z8JMH6Bp/KUYITGaAX88w/OjpCud/NU?=
 =?us-ascii?Q?EivLxpRnuVbw0PtKgMsysv+iMmNUXUsLbsZvlsMty7MBPzLKpCqONjik9ma5?=
 =?us-ascii?Q?Na0ZAk5BxmD9W5JpP8VFZD/Ts88V0idngkLoQiLSTDjW0Rr6AejNqWsk897n?=
 =?us-ascii?Q?fv5yHRKIUoNNXiOwhRL/Wx6W5iwf6OMJj3B78rNBDMiPvdAG5asiWlsJL9cA?=
 =?us-ascii?Q?+MhBZhBxlT9WsBXTmtDQ1WZvW0vlDthzmsc8ucs2hr+R0O3C6WEGU8cGAWgi?=
 =?us-ascii?Q?IBRdxIgkUar2QVxAtXkhul1W7JehRUbHD3RI4qJexPsxYIaL1R0DaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJDgPM68TpBsvN8jY4X52eDxUm5FyGp6YxxL9eCrMBvBOYtR5F3iAVmB6Rhg?=
 =?us-ascii?Q?YI14esK338pAXo3XMGd+CDfyyO0UXdfeLM7nwgXPcqW9w/h2r50ANbV8Q10q?=
 =?us-ascii?Q?chd5ThjB7yc5kTSvbqVoqxUXAkdUzoWY4r/Ow3HmvYn1JssFhxZ1wCEGmHRo?=
 =?us-ascii?Q?3LFUhQLE9Cafkyl0GJDzKhYbiY9pdHeYMb0eMseIY6u0z2VUNtEfn7yO+aCY?=
 =?us-ascii?Q?lU42lwuapHsHnhXThM+LvqPXDzivmeDiZgYL6nChITI3dtF4mMp4vEbSF56t?=
 =?us-ascii?Q?SQaGmurlJKpYrwyXBtN6BKKyv8Rlk6D8aq1QwpyT86R29wb0YLEI5AxYkVQ3?=
 =?us-ascii?Q?vxpAWBtnRbG4XILG4aydZcWckl3hRlG/t/nfQvDIBiFdOejeNQSzKwbDcCMV?=
 =?us-ascii?Q?c1lxePmCbmYdbHLQDAtIhgNmU+Uc6weY6ectp+x0vb641tmO0pQOLWD5FdTY?=
 =?us-ascii?Q?FU1dYviJlxs26YB/4f+oGTM3ZrMROZw//uHal4cGfmh/4Kqn/Bo4dkycuWu8?=
 =?us-ascii?Q?UWgEKNcKiofkd6cLkNi6qFUlzNwjhIukg3AdZn108X2Ni1n+FFVwqHP8LFMM?=
 =?us-ascii?Q?K7fErr0rrFf57j7uB8a/hAzV9zovzge04U4C6X6htlq6mu6bjiboQ3BhrKVR?=
 =?us-ascii?Q?otoKK79AQ5luPAKJMR0p01Go/pIB0SYBhztXz+tyMD7dgNN+59/kkLI6Cv3l?=
 =?us-ascii?Q?/NVOi68XLBiWEHeZGiPJg5DQBmQ2MnTpkvVv71+CdGYxPbyQpDPPL1bICrGW?=
 =?us-ascii?Q?oQ0/LAOOuul8dxX88Fq2qTq7OqFUN7EdWuncUjuiwpbzIm5UixQb02mbYb6n?=
 =?us-ascii?Q?kXOMUlBqMxoBv31fetm123R3DvIe/emxC/KtmqsSr/dQPnTEU4pkW6A1IUud?=
 =?us-ascii?Q?3Y4clxlhtLBHq2+a36cJu8kJtwscXiyBa9gK15FIJokTkNOeFcUyJ7aTQBq2?=
 =?us-ascii?Q?YGf9TRMjpBXit0ZAOxvn72Kj25pBKKvfAe3F9zOf/PhA8pSJLaJz40Xq0r5t?=
 =?us-ascii?Q?wRpnTtBhIRGCzvlSL7xtEMVCW7eCEYLWjkw+lf/WKku45qNoM1e6ZxnUjatr?=
 =?us-ascii?Q?pjazF3Bi1KjCGqKHKC5YpLR9cI4QuMqqIPOUApaF9lJitUBZJllVTXYxorEF?=
 =?us-ascii?Q?toIwvQhFfmjvf2uYMiwxs7+aMHajL2Vf9MwDb1toZx0W6SSRlW3f9gnYBvNp?=
 =?us-ascii?Q?/Jqixi8SiWpRfk7dc/dPWv3S4TeDFe8rhAeoTp6L4skspXe318Pt7VryxPxX?=
 =?us-ascii?Q?62l8pT+zncALzEoQHFo9oILMIhPN8bG1CYU0ceLn8yBpcYs08Tb3fWgnsgUL?=
 =?us-ascii?Q?iWFfFu2C58ehINdDXXY0rpoUnmR2ix0blx5GAk8Q48eb4hQCEHCuDfPCEQOf?=
 =?us-ascii?Q?YOEEcEQsPdb33h2KKL2ZMBdXJAVRoqQFkYZCg5TPAuTjimjqBCj5Ay5tSk21?=
 =?us-ascii?Q?ootedfounP9D0xWft4Ll9DNjLhcqgWFAOdPhNCNcXtJkbfiDUYLuV6M6/NvF?=
 =?us-ascii?Q?jaY+1o0FMeGl2KugYIdocUw/Vbhmy2ZL1mCjQy08tEnK6fvkmZxR41hZDqJR?=
 =?us-ascii?Q?lVmuULENmK5EMHL3KhQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa54a24-2a09-457f-13d1-08ddeeed5b03
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:35:35.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro7tCn7K/BJLRE6SJsrwpBDqZrP+gfPfmYbsjOrV3rVUGdYX/DfPHsrPpoudphXvnICrTreg7Ae8TOuHacwOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10259

On Mon, Sep 08, 2025 at 05:08:35PM +0200, Niklas Cassel wrote:
> On Mon, Jul 21, 2025 at 08:48:11PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, 10 Jul 2025 15:13:46 -0400, Frank Li wrote:
> > > [...]
> >
> > Applied, thanks!
> >
> > [3/9] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
> >       commit: b537ffe0eb2ab458f20ec135cc2b565c63a2ea00
> > [4/9] PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
> >       commit: 1f2ed78e43abb9ac0856a82867f64d472368a832
> > [5/9] PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
> >       commit: 1c2c5f9855a5cf4617bcda721c22dbd3345f06a1
> > [6/9] PCI: endpoint: pci-epf-test: Add doorbell test support
> >       commit: 5d4da5f8092e5a77ae371ae1112283b59790ac22
> > [7/9] misc: pci_endpoint_test: Add doorbell test case
> >       commit: a1a293e709a4ec0fa2e4253993a4b75f581c6cf2
> > [8/9] selftests: pci_endpoint: Add doorbell test case
> >       commit: b964b4894fcfc72e7496cf52a33cbba39d094c5b
>
>
> Hello all,
>
> I wanted to test this on rk3588, so I added msi-map to the pcie_ep node.
>
> It works the first time:
> # ./pcitest -r pcie_ep_doorbell.DOORBELL_TEST
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> [   17.996519] offset: 70040
> [   17.997904] left: 250 status: 0x240
> #            OK  pcie_ep_doorbell.DOORBELL_TEST
> ok 1 pcie_ep_doorbell.DOORBELL_TEST
> # PASSED: 1 / 1 tests passed.
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Prints on EP side:
> [   17.924761] pci_epf_test_enable_doorbell
> [   17.926035] doorbell offset: 70040
> [   17.927898] pci_epf_test_doorbell_handler
> [   17.932816] pci_epf_test_disable_doorbell
>
>
>
> However, if I run the exact same test case again:
> # ./pcitest -r pcie_ep_doorbell.DOORBELL_TEST
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> [   34.672546] offset: 70040
> [   35.688190] left: 0 status: 0x0
> [   35.688480] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> # pci_endpoint_test.c:258:DOORBELL_TEST:Expected 0 (0) == ret (-22)
> # pci_endpoint_test.c:258:DOORBELL_TEST:Test failed for Doorbell
>
> # DOORBELL_TEST: Test failed
> #          FAIL  pcie_ep_doorbell.DOORBELL_TEST
> not ok 1 pcie_ep_doorbell.DOORBELL_TEST
> # FAILED: 0 / 1 tests passed.
>
> Prints on EP side:
> [   34.600717] pci_epf_test_enable_doorbell
> [   34.602086] doorbell offset: 70040
> [   35.624718] pci_epf_test_disable_doorbell
>
>
>
> As you can see the print that I added in pci_epf_test_doorbell_handler()
> never comes the second time executing this test case.
>
>
> Frank, do you see the same problem?

I have not tested latest one yet. Look like inbound address have not switch
back to MSI ITS address after disable() and enable().

Frank
>
>
> Kind regards,
> Niklas

