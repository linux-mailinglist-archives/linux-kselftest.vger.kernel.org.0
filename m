Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7A7787BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 08:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHKG5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKG5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 02:57:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10D2717;
        Thu, 10 Aug 2023 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691737070; x=1723273070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1CieTg0J/nlpaErSFbverJUdPH3ES4YaYCd7yet7P0=;
  b=Stwp3M7ugx480wp27NY1DA/nRiNWQFTKvh2HsmQgJSyAHOLarqmrXEBB
   Uex0XeiZ6BXBGuFPzWkvJyZJtnjQNfkW41RFMXKrM0CEY/KLWmSZA6oSH
   MnSiY16HqTcSOXqGJ2yoHr55eQshdgA02v5SBgqYDQbWytRBHNoQ7al7g
   A2PAfNfmWTMxHE13EVmmRmq3EBUi7uKxmcl2dwZXwyLNit+s9IvRRS0zF
   oD/1R1ENB5hCzbQf2e5AcfJ8QP449AVum3zEHn8J7Cr47/C6GbNM4/xO/
   BiMDMcS3xTkQincbbqZ4uXqztegymLgFrA54OmKQnMfY9VDUKegJq1fnK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435504975"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="435504975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 23:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802566105"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="802566105"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2023 23:57:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 23:57:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 23:57:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 23:57:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 23:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8ZM1jxz4dyRKt2Npc0LSVd0W/1V6xK9j1X6Qj8mgOdh/SVQ35L1z5VJUex+j9Yts5rHzHiwoZMCfyCl7S1XMxQ0xdPuDF+160LS1U8GwU3117ifoAi5q8ErafNG008jYZtj7no9QGRLBKc96bYWPeFhDcn3wsPYr9fEhG0T89PWDbznDPkXsebbha7AmCjt1H7yj4EaymFiD/UMrddhVjbwgjeeyMsAvJLVzHXnCjfNba+Xof7+KgW1XvYuvMA1yEA3OiMeoGjnSwemzqk/oAzl0h7uQ7h5J4p/eAYhkBdS+KeyzgjCqJzLNFEoQRKsXE259LEhvHsQacq1GzJXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdK7bg7DelPnnTHNPqKhhrLy7pA2vTA9uhLTLmS+Kpc=;
 b=I2F1KuXnpVun1x7bttsXuYESsVs0bgLg2Y9ozo+OgfWa2BKIWsL3ffp0OUjQXz/fGqhCxJlPNIc6xjHEYeFQX8PUh+KRl2B31ydiqZ4AUQMj3pd0KJke2bpKSO3BpoHT7QVErHCVsmr1xiKzAFhionfd3sFSO80RCSnJ2a7u2NAJ6r0ATkR+qbrYxmXb5eT6zef92QlSe2te0dSvm9XqZnrP877aZFOE8pkmSTX6X3lC3DvS2SYUXMs7jsh5OkELDnH0ROZOOpLHVpljo5A9pRBcbQsLBvqaIrs2OvV0gu/duEVnRB9xATqQPEbqEVOQsXY/ykrmaahyINp0MEQftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:57:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:57:35 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v6 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Topic: [PATCH v6 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Index: AQHZyg3zSXZbcbFwgk2ZCXM62VVF66/iLcAAgAJ/adA=
Date:   Fri, 11 Aug 2023 06:57:34 +0000
Message-ID: <DS0PR11MB7529441BE81F24EE5C947B5BC310A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-5-yi.l.liu@intel.com> <ZNPCtPTcHvITt6fk@nvidia.com>
In-Reply-To: <ZNPCtPTcHvITt6fk@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB6473:EE_
x-ms-office365-filtering-correlation-id: 3ef50a3f-0489-4973-d214-08db9a383dd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+unXSHXvFNkTCcXrPXPRb2INgig/2sdTCMtu9PjhSEJ9S/GZC1OYhzg/oJXFN/mKx+N15P3ltJSI3n9mhn1m6w+C5p9mbukwwsiWdty1XJTmu9ZHRnOlqePnD2Y97IAFCWMhBgXD7pMs/0+4YM+HacpzKWLeZ4hxLLC7mD/YhzD4PITiBS+Z3wUfwnC/QqAwj0QPwIFSGs2zaMr2YDl8KpnxD5kilx+EDtOM2BdD2jCv9GdPrCO8SyAW8c2x0fULnRcXfqVfNCIU6YbPqZW4KD4KH8A7G0bntRd8YpNhrC8vRGZmAbJLT2nSZ8fkL9lRP03Q7JUvP+0RdcO3slkBCAhMs3ac2drU7GBuARyW5OeI0bcMbtX9PuNtkSd97SaJXA7QHkG7eCmZicrDr5B5fniQBimI0LKxSJZhCkkUwMFtrnkYS5J2BHwrbSlzJpkzeK+p59fBSb5bkEnt27OhSO8mCqVPks6CeRomgMfJPyt7Hh0t7md2kIIbM5SycZJCFnGsg9h7XmXQ3n1KadsAvgwrvsU14JTlPr6vCOuSH9FjN8hrqXi+/Wj77J5lggd62A63XJNxMHnppdZjK1jKqh7+DPIkEFQ3Cc4Erkiz1MwvH4y4QuDdmGW6t7bhhm/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(186006)(1800799006)(54906003)(9686003)(71200400001)(4326008)(478600001)(7416002)(6916009)(64756008)(66446008)(76116006)(66946007)(66476007)(66556008)(316002)(7696005)(38070700005)(41300700001)(26005)(6506007)(8936002)(8676002)(38100700002)(122000001)(83380400001)(4744005)(2906002)(86362001)(82960400001)(5660300002)(52536014)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5dqZjutnAvUMFVHLzuf6t3siX9iOEmirrnY4DAm+FOaJJ37yJvm+4gmLC1IG?=
 =?us-ascii?Q?Xkez52KRekFX9yJvVfNL/fGsWDoY57NHmcik8tVm11U1YZ5kfagCuElPCJGY?=
 =?us-ascii?Q?vB87chKh7a4gLzfIB8zm6LuOq2qXZ+Xq1ooi+7CCE3m6pcKFP2v5uYbnuIbk?=
 =?us-ascii?Q?AY5zoX7IgPAClsT3K5Vm+YTZeM4+DrXSkqQdI9fazFKR+bGHXAZu8uQZCJBC?=
 =?us-ascii?Q?Tic/vtRXDdk/GtfI6yR/IHIGhaY5h2mJKSGU1ut4uSJDUpMtWtl/tpKc9eTa?=
 =?us-ascii?Q?fdq2/tzaW1MeRk1E2bPSnGk6UTaf8ZOup7Ck6vE3dzN7sQupYRTAZENarVaI?=
 =?us-ascii?Q?FhCjNvTiEi4BNOgwrtjP3rKn8mBHWx3k9OtKCD3s+69Pglx7++36msA4C6op?=
 =?us-ascii?Q?ZKZ4aau5an3fOJ4TMJwcNVA1+RTrOQdLZTEfBvndHpGRadjo3szyiWA80FVB?=
 =?us-ascii?Q?m7NG5iNaVFmVoTuSZDPSONvQDjEkgb8e1iH9HySVlpFemP5P+tXD4YIs3SYo?=
 =?us-ascii?Q?LLDvgqynGANY7GBtFSTSpKHQOJwm59eYf9kphKpz3fwzpBIImM4GqDi6vyh3?=
 =?us-ascii?Q?GfiAiPTfLANyu1EDC+yv22BI6pXd21ymXfGqs5Rbny7tvVxUcJ7m13l+hwby?=
 =?us-ascii?Q?owssyd05N9ZxIbt+46B5N6UYJy8ZwKFR5v/Oc/B977qKwQfnFN6gQY3IAHfH?=
 =?us-ascii?Q?uKOkBzcVqSEYpTm71MHQoTVKzeP+g9KHfGXluMsOdm3vjzNairIXVM1YxFPP?=
 =?us-ascii?Q?HmWLs5a+Zxs84YyKq9CPkExs43UtU8cV6grOiSVd9sYsUQVWw35zw3iA6fMV?=
 =?us-ascii?Q?DicTbJnrYxioIUda7T4nq/Sn7/DXuCbO+uWYLs+cwYF8P+mj3Ud+Ix5mMYpo?=
 =?us-ascii?Q?PKy0P6oeh0hdZwA6I1yOU68LQjkmY8lSYFyOv6dHv1JZMSEC5NAfWDkE01k8?=
 =?us-ascii?Q?sOKAdtMZDW9M8WTbzJ5X4DroUpdabcNqfaISTEkXGO/TkIfulyiOMD1zHQkD?=
 =?us-ascii?Q?IYiB2ZJ4ugBpRtGoN7owInOL8MoHGrcZ9pvfzBetUNZs/KmmwBV5Y+rzvfwE?=
 =?us-ascii?Q?ZVBTJMtvI8KXvc7ewCWv3pr/i2N4LVgTN/sTnBSgilvcQZr6c/uXMzRUWzNd?=
 =?us-ascii?Q?CMbRHP68YOk5LHLdJPNcO7bJE3Z7l0zZfVkj/PB7aTvje1jmuVwn22HuAptt?=
 =?us-ascii?Q?mneTvSZd67Rn2TEGlFHzv6mKfbPLpHO56UABZnKo8yTsnzYV/HaucbcT3d4I?=
 =?us-ascii?Q?TgLqPM4Rhjo/mJ+/MDrE+pU+CPq+F6Fslh077RX9pXDrRmP7dN8CuRl7I1UA?=
 =?us-ascii?Q?t/75p3Xc/DfaOEUKL5wvp5HThnMuq1YtVQtM3jjTqjv0yUBWWIV79n7KbEl3?=
 =?us-ascii?Q?ri8NIhf5Ic90YznVz8vTiwkdkXaoMDkYECkeUPKCaOi1NKBKlJDuegrkTMPi?=
 =?us-ascii?Q?WYG8Iy7II0ekuHRZIC6z0uFS25dMG/XBGLwZIN/zayRdNvB9JJxptbmCqwIr?=
 =?us-ascii?Q?iUakEQwMYecMOahtPY2sgFXgh+DljAFyiGtNdcu5uRS72O5ig/5WoBtT7jp8?=
 =?us-ascii?Q?R+LrbjqU5cPQkeNDM+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef50a3f-0489-4973-d214-08db9a383dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:57:34.9015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZOECQYqjjkO8Y1oyVkK8T2JFuF9dSzUR/cvfAV1/XXbnE1WCPKtA2E/L07gvEEfuVoScxB95axAgLpxYf2Lqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 10, 2023 12:46 AM
>=20
> On Tue, Aug 08, 2023 at 08:35:10AM -0700, Yi Liu wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Add a mock_domain_hw_info function and an iommu_test_hw_info data
> > structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing
> > the test_reg value for the mock_dev.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_test.h          |  9 +++++++
> >  drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
> >  tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
> >  tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
> >  4 files changed, 67 insertions(+), 1 deletion(-)
>=20
> Don't forget to add it to fail_nth

Sure. Btw. Would you share us the rule on determining whether an ioctl/path
requires fail_nth case or not.

Regards,
Yi Liu
