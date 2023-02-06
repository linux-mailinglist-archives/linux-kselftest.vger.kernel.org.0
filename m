Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8D68C528
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBFRwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 12:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBFRwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 12:52:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD02BEEE
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 09:52:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso8502986pjb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zyweaVyiMqk4LHuNuzEqryLINLpiUARVWRIcVZa2lw=;
        b=Jl2YisgLdiqvhpCBOAhNrDu+USOFqPUBAMNQALaN99jC4eqrKpnaVmcdgUI9YgMhb/
         aE/stlsmeWlkXNJCUgbhkxMsUGClClfb5Za1b31fmi9dZq5NiRNcFC+H03SQxvVd9olz
         6zKxlpOrHVApTG9OGfoVYx1cN4JgH1yIzdH2ihtigTJub8FlVQAVQI3Eqpx5BEJmJ62a
         Q13DT/0Jp/lo3RTQISNRzwHFfVUvbugZv01Ym/FHDtp8zIwrNctMRrK33b4DmNrxhwk7
         ckLCC8si+AltsVqaM3L7xo2IK1ms8CzckQpKM7hj7gdPYMDUlJLr+KBfbjCccSVpOsAC
         qLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zyweaVyiMqk4LHuNuzEqryLINLpiUARVWRIcVZa2lw=;
        b=Sok+s4JtlIFtLrme44Ps2efecLGkDw5I9cb549M6bbJPs41YAq2WSPlEprJdVYdU8X
         hniHS9Sr9W8x8GGtOupWK5COnYYfNOY/hho0KkdfozOuiX+ngIS3neHawfXCWNVMdpW2
         Vs4iC5O5Gd/Dk7mcArAU/8xXYzpY4ulOTNLWqQdaoLI5HNi70MvNO3cwnQwY/gpn+GB1
         mbIUk7rF+rxH4IdfF6OLJBnQ0zuoJbKlgbaqb+fSuPazk6QV3eUNToTfJzRHyS0bKpE3
         zR34wPIovAejPppt5S+D1xKM118kp9Xr9dUddRrV37tDw7/7AXpTobf62LCWqJduL6Me
         mGxA==
X-Gm-Message-State: AO0yUKWv6UqlCU/sL85IG3PfLkKd13ZRzX/NkYJ6tZvLXgusF4qf35Nz
        LqlYQ3z23KufpdhrBfjH2Yw1VJnWNf3OBZGyyQPziQ==
X-Google-Smtp-Source: AK7set9V9OdoqOHwLvVsBSh6xMOnS76j0J/EJOguL3f2UWTtjvPiP0ISRA9SUhs+FJhcH6k42DfkTHAvGrK64PYZUa8=
X-Received: by 2002:a17:902:c215:b0:199:26b1:17a7 with SMTP id
 21-20020a170902c21500b0019926b117a7mr326393pll.10.1675705948668; Mon, 06 Feb
 2023 09:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20230204183241.never.481-kees@kernel.org>
In-Reply-To: <20230204183241.never.481-kees@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 6 Feb 2023 09:52:17 -0800
Message-ID: <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 4, 2023 at 10:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:
>
> ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
>   207 |                                        *(__be16 *)&key->data[i]);
>       |                                                   ^~~~~~~~~~~~~
> ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
>   102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>       |                                                      ^
> ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
>    97 | #define be16_to_cpu __be16_to_cpu
>       |                     ^~~~~~~~~~~~~
> ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
>   206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> ^
>       |                            ^~~~~~~~~~~
> In file included from ../include/linux/bpf.h:7:
> ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
>    82 |         __u8    data[0];        /* Arbitrary size */
>       |                 ^~~~
>
> This includes fixing the selftest which was incorrectly using a
> variable length struct as a header, identified earlier[1]. Avoid this
> by just explicitly including the prefixlen member instead of struct
> bpf_lpm_trie_key.
>
> [1] https://lore.kernel.org/all/202206281009.4332AA33@keescook/
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mykola Lysenko <mykolal@fb.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/linux/bpf.h                         | 2 +-
>  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ba0f0cfb5e42..5930bc5c7e2c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>  struct bpf_lpm_trie_key {
>         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> -       __u8    data[0];        /* Arbitrary size */
> +       __u8    data[];         /* Arbitrary size */
>  };

That's a UAPI change, can we do it? The safest option is probably just
to remove this field if it's causing any problems (and not do the
map_ptr_kern.c change below).
The usual use-case (at least that's what we do) is to define some new
struct over it:

struct my_key {
  struct bpf_lpm_trie_key prefix;
  int a, b, c;
};

So I really doubt that the 'data' is ever touched by any programs at all..

>
>  struct bpf_cgroup_storage_key {
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index db388f593d0a..543012deb349 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -311,7 +311,7 @@ struct lpm_trie {
>  } __attribute__((preserve_access_index));
>
>  struct lpm_key {
> -       struct bpf_lpm_trie_key trie_key;
> +       __u32 prefixlen;
>         __u32 data;
>  };
> --
> 2.34.1
>
