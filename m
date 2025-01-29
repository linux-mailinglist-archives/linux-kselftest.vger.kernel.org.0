Return-Path: <linux-kselftest+bounces-25396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64EA224FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D642B167C22
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5E1E231A;
	Wed, 29 Jan 2025 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+cAJWcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24D29A2;
	Wed, 29 Jan 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181593; cv=fail; b=Thm1EUC+bYzP3yN8tGwBWxjNxY9Ko3c84XllqW7eOx11G1Kd0IAEluelM+IYuOt9zdi0CkOBkh0J8dWhssHI6Wjhd1bJYpw3dXIjnZI8SdJTwTHzyf+a6b2DO6/CQ6hG5aTppqONqFsiC7/0eDNS66C0SCmulKCa6Baj7ZCMN+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181593; c=relaxed/simple;
	bh=KoMY8J+31tsHkXaZKiOmAGVj9cEmqhy5IpdhjXdl6z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqrCdFikQeiFXiBBKeyoDnw+YdnrxX4tZKxHyYq4w+M0a5qg0NGIaR/Y1abtmPWxxnOWlFo5eq9NIMFHMDYq39jv8lXd0uPqIPl/f5WxvYJ3SP7+Zmv6aIFhMwPhXKF+DjXw2BEWX/pTkpyVnwoM8rf2i5bOsPq+HIS3GVJbUe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+cAJWcC; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut3sX/NxCBWHRoCmjNHoKF4hy3WG/iNoPkO/4PoJoNIsfQ8JsWFEZeVb6fRONA824uuaaqftJ9L3TXXXXLvnToo6lH0RqAzYfzIzQifKkyN+iG+c+Z5/0ru3yrwZCWwffRXCV8ghPwywiqDRyCKRYIIdG4JV1LuogAfiRLyWsddjhB+xzy+WhEkaOsYtXZIb8z2I7q2LQx6N751q4Bw+9da0Nt4nT3DYIA27igMFtHIcZAkz/EQJpdp92hIF+Cjdh6DjP7RdBYUw6QQSEkdQ1XqVOnfpbK8/xI3LgLCxoX/TEjr5lE0sPW4LyaYQZmeTG483dcm8BecGgA5/MMvYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAaje1ff9XMHxfyt8koM3vxrI/9nY2e7FjT5f08Zctg=;
 b=fQdGxoQ6YJu2esUQvNnIR2a6dX3nm71SWKKwUuac/CZlNHgCX2NJwb7vLg/5V89wufsTpEDSeYBVihgAs4se+RvuLrQRRF24vdnvbDa1OE+zDWAb6UGfwCsagJ8+1x/2hFit3n8atIShILhEU3Uvysosiz+2HSyGufw6pAhhTvqeGuleQbA4XjkpRINUaO43dYkCS29rnkCbJSecjQ7OuyQ6KEcsrYPgFSzRpU1sAIwHWxt7VlDQWzcrn8/QKo5KHFgkT4jr/H716A71pDMdN+o5QMshaqTVtcCGRIJA+j91Zhizv6D/QvlCR7zzX/qjgUpVRztOrqet83ZKyms2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAaje1ff9XMHxfyt8koM3vxrI/9nY2e7FjT5f08Zctg=;
 b=V+cAJWcCwuepZwtOmNCL5STNkXAqDHM3rQmiJcp3mE8+HQMSKhIHkZ0ZNqooy7AJbpdw5O/+5cRGs2RDw+BpW2xLprE6PAhUrQG0inG54HOsFUdB21hIeIc8AdeaBjblaBEJuJhEa5jibwlnVOJeb2H4be860oFOsGzd2diE6IlTHq2a8lKTkgaBLV3BlcmmIjIag2sQ/VE7JapLelOl91LoY1vL5Tj9RbvYrwI8S8F6lZ3IE+Z881QOIjI8gM+1Kh51Mac9Wlo2eO4P81z8Z0JAENi29978ExUz2x35W6q85l2vW6/no6kuxvYLe20+lq+ohU5w9gBsvKFUJsIKZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 20:13:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 20:13:08 +0000
Date: Wed, 29 Jan 2025 16:13:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"reinette.chatre@intel.com" <reinette.chatre@intel.com>,
	"yebin (H)" <yebin10@huawei.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Message-ID: <20250129201307.GJ5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
 <20250123132432.GJ5556@nvidia.com>
 <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
 <20250129150454.GH5556@nvidia.com>
 <8e4c21b5-3b79-4f0b-b920-59b825c2fb81@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4c21b5-3b79-4f0b-b920-59b825c2fb81@redhat.com>
X-ClientProxiedBy: BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 24efa32d-f35e-449d-4eda-08dd40a158f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jlkvzVDu5CSWWQrwBHrrmivgQdVxaQvLExhPNLRICRVMy1r7Jflo+w8tvNrQ?=
 =?us-ascii?Q?pulIZ5KirBxUvk3xyyBdHrwouKo5kVNnOACY+8+WgslskCxpNep06LmL+1SP?=
 =?us-ascii?Q?0e59exXv2L1Al6QZ+LeG7iETekcyjZHxn4JVfwANzhuxzwolOa+ygRHDcLRg?=
 =?us-ascii?Q?x3lfNyXE+jUaHy/Pf4WILtPmFZybClmKB9KaRT7zwWNFBLPrTdPlGWwWk6oz?=
 =?us-ascii?Q?0ew74IKs3y8HHNrvi0qHxmoo+WDaCAwcq6GJ8iepuaN3pj86pV/dVrPibb/7?=
 =?us-ascii?Q?rIHFA6ZF9hG4B2RPJpUyY+ocvjckOX3T6/ashlW44wXSHaMYQXit3KkdwQgc?=
 =?us-ascii?Q?/TA1VzjZTA7IgM2mbj0AgcugIR7KuclFpRjHKBez7xs4bPchKmtQUSS2V6YD?=
 =?us-ascii?Q?LEsgcXJ8A1gsckE6FcAbzPndK0RdJHwddAyRnaATjavYwrTFixTCIXitfJ+9?=
 =?us-ascii?Q?Mneu76x/COJKTuZT8MXkFd74V7gtmqHaZ08LxwkGM0qFiva/yE9ECw6DBi6+?=
 =?us-ascii?Q?OYQ8fOD6BaA25ZL9YFU/z+r8Xc6dRY7cT51DLs9d4TyMC0g8e8gJXJRfiYS5?=
 =?us-ascii?Q?iQK69jUwXpRjsvmla2VDPq1g9Tpi3rq0lqyZyGaSwjsGu617PhUIlemmLK1N?=
 =?us-ascii?Q?NHzyoLwB9bY1zpl1j4UbIQaPkNiosLRj4F/SawVHuux54DBSrsNbBzu9cSHo?=
 =?us-ascii?Q?J1oEAM45YHfq0MF/YPvf2gqPgV+SqfNFgIEciIbGvnZnpeILdvE+V8o6BXXF?=
 =?us-ascii?Q?gd7LUxc/3GA7//ZKZyxsejytIIpP+awB1zcanXUzZMjTXStA1ILQ+MVJJMqQ?=
 =?us-ascii?Q?qnaPZpwttsU8KiBB26/GLZ62fMkQ38GJJnGGgiLWmV5YrQDcp3z0RWTyvAjj?=
 =?us-ascii?Q?h0q/sqyi6Sb2oYJDccZPqYlQkUsWeFQjEg8tc6+Z2sbfwHN3Jk2u/VSUsfdO?=
 =?us-ascii?Q?2XGuDoQ22x22bjJ7YWdCYjTuboAXOzmnnenxjHuVlH/pdORcxMUVED1Nxs00?=
 =?us-ascii?Q?/ttGbnBsXB3GNDy8JvznL7aPV6zd9+DkW4CaTOzfK4gdo3NcVk7BQgmAnnAF?=
 =?us-ascii?Q?X/SDTeeMg6RcI8l7+IS4kOP/YbdqOvR2Q2EypYR32Av+emTPSXkwbk20qlLY?=
 =?us-ascii?Q?MvHMIGS3LVU7YfiggacUEQijA12e1qaa7wb4wwS9oShr2kViS6lrn7EpOB5H?=
 =?us-ascii?Q?Af0/f68wFMhzJFyUh7JXtmraukcRdb2kQAjkcCxnaQeT/ywH4OF3rR/zy+BB?=
 =?us-ascii?Q?msYm8hjITjzzKKlyRK9aKNam3gwTf5IFiEIsUjCQq90YOeAvmnRxk+9tilDi?=
 =?us-ascii?Q?C3Nu7G6vPMbpWKWFEpby4X58UaTpZr00ICCbsjGRVnbOOjbUK/WJ+Sj1G+h3?=
 =?us-ascii?Q?RHrGxun5Bx1DhSs1bH/MaECvtqY5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8hsKHB1CNRTZgTqQkZ/Cs9mfG0xC1OZhAFZEzUcquwrg/BrjYX6aY/UTcO6q?=
 =?us-ascii?Q?qGID2km380SEpT7Z6cds2+n6cWEq2svXElp7868on85li9KOHlz6hy9vFT0d?=
 =?us-ascii?Q?oAWphSUHuFFrraNFCrzYnROJeTog4WdjU5SZCCBpEVlwUuaSVnnz3niAzr+E?=
 =?us-ascii?Q?ofxOQIvgS+gfxamiUu9baVnlhhQIDdLaxdCMBdt1G6dXw/O4roPDcDvNoetN?=
 =?us-ascii?Q?/2xb/AhjqlDNbXM0/W60UvhAdAKTfeImtjgK9+updoBSSJ1+LgUOIB78hzwt?=
 =?us-ascii?Q?33zu8ugV8VAL1c64udj5lSlosFNgSUiK5VkR/Ilc+JI7Xzf5UIpF9ALK30FH?=
 =?us-ascii?Q?zi2vYeQTSCdg9rOCI4GRckfrRvzEWZPIsFonVME9AZNcGylKBztK0SdQ1Kgm?=
 =?us-ascii?Q?+1WhLPVjxUvwhD0xB+4dM6vfsaaYWDEK18kBBnawElH6QkQhH+uhSumfU6by?=
 =?us-ascii?Q?uqpyyZzc2a5bEkOolvgSIPBIKyuJMKP+GDX2NGOf4ZUyD/vcUVe26ACMGvHo?=
 =?us-ascii?Q?rws+Qej/nlf25a89q/MiNJLxH6Hemslqxc2kL6Sm4aZzQzldgnihZCdJ1MVM?=
 =?us-ascii?Q?Kq+jMpXMzl1e+E/SD2o9I5virJIpEEqkU658xfeBVLdXr1btmeO+Sxhv/QWX?=
 =?us-ascii?Q?EXNOJfrUHuNjysGrqOsFo0+MOCSWk7X4nC0DCCCJUc3asJSI9+Ho8Dyk3ym8?=
 =?us-ascii?Q?v/2kiW24WUGRG5YmNZRDiUKbWLZ6ISg+UPRHGT2G7stII7NIJmBlAOVUXQ6N?=
 =?us-ascii?Q?JP1lFF4NnnNzJpS+BTtpWpy5KAvFHYJXBb6Cw7VpARvAkEL5cGRsaGGL5rFT?=
 =?us-ascii?Q?tDD/VJMrF0BsFX/7b3k3pBVagDFIrL4TeSFsxbpXhqlEhZiuWCMbb8JiJkOl?=
 =?us-ascii?Q?7yCgdkvQb8ob33BhsUHYMpo26dQq0jnnS6RepGyNOxujyQh2rLg7MEvM9Uoc?=
 =?us-ascii?Q?x6rWUk6BNYhHqi/kq83Srb79Xpgy/7aW35z2bRVhjIxMhZUQh1d42rrPNd4C?=
 =?us-ascii?Q?YpNa/4e3HmX18LqWCg3tjFEXm2svvMw9XzFj8c0ZVSqGLsbzIqTUj4yXc2t0?=
 =?us-ascii?Q?niNtj3xg9/7eH2fHtJH4s/Riops3RQ9zxMrLpvSUW3Q6BXOYOzZScg8cIyPr?=
 =?us-ascii?Q?vBhvkfCaEhIAPRfcVlFHkaMf3xE+N9RujXH3D6ozr1MnGmnC6bxrAtg5KK9A?=
 =?us-ascii?Q?krvkMCL3FOArd24koiBBYDaUkhyA8HWJzR/owIs/KT6cjEDDCgWwBajacK/t?=
 =?us-ascii?Q?RhvN6YLPGoxdxMP06VZqv3zhwAOnO8HULRmQZ9Fk6sYHRSV5z0AIrIxa7ekr?=
 =?us-ascii?Q?jpAR4S/NuSHuA6yqaHMsVuJwZUyZnsoM27s3K2pXlo1exW34CkPhpuTe+Dvv?=
 =?us-ascii?Q?EpQ0w6f9+w1Kr/O+CLDaeS5G/YCXYn9aIGfMPtbI1PJX80WJNzYZCxgHJ/gv?=
 =?us-ascii?Q?MGWKYy5zc7DHbNjIAy12vRXO0ymT4kjEZyK/zwBDXeDARB2KlpbTpRHfD1j8?=
 =?us-ascii?Q?uedwMUT91txcEp/iW/2yHxtR+3chcsVawPduepaZwUkgDSHqgk82bbGfNk5z?=
 =?us-ascii?Q?XcyxuDd3XTrxUO2rQCU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24efa32d-f35e-449d-4eda-08dd40a158f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 20:13:08.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKjjF26kQwhaAuUS7sFDKxFfKSkyMXYiBSidd5QqYdrViscfa2192z0K8VnbbWfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Wed, Jan 29, 2025 at 06:46:20PM +0100, Eric Auger wrote:
> >>> This missing peice is cleaning up the ITS mapping to allow for
> >>> multiple ITS pages. I've imagined that kvm would someone give iommufd
> >>> a FD that holds the specific ITS pages instead of the
> >>> IOMMU_OPTION_SW_MSI_START/SIZE flow.
> >> That's what I don't get: at the moment you only pass the gIOVA. With
> >> technique 2, how can you build the nested mapping, ie.
> >>
> >>          S1           S2
> >> gIOVA    ->    gDB    ->    hDB
> >>
> >> without passing the full gIOVA/gDB S1 mapping to the host?
> > The nested S2 mapping is already setup before the VM boots:
> >
> >  - The VMM puts the ITS page (hDB) into the S2 at a fixed address (gDB)
> Ah OK. Your gDB has nothing to do with the actual S1 guest gDB,
> right?

I'm not totally sure what you mean by gDB? The above diagram suggests
it is the ITS page address in the S2? Ie the guest physical address of
the ITS.

Within the VM, when it goes to call iommu_dma_prepare_msi(), it will
provide the gDB adress as the phys_addr_t msi_addr.

This happens because the GIC driver will have been informed of the ITS
page at the gDB address, and it will use
iommu_dma_prepare_msi(). Exactly the same as bare metal.

> It is computed in iommufd_sw_msi_get_map() from the sw_msi_start pool.
> Is that correct?

Yes, for a single ITS page it will reliably be put at sw_msi_start.
Since the VMM can provide sw_msi_start through the OPTION, the VMM can
place the ITS page where it wants and then program the ACPI to tell
the VM to call iommu_dma_prepare_msi(). (don't use this flow, it
doesn't work for multi ITS, for testing only)

> https://lore.kernel.org/all/20210411111228.14386-9-eric.auger@redhat.com/
> I was passing both the gIOVA and the "true" gDB Eric

If I understand this right, it still had the hypervisor dynamically
setting up the S2, here it is pre-set and static?

Jason

