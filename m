Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398077566C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHIJbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjHIJa5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 05:30:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4411FF7;
        Wed,  9 Aug 2023 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691573456; x=1723109456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c/CZ6DUSZ2CDBDkU+TFK8lokxaELxucoV3rlOU23cpg=;
  b=n3WvNlrokebsZfBIyx4mO2e8z+bSIbiJgrg1MUb7FjhlXGKkS/EA2Th0
   ileJks1AGkNPLi+Kf0ai7IuNUvSjMZKj+s9zbeXqG/pq2+sYoiGd4I5vr
   NwAZ6wlo3OCyGTI/kGR3z0M2v+1TkRTTf7BmTYdJK05iso0ON5c86ItE7
   bLaNyHgCzVOuxjTHwR/sqcCKX324VyQt/0Mx0nODgVTBdcQn6cjvYdj6N
   rcmuHPTSetkryd3qJ9LPblQXZq5X6sUM0VVRxDVxU4on6OjiB3yMM8QlR
   k0DHa1rWlgIH/FJb/ZrwIvYQq6h/nbNqTIYapcItJ/0WWkoOqgzcKe4Mb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369976262"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="369976262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681608107"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="681608107"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2023 02:30:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:30:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:30:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:30:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRhbk3e/xv+eXH8ZoqyQoOb6OS9gefH6kZuI1Fkh26OxL8dTNlxi7eW4cKjyP0xIPoW7ektShaSA3RCda1PlnUoLQ51eOJFB7U//5mrYlthlUkxEjZiwxA7ydq1EmZ6+jR7YIMfMNd9Q8n0toskxWf3mf8F7wFCP6xTKTWw2oRM+CtwIgdEhQ995qXvCbT9y7+fVRjsyL69uSPO3McD+lyZ0za4dSwmw3Yy3R41NgHpqPkroLTGpHzjWS1fwORoFF9tByTrUQC9s03cokZ0gKXZuyG7t3w0BfI+TJpm2OmVxakeMSNDF/oBgizPseM24hRtNyKlZs6hca4zj8mI71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzW/DzMivkEKQuMG70H3sicgSBXqw8m1eMTMZ+utx5E=;
 b=A2pMigvD2bS9tLSTqmPx6AZDxccBCQ4gTd23Z+2xrdxNp3EPYo0FL+HB1XTk+JBAXQIxPFszCo8UHGzczk4L61ghkGAm4hwCtWIzIbOMhv6AANVMaIeoZ2+jy6zwvxJnXLAfsHOOKCHfCZDpTkxvD7tZzbK5oQbkbKOx84DXi2Ikl04gD7MPhspKi8yi/8FUZcaP+MZNjg/0yq6KOg39YkUuZmzVCH/Drqj4l2f0hsAs6CH0TwFn18i2J44lLMM5OK7QZLcNUckVW/qKEByx4oweM/5ZTotRcf3+zOFfIIdvDtjtBEFiH+DGkU1jyHZmpVaS1alWZCmr1EtBl/nL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:30:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 09:30:13 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Thread-Index: AQHZvh/uqwr3PK6FO0KhG3jtetteiK/WrrGAgAhNwpCAANOqgIAAnN2AgABV8ACAAPYtAIAABp4QgAADR4CAAAcG8A==
Date:   Wed, 9 Aug 2023 09:30:12 +0000
Message-ID: <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MN2PR11MB4533:EE_
x-ms-office365-filtering-correlation-id: 6d12e904-143a-465f-3cd5-08db98bb3ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzDLG5TuZol/SqX260DsEnackDXyiEjZasz97SMIxJlrrbZbpuw1/3vwa2zoDi7Grivkn/4fnLE1efwjrFIbTHbAlEeizH2hOsW0dnZaLQhkCxv8XA8w1ICRix8mSDa+CtSMBnHvwlYnQYtk1eNgxDDESAo+mQ6LAUqnHwjjfau5dXAbb4NU+aAV3/byNK6ACwBqN+VscAAgF9PYeLiNQrGjR6VmhOm5aNdcjFy0MHbZP3R1j6fCkf6kBMbM4M3R1UTqQW/dGkSwk+JHWWuiWXDGEJsR5vPRlY7nklItiSmLMcD5euGNVmlec7hrok8lS5yYxEnE0Ynk6Rvg5EtxCSCaY75BW0Wb7IpXx+df45kwFGqZhqtfO9+Bhnq2Xt52yR/8LvKKG3O2H+tSh0Ryj7xYAvYZzSzQYD4KjOzN5kRmDF34+r82M3kISfqjxmR+oqCib0ffzRSaMNc+qffeLmp2sB4jZEe89HrjV+awdv0AjdqGGUh82dUcx1I4yJ4z8k/HUIZaUJLW19+bvrmueT745h8K29hGN3/ltAgl/JUdPVHjLwXSAve0g4Htu1922eK/0aGS+v5KNJEVymG1SMekQgkzHw4KeRvPSYQ6MSIJdtJ2HSqL/PwKNaTzl0Mq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(1800799006)(186006)(9686003)(55016003)(6506007)(110136005)(54906003)(38100700002)(52536014)(5660300002)(86362001)(38070700005)(7416002)(4326008)(2906002)(64756008)(76116006)(66446008)(66476007)(66946007)(66556008)(8936002)(33656002)(8676002)(316002)(41300700001)(71200400001)(7696005)(122000001)(478600001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ocyjz8L9rxkk7hWlAQIm7Hoz49RI1ic1zVtVZsSUozbxbdA3dSuBB6LANT1h?=
 =?us-ascii?Q?iZt8Zb51mjHJBo7kw87WVk7GyneTSz43HpevHPU7GR/qwSQGB2nIdQio64wZ?=
 =?us-ascii?Q?rwNzP2ROozJTtWAmfAoXX+6DhYEi9DxXREgOGEPvELRSGLx/N/PSjBkm6bMZ?=
 =?us-ascii?Q?ff1/eqK5SY5UnII09NJXAfwWuaVfg0olbwPFMakmj8F3C9HjyzVMVbjKJF0X?=
 =?us-ascii?Q?6tgsFctE4mKn4h3Eo3x5dCapek3s6goeCli/nIIEnmgz8y3hl73bQokg2es2?=
 =?us-ascii?Q?zFAncsIfyJfCkyeRQjypp6QIEB54Me4ZejqfRhIg+ndcXGxSNEARlwJ9slbb?=
 =?us-ascii?Q?jhfc/fJixO0L+8Bp6tp6yi7ellrWjQVe56kufUoFv8boejHM+Bh1giQxz659?=
 =?us-ascii?Q?P3LcNB5ZClS1ShkqxRdLFAUwDXP7l1uGbQ0zy49X8aCaucSEKriZfonBq53n?=
 =?us-ascii?Q?icGBuah8q+EFqATH2ZHWT+2gBVlprcNT68W9BqCRypVytBrnb1zarHjiGci/?=
 =?us-ascii?Q?j00HozyHzD9hb+NEny1Zo0VU0iPPr3nwyAZJcsahLHhcYui/WYowW5fTQJTl?=
 =?us-ascii?Q?pFeVgbe4lxZlFVsZM2FPUu0ke5N1Pz0Ui1Oc7eFX+IBrbDm5uoqsz5mc+4bf?=
 =?us-ascii?Q?d66aGMXckbWIM1/RymJGTF5UGZyVfsRxLp77l79dwXKD+8PEiKLypqYh09QN?=
 =?us-ascii?Q?r//Jw2f1E0tTUYsnGs5fH/cba+zLP+JVrJDF7v34zxbguWNTPNhgH9lMsh/h?=
 =?us-ascii?Q?nrAOV2pHJ/t33l9OPhPhg8/IHt01Gtzun1+uPkFqNNOvArHcYzuKnSYYS4yU?=
 =?us-ascii?Q?jswsk5Oq8lQ16yK9YxDZ6wHrFyDdglvnG+O7XTr+IF/8FcxqtLBCdZhTJ3V0?=
 =?us-ascii?Q?jPIQnA47UeFTBQinF3TC9jVjttDrBxJ7HlbgFwMupkDm6kzWirZeARWtr+lq?=
 =?us-ascii?Q?Txv2FfVeAgBD/d2IIsThuUVvLB5PIXqZWzrNnw3FoHuAsvbX2XpRBH8kQ+RL?=
 =?us-ascii?Q?tlTSE1K0FXK7LnsposFVr1GF/7EuUOmcDKOyS1dbXPbaXoZXeWwBKW3v2Qxi?=
 =?us-ascii?Q?vtKVMGqPYPaFBKuLQa2F5VSMbM6C832SbLQLj40kd8R2xJ8eCijtns7sNzJn?=
 =?us-ascii?Q?tV4Oh+yGwpSQpWz6wn8qJ/w7y4aRXICBijoSz14+EIlpbh8ormHY2O+6w18j?=
 =?us-ascii?Q?qqsHoZczCjdG9QiW4fcsdrJJrMuaPVccKOqFHBRCBv5/GR+AX1wPNG/YXDB+?=
 =?us-ascii?Q?rdWr/YZVVzQtmWfXjLuN+YV4gqnwXjovkwbN+vZBAIoLPnkUVO7L3sjrpqys?=
 =?us-ascii?Q?ccvWGYA4fiSjco9oF+jrwj+GpfPOLBz85xwFvx6ZJ4PHoCMCFPHdgmfN5BIK?=
 =?us-ascii?Q?PG/n5BMXzEbvydwveLGOT3H+e6cbeRIi9y1o5zYIwAxIEyUSLU5mhagd5f/u?=
 =?us-ascii?Q?nvZLggs8oCxCQ9vKsNoxvNOZV6FAXbLK1NOreZ0oF+o3lyUpDSvCknWCh2nV?=
 =?us-ascii?Q?hPxa/vvRIykc8xpi9vyobbpaL55skaB0+xk+KZGTVzIzlEBjEBa/8xwdjQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d12e904-143a-465f-3cd5-08db98bb3ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:30:12.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hrq5Yc3L0LaJpytYoFrMdHBhu/g/Ca6/l2gHvQZEMGISxFz+dhnbxbWDwtQmab0TNPM4J25h//7DuQrT1nzmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
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

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, August 9, 2023 4:58 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Wednesday, August 9, 2023 4:50 PM
> >
> > > From: Tian, Kevin <kevin.tian@intel.com>
> > > Sent: Wednesday, August 9, 2023 4:23 PM
> > >
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, August 9, 2023 1:42 AM
> > > >
> > > > On Tue, Aug 08, 2023 at 09:34:03AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> > > > > > On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > > > > Sent: Monday, July 24, 2023 7:14 PM
> > > > > > > > >
> > > > > > > > > +static int intel_nested_cache_invalidate_user(struct
> > > > iommu_domain
> > > > > > > > > *domain,
> > > > > > > > > +                                         void *user_data=
)
> > > > > > > > > +{
> > > > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D use=
r_data;
> > > > > > > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D use=
r_data;
> > > > > > > > > +   struct dmar_domain *dmar_domain =3D
> > to_dmar_domain(domain);
> > > > > > > > > +   unsigned int entry_size =3D inv_info->entry_size;
> > > > > > > > > +   u64 uptr =3D inv_info->inv_data_uptr;
> > > > > > > > > +   u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > > > > > > > > +   struct device_domain_info *info;
> > > > > > > > > +   u32 entry_nr, index;
> > > > > > > > > +   unsigned long flags;
> > > > > > > > > +   int ret =3D 0;
> > > > > > > > > +
> > > > > > > > > +   if (get_user(entry_nr, (uint32_t __user
> > > > *)u64_to_user_ptr(nr_uptr)))
> > > > > > > > > +           return -EFAULT;
> > > > > > > > > +
> > > > > > > > > +   for (index =3D 0; index < entry_nr; index++) {
> > > > > > > > > +           ret =3D copy_struct_from_user(req, sizeof(*re=
q),
> > > > > > > > > +                                       u64_to_user_ptr(u=
ptr + index *
> > > > > > > > > entry_size),
> > > > > > > > > +                                       entry_size);
> > > > > > > >
> > > > > > > > If continuing this direction then the driver should also ch=
eck minsz
> > etc.
> > > > > > > > for struct iommu_hwpt_vtd_s1_invalidate and
> > > > iommu_hwpt_vtd_s1_invalidate_desc
> > > > > > > > since they are uAPI and subject to change.
> > > > > > >
> > > > > > > Then needs to define size in the uapi data structure, and cop=
y size
> > first
> > > > and
> > > > > > > check minsz before going forward. How about the structures fo=
r
> > hwpt
> > > > alloc
> > > > > > > like struct iommu_hwpt_vtd_s1? Should check minsz for them as
> > well?
> > > > > >
> > > > > > Assuming that every uAPI data structure needs a min_size, we ca=
n
> > > > > > either add a structure holding all min_sizes like iommufd main.=
c
> > > > > > or have another xx_min_len in iommu_/domain_ops.
> > > > >
> > > > > If driver is doing the copy it is OK that driver does the min_siz=
e
> > > > > check too
> > > >
> > > > Ah, just realized my reply above was missing a context..
> > > >
> > > > Yi and I are having a concern that the core iommu_hpwt_alloc()
> > > > and iommu_hwpt_cache_invalidate(), in the nesting series, copy
> > > > data without checking the min_sizes. So, we are trying to add
> > > > the missing piece into the next version but not sure which way
> > > > could be optimal.
> > > >
> > > > It probably makes sense to add cache_invalidate_user_min_len
> > > > next to the existing cache_invalidate_user_data_len. For the
> > > > iommu_hwpt_alloc, we are missing a data_len, as the core just
> > > > uses sizeof(union iommu_domain_user_data) when calling the
> > > > copy_struct_from_user().
> > > >
> > > > Perhaps we could add two pairs of data_len/min_len in the ops
> > > > structs:
> > > > 	// iommu_ops
> > > > 	const size_t domain_alloc_user_data_len; // for sanity&copy
> > > > 	const size_t domain_alloc_user_min_len; // for sanity only
> > > > 	// iommu_domain_ops
> > > > 	const size_t cache_invalidate_user_data_len; // for sanity&copy
> > > > 	const size_t cache_invalidate_user_min_len; // for sanity only
> > > >
> > >
> > > What about creating a simple array to track type specific len in
> > > iommufd instead of adding more fields to iommu/domain_ops?
> > > anyway it's iommufd doing the copy and all the type specific
> > > structures are already defined in the uapi header.
> >
> > Then index the array with type value, is it? Seems like we have defined
> > such array before for the length of hwpt_alloc and invalidate structure=
s.
> > but finally we dropped it the array may grow largely per new types.
>=20
> I'm not sure how many types iommufd will support in reality.
>
> Just my personal feeling that having information contained in iommufd
> is cleaner than expanding iommu core abstraction to assist iommufd
> user buffer copy/verification.
>=20
> >
> > >
> > > and a similar example already exists in union ucmd_buffer which
> > > includes type specific structures to avoid memory copy...
> >
> > Not quite get here. ucmd_buffer is a union used to copy any user
> > data. But here we want to check the minsz of the the user data.
> > Seems not related.
> >
>=20
> that's the example for recording vendor specific structure information
> in iommufd and it will also grow along with new added types.

Yeah, adding new structures to ucmd_buffer may increase the size as
well if the new one is larger. While for an array, if there is new entry,
it is for sure to increase the size. I remember there is one tricky thing
when handling the selftest type. E.g. it is defined as 0xbadbeef, if using
it to index array, it would expire. So we have some special handling on
it. If defining the things in iommu_ops, it is simpler. Selftest may be
not so critical to determining the direction though.

Regards,
Yi Liu
