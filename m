Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2368C60E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 19:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBFSpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 13:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBFSpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 13:45:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51365276
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 10:45:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id iy2so3001536plb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DkhDQDKT3oVXHbvXapcI5zTOXdH8Icb/ANsh1giobys=;
        b=R/gvzAjpkUwIW2Ypz2voQVYC/0MAAoapXn89Mk0mzs1r9FBsjEjUzP53KbAdiKtEv+
         nCHbrT375Kte2H7weMvqen9+Na7Dr06oH7ZK83AZshB8v0eIGE5Zvi/cZ+H1/C6WTs6u
         oXgNjd6akjn1A46hqWw6X7Uzgjv4jxq/Fn6h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkhDQDKT3oVXHbvXapcI5zTOXdH8Icb/ANsh1giobys=;
        b=Bu/mM5pRq8BMhl4KRrlEaUsy4MmZ4xw+05MZkoHwYX3l3Qr1iDgSuR1O3MF0ZLPTgc
         VJD76ZMJ7jq++RizbWvvdvArxHIAP4iFGEIM690t764JIzokXt9h+fUfDqTnPQNcHeXC
         0S3ggqRaTyam2y9UKWSMCqs7ytbLLjvOJaEQkNqr59lQPRURO8QbM0qMgtUB+lrcVLym
         bPhJwPlwqoxEeqCqK5zNrn2ZSBNfjdpTI/S0imC0hnYcG0BX2NKTE62Czb+/iUWKsQ6u
         H13js1W3E6nbGYrQqhp66TF2WVOkDnEONDqVZsRfcJbuY+awPT11zgSPo0tSLWqCNx6E
         b3bA==
X-Gm-Message-State: AO0yUKUO8niAJPEYbGc6d/x1lp2u5I82OcPzP9h9yPI5IpsWCKsLFFe/
        wkaH/2NLRiWCtuy9Cdq+1mM84g==
X-Google-Smtp-Source: AK7set8KFBZcJoyADEvCdNhzMHm/y5MIdXeUfrR90b/geFbtcc/C2jtV6qhmaO/gjfdwti36unuj5w==
X-Received: by 2002:a17:902:f113:b0:196:7a96:cd82 with SMTP id e19-20020a170902f11300b001967a96cd82mr16617424plb.42.1675709116186;
        Mon, 06 Feb 2023 10:45:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0019601fbb963sm7225276pld.172.2023.02.06.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:45:15 -0800 (PST)
Message-ID: <63e14abb.170a0220.ca425.b7bc@mx.google.com>
X-Google-Original-Message-ID: <202302061040.@keescook>
Date:   Mon, 6 Feb 2023 10:45:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Fomichev <sdf@google.com>
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
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
References: <20230204183241.never.481-kees@kernel.org>
 <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 09:52:17AM -0800, Stanislav Fomichev wrote:
> On Sat, Feb 4, 2023 at 10:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> > flexible array. Found with GCC 13:
> >
> > ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
> >   207 |                                        *(__be16 *)&key->data[i]);
> >       |                                                   ^~~~~~~~~~~~~
> > ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
> >   102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >       |                                                      ^
> > ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
> >    97 | #define be16_to_cpu __be16_to_cpu
> >       |                     ^~~~~~~~~~~~~
> > ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
> >   206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> > ^
> >       |                            ^~~~~~~~~~~
> > In file included from ../include/linux/bpf.h:7:
> > ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
> >    82 |         __u8    data[0];        /* Arbitrary size */
> >       |                 ^~~~
> >
> > This includes fixing the selftest which was incorrectly using a
> > variable length struct as a header, identified earlier[1]. Avoid this
> > by just explicitly including the prefixlen member instead of struct
> > bpf_lpm_trie_key.
> >
> > [1] https://lore.kernel.org/all/202206281009.4332AA33@keescook/
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mykola Lysenko <mykolal@fb.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Haowen Bai <baihaowen@meizu.com>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/uapi/linux/bpf.h                         | 2 +-
> >  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index ba0f0cfb5e42..5930bc5c7e2c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -79,7 +79,7 @@ struct bpf_insn {
> >  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
> >  struct bpf_lpm_trie_key {
> >         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> > -       __u8    data[0];        /* Arbitrary size */
> > +       __u8    data[];         /* Arbitrary size */
> >  };
> 
> That's a UAPI change, can we do it? The safest option is probably just
> to remove this field if it's causing any problems (and not do the
> map_ptr_kern.c change below).

The problem was seen because "data" is used by the kernel (see the
compiler warning above). But if it can be removed, sure, that works too,
and it much nicer since the resulting structs would have fixed sizes.

> The usual use-case (at least that's what we do) is to define some new
> struct over it:
> 
> struct my_key {
>   struct bpf_lpm_trie_key prefix;
>   int a, b, c;
> };
> 
> So I really doubt that the 'data' is ever touched by any programs at all..

Horrible alternative:

struct my_key {
    union {
        struct bpf_lpm_trie_key trie;
        struct {
            u8 header[sizeof(struct bpf_lpm_trie_key)];
            int a, b, c;
        };
    };
};

Perhaps better might be:

struct bpf_lpm_trie_key {
    __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
};

struct bpf_lpm_trie_key_raw {
    struct bpf_lpm_trie_key_prefix prefix;
    u8 data[];
};

struct my_key {
    struct bpf_lpm_trie_key_prefix prefix;
    int a, b, c;
};

Thoughts?

-- 
Kees Cook
