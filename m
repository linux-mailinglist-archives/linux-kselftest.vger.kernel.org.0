Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A16656010
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Dec 2022 06:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLZFST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 00:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZFSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 00:18:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536D6273A
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Dec 2022 21:18:15 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221226051813epoutp04bda2342dd8f174dac94b2d898fa707e3~0QCYQozic3087330873epoutp04I
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 05:18:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221226051813epoutp04bda2342dd8f174dac94b2d898fa707e3~0QCYQozic3087330873epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672031893;
        bh=tqVoW9XOujr1og6Yots/s/tWi45DxCtJ8YEtukG7YJo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RAD4h3MwdPB0VCCH7sKZXSYYnQ7hY5FQzg0Oc5WRq4RQTPvwUP9jOWJAxVIOShiSq
         GPLGg+4+OcbSe5aDgnJLzYrFXmhIc/XTes/RKANINM7JBqSk7lyByJPJUIy+D08l7C
         FhoZ2VxMzYW1q84DpCcew4HS5fiRG7V40/BJu4cQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221226051813epcas5p24734806becee89a9f9580ed73be56bde~0QCXuZe9H2845128451epcas5p2J;
        Mon, 26 Dec 2022 05:18:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NgQzR28D3z4x9Px; Mon, 26 Dec
        2022 05:18:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.BD.62806.39E29A36; Mon, 26 Dec 2022 14:18:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221223134526epcas5p35eae04d9d781b77c92a50d039b8b0782~zcBXpUd4v1829118291epcas5p3J;
        Fri, 23 Dec 2022 13:45:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221223134526epsmtrp25c4d23645ce2cca5a5226429a4c2cb0e~zcBXojzDS1134511345epsmtrp20;
        Fri, 23 Dec 2022 13:45:26 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-01-63a92e93f667
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.42.10542.5F0B5A36; Fri, 23 Dec 2022 22:45:25 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221223134524epsmtip18d15fc5a232befc18655ef16d5da2812~zcBWBhbhX1494514945epsmtip15;
        Fri, 23 Dec 2022 13:45:24 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc:     "'Manivannan Sadhasivam'" <mani@kernel.org>,
        <shradha.t@samsung.com>, <pankaj.dubey@samsung.com>,
        <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <shuah@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
In-Reply-To: <20221221072423.GC2922@thinkpad>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Fri, 23 Dec 2022 19:15:22 +0530
Message-ID: <00fb01d916d4$cf7a8010$6e6f8030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQGq3mm9ar2hLoCe5FGl1VQzTHJ6KAKYT6NGAwyUBVOuqsSyEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuu5kvZXJBlcW8VpceNrDZtHQ85vV
        Yvqd92wWZ+cdZ7No+dPCYnHgwypGi7stnawWRzcGWyza+oXdovdwrcWUl+vYHbg9Nq3qZPO4
        c20Pm8eTK9OZPPq2rGL0OH5jO5PH501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izvnf3sxVMca14MPMiYwPjLLMuRk4OCQETif9d
        71i6GLk4hAR2M0qsXfOLGcL5xCjxbtN/qMxnRomTrfuYYFom7J7GDpHYxSjxoXc6VMtzRolb
        z64yg1SxCURI9HTeYwexRQQcJNrffgIbxSywnkli2v1nQKM4ODgFdCUmLACrERaIlVj2qQ/M
        ZhFQlXjU2Qq2jVfAUuLZ4y/sELagxMmZT1hAbGYBbYllC18zQ1ykIPHz6TJWiLi4xNGfPcwQ
        e50klmx+A3aphMAODok596cwQjS4SMzZ+4YNwhaWeHV8CzuELSXx+d1eqHi8xPm/y1gg7AyJ
        y3ufQtn2EgeuzGEBuZ9ZQFNi/S59iLCsxNRT65ggbuCT6P39BBpavBI75sHYqhLfp3RA3Swt
        0fT6LOsERqVZSF6bheS1WUjemYWwbQEjyypGydSC4tz01GLTAqO81HJ4jCfn525iBKdeLa8d
        jA8ffNA7xMjEwXiIUYKDWUmEN/fG8mQh3pTEyqrUovz4otKc1OJDjKbA8J7ILCWanA9M/nkl
        8YYmlgYmZmZmJpbGZoZK4rypW+cnCwmkJ5akZqemFqQWwfQxcXBKNTDttP3lopTxqukuI/OS
        /rnrd16acu/uy9XxPIt+vJp5j/9/7MVk9hNpZ4Vczx2riK64vuDF1V8yvitTuiI4EkrN2HN9
        pDOeNWU+0xMLXjzrSqbZfZEfOyZxNd75YTPzt/GGVv6LfwsOTYydctGhRzBbdPvj4w1pjM9W
        LWmWuFKTuOSZ8qKsz73XpO5xXzjgauR+Z/1CuVlrZmett7FMSH9bdeCnyWthxhMLboo1eFtM
        1Ztvuz9OmeFO2rWqY7az2gKVcovFK9fv+RfOppsws3jS9nvKru4nvRTntaxuFPXL2C2vtZir
        eH/PFutFp78f/H935hGf07vfFGjOOmuukMf2Ry1gKrNsl1zUUdmlE4/GKLEUZyQaajEXFScC
        AKROvkNGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO7XDUuTDe5MtLS48LSHzaKh5zer
        xfQ779kszs47zmbR8qeFxeLAh1WMFndbOlktjm4Mtli09Qu7Re/hWospL9exO3B7bFrVyeZx
        59oeNo8nV6YzefRtWcXocfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDJOb7rLVHDBueLG6SMs
        DYyXTLoYOTkkBEwkJuyext7FyMUhJLCDUWLxpfOsEAlpiftnJ7FB2MISK/89hyp6yijR820t
        I0iCTSBM4tDEmWC2iICDRPvbTywgRcwCO5kk1q27zQzRsYZRYuKjaUAOBwengK7EhAXsIKaw
        QLTE06n1IL0sAqoSjzpbmUBsXgFLiWePv7BD2IISJ2c+YQGxmQW0JXoftjLC2MsWvmaGOE5B
        4ufTZawQcXGJoz97mCHucZJYsvkN+wRG4VlIRs1CMmoWklGzkLQvYGRZxSiZWlCcm55bbFhg
        lJdarlecmFtcmpeul5yfu4kRHH1aWjsY96z6oHeIkYmD8RCjBAezkgjvlseLk4V4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgUhL54Nmn/u6S/7Gs5olX
        j02WDa/osbJMlL+wcOV/o7l//625UK3b0si+KvdtTxNTU8KS1xWrcs99MNFX+LGJq+fqBxuH
        FUov5RLDzQ9L8b899mCbVo3F22csy448uBK+SlPnQDJPfOFHfm+FCzOrGSoMM67kpBitfLW6
        0YLJ13aGS8TVaNN980oVps+9IXbbynCLjVh/kFb+9OvNEX95WjPFqx8vET+yyf5XXPoOrhVB
        Ev3+sxx2yImefhp27u77tC/iPa6FRdW/wi7ctta/+uu7jqxsyE3B3oozS2XuNysrLQqQnjd1
        tpLxuReas6N9WdnNtM6zzorxe/EmLHedt+KJhEuuby0Ec/jeNBUpsRRnJBpqMRcVJwIAuFav
        PS0DAAA=
X-CMS-MailID: 20221223134526epcas5p35eae04d9d781b77c92a50d039b8b0782
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73
References: <CGME20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73@epcas5p3.samsung.com>
        <001501d91362$a8689810$f939c830$@samsung.com>
        <20221221072423.GC2922@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: 'Manivannan Sadhasivam'
> =5Bmailto:manivannan.sadhasivam=40linaro.org=5D
> Sent: 21 December 2022 12:54
> To: Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics
> <aman1.gupta=40samsung.com>
> Cc: 'Manivannan Sadhasivam' <mani=40kernel.org>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> kw=40linux.com; shuah=40kernel.org; linux-pci=40vger.kernel.org; linux-
> kselftest=40vger.kernel.org; 'Padmanabhan Rajanbabu'
> <p.rajanbabu=40samsung.com>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> On Mon, Dec 19, 2022 at 10:00:40AM +0530, Aman Gupta/FDS SW
> /SSIR/Engineer/Samsung Electronics wrote:
> >
> >
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam
> > > =5Bmailto:manivannan.sadhasivam=40linaro.org=5D
> > > Sent: 01 November 2022 22:50
> > > To: Manivannan Sadhasivam <mani=40kernel.org>
> > > Cc: Aman Gupta <aman1.gupta=40samsung.com>;
> shradha.t=40samsung.com;
> > > pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> > > kw=40linux.com; shuah=40kernel.org; linux-pci=40vger.kernel.org; linu=
x-
> > > kselftest=40vger.kernel.org; Padmanabhan Rajanbabu
> > > <p.rajanbabu=40samsung.com>
> > > Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support fo=
r
> > > PCI endpoint driver test
> > >
> > > On Tue, Nov 01, 2022 at 07:32:16PM +0530, Manivannan Sadhasivam
> wrote:
> > > > On Fri, Oct 07, 2022 at 11:09:34AM +0530, Aman Gupta wrote:
> > > > > This patch enables the support to perform selftest on PCIe
> > > > > endpoint driver present in the system. The following tests are
> > > > > currently performed by the selftest utility
> > > > >
> > > > > 1. BAR Tests (BAR0 to BAR5)
> > > > > 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1,
> > > > > 1024, 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024,
> > > > > 1025, 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025,
> > > > > 1024000,
> > > > > 1024001 Bytes)
> > > > >
> > > > > Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> > > > > Signed-off-by: Padmanabhan Rajanbabu
> <p.rajanbabu=40samsung.com>
> > > > > ---
> > > > >  tools/testing/selftests/Makefile           =7C   1 +
> > > > >  tools/testing/selftests/pci/.gitignore     =7C   1 +
> > > > >  tools/testing/selftests/pci/Makefile       =7C   7 +
> > > > >  tools/testing/selftests/pci/pci-selftest.c =7C 167
> > > > > +++++++++++++++++++++
> > > > >  4 files changed, 176 insertions(+)  create mode 100644
> > > > > tools/testing/selftests/pci/.gitignore
> > > > >  create mode 100644 tools/testing/selftests/pci/Makefile
> > > > >  create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> > > > >
> > > > > diff --git a/tools/testing/selftests/Makefile
> > > > > b/tools/testing/selftests/Makefile
> > > > > index c2064a35688b..81584169a80f 100644
> > > > > --- a/tools/testing/selftests/Makefile
> > > > > +++ b/tools/testing/selftests/Makefile
> > > > > =40=40 -49,6 +49,7 =40=40 TARGETS +=3D net/forwarding  TARGETS +=
=3D
> > > > > net/mptcp TARGETS +=3D netfilter  TARGETS +=3D nsfs
> > > > > +TARGETS +=3D pci
> > > > >  TARGETS +=3D pidfd
> > > > >  TARGETS +=3D pid_namespace
> > > > >  TARGETS +=3D powerpc
> > > > > diff --git a/tools/testing/selftests/pci/.gitignore
> > > > > b/tools/testing/selftests/pci/.gitignore
> > > > > new file mode 100644
> > > > > index 000000000000..db01411b8200
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/pci/.gitignore
> > > > > =40=40 -0,0 +1 =40=40
> > > > > +pci-selftest
> > > > > diff --git a/tools/testing/selftests/pci/Makefile
> > > > > b/tools/testing/selftests/pci/Makefile
> > > > > new file mode 100644
> > > > > index 000000000000..76b7725a45ae
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/pci/Makefile
> > > > > =40=40 -0,0 +1,7 =40=40
> > > > > +=23 SPDX-License-Identifier: GPL-2.0 CFLAGS +=3D -O2
> > > > > +-Wl,-no-as-needed -Wall LDFLAGS +=3D -lrt -lpthread -lm
> > > > > +
> > > > > +TEST_GEN_PROGS =3D pci-selftest
> > > > > +
> > > > > +include ../lib.mk
> > > > > diff --git a/tools/testing/selftests/pci/pci-selftest.c
> > > > > b/tools/testing/selftests/pci/pci-selftest.c
> > > > > new file mode 100644
> > > > > index 000000000000..73e8f3eb1982
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/pci/pci-selftest.c
> > > >
> > > > endpoint-test.c
> > Okay I will change the file name in the next patch.
> > > >
> > > > > =40=40 -0,0 +1,167 =40=40
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * PCI Endpoint Driver Test Program
> > > > > + *
> > > > > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > > > > + *             https://www.samsung.com
> > > > > + * Author: Aman Gupta <aman1.gupta=40samsung.com>  */
> > > > > +
> > > > > +=23include <errno.h>
> > > > > +=23include <fcntl.h>
> > > > > +=23include <stdbool.h>
> > > > > +=23include <stdio.h>
> > > > > +=23include <stdlib.h>
> > > > > +=23include <sys/ioctl.h>
> > > > > +=23include <unistd.h>
> > > > > +
> > > > > +=23include =22../kselftest_harness.h=22
> > > > > +
> > > > > +=23define PCITEST_BAR		_IO('P', 0x1)
> > > > > +=23define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > > > > +=23define PCITEST_MSI		_IOW('P', 0x3, int)
> > > > > +=23define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > > > > +=23define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > > > > +=23define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > > > > +=23define PCITEST_MSIX		_IOW('P', 0x7, int)
> > > > > +=23define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > > > +=23define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > > > +=23define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > > > +
> > > > > +static char *test_device =3D =22/dev/pci-endpoint-test.0=22;
> > > > > +
> > > > > +struct xfer_param =7B
> > > > > +	unsigned long size;
> > > > > +	unsigned char flag;
> > > > > +	=7D;
> > > >
> > > > Align '=7D'
> > Okay.
> > > >
> > > > > +
> > > > > +FIXTURE(device)
> > > > > +=7B
> > > > > +	int fd;
> > > > > +=7D;
> > > > > +
> > > > > +FIXTURE_SETUP(device)
> > > > > +=7B
> > > > > +
> > > > > +	self->fd =3D open(test_device, O_RDWR);
> > > > > +
> > > > > +	ASSERT_NE(-1, self->fd) =7B
> > > > > +		TH_LOG(=22Can't open PCI Endpoint Test device=5Cn=22);
> > > > > +	=7D
> > > > > +=7D
> > > > > +
> > > > > +FIXTURE_TEARDOWN(device)
> > > > > +=7B
> > > > > +	close(self->fd);
> > > > > +=7D
> > > > > +
> > > > > +TEST_F(device, BAR_TEST)
> > > > > +=7B
> > > > > +	int ret =3D -EINVAL;
> > > >
> > > > Ininitialization not required here and also in other functions.
> > Understood , I will make the changes in the next patch.
> > > >
> > > > > +	int final =3D 0;
> > > > > +
> > > > > +	for (int i =3D 0; i <=3D 5; i++) =7B
> > > > > +		ret =3D ioctl(self->fd, PCITEST_BAR, i);
> > > > > +
> > > > > +		EXPECT_EQ(1, ret) =7B
> > > >
> > > > The return value of all these IOCTL's are going to change when =5B1=
=5D
> > > > get's
> > > merged.
> > > >
> > > > =5B1=5D
> > > > https://lore.kernel.org/linux-pci/20220824123010.51763-1-manivanna
> > > > n.sa
> > > > dhasivam=40linaro.org/
> > > >
> > > > I'd suggest to resubmit this selftest after that.
> >
> >
> > Manivannan, the patch link you have provided cannot be directly
> > applies on the latest kernel and hence it requires some re work .I can
> > rework these patches along with the kselftest patch if not please
> > allow me to go ahead and post the kselftest patch till then.
>=20
> I've pushed my patches here:
> https://protect2.fireeye.com/v1/url?k=3Df8a46815-992f7d3a-f8a5e35a-
> 74fe485cbfe7-1e3e3a1d7f2a8577&q=3D1&e=3De8998bc0-4133-4737-9572-
> 17b47a4d953c&u=3Dhttps%3A%2F%2Fgit.linaro.org%2Fpeople%2Fmanivannan.
> sadhasivam%2Flinux.git%2Flog%2F%3Fh%3Dpci-endpoint-test-fix
>=20
> Please pick them and rebase your patch(es) on top and post as a series. Y=
ou
> should also make the series a continuation of my v2, preserving the cover
> letter and keeping everyone in CC.
>=20

Hi Manivanan,
Thanks for the reply and sharing the patches.
I will post the kselftest patch along with your three patches as version 3,=
 preserving your cover letter.

> After the kselftest patch, the tools/pci directory should be removed and =
the
> endpoint documentation (Documentation/PCI/endpoint/pci-test-howto.rst)
> should be modified to reflect kselftest.
>=20
> Thanks for your contribution=21
>=20
> - Mani
>=20

Please allow me to reply to this comment in different thread, where you and=
 Shuah are already having discussion about this.
Thanks for the review.
Aman Gupta



