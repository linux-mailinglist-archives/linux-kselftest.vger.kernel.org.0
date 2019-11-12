Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC28F9E52
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2019 00:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLXp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 18:45:57 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:10113
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfKLXp4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 18:45:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJiwN5YxrytMCzVdav2ElxEHLXuBfXkCwn+d9nRuW1AGk8lNBbBapQB8ddCsD9X7yDSlmJOP+CtFQdREunMVawuxTR9mwDLzvbi0xw+Ymf7v8k/hpd24WMgg6Xhu21g+YT4YmaQvUbCvwv15HtoA/IBcDM8GJBZu8eokX76zKDhRgf1DibfE4D9W56J/b+m7RJ2s++6pcrYAP7n+Wc9OwNN0p/xE1o37s1Si1b8LttMXAtYrByU72n/PqOBoPiID7RL9MLz2R9BjnNNLD97ios4WpPhob1SPvJFpc6WFxxTkntgHqy36UxpPK+m3oil+5ve5of3znXDeh/Bfwacw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skoDK31U0/7SDkc3ZpaX+MWHCrcSYVcNoz07elFWxKE=;
 b=LW/KWRFGfWeb3vr/UCLnY3MkDQyPRnsvD4uf+r3sKVEGXKKVwysZsVgGz1xFt+owNthjBAkwo4yrDvOB5Q8iAQGC09V1fs1hQFwqm8ULvuMiJu3d7R+xmh214WvTca/jE3FISZJFRYZdS6MGp4G05x8AnU4sJpZ9tRhP5OPHEAFJ0t9GYvqcxgun4zTegJhzMJKgk+Y4JtR2tEfzzx1e7+TQo+GM+axoK0PB/tSpzoZu46jsbcDE8pGB7QXgJa44+y1PfVakfOyVfADe7nmuTTpDugAdmcId5aRnrZKyVA6n2UgcxZ527aSXLmo20eKqAlg8Q8xYm+EDwWHx/NO46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skoDK31U0/7SDkc3ZpaX+MWHCrcSYVcNoz07elFWxKE=;
 b=Z/Vffv5huEvFCw4I22gKLJhWhCVToIU1sjt1ThVs0Zas3VjoVekVnHz42iVdNPU3EgszcPS39FUDAYz04WlPzQGIVidEUVIlGZ7xi4vtr3qHOe40r8szM2EyDF7SWAj2ny55GwEOXdLxMpnAwUkV9u3JmE7LSJ/7EjvcF6cwxOw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4958.eurprd05.prod.outlook.com (20.177.50.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 23:45:52 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 23:45:52 +0000
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
Thread-Index: AQHVk15BHkNBC+HAokukKxKzDG+3w6eHtA6AgABrzYCAACAHgA==
Date:   Tue, 12 Nov 2019 23:45:52 +0000
Message-ID: <20191112234549.GX21728@mellanox.com>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de>
 <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
In-Reply-To: <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:208:e8::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd714597-929c-406a-8a71-08d767ca73fd
x-ms-traffictypediagnostic: VI1PR05MB4958:
x-microsoft-antispam-prvs: <VI1PR05MB4958DC049DE912254177A423CF770@VI1PR05MB4958.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(6246003)(14454004)(2906002)(7416002)(14444005)(256004)(8676002)(8936002)(81156014)(81166006)(4744005)(5660300002)(4326008)(6486002)(6436002)(229853002)(3846002)(6512007)(6916009)(1076003)(71200400001)(25786009)(71190400001)(305945005)(7736002)(6116002)(386003)(6506007)(99286004)(76176011)(86362001)(102836004)(316002)(486006)(52116002)(26005)(54906003)(36756003)(33656002)(476003)(66446008)(64756008)(66556008)(66476007)(11346002)(478600001)(66946007)(66066001)(186003)(2616005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4958;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwrEwufdOhJnbn0VmgOE440YYxCz3gIlVfovu6drMVFTKTxpViYeNVcdpMMw5aGUA3skjtBd/dBIDBGdneVBmdQeaCdNvmdO0ZU0XSk8acFakrbLo8VRYgMMQzjSdsmb0Y41dDtoFuBQSlZZdGtWTuGmiBSUUiNZrRvJE6jlvTUsfOyIleF9KT+xa/i4nR4otnQyI/HXE3JX4VTlU8gZaw9m5p42E1Xl+Al+YH80dQ9isqdbNc1RuxBIiMxWzKw8Znyg4m9ZxCEhDNYS9EUwK4WT6ZO/QdcsQ4bWdcR1T5GkoNAy6A5nn5cOvX32Q2WAVO74a6y1V9GKW4WOpSOhmg2woeFRUAyD3p48Efxh7XPvgM/pv6fet0lOT8qBgu9/HxLvBrc5wFrm0Ifr4a15uwRCnuNLGP9nGtEjzinNvT2YcjhGRMyKVC8SNQJxJ2Tr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F4164E7B161C4499113C50B183C779A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd714597-929c-406a-8a71-08d767ca73fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 23:45:52.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ateme6P/6lZt75AAoy5NBSqzB+PRwXltwwp28YrIrRGsPPP8sgJQ74lRo2/1RZkHAkdmFXlf0/SuxNLIYZKYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4958
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 12, 2019 at 01:51:11PM -0800, Ralph Campbell wrote:

> > > +static int dmirror_invalidate_range_start(struct mmu_notifier *mn,
> > > +				const struct mmu_notifier_range *update)
> > > +{
> > > +	struct dmirror *dmirror =3D container_of(mn, struct dmirror, notifi=
er);
> > > +
> > > +	if (mmu_notifier_range_blockable(update))
> > > +		mutex_lock(&dmirror->mutex);
> > > +	else if (!mutex_trylock(&dmirror->mutex))
> > > +		return -EAGAIN;
> > > +
> > > +	dmirror_do_update(dmirror, update->start, update->end);
> > > +	mutex_unlock(&dmirror->mutex);
> > > +	return 0;
> > > +}
> >=20
> > Can we adopts this to Jasons new interval tree invalidate?
>=20
> Well, it would mean registering for the whole process address space.
> I'll give it a try.

I'm not sure it makes much sense that this testing is essentially
modeled after nouveau's usage which is very strange compared to the
other drivers.

Jason
