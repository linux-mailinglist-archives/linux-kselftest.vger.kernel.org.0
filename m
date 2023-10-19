Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2517CEDC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJSB4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 21:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSB4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 21:56:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB54EA;
        Wed, 18 Oct 2023 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697680566; x=1729216566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XPkC8yLxHPfBJh7o9tTD7d72kGPbwScLpzW1wXL5CFo=;
  b=eQztThPZEEL47SLBy55ryCPJ33E2PCAxJIBAOHF/HVsRZpV5kqTKqKFd
   mgwvTy4MCrHDE6xIqxMPoDXs3DuE5ArM4cbyxFFBwtSJYl2JC6c4GHV2d
   SjiTIckKT9SfKDqqjXWBGZfcJg6H3D8/nAZrzj+7rY+PBvrZnRr5vUmjY
   z0776fcsvFwMWIYYY5cHVqnBMMkWTeSStcB0hVeCAIe5cuErzJUrevBkU
   SMD74Q0YfQ0NE+oX2xy0WarnfV755ONjHz7eZE1bRqy4bVGVsVsOWtUo2
   sExSi4OqbBFN+ZkzbT3Ig5OFz3YKIv8mWwEEg8EtNSDcFMIXHRJqy7qmk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417264399"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417264399"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088198821"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1088198821"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 18:56:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:56:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 18:56:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 18:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5V3HOZfAZTnbCjH4ACLTKuelnh8E9FJMlng+5J9emtQBpCNP+Cyg4J4xs78pOpkR1zIUTxPQtQbeDI7oBmp5mWqUrnNKXr/j1HFXCTnFeSzR6SUL20Ah96yFdHCkElqMmTIIXc5wOjSq/jjR2KmzA51J6g5m6CVFB7HzbKwf+7tuFmfbY8kEvfAiFmg7qQKMTe0XjsFCgVGWw1WWY4CQd2Pm6IVI+cqVgrPTXmnwIHzMoeKPRfwdrWnXi84V7kvKAEWm0a+FHSpNGnKP6Q7pLIxgfmybzWZ5RKUt7NDgDRI6IENxzYdwAff3IL4+f+ZUPlr1O2EbxZpYkY6UtVYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnigOM+W4c291/yfLIlFITCwnx5SOExnR2pD7nCspoM=;
 b=MNNUm87f+2+0gA1y2reafWCtqt9MnRKgH06DTFzgtznomKnixTf2Ih3zK/dms7xr7kY2AwCKfDIuh4wbOJlX/tmsIT4COF/DMfQNHDE0UqsSSqr57c42HBlrHVko3zagIpGSWWNH2rqcdWNiPF3im/qIBLucajnll5Wc4HZ7v/w+4NFclGE8XHXFISKg54MhmuxxTjRzL2zXP0zN6NeK77/l7mVqots4B+JzTbXz0+cLJw6FwDNAaRKiuldF+T5bj5mqbp48cXspNSa72nMknlnUqR8I3ZOzXSxLHsqL9EcGTO87z2OhgAFmEJRissmbGCEmCo/4e0WD62/ewpmDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Thu, 19 Oct
 2023 01:56:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 01:56:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8IAAN00AgAFSUcCAAIHKgIAARKGAgAFd9oCAAJQLIA==
Date:   Thu, 19 Oct 2023 01:56:01 +0000
Message-ID: <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com> <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
In-Reply-To: <20231018165113.GB3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5240:EE_
x-ms-office365-filtering-correlation-id: 0974a096-10b3-443f-d9f9-08dbd0468bdc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fSxpvHM58fZ9ukciOx8goq8iJe6hUCeBL3Zp0/59tQ6PuKUfLoBR22XLd9Fn+nke17+TxFsLDsCXeLLqYJITkAAKrAxODnU9SFPIt/6prZ+cMn/GhUYrZli8l+xF0xsAPXM0W31+0Vcz0efLgOeWpKaRTHVh58LXmVyw17cEpLpsw/c/QA/daOsdmX/cG6iKHW1OCDF2ayzWgaBBfVFlE+htuKP/w8GqOLBX6pzumSrVU+/GzEsESeKWLflfvQkrS7ERhCnUf06n2iylYn6CoUW+/v5h1En+9BJprEEYaaV/9KREuRRjd5CwzqL7ByTW14zID7WL8C0GZx2FbkIUlt55dQB2XEE/cCMvdEmautmZ5KzE8xKuGpezxhuaq202q0iMv9x+BNV41aArMerbElzdCN/+cN17Bk6Uh0LWWNGdZ4aSEKWOKxZlPCf8o1PVWWOt+1bTCCWfzwyKNYHS6jU5mKqi0JBthEQgRI3Iu5ibjfHYNJHvjJu88KwFP/IlBXRo8YtbnvfID6ly6nY6z2QAy2RybKQR6i58c6lDbB+bmaAj73+Jvs8Wu68pUHHZ6oLaEMXVIuj3jod4SRD2FuYo7nvuaZogdVnia2MM40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(9686003)(6506007)(7696005)(76116006)(110136005)(66476007)(316002)(66556008)(41300700001)(71200400001)(966005)(478600001)(64756008)(33656002)(54906003)(66946007)(86362001)(66446008)(83380400001)(122000001)(82960400001)(26005)(38100700002)(38070700005)(7416002)(4326008)(55016003)(8936002)(5660300002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WzIu+LhvVCRdzeHfaB/TgCqXtuxWwijHrOsHEH0R6DmXW8ELV7YoJiKHxLAm?=
 =?us-ascii?Q?n2TLpTftLJZguk9fxp6N65k3WUxcpzTzMwDrP8ueyrpR/6/cj4WQtbJrbfPq?=
 =?us-ascii?Q?o5kntZNDWJ+wh58Ti74Da2370p9duCNX1jFSArRtI51dIlfjZLIC0mPOHM+7?=
 =?us-ascii?Q?CtMtqGtxn8jJbhTtnsqIwTPnMyrc/PPXB/ihjSrAim6D/cpxAgrSyNeQbQLJ?=
 =?us-ascii?Q?nwYTb+u1bkaN+lxpH9TJw5FnyMne0GTkMv082cgszg5jzyRZTNbVi5p1I1aR?=
 =?us-ascii?Q?JQZ3rfEYEgEXcK7CO+3uSd5BcXMwFzAdSubf/wz/XqvIIRmG9B70BN5ORgA1?=
 =?us-ascii?Q?pqTgegzbcjPTgyjRe9PwCDE1EYWzS1mwDqeLsNxDlkdQGb3lLxWpwoKDy0NG?=
 =?us-ascii?Q?4bQRmnVSBfB/c6B8zpZs2Ud5np4RPKRFCZUZnNp2JxYS+aftbx7X6hiL/EJt?=
 =?us-ascii?Q?iN7UKFXItFiBqjelg0OmEYF+/TgTEWIeXeEKah8ZSkmJpiHg3pa4EfKhSZ0t?=
 =?us-ascii?Q?e/ZMFkYLEOZKYaUegSD7lWaCmUXw43mAcCoXkf4JTNM/jP7Q6kC6Cu1jfJpo?=
 =?us-ascii?Q?pdKHO8Q5umSu2eXHbPnpKKJcuVfDgopvRcEgRVnVbTEoMq7xqqwDzD9MpVh0?=
 =?us-ascii?Q?to4GG9vYgfwh2L5U3fqV/TDV0xOQ4ocjf+tIxznkRN7qx8ZEekIGsIF3IUIC?=
 =?us-ascii?Q?tu72nQNp2Pt8WDflabVm8zpfOcnwsX4kCgv9+D2WGfPf82/IKDc7rlm8SV3J?=
 =?us-ascii?Q?hdpGJ/5h26M15U/KNqEspqyrwYZH25SSjlXPaG88SKUm1dUEnQJEJTUIpF/+?=
 =?us-ascii?Q?5O6/RaZtJ+oY8FkOX8S5zKy5jHRBu7vshsAtYUO+tFP280XpPve0y58E575h?=
 =?us-ascii?Q?Bp4/Zu1MjK96yKO+aqYGTdX8pAzUAd8SdlXXc085+lTvvcNADC16EzOA8QiS?=
 =?us-ascii?Q?xXi7rwN7RVVF6PI5MOC1DqYDzEaADy5uKMw397W1sYRwSRJV27aU2PBobYIe?=
 =?us-ascii?Q?iRHsLkkXtx8i9wGLyHvRKENVtLkToolsTxDMGIL5prQoxTQOZKj7o/brvixH?=
 =?us-ascii?Q?KTdwUvDY8ASy0eUhaZDWWR8EVe1Gor0xfLAnWxbHYiLOGNaizrgCgQjR/pUz?=
 =?us-ascii?Q?+hlEW4mArcCXvTkqhAyyey6fPfeI0XL9XKMZlqEY8rj6FBIXqnlybJecuY2A?=
 =?us-ascii?Q?LX7z3Sau26ARRrtxzwXjTUxUF+C+xuq/y5lYQCxSra1EAMdULEPw2T3i79mw?=
 =?us-ascii?Q?PXllvyosGB7Ht4Dyg8uYCLkr3JH/9WlY6ZP1X4inYLUPEvmex5JSitJoUpQW?=
 =?us-ascii?Q?aHNOOtZbp1aUvZ8GECmhtAunYAOv8E8/YDRb8rATEnd97unMztQOARmZlqcj?=
 =?us-ascii?Q?N7DSNHH5RXFpsv4kNoZUnacDG5hPrnwQBtfLKQ48HXATRyq5Tir+Kz5ObfxZ?=
 =?us-ascii?Q?Bbln4wAvTzPMS/rZqA/mdfzriejl3c6318WrQYjLSNrvioZtik1YxCakGDVj?=
 =?us-ascii?Q?JPUkP9EHrc64dINlUU5dM4EeuFauIn5it7Ddn0uTwxhTxVP3Yx/V1Xlcx4OL?=
 =?us-ascii?Q?aiD8WebQJ9ye4sDejTZCwFAsWq7GxyBlw1RKBdlU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0974a096-10b3-443f-d9f9-08dbd0468bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 01:56:01.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mwg2nMYUjpQ1Z5FL6RNYFkXhoxIGIzyaICWpwE7j5tI7saW3VerxwAoK28IvpMw4Ce/PYBFbfq2U3VxsmGnUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, October 19, 2023 12:51 AM
>=20
> On Tue, Oct 17, 2023 at 12:58:39PM -0700, Nicolin Chen wrote:
> > On Tue, Oct 17, 2023 at 12:53:01PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 17, 2023 at 08:52:49AM +0000, Tian, Kevin wrote:
> > > > I prefer to removing enforce_cc in attach fn completely then no par=
ent
> > > > trick in this patch. Just keep it in hwpt_alloc and leave to iommu =
driver
> to
> > > > figure out the attaching compatibility:
> > >
> > > You are basically saying to set the cc mode during creation because w=
e
> > > know the idev at that moment and can tell if it should be on/off?
> > >
> > > It seems reasonable, but I can't remember why it is in the attach pat=
h
> > > at the moment.
> >
> > This was the commit adding it in the alloc path:
> > https://lore.kernel.org/linux-iommu/8e897628-61fa-b3fb-b609-
> 44eeda11b45e@arm.com/
> >
> > The older code was doing a hwpt "upgrade" from !cc to cc:
> > -       /*
> > -        * Try to upgrade the domain we have, it is an iommu driver bug=
 to
> > -        * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> > -        * enforce_cache_coherency when there are no devices attached t=
o
> the
> > -        * domain.
> > -        */
> > -       if (idev->enforce_cache_coherency && !hwpt-
> >enforce_cache_coherency) {
> > -               if (hwpt->domain->ops->enforce_cache_coherency)
> > -                       hwpt->enforce_cache_coherency =3D
> > -                               hwpt->domain->ops->enforce_cache_cohere=
ncy(
> > -                                       hwpt->domain);
> >
> > If we remove the enforce_cc call in the attach path and let the
> > driver decide whether to enforce or reject in attach_dev calls,
> > there seems to be no point in tracking an enforce_cache_coherency
> > flag in the IOMMUFD pathway but only for the VFIO_DMA_CC_IOMMU
> > extension check in the vfio-compat pathway?
>=20
> I think the purpose of this code is to try to minimize the number of
> domains.
>=20
> Otherwise we have a problem where the order devices are attached to
> the domain decides how many domains you get. ie the first device
> attached does not want CC (but is compatible with it) so we create a
> non-CC domain

in autodetect model this won't happen. If the first device is capable
of enforce_cc then the domain will be created with enforce_cc.

there is no "does not want CC" input in autodetect.

>=20
> Then later we attach a device that does want CC and now we are forced
> to create a second iommu domain when upgrading the first domain would
> have been fine.

then in this case the 2nd device will reuse the domain.

>=20
> Hotplug is another scenario (though Intel driver does not support it,
> and it looks broken)

Can you elaborate how hotplug is broken? If device is hotplugged and
failed to attach to an existing domain, then a new one will be created
for it.

there is indeed a broken case in KVM which cannot handle dynamic
change of coherency due to hotplug. But that one is orthogonal to
what we discussed here about how to decide cc in iommufd.

>=20
> Really, I hate this CC mechanism. It is only for Intel, can we just

Intel and AMD.

> punt it to userspace and have an intel 'want cc flag' for the entire
> nesting path and forget about it?
>=20

I dislike it too. But still not get your point why adding such a flag
can really simplify things. As explained before the only difference
between autodetect and having a user flag just affects the decision
of cc when creating a hwpt. whether we should upgrade in the
attach path is an orthogonal open which imho is unnecessary and
Nicoline's patches to remove that check then also remove this
patch makes lot of sense to me.

Then the necessity of introducing such a flag (plus adding a new
interface to report cc to user space) is not obvious.
