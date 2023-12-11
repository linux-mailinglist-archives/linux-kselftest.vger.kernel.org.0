Return-Path: <linux-kselftest+bounces-1499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452CF80C251
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA161C208D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE5208C9;
	Mon, 11 Dec 2023 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqG7ObbX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9750F2;
	Sun, 10 Dec 2023 23:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702280801; x=1733816801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w41zHNaKen+/XFr5huVy8uco+fENi3FdoUGL+CrUBzk=;
  b=dqG7ObbXeeUc7OxPx5mgX5t61CQoqEO91kAahVu0yZPOI4HClakbXX9n
   2d7ESZAjg4EnIncurppeLLSj0se8zsfLGvsQ4zogt9B72jxxx1Zl+BtRD
   pIQQxidNxX4oVPiyt6Vhl41D6ezEl7EXzjZy2lYEtCg51tXTiyRRuCRY3
   lRudjG69wSXYn8sUoa9ZbSO1sbIh5ILyT6T8rkdzuLLiUzCC3Gkcauzi3
   pcUbq8KrtLN2QVHyBq7uabiQvDlK3cHn4j72j/bHisf4RyBYZPi9CwIr1
   mPr1Ojf497QPoCwTiYsY1CeIAa/4BHknuJt4oI7nUyK9kcy7D/hdBEIgn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1418610"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1418610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807201018"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="807201018"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 23:46:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:46:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 23:46:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 23:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efyoscyY1yxfW6ToDtC3CHtZY7yuEtw6KTlc0zdUL8E5ALNPiMuEU9txkupbLmB+2Y5MdTVHp9JQzN/+5hnC4GLoqS9A9K7LyDE8sr8EsqF/JWNY8kkCXLyfgCyecurXdku37diVAgMCxUla1oxkvoBt92wKG1QeNNryQrzk8P/5cbb5gobn8OfftfdGUyJcTIEJl7c8tWPJKD3/8XymVKmmdH7PQ++XhkwAvpym99WgHf336q2ivMjO1cYJGJaxsOqEYqh9zNORPHd6s5ezNgTnen9pWYH9b1EZ2jEvxyhDss3VCbiKkATrCOYvsPuMAo/iMdz3wK3tk4iVCh7JIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGzfHPmU8QrJZ4OILgM9hWUw/Q0I2fhD4dUheLEywcQ=;
 b=Wyui94z+rxs4tYwZx+CMCInEZ7gdm9GOzQThcvOar8fd1/Ghg/gvZGYuv1Xr5xbw4zEo2IOWkMtGvQiliqeFAmJKAh+K9KJtJUa65V4Kllo/ItF8Wx2+nZrRFApQR9/Z/knDpjxb7lW33o66d+wGpPDfnIYajtKzfuUP7UAsynUFSVyw8ugdMMOj3WqHm0nwzfV4GXvml0+FAttwu/lYo/coaHdcpeJhUlTw0cQZ/VOQxBUtnKOFmkLoJR2OT29CVrpT2/NudusA2lt9tY/a4mGdkIgmeokwbb28M2mw7MfE8y5wX1kyYgUQ5JPXKvzp+LGO7Jg/c0nDL6XcqP3qBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 07:46:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 07:46:36 +0000
Message-ID: <eb4394b1-66d1-40ae-9d40-fb517ce18b6e@intel.com>
Date: Mon, 11 Dec 2023 15:49:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: c6161b05-cc59-4559-ca8d-08dbfa1d4cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMCq7xBjnH8LJt+JT1Uxf8NxB5bbuB8zrMxrxH2ZtVFqpzrCu/AzFs4NODjkRd/YmrexgHXhO+Zt+HwCcK+/0i42eqJRO0qRRZj83daYAjfokFvNHIwPI7Mnsvb0xdY0CiDp5b0I1Zx4RiOD7DF+y/vq1yR7r+9l702a6oxyK44aAV3+RX5dKmT4C6RV9vC0opL9C2wqb55hfWZDVtyVJBAbgaVdE6RcUJi0uxB0G8PcpuVccgJseoNn4iGGgN7IGgukC+iqHkMm/AMKZZL9CD3MVjWoAu/mx+UPeU7/N6a8Rh5RjhnWUTWNkqlWmRMS1mHiNVeaK6F/KBfDIx6Sj3SaQD7UQ8002ES430MPE3szuutm+T/4rmpACBEupqi4TZ42nXb0IAaGjChadGQMwwXc4RBDuOw47ugBUdkm7ldREvIu8mEAaxueQpTYHHOrkx6/5wuKkM810GhiCh5qc+e5acdJ4XyTbU2Ut7G6YjUkv/QDTVNvOoSamEVB9dzVp1AZuy40meecZQWRl/Jov6bxMvMVjNeYZ80nagV99s3Di0c1BApWNKcDpPMIlPL1MljgiO4W6JBwE9VE1pupu0nVwzCopfId/+46DkVEAKB56O/FbYhLNs0JjUUQ0k3tP0GBi06uTwht3sg0xeZIcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2616005)(26005)(83380400001)(82960400001)(36756003)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6666004)(6512007)(6506007)(53546011)(66946007)(66556008)(66476007)(54906003)(110136005)(478600001)(6486002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y08vSTRRMWtMVGFWYjI0UnJVRWowYmR0NlRmRHc4SWhBU2hKVC94cXk5MjE1?=
 =?utf-8?B?WER6azUxU1laZEg3aXZoUmZjenV4ZllVR3FaUFlVZkJ0Z0N1b1RUbVFsb0pQ?=
 =?utf-8?B?VUlWYjRmU0ZNaVpQSzIzR2w4TkFwRFZEVG14d2o1OHlabDVZTE4wTnFzWlRW?=
 =?utf-8?B?WGYyRllTWk10RGFJRGJ3NXB5UlFrZnNxUG5xQmZnYXg1K0FUT0Evb0RIamFI?=
 =?utf-8?B?QUVsVktmakdZRzVVNVhUQ3RUb3I5TExOQytoN3N5TmFZZjdqemdNTCs3WVZJ?=
 =?utf-8?B?eUgzRnRoKzM3VDdZU2gzVGR5Qm0xL0NFam1rd2hpYzEyQU9IWGs2dk5ZTUxX?=
 =?utf-8?B?N25FVDZPV2ZWdXN2WHRQOTRzSU1DTUxuN1ZqbmxqbnV2K3N0d2JNS3ZTbHJs?=
 =?utf-8?B?bzY5ZmhvRDdYbUlNRTgxWFZuZFdRdXNkV0JoSGtyNi9pcEpaT1h0TEtKT3dw?=
 =?utf-8?B?dnVISWhZOWRJSFFOenlrZmJvL2RjQTZ1SHpYNjV5ZWpBZldaWjhPRFVxQjlE?=
 =?utf-8?B?OFh1dFQ2MFBZVkp4M0NPaFhWNjR2MGR1bExnbktqaDk1QWpSWmRqVHBjZ05Y?=
 =?utf-8?B?R2pTM0NZdmN4L1pvSDNGaVAyZ1l3VXFLdktuNTdYS1I5T2tnbmhhdUp5djIx?=
 =?utf-8?B?R3Z0a3hyUjRYS3U1VGdjVGxnYytLQmdic3NsclU3Vyt1Q0xqdkdBVm5EVUZy?=
 =?utf-8?B?YVhKRWFlaVN6S3pFYnNRck11Ukh6Z0RzVy9yb3JCVk0rc0ZrYk4wdGZTQjls?=
 =?utf-8?B?cXpuMHp0THRnZlU4a09taVlINmlneUtnQU5mcm9wK1prbDFKS3I4TGhuOFNF?=
 =?utf-8?B?UU1keUhYMndNandSZC9ZQ2Q1bjgxZTBtbVFTOU5PdmtKTC9WSTBBV0JLWnlB?=
 =?utf-8?B?VytZVGJHVGV5T0JKUzFFNWhpcnhCNVJ3eUh4eWJlLzkyamZBQVl0NUZRTUZ4?=
 =?utf-8?B?UFhoaWQvUFhUcm14d0NoWlMwTVBUd3NNQkJaZFlDOVdQZTJtQVVFUFRjcWVC?=
 =?utf-8?B?MTRUUE5RUkYrNG04ZWJGcWdDVTRLZjdjcDRFL0RvOEZTd09XTG1tWm1NQytn?=
 =?utf-8?B?VllYY1Z3KytQNVZHZHNqWmUzajI2RTAvdDR5VXVPYTYvMUxsam9vMlRESkpG?=
 =?utf-8?B?Myt1bEwwMEI1VzR5N0tPMERaZTREMlJyUWM4TFJrbjNQekVXTWMyMGNBdlFQ?=
 =?utf-8?B?T0hvRXkxN2VpNEM0eVpycFNRT2tGRE1sTlN2R3RrcWRxbitvbktNN0hYenZU?=
 =?utf-8?B?RzM5WVpWT3AwUzdGMzV1cEp5R3YvZzJINjU0VFRCNmY3ajgrRGJ5UWY1QXlK?=
 =?utf-8?B?d3E4NVBWOUJZSjdWUTdSU0hkcG85WGxOb3FaRitzc0M3L0hxUVZlT0RsTHUr?=
 =?utf-8?B?aVFFZU1vblBYZGo4MW5teXRsb2t0TGdneHNML083MEZ2Q1hiZm9WdjVDOW5D?=
 =?utf-8?B?K2EwWFlwMUNmaGVORDZZQ0h6Y01CU09yYlhLUkllYndXMnJDbGRoSHFtWmJP?=
 =?utf-8?B?L0x3dXFxS1lvdmNNUEx6WTdiY054RE4vL1daQnd5QlNUK0RyZ09MMmlyMjdB?=
 =?utf-8?B?VWJxUytiRGdkR2wvNGxKdXl0Q3BPYnAraTdoTllZZjYrQXlNNnF0djd4Ylpj?=
 =?utf-8?B?Q2lvZHVYU2t5MitPNWhKdDMyNXVnY0czMk83THR4ZUpVbDdQUU0ra1AxTUU4?=
 =?utf-8?B?QjVIRmorYlVMSWdEcjJuVEpPT0xOY1VKdEFhZE41Zm9ENmVmY2JRVzJ6QVZN?=
 =?utf-8?B?eC9NZnVVdy9MMEdMK2g4cTdlZkhzMlljNjQxV0lld01GREZURmdRNUZIbEMx?=
 =?utf-8?B?NDFWbmxoWHFaUjQ4d1RZNUtFcHNXUWo1clFocFBjUlRBYnFpVno5TFZNZHFy?=
 =?utf-8?B?c0gyMG1NM05IekNSUDJ0U0xUbWYrNnozdnBxTTdqTzJQMHlEQkxWeHZNdDgv?=
 =?utf-8?B?VmdZMnUweVVRNGt0NHQ2VEY5VXlqYm0vMjR2VkVLMVVvQVJ3Z2ZxY1duNUNo?=
 =?utf-8?B?RGZDT3RaRDMyTkZXVHg1SW9naVh1SGNDTlRLbUdsTVdteTFMUTVRMTQzVzZl?=
 =?utf-8?B?Vyt6bDdZeDdvcUpYV2VKQ0xKeHNLUGJZWCtmS25SS1Z0RnpoYWFBbDJuMGpZ?=
 =?utf-8?Q?q4k73Lv7Zp0Z9gylh7078R4Mf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6161b05-cc59-4559-ca8d-08dbfa1d4cdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 07:46:36.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcDlJfr1mdPq/odDjXZJx0Vrn1p7oBtnWxLLuIWsxpf6enZmAhcABdjqyACNfSvnQaOrXF631IubY9eny5u7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com

On 2023/12/7 17:04, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 7, 2023 2:59 PM
>>
>> On 2023/11/17 21:07, Yi Liu wrote:
>>> @@ -613,4 +614,38 @@ struct iommu_hwpt_get_dirty_bitmap {
>>>    #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
>>>
>> 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
>>>
>>> +/**
>>> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>>> + * @size: sizeof(struct iommu_hwpt_invalidate)
>>> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
>>> + * @reqs_uptr: User pointer to an array having @req_num of cache
>> invalidation
>>> + *             requests. The request entries in the array are of fixed width
>>> + *             @req_len, and contain a user data structure for invalidation
>>> + *             request specific to the given hardware page table.
>>> + * @req_type: One of enum iommu_hwpt_data_type, defining the data
>> type of all
>>> + *            the entries in the invalidation request array. It should suit
>>> + *            with the data_type passed per the allocation of the hwpt pointed
>>> + *            by @hwpt_id.
>>
>> @Jason and Kevin,
>>
>> Here a check with you two. I had a conversation with Nic on the definition
>> of req_type here. It was added to support potential multiple kinds of cache
>> invalidation data types for a invalidating cache for a single hwpt type[1].
>> But we defined it as reusing the hwpt_data_type. In this way, it is not
>> able to support the potential case in[1]. is it? Shall we define a separate
>> enum for invalidation data types? And how can we let user know the
>> available invalidation data types for a hwpt type? Any idea?
>>
>> [1] https://lore.kernel.org/linux-
>> iommu/20231018163720.GA3952@nvidia.com/
>>
> 
>  From that thread Jason mentioned to make the invalidation format
> part of domain allocation. If that is the direction to go then there
> won't be multiple invalidation formats per hwpt. The user should
> create multiple hwpt's per invalidation format (though mixing
> formats in one virtual platform is very unlikely)?

yes, following that, the hwpt data type would be a kind of a combination
of page table type and cache invalidation type. In this way, the req_type
may also be dropped as the hwpt allocation path can record the type and
reuse it in the cache invalidation path.

-- 
Regards,
Yi Liu

