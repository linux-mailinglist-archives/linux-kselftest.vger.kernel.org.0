Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4A76C769
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjHBHu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjHBHuC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:50:02 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696C4ED2;
        Wed,  2 Aug 2023 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690962449; x=1722498449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZpOiDh6u5Ka6VkV1H6PD3YUGSLRNhzcYUVD2slLVZec=;
  b=RgvMZtOHgQC1DEPz2IueaZGiJRat3GwRHUL4jwgp9O5e+9YbDfTCkB2e
   +uvE6EOuE/cu8Hr2eGuEplbsj/TLMhVNXzfDvSMJXRxcZ9ecL2t3RxtPm
   dMZB3NxWdkt7uieNBu+TdM0w4RmDAls9QoNsTh1PeUd3rCF8Yb1p2xpxI
   R+vzVuLBYddBEFkHiuyPVWHetR7BgFgRxqtFgLhfEG+TWzSR+Sl5RHyJ3
   IAbsrgv1Vhv00WZ/ncB/zRaaLGvZ212IZ0ztI4/ccHcdKnS9JiKoqJYBE
   XK9glKOEbG2L8dE/0RYs4xluRUBtBln4hkfq0KUC0UMEXcLxOjp+dELfP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349109961"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349109961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="729004370"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="729004370"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 00:47:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:47:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:47:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQGNx3ltGelcJy/Q0v26HhBGX9GlGSQLTMQeUZvfZ4AuJxeq9B4Jph4nSCTERVcex3XNVwf2fhu6BNN+PbiQ3pm5uMBCIn4upeqHEZK9Idgqlrwz05bomxJlykR1+9KQj7DmZb3+cPvbsMVoIfaCEVa918niYaaRy5BkwDI4l2rFlgq3YlIVwyy+i5WRN64ScssVXc9HNamaxQ+BOW6mofZdKupjyDQXzSpuyZhmDKddjmRxxXK5DF0HevT/nPoaT5bLdX+U/2Bq6+xpkgrJ6NJ65+HF8RZBHPxa1yaAcpQbZydMTVtTd1rZvg67rwK1iABBLfVGF709xM8E5FMB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpOiDh6u5Ka6VkV1H6PD3YUGSLRNhzcYUVD2slLVZec=;
 b=I9hprGZDMZh43FkdsLLEkLMEb+dW0tSKWPcg9U4yLZgQ61+YsnyRHozXV8yxXOi3ANYPOZ8R+s/ykBl/OFsi11ghA5Gq5ZuWb+XTtwE3DaGtwz6k2hZMToP9DdOjg2M06u3ynKYc1238m8/D8c9IqtjlvA/Wn8Tr0zcFvk8pJh5wDVgjmvC9N3UKGsKmR10QciMqeh7usWEspgGcisrtcVYt6tBXAEzosc7Oudi+idpIOB15GAi9uRjv52XDs0TIuJOC40+1ja0ionquDOb29WTwtSPVQrk34Ww49G3ujx4ZBdX1FewvakIUAA9gmkkshbUU4oWmufgMRF6RF0m46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:47:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:47:21 +0000
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
Subject: RE: [PATCH v4 10/12] iommu/vt-d: Add nested domain allocation
Thread-Topic: [PATCH v4 10/12] iommu/vt-d: Add nested domain allocation
Thread-Index: AQHZvh/w1H6oeH8CdkKdI7moU5hp5a/Wrs7g
Date:   Wed, 2 Aug 2023 07:47:21 +0000
Message-ID: <BN9PR11MB5276E89C7E612D40672DD0538C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-11-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4957:EE_
x-ms-office365-filtering-correlation-id: 801ced33-142e-4971-38f3-08db932cb442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vq/lTNy8ycwA4049ogtF5sexAu7wAejagI+3NyDzIL1sHw0ztdzNNJTNrG5lh2kCMuS50HE54KQQIvcJTSFUmZ5/xpIcfHrVJjBIzFraRgKuhN0QW0rnUslW1lMQGjHxgK+pJ8FnyHpSTY4dVd0wZJtvvyQpz/R/BuZxoNa2jXl4wFLzGXWxg1bFjfSDWVuEuA+sYu+8ltdwrox5YiHEzDOtPA49fq5jkuGoDlMkX76Mkxs/nJEZxj+plK8YWbVBpeTlQADZZIL6LPpDAd++BRi1HZjDCP/bHYWFbEL1hS32AWvVBLpr1bL4HtW3sttJkgXNgwXkuPZc8EIk4rfw9YHifPIEb5OaBAnDf5xPlmNZucAGgCtpGNiBWhRb0bP990Ttl9PCUWdfYIzJS38PBSqDkelN/Tsw+EAgOp9oRFOQ9mlRI/DtsgGznsoLqtLRMuHUglWz7OF4967A43HdMO/2J/VSfYDUlQSKt+w2jCrvePc/byfjzjtEThoXflogkMfjUZYuAyVCcaM0Pb5ymjeBBvCAXsxsq+ahdyWdccSb2nAjgIEWMr8TAP2bJLjMLcGlY0O2US8lR85CcYcgZnIYLRsgc+lVpPuNQ6wUsxHlmPIKSlYpZwnckqDA77K7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(33656002)(4326008)(7696005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(71200400001)(122000001)(478600001)(86362001)(55016003)(9686003)(110136005)(38100700002)(54906003)(2906002)(41300700001)(26005)(316002)(186003)(6506007)(52536014)(5660300002)(7416002)(38070700005)(558084003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PAH+qCRVfu11lR+8hqwc5Yjb9CHaVobrxaBNUWtm8853sABuOxOUSir1URM3?=
 =?us-ascii?Q?z8Vqkw4EiwBq21taUtw7IfBZUdr9oF8v8nmUcPFgROHcADMmLrEnbHqOXce6?=
 =?us-ascii?Q?EBc5AUvsTHHZEZILiND16n+/Bssg7UBuwpDhiuIXe06ZoYWSD0T6bFX3tWwb?=
 =?us-ascii?Q?Zn8CY1nOJFM1FQNB61YXp/G3I46fmzK8OcGccRD+lN07j8pSYTf5UFq4y4Fx?=
 =?us-ascii?Q?Dn25iD7s9ve6BOq8rUSJ8wP4HupNnRoVSL0DWjJRvlsxmQn2S4bUqq+17iWX?=
 =?us-ascii?Q?SA088Uur1wpQAu9/lAAN5xYPUWOcYsdgiNyOaDb9+wIeUCnNThhp0FpJkZjY?=
 =?us-ascii?Q?CSOBzDL4Ij123z2c/UDpEHuZPyx0iChMBsl+QifWU/eUREtfT+HjkHcikG+p?=
 =?us-ascii?Q?N7iTlE+uLe78KlSqvRl/yJEcNzZQw977+XweAsBvyLl6sAyz+kSGVDofEEhe?=
 =?us-ascii?Q?wSN8it2dS1N4b7z/sY4h/drksDKnVM0jqSxmByigYzRfs52x3HZTDpiowell?=
 =?us-ascii?Q?io7ZiEESPfhOEjhvAs0dw03/CmxigyGtJZ/KNdCmQQGOUx4MCxIKENXz8imt?=
 =?us-ascii?Q?4yMDcMlwMMIR55EccDqfByTLCUQQjRoqN0psFWaIPZbMpmyyNrP4nxqjRRd9?=
 =?us-ascii?Q?oH9eq2Al4t/71liSHSuIrm/HiWjMH2fg3wuNdjymM/V57G3I2AJBYUHia/X7?=
 =?us-ascii?Q?kClMdK/gLjxT1LvkvDDzrYjaDSpyIj6wyreSkBGAfzrx2rzrvSW+Q40Jw5cv?=
 =?us-ascii?Q?sToClZq9vPm1oBZamBMLM3PWKXIBJ62qM6IbUTAnZtldJNNt/DE1UAotSR2h?=
 =?us-ascii?Q?Ixm0N55MbD8hEOv9fW50M2R3nDqEKDS+Ke/dwWPRZHHaqhjEYL61e1qbN8Dl?=
 =?us-ascii?Q?er0aJBkBhbdWxLXdPQX9FYswfvBFTxobtcY24st+azGZD6Hr/kC1IpoEhkCR?=
 =?us-ascii?Q?U7NT1kckJkxLoF78iPcPaC2ooVT+WlezBLD+byj3h8OVmjr48cAmKytMVkJ4?=
 =?us-ascii?Q?j0u9xxPstweN4orQPkT0dqlSHnfrp5d5fpyunh+pqvKy4U5/5wQXd05r/Mdt?=
 =?us-ascii?Q?0Bowh/tNtIcF1OW1q3l2iTDLS2OVqKkukMROoaLC4xfQwSVolcNeANEu6mVy?=
 =?us-ascii?Q?muJICuxTtkoFiBX26mR+bOXFGlhfNUp2DjeDq4EZJyl7jJeN1w0mmd+4AkMl?=
 =?us-ascii?Q?rPieINIAv2O8upBr4jZF820+R4Uoqo7pQLqscAYvfneIzOuVeYLcDBWM5cCI?=
 =?us-ascii?Q?RzdH0p2NKtZ2iIst9idyvWlfIn6iNui1BelieqR+qANzOCWnNluv198cpoxh?=
 =?us-ascii?Q?4oqUFxoA7WYsSKhcwd4Kua4IvEl7SsPPvIgE2wzTsrEuIsjFKp9DQiZE6jIR?=
 =?us-ascii?Q?MXxhnOisdVBnt7fQQvAUPg8I7Zc+CScj1YpuNhyFeYbDEKSf+gtTuuBOb8GV?=
 =?us-ascii?Q?14iK7NC6MyrR1UMFYCX2uwGWGtUKx9sRR1f6jYRjhbd8iFA8yJ2LwhJ6yLN7?=
 =?us-ascii?Q?uAkpXcNzHkp2rY8PylqMGrpv3geRK/Jv+KJQPJNn2Qa8RMSdL3o+1zKcJWT1?=
 =?us-ascii?Q?VwyoSUCliKWMGFenA79DRoyW8ZPUJjkPuK1iw6aC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801ced33-142e-4971-38f3-08db932cb442
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:47:21.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEeDmFImWSD48yDaugje/0ZxJ8GWeVRZoHspUrE1cuthWFgAd0+cL0T1QER/iGJ6CyN2WrYpw6k61svKEbC+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
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
> Sent: Monday, July 24, 2023 7:14 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
