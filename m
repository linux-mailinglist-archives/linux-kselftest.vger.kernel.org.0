Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6677408A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjF1Crf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 22:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjF1CrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 22:47:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7F2D7E;
        Tue, 27 Jun 2023 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687920429; x=1719456429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CysqMp8fxbpSEpwP60ZuinsTcIDEWVjPwHMT6Z9z8Mw=;
  b=dUVGn4/t1X9QNORMW9vai43hcrnrimjsVznWfyJ56kOVA37iaFFNWI8a
   tcScOtQO+eN+9NhLo/iwPZMBmjE+IsIbYUfhV4tky7PWfno9rgAU+UgHU
   tYQwy684/S4CWJM4lIIEEVMxidmWdoKFszpF4xuJPP18pkAE6UzJb+LA+
   unH046Egk8TrtTev3WEo6jNDNKviHtjwaQxIKLycOCDgLwsuc/iE9Jb8w
   wYPkZ/JzVQErdI4np5b3xhMhl8rwhlL3f1vu++07JJNv45GDLmSxRXzj3
   Q+ANmAkpNYf7PHyBvvG+6RQeFldDhio5H5iL8KZ0AR+v0UzTSwHKHMDVW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427739457"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="427739457"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694116188"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="694116188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 19:47:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:47:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:47:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:47:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 19:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPgcxZ9WsqKvF4um+UCIc23iLvii60OcR9i9zLQHo4GdV/3AyrYV9a/YXKN0LWEu7mqERbvKXCSUZGzRpzEylOtafUcdAKiSaec3afreSnhdfpekQtQWNXxHxRw93x1UWO94xuqcqyHB6bCkKCE57L9pmY6WQPKQVmuz/qkRVpNtLZa8/4ly7fSr7Z/KuQ2nB5A+XPpaDapo1YYJLoX4KaL5PkaVlxZvRq6RYbVUyF7MWEbfjNpvI6P/wBi7aTeUs4Cod6MbDC+u75gF0UOwBAIHlP/Sa4nDvED9sAS+3xj2RxMbFarHDSvPhSAq/xpEyA8PB4VKFgHHe4+MkWD9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CysqMp8fxbpSEpwP60ZuinsTcIDEWVjPwHMT6Z9z8Mw=;
 b=XQrzURmeWIdGUoT+12msjB9Bz6RWEVVQtAR7nNyDcc7ctezNMUykgZ8F+A3sp8/2HCKkRukVPKoYwUMsP2X0UJI5mNKTejjnotOvNj+O34coU6zxrgKi8bTs+4Eh0chNGWl3zfDx48B5WxbWs0Gh5l84k98tNL7LiFy4ybxp73p+/k3PXe4ZoSCgQQzrcZeYKE0tVIMFdqn3b8tdtWyHvdwD0r/4MxkxdxA0x+nB98Vg0yUMsQnP4BWtkkcWvCNkrJIcszSRty+I2h6QJMAwVrZtTfnK6sXRGfEvnhyvTOmI68CD0tkhhCMJSD85PFWiUwqMXkM8LbeESAdI6MYITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8580.namprd11.prod.outlook.com (2603:10b6:408:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:47:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:47:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAIAAzEsAgAcosiCAALdQAIAAz7YQgACqJwCAALFKoA==
Date:   Wed, 28 Jun 2023 02:47:02 +0000
Message-ID: <BN9PR11MB5276BA9BBAFB8BCC8B339AFA8C24A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
 <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJsH1NtUJIDfUthO@nvidia.com>
In-Reply-To: <ZJsH1NtUJIDfUthO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8580:EE_
x-ms-office365-filtering-correlation-id: 58264a60-c3a7-49d3-9d05-08db7781f37c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CeCLGGx6ci23zK4PMM8QHsUxPclsFVvJvawxzHCM9juKtDURKwrz7hMr9SDV5CPi8PAStYoFObVk5byJR/EGouUAVS1ZFcjSqn8Plu0fDQiiH070QNsrPk9fbkTksfYhzEBWji1AsLLebw+4ZAJ3zVeS65xGArt3IU24B5Unj5OK6cFZZdfDIfC3xqpmpA5fK0mviprjq7hbTF7aBLNSKDKpqxgd1YnMGElN0xES4y6vv6MhxNyaj33uPwEP1M75Jff0XxOESBkiXkgMPxsF0JZ2/vd8r06SwUOUKlqt7YXaqG+npoyjYXMbhzQXlom3b7xjXMoaUD9yIxRT8gElkK+EV0cuua070o43JNXGqSam6GXQ59VCLYgpb6MTlAMq4+H6nNObJoKPy/4d6xHA8xAEr/gWw6X2VHBHHFh8s+QkO78DT2TRkcehUXY5BcOusdngWNtTBTtecJi6ZrM73E5ui5S5K2n0JUspH6rEJ+9tAg4dTtN1QrobqcIrBy3+zYE1z57SLLMGw+PerUWGro8uzawICF/5krw5Os6Xw+SfNXGHcWG9GppophXwcrTqTesG5q29eNKWg+RVD6IREMBl9dlWdQ1InHk3aP5TM1OLWiIbH7VAyuJKXARlP5I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(66446008)(38070700005)(26005)(66556008)(66476007)(33656002)(122000001)(6916009)(5660300002)(52536014)(7416002)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(82960400001)(66946007)(76116006)(55016003)(64756008)(38100700002)(6506007)(9686003)(186003)(2906002)(71200400001)(54906003)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ccDwBOUDaLKhub9BzuRLS9aruxfzkhVsygtSELqBhD7KuV7kb5tEJWtjPla/?=
 =?us-ascii?Q?luRb2uJ/gYiT0ms5on9P4BqqZ9xKwWzmhPiavwbQL9UsfwbpfOtA9p7ADant?=
 =?us-ascii?Q?0Eh6ej/EkokTDEg1BpHOHI0I5rQTQuiIO4pR8k3uBJ4mT+baScTPvjFReiu+?=
 =?us-ascii?Q?5Y5uF6Eg9ktnfbsaHQbVSb/rpG/YMZwLf1lc8kN8Hpo6w6gYpnpPK4ZzIdgo?=
 =?us-ascii?Q?9cpzszEE2DZuIN9Y+gmPNP7+yeR68xMZFxYBz3KMGdMnJEoXEh2DFOiGEaxf?=
 =?us-ascii?Q?NnKKB8UtP2onPQuC6qbQ/HjF/WbEnvWl45BRMhy6tZiH3ZjUE8M+4KfVrB3p?=
 =?us-ascii?Q?Zi5zu1GWX+Ki3CAhK08OlvdhxHpwvDPdv3sWFnh+RbC5LWNYgxHeGKLAJhjz?=
 =?us-ascii?Q?E38Yr7Vld4rL+QCRnELg3njxUHkb7t1H4omYNJOcqQ9TIcoPEcvPb4Icc/MZ?=
 =?us-ascii?Q?A9OKZdhDpsvaRt/vOa0KRoP8plxmb5iq2Rc8CEAlWAaybBGvCwUTwtOGAqlZ?=
 =?us-ascii?Q?BKqJPe3sQapw/vzLt8thY8NisuOtPZtK2tfng/2lf/6HjUI7ImmRWDKN3BT4?=
 =?us-ascii?Q?VLbsmamChiTSqPf6fTiujQGat5lcR52JsjiPcgbLOCWwokeLTkUvymzvkOy1?=
 =?us-ascii?Q?sGXPJKKNiFGOiDtrg0+EwuG9oVOtecE3fcYp5RjphTG3h8SFfjRTBfV3oy0n?=
 =?us-ascii?Q?5hzz9tANjiMICwGypIP+mH7SJiVsxJftLndMf/WvLireKlYZIRl2hC2B3iDR?=
 =?us-ascii?Q?rHsfluWKNujPRwQHPZpZ3wzoZsN/6kXf2560GzxZw4vN27BE0PZxlKH6V7gg?=
 =?us-ascii?Q?1m9x5lw8MWVcINiiBHJ3W3yJTYLgW3lee1S4dE80/frXeRGu9iQfilge/lDT?=
 =?us-ascii?Q?4zzUxRFN9jqYu9hv1qoab8wDZuhEYO6/1PQn9HNnd1obVf+0qlWKCri6f4M3?=
 =?us-ascii?Q?JHwu8RjB8Y+SlLc9KlUQnAbJWdQftvDEWm1HBn4uSSBl/Q92L2IGJhHgKU4v?=
 =?us-ascii?Q?227hVlNw0vtoUdIKttDS+rUwjhgkqZihj85OMn5fWfIVXBVjI6ZvcTK7ZHRM?=
 =?us-ascii?Q?dZzAsvGIAZnIKhUUHhtCsoOEBOqNyw4rIMJO2cffL+J+QuYwF3cg5Dw7eWgg?=
 =?us-ascii?Q?R3kJecfGrboUEqRKRKT6/OMyJBh1agznCkoJeXEXA9feiVpSCOcwAHjsqOgf?=
 =?us-ascii?Q?tybR7kAoO1ZrpqGF6GY4BLvyu/dp/JkvKPgEJZ73OtJw6ASPD5OcJek4R4i8?=
 =?us-ascii?Q?Ea4cD9xLzaqaahVr/PsOnIlSDithB7RqQrQXZ746iJD8fQYo3CMIINNE3Dcu?=
 =?us-ascii?Q?GJvqtzIEgutcQicY4VdKZ8hljht8NbPD7zGktJMFJZHryzVbgO1JqCnbLNOm?=
 =?us-ascii?Q?HMKtQszMOMpglKD46nYxipkC0TDss8sLxlFC4a646LX2inWJkPtG30BPsud9?=
 =?us-ascii?Q?/op8T9K2oMiFyFex2X2RYT0ceUKBcC8ix1AudWl2ggHD2bqtBPS+oaF7BEEb?=
 =?us-ascii?Q?mIEbFrmQ5ql+QX4h6tys/xIYqZK0OuOSMIUq5/VXDFbZtYvBp2uh+gXIBUda?=
 =?us-ascii?Q?B4YEopjFunjpILnp56UeKs/NR2qFmiBRTcUXQdY9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58264a60-c3a7-49d3-9d05-08db7781f37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:47:02.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Qe6KYpRWpWb8hPWErS5Qfgyjn5lIRb9WpvYQ4W/roOjmtNC0gYHzDwjceXIYREsaow9MM4wLAOuI3S5XcDxjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8580
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 28, 2023 12:01 AM
>=20
> On Tue, Jun 27, 2023 at 06:02:13AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, June 27, 2023 1:29 AM
> > >
> > > > I'm not sure whether the MSI region needs a special MSI type or
> > > > just a general RESV_DIRECT type for 1:1 mapping, though.
> > >
> > > I don't quite get this part. Isn't MSI having IOMMU_RESV_MSI
> > > and IOMMU_RESV_SW_MSI? Or does it juset mean we should report
> > > the iommu_resv_type along with reserved regions in new ioctl?
> > >
> >
> > Currently those are iommu internal types. When defining the new
> > ioctl we need think about what are necessary presenting to the user.
> >
> > Probably just a list of reserved regions plus a flag to mark which
> > one is SW_MSI? Except SW_MSI all other reserved region types
> > just need the user to reserve them w/o knowing more detail.
>=20
> I think I prefer the idea we just import the reserved regions from a
> devid and do not expose any of this detail to userspace.
>=20
> Kernel can make only the SW_MSI a mandatory cut out when the S2 is
> attached.
>=20

I'm confused.

The VMM needs to know reserved regions per dev_id and report them
to the guest.

And we have aligned on that reserved regions (except SW_MSI) should
not be automatically added to S2 in nesting case. Then the VMM cannot
rely on IOAS_IOVA_RANGES to identify the reserved regions.

So there needs a new interface for the user to discover reserved regions
per dev_id, within which the SW_MSI region should be marked out so
identity mapping can be installed properly for it in S1.

Did I misunderstand your point in previous discussion?
