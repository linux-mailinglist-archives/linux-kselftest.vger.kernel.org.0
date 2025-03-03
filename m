Return-Path: <linux-kselftest+bounces-28087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23810A4C941
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D25C1884AD0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8D2206B7;
	Mon,  3 Mar 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJugn+Cj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842C214A7F;
	Mon,  3 Mar 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021335; cv=fail; b=YNAIc5saj3gxpUo1BHSJEQTihmZLwimAHUCaJhLdYd85TavaSVOeKNSQb6VtCEoOtqPV8r9zXNuR1uHUbtvE0pNm8ASub/IwiOGCBUXy2xOUlBmv2tueLbSVAmZ7xR2LKIyBdqTkNQczeBJ7lWrtB0SwIAmjYYxGDR+sE1Ct6No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021335; c=relaxed/simple;
	bh=xEevRscg2+BJVnLTuSOpzr0SQezERrqhexc9nAQjfTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gQx7b7zMST0w3OBqMnfKE29bzbsl2yejLkq2hFmGvrye2l0BEsB2of8iLL0OVPfOzedxyqURAbNN8ZOmAvMrY4rAhLQLY/kESFrh90Q+vxpwdRQTkxZLYwbF7W/kfTl61SDBKKt0LIcLpLNiy509p26WpMmyQ8i0wycI2aUnqzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MJugn+Cj; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhFwIvydVdT9yspwdS5VulKdwS5bzev8VVx7EMXwm28g13ATxVPv6okSgsTqNvHHmIruQ1VINkiiEDDhELJLedVCZ9zvx8ZtZ6SINrf9C0p8Hv9+TcjJ1szXCo2m3EBuzAjVxmXuAFWZdqK1HD5H8gBKa/HgSTdQGKdW+mhw4zPuOUW6Bsb6wi6JZbWQQ9HAgRx1B8KutzDMFtQt+svub/BAbTFYNTWDlXTQ+JJ/+tnz0689wNb/Qr3o2ppMGPA4em7Agl9ggTctbO+W92QqBX2Jbr6bmILUZJNSsmEJYz0Dogu2t5F2XQoMjBHTHhjMl1L7dgjr5KyBjAX8IcOwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSZ8Nij9Yn/j6LkC5iT4+Fg9imcYLwhsRLDRaTlquRw=;
 b=r4uVUaBthvjV0TXYUX3R0ZNucZ1juEeTyPXObJd8k+V3F7DhMa4QVM86yT6o5e4maI9kotsgeWDTPZSSgl7l8E1YhLswVK0z8yvG+8j09aIsXfZek72Y8ITr/ac/vp1TOVwZiNWphMFK9QSB/Q0oI6M2PgmzfBEYFXuAEE5gCVB3tbGcmhrgybVhnA6bEeX+PVZBovn37jEQ6i3HCtyYGx0Jda2SzuodA9NkwUcCNSeYabmOlHV/BdTYAerdG9zR8RCdDU+IV27LWqyVG36s2PmfcPllB+6g9/3F+DtveclrLzYcKg5D2j6iG1y+ghCaqr4J0euhas7st6sQvk6otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSZ8Nij9Yn/j6LkC5iT4+Fg9imcYLwhsRLDRaTlquRw=;
 b=MJugn+CjmNTIyN4cmpgyAcKNUZbqUAjtGbM/7GaWZofXhsTwyFtcPXNRlhhs/Znu509L0IRZWdyExyLmCINrDmC6wnHcznGrPFjguLIl+vVS8opgnaRuVkr9F4bVTmnoSpwMvLYArBBbmv+qa88WM8BR+Jftg2Zsy4BCie9rvJlPlj0dy1sQZZrAhKc+q9Hj4Fqvme9EWfMIFdADA7CqAyBoB/b6F4zy8CqgtOMgZdPBjkPacQhnRQXc5He35ZRTMm4CEFujR1e5p5time3gRLHlOqbzE6JtAzOieu5ayD7MeZnmoauObicLWalp4d8X1ApSwvbY+YE4YiapQjWzvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7208.eurprd04.prod.outlook.com (2603:10a6:10:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:02:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Mon, 3 Mar 2025
 17:02:07 +0000
Date: Mon, 3 Mar 2025 12:01:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v15 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE
 and irq_domain_is_msi_immutable()
Message-ID: <Z8XghE/VUrggdN7V@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <20250211-ep-msi-v15-2-bcacc1f2b1a9@nxp.com>
 <86plj1ovkk.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86plj1ovkk.wl-maz@kernel.org>
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: b05955af-0949-4b4c-2a21-08dd5a752173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QJLwg3RZmxbzM3EzNpw7VrFIchIIWhCJxB7ZivKX+yhEypSVmwQs6PxuEavl?=
 =?us-ascii?Q?CC85TTsUMoKRtuA+xpFEijkszw4unbIDzH24qRdjsUIWIRpZ41Hw10XFxuIk?=
 =?us-ascii?Q?dBmoZ+W+ReB+s0VQ3pIaloE8gN+yX/D1dLAqSkLS0fuXN0UYXnK9z8xDB4Y1?=
 =?us-ascii?Q?lbql5xu42QI4yt7lhrI03RuSs3hV1Ovu2F2R1DGVefpb+bd55vwmHGP5cPJ4?=
 =?us-ascii?Q?uDK6XWmTkimRS8FlZWo0ZmQT8Sw3fBbi6ARXv+lbCNOwmOuPZEY3Tt8NmVNJ?=
 =?us-ascii?Q?7RoywjjMsOMVsy3L08RGSJj7uyl+C2zAy+2gXcSSOZfd57TJbNer2a1ztNKo?=
 =?us-ascii?Q?B5xCt7TjeRg/MxUxWu3KJT8RJWIbNx9Y60FLeY9wFXtH3NAc92YB+b3wE7MR?=
 =?us-ascii?Q?TrbVwsItBz+9WxoKT4qLu3SR41dhNCv9KpoGy2426JmDXeRZmP86z/j3GXPn?=
 =?us-ascii?Q?SJqpy01JqjDltWRoZjzWJU5w2eeDRjQmfXbbWbucXpPDJDBrgSoqEfAOS3x0?=
 =?us-ascii?Q?cAIH7gSjvMUGOUKLNXPK4mUjpeieHooeCvlkdahNZgpjyRxgmmzLqyrV745w?=
 =?us-ascii?Q?D/UJ4x9q0UJ/JhFLM7AH5nAqyC+A3QuQYRWxy9yKLl5ypjeR2I3m7kuTxSs0?=
 =?us-ascii?Q?vJb29dmshazMjDBoNGlRDEWBEllRm9Jy5icTMETQZ08pcn3Zb0MwWsz1wUdd?=
 =?us-ascii?Q?Y6QfZNvOJzCdqhH8xtDjNIcmOsHxlHoscE7PyVY7m4wzfYCizt8z9NX2Lzb1?=
 =?us-ascii?Q?JUXdOttX+zdGPjjtrJulY0OTEykyD1+RDb10OHW16cNq1aQxNlBOPrKlLNGZ?=
 =?us-ascii?Q?bMmRj0xn1iA+1BbLhT5aSIV2gQ2lfhdK42pd/ZL3dFHKwBQVdxb0SnpkErOB?=
 =?us-ascii?Q?0jVJrgvAOfY+F04IZlw5DylhXxFMDfKgq72cXwCzKYVp+m0XiLaG6FbWL+EZ?=
 =?us-ascii?Q?iMLz8F7KYEDDwyD5VwO0VYkEe4z7Mt9nyshS7oYtapOUvkDtE/fYya8Gr6mI?=
 =?us-ascii?Q?/hyhgQS092d25pWle6/+5A+BG3Jb1R4YwQ+Qk9gXirqknew5f3PwFwj03ncN?=
 =?us-ascii?Q?JchGhsfTSFgxBLpPLamQWhcmr/U60692RUtNioda48+n3wYeTvMPmXrl7KX4?=
 =?us-ascii?Q?23yzHHpkvlSujhMekv5PpPLLudX3QRip79ClYiYt6AKXg7U1bCoO6txpQ9ki?=
 =?us-ascii?Q?o6EWNsnUSTdfIFKRa5Ikq0ham3nDZPopRmAEYz0Zu6gWfENHH1rsMGa+kidS?=
 =?us-ascii?Q?7pPgBRB50lwOG3o01QIS99mA6msF9YyPw8y6pUxY2z9Y8eRo2VpSDdzY5DV9?=
 =?us-ascii?Q?Ql/jmyU7AtfBhKz/r7Ci6FLZeeLgpVdscgIfFNpBEFxU3qjoDNk2/08iyGEQ?=
 =?us-ascii?Q?PDODw2Demrlgph0P9y+IhJFNPou0y8EX27lxqgd8GNR+zbvQNW2lycCDAIrh?=
 =?us-ascii?Q?iOuqU0oKTn08YRfpBiuQ2eNY1+SVMsXA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ZOoVcyCKrTC34UmNSo4KIh7wbOLsxrxA56cVVlm2mk1yau+XhY2gtIr+OqQ?=
 =?us-ascii?Q?KZu65M290ANhVYhjbEbF8nQ6aIg/X7dfsP5L7ol8MFbTdwBxiRJnYX313Js6?=
 =?us-ascii?Q?2svIY995RYDq65AYvIpol4m+TJFaE2I2ccWZ38fTIgOOrkbXAHBNByMUHBHB?=
 =?us-ascii?Q?Gv0muadALLPrMoK2iShn8FRPVoe8E13XUfD4avkQ2XqbucZQZ2vqS8YyqB9G?=
 =?us-ascii?Q?FoMbryepvm3WbITXV861N0hNDbxkKjeO/X6zdbi5Cv0JEIZMEUqGbcpxbNoF?=
 =?us-ascii?Q?vbZCplX12Z10B361DAB0yyfnKCf49G1WE96oDHewQaub/PtB7C3B6FICD4gY?=
 =?us-ascii?Q?GfEgKYRBjxJkUKdTlRWj+IbYOwM25iZkTmpJMv4SsmSC6uvq9pPTgXR1gLoi?=
 =?us-ascii?Q?ZmB/1iX7qL/YlpPuKIM1kM16r7awbg8tTsIvuvF2ryOZoEs/c7C6tJI3Csy0?=
 =?us-ascii?Q?znt3CtBkeAXaTohhcVv9MkaT5uLnmRS4ST83QOV11XYhWpgnvsB23PNABZkk?=
 =?us-ascii?Q?uQlVnhdiybKeEJGLnX8dfyceDHKkCuB85eKydL2b1XlmMb+Ua87wZ1e+kFCI?=
 =?us-ascii?Q?szALxmK9SzEN/TKAGmIpmrs9pXxxoV2ZzadnJhc+HcoyfM8UhyZha1L26b/a?=
 =?us-ascii?Q?HsX3g4pe7Ivia+JjCETetV7ytwSQUQOXQZJKx9R2lH7TBFPE6sTM6hf7cudz?=
 =?us-ascii?Q?G0djXKLyKa4JvKStuCRRt+c1MXSz0F+3mFs6jjbrhNBQ/NKu5aepZvWGblgX?=
 =?us-ascii?Q?OZACZIADRQLhbK8lIJ1HZLv5rLYY8Eibfy268dsExdio4r3mZwOIJv3zJIRr?=
 =?us-ascii?Q?4uEQoKjLiPyjFRCUuUm1rCeb6KNj56bjP06pvHgbhPeYBmYhQoYt8oYmnZDB?=
 =?us-ascii?Q?+Y0sL0IzuZXolLIeit4UfxDJzlA/da4O1drjprv/T8OkTQxISXUvViyWozd8?=
 =?us-ascii?Q?gPWHS/9gHWq1bUSzocKeMMGqeMSD3lZwyyDhS2Y6au68EqlfXaUoJys+s075?=
 =?us-ascii?Q?n1nNXwakRg9P4CxtOvrdMFSYJds8em7wb0Y7JlOrGjEZlStXE9LcYgbQAEV0?=
 =?us-ascii?Q?7LLlIGLvDm1Wb9Q0CsNwrepoxCTnTFYXtiU9YRKNyLR/tr6QpsuzQapW+9X9?=
 =?us-ascii?Q?K/DejBc1HQE1YHnvFhg4JLlHnstgdrsA0ASL0RAso3ed6Sno7f6VK8M3hh81?=
 =?us-ascii?Q?mMbNRtOqS+4jfAjLEm0UmBuKWHjByI85U2KS9YXQuEOB60lbMUNeT1iuDr4R?=
 =?us-ascii?Q?WVA07D4PcKThFWeuTW0kbo72OoSoGuJDqb1Z3PBQN7KPzbiJJrdcJ6FEGHTy?=
 =?us-ascii?Q?uEiYvsC6pyX2HV0tXB2Z7rfhV5DMLJOLgrcQWItZmgnQLgI2Zt0hsON4QW3d?=
 =?us-ascii?Q?P6PoMh+L7Y76PUv0OKzO2HeTzZemRwq4AzF35dnsQehSUN8Mm5NwoV7/52t6?=
 =?us-ascii?Q?507PqVfErl1X4DdBYdVsAH62EELdOZ2+Bz+I5Rl72DVPqiQFVNgLmjNyNFja?=
 =?us-ascii?Q?GBP0NlT3b/F9PGpZ+PbYvW3c6TWI/pjgvoPkfr7zmeje70PN5sDwRe03kiDk?=
 =?us-ascii?Q?+DwtMWCHRxGOqrQAr1dsUuB1jDTbOBPr4lcwq2AM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05955af-0949-4b4c-2a21-08dd5a752173
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:02:07.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccr2rX1yV7qX0kkXRXtwG0wgUyC2JkVXb5I7bkHQxhs05K+Mob2nWCh8+Dkn6f1Cmh85nENTjYMZiHWjg46SXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7208

On Sat, Mar 01, 2025 at 11:10:35AM +0000, Marc Zyngier wrote:
> On Tue, 11 Feb 2025 19:21:55 +0000,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
> > irq_domain_is_msi_immutable() to check if the MSI controller retains an
> > immutable address/data pair during irq_set_affinity().
> >
> > Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
> > require the address/data pair to remain unchanged after setup. Use this
> > function to verify if the MSI controller is immutable.
>
> Why is that a requirement? Why should a driver even care?

At v9, there were detail discussion about this
https://lore.kernel.org/all/87v7w0s9a8.ffs@tglx/

let me summary:

Host driver workflow like:

1. read address/data from shared memory (PC bar<n>)
2. write data to address to trigger doorbell.

1 and 2 is not atomic. So EP side may call set_affinity function during 1
and 2, address/data may be changed in some MSI provider, so 2 write to
previous address/data pair, which may not existed or map to other place and
cause write to unexpected place.

Frank

>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

