Return-Path: <linux-kselftest+bounces-49309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FED3983B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0918300A1E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C468238150;
	Sun, 18 Jan 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X413uDZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DD1D798E;
	Sun, 18 Jan 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755819; cv=fail; b=tlAJ4iTWbEmq7mt/rEDfmaglRBjnrQjCnKbJfrTp75udhOYZ1O0CECxWhdbFdC/8JtJWXmiEcVR+mb+0FMfPym8DmhtJL+WcrFlsUzTbWSOPA2EhDu+aRV84+80XlZhimrVZCjfMFGzHmUtAlz57DcEJkuIP8FVo6d3r7+mUGR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755819; c=relaxed/simple;
	bh=LfrX0kbEE7UCSIhWWZwkkGqUWOOetZfWVOb1TqX3pAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h5v7DwV217ij+FxDEVX23QvBYleO6hC+sTMPnwTMDFB8ej1PnG7whXUv3i+qNvva5vFhukWg1TXwCYB3RFzoi0GDsA9XBD3f1SM3NN4Cp3DCok8MaHsiFCLY16Bgy8ddo9w0WlBU2OBPhg49gnCBq4Mjv31OJa2pb71pqOjXvSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X413uDZ0; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR4OLI/GYHh9OtACP0Jv1ogJ6RwT/FilM3k42qauRm4bC/XHiN137hyTwwL/ce+56UEh5eUOQF6ez/DbI1Gi7K1cg3SDulbIKED873lXEc1bhedMOFs2SQ99vBmrjS2zz8mkfMpzVDg0fcDfmPsHsVh+H99ILNDsQjaDtsHxp3Zc2O+x3Kc2UelzkZrtlGE7Iw6fm8/Txwrd7V/POLeIIXA6nbaf7tgGGrGvyEjYDp6j8LHHCy/oP5zl8yxK2Zm+lS3pzO1CxtulxnKI+5F+b+4GXo/Kn0tOt1p9wbV+kkJx4LNFOaY6rjHSgxm0BLjzMRMCtv5ZHIWmrYiMDm1Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60Nd0P530Bopr5WwBuNPczqtZ6QkXRVOkTXm6BPzZPE=;
 b=a1uyhE+Wx1OajaEWcBb/momu8M3XbXO3v98EF/6VJhY7yTr+L1um8qJZKiq33EPpI2e6QqLBLV78hl4M4jxJzF7PJS5IZXRolw0YwpyQRRVMAxtRm9LpftYxX3olBgHcp9Z1GmSei7zfiRnEHTEzqlpxrgexHW1nVUeDIBSgl19RxWf1m/mRWWGssIQlmV2Lx6gPxst00ubrk5GFnYqMoqfPCyaIwi6shFUoHuV6s1OWsFJ6+kMWig0ZqQF8iemf2kCmmj2MdWi+X6DpjPq3bu3eqvuuY/HwaAX3mBKz7idRjBlASOXm2P1a5NoFxo7m9htNSqcZNonxNBkneH5trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60Nd0P530Bopr5WwBuNPczqtZ6QkXRVOkTXm6BPzZPE=;
 b=X413uDZ0J77fitRfhlGn+7yyBYpRYpFdHVUyZEfSGbUYmreGiJ9QIB5psuaFNnbb9JSf71LgoghwkQKIO31c5K0aCtUgnkflOArE4nSKpmfRO4DQjzCtkl5hgKYjCOnodF4eGWTicAgNib7JJ0h8/kDsdopGMFXArQkyDMyDkXcwNQbkDBFSaTOkmyECNIM22rMzefOg27+miebV68vb92AEI7Us37WU1nlla8E15lhvGFnDeA5ELw7vm9qLemiMDLuFNrGAygBFJ2KA8a5e89PMi5WJ8/SejiSrvKaknMv063sa4boyZG9tru3a1HOoTwtvGPbCMw9FMnbABp65DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 17:03:33 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.006; Sun, 18 Jan 2026
 17:03:33 +0000
Date: Sun, 18 Jan 2026 12:03:19 -0500
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
Subject: Re: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel
 interrupt routing control
Message-ID: <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-3-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PR3PR04MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dcc034-73a7-4800-7044-08de56b382e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HDyaE3Qagca0Lq0+6gSqxG76KWhvac6AYEWU5dmNIFmPAUExzPnHrVJZXaWN?=
 =?us-ascii?Q?h7GHsSq1h5vXd+JWOKukj2t4vUyYfOiLA5ZF3qIP13h95ABQL3++TYK6Jv50?=
 =?us-ascii?Q?D358kwuDwj7hq69DQUt3Z9e6ihj1znH35LlJdqHm77q3N7k1HZdX9Ftgedxc?=
 =?us-ascii?Q?HeUbnAvn9Xx3jYNOqVov6d4LX4khPV7OS7nOLXrE0xa9IwrPXplGDHqjI/EU?=
 =?us-ascii?Q?rLz43yfwnytZxsDCf1/d4ebvG+e59LDTjQYB0xm2YEQlGtmvU4NtGzYIgDmL?=
 =?us-ascii?Q?bH7F1YOZ+wXoI5t3y2baAdVxJ+PVTrezJlOgc3aiMqo9xgF7ZzGPFiy3ftCT?=
 =?us-ascii?Q?U3d/kqKYv7P9hf/yS3cnF8dGDezJyhyGZ1d1J9vNHWrXSqDC6LzDAjrAw688?=
 =?us-ascii?Q?osYDiyjHOA/b2i42mGaBp1a9pmASCs6N+F162RIbQBbAdGs7Nicy92v1SliD?=
 =?us-ascii?Q?qdvKbpayIDqFG3iDa0RQc9JfQkjBaVLRq2+XZvgr4BRkHbkq6H4cO8xO2o78?=
 =?us-ascii?Q?aFzy573bnoXOwrqixhRgq+s9xwWCmUpN7uOEANVMvjxeZn1Msf8Ma8GXe2bs?=
 =?us-ascii?Q?HdV4gfrFR8/E9A9atFDVkQYGSpB5akqFw6cv7TRayLR0JAXqRcv5veEr/cuV?=
 =?us-ascii?Q?MIxWshkFqeuO7BdVYkswdXijGi1ANLS21Ia1I6Yh3dIxaXKD24CfJCvRNc9U?=
 =?us-ascii?Q?1hvkZVFkjdd1jDaR2cyVj3kA1Q7q69BPIBNYOnNZl9jt8WGlW5EArSKERHkO?=
 =?us-ascii?Q?QLoVKbRktQJ8dKTNwu+QR+d7aFAC4fv1D9sDOn+AWzQFV9Lc61Rr1AHpjmK6?=
 =?us-ascii?Q?Fja7bqWOjheqG4h3xigFmUI5VT9WhJA0sjUtloeII2d0CKKyFjjJdzAMARoA?=
 =?us-ascii?Q?QTqjSfatm/3kbB9ex7v4AIU4spZ9S0ceaXKCwC3TFBrdQ3fcCnmS72UtizZQ?=
 =?us-ascii?Q?ryuzPEY7SzXqrBh+Mke+BI2klQwcm6nvvzC6u3fNNIBwuInw5CDtDl+tryBp?=
 =?us-ascii?Q?sSKSIimu1WOtxuXPNUZMlBvzbx6E6wRBEeRpj3UAVzlpuaXMfYFb8AhbyUPo?=
 =?us-ascii?Q?xKHyndaMzTCLpewN5h9J8htXKufJfYX1BNo6pP8PFbBM/ij4w1jRnp+PHAbc?=
 =?us-ascii?Q?04+fbakgqGyVJffGx4DbNN0veoifu5sDKzfnZ5pSv79m7WU45QpWTL8RFhf1?=
 =?us-ascii?Q?z/wYrrBh6UdDALEX6sBxE9tQmck1wMbJnCyy2xuNaS0hebZzlwznvxiYoGlj?=
 =?us-ascii?Q?c4is1trEAywnXR1NTYLqdEgIZcJgYdzKhjnnu1aZoFLskMn52xjpH62efjYA?=
 =?us-ascii?Q?MZvVyo2lPydxzjpgTa7pENfh9Re0PhLK/stf3Uv4zC6dqedLyU0afDaPx2if?=
 =?us-ascii?Q?/hCGxL1g3FiVSqxsduHVpkjuctmeox+iRr8CyARKBrQlXTqkBYE70EpC/LZS?=
 =?us-ascii?Q?4mjOCDRqoJIykXyMcIVE/UdsTQhT3T7G6NoDwwL5b3flPyINXZWZQMiMLxr4?=
 =?us-ascii?Q?4ETihz9hWYJ2v0mSI6k49BK2P2rZoIJHSZPwkWpYld3g0HdiDYc5xPEUdYRG?=
 =?us-ascii?Q?G91TRwDNK1Ok8kfLTWAAn3kHmeN6udQrd5YQiQXC9seDBFOPqMbhVHywb34b?=
 =?us-ascii?Q?nm0I1DR8zeIOowdrZ5Nq8Yo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQGb6yzWy4Jr70hM7a7HpB8ixW/2d5869YK3eMnjh2OG1i6ah7FdBs3PtMEz?=
 =?us-ascii?Q?BtG3YyMQP31M6JJba3P9dxZdoNAj1tj0/yzlzXY9+aiCMsxq7h7FWKbeatEM?=
 =?us-ascii?Q?dIdOv1CmvTZEv0v7c81hUB+ta3gbDCVhn1rL1mYWhe+F0V7DbYAAY5sipjo3?=
 =?us-ascii?Q?ons2nJ2ZVDXZ6fw1PC1vC7S9aKImQlbQdVpC56A9N6Mf/bNT+Tt6G4DZmMqb?=
 =?us-ascii?Q?B3z/xfctIrBVOqYrwXK3Q8K+d2O2InQol83z/6Ivj2xbaku3mdW3MSL9/zuN?=
 =?us-ascii?Q?hipjcALk+A69rQYhtJ6fVAAQ7hWp8fJsdfGUVNwQGGnnAtwcChLbCXKcwfKQ?=
 =?us-ascii?Q?vpzYVnpG6sAlmkAP9rjyq2ZY4h0A0yqoIZNMO2VyuLv8FXtIzZ1/NE1GcYQc?=
 =?us-ascii?Q?tpElU3HidvciLJBm7HGN2TNtYzmkG9UNY1Q80zW93P9zBOdqWCsH8kaMVwGQ?=
 =?us-ascii?Q?IQo/0mL4VdpNya9CTEopUKDHIIWCeN8XSG/c6PHxS2jbELrtAtNw3JiJLfyc?=
 =?us-ascii?Q?isrtbEa3L2d3uGmMkvvN7lRQuOurPoAw6koedXuAu9zHZSl9JONgWMEtRbHe?=
 =?us-ascii?Q?4aIkpE75FHTjBT8tqD6NwM1ItFADOI4PchjwG2/baqEbgko2cMHsWTe4fL1x?=
 =?us-ascii?Q?BLrf7Wf8ZQO7o2c8d2cILQ39JXfX4UxdmEciV24emrMJRTE3zaWVlYPthN4H?=
 =?us-ascii?Q?ToC8n+4AuoLG03QJS+p/10eALqN/YK1PSMeXGg8xaD/f7MpU8nOay497ZDOz?=
 =?us-ascii?Q?/fRTq+r1V7ZRv3IIMQFo5jPhskqHj3xNxwleRTVosLmGARhB9vRAtFv2nJmz?=
 =?us-ascii?Q?4nhhv8xlIZjhIALCTaW9R5fmiDhdcoYpHyaeGP3VImhLiwKGE/1fgv9Dr2/P?=
 =?us-ascii?Q?fc6D5v6i/ZaEf21qVy2i4/uJPzYU4nOCVFHenLdxJ6olKKAvwwQtAVSVgOej?=
 =?us-ascii?Q?B8x/L7qA+H07G6Fo2pgIlpUiUKtKMUq2K508IeiK/H/X+nn46MkjbjuA5u54?=
 =?us-ascii?Q?3zmIQ3KNO9Dn7pA6ELy1jx8bOw56fo5RfERMXlbNPcUgG8IYNdrPmEjZ/OYI?=
 =?us-ascii?Q?9uxILG0hdMjeKsfF7IHfzxMd2Koib5RfxTXJ9QK7EPWUegUiG5XOWq2oQud8?=
 =?us-ascii?Q?GCfZJvL54V0NCa+r3Nnr1fQiPeApLa87O2rJh4efPvyS60AkY6+mzu5AOE5d?=
 =?us-ascii?Q?dyJaZPAoU9w+CHxPlcEvQPnUMeBQJb6lx3rT7sR3bG8LBLSBiPAe6GMPnmoB?=
 =?us-ascii?Q?6mtn9udF+FnCxKXC52JwLvFCktAtMbXk51amWG7ntUcCvh+B/0EETfwmJFlb?=
 =?us-ascii?Q?tUDYTHT3/U5F48aSe2XCLkqrvcdfT+ZQ/B5cAwEnKjOxeeUu/va3QsvDyQjq?=
 =?us-ascii?Q?1GvN4WSrWy2+OUytq+rUOU357IOxKC82YlO8qD3e/IQFQnxdgui1NeNpByrH?=
 =?us-ascii?Q?Q7BgmOJZ6viHBtalLjbCwp6LR9kSMwNDPcuUIoXCeiUPD2btp02y6nOUk0i6?=
 =?us-ascii?Q?DiTcpJsaPJoc7NN3Rp+j6KfIzqt/Zq1a8DLzzOYRZpYqUzOGtZJWFBsV6agR?=
 =?us-ascii?Q?jmEtOt5WJLsOoC36ih8aDbqAP5Jo9hkJ7lUk3OOSg/BVuc/ag6yV+RXb2EGO?=
 =?us-ascii?Q?BG+W1EmFUKSi7gTWem/Dp9O4ODjn0DoyWCkNLALsszX7YAUUeuemom7J1bq9?=
 =?us-ascii?Q?wzcIwQFBLlHrVM7Zm9mgna2tvfrx0iia4BseELCofKgQ9riXduBnk3xFedrV?=
 =?us-ascii?Q?aS7dKRb+MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dcc034-73a7-4800-7044-08de56b382e6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 17:03:33.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/j+S8bYxn6mseNJRGAdwBHkOzz2557HFqMjftvp5pBlQu+JARC0CJcA/qlrQSGM3GUTaiV6XDqVJvT1OeCvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291

On Sun, Jan 18, 2026 at 10:54:04PM +0900, Koichiro Den wrote:
> DesignWare EP eDMA can generate interrupts both locally and remotely
> (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> completions should be handled locally, remotely, or both. Unless
> carefully configured, the endpoint and host would race to ack the
> interrupt.
>
> Introduce a per-channel interrupt routing mode and export small APIs to
> configure and query it. Update v0 programming so that RIE and local
> done/abort interrupt masking follow the selected mode. The default mode
> keeps the original behavior, so unless the new APIs are explicitly used,
> no functional changes.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
>  include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b9d59c3c0cb4..059b3996d383 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> @@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +int dw_edma_chan_irq_config(struct dma_chan *dchan,
> +			    enum dw_edma_ch_irq_mode mode)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	switch (mode) {
> +	case DW_EDMA_CH_IRQ_DEFAULT:
> +	case DW_EDMA_CH_IRQ_LOCAL:
> +	case DW_EDMA_CH_IRQ_REMOTE:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!dchan || !dchan->device)
> +		return -ENODEV;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (!chan)
> +		return -ENODEV;
> +
> +	chan->irq_mode = mode;
> +
> +	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
> +		 str_write_read(chan->dir == EDMA_DIR_WRITE),
> +		 chan->id, mode);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
> +
> +bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan;
> +	struct dw_edma *dw;
> +
> +	if (!dchan || !dchan->device)
> +		return false;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (!chan)
> +		return false;
> +
> +	dw = chan->dw;
> +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> +	else
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..8458d676551a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -81,6 +81,8 @@ struct dw_edma_chan {
>
>  	struct msi_msg			msi;
>
> +	enum dw_edma_ch_irq_mode	irq_mode;
> +
>  	enum dw_edma_request		request;
>  	enum dw_edma_status		status;
>  	u8				configured;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 2850a9df80f5..80472148c335 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_done_int(chan);
> -		done(chan);
> +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> +			dw_edma_v0_core_clear_done_int(chan);
> +			done(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_abort_int(chan);
> -		abort(chan);
> +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> +			dw_edma_v0_core_clear_abort_int(chan);
> +			abort(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
>  				control |= DW_EDMA_V0_RIE;
>  		}
>
> @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		raw_spin_lock_irqsave(&dw->lock, flags);
>
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index ffad10ff2cd6..6f50165ac084 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/*
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> + *
> + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> + * Write Interrupt Generation".
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> +	DW_EDMA_CH_IRQ_LOCAL,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -105,6 +122,22 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +/**
> + * dw_edma_chan_irq_config - configure per-channel interrupt routing
> + * @chan: DMA channel obtained from dma_request_channel()
> + * @mode: interrupt routing mode
> + *
> + * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
> + * not belong to the DesignWare eDMA driver.
> + */
> +int dw_edma_chan_irq_config(struct dma_chan *chan,
> +			    enum dw_edma_ch_irq_mode mode);
> +
> +/**
> + * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
> + * @chan: DMA channel obtained from dma_request_channel()
> + */
> +bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
> +					  enum dw_edma_ch_irq_mode mode)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
> +{
> +	return false;
> +}

I think it'd better go thought

struct dma_slave_config {
	...
        void *peripheral_config;
	size_t peripheral_size;

};

So DMA consumer can use standard DMAengine API, dmaengine_slave_config().

Frank
>  #endif /* CONFIG_DW_EDMA */
>
>  struct pci_epc;
> --
> 2.51.0
>

