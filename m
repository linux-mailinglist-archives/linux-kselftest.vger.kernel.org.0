Return-Path: <linux-kselftest+bounces-3011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0082DE70
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B831281343
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71018028;
	Mon, 15 Jan 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7VSpnIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0417C98;
	Mon, 15 Jan 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0sBPIq5IxTfW2IbhmQAK1Kui28G8nIvQpohBvurr1Em+nFLlWUVGxySiqxn8+/AN6s1O28pihXRc7FhIJQj0RZQr46CejOsH9rblMmd35Lv4XnO2/2MkjzlbqIdBiPWKy83S83yPOZeSgId9/MSjZYNQbfQCMOwphdsNTY+7luRtgzNhkAU12InJwWwXgoTFARQyKwEj3M/QRZydpFbC2xd2MKsWhFV5zDudLmPjtey11I56OKh2wbev65C1MVEBObRtjwhfDT1seKLutgTZ5xdfQg9zppNzYwAXfqRBCG8nrC9jrYhnSHGS4u8NPKP/vHzIoDYG7OoU7gtbZqhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs0RUuM45spVuDsqQfT7j80wtOfF4fNF57FwrMQEufk=;
 b=nluHaDeMDlvjrbHOhsK/6bzJELKPYKjkunOpq7BYqiB/o/9DovXBO4mcheip3rFGyMsjNHhJWTzgErW6LwCO++fFnvKb4kWYNf9aTWaj1/2auCeEop8cWUWChMm/j8GSL3WHKWydDHRQO7sMsP9FMdXroXTysKiNw/0VtDQ3ycOJQLDgFNomFQzopJzrApCFfGlEGC6r8obYRVFVLscwgEHILtKxoW5OXXhVV6+/KQwXrQtCMnlafsxz8auLJFqikzyNgUDXObkfxVKa3IrwIsTANJGUlBjkkigbzEAQIYYAr6w9FoMalIwwK6hNrbvOpiYn/YTt8YRXbid3gKcmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs0RUuM45spVuDsqQfT7j80wtOfF4fNF57FwrMQEufk=;
 b=a7VSpnILKCIWJbeUGRs4CVp6ZJa6CMd6HhqsElWdL1ZyZ+0AG3YBHtWLQisFbIZV3Jd0G/sEQXIC33Evy0KFLfiOVYg7PVjCVBiQPF4Lsy1ONzobE6KXuid2krKQuGdC9NibjkB8CzdiTQEcs4DLPOcb1AJSoVLOxMcZzU0wf42gRQEpIAaqN4H0dMKr2B1htC32vyRlriZLPZgZN9vGY+3G2ighGCy/NDBc4bQzPi1KvT3b2I4SE/1GzFZaCptp2OIpSSsNytl7Ttxl9f2XveOtT/LwclEhaoiYMNgjiExSxyPiM7jCYxzMeKL9zUUHZOzFKyYjs4VPCVASBc2NDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 17:24:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 17:24:31 +0000
Date: Mon, 15 Jan 2024 13:24:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Message-ID: <20240115172430.GN734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063428.127436-4-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: eed8b8bd-a797-436a-9fca-08dc15eed5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kmQm/JNiLVoLUKZBLMtClAO6yYTEkIFZ+D0sBCM8yOEQxZB8uy6wTLhqJR4jaWgh64PldPQ3enG1fcONClhkFB6lDPa5bNBG9/axSz0eztlKzT4y3qENihz7aw4pYWbES+L62cGO2YMkVaZtuqSgT/+1etamLS9Qg38UyeLfYlSfSqAvTpM51zZzESw5gxFUYKTvwoe3EVbdY9siftSEfq+TeRZ8/eGmiFqCWhWt62Z/pNO5wEbtlI5wVPCPWoH+wW/DFlMgTdxOPfXk04C9EzJqdbxak7QkzETtZIDtPom5C7xusCSosINuciabFqOYmnbsiyozK7L91U5Qg9SAMbhXfsskWY3xbryQ6foFviz3jjfAGjFSlMBJstNuHTz7COwLfb8DtyeQMvg8tt/5lJVTjEhJ5zKvs+9Cl+p9URzVndd0ZS1/SUcMJ151bbt5jp8jVZluwJylq0wXh8WENFKqWVpt/UcMedmKBBXXmHqyNiw/s65cTpv4IdWb0Bf21v8v4ZAJIeHpX7+PCjca5leM7xqKmXd3LHN7ElZ18IUEEhui4eXb208m7PRkgPL5F3xAZuReXvMhI+On21nXo0wLGNByv7Hqv+7dMhf6F1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(6506007)(478600001)(6486002)(26005)(1076003)(83380400001)(2616005)(41300700001)(6512007)(5660300002)(7416002)(33656002)(2906002)(38100700002)(66476007)(66946007)(8936002)(66556008)(6916009)(4326008)(316002)(8676002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Od18bQGSlWS5MfZqDokOyyUs15So/74Fga4HNYdaGzJWnr89bKP7pqHBio7l?=
 =?us-ascii?Q?d83BVgV0DwQcllQBQgtMiErh4+jMrq8lwWkYqbmeX1NWcPbkq6kYG7cfW3cs?=
 =?us-ascii?Q?YGGrU/KslY80XZEselTMgXFyHoTv3nRgf+AjRex7SLD56ZSlxHM5u4FBpjI4?=
 =?us-ascii?Q?HOQ6jmhzsUC9V+Jkt96xoiRgM71EX1S6qPXigwg5RMnO4N/l3NAi/sKWWUHk?=
 =?us-ascii?Q?66ylOEX/asnFuuTvWJSL413sUJ3Huz5vrNqQCOqi5p84dkesUchAEluN/p0p?=
 =?us-ascii?Q?60dMNydP0plpL2TS7iiY4HMPMhSQx8lQV6+70/SxXk9Ed/A628LlUcVQFRSm?=
 =?us-ascii?Q?WklcijnXaaiKGMg2JyK4LTIrU2xY00hA08gJqPGodFf9aeFyalD63VmUVxte?=
 =?us-ascii?Q?ANeg7wWyxvcxhNo/v9+Y8ixYAjRZ4rrZyz/hpq7UIHbXDwbhvQgKMVzQ0LCc?=
 =?us-ascii?Q?mZ0jq/TUvlze0DoOf+cKLBgYbsR4kUD6NRRY51QGvLjM2tbDibWHiQhjP/Tj?=
 =?us-ascii?Q?WRyWaqsSeD9J12DzQH8TPqrZLkZqvDH8JJpKNDWCxIHvUz/jQWDshLqZ2vWO?=
 =?us-ascii?Q?bVHf9Q9r1GuT54TDVNTuVwCsNWOL8ie7pQW/PkHX2qsYm5rupYyTa26j2Sz+?=
 =?us-ascii?Q?MR3XZrrbqToinvyX/h1IBAKYSLvC60mgK4FczzDvPJwspMXm9Ao3urUA3Rrk?=
 =?us-ascii?Q?M43/blW1uzpNpTcfIcHKm6fIEpQrDJ5UHF2OrIcdUGQWpcYWh8Pw9hNIjvhD?=
 =?us-ascii?Q?8v8hp6uSxGErA42D/ZdsxKd9WtFDJUUcr7dKNXAU6qtdNnplDeqIiGXxZDRv?=
 =?us-ascii?Q?zBE3CxFnEv9AYB/AXO0fCbTdmT3KhmTk2YKwj+QO5TODS7GUBQTQfuNH9bZw?=
 =?us-ascii?Q?eH3lkrIhVuq6eCbmup8g0ViO62REYKGzwQvvApmEmNlfi48LaG8+VRDul3zs?=
 =?us-ascii?Q?6YXHNhzX556ksEeETu1IPHu2BTpa9jB4bpyCXJQmmkyIwLa+AaPXm+lNPyYQ?=
 =?us-ascii?Q?T+2FMuFYySnVO5HtanE9BYH1QDVgl1aLYUcdrbJxBJU49YTgrVD3iniwuYNs?=
 =?us-ascii?Q?41Rt13WHRbG5gS1bEN9no/E5YcwTKDQyXRtDE5icqlvh0IDbL3BFFkO10gEs?=
 =?us-ascii?Q?rMCbr2GkXbyLQW15LdtPbkKGzv5HyDmgOeb0hI6VfPKCGtQxWfDr4SlmlgPK?=
 =?us-ascii?Q?bYsZF3U87EOsUdRMqqDlMNbG5OZz36/+x8rXsea8gSmAr8IH7CoeHVAf9KeQ?=
 =?us-ascii?Q?QkMZIWRw//HOxTolwWv5eH0Ecd1unAbaGgj9rI8MqQFdLlnFssKT3k5pyaE9?=
 =?us-ascii?Q?5MzSQGp0GWIe0jLcHbZfI3lFZkKs0xUAVizaZlbRv7fz2csDBno3COWoJ4mf?=
 =?us-ascii?Q?2VACSWCtT1HtdygUjVsAqZl1D/zqoo7g5TXZHPUXVJRxWaNnh6JhRXPX3ldn?=
 =?us-ascii?Q?JF9EBXi7UtiR2H7Hn2JTyVUWci4Pr/UQDX3ZL1y/qiyCnPdyBG4OrR2L29DA?=
 =?us-ascii?Q?w+1RtBjk+Bi+qJddOVF+i9bU+w1aiSQ0Jl60xtUHnu+/grSz/aLX3g6lRWfL?=
 =?us-ascii?Q?lLabWIt+1btTAEQkRdV1zbHgdFrN0KAwS//dq0XO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed8b8bd-a797-436a-9fca-08dc15eed5a1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:24:31.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65ZSkGLNsas1XJumnyPFGsED8roHz1DZThMIrS2CMWw3iBM5E1SOKD7apatBBEcY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

On Sun, Nov 26, 2023 at 10:34:23PM -0800, Yi Liu wrote:
> @@ -534,7 +537,17 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
>  		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
>  {
> -	return data->attach_fn(idev, hwpt);
> +	if (data->pasid == IOMMU_PASID_INVALID) {
> +		BUG_ON((data->attach_fn != iommufd_device_do_attach) &&
> +		       (data->attach_fn != iommufd_device_do_replace));
> +		return data->attach_fn(idev, hwpt);
> +	} else {
> +		BUG_ON((data->pasid_attach_fn !=
> +			iommufd_device_pasid_do_attach) &&
> +		       (data->pasid_attach_fn !=
> +			iommufd_device_pasid_do_replace));
> +		return data->pasid_attach_fn(idev, data->pasid, hwpt);
> +	}

Seems like the BUG_ON's are pointless

> +/**
> + * iommufd_device_pasid_detach - Disconnect a {device, pasid} to an iommu_domain
> + * @idev: device to detach
> + * @pasid: pasid to detach
> + *
> + * Undo iommufd_device_pasid_attach(). This disconnects the idev/pasid from
> + * the previously attached pt_id.
> + */
> +void iommufd_device_pasid_detach(struct iommufd_device *idev, u32 pasid)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +
> +	hwpt = xa_load(&idev->pasid_hwpts, pasid);
> +	if (!hwpt)
> +		return;
> +	xa_erase(&idev->pasid_hwpts, pasid);
> +	iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
> +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> +}

None of this xarray stuff looks locked properly

Jason

