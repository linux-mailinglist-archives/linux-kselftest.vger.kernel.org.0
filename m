Return-Path: <linux-kselftest+bounces-24675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7EA14323
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B98C18895BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C2240236;
	Thu, 16 Jan 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hekUFTNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BC22DF8A;
	Thu, 16 Jan 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058914; cv=fail; b=W7K+Isimyht8UkjdLKna9oCLYw6V+RwLsTsFPv8w3SNzJVDi/nrIw+GvA7pg2kee9zRLPQJnYDrN//vva5TOTE6S5Pttbe7TBPtG/QyBoz/e33k66jcxnuIAK4oHDZhNPGaclVUvywWnJPgqjNV1T2pO9/9b2YATXFAZH+vsNJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058914; c=relaxed/simple;
	bh=bxD6FOBj0AS+iUllgNE9BhTcXAwjGNgF+XVwH5YiVb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXUD+O4H2zpMHackASS2CtVGJxZY/9OdSpH6lt0e451Z8ykbkei+1OfY88LDnpiajN9KMpGyWbjFJ1FcvOuYew7vmBrVXQJsbZUP0bY+OUxj/6fzljk0JE0oHEm2+KBG3i+W+hR5iEkdIW9cuvETzu/a2E7qhRceKIw8lVYWCrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hekUFTNa; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV3sBD+A9Xvt5aDuVLQ3lA+83gfl1G25kCXIaffmZRtamc5ITDOppmTQ6qJn7+FVkSdjqC6oooQTv+AkAZlG43vPCpPhfPsgxZ1uUxMHFTmZ+12DaM5eDIQyMhVqvTeSilcWEIBxkmQ6jgDalxT380qiGpxx+oTegLBg79zhn7v+Zzytc/6EbGOl0NR15elp/nTVPeVBL98ZVrGk3goGnKu4lxR7sR3+ePA2RuF2qnTs4FVPiII29V7ClL8Y1/W+GyQ85idQCVFcUNXepxcU/Ntb9YVtb/0N3UJqP3d9jmHrMsC9tHAHRVfZy9vP68JU4QCqttvDcwpVCgQwApwW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oGGbB5F36B5HOIvGVl78LudJzl3teWwAVczEL7f1JI=;
 b=d9285NYrtMTn6iUjn9btJcXVKcGjEIxq7x6HV6qtVSRpdY3l2vLT6F18vVxslu7q4R4y5pu6oOMoMtLPUUYauepZ5Do8V0PtkUp8GiukT3OpDO3brfCUor2d+qbBTQhhxnEWMJ5aJG27Z1TFuk6njbrRJg1FejueFARSnzdMPrNp2YBfEf867S3H9Q8gBEhfJx/e1uzU5xEt+pF2yEln4eU0nRKdTtBhSjSzGFRn4/HPauMo7qHwxkV0psixrp5Z1OdDBsklA2Z4Yem4qG3pQ+gCqI/QZ6qgVzi5iY2WumEYd2mKvI4CRkuNW3YhMeYEgpvIWL2f0p8e0zxjjtff+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oGGbB5F36B5HOIvGVl78LudJzl3teWwAVczEL7f1JI=;
 b=hekUFTNasFe0Y38Z8I9O0HyOgwNJ0iRD3+dk+9FT8KlQG4ojNj333pD7JRCa5fRVDlFO645qrgzpNr1TRV20V3gc74w3biwhKwkQveI43hlIMP6DPeK4WuseSQ4hgJ9b1YUL5FifKuMwCwNxvFF/XT16eypeEPivGACai6Yv+Xag+sb4Olzm8mwJGePjuQKMIPM1jaRgIhjDxz2OABdwpE5RGl5ZRgCqJ4a9H5Lb5wM4fbpbpu/MaEI1WIqdpoBaUJMdDRuG+yAfI5SCiWgBqO3X/A4eHHpkzmsl2D67gS6O1CYncgFOZsjPxAWW5iXARx4GfeFNJX2/2gVZonMhfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 20:21:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 20:21:48 +0000
Date: Thu, 16 Jan 2025 16:21:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, eric.auger@redhat.com,
	yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 07/13] iommufd: Implement sw_msi support natively
Message-ID: <20250116202147.GX5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <f70451cf4274bc5955824efe9f98ec7dfdd10927.1736550979.git.nicolinc@nvidia.com>
 <Z4c3ueuDgM7YqElp@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4c3ueuDgM7YqElp@thinkpad>
X-ClientProxiedBy: MN2PR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::46) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 955d5b11-ec45-4f97-bc82-08dd366b675c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qI5uo4hcx9x0WmLq/iS7KNGlulMOiMoVqcRP0eGwpx7JBHJFgEKgvTU4WNUZ?=
 =?us-ascii?Q?PZL1eJ/apvt3iil97lY8SGZxyqqm5ZbEcAEQI66qk08YbFiHjMKEH1xN1ofa?=
 =?us-ascii?Q?2aqInMDWYNXW8+Qb04/NUSeERFd7vu/MkK1EdFEiO/atCBNVfJ3WAe8exQ/9?=
 =?us-ascii?Q?6TLPDL00EgS3IdnwmmsE6kJKCp7eSWRQ7a69wecHkt4e4I8YoNH+HUsbUptU?=
 =?us-ascii?Q?6W3An6zphJxpXzU8EL4Ds3XZCReOLwbj4Ra+9ZA+snQbQVaYiCNcW5X9Igxd?=
 =?us-ascii?Q?ofqXMEj8jAgi2Wawgecgc0mteGa5bzRhojtZYTLBVyWmNyKN8q010La6TMxQ?=
 =?us-ascii?Q?2L8YxBeEtmkPieatLPy9UazfYqlIrGr4u8B+OB2cvfNpLRCoXO/JkNjU4fci?=
 =?us-ascii?Q?LE6qYT/i/PA+79LyJkuH0zGZkJLQdd/AxWDHAFdDPflW08RGfj5+677d10aH?=
 =?us-ascii?Q?wPnElCo5uQP/5n8DBmHYlnhOOzsro+y9mW7emgrN99a0wS48xiQGQ8T2idwS?=
 =?us-ascii?Q?3sXTt0nWKq4eSbiciXUGooLj6O+UR7msFtAOEx1ZZaGy+yTFr30pJDsZlbfU?=
 =?us-ascii?Q?AtPNMGZY3PXTyixhHddsTEUGVTDqLQHeXFiQALgeRhswcOXN1dyIbTkbzHA/?=
 =?us-ascii?Q?sKNp0lmzBUlS3vcGsTS/RLRCfcw3/XZM6cIz5oItMkjnSg+Ezb24AYpztAVx?=
 =?us-ascii?Q?Sr6dytn3mS2ZLW00SYhxlk4IAKAdiglV4nN6y0A/QOi9zer/+OzgE7zEfhKz?=
 =?us-ascii?Q?SKocqILLshgv1hMn5rL2D/9Do6410R3jOme3tV+nuH5ByHlMH0cqkvxtS9OE?=
 =?us-ascii?Q?zhR0NsvgjEuU+kqLf7r5LoroMTYzOKsRtB05A8kUx71vc2nkiMsRXCzETON8?=
 =?us-ascii?Q?ym+zCA9iSgQrywEDsttp0azAEvMeSeXlLQJ/Sk6Mqf3kSHlDHPkqvtEyPtzs?=
 =?us-ascii?Q?oDQIX0ZfEo0ENdowUjouuSM1TJ7o/8z2giLx6MxtcvNS/YvPXU9yWjtFik9A?=
 =?us-ascii?Q?P7AMQ3VrvI5uMoJz1bjQOvDRoD+ETn6oCREMzsmzDHJx3DlrvpL9UtxWdJff?=
 =?us-ascii?Q?zVpOI8ERnmLGHOokYov1f8twr+LMHa/NVgrYMcFNpR4Gnm/Sor9D+SUkYR+P?=
 =?us-ascii?Q?Qij8B9qUG+YtlvCwfyyH8MCimjIskC/WVnFesZu1vqDDjKD3aAKBwuRUzZdi?=
 =?us-ascii?Q?7f6ueGg2gJffjHB/cOSbQUp5bXzq+0ZjtcnPIXZZHmNHgceRYZKy+tzc3tN/?=
 =?us-ascii?Q?Wty8MslmapcadAwLrO1+mTMUq18HPNMu7q8SujF7JbBjygDBc24hE/JgmwlI?=
 =?us-ascii?Q?dMG26OMsV8YwIPPDq+BexmaWPhGOUlJyJXSYfsJqmxvMapllaSoIcBVqqFIH?=
 =?us-ascii?Q?eKiotenc/Vn2bhofVQuBmvmK2RjE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KSl0J1z5mSc1yb92erkCOTEmnlbiXyRWHGehjdq+k4HWQz9PzIxvHc+RwOL?=
 =?us-ascii?Q?wF64vjg1ZDdXTkMqqwvc+CZ2DHIiTskEYPqZPdaWLd0o+c0t95ahUH/kUGjC?=
 =?us-ascii?Q?0BJctfpwDr5xYVNkaqCdS9WTI7hSWvO0ay66jkso6tphfWty/K5MRLHyhzbp?=
 =?us-ascii?Q?rYX8o12d1e0U8Cyz5CzjSOwFOuCYuOgrdUaIbfPspdYgXEwq5b5/07aefIG+?=
 =?us-ascii?Q?BWMqZhSgV8U/eiHPIe4vIElX+6Z0xrrsfpncEMKOF7HG8JH/lXTMPIAd1XCP?=
 =?us-ascii?Q?F0flSoSNQAiilkP4ua7/LFU/p3YncdPDRafwqTkGl8LDK4pZNNUOSaL5txVN?=
 =?us-ascii?Q?dlkak0jd0v7cN+ddlVfkH/YzD4okgl3S4FJfGjlxTn5PmP2GuMc06fOfEmSb?=
 =?us-ascii?Q?SjP60tmdYt2HUBHbIOK86DUgm2YP8B1fgY4tck60QKyjhkWbSmnvuJZaXFe0?=
 =?us-ascii?Q?wQob5ISrWGXLeUEHooSzEs3BBQfSDHSHMcwVaH5M6yNU4UtTefVNGrn9u7Pp?=
 =?us-ascii?Q?VXWGcDSYBZpS4KFTaKkE0xdaPQEBWwnv1H5qmDS4DFYULKSFyknaO3jZ2QY2?=
 =?us-ascii?Q?FZzbpj6PTaQoVRZFUGyTa0p+gVmLVhkkHziugGjMOQJbjCWkYI/c4d3pzB3V?=
 =?us-ascii?Q?avGd/jcBDzG8ta6Ht6V3mYhkYDIG3LKFSL6EQFQQJaH13NA9hj1RenpJQ9vU?=
 =?us-ascii?Q?3aeHZ3sNxY9PigmeHJ5q/izVvcu79MmPaL0o93pMzEKzmK+0T9T7wif2F0Sq?=
 =?us-ascii?Q?3/JA9tgKgaw/MvKc3GSTSPHq0JiUHSgl44+8xRJ/KsPeeSau5zxq0jWL55pA?=
 =?us-ascii?Q?JrIQ90P0Lpmaq7voZ5LTpSdKBN3Sh5q7bbQ102DiEN//x3Draq0YnOzSNeX2?=
 =?us-ascii?Q?E/wUcCgegMwcddMU9AgxD4unnL9OyW8e6LIF+HmRxVDVUw8rj8lrqcBtkWMN?=
 =?us-ascii?Q?G7FNe7v3LJjzBYDBz3sXTtbv9bmAjNrp6b6xkAB2gIo4BUxdxXC8amHa/JHL?=
 =?us-ascii?Q?YVLDRm+RZwpn/o1kaXRKVjeE5JBHVnoc/mBNj+JovpdurXMYa3sFzQUgEp+0?=
 =?us-ascii?Q?e5oFm9i9AJzEFxa3i7ZEh0ICXDPMQbipUw7h7YprSqv3aoY1fybWobGQkXmD?=
 =?us-ascii?Q?olzenLFGCrc2ggB8RLa6MSxNqf9OzhEI8n9EAO4bdLXMFBuQpWvmOxiK4BQy?=
 =?us-ascii?Q?5Sk/gg8d+eV/C80HlL+Ym8RuKUDAm4PyuWThaQDQC8agSSEeVs4U5VkBDeIU?=
 =?us-ascii?Q?FP/Pj7s9mELvOtzYAo+9zWN7mSxi7lhTxSpdHFWDuZWXERPpea8HByLyzk7h?=
 =?us-ascii?Q?+QlQvGb0MNcA31GKzZzeEHYMVWTLDXHKcuRDINKQzmoHKMD1+dtzSQReEW6K?=
 =?us-ascii?Q?h+2O6e9Hv8dWT5kCtJRywCNIF9pX+8PUseUYhXpfNx7nXVGWdoVCkzFvzR5d?=
 =?us-ascii?Q?VjlmKNbwUbCV2XVpR468K1Vhkjk3/doBrwRGNvXjj7zfcVL7WCzAGcVI8+Ui?=
 =?us-ascii?Q?6c0BupZ59X79AOv28exFzfi/8mUHHQLBJiocYoQsv7RFvGWAzmoUZwUL9j12?=
 =?us-ascii?Q?1XiE58d9/SEMIfCnZrs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955d5b11-ec45-4f97-bc82-08dd366b675c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:21:48.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8Wcthc+asJ2tQUSQc1jah1Mox/qwrTdtXXHw52UfqgqxmPKFNuVcPCh24ZqHotF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On Tue, Jan 14, 2025 at 11:21:13PM -0500, Yury Norov wrote:
> > +static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
> > +				  struct iommufd_hwpt_paging *hwpt_paging,
> > +				  struct iommufd_sw_msi_map *msi_map)
> > +{
> > +	unsigned long iova;
> > +
> > +	lockdep_assert_held(&ictx->sw_msi_lock);
> > +
> > +	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> > +	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
> > +		int rc;
> > +
> > +		rc = iommu_map(hwpt_paging->common.domain, iova,
> > +			       msi_map->msi_addr, PAGE_SIZE,
> > +			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> > +			       GFP_KERNEL_ACCOUNT);
> > +		if (rc)
> > +			return rc;
> > +		set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
> > +	}
> > +	return 0;
> > +}
> 
> So, does sw_msi_lock protect the present_sw_msi bitmap? If so, you
> should use non-atomic __set_bit().

Yes, that is a good point

Thanks,
Jason

