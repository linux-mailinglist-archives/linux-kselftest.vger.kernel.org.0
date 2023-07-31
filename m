Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8EB769696
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjGaMob (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGaMoa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:44:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E4E63;
        Mon, 31 Jul 2023 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690807469; x=1722343469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q16XdQQ5IKnlQdtgRp2QQWYjOjY/XdAzj/Jb9913Hho=;
  b=WMCLoOc6fkQijQl405t+bD55O+DIa6phuOmN0wgGZnVqGpGxRIwXk89/
   UMCJO1qMpkF6hi/AtCzNFUQ4t06odCRfqcJGNL7ZzScHL7ucgUCJ6ESSW
   Hm5+KhrFkv5IiA5K9d8nlVDOXHan7cn0L+3N+pp1ql4RLaLgP0EKcatK1
   GkM+2cyOtdZLONhikFMkgWlPGr3cFaMISiDHxBzGRZCQeCNGe5LwfMsMh
   WdH497nGLpZVk999bQOXva+Bp5CCCvCDnm66Qgq+etI/5jfOuLLYiRyRd
   8ck3kdkZK2tpIFhx67V8BFmkGpDbnbPXdvRWzq/nWVTbc1nj2vxsZ7tC7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367900873"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="367900873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728300571"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728300571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2023 05:44:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 05:44:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 05:44:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 05:44:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 05:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWuP2RsHjjFnIEku36VJGWVOUCzRI2xl2hmqfQXp3/fuML/UrAcBIU8wKOf07ViQoAHuOwVdWND+zo06aK3j+flcD3TwdxP1Qimhzlq/YjfFFEgSRnmCiUsp9Hml1lPM/W0bmgJnsKjP2nMCa09V0vg9okGhAtyg1SXFcjUe9HUATy9LxzbF6JHWikE0/RY0lAcG1cP8/1QK223Jd58ekfzJtv7xOtPq3YCi6vFo2hvihmgViGAaXMaIHauFvy03brEJT/CqgviScLkyvB4YAkN2McE5qjU07ZSHkQgEmTiip538BMfhh78wCbadFVQHHD1WXR6rzFogESp2RPLZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdwCo4LSyf/I3KS7S/241SVTI0l81+FaPS/hYCjz3QI=;
 b=LQla30QqLLEnWTBdcwzoQXxHpiKaxiY9qVIxsLf+eWgJ0P5X10mNU3F6DuwYUtdTR6+Y5lIIc6XisUeORUSkMBiZqv3yT57dUtuvPeCj+DJLr1xJEcRdLUAGQDWTYjpfMAf1D7PnDaFJ/1tMe2f0aiLx0hhfKDFTG4Ew3jk8Je3ZGO34AKkoQfHRj/cF5NH64wlViv6BKn2vbDcI3rEF3n0ysCMZap3Owgwyfte3bGBJ7VsJwWc0uB+Zh4z8k/12YCoVzoqnVWLX63hDMTooCZESyG8MvrMgYrxZTbATpdXj8QsWEZ27jBouNzeiRSZTquTHcs5G8pj0kbPaYR+Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 12:44:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 12:44:25 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
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
Subject: RE: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Topic: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Index: AQHZvh6eWezEip7iu0uKWl7ARH8xia/O8fmAgAB6lYCABHBmEA==
Date:   Mon, 31 Jul 2023 12:44:25 +0000
Message-ID: <DS0PR11MB752907DDEBA69BFD823F09EBC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-2-yi.l.liu@intel.com>
 <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMPzJd6iIFk/51Om@nvidia.com>
In-Reply-To: <ZMPzJd6iIFk/51Om@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|BN9PR11MB5483:EE_
x-ms-office365-filtering-correlation-id: 60efc0f6-cae6-44b1-d470-08db91c3df20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzEGjQbe5o7g/vVa1GXpAvv712K9Em9f1ddSNWNIJF2o/Zv+szZlUYDMNUKsU1mcdsqpjCDWMCVRV1ibW6nRia5TN1tf/mQjngcAzAYw0z4F6RpnahE75u4lPySQLnHvMm+JUQ/ldbUFEjdnwo2bfDXqiyDhufvVp8A4i+eT6q2DsVVzRQmZiAZpjyimAIY1h1xDYfdxnDdFTmG1JZ54LoP74pGKB2AmqTB/7rUpSNWsH1DYi1w1q9Xpa4oqzFZZz9ExkK6pRQnav58zSQ+fNhK1Bfepmpz/yv71h5CykUtG2C/o4Z2uQg+MllVpjM4+i1vxtPWEikz15Z3MzM9yYKwm71Wn8EgTdnsIqX9VIa2S7ikUoUspGj9gUK4yv+9QfDXc0fyoNApZQfyspEGgF0R1c6EwgDGuOYrOHstQWi6pku3+nIjwxswq71Wi5Vxka5bAruOChUC7yiFtwtkPsAQC4CWOxE+BDld+/P8yNgOy2QmfzLEN7+8uazqyfbCruwJ3wdI+UW0MmkTZQfPOwmnDL8q25x7eCiK0ITIHC6sy0qbGtVXciYZhjrDTamnNmm08N5nqlOZEtsmFXKuGc1ZyHGFmegCfYDUbpVjD9UHcKoInFO/LNMIUniDNhkcy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(66476007)(86362001)(8676002)(8936002)(316002)(6636002)(4326008)(5660300002)(66446008)(64756008)(38070700005)(7416002)(122000001)(41300700001)(33656002)(66946007)(52536014)(66556008)(76116006)(54906003)(82960400001)(110136005)(38100700002)(478600001)(2906002)(71200400001)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dx+3cBR4Cl4fd98MPVZGYQFKMWmdG4ysYZuAP1q/dgLa27/vpUBV4Hn4Sx/m?=
 =?us-ascii?Q?uLYU2tq1B7JM0NwFHtKmTVbQkdh3OhWEAOYaXmKSn/FEEKHUUMi2aAJReAd6?=
 =?us-ascii?Q?kaxaylUf0K+Xmk03DfhNEHqEEsY2dic37/CaSPAYnwnq6zg6zaDVEsxriF5F?=
 =?us-ascii?Q?f7zkveu8HlkqXJs5JFDIMKEZupogNGnC34jns/+pRjDiAf87zhs1fWBa4uQd?=
 =?us-ascii?Q?NMhLcKVb3PmA8kNXud0aZwNRtaNjOssLd5+jcC6TGVHvGUpMctfFZi5XkWuY?=
 =?us-ascii?Q?SsHef+aT6esPjQ81SqMXSlOrFfwlC96ru6iDKeCeQpQtX5N7UCFbjFCnibZP?=
 =?us-ascii?Q?JQlzL8sDYSTmW0O7pndqWIzEBqGZ2apOEbGw8Dj28llnPp8YS5lZ9lKlOFjt?=
 =?us-ascii?Q?oZxZEivm1zoFmwOPwJnky5h0iWMf+95ftrrhh1JLDEB9nsakmZ/XnrR9Ji2u?=
 =?us-ascii?Q?G8w/SnnaeQsVoIrGWy5AN0/Y0N0hJf/j90ygISviyBmNjXyH+bVpyAk/HwjF?=
 =?us-ascii?Q?L/Xob28S8LLNhNU3mwtAPbOCMk0zqPPxu6TB8JmAMFLIEEO7q+kr8Ds2gdk8?=
 =?us-ascii?Q?ch3gn/JLB0ON2DmEM5Od4qq8gFrE00J5LLAA3r4a2vXVi2zWOiXMcw7MK9f6?=
 =?us-ascii?Q?A7a/c0EnwoF0FnzLG1INZL8ztK4EMFpbALodpo1B3p1/reUUOYFEHT7R/8JV?=
 =?us-ascii?Q?PB6qP6PwcyhQC/MN1u3vgLDwt1HDvJdu/zgDmYeXi7hSrP9GHrLNwm/xvri9?=
 =?us-ascii?Q?FEJPu5gXrzTgGc6/8iwa7dhHvpU5wRL2+MFVvcp73lEFNElATL5C+2K8/ezO?=
 =?us-ascii?Q?MzKkVIhyo1JBQly3UXrSiIP03KMKhrOIaj4YQrACXHwmIpzlXAU36MdERQ37?=
 =?us-ascii?Q?/hB7lV8N6BvnTWt1VbJeUOj2bCpJnOAZW2ABxBOdbcHodQbWL3CWyyCAQruW?=
 =?us-ascii?Q?svWK/bBdHES/BQ8yx/5i2aVNYsQK3Yz9EUYE2xUoN9Rq6w9WVjFrHhe09lIQ?=
 =?us-ascii?Q?D3OGQI52512/8qM5ULpeKYSbqbyRCYPoN0zpRHoGmqEULHzynODgYREjRUWy?=
 =?us-ascii?Q?+eUbR0Qj4Nb288CbGFJoCSR7blJw6i5swj5qseU5Qo782+h8MvPCQE7Lb4AM?=
 =?us-ascii?Q?YalCZ58Hy9waCA2y4hFzwHQ5QkUuZRi21qSJRHDbHy+Z199Kb9NQSgjyAdFX?=
 =?us-ascii?Q?YkkaAM3nTkPkxRPdnH12kxtAz+iI6LEfdhrDrP2832CAQ88hlIp1oIBSbGjl?=
 =?us-ascii?Q?vo6SmfiomJjOhw7GVv7XIrrc9Y4UHeACJwAd5+xszEuAhNFGvBqP+mScRGAT?=
 =?us-ascii?Q?uSDKkhGA+xTSnf8znzobvZvGgoxUXjXpgQ4AJg6m9k1QOJemJVNCsvwhuHjt?=
 =?us-ascii?Q?tGPntJnHavBc9Q51/YlD2pP/Y/zOL9fGs2Nexinoe3DJlR0RYuTACHuDsH58?=
 =?us-ascii?Q?7Hi6O/dfk6YN2ZIBOoKXCNaxWAG4dsGhUjPg5BfLPkCGzbuuuMwxSxKlh8/K?=
 =?us-ascii?Q?uTXVL5EuaKN/9LQ17Wn20dP3ON5Sll8lz3eG6Wscm3fRXOowcdaPkcCrwj3m?=
 =?us-ascii?Q?KG2vQxsG/qSz1ugB6euxa3IhU6qYM0oxaE/3ioLm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60efc0f6-cae6-44b1-d470-08db91c3df20
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 12:44:25.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6XuoGRaFO3CYBRz/Bhxz/7SIskBjkQdegKAIpzaFicpf3jue3QTFX7Ek9EcG5VcbxOdIcYwtYuhzRF/ZI2GUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5483
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, July 29, 2023 12:56 AM
>=20
> On Fri, Jul 28, 2023 at 09:37:21AM +0000, Tian, Kevin wrote:
> > > From: Yi Liu <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:04 PM
> > >
> > > + * @domain_alloc_user: allocate a user iommu domain corresponding to
> > > the input
> > > + *                     @hwpt_type that is defined as enum iommu_hwpt=
_type in the
> > > + *                     include/uapi/linux/iommufd.h. A returning dom=
ain will be
> > > + *                     set to an IOMMU_DOMAIN_NESTED type, upon vali=
d
> > > @user_data
> > > + *                     and @parent that is a kernel-managed domain. =
Otherwise,
> > > + *                     it will be set to an IOMMU_DOMAIN_UNMANAGED t=
ype.
> > > Return
> > > + *                     ERR_PTR on allocation failure.
> >
> > "If @user_data is valid and @parent points to a kernel-managed domain,
> > the returning domain is set to IOMMU_DOMAIN_NESTED type. Otherwise
> > it is set to IOMMU_DOMAIN_UNMANAGED type."
>=20
>  "If @user_data is valid and @parent points to a kernel-managed domain,
>  then the returned domain must be the IOMMU_DOMAIN_NESTED type. Otherwise
>  the returned domain is IOMMU_DOMAIN_UNMANAGED."
>=20
> Notice the detail that this API expects the driver to set the type and
> fully initialize the domain, including the generic iommu_domain
> struct, which is different than alloc_domain.
>=20
> When we implement this in drivers we should tidy this so all the alloc
> flows fully initialize the domain internally.

Yes. this should be documented in the kdoc. Is it?

Regards,
Yi Liu
