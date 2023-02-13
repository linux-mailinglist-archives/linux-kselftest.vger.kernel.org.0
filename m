Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20634693C27
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 03:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBMCYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Feb 2023 21:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMCYs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Feb 2023 21:24:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9ECA0D;
        Sun, 12 Feb 2023 18:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676255087; x=1707791087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HW6aPPyQxa+rIXEwWqQuJoNMy/5COa0GFHkv4mF9zqM=;
  b=PEJKzHf2vs18lY+AHSNbulJtvT0CCROIDooegR5avZoJSK0nFz/4/ZEX
   b35z0mB/GqdrOAkuAjZHN8eXN1Qs4cX7yT8INw4NQ6SeAm9G/J+ayCGnl
   Pgmniodl2/Bo6UGyW4y86b5ygbfEjJz6cHnj6HvVbzOOzunEBDZZXtHvk
   Lu8ODLlbsciFgex/rPVjG7E+5lKTMNgEvcYyvtQglyxhvTrh8+OGH7rbH
   3g3Q9SQnvuW+sX/qqpqSUCV22ADvrLV2q09uYQc23AFjoCUy/O4lMV+f5
   Y2G13wykkBZ9KAfElV8BKYBiHOTICNSzhka2/i3COqcmOCnVkJ7l841iq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310425060"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="310425060"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701103368"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="701103368"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2023 18:24:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:24:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:24:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:24:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:24:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsNa54JcbplcUJCOkF3iYRozFKxUgu88t6vKv2BjGmN+DAJ1fVRy4wRt9r5rVWMf5XwYln+fOzGikEmDzLD38kzaHI3GeVCXzIYJhFZYd3iRrlQ9UhDIz88uU3p3zQh1VHJhgxlixDnq9z6ZkI2an4wYAtOhSBZywNAdyCQhCU0uM7j5sBMg8ZLoYxXVaG66Cc+ik7rjYIvBLU4mdR+xZ4pBCh13pTawSyUVJGEZa4OW274jlaLBT4Sm+92XmsWlehJZRFLJgv2t1JKebPedmjYy4mmyx3wYK1G5AGapLRCctuOOb9Cp2d/tuohE6ocHVlahQfRRLy0f1Wyj2Q0pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTmskC5h4pZjnzd3YUx9B+4t9gwWkpBx/A38WNlERSk=;
 b=JbvgTwOBwceJQoGHQ2Qt6cOGU3t2Uk/xB9oZh52UmpY7OhdAg3OkWrkQ30xaxLfw6tLPCMghiVfmIsokampa2IBfzUCbwXeUOd68MblEi2VZHLPG7wafEta5Tmigp6qx3sifoBEmweaRZ/AimtFsrt1tqXRujygSfeOdLXsQg0OxOpaAnAzffmaN5Zu6eOhyQhRrI5qkWuHElvCbwcwT8yTHFHyur1J+sxMh2Zq8Nn6vcr96IsL4fO0P2Ga0LQgker115pEgwHfCO6i90v0ThKBlTOQTAscNh9/P9Jv+x4t2THFn8+TGiP6a978CROTToGqipG5lesFA9qc1fX+YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 02:24:41 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f%8]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:24:41 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7I3qUAgAAO8wCAAz6N0A==
Date:   Mon, 13 Feb 2023 02:24:40 +0000
Message-ID: <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
 <Y+bk+GSCPKOJfr1f@nvidia.com>
In-Reply-To: <Y+bk+GSCPKOJfr1f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|IA1PR11MB8224:EE_
x-ms-office365-filtering-correlation-id: 58f43eb0-0ed9-42ea-225e-08db0d697648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPl/oKiX7bul2cd9ugVsI+QB7yLUerer54KoTeUBEKj5Xnwx/a/6Ug8OiGxX9oleQ6TjYgwsrxDMGInzmbcvGWg1GGg5hUoArFH7Rc5CIosSaprhAvLo1Dabhps+8251zSTBVmc69vWs9SF6TGZRo7ysS8n1FRig+v/OqBtGrJf6Dz+IYBXZ+50y7EOdEZ6zv1jvB6kJB6kDCXZDe+OHjw7YpPRVNskDekRUoW/zobEU+2QlsWwbjHFw8jlRw8pfhWO3TbXSdpjZkxqD8DKAx0VDHnXDjlNr2xc4ZRt/3qL/PS0hgP7AxAGG/b34YH2Db0QgAn3PlioeEhRmoyK5wQSMNsMNSjC+e/Ct/1zsAkksdVH/jJtjZ7Oi/7t87P6a1+3033Bu4p29MNZ8AfeePPlRLmDhU2YW2jnR04wT07kkTsNKys30NIDoz8n5fCI/+UuhDOVYjTFjOETA9RTNSg7pq3Uco1Ij6klk4dJNBndsMXS2NPRWQVEbC9mKms6Mo4YnWz6HoBMF5TyuXLVuhqOmYag3UBrQmcx/pDz0IW9e1qx+GQ3P1CxDb4SbsSVa83bSUTjygnZA4I8JeX3Y4kQSk2V0zUYnBO7s6w/34P1vUjkmMOMHLilHfpGuvR9wEPB3olM0n/JRlhsRZyvN57Y1rH8Pu87X3XrCIWFhaA7t5kbnknuxu3JdO28wyfNwF1PZ1y3MlAZD2ZnXIFnpkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(26005)(186003)(71200400001)(9686003)(7696005)(316002)(54906003)(110136005)(6506007)(478600001)(66556008)(66946007)(76116006)(66476007)(8676002)(66446008)(64756008)(4326008)(8936002)(52536014)(7416002)(41300700001)(5660300002)(83380400001)(55016003)(2906002)(82960400001)(38100700002)(122000001)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8Gu9WcDygJzHe+nm7wyb7G6dvHnjA5PnRfABhqYNX89XjkLgCY9xnL6fgF3?=
 =?us-ascii?Q?Icj5Jhst4J1u0eCPcLki3vwISByQayTHV1Z689RIVsgSdQQMzWRtuSofaDOE?=
 =?us-ascii?Q?tNiLq6YuodvwvvgPesbNFv5Ft59gL6lV9IGc3qaSWXWym6FsCzm9KIIU2n/o?=
 =?us-ascii?Q?R3s0ED9/ppF6nQnak5P/UnPy8NPdoqz7SZYDyZEO6OtwRjcz9dA7w8iI9y/u?=
 =?us-ascii?Q?Cy72eslstgWPOY/ok1L+iA3Wwdoj9AswAd/nA+wGGkn9u9YtiqmbJCu+dsTu?=
 =?us-ascii?Q?69nMfjwDY0bkCOnZ1IVc6fvYiahGKLHx5oLthGsxylVhLFs3bCthcDDujclB?=
 =?us-ascii?Q?EfKTmLjNllL7v5/YFQlQ8rZ5hqenvNLFc+SNBB0SujkCX7r+LjPvMy0attoi?=
 =?us-ascii?Q?xXc23TMQV1wqsyK5BSZ7Ak6hVbVz9fwCf+ibcL5EtMmstGmaeI2nc98euxpO?=
 =?us-ascii?Q?esl9i0+tA6G5FNg6x/5TkkGFKEbkCTybK1KH34s3Az4cfDxs/9wQhxI3bWgl?=
 =?us-ascii?Q?5DKxK4hlyABtRxJbDCivVhXxQTfIpQgvPkwidSk9SyXrYYE7vp+0mTVXlhLU?=
 =?us-ascii?Q?JO+HsTOD5/wmictVZReKNMtI0Mna8xB8zCiwnu+E20ex7mcNbypyqshnmt2q?=
 =?us-ascii?Q?QAGqRl8kGeJ+e2VselnUR+MosWvqo0OflWP9MMx7xBZiJXCVbtVUmdFUBFCI?=
 =?us-ascii?Q?liR0iiPuxYJuMFcgrqOOdM7IlBNsZtzoboePlhASCspb++9GDgP7fdUtwBiD?=
 =?us-ascii?Q?zrdeqdpopT18ZaF+WLADot0/8JTqo3frH4sR8bFBe4ua35iVhjnYsMTctvA7?=
 =?us-ascii?Q?wSn4L8KgjvxuLIBNR20oWXpMv5Myu3fd0mDw0Q0zHfHv88yr2LjlNzDH/JLs?=
 =?us-ascii?Q?csadIxjot6q9Ik0pL8BZUsAdNPom13+YlFZ5KxzXlY2GVWjSFDA1xEO0R+uC?=
 =?us-ascii?Q?hYOgiXlkOwoTNdlJb31BA9VKkp2JJjjHLPk8FlZyH3kNKoG8L3Zk+nUn9khO?=
 =?us-ascii?Q?k8q7FZsaXObemFHPg9HguufwcBIOS63eweOhfeWD/U0/PB+mmu0u6pv0B50J?=
 =?us-ascii?Q?VSSMVMqzgKnYf4vKIvYQtj5NdxJPhSlZU8thTF/9aPEAIogueII8jZ8f+MMj?=
 =?us-ascii?Q?W9HxsEllXM2z+idwllsynOOk9Nf0BY4J4l3nYrl402wqPvG4VjsUEEDnFpld?=
 =?us-ascii?Q?NhRczzIiApPGfTF4dFmBhLlky9MIKoWaXiXS/U08w7GDdd/WRoVThp/HkvS3?=
 =?us-ascii?Q?h2ox0HA7KxWxrP+X02I48OHe/Aqi3EFp7NIqVQm6f6kVCrxwuGyg5TQ46scP?=
 =?us-ascii?Q?UQIcKGR2Ck1NdrE7TVCWbr24ZqiYVk3xhNweQas8l3UYXXlSqhV5JCkSWlph?=
 =?us-ascii?Q?9mAJ2oO4kv0qYbq/t/5toILuAqw5fEnywxKpM9pEm28LIYESh2Lnvd8Av7bj?=
 =?us-ascii?Q?1uoKR06dAT9UedqIRZ7fCFYMFVaxAbmij15bsRUlTdx45Zv5TtUdRK/ekI7m?=
 =?us-ascii?Q?qgluMDT5+57EifiNzV5Kjpz5K3yRNG8yL6oBP8XLAGTaFSqND+Q4bXiCk4HJ?=
 =?us-ascii?Q?S4z+ADKlArI4CmE34BIYl7QHwG3YQ04oqyUHb9Id?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f43eb0-0ed9-42ea-225e-08db0d697648
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:24:40.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mzytyv89KA2GbDRZ25A0shfku0ckZaW13HB/vVqbKkIcEWjrdK0GgOAdQldp17OFQIRlIMW9JYw8nt6/t4NI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 11, 2023 8:45 AM
>=20
> On Fri, Feb 10, 2023 at 04:51:10PM -0700, Alex Williamson wrote:
> > On Tue, 7 Feb 2023 13:17:54 -0800
> > Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > > qemu has a need to replace the translations associated with a domain
> > > when the guest does large-scale operations like switching between an
> > > IDENTITY domain and, say, dma-iommu.c.
> > >
> > > Currently, it does this by replacing all the mappings in a single
> > > domain, but this is very inefficient and means that domains have to b=
e
> > > per-device rather than per-translation.
> > >
> > > Provide a high-level API to allow replacements of one domain with
> > > another. This is similar to a detach/attach cycle except it doesn't
> > > force the group to go to the blocking domain in-between.
> > >
> > > By removing this forced blocking domain the iommu driver has the
> > > opportunity to implement an atomic replacement of the domains to the
> > > greatest extent its hardware allows.
> > >
> > > It could be possible to adderss this by simply removing the protectio=
n
> > > from the iommu_attach_group(), but it is not so clear if that is safe
> > > for the few users. Thus, add a new API to serve this new purpose.
> > >
> > > Atomic replacement allows the qemu emulation of the viommu to be
> more
> > > complete, as real hardware has this ability.
> >
> > I was under the impression that we could not atomically switch a
> > device's domain relative to in-flight DMA.

it's possible as long as the mappings for in-flight DMA don't change
in the transition.

>=20
> Certainly all the HW can be proper atomic but not necessarily easily -
> the usual issue is a SW complication to manage the software controlled
> cache tags in a way that doesn't corrupt the cache.
>=20
> This is because the cache tag and the io page table top are in
> different 64 bit words so atomic writes don't cover both, and thus the
> IOMMU HW could tear the two stores and mismatch the cache tag to the
> table top. This would corrupt the cache.

VT-d spec recommends using 128bit cmpxchg instruction to update
page table pointer and DID together.

>=20
> The easiest way to avoid this is for SW to use the same DID for the
> new and old tables. This is possible if this translation entry is the
> only user of the DID. A more complex way would use a temporary DID
> that can be safely corrupted. But realistically I'd expect VT-d
> drivers to simply make the PASID invalid for the duration of the
> update.
>=20
> However something like AMD has a single cache tag for every entry in
> the PASID table so you could do an atomic replace trivially. Just
> update the PASID and invalidate the caches.
>=20
> ARM has a flexible PASID table and atomic replace would be part of
> resizing it. eg you can atomically update the top of the PASID table
> with a single 64 bit store.
>=20
> So replace lets the drivers implement those special behaviors if it
> makes sense for them.
>=20
> > Or maybe atomic is the wrong word here since we expect no in-flight DMA
> > during the sort of mode transitions referred to here, and we're really
> > just trying to convey that we can do this via a single operation with
> > reduced latency?  Thanks,
>=20
> atomic means DMA will either translate with the old domain or the new
> domain but never a blocking domain. Keep in mind that with nesting
> "domain" can mean a full PASID table in guest memory.
>=20
> I should reiterate that replace is not an API that is required to be
> atomic.
>=20

yes. Just as explained in the commit message:

"
  By removing this forced blocking domain the iommu driver has the
  opportunity to implement an atomic replacement of the domains to the
  greatest extent its hardware allows.
"

API level replace only implies removing transition to/from blocking
domain. and then it's driver's call whether it wants to take this
chance to implement a true 'atomic' behavior.
