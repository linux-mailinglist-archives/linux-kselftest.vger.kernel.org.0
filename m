Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC27D62F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYHdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjJYHcx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 03:32:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F1195;
        Wed, 25 Oct 2023 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219148; x=1729755148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pNeYLCaLia7rY6MK6IyNLsSvkU2lOloqcfr6TdfQRPk=;
  b=BvMM9cuwENPciePH2fQ1zblyGDGl014IQcuQFq85/nf+UvrRGcf2ivMw
   FZhelQHnq4aEgz1apOY78LHtEn0/4ktIKjK9ORLvuBBl8RrTd9SpJwl0J
   P8FY6m2VD90J67cVCr/ghLLuC5QXQVfBKH6s01TeJOoH98hx5RuOnzqjn
   uBRE/Kuu8Y/EDajjDslubbHnNh6By0h5m0bNatn9PeP9Q9gM8nd55AECZ
   vryO7ywztEWA6QGAoUnC2UNUlWInZSxfqYlmoWt13s7nAsbsFEBBFlVWI
   MliuMhq0RjIaQy09d3+/VcOLWzO/fxwsEuxkBkn4BX6Ng6sAA/0G7U8/Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377623671"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377623671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="18509"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:32:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:32:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 00:32:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k21AYRsYsEwUqSD+ER0BZmSc0npXMQCjLDaQuLEXQrIXmwXb+bILl/VQk6cqL8oEGWmoe4GvXDGVZymD7eCjEmR2edFRrm5D/LS+Q0K+BIcGUqwBHMgW7GN2bvNJFT+R3ymht1N6DQmf/kvUHj5viPM2H7VTxhUVtuhPGE3kYSCfC2Kt4ecw3rotKtXb1ZxJI1W0VDcUrsMJYCVOR9LmAQ8p+AkfB+yokF3cCiR4lu6zRrZp83qAGjpCmQ+V56A+Yp8rHDEuaA1e/ytZSQ+3jAPUECFznWKC3JFWO0TJJDz72yy7882kpsXrbiE02Lt3tBwqe8AGg9YdibWY3uzQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/yzBihjyXNsrnhk6FnXZeSVHjbyMQoVJV/LEm5fZxs=;
 b=XPbVJbcnuX1dz/1GuPGvhJlKo2l8MSoY/7c95141iE9B9gGc6gAki6NjSAbYmKcpyXh7PkQEU+oJYpCeXaaqSJyfStNk6xvUtxjHNpxibOP2H2BEITyTwZXq2FYfb5vqwVNgD3+shovLIPsOJkepi9jJk8i2zJPzAUcUHKpWBmq6390ArKLce1pA+gV/Ig91taMkU46Mm/39wp30o7K/I75F1cVqmu3rsDy2R85u46BW1n8ju04uQe3hVYM2fYXDybYG6GCLccIeSClWypfcQvFzUH/ak70nYmOujQqxwmAXrEUsRTTZY6tW7UHrVjLKPhyx7MDRVgFZpqFCBy10NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:32:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:32:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v6 00/10] iommufd: Add nesting infrastructure (part 1/2)
Thread-Topic: [PATCH v6 00/10] iommufd: Add nesting infrastructure (part 1/2)
Thread-Index: AQHaBounISnkqmNEJEWZYeo0kkRPLrBZOZ8AgADbGnA=
Date:   Wed, 25 Oct 2023 07:32:20 +0000
Message-ID: <BN9PR11MB527650A49BA4961B4B31B84E8CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024175604.GU3952@nvidia.com>
In-Reply-To: <20231024175604.GU3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: d5ac11f0-11bb-41ae-d552-08dbd52c85bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXQA8Z+GRKAqf3p2wsaalo+uhQ6x6ypreTjeoM1cXwhST9zviqiR6cgxwyvK6RJ39VV/x/wd11Fy7cYg1QXEGJ/frNgzEqyjWCwAKGNb1ceLHpUYbP00gyV41GzfC6ZN4/4jYnJQE/uKmu4UD4VRP4gKEenkLxxY1uOUx93oXctQC+L72ulynmWGnR0wah5HqqNyqtf7GunNFXnAP8pZa2x40IBPz7YR6y6cQuISxHwbyMwNzVYuMoof1+ut0a1GYgxteIHHDEIlT9/+XiLcV7SUOzNOwjO1CuhkNNTQfCd7xzkb1f3V7yeQ4lENPl7Sbn0/7CZx0Ny705WJ9iFEOuuInaVWNkaYLYiHcBHdp5QE1msIoesRrSiP9YKM0X/odRKI5Fak3+Gho8yCbo0e6AgMyR5W/F3epvE1qwR/g9zCiS7wEREimiwymvCzwKIKxDGZq3hRfZXsma/nGo317jkRP+N0I8dnRcbIEc16pxLwm7u6bJC8vfW5XPe3DioJHs2fpvwD+rN8jvXNjcPj812pbE7kHGGiG4JNQSGs+hDKevyffdW0Su5+//ko2UkcWkVKj996AljwORQAMyYaJo51VGV1wU6yuoBGyLnZxQCltCcqBlLU5slz+WM9JWVI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(76116006)(86362001)(6506007)(316002)(6636002)(7696005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700009)(33656002)(52536014)(2906002)(8676002)(122000001)(71200400001)(7416002)(4326008)(8936002)(82960400001)(5660300002)(41300700001)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DCvKesx2d2e+yS+yNDXAPYABYXMpP6cEFVX483H7drzomtQr/wvSEls9+eJ6?=
 =?us-ascii?Q?nTVVtZaEfXh5VZqZ3F4hO8ZLLjK2WRVmztFTMFOsTq/4+6UzOnNpTxovGjH2?=
 =?us-ascii?Q?EuPbFmggOSmNaBDHf65n6y/AVn+/fob5jzMl9Psl08iQhmLr8sXyKCilhQIf?=
 =?us-ascii?Q?XTby2SLTnglwh7wN4cCTdpgMwQ3wYXaypOa0nlX0PMpY+8t04VZoWSpkdSJf?=
 =?us-ascii?Q?gDmvL0rhVVx9ku1P8Jdh5d327xiumKOAdwOQdH+mzP445Fy+EawqarGlBdLS?=
 =?us-ascii?Q?efej/xelSMAaiyazD6eZh+WRtfdnBYzMTG9K9dYkG96Lf7eP9q4oqHkSSVCM?=
 =?us-ascii?Q?NT+7Siu66BLS1Bl86C0W5LjcL2KMDv7gI0xxsW7xsqMWuC4sNs6BAjt1BcDK?=
 =?us-ascii?Q?xj4JXSuXg/9Z6ADff+ALw23b8IjXgJcKI4js+yskXQCnQ4O0ub9MJA9ev5QM?=
 =?us-ascii?Q?OibMhiIgw0LgUyMH3Val4SuxZpUles2LdUZ1Y/YNmtz04CroIIB1tSxNYmsM?=
 =?us-ascii?Q?6b23q5G5xD/sH/Q7FFQ/Bsf+BrvdcTaBdMJg0GHemAgXSYuWwrtfIxeh8XRm?=
 =?us-ascii?Q?EUKWNc9wGEXkmcW/uKSKesuWQUXyh3Smprm9vfwE6RQRsWhgl5K6zQsz5hRY?=
 =?us-ascii?Q?ODsq+IvrJs0zno2GRie8GzgJCCcSlTFxHweipcmgID3A/lt0ES56F//as8qW?=
 =?us-ascii?Q?GqzZ6ZkOcDTvT70UpQdb1X5QGnPCv4RNTme60G2PL1Uiw0Z+Im2oNZt/k6E6?=
 =?us-ascii?Q?czBZYc3jOx9xg8C7mffHeQ2BiLjuW8YxRxcB5BGlxPDx8P6cG/UC0urxWoyS?=
 =?us-ascii?Q?rnBfO2TQ6/AXc9V9B4Zh2TR9vSebIFvsepFfvjK7TxTtFzTrNPl8G6ODeFPh?=
 =?us-ascii?Q?cJ1yyeWZR8Zq98XnzFTc7k0ZFJt8fOfJRYjfLpdFlnDXWuvXZJzb8AdHzo6X?=
 =?us-ascii?Q?1t6FprBH/eW3BRKu10DT/VWBMzLjCyiVt9NtQy/h5TWG+tYgvuGbNxFyCFAk?=
 =?us-ascii?Q?pWzYxTVtmwKD7rpciyjMePyhqzmANEruBXxBxpqIa6rO8xMYLETFVdGveoha?=
 =?us-ascii?Q?cECFlacODluifodk5e00wZAmHWOprdIskLCGwYzvJroPUwV20bymiq/rpQKc?=
 =?us-ascii?Q?pnDVQjpBmY6D7dbdpglf4Nigj8JuL/eFCaHsAK1TTIO3CyABttpcR+p5fW0L?=
 =?us-ascii?Q?H4rGgBVO9cEcsbpK0c1WO9SrFY7R1u6reQFZRgUUarRhx6IAXjQjnZhlER41?=
 =?us-ascii?Q?cIUmjEw60C1e6fub6cKSzai7tf55h74cGXCWJhDsuAaR4X3jd/ZNS3ph54k9?=
 =?us-ascii?Q?N17HJEeFH1UhLeGJOyG0w2kO0R676gUlTdB6h1rfMNZ0NfdC3fNskLR+IrL6?=
 =?us-ascii?Q?rGoIFVoGtDu0m699c58thWeUzhZjbOXkfT9PcvoiMuU4JMpLaQUUbNCEd8Lt?=
 =?us-ascii?Q?WCH/T3M3jZReyc4rOsbB/wad9kQ8buBMqopWuKvX5/qoI85to771f/w36noM?=
 =?us-ascii?Q?pnasPfUtqXLAHwgMQnWyI/eG8biLdPudSuwTRRG22Mv451fPns/Dgt9A1D1O?=
 =?us-ascii?Q?adNxFi7rB6m4jllwPMKCBmsvV5OX5rt5TOQFvVJJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ac11f0-11bb-41ae-d552-08dbd52c85bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:32:20.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BXus3k+GnffJiXy6MXAWxkqrRx6TfdoFIq92/JkVVW/wcOlgX2xElrTIIdf4zp7uTFH5rTEl8PO5nmMRgPYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 25, 2023 1:56 AM
>=20
> On Tue, Oct 24, 2023 at 08:05:59AM -0700, Yi Liu wrote:
>=20
> > Jason Gunthorpe (2):
> >   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to
> IOMMUFD_OBJ_HWPT_PAGING
> >   iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only
> configurations
> >
> > Lu Baolu (1):
> >   iommu: Add IOMMU_DOMAIN_NESTED
> >
> > Nicolin Chen (6):
> >   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
> >   iommufd: Share iommufd_hwpt_alloc with
> IOMMUFD_OBJ_HWPT_NESTED
> >   iommufd: Add a nested HW pagetable object
> >   iommu: Add iommu_copy_struct_from_user helper
> >   iommufd/selftest: Add nested domain allocation for mock domain
> >   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested
> HWPTs
> >
> > Yi Liu (1):
> >   iommu: Pass in parent domain with user_data to domain_alloc_user op
>=20
> I made the changes noted in the thread and pushed this to linux-next
>=20

this looks good overall except a small error. For the whole series with
your changes:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
