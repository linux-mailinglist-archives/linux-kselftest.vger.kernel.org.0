Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC48673F428
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjF0GCU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF0GCT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 02:02:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF961BEB;
        Mon, 26 Jun 2023 23:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687845738; x=1719381738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x/4lPV3K4hJ5VO9Gx6JlS47RTQ3OjwSlfTpMPxR1cVQ=;
  b=NwYlVCljxMtEEh9B9EyVOATEGoD/h+kvuxqsho5FipkDTtuHdEJZ//1E
   rKL46wOiaXs7MeUWWRmrsFnQmpVVwOS0xlPCPdl9mCCgPShDEYVcMvqHp
   BQvlsLUceUeAx9Q0Tb0JnoGTw2KYqNKYus0UeRqT4xqXKA4PEV3FubvWS
   GcClvEjbCQsOVChZWfv1nuFr03ENWgd5Aj+lhPyGUwxnbReLkcpjOHCZB
   w4kP0SpkzlhFEQ48ccq9RoIRHb8oLBP/Xbg7rcY/vyBvgYmrc6bCFCNE8
   n1yLw0e26ipE8VcR0jum3RLLIZH/4A9Rrb1CXQRiwtI2dwVHw9/me8+bU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360349264"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360349264"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="963046183"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="963046183"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2023 23:02:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 23:02:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 23:02:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 26 Jun 2023 23:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyMwxKjxfN5KL014MTT6ywX62S3eEa2w9Tg+Mx9P9Ys94STC1zqdZZdokTrqpNrnpSYvdEL+nqqJ5XUJrowZaNAb8RVFbqL6eTCmbbx2DW10aVrUesSvvtwKI3eJTu7yoRL5euj7r0zTgeukx9IUEvvvs7plq0kCDXPPLzOxet0VMBdV91cXiWG2hloM2J1+AaCB3CEVx3qMnzRPvLjl8PknPVYXfQYEMdUPTYGdiAO/1Na9T/HPhoS7XawzoGtp2Pe/dxlawL3fiPsW9MU5ggO/Ddm2GH6xMZUS9BLxlptEtSp8iFkjvC9c74KlL6oPJtRpwJOhFS8u6m8zOxSBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4lPV3K4hJ5VO9Gx6JlS47RTQ3OjwSlfTpMPxR1cVQ=;
 b=kFWoLYYW283t+3rGTPY2fZAQFc/rzLlhBfNw0q5QYanVPlWl3hpceGuC0n4AjrbuGmTvx73jQ1TrUG3SJFxn9c7mOpENc/nXF4Y9iG2vvu/ZJNQsk6g7togp81+BbLsxTf4Psghwk84RIQ4NgH5KM/IzFX0yUrwuxaF+YiQ6KxkPy5MKcxzQAnFF14a9r6KJhCEQsMxHdt/GAVe+PG3IEPmn/7/RiRUaURc9bHSzvd9CPbK/CfZFXIbE9BRDFhgisO/erelGhv2PYtCN2tY4p+r8Q+Vuh0H65XjDrr6A3Lhosv7uwVYYXvpaZ1jqyjQ44vzO2YU6xbM2l8sB32eyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 06:02:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 06:02:14 +0000
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
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAIAAzEsAgAcosiCAALdQAIAAz7YQ
Date:   Tue, 27 Jun 2023 06:02:13 +0000
Message-ID: <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
In-Reply-To: <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6444:EE_
x-ms-office365-filtering-correlation-id: 4baa2211-b1a9-4198-4bd7-08db76d40ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToZasCAcGcnFRCi1aQgVhfPuprNq/vNdR0vl/Tj1VaA5jEWXJIQJ5aB6z2FJ6XdPw+VPMxsy8XSCqP/GgmxnToV5uWABfyttaVSNF52VGRxlNaiVIS4n7dHjS+mqDWBN/2vBSqUVWExP2/0WF5fWy/cMUTeLjTk1c2QSLr0F/AiWhYflUXUUmawgbW+meAp7RZb0I8hDr3vkkSecTLA7CXJZH1HNUt8QNuCAaamLoD1CdFCLti9Mqvn1BdIXCvbAWBSGmDnVR29Ye8jGdGAQMdu2gSBDaI5SoKcJcWc4TP7kr1B4rUFOibrHgFRDWKkJD15qx+j6osCwt0LpipMabGtQLdte4xru/Yh0oUS47uodMrvLQQNHaLxmkWTpE4bkHO89dYS258We2AifpmUHeMnqQJfpIGOm3V+ATyWLoKptln7A26ftjHLroLL2GVTqTuFtIdfm9U4rmotR6eUFExekmQS3D6bfUBTDi/2z6Oy96Psj/X9BXC7M0CnDqReUh+F6DLKxSi6iCe/l9vp91DIm3Lg1tYv81vDYjAtgdId+Z8lYv1owmXmIE70djCs35rxGr3t+wnkVqpxykPrwCQTLGEDEMhF9HpECIaLjt8TDWvusYrE7jGROVxkz5QTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(2906002)(4744005)(7696005)(82960400001)(71200400001)(122000001)(38100700002)(9686003)(186003)(26005)(86362001)(38070700005)(55016003)(54906003)(41300700001)(478600001)(76116006)(64756008)(66556008)(66476007)(6916009)(316002)(66946007)(33656002)(4326008)(66446008)(6506007)(7416002)(5660300002)(52536014)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wi4/3NLLUSz5UredApyr5beifFuJBkV7rx0Er8IKeCWB7FmLkcQyZiR4aSH8?=
 =?us-ascii?Q?KKlS2qijnSjnNZwfwyBvBJukfodfSCAkpV3Lq6ermtRIIrme+guKe4oDT3RV?=
 =?us-ascii?Q?MoKAmk6FdMUWIxQXUY9MCW4/QI6RAe/6h04tt+WGDGv50Q0JQn3rcOmdjShM?=
 =?us-ascii?Q?aV7O8fGYZwlvTsZ4VM/Dfuo91fyVusDUxvaxWAFGGxfz9FnlmBDxFvOTUnOn?=
 =?us-ascii?Q?Fz0lpkAmgHarFOT7K+XEGioEYX6wStIxLcoSTXg255ylV3He2SZhBV6zZMKr?=
 =?us-ascii?Q?W1onBBCGK6/7BinLMpTWdVilP34KvSN+LyDH0qxPs8HCXLIZVzvkRHnxTIZ1?=
 =?us-ascii?Q?Vdw25GidIz7oaE7jEJAJWxdFOmeT3u12Dd0kGpCKASlaOyrl4yUQRTioVMkH?=
 =?us-ascii?Q?YSo3zSIelTplJSprZuSPQjofpDJdEI9tMy7Ca+RBo5KwEfp0YKp88JHse1zt?=
 =?us-ascii?Q?bBgeGG5TkMov/bImp6D/kWxX3kN/v8o5Opy1VV5GGMpjny7e9xg1s+56Z08s?=
 =?us-ascii?Q?uwPXrZp0iV6EoRzmxzpUEBxaziHilDkFvUzb6wveDqBEQAHFDiucJwzCG1ie?=
 =?us-ascii?Q?7yR/p01TcczbJm1vccZTEJ6RckQ9xl2dnVexrC01wXk3LWtw9DDj80ilOUv8?=
 =?us-ascii?Q?/t+tYl7scs31tc2HpPdwNtmcYaauCroxRD8XflA+sbQ5YgPOb73ZNtow7mPu?=
 =?us-ascii?Q?I6NPtPOltfDuDcrFXOXCaKGbJuvQsjHdahdhELw1B1rVhoYVRHW37HTynFTQ?=
 =?us-ascii?Q?NnqEGwZ/Dqq5O4MC43SFY990tZs3k/fanoftbfX1wowhnchh4px/9RuFYFuT?=
 =?us-ascii?Q?SiB5JAkBWd/PqRRJXLZMvf7PuDUnwZEi6DJw1DCPXBji7qCVDJEDugKX75d4?=
 =?us-ascii?Q?0unUeegP97xFrOOerS3MUcZJFzdYCukgf96JGHCiph3OyRTee1VT9EtMA4z3?=
 =?us-ascii?Q?9blK7LmSUavw/Q8TIEs97pQt7SKCvXRVI6vLujOuUH3GgSd6yvLkGc1MIgE8?=
 =?us-ascii?Q?3+h7uALDuKF/I+MWBhnNR+v8EP4/eUpimxvdl3SHptTrIh7qRclg7eKXllje?=
 =?us-ascii?Q?d58Q8edhUQghEa95AtAOke8ghpx8aKrH7nTAj/pLsCmV0jrAMp1qfzNLv++0?=
 =?us-ascii?Q?1jnByL86v/hBbh36IXe8gv6VZK8aK0TpLIAHir8T+sdGvV6u0jEnF4ptUY9d?=
 =?us-ascii?Q?zozQs6DgaDR+oCF1dBaGqyIUkyBwHqtQgsmOrsK8S8kQc2H0ZKixAL3znvgg?=
 =?us-ascii?Q?/7+k9mFqjtX0+IFb8f+kncbLlUALs2o5NiZm1LVsmAHlA+ZjrthcxjUIk+45?=
 =?us-ascii?Q?DPT9yBOntpEEKPHwWjgKNDuCATMXI2xDkOjLeuy3f5ZGepYc5gQRouO6CxFS?=
 =?us-ascii?Q?0B4VhpE+439eqf07uHJe7ko35tnQb1kw6R1spmeeFpLZVPqKfd/Hgt0ea4b+?=
 =?us-ascii?Q?XByoP7f2Yspem2HVF5AoGL+aUdVAkJZjAssmUex4TuPPJv3oWAqOmapTim/G?=
 =?us-ascii?Q?f0kKPsqpJYRS2nZkfLYQGNeIEQaTrr88m08I7qMRhMqWbVbwutNWr/ghvpa/?=
 =?us-ascii?Q?+XIijM6/LUbB8rSwGu59C34KlSkDhfP2MfnXhxVc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baa2211-b1a9-4198-4bd7-08db76d40ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 06:02:14.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZTVWlZPHOuh6Dd48HdBjkznCWU2fL063BZjSooJUTKlvH4Srj4YMFesvLcsUP0lm47Xc9a/VAM4GqUxjlIztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 27, 2023 1:29 AM
>=20
> > I'm not sure whether the MSI region needs a special MSI type or
> > just a general RESV_DIRECT type for 1:1 mapping, though.
>=20
> I don't quite get this part. Isn't MSI having IOMMU_RESV_MSI
> and IOMMU_RESV_SW_MSI? Or does it juset mean we should report
> the iommu_resv_type along with reserved regions in new ioctl?
>=20

Currently those are iommu internal types. When defining the new
ioctl we need think about what are necessary presenting to the user.

Probably just a list of reserved regions plus a flag to mark which
one is SW_MSI? Except SW_MSI all other reserved region types
just need the user to reserve them w/o knowing more detail.
