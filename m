Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C06E04E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDMCxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 22:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDMCxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 22:53:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F4CBD;
        Wed, 12 Apr 2023 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681354378; x=1712890378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=geYW3skxCpd/8ccJd+Vzzjqt0goQfjL/zxVFMElY4js=;
  b=G+QK3I1w64t0zFjrTFA+Br2NM/7PzGb+qQntv56BTmt8jJMHapQxsyBV
   atfUN+PAcGlpmtp7QDlFh7LTISrH8gFoGyVVHw4O0C6BOOF2rl87qf1QZ
   qckd1Y+LsifqFGwGI3hj9QTfpIvO5Ln4pkiy81KCLe1hCXxgt2t5P6PK/
   Ksuf6fJ5V91zxOoeDYNo8g11V50Rs1UKVmdfnMoc169Sf7ux0VapzTMnW
   36bUVyLi6cWpKE+N8sjqo2e5NSZmihryrY3tyI+v7p5fBSx7UqX0VbKvK
   pXIBoswqTEp8ibAJAQk6Vtf2TiKfzkCfqrL7ylAmXj47j6bKKM/SFmNdD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346754384"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346754384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 19:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719629608"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719629608"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 19:52:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 19:52:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 19:52:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 19:52:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 19:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESiL56rW5CCx2k8UwHSlWebzHbp7jIhW2LeQhmTANY4Vmn4sBYuNPszlX+f7RcLJks+oybM/trGcdckpxFrOg9rw3ng9uFC/iQsnucpf1jFAVTxWZhr2HSvJGE9sczUF8UmvXXcT/NSkQp74768hLUfTUwHiq4tZLTOrcCdP05LOtVkwyvZeB9BoCKAvUWxlyk+mMZokkhz39MytvP1t58O06ihVrJx5UE1gbUE9y7u3d/RFwt2iq9LAbawKoiSTdeUYQnU4Ah1Xh5bcpPGR7tQco0rz8MGe5UocGISsq4O4tV3sxD1jyzfUEI4tNOlKAW47bs7uVebgHXr783+Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nugw1O1QSOmyV9BLX9HS8iqVoNzyYucxayiH7uTe070=;
 b=DxLsNYDlDYDNcTm8Qi21IORH/nfeGRWcXHAHIxwsXJCblIUr2ixX+Ef0ngvpKsnkzSAfJ05Gywilib8ZWkOJ4hBUhkbTHAiStBw06tZD54koqkmnRm0zRI3Lcx7n/67/t7MLRf8eb8Li724GipCA7sab/tZDydtiUqbqBVIEVKqIC0FTHOY7/nJ9htLgrr6nRyy/XIMYf6qssiGYT+//WbZktMAPrbXufadiPwY1u1F4pN0HdsdcxYarUFzXJ2qQ08WXGETM1pCgy9Mxkb4j23zcOksezBL3fXDwZOGmqhOEZ847gU3tRw93XHxNGDtJjSlKO/tTt+70Ue1PRZRbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 02:52:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 02:52:54 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggB5ahYCAAStoMIAAMPCAgAD9cwA=
Date:   Thu, 13 Apr 2023 02:52:54 +0000
Message-ID: <BN9PR11MB52762841AAA04A24F76A743C8C989@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
 <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDaTY6OX8oR5w0uV@nvidia.com>
In-Reply-To: <ZDaTY6OX8oR5w0uV@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4707:EE_
x-ms-office365-filtering-correlation-id: e75f8315-cbff-44b7-1e99-08db3bca2df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldWBnEv/N3603KhQqAucnReSw2dVdI59d/wH1dEAm2rg+75DF/UJ8WFyqYFvwYTTEqZ33gSypNaROEsrqWqHJZiZW9kSI2WZ5C0P+FKrSpNQcC5Y4yPjgkHv6bR4FzHCZB26aNCy9jlyxd+4/dzowK1JIJEvg6UEwojJS3cNRj9WjMQjs1MsGH4VS22eJSk2q8yG1YUdpkfzoZOHydnawNqjOVIMgb/KHwuNFg9bnfag9VVpC68s5gnMzYzQWFuR0Xs45ANH3IJkVEa4v8+8v+u0Knlgy+0Mnh3R4p+EKRGnNsBM9N6R+tZM2K8UTGi1gPegwkjv0DFOR2MW/ib1LRGmZOT2xl1oEg3bG/jj9BOLNAxitsCPst+agkGCd1HPv/WD+Es+abzUx404pPHsManqxeKnKkwksNlsp4q7tJnsECg3Yx7VCRfMXy101M3CpJH0CAhp0f8S0ALhYr7mS9f3HUMVqTdkiSiDNrgMjscu/Jo2TvAKiJ9oBVioQ6imhENparbfkzAHLf3LYLLsA+ZyPaSGPDluo39Oix5hjMJDqroEL8P+0Hz+00W61pyZxOATlxNGoXRlfD/31g//+c3GDPfjFZL6RKDGIQDxa14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(478600001)(76116006)(41300700001)(86362001)(316002)(71200400001)(54906003)(6916009)(64756008)(8676002)(4326008)(66556008)(66946007)(66446008)(66476007)(7696005)(8936002)(52536014)(966005)(38070700005)(5660300002)(186003)(38100700002)(122000001)(82960400001)(33656002)(9686003)(26005)(6506007)(83380400001)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t/h3FCnzDIRMqpTLOHUJgeiGQuIvjyQFk6pTNxFr4XUd2zcmPNvQcQkfSUGf?=
 =?us-ascii?Q?jg93TFEuRf0VgL12en8xTnFkglRS599CY7DehnE0I6/jmqLv5rng6C4gAihf?=
 =?us-ascii?Q?q/rC0hQSRft0vnx8e3SEMq5bzfYuJQZGJ0rcsZbnOyFNTPGDHUr6veMC1sDD?=
 =?us-ascii?Q?h3elV1kZeZGLtdq4BPuPS8W1TkWV0C6FGsCWrYSxlfA25Vux9b//QUJltcGS?=
 =?us-ascii?Q?DkYlJO2XmQaBgT9E76tYSPNlyxyYsWeLnBFnqRY2N5j8m420ghgdZwbtMqN9?=
 =?us-ascii?Q?WP1nAb+vZpNCAIVIdTrRbNZqU//zHE2XdFMZW6RuGU0lT0bwQTQOWMVTPRR9?=
 =?us-ascii?Q?ap6dgUJMPQhZpGQ0DqrVGuPjnVNQDY1gt+takxLK2I1SXTV1Gx2jptoE6RRD?=
 =?us-ascii?Q?zgEp+Mqghp9srZeGYa56slnv9cO+IytGOopoEnbkkUVJifwPWMV2vFBLjJJu?=
 =?us-ascii?Q?V7taLGC4CscN+9bqFFDK2NpK80wXvY6gb6EFf2hQU8XW54EqycGMzRnSE/OZ?=
 =?us-ascii?Q?5CZYhWumwNe8b+oUU9K++UbO2ovtzqGjC89eMA8fyvilzPpGqN2i0L1/T1Iu?=
 =?us-ascii?Q?zr6qeVrJmUaGnZdyen/HVIZZicfhCBVT34kDnxHcu0Gu5RQKWit4XaOhimE2?=
 =?us-ascii?Q?3WKmpbmJ90DFbU620jdTtTP043QjC7IhepcDcaV+heopPCrEg2gw1SHvtRuV?=
 =?us-ascii?Q?LylT4QVp7RziP2Vi1oAPeqOp7LG58HKf8sp8tE3BDaHZ7AeCcVJdS9krGOQn?=
 =?us-ascii?Q?RD5mw0nVY71MlzkOOLmKROwPmI5EQgSKgEo1Rc0IujZE+kqzHxNF6MJ9mFAW?=
 =?us-ascii?Q?DK6g+GERq/ZFATKOmgjt7a8Zuw5u0xwK4hw4qPO+1Hc6QP/lD4NssS72Cl0u?=
 =?us-ascii?Q?A2aoizckNJhsUGhFpASE+bZltPblcj/DJDKRMuwMhHfSoBwuE3om4TZldVhJ?=
 =?us-ascii?Q?/y2aJsxVzEvuu5OnsCn87N89PjNxx/nAoeXsIsZoEAfXKxxMqhIbiSYlXIfA?=
 =?us-ascii?Q?U0VJCY1wiqgRCyPLHHAjeegbTeb6U+QTl0ZV1lYcXRa6U0ZTmkSkBC1D80Ld?=
 =?us-ascii?Q?0mLbL2gcePJhTcvDT6JnYqCNzKEMOKCcrHW3827y79AFQ15nZWeboBRmRicE?=
 =?us-ascii?Q?vU6FHiNXxqliOIlnvB8oWTe4tXZMj0RYYMpY/WMwORtzNO0V5Sa+kp37mfGN?=
 =?us-ascii?Q?+DkTPzTEU7tWWZjqZbYnxEcM2H7w5bwW5RKFjJJ9yOkDpPEqmrCMvNhkdmo1?=
 =?us-ascii?Q?x+yHZskKEGzvn1SLXY2tx6RvAEpuNlUDNVPb9h14XQm1H7U3g+1GOj9jdbyq?=
 =?us-ascii?Q?buXeT5hAZJoecdnTdrQcP74y7hKj0nId7Lnqgs2q/yTz5Yb+UI3+Keo3laNi?=
 =?us-ascii?Q?7LaEaXGTpfzq4zpHB8cTwSac4Xxs027nYIAaxnMZSCUe1e/UUnqOLalX5NuF?=
 =?us-ascii?Q?lx1YXUyqxl2CF27llCyoaJ4luj4it2BrjzTfa7fzS3bmJP7Vb/a/srhcyyQB?=
 =?us-ascii?Q?8VvvyomGTDSSCJqdafArgi5nRA3nyQ6eL5oJ56NtKLKBNzPXsopJ8KzVyhbs?=
 =?us-ascii?Q?9sOY9kUudIVdZlcDNcaRe5t3b5p1n6DRBMTawgGy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75f8315-cbff-44b7-1e99-08db3bca2df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 02:52:54.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6loSvD6anGEHtVLVDVkRmrsv9OoZD+Q65UxjRg8KY6Mf6UtcHifMuF1m4yFi4Jgja1lJAeBxj6JhNJSg7+jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 7:18 PM
>=20
> On Wed, Apr 12, 2023 at 08:27:36AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, April 11, 2023 10:31 PM
> > >
> > > On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
> > >
> > > > If no oversight then we can directly put the lock in
> > > > iommufd_hw_pagetable_attach/detach() which can also simplify a bit
> on
> > > > its callers in device.c.
> > >
> > > So, I did this, and syzkaller explains why this can't be done:
> > >
> > > https://lore.kernel.org/r/0000000000006e66d605f83e09bc@google.com
> > >
> > > We can't allow the hwpt to be discovered by a parallel
> > > iommufd_hw_pagetable_attach() until it is done being setup, otherwise
> > > if we fail to set it up we can't destroy the hwpt.
> > >
> > > 	if (immediate_attach) {
> > > 		rc =3D iommufd_hw_pagetable_attach(hwpt, idev);
> > > 		if (rc)
> > > 			goto out_abort;
> > > 	}
> > >
> > > 	rc =3D iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> > > 	if (rc)
> > > 		goto out_detach;
> > > 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> > > 	return hwpt;
> > >
> > > out_detach:
> > > 	if (immediate_attach)
> > > 		iommufd_hw_pagetable_detach(idev);
> > > out_abort:
> > > 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
> > >
> > > As some other idev could be pointing at it too now.
> >
> > How could this happen before this object is finalized? iirc you pointed=
 to
> > me this fact in previous discussion.
>=20
> It only is unavailable through the xarray, but we've added it to at
> least one internal list on the group already, it is kind of sketchy to
> work like this, it should all be atomic..
>=20

which internal list? group has a list for attached devices but regarding
to hwpt it's stored in a single field igroup->hwpt.

with that being set in iommufd_hw_pagetable_attach() another device
cannot race attaching to a different ioas/hwpt (mismatching igroup->hwpt)
or the same hwpt being created (not finalized and holding ioas->mutex).

So although it's added to group none will reference its state before it's
finalized.

btw removing this lock in this file also makes it easier to support siov
device which doesn't have group. We can have internal group attach
and pasid attach wrappers within device.c and leave igroup->lock held
in the group attach path.

Otherwise we'll have to create a locking wrapper used in this file to
touch igroup->lock in particular for iommufd_device which has a igroup
object.
