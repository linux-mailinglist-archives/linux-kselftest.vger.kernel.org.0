Return-Path: <linux-kselftest+bounces-1912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B71812E73
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 12:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B51F21A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856A3FB24;
	Thu, 14 Dec 2023 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6WpRNyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967A8E;
	Thu, 14 Dec 2023 03:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702553040; x=1734089040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qajbK1dXrjOoIr5eocHyhG/387ib/i926CZ1ci/LInM=;
  b=L6WpRNyqE+hTUmbUHVOWVcMk69QVyJkxoIVTubaUQbi7c0TEa00sxl0i
   IKcALXrh3BKx89jspDUTb/BE9o33nxeXqPFfazQPW2/gpz+V24P4Pt6wv
   55gVxAfWM/PZu0BTeLZHXSatI98C/9KbbKPKjTKVeRfvdjl70mZ0B7N6R
   47ipfKAMIyimpSnwL/Yx9pFTMdAfGs6l7rUM3L1ZYgNqfVpWcZiQF08pz
   UU72S55cZwsglL0hxb4XQbCzosb1ZVhw6p25Fv2AEULhTOFE/mPgDTSZb
   5tNYQ3IAXde+VL0wDlBXY1wMfBksawLTEzXSbgDoqYAVDsPYbuU/5iCvO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393977204"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="393977204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750502967"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="750502967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 03:23:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 03:23:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 03:23:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 03:23:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 03:23:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVn/zvdm2e/VNcDgFnjKaA8b2F/eP+JtFL4GqQEBSvnOB7nWd1/7C/XYVkj3Eh0LPKsR2vOO8nZf8+4PXQU1Oy/xdXK6xWrCO/C2sypYqeJfLyMdUZm7KFmM+tjNrBRcSAnjqP0q9JLMqsz1KDQWPGfJeqrYp1ZYo9WF4Ux1tpChHEPs3hR1b5uEGgg2Kuf8XNMqQvMksk0h8WiKKbqq7LCfTMOXKoZTdnAoeL15dPn8Js1xdF2u0Gho9Axwdd8TEmvh0D0Zh06jHyRGjXNmefYlRau9ZGGv9KKN9tXA6nrS2l2nDGeXcCo4NC0hXhxJ+oE60nRDqAnS9423z+x3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+6S04BPhkc+bNCy9xHOAshrUQbSl9FSzNgXYWFukG4=;
 b=Hylto6zRwroT9d3BhzBlmUZFYzMTx0YNl+V9emKBVD5iEOTpCOFd/TAF0YJgAJsgjbYKIruZXWHYNOoy2CWGzxiCnG3+C+f8c6Upt9BNfB8oPZLXltaZl6mJXJV0DjR1Q/N8ZdtNVHrKsu6N5HkFLqqyIdpOG7D7t6vCfZrJdi84dmtSH0WFwr0Lv5SxOfbxQxWOdy+yEPE7CvXG3ylh0Dp+KmtncKIxfxjYrgdapMXSkocGsgyqU34q5KInQS3bgkxU4WQrlh2mObzkgYlRUrEohYozpyP1DaddbSUd/e1g56GgV6O9Uzst6H+q+SRKzuZUJhML9Iu4Rz9xApvH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 11:23:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:23:55 +0000
Message-ID: <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
Date: Thu, 14 Dec 2023 19:26:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
To: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>
CC: <cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231117131816.24359-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: eee458af-0583-4a4f-2cff-08dbfc9727ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqRiesBw9nY2Ls7N89Gr3L2oxKehkdZv7dgPqTCiqHlLqAbIQsYAY0ZAIXmXJeUAGsgOGp0NcinQi+VDZAKGlfwcRZNOYqHed1jsMAwxkqd8XrOKw//DD6ijBQy2p9lDVA/oJsaU7QMU3jqzUR6wNhv5na7IGZgFE9Xz5B5MP3ToiA7UQEBSt66c2HpoZN+87LNW9HCi0U9aMgMu/xtmZPMLb58wlN629pzZRupELZOVg8WyE1Kg7QtODXYZW9EAAQz6rPNUOIrERS4GsSYf4CQ3PVDJsXW9VPxzE0BiX0xNe9in7wajg9DJ+QPJ4uhDdCF8rYNHnsMvBmknaErbAE1rg84WWHKyTCegtuBZjPtdM7nyH2Z8OoEtCuDR4RWDog09HaXyoV7IGYbYFvv2Mk8Gav3v8FM/30FQFCt/9Kgm0mTeBZ1t1Qz03lhQrh4k7R44T6fguquZENvHgBEIXG8PblhAJzhZxZ59QMtC+jHmDbFKJ6VY6DfCiGgu8juszLVNHabRQOzlA8KLMLY3aBllURPC+lEx2KV+g7xj2p3C0zWBiMdY+JE4vlUnWg2obiwzUNCj1yoKn/zB3Hric5TocTfhStTxJRxlJDomcX40e2V1zKK6q7tWu0J4ZCWIFzYmDtfmXCUlFtiXWKr/2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(2616005)(6506007)(6512007)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(6666004)(478600001)(4326008)(6486002)(8676002)(8936002)(966005)(66946007)(316002)(66556008)(66476007)(82960400001)(31696002)(86362001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1yWXV4YWNobm1qVWpVZHZzZENrckx5R21IbnlUNHdFUDRCTHNBVlplc1hB?=
 =?utf-8?B?QzhjVS90RGtGVjd6M09iMkFLTzhyL3VIY1RGVW1UVWhYNCthOEZGTE1mUzMr?=
 =?utf-8?B?S0VEN0pWL2tUMWdGQUdJVzJNUENsd2Y0M0hOdWhZazZlS1JCMkV1ZzZmcnk3?=
 =?utf-8?B?V0RyMEdrc0UxZm0vcVluV0VTRTNlV3g5QzRkSjlmY1pIeGNQRjJaSEJaUzNQ?=
 =?utf-8?B?UmJtU0NMblN0MTlYS2RrZTZtS2NhY2x2N3FUT2xyL1JETzhncHJCS2tJdWVz?=
 =?utf-8?B?K3MvOXROVC9lbi9xYTVpQkpuK3NIeXBETDF5ZHEvTHZMc21pYXIvL2FWVlR6?=
 =?utf-8?B?Smp5eDdiRng1Q1VrOHZrSjhkc0ExZjl0UU5QbjM4ZnVsekJmN0UxS2pMZGgw?=
 =?utf-8?B?VjkwckgxZ1B2enB2SHJ1OU01Sk95WjdqU0tQQmtjbGxwVzN5Y3UrQTJKQnhG?=
 =?utf-8?B?eXZia1hiM21sRGQ4bkNLYnZNZmY1azcramdsN05EK0xGa2YwamtKOFpDRHMv?=
 =?utf-8?B?SW9uVEg4MHk5N1BsZ1h2NzJaNXVYVXJLRHYzSmV3S2pWT3RHNTVhaVdoQnhZ?=
 =?utf-8?B?TWFmQ1FINDREUW1odWg3L2pzUGs2OExVbGh4QnREeGV5RWoyWHBJMTlYdlZF?=
 =?utf-8?B?S3d4RHBBNnE1SnRMZXQ2MGhvNlo3d0lNWDErQTlwVXEzN3lFTjZGRnhDQlda?=
 =?utf-8?B?dE52VzJKZ3FJdUNGN3Y5b3dnc094aTZmbmE1M0lXaFpCeHZybnVGQ3M2T1ZD?=
 =?utf-8?B?WmgzU3VqbGZnRVF2d1NoTzJpSE13VlFzWlJZQ3N6WXpWR3cvV2UyNGlZcmpx?=
 =?utf-8?B?TFJFQWdpRElaOHNlMW16amhhQUxIaS9NZ1J2YVFZSCtrcmk1MThOZFdaR0RR?=
 =?utf-8?B?bTNkRCtnZnVuREt5dkI3TEpzSmsvNWhwc29Xdm9JTEMvVzVJYjRyZld4Q3p3?=
 =?utf-8?B?eUFwY3h4dzZza0JaOEVWWHB6NTg5c2RrdGxhUkM2RkwycmR3VFlpaWFZakx0?=
 =?utf-8?B?NDJ4bHVDSmtmaTQxMXh0cXc2cDk0THB5TlpEZ29MWXZuejhLMkI1cFc5MEk1?=
 =?utf-8?B?RkhPR0hKZzRJYlVjVXpiakozSkdyaEtFUVVvc2NRclpESkZSZHJUUGhnSHJX?=
 =?utf-8?B?bWhDaFJQZURSVzhZQ2kwZ2hQRDcvOVJtM1Q4aEdUc2ZTU0dBQ1I2OXVEK0lI?=
 =?utf-8?B?WDRRaDlXM2E3WHlCYnZBS252VkxDMHRiSkFmNmUxVUh5T1gzSEIzOTB1NFdI?=
 =?utf-8?B?TTFXcHVXTGpBbVRPb01oNlB0OGNuMS9qdUtTanF3T0pCbkt5OFRQUi9UM3FH?=
 =?utf-8?B?OGJqZytEVmNIL3FzVXF0MGdiMWwwOG0rWlhLdW11VU1IRHN0RW1kYnEvYSty?=
 =?utf-8?B?YitYeDdHV2dlb3hpTHpXZkVWZHB6SjRCWnhtSThXQmkrQ1RiSVNuZUVqRzg1?=
 =?utf-8?B?ejhjWmxtcFE5VkJCTWhsclNtN3FnT1FoK3pmQnFVeldkWE9xcC9USVFKb2FW?=
 =?utf-8?B?RENlV0JkVFFOM0dUMTF0NUdsbnFFWDZrMnVBMy8ra0EvK0RadEg2RTJ5WS9z?=
 =?utf-8?B?czFwNFgya3pueFFGZFhqSHpWaXJCMHNiOHMzanZYZDhhYWU0RWIwbjYwb2tr?=
 =?utf-8?B?OU55N29QcHJpNDhXc0UyT2dzTVZmbXBZSnNzVWNmWHBIbUsvcm9NdDlqTnR4?=
 =?utf-8?B?enMyQzd5MkM5ZHRBbTYrTWh3NW9SMSs5UzlwUVZOemsrWnB6RDIvZ3NEV1Q4?=
 =?utf-8?B?cjZteTRmY0oxZlRJOFFMb25DM25oenVrSGp2KzZ0c0RnZjRzNXVyNHZsOUhi?=
 =?utf-8?B?djYydGhLeU51bXBIUWRKaHZxVytBakErNmI5N2VLVm5iWW1nQU94WUl3ekps?=
 =?utf-8?B?dTJ5S2Q5SWVOTERwa21FT1QzN1BKbFIyc0pFVzVQaDlMTUd0ekc1OVY4MGF6?=
 =?utf-8?B?VC9hTGVuUGFhazZicUFYZWRGTUV0eEhRa3ZqcDBIc3RYUmZRT1JVUmxIaS95?=
 =?utf-8?B?SThJRzFFYjJ2NTM4eElucEVNMWl0RzRsWDhUdXZsTXBOZDdtR3ViMXJhdjd1?=
 =?utf-8?B?aDZnelo4NFR6QnlBbEd5UnZ4VmxUZmNzbXVCMnVQeklBZzFkdzVISEREc2tW?=
 =?utf-8?Q?Faj5Q9okIuNLxxMv8Y6l73zgj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eee458af-0583-4a4f-2cff-08dbfc9727ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:23:55.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQfJD83NzvESzEWFUjiSdrbNmTgtltlnfZkam60ScG/OlFmQC97Uj+EztZhZayGVUxzKz9U+PkYw3wi7jTnLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com

On 2023/11/17 21:18, Yi Liu wrote:> This adds the data structure for 
flushing iotlb for the nested domain
 > allocated with IOMMU_HWPT_DATA_VTD_S1 type.
 >
 > This only supports invalidating IOTLB, but no for device-TLB as device-TLB
 > invalidation will be covered automatically in the IOTLB invalidation if the
 > underlying IOMMU driver has enabled ATS for the affected device.
 >
 > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
 > ---
 >   include/uapi/linux/iommufd.h | 36 ++++++++++++++++++++++++++++++++++++
 >   1 file changed, 36 insertions(+)
 >
 > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
 > index 7f92cecc87d7..cafd98642abf 100644
 > --- a/include/uapi/linux/iommufd.h
 > +++ b/include/uapi/linux/iommufd.h
 > @@ -614,6 +614,42 @@ struct iommu_hwpt_get_dirty_bitmap {
 >   #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
 >   					IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
 >
 > +/**
 > + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
 > + *                                           stage-1 cache invalidation
 > + * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only the
 > + *                            leaf PTE caching needs to be invalidated
 > + *                            and other paging structure caches can be
 > + *                            preserved.
 > + */
 > +enum iommu_hwpt_vtd_s1_invalidate_flags {
 > +	IOMMU_VTD_INV_FLAGS_LEAF = 1 << 0,
 > +};
 > +
 > +/**
 > + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
 > + *                                       (IOMMU_HWPT_DATA_VTD_S1)
 > + * @addr: The start address of the addresses to be invalidated. It needs
 > + *        to be 4KB aligned.
 > + * @npages: Number of contiguous 4K pages to be invalidated.
 > + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
 > + * @__reserved: Must be 0
 > + *
 > + * The Intel VT-d specific invalidation data for user-managed stage-1 cache
 > + * invalidation in nested translation. Userspace uses this structure to
 > + * tell the impacted cache scope after modifying the stage-1 page table.
 > + *
 > + * Invalidating all the caches related to the page table by setting @addr
 > + * to be 0 and @npages to be __aligned_u64(-1). This includes the
 > + * corresponding device-TLB if ATS is enabled on the attached devices.
 > + */
 > +struct iommu_hwpt_vtd_s1_invalidate {
 > +	__aligned_u64 addr;
 > +	__aligned_u64 npages;
 > +	__u32 flags;
 > +	__u32 __reserved;
 > +};
 > +
 >   /**
 >    * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
 >    * @size: sizeof(struct iommu_hwpt_invalidate)

Hi Jason, Kevin,

Per the prior discussion[1], we agreed to move the error reporting into the
driver specific part. On Intel side, we want to report two devTLB
invalidation errors: ICE (invalid completion error) and ITE (invalidation
timeout error). Such errors have an additional SID information to tell
which device failed the devTLB invalidation. I've got the below structure.

+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_DATA_VTD_S1)
+ * @addr: The start address of the addresses to be invalidated. It needs
+ *        to be 4KB aligned.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @__reserved: Must be 0.
+ * @error: One of enum iommu_hwpt_vtd_s1_invalidate_error_code
+ * @dev_id: The device in the invalidation completion message, it's meaninfful
+ *          when @error_code is set to IOMMU_HWPT_VTD_S1_INVALIDATE_DEVTLB_ICE
+ *          or IOMMU_HWPT_VTD_S1_INVALIDATE_DEVTLB_ITE.
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation in nested translation. Userspace uses this structure to
+ * tell the impacted cache scope after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be U64_MAX.
+ *
+ * @error_code is meaningful only if the request is handled by kernel. This
+ * can be known by checking struct iommu_hwpt_invalidate::req_num output.
+ * @error_code only covers the errors detected by hardware after submitting
+ * the invalidation. The software detected errors would go through the normal
+ * ioctl errno.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+	__u32 error;
+	__u32 dev_id;
+};

dev_id is used to report the failed device, userspace should be able to map
it to a vRID, and inject it to VM as part of ITE/ICE error.

However, I got a problem when trying to get dev_id in cache invalidation
path, since this is filled in intel iommu driver. Seems like there is no
good way for it. I've below alternatives to move forward, wish you have
a look.

- Reporting pSID instead of dev_id. This may not work if userspace for
example Qemu cen get a vfio device cdev fd from management stack. Maybe you
have different opinion, do let me know.

- Let iommufd to convert a SID info or device pointer to a dev_id, and then
report it back to userspace. This seems easiest, but breaks layer and also
requires vt-d specific logic. :(

- Reuse Nicolin's vRID->pRID mapping. If thevRID->pRID mapping is
maintained, then intel iommu can report a vRID back to user. But intel
iommu driver does not have viommu context, no place to hold the vRID->pRID
mapping. TBH. It may require other reasons to introduce it other than the
error reporting need. Anyhow, this requires more thinking and also has
dependency even if it is doable in intel side.

- Only report error code, but no device info at first. May adding the
device info (dev_id or vRID) in future series. In reality, the existing
Qemu vIOMMU does not report ICE, ITE, neither the SID to VM. Also, VT-d
spec defined the ICE/ITE errors first in 2007 spec 1.1, and added SID info
later in 2019 spec 3.1. We may do it in stage as well.

What about your opinion?

[1] 
https://lore.kernel.org/linux-iommu/a9699f71-805a-4a5a-9282-3ec52e5bc81a@intel.com/

-- 
Regards,
Yi Liu

