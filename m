Return-Path: <linux-kselftest+bounces-20998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C429B522D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C491F24558
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9820513C;
	Tue, 29 Oct 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4COp2Ys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C711DB37A;
	Tue, 29 Oct 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228046; cv=fail; b=DgZDI+8Tl8g6DcI7AHpZOVtyNzpclfUKYbceiGWIdLjCA2vrxFAIgBzeWx1SbZf6gkhL4kF1F1D/gp8Ue1nxA74BrXIpYVU2bcFZux6ZnLBgGsz+6t7YnwLvlQSJqQTWI+6LaLqo/XqSOJ4vH7lOf0XPCOnNNqJ3InNijmZx1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228046; c=relaxed/simple;
	bh=izw6IR3AaMoyTaWKuAZlXwQMrUzdP00vH1b7PCwmkUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E3FWOhk79LUSCNd4mKX6ETxXe9E+for4bYQ88Rgl+DDNaFsyxHHfvQCIVu90apuW48GFgyOBbEFVWUcsbVjyJ7JH1ap0o7vlvLDpyzC08cDnZ4Q7IfFBvkBf66IxC4+8XLWR1A19ljq6AQwJYsOnN3wlTcCUuK16Yy8MIWCEw2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4COp2Ys; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBRVU5BYlWigB3rQoxVJgrrriptOoVgcPReS6JPmHidd0QuOFBV2InkKTHNComTtQLPxuDgkxp7Jlp9kv0vuGceMq14+DPKEEtDAi2Ke6biaTgM1F5uyJz/5paIsOjg88mnN52fzeu4Kr0v9O3aF97NIKWuO63IJsNj8YDrLPEO+PPHEeNQHS2cVZLhfntj57+pfv/V+Jnlhmq6qU6tcnXyBOrEoOpetjeJHBqIDKKjKotWWtFVDyRbfqVAN/D7jaXLEF1TSozlt3x0wElWpPvtLdjTg0ovOrqyI3sgfgSh/ZjUw7ccimdOLNGY8oFyRU3DQPZtP4HVJiRx5evoYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGErvVXbv+tt7Ozg6GWttoXgN2d0PrA9kMAYIPdAZNg=;
 b=Fi0urJ7lecLDfMnICaV1F4WQBSFjjca9BdMMiSYsIpFTU2AyzqkRdj1MSWvWHtlbrDdNo38tR3m6Wbt5/02NCG1PI7EHxMNwF2rQdsfJgRSQ1Uu5EEk5a/zPV6sMKOvZkSMjC7xzTIwnav7OTHR6RJp15QHSe7OjTillt5kTaxSsf726ESpV7BrF22cSkuI3kvIrA1NYWDYuo6spvydRgLXTUJeODgCDeUDWFEal0M8aqzFxAIgud/Ex/NUZ26lI9rXi65NEahD6DDI329yvQ54uQ0Uhx/SyKoWyvkEmeXeCWPdWkITH9u3yOxC2tTHv0lm/8+Lp40COOl3PHy23MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGErvVXbv+tt7Ozg6GWttoXgN2d0PrA9kMAYIPdAZNg=;
 b=C4COp2Ysipc2HN8RXTmZeYwl47cSGzX3/GVlre+uTElJu+5CXkzKS9Jea2EQ+tr3XSnzFasYdBwzGyc4/z3HDyJxUPqd7ZeDURA7rCqjVoxudn19p20caS58XOHU67SdIOXInfONLA0jsSuCusqdaKFpuIpoXpNjeZ8CF3uJc9M7d/iWIlqBuWQ9cs5vHN7vrDV749eKTxMcEn/7WALdTPNEwl4GqOLeLrqwYAyLfBXbPWJH8gYnE14BvBKHpv3FrwBhpC4RLN9IokMIqobZbIWFtzQekguVyd45QteSk4UvWUXkrFi2K/zgqeoZW1m7N+BKC3VyoG1GfxMaejzfhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 18:54:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 18:54:01 +0000
Date: Tue, 29 Oct 2024 15:53:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20241029185357.GY6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
 <20241028130309.GP6956@nvidia.com>
 <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
 <20241029152746.GE209124@nvidia.com>
 <ZyEISs6uLbH+nCsi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEISs6uLbH+nCsi@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:52c::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 12159bbf-7ca7-414e-90c5-08dcf84b0ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymJ+oW8QJRl6kqPr+qNQGgX221AhecI39S+Rgg6fPSoKM5gQO8xd9A1A1auQ?=
 =?us-ascii?Q?/yeOvcaGKdrbtqSmrgF1EhOdqpeQ/U7+DQXTd7dDedUtZD5VRFh/tgMTdpcu?=
 =?us-ascii?Q?nx0SizPTyGt84u72w29rYXi0OoklhqyPr+BNS0npZ0nfH8kuVCdzJe0CZMkI?=
 =?us-ascii?Q?N+CB9b+OqqaPT3UMzuy/U2jpgGzGVF8uiA9ItqLIHlZ2j5OFHdINNE7oFWME?=
 =?us-ascii?Q?rPQxkCJfaBk1g8j4uPbsYlbwLnaVXXSF1aUESQTvNocL5xML+5eYq3sJnGEr?=
 =?us-ascii?Q?pENIcDSFgD0XwOnVuLNters5qiiAnpUfPxtRygqiiJ5NK235SPTBZnPGlNEJ?=
 =?us-ascii?Q?jnR/KDlLrgD03u++9Nzyna12EtcibckvNG+Nr/AQzyDuS/Tq3KW1htxqAy4e?=
 =?us-ascii?Q?hCLb+NjG6tDMJUrQ8PFQKlb+nF4mq6ax3YwENXavRsBoSIJTOYupvTC76qu3?=
 =?us-ascii?Q?99BuX+J/x/+AQuaV1DCCoALFy6hm4dRbG9a6PBlBGIF6nH9Mck+Eopk7FXY1?=
 =?us-ascii?Q?7whG8dnr1ygTqUK7xZnNw8la1YneLZtgttMEzV1hDTP/pMx3O/xkhQwwEsbW?=
 =?us-ascii?Q?0W58DSBIzXFnAvIGKekibmgJ+lDp+C3y2wuNifZnZqqzozBW4Afoe11mlL66?=
 =?us-ascii?Q?BKOMEM+IvWALUohK9D220oEWTtZredzwCkZ8C2pC9VRcL9XaorkR1j35JhD6?=
 =?us-ascii?Q?z9UX3igWAff68ugN5rIBAJAkp0RWc1hAxNc6JRZ51Niowz1sBkP/0vV6Y3tH?=
 =?us-ascii?Q?0fkYeQMUo7dWgoWihLMSF+OBgPHPVYFy+ah7DNAavJavKBaF41Agq5l2C5Se?=
 =?us-ascii?Q?JQFG4iInSOyriIoS9/ZE1P4miaXnXv8UviAYFKkQ7cAzLMaydUVG8UZjDBym?=
 =?us-ascii?Q?UDLXePyvFaxMX6g6KoNm7RJScn2ZL+yVv2ghOF2j3PqePE2XGrjYA1W/x+Qt?=
 =?us-ascii?Q?s2d5ma0GmQKRuNlhjX3+FLWN7Y6uQelxifyMBx3zIxPJD3hXxJU9gBS/tof+?=
 =?us-ascii?Q?OxzGgCFw0YrJPW5P8W+BRyVV6YKbMom8I8p6SDAvt92lD4wBaFVAGUFU7a1A?=
 =?us-ascii?Q?sATd1ODuhWb9w0NalLJzD+yeyouluUoFnvt9So0IqQvvJ1MNk8g0kuoWML9q?=
 =?us-ascii?Q?cmS0CR6oLKs11JFUP/mA7N071M6soDqtb2kRfB6ypDQ15dpg0Jkj/ItczEZh?=
 =?us-ascii?Q?ps8qTkqJ/ETJAKi/pQnJo0DNEVICRzQI2CLNzCo6hWvt7BArtgGdm1HmuxI0?=
 =?us-ascii?Q?NKevAocG3YwGPsvvs1Org5Gz6jxuOBuJFAWm0z6o4xClm2sMKNo94SAKwwQj?=
 =?us-ascii?Q?ukh7dS5uxXj/xOKjy1rNB+TC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJDEaFgIWNuPRlDqlvk+A5d5ZlJe4kC16kVXIT/Xkk5y8vDrVmnK74HQDdWQ?=
 =?us-ascii?Q?JN+GzINIlMdq07MUR4hv+yNriYMTKbVvdTm+4+/vqxwYdH6haYZlVquy7aKM?=
 =?us-ascii?Q?dhvC0gN7wRx0ysMmFH57C2Bxprl7oHaKczB+mtc6PWN5Dka/AQ57N/y18qGJ?=
 =?us-ascii?Q?tddk2j7elJW8Z6HcRzgA2Qs3vkgkPG2ciBR+INoAL5mxC+ceqY2Wpmr34LOR?=
 =?us-ascii?Q?93OOjLncUejsYJ44phCZWGBpvELra0vlJF3E+wmkfgn5vS+qgYHvFnPjOP5f?=
 =?us-ascii?Q?Qt8wJL2ySvexK7Xgu4hKU9Qehj/YAJxT+HHMH5a/IDffHIC1eYgtqkm62OWy?=
 =?us-ascii?Q?zH4Qu/k7y0F/khyaeEJ/LtWHnlT6V9koRdKf5sOIgo15ZGSq0dp30rRH4Sa+?=
 =?us-ascii?Q?W4bhM4PzWeqS+mUbxQCeuRKY9oyIiPD0t3tfGaCVXj4fCNkumumB7J7vqInS?=
 =?us-ascii?Q?ORU4cEznxSAt9N7UAFdPxs4Y+LddLYy7jzka7RnZUJWmbabqXMp/zVyBT/Cu?=
 =?us-ascii?Q?efNJo+fgEE+UjpD7X1GKnIVq9SC9z4VNe4Nd/64o9044dGVsmSVh0AXltPKh?=
 =?us-ascii?Q?ZkwupC6PIMQbW5k0invgKE5wAvzBPrOzvbOQHRXkNy7/K7qaLj/ivnmEJXV9?=
 =?us-ascii?Q?2GvCLoPdsNm6zjPhVlcqwfKwiJxUzO1mjodbeU1elW9trJ48jztBS55q1gD0?=
 =?us-ascii?Q?K7lXjHNQHG/ReXXlsVYoJiOWLeMnXPIefZejoD2RF+Rq0yXczkOnmvf1ZpnS?=
 =?us-ascii?Q?yp0umtQY9kvZy2Zcy04cjWn81VU33jr1G4xjvSJ9p57mz13V6ODIFteeV6vc?=
 =?us-ascii?Q?R898LIZLDoXfGjs6gMitDfsGCttHGB/xLrrqBvNsqu42DXk7MC2+AwdkErXe?=
 =?us-ascii?Q?OGJicHaUBjOCoQ6aMLgY8dp3/NJucgW/0M8xV4sOOsgjWmXunu5Azu+lCZ+a?=
 =?us-ascii?Q?vHuSDqEodOwLtYmcvlN2fV2wcRffZg//iZs9ELnhb8ytU7F0hPJP5JdA/Al1?=
 =?us-ascii?Q?DFWGfGKAOOTOkKyshEE0EwICa0MaoSJmId0egAzit9HM4d86gxsqfSxDkaag?=
 =?us-ascii?Q?CaKHopjntpJX4ID++XctcUuokiiPajeJvZ0Vg9++rlMED8LJqw2Mf+jsOrgX?=
 =?us-ascii?Q?X5S3zOtChjbKZxHbOKBLbsL2gCdgpfWWSJttgMV1pOzdsGfjDzBBOThmImCW?=
 =?us-ascii?Q?e9fWPb4jsfhU4HVLNFESpDWDkx8+h0Rrt9T3WAmKYpI8Jkp30sjJgqIvjC1K?=
 =?us-ascii?Q?DsGfbiy6RE6HMWCQYYvCOtPbIMJH99RTXwBw93v8f197AdeDCMsjVoP/1oVH?=
 =?us-ascii?Q?Sl3WtilSxW3kupT8gX+WcFdXpLLLJYZ7qO55MwUxDCPFMYIcDaaVD78AYCSx?=
 =?us-ascii?Q?M2k+tZgRPmejyzk1YIUppN6aW+erVrI7P1Wz9RhaOVDQ/VBLRqpyAZbyECZP?=
 =?us-ascii?Q?q3kmo5WxMzw6Tsq1iNfU7AVqHADZalWBf0Ym9Qq5xhgvvqaTM5GGedk0kDlH?=
 =?us-ascii?Q?SOdoH32pTrDvmMde6n8q36j1hHJLWjV39ryKJcRI5aWVg1LQq/6nlwF3gwuY?=
 =?us-ascii?Q?mcXWMhVLVzKoB3IuJWE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12159bbf-7ca7-414e-90c5-08dcf84b0ba0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:53:58.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcNV6Lt0XwBi8DGAazF7ueGNTqpDus+zTXNqt5axrb51iM37K7M8R2fPaz5np4oL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311

On Tue, Oct 29, 2024 at 09:07:38AM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 12:27:46PM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 28, 2024 at 07:52:10AM -0700, Nicolin Chen wrote:
> > > On Mon, Oct 28, 2024 at 10:03:09AM -0300, Jason Gunthorpe wrote:
> > > In iommufd_hwpt_paging_alloc(), we reject IOMMU_HWPT_FAULT_ID_VALID:
> > > 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
> > > 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> > > 	...
> > > 	if (flags & ~valid_flags)
> > > 		return ERR_PTR(-EOPNOTSUPP);
> > > 
> > > In iommufd_hwpt_nested_alloc(), we mask the flag away:
> > > 	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
> > > 	    !user_data->len || !ops->domain_alloc_user)
> > > 		return ERR_PTR(-EOPNOTSUPP);
> > > 	...
> > > 	hwpt->domain = ops->domain_alloc_user(idev->dev,
> > > 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
> > > 					      parent->common.domain, user_data);
> > > 
> > > Then, in the common function it has a section of
> > > 	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > > 	...
> > > 
> > > It seems that this IOMMU_HWPT_FAULT_ID_VALID is for nested domains?
> > 
> > OK, but ARM should be blocking it since it doesn't work there.
> > 
> > I think we made some error here, it should have been passed in flags
> > to the drivers and only intel should have accepted it.
> 
> Trying to limit changes here since two parts are already quite
> large, I think a separate series fixing that would be nicer? 

Yes, let's just make a note

> > This suggests we should send flags down the viommu alloc domain path too.
> 
> Ack. Will pass it in.

But this would be nice to get to

Jason

