Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7976C73F617
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjF0Hu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjF0Hut (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 03:50:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66893297C
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 00:50:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98bcc533490so506703466b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687852230; x=1690444230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/PlesO2yc7J0M0ez9vNMmpy4Sw/yrJpXbgL5YEpqPo=;
        b=bQwAZxoWB6E2WY7I4fXXrTkwiGW8Q+FBD0Mnb4fTXoziEoQ5gByHx/4vebns6dNpk5
         WuojIMrZzyD/DnuBWVTpStVv9gClUVaJ6JjT7ZAAvtJvyRdGiabkl/rvg+VhCVakj0fw
         ZLeF7iHxxt3qMhhlUrS2JzHrd/BLFOWsayPmeietJ+SpprSmY3HoYK353sq2HelWPvu0
         ssRvv418pXfKhpH3+Q2qc7mFlq7clRY19EZJd1fPJh34GjxQTHqwSGJjfL8rV4/ajb3g
         w3muIzK2awRbDHZZ0zQmB5qS3cKulXE9QdvSfc3uEbQBgEUKaEy5aBJm/M7U/3Yn644l
         kDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852230; x=1690444230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/PlesO2yc7J0M0ez9vNMmpy4Sw/yrJpXbgL5YEpqPo=;
        b=ZteIAKgh5H3NLmoot8ZHY8E62j4vi+QSRrfQ7Csy1GXDBAQJmC/izmJYRlMcoVSDtR
         atrFKCkuU7uB3XTmmbh8yNNqNzddHTm9rAD5i4q5uhSHazwPysMbglVMEOgE3216YvcQ
         8obSrETzqdV+EkL6v20tQfb23ngCWVk5gT5zyr35zHjr7B8cGoO6A4Ljy/aERoG5erz8
         ld9wT6DwiqkJy40slm0iuw/ab+Syd03hVFb6LB/HZBvDEPyhQD0bTTrseOYteSqaWEoh
         zMPJbaTIQr/eJAK2ShYhJp+/YYiGircbiPp6u4esUPTB2+1Q+0D+5F0P6C2CN/bQ9pA1
         Nigw==
X-Gm-Message-State: AC+VfDzXxTHfIjIya+ldwQ1+T6lA/qXMY+9fL7jpDpj1uqj2gKpC5ApF
        Vlyfu75MFH1pmZnzZ55yNrC0xM1/uZxh1FWXM4tkuA==
X-Google-Smtp-Source: ACHHUZ6agsn+BeceXhNtzplectJNaNMpkfYDD4sUR+SS3O74iUfYKtJvbDjdKFmOwS7FN4RvZ0O0zWpbX+Kgc5FB4F8=
X-Received: by 2002:a17:907:7f04:b0:991:f6d0:9bc1 with SMTP id
 qf4-20020a1709077f0400b00991f6d09bc1mr2598779ejc.66.1687852229607; Tue, 27
 Jun 2023 00:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <cdd04046-4bcb-d6fd-1688-0a85546e7b91@linux.intel.com> <649914ab3de4d_8e17829490@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <649914ab3de4d_8e17829490@dwillia2-xfh.jf.intel.com.notmuch>
From:   Chong Cai <chongc@google.com>
Date:   Tue, 27 Jun 2023 00:50:16 -0700
Message-ID: <CALRH0CiHjNeaHS88Oa_57hS_WGXY3-x2_aHco14nQpo-5e9seA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 25, 2023 at 9:32=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Sathyanarayanan Kuppuswamy wrote:
> >
> >
> > On 6/23/23 9:05 PM, Dan Williams wrote:
> > > Kuppuswamy Sathyanarayanan wrote:
> > >> Hi All,
> > >>
> > >> In TDX guest, the attestation process is used to verify the TDX gues=
t
> > >> trustworthiness to other entities before provisioning secrets to the
> > >> guest.
> > >>
> > >> The TDX guest attestation process consists of two steps:
> > >>
> > >> 1. TDREPORT generation
> > >> 2. Quote generation.
> > >>
> > >> The First step (TDREPORT generation) involves getting the TDX guest
> > >> measurement data in the format of TDREPORT which is further used to
> > >> validate the authenticity of the TDX guest. The second step involves
> > >> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> > >> remotely verifiable Quote. TDREPORT by design can only be verified o=
n
> > >> the local platform. To support remote verification of the TDREPORT,
> > >> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> > >> locally and convert it to a remotely verifiable Quote. Although
> > >> attestation software can use communication methods like TCP/IP or
> > >> vsock to send the TDREPORT to QE, not all platforms support these
> > >> communication models. So TDX GHCI specification [1] defines a method
> > >> for Quote generation via hypercalls. Please check the discussion fro=
m
> > >> Google [2] and Alibaba [3] which clarifies the need for hypercall ba=
sed
> > >> Quote generation support. This patch set adds this support.
> > >>
> > >> Support for TDREPORT generation already exists in the TDX guest driv=
er.
> > >> This patchset extends the same driver to add the Quote generation
> > >> support.
> > >
> > > I missed that the TDREPORT ioctl() and this character device are alre=
ady
> > > upstream. The TDREPORT ioctl() if it is only needed for quote generat=
ion
> > > seems a waste because it just retrieves a blob that needs to be turne=
d
> > > around and injected back into the kernel to generate a quote.
> >
> > Although the end goal is to generate the quote, the method the user cho=
oses to
> > achieve it may differ for a variety of reasons. In this case, we're try=
ing to
> > support the use case where the user will use methods like TCP/IP or vso=
ck to
> > generate the Quote. They can use the GET_REPORT IOCTL to get the TDREPO=
RT and
> > send it to the quoting enclave via the above-mentioned methods.  TDVMCA=
LL-based
> > quote generation is intended for users who, for a variety of security r=
easons, do
> > not wish to use the methods described above.
>
> This flexibility could be supported with keys if necessary, although I
> would want to hear strong reasons not a "variety of reasons" why
> everyone cannot use a unified approach. ABI proliferation has a
> maintenance cost and a collaboration cost. It is within the kernel
> community's right to judge the cost of ABI flexibility and opt for a
> constrained implementation if that cost is too high.
>
> What I would ask of those who absolutely cannot support the TDVMCALL
> method is to contribute a solution that intercepts the "upcall" to the
> platform "guest_attest_ops" and turn it into a typical keys upcall to
> userspace that can use the report data with a vsock tunnel.
>
> That way the end result is still the same, a key established with the
> TDX Quote evidence contained within a Linux-defined envelope.

I agree a unified ABI across vendors would be ideal in the long term.
However, it sounds like a non-trivial task and could take quite some
time to achieve.
Given there's already an AMD equivalent approach upstreamed, can we
also allow this TDVMCALL patch as an intermediate step to unblock
various TDX attestation user cases while targeting unified ABI? The
TDVMCALL here is quite isolated and serves a very specific purpose, it
should be very low risk to other kernel features and easy to be
reverted in the future.
