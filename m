Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2166D826
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjAQI1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 03:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjAQI1R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 03:27:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7E22798
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 00:27:14 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230117082713epoutp042d13f0ec850e976b26ded00d3cbabe0b~7Czqv29p31212412124epoutp04A
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 08:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230117082713epoutp042d13f0ec850e976b26ded00d3cbabe0b~7Czqv29p31212412124epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673944033;
        bh=S3Ojmh1XA4ZWIhhqdoj+w/+9KBQjnC5giJH2MCTF8rw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=h+oaoMXfpas/6KKtdQtV63pJA8f3mBReausflaxHy/Orw3Xe3USnuVBblw3mMR5t8
         Xzw1OIio9ATc5ATWf2VwrtWk+2Q1wpJsc3JXOb83lHRb1ObGwkb7VxJExoi5Kpfvyf
         pLRuM8Pex0Aw18IuUloiwacJWhSLEkHMuyF+ls+0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230117082712epcas5p37dcc08d6c2228bf0649b25b6efe54ab9~7CzqaMqGX1808218082epcas5p3k;
        Tue, 17 Jan 2023 08:27:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nx27M38RMz4x9QS; Tue, 17 Jan
        2023 08:27:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.6B.62806.FDB56C36; Tue, 17 Jan 2023 17:27:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117081303epcas5p285d274074092a1f9c2f82629329e075e~7CnTOt6yM2643826438epcas5p22;
        Tue, 17 Jan 2023 08:13:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230117081303epsmtrp2f5a058985e02d151062da86aef8a8764~7CnTNz7xE2401024010epsmtrp2j;
        Tue, 17 Jan 2023 08:13:03 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-91-63c65bdf2b0c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.9F.02211.F8856C36; Tue, 17 Jan 2023 17:13:03 +0900 (KST)
Received: from FDSFTE506 (unknown [107.122.82.24]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230117081301epsmtip2f9b454f6fe56e895cbd9a5fa95835539~7CnRfxvej2754227542epsmtip2Q;
        Tue, 17 Jan 2023 08:13:01 +0000 (GMT)
From:   "Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics" 
        <aman1.gupta@samsung.com>
To:     "'Shuah Khan'" <skhan@linuxfoundation.org>,
        "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc:     <shradha.t@samsung.com>, <pankaj.dubey@samsung.com>,
        <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <shuah@kernel.org>, "'Bjorn Helgaas'" <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Date:   Tue, 17 Jan 2023 13:42:59 +0530
Message-ID: <03e201d92a4b$851a7e00$8f4f7a00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFofYvwiqARWvL8UeiI8Zt/EpZYDAIhr9qdAalpc/cChsb4YwE9D0rUANGoP4wCy8h+hq8JBMfggCEz27A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmlu796GPJBgc+ilm8OrOWzeLC0x42
        i4ae36wW0++8Z7M4O+84m0XLnxYWi7stnawWRzcGWyza+oXdovdwrcWUl+vYLfZOX8bqwOOx
        aVUnm8eda3vYPJ5cmc7ksX/uGnaPvi2rGD2O39jO5PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iy27q2MBWe0Kh50f2NqYLyo
        1MXIySEhYCKxbmknSxcjF4eQwG5GifnbbzNDOJ8YJS6daWSHcL4xSszs3McI07Lh9XMWEFtI
        YC+jxM3Ocoii54wSK5btYwNJsAlESPR03gPq5uAQEciTOPAyDSTMLLCKSeLU80CQMKcAr8SE
        f9YgYWGBWIlln/rYQWwWAVWJv9svMoPYvAKWEoe2/2eEsAUlTs58wgIxRlti2cLXzBDnKEj8
        fLqMFcQWEUiSOLj9KztEjbjE0Z89YM9ICBzhkPhzth3qfheJk/M3skLYwhKvjm9hh7ClJD6/
        28sGYcdLnP+7jAXCzpC4vPcplG0vceDKHBaQ+5kFNCXW79KHCMtKTD21jgliL59E7+8nTBBx
        Xokd82BsVYnvUzqgbpaWaHp9lnUCo9IsJK/NQvLaLCQvzELYtoCRZRWjZGpBcW56arFpgVFe
        ajk8upPzczcxghOxltcOxocPPugdYmTiYDzEKMHBrCTC67frcLIQb0piZVVqUX58UWlOavEh
        RlNgeE9klhJNzgfmgrySeEMTSwMTMzMzE0tjM0Mlcd7UrfOThQTSE0tSs1NTC1KLYPqYODil
        Gph2v2Gavzcrpqyx+YqivZpAvPOc1UV6Sdkn/zvbrzLWs1+WuCpAImbWzMXPQz4XsRVsPK2m
        lv++Y7atb3NZzleLP1dT7lTNctx2VV4v/ldK82KugLxD3vrBdrce/GPiWH3v4KKPcRn9vZMN
        L22wmfTN8rWkW+9XA/c8+4W2jYuM1OP/vO1X/7bA32Ety8rKinDLQwHitz/se/Hnc2CqyLy1
        n/lmPmHbvW3BZ903Xpp5W7Oyr2n/615wXXjxTC+7tXvj8zdxR5ku0TBNXJtlLvbk/GXZs9eL
        X0o9s5l3xat21+MpyQ5XDC1jz/y8pZMYfVyvu1GA94aVcjvnDu1YtaOmFpoVB1ycudyffw44
        vlyJpTgj0VCLuag4EQArXfK2TQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvG5/xLFkgw8PuSxenVnLZnHhaQ+b
        RUPPb1aL6Xfes1mcnXeczaLlTwuLxd2WTlaLoxuDLRZt/cJu0Xu41mLKy3XsFnunL2N14PHY
        tKqTzePOtT1sHk+uTGfy2D93DbtH35ZVjB7Hb2xn8vi8SS6APYrLJiU1J7MstUjfLoEr4+6H
        T+wFHzUrfl97zNjA+Eaxi5GTQ0LARGLD6+csXYxcHEICuxklfm/pYoRISEvcPzuJDcIWllj5
        7zk7RNFTRokZnz+DFbEJhEkcmjgTzBYRyJPYMmEyWAOzwBYmia/rSiAampglVlzay9rFyMHB
        KcArMeGfNYgpLBAt8XRqPUg5i4CqxN/tF5lBbF4BS4lD2/8zQtiCEidnPmGBGKkt0fuwlRHG
        XrbwNTPEbQoSP58uY4U4IUni4Pav7BA14hJHf/YwT2AUnoVk1Cwko2YhGTULScsCRpZVjJKp
        BcW56bnFhgWGeanlesWJucWleel6yfm5mxjB8ailuYNx+6oPeocYmTgYDzFKcDArifD67Tqc
        LMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT1JSYejF/
        GZ2PHVclL7r/ky8y/yIfUra//dk11SX3liRwnFgxZw7b6+u/rj+9x6t498ibexwHVuyPv3lN
        XHP7HAdbplnLjt+ews+5QsPPKYBxw2KNxx3zCje7+zHPXsHXG8zPdizhqLx9ktzzdXMsTp97
        zPjJoDNmOp/IwQO2Yp0lAWULrpvmcahxaH79cl6zMGdO/c+P7etDJs+dtPxW6M7U47su7mfb
        xKla5pz2fJVBRlfNywn7J58W+rL59M4ZKa/LM2qy/SYIbnrnotKekdzqmr5CTPiEj3Sg2El/
        vedyYsmFrP8CbVwOSOc3e73Usaw6PTvC6e2lnso/3GxFK5O03j/cNGPK9/ULFho3KbEUZyQa
        ajEXFScCADa89ZU2AwAA
X-CMS-MailID: 20230117081303epcas5p285d274074092a1f9c2f82629329e075e
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

Respected madam/sir
Gentle Reminder

> -----Original Message-----
> From: Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics
> =5Bmailto:aman1.gupta=40samsung.com=5D
> Sent: 27 December 2022 10:45
> To: 'Shuah Khan' <skhan=40linuxfoundation.org>; 'Manivannan Sadhasivam'
> <manivannan.sadhasivam=40linaro.org>
> Cc: 'shradha.t=40samsung.com' <shradha.t=40samsung.com>;
> 'pankaj.dubey=40samsung.com' <pankaj.dubey=40samsung.com>;
> 'kishon=40ti.com' <kishon=40ti.com>; 'lpieralisi=40kernel.org'
> <lpieralisi=40kernel.org>; 'kw=40linux.com' <kw=40linux.com>;
> 'shuah=40kernel.org' <shuah=40kernel.org>; 'Bjorn Helgaas'
> <helgaas=40kernel.org>; 'linux-pci=40vger.kernel.org' <linux-
> pci=40vger.kernel.org>; 'linux-kselftest=40vger.kernel.org' <linux-
> kselftest=40vger.kernel.org>; 'Padmanabhan Rajanbabu'
> <p.rajanbabu=40samsung.com>
> Subject: RE: =5BPATCH=5D selftests: pci: pci-selftest: add support for PC=
I endpoint
> driver test
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shuah Khan =5Bmailto:skhan=40linuxfoundation.org=5D
> > Sent: 23 December 2022 22:01
> > To: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> > Cc: Aman Gupta <aman1.gupta=40samsung.com>;
> shradha.t=40samsung.com;
> > pankaj.dubey=40samsung.com; kishon=40ti.com; lpieralisi=40kernel.org;
> > kw=40linux.com; shuah=40kernel.org; Bjorn Helgaas <helgaas=40kernel.org=
>;
> > linux-pci=40vger.kernel.org; linux-kselftest=40vger.kernel.org;
> > Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>; Shuah Khan
> > <skhan=40linuxfoundation.org>
> > Subject: Re: =5BPATCH=5D selftests: pci: pci-selftest: add support for =
PCI
> > endpoint driver test
> >
> > On 12/23/22 08:02, Manivannan Sadhasivam wrote:
> > > On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
> > >> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> > >>> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> > >>>> On 10/6/22 23:39, Aman Gupta wrote:
> > >>>>> This patch enables the support to perform selftest on PCIe
> > >>>>> endpoint driver present in the system. The following tests are
> > >>>>> currently performed by the selftest utility
> > >>>>>
> > >>>>> 1. BAR Tests (BAR0 to BAR5)
> > >>>>> 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1,
> > >>>>> 1024, 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024,
> > >>>>> 1025, 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025,
> > >>>>> 1024000,
> > >>>>> 1024001 Bytes)
> > >>>>>
> > >>>>> Signed-off-by: Aman Gupta <aman1.gupta=40samsung.com>
> > >>>>> Signed-off-by: Padmanabhan Rajanbabu
> > <p.rajanbabu=40samsung.com>
> > >>>>
> > >>>> Adding Bjorn Helgaas to the thread.
> > >>>>
> > >>>> Adding pcit test under selftests is good. There is another
> > >>>> pcitest under tools/pci. I would like to see if the existing code
> > >>>> in tools/pci/pcitest.c can be leveraged.
> > >>>>
> > >>>> As part of this test work, also look into removing tools/pci so
> > >>>> we don't have to maintain duplicate code in two places.
> > >>>>
> > >>>
> > >>> It has been agreed in a thread with Greg =5B1=5D to =7Bre=7Dmove th=
e tests
> > >>> under tools/pci and utilize the kselftest.
> > >>>
> > >>
> > >> Inline with what I am suggesting. However, I don't see either move
> > >> or delete of tools/pci in the patch?
> > >>
> > >> The first patch could start with git mv of the existing files and
> > >> then make changes to preserver the history.
> > >>
> > >
> > > Right. This patch was posted independently of the series =5B1=5D that=
 I
> > > submitted to fix the return values of IOCTL calls used in
> > > drivers/misc/pci_endpoint_test.c driver.
> > >
> > > Then in that series, it was decided to move the existing test to
> > > kselftest. So, I suggested Aman Gupta =5B2=5D to integrate my latest
> > > patches, add the kselftest patch on top, then remove the existing
> > > test
> > under tools/pci.
> > >
> > > The kselftest patch can also move the driver first and then make the
> > > change as you suggested. Either way it is fine by me.
> > >
> >
> > As I mentioned in my previous email, I prefer to see the move as the
> > first patch and then changes on top. This preserves the history and cle=
aner.
> >
> > thanks,
> > -- Shuah
> >
>=20
> Hi Shuah,
>=20
> Thanks for review and suggestion. I understand that we would like to reus=
e
> and preserve the history of tools/pci/pcietest.c. So we have two approach=
es:
>=20
> 1: Using git mv command move existing code from tools/pci/ to
> tools/testing/selftest/drivers/pci/ and then update the file to convert t=
o
> kselftest framework. I thought about this but after movement, when we
> move it to kselftest format it is going to be huge churn and we will be h=
aving
> modification in almost all lines.
>=20
> 2: Develop kselftest based driver in tools/testing/selftest/drivers/pci/ =
and
> eventually delete existing file from tools/pci/ folder providing justific=
ation in
> commit message.
>=20
> From my viewpoint, going with the second approach makes more sense
> because if almost complete file is getting modified, and it will make the
> review process complex and anyways there is not much code reusability.
> Please let me know if you have any other thought process or if I am missi=
ng
> anything to understand your approach.
>=20
> Thanks,
> Aman Gupta
> >


