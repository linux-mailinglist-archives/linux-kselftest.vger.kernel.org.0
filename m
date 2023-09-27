Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586987AF7E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 03:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjI0B6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 21:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjI0B4Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 21:56:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402F2694;
        Tue, 26 Sep 2023 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695776888; x=1727312888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dcKotpAquOahfI7dd5o9hkflFmafI7gtqkpkEXrsf5E=;
  b=hRk3JMJrrtSPl8XF0ftwrBJ6t76b6lcniieCc5K0xGGOIZAYER6oU71S
   e8Gs6MtDom8OhXrsky/sl1Pc9rHnPBk3TPHKR6/kQygoCR6bjC12Ry+xh
   klBWhLLw5OCTZBPhinApCYaulLvi78blK2+aAfXkNhojYhRst+uCuj4V3
   Mghzc6sJ3vLbL7BLJdP7ZtvuBerD3iml3gTaAZUxL7LOzEErCuyZ26uNA
   Wgwv/8yfdFRh+HYfPU0HMTuI7ywmlqqvOvyMsSJg9KDHiBCPE0PjY9Fr8
   0s7xdYhcYahJzUPNTWGALbih9nNM9e1oGoRICXTw9ibx7Ti3rQJUytVtK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366763023"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366763023"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 18:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784144899"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784144899"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 18:08:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 18:08:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 18:08:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 18:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOhnnXBMR0WyHhcxGIVK3RUPbPyg8vpdsghT/5GqzkXaMI4mqe1EuxIlfFhf9nMSCDfvAbN00HEw5dgliogd8Aee5CHgzocSyzZicwW7RCzgK59+588H+4f6z1pR8hyq0nz6wpBo+chnY+HcWCuJ9oYPgiXOexy/6rkvG5o039KWd470/CWamJdXeLa718S5wHQt0vjkPvK2djMXIuh77GpMa4Metk+8fCJC0wofp5QhjEG6o1mbPJ8ZQ4OZgCbFoC04AxACnpjMpGF+AuCXH6clV5bN4YhC7zbDxg9i+Jzs297zNLELSFNaFX9EWgci62/AIhwEYQEBeNJE/gWwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hAMVjjmnxBnpfjQ27dcV7GTLT3SV01oMdtgW9h5qFU=;
 b=Z0gPbC+vTldynyqvgdWokWlohZyzx0TgmAY7CwgehrJozy6KboJJw6OcQxGy3AYe5aG1gbsospsiXOehNaO2gVrl5U6Zp1TnfoAgwYpmOlRbfZx1Km+JbW+A5b7DKx6LYgAX67m38WnMnI+IHfI7G34twE75euzN85gKO944KNZEZLFLqtRbcOgUYhYZsqz6cQ0E6AXudmRy9do2weSHd+U7TTPvpunOxwGTS9vzE33pyYgsWA+wX6VWoopxRtGNFKVwWBY0J4Wny6AF3tEY3N/tDnWY1S+6ECNkaGZyzzSUi2XigTLudeJ4feQPQ6MUDAUSeUl1pAiUfVPc5QJxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Wed, 27 Sep
 2023 01:08:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 01:08:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Topic: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Index: AQHZ7GCQqMA2D6hFIkG8of68DC8uNLAlMOeAgABMNICAAR3BAIAGE8WQgACl0QCAAI/EwA==
Date:   Wed, 27 Sep 2023 01:08:01 +0000
Message-ID: <BN9PR11MB527645B87FB0150E9C7AF4D88CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
 <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
 <BN9PR11MB52765B3F127EE04E4A79C7778CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230926162920.GQ13733@nvidia.com>
In-Reply-To: <20230926162920.GQ13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5320:EE_
x-ms-office365-filtering-correlation-id: 13decb92-715c-44a1-ac4d-08dbbef63270
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85QxCa3z66H4A22zC0XJaEM/4S7+QD0xjJgIUaqdo0KqTR0qaWdui3yevWNBNjBbGb8tapmB5rm3pIMgBBY4R8njuQdYF++yMlE60pDQ1Tj7Y/QCOTEGxJ5S+mP9dO4dl5eW1LFBjglwTuo/gbvRKQ993HyzdYcKl814uDHPx52aui9E5ARG0WwXfbN1iksUTBwwKqez6m223TPNbUHLWaJSd/tZ92h5q9LIgU4DLRIVA+SgNW51us6vQbM9YAoRj8NuW07ddVypairWTe0QECqkSx/+ML33xegD3sETTGh6JG4zFKPMQ/CjiJzRviRt/ufu+lQoCJpMEaAwg3ft6uca51j8TNfSyQYUy14cZbEFK8uf61saVhWgMsvIQ+pKImeLfK6qR7cSKCQTxB+XPuYmnl16vD6pm1vu5BQ3X4XgJL4tg4zOZgSiMoKHpQU84l1/Z16QXResE+Q6ThadCZ5VWGbTSJvcuG2BSm+giwI3NhA6Iyg5y8/0sWHDm6dJOHIaocJy2aleofy/8Dh0lWZPjCyAqFp/jyuW7/POookPDCznsxxVUEgKyUa0AfgmCF7di8Kg2GvZAiTIUNnZHzxpNYsXfYwYQeYOh2Nl0f7ieI3zVtm0KIRylw0JeDcK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(7416002)(2906002)(66946007)(66446008)(76116006)(54906003)(64756008)(6916009)(38100700002)(122000001)(66476007)(316002)(38070700005)(66556008)(9686003)(6506007)(7696005)(478600001)(26005)(83380400001)(71200400001)(55016003)(41300700001)(52536014)(86362001)(8676002)(33656002)(82960400001)(5660300002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uLhY1WesbwNQzqZViPoUcJ31qVCch9GNM2FMjYc1pMhJauY1EtXhfzsuQNyA?=
 =?us-ascii?Q?rha6hM56xYpo5saGHxuanSctTlyEZj0xCoCKdFOnGkJKcMlBqucwd4tzNCZ6?=
 =?us-ascii?Q?vZVo1s6fm9v+KqnB+ltpGGOYjucJoMqJ7lPVKLhTlAfJYf6yNnUWhXe1o8OQ?=
 =?us-ascii?Q?S46yNXiGdr/AZBIE8QA8YuPVmYbIfUKdMDDqByt0XTaifpLGyM2v4LJiVN4q?=
 =?us-ascii?Q?BETEPWC2Q2/+nUZ42JDRQSmye4lobRGtCULxARke3mSNgPWyu+6Kj20PcSVd?=
 =?us-ascii?Q?gV5Qc5EJ7f9BH7TjcZ8A5aZ/F4sEWv7Sz6RIpVm9wUjpTeXAAt3++b8VFqCA?=
 =?us-ascii?Q?DIJ0A6kCI6yShOyZvHWllEHyC1nFolD7Y4rLlHmyExL4Mkv5ghsFBBdP86VM?=
 =?us-ascii?Q?16Z/jpP+8ywuobV7fckkQnUnwghuRKQccJ3Re7lUz5bsqKh7r/2enykNnGFJ?=
 =?us-ascii?Q?gzMTK8zUvVELICAz2EWMg6kXQgVNrZxLY5/ShHZrX40S8yeYLuJUKTLrfdvC?=
 =?us-ascii?Q?1ZR7H20VI7lvHkbyF+IfYYUelL8GQzhZBQoVXeztJlsjZLCoAxcz2EvI/SyV?=
 =?us-ascii?Q?Z8xJQ+zpPKHAzkoC6NlsaxPg43w5OL9AGjGBA0MEizKRBPEVn/K2u4hLtCtn?=
 =?us-ascii?Q?mHdkotv7GTXRSweDxzZVsPJOgjgGniTt5G0rOcqM9KMa0CaavYLGr0laZqDJ?=
 =?us-ascii?Q?gK+IgaX7z8eGxkNNqHQL4nMpplG5tzOOGOQSlIwh65WhoiyI+oNYY4v4QgCQ?=
 =?us-ascii?Q?AhiWL3+ZxsO1GvS6fDi14JOjvuuwGFTZMQUNnA1lk0TLkjUD6QEWfnRyfYg6?=
 =?us-ascii?Q?SLAJl3Y+yIE+XAcuhHPrPSjwRmQM8i20+hIM/STnboOEiltuPFPD2ZeRpboz?=
 =?us-ascii?Q?kuBkaPDmWCU7676HmGUNI1EWGF9AAlOQk/l805sQ/h9tk52S85eCDklF0RZ5?=
 =?us-ascii?Q?V1Zr7Q94p+qwfGpaLhGoOQtSuOCWRObozwVFlYJap4x9PdGh5wUDtudvPdrO?=
 =?us-ascii?Q?L9h6ksLuG1XOtQQAA34BXWtMO2jV7I7Xmq9FjiPndjaDD/qlZ7x8TCyGLkvz?=
 =?us-ascii?Q?umCSX4CAAxzZOduPZhAc/f+xEnFRbmgjp96qhIHKlIi4gU77kis+JEwV8jos?=
 =?us-ascii?Q?Bx05Tg1JtTOH9ik9i0OW9IwEsFx+Qze+n6UlEgagmkIrjoTvNMVxAcYOMQMZ?=
 =?us-ascii?Q?4KmUDtjYFJ1M3S+Xo1iUj17Uk+p0QQzvm2qd4IBKZTZmmTtzvCfSLqJtdBIh?=
 =?us-ascii?Q?x8foUZi17cwJEEQ0G2jQyI+6E3wtaNdFw6AWygkeQZWppbsAJVBQzV+5o21+?=
 =?us-ascii?Q?lA0QM4FwgCaOJqdMjOEPSqtzKWC8DFeelGFgN6A6cIxfiE42g8IOKv9ZUTsQ?=
 =?us-ascii?Q?UAn5FAEhiTgEg1TZwme2uQE8PmQqEk4bPTBJ8kiL8xgxIsqcuFnbpwDQvV59?=
 =?us-ascii?Q?u6IrKYiezvJ7zSa20jvnKV0eEs9NMhBbOOsjGiOfpSLdJYAL6xsry4kBX6Nq?=
 =?us-ascii?Q?qSnQRd4nMftw48Qi/GzCZV1zXAitGzLO7p75uEDOIQ4ZD/7i8SBblSl95t7c?=
 =?us-ascii?Q?q+kLlxM4wKCNy9r3M3kpGuf95nHCRB3NB9r1luJz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13decb92-715c-44a1-ac4d-08dbbef63270
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 01:08:02.0246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK6koMup5WDhc3e184cerPRxD7ForwgZj5s2EdjFKhF7qkahZS871PAD8IxkVUuJeopEPqlg43P9Zt+tny/+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 27, 2023 12:29 AM
>=20
> On Tue, Sep 26, 2023 at 06:37:55AM +0000, Tian, Kevin wrote:
> > > From: Robin Murphy <robin.murphy@arm.com>
> > > Sent: Friday, September 22, 2023 5:48 PM
> > >
> > > I could go on enjoying myself, but basically yeah, "default" can't be=
 a
> > > type in itself (at best it would be a meta-type which could be
> > > requested, such that it resolves to some real type to actually
> > > allocate), so a good name should reflect what the type functionally
> > > *means* to the user. IIUC the important distinction is that it's an
> > > abstract kernel-owned pagetable for the user to indirectly control vi=
a
> > > the API, rather than one it owns and writes directly (and thus has to=
 be
> > > in a specific agreed format).
> > >
> >
> > IOMMU_HWPT_TYPE_KERNEL then?
> >
> > IOMMU_HWPT_TYPE_GENERIC also doesn't sound a straight word.
>=20
> At the end of the day this enum is the type tag for:
>=20
>  struct iommu_hwpt_alloc {
>  	__u32 size;
>  	__u32 pt_id;
>  	__u32 out_hwpt_id;
>  	__u32 __reserved;
> +	__u32 hwpt_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
>  };
>=20
> That pointer.
>=20
> IOMMU_HWPT_ALLOC_DATA_NONE =3D 0
> IOMMU_HWPT_ALLOC_DATA_INTEL_VTD
> IOMMU_HWPT_ALLOC_DATA_ARM_SMMUV3
>=20
> etc?
>=20
> DATA_NONE requires data_len =3D=3D 0
>=20

Looks good. Probably hwpt_type can be also renamed to data_type
to better match this interpretation.
