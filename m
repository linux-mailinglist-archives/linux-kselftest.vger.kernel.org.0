Return-Path: <linux-kselftest+bounces-39682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC30B31BF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C3644589
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D7322C98;
	Fri, 22 Aug 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bScIB7eP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496A31354D;
	Fri, 22 Aug 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872706; cv=fail; b=U5MERKTGxbIpmvokg11HhUHhZg4SdPXpvgUPTH+Mp+6huLhffh9QKF1cobt4V1GkyJkPiogNvGyrYepRoipsK7Jb4ZpjJ5N/2+owzpp1BAlHTjb3xrFzrPlbQazgeGryMycDfPiI+X1eMji8m/4A5YtryPKduQOoGFG92y++U1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872706; c=relaxed/simple;
	bh=ddQaJGLp+A0HbB9LpRsj295dAUbhzDgzL5rtv+7IqBI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q6uLjDWbop+iIE8oozFErLEnK+CPqrZC5xTpIqhUON/7BgmVKij+mjd9uIyPca4sUghR02iTOcfBeilnShx+GsZxRs3KI6mJyizrtKqbY/wG/01hNJJ8ZXNiHosqE2/qDqUCCFqjktxV0g3bmaUFutzgldTxh+NaHmdpPmr8rP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bScIB7eP; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2Se2oJMM8jj40B4c4/mF95VujdQnVaMVS3g/SrscWAw2l0eIDhRKC1A/cH1LXMjQRioL3POFZYNkTF3LIiEYgVHpWOMwGgCn9QPit8db5pX26855HpgYc2Rnb/JxqaAntNpK6TC8usn+dXOpZ0zP1cmYnCq9615eHzWgVRM96fW8qntj9541uqyjPCv7/Vnc2GFzVVky4/sZ94hSCqbrsVVJkzFP0V3A1EkEkzK61cYCvSRnxUmz+6fz3/hT3oHrffH5NScPQ6xLG7VlVA1k8seeUcN4fAIpgw9O0TPXCw6yA06QpW3LL/2FcQeeprlzpiXstWLuczbYei+6YlKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/MRLf+/uqQ/um91M/VR1FX/Ncq2w4IndTvQXnXEklI=;
 b=E4P65bCX3NMYaaKvYs2baDyRHoFyF1f8ZBtgk/pfYdvjG4NvoKYNLboDk0806/MU0zfbY/oqOkjlZOhfZRYv3V9q9gOpyfMSjeljAZSgj7vF8OPXtUHmvdPPlITRzcgMaSLDnOvCbi6XL8M7IGkwzLRybnIC+CpMkmJ/L3cSyTz2QxrIjJ+f+ocM3G+iMtNKR5tC/Nwcra1ndxQsWRp2kn5CbLE52nanTjIsYCNBYNPJaQ0UFt8PhMw4H7YbBqLZeoZuXZPiUewxIGGGppGewuJucysurimRPh4u38d/bKBMotgrFLjDbq0XIC3JdS6biKeWvOmL3lg5V0/fjgmTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/MRLf+/uqQ/um91M/VR1FX/Ncq2w4IndTvQXnXEklI=;
 b=bScIB7ePV8I8TM9tCdXPSasch2Eva2ziS2+Zk8+SiK0oJumAtzSVWRgSFeYHNkaq+lI5w7SLnZWNBsnK2jPPHXt1d1e83q0oSIXrTB4onHwk/NYWcCQqD2HDTk84R6mX5bKokBVXQjhpdHD2Rg7m+68j1CHa8SqbpnwL0ER2C11p8pUTfFrCRqt5zkZjFDj6mAWsz7ubhevKnN/nRE+/zgwHgTZArxe0DqQr591nQs+ImGju3RkHZ0RPMniRUMwftf7ftDrKuPj9PLx0JjCth9w5+m7vS2kGViXxE8O+29hXzNdhwNIvXVIZD5jrytVtwNEWjyfrWV/KnVwSG0fzgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 14:25:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:25:02 +0000
Date: Fri, 22 Aug 2025 10:24:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v21 9/9] arm64: dts: imx95: Add msi-map for pci-ep device
Message-ID: <aKh9tPZOtxyvOcCg@lizhi-Precision-Tower-5810>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
 <20250710-ep-msi-v21-9-57683fc7fb25@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-ep-msi-v21-9-57683fc7fb25@nxp.com>
X-ClientProxiedBy: PH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:510:5::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 650ef085-fe38-4e21-2539-08dde187ae8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KmIRLChX0iyM3fAwzTKy9f+V5JMDmhBcBQztlTGZih4eYIXzSI4pt/wln3r1?=
 =?us-ascii?Q?HtYBi6HMRzyzFsmtW8ZtE8jXr/GzeI+PUKGtLwHaGuTMTOfQOj97IrQY7PFA?=
 =?us-ascii?Q?hBMHWbjdoEtCw8iXIwR2z1OQwj+Hn3Rfrkv5rrpbbkkPKxX5NyIDmkYAiZGI?=
 =?us-ascii?Q?mJ47gr8U8Ve7kH3PEpXmm72gOTjja4GV/PpB/rThbiIvJ6cWCa/vqZdX/NKd?=
 =?us-ascii?Q?FDwjaEZvS16Raf3rhfltMn0FlUQVuow7bk4l5g5eAIrqBCZXq7L8W+PcOtCr?=
 =?us-ascii?Q?ow4b8VInMebpO09hEwkuWu95PFLS8sg2M6DYSKWDHBezhPud9xYkgiCs12Pr?=
 =?us-ascii?Q?eyFcLcoOd3z7MQum1hICjN/+SqIu80smJ6cut1RSRtTweNRSCWy3Tuk4hfG7?=
 =?us-ascii?Q?3x8m4CxCzygoseqztYUK/YuCVfceaizhI1UQj9cbeZIQWcADm7AVJHV+GGwv?=
 =?us-ascii?Q?UOoQoJMlZEBcBHIAHxyG9oEaayMXU3vXWA2pNBf+T0YwD3uvjpyNhEkxrcgV?=
 =?us-ascii?Q?mQh7ICACqzZHVQ+CDf5Qqv6Lv1tlrabm5oFYuYoEJ4gLito10zFBHNeBrIGU?=
 =?us-ascii?Q?rg85MQHzkLuxwdXYL8QYVCSFU50ljGdL696hBlzIp/17Y5Q0gsOGk+Z26aus?=
 =?us-ascii?Q?IV8R+2Uqrgpt/UBoGp56Ag//XjzPb0+erWA9c27674hJkE4N1fTBleKYj2cl?=
 =?us-ascii?Q?LdBPVIvaFFgkIlJZrwlLMrfZpNXTQCbDaFalJUtHmJ9PgVZyzYogrbHldu45?=
 =?us-ascii?Q?HgbQbOg0rphiFYJCEDoSGG0cFzTShtBK71wl97mNz5eJrmDHxqBuMtVU1MBy?=
 =?us-ascii?Q?jgNk461yHLf1rXTfp/zrdQ2DFa2jLwm+Q+5FYzjOzhKR79s25ZCtfF0SHZj2?=
 =?us-ascii?Q?6dOKuHokkEO7FEAcEkya63IKXFbgU7YdMn6CMYJ8u2hkSM+CWbcvV79X7Wv7?=
 =?us-ascii?Q?fqT3CCXZ2nqb/3I/a5yx+1KMs/oOWOFKreXZcAPlIsxhARHJhpECGu9sTgE1?=
 =?us-ascii?Q?A1IjXFVLpfTJtAGE4uE5Tx/3GeDKrhhraOsq30rd21Hh12b9KyhfhO06Utys?=
 =?us-ascii?Q?fAEiXyawgFq4U2W7g+3GWq8Qa3SfFenBNCSQRiFp3aFH6JeY1Pc8xmSHuytE?=
 =?us-ascii?Q?0Rp7F+QdMry8ZEWupqe5A70yXPxS378GfRD/g99PU0BCMt8GSt2XNCfh3O1F?=
 =?us-ascii?Q?tQg0viv7GMHSEfx6kEQHo2yxKPX3+K/Za9YZfMUkFtf5z+exeNe1182nbe70?=
 =?us-ascii?Q?M/sKgPSi+E1x17d/zf3NJpUj7wGSnhYb8B0Ti/g5TIcszos0s/euZLKV5Nna?=
 =?us-ascii?Q?QLKbYd7jTYQQ+8qvUKBnEKJW/3/sklqPQ9L+4sxoBWtwVbLbRbjAYFSEVGoz?=
 =?us-ascii?Q?t7oluTct/9TKNJN99EMVF/6qO3AteWul2wA6m7sIKFm2wCCDainOIh4yao0K?=
 =?us-ascii?Q?IqkkN2QyL6zhTRsbJs7gfBZLzut/IO+68mniKMCPK1SUtbb8VEVKKQ5aJ34L?=
 =?us-ascii?Q?GLVXhiPPZbTpeKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bany5BYg2YRlCB5/6OVcpWg2B+xnrEp/wsKpWlIOBmzF6ZwsEUuNWo57BaCG?=
 =?us-ascii?Q?T3tk2u1H6FdCUdymvsxpLJuZkYtLlXRK3/r82FO0OmWVjsEzNL8aB354kjYC?=
 =?us-ascii?Q?4QPEILtteuDaTcdHl9V1lRWmPAm5udPzZqm+AqQv2tOBXYFt/CiWOVI6iLIu?=
 =?us-ascii?Q?BOv8SrxkOKV75qwYjEHEFc3wSMRnLWpsHNAM6PGUOq3PKJr7tVZu/AfbmsvE?=
 =?us-ascii?Q?zH0KpxpFGzJyARSnCVkPcxE+scUCCclREMjGx9ELW8xrxiCWxxX68j+soKkt?=
 =?us-ascii?Q?6vH/6gY5bmMCK837RUE/12EloPNjXcNSMoGMIvfxJCfUwSu3S+DpvKP+W/eL?=
 =?us-ascii?Q?9wGXGIBB5j1OfKCrU/29XjQZQM+ZQA6iJ84XItID5yHl7rsPwqKH2IB2v+GR?=
 =?us-ascii?Q?uwDZNa3UdSCWxOU9fLSbLd1X3DzF3yAzrKWZKFCk034N9SSGadLgeoD7Tq0o?=
 =?us-ascii?Q?NoP+m1dd3C3v5X/qWxB/Vbh9pTHze2aZC9DxsH3rbvZawHSSOZCnba8VqAOx?=
 =?us-ascii?Q?twUg15+TLrJHFt69ccNsMY4fiyrlblltqILRZIqRv4qmyRca2pRSjUIxREcJ?=
 =?us-ascii?Q?6wheP+N5+WzDcyF8ciGLBMGY9QR/WrRrkHTzH8MF0nbfrqsQY167NJ6drCkf?=
 =?us-ascii?Q?jCHFawbEBrw+GlsQmLNhnpfVT7464tZUxHpES/BIBTzoYTA1FO3zId9EVL3C?=
 =?us-ascii?Q?miHMHiHN50dnzImjDEqBIy+GdUZdvD8MgIMDGKurG8KKYo7P9mQIRm4yDdg+?=
 =?us-ascii?Q?JG4A7hjBSzBx6K0BIwzUL0tTY3UmMUWB1GojhpEa3AzeMza2BxBr1wdre63j?=
 =?us-ascii?Q?uFpF0M197WRTX+VWyYCpLhRgxBv40cy913th0QSKguN8UP7h620ZnsJN3CmU?=
 =?us-ascii?Q?4BeLqIArzw0RCWICs3G+NRHj4UkCj/Ax19Qb9ozz5kTHC7cwySS2Ci7+uUT4?=
 =?us-ascii?Q?BnhK8Ks9843AiB6QofRhwD0vJgxnTei5I2CF8BXw3kWIYGUGTDGW0OvGA+sL?=
 =?us-ascii?Q?pGeqYCiIjiko+XTO1CM+hCEAEJr9HDnQr9PEF0T64qNvaiLtbp54EJaQcGrA?=
 =?us-ascii?Q?CmJM/R3tDk+SnoJxApVnO88+k2D9GOyrUnzf6BWvZKoNFvAiHbAfl+F3kVLJ?=
 =?us-ascii?Q?h9FDxLPMu/DNfYEkIqcyOYbzMBItXOwRqV+MrnTf1tM1Mg1h7VKdG2VIaPgQ?=
 =?us-ascii?Q?GGQautNm9CgxgBBUqzaRqlyFl8q356/Pu5uO/ZnBbNXBt1gp/NkYUNj0Mn1C?=
 =?us-ascii?Q?gXMT+kmqzrUZuqJZLmdc4j7JGV5gPK43l6Y/vWFxgM4m/dJYM8uxgAw1A2lD?=
 =?us-ascii?Q?csHetHuJtPWFirmj+E6cyB6CLrv6we7yG7HKh4MiagincVaCYgrIoRIDGg6h?=
 =?us-ascii?Q?V72zskrg1MuoftvFZ2eMYyGES9vrKo1X/DyG0nn/6Cp/fifkkJdoBnS+tlND?=
 =?us-ascii?Q?BWiB6q2AbMN+I3wjKBotvIsl5ZlK1fzspFob48cAu/hY4vy2B1bmLl88vjrb?=
 =?us-ascii?Q?4jqFOSFRvfpSKv5t5YjWFeP8p+TdsQnvuqhhRcR6RQxwZzpGRkl7Jjt5KZxe?=
 =?us-ascii?Q?jtRJRx1lsSxVS+jGYXAVvAmv97hJIVIhjbRCRSKc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650ef085-fe38-4e21-2539-08dde187ae8f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:25:02.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYN1MD0x1aA5uyGo+umCoMFdtV70Yp6lvwW32bsPiUYMy68+84v7m6k67JM0vXFXN3phvSry1ck7aOYVvDMxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

On Thu, Jul 10, 2025 at 03:13:55PM -0400, Frank Li via B4 Relay wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Add msi-map for pci-ep device.

Shawn:

	Other part already in v6.17-rc1. Can you pick last dts patch?

Frank

>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v20
> - add Manivannan's ACK
>
> change from v14 to v16
> - none
>
> change from v13 to v14
> - new patch
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 632631a2911224cadc16a943cdb467e091e43384..c59d11eb7a581a500d381ef96f1e44533052c2a2 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1797,6 +1797,7 @@ pcie1_ep: pcie-ep@4c380000 {
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> +			msi-map = <0x0 &its 0x98 0x1>;
>  			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
>  			status = "disabled";
>  		};
>
> --
> 2.34.1
>
>

