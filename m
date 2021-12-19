Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD147A187
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 18:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhLSR1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 12:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhLSR1r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 12:27:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191DDC061574
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 09:27:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so29237507edv.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KJMrZEXDcM/T7DLnqDgvdZVEREMw/sAHU3NJ11ovNwQ=;
        b=cgLwCh1hva5/ZFr7b/ckunrr4Un/SrfEk3NNboLI8xh1YV4i5YiQ6V0wF7FUDhGnSp
         c8K5T/WyCeMD8xhVCc9XL+bcpOjty8tNVo7PFFsqw1ABN7x2xZXxAnAJa1GRflKMBpcr
         0h+OOKMqmXLfixl3bPNrF7iMsIc1mP3RCBy+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KJMrZEXDcM/T7DLnqDgvdZVEREMw/sAHU3NJ11ovNwQ=;
        b=AKS0pOAHUWHVhCn2JVCuFPH1qnXcUHr7Hx3jG/GRD6oOFsLZza0sEEj6iCicQKHQ96
         ooGyaOYEtEmH2P+HHtMAtERiT+htUM6S9gydj7+jGPrxgut1W/dra5UAPnML1Kj8fL10
         wgYvsP29W4OdW3rIfH8I8vjuwS4pG/iZHKdmfXrEQSbZHD2fFq8rz2NgHeljHUe+79rf
         Qupm/f01XX4DdUfmcrqR+BmJPabTocXkSh3+UrqseV+WaqbLuhDVTbextA7UW4f27DU8
         YqtLEqUkVo9NbVOeleFOXYVlnDn+iEOqNpb+5cQ4GvAuHrAXaiwRpvsoKcJMwUg5dCBq
         lcsg==
X-Gm-Message-State: AOAM533iLqLr3FPLU3OGk92o7CfXdnV/gi+7xQEhHxE7ki9gcccbgs57
        CZsUm9CYEe9SFKHglxZtru+6lPoVYkqV+E3y5lY=
X-Google-Smtp-Source: ABdhPJwx3ZYux7wcc+/Vo4KikdYLu5HUisx4E5Jc9YCnW7fLKiF98gcHfDagnDjJZKV2oLPIygl1iA==
X-Received: by 2002:a17:907:1613:: with SMTP id hb19mr8879218ejc.587.1639934865410;
        Sun, 19 Dec 2021 09:27:45 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id dp6sm4674184ejc.140.2021.12.19.09.27.44
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 09:27:45 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id s1so15362687wrg.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 09:27:44 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr10021527wrp.442.1639934853596;
 Sun, 19 Dec 2021 09:27:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com> <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
In-Reply-To: <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 09:27:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
Message-ID: <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 18, 2021 at 10:02 PM Nadav Amit <namit@vmware.com> wrote:
>
> I found my old messy code for the software-PTE thing.
>
> I see that eventually I decided to hold a pointer to the =E2=80=9Cextra P=
TEs=E2=80=9D
> of each page in the PMD-page-struct. [ I also implemented the 2-adjacent
> pages approach but this code is long gone. ]

Ok, I understand why that ends up being the choice, but it makes it
too ugly and messy to look up  to be worth it, I think.

> I still don=E2=80=99t know what exactly you have in mind for making use
> out of it for the COW issue.

So the truly fundamental question for COW (and for a long-term GUP) is
fairly simple:

 - Is the page I have truly owned exclusively by this VM?

If that _isn't_ the case, you absolutely have to COW.

If that _is_ the case, you can re-use the page.

That is really it, boiled down to the pure basics.

And if you aren't sure whether you are the ultimate and only authority
over the page, then COW is the "safer" option, in that breaking
sharing is fundamentally better than over-sharing.

Now, the reason I like "page_count()=3D=3D1" is that it is a 100% certain
way to know that you own the page absolutely and clearly.

There is no question what-so-ever about it.

And the reason I hate "page_mapcount()=3D=3D1" with a passion is that it
is NOTHING OF THE KIND. It is an entirely meaningless number. It
doesn't mean anything at all.

Even if the page mapcount is exactly right, it could easily and
trivially be a result of "fork, then unmap in either parent or child".

Now that page_mapcount() is unquestionably 1, but despite that, at
some point the page was shared by another VM, and you can not know
whether you really have exclusive access.

And that "even if page mapcount is exactly right" is a big issue in
itself, as I hope I've explained.

It requires page locking, it requires that you take swapcache users
into account, it is just a truly messy and messed up thing.

There really is absolutely no reason for page_mapcount to exist. It's
a mistake. We have it for completely broken historical reasons.

It's WRONG.

Now, if "page_count()=3D=3D1" is so great, what is the issue? Problem solve=
d.

No, while page_count()=3D=3D1 is one really fundamental marker (unlike the
mapcount), it does have problems too.

Because yes, "page_count()=3D=3D1" does mean that you have truly exclusive
ownership of the page, but the reverse is not true.

The way the current regular VM code handles that "the reverse is not
true" is by making "the page is writable" be the second way you can
say "you clearly have full ownership of the page".

So that's why you then have the "maybe_pinned()" thing in fork() and
in swap cache creation that keeps such a page writable, and doesn't do
the virtual copy and make it read-only again.

But that's also why it has problems with write-protect (whether
mprotect or uddf_wp).

Anyway, that was a long explanation to make the thinking clear, and
finally come to the actual answer to your question:

Adding another bit in the page tables - *purely* to say "this VM owns
the page outright" - would be fairly powerful. And fairly simple.

Then any COW event will set that bit - because when you actually COW,
the page you install is *yours*. No questions asked.

And fork() would simply clear that bit (unless the page was one of the
pinned pages that we simply copy).

See how simple that kind of concept is.

And please, see how INCREDIBLY BROKEN page_mapcount() is. It really
fundamentally is pure and utter garbage.  It in no way says "I have
exclusive ownership of this page", because even if the mapcount is 1
*now*, it could have been something else earlier, and some other VM
could have gotten a reference to it before the current VM did so.

This is why I will categoricall NAK any stupid attempt to re-introduce
page_mapcount() for COW or GUP handling. It's unacceptably
fundamentally broken.

Btw, the extra bit doesn't really have to be in the page tables. It
could be a bit in the page itself. We could add another page bit that
we just clear when we do the "add ref to page as you make a virtual
copy during fork() etc".

And no, we can't use "pincount" either, because it's not exact. The
fact that the page count is so elevated that we think it's pinned is a
_heuristic_, and that's ok when you have the opposite problem, and ask
"*might* this page be pinned". You want to never get a false negative,
but it can get a false positive.

                 Linus
