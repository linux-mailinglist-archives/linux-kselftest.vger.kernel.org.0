Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922457325D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfGXPAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 11:00:18 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:45319
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXPAS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 11:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KenL55TjQFJIFnOXdGhZaoz1JhJ3tEPVSW3GVVIlmzusBcTgHIsgyfKHmV2bMThZEhk6cejrWybTudXPK2FSAB384fsGuEpV/hP7xYBFoW4PYcwKybRpqJrppPRcuNzL/yEGujFRP3xHxIP8oc1ikmq1NY1HkxoCq42ODk8WtTjOeTD2HwylNVRgY/hMlV/MpOoxquna43QzvnZXFJIVL5F+XsFimi4CDMr+anPYuV9vm8L6oEt2f4Ucu/bP2llgOjgq5sVjRIyHfYsu7ISyMUpzyQIsRmOzUeS7MY9yzwXJQ8zgYUbiCQ2QpsB2Y5mMmXe2rQDiaaPhHd2UmPJFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI1Aa3XQrDgb4cWCc+3h5PXo8jpiUbcKVdJO/vCeUzQ=;
 b=G5b0IYgUUDumipyA+I5xDmI9VLDG/3JTYAW6WduduVZPkQuom/b2ueWQrpvAYTRozxcXHWjwhFRbwahrOpz7mNSjlnahPZ5xwQD7J2lQ9NkBz9HBWh5a7FA+NH0MUX46kGMO1KoelPuwylxPw6Uxv0NVxW9khML45ztvPflnGgmalHKwHQcX23w6i1m+NHQrWl2ifiHtOPliBtJFSWZGckng6JZS73bIy5f/MU3dRQDrRzwAYzT3oDFeNVk4bPPH5XAZ4tK1srpF4SVcZAFEVEqjGbOxhI/mrY1PGLrYM6kS3C7UpBLB8dUwzoK5iHPqooB3seFNPaAJZTmtQ4YTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI1Aa3XQrDgb4cWCc+3h5PXo8jpiUbcKVdJO/vCeUzQ=;
 b=Qw8XSAL/UEaY5VU/sC+O+C+uk6PGzAhdMZ4909dO+bCTE/jieUpCOwlEdE0eQQth/Bzm4ako25R7jGjOu1Fm+v1HN7ws5+a+oExQiZtpW9jlui1rDpkO8+ZJkDuU2tzbmr8/ml7e3PyDq/6BxsXbZNGDgQKJYdDRTbNqFVO7C08=
Received: from VI1PR05MB5344.eurprd05.prod.outlook.com (20.178.9.81) by
 VI1PR05MB3357.eurprd05.prod.outlook.com (10.170.238.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 15:00:13 +0000
Received: from VI1PR05MB5344.eurprd05.prod.outlook.com
 ([fe80::406f:2c4e:37cf:adbc]) by VI1PR05MB5344.eurprd05.prod.outlook.com
 ([fe80::406f:2c4e:37cf:adbc%7]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 15:00:13 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Masanari Iida <standby24x7@gmail.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] selftests: mlxsw: Fix typo in qos_mc_aware.sh
Thread-Topic: [PATCH] selftests: mlxsw: Fix typo in qos_mc_aware.sh
Thread-Index: AQHVQipWQi7X5DisNkicSGy+J69XE6bZ3KUA
Date:   Wed, 24 Jul 2019 15:00:13 +0000
Message-ID: <20190724150010.GA17527@splinter>
References: <20190724141554.31723-1-standby24x7@gmail.com>
In-Reply-To: <20190724141554.31723-1-standby24x7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0060.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::24) To VI1PR05MB5344.eurprd05.prod.outlook.com
 (2603:10a6:803:a5::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e10c19f-7851-4b19-d4a3-08d71047a146
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3357;
x-ms-traffictypediagnostic: VI1PR05MB3357:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB33578BFE9E2D48128A45E88BBFC60@VI1PR05MB3357.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(51914003)(9686003)(102836004)(1076003)(386003)(66066001)(6246003)(54906003)(53936002)(52116002)(7736002)(446003)(26005)(6506007)(305945005)(99286004)(11346002)(6512007)(6306002)(25786009)(4744005)(186003)(476003)(8936002)(66946007)(81156014)(81166006)(66476007)(66556008)(68736007)(486006)(66446008)(33656002)(4326008)(6116002)(256004)(76176011)(3846002)(64756008)(8676002)(71190400001)(71200400001)(478600001)(5660300002)(229853002)(6436002)(14454004)(1411001)(966005)(6486002)(86362001)(2906002)(316002)(33716001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3357;H:VI1PR05MB5344.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LbxLe3t3UOqwc5UuPZS9HjWsSrLwqwOrBICFO+ErNzB+u4tPuKA8uqlManS9uBr3pj1eM2AYx2hzCfTLRji1HGswiS6GeRiHRl8kZ43mu3+bSLJInXyr48y70bs5y9Zs+bFAITLDq+z1r3o4bQYRqteuaZv87NJhAxgvE+Kb/fOhSSZvaf+lqqs1M6PxQnZLcKnlElbDnUUrQB9BKADytxx/PMaPx6C314cUDKxKDi9YZyMSIP3tXyNaIxA2t0HKUDoFzs4XHjaXYo0v8VduUTDEGF6oUEtL9KcuWMbQ43UcXs8oj+W2u+8A5DkMPFFswucvYcN1GEm4o5YBOPezEhZfNIw8ZYFkBXWG76eKkhHQDD/rQv/W4+WytPJKLKeqQO/IbEMurZSpq2b4fvMicopy/0ofGazf63qmLwj0nco=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74505029ACC7EF49B192D15902FE2878@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e10c19f-7851-4b19-d4a3-08d71047a146
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 15:00:13.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idosch@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3357
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 11:15:54PM +0900, Masanari Iida wrote:
> This patch fixes some spelling typo in qos_mc_aware.sh
>=20
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Thanks for the patch, but it should go through the networking tree.

Please resubmit to netdev@vger.kernel.org and make sure subject prefix
is "PATCH net-next". Please read this FAQ before you submit:

https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Thanks!
