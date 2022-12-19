Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172B650731
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLSEfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Dec 2022 23:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSEfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Dec 2022 23:35:33 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0F62C7
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Dec 2022 20:35:30 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221219043524epoutp03280acd2138e50add118d31bee28e4bb4~yF7-186522121321213epoutp03W
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 04:35:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221219043524epoutp03280acd2138e50add118d31bee28e4bb4~yF7-186522121321213epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671424524;
        bh=ChBUOt3IT4Ul7YqSVlNsho/uRfLds+F/SZ3ctl3XGuA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FAnnNsD/mHXkED3Vzi+HCCwZRaTg+bqJyIJM3ddMGJv4ZC/XqE9LPlZrsM7sUxu3M
         59ri2lHQQEpjVLhPVU0du2bOAtEijlavJ89TJXbcBO7zf+tUzaYOFJUeHv/rB6HqTe
         vHY8dVk42pCxJ3Cje+uDuoIgpIchfj7t+gyiWehc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221219043524epcas5p265c3ed5406bf80e06dfb876e212ff052~yF7-TM9ps2958429584epcas5p2W;
        Mon, 19 Dec 2022 04:35:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nb6MG23jmz4x9Q1; Mon, 19 Dec
        2022 04:35:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.4A.01710.60AEF936; Mon, 19 Dec 2022 13:35:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73~yF36cnhsd0562105621epcas5p3M;
        Mon, 19 Dec 2022 04:30:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221219043044epsmtrp1721d67c19f9bc2553b3683f29426ea73~yF36by5N-2028220282epsmtrp1H;
        Mon, 19 Dec 2022 04:30:44 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-ea-639fea06b2f2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.4B.14392.4F8EF936; Mon, 19 Dec 2022 13:30:44 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221219043042epsmtip277b46edd056102bd8587334526b14079~yF34voZYP0929209292epsmtip25;
        Mon, 19 Dec 2022 04:30:42 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>,
        "'Manivannan Sadhasivam'" <mani@kernel.org>
Cc:     "'Aman Gupta'" <aman1.gupta@samsung.com>, <shradha.t@samsung.com>,
        <pankaj.dubey@samsung.com>, <kishon@ti.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <shuah@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Mon, 19 Dec 2022 10:00:40 +0530
Message-ID: <001501d91362$a8689810$f939c830$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdkTYae8tp7m6A33Rh2/wd8u2KF0Mw==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhi7bq/nJBhPWqFss2NXAaHHhaQ+b
        RUPPb1aL6Xfes1mcnXeczaLlTwuLxYEPqxgt7rZ0sloc3RhssWjrF3aL3sO1FlNermN34PHY
        tKqTzePOtT1sHk+uTGfy6NuyitHj+I3tTB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54NJGj4LZvxb5fJ1gaGM/ZdDFyckgI
        mEjMmfGQpYuRi0NIYDejxK0XT5kgnE+MEsvvdjBCON8YJZau3MUK09J8cgZU1V5GiX9XvrNC
        OM8ZJbZP6WIHqWITiJDo6bwHZosI5Es8eTGHDcRmFljDJHHmrxmILSwQK7HsUx9QDQcHi4Cq
        RF9PIUiYV8BSouP8PSYIW1Di5MwnLBCt2hLLFr5mhjhCQeLn02WsEOP1JBZ/f84EUSMucfRn
        DzPIPRICSzkkpqy/xwjR4CJx8fJ9qA+EJV4d38IOYUtJvOxvg7LjJc7/XcYCYWdIXN77FMq2
        lzhwZQ4LyJ3MApoS63fpQ4RlJaaeWge1l0+i9/cTJog4r8SOeTC2qsT3KR1QN0tLNL0+C3WC
        h8SxxQ+ZJjAqzkLy5iwkb85C8s4shM0LGFlWMUqmFhTnpqcWmxYY5qWWw+M7OT93EyM4AWt5
        7mC8++CD3iFGJg7GQ4wSHMxKIry/bs5LFuJNSaysSi3Kjy8qzUktPsRoCgz6icxSosn5wByQ
        VxJvaGJpYGJmZmZiaWxmqCTOm7p1frKQQHpiSWp2ampBahFMHxMHp1QDk1TV4i/fortVRbiz
        b+dPW8uvsSTVZd9Rxocvd2n+6mstcM+XvbdB5pnEifOJEz5rLtHr/HTZ4q637tr/TRkfW/jW
        mrqHRr+LE+xesMvp554zE+c9LVuTLDi39sm713URN7q40xOvf1ZilelyiJWetti869CDnSwb
        uLpdTX+2H/99xa1k2tPary8ndNqZPQr8r6SQs/cT/4YJBf1JH+7s7rvg3Lt6/tQc5k3PDwQa
        MtYLPKwvCl2z/+ON7U4r/s4uFflzo+PScW+eQoOfGp8kY832n3NePzujy/DueePwUt4y2Zq/
        BSI/d0javBSKXfzpgVWy5kZGHqPquvN2HSuD7wuk2yo/LPuTkiMxaW7EZyWW4oxEQy3mouJE
        AEZmDjpJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXvfLi/nJBg2nuCwW7GpgtLjwtIfN
        oqHnN6vF9Dvv2SzOzjvOZtHyp4XF4sCHVYwWd1s6WS2Obgy2WLT1C7tF7+Faiykv17E78Hhs
        WtXJ5nHn2h42jydXpjN59G1Zxehx/MZ2Jo/Pm+QC2KK4bFJSczLLUov07RK4Mi7+6WYp+ORV
        8XH5G7YGxrOWXYycHBICJhLNJ2cwdTFycQgJ7GaUODxjFRNEQlri/tlJbBC2sMTKf8/ZIYqe
        Mko83PofLMEmECZxaOJMRhBbRCBf4smLOWwgRcwC25gkJp2bBJTg4BAWiJZ4OrUexGQRUJXo
        6ykEKecVsJToOH+PCcIWlDg58wkLiM0soC3R+7CVEcZetvA1M8QNChI/ny5jhVilJ7H4+3Mm
        iBpxiaM/e5gnMArOQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjOCo0tLcwbh91Qe9Q4xMHIyHGCU4mJVEeH/dnJcsxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5ON2519Wwo7Wn3nTnm/Wc5v679rImXfHm/4k5aT
        IXKmsjXlfGnpiy2xZ46pWj19+fRv9xob8TkR7/fynJZ4NYebK/f/sr/Tnjz5wW1g8+fdn5MB
        8+YuLF25pKRQQnz/8bhb9xuL31+d09ZeZvE0pfXR9ztO3SXbBD1Kt5enSFgr3toy2c42Pc/R
        5HrOXoXT4WdlNi9Y8pjntJxF8PFX35N/rVy9M+iZnMjSxBfJH4SnTAywMG0p+Bly4eQPneI7
        e3/+vSi77nTooWV5JRtC3jLwc5sfcTNJC2djTTGb91S05qZkq/PNC4aMtZK6H2b+m7C331To
        UsnpExYJRtMqBCuPKrhXMsUc+h224JSUbmmDEktxRqKhFnNRcSIANEFWshkDAAA=
X-CMS-MailID: 20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73
References: <CGME20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73@epcas5p3.samsung.com>
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
> From: Manivannan Sadhasivam =5Bmailto:manivannan.sadhasivam=40linaro.org=
=5D
> Sent: 01 November 2022 22:50
> To: Manivannan Sadhasivam <mani=40kernel.org>
> Cc: Aman Gupta <aman1.gupta=40samsung.com>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> kw=40linux.com; shuah=40kernel.org; linux-pci=40vger.kernel.org; linux-
> kselftest=40vger.kernel.org; Padmanabhan Rajanbabu
> <p.rajanbabu=40samsung.com>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> On Tue, Nov 01, 2022 at 07:32:16PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Oct 07, 2022 at 11:09:34AM +0530, Aman Gupta wrote:
> > > This patch enables the support to perform selftest on PCIe endpoint
> > > driver present in the system. The following tests are currently
> > > performed by the selftest utility
> > >
> > > 1. BAR Tests (BAR0 to BAR5)
> > > 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> > > 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> > > 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> > > 1024001 Bytes)
> > >
> > > Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> > > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> > > ---
> > >  tools/testing/selftests/Makefile           =7C   1 +
> > >  tools/testing/selftests/pci/.gitignore     =7C   1 +
> > >  tools/testing/selftests/pci/Makefile       =7C   7 +
> > >  tools/testing/selftests/pci/pci-selftest.c =7C 167
> > > +++++++++++++++++++++
> > >  4 files changed, 176 insertions(+)
> > >  create mode 100644 tools/testing/selftests/pci/.gitignore
> > >  create mode 100644 tools/testing/selftests/pci/Makefile
> > >  create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> > >
> > > diff --git a/tools/testing/selftests/Makefile
> > > b/tools/testing/selftests/Makefile
> > > index c2064a35688b..81584169a80f 100644
> > > --- a/tools/testing/selftests/Makefile
> > > +++ b/tools/testing/selftests/Makefile
> > > =40=40 -49,6 +49,7 =40=40 TARGETS +=3D net/forwarding  TARGETS +=3D n=
et/mptcp
> > > TARGETS +=3D netfilter  TARGETS +=3D nsfs
> > > +TARGETS +=3D pci
> > >  TARGETS +=3D pidfd
> > >  TARGETS +=3D pid_namespace
> > >  TARGETS +=3D powerpc
> > > diff --git a/tools/testing/selftests/pci/.gitignore
> > > b/tools/testing/selftests/pci/.gitignore
> > > new file mode 100644
> > > index 000000000000..db01411b8200
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/.gitignore
> > > =40=40 -0,0 +1 =40=40
> > > +pci-selftest
> > > diff --git a/tools/testing/selftests/pci/Makefile
> > > b/tools/testing/selftests/pci/Makefile
> > > new file mode 100644
> > > index 000000000000..76b7725a45ae
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/Makefile
> > > =40=40 -0,0 +1,7 =40=40
> > > +=23 SPDX-License-Identifier: GPL-2.0
> > > +CFLAGS +=3D -O2 -Wl,-no-as-needed -Wall LDFLAGS +=3D -lrt -lpthread =
-lm
> > > +
> > > +TEST_GEN_PROGS =3D pci-selftest
> > > +
> > > +include ../lib.mk
> > > diff --git a/tools/testing/selftests/pci/pci-selftest.c
> > > b/tools/testing/selftests/pci/pci-selftest.c
> > > new file mode 100644
> > > index 000000000000..73e8f3eb1982
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/pci-selftest.c
> >
> > endpoint-test.c
Okay I will change the file name in the next patch.
> >
> > > =40=40 -0,0 +1,167 =40=40
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCI Endpoint Driver Test Program
> > > + *
> > > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > > + *             https://www.samsung.com
> > > + * Author: Aman Gupta <aman1.gupta=40samsung.com>  */
> > > +
> > > +=23include <errno.h>
> > > +=23include <fcntl.h>
> > > +=23include <stdbool.h>
> > > +=23include <stdio.h>
> > > +=23include <stdlib.h>
> > > +=23include <sys/ioctl.h>
> > > +=23include <unistd.h>
> > > +
> > > +=23include =22../kselftest_harness.h=22
> > > +
> > > +=23define PCITEST_BAR		_IO('P', 0x1)
> > > +=23define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > > +=23define PCITEST_MSI		_IOW('P', 0x3, int)
> > > +=23define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > > +=23define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > > +=23define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > > +=23define PCITEST_MSIX		_IOW('P', 0x7, int)
> > > +=23define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > +=23define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > +=23define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > +
> > > +static char *test_device =3D =22/dev/pci-endpoint-test.0=22;
> > > +
> > > +struct xfer_param =7B
> > > +	unsigned long size;
> > > +	unsigned char flag;
> > > +	=7D;
> >
> > Align '=7D'
Okay.
> >
> > > +
> > > +FIXTURE(device)
> > > +=7B
> > > +	int fd;
> > > +=7D;
> > > +
> > > +FIXTURE_SETUP(device)
> > > +=7B
> > > +
> > > +	self->fd =3D open(test_device, O_RDWR);
> > > +
> > > +	ASSERT_NE(-1, self->fd) =7B
> > > +		TH_LOG(=22Can't open PCI Endpoint Test device=5Cn=22);
> > > +	=7D
> > > +=7D
> > > +
> > > +FIXTURE_TEARDOWN(device)
> > > +=7B
> > > +	close(self->fd);
> > > +=7D
> > > +
> > > +TEST_F(device, BAR_TEST)
> > > +=7B
> > > +	int ret =3D -EINVAL;
> >
> > Ininitialization not required here and also in other functions.
Understood , I will make the changes in the next patch.
> >
> > > +	int final =3D 0;
> > > +
> > > +	for (int i =3D 0; i <=3D 5; i++) =7B
> > > +		ret =3D ioctl(self->fd, PCITEST_BAR, i);
> > > +
> > > +		EXPECT_EQ(1, ret) =7B
> >
> > The return value of all these IOCTL's are going to change when =5B1=5D =
get's
> merged.
> >
> > =5B1=5D
> > https://lore.kernel.org/linux-pci/20220824123010.51763-1-manivannan.sa
> > dhasivam=40linaro.org/
> >
> > I'd suggest to resubmit this selftest after that.


Manivannan, the patch link you have provided cannot be directly applies=20
on the latest kernel and hence it requires some re work .I can rework these=
=20
patches along with the kselftest patch if not please allow me to go ahead=
=20
and post the kselftest patch till then.
> >
>=20
> Looks like we might end up removing the tests under tools/pci and just us=
e
> this one. I will CC you on the v3 of PCI test cleanup series. Please reba=
se this
> patch on top of that and post after incorporating the review comments.

Okay, I will rebase the patches after v3 clean up gets posted.
>=20
> Thanks,
> Mani
>=20
> > Thanks,
> > Mani
> >
> > > +			TH_LOG(=22TEST FAILED FOR BAR %d=5Cn=22, i);
> > > +			final++;
> > > +		=7D
> > > +	=7D
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +=7D
> > > +
> > > +TEST_F(device, MSI_TEST)
> > > +=7B
> > > +	int ret =3D -EINVAL;
> > > +	int final =3D 0;
> > > +
> > > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	for (int i =3D 1; i <=3D 32; i++) =7B
> > > +		ret =3D ioctl(self->fd, PCITEST_MSI, i);
> > > +		EXPECT_EQ(1, ret) =7B
> > > +			TH_LOG(=22TEST FAILED FOR MSI%d=5Cn=22, i);
> > > +			final++;
> > > +		=7D
> > > +	=7D
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +=7D
> > > +
> > > +TEST_F(device, READ_TEST)
> > > +=7B
> > > +	int final =3D 0;
> > > +	int ret =3D -EINVAL;
> > > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D=
;
> > > +
> > > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag =3D 0;
> > > +	for (int i =3D 0; i < 5; i++) =7B
> > > +		param.size =3D SIZE=5Bi=5D;
> > > +		ret =3D ioctl(self->fd, PCITEST_READ, &param);
> > > +		EXPECT_EQ(1, ret) =7B
> > > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > > +			final++;
> > > +		=7D
> > > +	=7D
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +=7D
> > > +
> > > +TEST_F(device, WRITE_TEST)
> > > +=7B
> > > +	int final =3D 0;
> > > +	int ret =3D -EINVAL;
> > > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D=
;
> > > +
> > > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag =3D 0;
> > > +
> > > +	for (int i =3D 0; i < 5; i++) =7B
> > > +		param.size =3D SIZE=5Bi=5D;
> > > +		ret =3D ioctl(self->fd, PCITEST_WRITE, &param);
> > > +		EXPECT_EQ(1, ret) =7B
> > > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > > +			final++;
> > > +		=7D
> > > +	=7D
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +=7D
> > > +
> > > +TEST_F(device, COPY_TEST)
> > > +=7B
> > > +	int final =3D 0;
> > > +	int ret =3D -EINVAL;
> > > +	unsigned long SIZE=5B5=5D =3D =7B1, 1024, 1025, 1024000, 1024001=7D=
;
> > > +
> > > +	ret =3D ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag =3D 0;
> > > +
> > > +	for (int i =3D 0; i < 5; i++) =7B
> > > +		param.size =3D SIZE=5Bi=5D;
> > > +		ret =3D ioctl(self->fd, PCITEST_COPY, &param);
> > > +		EXPECT_EQ(1, ret) =7B
> > > +			TH_LOG(=22TEST FAILED FOR size =3D%ld.=5Cn=22, SIZE=5Bi=5D);
> > > +			final++;
> > > +		=7D
> > > +	=7D
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +=7D
> > > +TEST_HARNESS_MAIN
> > > --
> > > 2.17.1
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D=0D=0A>=20=0D=0A>=20--=0D=0A>=20=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=
=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=
=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=8D=0D=0AThank=20you=20for=
=20reviewing=20the=20patch.=0D=0A=0D=0ARegards=0D=0AAman=20gupta=0D=0A=0D=0A
