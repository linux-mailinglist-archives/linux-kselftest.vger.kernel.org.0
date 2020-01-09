Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9F1363C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2020 00:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgAIX0h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jan 2020 18:26:37 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:23681
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgAIX0h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jan 2020 18:26:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUWMBUJC61Mma0kMuODmbSDPHP4m4BeCdHv+Ext1a70MKiQk4r1XUyiv3SDXTiZrq/MO4ScYUTFKN7RA0LTh2NumZ/qsHss/Mn7L1CM/aBScK7iWXiPoCdjD9Z6BtIejHaBbbXpgl/efcUWO1DrJ4JZQpSMeoPqz/ld/h+6RILBAq4yy7bH9O4FJMAQZe2XOS69otJTx4mYQXH4NrUvgQE2PZ6BqDmYZqkz9zG4x3zUnfYzuES7X+RvqsQiwsCSe/hSV6vutJ1HfGkzc14GYEEhQqy6j9SO1eYX4jli51nutEEUcNz50ZgjowtsvX7ujhQwsjFtlGQhg+vHzEFyHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIPL35tzUe8aLD265HECkUIaaxcEjrmQMKiY+PcYzxk=;
 b=JtoIAXObgaejMQ7EToP5WTkNc4jdn0NAhdM8xnSVL6Ngl7vizHWuJ3popJ14jgTk1o5B9kY564uxXIOYfYVJBdiBmqMBGRHzgkQOmxZv7j4BqmDHQE4kI2LG3HEbY5aPIMcsUX9hb/F8IiNVLcnbQKXLZBG0loFz6H57Zke/0Ld24vSkiD3IsyUsATCz6svHxnc4nu1ZaP62utQGiI4xRVc/Dx4RkAcBUXoU3mIpznBwcOEjxFqYpx81joN0rK8oxvJHAU3N5rc7vGAQ0jzEyvjp39uftTrcWmAPPFQDXnpShb9Hh8Dv4i/5op6lUIo/zak8HGRhaKE0XecQfx5Krw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIPL35tzUe8aLD265HECkUIaaxcEjrmQMKiY+PcYzxk=;
 b=WeB/U327GfFba08Tl7HM19G+vSiaQFXn0jTh5GKI/8LsofDbsKP3ewO80BR75tGNY59zENTa4BVF/Ox004umgZrZeME7Az+ucj/H78El+P0QSR4VNqQq0uVK/p8jn5FEnbN4D9w88tc9DwA7/wT/ZKr+LidL0lnIcUuKUgbO644=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4253.eurprd05.prod.outlook.com (52.133.14.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 23:25:52 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 23:25:52 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Thu, 9 Jan 2020 23:25:51 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iphBU-0000xv-Kt; Thu, 09 Jan 2020 19:25:48 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Topic: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Index: AQHVtEsczeksfKC51EmFDx7aa5U3hKfi4tSAgAAlPICAABeZAA==
Date:   Thu, 9 Jan 2020 23:25:51 +0000
Message-ID: <20200109232548.GO20978@mellanox.com>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
 <20200109194805.GK20978@mellanox.com>
 <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
In-Reply-To: <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d25df0d1-b9c7-43c2-9538-08d7955b4444
x-ms-traffictypediagnostic: VI1PR05MB4253:
x-microsoft-antispam-prvs: <VI1PR05MB4253FBFBA4D877B2CE165BD1CF390@VI1PR05MB4253.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(2906002)(5660300002)(36756003)(1076003)(2616005)(186003)(81156014)(7416002)(33656002)(81166006)(52116002)(66946007)(66476007)(26005)(66556008)(66446008)(64756008)(54906003)(8676002)(9786002)(6666004)(8936002)(4326008)(9746002)(6916009)(498600001)(71200400001)(15650500001)(86362001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4253;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkHr8W64E3DC8VAWi6KC8LHErwzDhDoM+f8sPMcV8cq4j56DYxdaEAeMo0rKDP80av0/GGUiknvmg7dxdHn4Qz98Nw4xO3JqVcjuoL9NimkKWgCWdSiwPKACeH85rGFeORYAlZ0pfqI57CLg786EP3yojqs2++1y6npmzcSwJL6dy1vSvZFOnn0Mg0tbi3ZdNIyK0stf86KUw4LL5Yn8xPfkaOUr+dEMDQNpO0sLvIele8WnPbcHfg2JAg+q5E1YYhLwjgNnPkCg/Gm+Qu+0jP2ErPilO/DIl1osWTTlhFElfvM4Kj0v84AxsIWAWCSm0+36gJbTMFPxi0ltik6PL88Gz9rPqitguwjjS6kX4euIVQE68WyiSEcJOKZaSvNeqeRk8BU4Amjl/PN8DJ+H4kecc0uB9gkbFKQW5wdXZUUkCSykAHs7XCPRG4zYw3L+bWWQCbqqEU52oo2pmb2J4yr4qQM8IY2pKIS0ERuIRBok34+GPIQ6x/5h37foo7wg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FD70D24FA98F84085481AF401873737@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25df0d1-b9c7-43c2-9538-08d7955b4444
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 23:25:51.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI42QODSVd8TnXohgJAgFQkUZ0Pbsvhos+llvnnvy4Mq6cqsbD0OsydhXIJkaWtv+UDcLxh/BMl+PICvU45ZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4253
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 09, 2020 at 02:01:21PM -0800, Ralph Campbell wrote:

> > I'd write it more like
> >=20
> > if (mni->updated_start =3D=3D mni->updated_end)
> >      insert
> > else
> >      remove
>=20
> OK, but I'm using updated_end =3D=3D 0, not updated_start, and the end ca=
n't be zero.

Tricky..
=20
> > ie an empty interval can't get a notification so it should be removed
> > from the tree.
> >=20
> > I also like the name 'updated' better than deferred, it is a bit
> > clearer..
>=20
> OK.
>=20
> > Adding release should it's own patch.
>=20
> The release callback is associated with mmu_interval_notifier_put()
> (i.e., async remove). Otherwise, there is no way to know when the
> interval can be freed.

Okay, but this patch is just trying to add update?

> > So why do we need this? You can't call hmm_range_fault from a
> > notifier. You just can't.
> >=20
> > So there should be no reason to create an interval from the notifier,
> > do it from where you call hmm_range_fault, and it must be safe to
> > obtain the mmap_sem from that thread.
>=20
> I was thinking of the case where munmap() creates a hole in the interval.
> The invalidate callback would need to update the interval to cover the
> left side of the remaining interval and an insert to cover the right
> side. Otherwise, the HW invalidation has to be extended to cover the
> right side and rely on a fault to re-establish the right side interval.

This is very tricky because this algorithm can only work correctly if
done atomically as a batch entirely under the spinlock. Forcing it
into the defered list while holding the lock is the only way to do
something like that sensibly..

So 'update' is not some generic API you can call, it can only be done
while the interval tree is locked for reading. Thus 'safe' is probably
the wrong name, it is actually 'interval tree locked for read'

At the minimum this needs to be comprehensively documented and we need
a lockdep style assertion that we are locked when doing it..

And if we are defining things like that then it might as well be
expressed as a remove/insert/insert batch operation rather than
a somewhat confusing update.

> Now the plan for v6 is to leave mmu_interval_notifier_remove() unchanged,
> add mmu_interval_notifier_put() for async/safe removal and make 'update'
> be asynchronous only and, as you say, rely on mmu_interval_read_begin()
> to be sure all delayed add/remove/updates are complete.

Hm, we can see what injecting reference counts would look like.

> I'm also planning to add a mmu_interval_notifier_find() so that nouveau
> and the self tests don't need to create a duplicate interval range tree
> to track the intervals that they have registered. There isn't an existing
> structure that the struct mmu_interval_notifier can just be added to so
> it ends up being a separately allocated structure and would need to be
> stored in some sort of table so I thought why not just use the itree.

Okay, but for locking reasons find is also a little tricky. I suppose
find can obtain the read side lock on the interval tree and then the
caller would have to find_unlock once it has refcounted or finished
accessing the object. Much like how the invalidate callback is locked.

> This is all useful feedback. I am working on v6 which addresses your conc=
erns
> and updates nouveau to use the new API. I'm somewhat sidetracked by the l=
ockdep
> issue I posted about nouveau calling kmalloc(GFP_KERNEL) from the invalid=
ation
> callback so it may take me awhile to sort that out.
> Since we are at -rc5, I'm guessing this won't have enough soak time to ma=
ke 5.6.

Yes, sorry for the delay, lots of travel and a mountain of emails. I
am almost caught up now. But you can post it at least.

Jason
