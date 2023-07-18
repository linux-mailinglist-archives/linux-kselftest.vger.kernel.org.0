Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB747583D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGRRuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGRRub (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 13:50:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56988F7;
        Tue, 18 Jul 2023 10:50:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so9843421e87.3;
        Tue, 18 Jul 2023 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689702626; x=1692294626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1NrIr5hWlf8puwaKUvqIDmFUDhuYj0CYIrwJtR/mVI=;
        b=Jfbhkv+K5cMBerWlxqPDCeaTnjEGuDKcVz0bad+6OAW9/bqVjRzzEpctOCWbq0Z7rN
         ZOUIjVHjQeuwxuah7a16ApaVYhwzRF/OfxHVk6WM0Hkrsf6VwqSmyCWWvxVCn/s2XKcx
         aULd8jNY6k3i37rGXY4VyRpA6SZ2QCULgRaZh/b9PR6KeB8nQlfCrQu8jZVCdlV50Xso
         /Wi7o+Uhr2yP4a7pwioK+kUwPKvfbNdzS57U09OubWqkQTdE1AX+vFDWDLSh2b/kwNyj
         B25xyYQVRb2RwHX0j3gk/Mxh26NCBuzCz2Gkt2bLHHgOszqxtnQRVsNNdGFmicCWaqBA
         hmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702626; x=1692294626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1NrIr5hWlf8puwaKUvqIDmFUDhuYj0CYIrwJtR/mVI=;
        b=hOIzlTOwjOD2W174jh1rc7pwLTfkg9IpQD2oQ9u8MDat6xlLn9yI1zX6ApakJhAWPV
         RLlvsA1GxgV7HPgbZZYgptrctRihcQB+QSYy1OkJvjHjE3mewI5K0v65iTsGsYQlYOcc
         zB4afjyVbmsgBz+IerX49Y0rUGPf8Lj+4/WzuS72JiffJzfzgOLKP3xrnY13cpQThYRd
         9RYlAmhX7hL0gKOVOF5RxXk9l07kUvlpVc8cM3DEJdGwWlt5E9eYvuwAKj8SXffiOvMf
         0EbIaYXGJQXNAnaBk8+24qOMrTwm4GqwftuxjiJKyGt26/WmjOHl1qAapw7xSqeA5pgg
         6w2g==
X-Gm-Message-State: ABy/qLYAZi9wuE0i8rLSX20jiZcgdG4zkb7VRuulbk7y4KsnxAm801MC
        I2uu1/YnWTSoOUEuOqRSiACQWWc9gG9rSUvxDKo=
X-Google-Smtp-Source: APBJJlEUGjLor3gTjMvv45yCty1yYgmc4Ncf4zsT8mew7vP1tguCbmQtcsECbpRpsHR/TMlkZqzErQk+5WqiwyChlrA=
X-Received: by 2002:a2e:864b:0:b0:2b5:9778:7ce2 with SMTP id
 i11-20020a2e864b000000b002b597787ce2mr13061113ljj.15.1689702626230; Tue, 18
 Jul 2023 10:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
 <20230718090632.4590bae3@kernel.org> <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
 <20230718101841.146efae0@kernel.org>
In-Reply-To: <20230718101841.146efae0@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 10:50:14 -0700
Message-ID: <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Jakub Kicinski <kuba@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 18 Jul 2023 09:52:24 -0700 Alexei Starovoitov wrote:
> > On Tue, Jul 18, 2023 at 9:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > > This is NOT for safety. You misread the code.
> > >
> > > Doesn't matter, safety or optionality. skb_header_pointer() is used
> > > on the fast paths of the networking stack, adding heavy handed input
> > > validation to it is not okay. No sane code should be passing NULL
> > > buffer to skb_header_pointer(). Please move the NULL check to the BPF
> > > code so the rest of the networking stack does not have to pay the cos=
t.
> > >
> > > This should be common sense. If one caller is doing something..
> > > "special" the extra code should live in the caller, not the callee.
> > > That's basic code hygiene.
> >
> > you're still missing the point. Pls read the whole patch series.
>
> Could you just tell me what the point is then? The "series" is one
> patch plus some tiny selftests. I don't see any documentation for
> how dynptrs are supposed to work either.
>
> As far as I can grasp this makes the "copy buffer" optional from
> the kfunc-API perspective (of bpf_dynptr_slice()).
>
> > It is _not_ input validation.
> > skb_copy_bits is a slow path. One extra check doesn't affect
> > performance at all. So 'fast paths' isn't a valid argument here.
> > The code is reusing
> >         if (likely(hlen - offset >=3D len))
> >                 return (void *)data + offset;
> > which _is_ the fast path.
> >
> > What you're requesting is to copy paste
> > the whole __skb_header_pointer into __skb_header_pointer2.
> > Makes no sense.
>
> No, Alexei, the whole point of skb_header_pointer() is to pass
> the secondary buffer, to make header parsing dependable.

of course. No one argues about that.

> Passing NULL buffer to skb_header_pointer() is absolutely nonsensical.

Quick grep through the code proves you wrong:
drivers/net/ethernet/broadcom/bnxt/bnxt.c
__skb_header_pointer(NULL, start, sizeof(*hp), skb->data,
                     skb_headlen(skb), NULL);

was done before this patch. It's using __ variant on purpose
and explicitly passing skb=3D=3DNULL to exactly trigger that line
to deliberately avoid the slow path.

Another example:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
skb_header_pointer(skb, 0, 0, NULL);

This one I'm not sure about. Looks buggy.

> It should *not* be supported. We had enough prod problems with people
> thinking that the entire header will be in the linear portion.
> Then either the NIC can't parse the header, someone enables jumbo,
> disables GRO, adds new HW, adds encap, etc etc and things implode.

I don't see how this is related.
NULL buffer allows to get a linear pointer and explicitly avoids
slow path when it's not linear.

> If you want to support it in BPF that's up to you, but I think it's
> entirely reasonable for me to request that you don't do such things
> in general networking code. The function is 5 LoC, so a local BPF
> copy seems fine. Although I'd suggest skb_header_pointer_misguided()
> rather than __skb_header_pointer2() as the name :)

If you insist we can, but bnxt is an example that buffer=3D=3DNULL is
a useful concept for networking and not bpf specific.
It also doesn't make "people think the header is linear" any worse.
