Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184387755FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 10:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHII6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHII6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 04:58:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CB10C8;
        Wed,  9 Aug 2023 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691571498; x=1723107498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0SsNwAyOhlJMsghB1YB8Oq+7aziqucYWnZwHk2NmCgw=;
  b=kGbVAhylCAE866ANlzfsWFLBwtL3UHUB48g4RijsZvUdf1kSefs+VX/a
   JJbQHS8gMorWDpDWeyLBK8HqOzDkgyywENy1n+lWKiDc31legH+6XuWxY
   E1Y17ZSwyYICE1A83kS2fCme01/3Rnx7laOnwDoTAFRRTdT6OyDzYJT6U
   Mv1hZOqgQd5VLqIBsRhWNh3eJxyfteN2nd4PTCFB8YdquEd5O4d9MUQiD
   0rqY68GKmeOCBQUKQHXmD49ydA/FItQT0gEy80+W9I9XFtJySqD9nwUzk
   xnBxW0a9RRt5W3qaNYuB4enkL2ACTYVWw/3QNzBHhFdIPVntrPSiXPJD5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351377997"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="351377997"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 01:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062384478"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="1062384478"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 01:58:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:58:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 01:58:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 01:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDo6g5AKW4pahWBJYzBMzPBnlUSfkAyLH3WZi2N+WTRaFnNcHnppjYh1nbPvcM2lcRe0eKGHlCzoq4ZLp5vm0ZYtgtz8jsewVIgjeAbxBumshFjyWUUcOlPUcVFlFb3wCw6JImo01PpN9TsaKpq5o318e60UyyTDHoXo6JvojoTJ82dWBZPa1yS1oC2FPy2nDn1g/IMi3S5HxFc5263TIRmWxtnT0EA6QI3dytf6+g5+VuJ4oEciVlHcThyChACZ1s5Ixj3yR2OddHgPYwfrW3VBcbfhltxSKQ6EURXo6WhW1wauIsOfWZruCAjq0OoXR0AENDOird8R9sthJh/Cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ekm/KnlkrJA/lPwqT8MMkjx3/V1OicVExloH3+syQE=;
 b=Pe6x/6rnPNT5UvBB0lK4KoucL2BS9OyAWQTxrTBYC0/ApdjYXiDLSCdx19ap9Y2/N72zSuQs49CYD2/+1x9z6f03hUnoE+PNYvy9hFwRvJ7OagE3FL0ccezFPb0ynUlhmsrS4OqcqN2MkMhO6fxZD15TzEdrwhWLiTz/D9AaBw0M6Xq2uyfpT4JcblJq7XmtiIg6Nb0asEz9KyZyvxpPUvZbfco1pSg9KOb59s4f6aSj6y5fvZ/YP+s5ZUixr422Y9fCRApp9SOi4baLlkQu6N69bmmmS7FXLcj/N6HPYZJspi9CBCZxtgLOk3E7ktm0eJM3qRPMBR7Hj/2jZ8yBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 08:58:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:58:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAhYJoCAAMpSgIAAnN2AgABV8ACAAPMnQIAACsKAgAAAQaA=
Date:   Wed, 9 Aug 2023 08:58:09 +0000
Message-ID: <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO6PR11MB5571:EE_
x-ms-office365-filtering-correlation-id: deb1b38d-5295-4502-be62-08db98b6c13c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qn1rQMxKuv0i0ne2tA33uUBn0UrPFf8Zxh+NUSOWiN7pHojZxKpR4VcZVhJs23amQo9ipvWt53ji/itaCn9BoMrH6Ws5UnlH44vcFqGMQu+3o1CJVH8XhY+0dIP3lYRSPoQRnk+28AJgCQFub86TRekXBNkMbaSKrCxy1LTCYGxI2UDVYtQNDACRQ84eZoFJr1ZcSYRIVOgEprLQjJ0Sg+H7CbprewG7LLydu7kkriC2QDXMCagMfRHvngvCRxUSGctioFb9OM5W8ss6hpvWmpKDNsEYzG16yg4wxHc8yfSv1G4DXdqq8DSBeGZYiu2ya1d5nMZEulyRqHlhDm1yvc/+UPEcmwBG8HFHdqpoa+eS+WjtWtaE5RmFgWSL0gi48+LUjLHh8gaz3GHt2FjDmKOi9e2YsHCSUzMlznv0xbmYs1w+gQwR7y714iH3Y4olomb2QWukjfQHHOyMyZkEB4DSaMyTldJ8Tf/h1IvyN/Ns9h/FkwbrPCnpSrmwvJH11MEF+H9UxNjt2k9m6x+qo10Hlodtkq5BWe3rU8hodF/gXu4LeuCyZKpHOajpr+L8yYfLWjWhNCOfSATWVGJm2RrMV99Af0Eq6bUPJ/M1JlijVVZqNM/Tk6UPJlQeo84t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(186006)(1800799006)(41300700001)(7696005)(71200400001)(38100700002)(82960400001)(122000001)(33656002)(110136005)(38070700005)(478600001)(54906003)(86362001)(66946007)(66556008)(64756008)(66446008)(66476007)(4326008)(76116006)(2906002)(316002)(9686003)(55016003)(83380400001)(52536014)(5660300002)(6506007)(8936002)(26005)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nK7K4hiFACzCdplcJP9vRZLIKOcYqCKN9HGYYmKE/346JxeYAEv88SFbuExR?=
 =?us-ascii?Q?uGk33WbtDYrQNtvvCkVHYEoxpwfb0SsZnFtLrk1b/FIG7vsZHH/Wh6NzYPWi?=
 =?us-ascii?Q?1MBOmp481UmZdN/0GPXOxG9gm5ToOtEw9Vyny/wIxIgGDaK5Xu3KBG+64ZFS?=
 =?us-ascii?Q?5wu6BJcavWVdoVXQGHvJ7C9zbmndEPcnObc59vIUCqBiZ047sRAwn+bloaQ0?=
 =?us-ascii?Q?M+Fm4x1Y5gX1VS6YwYjrzloNUSFm9IF3v1CsWeGmmFY3vgNrXOePDyBKXzyF?=
 =?us-ascii?Q?YBkrwWoDLEQ1TTA9tElXmm3kF1Er4kxiBNRCijgsmjiTbuuZG0k7gYJP/4Rj?=
 =?us-ascii?Q?eUSqWZLM3NhY+BbXuOHnwtcDFZ5zE8l7iLJdqw572cLFw4fXjY2MPZYhRjd/?=
 =?us-ascii?Q?LXVpX168CyiyIwlcj7AVHbQrZf0qXuTr2z8/3Q9KFZNnUbUfcSD+7iVwErZ2?=
 =?us-ascii?Q?8qbqq5mlyp05SFqeVwIsVivuW/FkF3qY/c6wY20AZlec2f9c55BlpXCrUyt4?=
 =?us-ascii?Q?rvUaM65i/nill+krlrjbSN2IRsN+c/2bQX/y+q/MXHutP30cgOQzw9spPprL?=
 =?us-ascii?Q?QPRIegf2mraLzWtRVtqZvccoBNxCEMhpfJpCGe0FRWP4z7Rnmt7uQGJF6EKC?=
 =?us-ascii?Q?2yUrmbHQuN8zf8f6qfolG+DzxM6jHZ7RS4JlD8cUVulsQKOV4zjAkafk7/1A?=
 =?us-ascii?Q?NiNHhwnfuwEgLJTfxFU206XB6m/iu5OHR5hWzq3BxareI7cvo5xIvX3iFl9h?=
 =?us-ascii?Q?soF9EhmlVna7IRarrZfImlIXTm1BcDTxgt2FbS0gGpuTVa13e+CMWmO8yGE/?=
 =?us-ascii?Q?N5izuv5L9lsvH3UbeJi0gIMZfCbL+QOmCJcr6AauDcUl/zXZGkJoF832DBdw?=
 =?us-ascii?Q?AvKXmyERY37tYLmuauE9Us55LKFe+yWMcMcB8p65h1HdRQELG/cPpWVboZzB?=
 =?us-ascii?Q?EkxvBKx5DyW3I5rI4DBOMG6RWKsVOW2lRzeTNTx1rWEPQTYdx2k0cpX5uvbW?=
 =?us-ascii?Q?wKgHxP4jIcDGhAIyhZJde+vP7KbBUJWevHDEJvfivdyDxwrWfO+psWSMKY9h?=
 =?us-ascii?Q?AHW+hYYHELYd29TyGcspVXoNRoHhxWvBQ+En7OwIMP0WSahO5bAKShqwEs5e?=
 =?us-ascii?Q?njve5Cu/NQB3VQCOxcFuUh03DJ2M55Z5CCW/2Ffxv5fZakbSfD9gBRgki1X5?=
 =?us-ascii?Q?kYJ4mwEzgY/lfcKR9UONr7u2Gs5pRfjbEYziK+2ouTQNLZdcT1pCaYQhk0Gx?=
 =?us-ascii?Q?te9o/vhASZni239+3HE1iOHl7/nzsaHc21IvRJCOO0bwUZ5GzrNQRZrc4oWU?=
 =?us-ascii?Q?hyiouha3CEIubiHhAjYd5NQqP0A9GxcERee5Ou7Lhrc+jBvHVxyIGnobRj7R?=
 =?us-ascii?Q?83ySeWbU9QkJjcEBBH8DWdRB0tidmhzix4HhBgRNZ7azrKX2WSNgt9R5Akx2?=
 =?us-ascii?Q?WjkiRTo6GreOI7chmnI3tbkbIj9VC94SqKIqst8YiZTSbRtuiNLL6D7stTlF?=
 =?us-ascii?Q?zbM+JpB609IURKl5msvWUmt5ItQqWSTKRQf34nWrVTWBXlDCFGluw3KZsvr2?=
 =?us-ascii?Q?OeNDan8wPGXd+2YdIJtS92Ecyzj/y5ATCtixKZZK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb1b38d-5295-4502-be62-08db98b6c13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:58:09.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Q+85zSviS9IjyEQmgJkCZXFk3u9tWomBVa6bDHm0wz2fd1VwuDr3RasSePSZuAs04rEVXWU7FWnCPmv6KM9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, August 9, 2023 4:50 PM
>=20
> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Wednesday, August 9, 2023 4:23 PM
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, August 9, 2023 1:42 AM
> > >
> > > On Tue, Aug 08, 2023 at 09:34:03AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> > > > > On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > > > Sent: Monday, July 24, 2023 7:14 PM
> > > > > > > >
> > > > > > > > +static int intel_nested_cache_invalidate_user(struct
> > > iommu_domain
> > > > > > > > *domain,
> > > > > > > > +                                         void *user_data)
> > > > > > > > +{
> > > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D user_=
data;
> > > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D user_=
data;
> > > > > > > > +   struct dmar_domain *dmar_domain =3D
> to_dmar_domain(domain);
> > > > > > > > +   unsigned int entry_size =3D inv_info->entry_size;
> > > > > > > > +   u64 uptr =3D inv_info->inv_data_uptr;
> > > > > > > > +   u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > > > > > > > +   struct device_domain_info *info;
> > > > > > > > +   u32 entry_nr, index;
> > > > > > > > +   unsigned long flags;
> > > > > > > > +   int ret =3D 0;
> > > > > > > > +
> > > > > > > > +   if (get_user(entry_nr, (uint32_t __user
> > > *)u64_to_user_ptr(nr_uptr)))
> > > > > > > > +           return -EFAULT;
> > > > > > > > +
> > > > > > > > +   for (index =3D 0; index < entry_nr; index++) {
> > > > > > > > +           ret =3D copy_struct_from_user(req, sizeof(*req)=
,
> > > > > > > > +                                       u64_to_user_ptr(upt=
r + index *
> > > > > > > > entry_size),
> > > > > > > > +                                       entry_size);
> > > > > > >
> > > > > > > If continuing this direction then the driver should also chec=
k minsz
> etc.
> > > > > > > for struct iommu_hwpt_vtd_s1_invalidate and
> > > iommu_hwpt_vtd_s1_invalidate_desc
> > > > > > > since they are uAPI and subject to change.
> > > > > >
> > > > > > Then needs to define size in the uapi data structure, and copy =
size
> first
> > > and
> > > > > > check minsz before going forward. How about the structures for
> hwpt
> > > alloc
> > > > > > like struct iommu_hwpt_vtd_s1? Should check minsz for them as
> well?
> > > > >
> > > > > Assuming that every uAPI data structure needs a min_size, we can
> > > > > either add a structure holding all min_sizes like iommufd main.c
> > > > > or have another xx_min_len in iommu_/domain_ops.
> > > >
> > > > If driver is doing the copy it is OK that driver does the min_size
> > > > check too
> > >
> > > Ah, just realized my reply above was missing a context..
> > >
> > > Yi and I are having a concern that the core iommu_hpwt_alloc()
> > > and iommu_hwpt_cache_invalidate(), in the nesting series, copy
> > > data without checking the min_sizes. So, we are trying to add
> > > the missing piece into the next version but not sure which way
> > > could be optimal.
> > >
> > > It probably makes sense to add cache_invalidate_user_min_len
> > > next to the existing cache_invalidate_user_data_len. For the
> > > iommu_hwpt_alloc, we are missing a data_len, as the core just
> > > uses sizeof(union iommu_domain_user_data) when calling the
> > > copy_struct_from_user().
> > >
> > > Perhaps we could add two pairs of data_len/min_len in the ops
> > > structs:
> > > 	// iommu_ops
> > > 	const size_t domain_alloc_user_data_len; // for sanity&copy
> > > 	const size_t domain_alloc_user_min_len; // for sanity only
> > > 	// iommu_domain_ops
> > > 	const size_t cache_invalidate_user_data_len; // for sanity&copy
> > > 	const size_t cache_invalidate_user_min_len; // for sanity only
> > >
> >
> > What about creating a simple array to track type specific len in
> > iommufd instead of adding more fields to iommu/domain_ops?
> > anyway it's iommufd doing the copy and all the type specific
> > structures are already defined in the uapi header.
>=20
> Then index the array with type value, is it? Seems like we have defined
> such array before for the length of hwpt_alloc and invalidate structures.
> but finally we dropped it the array may grow largely per new types.

I'm not sure how many types iommufd will support in reality.

Just my personal feeling that having information contained in iommufd
is cleaner than expanding iommu core abstraction to assist iommufd=20
user buffer copy/verification.=20

>=20
> >
> > and a similar example already exists in union ucmd_buffer which
> > includes type specific structures to avoid memory copy...
>=20
> Not quite get here. ucmd_buffer is a union used to copy any user
> data. But here we want to check the minsz of the the user data.
> Seems not related.
>=20

that's the example for recording vendor specific structure information
in iommufd and it will also grow along with new added types.
