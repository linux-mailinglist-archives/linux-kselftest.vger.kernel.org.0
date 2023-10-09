Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B97BD1AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 03:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjJIBJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 21:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBJx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 21:09:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCEAB;
        Sun,  8 Oct 2023 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696813793; x=1728349793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tefx/3h1WR6EJOM+8PNLlCYjWX1fBOCg8xSwp8pviMo=;
  b=FdjHMCNsAqsbvLG59R3PqNI0BPMZEW6zBJyj7WOlKOz6JxVWDYJvQOS5
   vRNaH5HzV1VcKQxz1/86KSvXRotbMBx932LjJCE0kdH0jKLtve6OzO2ss
   uQPRLc7ncMAQl+/QGABOJFxb5PYuicJtmvMthgTK0UJgNAO5JpBIf///u
   QiPc8ehKd2xoiaH4XlTDLJSgvXu1QFmo5h0XwGgfhSLwDcbreg2ft3wZV
   ttTFmPCzKN2QEenBUwrse3piPSwUIDNm0vhuSxOJKSPTbH7Jp0XbMSSSY
   /hRA9JuqOw15cC2qXBxZ+rbHqvkyOXuf3jmctvulJ2Z4gts/ltImDaPFp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="2649171"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="2649171"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 18:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843525003"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="843525003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 18:09:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:09:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 18:09:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivf8ELBI9C2nWtSyIIU1PzcgtBKp6xR5aZRwAIS4fkzELdv8uxgHbRAyYo8pBNw/hOJIR0ImehTasmHvvmPEtf4ZQivdGjYgRrYHqlogCHlemjwuFeum+2Ua+0I98Shi7KmhLcy8MnM00kZb3Q5XRroifkn9zfx7HQ3WYRozoUw+kyTc0WlKI6bLKsGh+z8Nui4sQVXHehL0t/SMFw6qif615G3KHMyaYx39oIKBYEzuypMH2ZX+Ov36+aZIhKxoZshbKYeudZm7drxhxBJ9NGqxzyj2Q+kXNTrrCBlCBIJGIoC3c6tUFTjhAqVki2xbS+IueKDxFXhXuT6OIJsruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF5OUdZBhXpAl8YsNa2OrfuxinMJWTVlhjFtzyHXg1c=;
 b=mAxZM6o+o/HrfIfml4xgxxkaIlzxaDriNLLNgZldqHlTIXt2rKf9GIbSMcmd6IH+1ZJTp5OOr4ZmZ1QqCc5hw1n+B5sNkU0AxOmyD+hSFezGcLXMVGrHwZvRMIT4TTHVBAL7odFFOKmt2JBg3/4lPbs/kdPMt0xYjMbO2sOAS/70Dr8pwZBaF12mI9paAd3Zy4wlIFHhzXwoSgqGCGBJB+tMJUo4RFZFlzobwPt3miensEhrOqmqGaj80a7BqpTxccROiAJMckgZ8OLlQ/K44+Wt7l4B7MGAF4kygGRMU5CzgHv1inUx+Z2jx0h8MXkEtPGB+WH1J3hdQ6xDCeMMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 01:09:48 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::53dc:1b11:86de:ff9c]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::53dc:1b11:86de:ff9c%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 01:09:48 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Topic: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Index: AQHZ8duSU5XbTPBwc06Tv5gX+XskOrBAtr5A
Date:   Mon, 9 Oct 2023 01:09:48 +0000
Message-ID: <BL1PR11MB5271DC6104FECB86A26565828CCEA@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-2-yi.l.liu@intel.com>
In-Reply-To: <20230928071528.26258-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL1PR11MB5445:EE_
x-ms-office365-filtering-correlation-id: 8893dbb5-a61f-4355-d424-08dbc8646edd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTC+O2iophLLVrtUh3lNMufjOSvkSDQx7gAo6AgQw05v4d2sYLoKaWnZZvR3VtPqPkT1MTPb3hNuhvbJwsQ61RIdrbrP51hwTAbgrrcQUqVaAIq0TT9SuIF+8qu2LRbnu3AW/+PWzaTjLPtjsgc7RmU2wEb7GcETIe9nLDCyqO6+Abj1mmWkrFPN38nzM+b6N9m4zW8+BQs0p5bLYhbmP7tnk2PDwnNPSD/h80I2YF4kTtlJfwb21lw9GbbQXLfGEY6BwysGQJr5OmcJ1GgesvH+7p756LBPTsYRL95bi30ZPgtnW2indQn7hNmsg+Y9oyOl6Z4n1LV4kn+0HXIlxbqLCshc+TKJilbKWqS811H5RSLogL6D2cVrxeSS09lwxBAJfbZHuznrvo8uNCyeNgZvFLe1JEM1n/w0X4EiecrabVWDyhA3zrkZpfSoMpIFFXRW9tpA6eqfA/eFIs7492UkE6evyZ9H1BI4Eh2zTPXaaYBDALXmetrPKecy07T+92Z/auNN/2QZyVviTg2b+CNkVIsTof7FnG9l2uWkSGmACz+964T6YBR4axJGBQMUwXeNc8YQGmesON8R/W6l0ww98DIwV8gyCOOB+TdA/e9m9wD4GIQHeJg++wIXahbP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(83380400001)(66476007)(66556008)(66946007)(54906003)(76116006)(110136005)(66446008)(316002)(64756008)(7416002)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(71200400001)(9686003)(2906002)(478600001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dD8n3AqQ+FXJmPq0hCRezi956xa7mjdQQ4QW4OM6B227PF2J/oLv+f8LnAbp?=
 =?us-ascii?Q?tksF5RDJenFLhC/IijGSgxY30IkQwu8oYbtCK20uKNh/74OPEblryr0YeRy6?=
 =?us-ascii?Q?UBEJuOQI+dtTEXPoxSDFEHW6ACKR1F0sUv81fVmxMy1FoLbXZas+xqXtgpYM?=
 =?us-ascii?Q?XJY6ZoLJrCXxcyseICEGMaPMcVPS3Ka+cfTIrfeKbJeZcj4YM0d/IzO0+bLT?=
 =?us-ascii?Q?ijycz581DEgdDdr6JdwoFYYIZcDx3/kyEe5ISi4XSl2sNiS9+9K9m4rbtfFw?=
 =?us-ascii?Q?Er3Ixp2bRDRLDcip2Jbs5DTZp3CuzJbqcwgwYurPQaemZWfqLcuunr/5itIk?=
 =?us-ascii?Q?ZZPnnBHSHeQ/EcnsFJRdcHvBDS2+1x5PULj23G+WZBVg5oO08+TTO0F/ZhFM?=
 =?us-ascii?Q?eM+cRQrdJwMGNsb+mAdjgn86G42c1QOHMPIViKO1BPlHsD4OwpL4IRQw8IFp?=
 =?us-ascii?Q?Dy5gQmAXtYzx2ABWpnJWc1VKiwNm+MpRXkXjU863Ax9tvPGXYfeKiGnCvfTW?=
 =?us-ascii?Q?UmqHAkmRrxldwGJZ8Y54UzHKp2m/+N5wrGIRoKLa6zyWTYWBdc1nBPyL2A9r?=
 =?us-ascii?Q?QprRcx9RTeyIaymvOukdvvJilBsotc3LSEdMoSLiayBdQjdR1CkZBzcecAYX?=
 =?us-ascii?Q?RPeRLlQHqP8VEeIqWr0l5jTSkA68WoSxrxnuhrsl9/NtYKcpSC99Kied+Ug6?=
 =?us-ascii?Q?eCuYtbVrNMwiaI4o0YfjSLb5zB3yalIjgC9lJQnULX13tCk588cZrWAHUVUc?=
 =?us-ascii?Q?AgFDbC0WTGvWZcSAVJnWk2H6ydbBBO+KNX8AlwH8zC2yFse7u+bGxX1yP4yb?=
 =?us-ascii?Q?tG/8uj7349bkASAZeKLuNRdU3XXvDVxKTVHf369rUSV8uGWDP71kf5+4lXuv?=
 =?us-ascii?Q?YA4IVO8+mxnkUB6BcPoOLDQKoBaQ/DioaZRObwv1caJjcFRD4+BZre/JM7HL?=
 =?us-ascii?Q?Xzx93wrQgGdQakdlj5lIGxi4kALkROpY38ynPsfHzX/YULtcV/+siDNn4wNC?=
 =?us-ascii?Q?KaFSC7m+AzT95IoBVTi1I0pcI77C+3xulVU3pfquZ9I9/OAMa0koiTmmrlRn?=
 =?us-ascii?Q?6ugBwOTlSoTwATH+SpuzwVfgjkXHSswPX0rmOeunPFnJwS29IcfcWRxR09fz?=
 =?us-ascii?Q?96xG0lvvnT+WXlvwNmHlXBEO4BhlZG3JFYvCCyta0jEltxU/yaQDn8mfd2Ig?=
 =?us-ascii?Q?qK0dSYOsuJ9cEDLOu2gU92JsTMILNDs/vrIrH0aLtK5I8iKdAejnuYmh2lAB?=
 =?us-ascii?Q?C8tqe/aD4KXnUlGuvT9+kHG863h5Tf0Ma0Hhu8wi4K0Pamk1Yca7yTvz/0hC?=
 =?us-ascii?Q?i9SCQQ/QiQJeqnUB4OUn+kuCN0NN4n64+ooneALjPqQ7MtFJnM95nl6vSXNc?=
 =?us-ascii?Q?d2mImhWdrUY3+63SXcQNSl0u/wGokcdAuKx5mASxKK4eIx572Gx3DC/GMh8C?=
 =?us-ascii?Q?viC+P1ZQXOVINxso/4Q+weA3QDEvAgqKv3fQp23w3HsPT1l+oKl+3pHTsi0X?=
 =?us-ascii?Q?p/CSy4to083FD2zOjcQi6F5EFWP2OwBNX5Vh14IuvWP1wsNmhgaD0juwNQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8893dbb5-a61f-4355-d424-08dbc8646edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:09:48.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhIrUIwH22f/hkQnhucMUK+/5BppUOOii2bYs/a15HvBvfXA1HngnPh4To4s7sJ7PfnvP2LKOToMW2+LnZjl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 28, 2023 3:15 PM
>=20
> Introduce a new iommu_domain op to create domains owned by userspace,
> e.g. through IOMMUFD. These domains have a few different properties
> compares to kernel owned domains:
>=20
>  - They may be UNMANAGED domains, but created with special parameters.
>    For instance aperture size changes/number of levels, different
>    IOPTE formats, or other things necessary to make a vIOMMU work
>=20
>  - We have to track all the memory allocations with GFP_KERNEL_ACCOUNT
>    to make the cgroup sandbox stronger
>=20
>  - Device-specialty domains, such as NESTED domains can be created by
>    IOMMUFD.
>=20
> The new op clearly says the domain is being created by IOMMUFD, that
> the domain is intended for userspace use, and it provides a way to pass
> user flags or a driver specific uAPI structure to customize the created
> domain to exactly what the vIOMMU userspace driver requires.
>=20
> iommu drivers that cannot support VFIO/IOMMUFD should not support this
> op. This includes any driver that cannot provide a fully functional
> UNMANAGED domain.
>=20
> This new op for now is only supposed to be used by IOMMUFD, hence no
> wrapper for it. IOMMUFD would call the callback directly. As for domain
> free, IOMMUFD would use iommu_domain_free().
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
