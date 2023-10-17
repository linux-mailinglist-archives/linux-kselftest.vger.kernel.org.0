Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7097D7CCB99
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJQTEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTEE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:04:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E61C6;
        Tue, 17 Oct 2023 12:04:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d885e97e2so5680626f8f.0;
        Tue, 17 Oct 2023 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569440; x=1698174240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3URO8PfjgnFnifpX9a/pgxt4rV16Mqdk8BmJm6wrjEE=;
        b=JYlOqaHMN/TfINJOTUtG884SeTU0RPTEvkHgrK1tY5HSEDF0DbejWuiEwBS1Rl+/gz
         CVoMXoAH2NotGP9AmIpE21DetHN0iJ1VWxXqI7/EZikwksNW6TWHXMJesGwR0kro7VFC
         qZY8BlQwnY1PAR5PSbKdwgyLBODDevKeY7SQLsFuynoNp6owrNnF8JxuIdUgZMQHh+Ah
         sQ8HtJi9kYM2CqVeSMh4vDTLX6syuK9mlQlTTwzUvU+KoN4TsBDGI8MzbXUjCXs+MSMi
         wUptc8P3rvA0wbtaZex9efMgE5M9Apc0wBEu7RPK8HiUXCsha5kIX1vkx57TLodzbja6
         esQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569440; x=1698174240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3URO8PfjgnFnifpX9a/pgxt4rV16Mqdk8BmJm6wrjEE=;
        b=ZRYJ4KDxvC9svGmbPkGKQasnNgELOn7wBZnVXYo53BUYsef7wfw4dXX0yMQSN0XOv3
         /w0Iq6faKcWcK1dOf2YPDtdl80wGAqPldCTtHcmv6s4xnsmeWILX1gRw1Ra25ziJT+e0
         Z1WAWBiUNN4bAA6ywzzRpj71VgSTQOMvyBmiSTRnUBKqBkrXnSAk8zTMcdIeE+mI9Atu
         aI6afvbOGQcqXJ94KqEsg60splORIfYWLw7R/9fpUjGMy+jcIC9VW1CI0N6tgMxvIx/g
         DSdW/4wK6/wmOuTn3noMoU8NxfOqbKMAMQC1nQz/DB4eWhUitYi0blnC4U5hJA9Ej0rk
         lyPg==
X-Gm-Message-State: AOJu0YyQ6psrh5C3LzHV6OkWsAY3QjjQjqRmMaxR2QkwKjuIhoOwr++I
        JlaheQMPtZGtFlEvhIdQAUJshBs7BG1nfsoVhvs=
X-Google-Smtp-Source: AGHT+IEqUCfXV01nbzvJAQDYMt9/bfI3+Cy97/1wLOR9HsrauveAzt0KnETONmK639Tj5oEfXeeZKSha0vPN++YdkEI=
X-Received: by 2002:a5d:4e47:0:b0:32d:65ab:2228 with SMTP id
 r7-20020a5d4e47000000b0032d65ab2228mr2493781wrt.11.1697569440390; Tue, 17 Oct
 2023 12:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com> <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com> <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
In-Reply-To: <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Oct 2023 12:03:48 -0700
Message-ID: <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To:     Jason Wang <jasowang@redhat.com>
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
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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

On Mon, Oct 16, 2023 at 7:38=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Oct 17, 2023 at 7:53=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Oct 15, 2023 at 10:10=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> > >
> > > On 2023/10/16 1:07, Alexei Starovoitov wrote:
> > > > On Sun, Oct 15, 2023 at 7:17=E2=80=AFAM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> > > >>
> > > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >> index 0448700890f7..298634556fab 100644
> > > >> --- a/include/uapi/linux/bpf.h
> > > >> +++ b/include/uapi/linux/bpf.h
> > > >> @@ -988,6 +988,7 @@ enum bpf_prog_type {
> > > >>          BPF_PROG_TYPE_SK_LOOKUP,
> > > >>          BPF_PROG_TYPE_SYSCALL, /* a program that can execute sysc=
alls */
> > > >>          BPF_PROG_TYPE_NETFILTER,
> > > >> +       BPF_PROG_TYPE_VNET_HASH,
> > > >
> > > > Sorry, we do not add new stable program types anymore.
> > > >
> > > >> @@ -6111,6 +6112,10 @@ struct __sk_buff {
> > > >>          __u8  tstamp_type;
> > > >>          __u32 :24;              /* Padding, future use. */
> > > >>          __u64 hwtstamp;
> > > >> +
> > > >> +       __u32 vnet_hash_value;
> > > >> +       __u16 vnet_hash_report;
> > > >> +       __u16 vnet_rss_queue;
> > > >>   };
> > > >
> > > > we also do not add anything to uapi __sk_buff.
> > > >
> > > >> +const struct bpf_verifier_ops vnet_hash_verifier_ops =3D {
> > > >> +       .get_func_proto         =3D sk_filter_func_proto,
> > > >> +       .is_valid_access        =3D sk_filter_is_valid_access,
> > > >> +       .convert_ctx_access     =3D bpf_convert_ctx_access,
> > > >> +       .gen_ld_abs             =3D bpf_gen_ld_abs,
> > > >> +};
> > > >
> > > > and we don't do ctx rewrites like this either.
> > > >
> > > > Please see how hid-bpf and cgroup rstat are hooking up bpf
> > > > in _unstable_ way.
> > >
> > > Can you describe what "stable" and "unstable" mean here? I'm new to B=
PF
> > > and I'm worried if it may mean the interface stability.
> > >
> > > Let me describe the context. QEMU bundles an eBPF program that is use=
d
> > > for the "eBPF steering program" feature of tun. Now I'm proposing to
> > > extend the feature to allow to return some values to the userspace an=
d
> > > vhost_net. As such, the extension needs to be done in a way that ensu=
res
> > > interface stability.
> >
> > bpf is not an option then.
> > we do not add stable bpf program types or hooks any more.
>
> Does this mean eBPF could not be used for any new use cases other than
> the existing ones?

It means that any new use of bpf has to be unstable for the time being.

> > If a kernel subsystem wants to use bpf it needs to accept the fact
> > that such bpf extensibility will be unstable and subsystem maintainers
> > can decide to remove such bpf support in the future.
>
> I don't see how it is different from the existing ones.

Can we remove BPF_CGROUP_RUN_PROG_INET_INGRESS hook along
with BPF_PROG_TYPE_CGROUP_SKB program type?
Obviously not.
We can refactor it. We can move it around, but not remove.
That's the difference in stable vs unstable.
