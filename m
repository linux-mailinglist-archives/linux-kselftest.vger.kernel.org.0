Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9787813FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379801AbjHRT7k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379865AbjHRT7i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 15:59:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0BF1706;
        Fri, 18 Aug 2023 12:59:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso20178621fa.1;
        Fri, 18 Aug 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692388775; x=1692993575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZnDLKTm+Vz68wW+NpBJGQv7K7EuvgOHLUSeyXNlCjo=;
        b=niC/NhGgJdLzQDWhJ35lBiET52DjSLPJEHDaV8oJKza+nvvCv0soQR4Au1Eh+snuz4
         H7OJ4oUMO83aS4/U38gA8ZSdKe66xDnyJticxRTZzXvDJ3fEWB6tUNmJjCE040S8m33K
         uAvRRes5EjWuooXZwmzV/12pm3BfRSc2HdrZ3ESOd8klSSPuaS6zxufdlRq2bciM1K2Q
         SFbZenKSnjpT+bqp+n92OX7mXjDWoWsXI0G8xt0/CwmdQi3NCIXtNz/EcdWy26UMmLjS
         xAOF5Ca2Wouf+rce5ghWNZpCgGUGqJc1HAM0PcZjBQhfofUciDanhqh1phmBImQgs0Kv
         7aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388775; x=1692993575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZnDLKTm+Vz68wW+NpBJGQv7K7EuvgOHLUSeyXNlCjo=;
        b=AlpbSGsw6rcddBgpsNb4EgqXtq+BrC2LA492SGARF3/uTiwLKx1pb0sz4jYgCZQwIw
         Hivnow52eY0aC1vVSr9b512+5AVX4lwgXonlTPj8fbAmFjEMaqc3edo4ZnG/y+1IyThT
         haA8TdYX42zFuKD+AviXkAaOASvPrqUKD/VglpDhetj9W5lj1TSjARhew8gRPMy2weeI
         ZTJ/eXht1CujY6VyU0Cb8JQI79Iomb806Rv652mARgW7tjvuaEzzbS/jkJn1x38EX7Cr
         YrkGk96i8Zlru1QjnJLKoXqE3BDszHp6UKm9OPgxp7e3dt3zfz750AoRnCFEd4XEdo+L
         xPMA==
X-Gm-Message-State: AOJu0YxKhMfFxtJ3jRB2zh5CTGTnMoY9wHgmkU00YPPJkWioT4nHaKKJ
        9dnZ3NxxckKEmOqD/3EB9pQH8+VHire+k5P6LoVdiXEK
X-Google-Smtp-Source: AGHT+IHRz6m/oi/P/iekiR7QjNjXfP8gYDO4z7yafhS2Tyrt9xR/S/WYMg/RvhUJls4YXcHCJe7016jERHdPLHqvb0Y=
X-Received: by 2002:a2e:3505:0:b0:2a7:adf7:1781 with SMTP id
 z5-20020a2e3505000000b002a7adf71781mr175907ljz.2.1692388775263; Fri, 18 Aug
 2023 12:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230814134147.70289-1-hffilwlqm@gmail.com> <20230814134147.70289-2-hffilwlqm@gmail.com>
 <20230817223143.jyclrtf3a6kmtgh5@macbook-pro-8.dhcp.thefacebook.com> <fea59b79-3f28-c580-185b-8c64dc21a399@gmail.com>
In-Reply-To: <fea59b79-3f28-c580-185b-8c64dc21a399@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Aug 2023 12:59:24 -0700
Message-ID: <CAADnVQKVKPpbMNV9XNc+yJCuaWRupsB5EBjghv++jGqYTnv6QQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
To:     Leon Hwang <hffilwlqm@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 7:10=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 18/8/23 06:31, Alexei Starovoitov wrote:
> > On Mon, Aug 14, 2023 at 09:41:46PM +0800, Leon Hwang wrote:
> >> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
> >>      struct module *tgt_mod;
> >>      const char *tgt_name;
> >>      const struct btf_type *tgt_type;
> >> +    bool tail_call_ctx;
> >
> > Instead of extra flag here can you check tgt_prog->aux->tail_call_reach=
able in check_attach_btf_id()
> > and set tr->flags there?
>
> Should we check tgt_prog->aux->func[subprog]->is_func? Or, tgt_prog->aux-=
>tail_call_reachable
> is enough?

Please let the thread continue to a logical conclusion before resending
new version. Will reply there.
