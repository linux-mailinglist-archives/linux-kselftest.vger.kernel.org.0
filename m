Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD57CB884
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjJQCjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjJQCjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 22:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D45EA
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697510305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLFBGnIpAzynaCLSWbQnRiqRNf9pByil8XHxQ2oSj4w=;
        b=TAwWxrYVcjmAlh5A74EoDab5QRJI/RWV8q5Ivqcd5N+z9gZtGV2h4QzwZ5q4RhsGgMBHjG
        niGusauG7xBt7/a9iFicQ9KjmyM1hOmYyzoErwVW+LaWkhz50jsY1Oba9ips5DLa4aidoG
        2xrv2odmAf4LhWi3eH7zjyhTnafV9zs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-COjrCxKgOduHALtSklFWvA-1; Mon, 16 Oct 2023 22:38:13 -0400
X-MC-Unique: COjrCxKgOduHALtSklFWvA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079f6c127cso2879064e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 19:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510292; x=1698115092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLFBGnIpAzynaCLSWbQnRiqRNf9pByil8XHxQ2oSj4w=;
        b=iqJwBz94nUVc+q9UdBdv78lsGHXTLjSzL7X+jc/kkLEkh5alpGBdwloiS12pcXemad
         UzHiB3ekiPB/qaEIJbkPKT5DohfnPVPgnvOfZ0nDuXeIzUB7sEDGTcU+nd9z4P7HBOxk
         adnRLkvIkxdaUR8SFof/ak3jNDs+3obceBKhhBIf7D2UkHRr0ABTDKHExVKua595aajF
         FvxKCgLoQ3h5jK4vUFTHkZDn9GKY3lqkzsijcgEERcBsWElmJxGoaY3aCyy79lY0St6x
         G27JbxWNeduqMGwbjC2VYonAx7GR/82eNCFCxhJfo8lRYBuusQNhAP+rONgetibJA/0Z
         Qc7A==
X-Gm-Message-State: AOJu0YxjLqJzPfpHQg8CCq7KFPzzx90WxIQE0egyL1T+FYujWnltbQ+8
        h2eFzFdt9falSRKbiLov9XmwL3IrIzUx+Orn4pbL86/zuPclQNCeAg8Xh/sLZY5NxvgWhrXb4sn
        gPXPp2WMDu6GddE6Jr25CF5OP3SkzcmssYTU5lLKLtb/t
X-Received: by 2002:a19:7616:0:b0:506:8e27:7ce9 with SMTP id c22-20020a197616000000b005068e277ce9mr773831lff.16.1697510292107;
        Mon, 16 Oct 2023 19:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwD5883Y6d40R7U3CghOpbHBfm9xN2dxJWP8byeoC8zFnDP5U2UV48wLUupwqJd40JvPd+TfwSf9k5qjsrlt4=
X-Received: by 2002:a19:7616:0:b0:506:8e27:7ce9 with SMTP id
 c22-20020a197616000000b005068e277ce9mr773811lff.16.1697510291790; Mon, 16 Oct
 2023 19:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com> <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com> <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 Oct 2023 10:38:00 +0800
Message-ID: <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 7:53=E2=80=AFAM Alexei Starovoitov
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

Does this mean eBPF could not be used for any new use cases other than
the existing ones?

> If a kernel subsystem wants to use bpf it needs to accept the fact
> that such bpf extensibility will be unstable and subsystem maintainers
> can decide to remove such bpf support in the future.

I don't see how it is different from the existing ones.

Thanks

>

