Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED465600D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Dec 2022 06:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLZFSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 00:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLZFSQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 00:18:16 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3045273C
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Dec 2022 21:18:12 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221226051809epoutp02da611880a19be080c6becaa24a2d8617~0QCUE7WBy2210522105epoutp02L
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 05:18:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221226051809epoutp02da611880a19be080c6becaa24a2d8617~0QCUE7WBy2210522105epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672031889;
        bh=JpUpo2y1t2LuXkTBSEj8IqXOdESjqyTvgxHfSl+cXvk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QPzzsbVoKx9kDDY45KOD8+6e/ukknCEcEuamCjassLBb28NDu2XDYWVIoD0qmImBb
         MgoSnsMn+gXoZl2Abrs/E7DnUuqjzscrg4G10nop36+eQj7dkS8lh9k4p08eMwPRpR
         GXXv4q6h47HiO9npfYPCN/WfEvr6sfMTF3hCaYGs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221226051809epcas5p199432b1160fc27e47ca0566340980d38~0QCTwuM512248222482epcas5p1Y;
        Mon, 26 Dec 2022 05:18:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NgQzM2wwwz4x9Q8; Mon, 26 Dec
        2022 05:18:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.B3.02301.F8E29A36; Mon, 26 Dec 2022 14:18:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221223133914epcas5p2bf3e8d3a066808213d7fec05312e4c44~zb79b7xIH0817008170epcas5p2K;
        Fri, 23 Dec 2022 13:39:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221223133914epsmtrp23e3ff62eec220cfc798829fc6cf58de3~zb79bMHtv0908709087epsmtrp2D;
        Fri, 23 Dec 2022 13:39:14 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-67-63a92e8f63fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.12.10542.28FA5A36; Fri, 23 Dec 2022 22:39:14 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221223133912epsmtip17b7cb233a06a3b0c8f3835af44493c44~zb77_Fl2C1091810918epsmtip1W;
        Fri, 23 Dec 2022 13:39:12 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Shunsuke Mie'" <mie@igel.co.jp>, <shradha.t@samsung.com>,
        <pankaj.dubey@samsung.com>, <kishon@ti.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <shuah@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
In-Reply-To: <7d982a83-a841-ca56-20cc-cb5373a4bcdc@igel.co.jp>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Fri, 23 Dec 2022 19:09:11 +0530
Message-ID: <00fa01d916d3$f1ef90a0$d5ceb1e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQFofYvwiqARWvL8UeiI8Zt/EpZYDAIhr9qdArOtAp2vNgEHQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmlm6/3spkgw+NghYXnvawWTT0/Ga1
        mH7nPZvF2XnH2Sxa/rSwWExZZGtxdGOwxaKtX9gteg/XWkx5uY7dgcuj8bmEx6ZVnWweT65M
        Z/Lo27KK0eP4je1MHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp
        5CXmptoqufgE6Lpl5gCdpaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07M
        LS7NS9fLSy2xMjQwMDIFKkzIzmjvbGEuWMJfsWVlJ1sD4x6eLkZODgkBE4kvzafZuhi5OIQE
        djNKTNvYwgrhfGKU2HF6NTuE85lR4uXCVcwwLS/XX2aGSOxilNjSso8JwnnOKHFpEcgwTg42
        gQiJns57YO0iAmsYJRr6+1lBEswClRKdnzqZQGxOATuJ13c/gjUIC8RKLPvUxw5iswioStxt
        aQOL8wpYSvQ9mcICYQtKnJz5hAVijrbEsoWvoU5SkPj5dBnUfHGJoz97wOIiAk4S39ZMAbtO
        QmAph0Rf83J2iAYXiRMbVkHZwhKvjm+BsqUkPr/bywZhx0uc/7uMBcLOkLi89ymUbS9x4Moc
        IJsDaJmmxPpd+hBhWYmpp9YxQdzAJ9H7+wkTRJxXYsc8GFtV4vuUDqibpSWaXp9lncCoNAvJ
        a7OQvDYLyTuzELYtYGRZxSiZWlCcm55abFpgmJdaDo/y5PzcTYzgdKvluYPx7oMPeocYmTgY
        DzFKcDArifDm3lieLMSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgQk/ryTe0MTSwMTMzMzE
        0tjMUEmcN3Xr/GQhgfTEktTs1NSC1CKYPiYOTqkGpraV72zmOLYGmr1OLpxeqhoW/PDYv83b
        Io4+X+ZrwB8iYS8fnLbVT17hzYv7ETPK9/Us+DbnzIZyngiG+WIL5jrdux2Zm/9W163p6n6z
        wPWnE/fKzVA7ZnSj40/x//OllXfXn7GeOGdpEMfh2WLqb23W/Qnh3b+759NhplMCQj4ntI58
        itl3cFLKdtdXV04/cH9wszHBqD2IseDB9vdfHx/9IGeQJrX5hXKK7fa2v09On9yh9n3ptIvS
        QmrL1dKZ9+n9+ZLOMnllrLvotPCASVutrm1lZVBSFBPeniusGaDQFmVz/WeJqtgEjxWR52d1
        PXY3CNrXVT9f8IP+z1NsJ60Fp28y+LmYd4rZIdV/h9crsRRnJBpqMRcVJwIAR3HesUAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnG7T+qXJBlPP8FlceNrDZtHQ85vV
        Yvqd92wWZ+cdZ7No+dPCYjFlka3F0Y3BFou2fmG36D1cazHl5Tp2By6PxucSHptWdbJ5PLky
        ncmjb8sqRo/jN7YzeXzeJBfAFsVlk5Kak1mWWqRvl8CV8fTnKvaCX3wVd2bxNDBO4uli5OSQ
        EDCReLn+MnMXIxeHkMAORokDG36xQSSkJe6fnQRlC0us/PecHaLoKaNEW9dkJpAEm0CYxKGJ
        MxlBEiICWxgldu6E6GYWqJY49qOPBaJjP6PE3j3tYB2cAnYSr+9+BCri4BAWiJZ4OrUeJMwi
        oCpxt6UNrJdXwFKi78kUFghbUOLkzCcsEDO1JXoftjLC2MsWvmaGuE5B4ufTZawQcXGJoz97
        wOIiAk4S39ZMYZrAKDwLyahZSEbNQjJqFpL2BYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxguNNS2sH455VH/QOMTJxMB5ilOBgVhLh3fJ4cbIQb0piZVVqUX58UWlOavEhRmkO
        FiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTM6f2oKLty16kb7meMqFH33vV3ampp67ULrJ
        9tUhF+8/3zytZtkK3N4Xdsp5Y47gYlamAyefP3spYfHO7NA0PZ4ivQPCsw1/eMzO+Z4kPHOq
        1wnRdR6L309PCKtb9YSHm03hq8Ys8fonpwtWrcwWe/bmxg37k1MztfhUTh4IW2bw2ETLKXCH
        uz2HXkVUmH+mQ+9H/T8TmRyM9r7T0/4ay+xj/55xw+JZjubCZxaE7vNlcJ/U4dLELe7pe0a+
        nCslgO9fyH+Ln7sj+Z5PNndavVnlnFLZzvCrhqm3Nv3wPn/mdUznyYW/i61mBUQkLb6UsHvx
        q4aV85Pd2Ou+yvxT977f0qDm+O/YI+cyW/a8CCWW4oxEQy3mouJEAGWu2e0mAwAA
X-CMS-MailID: 20221223133914epcas5p2bf3e8d3a066808213d7fec05312e4c44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221007053726epcas5p357c35abb79327fee6327bc6493e0178c
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
        <20221007053934.5188-1-aman1.gupta@samsung.com>
        <7d982a83-a841-ca56-20cc-cb5373a4bcdc@igel.co.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Shunsuke Mie =5Bmailto:mie=40igel.co.jp=5D
> Sent: 21 December 2022 14:00
> To: Aman Gupta <aman1.gupta=40samsung.com>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> kw=40linux.com; shuah=40kernel.org
> Cc: linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org;
> Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> Hi Aman,
>=20
> It is a nice work.
>=20
> On 2022/10/07 14:39, Aman Gupta wrote:
> > This patch enables the support to perform selftest on PCIe endpoint
> > driver present in the system. The following tests are currently
> > performed by the selftest utility
> >
> > 1. BAR Tests (BAR0 to BAR5)
> > 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> > 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> > 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> > 1024001 Bytes)
> >
> > Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> > ---
> >   tools/testing/selftests/Makefile           =7C   1 +
> >   tools/testing/selftests/pci/.gitignore     =7C   1 +
> >   tools/testing/selftests/pci/Makefile       =7C   7 +
> >   tools/testing/selftests/pci/pci-selftest.c =7C 167
> > +++++++++++++++++++++
> This test is for a pci endpoint test driver. so I think it should be loca=
ted on
> tools/testing/selftest/drivers/pci/endpoint. What do you think?

Hi Shunsuke,
Thanks for the review and nice thought about relocating the file.=20
As per the review provided by Manivanan, I will be changing the name of the=
 file to endpoint-test.c=20
and hence I am thinking to move this file to tools/testing/selftest/driver/=
pci/endpoint_test.c  =20

Thanks,
Aman Gupta

