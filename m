Return-Path: <linux-kselftest+bounces-1500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33380C260
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 08:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9331F20F25
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B1208D3;
	Mon, 11 Dec 2023 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCE85rkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE5BE;
	Sun, 10 Dec 2023 23:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702281075; x=1733817075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FPC/opT4BF9L9nzybPhZlCldZF/StvfJa+ySi1uBxFY=;
  b=BCE85rkJ82VLA8lSqIbpAFWW0ytR/5bH99QwySYysPs7WatYiuHF6DsZ
   HEuN4+fXpfVpg1zaee/C+JCuPaiwswGjl6weHjrKEw98q/N/pxOFPRZcV
   jbiiVQOMhaL0tEnjBCtEXJ0Zq4UP9iN/GKDZpdLZOcPlkxrUGgEwoV7e9
   S5bIOq07Wrpu+qZiNFqYFd//EMEgXSij6nSzFfDqb+AfHthoCOaY9GthT
   xKVsMiv9Uv2GRv6aFVMraSVHrhAplGHlk0OuxfLdbgsk92YtjC0fduRTm
   RZXpzqMYC1IUMY9/L4sHytQKhzRuw0mGsdNkoZIUzEI5h6cn8Bgv35zsM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393474625"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="393474625"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1020146090"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1020146090"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 23:51:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:51:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:51:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 23:51:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 23:51:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9D6MWimoXkn7ovthK8+eJ35bBXxaieFg8cxeR1XFvuqMljwCzW9eXXmKeRfRUjvbZMffJGupf2rIY7SBPxvgJuEDzsOVSVAf/SFkd9KFVBIZqTzchkbVCKppGJuBNyvkpI7XOZaacKQADSDp76SgiAJ2s8FpM2lKlRb2Hzk4ZuMeMXzHAq77ppLugW4c8oFsFNp0KFfggp9XZqlNMncLqjJzJV8OGfCdIez8YxB/QQ/j4Vu2irqNRYn1SI7BzrcT+mS+pfr/3KFiF6dYftEGHoL/oZutxRJO8motV/vp6sJ5VuOYWUQvHr9QGcCMyR77v1kkFoHRQIgUutFymf4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7hOYzkBiRCROJUabJ3OsSsbUMEIcm4DmZHuZcvUMJw=;
 b=H4Pqz/zUSd/6G8QoVjzNHPq3WR6vFUTgjfBJxCy2W9cWybXnk7CLk0zZJgk1REzq7rpfzPPCcAHs38R+T4rQeJZaol3fh17wKSo6X6IAtQBWkiUq3+nUbSBhNMQdl6DbApmcCZxF1B48S/aRAsYsyVyJA+fvuBWrb13C6fOornAS+wBzU8aIXH6tRTHThX+7BB9MIctUZTD4gxvS7l8XISUyiaRMQMFJOyvR0BBwz/6U11FKp4z6/Ck/cVURT1PUohjzIpUeCsqVJUf2/m7IWv9Dbv6+R3M2ar3X09jS0dA2MabM8yeGUiB16mGPdqzA6FsdJ8SP2vN5Q0tfp3UY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 07:51:07 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 07:51:07 +0000
Message-ID: <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
Date: Mon, 11 Dec 2023 15:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
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
 <20231207144208.GJ2692119@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231207144208.GJ2692119@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 632767f8-25ae-461a-e147-08dbfa1deee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51Z4HC9SZaxvRHtulM5VTXKzI4BdGlTxmnIfPnxeXTC6f7xA10i2PBvjpDoh4W+JzUteAub0LZMlcJOe8gLtk9HcdiOS7sdx3wRtZKvZbNFC8fNa/c/wpQ51tF12zc9H5N1beqYzbnqCuF68kkA8jMJPuh/kexqjK/jGvpyIsRYevs/JTscifyiPvYyE1kHSOTHtQZqtxDF61FRAaBL0+OeRFefq47wE8YsSpqdzSKJ399mryqu5jz9ChurjYPa5Eb763rGhr2G/n2JeeHCwg/0J9ydzjvU6/9DHJVvZwVTlFZGiHNy07B3MHVJOEN6mPLb69wzKSil4G5PFLnXQbyr2fHwHlgvIu43O+VU/sLm5fMKpsbqZoyo8ffeZKiK7KfJlvp+dvv3jS+Wxz+4tl6ctlUAfzkUSIihdAJEXDNejgQqL+zqgwLCFPKWSFETC/KMJSC+7ijHjSj4rqzXXP3tnZclR38LTKo0xrrItgJmf8o51RgoSsQzLGRfRxZF0sZ7MuujmBIoB7kTjn1ViHbwGlNn5MCzQry4cxiS9h7FUni6h+FCmufAphiMVGd/tYuEj/mp1AL4dkvkZXcHp0hJWLHhY3NepWgjp/PxBJ2S5r3DrrxDgZNey0Fq4hrm6V5zvEoLLD27WIW8SNekbfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2616005)(26005)(83380400001)(82960400001)(36756003)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6666004)(6512007)(6506007)(53546011)(6636002)(66946007)(66556008)(66476007)(54906003)(110136005)(478600001)(6486002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNINW5uNmxZYUo3T0M2dE1RNnlaNjlHZCt0SzNlb0p1cC82amxVQzVGSzFT?=
 =?utf-8?B?Q1o1cDR4djZmbERXUTE3dVFDRVJ4QXhYSE13c3BaZTlTVFVmcjNmMi94SEg0?=
 =?utf-8?B?QWlTSWRVUVJpaTJBeFVKWE1rTVlOY1dmbm9xN24yRGdOS3RzZDVLajdsMFRL?=
 =?utf-8?B?bVJOcWhMamhWcDJwdjdRcEx1T3NIdmZyS04yWlpJSEpyVEFqKy9xNXlRZjVK?=
 =?utf-8?B?RE1NS1hXODNuVkVJL0NmZi9mTHI1V2xwanRGcjFQWkRlN2dxM1hZS2xOeHFk?=
 =?utf-8?B?eUZHNFR5TFozdnJYSElpLzhTTzA0TWY4SjBjRWkyRkFoSDlqUDFrU1VPUmxS?=
 =?utf-8?B?RUJvRGNUMCtncWphUXZyTWJoUkZralMyL1hzNW5JcGZXWTVDWVlXMkF6eEV4?=
 =?utf-8?B?RzAxQ1p6c1cxMHVvbCt4ck5Od25uUEpxcUUxTVdSL3pqMzV6K0lGdFhZV3RR?=
 =?utf-8?B?VFlHWmVXK05zS1l4TXg1OVFUUXZFSXE5bkZGZndnZTd1SGhwOGJhUEJ3SnRw?=
 =?utf-8?B?TDZqa2pDRVkxU2ZQSlE4eWVwejhuRUFTTDB2c05oVHVuK3pKaVFFS21oNlp6?=
 =?utf-8?B?TTNCRnJxVGJYcEJGMmVPYkduTVRVQ0RCc3hiNEFKWm8wNjh3VENoWml2Ynhu?=
 =?utf-8?B?WVlkSFp6MTVrdlhhQ3FPOW00eGJTV1hsdS85V2FHWXZrNlZ6c0Fnb212b09Y?=
 =?utf-8?B?VVc0YmZmM1dWbkFLbW9CZ0ZPS1ZuSFBtNVNpYVFUQkVWeWMySDZDSktiYU1N?=
 =?utf-8?B?VWxWSFlKYnJYMUFZeE00NW1IcDhzM0hLOUNaNnhSbnF0SlBvaFd2UDFTeHRk?=
 =?utf-8?B?eHpzWTJIbDYyN25peGYwU0MzQ3gycWMwa2l5ZVZleG9LbXdITXdWNk1aM1c4?=
 =?utf-8?B?N1V4WklqUnhWcTg2V285dCtKZUhPVk13akNseitXVGlSS1BQd3JqSUgxS1VY?=
 =?utf-8?B?Nzg2Tk9kM05mWnFvTEFBQzVObjNWZkJUajgrSTNUK3duSHdMYmdROTlCdmU1?=
 =?utf-8?B?MzRySHAwejMyYnZiQVBXdHk4V2xQSGZ1dmV3KzdQTWJzZTJxMXhtZnBwSy9u?=
 =?utf-8?B?UWI5OHpGZExjdzhEZFFEaE1NK3o3N3hGOFNiVDExMngvNW1JalQ2RC9XYm1L?=
 =?utf-8?B?THlVV21PR0o3SHNrOTMzdG5MdzFiNW5iempFb3B6Q0FONklJbk1zUlI5cUtO?=
 =?utf-8?B?OEUvZS9CZDZNc0FFRmx0cERoRHBidkYxdVdYY2E5U2huMEZEWDZvRmdjenJI?=
 =?utf-8?B?Qng4bHc4cDUvZEFEWDNRelpsTUxnZlFsTU45L0hPWFFGdGhxZzBZajBieDhY?=
 =?utf-8?B?c0ZaM2JoL3hDdzBuNVJpeG9xRk1MTkRNV2dwMklzWWVzNW8rS0VRc09IYldC?=
 =?utf-8?B?SE8reDJHR3NnZ1U0N2cvcjUybmVUK2FMWXFtSEEyVnFtbHpRbENaQkdTbkFJ?=
 =?utf-8?B?OHp4b3ViemNFMGN4MTdVVUVYeTZERkZobzZxUjdQVzViTi9Ka2hzRmxWazdN?=
 =?utf-8?B?d3pSWUFSRlZJc3hrdHprMXloWGtOZkJHeTZpaDU3RjVFYlZNWWRGbHdkcW4x?=
 =?utf-8?B?OElqWE1nNXRLN2hpaFl6UWlPN3FSb2V2TnRZeHB5bmNQYWtLSXFKRGJSSmJJ?=
 =?utf-8?B?OGpROUdaYmVZdzFkM3AzdWhYOWM5c2RVV0t4RVNDNzFjNjlzem1OcDlNbHZz?=
 =?utf-8?B?QkZwWjhnWHMyZ3RvdjNwUjJHTkR1MytLVFdpb1dZWTF5R2J6TFg5aGtFd3BM?=
 =?utf-8?B?MnZ2ZG9MYXg4RnRZR0RaWkFLbzc5eTNONWpTYmxrWmt1VGtKUGdDbXRGd2ZZ?=
 =?utf-8?B?NEcvTDM3akh5NFVDTWlVMitaWjhaMVZXcEdSNVZ1T3YxUFdPWk8wZE5EbkhB?=
 =?utf-8?B?OHFBSHNYb3FNYXI3MmxueENJODYzb0xLSGtIbW44Rk9xNzg0a2RlYm5NaHNn?=
 =?utf-8?B?MlJldHd4bEhISzNvdXhNTENQWGNhVFdkZXhjaEZLZ3AzYjgwTVJ5ek9YMit4?=
 =?utf-8?B?aitUTjlwT1JWMzE4YjBtU0dBWlBHMnREQ2R6RlhUNDBVdWxWcjFKNTNUUzhJ?=
 =?utf-8?B?V0RQYXJWNEtORUd4Vzc4ZmxnNFJQRmdMZnBmWjlkRkJ5N2F6QU5zNlovSjh0?=
 =?utf-8?Q?Cs6Y4lSJ3PV3e33bt2S9nRLZw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632767f8-25ae-461a-e147-08dbfa1deee2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 07:51:07.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKHGz70ET2wQIQJOyiebx/qKm9R7qK1LXDUDq32keiwKwbf547udFmOGks9rCC2j3r1HpFbk08vVyOnMQ//A7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com

On 2023/12/7 22:42, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 09:04:00AM +0000, Tian, Kevin wrote:
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Thursday, December 7, 2023 2:59 PM
>>>
>>> On 2023/11/17 21:07, Yi Liu wrote:
>>>> @@ -613,4 +614,38 @@ struct iommu_hwpt_get_dirty_bitmap {
>>>>    #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
>>>>
>>> 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
>>>>
>>>> +/**
>>>> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>>>> + * @size: sizeof(struct iommu_hwpt_invalidate)
>>>> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
>>>> + * @reqs_uptr: User pointer to an array having @req_num of cache
>>> invalidation
>>>> + *             requests. The request entries in the array are of fixed width
>>>> + *             @req_len, and contain a user data structure for invalidation
>>>> + *             request specific to the given hardware page table.
>>>> + * @req_type: One of enum iommu_hwpt_data_type, defining the data
>>> type of all
>>>> + *            the entries in the invalidation request array. It should suit
>>>> + *            with the data_type passed per the allocation of the hwpt pointed
>>>> + *            by @hwpt_id.
>>>
>>> @Jason and Kevin,
>>>
>>> Here a check with you two. I had a conversation with Nic on the definition
>>> of req_type here. It was added to support potential multiple kinds of cache
>>> invalidation data types for a invalidating cache for a single hwpt type[1].
>>> But we defined it as reusing the hwpt_data_type. In this way, it is not
>>> able to support the potential case in[1]. is it? Shall we define a separate
>>> enum for invalidation data types? And how can we let user know the
>>> available invalidation data types for a hwpt type? Any idea?
>>>
>>> [1] https://lore.kernel.org/linux-
>>> iommu/20231018163720.GA3952@nvidia.com/
>>>
>>
>>  From that thread Jason mentioned to make the invalidation format
>> part of domain allocation. If that is the direction to go then there
>> won't be multiple invalidation formats per hwpt. The user should
>> create multiple hwpt's per invalidation format (though mixing
>> formats in one virtual platform is very unlikely)?
> 
> I think we could do either, but I have a vauge cleanness preference
> that the enums are just different? That would follow a pretty typical
> pattern for a structure tag to reflect the content of the structure.

Is this still following the direction to make the invalidation format
part of domain allocation?

-- 
Regards,
Yi Liu

