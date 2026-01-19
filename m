Return-Path: <linux-kselftest+bounces-49411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0BD3B7E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A33E4301D5E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905572E6CCD;
	Mon, 19 Jan 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MQPtyHxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794525F99F;
	Mon, 19 Jan 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853002; cv=fail; b=bBY4JXRYM/3KHxxfg2+mpokJB1R4bAtH9dUISshu9U8NIQzYaUyMJu5mOVMUhR4NoXgfv0Usvb3nICNX2QNtduVyLZZELnvuLIGDda1qjIBXZwksBKknZXPqKxH2CRMJoOdgkYS9QmraA68kbwtu+a8WsxZv2e0BJQXZv/+z1SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853002; c=relaxed/simple;
	bh=dQLAnRcogwOsLKj/wrB5viXCBpFM8tU2eDfZwYIriLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LkG37w1iAj1Tac/CftSLXFXuQK62dL99AxCbuZdGtB8QVCBqO9nRW+F+/ANI8qPTe/upM2ob74En1iRueuaEdRb6ynyA9bl4USBXFCAitqLpNIqM7eOWwGtorKi+PVYHzHqXSZwKUINQkLMhNc4WYOOrh+jGYQVMf2mJCVsVNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MQPtyHxe; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur29djQ2m+ac/NcH3U+a66dHAQlcYME+IX9atBSK+qj83XJmdAOGNHbTXvsN0hbBLx/Md6eUQPMpIoc5tCcZ4tMaG/Zq4ZcN0dSmGB7SoZN5O0DwdnBDByLTwR/XZP4hwXpMZm1xbABBLUP42oiNzw4MMlJcFso+1CvPfPK0e/VDB6nsPgKO/+x5j+qs/trNaMQ860TxJeqbVlQiyym5qqeN0S+5zjdf/glc9ienfC8UPFsrICda71iPmbtVhXQzwP4EVdRAnieDBDtToP8m0VlZ+FVVKR2y7N/mi2zMkZ9Oq/xHJupjiHMIHDiRlzwolKff4sTVrIvYgGYAUynwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaSXo1rpIRv5SE6rxs1UNnszr/fUh6UqeU5dPPyPSFY=;
 b=WvcakIxijVyS0Q+Y7nM+HlVUR2rCNjvUduuKRBzfD+reQP/Of7/QksANZBMJ5lASi9nNRS58A6nHPIMTG3DxYgeDvGKV3uC24GQrYLCZ6COPYTgb5lqaLtFQsZ3oPrglwHAIUb6DJL4uzPnPiO9oyYqieZLLRVh29RVEqRNHx1TcQC01IoJ7Eia5emsyUu4yzoL+dPbDprwDNU2PP+tnTLPYGqnliQQJ510hWEREbKA/1X/BaRPyPTEwOnrXXIH7CQm9DVGr/POSTfqTjbEF4LnWnJi4h4Oo2ZPCISOcGS873Vpjv8xdC+W6kLfV5YDuUW1VjdX4s8PojDywHFxPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaSXo1rpIRv5SE6rxs1UNnszr/fUh6UqeU5dPPyPSFY=;
 b=MQPtyHxe8JPnTW2IKBVBMFhCrVaSolouv+3KYai3rKA4NKQ68wwBB2tAY7Dm+yAWWgxfJjwm3ALuhoY34UtRXJy0So8GYnlkcxSgCepkjvrMGcKGQY7+KMHHI1PRdmUt4sZYOc6QPHmhxE/rY0xKj/W3oSoFwgdYh6STQSyTURSJuKBXzzCVAHROsN0YvmNQokmkF1pxitbcRRy5mUg0Qm7a2AjkTtOBjfuiT8wQRI+3XJLRTCsEJiHtDv4m2Un1FMJCkOrbL9ht4fLeDNn9K7WdOZdCO1lgERHB/3mubXa4bK8y9/rZSTZvHGjebSe+gqwlxbBwObSqEMkL4ivboQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:03:17 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:03:17 +0000
Date: Mon, 19 Jan 2026 15:03:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 08/38] NTB: epf: Provide
 db_vector_count/db_vector_mask callbacks
Message-ID: <aW6N+6r/Cy+VOYnW@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-9-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:806:d0::6) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: de48eab7-8b61-4ed1-8604-08de5795c914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+bWEZbGzNRQ2aEaXo0/gJnfZh/Af2lcZujkCpzkRMJggzkZ+rxVk1ZCHgJJM?=
 =?us-ascii?Q?pqEN81h+UOlvW2TrRDmr7PmskeH0UQU0rwIOFad7nCSj4y16JyU3dxRv+GPL?=
 =?us-ascii?Q?RHShNuJL6NhbB3eYbFrpKEWRA2T9rt0Xds5HmPvGkUvjmAEmxk2Au8EgFlHP?=
 =?us-ascii?Q?IQkWyRxbEi4xay25of1cZzGNdqfCQgy+WbfL92S8VPb5daCXc9FbV/nSZFUZ?=
 =?us-ascii?Q?81U0jjPD2J5achKK//oSo9S4UJFJ/z6aoofV4fcVfqSLYbSQ0fWlwNXdwjs+?=
 =?us-ascii?Q?LU3iOZTZSic7p8iE0R0UDCbH6R/5pcMNRx9ozhSfaC8IN5o0cYcoTPQx1Oua?=
 =?us-ascii?Q?Zb4yFhbr63uNgQ3aYPMSqaQOTzokmlPfg3dzO6/zhkKO95C7RZH8K3OPFABw?=
 =?us-ascii?Q?qzMmIwMfHJBWAa/2y9XtXbYB5FXb64UCXu4t9JzVanNLzJFdEaHV4d6d0ypB?=
 =?us-ascii?Q?VB0FjgPXo/QL7Nj8KD0v9rlShWOMD5WRNgY+j0Pmsumi0RKsqWH2uWeBvFaW?=
 =?us-ascii?Q?YW3SnwdLRG90FkNB8wBD6QXJD2mzGtNuRFjDMMikrYu7wioZJBDba7XSJmdg?=
 =?us-ascii?Q?qYmttvTm/T01e7sxX5T0lv32UdNowKGp9Ooacxz3wW1d4i0a4esGYBQbKFmk?=
 =?us-ascii?Q?3bV3RQ/jFhZ2WR22hQbEL8RdrnunaD8qaRBoulgoeuDhnjvakKfL7vZQ+c8/?=
 =?us-ascii?Q?3sCbyUJJSu8yLSpSvmFFfOPN1WJAoAkNMQ3NcMVjs0K38Du+5g4uJ3BlDp2o?=
 =?us-ascii?Q?yeVC6efSrmVMUa2/0jnvAMWX/L4F8RCFzJdxeTDyyBiCQ94KqbKnRWMdw20a?=
 =?us-ascii?Q?8AzZSssRrN+TWQUa4kEs8uTtPLmJKRpviR5SFsgWxCEK5g0lXeIbzCu1Gymm?=
 =?us-ascii?Q?Ert0muEqrsINzpD41ee0ZX1PMfLL+2flwCioRUj6+YsMj+bJ88x6+mknlkRl?=
 =?us-ascii?Q?O9ms5ysImp1sKviqDNEuY0u8m0BjhIxe3gaO/EXZGPWe40DX5hUuRl04TG5C?=
 =?us-ascii?Q?RmaANukSwGfIAm/iBgPR7ZhRPt2zQo5JooDd68qPL2Yx5YEyv+5pLnjouEE8?=
 =?us-ascii?Q?Qv8Je1rdFVuY0OVUCKKQ7ERu2Yrtqrn8hvg/bYzuSMLt4t+nsAZk+D8vwrYJ?=
 =?us-ascii?Q?o+/5vcdPWN91y10497SBwhO/wFxb8tWSo0ch4XpCb6IsMDGu+hDGC9GNxriz?=
 =?us-ascii?Q?B9NUqA2fJpvBSJ6pbJNwp8GYyRGl1M7x/6aObzUDqKNlWj7IlpWlRN14+S7o?=
 =?us-ascii?Q?sqSYSj0Er6yEXFnmaTfpP0HEhGzek7cOZ0qhvZqI3SrtmHIwnrUebzATWF+Q?=
 =?us-ascii?Q?pFz13SgeqwTp6Xxvv05yP5R+fhOk7itvTwTOSjlFvctoVSKD704HaL3bWBmc?=
 =?us-ascii?Q?lc9ajN5Ia3iTVyeq76gDFqi5c0ji/nBTmaN4+fbXi4WMfDr3rEeDpJDDBcDw?=
 =?us-ascii?Q?4avoM0e3gEgIMHoRRybFI4ahhg/2gu1E6lsbbvu+ec10Akn5luaj3JwdchKY?=
 =?us-ascii?Q?8etlVOI15zERbJX0QH2Yv518ljiUTfbgKKZuMjCuatHDho1dxsxa/xU94sES?=
 =?us-ascii?Q?b7vn3EU9HzDaOfavABD5Y2ioFbSd9b14DEusQ+HbUVloS+udhEGr1L7k4vH6?=
 =?us-ascii?Q?VzUoGLFuC/BozvTRK6pRj9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Nwk28GX+L7ZEtBGwNKKxFG/1oB6uDxF4h7lum+Th1lJQW86UR/jED71nRI6?=
 =?us-ascii?Q?GmcrlWlFwR7kvOX+ELyCYr/rifr0PkrF4JLidvpmP5RR42mCs/sJoYlcQ/jp?=
 =?us-ascii?Q?xjaVIpG4IovAHgCC2hUx72+pqeOeuTOl5Tkc9Sf1ww1Xiul1U4P0QMOXg0/q?=
 =?us-ascii?Q?xHvcfDP2enFmyQT13i2H86B7ET8VkZixWpI1ENdvzaYHunO7atLDPI0AQBQD?=
 =?us-ascii?Q?EUttG2N3AoE3yQML7BTVai2lJdIII3JIU2WzYHWA5LVjfdOewmPKFUOvyAc3?=
 =?us-ascii?Q?uYCASdUq2dEdpVpcBXJQEUGtrGWkPdo37jI356HrlVpfQqpZrQfiiWgYynNY?=
 =?us-ascii?Q?icotBmo8X9tGVdw9bx8UdpeyaGJfhdMp4lKPrb57IDyg2Fdx2ShPrXE2kdvr?=
 =?us-ascii?Q?kmmP7p2Rv8upxcvNyKBEdFvBTD8ahxO4CMkPbPBBYwJzbN5+1oaexVviGKz5?=
 =?us-ascii?Q?kTQnsRfwgJi8GMzD+sWDK0ub7xUcK+DVuG1bkn8uNEetICe+Kc8e2G7O5VJZ?=
 =?us-ascii?Q?HaJ3YwInYAWNCZKeI4s0cujDMdCKQ2LE2N/0pVckMzJ7C4VZDRO+URJjQYIY?=
 =?us-ascii?Q?QJUQ2bpjFgWCeIbgwfxs59yL0pztAwsUV2P+SAoezkNmBvFPekkpJ4dPkkT4?=
 =?us-ascii?Q?1YhW/J8yT+q539FVUnZ3FHlE6esVOv3nbhkDCzP97kxFsysvCbvrgzmwafWq?=
 =?us-ascii?Q?aLpWDZQ/jOXemoUWa2QFee5O77A+/G6feff09cHEho2U1rEP5Pel2FNPK4A6?=
 =?us-ascii?Q?cAfc4IEEmIHCEZI4gpH+bQ+Ibqm7eFpjMzikt5RiyMB6XZeyjn1CyZ71IRHB?=
 =?us-ascii?Q?p42QFwSOaI1rIbVpnBBs3LgLezzzFtPa0PxSCBiHCFJg6jNq1zltDwIeGrqn?=
 =?us-ascii?Q?vYKKLjXKfj1onzR405EbA3PO3U6cpIE0wuFnEGdjmkr/+044yxace5UR53ja?=
 =?us-ascii?Q?0uiPzltMu+vwHza2daBxY9cUEU86sT0Z8i+1hOP20QVNjgfZuY1MwgTk9yOP?=
 =?us-ascii?Q?pkf5KdXFypS/qjs4W/7QLHqo/INXVf98Dv1EJkIMLfoqhTuXct2aWHGOZnA4?=
 =?us-ascii?Q?akU61EoxZqGNS2cUW8xJN2wZjH3wBAXOr1YieETA6UG3ZtX7X50PSztwDE8E?=
 =?us-ascii?Q?npN8T55WmSYi0AhPaqSZWAml6hzgLvqP3f/tAjCkMdVl9rYbhCBydb3caS9T?=
 =?us-ascii?Q?SpTRj7Di5ThHKCyJowEva1J1Q2tSq2HJccBGoFV5FiXQWQ973uI1llF7L6v6?=
 =?us-ascii?Q?3hA1DnY5reeusOfJNi1mfcI50R6hQUvxthKGmaF5L4E3YGamX9RsmHv0Jj17?=
 =?us-ascii?Q?2Mc9rhW1B577/fTIXEjZKOi65ync8JHQ8U3EPixuV80yCoQ6WVWuKYWd9eFw?=
 =?us-ascii?Q?ZM+ANBzyLMOz5uly/zHYS9bd1d3Ie/uCSLIlH/NETLd2VVUxt24ukEko5q/P?=
 =?us-ascii?Q?2gP+fS6jR4aZ/SlPG4vrE/n6iNz/4X82XXP1BQjKrVgr9dIZOclQMzpZ1+FA?=
 =?us-ascii?Q?U+aKYIE5lXTBTXM8D7xM/awnYYpVVBgbAQy5zw0TgOkl4hLzjJ993UNK877Y?=
 =?us-ascii?Q?ErwHce9Fa9O9eIFM707oC+JbuoiLqWySjefoKXRbaPnfl3JTI7MDxVFTjiT6?=
 =?us-ascii?Q?759ndo8zQDZ7cJfJ8ga/56AwfPzxmK7GM7NKXLHdhbHo7t9lIB3CxQRfmcDD?=
 =?us-ascii?Q?Ch2W3ApUm8ZsCInH0jHSrrzoY06mnmJU9y7r9ZKP+BG0Nnab?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de48eab7-8b61-4ed1-8604-08de5795c914
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:03:16.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmOTpDa4Vvoikur+uTZ5i2SyUPbz+lQ7syHzcf6pvyjMy1t85QPLxReMtT2t3TpfKUKXNjs/QKJW31v/Bii/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234

On Sun, Jan 18, 2026 at 10:54:10PM +0900, Koichiro Den wrote:
> Provide db_vector_count() and db_vector_mask() implementations for both
> ntb_hw_epf and pci-epf-vntb so that ntb_transport can map MSI vectors to
> doorbell bits. Without them, the upper layer cannot identify which
> doorbell vector fired and ends up scheduling rxc_db_work() for all queue
> pairs, resulting in a thundering-herd effect when multiple queue pairs
> (QPs) are enabled.
>
> With this change, .peer_db_set() must honor the db_bits mask and raise
> all requested doorbell interrupts, so update those implementations
> accordingly.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Patch 6/7/8 can be post seperatly. Basic look good.

Frank

>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 47 ++++++++++++-------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 41 +++++++++++++---
>  2 files changed, 64 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index dbb5bebe63a5..c37ede4063dc 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -381,7 +381,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		}
>  	}
>
> -	ndev->db_count = irq;
> +	ndev->db_count = irq - 1;
>
>  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
>  				   argument | irq);
> @@ -415,6 +415,22 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->db_valid_mask;
>  }
>
> +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	return ntb_ndev(ntb)->db_count;
> +}
> +
> +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +
> +	db_vector--; /* vector 0 is reserved for link events */
> +	if (db_vector < 0 || db_vector >= ndev->db_count)
> +		return 0;
> +
> +	return ndev->db_valid_mask & BIT_ULL(db_vector);
> +}
> +
>  static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	return 0;
> @@ -507,26 +523,21 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 interrupt_num = ffs(db_bits) + 1;
> -	struct device *dev = ndev->dev;
> +	u32 interrupt_num;
>  	u32 db_entry_size;
>  	u32 db_offset;
>  	u32 db_data;
> -
> -	if (interrupt_num >= ndev->db_count) {
> -		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
> -			interrupt_num, ndev->db_count);
> -		return -EINVAL;
> -	}
> +	unsigned long i;
>
>  	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
>
> -	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
> -	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> -
> -	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
> -	       db_offset);
> -
> +	for_each_set_bit(i, (unsigned long *)&db_bits, ndev->db_count) {
> +		interrupt_num = i + 1;
> +		db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
> +		db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> +		writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
> +		       db_offset);
> +	}
>  	return 0;
>  }
>
> @@ -556,6 +567,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
>  	.spad_count		= ntb_epf_spad_count,
>  	.peer_mw_count		= ntb_epf_peer_mw_count,
>  	.db_valid_mask		= ntb_epf_db_valid_mask,
> +	.db_vector_count	= ntb_epf_db_vector_count,
> +	.db_vector_mask		= ntb_epf_db_vector_mask,
>  	.db_set_mask		= ntb_epf_db_set_mask,
>  	.mw_set_trans		= ntb_epf_mw_set_trans,
>  	.mw_clear_trans		= ntb_epf_mw_clear_trans,
> @@ -607,8 +620,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	int ret;
>
>  	/* One Link interrupt and rest doorbell interrupt */
> -	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
> -			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
> +	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE,
> +			       NTB_EPF_MAX_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE);
>  	if (ret) {
>  		dev_err(dev, "Failed to init ISR\n");
>  		return ret;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 4927faa28255..39e784e21236 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1384,6 +1384,22 @@ static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
>  }
>
> +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	return ntb_ndev(ntb)->db_count;
> +}
> +
> +static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	struct epf_ntb *ndev = ntb_ndev(ntb);
> +
> +	db_vector--; /* vector 0 is reserved for link events */
> +	if (db_vector < 0 || db_vector >= ndev->db_count)
> +		return 0;
> +
> +	return BIT_ULL(db_vector);
> +}
> +
>  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	return 0;
> @@ -1487,20 +1503,29 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
>
>  static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  {
> -	u32 interrupt_num = ffs(db_bits) + 1;
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	u8 func_no, vfunc_no;
> -	int ret;
> +	u64 failed = 0;
> +	unsigned long i;
>
>  	func_no = ntb->epf->func_no;
>  	vfunc_no = ntb->epf->vfunc_no;
>
> -	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> -				PCI_IRQ_MSI, interrupt_num + 1);
> -	if (ret)
> -		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> +	for_each_set_bit(i, (unsigned long *)&db_bits, ntb->db_count) {
> +		/*
> +		 * DB bit i is MSI interrupt (i + 2).
> +		 * Vector 0 is used for link events and MSI vectors are
> +		 * 1-based for pci_epc_raise_irq().
> +		 */
> +		if (pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> +				      PCI_IRQ_MSI, i + 2))
> +			failed |= BIT_ULL(i);
> +	}
> +	if (failed)
> +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ (%#llx)\n",
> +			failed);
>
> -	return ret;
> +	return failed ? -EIO : 0;
>  }
>
>  static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> @@ -1561,6 +1586,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.spad_count		= vntb_epf_spad_count,
>  	.peer_mw_count		= vntb_epf_peer_mw_count,
>  	.db_valid_mask		= vntb_epf_db_valid_mask,
> +	.db_vector_count	= vntb_epf_db_vector_count,
> +	.db_vector_mask		= vntb_epf_db_vector_mask,
>  	.db_set_mask		= vntb_epf_db_set_mask,
>  	.mw_set_trans		= vntb_epf_mw_set_trans,
>  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> --
> 2.51.0
>

