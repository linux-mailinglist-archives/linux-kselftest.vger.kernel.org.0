Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D96607165
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJUHtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJUHs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 03:48:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC74247E37
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 00:48:56 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221021074854epoutp02a25d8a898508d2049660068187bf4ac8~gBhGKwDU11779317793epoutp02R
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 07:48:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221021074854epoutp02a25d8a898508d2049660068187bf4ac8~gBhGKwDU11779317793epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666338534;
        bh=VWakfhO1QlE2pkY+JCsQRVNUMZhjZnPszbasxqY6UOc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LR0Bs7+qUfHf935Bgt0fD3VZk6wgL+tg0KbipDuxgz4cSEL+A64DcigJ6s0Cb6Kv+
         4xlB381gogNzNJ4NUFUbXlXOjJ6EZIjJVJj3Fno/W0qPAIx1aNLL1/zzgYu/r9SXN1
         Rn+NqjBPj+E7T1oKQXyOr2wdAtgqP86a1wv1JRNI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221021074853epcas5p1171d78134d5aee342d8eb8789d93ba72~gBhFpoVBO0403704037epcas5p1I;
        Fri, 21 Oct 2022 07:48:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MtxRm2BWgz4x9Py; Fri, 21 Oct
        2022 07:48:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.6A.10166.4EE42536; Fri, 21 Oct 2022 16:48:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221021065650epcas5p331c1d739a5ac6f6ee455e76fd91a1fac~gAzoj5_PA0684806848epcas5p3s;
        Fri, 21 Oct 2022 06:56:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221021065650epsmtrp17e8aefc10443fb8a2b276a0f70470b4d~gAzoiJOOH2298622986epsmtrp1b;
        Fri, 21 Oct 2022 06:56:50 +0000 (GMT)
X-AuditID: b6c32a49-dd627700000227b6-38-63524ee400f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.78.18644.2B242536; Fri, 21 Oct 2022 15:56:50 +0900 (KST)
Received: from aman1gupta02 (unknown [107.122.12.88]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221021065648epsmtip102531e38e8f224433663e1a76ad9c03e~gAzmxCKHl2840428404epsmtip17;
        Fri, 21 Oct 2022 06:56:48 +0000 (GMT)
From:   "Aman Gupta" <aman1.gupta@samsung.com>
To:     "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        <shradha.t@samsung.com>, <pankaj.dubey@samsung.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <shuah@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
In-Reply-To: <fe40a005-b6a2-2938-576d-acf5432636b9@ti.com>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Fri, 21 Oct 2022 12:26:38 +0530
Message-ID: <007c01d8e51a$4b2e3720$e18aa560$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFofYvwiqARWvL8UeiI8Zt/EpZYDAIhr9qdAV1v2ZSu3UATAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmlu4Tv6BkgyUL+S0uPO1hs2jo+c1q
        Mf3OezaLs/OOs1m0/Glhsbjb0slqcXRjsMWirV/YLXoP11pMebmO3YHLY9OqTjaPO9f2sHk8
        uTKdyaNvyypGj+M3tjN5fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA3SYkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE74+H7B8wFr2wqdjXxNzDe1+9i5OSQEDCReDW/h72LkYtD
        SGA3o8SiO+fYIJxPjBLzJk5nhXA+M0oc6frKAtMy7/QSqJZdjBKdH1dAVb1ilGhcNpkJpIpN
        QEfi291uZpCEiMASRoneuRPZQRLMAjuBWr5LgticAlYSyx7sYAaxhQViJZZ96gOrYRFQlbiz
        /iIriM0rYCkxc+9cFghbUOLkzCcsEHO0JZYtfM0McZKCxM+ny8DqRQScJKb83sIIUSMu8fLo
        EbBTJQTWckg0bOhlh2hwkZg78xgjhC0s8er4Fqi4lMTL/jYoO17i/N9lUD9nSFze+xTKtpc4
        cGUOkM0BtEBTYv0uaEjKSkw9tY4JYi+fRO/vJ0wQcV6JHfNgbFWJ71M6oG6Wlmh6fZZ1AqPS
        LCSvzULy2iwkL8xC2LaAkWUVo2RqQXFuemqxaYFhXmo5PMaT83M3MYITrpbnDsa7Dz7oHWJk
        4mA8xCjBwawkwlvwLiBZiDclsbIqtSg/vqg0J7X4EKMpMLwnMkuJJucDU35eSbyhiaWBiZmZ
        mYmlsZmhkjjv4hlayUIC6YklqdmpqQWpRTB9TBycUg1Mkkp/uc9c3PTWpTmB1yXvuUZslGSo
        Q9TthSw3w+cUtGyIEf/G9UDv9q52RYk0nmCh0L1r+U5MPnlhrqD5KdX4jza/LF5H2fDKnFUX
        ejirYta5Cr6K3qvTnj5bx187Y06JwslpS5PXTFZgMnYx69ul/eH52j9LVqoJ277eVawTn7A2
        i+fp7qC5HSJ2ewsq1vBsdHFIkW7vLdkm8fLFzxV7E1Ttn298d14kI33zmQlv1d6sesS0+H6I
        9gWDgKk9f6/lX9HTODFBtK1OY+XChC/vbyT+vi5WmC7ZoB+ut9ziDEv/vvQpbc8b2+1NbcLf
        XbXqNO5ibBDuYxJedvA9B7NhRWNfpXll26oy4aqgBVeUWIozEg21mIuKEwEFSfsfQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO4mp6Bkg2UP+C0uPO1hs2jo+c1q
        Mf3OezaLs/OOs1m0/Glhsbjb0slqcXRjsMWirV/YLXoP11pMebmO3YHLY9OqTjaPO9f2sHk8
        uTKdyaNvyypGj+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJVx69RH1oIzVhVXdv1lbGA8qNvF
        yMkhIWAiMe/0EvYuRi4OIYEdjBJzLu1mgkhIS9w/O4kNwhaWWPnvOVTRC0aJ63tegCXYBHQk
        vt3tZgZJiAisYpTYcWAzK4jDLLCbUeL85S/MEC1AzpFVf8BaOAWsJJY92AGU4OAQFoiWeDq1
        HiTMIqAqcWf9RVYQm1fAUmLm3rksELagxMmZT8BsZgFtid6HrYww9rKFr5khzlOQ+Pl0GViv
        iICTxJTfW6BqxCVeHj3CPoFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn
        5haX5qXrJefnbmIEx52W1g7GPas+6B1iZOJgPMQowcGsJMJb8C4gWYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmwbDQD6Z3+tjMQ0ycT4jsy77Jy3Ty
        740nYrHlDy56fk81ehTk8vuY9VqB8/EGS47dmSvLp2vx7ZIy7+WGjyKaVnW3j//m5Z6kF/Wx
        rS1jg4bupMehK7dNa5vTKl/8RjPoz51FX7Rr92pfNT+ffjWuolwxyEr276PJL85tzBGPUxDM
        XS7ZfpbD8bvE2k5X5afz1wWFBoVZasrN+C78dmPIxo/stx2qi99Ml+F7qaQoMCX3eqv6SsMb
        Fodu2N28H7thxYz0T4n/dbtNIp7dbf815e+ddwEPGh4lixXzvIi5UzkzoEEv11rQ+6xZx3VH
        VikZvx179EqfTGJvmOLy+bqwK4Or9IUvjLsUzLojJaYpsRRnJBpqMRcVJwIAvKcFPCoDAAA=
X-CMS-MailID: 20221021065650epcas5p331c1d739a5ac6f6ee455e76fd91a1fac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221007053726epcas5p357c35abb79327fee6327bc6493e0178c
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
        <20221007053934.5188-1-aman1.gupta@samsung.com>
        <fe40a005-b6a2-2938-576d-acf5432636b9@ti.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I =5Bmailto:kishon=40ti.com=5D
> Sent: Tuesday, October 11, 2022 4:29 PM
> To: Aman Gupta <aman1.gupta=40samsung.com>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; lpieralisi=40kernel.org; kw=40linux.com;
> shuah=40kernel.org
> Cc: linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org;
> Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>; Manivannan
> Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> +Mani
Gentle reminder for review of this patch.

Thanks and Regards
Aman Gupta
>=20
> On 07/10/22 11:09 am, Aman Gupta wrote:
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
> >   tools/testing/selftests/pci/pci-selftest.c =7C 167 ++++++++++++++++++=
+++
> >   4 files changed, 176 insertions(+)
> >   create mode 100644 tools/testing/selftests/pci/.gitignore
> >   create mode 100644 tools/testing/selftests/pci/Makefile
> >   create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> >
> > diff --git a/tools/testing/selftests/Makefile
> > b/tools/testing/selftests/Makefile
> > index c2064a35688b..81584169a80f 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > =40=40 -49,6 +49,7 =40=40 TARGETS +=3D net/forwarding
> >   TARGETS +=3D net/mptcp
> >   TARGETS +=3D netfilter
> >   TARGETS +=3D nsfs
> > +TARGETS +=3D pci
> >   TARGETS +=3D pidfd
> >   TARGETS +=3D pid_namespace
> >   TARGETS +=3D powerpc
> > diff --git a/tools/testing/selftests/pci/.gitignore
> > b/tools/testing/selftests/pci/.gitignore
> > new file mode 100644
> > index 000000000000..db01411b8200
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/.gitignore
> > =40=40 -0,0 +1 =40=40
> > +pci-selftest
> > diff --git a/tools/testing/selftests/pci/Makefile
> > b/tools/testing/selftests/pci/Makefile
> > new file mode 100644
> > index 000000000000..76b7725a45ae
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/Makefile
> > =40=40 -0,0 +1,7 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0
> > +CFLAGS +=3D -O2 -Wl,-no-as-needed -Wall LDFLAGS +=3D -lrt -lpthread -l=
m
> > +
> > +TEST_GEN_PROGS =3D pci-selftest
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/pci/pci-selftest.c
> > b/tools/testing/selftests/pci/pci-selftest.c
> > new file mode 100644
> > index 000000000000..73e8f3eb1982
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/pci-selftest.c
> > =40=40 -0,0 +1,167 =40=40
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint Driver Test Program
> > + *
> > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > + *             https://www.samsung.com
> > + * Author: Aman Gupta <aman1.gupta=40samsung.com>  */
> > +
> > +=23include <errno.h>
> > +=23include <fcntl.h>
> > +=23include <stdbool.h>
> > +=23include <stdio.h>
> > +=23include <stdlib.h>
> > +=23include <sys/ioctl.h>
> > +=23include <unistd.h>
> > +
> > +=23include =22../kselftest_harness.h=22
> > +
> > +=23define PCITEST_BAR		_IO('P', 0x1)
> > +=23define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > +=23define PCITEST_MSI		_IOW('P', 0x3, int)
> > +=23define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > +=23define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > +=23define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > +=23define PCITEST_MSIX		_IOW('P', 0x7, int)
> > +=23define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > +=23define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > +=23define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > +
> > +static char *test_device =3D =22/dev/pci-endpoint-test.0=22;
> > +
> > +struct xfer_param =7B
> > +	unsigned long size;
> > +	unsigned char flag;
> > +	=7D;
> > +
> > +FIXTURE(device)
> > +=7B
> > +	int fd;
> > +=7D;
> > +
> > +FIXTURE_SETUP(device)
> > +=7B
> > +
> > +	self->fd =3D open(test_device, O_RDWR);
> > +
> > +	ASSERT_NE(-1, self->fd) =7B
> > +		TH_LOG(=22Can't open PCI Endpoint Test device=5Cn=22);
> > +	=7D
> > +=7D
> > +
> > +FIXTURE_TEARDOWN(device)
> > +=7B
> > +	close(self->fd);
> > +=7D
> > +
> > +TEST_F(device, BAR_TEST)
> > +=7B
> > +	int ret =3D -EINVAL;
> > +	int final =3D 0;
> > +
> > +	for (int i =3D 0; i <=3D 5; i++) =7B
> > +		ret =3D ioctl(self->fd, PCITEST_BAR, i);
> > +
> > +		EXPECT_EQ(1, ret) =7B
> > +			TH_LOG(=22TEST FAILED FOR BAR %d=5Cn=22, i);
> > +			final++;
> > +		=7D
> > +	=7D
> > +
> > +	ASSERT_EQ(0, final);
> > +=7D
> > +
> > +TEST_F(device, MSI_TEST)
> > +=7B
> > +	int ret =3D -EINVAL;
> > +	int final =3D 0;
> > +
> > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	for (int i =3D 1; i <=3D 32; i++) =7B
> > +		ret =3D ioctl(self->fd, PCITEST_MSI, i);
> > +		EXPECT_EQ(1, ret) =7B
> > +			TH_LOG(=22TEST FAILED FOR MSI%d=5Cn=22, i);
> > +			final++;
> > +		=7D
> > +	=7D
> > +
> > +	ASSERT_EQ(0, final);
> > +=7D
> > +
> > +TEST_F(device, READ_TEST)
> > +=7B
> > +	int final =3D 0;
> > +	int ret =3D -EINVAL;
> > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D;
> > +
> > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag =3D 0;
> > +	for (int i =3D 0; i < 5; i++) =7B
> > +		param.size =3D SIZE=5Bi=5D;
> > +		ret =3D ioctl(self->fd, PCITEST_READ, &param);
> > +		EXPECT_EQ(1, ret) =7B
> > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > +			final++;
> > +		=7D
> > +	=7D
> > +
> > +	ASSERT_EQ(0, final);
> > +=7D
> > +
> > +TEST_F(device, WRITE_TEST)
> > +=7B
> > +	int final =3D 0;
> > +	int ret =3D -EINVAL;
> > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D;
> > +
> > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag =3D 0;
> > +
> > +	for (int i =3D 0; i < 5; i++) =7B
> > +		param.size =3D SIZE=5Bi=5D;
> > +		ret =3D ioctl(self->fd, PCITEST_WRITE, &param);
> > +		EXPECT_EQ(1, ret) =7B
> > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > +			final++;
> > +		=7D
> > +	=7D
> > +
> > +	ASSERT_EQ(0, final);
> > +=7D
> > +
> > +TEST_F(device, COPY_TEST)
> > +=7B
> > +	int final =3D 0;
> > +	int ret =3D -EINVAL;
> > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D;
> > +
> > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag =3D 0;
> > +
> > +	for (int i =3D 0; i < 5; i++) =7B
> > +		param.size =3D SIZE=5Bi=5D;
> > +		ret =3D ioctl(self->fd, PCITEST_COPY, &param);
> > +		EXPECT_EQ(1, ret) =7B
> > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > +			final++;
> > +		=7D
> > +	=7D
> > +
> > +	ASSERT_EQ(0, final);
> > +=7D
> > +TEST_HARNESS_MAIN
> >

