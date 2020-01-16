Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35CA13DF6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 17:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAPQAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 11:00:13 -0500
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:20230
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgAPQAN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7iuwfJMW/KTuiV1yeKh2Z7kplBtIe4fTUSSO0HHsRPCkOzA/xkGYD4Rr/ahoEj9Yfx9sI5Nliyc3OQB4DGkImx19cBH/X91jNllo+bhbPclMH5hsmEAxxOoYw5KxMjRyjEjdDXHlzM6/xrF7IIfJiCO+Ku20X1XzmEFHn0qwazJjWm5Yo2ai7sTKxuUlvn0NXPHY+ekScVkDC6CrfPh53OmNknhJKcGcLoJqyU39v6ESd0fHeQ8Y2+o+6o4SSdSqMuhBGGEWkFqzRqa41NvCqAkikNEniNmFFDz7/R5DHSa2hkVbgW1k+3m+05ZJEdoiamdS8stWUpGb+TjibKMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3tizVRyq4GUFAfNZmbiLXUnh733M/F+zveIQUtZh9o=;
 b=LQBA1LGzHXUtAs7ZH8Y0iLJY047XHSXtqpQLfl+s+16nvh0BFhG8IifrDzzEj1Tbv4iKgcT6XS7FICPTFcosbXjOOcVnOYHPklcr6QIiAKlnA10M4jqXJy39Z3U23F3EioOr2eqqj9c5mWc2MzLDDHbW/x//8Ztluej/y1rGx9kduJ921+2KAH4V3meaM1f0E3gDKpL424/1MGu7pEz5KDLxqmZK0IWVM5VnvqFpx0+zyfhDH9kJVwKN1mqYpeDQzkzqGzaADVUt7I4TmFAc0hIU5fZ6eFz9z580ExHWyfas0kzrdJfaLOtGgKM/l6BLXCkohyHbNjSQfMmuIgRQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3tizVRyq4GUFAfNZmbiLXUnh733M/F+zveIQUtZh9o=;
 b=nEBNDEmLL4utovFupHHfBAyxNQTrdAFDVy+U7z2HSF31naKLiUROZGEqgH2AlU0Lkqo+BvnBHf9M9639SZLNXxYLq+0nWNJjTlu7iTXE5ahSdSQJMAwLbaKSUri6Xp2GjTdVHoU0ySntb38+qmVt5l1QPENVFfxoXBVsjlLK7Gw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6768.eurprd05.prod.outlook.com (10.186.162.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 16:00:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 16:00:07 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BN6PR14CA0029.namprd14.prod.outlook.com (2603:10b6:404:13f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 16:00:06 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1is7Yw-0006Jf-JR; Thu, 16 Jan 2020 12:00:02 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
Thread-Topic: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
Thread-Index: AQHVymNqjXzbt52uukWssUL4CQa1/qfqIESAgAIr9ICAASsGAA==
Date:   Thu, 16 Jan 2020 16:00:06 +0000
Message-ID: <20200116160002.GL20978@mellanox.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-6-rcampbell@nvidia.com>
 <20200114125957.GO20978@mellanox.com>
 <5845f50e-8bc0-8068-ee21-4f910beb1255@nvidia.com>
In-Reply-To: <5845f50e-8bc0-8068-ee21-4f910beb1255@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:404:13f::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e34af3e-9c2a-4b8f-7dfa-08d79a9d2809
x-ms-traffictypediagnostic: VI1PR05MB6768:
x-microsoft-antispam-prvs: <VI1PR05MB6768856DE0040FF47E7CC132CF360@VI1PR05MB6768.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(2616005)(2906002)(1076003)(52116002)(86362001)(33656002)(316002)(36756003)(26005)(81166006)(5660300002)(8676002)(186003)(4326008)(81156014)(66946007)(9786002)(6916009)(66476007)(66556008)(64756008)(66446008)(54906003)(71200400001)(7416002)(8936002)(9746002)(478600001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6768;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDLgVCiLs+MqFDOwVfDiBXIGC09Ym7bo5DZw3ENsAUQfm5JiV+JBCqp+UiUAG2i+8lgizT8mVQlKOLGC/AmEUL2PI38NHdpGIOYuPYmp7Etins/V/J+GswH//CGYxspz/vRt65BgsPVfhCVzuuYiNZEf3ZvdG9nXATpbRouoOaUrM2mnEceSKq32krSDQwTnTdtxX5NudpsiOkFf77319St+1E0KYuBxawAJLmLBD2HJlM99YUu/gQS0IYAFBiHK78j4a4tB2kh3FmoI2g8QNQC2pGSTI138IekihHc3txY+qzuDuCnRpkAu2oShRkWXPmnavqNnr+UF66rYRuOP729Ixx3XkXFBcu5dZrAuOO6bcKft0blNeEl+l3uQzSQXZiVjtsyMfAEDNvbkTRKKbJME6eBZX/2LjIvMr4u3pN7QhZTNwPS7ENFhcfpdDy8EziM//Naws42hbdRkSRwxulCyfOposaeqGYuboL/sR0fuZV6RLCjOwz71mMu4V71J
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECF78F37AB44F842AECF3474CA80857C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34af3e-9c2a-4b8f-7dfa-08d79a9d2809
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 16:00:07.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFDusbytEkvVty7t1+keIrbzmOcOzhKbDwfejR/hlCLC6PyH+WGWJgHbxr+RmU/pLu0YlJki9Yd14H8BJm6XhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6768
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 15, 2020 at 02:09:47PM -0800, Ralph Campbell wrote:

> I don't understand the lifetime/membership issue. The driver is the only =
thing
> that allocates, inserts, or removes struct mmu_interval_notifier and thus
> completely controls the lifetime.

If the returned value is on the defered list it could be freed at any
moment. The existing locks do not prevent it.

> > > +		ret =3D nouveau_svmm_interval_find(svmm, &range);
> > > +		if (ret) {
> > > +			up_read(&mm->mmap_sem);
> > > +			return ret;
> > > +		}
> > > +		range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
> > >   		ret =3D hmm_range_fault(&range, 0);
> > >   		up_read(&mm->mmap_sem);
> > >   		if (ret <=3D 0) {
> >=20
> > I'm still not sure this is a better approach than what ODP does. It
> > looks very expensive on the fault path..
> >=20
> > Jason
> >=20
>=20
> ODP doesn't have this problem because users have to call ib_reg_mr()
> before any I/O can happen to the process address space.

ODP supports a single 'full VA' call at process startup, just like
these cases.

> That is when mmu_interval_notifier_insert() /
> mmu_interval_notifier_remove() can be called and the driver doesn't
> have to worry about the interval changing sizes or being removed
> while I/O is happening. =20

No, for the 'ODP full process VA' (aka implicit ODP) mode it
dynamically maintains a list of intervals. ODP chooses the align the
dynamic intervals to it's HW page table levels, and not to SW VMAs.
This is much simpler to manage and faster to fault, at the cost of
capturing more VA for invalidations which have to be probed against
the HW shadow PTEs.

> It isn't that expensive, there is an extra driver lock/unlock as
> part of the lookup and possibly a find_vma() and kmalloc(GFP_ATOMIC)
> for new intervals. Also, the deferred interval updates for munmap().
> Compared to the cost of updating PTEs in the device and GPU fault
> handling, this is minimal overhead.

Well, compared to ODP which does a single xa lookup with no lock to
find its interval, this looks very expensive and not parallel.

I think if there is merit in having ranges cover the vmas and track
changes then there is probably merit in having the core code provide
much of that logic, not the driver.

But it would be interesting to see some kind of analysis on the two
methods to decide if the complexity is worthwhile.

Jason
