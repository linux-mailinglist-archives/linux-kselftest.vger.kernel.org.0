Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3668B5EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 07:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBFG6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 01:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBFG6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 01:58:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13B19689;
        Sun,  5 Feb 2023 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675666663; x=1707202663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rekRmi0/6xXzFrDibffg+WDPUj72kdH0shvDJ3yPnno=;
  b=BopLvZzq2mVkwa3lSBPnwbZO7A57Ofy8OrAagk6gkOf88KAiM7vLEu4w
   VuHTX0UkLazR3RwF38bWqnX4yvgT0q1GOdH6ohgbj+1rQ1SJG03XsvFTk
   RHZX297WJFWw2SAuWh+5zTdXyW+75CWEmJr7vqP/0iUhp8QAX0kOdbO+d
   lYy2s+NIpDvQeIXkPmp64DYPpOA6Om4BDY9sUjXrne2TCUUOfmuqbk6Il
   J76D0qN5ccbfncVU9N96PMIJ2XSV7KNkqjA/L0YNpKK51CDQpRakYV4aR
   vt8s7FlBO0UJKpXK59buxUPowWAvwVjq2WRRhQSKXBp8I4HsoT+nkmmKv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312797388"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312797388"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="643915963"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="643915963"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2023 22:57:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 22:57:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 22:57:42 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 22:57:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW9Qt96LfU0WEUbqO45NUnLs60VI/HNSyJzQP974k+5Pvd43wr0rL0Jzoo9yJ9p+DOi5iMIezbr6IbjdYbDyG/R/47XwRW8O3VCn8iPMHuVYjE3YBp2YrSjhABKelz9b3ayQtvc8exrQGcA30b3x1uRCIe5K3297AMxp+1QobyZt+wdDwzhdHmdM8FjrBCgepyAezDZc93kNtgeUGoHerLWoJFcdx0Oxcq8W8u+7zvn9QR9JkDIVfzxwxGlDQ3//obhbD3JTl7tvn/moHNmY7XktJqC+HvsMzQzKpqhDpSevtg1sJjePDYulQfMs3oFRx2aOAWw4TXe6+xzuz0e7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9dBXLjhvZuFRdjMIjW90StxIMkr0l0dDa41mqopnp8=;
 b=X6Pa0tUGStGDV812515OpRqhhln9zD6HkcIDpM6qyIuH914g5GLfVIsHA1kEK2MvJZD61rxxSHI9qOxyC7Ep9ab3EE3kPoiUiqgSKZKLGQjLNVeiwy5nlAOs+roKnSgrwcSKc8DbPs2p1KX1Ne6NNAJYK9mWOWwnV8/C2jek0Np6Y6sjQ2yayxpAEJVfPzDtg45A0NqFRVC7f7N4to5g+7S7deivy7xzUyvhCi9V8SXbfCaVcgvQpF7N4tjEnpTJzPeSwcz5lZ2F8u0PM1c9XZ5D6QEMsmaQUt5ltt4C2nM1fvtCQ0pBALkQCNSOGl83CtOu5FDlfmglILExuNtddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Mon, 6 Feb
 2023 06:57:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:57:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
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
Subject: RE: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZNtTMfIuYSgtAgESqEIXUquWnsq684BXwgABzjwCABCqQ8A==
Date:   Mon, 6 Feb 2023 06:57:35 +0000
Message-ID: <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
In-Reply-To: <Y90iOAmnBtqQtmiA@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5611:EE_
x-ms-office365-filtering-correlation-id: 6091cacf-9821-4eb3-f3c8-08db080f6d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJdohQ+6dAEMiK/hbtyWfzytt9y0HG0D5P92es52jQLM07Y7s6CqgpiG/+iqs760DQhCy8YFXe1YpNPW7j8KoYOJUz++tWKFL2YYxv1a+l61MSPAQ6PRS2PYc2+sF0obp2MwzQ+FXMC/5rJubDHS7DJWNiZp7FxhAwhBj02rwW3faEvRzf3nz8US6DDuJrBrnzMnbPvGmHXO3Wr4sLQ6pLu/P2n4+A8Mv3K+Dop11SlTktHRblqmC6aJaw6f9MRlaIKNqkm4AXeE0KaJwR0YH5aYLY++I7ERwURXTv+bp0nurAy51YgHldUO1xSHReDMqXWaMXdzZKGlMl97DglLZhW/TJ9u4/NJJ5K86x/HAbxcmDURUfm1Yr9GqAUUDCurisWWOvyEmzHBoXLlgCRMDwm65eW/SksLqE4lVNys30I1h3ACIIToL4OfAhMM49wDs+SH7jm18qq5gpTucyXqbFgPSRpf11KrB8sCU5topz9ugdUEuDFfIFW2fe9PtgF79lhF56SMIh/GC4p2JQ+6qBRGF9ZewyaOQNFpJ+7TumuQAnfXsZXuz9shmW1p0+XFZnZeeBHC8sIvKNSo4ftbrkKBG/UFlpiUDZfvDDTGbFIxQXxdZllBpGHbXBfM2UNLlT9mVf9eZdjncKzWmpLRirC3YmU0x28AZ8A3QOGDo0bKZKgtRJKsa9qDj1wCf5IzaQIClmzMukJmcTna73S+vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(26005)(7416002)(6506007)(38070700005)(316002)(2906002)(9686003)(7696005)(54906003)(71200400001)(33656002)(86362001)(5660300002)(52536014)(55016003)(478600001)(83380400001)(66899018)(66946007)(64756008)(76116006)(66476007)(66556008)(66446008)(6916009)(82960400001)(8936002)(8676002)(186003)(4326008)(122000001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ivTsBRDWqM+6do4TjKgZ51nKv5MpEOWj8n8xVSrNyulehNboITeyQRWpdOWb?=
 =?us-ascii?Q?PvGP2uzEeyxCResLN/5pEq0vUaYAW9NkZaX3JNeoQprDcvqJKgeT2zD7AE6m?=
 =?us-ascii?Q?s/XHTMpqtAN0bH56t6esnQbDRv8/CI5UPZtehe3iif6HTfxbjJMhrYJcWI14?=
 =?us-ascii?Q?J6Xz+/a+Ie67hvBqaOHJ4n9hmPHCnYvLfwyhjNjSf6iRalcMfwWz+PnsjfRi?=
 =?us-ascii?Q?KsjMonbxsfCdM6GqoIbao2G8wtTFLUhhebxi2TRiVb+3G/wgAUH3oo2/exNm?=
 =?us-ascii?Q?Tzi1HYDZEqA8eEGnjGyyA06fju/Gn69VuedpmHCs0eGfCKvJDofwX2kQAwY2?=
 =?us-ascii?Q?ZXZ9NtBa71NAAc2NjQJ6/TjPML1Rpib8Eomz+HB2Sqs+/3jaZUkdS3DbQArU?=
 =?us-ascii?Q?3pUt/GK5G3jdSSRDPmJG+cN2nQYRTCd2UKgsUrWA7ipr7/tMNG4zzP5qRoJ/?=
 =?us-ascii?Q?pL2hB19IlhnmeJ2o3SNhycKFOmqHmf60slMAghTJr4mDupcwpbVNRDxUNMZS?=
 =?us-ascii?Q?UY2yavD0XCAX4DOYNYXxEjpmYbI3zOnnHZqXRuwZ7b9XXe5XoFMdWJ4a1RsH?=
 =?us-ascii?Q?IUyOMshcMaai6FxiGJQjeP97MlgI7wqx95wbBOKC6D6fu0Jj8n9AvVEgMz4z?=
 =?us-ascii?Q?6hqL3gy65Ot1A2yDAY8GlZRqKua5kHSwzeLQU6ZYy15r4/fog6mvuG84S7E/?=
 =?us-ascii?Q?2MEqFe+UBikiUx2aS+XdZAKF50zrRqBKg7xJ5TM+BjJsd8hOasviP0RzXwcn?=
 =?us-ascii?Q?2PEXFUefuc7Wrlnczcd3p0boETNZaBJvKPjAKcfJdBl6WerJlbhKGgpl9gNj?=
 =?us-ascii?Q?3HO4cM7ts9/v6wH7edOqY8iLUwrYYnr8gVbO2CsSHAfNhNu5nN6FzMGbA2RW?=
 =?us-ascii?Q?G1boV4szO5IIPKR2INy6bFkqp8YdY3+wR2Ilc1h4fByGrZknRLI8rlUUdak7?=
 =?us-ascii?Q?zNti3fSKMY86SjrfxNxRKWcTyW62oa1ZazKeuXrno5p3g77FBC8x0v65p8Gj?=
 =?us-ascii?Q?oLM9cjp4yXTQChKK/vnZWDOBf4R0149gPNs1kvVZxEk9HLNxay/WOSK8qhRx?=
 =?us-ascii?Q?oU9Fgg2fibz1MvMHrDrJ5IM4UsLjsPMEJ9ZUqNodAkuqESDBKw/68RyjC5Up?=
 =?us-ascii?Q?JkdoECtdWUxQmNir8cDjJKs/n7ePREc9x4Ycocsc1vHCjoEe3YEMsKS5wiMw?=
 =?us-ascii?Q?q+6aS1zHaFepj3NHEHTSRTeAMS6UyEZ96T+5Sf7LElltdaofHht4gH3xokAb?=
 =?us-ascii?Q?WjTG3hod15nBZq85HHl7z6tMg5xppmpzoIDhWlsXj6R3RAgRnKOSNaGf476h?=
 =?us-ascii?Q?Yt9BF1tlsZFAljA80/N2e/yp8IND4vc22KECWTci5fTliRWySO9pPiObwXoe?=
 =?us-ascii?Q?HzG6Sh2OPi0Ld73+f/RwbCJyyfUt9rgN0sX3vaX3xZJcAO3nwwUCGPKfXEqz?=
 =?us-ascii?Q?MS7IHgQ/Nl3S58p1JsRslwScEcTTDGOLifdGXOCbfYkpcL4b5n8kxbLSjBXj?=
 =?us-ascii?Q?HFZSYSlxa9ZErme59SkPNhbmrK/sMDzWvptPg9FJFTeMZfBnksng6i8O+f3L?=
 =?us-ascii?Q?M7ZxpL8TxRfyKRe8nJmRdsE5+CqZoYEk5470gO8Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091cacf-9821-4eb3-f3c8-08db080f6d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 06:57:35.6002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvS9teLdj/YlCR0aFeEvEIIkazBw0SrsDeKbp52mN8X90RXo+wFWRuyxA3pVghMojvOscCykGBcMIYr5MdLK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, February 3, 2023 11:03 PM
>=20
> On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, February 2, 2023 3:05 PM
> > >
> > > All drivers are already required to support changing between active
> > > UNMANAGED domains when using their attach_dev ops.
> >
> > All drivers which don't have *broken* UNMANAGED domain?
>=20
> No, all drivers.. It has always been used by VFIO.

existing iommu_attach_group() doesn't support changing between
two UNMANAGED domains. only from default->unmanaged or
blocking->unmanaged.

Above statement is true only if this series is based on your unmerged
work removing DMA domain types.

>=20
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!new_domain)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > > +	ret =3D __iommu_group_set_domain(group, new_domain);
> > > +	if (ret) {
> > > +		if (__iommu_group_set_domain(group, group->domain))
> > > +			__iommu_group_set_core_domain(group);
> > > +	}
> >
> > Can you elaborate the error handling here? Ideally if
> > __iommu_group_set_domain() fails then group->domain shouldn't
> > be changed.
>=20
> That isn't what it implements though. The internal helper leaves
> things in a mess, it is for the caller to fix it, and it depends on
> the caller what that means.

I didn't see any warning of the mess and the caller's responsibility
in __iommu_group_set_domain(). Can it be documented clearly
so if someone wants to add a new caller on it he can clearly know
what to do?

and why doesn't iommu_attach_group() need to do anything
when an attach attempt fails? In the end it calls the same
iommu_group_do_attach_device() as __iommu_group_set_domain()
does.

btw looking at the code __iommu_group_set_domain():

	 * Note that this is called in error unwind paths, attaching to a
	 * domain that has already been attached cannot fail.
	 */
	ret =3D __iommu_group_for_each_dev(group, new_domain,
				iommu_group_do_attach_device);

with that we don't need fall back to core domain in above error
unwinding per this comment.

>=20
> In this case the API cannot retain a hidden reference to the new
> domain, so it must be purged, one way or another.
>=20

Could you elaborate where the hidden reference is retained?
