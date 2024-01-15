Return-Path: <linux-kselftest+bounces-2969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B182D646
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 10:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E28B211CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A50DDAF;
	Mon, 15 Jan 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSAb/9F7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B37D275;
	Mon, 15 Jan 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705312018; x=1736848018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b5eLl9cwIoxgrAEzd122Dg4vfhr4YM1AhZA51EmFn4I=;
  b=LSAb/9F7Pkve6zvFJipxzCR0oz+RDaNZcvvffBEnjV4sRs8f14FCNVCc
   Olo63E4Ur9Dz4zLem3Wbz05To7uzp3bjgLt5NhDywAmzJlbVEQz+uzS+I
   WLjsqqsqC0JSi3z1VNIepml49qEJWnfnm+0C9AKQwTQF+8AmbbBn3R5+P
   PwLTReSjWj0FLMOiD8cVt4EA9xAPOHqxXxi476fW9dOgVQylkk2/cvqpq
   qNdGvR1mOj7xzrDPayOtyRu9tLowPUBO7aDjrr0gsl3Ek6pvHidy9nur4
   5KESlJKrLEw8MWKPN7WeIB/Pzt8lONRz9CNff70/Hcqdz1QENW8MQ89ce
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="399251493"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="399251493"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 01:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="853947977"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="853947977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 01:46:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 01:46:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 01:46:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 01:46:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGdtQ4JOVprH5kl6/zOjXXLxkYQ8D2/iEOnGBHNfxmtxQMbpTEidcGKbt9J2/aThtt5wqeRYQ0YoT6glR8bCPt3+VkhzzSdv3ov1HkZvAue/OOiNStqeLzsT8S8hyjOIZEZwUWr1/kburtZu02viHclCwM6dzjMayedsKRDlAd3ez+Eoeq5m1tdu5gsnq+ueEsNh2PPp6+vCCJNZYtTxHnx2Lwcu6X0A4Potf4HzRvpMOujFC4EUd9MLSSp9ZPZ7pL3AWtjlrTG/vkNa87xlRU/cr+5hzR/1ggwU4VvX1QX/KpaIFJ+u3nbk2ENH8pMlrdni9flwQisQ/J09GViggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENNrOLaT8Jmp0NDUE49V//l9EaiX4SvLQYL7RWDaoiA=;
 b=WGN+6aIFoiEl6ofXUk7MA7a3J5Qivd7gHIYORe6SB61fGF8abkxXILnVwNPnb7BYRHO55L0Vf4cfr06JXsrDjat693SU6HcEWjHF2BkzdOTTNEb96efEU5Lv486HdHQDcKxisrR2rQqU5hAz+1zpQm+Q65D4tPQSCfhxfoz6bwWSnJWcbnSlwOlIsKJPDlM6SMFNFsN8VnEdulYzdYatbJ/wX759QZ2/pMrJeXrPlK/NzB4gWy0x/AOerCbRr8zeO0bp9kLpn2yuL31Qs7OUn6gex0DuVEnPAvvXmmvJmjji+DzCm/rH3JR8E10PrDoYoJRQ+WvWiOICUWw0A8EfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 09:46:48 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004%6]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 09:46:48 +0000
Message-ID: <b3e07591-8ebc-4924-85fe-29a46fc73d78@intel.com>
Date: Mon, 15 Jan 2024 17:49:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <20231211181028.GL2944114@nvidia.com>
 <20231211114949.273b21c0.alex.williamson@redhat.com>
 <20231212153504.GL3014157@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231212153504.GL3014157@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 223f64db-2721-49f5-44a6-08dc15aee43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azHLoU/ows5zglcsktW3u5S13saFEuB2tfet6kPemMpFeorlRGzQnTUlwQ2qH1Z2Ds/NPLOkWebczS/Sj0kOIxE7f+4Qp7zgQJ5PzBKesi+tVt14sENoE8doW179XyQYH36iUQYf4WpSAFEMz106NidZ/dqhTX2fzb3S+Fcvt7HqyroQQcBamg0IuwFFeeZCA5rqDAI9OpscjEvYmNIHKBPfnVIr4yj5+QPYqBt8BU6A9LiWMJhkgoCCub4OMMtP5HKwB1vmG+B8ymVBznWDIAwpRgUajU0Ljfp+Geg6nEiRZ2xBbqtsjYlEJ93kT7sZFVdD+PJ/az9WshewEhWGkkjEmxgNOWcfollWLgHNgSaEH0HPcYCBxBZKsQBeG6VRabQaIlr9qc0d6sd3aaQ95m1OkO208L8CjHoDpfWQoREvw7YfIEfX5keBCMnnoDl5jKK/EYM24P7C89STqR9n+NpzOnIN2blLH3xDQLaVi9HI8zQkHVZR3ww9dqgxzNTEZia/drJkQPw5fxw0ZNI7bHUK9FYLMq32azUXVWOSKLFiRLFxjCROt7STWUBr+XXsrYqgZ+fQmjlk/sdoB82m3A4SMBlZV2BzNGqBq/yunJc9vdUHSV0PBarRXlbcrOcpNNja70kZXkPq/q7cWIjHsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(82960400001)(36756003)(41300700001)(66946007)(86362001)(31696002)(38100700002)(6506007)(7416002)(316002)(6512007)(53546011)(2616005)(8676002)(2906002)(6486002)(110136005)(66476007)(8936002)(66556008)(478600001)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmkrZSs2aHJuTTBiSzFXUXlJUUc3eERBaU1FRTg4NUE5a2hiZVdhbUdnV05Q?=
 =?utf-8?B?anp2QkVjTWZDcmpJL09iN1lpd242RUxtck82OHRSR2JJNFpnUi9VRFpxaHgw?=
 =?utf-8?B?Vkc5MDNHNWhmVGJhbXAyeEh5bHpJQVhVYVRDSUxaTmdYRnVIRWZ6QXU5bEov?=
 =?utf-8?B?WEcrUm90QjFYTnRZZFhvdngxZDByZWFGRzlUaFNPOW0wSFFPc3NtWGwvVnRS?=
 =?utf-8?B?N05EdHNWTW1oM1pCMWVlU2RCYW4wYzYycHhKekU0ZzdoN29QOUExMjAvUms0?=
 =?utf-8?B?bXZydThsaW5qM3F4azlNRm5IK1pLb0Q2bjN3SGNTRjVZMDZQYnJPaVdIUnZs?=
 =?utf-8?B?Qnd6R0xCTzJONDVoRzRQcDVqVE4zN3BYSFo1SjNwdXpxVU15eGVYeEF5R091?=
 =?utf-8?B?c1NvSnNtRGFtamk1anlHelYyWVdjTGtNeVhRK21tUitabUpCVk1BVXkxSHdo?=
 =?utf-8?B?QUNEaVFJUm9vZDU3cHRjbVI3SXNDL1VQdlY3OHFxYVBnYXgzT1NIWDc4QXo4?=
 =?utf-8?B?WmJ5RzI2N0dHcG5qNjRZaHRsMjNiZTFmckpxUXRGeW9yZG5qcGZIQmpYS3FC?=
 =?utf-8?B?aDBpbm1UdU00M2lXUHA1Y1hyMjZEemVoNjdxdm9XK3RpQWhVb3c0cHpVZmxa?=
 =?utf-8?B?VkpRY1JLOGFWODVGUkVjV003TzJFUnMxOVIrOFloTEtjcXFJaDkxZGhCMHZN?=
 =?utf-8?B?bGh0NXlGUUtqU0ZlTlRSSG5Qd2lvQkZRWnpFcnAvbDFLbzZXVnZtdHh1ajM3?=
 =?utf-8?B?cDVyeWRjSVBXRnVOWHMxMTF0UEhOZW44ekNpUURVam5haXZWd2c1MnFuR1hw?=
 =?utf-8?B?YW05Wmd4RTQySE5hdkptcXlhSnd5YWR0OU1qVEdwVFlEQ3dsVllPd0lwZWdH?=
 =?utf-8?B?dlBtVkdkeEdUVWgvR3lSUStUMkNQU2w0OXJxdlBCZk4zTmEwM0FBeFdRdEtR?=
 =?utf-8?B?b05uVElid3hQR2tRL0R3cmtsSkVOczliMXZGMU1HbHZRRjI0c0c0RVVxMUl1?=
 =?utf-8?B?RHE4eCtSV0dHZE4yOGpSdWZ0Q01pVGpYa0VYMHVrMm8xc1owQXpnc05DNmdE?=
 =?utf-8?B?MEQvNEl6T04rcDgyQUZlYUNnYTZjelgyLzBTOTAyUWRjT1QwM2hIbnM5eUJJ?=
 =?utf-8?B?NnNCNVpoOUJQaURIYko4L1JOYVdHMC82NXlWd005TlNhUzZNQ1ZOU1NMUFUw?=
 =?utf-8?B?WlZhbWpkYitQS2tCQm4xQXZxS2xidjkxVitJb1Vva2lFTU14cEJ1Wk1kWUF1?=
 =?utf-8?B?RU85bFp3SFpuM1VmVGpLYlNpeTlpS2xzaENYRmd3MThhTU5LNUw5Q0RSZWxE?=
 =?utf-8?B?bGJRYVczcjdJbDNCTmtrNGxOOG9hT21qUnZXdVpoVnNhN0FDZDU0TWhsQ2Z2?=
 =?utf-8?B?bmVsL093ZU5xY01ocE1ZM2s2VlM2WkwyTW5pdFhpNTE4OXR1cjhtMW1wWWtV?=
 =?utf-8?B?aFZ4Y1pmVmRKdzdoV0pSc2QxWmdVVXI5WWVXSk1SUVNRZEFReUtMLzhIRlcx?=
 =?utf-8?B?WFBPWjRJdWRJZ0xDQkdpNzNmTTlVUHlRa2wvY0VtSStmbXd0UHg0aHVnTzh0?=
 =?utf-8?B?bjRLckozZG14TlpRVlRaRVhISU1mTUMzQUpVbkN1RUxWRnVHRVlvZWpjdDNs?=
 =?utf-8?B?T1dJL0grazc0Vmh1MUNXbGhXeWI4T2N0NVBXNDI5R2QxWmRuQ3RiRWNzZXlS?=
 =?utf-8?B?V1FMc3dPeHI5VUJzc0ZKTWtLeFFLMTEwNUhpbHFidE9EQVBNeUtIZWs3R0JO?=
 =?utf-8?B?Z3FUVnB0THYrYjF1YnEyUFZHRlhIT2h6TWNnNE5nRmV3QXdXQVBhVWNVdWJH?=
 =?utf-8?B?bklrT0lpRWtxUGE1MjNLZzhLVjgxMzNXTTdzUFd1bFlhUFVMWkd2L0M1aUpE?=
 =?utf-8?B?bXFqNFdIWFRocjVTb2Z0U1JzNHZUc2lHbURENytzOEYxN3dVVXpmV01OdUdF?=
 =?utf-8?B?L0htSHY1U09LT3F5eFc5dmFDajVFcXBPR3hhU0V3V3hsWmxXbnpuZWhpKzJY?=
 =?utf-8?B?eSs0Q1VpN2M0VXQ0cDl3bnRwbDJGTGVqamladzJ6RnNzVVYzck9GRWRzOG16?=
 =?utf-8?B?dXFzWnhYWk5oak1Tc2ZHZVBJTTBGOUExL29iUUFKQSt0NXMyNExwQ2FpY2tZ?=
 =?utf-8?Q?Fzr0D0dQXdr4ds0OtNiKNqTH5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 223f64db-2721-49f5-44a6-08dc15aee43c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:46:48.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dI8/S0qTus1oFR6i+dsH8c0+0vKaHPvO6usuz2Q8YluXFOh3LgcYUrtvAWGM7TwgDDEuWLwLIWzyvG6Z7maYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com

On 2023/12/12 23:35, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 11:49:49AM -0700, Alex Williamson wrote:
>> On Mon, 11 Dec 2023 14:10:28 -0400
>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>> On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
>>>> On Sun, 26 Nov 2023 22:39:09 -0800
>>>> Yi Liu <yi.l.liu@intel.com> wrote:
>>
>>>>>     the PF). Creating a virtual PASID capability in vfio-pci config space needs
>>>>>     to find a hole to place it, but doing so may require device specific
>>>>>     knowledge to avoid potential conflict with device specific registers like
>>>>>     hiden bits in VF config space. It's simpler by moving this burden to the
>>>>>     VMM instead of maintaining a quirk system in the kernel.
>>>>
>>>> This feels a bit like an incomplete solution though and we might
>>>> already posses device specific knowledge in the form of a variant
>>>> driver.  Should this feature structure include a flag + field that
>>>> could serve to generically indicate to the VMM a location for
>>>> implementing the PASID capability?  The default core implementation
>>>> might fill this only for PFs where clearly an emualted PASID capability
>>>> can overlap the physical capability.  Thanks,
>>>
>>> In many ways I would perfer to solve this for good by having a way to
>>> learn a range of available config space - I liked the suggestion to
>>> use a DVSEC to mark empty space.
>>
>> Yes, DVSEC is the most plausible option for the device itself to convey
>> unused config space, but that requires hardware adoption so presumably
>> we're going to need to fill the gaps with device specific code.  That
>> code might live in a variant driver or in the VMM.  If we have faith
>> that DVSEC is the way, it'd make sense for a variant driver to
>> implement a virtual DVSEC to work out the QEMU implementation and set a
>> precedent.
> 
> How hard do you think it would be for the kernel to synthesize the
> dvsec if the varient driver can provide a range for it?
> 
> On the other hand I'm not so keen on having variant drivers that are
> only doing this just to avoid a table in qemu :\ It seems like a
> reasonable thing to add to existing drivers, though none of them
> support PASID yet..
> 
>> I mostly just want us to recognize that this feature structure also has
>> the possibility to fill this gap and we're consciously passing it over
>> and should maybe formally propose the DVSEC solution and reference it
>> in the commit log or comments here to provide a complete picture.
> 
> You mean by passing an explicit empty range or something in a feature
> IOCTL?

Hi Alex,

Any more suggestion on this? It appears to me that you are fine with PF
to implement the virtual PASID capability in the same offset with physical
PASID capability, while other cases need a way to know where to put the
virtual PASID capability. This may be done by a DVSEC or just pass empty
ranges through the VFIO_DEVICE_FEATURE ioctl?

Regards,
Yi Liu

