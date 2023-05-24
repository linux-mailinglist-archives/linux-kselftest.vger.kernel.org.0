Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C472A70EFD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjEXHsx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjEXHsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:48:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274C8F;
        Wed, 24 May 2023 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684914531; x=1716450531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D0bwcbVgg/6A3i1xNjo00BVL7wZhqiSgFoU3Ge3+TDk=;
  b=N3NkI2Av2+2Jkle+5z5fv+7GkOV2Zou4oQwC2dnOY8cKNL5PCrqdR9Ip
   ItBk9TxLri6stJ9LuQneB/8i79I9AhW1G97BZVH2WYV7BmKpheN6po/QN
   i7lbc/0Vwpx/wdPIACk65ef5ZPAfPhC83b+CHZr5wsFjfHvJyhABNCVm6
   etNSkzKe8p8jGPjxg5FDSw/uzCMgi58MGhHBS+oCsaLFwBrcb2WdyOKYx
   W2S68c6C7dctSNFhrqQGJ1cBMkGb+T1+UT/FgqCZ74caYQLfRwnwFqE2u
   iGEg/6sj5RQJDIDuagSmnK8/e7HXxitSC9GkAo6jJW8WxGmDMql1yoWkR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355846013"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="355846013"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704239382"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="704239382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 00:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:48:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:48:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ2qwcy3PLFSa3b0Kjd+WVdjZNYy3LZS/yOv+kNhZtcjyNabwNxmORPs4CxlwWTLPRu01sxo3AI4jx61cO6E2ucfiiivKSmeCmcR9ucHfII/fnJQggNpSCU2lh30dUsQ+He0Vhj18NoMHLmr4yFmA+/MTW2cMzXfWi1y2hBF/61w5pyfl1q1fKtuS4CzyAPGYvylZFiZESxfFiE3WqCNvMLDGA9mmN/uVbxj5nELD9iOyQVAZ9/+HLw87CIBef89Bx7symMO30aYbVMt/j3ebA/m48GJJRhfMePap5vT9tXObbK8YhKHyssDoxsA0jVLKJgbztEWMJr67GyNvMJRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KZj2eRFq4o23Aj8u/35JufORQBRFVvymO0lib9A9IA=;
 b=BhWFipqkW2Ukl8z3SpwdtvKpH8bqOh7hWRW2FF3oegrsqVEXkIZdsD0YrH1uIT7blewxywKwa9tFcL2thS7pkXBZ8KYwpXyusCcWFoqA5dzWTEZEm2SFTYTskcXxyTKJ2pfAbtlLL2HjUcnmwCrO7K/R2D9cHh5AqgFaS/WnHLm49u5Ssa/gt4QM2unpFoZbM4prb2mZK3VUKex9BjR8jQAmJSlaNS80i8yyqRawl1Ce/J1YWpSMCAGiSeYLU0ts3loWoAN/PUd0X/4pcr3fW5hYfXPypVOQ8TtTdLHQWKC8OOQg6cLA15C0F0X5F0OjityXHb7jFfMKgDPCbsPkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:48:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:48:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Thread-Index: AQHZhBZR9BAjlz4VKEe92tc9klslg69hVLPwgACnKYCABvWhcIAABhsAgAAoVeA=
Date:   Wed, 24 May 2023 07:48:46 +0000
Message-ID: <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2fVj41GgosR1dk@Asurada-Nvidia>
In-Reply-To: <ZG2fVj41GgosR1dk@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5406:EE_
x-ms-office365-filtering-correlation-id: eb655897-8011-4cef-8e04-08db5c2b4df9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbV2/qfmLMxzT07C3iWBb5QVG+092bY7jJXTkrsAnOXb/mBB09crPYfCKXugVCD4Jod1noLLUMgn6AZ+dgrXN5qt/1Qop7xA/P5I/crgNgfjcswsT2N5HLC+VjnWR3OQnloJgEfJyK/Zn8h7NvcpjTamrY6/+EySKOIi4K2s/JHF5jsGj+XppLXE3eTKgtzr/zgMqP/yqxzYOZtWQZjF9qRlwVPd3G6j8issL7MUuqyojfleHTXa0WOwLTazF9MRb5cXJ9y88p0jArqDJZ01Xhl6OE8UEjAbBPjxHEqC9ghR/2IACLTHnmtYrEYMHL2pOecVkavAug1oQ30GjbyEqRKT6CXA+qmp311Yb/d+sE3DAnea8EqMURFkLOWDzaN82mm/psmhe9vsH0FJN+XX/1AXvy5+oGHMk4UNMIJhbpfim7qSxTaVd7Hl9KnSpa3uqbG3iDOWvgqz7yl88rsgWK9dsM42Ev0GcNoD/tRiTzzZpDp++otvB3fAWKPgJD4Nc3mIYSjY2FuKOUbKZTaxle6kaqeHxqkzpYgvUkwrt9oo8EkR2+Wia/lt4/nVUW6KKVQQKkk1D0qiJ8VTP2b6wyAETO57EZRSq/X/AqH1OReXzkcgSuuQRVyiD9I4OlJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(71200400001)(7416002)(8676002)(8936002)(5660300002)(55016003)(52536014)(26005)(186003)(9686003)(6506007)(41300700001)(33656002)(83380400001)(38100700002)(38070700005)(82960400001)(54906003)(122000001)(66946007)(86362001)(478600001)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(4326008)(6916009)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6rIoo6aHYsEpUeqQE75N4UYmYyc6GUj9gUxzWl3/vzP/PkrzSI8OUMltTLSM?=
 =?us-ascii?Q?5bHCZlzmF6pp2wC+2PKeMe8c7G50Vl+6X/0KNvmDC0fCi4mz77X02Tl5HyfX?=
 =?us-ascii?Q?IUZRZxuNI8ZCYWySyC+jg/t15YpY9iWYY++gbaTz55uXs4dbZusTPS94oor1?=
 =?us-ascii?Q?LpdMUUct4ze2nNGlIxQARelsldj/ujiFghRuMS2K7NxyPhyBy33GAJfUsc/C?=
 =?us-ascii?Q?/vIr1SMqVzSxqBGpIpSAx92fcDbfQpa8Bowj9s7P27gV72G2M64t6kBjG4sD?=
 =?us-ascii?Q?omulwcuDggdsc38aIqQQa6r8rF+jUkeRT/I5N1m32ikLUit1HCf/NOE7meMR?=
 =?us-ascii?Q?v/K8FuQkXjBAtUwJzhHfvNQBv5DIAcI4UFQry+lzujS+s/l/YQCB37ZmlSbO?=
 =?us-ascii?Q?uO6UmiDJQlNuYx/lFJtGAJtKAq88uQEA1WbDi9JTL4WKZYy9Qd3/AkAHv5V7?=
 =?us-ascii?Q?IEfQxa+f88SNXiiFm/9GIKvhnJfarcD36JkaoAHek1LAU3g4yroCRfacqtX4?=
 =?us-ascii?Q?ImPb5YTaU0aZPdH/tRXN0v+M5sio5a3OxGrwf8kFXmVTXuQ3JwzeQMBoSrx+?=
 =?us-ascii?Q?84gO77KQbTCaH2EvOWkJHEG2ttLu5Ix+fkNCvbjHi6yKEZEBHcEq084yWV5D?=
 =?us-ascii?Q?1kK+Azg1WWoSxjVG/1JaULh6F7vOqPRTlj0ww1Eyx+4+baDi+jWqzVYBH33T?=
 =?us-ascii?Q?oyx/MTfD/Cb+swmiGRaRCBl0DA30LFxMSzl0OF7JGbZgUKf3xHmqwaGItjxL?=
 =?us-ascii?Q?PbGsiYiQtx+FWlRe1apibDjcmBH1HC/yUaJMtcvLB8c/bPsZlxKWM9wEK/yq?=
 =?us-ascii?Q?+x0HWiFNBTJ9ySbBrWFBtTL5Rxb+5QwM8h3XKUtwzno+zZxG/QiUZP29Us0o?=
 =?us-ascii?Q?T6+vRJtGIeokfVa15UXb75+BY83mUu/QAd10orQwv7sMqZ6T7J7uoUWXhnd8?=
 =?us-ascii?Q?beIja+Hxf4qCdYSzXY5cxuuXYdvTZER8Vb2dhagNnkWjwKUZOgjA0DSj0dO9?=
 =?us-ascii?Q?TnCO/OiFYuw9YVENkha7qTaqo1mWxkeQPiys1DdST1avnS4JHAV5VaRnGbzM?=
 =?us-ascii?Q?yHsmC4j0Hd73UdFk2NRThK0pKJRLLZ085qIQnKtHMdMlsLSQd/G4Ul4lpinU?=
 =?us-ascii?Q?cZ7ZhaRA3wre4piW89t5CQX5Vh/yPxXcD0F4R75f3rj1wk98gTXpHjkezuee?=
 =?us-ascii?Q?WfJpSMfvplq7qAlPjhFSw5Z6qFdmWBecWB+uYs59ESninVMhfItXGh/QnVVp?=
 =?us-ascii?Q?YUty8jYziEC6Y55y3n+FZdx93FLPYbODfPr23p4abkKEan7ijulrahdr03aB?=
 =?us-ascii?Q?v3fYPyxvM+LedwLFQxpUaVMfw6+D4p0XHRg74Sh6H+RU73r1QwGZ8jNKzItb?=
 =?us-ascii?Q?ceqkclDCievfmfalyWT4nMUDNQSitxCbUkdC1oGJctx4v42f695ejh9pT17d?=
 =?us-ascii?Q?UZs2yuci54pHzlU1wzRY6nygjvGPgQAI9EdxgTfYdUXmqTt1mXUshHcIERLo?=
 =?us-ascii?Q?KPMLeLFmo8ObOx6L6yvBiTYHWMtcTGrUVff2hKOGNp3/GnJU0Yp3wki5b3xM?=
 =?us-ascii?Q?KFYPgmRoCFGeTDSR1hNKCmSZiOPqwrEC3EKiV/n4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb655897-8011-4cef-8e04-08db5c2b4df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:48:46.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NL9iYyfgwg7L8Y8JEw1Bd/x0pl1I8IeuC1zO+5yP12EMGM18FIIwfSl6tKNrm0Hf4gty+6DCxZnj0fx4YOBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, May 24, 2023 1:24 PM
>=20
> On Wed, May 24, 2023 at 05:02:19AM +0000, Tian, Kevin wrote:
>=20
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, May 20, 2023 2:45 AM
> > >
> > > On Fri, May 19, 2023 at 08:47:45AM +0000, Tian, Kevin wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Thursday, May 11, 2023 10:39 PM
> > > > > @@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
> > > > >   *           after use. Return the data buffer if success, or ER=
R_PTR on
> > > > >   *           failure.
> > > > >   * @domain_alloc: allocate iommu domain
> > > > > + * @domain_alloc_user: allocate user iommu domain
> > > > > + * @domain_alloc_user_data_len: return the required length of th=
e
> user
> > > > > data
> > > > > + *                              to allocate a specific type user=
 iommu domain.
> > > > > + *                              @hwpt_type is defined as enum
> iommu_hwpt_type
> > > > > + *                              in include/uapi/linux/iommufd.h.=
 The returned
> > > > > + *                              length is the corresponding size=
of driver data
> > > > > + *                              structures in include/uapi/linux=
/iommufd.h.
> > > > > + *                              -EOPNOTSUPP would be returned if=
 the input
> > > > > + *                              @hwpt_type is not supported by t=
he driver.
> > > >
> > > > Can this be merged with earlier @hw_info callback? That will alread=
y
> > > > report a list of supported hwpt types. is there a problem to furthe=
r
> > > > describe the data length for each type in that interface?
> > >
> > > Yi and I had a last minute talk before he sent this version
> > > actually... This version of hw_info no longer reports a list
> > > of supported hwpt types. We previously did that in a bitmap,
> > > but we found that a bitmap will not be sufficient eventually
> > > if there are more than 64 hwpt_types.
> > >
> > > And this domain_alloc_user_data_len might not be necessary,
> > > because in this version the IOMMUFD core doesn't really care
> > > about the actual data_len since it copies the data into the
> > > ucmd_buffer, i.e. we would probably only need a bool op like
> > > "hwpt_type_is_supported".
> > >
> >
> > Or just pass to the @domain_alloc_user ops which should fail
> > if the type is not supported?
>=20
> The domain_alloc_user returns NULL, which then would be turned
> into an ENOMEM error code. It might be confusing from the user
> space perspective. Having an op at least allows the user space
> to realize that something is wrong with the input structure?
>=20

this is a new callback. any reason why it cannot be defined to
allow returning ERR_PTR?
