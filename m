Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0587D3E21
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjJWRod (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjJWRoc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 13:44:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08848D7B
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 10:44:29 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e9b6f39f9eso2689231fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698083068; x=1698687868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7G5ETqm85R+O8rjCffN/EgWaevuGBBGp+Yfy1oHvZI=;
        b=keG0lQJOTiUGod+aXy/v/c2aUbTY+vdZYc4pxe61FZ8WdY54LwR3RrIfMox3w/599W
         2Sbq1GnRUjQRfrUAWCL0oGQP/B5udJAMuMjh3/o3O15HgSxcVJWNiAKHtcC8v7KKJenU
         A4PZIxhMPoVBdrRLI8kOAQTSkFrExShXLMhhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083068; x=1698687868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7G5ETqm85R+O8rjCffN/EgWaevuGBBGp+Yfy1oHvZI=;
        b=P0JfwwqLUxEX+qdQXC1OtYsJDj58aV2pZ6Samz2NqfQrPigVnh71bMG8dkvAV1+O98
         /GeKHCuCRVl7Si0aZuEmnuNYzL/U7b19qnH5yt8M3KuRd9oNpUiT5Q2kZw8Ed0qyK4TD
         lNnlya7Eqv2O8Ad5ipi88PHiL6DQ/pGQAXO0L12f1kzAAQPQZlgEuh9FMay516FS7e7/
         wO1Og6jmrBekbFwNpXOwP4YjwGueST0uASD+yLugSZ0vgzY9GPHVwE49yhp3y3hjw1lH
         rUIs5ZbvKgChdnaMT+8Dba5O5TVn5CVZzag/G3nIj5rcty1JzKJ6mfEWsX4j2G38UEeD
         Gmyg==
X-Gm-Message-State: AOJu0Yx4wBwlib84k3cG5A9ku9o98Ldm9U0SiRdHsbdWKf/g+at/Njzd
        3LBkKrJ1xexKzwrUuEZPm13rn7Ndw6B5+AR6TdYSxg==
X-Google-Smtp-Source: AGHT+IGvCbHbkUldqJVCJnA7fx4lXJtIFpqmDQAAcI0RyigJuUbtyS+AoYWMaiwgaHhWwvs/j+j1sfSzoNiHFYIFbjg=
X-Received: by 2002:a05:6870:5312:b0:1ea:9898:c07f with SMTP id
 j18-20020a056870531200b001ea9898c07fmr12881189oan.22.1698083068251; Mon, 23
 Oct 2023 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com>
 <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com> <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
In-Reply-To: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 23 Oct 2023 10:44:16 -0700
Message-ID: <CABi2SkVqyBgh2JpvFj3yhu8UB-p7R9euvkJAjysmn1sR_NMwsA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 4:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 15:47, Pedro Falcato <pedro.falcato@gmail.com> wro=
te:
> > >
> > > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
> >
> > No. POSIX works merely as a baseline that UNIX systems aim towards.
> > You can (and very frequently do) extend POSIX interfaces (in fact,
> > it's how most of POSIX was written, through sheer
> > "design-by-committee" on a bunch of UNIX systems' extensions).
>
> We can in extreme circumstances actually go further than that, and not
> only extend on POSIX requirements, but actively even violate them.
>
> It does need a very good reason, though, but it has happened when
> POSIX requirements were simply actively wrong.
>
> For example, at one point POSIX required
>
>      int accept(int s, struct sockaddr *addr, size_t *addrlen);
>
> which was simply completely wrong. It's utter shite, and didn't
> actually match any reality.
>
> The 'addrlen' parameter is 'int *', and POSIX suddenly trying to make
> it "size_t" was completely unacceptable.
>
> So we ignored it, told POSIX people that they were full of sh*t, and
> they eventually fixed it in the next version (by introducing a
> "socklen_t" that had better be the same as "int").
>
> So POSIX can simply be wrong.
>
> Also, if it turns out that we had some ABI that wasn't
> POSIX-compatible, the whole "don't break user space" will take
> precedence over any POSIX concerns, and we will not "fix" our system
> call if people already use our old semantics.
>
> So in that case, we generally end up with a new system call (or new
> flags) instead.
>
> Or sometimes it just is such a small detail that nobody cares - POSIX
> also has a notion of documenting areas of non-conformance, and people
> who really care end up having notions like "conformance vs _strict_
> conformance".
>
>                  Linus
>

Thanks Linus for clarifying the guidelines on POSIX in Linux.

-Jeff
