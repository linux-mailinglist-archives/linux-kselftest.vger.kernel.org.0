Return-Path: <linux-kselftest+bounces-202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250137EDB40
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 06:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C9B280E7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 05:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA753A8;
	Thu, 16 Nov 2023 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvZkwxbE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A66E1;
	Wed, 15 Nov 2023 21:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700112964; x=1731648964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wYpykUPRQ4CeX7a01vWXa6tgdKgpoQTy+Npvudn94ZY=;
  b=FvZkwxbEKwBp7CgE8mQPRpUMivG7zNxfnFSF/ZcO6h3EZBDgPBXviGUh
   hYqLce43T3FMTQJk+9uSR/krG6UmEtgJcZmFAYDj94ty/chM47MPLZiuG
   d3s5LbXXqgh/cpqdoGK3/1e4LT0SlM8qLtqF7MOEc9z2StO7jINVxuEoA
   UwvXssqluz0ws6ZikQ+rQwIziaADqjXehkkslvZ3wdNQXyERY5c6ZgivC
   EDxQDwNUEXgg+oFAsFVK6Npvk2Cnd0Eby/mbSWGbKDVat0XVZmtIXip0j
   6fQI897/eGOY53mLsasDzmFHsYh2sAfOeU8yXWPabdcQo6ZtWdUxyjQq4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="376065905"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="376065905"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:36:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="13004051"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 21:36:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 21:35:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 21:35:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 21:35:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+UloJp8M+3hm0091g+iwQs/eTfZRJdmRh1YuW4Akb83RHeHKPevYatzTpm7PY3OnJKV/RBsg75Y5gtiQRFPDDSg0J6D+R4qlKyl/ifTnMRjXBarMRQTGoRB9UaPMVsYsdYMukXtBQEdUR69ayYoFfNmQvLx1d0N6VZAnF7+a/fN5RGTsZR/gyFF4/GEmaGJyRKmBUXVejrwf7bii+DlAf64wujvWMCqwZhw75pz/WbQ/hTPS1fJ9jKq6p/3H3REKWJrLE3MIQ+TBhcf+RaGC/ThpPNGUMZsldxLIS5kCulFT4Qkk8hMJExYX3VK7U8u5nh6RqzzLAZiHAVYvlEZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUBk8NNM8kERja+kvPCmz20MW/8NRf3GEq5HQFAZ2K8=;
 b=JvNkTtlMkY8WITpPfqfTRgU6KH4wScehHDefjMgcX+iRYQ6Ef4S/MiVoOgS+D7P2Y7MeyPya83EMWoIS47ao5ewH2br8d+xADlKxo5prCGziE963GpG7CTwlTmc3w5k9vNm5D3I7x4Dv1Nq5akJmZP44pzuY6Xp9klJ++Wv/syNS0y2QrBwXIXdsNwHGVA4Ai0Sxl1nBjWSirtu8Lzhvm9Rwz0f8xwgcq+LEsiZl+kpQRZ+etpBl58Bj2MEpc1sCTKQjjQy6b3iqS8QAJQqpn8NUmfp2Gw71oJ5IGGeW+kkSaRRxLAl3NxbEhIFVIokAiLoARrIyk3aJ3S/zrJA0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12)
 by DS7PR11MB6015.namprd11.prod.outlook.com (2603:10b6:8:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 05:35:49 +0000
Received: from IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::cbb6:48f6:d69d:f657]) by IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::cbb6:48f6:d69d:f657%5]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 05:35:49 +0000
Message-ID: <39222f73-35f8-4d05-8772-c6df4c8298ca@intel.com>
Date: Thu, 16 Nov 2023 13:35:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
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
From: "Cao, Yahui" <yahui.cao@intel.com>
In-Reply-To: <20231009085123.463179-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To IA0PR11MB7838.namprd11.prod.outlook.com
 (2603:10b6:208:402::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7838:EE_|DS7PR11MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: cc990f9e-6667-4ca7-9cf7-08dbe665e32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyAJMy7iXIJ5Xk5lwMvjzirIXuk6S5t6A9ZAwkuBrSrzebP3UI34y90R7Q3gd18ijIes8SlWSEgEOmnxV8fuxsFX2hMThGfaVoA6YQ0tLFlhpL4Tm1Mi4ASmAg+mwCBBI1BZ3TGupwiQTuNa9YAKAlKTl57hF3vkSZ+3tHAxZV6C+SuFo5NJEt8WtzL7XbnKUMk3ZaR/MKNaTdHhLmjcLKWhKQlsQdKrAFOzbbIodeYAgg4Mk01/htU2qJxuXYhiQWsvZr0D+XhntKRXBA+/8SfjjxhEo6rAjQ0CMc6ec+N2w2dqjTU5oJAizBzh/AYJAXSTx7qv9engmkykqMLeyOsaluM/ldgelTPPfIcTFXd2uMcdewaWjej1oKyuX6gaA3SlLdOXqRa1rnRJ+V5lq1VUTHM3VdJMs8NrAbNqzR21AESxcw6BuQHkUdN24JsDnC+9nWXgbU6mXR1N5k2UokTFIIMR0YCU7CcTyu81vv0Kz5Ejm2gTt6dnxS8h76xK7LbTXQX+X8WBIQiA6qpw7nSVTs/QBbFOKSSem3LOmZapsXRvdFdigm3l4GOWkE5vDSTzVS9T87EYWtznLZHol6KYvGT+PqXR4+Ug5QmyVeyrhwvTneea5438kRsGopczAUFGBBwibf6ghNomwUY6jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7838.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(66556008)(8676002)(4326008)(66476007)(66946007)(8936002)(6666004)(6486002)(36756003)(478600001)(41300700001)(31696002)(86362001)(5660300002)(7416002)(2906002)(38100700002)(2616005)(26005)(53546011)(6512007)(83380400001)(82960400001)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFUaWMxK2lCYXh5SWduMkZZTGZFT1ZMNEZQY3FNVTIzNEtJL3NUY3Z2bWZZ?=
 =?utf-8?B?NkZNTitzRVVTUjYwR0FxUElMZjVSMlJUazdIby9SbFJsbkorUllObXlnVkNv?=
 =?utf-8?B?MnJYUE9nMUh3bnBCZjd2RTRSZHN5Y2pqeDBlb3JzRnBWZ2hoTEtMTU1RWEk1?=
 =?utf-8?B?Y3pGNnJNRy95RlpQRitHVEJraFY4ZU1sbndxcTBFVVRXa2ZCWHRueTNHajVV?=
 =?utf-8?B?K0lsQ2hvTnRpeGIxQzFPTDZxekl0cEdJeUJMdndFYlpvT2c1QTJ0RlpKU1ow?=
 =?utf-8?B?ajR3bWFSS2VaTXBrWGR2NFl4eTMza2J2NXdza3BzQllxcnV6WlNBNUtld3Ur?=
 =?utf-8?B?MzkxYmliWTl4UzZRWEp1UGNhMEFkUFRrOUNqaEdkLzZ3a0NqbmI5TWNWZXh1?=
 =?utf-8?B?OHdsN24yNnp1L095bVUrWXVCejBncENUN0JCRGJkVjErMW4wYlNqNVNMa3Vs?=
 =?utf-8?B?bkU3dUs0bkk1eHBibWNUSVphV3dCc1J6Y3VjMHRCMGdVTWtVbllpTW91SHpH?=
 =?utf-8?B?SkdWemszUWxmMXJ1M2VGNDhPZEwvWm8rbkFYQW5QSUR1NjBpVkJMRnN6MEIx?=
 =?utf-8?B?Z1RHSVVyV0xOanV1dXQxYmYvaFlsK2lpc1ViaUJPK1A2Tlp0TVFwYTZVczhz?=
 =?utf-8?B?WC9zUytIZWRUQkVHRUp4cG5GOUhPMlBNZXRUZDlld1JFMHV5SE5lbUlPNVht?=
 =?utf-8?B?T2xhQTNaRERoMk5KWVRudTZvcS91Z3VlRjkzMG4wUTgwVVZ1UVl2OUEzUEFw?=
 =?utf-8?B?WGtkdFpmNU43US9EMVVyWUJHR1BOZnIyQ3V6YzN5cFlKYW5NRjAyQ0tQUHBG?=
 =?utf-8?B?RVhGR2tRcENGVFpvUzdPMElCTXdSYW00SDZGN3oyZVZFRnRuT2djUHZCMWdT?=
 =?utf-8?B?Si81QVNzbExXQ3psQXhJdUQxOGJMbDE1VHRlaCtzV01EWmdhTU41Wlgvd3li?=
 =?utf-8?B?aC94dFBsOHNkTGkwOVZmQUpEb0tkdXJydkJaYk5QVDVRK1NkMVVhdUVNZGpj?=
 =?utf-8?B?YlhPNi9sejZ6RVpuRUVsVTJNK0xXb2ZUV0VJUVhJYTgvU1FDb0tZUWN6ZkZp?=
 =?utf-8?B?NDB5UFlGNm5ja05MaVlQWTlzem9hR29WeXRpRVoyRUtLTHpPZ0dFdWhDS01P?=
 =?utf-8?B?YVNGNzFucmRNMEpjVmJkcktWdy94b3J0TWVwWUlKYm5Gck1kSEJ3MnNVV3R0?=
 =?utf-8?B?N0Q1QWxrSnlxbFlsQXRKb012UGE2aDEreXdxT3JFWDdMemtRWHd3K1l2dXFx?=
 =?utf-8?B?Qlk1NmxVNFhvNktuRld4NGhkL1ZWc1F5K2JkVVdsV1pGTllqb3l4QjViT3Bi?=
 =?utf-8?B?dmFVVitWY3RuODhzUGRSNmZtQWxwN0Vab1BBQld5WmhJRUxKL0Zwc0I3NlN5?=
 =?utf-8?B?b3BCWW1Sc2xrb1hUSkpNZlNFbEtGMlBXUEFSdTdnM0R1NDdsNUlJdFNKbXZt?=
 =?utf-8?B?SnU0dlpjWnExaHdRVHBVRlhFR1BZZWI5WnpuNkpZcnN6bEU1NzVoWFU3Z2FL?=
 =?utf-8?B?ODZ4a2VDU3BuY0ZROWVsdWUvZS8yWWNYUFRSdDN0YjdQSFp0OTF2R0xWQWU3?=
 =?utf-8?B?N1RYNDA3aUVBT1JNeHltaDM2NXptWlZjQ0luTmc2QU8yNDZHd2pUamMrTDEw?=
 =?utf-8?B?czRFLzluSFJTZU9RNU1BdSs0WFlLcHIycEttWTI1SURpSHUycUtBN0t4SEhs?=
 =?utf-8?B?MXB1VU9YVVZmbTFVM204bFJMd1J0a255Q1EwSHVTM1E2UnZDcUszVDAvVVZu?=
 =?utf-8?B?MEs5cUUvS20wYjdHcnBSWklmVTJZNjFMRVBaR1VlbWRwOU1GSnlFVUxiS1RK?=
 =?utf-8?B?NnM2VzhHYnV1ZGJrQ1J2R0FtZUhmWVVkbEtxaFhrM2x6eVIraEtxZGpmSHRn?=
 =?utf-8?B?YVFLcU0yVGp0UktxUWVBMlBPQmJrZE9zeE5GdEdsWTNDTEVxTWhRQzgrSkdm?=
 =?utf-8?B?QmhXWGpZZWgwS3ZrUXpjN3NIMW1YNjgzOFVnWUdRTy9YZnhEUFp1UTdOL0lE?=
 =?utf-8?B?QUcxSGs0RlFVUlo2b1Y4MkpXRTREU0htYUp4SUp1bEkyNC9qQVBFRVY0Zngx?=
 =?utf-8?B?NjRjdXRNVWZ5ZHp6VmJKQ3d5S3IrL0tINnpyY0Q0ZmFXbXlaeHRDQkhCMXVQ?=
 =?utf-8?Q?81LhZKRYP48+8OGHoF3h3pCsH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc990f9e-6667-4ca7-9cf7-08dbe665e32b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7838.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 05:35:48.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQaN17WCZkwBIXqe4xscr+eWmotJGUWGxPyJhn6+xhgHt1CJacrTSURe7n98RgkfgahxGptQ4MYgXCrNm6PNgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6015
X-OriginatorOrg: intel.com


On 10/9/2023 4:51 PM, Yi Liu wrote:
> From: Kevin Tian <kevin.tian@intel.com>
>
> This adds vfio_register_pasid_iommu_dev() for device driver to register
> virtual devices which are isolated per PASID in physical IOMMU. The major
> usage is for the SIOV devices which allows device driver to tag the DMAs
> out of virtual devices within it with different PASIDs.
>
> For a given vfio device, VFIO core creates both group user interface and
> device user interface (device cdev) if configured. However, for the virtual
> devices backed by PASID of the device, VFIO core shall only create device
> user interface as there is no plan to support such devices in the legacy
> vfio_iommu drivers which is a must if creating group user interface for
> such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
> the device driver to register PASID virtual devices, and provides a wrapper
> API for it. In particular no iommu group (neither fake group or real group)
> exists per PASID, hence no group interface for this type.
>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>
>   
> +/*
> + * Register a virtual device with IOMMU pasid protection. The user of
> + * this device can trigger DMA as long as all of its outgoing DMAs are
> + * always tagged with a pasid.
> + */
> +int vfio_register_pasid_iommu_dev(struct vfio_device *device)
> +{
> +	return __vfio_register_dev(device, VFIO_PASID_IOMMU);
> +}
> +

If CONFIG_VFIO_GROUP kconfig is selected, then there will be access to 
vdev->group shown as below
->__vfio_register_dev()
        ->vfio_device_add()
             ->vfio_device_is_noiommu() { return 
IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->group->type == VFIO_NO_IOMMU}

For SIOV virtual devices, vfio group is not created and vfio cdev is 
used. Thus vdev->group is NULL and there is NULL pointer access here.

Thanks.
Yahui.


