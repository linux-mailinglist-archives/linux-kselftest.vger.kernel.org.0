Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B00758162
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjGRPxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjGRPxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:53:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC54EA9;
        Tue, 18 Jul 2023 08:53:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so9845943e87.2;
        Tue, 18 Jul 2023 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695587; x=1692287587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OntbrWTAQG/PerhnF1AEFKB9M8jeJIrSqTc2k/U9oQE=;
        b=VGnT5Lmti59eeyj2eatxU2586QG+5HxDd4I/eNRYaJaStFWcWVZiDu7NckgcIde4UK
         F6mKPo4mWOwK1K1nZtBslnWyWsvqbyuS9Kn7b0p1hUno1espiZ/kmNlSck8u64tM4e7B
         dEEPLcHZ8Ste3wuXaXMMWBFthndctigEK0MDNS4MHS9as3aga9DVX4aVJGhoZx3tw5Nj
         Y15fGe6c6NF+VPOK3Q4j8O5AMDzzXM043c7HZgosyIze/1RZaYOayOjD0BD0Wji01HY6
         6zK+5KE8Vd8ESbEceUou+3vxrDcV/rL/v6AKNwk07pPtFuK8Oz/0g9twBTkpo2oGxCoG
         mMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695587; x=1692287587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OntbrWTAQG/PerhnF1AEFKB9M8jeJIrSqTc2k/U9oQE=;
        b=R5LmUri3ygkVO/oBo8zgahmhX90A3TDlBqABEsTaeVRKUmrzER8EssVm71li6a8yqc
         LcbMwrPHTIvHIVgEqa0AENyc8Bh0v39b+6H1DxtFf9z2cyCoWKuUfkRx3edsqEhKMueC
         U2sYmpvx93Pd0LwdN4toiNKMdEkb8aTmHj5bIPY++SbU+LXbL9AEO/sGvaObagqGRZES
         +8Nd/1HUIaQBtmh9itDBBDuhUY7SkxbIwr9jeZj675SH3BRt6MXzsxwzNjRP5YE4cZpn
         D4z14rXD3KmNVv23MmYoT+wLxY32ipFTwX1NgcvakfKMnrwGQ4nx2SIIPgn/pMYC1Jsk
         Yq0w==
X-Gm-Message-State: ABy/qLaQc5e0j7y+HGq9kMVl7Nkr63L4AbYQtVB1n76QeHqdUeUW1ltL
        g0yIRepivLn2nd/eCaofwxMSpszdfgk0YRDFqhE=
X-Google-Smtp-Source: APBJJlG8KwGt8fEvh/VGd82/ZiaWrzvEd8YtwE1SlbTm5zxmH9o9vqSE3PQ/DuGSH0SAsGZvVFuuxJskY3zpHgs7QBY=
X-Received: by 2002:a2e:9b4f:0:b0:2b6:cdfb:d06a with SMTP id
 o15-20020a2e9b4f000000b002b6cdfbd06amr12003868ljj.22.1689695586605; Tue, 18
 Jul 2023 08:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
In-Reply-To: <20230718082615.08448806@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 08:52:55 -0700
Message-ID: <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 8:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote:
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb, i=
nt offset, int len,
> >       if (likely(hlen - offset >=3D len))
> >               return (void *)data + offset;
> >
> > -     if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0)=
)
> > +     if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer=
, len) < 0))
> >               return NULL;
>
> First off - please make sure you CC netdev on changes to networking!
>
> Please do not add stupid error checks to core code for BPF safety.
> Wrap the call if you can't guarantee that value is sane, this is
> a very bad precedent.

This is NOT for safety. You misread the code.
