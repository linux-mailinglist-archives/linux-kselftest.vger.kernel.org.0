Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B034C7CB774
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJQAhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 20:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjJQAhX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 20:37:23 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01F95;
        Mon, 16 Oct 2023 17:37:21 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ab5150a7b5so4140928241.0;
        Mon, 16 Oct 2023 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697503040; x=1698107840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCBpBFy0sL3kGgajsg5bL9lp51r5jSArJUZNS83IHhs=;
        b=C3jiDWSveC8PtTe5bXeKzkGZWO3pkZa89DKC6nfS2+H34Hu2e/YDCYPXSZEFwvrXlZ
         1dC+aaOeLrBrXeTNewTbkuK6CCfsAh6nRZX4hE+RhyKedtZnmqA3uRDwreuabBXX0B9S
         sRt+d/lLDTMUWTLs+wBUQBmjZmtSu1xCcQiEjLSq9wjN7JWQZJ/6ZsIztI8SzFxctrMm
         LuEH6rs88L5gEEeaGvhBq7U6OFwPLdyLykJODzQmeKbr1DdYCyaDF9QYo7Eq7l6Vx2qT
         JMtPRQA6/gt7miQIPxGwpxCNOt0Ikzo9oXm2ijKHUs+4Ze4hCUlvg2ll+0Eff3F9iCqN
         6JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697503040; x=1698107840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCBpBFy0sL3kGgajsg5bL9lp51r5jSArJUZNS83IHhs=;
        b=Qc7dr/CAWve5s/CPqs1/+QU4dWMalQGFUyWpsGST6+A0Au+vUQHlS+I7fv3mUBWL48
         EqGB7REUZgRQXMSwWNkr9ek0yeQR8Z1xGzdmsVchj32ihzHhXZO/2bt2u8zbXfpIKWBQ
         RTccaVtQkq/o0j7Mxdzu3CoPucX6SrRXxlFxKj5WzzE8My4d8ii0tApcqAux7yVLOgnh
         hXYgXwBzTQQEEEk+XklLsh1BcFylQeqVa8c8BguWtfZD5qyEu2jpw0PqkAsKIjRPLXiU
         sjoSUDJ+Rc/T56Q6B7ckTnU8FCNwfF17OQmb038rJb5aTyppApCpr2LM2Xt7+mxTAhtY
         iSnQ==
X-Gm-Message-State: AOJu0YzWMUBVmfaWznhbVkyQqrT6J4asx8GmyNNb7D6yb+/OYSYIS+h7
        6xlGmH3Gfh4NI40uDszYRHmqtsDVWCLWp1P9/HWpbQY+
X-Google-Smtp-Source: AGHT+IGTFKrIo3DX3VTBrldf07y90mT9ODR4qoemWSfmdES5n+WGptKeaXQi892QmMn5GqvVYCmrHCk1YdrE8z97v4I=
X-Received: by 2002:a67:ac4a:0:b0:457:cbde:603d with SMTP id
 n10-20020a67ac4a000000b00457cbde603dmr189013vsh.14.1697503040429; Mon, 16 Oct
 2023 17:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com> <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com> <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Oct 2023 20:36:43 -0400
Message-ID: <CAF=yD-Jr1wKo6viUGWTcXsT5b9e1NkuemuvjN988qSyNmheM2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>
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

On Mon, Oct 16, 2023 at 7:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Oct 15, 2023 at 10:10=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >
> > On 2023/10/16 1:07, Alexei Starovoitov wrote:
> > > On Sun, Oct 15, 2023 at 7:17=E2=80=AFAM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> > >>
> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >> index 0448700890f7..298634556fab 100644
> > >> --- a/include/uapi/linux/bpf.h
> > >> +++ b/include/uapi/linux/bpf.h
> > >> @@ -988,6 +988,7 @@ enum bpf_prog_type {
> > >>          BPF_PROG_TYPE_SK_LOOKUP,
> > >>          BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscal=
ls */
> > >>          BPF_PROG_TYPE_NETFILTER,
> > >> +       BPF_PROG_TYPE_VNET_HASH,
> > >
> > > Sorry, we do not add new stable program types anymore.
> > >
> > >> @@ -6111,6 +6112,10 @@ struct __sk_buff {
> > >>          __u8  tstamp_type;
> > >>          __u32 :24;              /* Padding, future use. */
> > >>          __u64 hwtstamp;
> > >> +
> > >> +       __u32 vnet_hash_value;
> > >> +       __u16 vnet_hash_report;
> > >> +       __u16 vnet_rss_queue;
> > >>   };
> > >
> > > we also do not add anything to uapi __sk_buff.
> > >
> > >> +const struct bpf_verifier_ops vnet_hash_verifier_ops =3D {
> > >> +       .get_func_proto         =3D sk_filter_func_proto,
> > >> +       .is_valid_access        =3D sk_filter_is_valid_access,
> > >> +       .convert_ctx_access     =3D bpf_convert_ctx_access,
> > >> +       .gen_ld_abs             =3D bpf_gen_ld_abs,
> > >> +};
> > >
> > > and we don't do ctx rewrites like this either.
> > >
> > > Please see how hid-bpf and cgroup rstat are hooking up bpf
> > > in _unstable_ way.
> >
> > Can you describe what "stable" and "unstable" mean here? I'm new to BPF
> > and I'm worried if it may mean the interface stability.
> >
> > Let me describe the context. QEMU bundles an eBPF program that is used
> > for the "eBPF steering program" feature of tun. Now I'm proposing to
> > extend the feature to allow to return some values to the userspace and
> > vhost_net. As such, the extension needs to be done in a way that ensure=
s
> > interface stability.
>
> bpf is not an option then.
> we do not add stable bpf program types or hooks any more.
> If a kernel subsystem wants to use bpf it needs to accept the fact
> that such bpf extensibility will be unstable and subsystem maintainers
> can decide to remove such bpf support in the future.

Based on hooks for tracepoints and kfuncs, correct?

Perhaps the existing stable flow dissector type is extensible to
optionally compute the hash and report hash and hash type. Else we
probably should revisit the previous version of this series.
