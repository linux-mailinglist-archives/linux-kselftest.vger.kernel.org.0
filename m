Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE957CC77D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJQPaN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjJQPaN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:30:13 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780192;
        Tue, 17 Oct 2023 08:30:10 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d14708479so2422481e0c.2;
        Tue, 17 Oct 2023 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556610; x=1698161410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzY0GitsyqElPw0k5xUlrTwnu+ANjyD6D4kPaGkZk+Y=;
        b=gJosHrMPPwSl5KhyR/YP1VHR8TQDm8gLmCx7r9iY1UqFRk/hpvrPTKZUiRKCoN93Y6
         jx2NaxbReA+EED4uC2KtJJ3lETe98yfaS1B6tumsVa+eR6pZAxcbe8NegVnbcZYmVeHy
         Xwksty+fkpdENYzoGymwoyfqZ8L2xtxzGgLMnbPiOWvyAh4KCeWnrRu08uW8Qs2LZWfZ
         jZCpAmRJI3cpkTmOtcgkqf2lbAy0AKVbvySswLJs8J7FOmJX9OQSzU4HsoD3Xf/Kdi+n
         pSAYQ8VkeMkotyamjxhgGflgdHyshk+Ni8OArrSSQbTAs2IAjUhQlNGwdbnGfU4eDEMS
         q9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556610; x=1698161410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzY0GitsyqElPw0k5xUlrTwnu+ANjyD6D4kPaGkZk+Y=;
        b=o3wAjPVkerhphkp4GnsM/9FbaVL3jQlOzNyUrPdYk6mokaRix+YZAyj5R9DpPDulkl
         /VNURDWfIdWl8x9iWpaOgQtS+K62ScVtUqv4gKjffVOS0FF3vz1RL6zgWd2RBT4LO/Ah
         mLxAstvOIYGk7/Dvda+mKqsV+rzeaaR6wgvFDRmTVMFAqMhl7y5GVsLzMCbyS6ubl4/K
         uUjQW1GEOVgF10+8CYhEYbxW6HSnt52rBg4OUcWI/SElHFLKsvio7HKJz7HtYIJnsrH/
         qzYYMfj90HBzj5SZnJIuiNtp890Bt4jk4gYQ7VJ1hBQCXpl7Jb7hAMh1PED67w43NDqJ
         4pyg==
X-Gm-Message-State: AOJu0YyziO83C0DaR8F0RyWoYAvx7HZZxaOWyoPk/zbjTaaJ0JnV9XDm
        odifBNi7grgUOcEXQPGkswnnj/M9JiBAUB5+cFY=
X-Google-Smtp-Source: AGHT+IEToIjI6smNAtb9fQBnBiUnBPsWCGQ9u1vaLqsMsmIj7mhsOek4OqQxscUBMCeGRUVeH5hK/AybixcyAuDmkds=
X-Received: by 2002:a05:6122:30a2:b0:49d:d73e:5d07 with SMTP id
 cd34-20020a05612230a200b0049dd73e5d07mr2683910vkb.16.1697556609819; Tue, 17
 Oct 2023 08:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
In-Reply-To: <ZS1URCBgwGGj9JtM@casper.infradead.org>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Tue, 17 Oct 2023 16:29:58 +0100
Message-ID: <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
        namit@vmware.com, peterx@redhat.com, peterz@infradead.org,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
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

On Mon, Oct 16, 2023 at 4:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Oct 16, 2023 at 02:38:19PM +0000, jeffxu@chromium.org wrote:
> > Modern CPUs support memory permissions such as RW and NX bits. Linux ha=
s
> > supported NX since the release of kernel version 2.6.8 in August 2004 [=
1].
>
> This seems like a confusing way to introduce the subject.  Here, you're
> talking about page permissions, whereas (as far as I can tell), mseal() i=
s
> about making _virtual_ addresses immutable, for some value of immutable.
>
> > Memory sealing additionally protects the mapping itself against
> > modifications. This is useful to mitigate memory corruption issues wher=
e
> > a corrupted pointer is passed to a memory management syscall. For examp=
le,
> > such an attacker primitive can break control-flow integrity guarantees
> > since read-only memory that is supposed to be trusted can become writab=
le
> > or .text pages can get remapped. Memory sealing can automatically be
> > applied by the runtime loader to seal .text and .rodata pages and
> > applications can additionally seal security critical data at runtime.
> > A similar feature already exists in the XNU kernel with the
> > VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall =
[4].
> > Also, Chrome wants to adopt this feature for their CFI work [2] and thi=
s
> > patchset has been designed to be compatible with the Chrome use case.
>
> This [2] seems very generic and wide-ranging, not helpful.  [5] was more
> useful to understand what you're trying to do.
>
> > The new mseal() is an architecture independent syscall, and with
> > following signature:
> >
> > mseal(void addr, size_t len, unsigned int types, unsigned int flags)
> >
> > addr/len: memory range.  Must be continuous/allocated memory, or else
> > mseal() will fail and no VMA is updated. For details on acceptable
> > arguments, please refer to comments in mseal.c. Those are also fully
> > covered by the selftest.
>
> Mmm.  So when you say "continuous/allocated" what you really mean is
> "Must have contiguous VMAs" rather than "All pages in this range must
> be populated", yes?
>
> > types: bit mask to specify which syscall to seal, currently they are:
> > MM_SEAL_MSEAL 0x1
> > MM_SEAL_MPROTECT 0x2
> > MM_SEAL_MUNMAP 0x4
> > MM_SEAL_MMAP 0x8
> > MM_SEAL_MREMAP 0x10
>
> I don't understand why we want this level of granularity.  The OpenBSD
> and XNU examples just say "This must be immutable*".  For values of
> immutable that allow downgrading access (eg RW to RO or RX to RO),
> but not upgrading access (RW->RX, RO->*, RX->RW).
>
> > Each bit represents sealing for one specific syscall type, e.g.
> > MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitma=
sk
> > is that the API is extendable, i.e. when needed, the sealing can be
> > extended to madvise, mlock, etc. Backward compatibility is also easy.
>
> Honestly, it feels too flexible.  Why not just two flags to mprotect()
> -- PROT_IMMUTABLE and PROT_DOWNGRADABLE.  I can see a use for that --
> maybe for some things we want to be able to downgrade and for other
> things, we don't.

I think it's worth pointing out that this suggestion (with PROT_*)
could easily integrate with mmap() and as such allow for one-shot
mmap() + mseal().
If we consider the common case as 'addr =3D mmap(...); mseal(addr);', it
definitely sounds like a performance win as we halve the number of
syscalls for a sealed mapping. And if we trivially look at e.g OpenBSD
ld.so code, mmap() + mimmutable() and mprotect() + mimmutable() seem
like common patterns.

--=20
Pedro
