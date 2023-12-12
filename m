Return-Path: <linux-kselftest+bounces-1638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41F80E2B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEEE1C21434
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97B79E0;
	Tue, 12 Dec 2023 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiL/5a9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE74B8F;
	Mon, 11 Dec 2023 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702351439; x=1733887439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gJeVzPu8tSk3XIBqo71gNmayNjPhHDNbxUYTFRNgwi4=;
  b=HiL/5a9KLfCm/Jj2qQt4FG6TFp39E8L3CqaXrJRDz8BzBkkTkVNhxNLz
   SQTSS0x+AFmNY2y3e7+DLqf5dkhfXRCcoApj7eCcNQyMDfaaI/ESgnHgW
   wntY22ii0UOQZimhC6hY6MqmSCriacONrRy4+qvKhc/G2PpX7vvlTgpm7
   DfsE/7PhYqqTV6ToLRARti/PC/nwZipG1rsD1PQYv3mEqaEiWN3KndxQd
   R9GZ9tnpikw3fCVBve2M8wbMPUafAAS/vaka8+uCjolzOVO0/HD3XHTad
   yPkJhfI/msRuVFL6++V5/zc72s+xQRHalpDF1lbdMyJ4QxHHxbEQon/CM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="397532718"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="397532718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839284617"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="839284617"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 19:23:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:23:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 19:23:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 19:23:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+lLmML6qQiHk7EXVKOi7ft7fjLem7sRbsISZJyVpvmVM3YdTHhttdAYiHhnitKtXAT6I824ktk71kF2c/Ps8FIujSbD6e951/74t776k1WZppqgaX+D0qVJSqhbF9ewWsfrjMy6B6Z1/G+f4N6c0sSemRXbn0A4N6kZSnih65p7iYKdCZ/u2Yny/xpl85NrT0YDmq9VX4hsheFazgNcE6R2hxvkJ8L75UVfwDxk0Z9lYZ+RQ8GNYxyGZhID7+CIZWzNB2nxdwDF+2D/xRUGJ326LBKydbY8slEB+E+c5Cd4aGnZfUYNpCffuAH3cAX1hPjB9hjQFgxO+IU4Daw6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlxWSQc0+bahEm2rMjl2eypks1uMvxQkHWAd4yT5pmU=;
 b=c3//tR9wiNZ0pxquTRFtPa8LXK272iwk17zJyJaakgRkvicovk5GUxl8qFySDhVYxSEPx+pYqTrDokAHuwLPJyOm1xKCRdRxlHQjchFdJSG/Cpr8USOvuFoSxj3MTk10EPDeVU2xs39Kjj8LPSNr1OS6QjppzNEIQXnZENXeR35yHoXQHxpuzfI4flTVZqHjfnnmtQ7fUlgHSwNMsaoFFmWPdb5mia/GoTYyn8ybexu3vy9bUXsCb0trU74WNq2FO07RFbyMMByscUeWs7EJViyjWf97+TE+iFWZ1ZBAvc9NQDwqd9jbHf8SJ2oumDgko5eGFTAUTxPypuTst7lXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 03:23:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 03:23:52 +0000
Message-ID: <ccabd500-6b0a-4663-bf63-715bd28aff76@intel.com>
Date: Tue, 12 Dec 2023 11:26:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
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
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
 <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce4ce09-e7bb-4a49-dbf4-08dbfac1c3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UCQPS2gugMiIf2cJYZNL6WeRCoJjheJdhOLda6XSiW6I490itWCUh2k2isL+BEvoql/SaDybxiq06xvlvBpOPTUt3bD0omLwjLeu3qWKb0zFYPdSCqXdJ4K9oFqh534hGpz/lkZyWeoZQm4boXxNgpcrMTwbHIGhoDz24aAsTRamJldC3IiHVX3vQPpbQ5n/7xBhoCzfkMGEicdqcnsrRuYDw/Hw18XhUKUXRD7iLQQKMnBR1yC+7b7/7qYYZmcIuFplBW4KhYTykhZkATbHnrHDTUfsS0DG7uHHw/YAPLXvHAcUtjcwwDgRfvsHGnQPQMzFOg5Vwnqq3yBg1yBONxUkGgYhVn+dU8xASTOL3q4AahWxXqpXo8Zn2ialg0FFu6gKgAARR1zEwzV/zlSFFOVJKppNHZYvwe3mIekkgpDvVDyvHySqfkaYIKn05X6PdrtED1QuA/ZYU6rql/WVbIt0DuvvQPX5lBh2WB9vEKQsU48eedirKLsdS4iNnCkRjKmzStYk8ADkeSA2p/vh1rIrGLDJ6XwT8kSt1eibTZ2Z5/t55vEBMFxcy+2kLybIiULckXfbHYJrBzHePuHaS2kQSXKNo7YW5kXqKZ4y2I86MKENQFt3MI7H+9F8vzUl1xkU29MmXDA/DuvVy5pUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(2906002)(82960400001)(86362001)(7416002)(26005)(38100700002)(31686004)(6506007)(6666004)(5660300002)(6512007)(66476007)(66556008)(66946007)(36756003)(2616005)(8676002)(4326008)(8936002)(53546011)(41300700001)(478600001)(6486002)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lPMk9ialpXZ21BaTF6aEp0SWxUb3YyckViK1BQaGFtcmkreGlyU2N1MWdo?=
 =?utf-8?B?TmI0TEJYekt6Nzg4UkZWRXZyekt2d1BtSllMbFFHdkppMWo0djZQVHZpaSth?=
 =?utf-8?B?Z3BwYXdxN25IRVIyOEdnQ2dxSkFla1V1dXZsS29HMjJMcndYQnltRDV3bWJl?=
 =?utf-8?B?OEJDNFVsZzJmOWliUDdONFM2aGgxbHhONDN3S2tYMExkY0xCWTlLSkhTSG1Z?=
 =?utf-8?B?S01Jak1veXE0Q2lOZ1pjcDlQSFVyOEJIa3dXb0FyOTNvSWNLK1FiaFpuYkNn?=
 =?utf-8?B?TkdlQ3A2U3dFb2xaN1RvNjlyK1RVUVZQQlkzQVVvZVQ4NXdMMHNjTmVFdkZB?=
 =?utf-8?B?MUlQWUJCZHFDVXU2VzJ1eEh1V1c0MjZUZU1CWTdZdklQWEI4QmIxOGNJYjJH?=
 =?utf-8?B?Y0ZmZTExVHJ1bExVeUZaTjVINTJnV2hwY2cxOG95NEM2bFRhOXJqbVRnangx?=
 =?utf-8?B?am9INzcydWRDZm9jRkxpVzdsTDdIREFKNk5NeFVwTnU2SDBuTnkvK250MGNt?=
 =?utf-8?B?TTFKdEtFSGpoY1Q4U1BaMkc1dVJxUGd6RWVYOW9iQ0ZNTjRrOS96ZkpydEFl?=
 =?utf-8?B?KzNHd1Rva1QyUHlIbTlaY1hyQUUxem9lcnNXcURCdnB4RWFFazNYemdmNFo1?=
 =?utf-8?B?MHI0bzl6SFBEOFZjYVBQWVlwSUhSK291bkFFU3drUmVQV1pDVmg3dWd6elFj?=
 =?utf-8?B?cVFYK2YxUzlDMmJCOXJMZ2pzS1E3VmV4Y3hYNnlOa3U1bVV1RWVzTEhSVi95?=
 =?utf-8?B?T1FhY1NVM2FLN2FpdURYWEtGZTljUjVrWURtb2drL0xFTitVajlzWjZUU3Uv?=
 =?utf-8?B?d1ByM2hhTkQyd3pBc0pLSU9OY1JVQzV5eGZLeENPb2QwOXBja3NPZGdIcG13?=
 =?utf-8?B?Vm5ldkxTSGRMdnNOS0JZdnhIRkdHTTREaUVzKzc2R29TWjVJWWxwdllqNkJV?=
 =?utf-8?B?anFKQWhJK1hpT1U4QkYzMHI2bnZmLzdQYjJBb1NTWGpMSkRhQnZwUVRxdVk1?=
 =?utf-8?B?WFFEWnFsTHhkWlN6bEh0amlLWkp1OTV1cHVYdHVxRHRpcUxxeXFGS2xzOWZx?=
 =?utf-8?B?YmhVckQ4cm83TVVJdTZyZm9qVFRIeW4rSlVtNzZvSXAwK3doTXVuNEEzbEJp?=
 =?utf-8?B?STZ5WEptUEQvTVhrYjd6Nm9jQlR0TkRRMXhnSkZPT2tpRDJ3NVdsVG9rR3pP?=
 =?utf-8?B?b2hrMHZ2ZGluWkEvTW44V2kvV2UxM3ZveGhDYzlMaEJOR2NaT2kzbEtNdzc2?=
 =?utf-8?B?aThRV21SSGZzRXdMY3A3c0dBSjF0a0lNS2U2QmZsOElSVy9ibFhxa1ZOS0RH?=
 =?utf-8?B?TllqY2FiR2htWFo0MnZGZytobERyeUVlbG43aUk4QmNkUFN0UzgzRC9weVU3?=
 =?utf-8?B?ZUlCV3lKTWVVNFNENDE4dHV1VW9xbjZNQ2VZcmFPWXVQd1NPakJrYmp6NVlp?=
 =?utf-8?B?Wk5ONENRT2QyUHBmMHQ5czByQm90dUJDTm1HeEhRc2tvSjJ5TTZFSjdZOW9L?=
 =?utf-8?B?RmRadkxtdlZ1Vk9vUzhNRVN0WFl4RngzeGVoTkg2cGh0ajlVTE4vRVEyMXY1?=
 =?utf-8?B?TTVhbldMTXBGNDdNVU5XRytyN3dtek1GRlV0S2NtMURxUFpvL01aZWoya2lt?=
 =?utf-8?B?UzIzanFkd3F1UmhnOG1RalpIZ0FSU1V5SUdXNTY2QUxOOEc4emdtVFpRaHhH?=
 =?utf-8?B?Tjk5TThHNGxMOGMvZ0FlWkxlOXdwcm9NWUJyY3lSYXlKcmJXUldoTXQ1alV1?=
 =?utf-8?B?Ums1Vi80RlZMMURXaTB3Z3RKNzF1RVRFTG01MzFxcklCWjJyMkwvQ1ZndVF2?=
 =?utf-8?B?a1RFeGFWVTlMMzE3eXdtLzFzNEUrZVh3c1c3TzhjRGYzU2NnNW9LamRyMTU2?=
 =?utf-8?B?WWZGYmNsVWNEejZFS3R3Z2NBRGRPWWVWRi9ndG54Vjd0cDFSSkQ1aVpjV3Zi?=
 =?utf-8?B?T3VEMGcvTkhWQ08weEg3eW4vMU1rUkZjLzJ5RnNtazA0cUp4emhYTVcwQ2E5?=
 =?utf-8?B?UE1oVXZCWGZEZXF0bGhERU16Y1VRMkZab0NYSkp6UkZSSnJUQjA2K3JGZXFQ?=
 =?utf-8?B?cXdWNGg4MHdJK0ErODhPNzF2bjl5c2d1YlAxeWxMUUpBN1BaZWZCa1JHK1JB?=
 =?utf-8?Q?SBMBZXp/lEq34sMENRifGLuSU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce4ce09-e7bb-4a49-dbf4-08dbfac1c3a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:23:52.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ROZ/WaQDAHZ/jgsn5fGI8HEbCeFQruo7o0WlCmWVXJT6ho7g/p71bj7JTKsKquIxQbRPyuTg9Dp0Kdh/V79uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com

On 2023/12/12 10:20, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, December 11, 2023 4:08 PM
>>
>> On 2023/12/7 16:47, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Monday, November 27, 2023 2:39 PM
>>>>
>>>> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32
>> flags,
>>>> +				       struct vfio_device_feature_pasid __user
>>>> *arg,
>>>> +				       size_t argsz)
>>>> +{
>>>> +	struct vfio_pci_core_device *vdev =
>>>> +		container_of(device, struct vfio_pci_core_device, vdev);
>>>> +	struct vfio_device_feature_pasid pasid = { 0 };
>>>> +	struct pci_dev *pdev = vdev->pdev;
>>>> +	u32 capabilities = 0;
>>>> +	int ret;
>>>> +
>>>> +	/* We do not support SET of the PASID capability */
>>>
>>> this line alone is meaningless. Please explain the reason e.g. due to
>>> no PASID capability per VF...
>>
>> sure. I think the major reason is we don't allow userspace to change the
>> PASID configuration. is it?
> 
> if only PF it's still possible to develop a model allowing userspace to
> change.
> 
> but with VF this is not possible in concept.

got it.

> 
>>>> +	if (pdev->is_virtfn)
>>>> +		pdev = pci_physfn(pdev);
>>>> +
>>>> +	if (!pdev->pasid_enabled)
>>>> +		goto out;
>>>> +
>>>> +#ifdef CONFIG_PCI_PASID
>>>> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
>>>> +			      &capabilities);
>>>> +#endif
>>>
>>> #ifdef is unnecessary. If CONFIG_PCI_PASID is false pdev->pasid_enabled
>>> won't be set anyway.
>>
>> it's sad that the pdev->pasid_cap is defined under #if CONFIG_PCI_PASID.
>> Perhaps we can have a wrapper for it.
> 
> oh I didn't note it.

If Alex feels better to have a wrapper, we may have one.

>>
>>> and it should read from PCI_PASID_CTRL which indicates whether a
>>> capability is actually enabled.
>>
>> yes, for the EXEC and PRIV capability, needs to check if it's enabled or
>> not before reporting.
>>
>>>
>>>> +/**
>>>> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the
>>>> device.
>>>> + * Zero width means no support for PASID.
>>>
>>> also mention the encoding of this field according to PCIe spec.
>>
>> yes.
>>
>>> or turn it to a plain number field.
>>
>> It is not exact the same as the spec since bit0 is reserved. But
>> here bit0 is used as well.
>>
> 
> what is bit0 used for?

it's just been reserved. No usage is mentioned in the latest spec. I don't
know the background neither.

-- 
Regards,
Yi Liu

