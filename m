Return-Path: <linux-kselftest+bounces-28673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FEA5A5B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AA83AE8DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33C1E0B67;
	Mon, 10 Mar 2025 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BILsoixo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F581D6DBF;
	Mon, 10 Mar 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640946; cv=fail; b=O5i4mMWxQO9AB/j+ui6As8zC6TYEROsvL1qG02g0izYg4HrvEFGxcyCUuGi524cVgfrpKPgd7s7ixX9OcLy5jfcoR1WzCWU6Oral5R8wKy1vAybRQBpSMsO2NTnM0rp511Dn+RsQhax/y06lGF2GS9xqax2Mq6/1HoSR4TNjTYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640946; c=relaxed/simple;
	bh=dbpTr8tVWhnyYRHvRBqh2Qaz9hSWfHf6Ec/jeyRFQc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZcCMx8L246ityu19cUDriR7v0wSQyosnJvOAowJWvZ63bZ2RcjkKWl5j/f5IgA5+T7Sw7CKXHKlnLMiji0RfXntAhH/teOG4XApEF9FoVMVAnJy20zsRf9A7aT8sITBztNHxj7kcGSSJnnkzgkti02xHLZ9kFu4+suemxgLU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BILsoixo; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnI0RY3bGR56MHoSIZa4wghyCrEdDo2npZviNwgXMchXpEwuN3fP8Rr3A+7qTbRC7rQtXRG2sBlD7oGseevdzEG01t+1NGDRy70CxDUu8L7b0Ff5XscUn+89XPPcJ6OjKF3uYWsOI7KJQwikwmNSZTUNSYquu65ny6Gemjy0AyHA6a0bEZhQTv0x76sVz7S0uVMPkMrHs30x5Oi+g2diXWtM+aPqS1lnK6WIBHnIIjafVnXf+cj+iFBzt4wyYV8TgTeF+MXar5He0aUFTOF4Tio1ctrvVt5dU72T0dK5w6oSxecyIkKS7/jlirOTZAbLPGRUu7n29tGIBObgQpoEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHsZSq0AO5HKR14yCG3BVPkZQPcRJYxAChz8sUR1ons=;
 b=AEq+KaVRwrJZe3X8pLTJtznoYn76dF2N54LFRy6BHR7zJX1BmVzPV8HX2T0w4HBwNqSCia47YfHhNIUO652aPUTPNHQURdb268Ec6YSGBcVgiSbtHqx2hRJh/7XqYxK+aaDg5Q7Rcp+jYDZ/G3DmcYVqhtGGg14R/77G1tNGeGlgQp2d/TuzlJRz3M4YrPZqxkb2yQ+TxI3Z67/k+QzB3AXa5EBtJGfTMm8XrB069rI8DUelCXLr8DyTYA59fFWtiH6gewCttBjNJkJoOGaNBEQtXWRM2nP/CAVWtxRZzRF8gaM83/f37pzEdEUFJSvWb0pM4ERE0LJBTKAzIyYoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHsZSq0AO5HKR14yCG3BVPkZQPcRJYxAChz8sUR1ons=;
 b=BILsoixoVjH9itibzaXJm2FsVm3DfbVgjx2pomq84civ1UBUv/ZPBUh+clP6N+8IgfWR3klLRWQJ3UrCUBwdIw3qItoKnwjS0l3vm/4BnPY0q0rFUGoeDfP2n7JAyP0JTW/wLbf0t+UsDEpnfNKvkSDqg3KXcn75HmQfDgUGF1ql+XISx2qXvMUPinuaDGcHNkenAVlvtsGN1QfRAmsV14mDcAykVZiFYWo/dUsgCWwRpBAjiIeFrH1wtOf55BkeIyssL6qFDShfW9CDlFect1PAsugjUogiP6JEUJT53zZ2p0nJEBV2y7qq2bADu4hjwkvdK/fK09MfGVo4U6achA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9447.eurprd04.prod.outlook.com (2603:10a6:102:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:09:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 21:09:01 +0000
Date: Mon, 10 Mar 2025 17:08:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <Z89U4Sa1SqBPLNrm@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
 <86ldtpot6m.wl-maz@kernel.org>
 <87senwd3mo.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87senwd3mo.ffs@tglx>
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: ad44eab4-4a94-4c32-9246-08dd6017c7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmIMf5nszSHI3f7wBuJ5SeMfqpruN+mRyubNzIqzSR2Bk5143NjMs33A5hNX?=
 =?us-ascii?Q?QoEc/3fWFKloW7Csg3Qbyh7QjtqdQZQSl5q4n/kqDhGI8iYkLncHOwpVRvi2?=
 =?us-ascii?Q?Ftw7NP0/HwHscWFQy+ioL/PXU9FPNT35YUVih2eIBiJsh+GQ8CwFGyuLiMRl?=
 =?us-ascii?Q?lnJnAU2xpg17fLEC38ipaooUJAeRTpIfiRyvzez0ylQzV7QZYppHASqaiBJV?=
 =?us-ascii?Q?liOwZCeSp6Lu2Qw0aXfqq5tVdSBEP2J7YTUJJ/mXNp1Q0HzEngC/s3i9Jrrk?=
 =?us-ascii?Q?yOjSoOZI5dh6kpRFKwnJ7SEb1k94I8b/0VU2BYiyKi5AGAut1D+KyWSx25ha?=
 =?us-ascii?Q?bs6bgTekNZVUIPKwVw4asu+krBzmc5rfRexcT2t3+IxGDDs+a/2XKvClVs4z?=
 =?us-ascii?Q?lRpyL+2wciqig3s3bQ717rCo5B18yHtvspAVn5Tj2k/dVCtenWIt9WrOU6g/?=
 =?us-ascii?Q?Il1vUDXKKi+/7n2hpevPsTTfbw64n8kcM6Z4l4FwkVNIbU+lzhA3otVqgFDa?=
 =?us-ascii?Q?M1ixg/i9uLDaZxHUr68KISOorDXGRvC5uHp+W5LDPNFYnzY1kzAiEdfyb+NH?=
 =?us-ascii?Q?FeTjJbhFC4A0JmgZdEQjcn8fOrj/yOxlPi4amed5rXaA2ZN+jju1H9q2U3B+?=
 =?us-ascii?Q?NgaohJOTlhnWdCxSBNjzAb+S2ce1RQHtNu+PwZMV5FqwRYtGGJS1UPM2Upl4?=
 =?us-ascii?Q?rorMvAMnBq1f92xZb23EzbJAaWlzJ2YUxeRv2q9Vo22nnkN1xwrKr1bwj1Na?=
 =?us-ascii?Q?zTNsKeO0XdE0dST9HGEUNuA3WZxWJIlg6MYqa09a5D9VF4zH3rRvVnfBfP1p?=
 =?us-ascii?Q?6duIGQ/Y+jU/GigcPbjK0vSkwqmX0rjo/yRV3JRYsYoVh24auntA2tadnMMF?=
 =?us-ascii?Q?oxoH7V1SF/KTlZX+/zbqoxADIfTkGiLVOKbBR+PrT6uGQtA3BD2P9a1cctLT?=
 =?us-ascii?Q?gMT6xrLHqVToXoftSYQl681+Y8NQ9cIrn8yWjc5uI5C4ZDAwWT03lpu67Bmv?=
 =?us-ascii?Q?cpX0AXurIru33l5UZpEWMs8nAeuYAXPMHWit7p1J1akiAg24Cgs+86gkcDcW?=
 =?us-ascii?Q?bgOU0LjDw9iDfICU8dewI7buDI+J8xTZG7wJxBKF8zo6BrBaOnQHGusagqxz?=
 =?us-ascii?Q?sNBSvn0EYqvMGcJZTtFvfV6T6BKHJgZiuz+h0u/kv+bCbWihCk67eT4QVnAI?=
 =?us-ascii?Q?kh/1VeErxJKEIii62EzHawMMidq1ij/MREtCTi5P07VsPLf/HPACorfchIKq?=
 =?us-ascii?Q?GcPE+rNEXFPffIryI/0823Ick2KezmPSD6QBkVJNPwXxUrsLeCU2DmaJZ3vj?=
 =?us-ascii?Q?IXzO1aci74qzaYqkOjJHtI8RQ9IFO2MmobGUOJ6CTOXL7ayTQ2O2wUNPpLjS?=
 =?us-ascii?Q?Q93dfDsSixmhkmeFUyIVvohwAsIYMFkMT3Iirz8WLpLSbowvxLTPKCsYw+5l?=
 =?us-ascii?Q?Saz/p4MZtxUWluwmBGuVE25mdcM8P7T2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eONf8Xq1WpreaNERJgzpERUoWQY5ePlOz5NHNpfQFk1PyqC9fDoLZiglmjNf?=
 =?us-ascii?Q?DPrAYRo4hk489rEK/3/JLwcAk1re/kVPs+SURE6rOz7g1Olkse3qjJGXD9FI?=
 =?us-ascii?Q?F05HSjC7YugBz2jEoDZP5RC4HOweK3c+vC6pNIT3yp4kbLL6T+WyiDs8+4EP?=
 =?us-ascii?Q?iv6TcScsavyuulVyjR8X/jk1LNV1bKbJD2aW7ZWsHy372h9jOI1yJpcUgTph?=
 =?us-ascii?Q?T12Ma9xDjBNK7PBWrAjXeNIWvXJ2CnsITEhK5WmHnqAzJcXaGQUlJOJBNzYQ?=
 =?us-ascii?Q?orwmEnYigeRwrP+kEohh6VDl1Q/QwaXOHBvVCLLMYrszCRKkBXNoz3QqDXP9?=
 =?us-ascii?Q?zVcYARuQNExoy1ImlylQtKZmDQzgrgNc3Ff85nkaj5dyAiS3JkqsQVpz0M5P?=
 =?us-ascii?Q?5YeU2pbu3TX7+pCE+kSkbwXR6pgC2U93jk7s9KJWHCztwfURYcViwoIH/9pj?=
 =?us-ascii?Q?nEeygpyidraS4+Mtdjz0CzqSrP77uv0Or9EovVTfTOBDXVQ8kpnsz63wJYVh?=
 =?us-ascii?Q?H5G9MRab75UZ4SlN5R7S0mso+6kTwd7b4sU1naVl6GCn7tRtRywlQ3NZQaZ8?=
 =?us-ascii?Q?u6BrGB08jylKxcbHW2Vxav1vDNGBFd1b+h3dgxHGp1nYB8AXJEkMwfcpKJ+H?=
 =?us-ascii?Q?zJYRsfhj03fb0GxKrwk6qBLiR/s/x6jht11rOU/CpBSGe/0wmV5szhhEwh2b?=
 =?us-ascii?Q?vMDG2JhPJ2bI8ATb6njZmwh1iJ8BnSkSlRV0YYYHcPZiYeMbwVjD79iKwsvW?=
 =?us-ascii?Q?glLsMeNodgxg0WoWsa6aGLkw+2Lur6NmR4CRp5nXqkUy4v3Uqgt2HMNjbsM8?=
 =?us-ascii?Q?oXeJhptIraG07yA3Fl/ucBoCjZlPXU34kmGNO3KfzgSBRABjsb493a7cYF6/?=
 =?us-ascii?Q?+mwHYK2ZTefuZDu/4xv6UqWEpxMXnwD2nkATEwyKrTDc80WCgpqUPDZx83bd?=
 =?us-ascii?Q?7jJ6NUaZalJE2y2FSKvwapuoFtTsJ3T5eYqJjIXTrvFSFkVDR7w6C3C381Rl?=
 =?us-ascii?Q?OUlQt2bzOsSz+ZPyEWS+jIREK3mE9UkrZiW8/jbLuWQoBJWy7SWOxw2J4H39?=
 =?us-ascii?Q?cyXvfkDdxO3EDgHZW4G49JBLMoxVPKX0evh/m1/P+p7TgFhxrd+Sad2l/t8g?=
 =?us-ascii?Q?D3d/8V/Dwe4o7mZJqZj3HuNVxhMhcIIfGJftOEzwveC0chTHyXZYFAMNygde?=
 =?us-ascii?Q?OOeDLAlgV6t++J7MFyFqJ1QDGgYqwNiOwt2W2Wrm+ZBvwXnfaT69X5gRMkTM?=
 =?us-ascii?Q?2Sj6l8xdDiu9irKWwzz/tKbgntM6FTnHraKFqUiCyzkXv+HfqhQIbS1MgVAs?=
 =?us-ascii?Q?C6irdak+toOWR0NDXBLUygiqd+jxfZmOGdMPN6w82utnsFqrnWS7FrC92HVY?=
 =?us-ascii?Q?KldRD6oIv189kfUSiUFXqDg3FgXplCZzdRneD8U4mdSy8bs0h++qQ1lSUGHI?=
 =?us-ascii?Q?F6QggFtdvlfJk2ezq8vuYQjmudVzY2Ldbxgrgys+vy/DczXQkSrt8TiJlE2x?=
 =?us-ascii?Q?LKI3ZFKubYWdLc2wxjdB4nAKAa5gcJtA3cBxuPeSYFrEgNysVWq//1Ta562R?=
 =?us-ascii?Q?r40AlCHTcn1pqRCYcHsqY0hSt2jgWNd+YIBN08Kr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad44eab4-4a94-4c32-9246-08dd6017c7df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:09:01.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gijB34s/1Cm1EFOColdJNT4UR4RJACdZb9aDJkYXE0MYd7e8hDRDx1C+y4BR72qN2H2wA+OBUdlH/IFrCFZ4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9447

On Sat, Mar 01, 2025 at 07:09:35PM +0100, Thomas Gleixner wrote:
> On Sat, Mar 01 2025 at 12:02, Marc Zyngier wrote:
> > - This IMMUTABLE thing serves no purpose, because you don't randomly
> >   plug this end-point block on any MSI controller. They come as part
> >   of an SoC.
>
> Yes and no. The problem is that the EP implementation is meant to be a
> generic library and while GIC-ITS guarantees immutability of the
> address/data pair after setup, there are architectures (x86, loongson,
> riscv) where the base MSI controller does not and immutability is only
> achieved when interrupt remapping is enabled. The latter can be disabled
> at boot-time and then the EP implementation becomes a lottery across
> affinity changes.
>
> That was my concern about this library implementation and that's why I
> asked for a mechanism to ensure that the underlying irqdomain provides a
> immutable address/data pair.
>
> So it does not matter for GIC-ITS, but in the larger picture it matters.

Marc:
	Do you satisfy Thomans's anwser? So I can respin this series.

Frank

>
> Thanks,
>
>         tglx

