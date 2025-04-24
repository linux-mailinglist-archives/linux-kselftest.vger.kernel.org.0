Return-Path: <linux-kselftest+bounces-31558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A46A9AF82
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35E9465885
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96922424C;
	Thu, 24 Apr 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVNeOeiQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAF19E967;
	Thu, 24 Apr 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502058; cv=fail; b=PJi5TeTpTtrYycyZoBkzQtvFRJOWMJD9fhYDiZ+o1oW/qDVQzWS6sQCUEYOTegwdVWH8AdZThZ6Ndk4uxPfQ5gpzEelOagQ0nCbciyfPGRoYwQGOj65QyE9yj0+Jh0nv4N+UcboXo4hTvQrfwU+aPCch4U19sJ2UhNlnHIDn/2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502058; c=relaxed/simple;
	bh=m1wxva/gfGi536UoO+NxDwhYy3cGqUknJ515j/4oYTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s9prcn8LHBTIq/pn5B8+heXCpWNmRaZsvDSm5H+vaAlY8aCw6foSciQ7+OoH8xC+VQHm4JjWSwW3jWTPrG9jk4eISLFhyzlMmp2mekHaHfmYlV4Em2j6pWe8KNQczbG2bZ3r6wV/NOwnm+SdNjkTO9I/DRMSRaTOXl/NJas2AeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KVNeOeiQ; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ3/dP55o0bneCIOJvuh7X9OeuVYxfLv1RDothYmtksRnJt4OmD9TslDh7HwLDUTxx9NMn4BHnJJuNc60paXj7//rJGhxidifvlsRIOWmUcmBKhrBHi7C2mAUxS3708yI7Vp22/CDlZ1TNJgvblILQsg39ynGqXjVFRqCApUBjBHOuleYc44vP4OcNli17vM2nvVbh/XtfioysZrVINWyJ0P8rZGrBYZB6QvEf9J3BOTVRmRYjzwhUIdbrGAUlTQrJ3pamxYPYwXAaga+YMT0i8mLtu85nEVtexFwzd3cjVbu3yha5z0+loZO10HIFpNhEJTItI5dzh38Tpv3ALCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+gQGH+XDK8FvmDQoOQshiJA34I+izjI3i95dApyE6E=;
 b=JEL7x7qEWtMU9gbkhQ1POx3xSbb9mMaRV4p7VArvktGHNIA8aJOwhsSy1yAA0Ycv55gUTgpYpy2jp64qUqk6sljPVJI0TY99FqlmNOXJslaHQ2er2xjrZ/RKzrsDVrqT3cgYYZz1N1mbRVFYYuMPyoVTFLui5/0JGN/b4n7HJEzT76tBZvkfrDJOV0YthqFgiVWErovP4vGyJo6cKm2Bj6GtA9afEKmFmwwtEea13he80sdSt/eQAidQktzkplkOtXFaNKaQiGfbOYit133ogp0BfB9QWg7MAQHsDe2Tk5JAwYkr8SYlrtnKavQz2n/38e8SM3RaR3FvhDmyOf9qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+gQGH+XDK8FvmDQoOQshiJA34I+izjI3i95dApyE6E=;
 b=KVNeOeiQqcod1JH4bskA287DFx64znoP9SQWKkWwYk6z7T/ehXsIjEE22pD2e2tkNIVYhgCIyIAWLt5mjeKnV0QyoVJcadZV9pKedooULJsMEx3l6dUayFWERwaFa0oaCM6lI+TxU49DFb6IMOna2JR6RN9XWJ5vOqSHbF0kWSY3Dc0c/jEmdkOy6VX4bIFlOTZi41Fzd85g8utI55CU5FuSmAhQu4yrLD+f3oWtIzKyLnRx6/GZMs09kHHExn+GQS5Lcz2EytzTGFczdE0Xm+fqrsPS/lX+y5dfXL2eRMYROkLmms4pYOKiqZcIkXXDIn0goIf90CH+Zc+OdiPCqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 13:40:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 24 Apr 2025
 13:40:50 +0000
Date: Thu, 24 Apr 2025 10:40:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250424134049.GP1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com>
 <aAkyAbO5UQRySizN@Asurada-Nvidia>
 <20250423231333.GN1648741@nvidia.com>
 <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac21b74-76fb-42ed-46c1-08dd8335a07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W44sR1P6hBhlg0+vtpIKFA3z2vrUeHL46a8A2jympX/IIpmflqQ4W7OMsPEI?=
 =?us-ascii?Q?8tG1H8FsEe6MqIKz00D6zYq469H0neepEUzfmOm83/P/ggkmcFY1ZKU7O5l6?=
 =?us-ascii?Q?Sy+EMhMQpAYIxHyHrCi7DilVbpPmRA1SqzMBqPxWzAWyQBmQWoNyaOSAEsQr?=
 =?us-ascii?Q?XTWS2rLDxqnqD5DZmIAh+tRfQVJYpRXfiunrIGwpBoFK6A39uKIua0pyy6zJ?=
 =?us-ascii?Q?kJx/51oZMAx89ZTV1B3cRlff+W4msjDmCu+ey3IV/Ret/y874q5IrkmjQdP+?=
 =?us-ascii?Q?J5jnt/KFspRV64jG9d1GOSwt4EUstXtql+h0XobfXbd3kGczQ/RrfTmKGIx0?=
 =?us-ascii?Q?NJ01ddx9b0ixKDueh61z7i0U36e84Z3hIYjhvY5qBzXkjn8ZtQHSR9MZp+IS?=
 =?us-ascii?Q?cW6hoGjcZOdOXy7kIpuwU0hLd2QAJ78iaIHcJ2NaCjm6WLR9uPjwS/O5MIvJ?=
 =?us-ascii?Q?Aw1UayHgok6HUZQnlmLzE7SOSCLoGY3H421OpefLsfBiF6bKjSk0cbO8T5ew?=
 =?us-ascii?Q?JP6+T62bl+0Vn7Flt3ehO8aBnc7oRgtoGXvtwGUE8sx5f/hmUiZfDZpN/P9C?=
 =?us-ascii?Q?Av8tDu1mpK68BoN9vt0XaUjfbjjm4QFeZ6f1ycSciYCLe+zLVpCOYYYFu9mT?=
 =?us-ascii?Q?Ut32ydKCccVt3fCAq7bmL3qYfEuwcp2HbFUT9+82OKzPCEB7HCBJ4yfW9Gud?=
 =?us-ascii?Q?s86/vqcXj8b8BEAI7oxPxGj01xoY/sQ90Jv++u9HYQWKAcHYZp0aWEWRNhLG?=
 =?us-ascii?Q?4CdLniMcEMtnd/wlV/eKRhTfMdo70AgXuKSAJJDj5PhFuq2EgVO337JtwkfF?=
 =?us-ascii?Q?oCHa7eRzaBVcakZcqRtTwUHxh1P0XJvLxgsejnDWX5xDmOi+sc7rybN6P8rt?=
 =?us-ascii?Q?oEvi0+RR0GFXfetB7xqIj3/5RL+0wOrxNRvMxSwYyyWYLTIIjaGfWDKegdhD?=
 =?us-ascii?Q?iOV5EtPfs8LdMEuf0o3UGy2AVCJLHy6Z27Q0Vxzyp/VvJB1a3XIY6owA34oz?=
 =?us-ascii?Q?2YgcTwczHrpIwqv3pEwpQIvWuWGllg7kTB3lTXZEnzUgY5WCx8+11Fy/HPcP?=
 =?us-ascii?Q?p4fWqxd539WKq7KerOVcLK9mt45xUEwKwu4eOeRuLOkV44n6tu+ZBewNtI9s?=
 =?us-ascii?Q?8zttqxULIerST7urN8F0e5yBM4AaTBArDZ3uF8N21CnGrEJgo4u7WvmvVi4f?=
 =?us-ascii?Q?y1CVJ9RCydL4iXub7zpXIXjgcWRSKX9Cszwqka4g3zZhfINfARX9Tt6cLlP9?=
 =?us-ascii?Q?4d6s8jLC3ORKnGYzG1p+IKBI/pC10wdzormRuv67QL7cm0on9TRoP96/WIVI?=
 =?us-ascii?Q?1Mg5kL78HhdUyhI2jdjscFQNr3N9bm+wjYCwt3ZSw4/aihvznx2LC/fipXcs?=
 =?us-ascii?Q?xcyGKnaSrb2e42SqMGyOQrRZkViQs4BOKWc4KzMK1gwBl1JU7r8bdEVrvBRZ?=
 =?us-ascii?Q?Y8F/8eaGoWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1B0T/TpbGYrdzzO2e5mgVxdeqyfxqwFZbc5lPfSkHmL/XEOtt1+SV7S51JP?=
 =?us-ascii?Q?wxKntflLtRD40+/aeU4HtfkCbSFbLkMduWsldP4sk+J4j5vNgWo/IZbQd1xa?=
 =?us-ascii?Q?tdMSo7NJbmZBABMAyJ9XMRUzGzYVLaf+fi+eYD2uj8Orsp6juE+764lAK7FG?=
 =?us-ascii?Q?zry5h+4H5DqCnw+3NqBm6td9OL9XdKMwlc7DY71VNYQjdoqF8DknUYuGWJ5L?=
 =?us-ascii?Q?/rFCsmMjYvIRGfAj2plpDaOlvNCBy9ABvQTfyp4fVZ03e0q37KUu3GOYN/sq?=
 =?us-ascii?Q?RMJaQzuRe4CxPmmWpnYJUyFnqWr/iG60oVKV4HJeCRa7VKR6iMni7UOz8PTJ?=
 =?us-ascii?Q?+159k4wM1fFjx6Bj695f4IQ2LhiSR09YyVAtqT6zosYLmo5gz4yrUN1HTjXV?=
 =?us-ascii?Q?2AXwuuziJFQDaF7GxEj54bzEMbNdcR9bZlwZex2Zdqxevh87svtbFs/7xC1J?=
 =?us-ascii?Q?S9sNoBrL7FNLjhDN2tnNkutkAW5HfWgiiwzr2fuwhQgKT2nGKgLilKywT+Zy?=
 =?us-ascii?Q?nKfT0UrJFc5LBKUP6GANTBiQU1KYna8lhJC5q/e3h13i5yPalt/uxpG16opd?=
 =?us-ascii?Q?Kferw8U+hYFSJoG3ami7LeZciKDAp/Txq4Nbi+YQAt7j+v9y++vHnYXnZUuz?=
 =?us-ascii?Q?+nR4UqCL1qW89PH+Nt0UPiZwfAIbAxId1vd2GIl+NwAwPH/tyUlHSWBEYMQT?=
 =?us-ascii?Q?+wH44rWK4pxcHvwV9Ezh1CG1uLDFvzhdLm/Hy3TFLRebMoOilJ4HFJisIbQL?=
 =?us-ascii?Q?qjY2ZurxZxyxz1HHY9Khxnsc5LaDXWdafQLWUw+KrZIqpTm8e2SpFYMEv+Ze?=
 =?us-ascii?Q?0R8MeWvaTNs7ZEnchn33X1Tw34ZxHgxL63q3G1e70mrMn+w7d2SeosTeEfdK?=
 =?us-ascii?Q?I6EBgqmeYVknx1/1UGv2JG0DnKRN1eipM3BZt5eZjpm21mHxwFcyi7EBHrnU?=
 =?us-ascii?Q?iAKQeVWhZSK5ONiUw6QcHwRNNxwh3+CFiKzgHCp05YKCJ8eDWcXQpQ1f8a+k?=
 =?us-ascii?Q?Br/+sWCx7kQEytygJaNw/YYgCBBBv695XznKeOpa5ESN9mkD3BIA0SCSEZpD?=
 =?us-ascii?Q?Q/3i2Tjb+hHbJobbGPCnrnyUl8mjwCjsJQx4Ntzpn4pvvQKtXBUzaBaliQTE?=
 =?us-ascii?Q?Ukk72YUhkjcF6i8bjZrNr04FEA5CcLIoEur9bwkXmcdgf3FUshM0Xvy+u7zb?=
 =?us-ascii?Q?wnZZMI0HGxaPLAyQaaRp/h3z8qwhODEtQkt88bIDtq/6bzT8Ltc7Nuc5kqMb?=
 =?us-ascii?Q?cmirykkT/8bEp/plxtji3sjwZkdiABIRTqkZaoahuvvIq5dshAc8vdcZOb9M?=
 =?us-ascii?Q?OfUTwgN7pLGEVRprKZdy3CERCo9ptPIRi97RFPMxDKcVSFcXZm0iTHy3mkwW?=
 =?us-ascii?Q?/CDgH7N58U3/ueBX9v1Efp66WESaKRdWgh6anhbOihVtJkFo6Dc50SwklOKN?=
 =?us-ascii?Q?0iwUBD1a2JLJDO6ecEaG+kG3BlQTo6O0OxLQtCHk/nzRwQGX4Y0aHuba0fBI?=
 =?us-ascii?Q?4StLM3Uul5Gt33CG4eNutCUDO//l+948Uak4ds6/qvrM23z74WKYgjMfLMBa?=
 =?us-ascii?Q?mlLKFR1JPoobDL8NR+vi0FsuFNwvqCnCSrRAmWns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac21b74-76fb-42ed-46c1-08dd8335a07d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:40:50.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq+XVQzJ23j6dGgSgwD8vSMEcglvbf6usa3HVgZGu6WP/JJzp2W2Cjez/MYYVsve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

On Wed, Apr 23, 2025 at 11:51:53PM -0700, Nicolin Chen wrote:
> On Wed, Apr 23, 2025 at 08:13:33PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 11:31:29AM -0700, Nicolin Chen wrote:
> > 
> > > > It also needs to act like a mdev and lock down the part of the IOAS
> > > > that provides that memory so the pin can't be released and UAF things.
> > > 
> > > If I capture this correctly, the GPA->PA mapping is already done
> > > at the IOAS level for the S2 HWPT/domain, i.e. pages are already
> > > pinned. So we just need to a pair of for-driver APIs to validate
> > > the contiguity and refcount pages calling iopt_area_add_access().
> > 
> > Yes, adding an access is the key thing, the access will give you a
> > page list which you can validate, but it also provides a way to
> > synchronize if a hostile userspace does an unmap.
> 
> The new APIs are very like iommufd_access_pin/unpin_pages(). But
> to reduce the amount of code that we have to share with driver.o,
> I added a smaller iopt_area_get/put_access() that gets an access
> and increases/decreases the refcounts only.

Maybe the access should be obtained by the core code to avoid the
driver.o bloating? All the cmdq types need a memory buffer, right?
Perhaps that should just be generalized

> Meanwhile, I am thinking if we could use the known S2 domain to
> translate the GPAs to PAs for the contiguity test, which feels a
> little cleaner to do in an IOMMU driver v.s. with a page list?

You still need the access, and the access already generates a page
list..

Jason

