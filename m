Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43E6CD7FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjC2K44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC2K4z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 06:56:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD323C1E;
        Wed, 29 Mar 2023 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680087414; x=1711623414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5DmFfmFsO8Pd2/I+qOGT5SSHO/a050J9MCGScP6nVpQ=;
  b=E3cer28gXT39igkm+7scrp/cyy553XDX4Bgld5lqTQtMhT8sFjz2ay+Q
   Qnk3M6hBpr7biTinWzIZ9zxkh7wS6i+yql7h8MhEbLAzxOLHoOyqvjWoi
   BNKeYrb1MyGl43KKabMku7U0UULwiOpO0XmZKdAbCbHBZx3R+pqBddBlV
   L6AVRYzEeq3tLo7seGk2gTMpgazix+wWfy3vC8D/JkdRY9WtEt3ienNY6
   87tZk0Ytxv4bgmCDX56qn6deyvAstFOCnoaMBWa32gRVYNZOz4AhalQdi
   JWxQJvdM4EAf/p6C4/dntPOHfwB+UIx44gDQWQlDrtRjU0UPh+ob1f2pE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427119333"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="427119333"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827847007"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="827847007"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2023 03:56:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 03:56:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 03:56:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 03:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0rywSJTfMoTPSRu6YoHmFKpyT6fCIZHM1K0DwPJ0MK5UfnrbBdXIFRc+ecGgUliho9dA5er4xI2v7a8xFX1RpQM29iF3tS48E8xaF89u0cbn/ZeZwCv1oIbF7nscGSYoRe6delMVPHVPLNVmPiHyiG+VEKMFjsdf4nUEatBnA/g9uD+gIKLhEgV7koqfMPd/CxCJXmNMYJgptMTOqyGKQWV4Vp7uick1NGDqMvZpMADkErwib8NwtVl+ey3PThqnfTlQBJPy/1cpzEPaGYqMZJVCoAvBuClICpCDwIZ8gtySHmgYDeqnLlPQlr3xtkutR/Q9ophbrTcagViIRfNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xkOnTlurtOWgVxSllSpU5TTv1REicWFcuPaH7WMkC4=;
 b=odB+2tnkSK0+pfrFPK/T2PE2IVZXhGgP4mELp0gRB2/LSQLIkEnQ8OVsRTXGjzlgAt2vnQr+zabHLc17REuHh40+M2YFVEDT3Dnqig4gxdGdZeoa0Y9E9EVDwFXzgXDre4FNKtR4a22UMjBvMbAdmu6remwmSN6ToXbnfAIsWghIoYh30wLMk9zAT6DfVOEPZfZABa7whSk14aBMSXeHJNo+zRBbNrG897ucqrV/LzIA/yQYhjONU3d3oMdjHjpKM+BQ8ZN2WUHgJ/gH3JavuEn16nNcdEpdseIA9VzPk3EfuM+C+unF9dguyQif+cDJcS1ZoIb6jEjT2SCam5ukUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7882.namprd11.prod.outlook.com (2603:10b6:208:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 10:56:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 10:56:51 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Topic: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Index: AQHZUl58hBquGls480Cb3bmOyMypoK7zMXMAgB6BuFA=
Date:   Wed, 29 Mar 2023 10:56:51 +0000
Message-ID: <DS0PR11MB752971FAFC09274541BB89A3C3899@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-2-yi.l.liu@intel.com> <ZAqAJgoQ3f0L2Gfo@nvidia.com>
In-Reply-To: <ZAqAJgoQ3f0L2Gfo@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|IA0PR11MB7882:EE_
x-ms-office365-filtering-correlation-id: 5b67d13c-5e63-4c97-8aaa-08db30444d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJI1i0jMhVrpuUBAS7ysdJCye7BllsHYzm5rE2kpirn7JsTGxlT7lOJcm4ds7r0bL7/Nig7G07FVINfEq1/l4dfEKVS2ZT81FaSv37+jr7akaNy/Gvb0gQoAu0TD8Awz3+J8W6JvsrEqDS0SB/Z2QOqas3P4KrrWBNc9PUGKcW+ifrqJcVHS8ccdRe86gpof2lBK8E4z1GPvNngWo2jFQ+GXWJDHAk1MhEZ8DyYLyBSt7JDWI7V/bOiD7EBVxCIo4kt4iNSlPx9xNlCBvGLBmmwEW/InaHClz64NYi/2mJEcSTNE24cDgCiyxe7dyTRbE8VPL3PvrEacMzxZFBHwCi1/W6WtujgZsbFtWgvhdOpXJwHFoICW/BNPyAjgX3GlbPzZ66eT2ar8nUUAJ5ysfeyROsKKc4Gl7j8WtSoBZl9jauUBJWx2Jps7PrkiqgYe9+mK9A6FsEwQG9mzUlXm+593wG/JogP88bMVvmx7eZALJ2ycJPeP6qRTQfcycpTO89Y8bEfOYofoBWdHNtet/JK88S6KSXfA4YoQ55Et73XpWtB1b6G51Mpa8nPrYkNG8AW1WCiHZBAG5Prpi/N+9DB1rf478pccE7Leym9x8PSsOI8Z0w1L84EJ4eH+M1NS8iUfisEAhzmmyj5NgN6sjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(122000001)(38100700002)(71200400001)(38070700005)(9686003)(6506007)(76116006)(5660300002)(64756008)(66446008)(52536014)(41300700001)(8676002)(7416002)(4326008)(55016003)(6916009)(66946007)(186003)(66556008)(66476007)(83380400001)(33656002)(2906002)(26005)(8936002)(7696005)(82960400001)(86362001)(54906003)(316002)(478600001)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMdEaTqbnux5tlKNAbFJdP6nY76yKbhpVvLPelqAGinha/ElqmHSqQmcvJfk?=
 =?us-ascii?Q?ZyxfgTUhe2JAlsAGydBZh3SLfD14kAGCOyDS+xqhitTmoxcs0M5cX7S+gyo9?=
 =?us-ascii?Q?myVMWfq3ewGCIzoybC3SpMmo7MQWwYHo3JRafGKbVrRsFcHDOtb/8JavyJCG?=
 =?us-ascii?Q?DhgVgOThuEzGDozEtvt5yGB17VLgDXiMKo/shPVI9DpSdJVuUDe+k83OXTcJ?=
 =?us-ascii?Q?JVZpPYpoz4su89objimMu86mAO25JyudP59cWJ3i0VofdDdB5II054UOpfql?=
 =?us-ascii?Q?sT0LuXZFKZccuibEmv286SGHmY69AjNc2Br5zwH+vnaTWtz++CnigRZHv31r?=
 =?us-ascii?Q?T7vu6WDw+3RbVBPEPt9PdYfp2v8qJTTX774JbESAl/wZmCINtB4v+GNv3xGB?=
 =?us-ascii?Q?N8CJebL8iUI1W2V3KdsX5G3C/2gX36FZLsUUIw8BJqqB43ay9G9TEHIKspZn?=
 =?us-ascii?Q?63RSSFtnNrRWtL1Mr0RnNqH4z3JSPf5FFYCm94nl+9fXLEvu+mgIzDbyCbJP?=
 =?us-ascii?Q?0McEtnBTD3qxoBAhQym/PRh5qeRPeBnAF7aOK0gcYzAupnYO4ou7FSVELSej?=
 =?us-ascii?Q?JvcqoTIAponjjdLO7mayMLUOPmrFcP4V4xWNVsrvNPWPE8Kx6dMs77teMJp3?=
 =?us-ascii?Q?x3dkEY+Nieq8G0PnSaN8M94fgpbt4TozNE4rIj6FO6zdsucpY2EF9qfn42Hm?=
 =?us-ascii?Q?I1SZnywmHOfxNLw2MdZHfKicr91pD7P2+jYtEXXvXt3sNLFUWFag9VOJ+36t?=
 =?us-ascii?Q?SIZnTbLMp36Lqv/cjGJY7SydNqrJ+R0ZLZhveAmKb2jOhlHtJ/mlZc5AZae/?=
 =?us-ascii?Q?aDVK9+ss7LsAbVTKzmWZ9WqIMQbI7JyKzJLm5Nq0ozr1wQ1GaWD8UFVpf10c?=
 =?us-ascii?Q?bBEFp+S2ZC0mGSusOv4uOomasuea5rmOEBNJhgIpaj8YAPT5GtLvI9xD27F3?=
 =?us-ascii?Q?tO35oWDsrsxVUKIqvklEH8+fAk44s+OsDyDsvPX3fEiRRuZSG75NHVWtJule?=
 =?us-ascii?Q?MBV3mgxmi3ovrSnn1UeyK/Xr4DyAgcl6KodnPRP63+HFAYSRkhO2MBCNQ/fA?=
 =?us-ascii?Q?se3lfda0a5nxGmKmwksh7K1BgWLDABWs0dQ6PeNhk4bmN81NOtU2/2gC+sYR?=
 =?us-ascii?Q?gW9NhtByeNDux7a6utMTAwrLQKnSSzkeDz5eacH5k2dAI37DMoret5F0D5p7?=
 =?us-ascii?Q?25dgd8DKmRGsX0JDDCY17xogJBw15kNEYHMUgIGEie9VHPcqjmJOtXEXpFJK?=
 =?us-ascii?Q?0k8AUnMIUiOVvQUjbckrRbNVU3Cjvp1LSGvvX5qJySMXcaCnOLrqmClrZvZ9?=
 =?us-ascii?Q?IXBKxH2novc3MqdhVmsLgXoZrH6FukbgEhwG4D2tQNtJpdDAq2WpTC4DWNxo?=
 =?us-ascii?Q?n0UvSDMgPY2FzAaS3MSCmOXxBrmR3ouNk9J6ORWWkwWEsb+2v5anXEOrsSSk?=
 =?us-ascii?Q?qt40n+Ys/c+TPbbjE3Ys7jnlHlJFexvPzaz2FkoyCpAMi+cXu1fIR3eDUcEX?=
 =?us-ascii?Q?GMK6jFN/IfWSOK52Z37O0BxCbwN3QcZ/ZApD71Zm9lSDIN/ddRyyF3XKWLq7?=
 =?us-ascii?Q?Y9ffijI5Lh/IHb0mZ3XuEHCdt3oq1lA6rGT8vOsl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b67d13c-5e63-4c97-8aaa-08db30444d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 10:56:51.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOZIkgRPEW/+elAEirJ4a73QmszEeQYnFltCA3a6ZPejv+omyNecxpJg70p1KLSrUD80LZ5J7p5yccrbrBs1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 10, 2023 8:56 AM
>=20
> On Thu, Mar 09, 2023 at 12:08:59AM -0800, Yi Liu wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 3ef84ee359d2..a269bc62a31c 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -229,6 +229,7 @@ struct iommu_iotlb_gather {
> >   *           after use. Return the data buffer if success, or ERR_PTR =
on
> >   *           failure.
> >   * @domain_alloc: allocate iommu domain
> > + * @domain_alloc_user: allocate user iommu domain
> >   * @probe_device: Add device to iommu driver handling
> >   * @release_device: Remove device from iommu driver handling
> >   * @probe_finalize: Do final setup work after the device is added to a=
n
> IOMMU
> > @@ -266,6 +267,9 @@ struct iommu_ops {
> >
> >  	/* Domain allocation and freeing by the iommu driver */
> >  	struct iommu_domain *(*domain_alloc)(unsigned
> iommu_domain_type);
> > +	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
> > +						  struct iommu_domain
> *parent,
> > +						  const void *user_data);
>=20
> Since the kernel does the copy from user and manages the zero fill
> compat maybe this user_data have a union like Robin suggested.
>
> But yes, this is the idea.

Ok. so it's a union like the below, and in this patch may be only an empty
union can be added as the struct iommu_hwpt_intel_vtd and
struct iommu_hwpt_arm_smmuv3 would be added by the vendor nesting
patch series.

union iommu_hwpt_alloc_user_data {
	struct iommu_hwpt_intel_vtd vtd;
	struct iommu_hwpt_arm_smmuv3 smmuv3;
};

Regards,
Yi Liu
