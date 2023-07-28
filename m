Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B0766945
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjG1Jtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjG1Jtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:49:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1C30F4;
        Fri, 28 Jul 2023 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690537784; x=1722073784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7y8bHwWEWwWmFSTq6k+uYxEUitKzhBgMzYj1RFq26Z0=;
  b=NbNGdI8KUIgL/QcgRUtjussCu3m3zbb18S41ZPsPfJRdmak4kBNZY3Cq
   Mf6IhCe7ISsvXD4AAPIxxE5OPblPW/FROu+9cWoNAC6I5SMEm5biohUV3
   QPIb+bxXAuhdIKGE1IJolhdJlM1rbX1IrNGRiFy6ABooK6uaZN7HCnqnZ
   rqX+WHxDbu8UbVoWABpZOwXS23TWspr4kKh+5DCDIvxYZHiU+fKCiIuPb
   CnM/SWCFF57XsL223IXrCNFkyWFvm7rOoUPBZqsfisvl6L6sXPAa2RcrL
   0ja2QSHGC+h+u0ekxJZMwaGfrRtI5MfmaZoTLMqakqlLW2NPy7kompGht
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348839823"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="348839823"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797392788"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="797392788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 02:49:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:49:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:49:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 02:49:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 02:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYEP3hc9wWtexxdi7gK0mf2GSN9GzCdHkP0PBGluaQW033CGTrrgXOUOJWlF6e2/oH7Gv7+pllIm/aqAyoEZZCv1BJe9xJhJCGpzNKl/0kKJCI8NKu2d1QmSLDEiLClhFqNv3z4JBrgweycREuyjazD8U0lCocQ85GVDYzKHtI/VzwLFo47KJbDhYnfPfXj6Dlh5PLNutvSaOJ2xaxnhgiC9pRtEdsrNkG02bHuk44sz/qgSOL6XJQsjy1dXta1HUC22iN6VNnBR6MHo4A/ej0MzinxccvgWqmX5H7EpC1eKMjtKKPzopYjqE0R84Bfnt/Xxi7A1jjPiXVwud/wNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y8bHwWEWwWmFSTq6k+uYxEUitKzhBgMzYj1RFq26Z0=;
 b=ALRT+SkFmVeejyEeKFD6RRG8toaQn3OrwC+TeTNPdA6bT1DddsHqLhlYGx5DxQlBm1jCAlRjlDX8WKn/flHPVBIJAEItlnc8aN+lZTpoXFjiBwzEomCId4RgP0ECRtva4lk+z+b+1n1WpAv623SuNpGeAQTgHMhJbls3c9rITXiToirIO5+2SxX1B+W9wr4za5Dmkez794T+Z8jEFnfBj6hwjavYO4TBw3HudWG/7tAx/9EvHzKqBTu2DttlQXCF7Rl1JAyhgPfHzCNIoCfYIGk4lnDOJWNEZCGx0Z0cRuWhA9XFDYhldWYw3/Jq7ZWmIBqG6xlI0hrFpl0EliynZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:49:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:49:33 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 04/17] iommufd: Pass in hwpt_type/parent/user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH v3 04/17] iommufd: Pass in hwpt_type/parent/user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZvh6d3aPwDPeYpkW92uipxyiPz6/O9UKQ
Date:   Fri, 28 Jul 2023 09:49:33 +0000
Message-ID: <BN9PR11MB5276043A91FCCCC6AA81CD418C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-5-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: df07cab6-0c2c-4c70-21ea-08db8f4ff28f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2il0RlzVh+tdAEVzeA4HmxYY+Y9Su8oPiKfL1kY2OTJaeipKMESesEzFNJC86Qw+Lmv7ExxTWX4s0gz1NE/POyJehsIIVGo0cW0wGFIL8VyaMBmLCrVxErmqhMvG2gg/0s+Vx6WY77CXEI9PwpPWm5zsOxTxLGGr0e7BdWewIxWwFrZXf4o32eE4nza8W3gEydVDxeOHsY+eFdhIXeqSzrEPaEnRf0xWrYgBroNqxEgeiU+kK7ypdUHA/8axzPttf2014EZThuAEKDFprngtuRusjW3z7lBlivRmldcGaNEMum/PsNW4Ik0I4ydPU+CHzW95cdL0XzKd5crxx4f8wn5ntzDvM0YJRfSIcQXCSuTsHCfo6HxvQdwvartUsZNvzpZxiLGVKxkv6w1wWcjtiV5uzD0TUv1ZfwSNWUCtMHMB1tL9djVxcKJwyTE7rkNXGsEbtPcE/dOpWqs2iQTZI4M0SFddVwZ8XsukGnDy/IPBEzWtwJKuHpBQZ6vE9k/3/9bqe5oDPOHN3MZB3Z1BvcV2ABX8injyIAS1/ZP/irkR/DplwBLsEt4mQwZvj79+O55yrBD7aXeXvPwH45i8B1cBYbMCbGkx5wSiDiRjwmq1VsMlOGuYNpqJ465JlPX3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(54906003)(7696005)(110136005)(9686003)(478600001)(33656002)(86362001)(55016003)(38070700005)(2906002)(71200400001)(4744005)(66556008)(66476007)(66446008)(6506007)(186003)(64756008)(26005)(82960400001)(122000001)(76116006)(38100700002)(8936002)(52536014)(316002)(8676002)(41300700001)(7416002)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hcMSSqlMjeRzkLE/UJhmRq0ljR7Mf4c6i4gCgVCTuPIL9PEXFHyebWVbdoKK?=
 =?us-ascii?Q?vs+ZY+iQdUhY2wKPGlIs4KB2mwZXa6DBnzHHIaSgRUF8GpfrJenr75kyx4I+?=
 =?us-ascii?Q?PgDB3jQm2OTE72ngW2V22gnJQac2NCzOTj2rVwCSPi/ylV37IbGxedNwiTgF?=
 =?us-ascii?Q?jjqH6dSsjze8Du5GDl2NlO/XLNc6NjgrlTs5ujXYEYrWZXqSCO/r51Y58lG/?=
 =?us-ascii?Q?1Gdihxx1Ir7g3VXsVwIN/Hzd34GI0XukKHT7u5tMculoMyW8uxOoUP2hPEIv?=
 =?us-ascii?Q?Matuu90aM3Zhw/yS7MAiUyliBwCakpshcopj2p82+7wossHT13n7RuqF6hNy?=
 =?us-ascii?Q?qTea2EwVpb4RUvJijRswyg6I2nYdVtINLknIdlHJ6Y250rg+SCpWvhuY1z7X?=
 =?us-ascii?Q?2eNXxUN1w/HcBrI4dmteuDGMX+NpWSBm3Lq/DVOJ9ka2g7UbMqEv/88E2ExV?=
 =?us-ascii?Q?NegyGHHQX1j+SAtHQW03eOJ21wmlW8QgWjMuhKDDKyAhFu0DvPVG+8nxdlTe?=
 =?us-ascii?Q?6l7YU+VsTHZai+HmCYctP5aGLlZRmbZI3Qq/ZdIsAkIQBzy/xSsgtSsrobK5?=
 =?us-ascii?Q?7lO2Sl2Wg6n7tLyTuKZGk7ZZb9HgX0ZJcgKVaF1B3X1W9kQOk6wwlii04dDg?=
 =?us-ascii?Q?KC3/gw2XvSBt0jaz2aG7kGOed0e0FRcsoc0gobyQjpRT8neMAtnIyvYEhpxO?=
 =?us-ascii?Q?boGm3QniU580s+Pb3tVimc2OP0+6Red0bQiLHs4jNIN0dd2LOrIV+mk8hcae?=
 =?us-ascii?Q?AZvpWyv4+KWTjoCTzsXG1i5N/MGGmeRfnEN4qXmNX0saykHncxBMWWo2YJDK?=
 =?us-ascii?Q?Wt8lBxl5kLFCi7uU4vtBKVeODeW94ek40B1GF3B9WTMbXVnVh5I7t3QeJibo?=
 =?us-ascii?Q?Edw0RoWBuDjNLunZYZ1uU+SImweQUsvXBoUuPhNfBgYN7lHRFdjIIxyFhQoM?=
 =?us-ascii?Q?d31TDoqwW4tfzvOOLse9Mr0RhjR3k/cQVTis5azDpTvbctxodjbgSto1CX8l?=
 =?us-ascii?Q?2TFdB3HokofO/FPkchT3atVc0px7boDV7IfSzDRak9m78kBYWGpjX/puvgxx?=
 =?us-ascii?Q?XHgniYxXGcU7Q1B/EuKl9SL12jfOcMVVv0fOd21q7NcdyeMeArQKdYVoEacw?=
 =?us-ascii?Q?fpohshXWklXr0Tr+drD6mkYfgxHY1fRMslEU5YHuq17zzAci9JDTrmyqRFYr?=
 =?us-ascii?Q?1PcDTj71t0Y0o1UFgAYhf3YHI+kEO6mZpGWxWxzUKnw+3Unci//dCaCNfDGN?=
 =?us-ascii?Q?hM4WAymYJvVAJ9z20yb4sYO04zK6SIEUXwDfzl2l8h4S9ISh/silitWpr9pY?=
 =?us-ascii?Q?tT8LfbmDsoJDW4BILFnEGMik7PMkjcseWN3jkzF4pt80NiWsbYWdpxGIhwfB?=
 =?us-ascii?Q?VvrTIUpqQ7IPun/1ZwHf+f/ogyhlHEOZqvDC8q2zAEeQUD+0fb8TLTXjftr9?=
 =?us-ascii?Q?pCkbFymOHeIUzuoLRxNb8BwKio2m7FLZmyXr1AMB6fOEHWCrofIu1TBkCkoj?=
 =?us-ascii?Q?GuXlHDHrcRkzVOiS6a1S3qPIwp7FtibhMOol0XwPwuBsHsTxVLec2lPOsANj?=
 =?us-ascii?Q?4uTSy49yfw7DukUrV5uV9tKW4V03g0mOFAyy+UId?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df07cab6-0c2c-4c70-21ea-08db8f4ff28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:49:33.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMb2m4ok5TT+4MHFG1kcdNkM40RmRoH+CM/1DcinOcKlHfklCZe1mXzRTWbVfNYzvdViSEtw8y4DNPVie6WHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>=20
> Nested translation has stage-1 and stage-2 page tables. A stage-1 page
> table is managed by user space, and it needs to work with a stage-2 page
> table, which is a parent hwpt for the stage-1 hwpt.
>=20
> iommu core already supports accepting parent iommu_domain and
> user_data
> to allocate an iommu_domain. This makes iommufd_hw_pagetable_alloc()
> to
> accept the parent hwpt and user_data, and relays them to iommu core, to
> prepare for supporting hw_pagetable allocation with user_data.
>=20
> Also, add a parent pointer in struct iommufd_hw_pagetable for taking and
> releasing its refcount.
>=20
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
