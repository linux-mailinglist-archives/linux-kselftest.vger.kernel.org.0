Return-Path: <linux-kselftest+bounces-2968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C604B82D4E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 09:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11B91C211E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB545689;
	Mon, 15 Jan 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbvBnjoM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4E5244;
	Mon, 15 Jan 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705306691; x=1736842691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mPYaKGlOSyU/7cQz4snASnIsSEBhkIK5U54BIPPNRjs=;
  b=YbvBnjoMDIP4Roem1x5emPB/whLuh7EyCWI23uZLIM/CQ3W5sYM8A5ID
   WBFle/HH7Upw0muVkXQwsh2ZFP8nm542Y10o5dcRlAz5f94CpKRiASZ3Y
   CSAd2tdcQL8MIVoj9q2hK2MbnbhrgsvsP/Wz448BvsXZbYSFM6PiOzkYH
   CUTGdKyKkfhiKnR6kSeJd7mN/VyW5pnhxhwTro3zmsDJTMOtzuKxRp92p
   Wk06g4GcyimVl9Qi2f3iP7WbQ4KGgzQ6RCyK8aEfei64Ip+QcHrhGe3u9
   yMrYDfkstRkqGkWguc6i/SvNoW0cohqH+itwKnnnuWR4aDt6U67UQhNiO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6283165"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="6283165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 00:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874030556"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="874030556"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 00:17:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 00:17:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 00:17:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 00:17:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN9XLqOk7dcetwPgQM9V58srJUL5562k3hAy/TVY1y9MY0qViGijR4SXfU68mr+83PFOT87O1cmBAxzQzzbuNFSZBDkqeMesVe8VNE3++4Y96JJvVGs8ezo+tonrWIbPACTgSjzzZijohqHLPmVELWmvG79rZlRoi5SMmslxT0rRm+rhF7u090LICgPBn1z+bIuAXnfxLiMgWO6syxzJME+RpGMPXDiTXReuAxPKlNRMBIkxw1odoWZqNrQ97CT1qONwTO2Ec6F5I2fEz5kpUfR1pV4ayNDt6jqRFf4Cx7uGhFMr4WGPhmML1xhRAynPasygZOsryklDMIJd7eBlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp7V0gr7XBinuS9SoE8rIE4B2pp1CsvdbaarqG+Adjo=;
 b=I21wm3HE546/NlG1tgzvBdLamKn3lLt/iaJj4ivf+wlUj6Mb/tuTsEeXhm5+kZD0/EL8RbCLRviCxKr+SHFixEvcnqT4ESbC3G16vJgQOxLfisneZuj7Wpnyp2efqmE1HlaYWH+WBLHolV8pScXvgyWyb5Nst+zOqYl/9a9ZlyQzmHhiS0cLCpdO944wCq+dZ4lTF9Y0aOd0gupGIif9jTNlv2PPy8Wq3RQ/OjIfdPoxxp5lTjJtrv/IUlf1goYQwsdCtKLaKsUtrWGgK02t7bPEPcrRTvvJ/qVeh16zuTj9dWO5JFMatoW5lvRQVWAPNet4BO/LWrgcCjlk8SfKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 08:17:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004%6]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 08:17:49 +0000
Message-ID: <00742a4d-c7aa-42b9-b851-e6ead0f7a29b@intel.com>
Date: Mon, 15 Jan 2024 16:20:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231211203946.35552183.alex.williamson@redhat.com>
 <20231212152725.GJ3014157@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231212152725.GJ3014157@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: d4da294d-447c-49c5-9885-08dc15a275ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zRwI8E0KlAv9Vp4iC49xiqIX/pF2v88IFncbcEGnksFzpCUlEtrPOHitmnVpdmoBDNQqGqABhbfNaOQm3GvkIjNB37J1OgRFudmZhbhjjeBAGXSvSvz3I7cKfIETRU02tZt2UPQFgXtTLPzr3pzxoW0BXrNHF0WDeKST/WuvzJjPQZcVWi/67du9n7tu/JavUH6KbQmESFxnal9HLelIDKmKUzzIgqXpHRZEmgPgfeetX6hbSuoN4M20A/tYRkaBAXwvynl9+vulA4vm3eHAK4oBYvfyQeXKoQ6kPOkvvNnAnbuJHXLiglmQ7nfvdj5a4zOYOiJCn9nV/TjbYPL80v8fN72FyD8oHsOeBgNcTqzknuSNGQ6ULUPnsnuQjTrP2nupd7ufui89k5ZqjLxBbh2xRGTN+0M8VrbWt0eNHrgdrFQ36MYGwcaPhpibP+eY1KTvOH3lz5Jx/tMQrnwXzc5IMjFyl58krLVdWfbfzNE4nO+kEIMWa6TAcW71VQKEkpkg7w6/GtsUixeTbo1voJMJQmnXP6ajisc/U698OU7p3/wuf+Lj+pRvEh0FGk8kObOqaj2/tqnGXSPQQ9ouzxq+upj8olfLGHmCbeIxlsS3O/iMpk5WQBZSNAR8ymgvUkzraO/BCvr0ncWQYKxBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(478600001)(83380400001)(26005)(2616005)(316002)(110136005)(5660300002)(8676002)(6512007)(8936002)(66946007)(4326008)(7416002)(2906002)(53546011)(66556008)(6506007)(6486002)(38100700002)(66476007)(54906003)(36756003)(41300700001)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhMbS9GMWJMRUFFbGZDM2Uwck9MSSt5cjJxVU8yQnoxZGt5M1AxNmdJeUdl?=
 =?utf-8?B?cmlLZU45c2JCaEcvclpDUVljek85NVU0NXI2YzVkY1l4U3RxdnpSVU55Unla?=
 =?utf-8?B?aFlVdWxoT1BBNHhmeHFBZTF4bmVjSlJXM09SNjZYUnMyM1Z3bW5yWENmMlZL?=
 =?utf-8?B?Zld0N3BMR3NlR2FOU05xL0QzZXNNdkRqUzhWWDQ5VU9nV1paekFiR3g4a2RE?=
 =?utf-8?B?Z1ptZ084Z3ZvUUJRR2t0MXVsd21jcTVPWFRNN3hIaHJOb3F1QldXakltTDNm?=
 =?utf-8?B?YXQ2SCtVL0tvZHpENFllRzZPcW54TUtsMmNBRmtQUE4xT3FQVUVjcHJIYTJw?=
 =?utf-8?B?QXlmMVU3ZVFwaDhaeXVZbisvQk5aa1BZRDlWZU1TWWRxUEZtaC8xVjFFTUEy?=
 =?utf-8?B?Smw1RjNYUWZIOGROVlZnbnVwTVdZSlZabmNGQlN1bDVZOGRSZHpYQW43L2FQ?=
 =?utf-8?B?aFJIQlZxYzh3UGMyS1VaMFBqUmNXQUpHc2hpeUczSTZiZEM1YTdhb2F0NFM3?=
 =?utf-8?B?NUlNME1mb3RxNXNta3cwQ2ZqRVhpR29WaUFGUkQ0S1E2L25uekZUTjVLc1Nq?=
 =?utf-8?B?dkxvTVJkY2Qyb0UrdFFZTHdiSURVQVVsSFpGS2VXVEhtUVpIeEdLQUhsMVBD?=
 =?utf-8?B?RGhLbzRiVzRaUUNZSTlmRUNkZk1OdW9Xd1lBdmFXeWljTitjTEtuMG0vdnha?=
 =?utf-8?B?NnhhSzFkQ3E4WEZCY2FremdQV3JjV2dqZDVVZEhsMmRydTVtN2JONTdIRXZi?=
 =?utf-8?B?MlB4b3hxMjhLclBUOU5HM1BwT0UrTjFWc29iYitGU3p2bW5UZ1JhM2NZRE5w?=
 =?utf-8?B?cTVCT3gza09zR0hFOVRTMmd5RmlrcDY1dkdia2VvdnZpa2ZSVUdCbzFYTWZJ?=
 =?utf-8?B?ZkkyRjA2aDA2VlZCRCtBRjBrbTI5M3YrRFdpWVM2bHFHQzNrSGVJNWVPRU54?=
 =?utf-8?B?dG1nZnphaEtrRlNieDVWcVVIVkIzcXZ4VjBDRXJCZEJjQkZDYktXdmpTcENJ?=
 =?utf-8?B?MiszSzRheEVXeHVNeHJxeklvVnBQUHZPSGtaejFQVmdlSzRFdnFmN1dJMkVU?=
 =?utf-8?B?TnlZMlp6U2hBQmM1YUF0YkxaVC9IbFcycVdaemVrZVV5Z0ljR3JNSnFJODRK?=
 =?utf-8?B?K1J2bzIyZ0xQN202TzVmMmJzeit6YWRyTFhOTDhNb3dwcmNBNTdFa25obDFZ?=
 =?utf-8?B?ZUVRYW9tVENEWTI0amRIK3VuMWgvVUttNXUrYTI2WW9SN2QvcUVTZjJXRGYw?=
 =?utf-8?B?bWptRGNIYWw4OWkvNDVmd0ZvSjRSTEhsQmQxNG9Jam9MSktrbHJSOWNuL3Rv?=
 =?utf-8?B?UHd0VmpETGdWazhoa2JXaDVRV294N2JEaXJ6Ukd1RVYzVlp2N0x6MHNTK1B6?=
 =?utf-8?B?dm1EaXNnQWZUaFY4R2FzM3doUFlSVDVTRE5xaXpSbVJLYTVyTW9RSk15RS9U?=
 =?utf-8?B?dk9wM1doS2t1dVBUMm5NM2ZCS2dFbHpyKzErbkdueUJDZ0FHRmErRzY3dm1O?=
 =?utf-8?B?RXpKTUkwdUZQQjUrS01Rb0ZFcGpuaXAzYkx0MS92eDl3eXIzQWFuaStBNks0?=
 =?utf-8?B?UnNDUlFJNGFSMGl4cGNxWWJkZFhvTDZmRzRGOUxNTExkUnhodVBBc1RaMS9O?=
 =?utf-8?B?c0h6ZWdqZEN0TVNjUnhhK2FXblUwTWpFUnUyV1pNN3B6STVuSFhaTFNJNVNQ?=
 =?utf-8?B?RENlazFpUW9RWnlGWUhoc1NPQkFPT0pWSmhUbTgrU2xieGQxRHQxRi9pZHJU?=
 =?utf-8?B?U0pSczIvc1kraG5yV1I2QWpzeEk0OXA0ZWxOaVFScXNzUUZwamhtUTlQTkZt?=
 =?utf-8?B?UWY1YjFkazJNaml3dXU2NG41UDhVSkVDUHA4VlVtZ2thQVBySFFNbkF1aFA2?=
 =?utf-8?B?eDFHM3F0T01xRG1IL242WlBqdU94aENHb1NGQU85NG11cmV1NUFjeVFNK2pq?=
 =?utf-8?B?TENQbzYveHVtZ3ViTkVXRTk4ZUMxVm0yNHkra0JiM3dWcy9GVjdoRDluQWFo?=
 =?utf-8?B?L1lCUkJtU05uSktMb00rUHEzaDVHRU0rOWErSGloMjlQOFZwZFVvdHJFQmla?=
 =?utf-8?B?VUtNUHpERXk1dHZjNmQvTDEwYy9lN3M3WTluOC8wVXVuZzBFYmNYWnNML2pJ?=
 =?utf-8?Q?ebMqtCCJbvAFP78G3aJ1swUw0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4da294d-447c-49c5-9885-08dc15a275ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:17:49.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhdFY9u2CoO+hyhsXV4CeqiQCY2Nq9zNePyStA+zskroZCX/+npM6vIxYOxIQhm8xpiOX8REKPvchPF+NgZwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com

On 2023/12/12 23:27, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 08:39:46PM -0700, Alex Williamson wrote:
> 
>> So how do we keep up with PCIe spec updates relative to the PASID
>> capability with this proposal?  Would it make more sense to report the
>> raw capability register and capability version rather that a translated
>> copy thereof?  Perhaps just masking the fields we're currently prepared
>> to expose.
> 
> I think the VMM must always create a cap based on the PCIe version it
> understands. We don't know what future specs will put there so it
> seems risky to forward it if we don't know that any possible
> hypervisor support is present.

This series parses the capability register and reports the known caps
to user. While this does not include the version number, userspace should
decide the proper version number. Seems like what you suggests here.

> 
> We have this problem on and off where stuff in PCI config space needs
> explicit hypervisor support or it doesn't work in the VM and things
> get confusing.
> 
> Jason

-- 
Regards,
Yi Liu

