Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9148C6569EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 12:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiL0L1W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 06:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiL0L1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 06:27:02 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BBAE5B
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 03:26:59 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221227112655epoutp040a1521820c83d8df33ae693fd3b2e9ab~0otlBHzZz0803808038epoutp04Z
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 11:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221227112655epoutp040a1521820c83d8df33ae693fd3b2e9ab~0otlBHzZz0803808038epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672140415;
        bh=ppVNGPjDtiPr0nzutVdXnWJrOzUX8smAyy68IvbhYYI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HYCmk2iIzanmVxoIsUwhM6Z7hmAEOIoPCC6KdfZ9NHmPasNcPE9J05p+2IKwddAfD
         4zXRCyCvw2QXFo1uzaPSqDQOUoEdeOPhV/twibVYrTw9dHmjX2pVDokABqCgo45oz5
         3addSfnhuz9O3GPJtShaUhbE+0wa+0mkyWbYvFn8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221227112654epcas5p3dd1ea26b5b587177d7de69b4b5d12251~0otkE6Z732135721357epcas5p31;
        Tue, 27 Dec 2022 11:26:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NhC6P48hYz4x9Q1; Tue, 27 Dec
        2022 11:26:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.38.62806.D76DAA36; Tue, 27 Dec 2022 20:26:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221227051530epcas5p38ba8619673bc3a997c25368152be052e~0jpR_vxOr0725007250epcas5p3B;
        Tue, 27 Dec 2022 05:15:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221227051530epsmtrp15e5c5b40254b297b3bf3c34ddcb3c166~0jpR95j462265422654epsmtrp1k;
        Tue, 27 Dec 2022 05:15:30 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-1f-63aad67dba50
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.46.10542.17F7AA36; Tue, 27 Dec 2022 14:15:29 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221227051528epsmtip1b1e935ee71fad6cf8725ab942f9575ac~0jpQPxRLA0380003800epsmtip1a;
        Tue, 27 Dec 2022 05:15:28 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Shuah Khan'" <skhan@linuxfoundation.org>,
        "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc:     <shradha.t@samsung.com>, <pankaj.dubey@samsung.com>,
        <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <shuah@kernel.org>, "'Bjorn Helgaas'" <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
In-Reply-To: <7dcefe25-d31c-bc26-4910-e53bed6eb01c@linuxfoundation.org>
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Tue, 27 Dec 2022 10:45:26 +0530
Message-ID: <003d01d919b2$3c7d54a0$b577fde0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQFofYvwiqARWvL8UeiI8Zt/EpZYDAIhr9qdAalpc/cChsb4YwE9D0rUANGoP4wCy8h+hq8JBMfg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmlm7ttVXJBs2LZS1enVnLZnHhaQ+b
        RUPPb1aL6Xfes1mcnXeczaLlTwuLxd2WTlaLoxuDLRZt/cJu0Xu41mLKy3XsFnunL2N14PHY
        tKqTzePOtT1sHk+uTGfy2D93DbtH35ZVjB7Hb2xn8vi8SS6APSrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoTiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbl+9uYCpYpVnz8dZC5gbFB
        uouRk0NCwESi92ITaxcjF4eQwG5Gibczn7CBJIQEPjFKPP0YCmF/ZpQ4sSAcpuHWtYvMEPFd
        jBJPpjlDND9nlOi5/5MJJMEmECHR03mPvYuRg0NEIE/iwMs0kDCzwComiVPPA0HCnALuEtub
        q0HCwgKxEss+9bGD2CwCqhJr+/eBncArYClxo+UvI4QtKHFy5hMWiDHaEssWvmaGOEdB4ufT
        ZawQcXGJoz97mCG2Rkl8maQAUXKEQ+LVdU0I20Xi56atrBC2sMSr41vYIWwpiZf9bVB2vMT5
        v8tYIOwMict7n0LZ9hIHrsxhARnPLKApsX6XPkRYVmLqqXVMEBfwSfT+fsIEEeeV2DEPxlaV
        +D6lA+piaYmm12dZJzAqzULy2Cwkj81C8swshG0LGFlWMUqmFhTnpqcWmxYY5aWWw6M6OT93
        EyM4AWt57WB8+OCD3iFGJg7GQ4wSHMxKIry5N5YnC/GmJFZWpRblxxeV5qQWH2I0BYb2RGYp
        0eR8YA7IK4k3NLE0MDEzMzOxNDYzVBLnTd06P1lIID2xJDU7NbUgtQimj4mDU6qBKTKB/UeU
        PP88C6YP6ZM2zch8cLDyQ9mbe/VTFG98LufK/Nlvo7Ps6qw9N7aqXkutmrH+B6/jnhP1epLS
        U6ZM3sZ53/i33r8jU01m9TE/SVm9fRrLfQmvRg+lPyd+5p34OpGxV4zXlk3gXb6ET6N41X0r
        QQXG02cYTqsW7fjAbsiUqa67bdWLL3eCee4dbDTk/LZvZuuFrf+38UU0b14fm/b/mfl+m4xr
        e96xHll2QV7r6E2H+6meHSvNAz9f33x2Xzfn0ktstvyzDnDf4rL6t6H73J3Ypsp1X1pztgRN
        98lPXlzzwtE7+P3aSt+0uQJrb++MbixY27Znm72ah+Pp7x21k6JYzRlWX74bs0XTc48SS3FG
        oqEWc1FxIgBrNfbcSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnG5h/apkg3NbbCxenVnLZnHhaQ+b
        RUPPb1aL6Xfes1mcnXeczaLlTwuLxd2WTlaLoxuDLRZt/cJu0Xu41mLKy3XsFnunL2N14PHY
        tKqTzePOtT1sHk+uTGfy2D93DbtH35ZVjB7Hb2xn8vi8SS6APYrLJiU1J7MstUjfLoEr4+l1
        z4J/ChX7NlxiamA8I9XFyMkhIWAicevaReYuRi4OIYEdjBJbD8xmgUhIS9w/O4kNwhaWWPnv
        OTtE0VNGibtfV7GDJNgEwiQOTZzJCGKLCORJbJkwGayBWWALk8TXdSUQDY3MEtfbrgIVcXBw
        CrhLbG+uBjGFBaIlnk6tBylnEVCVWNu/D6yVV8BS4kbLX0YIW1Di5MwnLBAjtSV6H7YywtjL
        Fr5mhrhNQeLn02WsEHFxiaM/e5hBxosIREl8maQwgVF4FpJJs5BMmoVk0iwk3QsYWVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHopbWDsY9qz7oHWJk4mA8xCjBwawkwpt7Y3my
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUw56RK/rp+2
        3Gwesbxk8fenXYoO8Z86pG4+kY7hdw6KeH1/zkvRXTGtfqU+f+78/vLB5v2C6Y4nuSZ+y5WX
        uHtZi0V6y7yemH1m/abH1Hm738X+jOPN1vaUSXtf8TPKtmpO2UX/U27Le36tKX7vUfXmaMbP
        q1+bxRS/xmUp+V7ZZz6VYenevZ5/W45uLH9ksXdVkveCrbNv5sxNTV0/s2HB2cwdf10mZPf0
        rT5981mm6MFmS7+zvXeLww9t6SoX/l/SmMeqwzRNNuWceuzeyK0zXh7etSJ+G3sGZylrRMOV
        2i+uB9J5F952SzjeL23UkiGgbLFLsvfe668ak4sS2RdPfBDwdca+jCPlMn2zNnYpsRRnJBpq
        MRcVJwIA+ScoPTQDAAA=
X-CMS-MailID: 20221227051530epcas5p38ba8619673bc3a997c25368152be052e
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
> From: Shuah Khan =5Bmailto:skhan=40linuxfoundation.org=5D
> Sent: 23 December 2022 22:01
> To: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Cc: Aman Gupta <aman1.gupta=40samsung.com>; shradha.t=40samsung.com;
> pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> kw=40linux.com; shuah=40kernel.org; Bjorn Helgaas <helgaas=40kernel.org>;
> linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org; Padmanabh=
an
> Rajanbabu <p.rajanbabu=40samsung.com>; Shuah Khan
> <skhan=40linuxfoundation.org>
> Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
> On 12/23/22 08:02, Manivannan Sadhasivam wrote:
> > On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
> >> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> >>> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> >>>> On 10/6/22 23:39, Aman Gupta wrote:
> >>>>> This patch enables the support to perform selftest on PCIe
> >>>>> endpoint driver present in the system. The following tests are
> >>>>> currently performed by the selftest utility
> >>>>>
> >>>>> 1. BAR Tests (BAR0 to BAR5)
> >>>>> 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> >>>>> 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> >>>>> 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> >>>>> 1024001 Bytes)
> >>>>>
> >>>>> Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> >>>>> Signed-off-by: Padmanabhan Rajanbabu
> <p.rajanbabu=40samsung.com>
> >>>>
> >>>> Adding Bjorn Helgaas to the thread.
> >>>>
> >>>> Adding pcit test under selftests is good. There is another pcitest
> >>>> under tools/pci. I would like to see if the existing code in
> >>>> tools/pci/pcitest.c can be leveraged.
> >>>>
> >>>> As part of this test work, also look into removing tools/pci so we
> >>>> don't have to maintain duplicate code in two places.
> >>>>
> >>>
> >>> It has been agreed in a thread with Greg =5B1=5D to =7Bre=7Dmove the =
tests
> >>> under tools/pci and utilize the kselftest.
> >>>
> >>
> >> Inline with what I am suggesting. However, I don't see either move or
> >> delete of tools/pci in the patch?
> >>
> >> The first patch could start with git mv of the existing files and
> >> then make changes to preserver the history.
> >>
> >
> > Right. This patch was posted independently of the series =5B1=5D that I
> > submitted to fix the return values of IOCTL calls used in
> > drivers/misc/pci_endpoint_test.c driver.
> >
> > Then in that series, it was decided to move the existing test to
> > kselftest. So, I suggested Aman Gupta =5B2=5D to integrate my latest
> > patches, add the kselftest patch on top, then remove the existing test
> under tools/pci.
> >
> > The kselftest patch can also move the driver first and then make the
> > change as you suggested. Either way it is fine by me.
> >
>=20
> As I mentioned in my previous email, I prefer to see the move as the firs=
t
> patch and then changes on top. This preserves the history and cleaner.
>=20
> thanks,
> -- Shuah
>=20

Hi Shuah,

Thanks for review and suggestion. I understand that we would like to reuse =
and preserve the history of tools/pci/pcietest.c. So we have two approaches=
:

1: Using git mv command move existing code from tools/pci/ to tools/testing=
/selftest/drivers/pci/ and then update the file to convert to kselftest fra=
mework. I thought about this but after movement, when we move it to kselfte=
st format it is going to be huge churn and we will be having modification i=
n almost all lines.

2: Develop kselftest based driver in tools/testing/selftest/drivers/pci/ an=
d eventually delete existing file from tools/pci/ folder providing justific=
ation in commit message.

=46rom my viewpoint, going with the second approach makes more sense becaus=
e if almost complete file is getting modified, and it will make the review =
process complex and anyways there is not much code reusability. =20
Please let me know if you have any other thought process or if I am missing=
 anything to understand your approach.

Thanks,
Aman Gupta
>=20


