Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749A2764F98
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjG0JZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjG0JZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 05:25:10 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9B4695;
        Thu, 27 Jul 2023 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690449293; x=1721985293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THZkb6DbUFsSj16CkUolyYW1Mn4VyoK0ntoKNGEY4II=;
  b=C/Io1jVIPgtA2exmUmPqcMP3NYQKxHTQV3JChM/xC672t4n+/AfWOeMQ
   zLOj+B2Yh2xYusZwwUjYgNNjRadAbFvs4qu/b0tTdWM47SZX3NGG7oJf6
   efQ9BcjYyGieVmGIqpqApG/9rSdimJJiesuZOoHIhyI1USNK3RvBcDlb4
   kXj78UgWa2pvY6crRdCmW+ik4ypcyPNqTas7tz2jOoZekwmh2tjo7w6/l
   cBbweM6FbbqJIUE5LMavETwWcgPpYi++G+C/ClJ2DsijwEW59MYyS2WG1
   6ODZYsmnd2oIOyyr+XbWMO+ybK0shfgnhIOkWNkMNBLJVvZdROCwG7ybQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="432056495"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="432056495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 02:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796906088"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="796906088"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2023 02:14:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 02:14:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 02:14:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 02:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcgSpx2ggRyqcy/YwVEmL7xwf+wrP81uBfaJ0ETfpdLsfPagEakO24dpmZ8oWTyhq9XWygcf9GgOW4dnpI9wrYNURb6iIb6rP9pRPpMhQ9GIdi7BKAfq2H860OKx7c8vwVzyQi1gr/zypY3cY5z0OeXkFZ/dmTRQ25oUUv6PXliT8hOER9LFGWswXyz/iz/v5y5XMx9tAGNrzMpDVhvlEet8EQ0iBdCgRdqWrEPJGv4DVjVA93OOqxO2yaLjDIPnogE8qJdcYygasFG+b2GcFMozoTp5mMFptUonxfcnuH0LsoTbduZS7RjkX+cLzy6JAmdGMgI0iA0cYm1HdvBCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNGLSbMLu99SLKaIVdX3H38Mx6sdAoLZ6bQUMXcEz+Q=;
 b=UL+lsZq6/RNC/2hZ2EklDFe4Rv9Iw1qzTNCDvU1+PeFxUtEUHxX+j6zSivg3lNF9koj4aname+W9thFCyoxHgd5wMeuLT/SUA2yunRLTR3ZQeqPnaJN5eNcIkPR7y1Ng2KeJ1Z3d8JpvxOhOxIcoEDM20Va9NrvW6Z5vO/gUZ6RtkoWM/FY4oy8IIYldTI7DDYdpzlBU8yeZizpPu/N7fc9lrNe7Vdw1LANwoMNPtNHrS7yJzlXSizh0mwIvgtWsjQZRudr1CMm2JWjhv8zRXCwvaMYtj24APvmN6ULtSct7KNaWunLUYCKGtDkHGFe5VtJogTbAeg0JPEDqRVRoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:14:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:14:33 +0000
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
Subject: RE: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Topic: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Index: AQHZvh39pjev3HWHHkqCl2UrU23cMq/NSB6QgAAHCYCAAAoKkA==
Date:   Thu, 27 Jul 2023 09:14:33 +0000
Message-ID: <BN9PR11MB52764366FAEF79D4696B19828C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-5-yi.l.liu@intel.com>
 <BN9PR11MB5276E70BEC76AB3D96CCF5028C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMIs+6w4vF3X27L7@Asurada-Nvidia>
In-Reply-To: <ZMIs+6w4vF3X27L7@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: b2619f39-a706-4f2c-1c57-08db8e81e44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wfeygpIetgdjqSLJSxTBmlpwLbPW48GTA9w78sa/VU5Mfo2RhiJqJ3lhI1b3qzm+OJ5e5gBun8uG1obj0yVKddjXq7syacMAWDOvoulAhNzuEuapiqT2Vj1qTE+94kKCqLNxwORh8MbdkjJTghXVk1PHqWaHyDVjnDQ3G7WFa7XdM9rX5k1ToCwKM6GwKZvvWbdIgUTxsT6uMC70cZL/hdeOI74479QMYzMmKFTkRNnEicS2Cp+KTXuQICBT+DUGzXSWk3uCr316/1C8eEEi+E8PjLaCBX2x0I+LEIrFAvFQgtSmkHs38rPHOlg0p4IPHGoyyEOdqiv/B6DTBPNdgdFbGU8tep5NlZ+CrXPqqIQ/P7rQUamaeKA1dL2VjbM4QXWdfkIJA6EbeDG/6yyXW5RKvo2/PMsiDrMV2Y8hZK+TKCmrFDRHQLq+9y05vqFD92D9mmg1IVpw3mhsWyHIL9GT8OkOzTJ3F2+CyvinVgkYrO77yQt8WUHd56epaeW0u8Q3P3LCGUcPjrkNRZ9fgHrzSg00DeXckDWDI0NAXhqhXNDSHXmdZWsCkjvksh+m/96USnfBHG/6QMR+1E7rRAvY/HI86mNVqydbibbtSdbue+mz1U1hiO0OrgaPSEm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(316002)(41300700001)(8936002)(8676002)(26005)(6506007)(55016003)(33656002)(54906003)(122000001)(82960400001)(66946007)(478600001)(6916009)(64756008)(66476007)(9686003)(66556008)(66446008)(76116006)(4326008)(71200400001)(7696005)(38100700002)(4744005)(2906002)(38070700005)(86362001)(186003)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FbzPAhVZ8mmcalcAWWcvBAcfIZOy5i9D/h22nJ3g0b6gFwVEHeOO5hxKDITa?=
 =?us-ascii?Q?q7vTw2ZH9aE+a04CASqsNe88QrqBfCrfPdxyE9AGpzm7oxyaOg9IN2CK9Zl+?=
 =?us-ascii?Q?hf05mBcYkL5pzqJw2aeA7iIE/80AOqCQwKlYE4twmgY1rLwHaSIgnai4KChN?=
 =?us-ascii?Q?Q+m5HUP1xWm5wI6wflyQxM6Awooo/eDmSmb2wWiffVF72D/kYMLPe/a97M1u?=
 =?us-ascii?Q?0eexzNIiK1jEzu5w8S0fRHYpQnKi5oOf/pZc3XGsz/G5V4RR1VVs4e7bcaDa?=
 =?us-ascii?Q?w3jq/OfqxzA6Y0VLX4WagWtTOj4NUwDcNkem1FKjYszP2mk2TUbpP61UTGoE?=
 =?us-ascii?Q?v8R1APTT9QYA4wPd8jMKe+xdEyDYHVA5GO8DOU2EC8IzT2jMuCcindOj6Jyt?=
 =?us-ascii?Q?hRMOOLXQk4y4CxxCORGQtR9zSNu9kYXjgSsRQ6xQsdhPEwKie4gTAsO+kPtv?=
 =?us-ascii?Q?Z1sc6X+TPTmw48fbH50H29eQwQapDGZwjxAEv+wzvr7lgZKcqa/+Sq0UmYZa?=
 =?us-ascii?Q?vEFFcl+Vbxr7T9RlkJMDxQB/lgxz9KZPEw7pJC9/ye4yeshpH9QT79qTImuU?=
 =?us-ascii?Q?+eD84Y/30h2p3ZprqtIFR3htFsb1cP3eBhPvofqSnoLtgql3rMeDgidXxBhf?=
 =?us-ascii?Q?hTBztdeOrkCYl2ytw3s5HQVgWWZGy5pXh5O8nlMziN6Oilzx0aJ/3sz8Dqfq?=
 =?us-ascii?Q?qenJ7opDvsAf9qfzv2tfsiDXad2oQQCYul0j7eI8zNkj4TT1+YZfJFex6X4Z?=
 =?us-ascii?Q?0xGxsdsYVj9Pxlx+YxLKyNWf/XdLBFC4Ps0Ldhw3q541dpD1zz9jYmdnVQOT?=
 =?us-ascii?Q?zj0O9oEUMF2JmRhsfqqeZ0YByV55j4zgeNY/zr75fOP6fH6G23DmXo2MW6gX?=
 =?us-ascii?Q?Bvb42XflMztL/ROVoHgsrPo88qQjKwX0syx+6CRGMNj9zWo0Vht9lmTBW3fk?=
 =?us-ascii?Q?+Dv3DgQzqJXGFnypQ6DkYIqm8BR9Lx1DrZREqYawZQpnNhl7aLWkQfd+SM0O?=
 =?us-ascii?Q?rDyCwf2UUjGSLt9lGn8KSkkukcPqbypuDLXHTstzqOsH9V0Im68QJG1NcxAr?=
 =?us-ascii?Q?rc1GQy+YNuopbvkIAtmGV2481HKXKJZLJ+GBXwIXIsPQtu0VVWyf+bL9V8rE?=
 =?us-ascii?Q?3Bzr9mWIdXDvQFsAdiB3ZgJ9dv9r1cPQcQwsymt0mFotzI9EgD43jGb/HZYz?=
 =?us-ascii?Q?qunHhRv3zw/HZWbygWqt+qdeNs3ko3Xbfmj0/VP7489zY+P/atMUHFl9cWE7?=
 =?us-ascii?Q?LVXU/a27a4t6I5jDKvebiYUc8PbmpkQz4M137CXrfnvXRpI+fHM4uiOIoq1f?=
 =?us-ascii?Q?3kWsWsPqKhglAQJmCRDXII7FqX+l0y/ddV1bnithNiLoVolB4ZgHZc6KxVDu?=
 =?us-ascii?Q?aX4oebcnJyBCkMid0HMecODSBthOf5AIkBWTWC16WuFAJnnN7Y7xKETuvS/q?=
 =?us-ascii?Q?AzlgxayEKnls1EWw1+1uLGMhNaHagoxyTkMXtMp92Y8fmCRllFUVMyEDns1p?=
 =?us-ascii?Q?pVpTGs3ZVMyghL6tjHZe0OOnXGVOCPGJ8OuoJ1dcfzsRxb0Xuj01KODESn81?=
 =?us-ascii?Q?5OowJtqeRaYC3YzCbaiUIyGAW0z4EdDQPKLf51K4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2619f39-a706-4f2c-1c57-08db8e81e44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 09:14:33.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yrI5jdRjBZFvCuqmeyvweC4cAlYe+V9/ydBWxpOVDgaW6y1unQq3cT4Rux8UzxonLOpFKaqYhYG1eNzf8u7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, July 27, 2023 4:38 PM
> > >
> > > +TEST_F(iommufd_ioas, get_hw_info)
> > > +{
> > > +     struct iommu_test_hw_info info;
> > > +
> > > +     if (self->device_id) {
> > > +             test_cmd_get_hw_info(self->device_id, sizeof(info), &in=
fo);
> > > +             assert(info.test_reg =3D=3D
> > > IOMMU_HW_INFO_SELFTEST_REGVAL);
> > > +     } else {
> > > +             test_err_get_hw_info(ENOENT, self->device_id,
> > > +                                  sizeof(info), &info);
> > > +     }
> >
> > If self->device_id is invalid it should be reported right after
> > test_cmd_mock_domain()?
>=20
> A device_id is created per mock_domain. And mock_domain is a
> variant that could be 0, so a device_id being 0 could be a
> normal case. Here the invalid test is for negative coverage.
>=20

I see. thanks
