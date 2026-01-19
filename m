Return-Path: <linux-kselftest+bounces-49419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C5D3B8A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D883045CD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A72F4A15;
	Mon, 19 Jan 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSs7m8Zp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79127E05F;
	Mon, 19 Jan 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855145; cv=fail; b=XYAUzTh1gMbaWNqCG7qPSVXjnIsuZXhJkYK5ISW53G5Wi3yHNa/NsG1m5RfZcHNVGelz/EdE6n83sFipXBOgTA63Ofq8sTtysGWmWOjQSgYTTk4z05N+AHHeFB4szSB5JyWo/bG404Qyp93+vuTcbtp3gLWqI+ryrFbnX4baNvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855145; c=relaxed/simple;
	bh=IKNDb0X4Ia4uIgxCgpzjw4hnFxgB8ZNp0Urgz+ID6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GN4muf44I8PmVgbC9rn7KQ4cwGz7c22HQ03o7U79smCRPzcbnJQ41729YZAKUKYy7DasgGdmqbNV9ImPuHhTtGdkDN4ZO2icQ+567S3p3TXJKn7zwgVzRhhxE0keEeC67o2hgjsbWZGr0ZfmwnPoT9GiXZEnLEtiDhPTDyz53I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YSs7m8Zp; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBNNCoy/hH9e8mfG+Qt8B02FKu1Fxjh17fD6R46pFffPRVSaLMyrFtZcH1X2EzaLukFiz4beq9VyOdHNXjv/pFKax7LUcBHNBHb5e18r7vS2mdKwhaxyCLuenmzP/tp2Vip066DgAm5nW+VRndDzkIX6Tx6Xhf5FLK4A7GI4r9iMkGv3hteDuVsYnWePbR26+yM/FPfW/x0glpIK6dYz+de87n2WmwoJp/v1YTkD1L4V2iK3uQLCW+jgJZeaxxkqtAuoC+uo5xdKdn25Peznq4u6ACfIBj9kz4UsoHNsqBAfG00e+sUW1KuNhMd0JRlgxghyrWcSlZgnnNvYFg8o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8EDeRiCbSg9y+6h2Kn0j/nAz7TQuy28vpJSwrcleSk=;
 b=cM6nwW6UQf7F/qL+c5SPKe1fznPNG7BzYFIOHkzuG6l110QChrzoj+kbYtb9M/vjCwZAYAH15QCW6+UhAV3lT7rjcyAzL0DWavSz8smFuoiUgRQOUSHGNeyYRlTwVzJF9KG/kOgYEI3wx2MyS/8WBdTVi+g11ayySea0/0MfcRSImJO3wY3Sp6MHfvi3FSYFRCZzBvfBs+P1BEaDsuSxGSm7m5ANmwv39sYrhNQc2hM/dOXMc7D0JE+HNP2CKt4TZSXRwnPMgEg4sN/mcYsRWs0/IermlLLeOu/UQ7eRgWBgP7yi36MaOsL7Ax73qzLwJUFIatODQ8CpLSayChW8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8EDeRiCbSg9y+6h2Kn0j/nAz7TQuy28vpJSwrcleSk=;
 b=YSs7m8ZpAehMlbxiBQwmTRfXPCxGquHdwxgLUHfWtDM0H0f1HmSNQRYvn6vnHIKjkUcjpO2b87E27F55ko3R//kqDHbRLLrSvwMJQpeSSyDpmR6f0P6zrlUtxhXnzapvFTH9K5fXT6wR48tkMWKDlrggDaG/bofEFOxm9RERLoravsuKOZusIfgklLTivZQFSvuq5eq7Dy8FivFYkw+CcE5U7nfDMYouiFdo7Pr7JpOCgi/lUx0eUdeDYN/mxqOMOTu2BOTrGp7OrJ/3j7LATNDLqJm6U6eZ7iIWWGUPuftuGO4XiqnzLQzejgKCl7w22xITcPcNCX2kohFJNQ3NMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by DU2PR04MB8614.eurprd04.prod.outlook.com (2603:10a6:10:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:39:01 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:39:01 +0000
Date: Mon, 19 Jan 2026 15:38:51 -0500
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
Subject: Re: [RFC PATCH v4 18/38] NTB: ntb_transport: Use ntb_get_dma_dev()
Message-ID: <aW6WW6S3Qq/usQyi@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-19-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-19-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|DU2PR04MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 562317f7-5304-40b7-0df6-08de579ac726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7zqE0dKhOXy5CzHs1a8YBJujMOzwF2Z4YNqNAujczEHvaXQN6AdK/iwX6hsx?=
 =?us-ascii?Q?VIwCKJ0G0sr7BecehbZ7rC/eKk2ueSyKtBNTCaLBZvfemwVTV9SMlWEzpYvC?=
 =?us-ascii?Q?hKUDIwUys435iHDcDERnGLRMtLUmmQTK0gmy+Vf4yTYCbHcQEJ5hqifBy+9A?=
 =?us-ascii?Q?q1k0gXyc3GnmgJduDTu66FLuquDJuxZvMIRY+WrspvruYEDrHz55TqyJNdY4?=
 =?us-ascii?Q?hPE18ob6wj26KgEVueb2yWTTivhpbfBvA0nhBfLQUf5/1mUZrqaxbn+4YfXa?=
 =?us-ascii?Q?Jqqgc5bf9CzcJsJS1lYbHpT2m7SJ7gtqvUjb/IkC2aaLYanw/UUJ5WmnPWi3?=
 =?us-ascii?Q?7Kwdah1bOQe5r3PtSPjvp31E5BMfcPO6Lqbcwh3iQjZkTl3kn99Bsn+n2qmk?=
 =?us-ascii?Q?MY0cF/MgTyU0gC95Q2x9JDMokJl6Za8LGNAwy+7WNU73UDHAGfGrVX2SKYZg?=
 =?us-ascii?Q?pxvblEKYqYdmOSFM+jTXeVdRPSbv0dBmkI1tMeGEJKKGQZPJM+jdKR7B2TPX?=
 =?us-ascii?Q?n2bgmIomQwQRn3ZL2eMTrxH6H7g8adOjt376gvX+r5SAAoDOgw/cLiKV3SEF?=
 =?us-ascii?Q?/5uBRNWTE9S7CdBkeSqiyLRIUl6j+Z97wQxziK/Gq6bykIML6gojk7Mw9FaD?=
 =?us-ascii?Q?o7XATTihzlt5kzNCUi96oKSlMjrzST3ZbKGgbSsUdk5drU5n7E/0o8tTWMv7?=
 =?us-ascii?Q?hPsJ7OFLAaNL5g5Be249kAN34uZEk1BDXUIMj1uQFDbWFqW2FS1JgndV7Ro7?=
 =?us-ascii?Q?AKQpnbjYNywyQYX1S4LHLyc9hxd6VtBUZoU10qcgrUxI/0YooQyAh3DIMYQI?=
 =?us-ascii?Q?LeEpvzpF/IgcRpR5hStu8MJyH0BNXGZie+HOUOVDO9V/HW2Tdo77x3Ep67Jp?=
 =?us-ascii?Q?IXSahquGcwtEaz5urT3R/k+5BbPoIH0vMahJVL859Cotiph4UzdKLQYmY6bA?=
 =?us-ascii?Q?FNsQLYElxnwbCfunV6BQM4gImmFD/Z/swiXptCuTf0JV9022nfyAelPUnB+5?=
 =?us-ascii?Q?0Za0OuU4AeEWPNKA26645sKz758UPgVnj1JkMUfocLI/OrMzrvv11lAqMibm?=
 =?us-ascii?Q?WuGPSHmq8xsHDLjS9rDIhZHdhJzwHxpX3hRQW/KCyoE8Dqd6LdSqJ06yYlLq?=
 =?us-ascii?Q?7SRcpZCMRK686PAb4HhDsVB6jnhExDDkmUMQfd+6pp5jqgmBuQrD2ni7eKae?=
 =?us-ascii?Q?pheYSR1Ummp+2qYGfG0U6BkrnN+CaCWQXi6/ne0KoZj7lwBdHZDNL418mTLQ?=
 =?us-ascii?Q?jw0FYP7+Tdyhs8ltot2ACmWhHd6hZIUrfphRbRay0g4LunS6UZvJRKsWl7Cs?=
 =?us-ascii?Q?6LJKm1bP9lvxNjuGlMck5TJaXZlBgUNYy5OX+zQOdUsMrop512DuATrqUqaV?=
 =?us-ascii?Q?5C/mwVdPxXk4bv1LeRNG+p1iwlhkcb3HGiZv6Jke43atNVbYValV2ydioPuY?=
 =?us-ascii?Q?nSxfcFv6zNQizbhg81pZGvcOx3ZRvl+5g+1JDpMq2ppgXzUAlfLkSVPkT5hA?=
 =?us-ascii?Q?c7ztbw6JGZFhdlAF1M4u2/An0jf5Ed/4jLlb9D92tTJuQ3lw6OCbC/ulGGUM?=
 =?us-ascii?Q?9jitB/P+Dm8EI4cOAPYyQhMqgQhyHdppUDRkibNiZbnRBtr22RYKUjxLKyGz?=
 =?us-ascii?Q?Y6XLPBv12xpZAQZWGGPm5Z8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsYDuFU8r1RP5HFFLQfFyVMmRYIMRcHACJrehgOhTY9jCYLJgf4zIK8C6wZZ?=
 =?us-ascii?Q?cTE8yaCiiZeHlfNoxNAL10ACpWLUnFIZb1w+0VNUEVp2Es+l/tov048HyBhg?=
 =?us-ascii?Q?gUX7WglAQY4Zo6R+ykJEzcwV2rqaMwtU0CAqAMXZYkzRwXufc7Rt+sE77rwN?=
 =?us-ascii?Q?3nmIzPM14NwP/OltHsujqdw4yVf8Haco+IGZtURErrSf746bsqvNuOkMNv8u?=
 =?us-ascii?Q?/1A7ufMAP31JRvBXkh1NXwzjoGBy62h64jw3o1+lBDquHxnv/C3MwngrJWRk?=
 =?us-ascii?Q?mlQf9K50BIn0LIiC+M/2+UKbsrematQnqePwThNDJbU7ObCgw2Z9GY9/pkl1?=
 =?us-ascii?Q?lvn8sg6h7kdA5Q7A1n7BQzNiP/aqiR0jdbKHWFoLATz40pwaETD2bgsrDuFY?=
 =?us-ascii?Q?tQCjmO1EsUAdhl+kOOisnr+pcG6fIl5GlE8aj1ljJ+UkG7CAWk9/ePr+pmyI?=
 =?us-ascii?Q?dlDlMBQ33lrdF0gj+Aj3W1dDsjc1MIUHgQx6Y/U7Qcthv9dUXbprFbmkOzt/?=
 =?us-ascii?Q?gZ8ZvYK2DBMYwq5D4be9CG1F/U3yQiww9+R+1M1aIWRHrZyvLQwV6v23AyC3?=
 =?us-ascii?Q?CgGwA7dGAOO6NWHNkqUWCX3uKcl8EyfNzIJ3hRpJVCogWLK0rDl5xVW9c+cX?=
 =?us-ascii?Q?wVecRCYRt5wh/c740F7vm/soDg+riVqDrQqqz5XQjdH12jecXLFynjp5WBiZ?=
 =?us-ascii?Q?RpptXYLVXxFd6wgHGX8EXH4IMjwDOpXOX3q4z1ngEyjgSR1jCgbN/8jR1i+4?=
 =?us-ascii?Q?EmPh9SXPBg3Q76j2calkiujwwtIIp01fAp3nL1XOMIBSa+jCdJe4k1OlrDz0?=
 =?us-ascii?Q?4sK0x2X/Z9/kr3HvGjtJ6FKVMtL3+YUbv3IziHbFFkek6Z9nzqU9AeSFmlTh?=
 =?us-ascii?Q?3216o7t5FMBb9n3w/zICkzaZV4rhUmgc+lyZofeRJ3P3WAPyu0Srj1T6aVVE?=
 =?us-ascii?Q?74NnRURjFJBCdEShsSa/zAFmYW6U0NrKzoOVCviRgQHu+kqMh0vmQHQkF9qq?=
 =?us-ascii?Q?YAcIQfW6+GgBoRFGz0kHDUDBfYlfthsiG/6K5TqIev1CF96gANosCDhee1Vv?=
 =?us-ascii?Q?smrYmVrAz2R1ybw081+X2Rs0vy6pGfv+8gC59Dcgqh2UyZXhz/EGQ6FE61dF?=
 =?us-ascii?Q?kjfrCPo8j/Ol7yOeHGzRP7WTwCyi/th1oOYzrTDrfBT/6Lwej3ISiSgnm44M?=
 =?us-ascii?Q?tUKNErnN5jZyAwJVAsD99sGaC3j7FLp8OklUJm4yvbUZlRJRJTDI9gfTX5vD?=
 =?us-ascii?Q?bCYuOaplO91DZqeA1+oZIh8y93ejCKyuLSghnad+I0M2lpYgJfIe+rW7FAex?=
 =?us-ascii?Q?OzI1lALjGbClVNeJQvYioC1JVv3Kvn4R3kppzeodOOgNMefn3OvxssnnjKWO?=
 =?us-ascii?Q?NHD/EgkBMnJJA4FIRgPBNAKPeLqY5V8MdGnEJfzEQZQRSKFX63KdmpjldNka?=
 =?us-ascii?Q?Xh/eJQcLKcdBiQNj3vKlbZyFF9MKgYwkAls5P1NFr5TvexsYz4+MLEjwYBUH?=
 =?us-ascii?Q?sqjUxZP9rIerUwKNANf5I2CGJOxRiP7za4EwCgObx+MIVbVyOoeinigPzbXv?=
 =?us-ascii?Q?5ycWXUAgTztfVUrOzfSkOtLGw+XL5WS31WnOXeHd0+7QRifnCnqVIbdTluHX?=
 =?us-ascii?Q?U+gS5HbY9ooVKL1K+wmpjqisAyJP6IcFDkdip5RLwmZOnrVPmKp9xP5B+9t0?=
 =?us-ascii?Q?yH2saBw3WCTMewfSPS9gUtN91sASR97qJ4Do8XKdqKfA3I5o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562317f7-5304-40b7-0df6-08de579ac726
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:39:01.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLuKblLdzMeifspwhO1UK5SFu5Kd3+lJCMfSKDYr5fWutduVBzCMLwJwtjs36l5lOSwpd46U8rZDKVtRe8Epqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8614

On Sun, Jan 18, 2026 at 10:54:20PM +0900, Koichiro Den wrote:
> Replace direct use of ntb->pdev with ntb_get_dma_dev() for DMA-safe
> allocations and frees. This allows ntb_transport to operate on NTB
> implementations that are not backed by a PCI device from IOMMU
> perspective.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/ntb/ntb_transport.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 6ed680d0470f..7b320249629c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -771,13 +771,13 @@ static void ntb_transport_msi_desc_changed(void *data)
>  static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  {
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> -	struct pci_dev *pdev = nt->ndev->pdev;
> +	struct device *dev = ntb_get_dma_dev(nt->ndev);
>
> -	if (!mw->virt_addr)
> +	if (!dev || !mw->virt_addr)
>  		return;
>
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> -	dma_free_coherent(&pdev->dev, mw->alloc_size,
> +	dma_free_coherent(dev, mw->alloc_size,
>  			  mw->alloc_addr, mw->dma_addr);
>  	mw->xlat_size = 0;
>  	mw->buff_size = 0;
> @@ -847,13 +847,13 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  		      resource_size_t size)
>  {
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> -	struct pci_dev *pdev = nt->ndev->pdev;
> +	struct device *dev = ntb_get_dma_dev(nt->ndev);
>  	size_t xlat_size, buff_size;
>  	resource_size_t xlat_align;
>  	resource_size_t xlat_align_size;
>  	int rc;
>
> -	if (!size)
> +	if (!dev || !size)
>  		return -EINVAL;
>
>  	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
> @@ -876,12 +876,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	mw->buff_size = buff_size;
>  	mw->alloc_size = buff_size;
>
> -	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
>  	if (rc) {
>  		mw->alloc_size *= 2;
> -		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
>  		if (rc) {
> -			dev_err(&pdev->dev,
> +			dev_err(dev,
>  				"Unable to alloc aligned MW buff\n");
>  			mw->xlat_size = 0;
>  			mw->buff_size = 0;
> @@ -894,7 +894,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
>  			      mw->xlat_size);
>  	if (rc) {
> -		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
> +		dev_err(dev, "Unable to set mw%d translation", num_mw);
>  		ntb_free_mw(nt, num_mw);
>  		return -EIO;
>  	}
> --
> 2.51.0
>

