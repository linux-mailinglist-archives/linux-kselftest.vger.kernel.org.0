Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC07C99E2
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjJOQIF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 12:08:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F890AB;
        Sun, 15 Oct 2023 09:08:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so37616635e9.2;
        Sun, 15 Oct 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697386081; x=1697990881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XujhMv/8pwB8H+Ij7K6MZPspXyDbpmJ+2p7uc4kDFNk=;
        b=AB0lTmfgWQPvnHMkCiiWckdZn655ocvhrgppqgLxkhdTtwrpGmKdX5OlL7LRqQgsar
         W0/tqUa0MwCJhoUYSEYT4JKpkPZ85CihR/cFynoarQUC7EQmqYCvI+zVEhfafO8IkZk3
         OdGseues4F2kE6jkll6PNZwS+P1N+RlyLqj+feAiLi9DwNrflBQoYNTjUA354IwQtHW1
         VXkquQAgLutmqTIl8sN9a5V0KlEeDbmXbvIkBXhgCvjUdrLFQrb4e5jS51jnNBQLwzhQ
         F9vDxn3IDLUlSr7enAuvRJ+dTVPM/zji9On94hMGlEDbkDetLtBIIWZmfqBaXB+8ftTe
         iruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697386081; x=1697990881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XujhMv/8pwB8H+Ij7K6MZPspXyDbpmJ+2p7uc4kDFNk=;
        b=cRvsQPwBYqsnjYiH1pZ7OzD+KEMb/kUIjWbQagaML1qHhIZhSEFkLz+ktcMtU8WyD1
         nZJVcYIGk7Fwjx25l+CTkEzQVWRkGvRw8YwZz9oRheWFHLGN7ZRjnTxNT2+0aFPSQgVi
         UotJJjZTNDQt3bt2y8hqdKlNzHwyzdch0V8LtiDNaYCQ1AzxSp4Hk4ngjsHK2Q2vru4E
         k1aCAIYAy4XqcfmHHh8o1yDcHD+MNZtvJsqiENZkEvBKFD0knrl4XgK4BrJEWLElVqA5
         0+P+5H6sdinR6KeF5SPpBEUvcsf8UDvlsmysMPPOTnT4JNUeC1HvqujKeI4VCOPmk+4C
         E3PQ==
X-Gm-Message-State: AOJu0YxN8czhQqsqjN9By13+sUH02C13lipa2rZJgo2ChPweHXiJZmv3
        pmI1McKaHnqP3MXHSkV7Fo7LohqFu+nO3nJmKGU=
X-Google-Smtp-Source: AGHT+IHRwQ5bE3hW1waPm3vlZF7IYRIPl+hr17w3AEC3uTMy8O1jLNp9Skrcd0Po7vdFsljBETR6eKnURnRLMkMbVyQ=
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id
 x17-20020a05600c21d100b004053ae62413mr28009964wmj.25.1697386080580; Sun, 15
 Oct 2023 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com> <20231015141644.260646-2-akihiko.odaki@daynix.com>
In-Reply-To: <20231015141644.260646-2-akihiko.odaki@daynix.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 15 Oct 2023 09:07:49 -0700
Message-ID: <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
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

On Sun, Oct 15, 2023 at 7:17=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0448700890f7..298634556fab 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -988,6 +988,7 @@ enum bpf_prog_type {
>         BPF_PROG_TYPE_SK_LOOKUP,
>         BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>         BPF_PROG_TYPE_NETFILTER,
> +       BPF_PROG_TYPE_VNET_HASH,

Sorry, we do not add new stable program types anymore.

> @@ -6111,6 +6112,10 @@ struct __sk_buff {
>         __u8  tstamp_type;
>         __u32 :24;              /* Padding, future use. */
>         __u64 hwtstamp;
> +
> +       __u32 vnet_hash_value;
> +       __u16 vnet_hash_report;
> +       __u16 vnet_rss_queue;
>  };

we also do not add anything to uapi __sk_buff.

> +const struct bpf_verifier_ops vnet_hash_verifier_ops =3D {
> +       .get_func_proto         =3D sk_filter_func_proto,
> +       .is_valid_access        =3D sk_filter_is_valid_access,
> +       .convert_ctx_access     =3D bpf_convert_ctx_access,
> +       .gen_ld_abs             =3D bpf_gen_ld_abs,
> +};

and we don't do ctx rewrites like this either.

Please see how hid-bpf and cgroup rstat are hooking up bpf
in _unstable_ way.
