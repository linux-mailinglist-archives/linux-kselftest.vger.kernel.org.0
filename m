Return-Path: <linux-kselftest+bounces-26861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8503A3A141
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82079173EFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BF026D5AE;
	Tue, 18 Feb 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n72m1MmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6926D5AD;
	Tue, 18 Feb 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892606; cv=fail; b=kh1QkXyeO9LhM2Q3rQNJ3Tb110QAMFz4aobdkYsTeGKIbugO4tWEwGZaAFK+s0zUyRUBp78u/hhWlMXYkv6XoZ0xvzFPHM/rNsLaeZoL48DWwIW0WkIpTAabbtw5DNFck2EgGQCTHvyXbK/7XdeWgybzdDzw7x9KpbyKcRIC+Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892606; c=relaxed/simple;
	bh=XxIXoLuinRk9IhFZ9Rb26Z5sOTAetkn3XWwRZuQUfhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7PKKGqqHO8r/goGXm6q/G7sG6mDegVs5jkQWekwge8T/2aNmolQwhfmdSYybZFab4HPlB9pmQbPZ6uKpgf9qckSW72rhrRcD2L6b+2xkTWBVoCbqNv02P/TItZb4t3Esk37WlHfrRGtTRtRQOcTn2w8a8mWC49K5LD7flR5nvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n72m1MmW; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxF8Ka+s8ra60RkQoSJSjfTDWEUJ9THicALWNOPIqKBuqzi8uOxj4ENo5eVugTBzFj5TjFYFcm/VV7N2K0utxFUeMsfsprhbhaHlfOQTsZAFiAyAXlKdJmqpdzzrnASuS8EbsjuN6BuTejjvDdj7v/ThsOkC/RzaNw6xJAfLIBhJzFCdwOfvYFWE35P0q7lV3Mi9emO2UQLVUbjCYZCwso9wUF03bRKXMORhFV04o5n/Dlgr3B9DKoMvLI34Zvm5U4pRCFiR0Y3DYaXLBZipJIT3K0wAUzC+DCBsZwvl5GJ95/z3QD9yhhiSlZ8LYSDUeibIJZYsdPIwITqtu3Cc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/VSgy+9Rg4DgIxZTePA1L0vot7N7qCFIGYl0WvbSQ0=;
 b=O7A+kD+/pS+ILL2u2v3twLZUwQ2UalxfxfXDv4ipbdlFIy8oQ0QFw/5c8I2qKnkno71oh/Ua+MTpfpvwbBHGkXeiTXWBOqeslF/tUSF/2KX7F8vJ7W84DUYIrKx0gLEiimeLm6ZhokRcGJQQGcl0SiRikraL+9USMdE94Loqwm70TR7ffTJu8HovQ2o6eMC0SpvjGFuIg1w9kPL6uV0HC6YvCvmq14i0zE/sB+24kBczTL4HmkD65VGUK+a59ftpMD8WM3zyk+BvAqJfNFjP5nPPgdoA0o0RjAtkPBm+cBaKv4fjsKv5yjVNWb2Lf6eBuHipzGNzDqX24Kn9jMmIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/VSgy+9Rg4DgIxZTePA1L0vot7N7qCFIGYl0WvbSQ0=;
 b=n72m1MmWRPNWTI45vBQ28xsrOM9peP1ujTaEUIieKfuzFtDrroSDasUPEhVt9jUFb493JMA9Qx0+rhlc1ud1XAjri8h8YP1qwMXcs8EbFQVrB9shDAFefbZGfKJ8zckfjbneZhchLBvxK5JU4kjKu9dnB6cFUIdRb0EMk8uSo4WQ8CWCLeOnx9spZoAHll65tz93hOEk0xeoPMGyCJimu6/s2ec6q1sy8mKtGWgnXoFD9odb9KjeqdnapiqmjgNf586emd+JIclQVGrEnhKeeBKVvSF5Jt2vk3+k8sR7PLBq9/W5f5BwDRpMb8jZhlbYUiyj3Pep/ELDV3nK67bW3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 15:30:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 15:30:01 +0000
Date: Tue, 18 Feb 2025 11:29:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250218152959.GB4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:408:e5::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: f7217d5e-d1d8-4c4c-899e-08dd50311bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCTlk21pzPtPRZGYGlsowqyouesLmD3GGksIzHtAGjqrjSGuJWVv5/XMsMga?=
 =?us-ascii?Q?y01mM4bQrbZ6RXTT32r2ipQNSUphsJGHgTe4WVKIlbrZrhaKnfRnfFtpCA8T?=
 =?us-ascii?Q?s/VUsKP/eIhJjdmyIo20YOJR72UAjM1rtBJQYN5xnp8chhFLc0o6N6zesO9S?=
 =?us-ascii?Q?Y74lui4jIMQ5ZKeD7fG3yUQ0P3k580zzeB0DVIwffo7hj9rlnnTa+w7rWK9g?=
 =?us-ascii?Q?vfyhirVqFtYmmzIwLbrr5K8ODHD2a2ebi2W0PHRp4CfmQNIFoxTaYxGnsUnF?=
 =?us-ascii?Q?EYMuHdjv+coT5Ck0J8pHoDNPiknFnFZti7a6PGJbrH7FUvMXXlcJ7kPc+fj1?=
 =?us-ascii?Q?/Rym/idkTojU2TdvFo4txYzjGa5s5haiZu0g4LpNhZEV3xNLm8AlLji3/Ykr?=
 =?us-ascii?Q?+zzmlXStO37/icRJYcXp36AV16aIQTyF5IsNmSf1LzLZy2XxAUtUKgeHaDXn?=
 =?us-ascii?Q?OzNR5BvB5JrXV1st0p8Cpe+XRNf4ZPcAfWTomcNzUHyP2eHmAUETVFelBucs?=
 =?us-ascii?Q?nzd2L4fXD+BQ0tnoiOBMNZzqPycxfYnhabeSAzLsHkG+PXxR9okV3NqxWI0N?=
 =?us-ascii?Q?0D4/91o+52K0FeINJIkahhMRywDQEjTyZOKvLatXEhwO+I0YMCCxntnYjPjr?=
 =?us-ascii?Q?t7WxiaILGiT3OXTVUsrnTeBRqMjSyT9Q3T6QoH6pNifr6/qN/jJYTB67qjdM?=
 =?us-ascii?Q?mqQRng9lBXI/uqVkJFHiv0hQ2fCtpOesMdiPZt1ml7bQhlL+ez9i2iwjYpat?=
 =?us-ascii?Q?tLTZo+Ei4vt6kqcsGI8fqvOA4FL6txkN2ca+ysFT5T6urv6izGkshq2HLx4L?=
 =?us-ascii?Q?iIp/yyku/5tMz0v9sdZfSvgY8TetEK4Si4ectA1xthrf+H5sDHW2BMovABbL?=
 =?us-ascii?Q?0atFPNs/t8yAuO4B94nKLMIGDaNXqqNi7McXGBzGDzNVK0/7Jxa4ndSKPZOu?=
 =?us-ascii?Q?wTrjhJDF7M8qcOuCLEHiZywZj988/r9x/t8pPREGuXPW5s4EjogX2az7DeQE?=
 =?us-ascii?Q?i3gFhI9731sxb9X2GwSjZ1T0vVDlOQkCfiadFxXmJ4yPCXZE+dWbYMBRrzY2?=
 =?us-ascii?Q?a3xR8HGQfjv9dqgFtnaUmJ4CftYvC4gew0mB+192FeIYdzhxnF/Fovq/Jrr7?=
 =?us-ascii?Q?FM/pZ6jw4QLk2+PJ5lWYSULE1P+cmLjmemZbRMzFxC/tZVfKmAvvWusTvfcd?=
 =?us-ascii?Q?2rN8YVr8byAJyrw/5m3oqkCQmVBPfs1A9rAmfLtclnpHtsOlAFvpHYFBpu1Y?=
 =?us-ascii?Q?5+2A3EPMqsgQrUIw+ykwMDXfUCSYF/1hb7a2+3ZANu+9FJ+4gTbWi/OxJaWJ?=
 =?us-ascii?Q?eHMy156Uk1y5g5kLAUUBNO21HqROCfDMpDFBPfIj4eYLT5CFa7BTlEZzI/Jn?=
 =?us-ascii?Q?dXPsYsnvG5kJeoKGAF2TI0rUWA4Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3O5yAkOJqipW/lNofLdYaCfFcy0Gl9JiMGcY5Vn+s13NvQ9QZuUX22gAy5YC?=
 =?us-ascii?Q?vrpewm7SpATSn+ydrzgf7AJaRoQtYvHFVu2BGociLUqKjb2O7gBCqwBFiZa/?=
 =?us-ascii?Q?M9SvR6hlz4ZIteBX03iGMD8av4ejve+Ce1V8n9r7thvKD7VsT7vTf2uCyup+?=
 =?us-ascii?Q?S1H3HwOCHRBz0z//KkWPYuz8AIzu1pQT73AXyTL9lFeqrcWDqu5PGcizoVjw?=
 =?us-ascii?Q?quWDH8ghlSueXnS08OJdKaGIVfK5n+eA8NaLhB4HI4bYzErxK3e5Wbtn5b+A?=
 =?us-ascii?Q?MqamqUDmj0X9/3DeCMYu0atG8PFuk53YHDdSopmABowiG14dkd4GNvB61uUr?=
 =?us-ascii?Q?9yWnqRCuZGAkD8zNnx/iN+MhB6sBCKAZlIhB1JdGLFpNbE6sg8FawOh3lCTy?=
 =?us-ascii?Q?lPaVgRuoMiOIMM2rvliYr/y+D+N/jrMMENChlsgREvMtOc36TSVIc92LeLG5?=
 =?us-ascii?Q?nqcUJu/fEjoKf2lGUYc3bbHnh8qn1S3nuTRewlcnaJBB3gfGAk+qI1MrXq/3?=
 =?us-ascii?Q?+M7L3SPbAf2c6nU8t9Thn1IX0gNE2X2EsMIpvGKnTlJgE4tDZFcalXNEwhqz?=
 =?us-ascii?Q?MeFetEJeBwUD1rbrgUd+obOi5VAGj1TRXnhmzEuANpkE+rMs+UXXdjnPPVV3?=
 =?us-ascii?Q?foBdkdTOvR5uLm2q3mpoJJxbfIpi2nxt8JcPr1XgwkCv04kHtbzlqNQQP0Yt?=
 =?us-ascii?Q?EjpJyg2YatEvAui0tmkdLJosysJyRxM2pwssvRn9a6cmpuX55yeDLf7mEvoW?=
 =?us-ascii?Q?/iAXt4JssYiI8fPBs2AMjMBQpEIgfvMCdf+JTF6xHKDDnGxLF5AJEnEZfwJy?=
 =?us-ascii?Q?BoGlg6hToWZQg3bhUUzPBf6u/lZQ7ACt9O1QvmvQYgIdFbzLV3nl9RPt4Alw?=
 =?us-ascii?Q?yer6z/qoyTWAh/rUppUwAiRlZVH+t+dnF9X5T+aa+KmWNsbk1hHEZ+iOObtE?=
 =?us-ascii?Q?+AMXDDgAZvDYr6frB+1PjLEnkgyS+MSSVvc5zVnjQgbd0CThoMh0zCqADFMU?=
 =?us-ascii?Q?LsoesfedwCRcGR8OBBdzEECUijZ/sNG13zPt9O7C0amp+ZHeTDkRuqqiXV8Z?=
 =?us-ascii?Q?bzjcW3j8J0XnscYmk2mtQbMi1TgtKEh9wL1Ag7taXnooWyHjdyzkPGtCrKsC?=
 =?us-ascii?Q?QbrJx0H8LwDWAlQnut6DvFvNMMXOD4a7Mhi0Nr+1XRBMYku0//3Dl6kV33bx?=
 =?us-ascii?Q?RDCoHKQlajIP49vvDyqcs4NieF/O8K67+R7R36+LbiD1KWewW7Cg4PyywVrr?=
 =?us-ascii?Q?aLXh3erkoC+9TzZhoqVjNTOFWtos94Kz4CsffNkNMdj5lOtcBLrYShI9y4Lw?=
 =?us-ascii?Q?qZA4b1JHYdhDeeSEvxiL20XGiW4bOBopSxUJpTRimgC3b8Egz9ye+y459td/?=
 =?us-ascii?Q?Baq9/+xMPZr4ejsgI+FAVmhX8QVQ6jPKpGnLlkikgOfAUv7rTZeLewuPufZo?=
 =?us-ascii?Q?wQfjGJDM/rRbUW4DrXFwBmB+U2TX+1XR8MtIB77sxF4MCNquniscOS12MfiQ?=
 =?us-ascii?Q?GNeZzburO+V17SzZrNHVik8UNJhsD0YGAlL7fGGIEY+ntVHg9RwDHcjDUtJX?=
 =?us-ascii?Q?FLw+RYpyFENWj+4+8Lw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7217d5e-d1d8-4c4c-899e-08dd50311bd1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:30:00.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et42yhuDSjsy0nHfNUuoryivyjSholNHDb6tZGS91DS1YnIyLiYqRhr5Tnfag+Jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

On Fri, Jan 24, 2025 at 04:30:34PM -0800, Nicolin Chen wrote:
> +	list_add_tail(&vevent->node, &eventq->deliver);
> +	vevent->on_list = true;
> +	vevent->header.sequence = atomic_read(&veventq->sequence);
> +	if (atomic_read(&veventq->sequence) == INT_MAX)
> +		atomic_set(&veventq->sequence, 0);
> +	else
> +		atomic_inc(&veventq->sequence);
> +	spin_unlock(&eventq->lock);

This is all locked, we don't need veventq->sequence to be an atomic?

The bounding can be done with some simple math:

  veventq->sequence = (veventq->sequence + 1) & INT_MAX;

> +static struct iommufd_vevent *
> +iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
> +{
> +	struct iommufd_eventq *eventq = &veventq->common;
> +	struct list_head *list = &eventq->deliver;
> +	struct iommufd_vevent *vevent = NULL;
> +
> +	spin_lock(&eventq->lock);
> +	if (!list_empty(list)) {
> +		vevent = list_first_entry(list, struct iommufd_vevent, node);
> +		list_del(&vevent->node);
> +		vevent->on_list = false;
> +	}
> +	/* Make a copy of the overflow node for copy_to_user */
> +	if (vevent == &veventq->overflow) {
> +		vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
> +		if (vevent)
> +			memcpy(vevent, &veventq->overflow, sizeof(*vevent));
> +	}

This error handling is wonky, if we can't allocate then we shouldn't
have done the list_del. Just return NULL which will cause
iommufd_veventq_fops_read() to exist and userspace will try again.

> @@ -403,6 +531,10 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
>  {
>  	struct iommufd_eventq *eventq = filep->private_data;
>  
> +	if (eventq->obj.type == IOMMUFD_OBJ_VEVENTQ) {
> +		atomic_set(&eventq_to_veventq(eventq)->sequence, 0);
> +		atomic_set(&eventq_to_veventq(eventq)->num_events, 0);
> +	}

Why? We are about to free the memory?

> +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_veventq_alloc *cmd = ucmd->cmd;
> +	struct iommufd_veventq *veventq;
> +	struct iommufd_viommu *viommu;
> +	int fdno;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->veventq_depth)
> +		return -EINVAL;

Check __reserved for 0 too

Jason

