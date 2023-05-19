Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D347091F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjESIrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjESIrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:47:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F4EE;
        Fri, 19 May 2023 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684486070; x=1716022070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JGBTbYwIwXdKmglf7c/crBW0mf81UuCqTQ4SxFg9p4Y=;
  b=BUIVBcE2IVykdvHfMevbn6FtFroZRGz6KeUfC8TTGE7TYFv0idKDegiH
   0vAtqzFOz6xKUjhTD94UHefjZdEWGxVPHL27PkC7haGQsdM7j8F+Lvz8i
   g2O9re9lt+UBUo8eGCFyvtDV6ITA10YMrM1S+vHwiHx2G99Ecfa7FD4q/
   rhmjFcKHjbigb9RlkUgjSKaVA6orlRxfX1bmZ3pArh3yyxi87j708KMYs
   5bFDODOLKXMbdJdTP61ciWROBbqJCv9I9nQCcO0pJO4Sb5Ulwm6H/monC
   g/01Q6sYkxSiQqbc1wTm1QMXV2QM4Q9j83vqQOrXnNGab71Jvn0DkHyjj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="332683183"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="332683183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846823165"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="846823165"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2023 01:47:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:47:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:47:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 01:47:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 01:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvVIwvGDOwOXZ24jHweUwiju114IHA+RaMQWuW6FLTEMobqignqLXU456lZ3dCnyKWYdEMQ+435c/wa51tgg7ZPTb4gWg5yGWbRceS/kWm323FTLAB4bjhTkS0JtYFHvN7DqtXpn5zpovWuQTbrvD+lqVnYBkmgV2HUDYgI3EdZkgq/BEYooGSP/S0oSakq0vtdBZzTl+cCZS+tLSAeizJdvDtjqm6P4kDQOauZMcLikSwSaBL3qh8K8uPR3ryd99pPp6n/8D8vOF6I+g3aAy7gPPE9newRDu8Jtguw/ZgM247uAJk0zHbUftbZshYxNuGgdAP7uUtFQ94KhUPdy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3GKAVP6JssRITvOMCMpIfbDxLAEXI+6OsAj38tO4oU=;
 b=gGTEjXREnHy8Q1b74fWbGm+B45jTRuPSZrHo3oYYNJI6tcyhu0ERsYiToWM7/tBbkIYhYDykrfEi3SihLmcPGyI34Y56ZT7y90aMUX5pZqfyXnpiG5rXDPl4HRe5+c3gg2+ZQLQv0SS76IBM+wdyB4FpXAoZt4/nPxw90bigec4BC1WJc7aivLxjA8nASoutsSyl/V2aJZKeRpLTYusDjfpBvZWvEYclNwcmGeIX199KKqrEOFIesBFHMdr6RHaPVD44FrEESK4nFwkdsjx4dKTw5ED5a2ft0V+kpZVUUZ6P4a6vlrAmi+BeYwOEwRFhslswECF8IF4ZpSKFYNwlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 08:47:47 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 08:47:46 +0000
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
Subject: RE: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Topic: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Index: AQHZhBZR9BAjlz4VKEe92tc9klslg69hVLPw
Date:   Fri, 19 May 2023 08:47:45 +0000
Message-ID: <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB6786:EE_
x-ms-office365-filtering-correlation-id: 7912caa1-4738-4ffa-3fb1-08db5845b7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfhOg9nyfSW/+nD1FnUhMYudyxqK2yNyMRhxM9X1qaCuWJA8u9kGfdFFeeXiBgGrL7OWF+kybtWkiutN5OSX26soE1tc0fCOjEo8J8rVZJ8FzJ23fUrnRiHkFr7UkfW5kmwaDL8gLry3dn1hdQsT14fTyA2cEJ+lCruegOr4EBz3aZmoqKnv7Bhyd3sOACeR6y/cCKGHOqs9QX4qTUJTbufJRSGQL4NPuZqQfXqjeA0Fq+PU3auTfb1SbJyQmtbuTtNQsSOxEwOkkgB7WojjdAh2YC35QsySBV3M53Ji+3o6ehD2YoC2cHt8aIxtEBsTS6wf6LV+ubTh2FwPoEDb8j26SjgDw4KcuA5o7drI/PKhSX/aqV4+ljTPmSx9L95MKm3VitkFnBiqe1gc2fvUQoQYFOedFPahstM9aAqu2E93X+pb2tDTJELKVvSLz2d0WY6TDujSIWYnE+z3XI5FJ/8Lje/iMseM3aHRwg6y7wih3lToQKXIPtHY511pmxeDtp2vg3IuzSoazf2JnXeUcFgpAR8HZI/kxXPNJwSkDNKGfcdev/Ktqdt4fQz0p6E3L5wZxcz9a3ZoFV0LvKpQD5C+JwdVoTXxpg+QhVTz7/5rKkg4X5MZd9ZfKC+ENrto
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(2906002)(4744005)(478600001)(41300700001)(4326008)(8676002)(316002)(8936002)(7416002)(54906003)(110136005)(7696005)(71200400001)(66446008)(66476007)(66556008)(76116006)(66946007)(64756008)(52536014)(5660300002)(6506007)(9686003)(82960400001)(186003)(55016003)(83380400001)(38070700005)(86362001)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q5ByQMvBw8uvWXm9E/J3lZ6x5SyE0fjKWFMMHhMgxmKs41xRwNvsuuuddc30?=
 =?us-ascii?Q?knGoNJP0PiTU9QWOk9rX6quPo2BO2raUW4WrZiqE8XZHLql2L5m0OzkouTpA?=
 =?us-ascii?Q?kvLsYfNvZF1V73yFjQg+fYyNvLzZV/AUmFxy01uWknnBS8caS3wmjINnbDjP?=
 =?us-ascii?Q?k6MH40awITEEE6yzfklUN5KAlDXUtmNlwVmzOelTb1OsDyEX9ghMg+3BGM8V?=
 =?us-ascii?Q?2yC9NAA64/RsyKUPmepBT0+xJRJHoEwdWkNgZXnPjaH0YupBxsvn28pHs3bU?=
 =?us-ascii?Q?YJ296KBq3pEHQnypAL7lgmEGR8I0FL0mH6j7OVXUM/zwPs6gx6lsJEpF30Dh?=
 =?us-ascii?Q?uwpUT72YN29x3S7GCuVwkbI4SKWuNa5XS5wPfqdu9MZbXBkdH3RJ4HLoA0se?=
 =?us-ascii?Q?HdM+H6v/w5tif/e+GwDo9bJgyoXQdH2R8ccJg4mpKxHgJ3CEgIrDDJTvSmoI?=
 =?us-ascii?Q?p+JB/W6bx0lOQkafI5SJXhGqROLFYsGCZCTbg2+A+LwgOnlm4Z82ep4XbXdi?=
 =?us-ascii?Q?aNOipxcn9MWOYkALqSjmd1+mKciYLaatZ8w1yM8qL2vHQ9ozNgrB6rOpqmdb?=
 =?us-ascii?Q?crJ9tMOrdGGFcpm2WAZvPYjiNuJcTaVoAKIruj0cxGrY5NKvEuPJUZ0GzCOp?=
 =?us-ascii?Q?W/ZHGCoHxqL6xwRC9YTmWlK7sgcEVSCnQmXZ1rQkoNVr7tQuy8B5vxKEBgZY?=
 =?us-ascii?Q?dLxXGhgESkPyeVfAXiM5TizaLvEPHWzWFmq65X3vKHFThUW2UNcn/kHeJ55g?=
 =?us-ascii?Q?DqRMmvbVcSBtKDXOsLeIt/3YwA+EEGO9xqm+D3jYn912bAcUZP0bdZKORXsE?=
 =?us-ascii?Q?L2N2XnZ/JJvfuJF5uhzGFsI0GoEtRX9zwjZuJlP/vTDYZjSSijRZRanyxzUN?=
 =?us-ascii?Q?99mWZ3mMDfaSmx/akOoJHCN7eTtFDqwrmD5iZwzHtxH/8oQTTpFu8WtRFhkL?=
 =?us-ascii?Q?Id06CghbDlqTyApVFpgSYjf6u1nYN2sV51ObGKarAVtlPr+r9TPw1lp7qCIa?=
 =?us-ascii?Q?Let7WOEvKMjyEAJZAnrWH2wxqnLF5fYulU2b9220EimZsiEThZYiE9v/zSfK?=
 =?us-ascii?Q?MfQoNV9El9y0ZQQgOQt2vQTT+cwPjBOdnhVOwZ9s92SSqQpKLMu3TMoznhj4?=
 =?us-ascii?Q?oEBMx9SHNZbudLiPTjjEJW0gxxCct2IUEhijQtO6ZDt7v78sNjpjVJ0odC37?=
 =?us-ascii?Q?5CuxApZrCPt6S6BC/j9tsngVVSj+BwV3RP/1fOpeXs1bibkjS/D3yIlDM88B?=
 =?us-ascii?Q?QBQsNAITzHoKYaW7l8/EDFMKTte60zQUp22qzFcBF1KIyU3aW16JqQ1qCrM4?=
 =?us-ascii?Q?pbv0SkytQ19IKIonOOWpPbw8gGzeYfZVO6SQEThzUXgOz6sxksl1V3oPS2Oj?=
 =?us-ascii?Q?tADZzkjyH4grgXhNYWTS5jXWRc9RFTP66LxSg40rYHKKHl5pnDzeFXQlWD6I?=
 =?us-ascii?Q?o6THokJAQ+5a1h/jFf30TWGGoDRQH/Cl+TV6NP6YiJOpb1iedbKJjJZIDkVE?=
 =?us-ascii?Q?ZiJsmE/HZjwAkSo07fFmyp66GWq8BDiYzw4bPKZomrtLAtxfgWTt3mN7+/wX?=
 =?us-ascii?Q?MyZtcA0JtCNpb46IUDo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7912caa1-4738-4ffa-3fb1-08db5845b7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 08:47:46.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkzvst+pWtgDLj4YrEcf0s0+ALwkarIZ8Ye0E/uar6CTuQQskMUjR/XEeOnB5USmnVGWFGlg/NI1UtoQjT0+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
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
> Sent: Thursday, May 11, 2023 10:39 PM
> @@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
>   *           after use. Return the data buffer if success, or ERR_PTR on
>   *           failure.
>   * @domain_alloc: allocate iommu domain
> + * @domain_alloc_user: allocate user iommu domain
> + * @domain_alloc_user_data_len: return the required length of the user
> data
> + *                              to allocate a specific type user iommu d=
omain.
> + *                              @hwpt_type is defined as enum iommu_hwpt=
_type
> + *                              in include/uapi/linux/iommufd.h. The ret=
urned
> + *                              length is the corresponding sizeof drive=
r data
> + *                              structures in include/uapi/linux/iommufd=
.h.
> + *                              -EOPNOTSUPP would be returned if the inp=
ut
> + *                              @hwpt_type is not supported by the drive=
r.

Can this be merged with earlier @hw_info callback? That will already
report a list of supported hwpt types. is there a problem to further
describe the data length for each type in that interface?
