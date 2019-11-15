Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14BDFDF9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfKOOGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 09:06:32 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:45636
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727380AbfKOOGb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 09:06:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3m04HQOKz6ZcXFJ4QabobcTIehIIhDM8SgTtgSjTp7z75AhcrEu8cO16GUfSOyBZKY6/mgesc2pgjanWjHgEbxENDcaGxYJ4Ef4GWo/ly9p8HeJkSyd5oaDx+l/9KjRqw4mCIrXSq4B0/p4rkNHUPxatPidcmQN5To+TtD2jvHbKuOyouiBb1fc+oNxNHKAgdMjmCVNw57NTbYf/o2xWVuu2s8GRxV5Ll6yF9kmSW2/qI5rmdm7MrCJ0uCwmUVFEX4m/cZ52Sdhy1QRRFBGPjfClVW7PCefa4AUlOVa2vfN2Qy389e02kaBrS6VdEYZwUBlk3mt3dsH6z3MOjPlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEIgOmwhC+nXWHcSSoAy8zB7I2+gpjMezVcCEKNCeZc=;
 b=nqOwuxl9kjoX7KiVzW1OVYnXcP5CzE8RmR0EAiOAcWYayvKZsju4I85FJcf3zatKpFp4GJE5STtGxNLL1rO8TWgBOLmDJUioKNdwxGqcQLhaH+RquSNNfzqkj8vzTj9RDNRHSXPr/fJ5nUWCw4fPQrfYp3UMXZwhRAwtpbjN6GB/A1VZOERXc9sCefoCB+qsUet0S3YmJVY3Q1W5EHmVrG6FFfUKetB5fHoRBJlHBj7K8O8hHG3oOsvoeTSRxiEZInDjWnZwqCLFwl/smCVx+Wb6vZFHiOTxSfdBrijhBRK5O1faWVjp34+CvpxSNJm0qNFzCkhn7ULMqLLu1Dy+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEIgOmwhC+nXWHcSSoAy8zB7I2+gpjMezVcCEKNCeZc=;
 b=iy7AzixiXXs8Q+Gf40cbxV8nUFF1TlpgX49rV1Pleoidz6MJvHxsRh8skMtnP8GSt+cz1AHlg0tkgYftSMrxWjwJVuNqbipxNZTDMtwCBwGfJVsf/HmKhPwCeSNonbnzsGKL5q4w/TE5d6xDJp6CepSO1Y8XATt4yASB/U/zTEA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4861.eurprd05.prod.outlook.com (20.177.51.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 14:06:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Fri, 15 Nov 2019
 14:06:27 +0000
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
Thread-Index: AQHVk15BHkNBC+HAokukKxKzDG+3w6eHtA6AgABrzYCAACAHgIAA7DaAgAItWoCAAPuFgA==
Date:   Fri, 15 Nov 2019 14:06:27 +0000
Message-ID: <20191115140619.GC3873@mellanox.com>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de>
 <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
 <20191112234549.GX21728@mellanox.com> <20191113135115.GA10688@lst.de>
 <21d6b69c-3167-e60d-eed2-65bb1f8515ae@nvidia.com>
In-Reply-To: <21d6b69c-3167-e60d-eed2-65bb1f8515ae@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:70::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70c282fa-5277-4624-2508-08d769d501c5
x-ms-traffictypediagnostic: VI1PR05MB4861:
x-microsoft-antispam-prvs: <VI1PR05MB48613520615E334F45E5BC2FCF700@VI1PR05MB4861.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(76176011)(36756003)(478600001)(14454004)(6916009)(33656002)(25786009)(6116002)(3846002)(86362001)(256004)(14444005)(2906002)(6512007)(6246003)(229853002)(6486002)(6436002)(4326008)(66556008)(8676002)(81166006)(81156014)(66066001)(8936002)(71190400001)(71200400001)(386003)(64756008)(66446008)(186003)(316002)(52116002)(1076003)(66476007)(26005)(53546011)(6506007)(99286004)(66946007)(7416002)(54906003)(11346002)(102836004)(2616005)(446003)(7736002)(5660300002)(486006)(476003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4861;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9o+SXMZCoTFB1JPchXi07DbCHczLjbPBhBzUA0fBinOo7b32RrmQFXjBSJHJETPUKj7cO2fbIvndW1bQ3arNXgyvIrh+L4MLwXQPbDk5AK5sfvjrTWtRYY5em0UrOFNSkWBeOW7WAWqVlyk0uNStnhsLK5V1MJ9b/RicFu/utDM343fptiPv6x8qWnRjf7w+RuGhcsBH9uj1V9BHS/eXHwVhP3hcNdhOjOGeVapImXbMIFZH8exhvn4tKAYynFFF7cXlJGJzO4njMeksFuxzAvl+xoRV4w/hLhE5F0s9+YsXpjhDN7qSXzh4KoOnPEs4s4Wu28TrQpazhrB24ljyUJdq6IufkpScIIWkihG8MSyOatD+skybukGkH85AZ8zo7pj5TAv9mHSteg4dM+lQ3+IjhvLZ4srihXkmAUdlGXxuwSBHL/LfPvzJDLEeYGn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA2873D830377645B91FD516E9BD997A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c282fa-5277-4624-2508-08d769d501c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 14:06:27.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ciU3MFxeJpFMEfvqh5B/SvAwI3gSNG3JjyEkpY+ochawCXvXpi8m2ZI2GTdDd0TDOGOjuD5GTk1yQyn7flgjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4861
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 14, 2019 at 03:06:05PM -0800, Ralph Campbell wrote:
>=20
> On 11/13/19 5:51 AM, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2019 at 11:45:52PM +0000, Jason Gunthorpe wrote:
> > > > Well, it would mean registering for the whole process address space=
.
> > > > I'll give it a try.
> > >=20
> > > I'm not sure it makes much sense that this testing is essentially
> > > modeled after nouveau's usage which is very strange compared to the
> > > other drivers.
> >=20
> > Which means we really should make the test cases fit the proper usage.
> > Maybe defer the tests for 5.5 and just merge the first patch for now?
> >=20
>=20
> I think this a good point to discuss.
> Some devices will want to register for all changes to the process address
> space because there is no requirement to preregister regions that the
> device can access verses devices like InfiniBand where a range of address=
es
> have to be registered before the device can access those addresses.

But this is a very bad idea to register and do HW actions for ranges
that can't possibly have any pages registered. It slows down the
entire application

I think the ODP approach might be saner, when it mirrors the entire
address space it chops it up into VA chunks, and once a page is
registered on the HW the VA chunk goes into the interval tree.

Presumably the GPU also has some kind of page table tree and you could
set one of the levels as the VA interval when there are populated children

Jason
