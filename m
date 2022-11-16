Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3E62AFDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 01:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKPAKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 19:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPAKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 19:10:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F562A70E;
        Tue, 15 Nov 2022 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668557414; x=1700093414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JWH9cu3vSNQWqELTcYw5M90JbXrE1ZkENu0VXH+K83g=;
  b=DgJbVvlSMi0Mhywve2AhJTGF6gre1sM1fMFSss6i7j+Qavb+rCXoBKcl
   wWNnAtgw3zhFBEtJ6if6Rg4KgNOrbSwYxiv3hzA/zGfMaIAQ35pndKnKs
   XwBkQViXnTS7EEnlumvsALelbr7zohZoiFnZ5FUB+YFYl9yUm/CviT7nO
   XYhzMcc003WW7F/rpuFCjpm+v87N73KvaN8kksMAooNqPRxC2JiUfKTeZ
   kU0GWkigCVxdo0orexM03fef48Z2pU7a/xeHttf/WGSZ0fNDbpQidUNIB
   TpDBFQMEHo6WJl1q7EifHfjZZx3idItXXEdaiWcViKvElgUH5DWbwf4sG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374536558"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374536558"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="589982866"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="589982866"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 16:09:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:09:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 16:09:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 16:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoGtHLDCcA5CqzsO6R3dVx4Nxo4zBqZ2HvsQI08S4Pf6KIdmc2QdgYwhKn5qRSHVw2qwPt7Yg09rFxzh+OheWFvwwgqDzOcSi7s6ErI8FgUwWspCGv69f5GGzku8yzCCNuLDMp9yNF7FBTTbjpQwO/OrXAbh6zVYoypvArba0w1WPhLZYTxAJqQzRKHJAcPBxULR4o1ThBspo8CR6WEN1BDfYYWoJcPBXQ6wGA5y0My1r1QPZOjEwYF3PAZ1bUtuLj8sLmUy0scUK7zR6FRc4UQtktwFF+30+c3iWucwVYke78FYJbVpiGcuSnHm/6QiA7r339OCYxxQZx+vR00o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4WZR3VPyNuvuKY4e+MkPyYH6tB1Bu9Zrb/rXd9Yrvo=;
 b=Cr8XQg2FTKY2bSYUfUpqJBEZ1FoFs85mGfKjwHCjulORokKSDCSppIoLKDzutViT6HJ8a3PmtgjLopogrla2wNEz1HeKMBhR/QE2fI8rnZ+99cEjR5JGk0Q/5PDKnsmgb6ajgcY+1GpPwqw4SgJWKyVwlLrs6cypIizqC4qxK7IHMg7cHFKTyIPE/FxL9CDWlz0yYKlTTGfRjTRyEOB9oEdqRG8n+Y1notpqeJ1gUQJUdIM48rYZ8N1UeTlwmhk2n+nXSDOiT2KyZZ1I/LjwDHeT0z6PMBpbOO0ybcofWkeIm9krscdzbgl/+KXnZqMSTrleJg9hrLHuzxWtq93NTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 00:09:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 00:09:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Chaitanya Kulkarni" <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Topic: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Index: AQHY8wv9weOL8WzpqkSvohFTeBt9pK499F6QgADXp4CAAIydYIAAyJuAgACOkcA=
Date:   Wed, 16 Nov 2022 00:09:52 +0000
Message-ID: <BN9PR11MB52763671DBCFA976C0038E6A8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KMbyVwS6D505cA@nvidia.com>
 <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3Oqq74bKsQo1YMH@nvidia.com>
In-Reply-To: <Y3Oqq74bKsQo1YMH@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5213:EE_
x-ms-office365-filtering-correlation-id: 9c47bccb-13d9-4b1b-c0c3-08dac766e233
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5z3TvAMqjsD+btdqfYVnTjyG0oKi1KkjkOBUwcTkR5/bhSs0lrWuMHypXV68Y3STV96KTiumRPHdzu4UwxX8D6chTjc/HM9SOiQzDiCyY9SJWxf5DTALlhHybjF9kTcIyjlP3mPAGAhY25IB0ndQhSOwb+xC+QkVF/NEEzu0JVU4i0tducVfPfmbgR/K35ZDLNymJ0ik5W2qu7nBogAuYmYVGlT5ls7DKPMfmaAjvYQQQ35/Y+wAikMnjarV3bC1CTFQlCEJweph901hVagfgo/SCnOV2cuU0zrMvdkXwlWfZZgesZ6rVvXehwmT88J3TfucKySG/mTeKZIPsT+dxXZyF37243T71FJGf2xiIy9V55v/PPLSYLF6wSbIJN554FLOVuO+AFjM9FeqWxNc8W6Rq8Ahdm0pTHjU02FrEOsj2jaL7XOWLuqVv9x0NhhtdWnQSzaK2A00TSI+ZBBZq40iu1cBNMaR6sAAD3DQUS9oeHzzB8Zv3Pc0R5TW3GKF+fIUbtmu8fRzxIM0Gj8csBqgysUDfStcMVfWFSmfUAqxYGyvlwVjNoZQ/9yOTGUx4KsM/0I9z3u9NK5Tpk7e+4uWPlYrmxZWvwk0VHa+naJN52f5yiiwP3DPdwEyh6P8bRDkoYfO6tyipo0GW31a5FVbXO5sdG+c4EzpnVxe1FFyERww70pliUQ/yiuhT87O3yJsJaWqROeAfzM95R1c/9+LiqwyuJoN1+7G0JHlLsJBzaqs5mqoBVk06Rn20F8xrPxtw1djcIfZ8dZQM/sPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(8676002)(4326008)(66946007)(66556008)(66446008)(5660300002)(66476007)(52536014)(8936002)(86362001)(316002)(76116006)(83380400001)(64756008)(7406005)(7416002)(38100700002)(82960400001)(122000001)(9686003)(6506007)(7696005)(26005)(71200400001)(38070700005)(478600001)(6916009)(55016003)(33656002)(54906003)(41300700001)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k/zuCkXrK1DVraOGXhqY6a+9THI3NU+h802DSRmzXvCmRj8bk5MX0S4YO//p?=
 =?us-ascii?Q?tTo+TsWcGlUKCZv96aGDvfAOtP17qtRmAZRk7iQKxJFgIajXvBDxUF7Cdty2?=
 =?us-ascii?Q?nOJhn8ei2ZqkxK3RIPbDh0TFCnprLtiHr/bhvKZjx5srk0GsbiqDn84SRTDU?=
 =?us-ascii?Q?jaQ5YhzwvSdhTeYQgF+DpY7TEC8mZKYzP60nnKVwU+4/gh6/THL5iK9NoPtg?=
 =?us-ascii?Q?7S8k0z2UbDbR6i51sOftJFyiK2TTFZzvEttzA0dm+JnZmwI9q6WVzm44WyYE?=
 =?us-ascii?Q?6kFV/4CuWWkTJtmsCrCkHF735GFzrjnShpsKPgnUaVGe4JiUO/jTwezM76re?=
 =?us-ascii?Q?h+jEnJ9fKPIEMUb/1K4GJ+It6yIJxN2BkQYFpm8xCg493Ifbo0pD3GjdgyHN?=
 =?us-ascii?Q?BhS4H5jyQd5Oe8e2ye/xBZX5SBB0i6w7uEN6JxlMFdhJdCEntoL+yVpDIqN0?=
 =?us-ascii?Q?ATBOBe5gdWKEMZjcU52zSlJXsGBhHBkas/Y8R7L8caV8/rG+c+PkTcVELdyX?=
 =?us-ascii?Q?Aeaxap7SOhvDxK66j2YYW5wGpfhyiN7forSCxY+Myh6sFUk8K6b0cxIm/Jam?=
 =?us-ascii?Q?NdwZr+KUGfM+TBfeAvG2jKLtK1sQPccp9Dn3wcpQBXwrHO1f3TF+Lclexois?=
 =?us-ascii?Q?N5fu2T4P0N3aY5Q9s7Wg472t/bTfMVumdBZ3be+F9feOoQqKYh86ID8ympN3?=
 =?us-ascii?Q?jkdkmvlBOZzbIBkAqbVbxDqSs7QYDz+QJumoqH7kxhCP5yrl8bILKvrsEikq?=
 =?us-ascii?Q?LEXgOQsdD5gWYAvNpSmVo9D+qGZIdbptvMxDCjA+XppSk1jVYIlijugQRFfq?=
 =?us-ascii?Q?5mS6bao2OtMGgDGqLvR7CPOX8n68vBTGSVjWeauJE1ssQ7JJvuKW5klWt5LC?=
 =?us-ascii?Q?dTiWo3IOL4qKl4LPWTf3xNpEyHsToMC1oIyC+U1ux/+LDrmsOAeYCEHT3tMc?=
 =?us-ascii?Q?AD/CrPrTIfXEEOiA9+STOYXLUhyOD5Qd8v0Kc7Iuy9DP4P7Ii0czIBYussuv?=
 =?us-ascii?Q?29eQTcwXLoyQrKsH48Ewpc1+jk28CG6IbvKpw+L5//oLuKHXP90l5pJ/O6mj?=
 =?us-ascii?Q?pyj+hfNSyKGBVQ1xBhoBF/QMB11pyVZVl3ufLZwbo1r7f+DR6DQKXRTu5PR3?=
 =?us-ascii?Q?iWA/7waVzIQzsUZMKbMK+05E7C3ST41++6EsqEwxVxq4UvKqFUAE8G6Hq1iE?=
 =?us-ascii?Q?hKN1xqSs7xmoGKoJw9Hp56UHvWndY0WozyovRqS9gmTQQAm1E+HOXO0Uzq1W?=
 =?us-ascii?Q?16MqwJxtCqtZZpvpBK4gpJ8ZSEOBX2LOGXg1MP0nkmgNLvofJL8BYr4/oCxU?=
 =?us-ascii?Q?bDTBiBlJi1m7W6mL8hpF5zgI4II/f2ngkis6zt6utdLIW9+czGHbJirGCmgb?=
 =?us-ascii?Q?gCXBAS7BZ2YRszaa87CcFXVmD2Qc2inS0RXFlnuAd6Wt0Q3z5tbOnTZ+zgLM?=
 =?us-ascii?Q?sNxMCkLrDx9vzbEzAPfiEkduReRrUPznTyuM3UYBMQtpqyqm0qM2p79ui9Yz?=
 =?us-ascii?Q?VBXcxNvFhvDAntOuyyMC3pDguwkNPVaF5xWOSOYZAKidA0zqi1KI65/4IbGw?=
 =?us-ascii?Q?mneyZGuDivVYKgP2fuzFxeUAKx+1SeSC1qJtkjvs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c47bccb-13d9-4b1b-c0c3-08dac766e233
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 00:09:52.1667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvCdhSEOpqdP/iZduKvfnETy+MZKQ78eadAdqJi//3ZtcwoivgYEetaXgyCqa5JDzVXrsFY2aJ6k9ON40uV/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 15, 2022 11:05 PM
>=20
> On Tue, Nov 15, 2022 at 03:13:56AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, November 15, 2022 2:44 AM
> > >
> > > On Mon, Nov 14, 2022 at 07:28:47AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Tuesday, November 8, 2022 8:49 AM
> > > > >
> > > > > +
> > > > > +/*
> > > > > + * Automatically find a block of IOVA that is not being used and=
 not
> > > reserved.
> > > > > + * Does not return a 0 IOVA even if it is valid.
> > > >
> > > > what is the problem with 0? should this be documented in uAPI?
> > >
> > > 0 is commonly used as an errant value for uninitialized things. We
> > > don't automatically map it into a process mm because it can cause
> > > security problems if we don't trap a bogus 0/NULL pointer reference.
> > >
> > > The same logic applies here too, the allocator should not return 0 to
> > > reserve it as an unmapped IOVA page to catch bugs.
> >
> > CPU doesn't reference IOVA. Where do such bugs exist?
>=20
> SW is always buggy and SW programs the DMA address, so it could leave
> a 0 behind or something during the programming.

address 0 is never a bug in DMA to IOVA. if it is, it will be out of the
aperture or in the reserved IOVA list.=20

DMA API is also a auto-iova scheme from driver p.o.v while it doesn't
impose any restriction on address 0.

> > > > > +		if (!__alloc_iova_check_used(&allowed_span, length,
> > > > > +					     iova_alignment,
> page_offset))
> > > > > +			continue;
> > > > > +
> > > > > +		interval_tree_for_each_span(&area_span, &iopt-
> >area_itree,
> > > > > +					    allowed_span.start_used,
> > > > > +					    allowed_span.last_used) {
> > > > > +			if (!__alloc_iova_check_hole(&area_span,
> length,
> > > > > +						     iova_alignment,
> > > > > +						     page_offset))
> > > > > +				continue;
> > > > > +
> > > > > +
> 	interval_tree_for_each_span(&reserved_span,
> > > > > +						    &iopt-
> >reserved_itree,
> > > > > +
> area_span.start_used,
> > > > > +
> area_span.last_used) {
> > > > > +				if (!__alloc_iova_check_hole(
> > > > > +					    &reserved_span, length,
> > > > > +					    iova_alignment,
> page_offset))
> > > > > +					continue;
> > > >
> > > > this could be simplified by double span.
> > >
> > > It is subtly not compatible, the double span looks for used areas.
> > > This is looking for a used area in the allowed_itree, a hole in the
> > > area_itree, and a hole in the reserved_itree.
> >
> > the inner two loops can be replaced by double span, since both
> > are skipping used areas.
>=20
> The 2nd loop is looking for a used on allowed and the 3rd loop is
> looking for a hole in reserved. To fix it we'd have to invert allowed
> to work like reserved - which complicates the uAPI code.

The 1st loop finds an allowed range which can hold requested length

The 2nd loop finds an *unused* hole in the allowed range

The 3rd loop further looks for a hole in reserved.

last two both try to find a hole.

>=20
> > > > > +	if (iopt->disable_large_pages)
> > > > > +		new_iova_alignment =3D PAGE_SIZE;
> > > > > +	else
> > > > > +		new_iova_alignment =3D 1;
> > > >
> > > > I didn't understand why we start searching alignment from a
> > > > smaller value when large pages is enabled. what is the
> > > > connection here?
> > >
> > > 'disable_large_pages' is a tiny bit misnamed, what it really does is
> > > ensure that every iommu_map call is exactly PAGE_SIZE, not more (larg=
e
> > > pages) and not less (what this is protecting against).
> > >
> > > So if a domain has less than PAGE_SIZE we upgrade to
> > > PAGE_SIZE. Otherwise we allow using the lowest possible alignment.
> > >
> > > This allows userspace to always work in PAGE_SIZE units without fear
> > > of problems, eg with sub-page-size units becoming weird or something.
> >
> > above are good stuff in a comment.
>=20
> This is the comment:
>=20
> /*
>  * This is part of the VFIO compatibility support for VFIO_TYPE1_IOMMU.
> That
>  * mode permits splitting a mapped area up, and then one of the splits is
>  * unmapped. Doing this normally would cause us to violate our invariant =
of
>  * pairing map/unmap. Thus, to support old VFIO compatibility disable
> support
>  * for batching consecutive PFNs. All PFNs mapped into the iommu are done
> in
>  * PAGE_SIZE units, not larger or smaller.
>  */
> static int batch_iommu_map_small(struct iommu_domain *domain,
> 				 unsigned long iova, phys_addr_t paddr,
> 				 size_t size, int prot)
>=20

I meant a comment in iopt_calculate_iova_alignment().
