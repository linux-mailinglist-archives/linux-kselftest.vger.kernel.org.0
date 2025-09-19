Return-Path: <linux-kselftest+bounces-41960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B58B8A47C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9733BD677
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A447316915;
	Fri, 19 Sep 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEtk/CJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AE2F83BA;
	Fri, 19 Sep 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295596; cv=fail; b=ZggC0HVaupb2Kc2rYmUhzbkIMEp3LhienzuL5iO/1Gi0NRewIMUVvmOnA/IFnzkz1iu92p8jyla3b412ywKdl/0VgJwC75EjO8ugBHiC0dm7TULqeaQePRCw8Gg9sdQ7N09Cl/3ktoRCjmpIUM1HxMeUy/501kwfaPO1Dwcd8XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295596; c=relaxed/simple;
	bh=8nsgDTI3jtH2J9u5R6mzCIBwMqubXnNNevbupHLbGmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4vwbokvGAQEBSog47DBQGFUgY+cy8NhUEH3I3H0xsg9v9Qdt3GKeTVbePMqXa9oD/P0d4sP1R5wrKko8p9hSDMtwRz8Beu9QhRURd0qITWZAvbgYnnmeTaaQgptSXTb1xCw4/w2uzSiKF9RKqYQASDIcaP8zHfjfqFHfCDTDac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEtk/CJY; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnYqkCeHahRGxD8o8d6ul4NUaXYSvOtKasmWeuIX0U9E37xK066hPwbDqxSRwuPOhzMd4C7oZeXS9xhzONyAHdq6DomAiFcvUFyL/9v0EfoVfuWXznsH6iUIn+PnolSDehz3W/rcEzFjqHvrvEG88KyvUOL6pyh/h8XwWFat2YP+dS1KeXLQbL+i5kqJ1vrlOK0eGZGIuW1fNeB9mTcoiL23mbItV83vEXbzRGxwdZxetkEmbxlVlXCxYe3GvMBFP6S1a5FJFFkmUraJBYD6DbWeJDyYn1NPgcfaXPHZHmWLV/EWcidPX6NCZK62KESXUKVNHHx8l99VUI2k801U+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaKaEc9auKokaYKlWipbRLNY65zE+0MoZ8sgc/UJwF4=;
 b=yJxMLrxxvdx9X+PC8i74DqmWzFNIJRAxqPmhY2gsY2SqhQNCywY9FrNSOHU9ib5opfl+jtTh89+s9EF6R6Gxai/P9X3ndivtXJ9WrcvB3deFk8YaDtFH/iB5x5/L9y3wbQENvy1kr5OESD1vxm5PerroHUSxi3JZJOOja50apREneH8VSQFEBZpRsRwtVOkeR4n23jAhz66fmOP0edajE+6K7hPrmQJA6xZs1l/W6BJIf/ZdvjKHiFidCI9eU+ChBfM2I23EERaKsFSc7xY2SwqqC7chnOhtxNpzHkQRpGjfCR3efB+3NJ1pC5AAdTa+l9eaB9LIDfTKg/J3qNX5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaKaEc9auKokaYKlWipbRLNY65zE+0MoZ8sgc/UJwF4=;
 b=hEtk/CJYiv6nEe89c3BAlAn5iM5O0sRNe7RPDCz5TpHZM+2xlVrrUnEar5M+UxxQRH502ifkM7W8rwWIJ0isGD0GpWggz+dFhGkdmK8WOJrjvoPylFprrFrJZI+rikaiPjiT6joZvTkpiLdD+wkNvyJc/60tUaZxTTD7IsjO7Y+2WjfCeI4R+v0Dm4MJchgVzLCGose0GJBnLtLQ+1xLHkCkKfUa+wl036FvjphKPY83FhnY546SM4HqgZNLhgzw/5fvWVl1OXqxeS5HDK8mRBbgiWnMZECDB2OBuXsDyXux5UEV5Hx8ZuzvfoUWZMQauqptJeZ+rXYWQDcF1xzBQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 15:26:30 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:26:29 +0000
Date: Fri, 19 Sep 2025 12:26:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250919152627.GE2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276DB96BCDDFC2DB68FAE178C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DB96BCDDFC2DB68FAE178C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:208:2be::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccda12f-9005-4a60-6bbd-08ddf790e7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5DxJNiTWaPyKxox0hwuNdFVIjJBSNH4ScYQzaYEVSykD6mOujjB83sMKg4a?=
 =?us-ascii?Q?gHEwdmyzyhtr2gJb5XJiZwyDTVaCW+4hrNPsxHnrBLqWY91l1R72SA2deQj0?=
 =?us-ascii?Q?LOMZjm/gnLiV4ztYCDOwSA/wTO6FgtFM6GAsLNdqXsPfNMqg7Yjb9uazugxu?=
 =?us-ascii?Q?Fb2XZUzrgJ/cY+Ie+WNibtDK8xgvxnGjOSpXxGJZ28G78M33P5zrIooTLCgR?=
 =?us-ascii?Q?zRWmoitG3LXlqRa83Mr53jubsOKpxxBbX1OrWjk79Fvyfh0fSShJnFdPjbw9?=
 =?us-ascii?Q?hPoHe6s1e3Z6HXBRQAyuKxv7/5sODM7aiA/LuFD7TOUXbR/Uxy+1CTlzbe5y?=
 =?us-ascii?Q?TSQ0kEqJ7E9rw0Md+OxshsHHjDkUEI/qKg1g3eHXQ7N3yMAeyEGnOGkRHciu?=
 =?us-ascii?Q?tdbVAhFECIJGQId333QUZIAfpFFIbFCk6o0fQSsKA3TEE3Ly8bjNXa2KTIWc?=
 =?us-ascii?Q?ZH0/aqlYR434GrJapSGxxstnjQvoMv470fakoKgt/dLx8xpz0EvKxT9spXYS?=
 =?us-ascii?Q?3iYW+nwwR3HcplC9zkDxWaVPk2qULpk1tv5ex0ksHvwBBUPS1AawmxJanX2m?=
 =?us-ascii?Q?tVlPAiydQZ4evmum4W9vFCCbTofJXoFA4FZzpFG3Tu+LCsulu7wK/q/NG8z0?=
 =?us-ascii?Q?TYIVJ2RigGO8GfLLbHwD/ZRBvmfD9dZsNDLeVY8zBPFbt0VelkYj4UVX3JW/?=
 =?us-ascii?Q?v/M1JmQ9LYceQ5zUzTPQGR7QJnr9XzUGU4TqdNaBJE8+KCqTIF9jdv5f2CSK?=
 =?us-ascii?Q?kXk6XON1fGE5qkOl2uvSMLbz8ZXVWZ+KzBOK33llSqSC6+8Y7N7iGOavXvrW?=
 =?us-ascii?Q?XwMFUcY6Y2QUit84z4zCC6behSEnqNQB0v+UXb/pcT8SMUGF0SjCoSeSfv9D?=
 =?us-ascii?Q?limeWh9jjbZCKX91P3Q5apyzwGoUwokKKt8UgZyxuKu3SdBmLEE1keISdfSi?=
 =?us-ascii?Q?oG3MWnrS3fIbTqOwWpin8QDEJo2yrSfnc0QsesZ2JDOaj3PpJ2w9/Ry+5/u4?=
 =?us-ascii?Q?dNxJJhMGHojpiSSjGa1BhfGpCp+FII5f0tYftXYEaNWbkcl3NzE9bs5+NcTn?=
 =?us-ascii?Q?hKlAl9a8u+e2fZsGHcvZIRvI05jOkggqQkUOwQyYXOfrPo8Vr8IOxJ8caNtz?=
 =?us-ascii?Q?bDWCSuKjWIiBakPkDjQrwpAC0SYHb6SsZOswyh1MKI3WOhQuzsZN9+F3exQY?=
 =?us-ascii?Q?uS+8zGZl31TxqhsriXF+3Z8bEg2WR6rJ9S0gZJWb3s1Bp8BNW2AXEW0wmwJX?=
 =?us-ascii?Q?cOEMhcw7m0J/300h+O8tGmtXaU7NRoWP4+8k2h0JmtxgsNmQ4MVSpiQfCzLV?=
 =?us-ascii?Q?vsQ4ia+QZ39MTLpG0Je7k/su3Mfw+kP/2mbVBEvM94YokhWQpDQPaQ6a62Sd?=
 =?us-ascii?Q?oJRsPbAnZi7khguySQHBwfome/anNnhUeAMolL0IjZ6y2vEFlKasx0mHmk46?=
 =?us-ascii?Q?e0vv2lpduGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rz3vSjUkiZoz4KRG5mZt1oRtVtTxkD3+2aKs6ODk3ebqIvf4WKjdLs1YrYec?=
 =?us-ascii?Q?4FjS1gtpmmtKDfFMLWAtpu3HVLNVVze63qHHx1kt1xZWLxRXPezG+sUtYSwA?=
 =?us-ascii?Q?scEwEv+xIWAqp9wqWkANv3+3xJSqxA9D+zOSFtLMRu+LcuplNOkkJjGkfqAJ?=
 =?us-ascii?Q?R2hIFWXzwegdth7Jm3l9/Uz7nkM/TeLeoOQ1QghBL9Jh11A5+wVKc6TNpPR3?=
 =?us-ascii?Q?X9TuUS/fG9lwpW0jS3bvTvR43LSC4owr3DfwSh4MmbG55S3LiQuylJUAOhYo?=
 =?us-ascii?Q?J/+r2WR/6anX0danxq452eBv/2PzCdBWSzwMQgN/IDoXvmgY5OV+S7WuG7xx?=
 =?us-ascii?Q?i3T1ivnRU3hPwkg8UUVoXvnZYI3Ky5wKAJ3TK/iGVusyflkN4jqbJ8q2KA4T?=
 =?us-ascii?Q?LjqI3SvjZ5hWimfdWkb7Vu5ZsEqyJwqRDZ6+37XT1s5SeOvvEZn7L2jYujMw?=
 =?us-ascii?Q?4MxHxowF8MWppbYlOXYmdD/AW9kk8+u9MTHfptdvC/qxanJ6/W15UJ0J/wMN?=
 =?us-ascii?Q?nDpItsBpU3PYtaCwmlUXbUOgO3wkh6ttgOSe+6rdodDHtaMwiEDOXZ+ucxZR?=
 =?us-ascii?Q?ugdTk6fxmls+kvREPTU5czAvqbN5m1ugy8ah1JyFMSQdJWMsdCW7QrvhaNkl?=
 =?us-ascii?Q?xDDF4VtW+anLu7BDMf/h8/I3xayeez2bBFV7/XRjvkk5X0rYcQPZM/IOw2wy?=
 =?us-ascii?Q?p/H2+i765RX3Bn/H7gZJGBhTPzAPlGwenpXEHW3aA6XK2tSR0f5kKBjJwhWc?=
 =?us-ascii?Q?adr6aM9XHnEmzZcL1yJfmNUtdhRX7yDcQhyHKjElQyLwTz7yp8luCbhZ5NHm?=
 =?us-ascii?Q?hSU9g/5DOoV4NMHlM49D3g+6zWyY2PrX0pXrrWGNGhXR9EfKXvbFV/duK+aN?=
 =?us-ascii?Q?nqqqp2kspFF1Q78VL6eEbv9oXjugpWvuQ3iesHyTeY9MAtBlX8GqQzVzRxNX?=
 =?us-ascii?Q?YcPHhdEa9Km1OnIFsoZgwDsKl3AkXsA0cmhJHHnd2qok2ll3/OCVEs37r7W6?=
 =?us-ascii?Q?2Q+iNsiSpisv6jUVPWExvPq7sJcbgOF3ZFzHKeruC1eKSV3AWJ1Vq+YD9bby?=
 =?us-ascii?Q?BJ6HwLLWdPIVWxITcpn41oGDlcbNFaG7BYkvKyGNl9L2IyQ3GxMaRU1An23V?=
 =?us-ascii?Q?Dq8FY8gynhfRuKR6gsUnae6HYSn/19uFme3gP5ZsT5iZycmKwKsu7KqzrejR?=
 =?us-ascii?Q?7TPBBn8MljzN56verYnGR3HqUxLDpiwWOvg+4yUYXWsQJH5/7+jmLFhmIrkl?=
 =?us-ascii?Q?cM/+X4Ysk7qSjH/vDKJ2gofY8xYvvLuVIFtBR3G12PjAIVGcYNJqr1oka2R0?=
 =?us-ascii?Q?n9dHRG6XMfxYzNZ6DqQzHxDPrVEoAX77+QtFcIcTR65LRBpYABL0n+EJzHMq?=
 =?us-ascii?Q?P6wuX6jPu8q/s2RI73BA2980VrfWL+cTru9L0S3XVzqzrxpMjMHEAyyXGRSC?=
 =?us-ascii?Q?xy7oQggfIgLybYfn+VPeiOqeH3nzQ2aK0M6xeMnR20EnVPt7aX9/q5H4n66V?=
 =?us-ascii?Q?67/agl9CbuxVfVW328C9bIIDYcaJReiiLoieHcx04Q5kxN3smMnkngonVbhQ?=
 =?us-ascii?Q?tnoIJTuk3/XwBDfSzusnkea6QV3PCt02QAf7ntdG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccda12f-9005-4a60-6bbd-08ddf790e7ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:26:29.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afu8VaKt/O6rpYgw1RrmJi/59Fx3ycdtWxtMQBsDIKDaZ2MbbQQI2vV4QPxBlWef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

On Thu, Sep 18, 2025 at 06:58:04AM +0000, Tian, Kevin wrote:

> I don't quite understand the purpose of ignore_mapped here. Could you
> mind elaborating it? the only caller always sets it now...

And I'll move it to the map patch that uses it:

+       struct pt_iommu_collect_args collect = {};

And invert the sense:

	/* Fail if any OAs are within the range */
	u8 check_mapped : 1;

Its purpose is to micro optimize deinit, we don't need to check every
leaf table to see what is in it during deinit. 

When processing map() it is not allowed to overmap something that is
already mapped, so the extra checking is needed.

Thanks,
Jason


