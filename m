Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C46622A62
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKILZP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 06:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiKILZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 06:25:09 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8ABC248F3;
        Wed,  9 Nov 2022 03:25:07 -0800 (PST)
Received: from neptune (ip5f592f1a.dynamic.kabel-deutschland.de [95.89.47.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B3D1205DC1C;
        Wed,  9 Nov 2022 03:25:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B3D1205DC1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667993107;
        bh=zUwbg/HEyF+bezTrnaFC6nz76szbZgSmnWrOoGNXm+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hn8MKJT/RjE39bY8km6r3nNO43pooj3ElbJ48yMi2AD+e8wHBh51flFON7siZhHRp
         mLcXyuPZsf9P+60gg1ewlnJm29k4ElLfV44jMTYN5kss4lYlj/egI9D8+QMTA9NO23
         QUtJqAXqxBPJJSvpATB8AyHbswG8r5BqdqtxtMAg=
Date:   Wed, 9 Nov 2022 12:23:38 +0100
From:   Alban Crequy <albancrequy@linux.microsoft.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org,
        Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault
 in strncpy_from_kernel_nofault()
Message-ID: <20221109122338.7e931640@neptune>
In-Reply-To: <ab5a36cd-e9cc-074a-2fb6-858f5cc897e4@meta.com>
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
        <20221108195211.214025-2-flaniel@linux.microsoft.com>
        <a725e235-f4e9-84a3-a88b-dce274423a75@meta.com>
        <ab5a36cd-e9cc-074a-2fb6-858f5cc897e4@meta.com>
Organization: Microsoft
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 8 Nov 2022 12:38:53 -0800
Yonghong Song <yhs@meta.com> wrote:

> On 11/8/22 12:35 PM, Yonghong Song wrote:
> >=20
> >=20
> > On 11/8/22 11:52 AM, Francis Laniel wrote: =20
> >> From: Alban Crequy <albancrequy@microsoft.com>
> >>
> >> If a page fault occurs while copying the first byte, this function=20
> >> resets one
> >> byte before dst.
> >> As a consequence, an address could be modified and leaded to
> >> kernel crashes if
> >> case the modified address was accessed later.
> >>
> >> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
> >> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
> >> ---
> >> =C2=A0 mm/maccess.c | 2 +-
> >> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/maccess.c b/mm/maccess.c
> >> index 5f4d240f67ec..074f6b086671 100644
> >> --- a/mm/maccess.c
> >> +++ b/mm/maccess.c
> >> @@ -97,7 +97,7 @@ long strncpy_from_kernel_nofault(char *dst,
> >> const void *unsafe_addr, long count)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return src - unsafe_addr;
> >> =C2=A0 Efault:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pagefault_enable();
> >> -=C2=A0=C2=A0=C2=A0 dst[-1] =3D '\0';
> >> +=C2=A0=C2=A0=C2=A0 dst[0] =3D '\0'; =20
> >=20
> > What if the fault is due to dst, so the above won't work, right?
> >=20
> > The original code should work fine if the first byte copy is
> > successful. For the first byte copy fault, maybe just to leave it
> > as is? =20
>=20
> Okay, the dst is always safe (from func signature), so change looks
> okay to me. Probably mm people can double check.

My understanding was that the bpf verifier is supposed to check that the
dst pointer is safe. But I don't know where it is done, and I don't
know how it can check that the dst buffer is big enough.

> >  =20
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
> >> =C2=A0 }
> >>
> >> --=20
> >> 2.25.1
> >> =20
>=20

