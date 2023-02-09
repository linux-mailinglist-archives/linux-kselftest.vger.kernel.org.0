Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93833690EAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBIQzj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIQzi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:55:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2220643D1;
        Thu,  9 Feb 2023 08:55:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so8234625ejb.7;
        Thu, 09 Feb 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6l9av8nyvwfd+ZGZCPAlJ7AddxXr455p4AhnsNGCvcw=;
        b=NK6ht5AeLDqVY2CrdjEahAMWjJ6lCy6wb9emMfbDBaChLtmf8gp9iD92C9KQJGfVlD
         wY22m0p4Tm+/AJ+H7ByoYFakSdzi60vnFUVJUF0PNgFB+zVFxmLl6cEDKmDeo5v+sg0c
         Iney5rYxDEs6h8dSCWxMhEypm6F4MIXHsdTEbIk6weBpBW6YqAbzbM1gxYZB+yAMLkcT
         BA+f4Y9Lqq1nWlFLsQEZ8PQQD8E3t6zbkD375wogCImI+QhO5nBr8HldEzS8US6pvrIy
         CCGQKdPZiaYqMEfwm4lCXlJSQ14UnAu62oHi/Zz9WWqDCmuUlN3lehyeee0lVbluydro
         nagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6l9av8nyvwfd+ZGZCPAlJ7AddxXr455p4AhnsNGCvcw=;
        b=P5QmLL1IDchHlMEHPZkm0UdHf+ph7+YrGh9ADOqBsX3oQR5x23gv24ztF9LDzUN4Oa
         0Bn9h+1Nl487aPVs06Gi6OxICrb9vqmRJSy/WLyEuqWYaYG6zyMxzrLaDzgb6a2f2OA7
         P0S41BGvWPaJS/cAl23HPnWGPVo4KCH3ioqUTzeK3VAqx9bZTsSLKJGwy+BxThrL2Hjr
         8Q6UiUmGZgz2KLGAA0dc0UYHhBrwmGcAK6OaZChqTtpjQJlc/zDnCavYyOf3jsiClCZK
         o5mWl/5UpKW2ZzGqSuyIfoHHsGxmO0spUEjxEE+lOGrNEPR/F89ku2wHW/hEQsUyxfg0
         u8DQ==
X-Gm-Message-State: AO0yUKXcxXA3J8Cjd+I+Fk4FZuaeUc2iFDPfwUbIHmgOfmQ6tja46by2
        UKtmS9m7eyWobMecAXakgHcADciVkKENvinGfTA=
X-Google-Smtp-Source: AK7set88flBG1oPZ+F0ymt+9FEmLxGig3e1Yib4mMs5R3zvW6Pd9XtM8vdWyXxN7/vcJ1Pb02MnQPZaeONxgiZE12yM=
X-Received: by 2002:a17:906:eb8f:b0:878:786e:8c39 with SMTP id
 mh15-20020a170906eb8f00b00878786e8c39mr2756943ejb.105.1675961735319; Thu, 09
 Feb 2023 08:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20230204183241.never.481-kees@kernel.org> <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
 <63e14abb.170a0220.ca425.b7bc@mx.google.com> <CAKH8qBtX0HU4_YtnZ3hU4NhGHSQ9VU70niXFFoqf3k67a1+6aA@mail.gmail.com>
 <63e5210b.630a0220.c17be.27ff@mx.google.com>
In-Reply-To: <63e5210b.630a0220.c17be.27ff@mx.google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 Feb 2023 08:55:23 -0800
Message-ID: <CAADnVQK-sW51SsC7FYDqLaO8c5xj=MAgcu_6p8L-JN9kAsrzeA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 9, 2023 at 8:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 06, 2023 at 11:17:06AM -0800, Stanislav Fomichev wrote:
> > It's my understanding that it's the intended use-case. Users are
> > expected to use this struct as a header; at least we've been using it
> > that way :-)
> >
> > For me, both return the same:
> > sizeof(struct { __u32 prefix; __u8 data[0]; })
> > sizeof(struct { __u32 prefix; __u8 data[]; })
> >
> > So let's do s/data[0]/data[]/ in the UAPI only? What's wrong with
> > using this struct as a header?
>
> For the whole struct, yup, the above sizeof()s are correct. However:
>
> sizeof(foo->data) == 0             // when data[0]
> sizeof(foo->data) == compile error // when data[]
>
> The [0]-array GNU extension doesn't have consistent behavior, so it's
> being removed from the kernel in favor of the proper C99 [] flexible
> arrays, so we can enable -fstrict-flex-arrays=3 to remove all the
> ambiguities with array bounds:
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> https://people.kernel.org/kees/bounded-flexible-arrays-in-c
>
> As a header, this kind of overlap isn't well supported. Clang already
> warns, and GCC is going to be removing support for overlapping composite
> structs with a flex array in the middle (and also warns under -pedantic):
> https://godbolt.org/z/vWzqs41h6
>
> I talk about dealing with these specific cases in my recent write-up
> on array bounds checking -- see "Overlapping composite structure members"
> in the people.kernel.org post above.
>
> > > Perhaps better might be:
> > >
> > > struct bpf_lpm_trie_key {
> > >     __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> > > };
> > >
> > > struct bpf_lpm_trie_key_raw {
> > >     struct bpf_lpm_trie_key_prefix prefix;
> > >     u8 data[];
> > > };
> > >
> > > struct my_key {
> > >     struct bpf_lpm_trie_key_prefix prefix;
> > >     int a, b, c;
> > > };
>
> This approach is, perhaps, the best way to go? Besides the selftest,
> what things in userspace consumes struct bpf_lpm_trie_key?

Plenty of bpf progs use it:
https://github.com/cilium/cilium/blob/master/bpf/lib/common.h#L352
