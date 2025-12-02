Return-Path: <linux-kselftest+bounces-46901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA4C9C980
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CD5D4E34EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7A2BE04C;
	Tue,  2 Dec 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YrmnIh3/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007792C0F92;
	Tue,  2 Dec 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699575; cv=fail; b=PWgUuVXMPFfL7EjoqLqMz2HdQnjvi/5tE+DDKBC+6GQuQtBiOJDgqWZekiouT+zXzPTQV8/7FSIwREQ5Zwnbomw4zaOMfODvHX14UFrbgERLJvEIoYG2IhCWcmgQhgxs0I5xIz6Isvyo2JExtiR0a5pHCjRZmVAQIfb9YgNQM2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699575; c=relaxed/simple;
	bh=F3u3uYqCIfecYppkDssZ/1XBCQZ5qg3ezpAKMzeiGdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7Zk6caX06+dKuNOCtLO+5tiMAUt3TdWlMTx/AYELFdNa/uIjSDPmU3u51znVohxVRpOz6s1MirfNC2Nlp6FXQuCAFB5t+PzyvBaCTLNgvDuN0GI8nHdb+dgwX3sNCR6B/ec4gkqJCDwk4AWRBs3H6cSLQDZ41N9GW+PcP5rpJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrmnIh3/; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWY8fWPhW3pxOjOXD+xXQoYCkGyVED0htmo2WjRuBICRVHX7leq8pYVoxXgJBBTTcuab3aKzYPtlMhprCmWmCtR/bogmOCxRhWuz8X5gDa2HOngXV2LWdp+Cz5Bj48ANc5V3bBhikl1Xt7x+K5yzvR9ZPaNtBlBvFEQn+N/h9luG5sjMWO9nGr5G+C4OoauZb6R9UQx/N+SfVE0j33b6KIYr0XikT78XgQSnWrxWE2FhUn7nE4AKMhskTj8kxXPyMlkMzH2ztiWygnlK96nfYOQkeKQhRY/mXNbg/TSkMTtPEKnGxsI5wVQH75ch6buRkTUh4AmqAMWymm3jTLCPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3u3uYqCIfecYppkDssZ/1XBCQZ5qg3ezpAKMzeiGdY=;
 b=BDf6K4HqXpzFfNj14bzrd8nBFYNwZT/FIg7lvtrxfvjBv/giLn3X4SfFhhR6f3AMlpw45fii8NEJCYJK+8MZp/MPxWf18SbCgXhtOhvJ3u9CliCUiy8ukPU30B5K4ZOP2wAYCeDxh4299K4c8DFmnxseb/m7TBDKcRi6ypC127udNz31+kZBlLOLRA0IXb4Nn1KPHxQajtFw5PblgdH5/+bH4BqtcQ2p0S3kr5lf43aoffulj9rLSjxZhvdEsigzEWi9esh1WkuuTJuAozgg+ycNBZRMt/AbbmMy9DmBRT3Q99XSm/hT4MRpkJlcphpuewEDEIykAuiZ8l/emMk/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3u3uYqCIfecYppkDssZ/1XBCQZ5qg3ezpAKMzeiGdY=;
 b=YrmnIh3/pX0T3m+2eyxlGgHtmu2SB+gsPQ805Ge7QGREo/bS4KhFiPL0Hfwtgh90dq5yTEYLkMbtcHh893qH6J+a7UbpSaHDxEiZ1ih/70lyZq5SkBGTWVD7ubp1Pf6+j6XEVUHXibryDQZLN5nSXgpQTNint6rd3PtGWJQ2Cr5CcIcYt8TblSMpm6NRsMVGnwMKsssY11KMILnMbdaU1wu0euS77mUg95np0k8a2ppwWEavX1Ex1D7uckOHlBOwsVEz6Wc6JWUU33jqePnVLzE/eKCLp6cm+0mjpPGbuV7zk/oeD1Vmm1j0E7RCZUHUz80BBev1HslKe942QXbNdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 18:19:24 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:19:24 +0000
Date: Tue, 2 Dec 2025 14:19:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chris Li <chrisl@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <20251202181923.GB1109247@nvidia.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
 <aS3kUwlVV_WGT66w@google.com>
 <aS6FJz0725VRLF00@wunner.de>
 <20251202145925.GC1075897@nvidia.com>
 <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f335b61-3a55-4744-0ef1-08de31cf5287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWwmFQsKP3KrnSbnsEMDhvp7QXfcDpDRFQ6k8TrOT7mdRh32evZA6ll5DOlS?=
 =?us-ascii?Q?kjt4+u5apcmBBUFG8xiPDJhGmHwl/vqdlgNy4ZrZuzOvaDvgK9nPy3510cuN?=
 =?us-ascii?Q?h7Oql/zIH0vR4aLlatB5DENLnOhsW2DmTh4nRXWbfnK9jtv3gpm5PqMAUs4Z?=
 =?us-ascii?Q?LgLpgO//NmCG72PoKITdocgU0cPB/uvgv7LxI+ZiEL6mJwNfPWGhE9/+D68f?=
 =?us-ascii?Q?ErMyL47CWOD3y9/y24l/t01dCT3FrhQBQ3wd2Ndt6Dn2A5tLGZpxhFWjO1qw?=
 =?us-ascii?Q?6lcIg6dh19HHKAOz+VmFLWmoJbK8dShE7EQFBkHLqal915wnOV59orJaxjD0?=
 =?us-ascii?Q?+1yyPwVlP8pgU+g3W4tO1/EZT8NHg+uuk9Tmc/EvVRz8pS6DmCmTvipBA6g8?=
 =?us-ascii?Q?TLT5j2l5ylcFbS1aEMCGjDG7VIq+zsDumC5NzxW7LAHHCd9MfAZESi9E8DLn?=
 =?us-ascii?Q?HJtBHq2iuhZlTbBNQQfHHykCJznxDyEZwdLw9ijw394gPnTXjHTUHeOFyocI?=
 =?us-ascii?Q?YqyFQGoHPkkuyr2ErNBao5fie9jnzTNPedhNl8hzXWWWn71jydd/Nvb79+w9?=
 =?us-ascii?Q?aoLzY3bSSaZonAErDaiwotvAlOy4NCCtJWptvaGVt81Vol8qaIFm1ikxVi3B?=
 =?us-ascii?Q?AxUGazaAzFjJfwTdZ9hvy2SRVhG8TTUyfyzLVkrWX8bNu4giva2OHbUFlcpl?=
 =?us-ascii?Q?ADGie+A0rTIzjboFCAGgE0Z7MlS2C+f6riv7J/cRbeP4DkqGZNOyjKWuE76H?=
 =?us-ascii?Q?eW/Q1mO9tYGWy70S2JcZmX+Ucv3YGPS97UlodkkGN2VZo2PRwqJoOOJ/TTrS?=
 =?us-ascii?Q?w+DgRiUASE62KL6JxG2gSUkbjEgKBX6C2NUA41hcU3mPVIWa0ZHCRKd2C/5Y?=
 =?us-ascii?Q?GS8PMfSe4tblwc0M4Yo5N8ULoyV78Zg/5KN7DQ5IQVEqNofm2rJZh8BSDaRG?=
 =?us-ascii?Q?RxQ2OEtFdwcVq2fhpf18iEPUFTU9dxar3qGV39CXFaByKwz5+PzkqoBopu1C?=
 =?us-ascii?Q?KKQwWii8Lc3Ygq2yCMiAo2jpyDTXMVvyS0As6e9tKJ4HXKrKg++Tad20kcrV?=
 =?us-ascii?Q?I05PncO80zqrJM+o8l02mOloB0vXXMFL9o04uwMGgIT7Gl1Tjx1xmffozG8E?=
 =?us-ascii?Q?ILZEsCAZ+l495Dr3e43ZJfyI8PrzyyRkM6F9AWJ+d7ksKqb852NiN7ECo3jP?=
 =?us-ascii?Q?Jt2D7QkiWUD3uncG5pBQbG9Xqo6FbeBvW/jxXffTpH1D4WNJ88UNfDWovQWs?=
 =?us-ascii?Q?VmfcY6cRFui5MNWydQeZlMRxtZXr+eWEs3j3Q5hDYBI6TrIuH0tGBelksibE?=
 =?us-ascii?Q?wHoPxj6JC1bVFRM61sb79Tor3EjinRgch0U4WrWjXSIeFOT6FkIEQAJYFiiL?=
 =?us-ascii?Q?CaSRqwbG2ZGQ/bDeM+JpjzRdhd9kVNNDkpR+MHBTrBY6hpczd1ipOL4L8+92?=
 =?us-ascii?Q?e09Ql1Jd5b8r1HlrbBdP5+JZjYKOJH4M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2SUFQn3dMOr5Yy679SCH9KNrSJWQWP6x1sUVgdVUxdY+qz9NE3lbDQsJR2k?=
 =?us-ascii?Q?C1B0WEkA46z4m1+kPlspSjnDwMT09bZF+/HnLeD4HZEt0AncXNKfRAunZMxM?=
 =?us-ascii?Q?AGtz/Sak6Du+lTbR/7ap6ZRVD+IGlzYfMBLEjU//Co9FpJWoajud5jOqo0Lr?=
 =?us-ascii?Q?pkbMO737nOeNbifXhso2U1AEaYHYuxfitR7JQQTQSaY8Araiu+txwmZBM/Rq?=
 =?us-ascii?Q?+4FomprwGdSX+QKMHp33CGZp8746+MF6KnEOycS7dDaFMlspXh9A1JpBpLPQ?=
 =?us-ascii?Q?lOCmpM4gtRFYm0WvIzcvAyaHp05ST9VFPnKb6AOPdcIvH7EPOIuBhzomUmTs?=
 =?us-ascii?Q?ldHHCPE9k3d5Y+hwbHsMmppcvKEpHXJIZJj7sdCwLnABvwGP2yHfNcOApU51?=
 =?us-ascii?Q?KPbFljgKdPupNqCxjRQV4UzbM6gHZaW3lsnpvXPpBNCn9z7DkPuUCgbVKZIe?=
 =?us-ascii?Q?2apYgzRP0Uss43Tw1WaQOi6fkCPdYXBe53iGlaTjaVxFFfsR3lQnnuaBXEjp?=
 =?us-ascii?Q?5BQmKDJAlArzx2BzW0SCBMBQcMrOOTQex09NAFbToA8gCzcw3qOZ6zRIl+PA?=
 =?us-ascii?Q?v9N/Ivp010Ac6cqixM9qyaqS+S7UdMgsBHs9vtpHT5Wite8h7IQBQMrycpj5?=
 =?us-ascii?Q?AlnjAehy5SjjvdqIg6g7iKBPBQ/z4lyKnlfCujx0m0yc2QF+PfCP09G0omIQ?=
 =?us-ascii?Q?woYu96v0k0wo9zYOj50tMpHk5rbYGs+rdKqQcfgoaajR8QG43/PSVVd3c10L?=
 =?us-ascii?Q?6MiCAcUpuhkYqlUIXiQoZ5/oDKL/QmnpqXsv0tztxyRhLd/2rBWq4TMDdCmg?=
 =?us-ascii?Q?69Jgwt99OEPk8m8jSm3nAU9kVabk6sirdOtpQ97FbDfKdry9zOa2+gaztS7Z?=
 =?us-ascii?Q?oySx+RLDgpM6dSTu0ojSa3hpDDz3vFMRPMU6Ic2IA9ueeL78YqNDW8+msEqa?=
 =?us-ascii?Q?QmB8kNrlYch0VcqNUhW+l+LxrInmmwod+y9tE+GxSX35lRITdQK2qEqWbEH2?=
 =?us-ascii?Q?lWSIdnQEc5o8xVO5eBgOR0bVynYTmbVp+tgwhajL1PMexDmBermeqXy34EzY?=
 =?us-ascii?Q?uSl7bbESzOkQ696+5U+ni1Ddeg4vgPqINibJ8l5j51lqz2UYjxe/eRS4l99K?=
 =?us-ascii?Q?/iHmclmOOJ2yuPA7FBLBWOZ1wMvJBNBJ/+oTCt3hwMdMrUsBAX3oXdWYEH5/?=
 =?us-ascii?Q?djxwraOO9QUfKyDexSwIeQeZ/BZd4YJg47ow0nQ/rSYcOmNAJrfaF8tAJYTG?=
 =?us-ascii?Q?BRDgpk+L1Tob7+WZRcdyZaA3L2t6SicJf6b0ZQNIZ7vKpbf3En89nZZYM6ml?=
 =?us-ascii?Q?8cBP3wRV7GHXEJ4au/Fh+YBBQgCTNnLf5MGupAnr60WpT2fT6iRVtEcWQxH8?=
 =?us-ascii?Q?nU8b9Z9MoKRzoyhXyqUP+L3V9vRK+hSj3JIpXu1Ges777HPlwG8PQtZK36z+?=
 =?us-ascii?Q?uXGvwcBptMKtrgjW3HePdaVv5hEA3BM7d89gNJWEiuHSP/X6R3wU/ICkCKzL?=
 =?us-ascii?Q?XgQDyGujsHW5oQy/G9IF+RyuGDta5VlSMZUkbUvPASOSs7u/OUzJZY1eEbNi?=
 =?us-ascii?Q?0DYR0CdPc5xxVdh2N/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f335b61-3a55-4744-0ef1-08de31cf5287
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:19:24.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp+S9EBhZWdihscNoAjkIlNncAx4Asl19xDSLq7a2tuGx4+Tz2WlMumq/yFLfdpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

On Tue, Dec 02, 2025 at 08:36:53PM +0400, Chris Li wrote:

> Jason, please correct me if I am wrong. My understanding is that not
> only the device that is actively doing the DMA requires the bus number
> to stay the same, I think all the parent bridge, all the way to the
> root PCI host bridge, bus number must remain the same. After all, the
> DMA will need to route through the parent bridges.

The completions need to route back through the parent bridges, so yes
you cannot do anything to disturb RID based routing in the active
fabric either, with also means few changes to the subordinate bus
range of any bridge are possible.

Jason

