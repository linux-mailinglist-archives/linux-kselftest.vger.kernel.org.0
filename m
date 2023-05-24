Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6470ECCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjEXFAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjEXFAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:00:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35EA18B;
        Tue, 23 May 2023 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684904450; x=1716440450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ULErIEV9ENwIOZZTzWx5RYurmjWLI5QolcORyljo9v0=;
  b=Z0tP0u/uLBkhkFdKdCBZwemJnXxoW3KJDqNptZzJ+MCfuDu5ifwHnIpq
   B2FDwiIWopEOCubIEbHHiBlkan00v9zKDtUE0vLC47/LAPMrKKknzELXZ
   gR3Ol0FQHg94cbIrCEDRjKu3sGj2sTj9yKsbaeg2UDFo18IjQJUE/b9kG
   /RalC6x/VntJPrBEWkEkxj2K+MLnh1yvHVhtnuu2Di+wuu5RPWRZSDDIc
   qQ73MT7zXAX6Z+vTCgElS2ERauIJDq8IJwjFhtNKWYlHuQ1m2S9eHlT4L
   YxdrK3KVBFkOyxM6HzuoOb4DBGNdXvO11AtZ2cUrCzawpE2vpJmfdYNJN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342917694"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="342917694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698373453"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="698373453"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2023 22:00:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:00:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:00:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThAPgj8ihpIP+PimOiG0dEukY67GdxAdc7wJB/C11h3wauwTmjE5LgrEdWLw+qbCZ2X+4ZGNh+WQl/l6tFrWPcH7LdSmNIucQakBCj18GUdhPrPEgv1hRT1RLUizJbedIQRNWMp99nTpuLKh8YnHUdlM18TWunJ7VAhDat5oQsrlECt2Q7IJstFYHd1O8lNrgZ6pZbZi4DrqNEwxfrBhyvKPy30PBT0IPrCQWrZMscmNOmHqPJyA7dGdKUdYLwEsT59xzkWAwQjUVOgr48uK9zoaXHIePD9AGFSJb//MmkR5832g2cVIRS7MpOue6DCIDTilBfZ+LoEr/xvCLsexlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KswGDQdft98cWuaAe0LJDlDMxX2PWfBJahQk/tPga3E=;
 b=VSzdg6Uhzg6ET8k4wGQ0ZEq4i1ti8wkChCHvx96fYA3VNsfymNNEBJcVvM1xr7l4+LWYs0ITgTrf9xBpvT3NwjCJ9ACrxaUDjZBDX+cj6PUDg7iWPlPjDSeeryizWz0Z8+bSeGPli6mpmuVKjDjKvZ3BXurbeXjHeoup7A3iRfn7WNRiTJ6FbgtKGUZEg4iRBI+bHSslDExC3DM3yRUjut1b2LW3MPFVMMpeqmeJWDIgLezZ3BMf0nzsVuH2mPtdMaU2mpd82mEceRr9eVfQzKiiJkCPp/wo+HcGLNnRcTztTw3UvIkESx03EM70R8WrAU8MWPzp45PdYUyNncwWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:00:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:00:41 +0000
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
Subject: RE: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZhBUvZZEu1sIxqEeJFXndXH1dUK9hUM+AgACm74CABvh3oA==
Date:   Wed, 24 May 2023 05:00:40 +0000
Message-ID: <BN9PR11MB527674C06FAF4DD211B342BB8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <BL1PR11MB527103529CB229A58C2439FF8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfANz/aJp2WtXSp@Asurada-Nvidia>
In-Reply-To: <ZGfANz/aJp2WtXSp@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: b0970c0b-1b8d-42b1-8c34-08db5c13d27f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xnmY0SDokgRitZIpsryyLbOht6RnWyWoV4ARgvTW3D22SNjH+aoikm81K1OxLRRbxW6BHvR9Ihj+iOkX9StFFdUAwizoTLCzCXUDu2Qd+GmB5c++5Q6jvDpHxDwx/GZyk/bS+gSuYzo004m4W+YEamKPU0f26y5yDCx6vDXFr5VoRvqquvN4ZAQgd1Ncmk+2RT8s4I55dlXr3WvoIoE6CJDgTrdYWkcBqaXtQWZE6vq3WBP5tutn0R4FycieeE8Jspv5weVT+TBG2Rex4gxACqsDO595BMkUL3t/PTNFLbYUgvdsy9IfI279a0rCn8IpvvnXNK6oC6V8EeyxsTxI2miTyOLM6Fjyfe0hTPNWf7roZ6XtAvu4pFTcqZMrANVEwNJa9NR50XW+NFpSxHUo4tP/ywJWcw2cWh2TbnN06i5XgL2Q/ybsmOPyB6Fdi9++1OW2Qsnyx15+u8yN5XfdxP3Tfa4xO/D9VQkRVP7DGhnPg9+CdrVJaHNeMwxNIl7eRRa6mxmxothraQIhJxkDTzt2ij7nm3BvuhQEqnsBt9IAPbV37pTv10jOSTKny507RpUFFzC8sYPrst3VBDU1ojwaT/EH+lLQnMYmDJtLYk8q9p9qUYO86HHXaI40wOF6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(86362001)(54906003)(41300700001)(7696005)(478600001)(71200400001)(316002)(76116006)(6916009)(66556008)(64756008)(66446008)(66946007)(66476007)(4326008)(5660300002)(38070700005)(52536014)(8676002)(8936002)(38100700002)(26005)(122000001)(7416002)(9686003)(186003)(33656002)(2906002)(6506007)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X7TWCwwGucfgq9eq5LqQP8Y1tXdUA5/sPoKziTmdDZjcydhUI6azhXhwklJ9?=
 =?us-ascii?Q?0HqlMolCRqTS0ccAyT1PgCsyOXnV58MJqfOw7oYJP+VztlaxeatDvqZKs841?=
 =?us-ascii?Q?tbwRTyRSmIGM0HHRiNU1RDBrdqAxIpBaJDz9kUTDWaqbKZDg3XIuGYSRlBi3?=
 =?us-ascii?Q?a8etFR1vTYWzJIfUg6+rXqRBYRlq0sDIv3Kag/O4JCwPnWeCxLuCZipz1fZG?=
 =?us-ascii?Q?4xOT/0RLZefi0rJ70QSEJWYVJ0+CrqSW+I0Pz99fdkWfyvLks/V8yxyX51yk?=
 =?us-ascii?Q?9TV4oL6qS33uuypwqhiPN1XlDZKhoDsIRaSWnbmWH+Pt0PerM3Zrs+TZac6M?=
 =?us-ascii?Q?VpA3Q4iUspJXFuINie2UGeuB/+a5R7xCoon0tUgD9nD1CvtnEjWrOey9lVrV?=
 =?us-ascii?Q?78BT1uEe6GpMga13lj2AJ5Gge0lzxqUeVdDOBStCMa3AzkLbOdfaSt24XX3x?=
 =?us-ascii?Q?u6LXz0nyFhCqX4jrr5g9yPyRWuQ9EsJAtB7D8H2h+Voo9fHro0gIm6wlyBlf?=
 =?us-ascii?Q?/XRA/PtKykpC5R+DPOzUxL+iDhgJayYPi3mmymeOh0qqT+tFP9DMZLO7QNoa?=
 =?us-ascii?Q?13IaK7LXfIkGltAxdeHzJMmlD2GQ3UkTsWX7biybwC10ulRtUNerzaVntB5H?=
 =?us-ascii?Q?tswMCFiqoyNOPQucYbQQ8rmlc0xNR+uGDLJ4BGjI9l/U0En1//IfdkrCL+Nt?=
 =?us-ascii?Q?C0GGGfQXggGevQzARJtGlAjcb2N3XDFDIAWFtNScdqnVKKmX4Ix71Mr0jzLl?=
 =?us-ascii?Q?Q/+4uJA1dDKDEneceAY0kpVbZakjSD2MtYGPA45Qad2o11kbezZUUi9mR8Mu?=
 =?us-ascii?Q?HRtKudR9a0UfxIJRrhJkSZ5iK3HEzBOoJKiKDXxs0+xhhJ8ziKULzF5VRkDs?=
 =?us-ascii?Q?9XLY5hg9rNuKFA1f1FCTIzpm2c1znanPG9/oTL6ovNBYTFklyZa7wL8VgDZP?=
 =?us-ascii?Q?NNX8Tfzk7L+hqhcmLRJY7T1w2fMu01/UO66WYSkJ29uZqrzZuOHAV2MODXyx?=
 =?us-ascii?Q?vH8N83g05MzPhE8aQUpy8AmmPB4gKUeNHva74lYb+LDQKX24bDXlH7T3+o5D?=
 =?us-ascii?Q?TTxEOifO6xOzPFUwuHMBKjWwZ+YqRLNNhWpPj7U9A1gBZGSj1bm7BxzOtz5u?=
 =?us-ascii?Q?eSreEqnzbMSekSYRFBL89RbCzS0NHiRzY1D8QYqWA3akYou7hG1zGMmLR3nE?=
 =?us-ascii?Q?tbkY1iwA+jbxIX/knZwHr50/N/1vwZM8Rt1hCdXj997VVeNnvbzyqWu5VSOC?=
 =?us-ascii?Q?FTkCMou/KjBFftHctTCP0SqZYbhjvbflMDFaHpmHXkPj31CePtnZDVdNumtP?=
 =?us-ascii?Q?1F8NxgU7HgLTcotCG7P4GZDYHnBAyCa9LZuxEO+GoDjkYK5b6VqXPGAl1Ka4?=
 =?us-ascii?Q?b4NWRuzFSRxnNrEvSTI/sqB/rBHv+buNUhgYF+q2y6Eto0mFzkAtC4PzCa7E?=
 =?us-ascii?Q?BT4E7LrKCj7xB1Luz7StlhTacWAWepOpg12lY7i7NoCBxjU4fYWfTB47Yc06?=
 =?us-ascii?Q?IoRh5dNd2FZqaeDuJzcp/ZSNaTfZbDbpZLiorP6MrAQJuq+NsrUkitLl/jUw?=
 =?us-ascii?Q?oY5eRDjccLL9JMBdUUyqV9CU4dRSKSD8Rj2knYLo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0970c0b-1b8d-42b1-8c34-08db5c13d27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:00:40.8360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbvia4fX1CUVGifUnZUoERRBNj24sU8QRx2PIO8GOnMF9UbiJVs6VutGS1d17WXuK57sJyCS1p/9xC7hDDjMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
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
> Sent: Saturday, May 20, 2023 2:30 AM
>=20
> Hi Kevin,
>=20
> On Fri, May 19, 2023 at 08:42:07AM +0000, Tian, Kevin wrote:
>=20
> > > +};
> > > +#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE,
> > > IOMMUFD_CMD_DEVICE_GET_HW_INFO)
> > >  #endif
> >
> > Here we have a naming confusion.
> >
> > 'IOMMU' is the prefix of iommufd ioctls.
> >
> > 'DEVICE' is the subjective.
> >
> > Then "GET_HW_INFO" implies getting hardware info related to
> > this device. then it should not be restricted to the iommu info.
> >
> > with that it's clearer to call it IOMMU_DEVICE_GET_IOMMU_INFO.
>=20
> Though the entire ioctl is tied to the input "dev_id", I think
> it isn't really about the device corresponding to the dev_id,
> similar to the IOMMU_HWPT_ALLOC having a dev_id input too. So,
> I think the "IOMMU_DEVICE" here should be interpreted simply
> as "an iommu device". We could also highlight this somewhere
> in the header.

yes this is a good view of it. with that it's not necessary to have
a 'DEVICE' notation in the name which looks confusing with dev_id.

Just IOMMU_GET_HW_INFO for the iommu behind the specified dev_id.

then keep the structure name as iommu_hw_info.

>=20
> With that being said, IOMMU_DEVICE_SET/UNSET_DATA should be
> renamed to IOMMU_DEVICE_SET/UNSET_DEV_DATA -- "DEVICE" is the
> iommu device while the "DEV_DATA" is a given device that's
> behind the iommu.

this then becomes IOMMU_SET/UNSET_DEV_DATA.

>=20
> > similarly for struct iommu_hw_info.
> >
> > 'iommu' is the prefix for all iommufd ioctl structures.
> >
> > then 'hw_info' is too broard.
> >
> > iommu_device_iommu_info reads better? though having two
> > iommu's in the name is a little bit annoying...
>=20
> How about:
> IOMMU_DEVICE_GET_FEATURES
> struct iommu_device_features
> ?
>=20
> Thanks
> Nic
