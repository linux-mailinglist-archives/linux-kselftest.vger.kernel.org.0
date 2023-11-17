Return-Path: <linux-kselftest+bounces-239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CD7EEC41
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 07:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10CC1C2074B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85ED30E;
	Fri, 17 Nov 2023 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BA6fnwRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342290;
	Thu, 16 Nov 2023 22:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700202553; x=1731738553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fv8Xg2gMFS6lY9BjOOh6T9+0XXMKOt0PLs2V3y0fGLs=;
  b=BA6fnwRUWtAUIWKiy6DbUA7cp9kOt2NGyd4q3mc2aLAtIclK16d1HGru
   lq6s5JvPTW8kWnjz8ZJQ8yw0wcn0D7WX3pln4AmQDrr4ifSurDXWODvH8
   2OaPpvF3i9cLcmEkdCvAj1GIMqAPG5LMQA7EXlXCB2jhSRnM6yH1MjuUr
   28554/cJz2ZO8l20hqD2MtsHIuhV3RmU/sPT7RGJgVndEpU7HaHkUS32h
   D1rauQo9nEq4JpfX5tp7UxtMurkWHY3cGQ9crb1HSFxSnNBW6GyAoeifp
   cMshFa40BsGK3uxcUOP+dKkoAKCqcSN8L3CytFl5BGqI03h4LrqaiTfas
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4327253"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4327253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 22:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="856246862"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="856246862"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 22:29:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 22:29:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 22:29:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 22:29:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjNCtLBU0ELPpN7vlIhDYlbgDW7UE2K2FJxXgqNT7tz2LqDwVEzVk06Y5Gv8zUDBPP2G3xf/SCq20/caMHOfteICV1sDUi3ahF+wUViFlETjcz2+Kz7HGKAra8KFkdAc41lfvnkuqE9YTTD1fV3zjb8ggrJpV7rJy2+Q6QsT6VtrkywK3ibJCv6993Gn/Mbf3q2hDW3dpQLzmyNtR91a0lHgowomQPXlQDQjjGqEYllGUo+Ama31Y6/GZwEXM8EVCXVLNLTAHoh73X+0sROQyY08sI1Mj2g3vqu/fJVJluvGBMjZ9wylP3ytw7Z+Gpj0/rgWxaGb9aDOrdSZtPxxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjm+Kg9DlB5dRooUYDFlvOvVw8CMk076kq1gn7+5Uuc=;
 b=TpPiLiXhAHoxqXE9pB3fWvrjoxmkz3yzeFRlpjuLKQarBJ3c9aaDa8mJpMKLD7i1snoGdDlnRFedUrM0ShMwj2kCRoz/7jQPTl7uLYA8nNCvNBUeoXeJMasaq23In1+yfbnv091b47nixCLrg+iP9r0O+mRcoVxC4wa9Ci8NtMeA0yj1o8JtHmTllwdprK2QFvcNJIrZ6lbvsPILKfVqoqgvUhnaETpIFMs+ifosK8G8sEb8Yupa/Y1I8UX4BS7j06FckcATNaGC+KOjLUQUzLBhxjhem4vzHlhJZwcRPDXv/guvCFq9maSDguDk8VG9K/bUtMSM2CbnpFA2MN490g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Fri, 17 Nov
 2023 06:29:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7002.015; Fri, 17 Nov 2023
 06:29:09 +0000
Message-ID: <b05ee1ed-b8ee-4683-81e7-1cbf780432c3@intel.com>
Date: Fri, 17 Nov 2023 14:31:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Content-Language: en-US
To: "Cao, Yahui" <yahui.cao@intel.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>
CC: <cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, <jacob.e.keller@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-8-yi.l.liu@intel.com>
 <39222f73-35f8-4d05-8772-c6df4c8298ca@intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <39222f73-35f8-4d05-8772-c6df4c8298ca@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: c22589de-51aa-47d3-76ce-08dbe736815b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0XdmsLYJM0G3QJxTG49Gr1aSl3m8POlCiPGBjiRE9fZeeKB8YH0QFdPtfVLP2YRP+byJR2o/ugjn1gSkj6E75I7KNxqQY6uaUtq7MFZFnucPMIojDqDY4O96SV4cQE1HeMhu36B1KXsNaJcN+Idp2D+KP+nmxKkTscHEcKEphFCBxTaZFkD8m8/0rWth+h6mZkkL0rbt9uKwjT5ZSN/tGYqqUmDDc8fcdRZ1v4hp7ODM2++R4XCkDSGKKOtW92AaWMNIFLf5cfn4WGlAlMekf/+lWncYLG2R9XdMeVQVIouDCuGXFLaXhqGLttnoI4YBkagtg9796x9XnpB+MstVPZwZn8oCoJL6gu7UlK43q3YI8nM0jHEpATSlW4C2AiXa8KPe2EG+kjodBWSwW+Xr9htPKCyCkKXb/ccSBaA7kaaEtQoTJ3akoYvNBx48dnYOoWplZiOpvyRXLBn+W7lDA5QepOUuqyXdqp7X7VC9XSDbF624zvEZ16kYg3kntL8KiCxNNH1o1qfKCf5DbRXb/RP/WZE3MCNLHw/j03ypOPTJVgqUhnFHQ3tw+wQ2Ipp3YJ+NabdzCMZuO4h9cBseFWKi7vDXmpGXa8tbBiQiKfD1MDY7PmuauPAbl7wf0NIACdPML78v1pIjm4m/ufY3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(2906002)(478600001)(53546011)(6512007)(6506007)(31696002)(2616005)(6666004)(86362001)(5660300002)(7416002)(316002)(66556008)(66476007)(66946007)(4326008)(8676002)(38100700002)(83380400001)(8936002)(41300700001)(26005)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENVVFJWTTFkeXd5M3JCVnhHU2VlZVZIQldWbEtCeUMxYzVDZkpBd3l1WHZ0?=
 =?utf-8?B?cDJVUWVXTjh5K0g2Zk15V0FZR1NSN2NiSGREWHlaQVZMaFFIR1RtblVwblRk?=
 =?utf-8?B?djBNMDFuaHpwdXpUdmcxUStCVmdsWjlPQTdac01XSGNtRTVLUHl0M0lXZk5L?=
 =?utf-8?B?YjRFVG8zOHg0a04rUndyQWgwZjUrZXZPNXdDM2lUZ1dWVXh0SXhranFKRmQ3?=
 =?utf-8?B?YUxqMC8xa1p2Mmd5T1FWWlQ4VncxUkQ1d09PUmxPUm5paWRscVg5MDV5VWZt?=
 =?utf-8?B?VExSM21CbmVGaDg4ZHc1Uk9VZWVWaGJSRGg5WFpNSmJMaURjblhrZGJFUzh4?=
 =?utf-8?B?Z0RYOW9xUUFDZStJNmFtSVJHWktFR2R6RnBGNXdzeUh6TlA0dTVvTytVaUFy?=
 =?utf-8?B?bjcreDVIN25RRHZhUVV1aEJOeVhnVjkyWDJWM3Y3dnNHL0hmUmJHOEN1ck1a?=
 =?utf-8?B?RmpuYmoxeDdJZDZxb1V2RXV5K2krMTVzNytUTGNoU1ZoZlJuNWVSdHVIcXYx?=
 =?utf-8?B?cnA5Y0dRKzF6RnpsUy8yaGRld0FXMWhpNUEzb3JIUUxxdzJITVNUWENoem9L?=
 =?utf-8?B?bUVYLzFnc2dvTHBueFJzZFV0d2NoTDB0MGMzeHFtQklORVFVYVNlalp5RUZx?=
 =?utf-8?B?YlVFbkRzYTVBa1BCNVJaN2dBZEVGTDh5UWRteWxjeURWZXBzU0VxUXZVMFph?=
 =?utf-8?B?VXRZc1J0dk0yWWVGcERlRDIvWnV5bFkxbVk2K1VXS2ZDYldjTVdpWjVVRFJu?=
 =?utf-8?B?RjRlR0pkZ2Z2bS9nbm9LYkF4WHJHdE5NMHNzbS9nN3pHN2EzUHIzRHN0dzZH?=
 =?utf-8?B?T0VjVVpkOVBKWnVrY3Rpd0FyMUdZZnpMMlIwNkV0SVd1MEJlWDRMNFNlTlFi?=
 =?utf-8?B?U1p1MmY4VFhtdzdwQ0k4TE9tbWNtTWs0ZUNWZVphekZyMHQvRXp5UklLclYx?=
 =?utf-8?B?UHRTejRucXNnODh5SHhaN3ZOMkxhbmdiWldSNUF1blB6ZXRrbGgzbWJBOFVK?=
 =?utf-8?B?QVJ0YllTRDN6V1hFQTBjbVFKMlZHNGphYS9CNWpia2lJbU1QRjVkcUxRRFFH?=
 =?utf-8?B?cVZwZnFmam1EYXkwQUJZdDhDeEEyaUU2TGhVb1ROWERqYnVUZ0tIbyt1NU1T?=
 =?utf-8?B?am1TcDBJL1JzMFdjdTlSeDhzaEg5dWNBYlZTSGU0RW1JU0ZLc3VCNm1EdUZo?=
 =?utf-8?B?ZlV0TkRaUXVmOExpSHRKc0pRTEtGNGlCd2w4WmVUbWh0azhBa3prNjlxbDJa?=
 =?utf-8?B?K0RxQW9ZNDJ2OXV0SDRjZFRUQXp2M2FzV1R0MC8vRFlMSlpzaFFHOTVEOXU0?=
 =?utf-8?B?cTJrcSs4YzJkSkxIWHlTR3kzWnN1TXh3VCtiQllSR2k0RTdFbFA4QUd5Wlp6?=
 =?utf-8?B?NUV3K0lxRDBrcEdOTGQybUJBZ1lkeXd1ZHovRXV4VXVZTmU5bmt5NUVCV0lN?=
 =?utf-8?B?MnE5THZqbkMrbVoyMXYwSTczekRoQ1dZU2ZFWWpwcUdWSHY3dXFPSmxkZk5U?=
 =?utf-8?B?djBBUTNRaGlKMlYydVNxYm9qTXh0MmpYZ2E1TjcvZzEzNkVpb21Tdktib241?=
 =?utf-8?B?T1Z4bWVJalhFU1E5MlpoaThqdHk4bzZKR3FvNklZdkJhVVNTM3QyczlNZTFn?=
 =?utf-8?B?MXFaODNub1FPSnVrU3h2L1lLRzBJZFIrcS85V2U4Y3RSNkkyTUNEdEZRS1NV?=
 =?utf-8?B?Q0JmSDF6OXJwOFdrNlp5UkgrVWFJdXZ1em9Zc2FHMmI0MFRJYWJHK0JIUWZT?=
 =?utf-8?B?TnFDb1JTdjBELzFHcXcxc2l2TkFEd3oxa3VKeUxadVRlcGtwUWg4Y0Z3ajdn?=
 =?utf-8?B?bWsrNCt4WmpYTytvb25SVEZTM1lPTWNqMG5OZDl1aXM2azZiekkra1RLU1Ju?=
 =?utf-8?B?NEdhU1JqMlgxYUNZNWQxNnBtVTNmQVh0RWFmK2hyYVpNanlScHBXd0RidXB3?=
 =?utf-8?B?N0svWXdWMUsraUtXbVpONDk2QlRnTUdVdmsyZVREeTA1ajl2aXcxM2NqN3VZ?=
 =?utf-8?B?OFV1S1U2eE1ENDZ2T0MyVUU4b0YrT2VEalhVNVZMSmNXcWxvclBYTFNDRTQ5?=
 =?utf-8?B?dTA0OUx5OFNEenU0aVBJdXNIblYzckNxNnBKUFlMNHVTL3hLbGR2RkJ1T0xz?=
 =?utf-8?Q?nmDkmJeurgasuXAYf8EutZVKJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c22589de-51aa-47d3-76ce-08dbe736815b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 06:29:09.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdPAXOeyhcdvYMhoUajW3fomBPbFEulaRPpw3DIpjVkhvwto7L+MGNOrxTmtGzbYp449Wkw3aERDZn9Jb/791w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com

On 2023/11/16 13:35, Cao, Yahui wrote:
> 
> On 10/9/2023 4:51 PM, Yi Liu wrote:
>> From: Kevin Tian <kevin.tian@intel.com>
>>
>> This adds vfio_register_pasid_iommu_dev() for device driver to register
>> virtual devices which are isolated per PASID in physical IOMMU. The major
>> usage is for the SIOV devices which allows device driver to tag the DMAs
>> out of virtual devices within it with different PASIDs.
>>
>> For a given vfio device, VFIO core creates both group user interface and
>> device user interface (device cdev) if configured. However, for the virtual
>> devices backed by PASID of the device, VFIO core shall only create device
>> user interface as there is no plan to support such devices in the legacy
>> vfio_iommu drivers which is a must if creating group user interface for
>> such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
>> the device driver to register PASID virtual devices, and provides a wrapper
>> API for it. In particular no iommu group (neither fake group or real group)
>> exists per PASID, hence no group interface for this type.
>>
>> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>
>> +/*
>> + * Register a virtual device with IOMMU pasid protection. The user of
>> + * this device can trigger DMA as long as all of its outgoing DMAs are
>> + * always tagged with a pasid.
>> + */
>> +int vfio_register_pasid_iommu_dev(struct vfio_device *device)
>> +{
>> +    return __vfio_register_dev(device, VFIO_PASID_IOMMU);
>> +}
>> +
> 
> If CONFIG_VFIO_GROUP kconfig is selected, then there will be access to 
> vdev->group shown as below
> ->__vfio_register_dev()
>         ->vfio_device_add()
>              ->vfio_device_is_noiommu() { return 
> IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->group->type == VFIO_NO_IOMMU}
> 
> For SIOV virtual devices, vfio group is not created and vfio cdev is used. 
> Thus vdev->group is NULL and there is NULL pointer access here.
> 

yes. needs to be like below:

return IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->group && vdev->group->type 
== VFIO_NO_IOMMU;

-- 
Regards,
Yi Liu

