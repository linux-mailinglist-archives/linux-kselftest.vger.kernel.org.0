Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898A77CE635
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJRSUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJRSUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 14:20:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A2B8
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:20:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-419b53acc11so42801cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697653239; x=1698258039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vVIrHuWQVA6shM3HnYPie5+SRU5CPGTqtle1JU5tXo=;
        b=2Vlfe3wPPKaCOHn3S36I5scTD/erTZe6VUeGITRJcVPh3Jsa4z0A1pMS9Drm2T31zQ
         250mnWxYhasaEQ5DYVxSsSREv/TULBXzcITSNwLrUSMlLH6u0ofjTLQoA5DRArTGgxqj
         G6stLv82rdMdF6FdxqSYYSBNcydyyzKfbsNQYF7oQzJNY0w2aXRiKKJd7Gm8WxR3somE
         fQM76zCSVPBpkrfn6DGrSDpWOEhssv5+8qcsHoqClS7X3oLbc84zTDiAPpKY7uGDvLct
         SukbY6cA0EhbPqgGhW9DrCLyku3rjNIO0yI5k1LZF0bz+tMqWvJYkMwYdxsWkk0frBVu
         Ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653239; x=1698258039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vVIrHuWQVA6shM3HnYPie5+SRU5CPGTqtle1JU5tXo=;
        b=w4Xz2UEzLnKy2rrnRv1AkTKSRQPWlc7zbjWBGs+UQZS7qGFq2/xpoENJ1NrGzSXnjt
         pxsCQan7gQuGjl9pvKlYa1QACrfWBOPjXHYewtfqMjhWN7y16kbWU00T5s61b237IUkl
         pZZIQaVZfVUe5XIRxg7z9EPyJ50wibT02S7f6wFOvaHmDNXLbC+ZO8iRnNhmDKdrBzKf
         zm3EcBJytxUqDoeTxI1LXUhkH2JqBWzbkNu+2PPTnb1ATdnMMmU+Ne2QpOycMSeF6yhq
         HVdYqwY+6TlezTNSx0xN6+EAkWt+oNpmu6S153WWAEB9ThI2hLLR5oktvFHeRI/sB4+1
         xYZA==
X-Gm-Message-State: AOJu0Yw1aYRgyAI/PQe8yN5jR0HXGXaciqwvOmMXHJZ/soKkmt9UOSA4
        mZ5lAFZgBoIFTlFTKh2jnFl00tiVz94mP3mzEfosxg==
X-Google-Smtp-Source: AGHT+IGyGQSgQHJFj8BImsesXGVlASS7RW6eopJfbHL22F8InhKtFg9dsIpDe/ROKjo5uadHLqVLhE2zRmNvOeNRnlY=
X-Received: by 2002:a05:622a:a049:b0:412:9cd:473b with SMTP id
 ju9-20020a05622aa04900b0041209cd473bmr48343qtb.4.1697653239212; Wed, 18 Oct
 2023 11:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com> <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
In-Reply-To: <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 18 Oct 2023 11:20:02 -0700
Message-ID: <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 3:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> > >
> > > I think it's worth pointing out that this suggestion (with PROT_*)
> > > could easily integrate with mmap() and as such allow for one-shot
> > > mmap() + mseal().
> > > If we consider the common case as 'addr =3D mmap(...); mseal(addr);',=
 it
> > > definitely sounds like a performance win as we halve the number of
> > > syscalls for a sealed mapping. And if we trivially look at e.g OpenBS=
D
> > > ld.so code, mmap() + mimmutable() and mprotect() + mimmutable() seem
> > > like common patterns.
> > >
> > Yes. mmap() can support sealing as well, and memory is allocated as
> > immutable from begining.
> > This is orthogonal to mseal() though.
>
> I don't see how this can be orthogonal to mseal().
> In the case we opt for adding PROT_ bits, we should more or less only
> need to adapt calc_vm_prot_bits(), and the rest should work without
> issues.
> vma merging won't merge vmas with different prots. The current
> interfaces (mmap and mprotect) would work just fine.
> In this case, mseal() or mimmutable() would only be needed if you need
> to set immutability over a range of VMAs with different permissions.
>
Agreed. By orthogonal, I meant we can have two APIs:
mmap() and mseal()/mprotect()
i.e. we can't just rely on mmap() only without mseal()/mprotect()/mimmutabl=
e().
Sealing can be applied after initial memory creation.

> Note: modifications should look kinda like this: https://godbolt.org/z/Tb=
jjd14Pe
> The only annoying wrench in my plans here is that we have effectively
> run out of vm_flags bits in 32-bit architectures, so this approach as
> I described is not compatible with 32-bit.
>
> > In case of ld.so, iiuc, memory can be first allocated as W, then later
> > changed to RO, for example, during symbol resolution.
> > The important point is that the application can decide what type of
> > sealing it wants, and when to apply it.  There needs to be an api(),
> > that can be mseal() or mprotect2() or mimmutable(), the naming is not
> > important to me.
> >
> > mprotect() in linux have the following signature:
> > int mprotect(void addr[.len], size_t len, int prot);
> > the prot bitmasks are all taken here.
> > I have not checked the prot field in mmap(), there might be bits left,
> > even not, we could have mmap2(), so that is not an issue.
>
> I don't see what you mean. We have plenty of prot bits left (32-bits,
> and we seem to have around 8 different bits used).
> And even if we didn't, prot is the same in mprotect and mmap and mmap2 :)
>
> The only issue seems to be that 32-bit ran out of vm_flags, but that
> can probably be worked around if need be.
>
Ah, you are right about this. vm_flags is full, and prot in mprotect() is n=
ot.
Apology that I was wrong previously and caused confusion.

There is a slight difference in the syntax of mprotect and mseal.
Each time when mprotect() is called, the kernel takes all of RWX bits
and updates vm_flags,
In other words, the application sets/unset each RWX, and kernel takes it.

In the mseal() case, the kernel will remember which seal types were
applied previously, and the application doesn=E2=80=99t need to repeat all
existing seal types in the next mseal().  Once a seal type is applied,
it can=E2=80=99t be unsealed.

So if we want to use mprotect() for sealing, developers need to think
of sealing bits differently than the rest of prot bits. It is a
different programming model, might or might not be an obvious concept
to developers.

There is a difference in input check and error handling as well.
for mseal(), if a given address range has a gap (unallocated memory),
or if one of VMA is sealed with MM_SEAL_SEAL flag, none of VMAs is
updated.
For mprotect(), some VMAs can be updated, till an error happens to a VMA.

IMO: I think it makes sense for mseal() and mprotect() to be different
in this. mseal() only checks vma struct so it is fast, and mprotect()
goes deeper into HW.

Because of those two differences, personally I feel a new syscall
might be worth the effort.

That said, mmap() + mprotect() is workable to me if that is what the
community wants.

Thanks
-Jeff

-Jeff


> --
> Pedro
