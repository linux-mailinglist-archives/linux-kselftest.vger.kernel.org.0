Return-Path: <linux-kselftest+bounces-30745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6CA88B23
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC073B3B99
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1128DEF6;
	Mon, 14 Apr 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iaMkLBtV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012020.outbound.protection.outlook.com [52.101.71.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD428DEEE;
	Mon, 14 Apr 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655483; cv=fail; b=W5pXduKrN23HBgQBqK25Kz+uA5icafU0F38DLZK/Pzx1pnmUCwtBEbza/TWTFRuq6K83JC22xy8gcY7ZiQcnQU2/JABS4jGuC2++2oN0Mb9GASXaZRmOyL+cdc2mXgg/YWt8hJSPst5DXuPcob0EhecNugiVrA2L8Xkn7TePIR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655483; c=relaxed/simple;
	bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qKv5IJ6F0pK2oM8Tyl31NEATbok08fW2rpRmsTDl9REPnJv7Qz1m84F80Rz54jVxz7JL9Aw7cUsFuJ04D7e7ndTevJr2O+TcuUpx6lKc+4czG6nxdkeYQMpXmqLpbYqMk9uqRelZ+5fzNYdqmUaNJqrl44MxBqJKgjswxDNTGZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iaMkLBtV; arc=fail smtp.client-ip=52.101.71.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1pqDlbAGgDAauyXKxbANyntJhrIE7sCzPSJjuHv6jZnUUDn67c7noEJF0UuzdtYLwrcklceOFa0X6aV/T4PdDo23k62S3xhEUBHFc95YjhuySwmBRuCrOjyVJi3Kx2Xk1l7IHDF9YlLK4hXeP4LaG6x6pu+W9ZUc7WZu/TGKV9PmiFW7c+3fQHoM7zE5FEbLRelYeqWjPoN+WQv0qhnMbgQMPtkdUH1Q2vmEtnqrqcOWmt5jESsALWjA7LAcZczF4gfg5hPxSpHhsHBocQt3cYfXU+NRlwhQsiBcM66FPuJrSWaBNUy7WlssTSVjmnu235sw5b6ShnPtLkqaPrWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=iVfzMfgYGGO8CtZaS2WNp0TPiSE+Gma46d3fiGqp0e++U5JRtbtKEY/ho/4K54qbxxGV1F7C9UFdd0/9iUgVcvq3XSRhy7BAGdgJX/N/MMD+2JouZnT0jAQiMcIFqze5qpGpxiO/41mDy/mpJSlrvQ5C+YICW3nDry+t4mguRivvqW+PhVCcARVH2puWKSDxIg4ZGRQC5JjQuid6Xt1Rjm6Ma5AdLXm6bJhOfGANncO1RzLYqfPP3HuqKv6HpAgal53tZ0CqM7mo7WNkqPLP0SC5+9bgGz9xxdoKDRKO1JoemNPsIgAEgOri5TSEdXporiYkkhsPmSgMDsr2JSfzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=iaMkLBtVsVHlOvG8bshFKtYpuRNUFJ+kJUJBkMDeYsjoYfEGXJnEOo9yAtXLmVppVp3TU0JOHmPwO8BslpDOKa0SuJ6n5KzWJX3lBUeh+GEiQzqNNu1EkJdN+/az7DMO3QjZ+wcH83TkDacZRi7RqDkjxiYB1nKi48RIHNU5cMCtZ1ianaEkId1/fmhvw7ePeoFx0GLZV4/RcYnqIl78EsQuBkDt5n2qde7FgibAYzfbFm6433DJZTXZAIzDBg2eiZyT7kpj9fEWIRDuEz1lyNsIlMDpKOfukfahwZHZVlMxA63Yu0jRRz5BcOe18e4446AOum/Tr0IHPtCuH61Auw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:30:55 -0400
Subject: [PATCH v18 01/15] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-1-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1529;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
 b=b6JzLr6TJS6NDSF7+zA4FSE24DWLtOJKbt3Y3TgD/ueri2IVpzWsSgX1kMdWz12VzLB7cq+Gq
 aZ/HGbPt7ZaAmY3Pj9O+OYYy2JabMuvbmeubwCSr7FR7xBvvjWuowOR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaaa865-23b0-4d4a-bda2-08dd7b828bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFlheGpFaXNCY25NMXp5OWtQRmdNOTVTdVl2bytQYjJDQUtSbldtb2RqVlVI?=
 =?utf-8?B?ZFpLaGY1Y21DRXVOQ3VTczNxOE9sU0xQUVNUT2FrRy83d3NiMlBRWjJqaWVX?=
 =?utf-8?B?MzM0YkpwVkhFb2FkVVNLZ2tBWW9iQ2RUbXBwWERUbWlxZ0trZjhJTlNjNWxS?=
 =?utf-8?B?S0cyMzZJTEJCb2pKbmwxSmpNNTI3aW8vMzZ0SXRyYkc0SjY4KzhCd1ZCZWFm?=
 =?utf-8?B?UzVDWFhuU3JRcXFzZDIwOVIwSFdaOTllZ1lQcDBrc3FJcks3VFdDb1ZvWm01?=
 =?utf-8?B?RVFyMEZjZy85UDhPb2pLWmNBUUxhWUhSVHRtZnZlcjkxK2JJdGZ4YjdrQjlI?=
 =?utf-8?B?bEthM0dYVDNncmZyUU1HUVdoazZPckVLdVhLQ0svMGtjTzZlb3NjWWtRWUtl?=
 =?utf-8?B?L056UFhsNzFGdEtqNkxMUEpVRXA2WENkYWd0V1VEMWFqZGEreGRkZHhWY3c2?=
 =?utf-8?B?U3dLMXo5YTJpL3Y1MnJlNG1pc2M4RUY4VFI1eGR6ZWE3a2NmcCtxTUk0VUZH?=
 =?utf-8?B?bHdwQWEwRHcrUE15MzJjalMxYms0Q2d2Ulk0WkJtSkljMUZhSmY1Q1l3OTN4?=
 =?utf-8?B?US9wRVpvcnI4dW12T3Y1QVh4M1ExKzczWnp1UysrVEdLZDhWaHI0Zjk2Mklj?=
 =?utf-8?B?U3VISHhYWEozZGw3RmdNT0xXQk9Mb3p3UUY4MzZkcXd4VVhKT0pYbE1TbTd4?=
 =?utf-8?B?TzQ2dmJIa0xDV0IzZ042ZE1RL0tueEx1NW8wNHBKSjRycDNzWTRRdUQwWWFu?=
 =?utf-8?B?Z3pCR0N2eW93d2ZyQmo2b2txaGpGRDNrNExBQWhUTXErU0ZicHFaaHFUeVkr?=
 =?utf-8?B?WVlJOVJ2c2l3T0lYT1dvS2JWZkNwUlZFZjJiZ29PMUp0S1JNS1F0Q0hGSmh0?=
 =?utf-8?B?NTJPWXVqUFFFeGROVElkVkFESTc0TUQ0Y1VuOXN0dGZmYVNHOVVadk9iandO?=
 =?utf-8?B?bUhCUzJzNlBaUkVIY3RrS1oxRXd4cGFtWEhJb09BL0VaTm9WcHp6dUpVOWdU?=
 =?utf-8?B?YWlaa1NSOUd3NWt1M0dVUHVMbVhKd0xZSE1uaHpDYjNaeXcrSEtKRm5NV3Nm?=
 =?utf-8?B?MWtXZk5Ialg1aDRNVlprcFI3dkpKQS9BQW44Nk1oYTFqVTVBUzBuRHlZY3hv?=
 =?utf-8?B?N0xReFFsR1plV25HY1dXN2FkUTYwUzlxMk9UdDlXc20waFZsSjZjcm45a0l6?=
 =?utf-8?B?cCswYTFPU2VySGRsdHZ6SXM0OG44di8yRjlIRStlOVdpeml6WHNIcXVkemps?=
 =?utf-8?B?U2JJbWREeExiV3Nja0Vua09DUXJPSEtncVN3aHUwMGN5aTdhREZKbkxDRzBI?=
 =?utf-8?B?S3NCVysva2MxK3dyamhSOUxqbEhHQTVtT05pVW9PYXpkYnk0OTJhU1NUd3Ns?=
 =?utf-8?B?NmNyTHBxcGgrSkhZOHc4TkNESys1bHZpaGhFTGd3WGF0RUZhejk1cG8zWHhN?=
 =?utf-8?B?VWZzek9MbHBuejhkc3pBaWdobFVxOUJSVDlpWUxCdC8xOGd4TVM0eFFQRm9v?=
 =?utf-8?B?VmgzM3JrVFlJMmNqYnNDMzJ0Q1p1dTNGd2FyYm9ya3daQW1sd2x5R0FzbW52?=
 =?utf-8?B?WW0yUVFaRGR4U2dLV1ltWkJkV1d5L3M5bWZuaFRVdVFXYXJxMVdKeUU3TUQ2?=
 =?utf-8?B?a2ZiNGJ6NjUweEhxM2w0Mm1FUW9iaS9aYnJRMzhSVUJud3VPOThGZ1huaitH?=
 =?utf-8?B?UFNvS3U4WGFpNkk5eUVzQ2gvdWIvT1pVUjRwRGlyTVNrNDNYVjJjNnVRUTFL?=
 =?utf-8?B?YjRyQzloMFFndzhtVW5vNHVLY2Fjb3VOUFNmdGNpMXNKK201Wkhac3dnM211?=
 =?utf-8?B?bDdRWk9kcmlWZjRSU0MvNU9pdlAzMGpBTCs2MjA5Rkw5ODFyYVpRUzJ4YXhr?=
 =?utf-8?B?YkNjOHY3WDNQZzcyeGdnb2d1a0E5dUxUOHZKUFdNQWtUczhDWE1SeC9wSTEw?=
 =?utf-8?B?NlMxdFZaaE1rNityMERyVVhDRlJrZzI1cndMb2U4elBhYnorR2VPYzh0KzJn?=
 =?utf-8?Q?ZS0GheY4i0ppMAnwdkkiZxLt8ev4Ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Unh2VjYzeFhlNlNJODErUVNpOXZqRk1MZU9adjJQeS9rT0l1dEtnb2Z6TUdC?=
 =?utf-8?B?Znp5c3cwNGlKWmF3SXV4Qys0MjRQYklNSHRVSVZOcVNKblBHZ0pzY1l0aUo2?=
 =?utf-8?B?ZmthQTR3Tmp2RXV1TDN5YzU5ZFdPbk9ETnlsTUZHeUtpeWlzUW01bzdHbHV0?=
 =?utf-8?B?WDhUVjA2dDFKSmZMd0ZRYUl2cUNYNDZVT1VuYSs4M2tUOTFMa01VVXJnRUNW?=
 =?utf-8?B?ZkZXR3R5Rncrd2ViS0VrcFUvTzVrSlJISmNkM283cmh0YUJFelVWVHlmdHRs?=
 =?utf-8?B?bkZKTW02d2E1WWNHWEVMOUIrVm9xMTdDMXY5d1JBVWVsTmtXSFloeUt4V1NS?=
 =?utf-8?B?dmE1WEwzSld0SWZMT0pVUlVPVkxXd2tFNFFHVXdibVZVODBmVXVHdEFNRC9y?=
 =?utf-8?B?dDRYQzNtYS85UU5FdUozeUhVK3p0bWtxK0tpbHpOVG54SS80M1d3a1BWd3Ew?=
 =?utf-8?B?RjV0a0J2NjZVREZGMy81TWZJalNFcEdzWEx6djA1Z1l5TGtRaUdQTlk5a3VE?=
 =?utf-8?B?a05ucjJLVG1FdTh5VGQ4ZXp2TDFZK1Z2MzUyaTQvVWxRVWlFK1R4d3pEUWJi?=
 =?utf-8?B?ZHRBYmFSem9sUGxIYXlwS3ZoTWIwcXNsdHhqTHVJNGl6VEY5RlNmRDhPbVdi?=
 =?utf-8?B?SzZvVWh1SEVraWVrdVJxMG1LVm5mWWJsWjZuLzM2cGl2dGd6QkI0ZjNxS2hj?=
 =?utf-8?B?eGxwaWdtSEc0cXl2Q3pYOFh5M2kzanY3Rm5MdnU2VlpFUDZCOWtZVnlwVUMw?=
 =?utf-8?B?WDVMUTl0am5JY0ZONXBvSCtUdmFjZHN5enY4bFZZaG9pQ2dEczJ5VVFpK0xG?=
 =?utf-8?B?VklNNVRIUDR1UmZPZ29RejByTmY0Y2hTVnhSeDR6cUJPTjJGSjZiNzJjeW5V?=
 =?utf-8?B?T0dPSStMM0Rrdmo4MUhReWJ6akRxdEh0d3V3Uy9oc3Q5Rm9xeTBWRld6bTUx?=
 =?utf-8?B?bC81UlRqZ2FEZlBNQ3EzQ3ErMTFuN3RPWmwrUk83bzNpYmZ4OEZJTWRPQkR4?=
 =?utf-8?B?WlF0QytNWXowcjdSemNyNzNrMHZYOEhLb29KOW5sZ1o1WnNGNCsxb080Zk55?=
 =?utf-8?B?eUluSzNZZ3lQR3FUYUM2RVNKUlp3Z0FFZnduVVo4anIwQlpWYjZlYTB1U2pu?=
 =?utf-8?B?R214WjFzUWEweGJFdkh6NlhYM1ZVemFNcDJuR1h4czM2OVlITWlOekJXejhO?=
 =?utf-8?B?ZHRrZXd6N2J1MjREc1hZOFN0RFJWYVVmeHdRL0tRLzNQMTJZMUxzaHgzZGlr?=
 =?utf-8?B?bWFRREYyWExMQ3EvRWtjTjhuSFFLWENTMXFWVHBJaEwwRGc3MEVJSVVkcDdY?=
 =?utf-8?B?d1dSYTRtZXB3Qzh0eVhocUtJaVZGVVFEcU8rU093ZVUyYkgzOE0reUp0Zy9H?=
 =?utf-8?B?azcyTVN1MnpnK0dDc0JkTS9qREY0Y2ZqeENNK0RoMU9nOGpXcUpUbGVIRi9C?=
 =?utf-8?B?V3NqVVVVdkMxS2RHbHQycXhzclB4VjQrajR4YUdNVlphODdwYlZrdU9IRW9q?=
 =?utf-8?B?enQ0cHpKZHpSWW1kQWZCYkR5NXg3U1RtZFIxZTl4MURHVHFXaFNPSXNHS0F2?=
 =?utf-8?B?OVVtMVBRaDZydUptdTh4K3pnYlUrbm9TcDNGdVk5aFNqTHlqQkpqd3RyWVpk?=
 =?utf-8?B?M2VPL1Q2UlpRQ2VNTEJSRTgrb1VPbEVyMEZUbkV5WUZ5QVRLOGxvQUh1d0Rr?=
 =?utf-8?B?VFpqQk1IRllXQ0J0ZnVIKzFleHB2eWdnVmVJSUxVVVVUaFo1eVpRc09wdkFZ?=
 =?utf-8?B?eFFQVExsK1hjUXdiRlJReWZwVlZRNUhuQVp2bEtQUlNBWFpZYkpVb3l0OXBj?=
 =?utf-8?B?TlhZNVo5RXZhdHZxYjlMUm5PQVBpczZmb2VyOE4zTmtJZ1h0MVk4ek9SOTFs?=
 =?utf-8?B?UjJndXVnNTFPSDBEWFpVRy9zaG1WRm5xdk9FeUdPdE9XY1pjSXNjUTFqVmdy?=
 =?utf-8?B?SVlsN2hiV0Z5WkVqTFlyMVVBK25yWE8vYndFL3BVeER4SUtJRVJ6SzhVS3pU?=
 =?utf-8?B?WHhmZWJyd2V5OSswWG1wSDIxL0hjbkpmRUdRUWZKTndTVlpIejA3OVdyaldj?=
 =?utf-8?B?TkloRnQ1dEFNemtJSGZkWFJhN0RnYWVlb3lxdE9nUS9CUUFxRC8vTVVyTmpq?=
 =?utf-8?Q?dvac=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaaa865-23b0-4d4a-bda2-08dd7b828bc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:17.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/j8mmzCHdFMWM5BxuBFX8x9Hw6aw3vNK3MVuzqrA7VjpIjFYygEtTmYNDlGt8GmGiFC9yKmjXa50cpKMhFZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

platform_device_msi_init_and_alloc_irqs() performs two tasks: allocating
the MSI domain for a platform device, and allocate a number of MSIs in that
domain.

platform_device_msi_free_irqs_all() only frees the MSIs, and leaves the MSI
domain alive.

Given that platform_device_msi_init_and_alloc_irqs() is the sole tool a
platform device has to allocate platform MSIs, it would make sense for
platform_device_msi_free_irqs_all() to teardown the MSI domain at the same
time as the MSIs.

This also avoids warnings and unexpected behaviours when a driver
repeatedly allocates and frees MSIs.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v14 to v16
- use Marc Zyngier's suggested commit message
- Add Marc Zyngier's ack tag

change from v14 to v15
- none

change from v13 to v14
- bring back from v9 and remove fixup and cc stable before it is new use
case.
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0e60dd650b5e0..70db08f3ac6fa 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,5 +95,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);

-- 
2.34.1


