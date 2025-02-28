Return-Path: <linux-kselftest+bounces-27936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D833A49FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741E07A2689
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6128629C;
	Fri, 28 Feb 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q0QL3S07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013069.outbound.protection.outlook.com [52.101.67.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99C281358;
	Fri, 28 Feb 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762481; cv=fail; b=qVHMt9JFXYLAxPB3C3qvhCjh8KtCOZIkxFrqmoOSmkmIIJQ2jDihkNev39OJHSmcJrkaXapMsZctuk9ZI/V4Eujz7mmexRZHFWxFGP8k3F5c55vra11NZiLxLnfzDZgfn/xAI9aN1WxHkvKfiCbf2whzbTSwcWmmClBrr0fGF6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762481; c=relaxed/simple;
	bh=iEuvskA5NAVhaSdGhvvkEnpufuEGUWvJbf5MtiSyOEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tX8JNsWYYxJqsLeRS4lGuJEzzRJcEv4S5+zpwQnjQhO+YxPlPLK8pwiLB5L8tsQuOYR+Osnxvv2MX1ENIQMGF9FNf4qb2iV0eSj5pppL1WdUYwpzHgXSx38Gm4vGqcErzdgB50CU1Pu/lT5ujjqKX1eAslxhjL3OESmUWQQ9ZSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q0QL3S07; arc=fail smtp.client-ip=52.101.67.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8TH6bdX605b7AFqoNOFPUFtX3/VEOaZKvt5tFtXD7ltfHNoZlUAZ/sNF4kjGRHhs6Yhq+Jy3LqnIclBsDqqWOgHRR8k4arPSx6S/wixGVH5KHuZhI8xast/CmI5V/d/qbtBp5ldv7TVFYnfqNd3z1qhUITWynStUG+cwgdvK0fb7n3wrWtEYAz/ChEcvG+S7JEFZAiJPxsvuDJf2dx0ibXx3Zj9mQnWNk/UHOAx1IZ0Q4RTFM5gbOu8+IR5BREae9C+JKqbc397/iAb/D/FfYltkUuyjQmnUF7nLO/cWSHkC0SIZwyB1nfWzdlXBIOemjYITLQHjrNsvr+03yfRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9azf/yJgzBeFm/Uzg6q67IEQEdWBzlyagDfRYHshJeA=;
 b=HoKs/Vgf5GT57P8VEA3zeMohbZws2wyhPfMeZPm4uSBjzAypLwGPDozoM5agvhagVS3m9cMVUy9hVnxeoZPzTZtNiW+tYiIS1HjEXdWUU819NKfLHOSGL/pa6DikqnBtqgyO8VKbut7dAwo3j41+Xa32kUbWqRowmSSyCfqmF1eKjVjeJup/46nUgRx/1qyn2iFKpjpFL4n8OG3RxG/YSS+k7MY+pxpwCps9ehdskuLlEbORpOb/gdUU//UqOVdIl7B+TXrLS+WSxoThDbTMUuJwp4p8cWgDfcp6bTXZDWMNod2Q1izpv6a3WX1X0KUVpILdZi4+x6XZnI+6OHq/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9azf/yJgzBeFm/Uzg6q67IEQEdWBzlyagDfRYHshJeA=;
 b=Q0QL3S07E28JURU0RFECgmtagR/t8JtvPuSFEmk5NPv2pgqz0YkiLzUZVuE4VasB8N1F1tD9V4URscQnLIhYqvj3fKFchXIGkQrRWPQ573lXrGj7MaQQFv6cb0lu3ntsMP0y8Z4mkeSUi7BMbGu+vuc65WwEGVaXrVziawwz8xKIa3R3IaXr8YSbWJtPiPtRU10d44rDcupMQChRm76Gw2Lazw7MPsaeOfpUmGVikRDC3F9mSB91qh/4uUM0ZIGoS0PynULjfTjkAP1dnNSnY5WQUp6O7EC3jfmw2mnWzUfh8w6ISuDr8oOcrhYJ/362/1g3eFCpiDBuP2cOpQVOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10531.eurprd04.prod.outlook.com (2603:10a6:10:55a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 17:07:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:07:55 +0000
Date: Fri, 28 Feb 2025 12:07:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
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
Message-ID: <Z8HtX05shTGRA4xd@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
 <87r03sgxf2.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r03sgxf2.ffs@tglx>
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10531:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaf0767-4b4e-4b71-2d40-08dd581a71a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPgzkbdjeM33xg2iPijQLsAyOSJNSOEljB+RkJHmjtbrB3nzG+njGK3tY+YR?=
 =?us-ascii?Q?uXY5PWVy/OS/bHS/ZLkNIXR01dZ8tJuOrhDzN/Anr5/6M+q8YmvJLJPnNbmc?=
 =?us-ascii?Q?5ubtZkkWhGIXga8HLBO1xB7ORjdEjd0UX0Ig/fXV8r3oIiW2BLR1a3LJPhdZ?=
 =?us-ascii?Q?gkROtvBd1sYMFR3JS7wgCeaAoivucsjtKjegNcCzH5QrvjBfAE9s4/3CYZDr?=
 =?us-ascii?Q?Jwdwzvw+534l7xnrPJTxIPZJuVk8lcdvtCzi66jk7Xl0xtD5JctcHT5vGXbH?=
 =?us-ascii?Q?VFgHHRsNg/qQ2RUfeZCWEVaBnsy2JSqUuz6NVKDTVPOAYX0lkQ4Lem3yijAd?=
 =?us-ascii?Q?XMDumNvanTxK37zHsWYJe9jJBjzWSg3FOch/Na+wtfoU85W0TBbx1vgYxTPq?=
 =?us-ascii?Q?OTESwgNxC1ASi0FSJgdxI+CSjAmB0/itdoJp8Pzr6ZiLzk6bGjJhXrzdCbeh?=
 =?us-ascii?Q?CkRs4hBwjPrtcNYvnsYKh/5l1MLL8VJNDI+elyeg8P82YHFEA9ElsEpaGwwU?=
 =?us-ascii?Q?HgQNX39e1btVlhalId4ipxszz4+MfOp+CjtihxyWc4lPzrQrHw+P+awV1UZ/?=
 =?us-ascii?Q?ONu9pKTb+KGx9IkV+M+sUIS9tv9QQphmuNt9bYAPOGkVlJcd9JXywNlZp+Te?=
 =?us-ascii?Q?jVHNrK2iUWWO4EWGEqwYlUjoPdJxFuyLU+ZEaq5fm5jz3PfKVrk61R8aznPd?=
 =?us-ascii?Q?WU3DscL5zvWFHgB971vZ131dcccUsyC1//ctb+xnE8WyVQ6V8q0z186lK8+w?=
 =?us-ascii?Q?MSKI6EoPfSC8TS5r1t+lrvXD9l0eR5FWv4lzWoxz4tOFfySxdqIPYz+RuepZ?=
 =?us-ascii?Q?rv643U3juGUE2R/mR0EBhaRX86jTD4bYd+rsdUQmIzoLcSbuY/+adbNDemK3?=
 =?us-ascii?Q?1uq1TD27chOwqK6VHlXGHy4rM+CqSIeM87ioOZVEtZq1275sBue1E8BH9upQ?=
 =?us-ascii?Q?x0ZTbWzxdJDOQSryuVspphPM8E6Vw2JKFIPYyUxRc2xmyZjsA5N2QRTL4MoG?=
 =?us-ascii?Q?GEQ5iKmILNJVKSTyhTKcuvYxgXPMJSIC2X0D8Aks2mm+Wy7U3bcBHFP0zRvG?=
 =?us-ascii?Q?KiMFBm8p6W/Dm2GZ8GsKrjHJwHoTS05+aLTbEKEuA0jb9QRQqgLalUemV4FF?=
 =?us-ascii?Q?lBbwhYF3z5Ft5glWSs1fy2SS3hUQRoHFLZrmZrrtEAMVE9Rs0ZJgP4Q4mfDg?=
 =?us-ascii?Q?2MwU+ZAu1adrRAEyTCoR1l7pZv5GLEzpEvOjGUtCH39DEoWhi2duMr4soURY?=
 =?us-ascii?Q?xJNk9/ry1FbZCIKFhP2vtntAzCTDnEDFKYQo2N7FOQehQ+3frrjCPzGznZbq?=
 =?us-ascii?Q?U8i+k+egqTa6NsfIb5BNkJNDYhbR3lX0tvkvLDhqrB3GrZaQBsEbH2KEBqav?=
 =?us-ascii?Q?ZOrISzpRW4xR0fFpf0+s8XJqy0vtIsewopRrbj98ugVGRTSCIWYoZCA9mCnK?=
 =?us-ascii?Q?86K5rVUPX0wPnEBg2+Pawl4dctSJb7lu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASW/G482Udr6qfNSyJNhaMQ7ExBvorwMTCQqXdkL4aRQyzB5FrWPFBsnNrHT?=
 =?us-ascii?Q?GS58U9iHIjyNmjcsvmKrcNmjHd9xPI70A4hOOYwsaheD1REI4/4IGks/jggc?=
 =?us-ascii?Q?OOpNRBqjGLkKqK/GrOsIIOgAqfG68/WkxUY1H6wr40USQ9s7NDrKTM1GIHlH?=
 =?us-ascii?Q?F3f0nNmCEpXhCV0o6LT+1onZxEe7fVor+UnFVyCpQ+5LYwayKr0IwkHYdZKB?=
 =?us-ascii?Q?sGQK8W4ibGTpCXuki8R/DLaEjsO3YhGvj1GbE7MTNJ+g/uoFtS+zPhSLXs0j?=
 =?us-ascii?Q?wY22qIRGPENP3Jd3xF2kkmLbskeMHlbBhK1ddpGlReJ+XD29aQTy9VvFOZNA?=
 =?us-ascii?Q?Ljv16wODd23vJjAzKz0abOrsN7iQybpbdLS93UYiMZl0eYYHwB+5rdkcZurq?=
 =?us-ascii?Q?do2M4A46wfW3hopPinyswqXfk6oWGfnF3j3nyPJ2Dp0LuSDc+KUaCDAYscNI?=
 =?us-ascii?Q?cf/w4dEH557btuIV/VS0CPcTY6+i0aY++6FIAyDa7KAXgsh/JWJmKGzQVRzA?=
 =?us-ascii?Q?5i2p5d8PKl9rmp2zs0kZhe36LSCQhuv7RUoCSlnno+Var3k1WNu3H0Cs6r17?=
 =?us-ascii?Q?X+l0JZm+DUNMJToHpXDCvqvlfHcVZL/6zI4MPHeM73gPH2dpLMY66sDhpw6a?=
 =?us-ascii?Q?7/JzFhX9FFcyIbxOfWJiobfjG9n8lQ8RINl3amQvmye5Fkddjf0kvpsa4B7R?=
 =?us-ascii?Q?7z/yXou1dc+l60bOA7vQfwKK1usK0c/CoRfCeFZ7I7Hyg/bWrz75snFCyZjY?=
 =?us-ascii?Q?Q1jeadzCJlTbOoki6J1cTTNU/b8+Pt6wpnBRCDG8soB/MAaBc86V6l2XVLVQ?=
 =?us-ascii?Q?SDw8jyI0r1V9krQQI5NAXuiDNmocFNE2qVV3CGYpjIRKav7EPedw2UTDr6Fk?=
 =?us-ascii?Q?0+DZLfX6V67fu1yi5drr5cbOr3Txe+UYryZ705rp/tCgjRP/f1yeiFV3X6KM?=
 =?us-ascii?Q?SB0tK0BmNz7NWsBZVConLXk3Y15e4t3+Bgu2QxNMiU9mJ6P8hhZasdLDGXVF?=
 =?us-ascii?Q?E07/NZJOxV54GMZYrXee5mOBHOFwiHomUXFUfRp4qms08JXyDF35LYawPz63?=
 =?us-ascii?Q?Nij73bj6XNHFQNOdhmhvwZetvt2gmXkQ+1YHb++j7oM9ypyoCJP1v3e/EQ36?=
 =?us-ascii?Q?4dpXfaFeAWspNQkiDrr+sAQTzgOtHw8b6IL7jzsNTtqthD1jUbStxd/Xn+7p?=
 =?us-ascii?Q?7PDkRwU2hebQ942XvLt926hRObb3g++6glVlb5uIxgXzB1xIdGh2NzjvrZHV?=
 =?us-ascii?Q?lMjWmHf98c+m027pF2OZG0i3ok7FXQm31+G7vHggVW3AwgcpY9un58MobCLW?=
 =?us-ascii?Q?vTqsTpqdpAj4sZKj2gEiYA1lmG8MLRCRFwUqlHm3NNF1k4L9grRf5uc6uNbr?=
 =?us-ascii?Q?kRtXYtd0Jd2xSwOsbEv7jWPbke+1uM3JNcaPfNj//IIqxB5ZPACS+skkzTjl?=
 =?us-ascii?Q?Fm8MXfCHM0BNUyUzCVEPELDbhdu2PgujXiUXr/p1V+rBzvTDIll8nEprPVDU?=
 =?us-ascii?Q?DOu5QdmWnCWKrkPPSp3xNMRvVKAP3uzS5TeJ9K146vrrvpJr+Kuc8DK3vX1i?=
 =?us-ascii?Q?gSoZjH/5+vN/1TpFKqWVs1IxJJOWY78uTCOOx05/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaf0767-4b4e-4b71-2d40-08dd581a71a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:07:55.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkKOekWPuBS9BjXXC+wZCcAbLb1WBkDROBR5tIIUokcOSdtZl5Au708VZYnTqD/sZd2+eSxTncwyqby1/IagfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10531

On Thu, Feb 20, 2025 at 09:42:57PM +0100, Thomas Gleixner wrote:
> On Thu, Feb 20 2025 at 15:01, Frank Li wrote:
> > On Tue, Feb 11, 2025 at 02:21:53PM -0500, Frank Li wrote:
> >
> > Thomas Gleixner and Marc Zyngier:
> >
> > 	Do you have any comments about irq/msi part?
>
> I'm not having objections, but this needs to be acked by Marc as he had
> pretty strong opinions on the overall approach.

Marc Zyngier:

	Do you have any concern about irq/msi part? Is it clean enough to
answer what your conern at previous version?

	How can we move forward? This help PCI EP side avoid software
polling status.

Frank

>
> Thanks,
>
>         tglx

