Return-Path: <linux-kselftest+bounces-45913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC601C6B770
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 20:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2D6682A101
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57002D8DCF;
	Tue, 18 Nov 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BaOm1z6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5B2405E3;
	Tue, 18 Nov 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494703; cv=fail; b=TbccJOtxlxj+cVTbplKkLdcr6GmS4B24lHjSD53wAnN4oCGYVTqNbn6krYiMAkPoRFi7bwEi197BcEV9nl2uHZsZcDD3eQYrDrabGI0Bl9FNOQ5Xw8pbCmBaLenYTHgq4KVJhVE8WF+iPPMD+tganrdA71wBXUUjepzbFJbSB78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494703; c=relaxed/simple;
	bh=Cuuv3eiZPjX4vjw2OBDWaZAIwO/bZQm5049lXI2SbtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=otMPMT++HNAjc2MY/uyWmZggRvIA9pvlHD6oVNMXRSviw5CqCj8CvysW6dA3if4MGfrtUDKupGrE4cxV3HfpO+MDPFSj30TlCuoJ1avRmOrVK5/Gfvie3CEpuquAqDn/kgUNN+rHmz/gyc4rA1D3gnQqmmt931DCWCsP29ZbG7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BaOm1z6f; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9+jX94Njpjm71YEe55t+Su12ewW+QRK5dAMSjCgWBo/YyuycQ/tu45NZs9L7lgbTKM8yY97VWEQfwN30A8iAvCvbG8G8J2qVMnPnr9uYEbXkvTOeag8GDq8T3M+qw8mySs9dk2ciM+zsRqolNBt+bFyDHtLUhiS4L7DdAotQnkpTXZEJciBdqenydT0oYaOWWdYXKQYrih0voBSp87wqccG9uX+Yh9U/E+7R67OlbRof/eqalvax5+5ryOMIUrUpTsmJK5KkmWk6orJHApEZN8LeG+0McPdB48/X5CaVwHVwbAhFyN6k/UFcYJPQK5PhvXdf+jgbtkIPp+bD3BHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfDU+hOlWQsw+xOuOWZ396m7X/cGmXym6waEtVpnUOk=;
 b=t5MWrXG1297YImQq870MFzJ32WMl0I6vc4bdFE9S4JUhuX0lRUzN5aYZiOIpy1QRL7UtUFxPIL1ZgWFLSrf0MixkbkVCLJ9pBAI0GEj+oRXHx/Dt42z4bzKSOqUWoy9ZhjG9Vjd6MI7W6yfsamGmHU96pVAjSh6c1nr3mUK4ULlLcY5JtYtm/3qdPsjndu2QZuKLnywpm3C0+BDNQCYooPnWqtsEqYdpF6MtW+D1T64XNXca5k8iR49/CtE9fBuD5YvkkJoAAWa3pgjcVIHfe/H5msoMm86GoMyaMsFQ7VCFRUzb5/9VPmIPrx5/XCJYmdYwfA7+3JY/2MAbHRvEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfDU+hOlWQsw+xOuOWZ396m7X/cGmXym6waEtVpnUOk=;
 b=BaOm1z6fHGg2PnwkJI0v13iCNltFXTgF7H62fGoVYctDU4NL+7misOUZaU3KhZWdMl1ubrOS+vT1smzG9x1T3v+oVtWTsgXf4OEiCCy+NPPSfSNvJtfa8QZbbJmWTPx3k9ePCgOIkvMXoSpLrBcQK55kUTOZI+zBjgWovoohxERnq+cnxrayv1+2YAvGdDd1BPjdd458PPb+m4EOLsKwK8fN6AZRZcTibcu1e5t6fFd5tUwUJJCsTbaNXGbw7L85f74gZTh0KFBXfKHHerYWUUbIpaHnnMX9LaX14/58vu9kOjg/6f1gygNlK0yVb+g5EuPtUoIz4Jsc8I8Wb0GXFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 18 Nov
 2025 19:38:19 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:38:19 +0000
Date: Tue, 18 Nov 2025 15:38:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	patches@lists.linux.dev, Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Message-ID: <20251118193817.GA120075@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aRZsQvvEfAD2vpcW@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZsQvvEfAD2vpcW@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bdbdd6-fe1e-4e09-2b39-08de26da0671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GF2UxRYzgdqNqu/yM6e9LDBa9VfxEM1qrMLTCvAjX2WGQdQvucTDe5N7FYuA?=
 =?us-ascii?Q?iC//ktuaLjNCHFwxt3r37JZp2iQpLZaMDdPZRhzH3MOgEfhiFHuZsgeXTIGi?=
 =?us-ascii?Q?c/5ZWHS6mgjGAnBwrKwwJLnWyjg3bi0e3PCbzEZUvLiAHgAW7M24HRguGwlJ?=
 =?us-ascii?Q?nfnIymLdKYg7dnpLNfP38BF7qcmFRUGyIbXha7/qnGiOKxzhxlDgmZ/OuPdV?=
 =?us-ascii?Q?SQoSs28zWUoFgA2/06jCNZKUux1zKHJIDLPkb+YXZe+ASG6XpfFPfRdRpKRd?=
 =?us-ascii?Q?5YrKTh4tzUcnTGbBH9jCuq7SPYe8OdhrLLimjktZ97zJrRXiT3F4gUROb9gR?=
 =?us-ascii?Q?DQera5tE/xAS5EuZPTNAJZS2mlMQBTwvosEuW//ianAjfyWmYBXWfzIzs0Mk?=
 =?us-ascii?Q?qrx17OFcyqRnZpd+uv0fEROg+wrwfZfnv3nrw9J8x9stmknvgCEtLywUgCIV?=
 =?us-ascii?Q?ADVHXoKnoB0u29rcGmBHmyJWFal74Ghisy9kArM6RTtLcZ9tINOPOM105SjR?=
 =?us-ascii?Q?RHMLaxLFdUKeYvfDUCTHo743wxMvUTGOoECc2RP0WwcqEv1QfLveWh4dMrQE?=
 =?us-ascii?Q?c4Xn17QJZOPCDk3gpOIq7sM9ychFBK8JC1s2FAXRrZtwUL2Ki8btzcazf21X?=
 =?us-ascii?Q?GXNEkyLBxH3RbdUj1vEsoN61Wjn4iIpeiKzfBfBIigwVrJm33uV7LzCUyMGp?=
 =?us-ascii?Q?dg/UoZQ2vobjJc0CPUo8nOhJYLsIEc6v7UQ+5JMN6/Cj3dQQ5pgKbsgEzxTU?=
 =?us-ascii?Q?BfBihNE1F8MIoS6YU6H3uZxv70Y6hJf3oA+oiD3NwAl5xMa8vJXBCHIo8+2F?=
 =?us-ascii?Q?GANdhBobI09dMgWLCmJ+Naz3MShui5Wrh0kaJXW+g+1CH+Q3hNP+QU5lBPQw?=
 =?us-ascii?Q?9WgXQew+vRLTrL3flbJl6JqWcOEkXDIqyume3RLgPxy3u5rYbsoWiIvdzlNS?=
 =?us-ascii?Q?NxKY73SoHS1FvKS4OwD6P0+DoavL9yWXFRgMgISosyb/z9jyrWYb0KRv7tTm?=
 =?us-ascii?Q?U+0m7dcY8NhHw2cg4UDryCNBTivCcNOE2+jm05YgcEZZ7mkktNx4CX1HjUks?=
 =?us-ascii?Q?vqVtp9LsCmK0kRRosAjBL0W/NeaUZiLVDJNpZW7HMIJo3ZI1oyqGyJPPdKg/?=
 =?us-ascii?Q?wovqk3a5vX8KqoOl0XeNv5E28nBEO2OTzOl4EEjQxc/OJzmJbr/kafmKTpmQ?=
 =?us-ascii?Q?oVACyU5SFTjn6bBNdABalHrazicdNSBQvZOqkmKv/ApsPReOCtUAxVqgPdQV?=
 =?us-ascii?Q?sBsKeIAsfB/j8bYTR2cOY8m30UXQQfWlItuNR1KtJsD5qlDHmESV/P4q6Uc8?=
 =?us-ascii?Q?xk0IHQpk1cN9uPnyeparGLYOim2DG7koYAV/6bpEOk3PZOK7QApXs5zW7z4n?=
 =?us-ascii?Q?+40fIX9xyQQqWwpX1we3Rsg4FCkElrd93uHgugQRxOVvKwwQHU9nNBUdyylU?=
 =?us-ascii?Q?vIes9tmPAWif2KVgdIR3L0ePyeD8FdCD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73lRzuyDTfzixQDGc89dqo3YO80gT5pZDyFKlL85F+1NAmvSQ4rEKjfTKKME?=
 =?us-ascii?Q?i/+HeBG1591gq6dW/UZhbHiummVlVHSjDwcoQueBsunZobNjibTxDVnwuBXe?=
 =?us-ascii?Q?cQYMypzjFeu+xJPTtMCoRGWuKVjP5EzeyvOd08KQrvCSJKV3+Qw7uEgqMG0l?=
 =?us-ascii?Q?WfY3ck+XDx4VwPH4+gdP6zKeD2BLGMmodf30xrN1KQjGTx5EMtapEZZaY8f8?=
 =?us-ascii?Q?W5fXSVSmkDaweuzehWxxFXC3rWNZcSei6IHg+lKQeLRnnyqLxru98sWd1JWz?=
 =?us-ascii?Q?kdHjIEq1EeNWL4RG8ogIX3JjmEeytpnzOYJv5+ViWORxxGH1OEZK38dp1tyF?=
 =?us-ascii?Q?zugG5dIe22eScDs99lJWFRmQvg+HqgcEYClmMWIOjlc+kb/b/DLa2JPxZO97?=
 =?us-ascii?Q?pdnUk/d7aK54v3ktnz6mS9sV/WQH3pkNQA0xN9EPhgWEwxaaURRg7JYViBq4?=
 =?us-ascii?Q?BnbiMKK9JF3TRPD8rZmJNhiX80fxskD+EkBFb0/5eihazo5M/edyhc5b9WGW?=
 =?us-ascii?Q?H5gkxQsDs7zddklIwXnLFKQs0rc9wnDINxdc20Jwq2pDLGr1Z3F3/o8i/v2J?=
 =?us-ascii?Q?xIvxxvlMsesWc1TPWjNbODA2AeB6jJuTz2B2C/uOsJT7XZhnoYF2BMVh3yzA?=
 =?us-ascii?Q?TcvImZ8R+bZlwRjR8J5VCJzEgGZNa3nqrqMoq3OjNi9qR/xlHn3kbV0l/ltA?=
 =?us-ascii?Q?w3oZWeHr5E1eSpaFkuYlMBuIV0GgeSOgieT+j6D1D2TRRgtNDcbQ3hY2cgnc?=
 =?us-ascii?Q?u45bIMPEtNB6sjPHdQVr4/U5GHOdMxFwhBPyoInd+BuebBmlZkO46s79bTbz?=
 =?us-ascii?Q?F8YNczJk9leXbLLFrNDGRCruZYTi5PQSTbpt4We7sBcx5R5zUl9rjxEjwLE0?=
 =?us-ascii?Q?m6UN+/P5L8SU7q0KjXVZjdAWkh9g1WbfBmpKGaz9Uy+DBDufZWmP9jCRFkfO?=
 =?us-ascii?Q?09imViyYEkeLOEaGf8xXDt7P9FK3tmvnvDlnf4kCpgs6zwbUEoTcUwiLHS4U?=
 =?us-ascii?Q?XqlnZD7UnGLiYQYlm6YN5lvoD1nuWrJdbRcQfNzbSk94/H4EPGjdS0/SSuFK?=
 =?us-ascii?Q?OCdm/EDmhOoKwnU8o7mjv9nzt8g634hMHr9nsihFqTIQL/EV7Ss8eSkAV+/J?=
 =?us-ascii?Q?bZbq/MtQT6dnXjGRMgbHNC23LKxGqrFEuOvKwg2uMnqgjFQXH4Xw/NruhDFM?=
 =?us-ascii?Q?2+LVpEEW/igWNopgkbx2ApcTFkdWT2+KPTU42uQM3PnzR9/E2PENNo6fvih2?=
 =?us-ascii?Q?UAqf2r0qUhmdoLq8UNDTa+V7hl0Gd17GUxAE02mo9eB20BoN5zy2b7I+R3F1?=
 =?us-ascii?Q?pf/PhP3RUczGTjPow9lRW8Q2BZeW6mclAHJzkXx7Udhq/kcKDMx3pxGaT210?=
 =?us-ascii?Q?92djuEV8vFHHl0WcgQvkncxqHXyck5Pq7IANvxRKjPk5j69Pg1FpowlKdHxL?=
 =?us-ascii?Q?dKeckrg0VVCy7mh6iW7E4FIOV8s/sBItQuSDQvZm1NKXd4yey3nEdl/8S7Si?=
 =?us-ascii?Q?os/3R6pcUuy9RLDJlRdoewn2yFB+HmEc/aqJn1phd2CWzseRUW1yNqiOjvcE?=
 =?us-ascii?Q?rGbpWbl1aYESwxswkIA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bdbdd6-fe1e-4e09-2b39-08de26da0671
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:38:19.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MngkeCTahDV86joB4Ep1GWkbbLFqDJM1s49IjiojEZvb/5izZKhsgsNxUxjYQYKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

On Thu, Nov 13, 2025 at 03:39:46PM -0800, Nicolin Chen wrote:
> > @@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
> >  
> >  	lockdep_assert_held(&pages->mutex);
> >  
> > +	if (iopt_is_dmabuf(pages)) {
> > +		iopt_area_unmap_domain_range(area, domain, start_index,
> > +					     last_index);
> > +		return;
> > +	}
> 
> Should it be:
> 	if (iopt_is_dmabuf(pages) && !iopt_dmabuf_revoked(pages)) {
> ?

All callers have already done it, let's add an assertion though..

@@ -1873,6 +1873,8 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
        lockdep_assert_held(&pages->mutex);
 
        if (iopt_is_dmabuf(pages)) {
+               if (WARN_ON(iopt_dmabuf_revoked(pages)))
+                       return;
                iopt_area_unmap_domain_range(area, domain, start_index,
                                             last_index);
                return;

Jason

