Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5A76C561
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjHBGk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjHBGkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:40:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AFE2728;
        Tue,  1 Aug 2023 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690958450; x=1722494450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zWAInL+Y+JvL9c6U27dfKWQhhLmxrfhU1BGGMim9Z7A=;
  b=T4w+X/thyIpD79YcJnMeEhE0tgiTVVmT1toAfjOMnDXxPcYDcxiaWtB/
   +Y99l5GHcM3X/yBrGP5V8E8NVzTEUjd7T5T6yoEy1LI3cUtxbeQ3eIL0t
   xQjGKMB3j7qdwqKJ6hl6c4VhQgd8JxHcyOOxBknIBv2vAAwR2kOidaq43
   zD9cSqbOKgNtFHyyM+Mtv8TRoxnoqYgpu0McqCrvCBJW9eRJiQWZ3FW3L
   iy61BZnf0XL6/Q0JM/E/KqMwXTIGq28DTivNefRJqom8bnHo6+jEUtHb4
   69iBMqeHo91bn6BZMWI/jhGMJvtOjEj/JFcy3G2G8Nhd470s9pRgbVH3f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433336604"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="433336604"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="728988969"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="728988969"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 23:40:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:40:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:40:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 23:40:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 23:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI1bXp+MXOhiXCB2HWFxCb89Udf2CWgkUneUedLZUDrEW7Gd7+QY8ZiFhMpLzhOl6R1AzKUglqS3OyCk9ZH4JlZb6khl227tKAEjm9UAn29p5vWgIdq825jAe18RGXtAVwTvHFm0SF7umpNtNgZwGFNJ2qQ9uCuMjJCmHRO+sa5NNvsfJI0JiKU1RlVKH/D6fF2leTYPdogJ6k/4wKZWapeMpiESZYY1GvhhY+cfptNTt1gOmC1pLTmKh/MLSNL+T/hobShm9c75C7MlLC/dPDILUO2QDND3v/zYhzg/TPsblZoUnt4sgzHhwRmHZDWAlIGad7YLYeOHrMENvYcggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeWvosz0upjVcHKU886x0lu1I7VS2TZ7oRc0Ddi5LTw=;
 b=F5GWHJMi8t8shcw3FO/325/kpaTinrMceTjBGjrUBHUgIksI4c8Tw5FaPH15PozcT1pNZWjzUsUmgImZXonHctyKMyLR7P/dwKZbbPbRLcMmBKirpzwV5GIS2G+5Fv+hfr9dCiTwziPXHtoZuUTCT34YSPJCZk8eD+dOzvAXpNOwjhkaqdUYVtfvtfdd2spzMRubkGnGeVBvKdcJgPLyLrqrD8l/jnGtMHWd2x3ri+NRrLWvVGUTMzxVK1Zkr8q92nmHXO3LfVh/FkpWZ69ccH7JwPHbF4Tw/So4p2GmF5YyGbmlRVXxILy3woT4Lvplh5EH2tT69GL50H4L2i4qEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:40:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:40:45 +0000
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
Subject: RE: [PATCH v4 01/12] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Topic: [PATCH v4 01/12] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Index: AQHZvh/r9YX/Pz/Wpk6TTWJVn/EYta/Wm1KA
Date:   Wed, 2 Aug 2023 06:40:45 +0000
Message-ID: <BN9PR11MB527678547A8F9E98EFA4D1AA8C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-2-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8465:EE_
x-ms-office365-filtering-correlation-id: ca86a237-230e-421a-b9da-08db93236679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aikdYxFN7wGbgilVgSwgO7CvoKE4DLdFq5PDPFEw88Jh7yYIBBCMTonn/Y+989vJ6LAPmo4hbTyC3qLfmhBywUt3ajUzwNBNKacwcLUafP1Y8jjJC5WXlxjJ7LKbXoMsokHET/ka0IEvLUIHfeOAOgrspldcUnQpBiY1FiE2mv6Ocn+MD7MplfX82UyJpzK+O3hRWj4MnXHXDPHyxys1wNs+MNJ1r1xToE8YtSQ44JCloAo2jndXfwYcFMYfR1qONEwM9wtu2F4pIuJmgRE930AxLdS5sRJZ0nSJXDyeWwtjzeYmPPvWBtSLPzD+riwd7p7S0LfIzP7vTt5DafBUYCDOKVJwBdbmct8OhP5V6ZzHb3xotfDy9bSLICXHWr0nFLpyJaYWWcfRohS96UBrjc+s2TRNBOnJuzug4pQWN0zuW52o5wpGTnX0C5eF+fyVK4od1PggR05r5FxGB1oQvHdYFizjPB9W3V6EExRYT142YMfyxHM4vVBp0joMHyZBmY6IH48NY011dU+4cCwyLS2KahUaKIAngxuXnchiWadBdLOtMhrowfYNygSCi0ipvMW7qHV6W68hXMuhBQi8EMYQP2/64tvpnyLbc3EfG5Tu5BHZ8pywM0wlNXlHxTn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(66946007)(2906002)(76116006)(66446008)(64756008)(66476007)(4326008)(66556008)(7696005)(33656002)(71200400001)(86362001)(9686003)(478600001)(186003)(82960400001)(38070700005)(26005)(6506007)(38100700002)(122000001)(110136005)(54906003)(55016003)(41300700001)(4744005)(52536014)(8936002)(8676002)(5660300002)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UZWtoX+/BIY5VkDuCVGfrzwrbcue5zPNiTEeSrV10AIwfgDnukwsi6Lb0M4p?=
 =?us-ascii?Q?9LAA4Yf7+NAoyq/F/Zhtx+xy5BfwhAEUftkSt5daSgxgCg5Xk7J7LaxMPJJO?=
 =?us-ascii?Q?Z4rUq/g53CV0MTTKJiHKQ9Yj60BpyGHyL1eOjv7y+ImC5crNxGNHVA0CM1Wx?=
 =?us-ascii?Q?CekmKmM51JBUKYB96YU3bPwbrFGMCqsX9wLiwjHZe+OzO1mCKpgjML2K7A+J?=
 =?us-ascii?Q?nsCwYRRsLKkz3cotl2bcLD/qyfwQtneaAx6u7PoEt1wKdyV0Nln7tK3OJoNU?=
 =?us-ascii?Q?l4P98caoMQeEEQnLGGd94Sr4LE6fP4FyCE96K/1TZLgAWIXA53ObrG9neaDt?=
 =?us-ascii?Q?eRSzoyovtKqr13uDouRUQgjfcEdTsXg6bTC5AnG1i/Fzq99fU4cnVvNlotTN?=
 =?us-ascii?Q?APTqiGTM8H3mhYyGjTcQJ2hRwm8nXZLNs46n5U7v0Y2iFZjGZJFo+Nq64NPe?=
 =?us-ascii?Q?C9K3JyOj2FDL5pTZSM59cf01OHDjQfQdsfGaS79MTOqbpgNHuLAQnaA08IU0?=
 =?us-ascii?Q?DbkNH5fOxFPoK5AA8HZ7vUAd6tD12HVO5njqY5m5WYua8VW85mTg+91I0jyQ?=
 =?us-ascii?Q?PV9I3eIIjNuFOyFdTEgQPCQG1DlW83KgXnNX9lHX6NNQn7yBsWZJ9pb/PuH3?=
 =?us-ascii?Q?3pYqex/1HkgR5tsvVrm/1WW8MiqzhJbOcesylXDcagExb9QG1/vCsRXD5iOd?=
 =?us-ascii?Q?Vsj+qYlL4UMLlYwLflJbmOsHxE2HdIJMwOLFBldOdKFZWuluiJGPTFIxPvzb?=
 =?us-ascii?Q?QprQw8JMtPiP55y6HXelIea6GDQB9tyLhPRG9HvwRv5d7NdAmYpWuMDj0blf?=
 =?us-ascii?Q?LwYjenug5DSGl19MSMwF/feHiNvdYqQLSoAld5b4ENI7wYoPADL8D10f9P7d?=
 =?us-ascii?Q?cp4wtyLR/N6Y/tzPz1/kqHS4sSHncXTGDk540D3s4/eQOwXQ0MyP6MYS7RSC?=
 =?us-ascii?Q?T/q4kQdaRfPdieZAOKBQAzxanIyRfunIRidhQXgBsNwSHPidtEBYB7/g0ECR?=
 =?us-ascii?Q?sRBZg1s9ZaVEjDJFtD9DdGUQsl0tdKcRCBUbXIM5gtXmyvymk/JMGOWgVqLG?=
 =?us-ascii?Q?UvZznU+SE4MgQke5PJZ+t3E2fIkl1YCsgMaWMlOyxRKNN5y0M1otvVN+0ZI0?=
 =?us-ascii?Q?gwZ/0bsCEqlcS7AVkIaiScbR0I2MUbEa26CQeMxJVqZqF4rJPPMT+GO5F5Nr?=
 =?us-ascii?Q?NRMxZUH5vzZ9PmV7BbtRq30KOB9K5ix0qUOMN5yM4gasFVIFdgfwWHL7A3Ei?=
 =?us-ascii?Q?n5raxVrmNtCYfUg1Whg7UQbxy19RdigcxO8cGWDHfa3j5m5ZYaYnCyX/HRij?=
 =?us-ascii?Q?1/vGSqPZxen3CUwvvQeerz/hnI2Y7PuPOVc9qq7fOmBFhJyKYuxS2BIBjJHr?=
 =?us-ascii?Q?BMCtkjMWEZWZiVCRz5iJ4qLvFQoHpJ9DgubbDuulpDVa8HSeVUmVjepKWQlt?=
 =?us-ascii?Q?BLWhabaXF5qclS9lUk64sco6PLnocIKf7rpci2OJzAUnHZ5YQ3nw/g7/2x14?=
 =?us-ascii?Q?NHiihqROE5rgcCCrUx9wSLZpQ4TSNrp/R6eXoUJorIfu4kcLz92wopAH9nU/?=
 =?us-ascii?Q?N/QYqeOxXcimZyXmqkW+suwBVEvb83ZPoZtc2c1W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca86a237-230e-421a-b9da-08db93236679
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:40:45.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJzl0W0H0VRWjkscyeZrUAGRpLVPIvcMFLTI401+UYRLMPA9FDS4tdyz3Kfu3+xa2O9XT3rQuVjpJ4NpdTRfNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:13 PM
>=20
> +
> +/**
> + * struct iommu_hwpt_vtd_s1 - Intel VT-d specific user-managed stage-1
> + *                            page table info (IOMMU_HWPT_TYPE_VTD_S1)

remove "specific user-managed"

> + * @flags: Combination of enum iommu_hwpt_vtd_s1_flags
> + * @pgtbl_addr: The base address of the stage-1 page table.
> + * @addr_width: The address width of the stage-1 page table
> + * @__reserved: Must be 0
> + *
> + * VT-d specific data for creating a stage-1 page table that is used
> + * in nested translation.

this doesn't add more info. could be removed.

