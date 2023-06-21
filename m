Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEBA737C54
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFUHKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjFUHKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 03:10:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327A1703;
        Wed, 21 Jun 2023 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687331400; x=1718867400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QPd+MI1FddaBkFC47EK8ZKP4ZmymvxUCkm5CfrqAaI=;
  b=Rqa3vbB7yZFCEWJPtD3zGWYay8juiCsXhT7P1eJ6KRCtCaLoc/Jx3YPk
   ap9XPMT499OOyD9BxEaLGqGXWYsWmQGv4qKVrhjFQ8cTHCoNTH3rvK6G+
   UJPBm1Pj1Jz9nlkWz3aj3yOP0ishBIhz2LeiZ8rcgiWInCxtlEmtdRTyI
   Fq239QbpdgGR51KUSVmxZhVI2W5tQmmN4w3gJCkryoW0xFUjxB9sWNb91
   T4a3wPa+a+XOHvQDoDMu5EcI4ldBFNqpI5c6h0pAMG7pCTx2QkFP3x3aI
   LT+MZ+Z9ZvrDEA1LBR72xgPCJ5jC7K0hqKrxCiSvuHVhcZwjromqeQdH2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344829142"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="344829142"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="744064148"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="744064148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 00:09:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 00:09:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 00:09:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 00:09:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 00:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBe1TGmK3+YmpnxJ5nBA5Mr7TTF9JBg9+kB0oCHTb7YE1FVR25sq1VuQAtl1vUGnN8SK3eHQPMNfIMLq4vSoJgTJKYmsnGnGQaw8CSBeuCMQO88w0LC9vU5oJ3IoD85aELJdGsrolhHl3c9N9qsAONs/mxVEW7rV9mn9Y563Ly4z2bXdu9FLWC+2TImAGaaurG/eZOQRSR01u/0YXgLozTIOHb7h6GIvqDOkR3PTEnrU4REInf1E5tGlIID/yP0ks/x3WHNpaM8yE8TKdqMEJscNHtw68XETUG/mWXEoourwq7awNaR2TJUlviCmSHyoIj2U9dh2QMfVV1YSQp83mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UallJ0mgjLZc1D/NJDUgDRjGn3GghdFmNlQ6sNfJ8nw=;
 b=OyLGFagIFlqL3qwfmPudtP59DpqwPN6S32YDqhGHGRT2pzw9r6fSoDEtBl9bJzLCEIB6wKwxiB2/KJxqJ10NnHJwJhmXuLVDogSkPrIzpZq4tw93mayOgd6jzTVyVg4amMUxs7Y19h7wNOVj2RycKfGCf4r3Q6j0UmB1D6k4xPoquulHLkZrgJZ3yh24oKOCbEA4U2CST9mqWqJceB2Cjh/5YIpNNmy1fYssSVYeHmRp7ojjB5j6yFBKlbABSsM45/rILwKptxWDcvnx7pJtnGwqibW18xrfkRNaRemzVobLzdH7KUsOSwr32YiwuWfLpBGWXUDYtd7G5AVreVEK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5522.namprd11.prod.outlook.com (2603:10b6:610:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 07:09:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e7db:878:dfab:826d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e7db:878:dfab:826d%3]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 07:09:28 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTR8nfuQ+8HkGYw9uZHMojRq9haBIAgAAfs4CAB1VTgIAVHiGAgA71MYCABVzrgIAA28cAgAC5cgCAASEngIAAEmkQ
Date:   Wed, 21 Jun 2023 07:09:28 +0000
Message-ID: <DS0PR11MB75291BC455C6BA466C7B2F2EC35DA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CH0PR11MB5522:EE_
x-ms-office365-filtering-correlation-id: 2e0b899f-857a-4790-b5f6-08db722673d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vEXWwq37Q3rP8e9pZgfXPeDm77CXfpuOKeaazIuas7uOA4N1G7un9g9f2ZitwOV7h+jC9IIFPNbeaAyAIApPG8aJqOKkjUNvAA+emgKPkl4DiFSTtqmwccFisvpa6xtZkFscFX4rB05izXfAQNgovrAGWymgRtOaKXB/a54dMwi4DipdiRnOY4fG2jw0OjAOYj8ddyn1/mjzwIs++Hyq15g7zpFXMgrvqk6pnStvl+cYf7RvZYo7lTvOYt+vYafGwkHo7fJRf5Ucoy8YWoGUDjgwEshlYowSXFPSGV+YqOORKVwMLhir1xO7yOki3wo+E5fvbIHMTMDMlpg9dqLRl+m989DfYdrzVUcTjGtPJJdiXF2+EksAX3Tsp5Y5XYJJCcP4CFHu4tiKf/0Zqq2zeTM+B2HLvdEyNH3GjjIDKifDhORyU0rz9xTRTxyNROQL0+MVyCUolW/uHaST5yBL0XCWNiebWLSheEEgK67OAFw9gxZX7cBC3F9LrmG4ytVnfpeN55YBRJtnR+OwDy3oh6+i+A0P9qiKgvnW0S6SY6wXKEWnk5L500ul9KA4ivai7cFzfsMd8D2bLTaf3gxmGg7cm7cxBkTme/n0BlxD6BlWqzfUri4r3tCF1N5Crxq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(122000001)(38100700002)(82960400001)(6506007)(83380400001)(9686003)(186003)(55016003)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(52536014)(38070700005)(33656002)(71200400001)(76116006)(478600001)(7696005)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(110136005)(54906003)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MyTyMpKU6gumzhbRVMOVL76zMvMNMFt+Tzo7Y5/Uy0FoMThjQrddaLgmbhto?=
 =?us-ascii?Q?Q16PGHfbeJzBeVrpXMZ/jA1stTnN/60mWiawK83KCWUNQSZqefr/L2EDing5?=
 =?us-ascii?Q?Fj5j/WrkXP7ZzvkrGBRb9A0GxOZ/G7FJXi6O2qNO1LXoh4SBCgB05pm5/mFh?=
 =?us-ascii?Q?HPI/ocndlFXFP6o1Fgf385gZahgnDR/0mFLRAWk1A7ZSLhtGnWjvuQjuTCGi?=
 =?us-ascii?Q?EfN5FvaztmAKkybegHl+01JAfjkGd63rgrj6H5PcTCsPOgQ9v5Z4YWwEwqF9?=
 =?us-ascii?Q?ebCiQ67fVA+KggNwivhwVlpRSPedYAKa+zkkgGreZVhH9/3kZBtZRU5fFZau?=
 =?us-ascii?Q?CR1rM6J9hq81/C/egPVKOanDiwRc8JMvnbOD/X3Vfz5BlSY47P27nu+Pnya8?=
 =?us-ascii?Q?q59BWgJZj7NOGuYWU4A4Y/M0U1tyd23kKBcPKqnSHiNeLAPpX1W7GLL1Sea3?=
 =?us-ascii?Q?dr+z+B/2OH+61k1VaqMpg0ydy41fx+99cNXKAv1ajJ64cBK2Z6SvJhb/zMdy?=
 =?us-ascii?Q?gxGozMNGC6FhbnLUAdtJcwZ+BE7mrOzMX7Qsn38/e041zL8xCV6+EKM2dp5L?=
 =?us-ascii?Q?ZOLfK+PRfWHWZJbJWjqAuG8ltstfgwnNw11hT92xx4P6OV4kjTAq0ysjm2lj?=
 =?us-ascii?Q?MKfwZegdF5CN0ZWSiCZMu8AU1qDqqxHCwT1POrI2a7zgOltk854d6L+6Lo96?=
 =?us-ascii?Q?wquqnGoaEWJ785dRQD8pWsfOEAkqx9CCE8melkEaKtAYUB95gURPCRjglzZU?=
 =?us-ascii?Q?LsO5DHd6iE5VPGcUZvjRLo/68AVtarArKMw4LqlQ3pCjNqO2Vv0Cpy+mnyTr?=
 =?us-ascii?Q?RUgAZ8d3FKWfNL62Wt/Z7Mxl2LMhOWmVCKPJmYqvpfdbzzqEqVdpv8QfI80p?=
 =?us-ascii?Q?Xxz1f+94fQMu2O+4gVwe+FTr/zdYvyDszmK2N4xguiBE72B+W/qd1ZYM8qKR?=
 =?us-ascii?Q?7LVclK4F9rqZJxbwNufiKr39+HC/ueqPU8gJSnC8A+KSBuxHe9W2ki0UdX8J?=
 =?us-ascii?Q?wW3pT6asXqM54hKrHtNMEWAjNHPAOTZf9Q/TmoEG69j713Tnt4u/cXUu1E6u?=
 =?us-ascii?Q?9dUlHrGVsT8WHyHR2Hwm8fCTie91hePhvMBF1k7x+J9bsLx/eF6pIBpSaX/i?=
 =?us-ascii?Q?QCbdJ3nIkGnNUd5znfZPgtNFIA67R44YYT8S9HUO9WCG0zNmHB7ZVzjOeqRq?=
 =?us-ascii?Q?bNwKdwiQ9zpuUmj4rMo/LA/j5nbPp7Ie99QreaVyXABnQ/aIH0t60onKwKIx?=
 =?us-ascii?Q?LRmIklW6Y1kzR+6hW1xD39I54eRDHF0kfDgte+QKNYkRTuQh+ehTe0mLqriT?=
 =?us-ascii?Q?0qYTAvYINr8okzy5uN5QBIEaIbs/SoYjixT9AXgnvL9RtG2+0jhk40QLNRLe?=
 =?us-ascii?Q?IIWVvjLKYPXWVwRYslGQUQpwHKbPL2vmzClVqZbx5CROGs6IkeA2nSm2M1w1?=
 =?us-ascii?Q?Kg80+fy1ukv4in+NBU73zWuNwXh7Bh8YTPLuaOcrKKCRvZ070iLF/iZW1gio?=
 =?us-ascii?Q?mHc6dsYL/6R619KBVFAPi0MOhbdTgMSxJ+AhCI0tkEuyKozc/AAN7xBz+Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0b899f-857a-4790-b5f6-08db722673d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 07:09:28.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFGwL6isqCGhXZLvBOepQxyoim5pOWLPS6tDriduTzazV2lJs9qGGI3km3BZqk2p775fbbBwXdalMKrFa9ilHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, June 21, 2023 2:02 PM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 20, 2023 8:47 PM
> >
> > On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> > > I wonder whether we have argued passed each other.
> > >
> > > This series adds reserved regions to S2. I challenged the necessity a=
s
> > > S2 is not directly accessed by the device.
> > >
> > > Then you replied that doing so still made sense to support identity
> > > S1.
> >
> > I think I said/ment if we attach the "s2" iommu domain as a direct
> > attach for identity - eg at boot time, then the IOAS must gain the
> > reserved regions. This is our normal protocol.
> >
> > But when we use the "s2" iommu domain as an actual nested S2 then we
> > don't gain reserved regions.
>=20
> Then we're aligned.
>=20
> Yi/Nicolin, please update this series to not automatically add reserved
> regions to S2 in the nesting configuration.

Got it.

> It also implies that the user cannot rely on IOAS_IOVA_RANGES to
> learn reserved regions for arranging addresses in S1.
>=20
> Then we also need a new ioctl to report reserved regions per dev_id.

Shall we add it now? I suppose yes.

> >
> > > Intel VT-d supports 4 configurations:
> > >   - passthrough (i.e. identity mapped)
> > >   - S1 only
> > >   - S2 only
> > >   - nested
> > >
> > > 'S2 only' is used when vIOMMU is configured in passthrough.
> >
> > S2 only is modeled as attaching an S2 format iommu domain to the RID,
> > and when this is done the IOAS should gain the reserved regions
> > because it is no different behavior than attaching any other iommu
> > domain to a RID.
> >
> > When the S2 is replaced with a S1 nest then the IOAS should loose
> > those reserved regions since it is no longer attached to a RID.
>=20
> yes

Makes sense.

Regards,
Yi Liu

>=20
> >
> > > My understanding of ARM SMMU is that from host p.o.v. the CD is the
> > > S1 in the nested configuration. 'identity' is one configuration in th=
e CD
> > > then it's in the business of nesting.
> >
> > I think it is the same. A CD doesn't come into the picture until the
> > guest installs a CD pointing STE. Until that time the S2 is being used
> > as identity.
> >
> > It sounds like the same basic flow.
>=20
> After a CD table is installed in a STE I assume the SMMU still allows to
> configure an individual CD entry as identity? e.g. while vSVA is enabled
> on a device the guest can continue to keep CD#0 as identity when the
> default domain of the device is set as 'passthrough'. In this case the
> IOAS still needs to gain reserved regions even though S2 is not directly
> attached from host p.o.v.
>=20
> >
> > > My preference was that ALLOC_HWPT allows vIOMMU to opt whether
> > > reserved regions of dev_id should be added to the IOAS of the parent
> > > S2 hwpt.
> >
> > Having an API to explicitly load reserved regions of a specific device
> > to an IOAS makes some sense to me.
> >
> > Jason
