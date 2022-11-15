Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2A62904D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 04:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiKODDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 22:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiKODCh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 22:02:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3501CFC6;
        Mon, 14 Nov 2022 18:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668481194; x=1700017194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MFpVPeSlPMlXMX7pUpQNKoYRadqcwhpvYaa8p2TBqGU=;
  b=Dn4X0kIOWCC8oXLMomwlkIuSr/mM6PhckV1qT+abR68qqb8g7S6h23Q4
   3qy9CG4tsa8Dpyi4f2yUoUFRDSQGXDxZplGEoPYSm3PWT5bnLR1fcMwZz
   MYg+jr5ktXffs4TSpZOGuguZlEGI2rkdrl5xSGxc4DGOnSgxzREPWhV8s
   seK/yeUA60I9ziH75Qvr3fyTbG+hZ8Ie8peyIHMuDuEQKbkxtFzHffIy+
   X66UuRyV8iz+VYLxi7jSW/kBx0p7m5dScJA66zUTjP7pO5w8Bk70yd3Cd
   SgKL/lWC9D454zmxU5f+taEaIX3hnPf7giAIViVAnBjYJsFyP5HfehFTt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310851148"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310851148"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 18:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616576656"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616576656"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 18:59:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:59:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 18:59:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 18:59:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3HzTPja/6F/2sHCiCV3eYb2+Mj/jZ6ox5MnmDtzhaIr/3sZpWQ7GZ9p0AhvJ3eSUgrDiWKI1/d3GkaqtGkvtpD8s0ZzfAe2krsnbUQMda38fAr6JVy+MrA8WzdeCSm1DDViOzHgt0Ekcer7y+FYOiQFhIfd3xjrvmyd7iPTReSobUcoXcc56Ulr16fITFE/0umerYp/uQ/VIeXsaVIvd89pgLqEMgQQI39Fu6gmgdqwhsWnZWbT6islkAHYbi9VfdjxyTbjdwhjAZqxtuWTVNjaialj1kVOmsXgGqfCbJQMJk4vQxqGGmlce1OctNhwDGLnVhWteDjtN2SJVP9a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnWIKGEllHmZlduGHLG2OtXinK2MbPj3TpfE9FM4fZw=;
 b=XcfNhpw7r8MLb/SD3GdZ580xrns6QcgcdX9WQTEIQoYL3XcwmLRyS/vMVGEUc+v5pOc6ciTwYh0674rrR3cpwZrTtBXK5vNM3qZLif/cZ0bs57CnYzjm4O2Trc1YAU5y7PwyLqyPnsQSf+hGH6ZTtN4zEf18LIMqqMPz+Zb1AM+npBlnzaHiXzZLvaGAIZpwvYiaz278jcw1L3I/5muUHjSstYbcTtkV65oUPl5iGbL5AyAFf5n9ecOp+VFY5hFBvByhmFPTo9u+ncZVlDMJ9YPi/re8TiB9AjSnmD/7yGlHI1yKC2NrCoBGeji4diVhZHj0dVnabLbbaMudRCvtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 02:59:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:59:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Chaitanya Kulkarni" <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Topic: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Index: AQHY8wv9HPFWNovkcEqO1j3PpM9p5K45j8fQgAUmDICAAKCJsA==
Date:   Tue, 15 Nov 2022 02:59:42 +0000
Message-ID: <BN9PR11MB52769AAA5DD2EB433F1298B28C049@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <7-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276F9A4AC8861005DDBB3A08C009@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3J50bvzPallqYD/@nvidia.com>
In-Reply-To: <Y3J50bvzPallqYD/@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6382:EE_
x-ms-office365-filtering-correlation-id: 1f5a8105-30fa-4f93-4112-08dac6b571ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXFLcOtys81CihWdl4twBQxbNAuu0OKWiqGPAZrJEJGj9OQtL3Yrw9eE6WhjCRvEpeT0NzTP4qkwrSYcnu2srjiqu+EvqVaqWxAOMQQvHqcmFAz5+fFVmrtAf85PYki5zmR0Iy1s4J3ZVFGcO/Fqk9zNMIbZ538iuz+pl3Lt6yPdDRifY00zF8K8PkXdOI/X+8hkTuNdqd+fX0LHWbQ465MRQirps8n1rDOgMndT4Avok2J8pyiCEG3Rf3TyARD8Qp/BYuKViSMB8o3G8VdSqGbsb3xxyQGBjIHjckG6uc6E/jhGtnqPvwGqBphEDjDhwEzmLeQqgV54WGXzAS9BdxmJWfZxFxHEJExuj3LsSBHmmJ81wh61is4Gw5kFq22Tx0e0LKFJTq47iqkKbTuMZmKdlVo4N586dp/dB4iMAKW570MKgIpFjk1Tw/IrjlzpMX616lWlqVxPSRrd3cLKG0TRVxstB3TkmnGN+f8l3/FmXj3f3VHdTXpkhaOo+BhP9wQQO/G1ADeekqp0xidhjfAYljiK5T8NSRz/Ox47ne8iSmXPZNr1OsUV4Mfyv1PilasxjHGQk6W5J68U+4GkrsasJHiyRQ8/vnqeF8jhV/GoF8c7Yo0c1lhbPayTsOnHoZXaWiz8pIkCKnOwciC0yjGfGqktx5/Oh4he1Cov+CCdGjhjUb0+my2d2egGiNJUkVDdUuIwrCw6ykwnwjoiyfaWYuGHpvm5AToF2wX2eNSVNl3lhV6nrXTxVJxeRvHNY359e61Q/PHFugMaq3yIGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(83380400001)(186003)(38100700002)(82960400001)(38070700005)(122000001)(2906002)(52536014)(8936002)(7416002)(7406005)(4744005)(478600001)(55016003)(71200400001)(26005)(9686003)(6506007)(7696005)(66446008)(76116006)(64756008)(66476007)(66556008)(4326008)(8676002)(41300700001)(66946007)(5660300002)(316002)(54906003)(6916009)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/6ug3oIFxWc7oKwDrh0ZrzfEPt7cEhxv5U8vkXEmsilpqbgBkLNpuqbtXHCB?=
 =?us-ascii?Q?HMNeyY8ApldUr7HMijkUNAn5b5KNcWUp/Kq69kv+yu7pzQNdyt+GGH3UlJ9z?=
 =?us-ascii?Q?OWUoXmE7lAstT0d43c6KUEKQLjbEBIPLIechwbORC92cZcw3ZGkMwv4qABmf?=
 =?us-ascii?Q?KKHyBC5FMGjEhBBjBFUyOVblpwNpFODnkX28GaAc4Xmzh3m+kJI+ZnJClRAJ?=
 =?us-ascii?Q?gxKkDp/Zzum0CdxVbNWQ5m5APtv72rYkzpzr+kyG467fReMN6fe6f5xpCxJZ?=
 =?us-ascii?Q?i02DpPU601VC0fGoCLoUuPxAbz7aottPpng0wUhIYknjzfxGcdWlL3gfpQ81?=
 =?us-ascii?Q?HXJizCxANF4SjTnBTDhIeGJScwHyERGFOUjYm5/+YISxlhJO9aBpTtPkh5bj?=
 =?us-ascii?Q?iQTtnUh19jdcJmDB3Zw25/hvBINNpUuVWgERNz1eWfAaXtmdzCel2ZOCmIdt?=
 =?us-ascii?Q?d/6Qwbr7Ioi4JzF2LaWys+eyd5uy2dmQVtNJt4SZSa6ovC4cqFcExrGg0XCD?=
 =?us-ascii?Q?Vku8e4f1DWoI6s9R1zXOPWzyMY4wndXfyP+1V2PQc7vHdfcR/FVOhaSo6dat?=
 =?us-ascii?Q?FUG8qdBGRUC7MXgRe9gQjKfbTozgw5H+WckgFDUGkWOXmjarEUEn/XpQUbiM?=
 =?us-ascii?Q?oodlJHrXXeHvtKgEdAfGt1cUsmChypgupveSWFVaYw5tf3dzp+/DpCf4DODF?=
 =?us-ascii?Q?yFMdtwpqck4TiTFH28XD6vatxkJo6uHTUyHLxYbxde15VMpaCSIBbHc502ED?=
 =?us-ascii?Q?ri13DGA3et9yLa4AjlMlbN++8KzWGDx1lmYqyUJSXASKA5EPa+6RA7/8EvIS?=
 =?us-ascii?Q?EpaSI+DnbJUi/xhtWihkVOuec+ceM523MWtHm9B0wniIpd6B3dyzJNf7HAAN?=
 =?us-ascii?Q?QrrI1BG+ETH9OiVhlYyGjXbsi9vfAJKig/rtE7slzjHsV6UezVN/TV/UbU1c?=
 =?us-ascii?Q?hS0o5E9w4snchIo7T4en7cb/f03fayhmx+CZ5kQFscDmHQgtYNeU1nZOLE5V?=
 =?us-ascii?Q?8/fRSHHZ6sG5ZM3qreR2ZqnWn1KP1ynPQw26Q+Sj0TO1uE5wgLunuI0DxN3z?=
 =?us-ascii?Q?2UZHRkst5mdmPuBZ+lmE6XgJYWjTGGlo9svoRK6tB2jeOXlpEBAmKXe5aVUB?=
 =?us-ascii?Q?qXk6IZsO5l3DiltrgY86alM5roFtezWRkoGu5cS10zn3N+BM7Z+hpC85Gq7n?=
 =?us-ascii?Q?AkqaXB2BKFeFS9Qp2spgwO7RLV5XAlHOHhG4NeNrBEEMXOJRp9tfS/4ZTgVH?=
 =?us-ascii?Q?n1HURhYaCnoRzXvHoMzWvCYcOQ6zgs01lvmn+NvmnB3O97Ej5J7cCr1ONRFc?=
 =?us-ascii?Q?c2C3DEZ9dY4WGq6loOk54OhPEV0gdRt8HXH0MfdhYPk4mUOZdYD7Nv2aNYSY?=
 =?us-ascii?Q?w+OKIzDm0AWqmZfCIR7h5c4q2fGNp41wjejTcR2yGODDusPb34WOEIFrIukG?=
 =?us-ascii?Q?InIKJr332T2Utv66aGAA277dARe+aVbAF+mG876nJTw+hARjQtX7kfOXZfx1?=
 =?us-ascii?Q?W5HKyXL+ACNvzBRhi6yNcmslLi7n3epN59oo6n3SCQbIpu2culdNu80BlaD5?=
 =?us-ascii?Q?v0/94LuhFRaAXxNatT6uGh93RH8bEJDQSx3rbOgE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5a8105-30fa-4f93-4112-08dac6b571ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:59:42.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzCXrftkyqAPCr0lsYoNEjJr6VFYivVAp7nb8ZdgDT1FU3rxmdX+1G7Ru/wL/UjvY7ywY9Cg9mr5AxmIjM0kBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 15, 2022 1:25 AM
>=20
> On Fri, Nov 11, 2022 at 11:09:08AM +0000, Tian, Kevin wrote:
> > <...2nd part>
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, November 8, 2022 8:49 AM
> > > +
> > > +/* pfn_reader_user is just the pin_user_pages() path */
> > > +struct pfn_reader_user {
> > > +	struct page **upages;
> > > +	size_t upages_len;
> > > +	unsigned long upages_start;
> > > +	unsigned long upages_end;
> > > +	unsigned int gup_flags;
> > > +	int locked;
> >
> > document what locked=3D=3D-1/0/1 means
>=20
> +       /*
> +        * 1 means mmget() and mmap_read_lock(), 0 means only mmget(), -1
> is
> +        * neither
> +        */
>=20
>=20
> > > +/* Process a single span in the access_itree */
> >
> > in all storages.
>=20
> +/* Process a single span to load it from the proper storage */
>=20

with your replies:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
