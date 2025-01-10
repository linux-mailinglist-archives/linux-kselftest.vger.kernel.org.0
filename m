Return-Path: <linux-kselftest+bounces-24230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BBA098DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3D3A888D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353C2063F3;
	Fri, 10 Jan 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bM4t7GHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B719ABCE;
	Fri, 10 Jan 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531328; cv=fail; b=kCcHlrsAL/UYH1Q9cGOuDNdKQOtJvjlqCbmG+4Kiw4vR6H149fGydt6D5RelplVSuE4tC27Asb9TIsZpKhZKV1CCCXZjF447FW+TZYJVQgw4cSmXMieZ5zXHa99M1fTMm8lhQBuy1EjZlZGVrbzHI2v1d5bbHrrLtQ/pDyXI7ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531328; c=relaxed/simple;
	bh=T9ZEC911WjRuDY9v9O3CDQLiJjEoTLeL2ZtVHOVZxdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NM3gCOii5Jqx5LQzRYrptYulkJf9hUH5d4mztVu35p2tyaY2kuXKsBJU8nuRJKOWG3cK+SPOb/WjJ8BgtifptRPUnOG7zwhnIGLeLwxP+BPa7ncYOXCygRAr27eJ92sL8QgdPsNaScuFabjEbWeE+Lwt0S7AYiEPuvopk2aHYG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bM4t7GHH; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCNW3RorOZrjUD1Zq54yACfugktXjGasyZtWk2aigXEHdEkhCzgg7d0SHUFFnnNxknWoLvIZYlWcYLeciCbSRYeZAw+VfPoiLKJqL/auRiH8ueZNPw9N18WG/O8cphSGYNzrv9lNUAqUn2W4N8YmrrpUzCYH/CgsEcHGGdVuk7MObnrHrPklyDmkrwIntOGNsyDwcWqg2v3nUEL94C+Fip+s0Ik4fWfFPrfcEG+zVG7HVftHgGOkxtFbdktPRzj+K6KMH8Jxb5hPc+8Tzrjar2wMZUHPFc/Nl3eWun6SV0k1d0u0+bbAQedyNU4lj8tOfgzTZDmPyZOsMz8Oh/M74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/vY7h+HFPG/GpdrJJy6eVbrusBziRtLYMdmUhgl/j0=;
 b=v33txuhfk8775UNZ8Dr32Qm0PoqEqTIzTbB84y5Xs1iJZ9v36XI1PKwlfbfo5oWOfgs1/xtQZqfNVfPIuM3vIBm7x+Q7OdZt9i/LXRzF4RP7SP3nyvN0qy0ZrNmjvitNRxjBZfx5raHLRZEs7/l++EBiZc859kXPU74WI7p16JvLpfEkxVYFtSETGM6fomtUyAN7XQYYPvTfuqRfS7/BefD3kZxQIoF41XR2OqfK5CHBOzXCP2eCwwFegfHg7b7biqd4buvPNU82iK6Zru8xa4mEiE6XBe7A2mviBUl1PG7I20LD3YZf2+CfhBwpJOxm5bllnykMQrSdNpSd+25FiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/vY7h+HFPG/GpdrJJy6eVbrusBziRtLYMdmUhgl/j0=;
 b=bM4t7GHHAPJln8EL9v17sN2G0BZ5Qz0vz0JoRtz3fw37/UgdI92iOnWax65HZgItev32IMf/fgcZClOTx+7Qdql/PqyIldMy4mYpIocXrMWnPiKGx8cFKjJYwjIS0aFwnNBGQiAwmLia3LPPNFIm7abM9k53O3PQPucyVN2shBujR8lM2+OQrW47TF+rGUt6w6rOuO/P+ItzPZ5LZmTvStnswtJri+WfgVRmvVJoxr0NuwxOPy7ZAMCUelDRUJ6I+EY1ljXcwi3y5qIE6u1q4L3XRj1Y/JG3Txiczo9/cEXUCgNWW11aQkEfKCh4Ur4Y3p2i5K6mYI2xNaG8SpJ0OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 17:48:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:48:43 +0000
Date: Fri, 10 Jan 2025 13:48:42 -0400
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
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250110174842.GI396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:408:f7::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e8f8b5-6912-4af6-8b0c-08dd319f0627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omsxOvHF8Fa4i7UfOkc9P4K9wX8/c0fllhqEeKgVfAv8V/FOsT387oxYdZG7?=
 =?us-ascii?Q?MP1si3pTGHbIBdnUtLs6TWhzbGU/7mdiR9+023Fcy+DIUxQx0rcsHYFKn2vY?=
 =?us-ascii?Q?VU3Z8+WqT9IeLO3m6nnuQZvP/oxZC/5EVfpUr7ErV0aC0uDWHIxHUyQRQ/T+?=
 =?us-ascii?Q?6RC9P6PK/vMW1F6zn6BPq9ukMWH2l8j8cYOfEvQuqamUmV9DvECaho8/viUg?=
 =?us-ascii?Q?1+xHzduwizBsREZ0ERsOKvTjFT9rBjhfeYT7urQ1qBt1xn0EKXoKXVF0m/6x?=
 =?us-ascii?Q?pr7e9kan6PSuuGfgQ8crgD5uQg7/lTU9udHSDNTU6BrdUe3AW3UiCSozbFdT?=
 =?us-ascii?Q?UTyO/yaff8rIIavOkFI3kGYx508iCfOzOKrYaeyQbaYXe+DCNJitpvvVMQH6?=
 =?us-ascii?Q?EJa/a73AAnQMb8xGU6KSRVoHp+5eSjJTLLlQ8XCGye571O+f16+T2+oo5Eoy?=
 =?us-ascii?Q?ykIpax347tDsRkWxvYni+X0oRBl8LYNs27K4/CgyuvmEgbMF12SQiC3FfTVl?=
 =?us-ascii?Q?5wNlzzw7c3mCm2lCj3netZGZhRs+opEEYbNN2nu8Eqi7IjIFCCOr3e19dfk7?=
 =?us-ascii?Q?T6LBkpNBIQS6FgiweT8rbw7cTnA1yw4OrxAID+JI5tbHz11VhN+SRC45IzkE?=
 =?us-ascii?Q?Yc5dva5MgGEdGbGVwKDwRmQhN/odvIaD/b/hSlTCeA6FtEWGVdokpBmIxZoj?=
 =?us-ascii?Q?DVmN/hvcp014ZsLwo3SzlUZI+nOQlwGBRn8lyKGDU1CN+55EEUXtBAvs2KJU?=
 =?us-ascii?Q?9oo/HQr7pAyLzYVQKQ/GgGHtS739LO9c4MCHMfLDgf83fU/1t0Xl1iCGfNo5?=
 =?us-ascii?Q?c9xfPiNKrzX9AIle/uIERmhdx1qtNRVFRgJHMwaCXJ6wlJiSnHnV2+fO1xpg?=
 =?us-ascii?Q?GHvFVKg3m2GiA1G95s9/RabPcrwon43MMwD4m+9N6ZrceXuutitJCQjF0qQV?=
 =?us-ascii?Q?4vQ39pKK4kR0h8BC0OA7j+TkEpTExqmpk6BphMhTo8671pPD1khPWbS55s8j?=
 =?us-ascii?Q?Wq9fXQbAkziLQ5W4Jk3ACJtL66cJ4YiorQ7IPz2nCQhksnXPJtAxA8hQpUFd?=
 =?us-ascii?Q?Z4R36BhWOdLgEMlUAJaO+XD4GOgazpyKmLxhAPgwZHac+zjbRfh8knl7nd1t?=
 =?us-ascii?Q?3dSLDmLULAqIvyDBFMQDNgyQJ2fkUpQLNq/w9yvsvc2rqiTn/F5oBjYY1US7?=
 =?us-ascii?Q?9k/3ofUMNqsktULRif+8jqjMa5CwlIVsqC4rvyfeLvHpPdWbQLL2J2NEkVPF?=
 =?us-ascii?Q?amc1et9LK9oGfwytVGSDHDHY8OY89RBNxXN+ys0Xga1P7lUZ2BhGFlJN/PST?=
 =?us-ascii?Q?ppN/JwZp73OcMEl6i46euk1sNq/wCnleUCRJ5VHy/7MF0i7RpxuxzO7qpZTq?=
 =?us-ascii?Q?e27vmgsnnIy65Sxm+QlXnqBMewoE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?endeuzGvL4U0rlhgG8GO52LJM87wQ4i2JEw0WAucGkfmfiVqyFynF4aPXx3m?=
 =?us-ascii?Q?GvMovbljcmJObBSjowIfst6XqUK9d/G8o0eWt1d4vKmWpLTwgVz9sK/nmCu+?=
 =?us-ascii?Q?5w3dsuIv4hK7VAlzFMGjGE4Rc6xdlIgGXb/oTePkrhmm8rbOiaxes9GDW4CD?=
 =?us-ascii?Q?j9zJBfhYxs72ocfHT5BQfACB8opxJEBxaVFZS7ntniqVNfXj1BSAkuOVK48O?=
 =?us-ascii?Q?g4UtOgMSO3ovdgpFSFnj7kbaawYPH8Odv2bu1Tlx8NDnBE0i7wAug8MLo7Tf?=
 =?us-ascii?Q?jkeuCpDhxK7uUDr/79TP8zuPewWWc76xMN2OT8BxCvHBbxj0/XYyPhTZvGIK?=
 =?us-ascii?Q?3c+WROGRoKQ36venZ5ZVYM4BULZ9RkiqYkAONTXlBTAYetBJ7ctftIzF3vKr?=
 =?us-ascii?Q?+yExLd2eW8LhAGPsmU6MYhFNDr7Uu0HyQuXY9g8YOMl5DT6uJNg0fPoAx38w?=
 =?us-ascii?Q?HiWVcnMuAI+5bcKUHiya7AsXhPgdgTeuV/TkE5Y47feEE/D8a+OGJpD9nvw9?=
 =?us-ascii?Q?Iil2H73OKZichpGGFStjyLfBQkahJSkGECeEAOHiaeUKngmGFcDEQw7G97Y/?=
 =?us-ascii?Q?QOj9DIHAq1nDyxfyloc+icuCPcch/dwuHzC9Rw53P+XZ/aB6yjh6z7eVY8lw?=
 =?us-ascii?Q?yhmX2zWXAVoaxuY/TTHhDkPwYglBEbIGYo6t7CblqrxWqLj1bpyiIw5e2Hn5?=
 =?us-ascii?Q?Q3VoU439oQbU+z2mgRiGC8xjFfAsKd/RAye9Qinxf7E1CQOFldBcceEpzSnz?=
 =?us-ascii?Q?OZWUjs+rk7BOE7QJ2wq8PpvCHMSQnvs+Tqmwh/L1xABSm4YfGju3Zu/8co7k?=
 =?us-ascii?Q?cDso9wux6k0Lcte4NLyxcT/pv90Rz6uEJ8K3SopDr+ZIW7ne7fFMoQqwtcVX?=
 =?us-ascii?Q?AyS3Axxl9RuGvXBpqHkvyHzxz/AHNhkAMvuyjds0cG8VCIvEM13il6BnbWzx?=
 =?us-ascii?Q?Q7aKJl4gaT5Ow+Nq4jtkfVGNAakW534xs+99xwm8EfsUjczKTH5/ISGE1FNa?=
 =?us-ascii?Q?+ri+PBNx/y23JVeMA5y95UNcf/ZnAc+iSILu5u2pjp0psQ363ROzthRSy6Wc?=
 =?us-ascii?Q?ZguRkUhWvEjy7sME21RZ3I3EsS5jacnmjWV9OPAAb+aiWEVMM1RUlrGpnFWL?=
 =?us-ascii?Q?j1cHcdMNDU977BzFJYnd25MoK6LSBj8Ho2dVwjbjr+rYAtvdV1+crIGIbCj0?=
 =?us-ascii?Q?pZsGyhy/D9v+12/SLisln2EbWHUF7YMw7OqQmVNzMXyMuTPSRLdvxKb74lvQ?=
 =?us-ascii?Q?BWQmXR0XTEBIgH1JBlpx1MhiqNM5szbDw85tdeSPAF3rEZDP7kDOoQ3dDW5r?=
 =?us-ascii?Q?C/9n52b8k4ZU6nD/pqQ1ST5b6Xlkr3XzL6jt/V4GilPX5+WP7+u2z268KoPG?=
 =?us-ascii?Q?PAv4u7tAPEIOkvWHG7OL4w/KQSRfqfuX9LWPgxyiPWWoIj0Vrhe0axG9oEBv?=
 =?us-ascii?Q?KdGIZ7V2PkiM1gKHNfwY/HdJIVlZHSifQUmbC0l+aXmYqCXDBpp7pPKLRpMT?=
 =?us-ascii?Q?kav9mDnJn0Mvd0e3LrWUFUCEoxwRAUn3jiC6fd+PJxxrQrxNH+TrUIBlfIQS?=
 =?us-ascii?Q?ZTdYOIBxL9AW1VHOiTT+dXb1Ay272qYHjna0k4/H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e8f8b5-6912-4af6-8b0c-08dd319f0627
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:48:43.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opyn1mSVaHQju8DMJ7IjAiIX7wxH8T4/iPcypqatF2l0ZZ8lhMXZWnOlmIAzrR6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

On Tue, Jan 07, 2025 at 09:10:09AM -0800, Nicolin Chen wrote:

> +static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
> +					 char __user *buf, size_t count,
> +					 loff_t *ppos)
> +{
> +	size_t done = 0;
> +	int rc = 0;
> +
> +	if (*ppos)
> +		return -ESPIPE;
> +
> +	mutex_lock(&eventq->mutex);
> +	while (!list_empty(&eventq->deliver) && count > done) {
> +		struct iommufd_vevent *cur = list_first_entry(
> +			&eventq->deliver, struct iommufd_vevent, node);
> +
> +		if (cur->data_len > count - done)
> +			break;
> +
> +		if (copy_to_user(buf + done, cur->event_data, cur->data_len)) {
> +			rc = -EFAULT;
> +			break;
> +		}

Now that I look at this more closely, the fault path this is copied
from is not great.

This copy_to_user() can block while waiting on a page fault, possibily
for a long time. While blocked the mutex is held and we can't add more
entries to the list.

That will cause the shared IRQ handler in the iommu driver to back up,
which would cause a global DOS.

This probably wants to be organized to look more like

while (itm = eventq_get_next_item(eventq)) {
   if (..) {
       eventq_restore_failed_item(eventq);
       return -1;
   }
}

Where the next_item would just be a simple spinlock across the linked
list manipulation.

Jason

