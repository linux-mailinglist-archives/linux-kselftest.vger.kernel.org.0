Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477377700C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHDNFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 09:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHDNFG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 09:05:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F549D8;
        Fri,  4 Aug 2023 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691154303; x=1722690303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=15PMzUNfl5GdLs22+epkf/Y31boWGTWsVemCl2EpGDQ=;
  b=Zsm36vSz9IpiJq7xgzZn7SkHPjCqgVkvQ5JrVMnxrmU2VS7WtmDdG1G1
   gFyOMffL9/lc/ZP0W5gC66ucmAkDsbI35UOsfD4uKnCdPqCjVbfeKTSo8
   k3SvYr3zGooo8h9zCHoOVf2+Z1D+z1c9S7xADYUpzGExnsV4mlkytZM6i
   2WvU3g/xspHAhabXJW1INzRKfHN+OVhspHgdTbQmp4uxdcpyeDpk/plqR
   TC3M7nmkIUNz8eAWvkD8jF4wDYih5V0Pywjs+x3ukfbMlT3eVk5GoiXJ6
   WkCVJgHF/qvvnPL4/YgpuiERF7SK/KRj4WZapLLvbkTPKOYv47ur1NS/7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372894783"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372894783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 06:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844081715"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="844081715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 06:05:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 06:05:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 06:05:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 06:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTYTrxDf7OyaiNnYaFQ7eGc5p2FA60mPeMRAgkUa6U30qC7Lm8ghCnBsnnLeJQwAaqhG1sDfDptsUYdoDy/Bqcji94BB0us8ujnIUbhF2+SP4LuZXCNWF7Ih1Ej0ZFDKX75rgLhPg8Lc3ao/4v/pBwcihbUHo8e/xMRkXslGMb+ss4SezXvH9RJJh7Ger71eprObFtIZ1BL7XefO/hbJ2AqEFYFz9FvJeG7bzS5yGcKzke3VkQ3OqI70AOM1uB3lsV0KX6+NGzEva7LBsWKmI0I/7BCmqHLAnP5Q31L4HEDuvQnc6xnHD9mMLiF1HhR1V1HDYcaSTp/HlHO1tTBp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KctEiXP6AVBTiTIpWm4e7NHlZOpuiFZ/HYl59XshlR8=;
 b=AYrts+H0PGOi1beWmwp0wttLdq75KU0BJWMfG7tb99iDGQdcjqD+LCBE6OQBRWeJU3598HjhO5DlDzlgc7KfMob1iT/+aR0ekAf2wRSqmD50MguONGnjzkNonGKANGDRcp+/8fLKSTU60J5Y8LFgBV8MPWqMeySR37evtPTsw2dH7g2dxS8GynXvJlkk9Ad+sky+abu5xky10VJgir+UANZIu+KqFPExnOFQ678pNzn5V9VEK9eBuMPIemrh7VoxRHdPD4VYxwPCSQIAGQyG4zvVdjwv1AdNcyebH8wA/S8hhRo7D6Vb7/8axKdTZNdreFxn8uJKzJ1D5ZkTn4F5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL1PR11MB5510.namprd11.prod.outlook.com (2603:10b6:208:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 13:04:58 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 13:04:57 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHZvh/vmslv1BsHJ0KI1gktitpb2K/WrSKAgABmfoCAALXhgIACYSNw
Date:   Fri, 4 Aug 2023 13:04:57 +0000
Message-ID: <DS0PR11MB75295187EE9B4EB64D8797CFC309A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
 <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMpei2/CffaW97iU@nvidia.com>
 <BN9PR11MB5276035683CE2AFB7B0F36D28C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276035683CE2AFB7B0F36D28C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|BL1PR11MB5510:EE_
x-ms-office365-filtering-correlation-id: a88991b0-f818-45ae-5aa7-08db94eb6773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5m9CiqpPEBt/gACMns3UbeDb7bW8GkW0fgY0fEuizS60MOF5X4Vk5ctCFXFvHF1p6fYZ9qLlTmuaMV3qg55X5ueDcLtNTgIMTUD1dlJLRLoI3C1BbacDs3UJBKmJ0MhxKnK5tvRcQg9T4+7eS3KxgxyC5LbO+ctRQgyITz5jTzN2lqyhQl/rtZCXlUaT8ti8myEQOa4vapWKFYjZx6lrtMTD3rjARKub9GHe3gVEBNPKdL16ZIjV44kPTZETo5Py0LpkL6x5SgYvrL92dkTSVu0yj4DljB9UbbUjS7n4F5XZer6YHmasqXYpq0RJB+gHrklyAKGdbLxU8qwi9eT7rqXk5w9HczNfOb7znFBGxZF+tFunQkoG8L50XPbr/ZcxtOGnNafgW9mvAaMc/r+hg/WD5NDFY8x0kQJ5vOxjx84nFBT3fYWFPc+E89t0lVwBo02tCpcNP2mpZcj3qqdmPlr8tcoxVNP3BkJYOcOLX03B/9/IHQ5kcEfl/xpNDfN8LVTXONZ9yOg8QTVCTH/wCEGGWZhM1emirCsPitlr86LQH2pakQ7wU+msjME/SsDe5csqM7Dah2zg3v9cbKpD4uni/1kXmMkdLvrYJzRAE4magkOW+z+Byw1SJAdKqxl8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(186006)(451199021)(1800799003)(66899021)(6506007)(38100700002)(122000001)(478600001)(54906003)(7416002)(33656002)(5660300002)(52536014)(8676002)(110136005)(64756008)(4326008)(66446008)(66476007)(66556008)(66946007)(76116006)(9686003)(71200400001)(86362001)(41300700001)(55016003)(316002)(8936002)(7696005)(82960400001)(38070700005)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AIRbiFu/cI43GD0pUbrGMy+JZ5rTb19IandyFNwKvq9VL3Ub8X1N8k4Nby+D?=
 =?us-ascii?Q?7Vw79pkMK9LZDXo8UyO4YbW2GuPL9FxErpv7RI/hIA/QGw6GO6zg/WOE4bNM?=
 =?us-ascii?Q?G1F/Ugx9t0oWhnQw32fmaZQjnb18s9azAFBFpy8wGwjxPxoK+sSjjg5i6WAw?=
 =?us-ascii?Q?n1D60Utm18ZH3wPDhNf7CWj4arlbzSKPUUwxIaUlEXsmZ5HcNU2U13IyRROm?=
 =?us-ascii?Q?xtqGS/9QJqPzN2gqbNNUfi2ygPhCtWXg0BIWbG3JQuYrJbc3YQgp5Bc/9KKR?=
 =?us-ascii?Q?HBY8TA/uSbxrAUUr2dy/LFeDUJlnqUgej93VPHB4kN4+FWbkOtlOVSB0Y4MJ?=
 =?us-ascii?Q?NE2DRkUZyIaqJlOojfsgXDeB3sLm61F2vb/LT+DQAaU2whgrHD5yacgma/AK?=
 =?us-ascii?Q?XSUvfb6WrINWd4DMHlLx8W/yEQtrdl9Rv48KNqfbkMn/fI/GdPVIxGpebauf?=
 =?us-ascii?Q?1cYs6TFZiOkIsnXBFJ93FzyU2m2DEZPeTJUkJjhlOyqbvWJ91jlLkFAnSQoO?=
 =?us-ascii?Q?30a//NVGZwGMTApIkX3eeZ+2kiR2N7ef6r1SmwwcSNM8jWbUSOgCMP+itkRX?=
 =?us-ascii?Q?8PjE/eqoLXQh7/WewxHLZDXe2LejdSe+qnNakTcsXdz6taSxNzj/pCvDU8wJ?=
 =?us-ascii?Q?qi9I4Re103zGjBfo6/BUZHK4rLImfn3zGxxkZYDPg00Xhn6oxyECOdKNRc07?=
 =?us-ascii?Q?3pOy+2eQmhZFWCM7adq3vs+KmNA66nyZV30SYkXNO5uqCEn+WQEca/AGey64?=
 =?us-ascii?Q?QzB1JrN46J9Nl0m/ureDumJ6Dn5X4u80A9mQLF3n+dwRt0nLYX1iWSq7ust0?=
 =?us-ascii?Q?6n1+PC8j2sGzrTNWhO8lKcWwVZL8efGoasa39bKjLa3dgDYCXIrAPz+/uruF?=
 =?us-ascii?Q?Qfr7hX5Ws9WoDcCu5IAU2/ZHckaQwTLJ8oNdFyvEtNUDB1sY2iDyENQi0OWU?=
 =?us-ascii?Q?w7wYPVQbN88xgFuJKbcXbjoPxKBDWtX+9xMYHATYQnvpafvmOLubpnjMXajQ?=
 =?us-ascii?Q?Xo8Kb1FtkZiCZvA1GUY/s+SD1dkSTMWOnnMLCa0y5KNAeUeJQYtNDf+88IRV?=
 =?us-ascii?Q?et0qdfIE0xU1t7C+HI/p0nDXm8NHvrslz6+9BUwENSEx2D+NrIq9wZIMOYu1?=
 =?us-ascii?Q?hnooBaHjwrLiPwlxxbaVqGk4i3d9NC1d/ULGaI5oWWmmU2c2FPmFFMxAzldZ?=
 =?us-ascii?Q?LLxnq9dzlRzPWLN0OS2JWxYBZfZaNIrvpqkeqV77tQ9y9IfmKecDwJIXtcvD?=
 =?us-ascii?Q?UoE23BkG3+ebh3Tte5DJ8MdwSp7IRBkWreS/ADYYBnHTJ5I8eW5eW89c3Jfz?=
 =?us-ascii?Q?Q41OO9HAQku4fZAOkEY97Tl6F1/VufefzfwEjuvQaGkjBsbOhCzAnHYSNmHF?=
 =?us-ascii?Q?snjStKZYeWxopUkmN5FpynFVqCxgbznMXFOL6Rab5/KAiXeKL7h2R6z9ISqv?=
 =?us-ascii?Q?H2fAxCvDPwmSdr3FmR/sJWgX1ZtupPqe8g0jUmTdIYm4KArfqXcHnLEg1zv5?=
 =?us-ascii?Q?2GZaBXZSefNHGWnMrIbId8kj7ELmCneSVKpB0o6aH3YGBGlk09tOAJn6cw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88991b0-f818-45ae-5aa7-08db94eb6773
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 13:04:57.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dTc6IQlXDNZFAZFgxmMWK0tjZdD4Xxw3I54yg8qU+c7+X1ogtx8lGkvJo4cGW54ryIEFaH461zpKWVVMykxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Thursday, August 3, 2023 8:39 AM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, August 2, 2023 9:48 PM
> >
> > On Wed, Aug 02, 2023 at 07:41:05AM +0000, Tian, Kevin wrote:
> > > > +/**
> > > > + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalida=
tion
> > > > + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> > > > + * @flags: Must be 0
> > > > + * @entry_size: Size in bytes of each cache invalidation request
> > > > + * @entry_nr_uptr: User pointer to the number of invalidation requ=
ests.
> > > > + *                 Kernel reads it to get the number of requests a=
nd
> > > > + *                 updates the buffer with the number of requests =
that
> > > > + *                 have been processed successfully. This pointer =
must
> > > > + *                 point to a __u32 type of memory location.
> > > > + * @inv_data_uptr: Pointer to the cache invalidation requests
> > > > + *
> > > > + * The Intel VT-d specific invalidation data for a set of cache in=
validation
> > > > + * requests. Kernel loops the requests one-by-one and stops when
> > failure
> > > > + * is encountered. The number of handled requests is reported to u=
ser
> > by
> > > > + * writing the buffer pointed by @entry_nr_uptr.
> > > > + */
> > > > +struct iommu_hwpt_vtd_s1_invalidate {
> > > > +	__u32 flags;
> > > > +	__u32 entry_size;
> > > > +	__aligned_u64 entry_nr_uptr;
> > > > +	__aligned_u64 inv_data_uptr;
> > > > +};
> > > > +
> > >
> > > I wonder whether this array can be defined directly in the common
> > > struct iommu_hwpt_invalidate so there is no need for underlying
> > > iommu driver to further deal with user buffers, including various
> > > minsz/backward compat. check.
> >
> > You want to have an array and another chunk of data?
> >
> > What is the array for? To do batching?
>=20
> yes, it's for batching
>=20
> >
> > It means we have to allocate memory on this path, that doesn't seem
> > like the right direction for a performance improvement..
>=20
> It reuses the ucmd_buffer to avoid memory allocation:

I guess your point is to copy each invalidation descriptor in the common
layer and pass the descriptor to iommu driver. right?

> @@ -485,6 +485,12 @@ union ucmd_buffer {
>  #ifdef CONFIG_IOMMUFD_TEST
>  	struct iommu_test_cmd test;
>  #endif
> +	/*
> +	 * hwpt_type specific structure used in the cache invalidation
> +	 * path.
> +	 */
> +	struct iommu_hwpt_vtd_s1_invalidate vtd;
> +	struct iommu_hwpt_vtd_s1_invalidate_desc req_vtd;
>  };
>=20
> I don't quite like this way.

This is because each descriptor is stored in the uncmd_buffer. So
Need to put the struct iommu_hwpt_vtd_s1_invalidate_desc here.

> >
> > Having the driver copy in a loop might be better
> >
>=20
> Can you elaborate?

I think Jason means the way in patch 09.

Regards,
Yi Liu
