Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A770EF77
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjEXHdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEXHdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:33:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF768F;
        Wed, 24 May 2023 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684913626; x=1716449626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0oNpebSttc8jt0CQoPqlpvbac8FK6pH0n1MH5O8TXeQ=;
  b=U1dC2gTo5jW6g5dk2gfgViIDSlUuYw1MF1JrhvmCLBnAn1xPnhxiM3Dg
   m5wmst5ROyQm+SpW+MMNW1Jas9uXN6uPCq91nFo4NaV+a3CkK2tmGvDzn
   f25EeaREKCsZWK8ds5ZJ01Q3x5P0CLiGJdIuMZo4r06PkxIPeeMdxdZyy
   maB3uEF7C4D8IgDtD0HQ1lpY9DQ+Asger997/ty5s7i70sSq4NZjRcqHW
   zxLs3Eqc26+Ref8RFV0eJhZYUnHhG6aL8HKBufZDNbMrd8i4FZqCrVIOg
   M/BTaZLzvqAaEWeDLwL6sNI8VVQmeCDU7bfEir6cGhzn0Ho4ozADyQFsS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416946433"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416946433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="735074480"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="735074480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2023 00:33:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:33:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:33:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGHMJaw63kVKNV6tugFZokp2WhXkuIwUUBS/Oh+nid7PE21n/JBpupKCZgN7SxqV1tKqsis3cljWLtb4uOny1Ny9P9WLcdWVEKQrhTALzGwXwrvsDPh8OG8Gtq6La8DQAsYEZsExk2ObBCFXRX8qjKwezRD3sg9IIs4NnnalqsC/6Ff1nKOsrboIgUdG1D2qB62GliQVGbjoyeYTuNw7SRG4NGdlga/emnCOVUWMLJuuKPE5buA17bDYC8nv4G15/SbNNTjp4gal32acbu0CZGecBqMjhaBK1FJnk4a1B68YlB4r8SNKal3oSZ53elLBbUG0shRVj49attcduOgF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tc/CXy5379TtOgziMzY/f9HzMHAsvpNBDuPK+7rNHM=;
 b=OVlKJd8Ci+JuYOqMNM8Vz0T4+HlJU27JGA5GUQy89WHxNqOyKIuGCF+FRLrOSMSE3NeelFLsaKKFMLt7H0XgzKvRAM7omlandbynAmtbJp4CVFabCMbRYpLZyI9egEaXgBdolDYmfD/4TVy8G2akx/Xajj2nELAqZVUqZf663JpJ9PGg3NfJfyaRUyjWaBIh1YUQhB8w6M7UeOsIZMer0KjlCADWlowyCZho/Gc5f17WGqGjuzW6cR7k+yGXK3s1L/EUF72vzLskha9LrLEfKymKMl1g8Bwr6mG8zfm43Gv4shmhnizSxcjGiDv/YL4CrQXK2bnxMsi34CESdz7UGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:33:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:33:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZhBgQjFIbgwyTRUizGAHHxi4eh69pGL1w
Date:   Wed, 24 May 2023 07:33:42 +0000
Message-ID: <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-8-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB8143:EE_
x-ms-office365-filtering-correlation-id: efcc19eb-b6ef-48d4-d55d-08db5c293321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHVeWtC6IrlsSYAk7enxsdJSVX9ta1YAHMGZbxSVdJykpD6euITTyHPuL3wo2iPp6S5VHtb/66yp360MRhE0FXUA+eqhWMZEqjoU85+tSTaV35l5d7tdYpgf4LBoHQyqzrO1MMjUembX64SOGKewIW2G+TqpBvPsPNxyHc1KkBP0p3qqx298xwfmwkRMgsfmcEkyH54nNL0/8puMsxReIW2hoXA+jghL2nWNmyDQnFVXZDsDM/TAUXe4+HzgM/6IbkizkCGu7wvVgUPiLymCUhgTC8HkyDpYnR1aHjql1CPmsd0js9S0kJNtI6kg5MYedjNxNJyPq66FBQ7XRyEBxiLTjWpSzuimTk1GWPrByXWFEDtoWkLxgMGOhd0Veh7CVQumIrGdcMnHBsgyn8uC4Mol2LIGznmIkMJ0GSfHNwY7ndRWPen3bV2a65dK1RSwbJYAwqU0NJIVABU0SjP4IrViXNjITbITW3238U+9Z+rOy/N6YHtB1sgHEoXksbyh/rWiPDTygzUAY8Gt4rrPLIOtJrMQMoPOWIzpV9gQbQNysn4VwOKf2JeD5BkxjsHzqM9OngYQOCt+WoG6l2FsHyPPmPnQPK6PZZBZsNxohSgsUJF8Ep0zYzeQNzQft4y4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(54906003)(86362001)(7696005)(41300700001)(478600001)(110136005)(316002)(55016003)(66446008)(64756008)(4326008)(76116006)(66556008)(66476007)(71200400001)(66946007)(52536014)(5660300002)(38070700005)(8676002)(8936002)(38100700002)(122000001)(33656002)(26005)(9686003)(186003)(82960400001)(7416002)(6506007)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NWi3VR17YKAVlphJrckdcvdpojdpr/iEBCYcA/ivFykMXYURRdFsDY2+j4Z2?=
 =?us-ascii?Q?6U6i9sUBSmltAhDPKPXm5fHuh/o/GaSACoudeK70w/iovNSc0TL8tqbcdzoo?=
 =?us-ascii?Q?muFGuWbWDLvyxMCt97z+Y69zweXT9bcJgnshmqumQ+QmPCFw4wqnpkrQBA6H?=
 =?us-ascii?Q?68YTeyVFMOF2Ev6YY0xLoVd6SsEa+KD3CgVHq+MwSLf0tdN9MVgZJIjLaSgk?=
 =?us-ascii?Q?p7x7o3/btPzeUoGPgeIM7mjnp3Hu00BuwYsmUGgVt9fZDuY6Eq7l/htNZr0S?=
 =?us-ascii?Q?waG2D4sm2M70ySS/oyivGLpRdYTDSAHaENmCURz7EIK1JzLsfeldfjYShuNR?=
 =?us-ascii?Q?TXRpME9ltphe9+TPDlxG4y+5CL+lMcwxLWQa9UvjY0P09/QdrIDxQvVXH6Nd?=
 =?us-ascii?Q?79aCy5GT/Ns7+byF1EKP000tMHuCWflooHS0Y6pm+6QtZoJhjqXtZKYOU5rN?=
 =?us-ascii?Q?eJcSHUkhAHXrA8WLJPjtgJE2b6T2Hj7J/ImqJcGdYj5C22WmjjtUpB3u3TgA?=
 =?us-ascii?Q?empfzsyFS16nHHH1QTweMAFYL2wLVFnD7k2mTPOuKWC5UOngRpSvRe7nuwFM?=
 =?us-ascii?Q?VX5c8ei1tZWShXkIDf+OuA0gt55bDb2zzCqpFm1sSIXfx+SB9+RWtQHsFNIG?=
 =?us-ascii?Q?Pj+dSi8vdH8AjXlKh376n9UULcsCc5B9oyIqobgt+Bnz7dq+VlSB9gev2W24?=
 =?us-ascii?Q?5O7A5Y7k/CJJcqsxiWJ5EfxnsVekDmfUKRwokT93H9qb+cmrd0GTYARgodj+?=
 =?us-ascii?Q?CsG4Q1uK+sCFPjjxHsfZMbTurn2YkvngyRT6+mxxCMqaBUWmAtmgD3RQ59nR?=
 =?us-ascii?Q?nsFxTSm5NY3Abt5iQR9zCrmcbd7Uo7x2zefaCbeSnRm6OtBBberruYtvOFjC?=
 =?us-ascii?Q?07wRy3rr7ig7hwTk1kECHCo8/trQ97ukvPpp1ssrit3d5rk2mM/f+7tSsFbe?=
 =?us-ascii?Q?iBOTpYotEEa9BPW8u1sPNCjoeW6QOidOIn0uKuGbKubA1o8IfhAf87Khxp+v?=
 =?us-ascii?Q?gwLq1P+4+0jnNPRu/vEbz7YmKn9FN39PHqTMJsiZ9cSw7E9bES8ik8wFGjVr?=
 =?us-ascii?Q?hbecPpFFXDQHfGJkcJztYx5/wLwqDNNcxreqRbz0O6/3u2RilRiM/mwdmNZN?=
 =?us-ascii?Q?+/Qf/dmQWSxBkBz2Vvkw+5JeuGa/XZQd0RUrsdrB1HSqAN1pAQRU5pWb0C0Y?=
 =?us-ascii?Q?qKyvG/Y+CiMoHeUO2gehmL71wVaNPX+pJS8BNiM0SA9O40iiqAR2Orsw2nRO?=
 =?us-ascii?Q?XZJC1MJP5nZoWII492ibBoPIZ6OE3q6qNASTPCClwyn3gHhGJlWYbd2EvC+N?=
 =?us-ascii?Q?yi5hNwvhsjxD5rnh/JQPxojO34MdCZqCQBozdbtLaGspDuNwIB6wnqqxfv/H?=
 =?us-ascii?Q?YV3Tkd8A9UJoRpVkjjDp0s5aFkDw+DjCzHtwWmt2aXLk+1atEgVeNCSeHL1J?=
 =?us-ascii?Q?eWOQUDzJGq2+V64XNZeO874dfQDYyt5yyBZT/ME1wofXlKoShKPnHywy2rc3?=
 =?us-ascii?Q?nXJ6Z51iwAoW3fuiMbQLo86VNWKyfzqJPrLNezzZD7vva8I8UUAHqNcYMoJ0?=
 =?us-ascii?Q?O5QiPK9k/NFuO4JYzQ04zBeQsFqFFLv2MEv3hJO6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcc19eb-b6ef-48d4-d55d-08db5c293321
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:33:42.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bysw+D4j+hsf2YNrMRVCwKWTh12v2XBmMzfBPoD1PG62RsJL0YvA+xxlpQumdr0WK/I60c8irdRE/25sXy8sNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
>=20
> This is needed as the stage-1 page table of the nested domain is
> maintained outside the iommu subsystem, hence, needs to support iotlb
> flush requests.
>=20
> This adds the data structure for flushing iotlb for the nested domain
> allocated with IOMMU_HWPT_TYPE_VTD_S1 type and the related callback
> to accept iotlb flush request from IOMMUFD.
>=20
> This only exposes the interface for invalidating IOTLB, but no for
> device-TLB as device-TLB invalidation will be covered automatically
> in IOTLB invalidation if the affected device is ATS-capable.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Following how you split patches in former part of the series this should
be split into three patches: one to introduce the uAPI changes, the 2nd
to export symbols and the last to actually add iotlb flush.

> +static int intel_nested_cache_invalidate_user(struct iommu_domain
> *domain,
> +					      void *user_data)
> +{
> +	struct iommu_hwpt_invalidate_request_intel_vtd *req =3D user_data;
> +	struct iommu_hwpt_invalidate_intel_vtd *inv_info =3D user_data;
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	unsigned int entry_size =3D inv_info->entry_size;
> +	u64 uptr =3D inv_info->inv_data_uptr;
> +	u64 nr_uptr =3D inv_info->entry_nr_uptr;
> +	struct device_domain_info *info;
> +	u32 entry_nr, index;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (WARN_ON(!user_data))
> +		return 0;

WARN_ON should lead to error returned.

> +
> +	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> +		return -EFAULT;
> +
> +	if (!entry_nr)
> +		return -EINVAL;

Having zero number of entries is instead not an error. Just means no work
to do.

> +
> +	for (index =3D 0; index < entry_nr; index++) {
> +		ret =3D copy_struct_from_user(req, sizeof(*req),
> +					    u64_to_user_ptr(uptr + index *
> entry_size),
> +					    entry_size);
> +		if (ret) {
> +			pr_err_ratelimited("Failed to fetch invalidation
> request\n");
> +			break;
> +		}
> +
> +		if (req->__reserved || (req->flags &
> ~IOMMU_VTD_QI_FLAGS_LEAF) ||
> +		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		spin_lock_irqsave(&dmar_domain->lock, flags);
> +		list_for_each_entry(info, &dmar_domain->devices, link)
> +			intel_nested_invalidate(info->dev, dmar_domain,
> +						req->addr, req->npages);
> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +	}
> +
> +	if (ret && put_user(index, (uint32_t __user
> *)u64_to_user_ptr(nr_uptr)))
> +		return -EFAULT;

You want to always update the nr no matter success or failure

> diff --git a/drivers/iommu/iommufd/main.c
> b/drivers/iommu/iommufd/main.c
> index 39922f83ce34..b338b082950b 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -282,6 +282,12 @@ union ucmd_buffer {
>  #ifdef CONFIG_IOMMUFD_TEST
>  	struct iommu_test_cmd test;
>  #endif
> +	/*
> +	 * hwpt_type specific structure used in the cache invalidation
> +	 * path.
> +	 */
> +	struct iommu_hwpt_invalidate_intel_vtd vtd;
> +	struct iommu_hwpt_invalidate_request_intel_vtd req_vtd;
>  };

Can you add some explanation in commit msg why such vendor
specific structures must be put in the generic ucmd_buffer?

>=20
> +/**
> + * enum iommu_hwpt_intel_vtd_invalidate_flags - Flags for Intel VT-d

enum iommu_hwpt_vtd_s1_invalidate_flags

> + *                                              stage-1 page table cache
> + *                                              invalidation
> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
> + *                           leaf PTE caching needs to be invalidated
> + *                           and other paging structure caches can be
> + *                           preserved.
> + */

what about "Drain Reads" and "Drain Writes"? Is the user allowed/required
to provide those hints?
> +
> +/**
> + * struct iommu_hwpt_invalidate_request_intel_vtd - Intel VT-d cache
> invalidation request

here you put "intel_vtd" in the end of the name. let's follow the same orde=
r
as earlier definitions.

struct iommu_hwpt_vtd_s1_invalidate_desc

> + * @addr: The start address of the addresses to be invalidated.
> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 ca=
che
> + * invalidation under nested translation. Userspace uses this structure =
to
> + * tell host about the impacted caches after modifying the stage-1 page
> table.
> + *
> + * Invalidating all the caches related to the hw_pagetable by setting
> + * @addr=3D=3D0 and @npages=3D=3D__u64(-1).
> + */
> +struct iommu_hwpt_invalidate_request_intel_vtd {
> +	__u64 addr;
> +	__u64 npages;
> +	__u32 flags;
> +	__u32 __reserved;
> +};
> +
> +/**
> + * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidatio=
n
> info

iommu_hwpt_vtd_s1_invalidate

> + * @flags: Must be 0
> + * @entry_size: Size in bytes of each cache invalidation request
> + * @entry_nr_uptr: User pointer to the number of invalidation requests.
> + *                 Kernel reads it to get the number of requests and
> + *                 updates the buffer with the number of requests that
> + *                 have been processed successfully. This pointer must
> + *                 point to a __u32 type of memory location.
> + * @inv_data_uptr: Pointer to the cache invalidation requests
> + *
> + * The Intel VT-d specific invalidation data for a set of cache invalida=
tion
> + * requests. Kernel loops the requests one-by-one and stops when failure
> + * is encountered. The number of handled requests is reported to user by
> + * writing the buffer pointed by @entry_nr_uptr.
> + */
> +struct iommu_hwpt_invalidate_intel_vtd {
> +	__u32 flags;
> +	__u32 entry_size;
> +	__u64 entry_nr_uptr;
> +	__u64 inv_data_uptr;
> +};
> +
>  /**
>   * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>   * @size: sizeof(struct iommu_hwpt_invalidate)
> @@ -520,6 +577,8 @@ struct iommu_hw_info {
>   *
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D+
>   * | @hwpt_type                   |     Data structure in @data_uptr    =
   |
>   * +------------------------------+-------------------------------------=
---+
> + * | IOMMU_HWPT_TYPE_VTD_S1       | struct
> iommu_hwpt_invalidate_intel_vtd |
> + * +------------------------------+-------------------------------------=
---+
>   */
>  struct iommu_hwpt_invalidate {
>  	__u32 size;
> --
> 2.34.1

