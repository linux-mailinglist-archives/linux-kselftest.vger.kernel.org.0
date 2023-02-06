Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3709368C69F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 20:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBFTRj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBFTRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 14:17:32 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489812BF08
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 11:17:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id pj3so12592146pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFhCCF6KKc8jrwlIib3xYlcK52nQlU5i7JbQZG5xkXg=;
        b=WIa7oPHbexPVvg4fvwaR9+kndrbroQz++TujaKD28jY2+pxf0hdMAI3dY/LgXNAy3r
         Qf5FK0+I9qvhFLMOEo43LueGk5poqBnbYVUnXT0t+Ifb6XFaVyG+8AaZiyAEIC625pot
         j5zoY+NWeNUrD6vp0+dFxCD4OHCRpwcVf1OmeWPxZ0zzz3Dg5GGORrCgUIr8PZ6IZ/o0
         tYXlfjF+DeDK+Ae/lA0F56vFNv6gYkD75dK51ejHN3N6XhOMEpgwfYjHaSakMJ1mPjlV
         e6Lun3AqirDzO4xjcq3dO84B13UX2cnUMP0NyznhT+WZgBIpwXLPOjTmfzCr+0vz16kW
         iroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFhCCF6KKc8jrwlIib3xYlcK52nQlU5i7JbQZG5xkXg=;
        b=vfOzATSeCEiPx1CoZUaEKr6BCa1Stc7EMvI3Hlcq12QHAhJUZOGnVGYnqB9u3oThjT
         p6HIMw/iNboHBNaKEqfZVghEhDZ8tBmPbL5qFQ0oNTWY4ZGBgBlYzV/nyODWr7ps6taL
         Bq0ph1fyd2Vze+020rrtX3bpKEJNubI39g645tuesueY2BJaC0JL3LMHvdNub9pxJY9K
         Xc/dErOkvs/6ihkTyzZcTqsmak5sukg8lMzfT3VzBVdZ0HzqAYHjrKi60XCsViMtAqF7
         Gaqo1xR0F7ZpmIiMAjJIH0GlJeSY9d+s6L5fOosn1MGR9G7sa5Hd7Lz23rd/phYA/3h4
         iUIA==
X-Gm-Message-State: AO0yUKUKrKWr4ozoHwGJOMJqpGkhBc4natpVESFfKm53d5YvFqgbmBBG
        K9pa+LCvDCva0TXa86NtKicVU04+A15Sv1xUHT9BRA==
X-Google-Smtp-Source: AK7set9Bd4y8RazRLw+FgG1fYKluMFeh9bpugxhLYn9uSsK9r462sJPsTzLTYkh/jbCi2pN9gIlAXA1PsRLtyiap9CM=
X-Received: by 2002:a17:90a:3d01:b0:230:8961:22c1 with SMTP id
 h1-20020a17090a3d0100b00230896122c1mr167548pjc.95.1675711038558; Mon, 06 Feb
 2023 11:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20230204183241.never.481-kees@kernel.org> <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
 <63e14abb.170a0220.ca425.b7bc@mx.google.com>
In-Reply-To: <63e14abb.170a0220.ca425.b7bc@mx.google.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 6 Feb 2023 11:17:06 -0800
Message-ID: <CAKH8qBtX0HU4_YtnZ3hU4NhGHSQ9VU70niXFFoqf3k67a1+6aA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 6, 2023 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 06, 2023 at 09:52:17AM -0800, Stanislav Fomichev wrote:
> > On Sat, Feb 4, 2023 at 10:32 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> > > flexible array. Found with GCC 13:
> > >
> > > ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
> > >   207 |                                        *(__be16 *)&key->data[i]);
> > >       |                                                   ^~~~~~~~~~~~~
> > > ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
> > >   102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> > >       |                                                      ^
> > > ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
> > >    97 | #define be16_to_cpu __be16_to_cpu
> > >       |                     ^~~~~~~~~~~~~
> > > ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
> > >   206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> > > ^
> > >       |                            ^~~~~~~~~~~
> > > In file included from ../include/linux/bpf.h:7:
> > > ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
> > >    82 |         __u8    data[0];        /* Arbitrary size */
> > >       |                 ^~~~
> > >
> > > This includes fixing the selftest which was incorrectly using a
> > > variable length struct as a header, identified earlier[1]. Avoid this
> > > by just explicitly including the prefixlen member instead of struct
> > > bpf_lpm_trie_key.
> > >
> > > [1] https://lore.kernel.org/all/202206281009.4332AA33@keescook/
> > >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@google.com>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Mykola Lysenko <mykolal@fb.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Haowen Bai <baihaowen@meizu.com>
> > > Cc: bpf@vger.kernel.org
> > > Cc: linux-kselftest@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/uapi/linux/bpf.h                         | 2 +-
> > >  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index ba0f0cfb5e42..5930bc5c7e2c 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -79,7 +79,7 @@ struct bpf_insn {
> > >  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
> > >  struct bpf_lpm_trie_key {
> > >         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> > > -       __u8    data[0];        /* Arbitrary size */
> > > +       __u8    data[];         /* Arbitrary size */
> > >  };
> >
> > That's a UAPI change, can we do it? The safest option is probably just
> > to remove this field if it's causing any problems (and not do the
> > map_ptr_kern.c change below).
>
> The problem was seen because "data" is used by the kernel (see the
> compiler warning above). But if it can be removed, sure, that works too,
> and it much nicer since the resulting structs would have fixed sizes.

I guess I still don't understand why we need the change in map_ptr_kern.c?

Re-reading the description:

> > > This includes fixing the selftest which was incorrectly using a
> > > variable length struct as a header, identified earlier[1].

It's my understanding that it's the intended use-case. Users are
expected to use this struct as a header; at least we've been using it
that way :-)

For me, both return the same:
sizeof(struct { __u32 prefix; __u8 data[0]; })
sizeof(struct { __u32 prefix; __u8 data[]; })

So let's do s/data[0]/data[]/ in the UAPI only? What's wrong with
using this struct as a header?

> > The usual use-case (at least that's what we do) is to define some new
> > struct over it:
> >
> > struct my_key {
> >   struct bpf_lpm_trie_key prefix;
> >   int a, b, c;
> > };
> >
> > So I really doubt that the 'data' is ever touched by any programs at all..
>
> Horrible alternative:
>
> struct my_key {
>     union {
>         struct bpf_lpm_trie_key trie;
>         struct {
>             u8 header[sizeof(struct bpf_lpm_trie_key)];
>             int a, b, c;
>         };
>     };
> };
>
> Perhaps better might be:
>
> struct bpf_lpm_trie_key {
>     __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> };
>
> struct bpf_lpm_trie_key_raw {
>     struct bpf_lpm_trie_key_prefix prefix;
>     u8 data[];
> };
>
> struct my_key {
>     struct bpf_lpm_trie_key_prefix prefix;
>     int a, b, c;
> };
>
> Thoughts?
>
> --
> Kees Cook
