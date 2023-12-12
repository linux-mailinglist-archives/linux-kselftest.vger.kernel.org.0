Return-Path: <linux-kselftest+bounces-1637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3180E261
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B866A282348
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F555248;
	Tue, 12 Dec 2023 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6cJ7lWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C699C;
	Mon, 11 Dec 2023 18:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702349993; x=1733885993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbCoX/9i7wkad1UTB8onFxkCKvtLpRjOfuvvBsRlBPc=;
  b=U6cJ7lWLyHE7mHzKpGmFShafIlAtHtQpq/JWtjHZJW+czXnNjp9Kzj83
   4HhWoi9nGHP/5lEndJyaJJkoj83yei5M8pF37uphh0iaK0wKl+0gUCY2H
   nTxJPBMFO3XAhRtG2y4WfnSxcxiHmk+yoF1nGH/3kIRGrgqW4lMh58hyL
   vVMjM/jS+0+C1UKDbvE05ZfEf5/x5oX4ELdkEe8BMPtcA0mduMkSYRTyd
   lVQUyIbSe3ayjWh7viTayZa/lQi1jnKiFXJ44lMJmy3EEaXMuPUI69YQ1
   w53MaunNEg8Bv5t4qMf1l8XAfIaFrFlDfwA6GRnnxxODYLEQJDpVcxgfL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374903482"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="374903482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="723056551"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="723056551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 18:59:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:59:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:59:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 18:59:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 18:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7RrOt7miIRhw4obk8NvptZ7HZ6J7uhRhQpgKoB4lJb3GGdV7CvwSAd4p6Ri2GnkMUlvvXhbNuPOlct/kosvnhdCsVV8FITbCLB31KW31UCmcsX+W1uEInYW9zXB4Dy+sXQxuBTxFh9P4x9Qke3na3q5/kaPz3dv3A44tORy4BUSHkOLINRbyJTD8HDDDVDRUsqRi+mJX/n6CdihpCF5Anx54yTfJBYtAO7MpRMZWWfyWB+l8vrSDDEda0l6jn3ynJ9aX5UxdMTLJl4uNVPieONXvBzy8SGnrIp57t87BRrnWplrTJprKbKKn1ji49IHRnDpYGtfGQw5zlbInvnw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pzP0OLQJSBdhh+5dVbsvch1y/mtbEJNEOnen06YVDU=;
 b=etbZ28bI5EjYcP1luHV+rReRUfeRlWBCBUm994+CPP4muOEd2X08RyzmTfzdkK4AyfvWkq0ph/OuAknepzNMMV5P4HY4Fu2CtyOYJIAOsc73IBluzdnr88Px7JQ7HGxF147vJ7cUeu8qosTqCkEjqKhiciESkC2PRU8Lii5goNfhMLYe4g2hEv9g7zT1I0M9JHtkVIiTvG/F/lYguZwol+RZKMtdHIpLd01T5d728YFUTDTqRl0Hf1qW8g5Ci9v7oMQUavn8PB8pq/W1Apxi8OqOdtBUr8tZ1kVUUOBzAkbVxg7FQdaPjWIUFvJ4go9ojCG2r/qT0LtxXUh0Fqi6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 02:59:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 02:59:39 +0000
Message-ID: <a5bc36fd-dcbe-4b09-b9e3-90578871f776@intel.com>
Date: Tue, 12 Dec 2023 11:02:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-3-yi.l.liu@intel.com>
 <20231211100501.1c4032ce.alex.williamson@redhat.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231211100501.1c4032ce.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 79492446-7adc-4d44-5915-08dbfabe61dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD9nszyTy9Lik3IS1e3/1YP1mb/Sl8srb31cEjgRVUPbygIJoaQGc+ihvVY+5jTZjj5LcNq6i59043twmo2PyQrOYtZ3BtqaQeKHWcarML+NJJ3d+JJLD4doL8JBFaJLgSokGr5lFQWxAsvuJG2znSObn0a455ZnxEeC+1JkSWdGOkn7+I4NglO/Q2omqCE/UqUAQtTvhnJVn46LahoNFRcpmuW3LhFtKF8Z3fdTfEur+BpdISmOR1pa4/wC1fjfHuIsfoyQfyHA4D9DTGqTWJdyUT6ydrECxHO9/oGiEp93fmJOn/JoX5exx/BaXYL2wAz/S0QX/w3WJdGRufRn+vQaTb0rbGk5scC+yporBarK1RXXZDuDBzd6kPAN4TkRbZB7VxcexWcR6jxmObY0wzMbiNWr4OsAbkpAfSIUsWyHfNXpNvlqTa5My8cog0KQEVFovC3hsW27GH5uNg/pMbQkAIACOEyspMcPza4XLFH3OSRXdlRK/0ydpm3Uagg2zpV2UJOm2Bksg36ME3kokJY33xvnBxK3nPm3I/5N04E9C3mrxIc+yZKUAjh6q9iI8KvgXtOZ+HlVjYRdmgx5/b84l1l9BrgmmNtWDj9GauJq/JapVGsVcCZpkmcEGZxgchfw7au4nXsZrETtUN4hTiIFCRA/sgDEYTVZBp0zJpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(7416002)(2906002)(41300700001)(38100700002)(82960400001)(36756003)(2616005)(31696002)(86362001)(83380400001)(6506007)(26005)(6512007)(6666004)(6486002)(478600001)(53546011)(8676002)(66476007)(4326008)(8936002)(66946007)(6916009)(66556008)(316002)(31686004)(83133001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elloeGFNR2tMeUZKUVJzL0NMNGQ5MkthYTQ1aW5Xckh2aHVUWEdHbkhVRmhQ?=
 =?utf-8?B?enh3SzZwQTBJdUJ5SzdoYnMrb0tGVjdVT0g3dDg4MU1tdzNyR0sxbnBFQU9K?=
 =?utf-8?B?VG9kVmJqK1RmOHB4aXp0RXFDVEhQYlpBUEFJcit3YXdINEgyYUhFV2d3ZFFL?=
 =?utf-8?B?c2hPSzF0OXMreE9xTURpWE9PczV1bzYzM25PTCtCQXF1eDcxbVVuWkhSTWUv?=
 =?utf-8?B?Z29NVzFyaDVlVE0zMTBzSW1YWThTUjZLMFNsZkd6R1hWYnk5WWdJbUJScjBh?=
 =?utf-8?B?ZnNLcjZTV1ZWdmdjNllPR3h4bnhscEl5MUhTYm14V0FndllLN01nbWg1Sm1Z?=
 =?utf-8?B?dzdseTdDU25RUEtPYkhEMDVlMmRQK00zZWlrSE9DMEVqWFdnS2ErSVZRQ2c4?=
 =?utf-8?B?TWFMYWFOWVpZenNnVW15ZUtIWnJPVldScGNSNW45TmpoaHlMTkRBWm9uMDNq?=
 =?utf-8?B?bGt5dkFCVTBCdWw4aXZPZkE3dzhKTWRMWFFwRzB2MUJVOWR1OTVpYTJIZ3Nz?=
 =?utf-8?B?L2FDK2VlTUt2c0ZIaEliY3FaaW1sbTVIQk5yUWJ4emgrUlRvVXo1ZW0xdzdY?=
 =?utf-8?B?S1lKS3ltcHlOSk9EOWpUM3A0ZjZUZzdaUER6MEJkSzRHaWdvMGVvWUVEM1oz?=
 =?utf-8?B?bW5VQU1ZbmlIaWk1djkybVBCUG55YWxUUEUvTXREK1VVYU5RU0w2K0ZkVnE2?=
 =?utf-8?B?OHVlUHRUN0pOYmRrcjlqME9lZ1dlYVlOK1pFb01xNkh1NmRUNWI0SUtlTlFw?=
 =?utf-8?B?Vy9idlN5MmJaQkFDM0x2WEZjVE01Z2xVSmphK3NDREVuWk1TV0oyREpVcU5S?=
 =?utf-8?B?SllXVlo1SzhVVU40bzE2eTlBd2N4clNLbW9JNHU2KzZkZllaY0licFo0YTlk?=
 =?utf-8?B?V0FKSGNVb3MrNndEMEdVTXFpK3Z5SmF1bmduZ3dkZmpWRDlBa3p1VTZPSzlP?=
 =?utf-8?B?a0Z0eDFIT1p2L3pCd0Y4L0hoNlF4c2JnTXBnc05FUGtwM2l2eURMWHVXNlFl?=
 =?utf-8?B?ZFdnR21jR3pPUjRzdjRDVGpTQkNWMVlyRUlIODRhd1g0R1lhbTRDQUQ0Y3kx?=
 =?utf-8?B?T1M2a281S3VzMHhmZnMyK2k2cmp0ZkNKZE1MRkZnWXFOYmt6RlJ0aUFDWk5p?=
 =?utf-8?B?aEY2UnFUWnVWdzZDZjlHVGtZWG9UT1ZTR3ZJRzd3VCtKMCtXNU1zWXBab0Zv?=
 =?utf-8?B?T2QvQXo3N2dkZ0ZFam1Qd2JOb1l2Z1BJVkZhR3lzZDFLSUFVWGxvaDRHWUFE?=
 =?utf-8?B?akVUWURjdjl4a2JPV21zQ2RHa1RleE5KcExoSFYyNE5QSk91TGNDSWRvL2N4?=
 =?utf-8?B?SHIyeDU2SWVibDBLRk9EWnJPM000cmo3eTBJdVlBOTdGa3UvWnptMHExbVhh?=
 =?utf-8?B?RG5MK1BoNUVEdmpTbE1IeklGcTRLMGZwNCthUG1xb0tCRlgvL0l6VTNmemVv?=
 =?utf-8?B?Mlg4Y0d0bDdMRzdqWXVqYjFwamlrNWRjelNjSkw0Y0c1bk4vREdFR090RkhJ?=
 =?utf-8?B?RkY5dUlSaXVRdHgwVnVjWnczWWtlRFI2MFdPbEVEc1YxVHN3d0twZjdUMHZ4?=
 =?utf-8?B?cER0VXVlbDRjUEdRa0N4NkdCZU1jUkcvdWM1Y0YwVXF4dDFxTmRFNFNrN20x?=
 =?utf-8?B?aWI5eElMNGtMSEdpVVJaSlEyRFJ3NkFOaldoT0QyTk5xSkJLZ0F4UW1ZMmVE?=
 =?utf-8?B?SVEyMWlueVoxV0hnbjJYYWJjSG9keEZDdjc4MmRyVlB1MXZIN3FFRVFwYjM0?=
 =?utf-8?B?a01TR0xwNDliVTZWdTlWRXpYbThsbXdxRzV5MWQvVjlyZExPb25GVDlMaHM2?=
 =?utf-8?B?b3lwU0FjakR4S054Z3ZSaE1NQUZNd3BsaDYvS0ExZWl0RW15TkFPY015YjZV?=
 =?utf-8?B?ZHMrZnhwK21MRkViNUNKVldzLzl6Z2JHckVENVJZRFpEVEFXSnhiN0VTUjFU?=
 =?utf-8?B?bTE3c1hTYzgyNDN6OEpvNXZsb1NvN0MvcVNsejhJUnAvQkNvd3kyVFBmRHln?=
 =?utf-8?B?ZFAvenZHUnkxaEFsdXJsVGVTeVEyVmF5V3FDdXlVR09qUFN0WUdMcXZCQWsv?=
 =?utf-8?B?Q2gzM1piM2RKeElDb1dJNDQyMGNaRVpMRGsxMzVVQTczWDlKQTFuaWtscEVn?=
 =?utf-8?Q?y/Y5FkHUE9rF301+RZMrGU8RN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79492446-7adc-4d44-5915-08dbfabe61dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 02:59:39.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaWaHOykDXM0NonHYNXvORpgDn4TNYTjeG6viL+DarBAFBs547/LGhu0vMfJ6aJiwabSXUq9XM6g/2jcGCLonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com

On 2023/12/12 01:05, Alex Williamson wrote:
> On Sun, 26 Nov 2023 22:39:08 -0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> This adds ioctls for the userspace to attach a given pasid of a vfio
>> device to/from an IOAS/HWPT.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/vfio/device_cdev.c | 45 +++++++++++++++++++++++++++++++
>>   drivers/vfio/vfio.h        |  4 +++
>>   drivers/vfio/vfio_main.c   |  8 ++++++
>>   include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 112 insertions(+)
>>
>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> index e75da0a70d1f..c2ac7ed44537 100644
>> --- a/drivers/vfio/device_cdev.c
>> +++ b/drivers/vfio/device_cdev.c
>> @@ -210,6 +210,51 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>>   	return 0;
>>   }
>>   
>> +int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_attach_iommufd_pt __user *arg)
>> +{
>> +	struct vfio_device *device = df->device;
>> +	struct vfio_device_pasid_attach_iommufd_pt attach;
>> +	unsigned long minsz;
>> +	int ret;
>> +
>> +	minsz = offsetofend(struct vfio_device_pasid_attach_iommufd_pt, pt_id);
>> +
>> +	if (copy_from_user(&attach, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (attach.argsz < minsz || attach.flags)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&device->dev_set->lock);
>> +	ret = device->ops->pasid_attach_ioas(device, attach.pasid, &attach.pt_id);
> 
> These callbacks were only implemented for vfio-pci in the previous
> patch but they're called unconditionally.  Thanks,

yes, will correct it and below. thanks for catching it.

> 
> Alex
> 
>> +	mutex_unlock(&device->dev_set->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_detach_iommufd_pt __user *arg)
>> +{
>> +	struct vfio_device *device = df->device;
>> +	struct vfio_device_pasid_detach_iommufd_pt detach;
>> +	unsigned long minsz;
>> +
>> +	minsz = offsetofend(struct vfio_device_pasid_detach_iommufd_pt, flags);
>> +
>> +	if (copy_from_user(&detach, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (detach.argsz < minsz || detach.flags)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&device->dev_set->lock);
>> +	device->ops->pasid_detach_ioas(device, detach.pasid);
>> +	mutex_unlock(&device->dev_set->lock);
>> +
>> +	return 0;
>> +}
>> +
>>   static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
>>   {
>>   	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>> index 307e3f29b527..d228cdb6b345 100644
>> --- a/drivers/vfio/vfio.h
>> +++ b/drivers/vfio/vfio.h
>> @@ -353,6 +353,10 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>>   			    struct vfio_device_attach_iommufd_pt __user *arg);
>>   int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>>   			    struct vfio_device_detach_iommufd_pt __user *arg);
>> +int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_attach_iommufd_pt __user *arg);
>> +int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_detach_iommufd_pt __user *arg);
>>   
>>   #if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
>>   void vfio_init_device_cdev(struct vfio_device *device);
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index 8d4995ada74a..ff50c239873d 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -1240,6 +1240,14 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>>   		case VFIO_DEVICE_DETACH_IOMMUFD_PT:
>>   			ret = vfio_df_ioctl_detach_pt(df, uptr);
>>   			goto out;
>> +
>> +		case VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT:
>> +			ret = vfio_df_ioctl_pasid_attach_pt(df, uptr);
>> +			goto out;
>> +
>> +		case VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT:
>> +			ret = vfio_df_ioctl_pasid_detach_pt(df, uptr);
>> +			goto out;
>>   		}
>>   	}
>>   
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 94b3badefde3..495193629029 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -977,6 +977,61 @@ struct vfio_device_detach_iommufd_pt {
>>   
>>   #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
>>   
>> +/*
>> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 21,
>> + *					      struct vfio_device_pasid_attach_iommufd_pt)
>> + * @argsz:	User filled size of this data.
>> + * @flags:	Must be 0.
>> + * @pasid:	The pasid to be attached.
>> + * @pt_id:	Input the target id which can represent an ioas or a hwpt
>> + *		allocated via iommufd subsystem.
>> + *		Output the input ioas id or the attached hwpt id which could
>> + *		be the specified hwpt itself or a hwpt automatically created
>> + *		for the specified ioas by kernel during the attachment.
>> + *
>> + * Associate a pasid (of a cdev device) with an address space within the
>> + * bound iommufd. Undo by VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd
>> + * close. This is only allowed on cdev fds.
>> + *
>> + * If a pasid is currently attached to a valid hw_pagetable (hwpt), without
>> + * doing a VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT, a second
>> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is
>> + * allowed. This action, also known as a hwpt replacement, will replace the
>> + * pasid's currently attached hwpt with a new hwpt corresponding to the given
>> + * @pt_id.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +struct vfio_device_pasid_attach_iommufd_pt {
>> +	__u32	argsz;
>> +	__u32	flags;
>> +	__u32	pasid;
>> +	__u32	pt_id;
>> +};
>> +
>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 21)
>> +
>> +/*
>> + * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 22,
>> + *					      struct vfio_device_pasid_detach_iommufd_pt)
>> + * @argsz:	User filled size of this data.
>> + * @flags:	Must be 0.
>> + * @pasid:	The pasid to be detached.
>> + *
>> + * Remove the association of a pasid (of a cdev device) and its current
>> + * associated address space.  After it, the pasid of the device should be in
>> + * a blocking DMA state.  This is only allowed on cdev fds.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +struct vfio_device_pasid_detach_iommufd_pt {
>> +	__u32	argsz;
>> +	__u32	flags;
>> +	__u32	pasid;
>> +};
>> +
>> +#define VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
>>   /*
>>    * Provide support for setting a PCI VF Token, which is used as a shared
>>    * secret between PF and VF drivers.  This feature may only be set on a
> 

-- 
Regards,
Yi Liu

