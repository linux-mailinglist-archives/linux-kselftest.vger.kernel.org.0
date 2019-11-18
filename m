Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F80100BA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2019 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfKRSms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 13:42:48 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:13303
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfKRSms (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 13:42:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQxScN7Okw2xNf7NosFLfOBezGGdLSpKyed8h3wIKqyGjoHqo3O4QzG9c036wskafB3cZrArXLCzVubpzDrVWGvvraetFsAg4k9c5kVEaoAwln+WtM2Bo456IQIUK0s8qDNsVq4DNL5T6Lc/uad+3giJAyhOp9hIWMe/9WR19OUjQafby4Mfj8Zu9fkKMarw/TLdHIPg3j3TtU+wjYXMg3EEk9HRPUR8WS2l1dri9rttpSvRe2hAjEk9okLyUXKJmcq292FOKwd9yb8Y0KmWbjIOiPCmqhk/Q0TzkQQBe53D1qSLhBWAtfw3M4DXqUWSYq5B4Zky/MjlyaMgAveXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMLpku29i5OKHjSrTDwwuTWkVK9OVoaoR5LR+jEYWc8=;
 b=HlGfP38ocKhsRVxTDv+U0htbpn4eyDbZrmwhBZsM0aOMEq6QfGM1/IwzAAfSNGVwCWLjb7TzcV7+9LoWe4XIG7o5U5Wg/vaMZEWHuWMTsrmbkWtj9xJ+/lh9SEIyr6J0d+hPRcqjiASzldvpuK9Ke1hDcOX400wrsWIf2xEWYJ9xd436k1Jz9hOeyW+Mz/FjMCiQBdD38NE5OUHwHxeqLXp340L7QgvU8zo1yb8+xEJ4boLHPiJQ6sQFAEeGjHgYS3GA1s96kMmR75kTvuMA+smiQlP+hUq59xyaPXRhTujUvQIEVtrGJUQ5KkSY7CCtS+iRLP0aikuuolHnEbZcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMLpku29i5OKHjSrTDwwuTWkVK9OVoaoR5LR+jEYWc8=;
 b=fwHk/WP6oFetwCg7hda3Iio/aqqu6/7/fq/4+OXOeQ037dm+hlUT3Hbvahndm1gDd15hS5FBJmAnepLjC5N7KJOwiVMIT8PFSvl4Pk+jSfrE/xG+0RB3D4VxR3urlCdwmbAflaJ2lh9VGosaPu2fxP1rI/O/SarUu2o/5f6livg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5309.eurprd05.prod.outlook.com (20.178.12.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 18:42:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 18:42:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
Thread-Topic: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
Thread-Index: AQHVk15BHkNBC+HAokukKxKzDG+3w6eHtA6AgABrzYCAACAHgIAA7DaAgAItWoCAAPuFgIAFAVAAgAAC4wA=
Date:   Mon, 18 Nov 2019 18:42:42 +0000
Message-ID: <20191118184238.GM3873@mellanox.com>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de>
 <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
 <20191112234549.GX21728@mellanox.com> <20191113135115.GA10688@lst.de>
 <21d6b69c-3167-e60d-eed2-65bb1f8515ae@nvidia.com>
 <20191115140619.GC3873@mellanox.com>
 <912f9f23-fa2a-1dd7-3f91-f7175094c2e2@nvidia.com>
In-Reply-To: <912f9f23-fa2a-1dd7-3f91-f7175094c2e2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:94::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a602b41c-3d70-49cb-1420-08d76c571887
x-ms-traffictypediagnostic: VI1PR05MB5309:
x-microsoft-antispam-prvs: <VI1PR05MB5309C4A657FF1768589ED8D3CF4D0@VI1PR05MB5309.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(2906002)(66066001)(102836004)(486006)(386003)(53546011)(6246003)(64756008)(6506007)(25786009)(6116002)(1076003)(81166006)(4326008)(71190400001)(71200400001)(52116002)(3846002)(478600001)(186003)(6916009)(7416002)(99286004)(5660300002)(476003)(2616005)(54906003)(36756003)(446003)(11346002)(81156014)(8676002)(8936002)(86362001)(6512007)(33656002)(66476007)(66556008)(7736002)(305945005)(26005)(229853002)(76176011)(66946007)(316002)(6486002)(66446008)(256004)(14444005)(6436002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5309;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuWMY9qw9hHjK3xcQjTitZJB29Ck9bDohoFIGyFo7rfbBzbZK6yqm+xLxv2/rb2Waf+KtEEhdMYcbULGibdjxKOm6olIZSLQh1tZMS8qyx0s7rM7w1vOhkNQruClu9C7MyVN4mw4PMF6Kln2SiFwCiJdT3gkSXWHOSfFXHhYO6hNZnY07bM5o+AKXvh2VdJwhINuzqh6eGPIH45NCec0f75sOEdSv/DZ5Ghj2e4uuEjAMOQpC8xJF6AW7w/GZLb2VApTXv/eOX+86Wo1mKWbkmZVMtB7g4SSlQ0dlqoH/aRVBnmEioMEB50IflQAg10dtCXDWeqHgPWK12QV6DtYTojwK92cz0hnKBWipIksYbxjF1zrwX/tzb5iGU+XYdI3wPoDmA3tGf+SSj+10pb8OZnV6ZOTHTstIBG3F8gAinDIhXw1xGD2CVFfmZg8G0H6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2F15A664668AA47AA0062EC11B2C81B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a602b41c-3d70-49cb-1420-08d76c571887
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 18:42:42.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYAPuVNlmW3yvq1nJKfWoyZOjZkriCfra8oewrJWge1iCIy8Ydr4B6YyT3izJj3GoQKCwLS/+ICadmwXHDLH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5309
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 18, 2019 at 10:32:18AM -0800, Ralph Campbell wrote:
>=20
> On 11/15/19 6:06 AM, Jason Gunthorpe wrote:
> > On Thu, Nov 14, 2019 at 03:06:05PM -0800, Ralph Campbell wrote:
> > >=20
> > > On 11/13/19 5:51 AM, Christoph Hellwig wrote:
> > > > On Tue, Nov 12, 2019 at 11:45:52PM +0000, Jason Gunthorpe wrote:
> > > > > > Well, it would mean registering for the whole process address s=
pace.
> > > > > > I'll give it a try.
> > > > >=20
> > > > > I'm not sure it makes much sense that this testing is essentially
> > > > > modeled after nouveau's usage which is very strange compared to t=
he
> > > > > other drivers.
> > > >=20
> > > > Which means we really should make the test cases fit the proper usa=
ge.
> > > > Maybe defer the tests for 5.5 and just merge the first patch for no=
w?
> > > >=20
> > >=20
> > > I think this a good point to discuss.
> > > Some devices will want to register for all changes to the process add=
ress
> > > space because there is no requirement to preregister regions that the
> > > device can access verses devices like InfiniBand where a range of add=
resses
> > > have to be registered before the device can access those addresses.
> >=20
> > But this is a very bad idea to register and do HW actions for ranges
> > that can't possibly have any pages registered. It slows down the
> > entire application
> >=20
> > I think the ODP approach might be saner, when it mirrors the entire
> > address space it chops it up into VA chunks, and once a page is
> > registered on the HW the VA chunk goes into the interval tree.
> >=20
> > Presumably the GPU also has some kind of page table tree and you could
> > set one of the levels as the VA interval when there are populated child=
ren
> >=20
> > Jason
>=20
> I wasn't suggesting that HW invalidates happen in two places.
> I'm suggesting the two styles of invalidates can work together.
> For example, what if a driver calls mmu_notifier_register(mn, mm)
> to register for address space wide invalidations, then some time
> later there is a device page table fault and the driver calls
> mmu_range_notifier_insert() but with a NULL ops.invalidate.

I'm saying drivers shouldn't do that, it is a basically a hack that it
works at all.

> The global invalidate() callback would get the device lock and
> call into mm to update the sequence number of any affected ranges
> instead of having a range invalidate callback, and then do the HW
> invalidations.

No, I just finished eliminating all the range iteration code in the
drivers - and you can't update the sequence number from any place
other than the interval invalidation callback anyhow.

Jason=20
