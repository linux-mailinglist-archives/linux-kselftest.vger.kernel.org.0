Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601707CB730
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjJPXx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 19:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 19:53:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E9A93;
        Mon, 16 Oct 2023 16:53:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406650da82bso46816845e9.3;
        Mon, 16 Oct 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697500404; x=1698105204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VEVqtbhTZ62Wt4BNsx/63ghGB/h6YT4GupgB+U3dfc=;
        b=bb0Xz1yXNb2sHQ3xC3CXxWgQe6ZCXuPffo+qa+iwpa9Lt0MUmiLSLOOsvDR6UtHM4B
         TTM5TVvEoYoz2liqVMYiKY51083wyyZ7hVWd3ANRa+1SDU1L34H8AGYjbW30FGiY62VP
         Ly66nl/ywm69zoWmrMynVdM3l2QVd8osP0yYsuAZUxSxdx8ZSMJU7QXn+I/lo2Tvs3zm
         MnRzg3X0Cr7hYYrhKQrgMa2p05t8BaoxBskPicLUza2scRMNEOWOzUVIWx6lbyIcUZrm
         19j24h5UIp9L8KchCN4uq0b6EmEV1q5pqdefyTPlgXd2OvANZcwl/mpW7oGB3l38InCy
         2siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697500404; x=1698105204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VEVqtbhTZ62Wt4BNsx/63ghGB/h6YT4GupgB+U3dfc=;
        b=pRatSAan9ql82OmtnAEv343cGrbq620k0xwFUGc25/Z65bYROIrGs0X092k1bWkwI1
         y+/fUQyZxAxp6A2s9AR5DSb32EwcbeDsIHG8gyF24jSK0G2pdl+ERNf0xXHhwggG+sZG
         7WujquDYzzzia3+8SjgWd9eJbt64+PZdrE5H2cojlAa4dAxPS5ovvWf3MJlG8jGp8EsT
         WbT84GkAucTOiwyW1niES6X2d1VuIhvQhw4iVj2VY/87xg+wJuVLQM0cjg29TlqPqX8D
         dSlvUuE+uZPu4cnK1uNEjfngZ8BYcPXv593lkJgggIsOjRRB3xB06MHhO8vFKfdkrKcA
         U3xQ==
X-Gm-Message-State: AOJu0Yw82DiKHjuEwQK/JnbQZyF15Wh9HsKXkxnNvN/G2dggG+O28Gv7
        f8Odgd0qy4cQDDvjFFK5gJpnkZA9EL4ZeoYovzahYuWq1R0=
X-Google-Smtp-Source: AGHT+IF1BuNjnsWI6nItlbieev+STDfI8LZWyBbAFr7V6O8+/fhS7AV6KvGufUNVb5YGTQIWA1gzYmteJZKw5LQ/Qio=
X-Received: by 2002:a5d:63cc:0:b0:32d:b8f8:2b18 with SMTP id
 c12-20020a5d63cc000000b0032db8f82b18mr715262wrw.32.1697500403744; Mon, 16 Oct
 2023 16:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com> <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
In-Reply-To: <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 16 Oct 2023 16:53:11 -0700
Message-ID: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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

On Sun, Oct 15, 2023 at 10:10=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/10/16 1:07, Alexei Starovoitov wrote:
> > On Sun, Oct 15, 2023 at 7:17=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 0448700890f7..298634556fab 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -988,6 +988,7 @@ enum bpf_prog_type {
> >>          BPF_PROG_TYPE_SK_LOOKUP,
> >>          BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls=
 */
> >>          BPF_PROG_TYPE_NETFILTER,
> >> +       BPF_PROG_TYPE_VNET_HASH,
> >
> > Sorry, we do not add new stable program types anymore.
> >
> >> @@ -6111,6 +6112,10 @@ struct __sk_buff {
> >>          __u8  tstamp_type;
> >>          __u32 :24;              /* Padding, future use. */
> >>          __u64 hwtstamp;
> >> +
> >> +       __u32 vnet_hash_value;
> >> +       __u16 vnet_hash_report;
> >> +       __u16 vnet_rss_queue;
> >>   };
> >
> > we also do not add anything to uapi __sk_buff.
> >
> >> +const struct bpf_verifier_ops vnet_hash_verifier_ops =3D {
> >> +       .get_func_proto         =3D sk_filter_func_proto,
> >> +       .is_valid_access        =3D sk_filter_is_valid_access,
> >> +       .convert_ctx_access     =3D bpf_convert_ctx_access,
> >> +       .gen_ld_abs             =3D bpf_gen_ld_abs,
> >> +};
> >
> > and we don't do ctx rewrites like this either.
> >
> > Please see how hid-bpf and cgroup rstat are hooking up bpf
> > in _unstable_ way.
>
> Can you describe what "stable" and "unstable" mean here? I'm new to BPF
> and I'm worried if it may mean the interface stability.
>
> Let me describe the context. QEMU bundles an eBPF program that is used
> for the "eBPF steering program" feature of tun. Now I'm proposing to
> extend the feature to allow to return some values to the userspace and
> vhost_net. As such, the extension needs to be done in a way that ensures
> interface stability.

bpf is not an option then.
we do not add stable bpf program types or hooks any more.
If a kernel subsystem wants to use bpf it needs to accept the fact
that such bpf extensibility will be unstable and subsystem maintainers
can decide to remove such bpf support in the future.
