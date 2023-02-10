Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FD691688
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 03:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBJCL2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 21:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBJCL1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 21:11:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C26E8BB;
        Thu,  9 Feb 2023 18:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675995086; x=1707531086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2mxY/5NTnlkidB+sbwAngQWS0rttclnF8pGZV3WHYo=;
  b=mrfTSwDIaWTMEd1PlKLjxPrR0cA5ZSLeClEIpUxqryEU6w31xownWlU2
   2BNsoO87ZcSWfpQCP2O9wwBSTQQbG4+8NavzCx54+zds3ljziFlQkPxt1
   CgOFEn0Jp6vwNQgLHwkTCjSInc8p5Sxd1g4USJBLbL3IXinapAGQMo1ky
   7enumcD6HOKsX6ZGfAZwV0j2ahblPwpj8v9cUab6QcUFThqeDWVCUE96B
   hhIIwzZuC6n051eT8E3kcqPBYxGS8kSELcuV1E2PbmzFWusDbol9YbzQJ
   /0PS2E+kk7MnPZEjJNTKHeY93r2vJCDRFo+6N9L3rMQAgJPF9QyD6TwXD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="392711853"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="392711853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 18:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996790310"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="996790310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2023 18:11:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 18:11:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 18:11:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 18:11:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBLKsqEymhzssYQKgvC2JNF33zom+t+nnvMkI9Qg6NRMKt7qrA35qH1dqzLFiuyVf1CllSWyjizWNAOOfQAFxUOhHJwDfaklEGTaVTGfO2DRy/9LWWA8gPDdyY+y+U0iefnDAIsZcm4rjPDSFH0ZHROabWDfc7KPLKfctzDLu2Y47zcDc5FmTtweVCTmGU+jFpTFblRNUmGVOYB7bjXArDa4tXrz6fa/S6zY84fFiHPWFBUkCQHjyd1Ff3I7whn9TEjpH2hLaxgVGKHqggYd18Lstsu2+hJD8QnyNTLeFT2HQikHsNjDajIefvDVSxHc8IXu+aPQpBMnFF1uJMx+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUKDNKpKwlPBZUxeqNc27rW0KHFVbTOYYbNHjJLFsPc=;
 b=PScGqAFTXyJj7Nif5al12Ea5fN2Ms+hKTyGjgqpBG8VYNoDqLwugXL1lnqf9MaMQ+DtcP1/LVBr3wUIboePfY6WJQayvGpdcJ9SSYqj2m7y67HDs0COL6wGu0v9sOI1y5gmnNvu0Dj1oDAqwLd183fKxhmvq3aMgi21FfrBoAviEtT/z1yUmMgE+2OK2fumWF/knl8mpjwtwUcd5aXgOr/cCCkpz7Ix/2AJ4OqSw72EPNX8+tetJtU2jopJknbsJBvyYvyHjEJIazZ40+MZwOaA1LRlB+z30NMuz3bsSutFFi80D2t0LpLBT5ZCWieY18Oobg3lsE6w1gQ/7BVwrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 02:11:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 02:11:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cA==
Date:   Fri, 10 Feb 2023 02:11:23 +0000
Message-ID: <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
In-Reply-To: <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: 35745af9-602b-4349-4f88-08db0b0c1b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVvOxB4L+9gjiNMxKWpOM8l+4XIlosHQd6E8PwxAIY4I3R1IJ5rPn46YQTLD65te7eRmbH1dWWoF0Kg6Ona2Ns7gSB+08BhVpw2ovPjftTeSqrsVA6e+7Xfk1wddi2RPuNQ1L4pe8Hm9rvEhbmdtgRiHLjhZVZXWokFD05tiWj5P60tPUwseaVm71+J56+R0oJH8LHLUCzIcAmthv56FWQMKpqk6N02VR0GQsF/tEYR6q3zGHLTYIwEkDhuLSoR3N9b8CaPl2xZmhByG0TEzTs4GXu/Fv79vMLY2/OJE3gllLCzYRe0NOeS0z/J7GimKdZJBGYgWCSGSQnpo646lf357k2Jr01PCATw2chPt7LifXRcJXuDzu17pLNWn88WJnNV4s9fQQ4iiuinWqF5u2I/viNpcCV4Yf1gf932QuGS1ECyj+4I4vs5Pmn6CmFMXMiVoS9teqTVMLr9glF+cOYfE7OSQFEqk2lL9aL4rgGw2A0Bw0gVkb8t7bgpQ+w9iVoqFt88KCajIGx8PEDEHXUtA25ELJclMLRPxB2NNkly0xDTfbxe0eY8P7OzTG9/Ie61v5YDiqRT8uLQW0xl9iV5Wwpzro4yJOzbta+sq+F2/5OFUzhAiPcXVJYuVW4xRyyLX038uA9Sza7cQBbGDcLdbEpdXH+fqemwjowxIeTyCkXHcxXucfB1zG4IHnp7wEpqV7Q0aPvOtYZ2qHDAF2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(86362001)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(8936002)(54906003)(66446008)(316002)(4326008)(41300700001)(76116006)(66946007)(64756008)(52536014)(8676002)(66556008)(66476007)(6916009)(5660300002)(55016003)(2906002)(83380400001)(7416002)(71200400001)(478600001)(9686003)(26005)(7696005)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8urzy1hyN1wYeYuA2NjY5gwcOQO2D+YMGQ2sQjDuZusSzkMOsPN+YeiHKTXV?=
 =?us-ascii?Q?4VkJmE5halb47v5ZdojNyWMRK+opXPAVslWkdbws3nic36Qiptg8RktB3vrc?=
 =?us-ascii?Q?15C9hInxTgIF0RjRsyg2t/L4m2Jw9Fe1U5XYJQPqeUVuyft21lFgypQU2ahL?=
 =?us-ascii?Q?HKhHhG691lHmS1R0yvOkXua5COwJZAt964WnO7TVFJk3nDhktmIqT3MCSyLa?=
 =?us-ascii?Q?SxAaRtAJkyPxWLuG6rouvwgcoTnXqBIKrldgoaPjc6vZcwizLeYM5eC01PCd?=
 =?us-ascii?Q?aQKQaPP9vsWWbqnAoDzWOswa+y7EmPcVe/Gf8qsw67+2wHUiFH7o1vkbxIOE?=
 =?us-ascii?Q?OB9K6PAURdXbFnIOs/oRTC8dJZmXWz0XAeEAXeupl7oXYptlL6XsI05S8T7p?=
 =?us-ascii?Q?laMYRsAgq4TSjdNDZUHsTg7GNHGe74PROxdZfzfUJhuepIZCYac64/hBMi+L?=
 =?us-ascii?Q?1Yn6b90BPdWjjTbFI2hBCNHs7NWt7IH7Ou5cL3IMRloMfUaByssUxCIGruf7?=
 =?us-ascii?Q?ApBkPifL3LW92ZaUPNG3/v95l6pTR6xjzlJOGJ4CKqF2f45G5yc5OXSU8qo1?=
 =?us-ascii?Q?Uo9ue56tDQ/fFX/isHjVpsEbrY8Sh0QrNn9amYag05ZL9ZB8QBonR83Ewpps?=
 =?us-ascii?Q?OR+OHnvG7aotVM4er6eNxGkCMfryONVXDwc2EyDx0iHZ+YIaehDNNx1jl4ER?=
 =?us-ascii?Q?By65KjkTE82A5Cq8XPqesMY2znhl5EfZdmT8pt2ke0SGAugEYuKsXm3Zemx/?=
 =?us-ascii?Q?mvEw/ylLC39XCvcbr4mB6gPlIzBGm8v9oFfS5oKndWtZgvRgDOVNFg+dVMxy?=
 =?us-ascii?Q?2pDcxW64hq05x0A0SHVnsrtTpAi8LJxOzNq6yWH3gazxdOcJ7GHaoWilERXB?=
 =?us-ascii?Q?m/S9obbWAkKT3odM4vdA4tekOfau/0tNmA0Wp1lakpUcY82BE1U9vapjIs9n?=
 =?us-ascii?Q?sit2m/1b6lwKLxJWSDrVLZPsyqq2mEgn3mvXfjlF/UkXn3b/dJUgObuz++tf?=
 =?us-ascii?Q?apEWE+H97AOyDP8GfouoFBncHlXxeSfQbOl7zySIgBNDjoyqbRN4QEHjdIdL?=
 =?us-ascii?Q?hjk+wH8FAJzjOD7lMZbFZgFtLgqqec72zKr7BJxF8ftTFWsW/K/eDyokLLBi?=
 =?us-ascii?Q?nc06+P5y1fa2jbw9LuI+J98HLSdmTNfNfdn3QALR8/myVcjV3X7sPqajM9go?=
 =?us-ascii?Q?OYfwBrW3/sCeGqFw9NeajnyPk7fpoovtvS1N4s+bZUJBIqeRtH+C/yOor2vy?=
 =?us-ascii?Q?MFZEj13fGKLmhADdG9w32m6/Ow1GG3CHOpp7iQFSqMR2iLKLIh8e3VHDEY/K?=
 =?us-ascii?Q?B7M15F4Ni7YavyGr/Q4MuRowtL4BiS+gvd7I6v3tspNprt4ZNy+OhaUV2P09?=
 =?us-ascii?Q?+D3J37xjQnrYXt1usxwuEjrzWGOfiX/DvN49hG4xfbqv11hEOP7nFaH706uJ?=
 =?us-ascii?Q?+rBPWYPUOJum+aLK2HU9pxCxTn61IngMJDQKIe0+f7r7JVbGtrxAO3mecRjb?=
 =?us-ascii?Q?lXCjslxJGylMG9LujIC+FuShPzaPfKdkZO86Nm553rsXNkht4FshSFPxm8KD?=
 =?us-ascii?Q?OQep4DwaxfFeyRtvpduaDmIJtXqtLZsuxOGRtSTl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35745af9-602b-4349-4f88-08db0b0c1b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 02:11:23.1349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G91B+jct4/NgjzsBWkM5k/BonhGtdmob0d7c37rY6XqbcAqLE1wmYvUPpu243h5pG33nuyjOTs9HjcVgouHCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
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
> Sent: Friday, February 10, 2023 5:13 AM
>=20
> > > +     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > > +             if (list_empty(&hwpt->devices)) {
> > > +                     iopt_table_remove_domain(&hwpt->ioas->iopt,
> > > +                                              hwpt->domain);
> > > +                     list_del(&hwpt->hwpt_item);
> > > +             }
> >
> > I'm not sure how this can be fully shared between detach and replace.
> > Here some work e.g. above needs to be done before calling
> > iommu_group_replace_domain() while others can be done afterwards.
>=20
> This iopt_table_remove_domain/list_del is supposed to be done in
> the hwpt's destroy() actually. We couldn't move it because it'd
> need the new domain_alloc_user op and its implementation in ARM
> driver. Overall, I think it should be safe to put it behind the
> iommu_group_replace_domain().
>=20

My confusion is that we have different flows between detach/attach
and replace.

today with separate detach+attach we have following flow:

	Remove device from current hwpt;
	if (last_device in hwpt) {
		Remove hwpt domain from current iopt;
		if (last_device in group)
			detach group from hwpt domain;
	}

	if (first device in group) {
		attach group to new hwpt domain;
		if (first_device in hwpt)
			Add hwpt domain to new iopt;
	Add device to new hwpt;

but replace flow is different on the detach part:

	if (first device in group) {
		replace group's domain from current hwpt to new hwpt;
		if (first_device in hwpt)
			Add hwpt domain to new iopt;
	}

	Remove device from old hwpt;
	if (last_device in old hwpt)
		Remove hwpt domain from old iopt;

	Add device to new hwpt;

I'm yet to figure out whether we have sufficient lock protection to
prevent other paths from using old iopt/hwpt to find the device
which is already attached to a different domain.
