Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755177863F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 05:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHKDw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 23:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHKDw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 23:52:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B42710;
        Thu, 10 Aug 2023 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691725976; x=1723261976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qzo82lbOK+suEkJbv21qFz0XRPWjwNi93usTE7In1Ic=;
  b=jmTdDBJcRk1/iY+J8PnN+JakItEA3eO1aADflpjQ6uUO3aGstirVRjX0
   QN6aOH3NplWvPfOK/PlrCEqMY9AQ58YN4fPFvcEpzKScLT5cU55WboF4w
   fzeAk9NttuVan2qGfYsv5rszBBpDlkb3QJaEWNJA03DW6Uj+YWqnTGBR2
   ShB8YT8Su2qbVME3Cw9J9luWIlEaAAP/zXwl24WXjMJ7USZ7EykgcIV3Q
   G2jFf2GZvbSd7WUKUsCRv9v5Swse+i/8/XROLoLhYO/8TrQGBfb1OhODr
   g4L9sN5C99qidn4IcK3zamUxhph28ArhCYjSbq+qpZ+bMbopR+adXE7ai
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351905005"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351905005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732522650"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="732522650"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 20:52:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:52:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 20:52:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 20:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0foAsAxas4ZqRNAWgskLA7TtxvT1+EmeDz1BynHAa41zm+8X8pKIdLp5Q4um9x/23a5HrrFDoeYbymtFlI8b+DuWA8IDQmKf8LV+JVwq582/c4tZPl8FMqZfT1zLkPDnSSlTMAbiwLWX0dY/o696DGATCYZE8WLSGcOlMaKiMWy8PMCZACWhgTGxcCPJk9/FQY4L5uYMbjzc4QoD3ukO12zHjzw272DoO+dS+p27o/9YxD29fw9a+JDN+WLmkhjuRxF3yXcQwWhaL3etv91IiJKF/HoxVP3G/jAvacsFi1VzDdpv6zJyVpQ01CXfM7kntrLuOG5V1ps/LjfEnGX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qzo82lbOK+suEkJbv21qFz0XRPWjwNi93usTE7In1Ic=;
 b=UfivX7tfWYv//Y17MLvQ/Ucgup+617o8FrTGp60h2otPj4rMw8VHRxZqt+FG1AczZ9YZ+1ILFi5MevBzunLiemMpioQ9V0jX70Gi5q4BDOeZ9TXPdIG6CrS+X/2gLWTZ80Je3OKceabHSpCamhn8TkHrEYIM8BoP5dXTi4gBPO2jO1fIJwuzsA75AS/3MJM/73rezdIpV+wGvH+HhDrh1lYv1l17ky/Z3fZ04vkSJNMQsntypo+XWW/HOABF80kxfpDUATF7wplmNqZ/4j3yUl3VpaZqmfwm1kAsDAQ6SjGZZU12ccKwD07pYLTid7KNloyKG8q3djhKkYa0KuMq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6510.namprd11.prod.outlook.com (2603:10b6:930:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:52:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 03:52:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAhYJoCAAMpSgIAAnN2AgABV8ACAAPMnQIAACsKAgAAAQaCAAArdAIAAc+AAgAAuy4CAAAHYgIAAEEsAgABtjjCAANwPAIAAFauAgAAk/wCAABq7AIAAbchg
Date:   Fri, 11 Aug 2023 03:52:52 +0000
Message-ID: <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com> <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com> <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com> <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com> <ZNVQcmYp27ap7h30@Asurada-Nvidia>
In-Reply-To: <ZNVQcmYp27ap7h30@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6510:EE_
x-ms-office365-filtering-correlation-id: 8cb2def5-f4fa-434b-37f3-08db9a1e7044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97JrjHG4SjDRylqNNKffs+SbYEXgTd/Z/XsQqJmOb6hlKlOdIM3DlegroROKaIds5ilswwUxndB+dYHpfnZD+ljL46MRbDxyLPaHGUpfKGNYxur6gYWMKNpRJkzVLVjR3kU+oQSkhodBiokHSpMkCnXfriTzq349f5RDFOldg3Ql++tBMBbrjI3dCkSfcr50Zu4FvkK6wuMcGJCU+bbfe02KaYVqqZAhwJJBx0QuhLcRdBO+Jq9KqTA/b8UbOoQRc824/Svnrsee+Xt37CdkDmEnzcuZLJpSIb9Nuf+RMEcry6AhtrNB4ReU9O99w9msbFmQoWXrk0RZjERRhAGxqIeVz3io0nWdtR4ohujBq8niUtFIZI/FuuYx03EDB02XLsqB48My14gNdhBdq0VXaLq8SKJqMr1YSc63Ddqe2rt36q7hUadiGMiXs4AyTMV0LoVAgBud3+DvKCE1531QcsBHJdlXbSr5OlSzhaiWb3UyELf7BgqFlbUhVgQAaYwRF2yGKWVb75IsTxSn6HDidwzWifkDjYrJOdtIIlrnJS55OIPVRK5trdWu9Ha0YMFjss8FrgkIwOQXMukeJL0eZYRoScjhPcKa9wEH1zvQYcelthVxBVgqbluauLRbtubF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(186006)(451199021)(1800799006)(54906003)(66556008)(71200400001)(478600001)(110136005)(66446008)(6506007)(33656002)(76116006)(66946007)(66476007)(26005)(64756008)(9686003)(4326008)(2906002)(7696005)(82960400001)(41300700001)(316002)(7416002)(8936002)(52536014)(38100700002)(8676002)(5660300002)(86362001)(122000001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rB+YHD/ROANefPhVNLU0Yn7YIpdE0TRS44Uqg6VBEejhEST0VRpNuaD3Ueb2?=
 =?us-ascii?Q?OK1XvTsMNZlefZJccnWkSZX2xPGiaI9DGN3NVldQRxYI5uGqBuATqWKlfogy?=
 =?us-ascii?Q?AgxQ921SpGTa0SCbgYBefvhfvkx/KzyHuV1VPGKemIF078GrEwfTeGGErh+W?=
 =?us-ascii?Q?/rfoeL1kX778ReXulW3SmQQ6V4dioH4P2mfRtr9K9J4BnhbSeprjgmGN8Pe5?=
 =?us-ascii?Q?OfyJYewLMRb/fm+bHF0+VKNIPYFKByoF1x9Otus7apdiSUjrzwrvOWvvzY5h?=
 =?us-ascii?Q?9jXZQ022Q6IKXQ5Tdb0WAvqHRARpMYLHDiUPR8ooL9hYRaRjIpaiC5bLZapf?=
 =?us-ascii?Q?y1WxfwnrsOfkuFnbZE8/F2OmycpgXN7BQbIlaefGWEwgQjejRRjSSpLBuA53?=
 =?us-ascii?Q?GSjPlLxSwGdRDhxwx9ZmqUMIzD7PHofclBLvvPTE8/Yrt+w451A/YKXYI5jo?=
 =?us-ascii?Q?UuXV+Yx/wG8nHTjQ3m9ZCqd7csT7jEo8e6nqSY5i+tYdKVhnYUyenAWl+eEE?=
 =?us-ascii?Q?gJR73emVkM/31D2V4pBhRIZQKG8gToXDokI66ulIGk0H+5GMsjhZK08mqgUo?=
 =?us-ascii?Q?J2+/kHJdI1K/qGm+a5Jt1Y3uw6OgX57xmm2IsgasgLJ0TvxB7+ZMX6JXoeCv?=
 =?us-ascii?Q?lt9YzLJeiJfkzX42+jPJh3l4BJ8b4xBubFKvaXRzXs0uHQBqsk/T8PdZXKaW?=
 =?us-ascii?Q?f3/zUP3OLUfnt6kFmpwY1aBLoccCt4XC9QSaZYgW2PEF1Jozm4318zEHtjoI?=
 =?us-ascii?Q?cpXEKL0GnCohic5zKPi/J73ojffSkzr0wAUnSffqy1X2kucBt7ZyKfFCo3GT?=
 =?us-ascii?Q?f4d2dN4TypiWcQwCBh4l7j1DblCAuynSVcfc2h3ynQrF80u7tFoAyGg7YtCK?=
 =?us-ascii?Q?CfVzbnBCiRV2r1ntCy00FnaStBGndVjK4YqDVFEfJ9ksZ+TgYzzjSdyj3zo7?=
 =?us-ascii?Q?N7ztb8sYoTTifxuXDu7M6QWFLylU4Lq4K/vU0Q3qIvJQCSZXSJ+y2Q1QU28V?=
 =?us-ascii?Q?4P9gTKNuJcDQ7rM3Hdi4CbDbpAhzbmcrp5Q+fGbCBhrwLBLdlOKPTlLOcA/A?=
 =?us-ascii?Q?d77PXogWWT+4N5mf23ighqnL8DLF+g+HeREviyNub/D6FZaCeKl1O5i3tsg+?=
 =?us-ascii?Q?g+5231f2WinOqP4zjYK3x6rgefr7nV2JrE6KR65v2pOfBNHSiz8Nb7rYMK25?=
 =?us-ascii?Q?XV3G+Vse6kGTSg/9UuJ59Do38uBdOsLvXqse2BgtZpYOoIEOgPp1slM0uUby?=
 =?us-ascii?Q?zkXr+SeMKEvbrtMaSbRS3BQsL75K9fxINDT01B6wedluhR3cmFJKpVjqoX+5?=
 =?us-ascii?Q?sZZ3EQt1EUmj4sWHQUsDSDSURGvaFf/xdgvURRD7QxGr4gYLNkmkcI7tdSzy?=
 =?us-ascii?Q?UCwX1yOkDFCXFFcKoYrlpKho9jZpTxFRVu9tLR4xanxRFfT/j5kYADmgW5s0?=
 =?us-ascii?Q?+Gmmf3XowC5O8w+GcU+dTjiKWaqxI5rQb1COQ57bC30zKEx2yMcaPGYDj36G?=
 =?us-ascii?Q?igs4MZpMqVXULMBH2b0gcmDuQ8egRrhIEo2SHRuwxqEVgpt2nA4jsbTSamNz?=
 =?us-ascii?Q?cv3XO1UFiilnC1GZDosrPgPc37zXWrrLN8JJLkHU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb2def5-f4fa-434b-37f3-08db9a1e7044
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 03:52:52.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7Lp6wbw0Peg0C8JsKAONhUFKvXsidaWy2g+6LpEU7/UplhIRcwyGJhLA+LEcqnUZLUNyVFtBbH8lG/6pS7zcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, August 11, 2023 5:03 AM
>=20
> > > > Is there a use case for invaliation only SW emulated rings, and do =
we
> > > > care about optimizing for the wrap around case?
> > >
> > > Hmm, why a SW emulated ring?
> >
> > That is what you are building. The VMM catches the write of the
> > producer pointer and the VMM SW bundles it up to call into the kernel.
>=20
> Still not fully getting it. Do you mean a ring that is prepared
> by the VMM? I think the only case that we need to handle a ring
> is what I did by forwarding the guest CMDQ (a ring) to the host
> directly. Not sure why VMM would need another ring for those
> linearized invalidation commands. Or maybe I misunderstood..
>=20

iiuc the point of a ring-based native format is to maximum code reuse
when later in-kernel fast invalidation path (from kvm to smmu driver)
is enabled. Then both slow (via vmm) and fast (in-kernel) path use
the same logic to handle guest invalidation queue.

But if stepping back a bit supporting an array-based non-native format
could simplify the uAPI design and allows code sharing for array among
vendor drivers. You can still keep the entry as native format then the
only difference with future in-kernel fast path is just on walking an array
vs. walking a ring. And VMM doesn't need to expose non-invalidate
cmds to the kernel and then be skipped.

Thanks
Kevin
