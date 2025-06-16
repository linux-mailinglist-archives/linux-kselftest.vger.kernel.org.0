Return-Path: <linux-kselftest+bounces-35111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43118ADB6D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F518880E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE38286437;
	Mon, 16 Jun 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mbtrBEUR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA90286887;
	Mon, 16 Jun 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091182; cv=fail; b=Q6V0vgj2KV1j65pHZtO194/p38u8NyelvWaJ+NAYiXiiVCR7wMo/vL7ZBNMDlmrJV6+XKbl++1hyFMcLUczys+pDZU5pia3nA7VTkhcrBSvZySm7teyip7lpq4inWNGS2cb66TI3Dhb661apJOs9QUhfGmTeNWLKI484Uft3XeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091182; c=relaxed/simple;
	bh=uu8C2979avexos+6maFq3yWopzpItWA+o7fBqz+7+Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftOlC8ORsURd4ON6ZNhlUIsl9al/93GyYwIH84hfeYb86RwtoHK1H56ADs4jbFp74Zoq3WfVE/crkMt1OTSzGjZmBMHllu+8l5o1Qoq6AkHrTtTfccc1ifrmpsvSBQaa3lnQ2vn/z60TBWU3EZRmlq6LbcP8Vl55SrCWknweJVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mbtrBEUR; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGbl8oYHXtIwBkcDcd0vbbciVdlOWlo+3CdVwy9+CJqOwuO/9XPaHKTND0c6cg5D8Xnr4iNWgGudR9AdoqflP8tpZuTZ1WnZd15hFr6RUPJq2nvziJHdh2oODuR0EpdfdwOp/DKPrb8xR/8ZfX6cJdmAmATFP8Vn2mv5Kw0MiBL4d7dhkXB3xSa5TZTiDB3s36CewpEcgR3cxolQwTstr1mv696cv90Ou8pTOrZp8RUkX8kZkEG2xFl83wN7DAdR0rBtC6Ge7l/Rm56Yj3k7z5wmZ5xrLBVR3Rr7uWNiA/r0QXzUift2yBd1BQoD7antaaqRGdEVZbQqqy7kZ1kt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoEXKiAr0AmzakssUFmdRGwC0NPrbZITo9PbTU5LmT0=;
 b=J55rEue+DCnVdU/r3E14PoEXVjr/QBy2MjTe0Zp2apwXvPV6keMq6elz3nVgv6P5+XdLOEUw2cxT3nGHA/Of4h1vpC9lA/vXsAKnLAmVkeFEozZIpCs9SnSzE9qeYaIXr0An/qWto5EtWkJ44zuc6cj+5fOl8YmCnwg0M8J10XN/JBV6WRH6INriPw/RBC2U35YkLVyPr6urZZOySoI8uaCvmYCXyv2SLH/Tieokd4Ou7DJx1B+qeHNlvOzfxdPYHmbC3Bb9gh1X3RD3+dQTV1fqKoQ3rDmcrcyHAeI5lXy5go7Fn8ofsMR4x56joP9yMnI+5rxh9c9jkqNaYWLj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoEXKiAr0AmzakssUFmdRGwC0NPrbZITo9PbTU5LmT0=;
 b=mbtrBEUR1onLekY6igQMRVh769u29UP3QRTaX2eJmhhi2hd1Mg49z9RObd+fmnxZelzsF/KDs15YS1EZZeNWXcqNXzxCAgz+j9qm9jZgV/n56zNxtD+KF/coWasSeEpF7WNU8rBR+01Bbflgq6rwluaHyl7cDpnro2M4R8tW5a+3mlnAA5ALFmVRzQ3aJ9LrNiA5DWWtma5oNRNSHAipsktCP/PwiuNlQFcwiwbib0tJB1w5gAaHV8qGlczgjNxhq7LZXqC8o0xudcFWu6M5LH/OdG1IEhtfAjGA0bEzaOH0t10bZFupdDPAsj29skd3fnnDhGHE4wjZk+J92F2u0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:26:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:26:18 +0000
Date: Mon, 16 Jun 2025 13:26:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 3/4] iommufd/selftest: Add asserts testing global mfd
Message-ID: <20250616162617.GP1174925@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <03ad77076f50a1931b08cdaa37c3a0e11038a934.1750049883.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ad77076f50a1931b08cdaa37c3a0e11038a934.1750049883.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bea0082-b0f6-49d6-dcd3-08ddacf285e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0B+Mq5V7jfxg/uDye+/K7NA0Gwn0lKPigt/XCgcdIGcDJKLQJy+C0YJWq6U1?=
 =?us-ascii?Q?e9boelPJ/4g0XTomhRNnXnjJvJ8luLLdFbgQ9Hao9mybZxFNvxLOnQk07O2o?=
 =?us-ascii?Q?mfAA/nS79XZ/9RvZMbWHfNPFas4qJX4hel7HSXtzGxgyezSo0ZP3u37q9/pH?=
 =?us-ascii?Q?+NVy1ilRahtakAUh9JShRdJUdXPaALCmYRUPhvHH1L9+iQ0zIwGLXSNxw8Ud?=
 =?us-ascii?Q?zKXIAeVAfG/3vEAOEb0Z6TcvPZc6lBEuG0rdS4bHD605nV7Kr2cXuLMwSqFh?=
 =?us-ascii?Q?eSAeNyIqSoPRKjaYZ5T6RLX48m0nXxG7gDjCTL4SkzCy1QZIKoF3ETo0L5ny?=
 =?us-ascii?Q?aJHEVsSZ2u8dat56SD4tE1a5YuHxZu7u1mF4REeQC/9eResIL33XmyxICiLT?=
 =?us-ascii?Q?O1sLm4FYJgSG8xMdya9d0KN8NJoJQX0sK0qGhrYHtp/MHD2/yLopA6+KMjaj?=
 =?us-ascii?Q?HRStovNYMf4S4dcT4GCWD5vHL83fr8jVaoBoZoyJMf5WOIBB4GwaaCMICMqv?=
 =?us-ascii?Q?FHWv+BmmHpvH6BiF7PJaaNvzAnhtL2Vz5Ye0ppJmLf5S68oWA3jMHcmk8Hsw?=
 =?us-ascii?Q?EXiU0AiQYywAr3Ep88ssarrO9J1qC8QrnxsTJ1y3ZAIIp1RHvSI+I8fMLT49?=
 =?us-ascii?Q?VSjkJEVvvmL/USIJ3zFtUO/c1fservBcmmjVW2pzAykBbSFp9r0a/UfiHA6n?=
 =?us-ascii?Q?M435hcYL7J1I/eneChjhUrBxISr4yh2CqletDuusckdcuSHU2sgAg7NqY8G0?=
 =?us-ascii?Q?/4J2j4cnWfKdI58KOA2r2VLILkcs6KyHQ3cQOSgBlmnIlUz/vSeEcEncNiqw?=
 =?us-ascii?Q?JmxMwrEqv76Rix2tIQFp4d+8b6+g7up1qb9V4UNAKXDrp3DofWegUKiX+6rf?=
 =?us-ascii?Q?Jm+PIKLT9+6Qi4iqYAoxFVklYpXfGAovbzcfQuiASEyUVwAo/PLr9UezrZ4p?=
 =?us-ascii?Q?vKuhEnb8g6CApJrSI0Zynp2v4A6LvN0f3Xue234IGzitaQeVB4x5WZflcoyF?=
 =?us-ascii?Q?SHiKS2b38T7wA/ny2qqO3QjtduFuyIDkIFEzZBQ4iwzpdCDCR4n3xGpgZPyA?=
 =?us-ascii?Q?mvyF01nIl+Fmr0tsIe+R2X3lH/cSVvdFvqX385yDfS26Ee9YbCYZjRZVy5/H?=
 =?us-ascii?Q?NVEACsOS40A19iuHA+UQI3l7Jz2lXjg0PeZRsroVAjyUJa3bEEcJiwXXAljx?=
 =?us-ascii?Q?c0jfnEcPCxCy0e7o2AL8ybggKQhi7vtnt+RU/J153M7rHMuGAF1HRiUBQBVY?=
 =?us-ascii?Q?/AaznpZMS3A/wWitmPHU6mNmXHayZs96m24N6wQyBWgjg7VZNwPo7/Br3WYc?=
 =?us-ascii?Q?uX4BMPZo0LCd2EZlepjrwUrOgEkJGVgb375hmzYpdv+zDsDXN5EWTjUtqmZv?=
 =?us-ascii?Q?q8IP6gKhdE1uZsXfaESpIja6beL0UVVO/dMwbf15RREFC5cMYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIq802oghu5Zy6iTYWUUnBnujZbgdFUNSYqlZ+XeeYCa8E/4t7sWPPAelyuP?=
 =?us-ascii?Q?ZJEuVE7Wvrmoqd4cnpd4e2Uw4z3tlw+rnGZyaBH74i0V96JiUOVu7IGAhiH3?=
 =?us-ascii?Q?pt7SsQ6LEJex4A3abpiV3mK3zc3O3+zfVLRInGdmP3hkBmp5y9bOrALQkAPw?=
 =?us-ascii?Q?VU/j+TavKMRwO/06yJbKBGA6ke0FUOKZSnr8Dz/BC7c0kToTbJBjA/Qhdot/?=
 =?us-ascii?Q?tkzI8Qc50Pe4S7nGXch+RuVl9K36zeQGqeBD3MzRd0BcUjnjrLReMxirijiv?=
 =?us-ascii?Q?NwhiOjmCL3GBbcvowNxhRdPIzG6JdSNC3ACfEnuUUjJMLzsPVsj1OGwure05?=
 =?us-ascii?Q?j7Ozl/x0fA1vhZhaVnOyCOPbr/Fzqo/hxt6bFuZZ5JWYijswKrARP4M3Ze2q?=
 =?us-ascii?Q?tHUuztK0AWT3PkDbdEPlx2PWokA4wJ1/D6HMSU4igWUDTxTeDu1PMLBa2Mey?=
 =?us-ascii?Q?Ds8KkT8u+aKkKQ//pvxq01hMYmVwAILsx4104xGg5o2itfbiuATIFdKgyikq?=
 =?us-ascii?Q?VfwYl0IpcZaDcp+h7fbL1QhVXmrfQ/DRcCbpy2caLK8ywFb1jXHyiIM6eF+C?=
 =?us-ascii?Q?DfiM4qVPpm5K4Qi8yYGjKM6qgdDk0GGsE+zEtzyZlPHH1JvAjbl6P/31kB3s?=
 =?us-ascii?Q?G5nuLiC/f/Q6xx0cuA3CeeCSk0Y26+4lXrsGXlyU8EhEned0OV9dPIlyq6t7?=
 =?us-ascii?Q?zekZ6CzkBkB6fp0FjM/UhRk3iKWy8R19TZZG9rszuYgMAj9zNEbeiDUzLVVY?=
 =?us-ascii?Q?Q81p5NkO+5sabYWCzOgF+8f7NrUyjNiObJ8fIXcInFVDKml23KczAWQH81fq?=
 =?us-ascii?Q?rZDTIxDQPsn2Q4NI+7wEg1y81IlWfPnuusZ2DCVi7Vxyf70hkzgiHrsGlyeW?=
 =?us-ascii?Q?xsZ3/srLG2GxpWUdyl2yhCr4nSct5M1b3ahsL9bU0V84ua7FEWnxkFFC05Zr?=
 =?us-ascii?Q?kMaUCGl3OZU2548CjXmSvEdDqh6sU6z//RKJg7Sne5AC07xyBSYpbCt1wjVX?=
 =?us-ascii?Q?TPcBAZswzAFiCUchPdsEPWWQL8WRVfJIO5LJf6S66mzn7GvoIAIaIkAPv10L?=
 =?us-ascii?Q?SqAlkRt6Az/S/EcKxrQlA6XFM8K9z0zdSnwDsHzkJ1ElPpsB06Z+vQKbT2p5?=
 =?us-ascii?Q?XtAyh3ayOq9bpRNQV1lAfhCCTDN3w/F210hi+gxXAkxwS8J0IZgkzl4BP78P?=
 =?us-ascii?Q?cHtyQ+McXWWIBhlgsUXes0BaFUz/UKNPnSu1Jtjl6CQyUKEHRg72bF8ClJ8k?=
 =?us-ascii?Q?Xd7wJyA7saYlHQCGMrEL5jzGZsd6bvuCHlX/OXO9l1QMGiw0O7GXbGhE278P?=
 =?us-ascii?Q?WvoVLgvOeGjS63XDtbyU+GyGiqkkyRPYoegUOfW4noDm94Q1W4jVjey3Zhb5?=
 =?us-ascii?Q?nnhoFm4h2HKhanBuYkOOCM15U8A+nfF8GCJo/AEorAAtgYDawLFVj5jkFAwh?=
 =?us-ascii?Q?45jty8yEaVF3SCzS03HCy7iR1FDQqsIh4Nul4y/hRe5+cTgd5toW/CteHpgS?=
 =?us-ascii?Q?7p0CQlTsO9e25cWTqzvhvZ9ZojVy0SUQXU7yXRCpj3SLng7s1bXmmL4m+6wW?=
 =?us-ascii?Q?leP3uD7cfkDSfWhEqsZm9L94kQCgYiTngZcjRzDg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bea0082-b0f6-49d6-dcd3-08ddacf285e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:26:18.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQDS7chjz6r+WmmscVZeosTVU0evz0F7F7NCFd6MlejQfr2I1a8I/ZD7VbyMB5Yy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Sun, Jun 15, 2025 at 10:02:05PM -0700, Nicolin Chen wrote:
> The mfd and mfd_buffer will be used in the tests directly without an extra
> check. Test them in setup_sizes() to ensure they are safe to use.
> 
> Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

