Return-Path: <linux-kselftest+bounces-35071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91308ADB202
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FE81884002
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB2877C3;
	Mon, 16 Jun 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5fb+UiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C82BF00C;
	Mon, 16 Jun 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080793; cv=fail; b=iDuAdcbOq6fsufOI60MHjPP4WliNlDhLJk2FSVWhcDflpvAUZnZfhhNCG5i7zacQyWLSZUhbtrK6lh/6BvZw86AZTt7Y3hEpTvqpChhJswG37dxDfOywaQZEVYhjVHwUV2hMEXyUFklv09GiN6SM26hfgdNOt/oXiVp5zaE+buc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080793; c=relaxed/simple;
	bh=byH2cyp5EF9U0xa8OJSY18woro4RKkJBlFl7xQIrzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFrwVBZFkvYDeHEWNRGUZiVcFSAWKFcZAGuRyHS34/H34syE524bOySH5l1bN8u6BxeXy7T2lnyqIiN0/bpcio9SUTPKw2jJCEOyw0U9TnuUdC35p5HFuoQgjdJ7ZDHd6zwmtxqEqRaiMHvqoexeV03UPOVW3csZpjo3ZM9YOrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5fb+UiS; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaQszcsGbDhfp2QNkg+RVaIUe7rkEtD5jIRdnhO24sADOGBIQOKUAnUAqJs4KC28SEPm8/2O9AcBIK6fylTmrxGDK2FlvLAWkJsMtecHpcbKhq3mlcNSHXa59OWB8TIQeTytJfVNNpczgfhDQvAlKuk95c+4fDQu/qOM1NqhY5WLYjAblLgL7t03NN9z0Un1iuWMngqi/ikTWcF6TjEXDQ210lnlPQGHg2IWVrmkM+kMWuFvym1B/ytlNFNIf1t7BJmI+MqEvZ3bP08IWNT8o38oYADuap3pKRkYGONCKs3hn5Em3FGN5WY2irJObiQnXPSKk+f5Uc6opEkmkFPHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nhXvG/i05H+r66Ojz88EKRP27lZiqNP64L6sp+cacQ=;
 b=mgbGGSGUyfHqQBslUV61v+pY+ObwfsTr+BKa/H2TDvK+V6BIMWFpnSGKHQzIbSD2A4qvok0uvjuRV7TpprAaCPiC5K7/Gd8m606YNMzcLugAxZZVKsn1xsYX0bUe8A0kWAkLt4hwnEhEUla056DeXEDhyN7ZirihWaOF5sHdWoKd6WQyN5CiECoqRPq5jRip3GhVqAp8z02PLtNl7OllvzJ2Yv8rsrOVTj7GO7vFQMJhXRpPnvlcWabswLizciqyqGE2g/YEXpcZjCQJOjeE4nLLQg1alwpB18rcIqJRIJIwfs2yLlmuz2tUIvz/XdfU8Tt4ywK5ZouJ4OdSYt4y+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nhXvG/i05H+r66Ojz88EKRP27lZiqNP64L6sp+cacQ=;
 b=c5fb+UiSk+HETENpp0Z07xaXCK8Y5GiUH8GzLIEP/JEZOrc77eSKXL/DQts5/AGs5xHYjiAD37KhImbAw1bOii1rMAK0n2P2p3xNqgL+w/+7XmsgaP1lkmM1ebxzRqQnIYEb/LxIlsvbclsaS23Zj+zxBgp6xvDXmBB+F6lsI12piZ1gmFgSYDZ97D5GsBTEaABc+BD0SLzwOLped1IJmDvLmCnI9IN6TUrlXC/eZQwoMwy8MxkuLiTr6wpcRO0703NwN8/MEB8/yrk9KhodENyi9LIIg8VwaQBxesheFaLo7stz4XwM71duzqnfIq2zypQIS9I99MAqgQJuLq0vIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 13:33:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 13:33:07 +0000
Date: Mon, 16 Jun 2025 10:33:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <20250616133305.GB1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: CH0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:b0::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de2901e-21b0-4ff2-510c-08ddacda53f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ait+B/I6vYqaCqCq2NnHvFOzIaqIwgdp/1z6LuFoUWdfNZpY5u7LP/KPc9wh?=
 =?us-ascii?Q?HdBri/RRUoRsqgQBF8XkNkyD+4ukgxTZ5g5tKLl/LjlmKij7tuv2xMwPFoof?=
 =?us-ascii?Q?idasgjUEo/6mVDLwlpYvdyoNly4pmHGrINdvW9ZvSvEJPiPk1sLTJRSoCR0E?=
 =?us-ascii?Q?EM4Up3U9Q4rbt71UKfqDDCQAbYx9JITtpAK3VpD1Og3OJeCoB4VjQJqcyHkv?=
 =?us-ascii?Q?n4fGdZqbq2bGErka4eBUCRUl5R0Os8vrNKNNVrwuBcyG2AXp59suBmP5N9u/?=
 =?us-ascii?Q?ypqDipO58HNoikS3PVnkjRbPSBTDoyDDZo43+A5SILhFOCJbf8mNQRiOt9t2?=
 =?us-ascii?Q?GTbbYPE4Jzr0Nbk4NPSpGKzL9rXUK9qzc9xlSwIduAoyELcNeFN1qNvEOd6N?=
 =?us-ascii?Q?8paAwDgEV97suYxzo8ffAQ14K7cTCLffIa5gSe7vBereG/cYifWjoObZAl6X?=
 =?us-ascii?Q?FkWJDGjv7LOb1GfEy+8MP1DphEy7FwbCCGl3v/JodH1sig0Ur/6HKdRtGtlE?=
 =?us-ascii?Q?5QZl+6F+RGKc293+bKaOxDON0Hb5ozxorb9J8aeix0RzXLVRRyw36i5DollC?=
 =?us-ascii?Q?QmC+dNqb95ZHWZ2qvXCaKFrjKKfh9B1r05DUDzEuIrbJ5ylqk8ig2BPru9ei?=
 =?us-ascii?Q?HyRBX2Ttzxp0Xu8lr3u8Qb2z22hp8zpZsDkxTNmAwizLs2DXm20QY9sC7smN?=
 =?us-ascii?Q?BbUUvKPvBFzK5JyPhHMS2Q5fI16+j2ijwjCgJTL+f2DyaKd+LhQHUtwODLjQ?=
 =?us-ascii?Q?p1IwHQTKT0gt9sgBGxxsFeyDNsXXy9mcFK4NJ5Jy5KOVmUBD5wbRMULDP+L1?=
 =?us-ascii?Q?aNV4eYf2o4ZwzYSGTDKCtKu1MSYhHAClWdCeVJKKGYeZij9DJksVAj9SKfPT?=
 =?us-ascii?Q?bV35wns2H40auUtlPu3szULHPi5NxeEu7bQ0w5MSu/TL4gQ97kc7ZZ68odeA?=
 =?us-ascii?Q?C9NMvLASMOpBOa/wb9qvWjWHAF321+7xkOOb9FQz+sM+94FT4uFJ+zXuNk+D?=
 =?us-ascii?Q?6nF9N6mVuPa8cXmZ2m5fH59W4yIk/SEZb91mpwO3vupbSsI5CDh2A1VhDiHb?=
 =?us-ascii?Q?8BivJ9pWO3Grt8Vf2HUeasJsnDCDXIRCaOsAlFpPfWU94srBiGCtpwQ1kooY?=
 =?us-ascii?Q?LUbxyVp+XL0UazT0MCKAAX6UUUTo2Q/T3GxOtAqeyoGb9vaYYvK+Ti/Tnx5S?=
 =?us-ascii?Q?lfVpNhOmU2MbpugEwmC82T1VQUOzDD2njH9Y1arQXIjER7FIWWjuUJ4BTiV1?=
 =?us-ascii?Q?EOYnx13vxu/LtXlYhblI+OOfqcIEa4wAue6QcKcgdRjryBtHlyb6fYCt8AdS?=
 =?us-ascii?Q?SiuqeHilJvhpTzq62jrt7vGAkFdbEpzEvt6CbvVjLgghVrTG2/7iHWN2ASvh?=
 =?us-ascii?Q?7oybl69xC1X+oVXkG9n8VxNwA/fbWz6LPSRH/73IfzSI3p5kX05LNRIUPMZ5?=
 =?us-ascii?Q?f5p/NweIHPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/x7NUo9EEqPb7qqo6/R5xTuABjS0jd0ZUqEt8gjjz+gtBFOEPFwmQ1aguG/?=
 =?us-ascii?Q?lIP/cLbiYnHTCnQAKvgC/FWUqu2zIRz/Kl1FU77q53RMs/jztUVUCIKpEeEX?=
 =?us-ascii?Q?7LtEMESj9kD8dpL+ezi2eVIzy4WzS64RpLuM1oKDh//8ECTExKIRgrNAjJM9?=
 =?us-ascii?Q?nJ0oKLNr6WR0/8htUmSlhBaAtyo5fMqR+OVYYg84GL8iylAhkBm1eIzOKKj9?=
 =?us-ascii?Q?weQcLVDFDslbKGuksoL2tYI1R38/xhnp3jBvYQJGFJDV3CrUCetSEwprOhf3?=
 =?us-ascii?Q?bAVBSbFMsbYMaL8AFS02szTlEdVUOP5sGZ8MY60k9wPHgvMcpm2Pfn9EOCco?=
 =?us-ascii?Q?NR/QO+biAymGUSpkpmZccy9bdeuTGkzYTEJc4GhlR3crrDKAup5pf/s/L2qS?=
 =?us-ascii?Q?5TqKjuOmbxrAlp+aOvSeCU3uDlAGP8yyIhO8WTS+XCPEHLcZNNh5S6G0uh9e?=
 =?us-ascii?Q?Ns1m3xy4v1dAVRRYLZtp85K1sNDkYl11tDDVps2dvmfnIvTdAibSS+g2nfQi?=
 =?us-ascii?Q?g9ig7hZ95YaFfFznJipXm+2VogURWGY0BFapxI1F0rpuiduU+uinjOZwjcCW?=
 =?us-ascii?Q?jFmFnZ0+iMs2Kskikwi+aXWvapUEVdI32KAgKsFVg538HV3W50AynOITOFVH?=
 =?us-ascii?Q?aV2VnAwb/KMPDIaUeeAP4VSKqr4xCIkgL1S/h8pBC1q4kx8SClls5zk4D0f8?=
 =?us-ascii?Q?JrPG9Mt82ND9UGoaa+xVjWwfgiMyLM7ElTXKtb7WRJ5LIg7Zb8DKkOlz4XYJ?=
 =?us-ascii?Q?w26ibsJWXBvbu9Yt6JgYB5AfWzZ9IRAP3wlEq7z9/fNaZR+GPPZ/XsAPvII4?=
 =?us-ascii?Q?d6qDmVs8Hk5jw6bNmeG9+63sbMigrH2+H19fiFnks5s+4GppZHGMAYuYOtFA?=
 =?us-ascii?Q?S5UErUqJ0AFFrPFtwcyP+FcgxvePSg5mBsSHzFxYhrMHJEY6c9YozCRXxxFd?=
 =?us-ascii?Q?E9WrfaEzp6RsXaElfr0WCz0UdBW9EUkeiZ54LyfTE84t9RrjQvbh6QjLGVzw?=
 =?us-ascii?Q?mdZH8juyyrYGx+bCEAbmtD9GmQLrKdZVlKTu53ddkYhEGyXLakelmG18qlc+?=
 =?us-ascii?Q?aCKXh/GfweaUVraWa5eIYIFHBvUX9bpxaFDRitwwEQp+Rk9nxKxmMX9VwPAQ?=
 =?us-ascii?Q?MkfFiI2SnO0uJon2CF9CtdsU3Rw0xz+oPCQC+sz1sm1Av8661QdonvQZgt1k?=
 =?us-ascii?Q?078qR1tcGt5aCBgN7yiDxc/R/nLH5BOMI4a9ijrjJsEK21xH5ohnrXJG+YN/?=
 =?us-ascii?Q?qCg3PEOyiF25YxHg0MLl7o0C1ssGjAIXktWYcZCOjNXxhfduDZudNiEsTXzO?=
 =?us-ascii?Q?d2P2JM5lV7qDXkiUsYWx05mzVgNMdCQx2giIcy/cVruPlFX1Q589bgn4VE6g?=
 =?us-ascii?Q?swsAs6mS+vAcwU5C4VKAoJs2+on58qj2FvsDii4bZT8skFvzk4aj7pomtvwS?=
 =?us-ascii?Q?T9F5W8U078x2dAd6D41MJ9ldfrzZysFqFwWX5mxTS5e0h0aT1bWOKN5ce6qT?=
 =?us-ascii?Q?j4V2NflDXwyNV3Pvg0vuXjAoYLKUzaf4sHVDZbKcpPrjRCQ0RtyEA8fdOCOA?=
 =?us-ascii?Q?IoHaNvHcvpvM7j+EbPMXf1QQN76P9usCCgq1Tco4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de2901e-21b0-4ff2-510c-08ddacda53f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:33:07.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG4nggYZN7EGG0CytPZRmm2oZbhy538Q4GsrYA2yZ87ASemOOQJ08ojOJR4DBlxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

On Sat, Jun 14, 2025 at 12:14:31AM -0700, Nicolin Chen wrote:
> @@ -1321,7 +1328,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
>  
>  	/* Driver's ops don't support pin_pages */
>  	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> -	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
> +	    WARN_ON(access->iova_alignment != PAGE_SIZE))
>  		return -EINVAL;

I don't want to loose this check, continuing blocking mdevs is still
important. Only the internal access should be able to use this
mechanism.

Otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

