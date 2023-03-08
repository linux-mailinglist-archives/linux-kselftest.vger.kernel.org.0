Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA636B056C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCHLHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCHLGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:06:49 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED16E95
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 03:06:45 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230308110642epoutp02a60998a0f547dea4ec91f218c0e67a28~KbPMd3gU20503305033epoutp02F
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 11:06:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230308110642epoutp02a60998a0f547dea4ec91f218c0e67a28~KbPMd3gU20503305033epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678273602;
        bh=tjBJYPqeuw+zDOLOIcBCjONFSzyOoz7WDqmP+Wds6sE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mj/nfG3AcI+PVCd+vdSMzMamH+JoKR/Cj4cEgXAnf8cGhfNsrymlb5E/3kadrSfQA
         Fe5Z32fEaZIu1bz6UBOn2CCfyvKfQeNDmASxBdzFLy9q5ZvPwg8ztwnkQjeu/oTwUy
         lS/hlKznNz+BQhI028btPg/GE5w7aZL8wc4zV0vU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230308110641epcas5p3ee30d9e0e13c5047fbc0356260b0b9b1~KbPL6dYTY0359103591epcas5p3N;
        Wed,  8 Mar 2023 11:06:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PWqJJ5m7Tz4x9Q2; Wed,  8 Mar
        2023 11:06:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.A5.10528.04C68046; Wed,  8 Mar 2023 20:06:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230308110619epcas5p2e91a10d1ea54d189a759cf8d26a0ac4c~KbO3XyJBf0411604116epcas5p2B;
        Wed,  8 Mar 2023 11:06:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230308110619epsmtrp1d0012d65e72aac4507ee7f289ca8c362~KbO3XE1pD1619616196epsmtrp10;
        Wed,  8 Mar 2023 11:06:19 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-f5-64086c40c470
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.D5.31821.B2C68046; Wed,  8 Mar 2023 20:06:19 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230308110617epsmtip2219edf1fe8e5fc51fd3a1f84ec88cd9d~KbO1WsdQy1517115171epsmtip2z;
        Wed,  8 Mar 2023 11:06:17 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc:     "'Shuah Khan'" <skhan@linuxfoundation.org>,
        <shradha.t@samsung.com>, <pankaj.dubey@samsung.com>,
        <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <shuah@kernel.org>, "'Bjorn Helgaas'" <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
In-Reply-To: <20230214061643.GA4981@thinkpad>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Wed, 8 Mar 2023 16:36:16 +0530
Message-ID: <00a301d951ae$02c0cf10$08426d30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFofYvwiqARWvL8UeiI8Zt/EpZYDAIhr9qdAalpc/cChsb4YwE9D0rUANGoP4wCy8h+hgG1SW5bAmNPN6yvWDLxwA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmpq5DDkeKQedxLYtXZ9ayWVx42sNm
        0dDzm9Vi+p33bBZn5x1ns2j508Jicbelk9Xi6MZgi0Vbv7Bb9B6utZjych27xd7py1gdeDw2
        repk87hzbQ+bx5Mr05k89s9dw+7Rt2UVo8fxG9uZPD5vkgtgj8q2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQndHUepip4KJuxbPGLywNjPtU
        uhg5OSQETCTmP5jI3MXIxSEksJtR4t6RmywQzidGiaUfe1ghnM+MEicvdLLDtBxYfpIRIrGL
        UWLfj/VMEM5zoKrfT9lAqtgEIiR6Ou+BdYgIOEi0v/3EAmIzC1xjkrh3qRDE5hTQlTh6bCdY
        XFggVmLZpz6wehYBFYn9t18xgti8ApYSC9/fZ4WwBSVOznwCNUdbYtnC18wQFylI/Hy6jBVi
        V5bEwq6FrBA14hJHf/aAPSchcIRDYtGJdWwQDS4S2xdPgnpHWOLV8S1QtpTEy/42KDte4vzf
        ZSwQdobE5b1PoWx7iQNX5gDZHEALNCXW79KHCMtKTD21jgliL59E7+8nTBBxXokd82BsVYnv
        UzqgbpaWaHp9lnUCo9IsJK/NQvLaLCQvzELYtoCRZRWjZGpBcW56arFpgWFeajk8xpPzczcx
        gtOxlucOxrsPPugdYmTiYDzEKMHBrCTC+12KI0WINyWxsiq1KD++qDQntfgQoykwvCcyS4km
        5wMzQl5JvKGJpYGJmZmZiaWxmaGSOK+67clkIYH0xJLU7NTUgtQimD4mDk6pBqYFp37MzWBb
        8X9O6bkfu76/UJ+c13f805tGyV7Pa3wskTF33rEmcM1wOaLDKFQiJsOY5Pvil6xazouvfk/m
        sUQUaS5L5NJpzJe7Hm8TpmXUt6BlYceK/wdazJaYvbt9WqCs5Z65svfpWMF5cb9dZv2vfRhb
        m7Rryenp7J+DGj3P9G6431CluUAqc7FdhtEJruVunzve2v1qv/Ni1Y/p7lG3GrUmFqRqKi8/
        Z7Ag7EDC85DIhq7NEf2tq862R1lYf9Av3V1Vdj4+p93l/KS1Xfp/j16fk3Klw61gcxXz6kVt
        67PtTXc45b0ydGPmb1iyz1j3yzEXy0CGxA7nimPf55/yf1Ih7BjEcOiKkKNQsBJLcUaioRZz
        UXEiABJB5X5QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvK52DkeKwZ8+Q4tXZ9ayWVx42sNm
        0dDzm9Vi+p33bBZn5x1ns2j508Jicbelk9Xi6MZgi0Vbv7Bb9B6utZjych27xd7py1gdeDw2
        repk87hzbQ+bx5Mr05k89s9dw+7Rt2UVo8fxG9uZPD5vkgtgj+KySUnNySxLLdK3S+DK+Hjp
        PlPBd52KTYs/szYw3lTuYuTkkBAwkTiw/CRjFyMXh5DADkaJli+XWSAS0hL3z05ig7CFJVb+
        e84OUfSUUWJ3735WkASbQJjEoYkzGUFsEQEHifa3n8CamQUeMUks+VEF0XCBWaL7yCewIk4B
        XYmjx3YCFXFwCAtESzydWg8SZhFQkdh/+xVYCa+ApcTC9/dZIWxBiZMzn0DN1JbofdjKCGMv
        W/iaGeI4BYmfT5exQtyQJbGwayErRI24xNGfPcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnBEamntYNyz6oPeIUYmDsZDjBIczEoivN+lOFKE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYMqRYFujntzx
        kmXX9Rox0ZVvmV6dX5/8+Y90Fg/HucSTV68oTQoVurkk/c2Oq+985DnSr6xKDWJ8dp5hn7Rt
        oznji5UmAsuc2oKeaBtfUmo6/p2x4IDVh/4bO6efmD3l9keDqWbHm9+Zbo+cb/P8Dqfuh5Az
        mubTco/te2Ypf+7DxLe1Wp3n4urTj+VFTL8jfPq+hkfVg1mib66tYHsT/6D5M/+LtT6trbNs
        Sz4cPDY1U+zY6j8M9/K8uo6yKzSrx1z/Zqf6XPr/6Yt/zFde5Cm4UWG6st1SmvHz2yOyU+x/
        mBamR3Murqq/YyUw6U/eTHb5PTzN92ZHXUv/7JVcNIv54ZLsba9lFijePfkkQJFViaU4I9FQ
        i7moOBEA0iht0zcDAAA=
X-CMS-MailID: 20230308110619epcas5p2e91a10d1ea54d189a759cf8d26a0ac4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221007053726epcas5p357c35abb79327fee6327bc6493e0178c
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
        <20221007053934.5188-1-aman1.gupta@samsung.com>
        <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
        <20221222174532.GA59500@thinkpad>
        <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
        <20221223150211.GC4587@thinkpad>
        <7dcefe25-d31c-bc26-4910-e53bed6eb01c@linuxfoundation.org>
        <003d01d919b2$3c7d54a0$b577fde0$@samsung.com>
        <20230214061643.GA4981@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: 'Manivannan Sadhasivam'
> =5Bmailto:manivannan.sadhasivam=40linaro.org=5D
> Sent: 14 February 2023 11:47
> To: Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics
> <aman1.gupta=40samsung.com>
> Cc: 'Shuah Khan' <skhan=40linuxfoundation.org>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> kw=40linux.com; shuah=40kernel.org; 'Bjorn Helgaas' <helgaas=40kernel.org=
>;
> linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org; 'Padmanab=
han
> Rajanbabu' <p.rajanbabu=40samsung.com>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> On Tue, Dec 27, 2022 at 10:45:26AM +0530, Aman Gupta/FDS SW
> /SSIR/Engineer/Samsung Electronics wrote:
> >
> >
> > > -----Original Message-----
> > > From: Shuah Khan =5Bmailto:skhan=40linuxfoundation.org=5D
> > > Sent: 23 December 2022 22:01
> > > To: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> > > Cc: Aman Gupta <aman1.gupta=40samsung.com>;
> shradha.t=40samsung.com;
> > > pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> > > kw=40linux.com; shuah=40kernel.org; Bjorn Helgaas <helgaas=40kernel.o=
rg>;
> > > linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org;
> > > Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>; Shuah Khan
> > > <skhan=40linuxfoundation.org>
> > > Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support fo=
r
> > > PCI endpoint driver test
> > >
> > > On 12/23/22 08:02, Manivannan Sadhasivam wrote:
> > > > On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
> > > >> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> > > >>> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> > > >>>> On 10/6/22 23:39, Aman Gupta wrote:
> > > >>>>> This patch enables the support to perform selftest on PCIe
> > > >>>>> endpoint driver present in the system. The following tests are
> > > >>>>> currently performed by the selftest utility
> > > >>>>>
> > > >>>>> 1. BAR Tests (BAR0 to BAR5)
> > > >>>>> 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1,
> > > >>>>> 1024, 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1,
> > > >>>>> 1024, 1025, 1024000, 1024001 Bytes) 5. Copy Tests (For 1,
> > > >>>>> 1024, 1025, 1024000,
> > > >>>>> 1024001 Bytes)
> > > >>>>>
> > > >>>>> Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> > > >>>>> Signed-off-by: Padmanabhan Rajanbabu
> > > <p.rajanbabu=40samsung.com>
> > > >>>>
> > > >>>> Adding Bjorn Helgaas to the thread.
> > > >>>>
> > > >>>> Adding pcit test under selftests is good. There is another
> > > >>>> pcitest under tools/pci. I would like to see if the existing
> > > >>>> code in tools/pci/pcitest.c can be leveraged.
> > > >>>>
> > > >>>> As part of this test work, also look into removing tools/pci so
> > > >>>> we don't have to maintain duplicate code in two places.
> > > >>>>
> > > >>>
> > > >>> It has been agreed in a thread with Greg =5B1=5D to =7Bre=7Dmove =
the
> > > >>> tests under tools/pci and utilize the kselftest.
> > > >>>
> > > >>
> > > >> Inline with what I am suggesting. However, I don't see either
> > > >> move or delete of tools/pci in the patch?
> > > >>
> > > >> The first patch could start with git mv of the existing files and
> > > >> then make changes to preserver the history.
> > > >>
> > > >
> > > > Right. This patch was posted independently of the series =5B1=5D th=
at
> > > > I submitted to fix the return values of IOCTL calls used in
> > > > drivers/misc/pci_endpoint_test.c driver.
> > > >
> > > > Then in that series, it was decided to move the existing test to
> > > > kselftest. So, I suggested Aman Gupta =5B2=5D to integrate my lates=
t
> > > > patches, add the kselftest patch on top, then remove the existing
> > > > test
> > > under tools/pci.
> > > >
> > > > The kselftest patch can also move the driver first and then make
> > > > the change as you suggested. Either way it is fine by me.
> > > >
> > >
> > > As I mentioned in my previous email, I prefer to see the move as the
> > > first patch and then changes on top. This preserves the history and
> cleaner.
> > >
> > > thanks,
> > > -- Shuah
> > >
> >
> > Hi Shuah,
> >
> > Thanks for review and suggestion. I understand that we would like to re=
use
> and preserve the history of tools/pci/pcietest.c. So we have two approach=
es:
> >
> > 1: Using git mv command move existing code from tools/pci/ to
> tools/testing/selftest/drivers/pci/ and then update the file to convert t=
o
> kselftest framework. I thought about this but after movement, when we
> move it to kselftest format it is going to be huge churn and we will be h=
aving
> modification in almost all lines.
> >
> > 2: Develop kselftest based driver in tools/testing/selftest/drivers/pci=
/ and
> eventually delete existing file from tools/pci/ folder providing justific=
ation in
> commit message.
> >
> > From my viewpoint, going with the second approach makes more sense
> because if almost complete file is getting modified, and it will make the
> review process complex and anyways there is not much code reusability.
> > Please let me know if you have any other thought process or if I am mis=
sing
> anything to understand your approach.
> >
>=20
> As Bjorn and Shuah said, I presume you are working on option 1.
>=20
> Thanks,
> Mani
>=20
Hi Mani,
Yes I am working on it, soon I will post the patches.
Thanks ,
Aman Gupta
> > Thanks,
> > Aman Gupta
> > >
> >
> >
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A
