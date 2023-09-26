Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437DB7AE508
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjIZF21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZF20 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:28:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69FD7;
        Mon, 25 Sep 2023 22:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695706099; x=1727242099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qU02SKhLV+5F1Wsibfq7UXiKGERHgZpxl8ElTV38DgI=;
  b=eKjBGaZX+goN8Up8txzXKtfUmK4zyqlmhG5llEMzqtww5e5IwApGAbST
   sqkMZetuZCTiNzch4gRmEwFS8frujKa2Is7fGCxbbST01DjQ+zsrjkuLq
   ojnx9vj/NPyl5HyAUWbFPIT9ehRYU8jIVsfoBx/nyIDQJkoxanQ57+vZX
   p/Jp7aAAQI9hVwAJrILYMI4vZQ6tcLnX0KLWb1yvaBqY+aK6rjp1qKx93
   akFoIr7s9xx5qJZ3uzOxIz0rRvXgfugPBVJULu1LWB+Rf9K0SvsNXuYxz
   ilsZ3gWllJ/tkfuT3YG8u9FFEzYOj5vcsPhW44XToCxJlGczUCiIoFLB7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366548625"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="366548625"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818919836"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="818919836"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:28:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:28:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:28:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2t0KfoiKQKjonT4I8wzQtCzv0zCFFdpuwipSlIclnrIOSA7hukIZFz3p1sRpUHbA72QEpFUc7YuIB5j+qqu2UnMOWBlht1NnPQRAVr+nmt+wDfUPONvj3M9belrOa+yKm8XSSQ4N9HsOgSYonY5RFPrhUgKpD+Iev3xH+k2h8itFuHZvNUClIp8YkQm3Z2EFeKjmiNgcHc459K84zULP0Hritelmjy3dRr86sp762ZB1G4QXbIgU55ESLckXHX15fET4S6MCYBdpIIWu1ZkLkhlmRngmULjm6iacwUs71SFbfFwT9l+3oIafen914DWQFMugL/NJ6KfBWHNus19Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oACOxItz1sMA9epf1QWJqJJBHjAPJSfjwZua66ISpJ4=;
 b=DCof8RgGr3I88LLgWurFz5/4hFjmNFxWl5UzleCdKQmz3tvlqLBHbz1u6AahLhliAnlFw1s5Id5hdokLYjnSqzzFQ9aIQg31QDtsa9D/ebamRm4FtvjJtssbJi3HOm2qkrYnCle6pvsOHGeb4Sjz2nwowf7IMMRQsdvpHUIQtW0zuKtGGXplQlkK74tSv6Mjcefknb5UKvxqmm9rA2YSb8avLsDzzJ/5Jsv7TZYZ3FG1eGo3Sc1GniTbDWX1LDGlcASxMsfQBOVxUlar0nWxGlvbrITaNGjTBdugs6cfz+xKVPUA1KkgR85Db+duXRjFjCSVNgHphZv+/UJQZLzYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:28:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:28:15 +0000
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
Subject: RE: [PATCH 1/6] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Topic: [PATCH 1/6] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Index: AQHZ6ttG+pOroHJpaUK6j3B03cTda7AsnJDg
Date:   Tue, 26 Sep 2023 05:28:13 +0000
Message-ID: <BN9PR11MB5276A8E4869C48A2419CBA5F8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-2-yi.l.liu@intel.com>
In-Reply-To: <20230919092523.39286-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: 2bb9f8f5-d1e7-48d8-22a5-08dbbe516135
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZG6LfJGd3KYz+4Wy1dffgOu0HddpY9n8fT5saXsJ6btanr0fLv46rcEPHmrHyJGZdqRZowEACKr/p8SSnVHSfSaIWOw6IWAa0Bc67oTqN/TPol395XS3liRT5/HTKGPAyRtruj5rDwIm6i4XC/BGeDQGuovjDPqwhR6fOHJ/Xi91BwUbcT1H1Dad6xIajEPD5dwMlGs6l3wXmZCBTczDlrwgfg63l680muMe2oDR5n4v9ZAzkiT7X62brV5oUH/vXc6d6JG70j4o4eBUcK6b1+8mVnupHcUeu2NoQZM0tr0qKuvsB1p8mFUmI+Esn0kQABJJ8gzXNLndL8KW32jdfgBXztP3Yfn4D9NUwlDddYsRGoOjz9R4rSQlO0/DbdJKE09jQio07GHmyqo9TctoaPYQPUIwLuiXQfEAxtnYkOTIwPxzYjicEczuCsi6SNhCqv8i1mFNmrnRkdMTLQSulskL2JQKlT3+4wFrE34VyOoP1fp6E3uw03YaYNpBjFRp5Ptqx9mJQxXpNsX6WCZnjl6EzGuqEwO0xHRMYzCB1wXHJXOvfN3vT6V7P6YAbut2ClKf/Pf4xjEv4KrR8RkQj8xhtYU8vRF1roXRiFX6PRs6G9UrLd48gQiQYcJf4a+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(33656002)(38100700002)(82960400001)(86362001)(55016003)(66476007)(2906002)(52536014)(66556008)(316002)(41300700001)(5660300002)(478600001)(76116006)(54906003)(64756008)(66446008)(110136005)(66946007)(6506007)(7696005)(7416002)(71200400001)(122000001)(9686003)(83380400001)(4326008)(8936002)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AaRtiRwTEQ3ajEOHmGENwsHBOTVC+SLM2frqmvmMTOvBJ2eGu4W+7GqQRcU3?=
 =?us-ascii?Q?oOMLVTwwKslqTCweYxjEtJN7oHi8Pc2ytfmQ9/GV8r02s7OlmbaWaZ2IysLR?=
 =?us-ascii?Q?kotI1fcW8XrqZeBx510KS4Ki4tbQW8HpnUoIsYBXCO/F0YkXWNm7O9vjBHLn?=
 =?us-ascii?Q?viU1zClF2hfu/lHZLs+sXfABY+vAGXAwhu8a5usP3SU03SYQPuxaH4qIrfMe?=
 =?us-ascii?Q?Ww8U06r2vMOT3f8N5vO/OCCsRlHVBpoNnsUWF7F6kx52A9Ab4zIlleO6YcXH?=
 =?us-ascii?Q?SP+ZiY8WZA8omBFxv6tzVODSy7TP73a0fo0fF0RA6AHTODQ9fsJMnc6wSD7g?=
 =?us-ascii?Q?m4wsIvjVgcggRcgm28tFbzwzw889jcAW9GeiVyjyalvi4et8jAyBFEiniHL+?=
 =?us-ascii?Q?+f7nYJT/Y1onUTVnHvEJGN61n0KIlZdadkPINOkH0tlL6RLD1h5lI5OiBoWS?=
 =?us-ascii?Q?igPol+8ZsEHiUbSAJt8PmKOUvvAW6FcLC2tZWDvvFhLnHp0k1m+UekZUaHIc?=
 =?us-ascii?Q?O+5Iq778Ok2axvgOWiHNRGJJUWS/p26VdY+UGpV6dbHlvjJwsBNeJxDTRNdV?=
 =?us-ascii?Q?K8MvJoZixqxarvrEAwN9jqZi3GAybVri2KsyO4HoJHdanLSz3mYAkAgwrC5l?=
 =?us-ascii?Q?AcfGGEQOGlXX+cgKt/KTIYAYwMOjUlZhC+x4puifmSid209UltJ+so93DiWA?=
 =?us-ascii?Q?Co9NooNb/l3goM6JbnFJ29IxsR4Nou1OF+BMERYoeb2hYwMsAc9rG34fQAmg?=
 =?us-ascii?Q?hHHokVS/BjUxAWejBPY0aYpUQOG2BIgt4mSKxU3o8i4c8bKNuvPVgVs8sBL1?=
 =?us-ascii?Q?uVjI/Cz5SNglvszzFbxrbil+wU6pYQylFxI/iRvekbkTr4HXuXQUpGNMtkng?=
 =?us-ascii?Q?uJmS2D4GXdypOHDsPu9yypmUJn/DFizSb9xZS8ySK1b2WzkUH3dLTALxdkKi?=
 =?us-ascii?Q?ulLAntMnuztp3FczTGcglgJNOQkheH13fM6Qz4VykXWu79QYO4p3HSZi6Qgn?=
 =?us-ascii?Q?Y1B3lwaatw29WYUYAn3TGPRum+zkzWqmNXmaQfjc7MU5rGp514B+sr6zDfRX?=
 =?us-ascii?Q?RbRFlySA45tNJvKs2E8eIJfz8UAM558VYa2Jgm0n0hkg2iJU0SRmHi5vbY9T?=
 =?us-ascii?Q?G2myHFXWaJONzELBbCw02KPgLMpYmr9XAkNdroo4uv2l17vLuIjNCZyqjRV9?=
 =?us-ascii?Q?g3oCr5JdTMt+eRHdTfsJxh5GquZwQSlHF7NA+9+tFXfKGsA/uct43HjLVc5b?=
 =?us-ascii?Q?AN08fh3a/z8XmdEB4f6YuBEShvUqNZrEmlPmWxksM839cfZsUXWtH81jIa2r?=
 =?us-ascii?Q?w5HaEjAWWR9rujrUCX/sr8CE1MXjExiIJZdAAaQpFbsLc0F8STlu2QcYzR9P?=
 =?us-ascii?Q?mc0i71cKBw9WJCu9WrRUxRwPOt7ZeZHnlb0Dgin3YByYcRtiGlDgcNTAOmfq?=
 =?us-ascii?Q?1WDe7SwkaMStC1Gzhxn3UqrBuYsBTIf10BcDgLiq6I2/yBsbh4cKwHVb45vz?=
 =?us-ascii?Q?vopnUgzUidy2z4pQkbVbgHYNQqX2A9m4qd2v5CQ4L7ofOqolD5kWJqwIceZ/?=
 =?us-ascii?Q?CSKj29npVhB/jT5X0zQ/A0LKvByz1cQMDTlE30oG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb9f8f5-d1e7-48d8-22a5-08dbbe516135
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:28:13.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9gIp4YUucOqUdz0p8hzyprsN3Hd+wEqAEhCP3l/afr20YElLBCY1B4obWt+4s8AQeTZCaYv6IiTX2z6mXJitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 19, 2023 5:25 PM
>=20
> @@ -235,6 +235,13 @@ struct iommu_iotlb_gather {
>   *           use. The information type is one of enum iommu_hw_info_type
> defined
>   *           in include/uapi/linux/iommufd.h.
>   * @domain_alloc: allocate iommu domain

Given now we have two @alloc ops it'd be clearer to also update the
comment here so the explanation for @domain_alloc_user() is easier
to be understood, e.g.:

@domain_alloc: allocate and return an iommu domain if success. Otherwise
               NULL is returned. The domain is not fully initialized until
               the caller iommu_domain_alloc() returns.

> + * @domain_alloc_user: Allocate an iommu domain corresponding to the
> input
> + *                     parameters like flags defined as enum
> iommufd_ioas_map_flags
> + *                     in include/uapi/linux/iommufd.h. Different from t=
he

"to the input parameters as defined in include/uapi/linux/iommufd.h".

> + *                     domain_alloc op, it requires iommu driver to full=
y
> + *                     initialize a new domain including the generic iom=
mu_domain

"Unlike @domain_alloc, it is called only by iommufd and must fully initiali=
ze
the new domain before return".

*domain* here already refers to the generic iommu_domain struct.

