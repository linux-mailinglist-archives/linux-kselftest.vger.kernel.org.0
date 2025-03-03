Return-Path: <linux-kselftest+bounces-28074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4137A4C71C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31A71887EB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4D213E75;
	Mon,  3 Mar 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B41Q/JbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04246157A5A;
	Mon,  3 Mar 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019251; cv=fail; b=rlBfiA7bsvVE+uHEYmZMLhnGAk9OSCDhdul1qaQtI5uZPkfX8XC2bSRK5Av+1OBd/n+sHZ/xVmtmIhMmavbT24s0qDY66wSV3dw6dnQKHmMBYbRxj1BOLTRGalUDhyXlrt0JEjtqWzohhr30CziiZA4Sn9kxoHjcTapey8WVkIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019251; c=relaxed/simple;
	bh=XQgsW/X1zsm7E/hOlzNInp7qtVgjgLcpihW9poK5Pw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P4LUQ98lzEa/iYcPVKXGS938jzAZFficTkrxrc5B81+J7TR2+V0sLA1pLOjKxO8SIrlYlQaO5KB1Sp96gefyhcqOx63wLvMwTD+wb1UWtfZjczImUQ2NSXMKMMLSd9GnaYPtmrEwgi0rb+mP3o4vnLOYkjiOl0G17ezCXlmvx90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B41Q/JbL; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKGs+7B56WIv7oe2lv2LYpR7uBsvOz8bov3s5pt7gNA7PBz5rCU3ZE0jPFeU2WBpngGOyJy4dqmTapZQSdVZw7J0qbXsDNg7BbNuoBlH7IqchIn4wCoPU+QgJ4F0W5mOPrVwDv0gmvEb2Ev66vbq9JifE6ibU1gLVh/L73xoybZZ+7l8WktPv8g/P5AF1j14qcbaUAV5mew4F4xMnZH4O/iwpz2aVxLgCWoSnIfMZo1pgxETZ1MeFwsKiwGRSTMevBw10lgS2pvRn62KcAKysQox2kDDNGV4sT1/n+2EsKXNCHktuD54blfdj1XiBEPV5SaYhMACZYds0blqArH4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtySBx51wqAf0FT8Bnfs9GMtRfdOUgpZ+uYSC+PdYxE=;
 b=lXTXg76RbeCwY+qLzsk23GdYPx9vgywzm0kaNnxP1hLKUAgUHnHP7qywtuP7D8RBJvbSTOJ4WR2mnSiYS/tCCK3j5OVBOflZIuHmQCJyp2hBWay3+0df3L/hhbIherqWO7SlNxjFhGKFzW4G9RSN/IxWoDxxWLAzP5+qG5lHeWtNLVqH9qKygGI5AKrZ2Z1x6RvtYZ0Klw74HdeVZe3NYlka2KAKYa7ZlIW8W9Zus9nYYG/CExa1PBTY1LSCba7Mu/BmJAEYFumFzsf8rWWS5WmI5PmSzae24E1la2lPAm4GsScOvYBt5wY3Tm0zxbslcVRMhJ+XduKUzj/13lexDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtySBx51wqAf0FT8Bnfs9GMtRfdOUgpZ+uYSC+PdYxE=;
 b=B41Q/JbLr8YGd9eIOY2czKcLdWykoBV/Lyo3mjdQIkZKbhlFOacQ10dzwevhjaDQMYaHCpHEshgKM7uQUu880Fik0IJ6ak9FKtMN6gJNDBidQLcxH/vzYTXOm8Jd4hcksiSMoqjUcbD+vQka3mf1jBs8yg5pTTBgJx8u8hSwtYwI5JPPn90WFeVuy/Av2HRsA4iA4MGE3C3odT9OjLL19yTTzDwdAw0TsaZ6adM8CuwbBa+2I0v9gB0FwcqJbhUFSwXRqs/jgfdlSrEyrxlyedqgvhwMNWf5vaKHSlKl1kzMC76ysw0aLN3jGBtMgbnaEQxlg9kDq82rqCBpcZ4UZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB10039.eurprd04.prod.outlook.com (2603:10a6:10:4d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:27:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Mon, 3 Mar 2025
 16:27:25 +0000
Date: Mon, 3 Mar 2025 11:27:11 -0500
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
Subject: Re: [PATCH v15 07/15] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
Message-ID: <Z8XYX/D5c/+PuOg5@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <20250211-ep-msi-v15-7-bcacc1f2b1a9@nxp.com>
 <86mse5otzh.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mse5otzh.wl-maz@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB10039:EE_
X-MS-Office365-Filtering-Correlation-Id: 17723f04-b805-4db3-7bf6-08dd5a704809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GP4yu22ldbjdP+sTMdfdktcEQds+nQLw8yNj1kRIXO1JQT/XJRgb3BG99ha?=
 =?us-ascii?Q?nlPntZj8lQ7VhGqVLSzNvIYGvKD48kfkr+owDuMWfw/lUUbyqfvVsqP997KS?=
 =?us-ascii?Q?4Wd9RiOiQZH5Wy23TYPRPJZITEmTo2fI1hY9q+xLYnmzk5+kjjOhia4DK/Xx?=
 =?us-ascii?Q?bvBdYjoHzjzplGol0BubWuymYwVdWsjc/XMmFlNjdXpGyZcPPdQuwc/kE/h+?=
 =?us-ascii?Q?Fs7UtQWJVwNVRngS+OYE5uCJe41W8A6bkPoyAZda9XacakXdzxuWllRtms1e?=
 =?us-ascii?Q?u6k59yFXuZW1TXUhUnAgWr+ijR4g0K0NCY6SrJU9ly++hO5+gr8XVJqsT6OZ?=
 =?us-ascii?Q?PWDrqUf5IfHFRSPESPn2R+dsaYNIqXKaYfrbd8KbBjQQtiIhWfH5f/nBxRtj?=
 =?us-ascii?Q?jEFKSznunfWQPVYb66yteOVWiMXpav216tsWlERMUA9q19As0L+YOoCKZXPN?=
 =?us-ascii?Q?0+TJUg874qsiO1CxafW/pFiWSiKgx8oz8ap+eZ8aqh0CK2LPQeaba0h4Ybw2?=
 =?us-ascii?Q?x0NodL+x0hgnrjKSBoMuAAxxiVwk4804gybEDXTDU1fr9hIT/51TYbKtlAkv?=
 =?us-ascii?Q?yTI//gPBywcARwQkMrWjWSDaG2V2AX8cdn4sZhcBN232IWF60a79H+6iFKoI?=
 =?us-ascii?Q?0ftHwymqfQ95ZSL/LXgrK22/tOdGMKXXO+NjwXliMh/EvncXW5tn/zSZIqy+?=
 =?us-ascii?Q?xLJasd5bh/rK/y5PSO5gOoXVOLi69m/Jv8Q1URCDrrAwUdqYl8r4NNvPaFYa?=
 =?us-ascii?Q?i/4q/xQYjdTVPV3X06+Nz2siFWuSqVDUQw52+ezDm9Rx1+KvmtlXYnS911/C?=
 =?us-ascii?Q?QD07hRWtu/8JrnKafvElTlJcxiqJMbSV5L1nwMnjovdjSpm4RGj1z6yVNHSB?=
 =?us-ascii?Q?yAGKaeYWBPA0tn9UvGckLb7rYIamYDJ5O52d4Aq9BRhb4dIZ/pWhAiojE9qc?=
 =?us-ascii?Q?dBfZ6JwBU7/aIQ2nJzthQlr0hVcPxoBLFmNR7CFlalVJ0pA1SpVjAWWqW8qS?=
 =?us-ascii?Q?jrz6mmSnstSp6S/JV7lSYgYhDrnNZYUFHSgzgNr5gvNsbHgrDVQF7hEkxwT3?=
 =?us-ascii?Q?xNzpsqXbOJzGEZiw30QZcTjhH1G5Tjz2tZT4G5Fd9QdHzZbfo7XCvBDWuHhE?=
 =?us-ascii?Q?9RomNVgztj6hWiMBI0eQ8FqiRZKB52W+TnUd3tre3poh5tW8vkVvgrYPJErV?=
 =?us-ascii?Q?xAUWtTpD92R2abNmVFhPblsOlHrQ2w1kGZf8+LY5D3azoZnl0BV6c/Ln88zu?=
 =?us-ascii?Q?UHJD7ofe4QpNSusBQLU50urpHajEF0YMjhGttPr3KSby7w6OuDuWLrQevJ/j?=
 =?us-ascii?Q?+xOyBlYuEGjTNRYijh18TQj6ljjVQCCiycxazE1k6P/YbZRb4yHTKLr67aav?=
 =?us-ascii?Q?yhzYnr0oLeFI70tFRNbg7SEsj5OIf706OQ7wlc0sjSvLfZBdBJ/dGKEaJJA7?=
 =?us-ascii?Q?ydrhXVzeX7GmplYchm8uvKLDcgyhSE1J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwdllMdiR5syhA47iB12fJJCpX/OnDYwJt3dsdGerstzi1dQjg/0+U5LHGVg?=
 =?us-ascii?Q?YdTXfNFKB6qaGQn+1wwL239tTsDEPT/d94b1gt4MpS9uDH+VrIEt5Z9UicCq?=
 =?us-ascii?Q?2ynlM6ygwxmMm+DDnyv1f62vUpuv6pI/CooxFD/tJtpcEfnkg4bdtGNhbbNG?=
 =?us-ascii?Q?jJnRQM8bWcGoW1Xq4k+1jMEkW5TX5FYpuud0eQLd9GTolEQuyXOThn6+4XtG?=
 =?us-ascii?Q?AD7WbQgAr9iISOUH7ncwRa6bQZA8JCUQRL+GpIfYrarYK3h13jt4mwVJ1i2M?=
 =?us-ascii?Q?QmABwReYSLsSAGptla2UQVnyvMY9yLb6w4ZMVEmhuIh04wexoks5Yi8AD8lN?=
 =?us-ascii?Q?aQc2iDStgPvpGNXjX8RoUfBt57mGsbh9uHgH1D4wd8eK0WCHZa6sSbDnUi63?=
 =?us-ascii?Q?E9kafs2AhOnqCbzh97+2IIIrap1b+vC9X/2x8PGRfPu76u4UDnSWbYwhVYCQ?=
 =?us-ascii?Q?g1vdVyAIe5uFkW93J+IdLiXiODgfG+IvVRDME9dEKDVOvFV9J/jlmFyosu0y?=
 =?us-ascii?Q?XzRErEpR2nRBy4duppxgxXxKnPAMR+gEsx3IKWQcQkdnyHA+Vhgll/GD1HXH?=
 =?us-ascii?Q?ZStEqc5PX3fArFOBCncLuUp5gOzhNEJPpDEtjL9GaQyf2VXWk+NPBDzJoBhk?=
 =?us-ascii?Q?zuelNY5oSC7rgAf9ipcGL0FohTFUGcdyX1BZ/zJlEgAI6X5eXpXtqMgYw/15?=
 =?us-ascii?Q?0OBnyYJMO1hf/O/P2D1GWWu8Y4jJQsG/xiHGbykjn3sbjPm3/4FFFiw3fgMh?=
 =?us-ascii?Q?Tg2E7tHPaRDThBZOqYL9/EsD//vvbRUWmyccDdbJNTFLYvu1wmp4wq9oKMN7?=
 =?us-ascii?Q?2VcQRFQLLr2NY8x5fdDzGCTiXXPSaBZ5X4Ddd0O8D/y8tnIQOSJECz3hO2un?=
 =?us-ascii?Q?k6zORDbgpTCXsDITeZjqVl/bV2GW+TXmVeJiNMDZapp5BUTCMF8EyWp5YbL0?=
 =?us-ascii?Q?uKhxIbtl63OTEQPDn+F2MCLFmYfAuHsClPK3hhQRw8OQ/BIAvfhsumBhJgHp?=
 =?us-ascii?Q?Lqwd5/DFdTbKaqfPdWyA600YtxECdfUS0q8wvtNHbrzSHD5XPfCRCjsaDSYc?=
 =?us-ascii?Q?s+yxh6s1JYJ0dbUrwbtxHYMIDBXYaEXKSfKby8RTnRY6YjwxRL73C6G6+olo?=
 =?us-ascii?Q?aon2tGToOk1+vmOGhDsMREsTyyS3CZpoDRA6INMyfyr88DfQqueXnJwTRJvZ?=
 =?us-ascii?Q?cJOfVfr7rufyTzkYSvLXuBVNh+oYRZhSrxyS5Ygug3fEG8DDTeLSk+Zxxd7G?=
 =?us-ascii?Q?cqMgeTdFQoXLQCn8bIr2oWnSHkMvC1Wkm20Vj8g05tzKGLXcRZ/AzdOVkqNN?=
 =?us-ascii?Q?h4IGxr3pBn2Mu2TGO344O59gvWgpszRzH2B9x3PqwQFSuSUnAewTOeKWdeWk?=
 =?us-ascii?Q?D9wRT/rQuPre8lKgIVopRgG+pCWNbB6svcydNKmxLR17paccm4NXWNwMgS1J?=
 =?us-ascii?Q?OHvulz/X86oDYVcHetqN19+iE51ML5Uxx/WugiQHniXtZbDbxr206BeC24Gv?=
 =?us-ascii?Q?WphXJilvELFf1v6CdE1znanRG4dA5RPPRXJY27wEap65EtyPWoUPXK7M0Qhg?=
 =?us-ascii?Q?krPmCJVJIIfp9gDMooI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17723f04-b805-4db3-7bf6-08dd5a704809
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:27:24.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQjLX0RTf/dZsgDMyfuuu6GaZPCB5uRQCGOOUInPrWac4gsP3hAKfqxjuuWLHnPw0d330ByiALYOzk8VviA0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10039

On Sat, Mar 01, 2025 at 11:44:50AM +0000, Marc Zyngier wrote:
> On Tue, 11 Feb 2025 19:22:00 +0000,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Some MSI controller change address/data pair when irq_set_affinity().
> > Current PCI endpoint can't support this type MSI controller. So add flag
> > MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
> > doorbell.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v14 to v15
> > - none
> >
> > change from  v13 to v14
> > - bring v10 back
> >
> > Change from v9 to v10
> > - new patch
> > ---
> >  drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index 549b55b864d0e..c0e2d806ee658 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >
> >  	dev_set_msi_domain(dev, dom);
> >
> > +	if (!irq_domain_is_msi_parent(dom))
> > +		return -EINVAL;
> > +
> > +	if (!irq_domain_is_msi_immutable(dom)) {
> > +		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
> >  	if (!msg)
> >  		return -ENOMEM;
> >
>
> I really don't think this brings much to the table. These systems are
> not built by picking up random bits that can be put together by hand.
> They are integrated in an SoC, and I can't imagine that the MSI
> controller is picked randomly.
>
> So my conclusion is that this is either *designed* to work, or it
> doesn't exist, and that this code is just dead code.

I think Thomas answer this question. This code is actually safty check MSI
provider's capablity. If MSI provider can't address/pair is not immutable,
there are big risk when irq change affinity.

https://lore.kernel.org/imx/87senwd3mo.ffs@tglx/

"Yes and no. The problem is that the EP implementation is meant to be a
generic library and while GIC-ITS guarantees immutability of the
address/data pair after setup, there are architectures (x86, loongson,
riscv) where the base MSI controller does not and immutability is only
achieved when interrupt remapping is enabled. The latter can be disabled
at boot-time and then the EP implementation becomes a lottery across
affinity changes.

That was my concern about this library implementation and that's why I
asked for a mechanism to ensure that the underlying irqdomain provides a
immutable address/data pair.

So it does not matter for GIC-ITS, but in the larger picture it matters.
"

Let me know if I miss understand your means.

Frank


>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

