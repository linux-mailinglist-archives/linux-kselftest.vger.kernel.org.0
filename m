Return-Path: <linux-kselftest+bounces-17771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA27975D94
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 01:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D721C22811
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3B185B63;
	Wed, 11 Sep 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVs8JPZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E41474C5;
	Wed, 11 Sep 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096062; cv=fail; b=s4Cnf6MjEZoss7CCFv1dW3/I5m2I4MdryUfgQSjCGK4YL8o3vLQNcWxlBOXEbH8LM03796n2Oe6o61qAorXtTBnzUSPY3Ii2/s/Afuh5+nBr/fzfNS2h193uM80ZaMhsWp5/fotReCL3YydwRpfmvWK2qsz8xai9/t3f9OB4nUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096062; c=relaxed/simple;
	bh=4qJk6LvBDv+5hzNQHr6m9Gaf284C/yj87HuushTFrGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKfmbQJn4k+3xyBb4j4/ZAiahvHpxWg8xdyKYJJDbLnTcnKlS4nO9frv1ClbUuayWOl/dAxrna0ykBqhp6Cl6Fz9LUUif8YNuS8T9hlJ2Yi6DgHMWyABizTcthKgyM3SajM74xxSzJms9jAbEa+MVS7jARBHH0+LgUnpCj7zpbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVs8JPZJ; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyvMoMqobRKECLXZW8YaaVVj8Em+1MljhTQiWLG0xUujWIEkxTvPLdBPpnFMsNyP1IpgL9IZtWjRNEg4rHBbXS8OY446RPo1s5ZLaEr4UYl2Wh/+RglgUFu7dKo/UobKPLxzBCpmOtERu60l3M9is9pXEQUTJ7L7H1s8ZkyiGMpU75pWY6rRzFsQIfOvUbpcP0ZEuVgvAaEFI6WEmyukQn0WbuPFIYT/ZPCrSeCXdKA0c/x/lG8TdGbT+bTBqZURCvHNEp22rUZj6mzSZZ2C13rVRNCHHvqmXoxLVGsTG4fjOEh8ezMrm2QY3DHitI5r3BMIMa37DVtzVqkBSIkZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qJk6LvBDv+5hzNQHr6m9Gaf284C/yj87HuushTFrGI=;
 b=nWLR9bEYLSxGMU7BTB+F690hBnzl5YEzArvObApZO+WeiY/bb+LioCxrkPlz4uJj8PPdjtK/ifJI3ijCV8MAvN4kFreC+xzCnqeqwuh0oIARCKDzxs+i9FoDJK1r33JQ9s83rqJa1qwlREiCB8SrS/VlCZVGEOI1zEST9oW+hvNFlii6W8oVvYGFE85TFUbOS+BoP1rj59MlpO0CcIGPPAgfyfXckXpRdS/5kSemxcSsdvASTpblh4HJTONVprb7nUuMQKk8UMPG4c9CtAJYIBFPiizARm5RhvqU7E6Kwd+tktbuVt06TgHXMAxufCmIbnOfWhMTuamzdivSic2kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qJk6LvBDv+5hzNQHr6m9Gaf284C/yj87HuushTFrGI=;
 b=ZVs8JPZJFo7b2fs89io1WUGrTP8EWi33qtyMwQBdZh/YcyWcJIKGVaeeJMiYm6JFS5zYdIrYlqfFC/KfQk7exN50E1j/9J1StTvSowl4yCd1hcPXAQDfT6klcVFoX2GQG9yLzOsyukyO6MFMg6EaitV4v7E+6WJIW3h8KphkHEssxU3hq8fq41UZF2puow9IILPTX7SrUqVu+wNaSFwsEfD3vZp2XaWkulzfREpMY6K/ecXexrerFARiA3n8ROo1etJYoEO4LQVZH9NaOvjFuFPfPHScak2mUxxkDA6lSLAUT5fJ2yW98QuNtrg2NNH0/MHaJmoPQoDWd44UtUT22g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 23:07:37 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 23:07:37 +0000
Date: Wed, 11 Sep 2024 20:07:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <20240911230735.GQ58321@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a519cd3-b107-44d3-14cb-08dcd2b6873e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LkcTWWgKbaKLFIebzZesqtlaJ+uPijSs75/y46trG8mrlpFnJ5x8oTtvOXST?=
 =?us-ascii?Q?FlMXP92Widpe9NhZU5inZhE0crEhFBifbUgWvLJrFDlHphw7IYx1itb3Ao0G?=
 =?us-ascii?Q?EYIG6hyoDQK+2B4NZ3GZGP+afhdSFOA5loyc6qt7uH8RmvjZ/I4zhboxSitC?=
 =?us-ascii?Q?i+e6otRtBso4CMUYL5/9bL7UkdVD2GWFGu7NwJLMGuGZhss+bDoL7Jn6kDYZ?=
 =?us-ascii?Q?NQh/72zgJKWRAF3oOeqGx+g0ijhS2wtW8N7cr2rIOsx5gOxevRYO5OeYFpsK?=
 =?us-ascii?Q?JsAycMDWX+Aj62/3KjwJ0qusEeaPXKXShiXhb6/xadxZE02xXBFBTWECS9n+?=
 =?us-ascii?Q?1QmMcP81VjnTh6UGIQVZeA8XqnhMirCwY5H0PAqc9dgLAbAXyrqmUME1tBo3?=
 =?us-ascii?Q?A94q4ftnkXddeIQI3QHEH9//1qR/fnleqiO48LUMuFN0lo9R+hwv42OshH1X?=
 =?us-ascii?Q?BcSdjy3QGLCNrPOJy9zjRGtozNmzDwpb+ip1wsbBCZJjkJIMMVzVR7lZA8N/?=
 =?us-ascii?Q?HjnycKxP+P++zsRzEude0XyCDXIAUC/Oa1Nm1mGO0xnbaWlxrz0Y59bI8/Xq?=
 =?us-ascii?Q?cmjS1PJ/TIT404t2Xd8GW04LwZZF7OLaWc7Lnq4sX9wUXaoX42+CzadPY8IU?=
 =?us-ascii?Q?YY4NO9xsGkx/1DVeJFe2kkyLIxNDcKI3beGZfm8ajqulbL4GtDuUOSX1vGhJ?=
 =?us-ascii?Q?/auZ5l3lx/g84oB4lzUFzTBXovO+gtqxGe0QouRpq0Bs8rCa2XZIcv4a4n/y?=
 =?us-ascii?Q?PdFAcWlp+D7qyy86FYLmHaSTf6GOxxv1Y9cUY/5UWmzatZz7cLkWhbWbK9d/?=
 =?us-ascii?Q?eaBaTNmiwxiBt2l5AyhpRlspKazO+X17A64zCEq8Rmz34rVoV8Xny0rRpbxX?=
 =?us-ascii?Q?KBnOeorc3OdFKeqgakAwZxkKINChJZlnOxUc5Yg67IN9KIofd8mIZAfp7zgO?=
 =?us-ascii?Q?3PtaIMiwtC35GYT0TKhbS/2UWeBF+IBSnxihchOWQYUNMAlUJY3d9N/jomsq?=
 =?us-ascii?Q?3k4Qj7OKGcfuTMg70Cj/xf1Ppz/K5kNOk9ezWimO1ZqQPArygHS4QF+HSbFE?=
 =?us-ascii?Q?HYV/vnDBgxjiuRHlieURxcwgwSZAWvq4dDM95/vDZeuHWPXgGSPPTo1s1SQ3?=
 =?us-ascii?Q?XbNycakustEHGyi8UBMJjCzFHmMTmcQXXtrrpM9KIT41mURwH0v2s8yt0Qr3?=
 =?us-ascii?Q?d65HJugpsFOr0aC53UmHImPbvnIGYp3WFoQPMhN5bxIJedVyXQ9DfAOBg0ms?=
 =?us-ascii?Q?u6bPX7Q95/SLLv7dikNhP2tiKADpx9YHMGNUtLxo6kVlxudo+jZ2KSVn1s2c?=
 =?us-ascii?Q?biVffDFBgkw/yw1LUPomSB3UDO7KqVPi9YFPj2GeKLz//w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgVxpgTM/fVzcQUTOPhjXNfUTfX72VMaoApheiaFyePsMiRF8VebHoLYxp2s?=
 =?us-ascii?Q?RKzrkdxmsIaj1OzGw5EPqb8jlEV1mv5/hThup9B+8GX+2N7mzsI7Haaea9UP?=
 =?us-ascii?Q?UH08BQsjCAwUtKdh6nRYwN9TxAdRiWtzFs4NHVR5Cp5/UidSn1S8WiFVXu0h?=
 =?us-ascii?Q?xAq9EGaqxOauaZsQ/amcHHo8asgLHuJ3x8tN8p/PVPKwE4vROmcB1ewYaxsp?=
 =?us-ascii?Q?v+MR+Ilt4e4QvkbCZcxO5orxFhkaV1aGQXzcyli2C4XeUe/vkEIVbTqxG0ON?=
 =?us-ascii?Q?GDLl/+uy7mjrvix7DkcusET855AFKloJLZm3J3vG/bJztKGicDVBNLcKOA/g?=
 =?us-ascii?Q?zdGyCcY/EjVMpVbV1SZiNZLgGBJir0KZBgQRedhO0M+tSSg/VaMnzTEDj4yT?=
 =?us-ascii?Q?36GISxEaXiXC6E/XwUBwxIflKDIFKAoD5a3RkKDLfhAQV60nrfPYx8RiY8gF?=
 =?us-ascii?Q?rUSKKaMhcQGTv80iZNvyGJiEP974fHjVrude5ddm1KDe2KcTxryGUzuvE56A?=
 =?us-ascii?Q?wTbpNTY+6VtFC78P2VTNV39DeERRSSEKz3ENUnbJSG1bUGThHtSf8zZocGTx?=
 =?us-ascii?Q?0/qZL5dlJaFz4nzKq4I9R5lSWPcAZFC9nvbARlRgwKAfootOoI17O/bzpt2U?=
 =?us-ascii?Q?9wefRam7Yn7B69maKeF1OUOKKuGrwdS0Q//hok3T3RjbGTiOj88FYhw63xTD?=
 =?us-ascii?Q?6RTYW2LPum5byPbORnC68NESwdHVHdWc1i+1dMTxtFsC5+9nhO8SjHIc0ZtA?=
 =?us-ascii?Q?MpJvYwxNbtR40p3wvtSdi8Zz7NnYDmdcQm+QeOuIy461wv7enWdfW9mdmYwt?=
 =?us-ascii?Q?XTct5UzfWsBug+ls5ev/pacclfK/Zkc7Xdf080JiL+9SKSszI8nEeblEuQcX?=
 =?us-ascii?Q?Dd7z8NB2uARa8ZfiZD5ks3wmtZGORtz4Xc2k5lWJVFnV1Xm+LJWb3kj7GLeC?=
 =?us-ascii?Q?WkiLLpJ2M1Sr4K6vFFzVCJVZF/URXie3qIpLzw42Qi1lOoM5ZB96NnuQNCvp?=
 =?us-ascii?Q?pm85RLdNz8D+/H8FO2LrzccCl1BpfKxzmk7/qg1/ImvdSsgdPbeOdjjVmY03?=
 =?us-ascii?Q?PG+Gl/Cd+UNcMLCzOz0rO0yWssGOu/Sv4braVkrKIcU9m+gE67Dw0qi1GTiV?=
 =?us-ascii?Q?TX3gUY9UzxojNjhj8fvuV443GCk3h0WBE3xwZTn0ye8gi2SO2Qj13svtWL79?=
 =?us-ascii?Q?to4uqJEAewA6LCwVxzZCzuM1QazNRJVCAwSnSDwqRCr07v0hoYkXj/pcQavV?=
 =?us-ascii?Q?4zf+lrblRlg4l4y0hOL6Q9CKI3FBPncynUV/Eo88u91uVTeFb0X97rg5EqQr?=
 =?us-ascii?Q?QxpkiOKdxjneYaeB8yN0r3LjBPYPZu2bRrflkdEyD6JxiN/j0B9Z8Z5iLqQP?=
 =?us-ascii?Q?mJNnRHNH0HjvyvcmQ0xKcareV0sbeqU/W6JfPqK2f6lJch4wlLSnbUcHUNhl?=
 =?us-ascii?Q?SGbxBon1CgFXKJROTSLWO6c1bWARX6GTb6VJzjhw2cHu6d3CHQLsrzNcThLZ?=
 =?us-ascii?Q?PVklw7kjBV6gSdL7DCUaRj4Ts56x1SNWQbIjCdgolvV461uUCuwVH+B6ktPT?=
 =?us-ascii?Q?1+ZWT59WRgbTkQY2fT/XeESd6acSqwkFLAN761lh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a519cd3-b107-44d3-14cb-08dcd2b6873e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:07:37.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkAWKJQhi7PT5sAjnzC49lx+51ry/kEFErgx5CVugG65+RC0c90+cdCmpL7/Dvij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143

On Wed, Sep 11, 2024 at 08:13:01AM +0000, Tian, Kevin wrote:

> Probably there is a good reason e.g. for simplification or better
> aligned with hw accel stuff. But it's not explained clearly so far.

Probably the most concrete thing is if you have a direct assignment
invalidation queue (ie DMA'd directly by HW) then it only applies to a
single pIOMMU and invalidation commands placed there are unavoidably
limited in scope.

This creates a representation problem, if we have a vIOMMU that spans
many pIOMMUs but invalidations do some subset how to do we model
that. Just saying the vIOMMU is linked to the pIOMMU solves this
nicely.

Jason

