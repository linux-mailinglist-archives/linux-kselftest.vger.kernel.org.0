Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3473D7DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZGna (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZGn3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 02:43:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82BE53;
        Sun, 25 Jun 2023 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687761806; x=1719297806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llVZvcSu3tqguw5Yxc1rqOJytFA34U+GWnY++NIFpvg=;
  b=nX10yf+DzSbb9F2I3AcSEDlenCpGyiJpKS2oVzMMsiPkgRT/XjzJcl4k
   nNxHOAUpy1fIOXVvN1rLCyQ2r+MkijJuoBQUMamYgU9bJKJxFQE86RuBt
   rjasq2nVFepamgStqrBzOT5mPgyUSS4rQeAknHee9Gue34/sCF6U6aSTL
   BHsr5UkxxSPLyQvA1m4CWPxALl0E1+hk7rBEnCVdTOv3tCAsfLtwTBjKC
   a8VbZnFMnZwPYSVAecf+4q6p6A9hDcqARJ/52dNfRAKEG7/DD1zNTWGF8
   WpmkKLm+/bJU/NzXFx6bSu30xdGGH2Uo22Wk5ld0wtzQQZaJLibtkKGre
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="361230887"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="361230887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 23:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="666183198"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="666183198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2023 23:43:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 23:43:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 23:43:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 23:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfFAzUUIhugbEOCMtK6mY9Dq148AN7lhDwm2wyKdqO9zxhAwwDvwv39Z2N2fhRJy7H60GxZ+87hHuTJNcEW+y5lrnq3rlKndkUwvYjel2TzG0untLyQTwxGZm+SokZL8toewqNadAAqfDS6WdqvnYzQ8w2irHyQaaeptfMFHLdJxb9Qfg97u+O5gcHyR0R3O4BCMcAVpcO1ZJkTSjcc6CVlMislbqXab5bz/xPLaLZB4EQoAg3dcjrw8VqtbTTFbCBBwiYlQ+m3SaRFDTBL/j8AXpiSZY7xN2dy79wRsaMHUIRLGKWlKY5RPNd7N775E4CwsPHzu0xVkk70UR/BkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llVZvcSu3tqguw5Yxc1rqOJytFA34U+GWnY++NIFpvg=;
 b=ExLXJvaLrynZXZuQXEqmuMS0w1zEhVQcJuOpJM9Tb3lFreujeBaDsA2jwgNOwluMYruLbVk/RiKIS9qo0oxC2O50H2iL4KWeVNMCKr3B2Lq3lSXwWWxzcWwb1eHuxzszv8xZ+xViY+MlDQ2GbFTy1wu6RSWznrgqHKWNQdOYTMRSru9fNf5hnY+mVz01YSGf9bt7A4O3leADivYB5ahqO+l9PBVf1IyTnQCuUZaX746hbIS1MWnS4TjiVSy1UwZqxhOPnHbK8Qujp2AlzX8bokLA17d3fLws4TieIZ/csiqu0cMHYKe4rSMmkCV0irBJBSbi7g3p/8RKYdCs6echMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 06:42:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 06:42:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAIAAzEsAgAcosiA=
Date:   Mon, 26 Jun 2023 06:42:58 +0000
Message-ID: <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
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
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
In-Reply-To: <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5385:EE_
x-ms-office365-filtering-correlation-id: a3362790-0987-458d-f254-08db76109476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Z5ZOTp9pOpdnKV9cJaRiua25HQfoJqta/lRk/PQnUDOb/gk6Vv40xMrzeaT2qYTwTS4YnErqBnyhT5Xrxb4mHQnZd+U/37y51dzdCdrUcGFYnf8Rt092FVjQ5WijixoKSUnb85kjkaUm7jbiUz2wZkCiiVlMgMxpINIIgpPHjH7i3Nd1rAcnPw39evhcnioGAGMh+bi4GeeSVjSiyRjRZpBFCMiAZhslOJzus+UC7UpgU6X7cj38NKpc6o3ff5U8gfAZFS6hW2E0GSu9W0glGOnabZqVKtVB2SYd4ttM7DTKn0XkC7ifqJ6vqK0j65uj6v4bEjfrUMgEsPHzZEVIKcNcRwNQ6x2iSOhslPXafICGRavaaPmYAiYe6OjYt/ao6YyJ1rNkeyFfl/nVjO/znzEYqyQIxegmRj1hjcyneMtsQrqubkpAsh0xms4E9kIGoeiT7GKOwkm1RtnnmERdgibPOaS4Mrh77Q44Z0ejhNWurLWeLE568kR6XIWJKwKEiJ0EYw0DCTdjiTmxrlN30cbryBq4/7R63goeRPdaTOs0L1KIgp7gULPZTDiSwuXaen0CxZGfliR4VTf+92/LUWzRPROhUB9BaojaS+sNBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(33656002)(5660300002)(52536014)(7416002)(6916009)(86362001)(8936002)(8676002)(41300700001)(66556008)(64756008)(66476007)(38070700005)(76116006)(4326008)(38100700002)(122000001)(316002)(66946007)(55016003)(82960400001)(9686003)(6506007)(26005)(186003)(66446008)(2906002)(7696005)(71200400001)(54906003)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kC0lKjSV7xrWtLHQ7486I3jxSecWfqT99v48kUbggW+acKMLYvOD8fpQTWFF?=
 =?us-ascii?Q?EwcVbZ6hce6UDconuxqjkw0kZHkLwVHUMquNdVQNhvqBkg+MlZEWRyRLiKk1?=
 =?us-ascii?Q?UukHo7I6eP/pup8JAXztQkeobQFr7L/Ab2ru+lojz0Il2K4GbWzsfJTfXffN?=
 =?us-ascii?Q?9AS+1ZIgyXJwaFLtvSEffqKLL/aqpqxcGTfKjHbW6y13rmjZ2qm2yjuhUbl4?=
 =?us-ascii?Q?AMxHGdeXYaVcAzNUV7xiCcWffLVP95b09Za21QSQGlXEkEPvmnYsUq0cRfJM?=
 =?us-ascii?Q?NwLU4ytPuL9E9chWmepNfPJS9K9Y6d8g9XezZW1LoMscPXnhdag0an29erGO?=
 =?us-ascii?Q?Srgl8r03K/F4oNeRJ49IsCJBbbAH8IEWCPgJK8aNdw3bZ09DGu1GI8Q5AR9V?=
 =?us-ascii?Q?SMM5pQCOnf4p8SlaXMKD1f3VIvrMy4j1iXkTxgb5xikiHmcGGuqb3X2OiqR/?=
 =?us-ascii?Q?ZqMi442Xg4zNzc/uWxit/VqwqAKlrkKNIjJfSsF1WJ77Ws3TBH7TE1bz0ukH?=
 =?us-ascii?Q?Sfrqk5A4gFQv9gz+hAqqDJRfZR6yDU1aFRWjs3iWWCe0AojNGImT7gfwEU4c?=
 =?us-ascii?Q?Jbh+QARKfTSagcQ8dXyFDBdBe7HdGH03PKoPAyYIH0cBLxxYP92dVOzZaeq5?=
 =?us-ascii?Q?qH1LHOWsENdHKWjbpbdW+6jep5wAMyi7iHU28jPKfnkCKGd9AcEHgx4gbDRb?=
 =?us-ascii?Q?0yg9xRFXVzxdWavox909kTI78Ji9YCPGE3uFghh6rEtFbVyLDcixaedEzQ6g?=
 =?us-ascii?Q?aYnZwn4se6oH+y6A+LgNybbtMdxwlG/2f11IDhWb4VI3Q+54YqBhXNZVRvav?=
 =?us-ascii?Q?jPiHLNCdoxSS8UmdGIpKeWjeFYm/iapan9I+Cj9Pqy25KPB8DB/l0RJVqkxl?=
 =?us-ascii?Q?ttbOaPvxxS9v82FCuW73cKbok04lUuRJJLEE2Qcp7wHCAxlEpa0DZso6zIfi?=
 =?us-ascii?Q?MVfiX/MvwHB0bcBCrNtaLoJkrO1nZJcOkVLtFKJkhz6bPygHz27wcsiYzVEi?=
 =?us-ascii?Q?eig+e4aYT1bk004A6iIEwc0hjOaAt3gzZ/iZiYsDsYsweY++126zile0uHtE?=
 =?us-ascii?Q?VcVhLdeGhtjPzGodJh0SxWVVfAuULva3tfFj1HhrqncN8fREH6Dfwemqcm/O?=
 =?us-ascii?Q?ZzGwEW3V/PqNYEXJG6ePdUmCnZXFR60UNMNbsvOt8WJAh8P2P2/Iu/nrMIST?=
 =?us-ascii?Q?jj7dYAJilhn/bktIM5cenkvLvh9b23o97H18E6BVL8J+go9dSrQuorIv03Qd?=
 =?us-ascii?Q?CP1a0pSPftW39r3BsucpuEfZpp55gUL8NYbgO3Q6lvbOz2mMadPZQt1YGaZ4?=
 =?us-ascii?Q?wqq2FQFiWEwGbc44tt8021PSFqWIMOa9YdTIaSfOC0ty/a9RwEU40ghxcrXF?=
 =?us-ascii?Q?YF0dqPH9Tz0FUnGh1U8yH00KGoIDjz9VRRFAI2we8iQcz5eOaFblGz6xL+J7?=
 =?us-ascii?Q?JHV6NbLKlu7lyDPKqnJJ52VHG34Y6IChos5+peZAJqzln8RtdZKe9g5P+aLv?=
 =?us-ascii?Q?U/s8zIIp16NLunjrIwKaWTmLPDdVzZx08uArzTUTK5c1UrEzLFgfZktUeToL?=
 =?us-ascii?Q?QSaaRfgRzAk4aH4NXQvkSqFiMKJNPSzG/ecJ4QUf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3362790-0987-458d-f254-08db76109476
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 06:42:58.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpgOrJtKbUHExwoOxY7jo3aGA2niqrqXeX55PJ3PxTLDIwq0Gx1um1ADdwQdFvQ+G+qP+U4Cy/lHnLIzCfZr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
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
> Sent: Thursday, June 22, 2023 1:13 AM
>=20
> On Wed, Jun 21, 2023 at 06:02:21AM +0000, Tian, Kevin wrote:
>=20
> > > On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> > > > I wonder whether we have argued passed each other.
> > > >
> > > > This series adds reserved regions to S2. I challenged the necessity=
 as
> > > > S2 is not directly accessed by the device.
> > > >
> > > > Then you replied that doing so still made sense to support identity
> > > > S1.
> > >
> > > I think I said/ment if we attach the "s2" iommu domain as a direct
> > > attach for identity - eg at boot time, then the IOAS must gain the
> > > reserved regions. This is our normal protocol.
> > >
> > > But when we use the "s2" iommu domain as an actual nested S2 then we
> > > don't gain reserved regions.
> >
> > Then we're aligned.
> >
> > Yi/Nicolin, please update this series to not automatically add reserved
> > regions to S2 in the nesting configuration.
>=20
> I'm a bit late for the conversation here. Yet, how about the
> IOMMU_RESV_SW_MSI on ARM in the nesting configuration? We'd
> still call iommufd_group_setup_msi() on the S2 HWPT, despite
> attaching the device to a nested S1 HWPT right?

Yes, based on current design of ARM nesting.

But please special case it instead of pretending that all reserved regions
are added to IOAS which is wrong in concept based on the discussion.

>=20
> > It also implies that the user cannot rely on IOAS_IOVA_RANGES to
> > learn reserved regions for arranging addresses in S1.
> >
> > Then we also need a new ioctl to report reserved regions per dev_id.
>=20
> So, in a nesting configuration, QEMU would poll a device's S2
> MSI region (i.e. IOMMU_RESV_SW_MSI) to prevent conflict?
>=20

Qemu needs to know all the reserved regions of the device and skip
them when arranging S1 layout.

I'm not sure whether the MSI region needs a special MSI type or
just a general RESV_DIRECT type for 1:1 mapping, though.
