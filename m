Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0F75843F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGRSLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGRSLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 14:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B04B6;
        Tue, 18 Jul 2023 11:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CA9616A8;
        Tue, 18 Jul 2023 18:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A6C433C8;
        Tue, 18 Jul 2023 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689703863;
        bh=aqcG9Vf7IvNK4ef7PMfcSdn/i3BQZS0UfVecmDeGi6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BjynpWZDiCelBeBxML03iYCKn63HQebwSJW/2ICI5rkz+TZqzqaZ+Q4HZR3RW8JT1
         kQE2JdVHC7kqFOSbeELi/RHSP7GAhJ0E+STVls1dRl0gwMnWAq6NmEl2UUP8HZFwrW
         TVa/CXvOVkNsJBwgXxpPkkmqmJWM9Jwa+QD0wVW/oICnTcrMyb1ZOa+ksPo01qz8Qt
         BLoisRABRJhYju+39Ruro42AdjJYBD2MlooUFP0dbO+eERnHJT5B2qBzfztGMkLX50
         Fd9jb+Plqc8cnL8Poh4sJyneBR6tvVfqiBYHbqUvPB6lj8TSIYoOdv663xLp00zo7g
         JtGmxO0lJ820g==
Date:   Tue, 18 Jul 2023 11:11:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718111101.57b1d411@kernel.org>
In-Reply-To: <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
        <20230718082615.08448806@kernel.org>
        <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
        <20230718090632.4590bae3@kernel.org>
        <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
        <20230718101841.146efae0@kernel.org>
        <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 18 Jul 2023 10:50:14 -0700 Alexei Starovoitov wrote:
> On Tue, Jul 18, 2023 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > you're still missing the point. Pls read the whole patch series. =20
> >
> > Could you just tell me what the point is then? The "series" is one
> > patch plus some tiny selftests. I don't see any documentation for
> > how dynptrs are supposed to work either.
> >
> > As far as I can grasp this makes the "copy buffer" optional from
> > the kfunc-API perspective (of bpf_dynptr_slice()).
> > =20
> > > It is _not_ input validation.
> > > skb_copy_bits is a slow path. One extra check doesn't affect
> > > performance at all. So 'fast paths' isn't a valid argument here.
> > > The code is reusing
> > >         if (likely(hlen - offset >=3D len))
> > >                 return (void *)data + offset;
> > > which _is_ the fast path.
> > >
> > > What you're requesting is to copy paste
> > > the whole __skb_header_pointer into __skb_header_pointer2.
> > > Makes no sense. =20
> >
> > No, Alexei, the whole point of skb_header_pointer() is to pass
> > the secondary buffer, to make header parsing dependable. =20
>=20
> of course. No one argues about that.
>=20
> > Passing NULL buffer to skb_header_pointer() is absolutely nonsensical. =
=20
>=20
> Quick grep through the code proves you wrong:
> drivers/net/ethernet/broadcom/bnxt/bnxt.c
> __skb_header_pointer(NULL, start, sizeof(*hp), skb->data,
>                      skb_headlen(skb), NULL);
>=20
> was done before this patch. It's using __ variant on purpose
> and explicitly passing skb=3D=3DNULL to exactly trigger that line
> to deliberately avoid the slow path.
>=20
> Another example:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> skb_header_pointer(skb, 0, 0, NULL);
>=20
> This one I'm not sure about. Looks buggy.

These are both Tx path for setting up offloads, Linux doesn't request
offloads for headers outside of the linear part. The ixgbevf code is
completely pointless, as you say.

In general drivers are rarely a source of high quality code examples.
Having been directly involved in the bugs that lead to the bnxt code
being written - I was so happy that the driver started parsing Tx
packets *at all*, so I wasn't too fussed by the minor problems :(

> > It should *not* be supported. We had enough prod problems with people
> > thinking that the entire header will be in the linear portion.
> > Then either the NIC can't parse the header, someone enables jumbo,
> > disables GRO, adds new HW, adds encap, etc etc and things implode. =20
>=20
> I don't see how this is related.
> NULL buffer allows to get a linear pointer and explicitly avoids
> slow path when it's not linear.

Direct packet access via skb->data is there for those who want high
speed =F0=9F=A4=B7=EF=B8=8F

> > If you want to support it in BPF that's up to you, but I think it's
> > entirely reasonable for me to request that you don't do such things
> > in general networking code. The function is 5 LoC, so a local BPF
> > copy seems fine. Although I'd suggest skb_header_pointer_misguided()
> > rather than __skb_header_pointer2() as the name :) =20
>=20
> If you insist we can, but bnxt is an example that buffer=3D=3DNULL is
> a useful concept for networking and not bpf specific.
> It also doesn't make "people think the header is linear" any worse.

My worry is that people will think that whether the buffer is needed or
not depends on _their program_, rather than on the underlying platform.
So if it works in testing without the buffer - the buffer must not be
required for their use case.
