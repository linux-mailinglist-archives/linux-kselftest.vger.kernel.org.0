Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC26973B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 02:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjBOBhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 20:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOBha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 20:37:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B12B60B;
        Tue, 14 Feb 2023 17:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425049; x=1707961049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7BhXrChjOUB00MgRbLRhVorwv1bG0dKf7+/gXeVE6cY=;
  b=WqZHZRl7Sf8A2JBnpy4RK3U5vsc84gCJwYp27owyoob+QojWjTrcq2bc
   damMcYy9P2GLQibdM5sdFOFTk4Ut8I+cmHNmRdjs7lgS0Xt8RH7NCKwOs
   Vn+FaZVVc77MMq9r/bZWiHClTgMVjy3ewB6rpgju8cSwHdt6a1aXhD5tC
   +UWscvLyF1dyUBkDpZJm4DEeQnKeb8NgecuFTu5hNjB8wR5pJ3kRyUJ2a
   QhQyF/q/kPwcdf5ftBgnpWi+MzKOKEwt9vjXvjdf/vayGBbh2nfpfsCl0
   lsEy17tuXRT2ybiLZ+eAiQ3VetbNM+7VEAwjjxNksFD6hJ8TaUPtIA8E1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="331324292"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="331324292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812247490"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="812247490"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2023 17:37:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:37:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:37:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:37:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haLY1qyS9E7zoCNHckrlRmgSS7WGGACrGpaQMFMlbPN1Q2jugREE9+e3cq9EJeiyJRQBoTFA+xG66N/hCU4WjwsEHEmZQz940ySA3SUCCohFPZ0yC1pfQdtVkm4RzdSsD37hWr3jMFhdYWNRzancVwdnI0ZF40OS7Gz6iHkIWmoEur70LdspHfmDXI2Ns8SP5ucwPDbbvdYtcvwc64OQSt/w9Ys5KTMe2lQeysTdpRIX0reG//4gv3kxC/05gmoFjb1AnxS8w+QhMJVrH5E8mEAyAZVsaIo0LwYFhyeTZbMCqWK4gFgnBvXACQsBxuHTm/x4ga1bGxpn5mDS/A7pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciqki2KwenMLD6J8Cph82MvaHwrLiqQ22FpG/3ngHqY=;
 b=aaGDO/YOwcubB/y/2jKhWzP7zG87ykypps8xzi/qoiyUwhihmjnGpTkk6AKIQvNvucOBvNVWxv+ZgIFI84u8yhIzpIRp67Wgaf981XA0ZgV9e0XtMx/aZ6OE6ZclGM14Qp77dNYUQlUaCzv1GsappysMIxm/SuWhJKsd//UohSBVOIp/5Mte4lYilpNRWeqeIdZsUZT2esCuM2mE6CTJ3/bbr6IvUE3ydF2Ca0XSnkOK5TbuHyM0c+9LVB9LlqW8sDd/PRlpBFsx4uTY5y159Of+cbqjzuj5N97UwzTC2Ih/1OPkd3FgJGrjNgwfKQ3AVQZwnPGiCvqjzrA2a48tcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:37:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:37:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIABdh8AgANLy2CAAFjcAIAAdaUAgAFQnACAAPZWYA==
Date:   Wed, 15 Feb 2023 01:37:19 +0000
Message-ID: <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia> <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
In-Reply-To: <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7459:EE_
x-ms-office365-filtering-correlation-id: 549d0300-130a-48b0-c592-08db0ef52dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AyjJBhYFuCu2ZJ4UWtQn868XLwqut3wubxUBm5I7WXglMIzuCZEseciutbxkCeCUEpX4senoeLOSDC+/Ozw3M0S8JRQ19L2cj3i9Hijzt9QSCNIAyIdgHHYs2GD5lmxXFxAlItCJVNyqu8hWgz0Q8TUieBF7wEzHtEJHRk8KIdUxsctvm0dseJQsXGKYkShhrO2VAsYoVwKlww59ohnIpsz28YJLFr/R54RfT5wb3sjc6my/V8aoB26wcgNgGKwWKfXykMFRQR3JpEq/VVH+71op7AC25/E0I1STkfLi8RxHh0s4h5SH1vPK8zRNPxtH1emlzbzwzCsJls8oe2Mqv04XhN6oy1pfk36ZcwPwoKdhItaKTFRrI9HfaP38R2ooYDBNMFS2JuUFP3Vlg8MYe5NJPb9eDXAtlNy7ZaWN/LkDbrZ4sx46wavKFShC7tnxV7asnns9qJiDjD6rMVw+he+s4Scyzk38a8zIx7cEv4pP9C4WmqVmgkuoLdwjfchBQcnE61O9AzIYVgsDZ+Xc5BhfsCqBsWJcbznWArmoAzJq5H2W7oAJMGWp0vPm+Br4cxFiFnaXjjC0GWsKXvb+OWdY7nt5ADZYKQd2LkVGQ2LO8NEtR3yvx6OpWElZGsTgRWXHW7WATkLIqMty24JsgnZ4X0n/fA7zsGuSXWAuCX2xJwSS2OL01Cjk2lZKe9vRdS3aMLvk+HxvbhHtYwE6Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(8936002)(6506007)(52536014)(41300700001)(5660300002)(4326008)(33656002)(38100700002)(82960400001)(66446008)(66946007)(64756008)(76116006)(66556008)(86362001)(8676002)(66476007)(478600001)(7416002)(38070700005)(55016003)(71200400001)(2906002)(122000001)(9686003)(316002)(110136005)(54906003)(7696005)(186003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oi9aiQUwtUTD4m9f9Fv+GXYAlveN7kL0iSet0sTy39A8J6cQyd9GiT5c8U1U?=
 =?us-ascii?Q?I4WgQOPsm+QZW0PZr/c8x1BYaFKKakxDPN8YYYpqy83NojNXa1fntlNmgCdy?=
 =?us-ascii?Q?k422kZDw7cQMm+xSyvIgiwACK9dZWYuS2SGw+4B5OpprrbR2JBEHZnS+nGKR?=
 =?us-ascii?Q?tZiIJs+6qhMaOPDrY28Q6baG63Z5/OB0ZUH2ynV4G/aHx2Z/2mX5M0bBj/2p?=
 =?us-ascii?Q?TFk++Br9xrDy6yE7hEqAD6cEotssfTQxrmz6x5Dw0wqcUjWY0rCKj56wcDlu?=
 =?us-ascii?Q?XpPp9o77dOf9JAydAmzY5Hm4SWD4ZbdjX+a6M5x6sGt1vWvkXlMMgbzo5jxY?=
 =?us-ascii?Q?Z+CM3GKzn6dex8du55g6tiy1HQnhkBiaRYBSoWUvNI4twDOrrRCkIePlu1tj?=
 =?us-ascii?Q?i/KSs7aM9y9H+wOT3UIox7ABXwIezfciUUSVoh8cGNUpizObhm1WewpN5NCX?=
 =?us-ascii?Q?nkWXSHCQTvYpsk2WeAmtT+y3j2rxhM4gX+I3aMLA/T6ppn7lu0Pft0a1fRti?=
 =?us-ascii?Q?VScJxacCRxuqPVYbLfguLLcmA9i9Flpir3EJxQhCEaaDr7EAE1QhkfVZPgGl?=
 =?us-ascii?Q?FoRtnL/3AEZpvSNYnao15tqeUDyER8bfZJ5A692Ro5GNf9AUCzlj7+U2LhkJ?=
 =?us-ascii?Q?Y1PJsYR/bWoEXoTCQlLqJEuTvjtOSJxIsm3KLLMB7Z7m0VVpMo9rDMqCWRQZ?=
 =?us-ascii?Q?8x0fJ+lxloVidoKgLvHcPicAlquEHKXMvQcRHUgqvaSObbbzFmho0B9FhliV?=
 =?us-ascii?Q?2njZOyZB0kvi5njt6kNo8bW5+aTXTtr5+A4NJIXH803bHayP36CgfRVP9yUE?=
 =?us-ascii?Q?a2e1letvyHssdC3sF2KgCV5NUh3cFCMNt729dcpYt9IpcMlvArHmTi3Bdldk?=
 =?us-ascii?Q?9jeLfuI2Csr6yck7FFLBg0v7I5bUrTQn2oxR5LW/yecKZpqpDPzr7LZHU1oE?=
 =?us-ascii?Q?AC9xBXitmcF6kwYj1ZrIoIbOj0SEzKOiyXa3EufIFMVNCQIEJvmhNp1+lyIE?=
 =?us-ascii?Q?rnINwbpsDQL5IkqYLi1ssOrUMZ73S0QL0mxvtqqcoDwQADfxVy4tnJ0JDsB9?=
 =?us-ascii?Q?cS3Y3CFCAwptjHuVePb8l2XVkIhp3mrohnzkWtEmeuOGmo0iEC62kmoz8Q5i?=
 =?us-ascii?Q?1/H1jVRx1qZgAqcmE4VX/1nNCZfuUFeLaScOBR9TaPv7sAwt3ktYDqdurw9F?=
 =?us-ascii?Q?JWWhn9dMLPLP3EH1rkss7UoT5+SGrrYhBPH6ILKmyXby8RzncYY6Na3XGZJP?=
 =?us-ascii?Q?1sLI8bPJDWjORojyCkiSEKLO9EYq3mrgn8zoEIy6kQ/0F+KDrsuwnw4R5OeU?=
 =?us-ascii?Q?vMPLOQnAMNzUz8CuPHNE0W/Y8sj28oXpjVn7t/Lip27onFX17APfwTkJK+/b?=
 =?us-ascii?Q?3ipiKGMlDm6SImCYOsboAklaPEqhOZ1PDIdeDwCSTD5Xlptt8DbMLIxvCvmX?=
 =?us-ascii?Q?wd5vYfGyM+DLTUBW3fd7t0lkC/VOKeiYXYdJSCK2+fw41vZkFav+yPqJ8fep?=
 =?us-ascii?Q?hzYSjBmOXpeBHwoHgyGC5Jq3R1qn++FmGSR/VquWnTukiUKQBvPT7vr/JXjb?=
 =?us-ascii?Q?Rf3sjH1T/vRLcWTZtW48K1QLveGJBOyhcD7mJlAS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549d0300-130a-48b0-c592-08db0ef52dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:37:19.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RN4yCimyKZC0ow59ra2gr9E4eL8xq9eE46ENEiDQEiJv/BscMFQ+Qp/uZbGuMFT97GLOBbNtitnbbIHGvVwF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, February 14, 2023 6:54 PM
>=20
> On Mon, Feb 13, 2023 at 10:49:34AM -0400, Jason Gunthorpe wrote:
> > On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:
> >
> > > What about point 1? If dev2 and dev3 are already replaced when
> > > doing iommu_group_replace_domain() on dev1, their idev objects
> > > still have the old hwpt/iopt until user space does another two
> > > IOCTLs on them, right?
> >
> > We have a complicated model for multi-device groups...
> >
> > The first device in the group to change domains must move all the
> > devices in the group
> >
> > But userspace is still expected to run through and change all the
> > other devices
> >
> > So replace should be a NOP if the group is already linked to the right
> > domain.
> >
> > This patch needs to make sure that incosistency in the view betwen the
> > iommu_group and the iommufd model doesn't cause a functional
> > problem.
>=20
> Yea, I was thinking that we'd need to block any access to the
> idev->hwpt of a pending device's, before the kernel finishes
> the "NOP" IOCTL from userspace, maybe with a helper:
> 	(iommu_get_domain_for_dev(idev->dev) !=3D idev->hwpt->domain)
>=20

I didn't see what would be broken w/o such blocking measure.

Can you elaborate?
