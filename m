Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B36CD070
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 05:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjC2DDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC2DDt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 23:03:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CD7213B;
        Tue, 28 Mar 2023 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680059028; x=1711595028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w7YovTqr51KK8gYz8qufFuF08P2XAMTTKNrs9xz1BGU=;
  b=L6sl1/L/tj90SmGZHWCOKWBqM8BfktmNNTMGoquVbi8lACknTKPx9UmP
   epQwkRnsc+Rle1e0SR3Iw5/FgyDzpDB6EW7Euj2OzgfGy64V+5PRDWcwd
   5Ad9j/v/Ju3NLsNor1ZqoRcxA6/PToSZlR3DXxzU/kRgxnw7D9oTSsBtU
   iUUuQR2sQCycS1DVHD5bH1UrqRD2wTVk0ZaAHq8IKUu3gpbnjCb0duA2l
   bVJMjvaCi+/S1ItOqWD0C3AuKRt1lK49+pWCrQMsOJ9baiPFkxNCCUB5e
   dQbSJyJ7hvSxHqy0sWfyoe78t/5UQ4e/5YcfSMnnAaAQbT2rgKjBjh5Jk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343173172"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="343173172"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677609557"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="677609557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 20:03:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 20:03:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 20:03:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 20:03:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR4Hu+rtxK7PVgH81nxoZe067XK2Jy2CJuKNx1f/sGRpy/POUaL1oLa8ZmwJX+QAWxMX6CfFoExJbMGlbdiFO8+3Xp3iDWIFCn8DpDQEnyDCWmSsyTMqnjlXsyZzKvqQyHbefTMY/D+MoQzCPrp4yJcnRBeaneUY0SS7Z/sMozYqi//avRvGqB9FLB4MqkND+0wrg3UBm0UOpLnldFLxnjaSzNtXaeURAfCTSndEQYTn6oBtoJMJpnx3VdIarJmypwRo8w4HFcsyO82Wz13nIiYuPEyeUR3RexA1QBIhGGcDGu+VeTH7kBMWhdGfq2mYMipoczntUvixGlsMwqdTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAF5Ar6T0xZfO4RfxMp9ScjkJxHG+3EGNLtGgCCHkG8=;
 b=egyBnQzKTzrtLcQQPIFBlTYdAOqENcC5nSLWiE0O1QWtHhcofgU6xBA/VT0yHKgJWM4LC/N/gqsTkJav0QAW9UX6j//f/VLQfCOFGuGnhkgT6CKyj2R/n9xpi6uUUeA790QKLigryuZuaBLLxWQpS/lxOXzBeagBSbljSl+n+zyzNIABJ7YVYkiNJRctK7qHA0a7OpeqfJ+Whbi3cvNPzRlakQQvo+RaSWWIfTIcrn/j6SUey/Ok8AGuVtU40/zM7bgSpGr6xEdrJeP1uOT1dycxQk+a11rBNR2sN81kSGNv0sNH3K93JO57UUGNdq69XDrXVBVn5emXcx1cvFBUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 03:03:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 03:03:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggAB8LYCAAK8/AIAA7fKAgAV2LmCAAJofgIABAjQw
Date:   Wed, 29 Mar 2023 03:03:42 +0000
Message-ID: <BN9PR11MB52769540C61AB5FB16DC8E278C899@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxg9cRIpsozB15G@nvidia.com>
 <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB27ke/vQxsCngtC@nvidia.com>
 <BN9PR11MB52768F348A2814083BC5F5328C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCLRu2NiVWNcdMk9@nvidia.com>
In-Reply-To: <ZCLRu2NiVWNcdMk9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4644:EE_
x-ms-office365-filtering-correlation-id: f6ebec60-6c3d-4b3f-f9f9-08db30023433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4AH855IOPXi9VC1Sqf47d7WSL4i7kYukoqqNdmT5liM0OAJ/wyJ90KYP+Oq6/WjDd6LKD7vSomjckuJedrrohJJnF4VeqT7WLI//vziTtfH/oPFJoTHUqMVDUK2ygfvJRoeFKom1xTDW0odpgY1ok2X0TGjbBFEUONpJL9iepRue5oW7GArxjZ3wGndJjj9ZArzNUl9Cr5vQInjfRLjl/gsaQyu3tCz5mVglg1z9tBpSaF8fo6iTNFELEDAQ9t7LCesWViIYxmDIzIfPveDWs8BdoZHf5S9lwV0fHz/921D0y+xX6fVmd7iqSM0IGamNUCrPSiNyVUmnxgfVUMK8IUCa8QNAb8oEukttbBNeMWeH0ht2cHJrZH6Lka8Dgw1Wx+guUNDR6xR0tbmzBW6yTsGBNGMt3z3saUQt759dThogWh8onnYlHYpaxSrDWKuB82X8Vl3TiYrmlMvzIQV0nYAovhD3WHgxhax3Fot5+mJkwnCeX2WI9lgKWw7fbxdIqReWVJbydcPOvUeRqLZO+N5X/NBM2ocS8oWrp2NHLNua3VLxwzfz+0arOak8duMS9y8gp/QX+jNy0zKnkP0nnCN5tfA8RATtyz3yICkKLYITSeEeGb+y77FysN1GZPk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(186003)(54906003)(316002)(9686003)(6506007)(26005)(83380400001)(7696005)(71200400001)(122000001)(478600001)(33656002)(8936002)(38100700002)(38070700005)(86362001)(5660300002)(55016003)(52536014)(41300700001)(82960400001)(66476007)(66446008)(76116006)(4326008)(64756008)(66946007)(6916009)(8676002)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RcXlSVYBsuc/Q3Nfc0TCz+lEwJUKb7JmpL0IkEkXyldcDYFTnauKTvmwKVSd?=
 =?us-ascii?Q?lCsA3cjOHCIBL5mv7ap3LjXpKfLL7Xc6FKBalVo5ZneYEnszBDBftmfKQTd2?=
 =?us-ascii?Q?Lw9F3mh4yP6hzhmSWBWRuYLy0aHdMH2MlRaKI72Z855pokvbXztxfZIsZwSP?=
 =?us-ascii?Q?jvGdO7AYBCCDNunoZWSKT+yNTUmXhbKV0dq5+Db0etVQCq/PoJf4h/cPKOYQ?=
 =?us-ascii?Q?t3tvHhgpeNDkF+WR1pOTlrn9VWWTxiUg6kH1UBVGqJzMFedoTCo7mapz11PB?=
 =?us-ascii?Q?y8mWyBwZlU+iQUXzlXhZBJ2udCbI20TscFI/VIgZ+WasJb8sur7rvN0vGgL/?=
 =?us-ascii?Q?tNYYrFv4JqAHJwZNiiedOCmgBp05ILDIOkAiN1hBiVPtTVAoZu47wS0cxZiT?=
 =?us-ascii?Q?XinbYA5eTCsFFwDE/xGPg0FYIGQdEaC2mjXMmQJTnPZaSxZwVOGht221jvvF?=
 =?us-ascii?Q?Kxdta0B6Bkv7uHX5b/XIzGA9IDKGa3jAaX13pSvUaX6/rCuNFlknC3Ex5PLG?=
 =?us-ascii?Q?RT4fNiDcAAEU0e47Zz+Z+13mk5Ap/lIU9IL0OLb+lFenHiqm1QdVS2wWeXAG?=
 =?us-ascii?Q?Y2ofJxNxbK92ux37HK7XwMquYB9FQu/PcS8I1pjo0JqemEOmzs8YYwpGVerq?=
 =?us-ascii?Q?PJp8njWD0bn96wkDQgPaD57eX5PPrV6mw2mD+y9cqCONHIapkY6e2xOq3TL+?=
 =?us-ascii?Q?a79H+JoYJjYmnyYMsarl8rLXIb3iNANTEKLa3EuT8spfhadhFabiH9ZrNGu/?=
 =?us-ascii?Q?JDQ8G1FeayyBntku/YlRoJfqS/Ry9Rl5aLP94tBeCeL+H8U5nfC2yzW7AhOS?=
 =?us-ascii?Q?FptsVnGMtx2btlySx9kYhv8voMQ0qYg5nfgTDLkq4iKLgLiZuZMj0zTef5y2?=
 =?us-ascii?Q?9VG2inf1fSRPjheDc0xzG9KpYGJuRHx2kygfP2nsc0CNeLGOXzFsCdg+QDmb?=
 =?us-ascii?Q?iM101aZtIeJHGwQk2CCjlZA9TzejX29O4Y7Nz0yf1HbxyDq5Ob0OUztFGIHD?=
 =?us-ascii?Q?HcQc0qv4OWFgePaqhpoyBHL152cCNlPJQ24THvuqKBghwkNjA/0Q+f6iJRik?=
 =?us-ascii?Q?w2sD0RwyhuFaTDo4Fmdn7p96+7gd8x8DvtvT3moxSKE2ELiB1S8eF9+5odFb?=
 =?us-ascii?Q?qrsmisobD1OByreVVzcZDxUGVY+iYOhr5p93MY950E44c8wSJGPxVJViEtV0?=
 =?us-ascii?Q?IU43QG7K6mY+xCONtGpEbImvkvT5qA/JVP1jFeTy8iM8urVkEGwPbAE2Quiw?=
 =?us-ascii?Q?/kTwjwe3UbN5NyB8RLgpy3yHgjqTGzRvsUo+CoEsSHDBCbGExmbqTZ/lVncq?=
 =?us-ascii?Q?fUmWfHHAy6l359K9tDSuIqdYhTYY8tdF29fMryjFyISy1RORdSm381c2ires?=
 =?us-ascii?Q?1jLp5cSzQy6+zcqs+nEU2hKX9nxxdbxK4kqW1itBjiUb6t6TaLQL6EgyuSsV?=
 =?us-ascii?Q?NGSzmTf28AvS9PnBh6is17lfTTRpoubKAklaFTWeYkWgqJwgEGK4HAKCAw9g?=
 =?us-ascii?Q?TAE347X2X0ViYKObRyrRfs4wj9n2FXV/LHvYGET8Ou+4sAoZKEVbYXPWm3Gw?=
 =?us-ascii?Q?uDtS8wZfVmcN2NcVZ94hKjG1amP6kIF2/pie73Ch?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ebec60-6c3d-4b3f-f9f9-08db30023433
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 03:03:42.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmPxdn9+DGWmsfOktVd3mnTCZCm42fEPSNq/HE2slV0aX1jhma8fvlh3CdvZqjDOCwlVz9mw9tG6Yf04egPzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 28, 2023 7:39 PM
>=20
> On Tue, Mar 28, 2023 at 02:32:22AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, March 24, 2023 11:03 PM
> > >
> > > On Fri, Mar 24, 2023 at 01:37:51AM +0000, Tian, Kevin wrote:
> > >
> > > > If vfio races attach/detach then lots of things are messed.
> > > >
> > > > e.g. iommufd_device_detach() directly calls list_del(&idev->group_i=
tem)
> > > > w/o checking whether the device has been attached.
> > >
> > > Yeah, you obviously can't race attach/detach or detach/replace
> > >
> > > > And with that race UAF could occur if we narrow down the lock scope
> > > > to iommufd_hw_pagetable_attach():
> > > >
> > > >               cpu0                                cpu1
> > > > vfio_iommufd_attach()
> > > >   iommufd_device_attach()
> > > >     iommufd_device_auto_get_domain()
> > > >       mutex_lock(&ioas->mutex);
> > > >       iommufd_hw_pagetable_alloc()
> > > >         hwpt =3D iommufd_object_alloc() //hwpt.users=3D1
> > > >         hwpt->domain =3D iommu_domain_alloc(idev->dev->bus);
> > > >         iommufd_hw_pagetable_attach() //hwpt.users=3D2
> > > >                                           vfio_iommufd_detach()
> > > >                                             iommufd_device_detach()
> > > >                                               mutex_lock(&idev->igr=
oup->lock);
> > > >                                               hwpt =3D iommufd_hw_p=
agetable_detach()
> > > >                                               mutex_unlock(&idev->i=
group->lock);
> > > >                                               iommufd_hw_pagetable_=
put(hwpt)
> > > >                                                 iommufd_object_dest=
roy_user(hwpt)
> > > //hwpt.users=3D0
> > > >                                                   iommufd_hw_pageta=
ble_destroy(hwpt)
> > > >                                                     iommu_domain_fr=
ee(hwpt->domain);
> > > >         iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain); //U=
AF
> > >
> > > You didn't balance the refcounts properly, the cpu1 put will get to
> > > hwpt.users=3D1
> > >
> >
> > iommufd_object_destroy_user() decrements the count twice if the value
> > is two:
> >
> > 	refcount_dec(&obj->users);
> > 	if (!refcount_dec_if_one(&obj->users)) {
>=20
> Ohh, it isn't allowed to call iommufd_object_destroy_user() until
> finalize has passed..
>=20

ah you are right. In this case iommufd_get_object() will fail in the first
place.
