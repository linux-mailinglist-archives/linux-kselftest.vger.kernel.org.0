Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00087479E14
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 00:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhLRXGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 18:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhLRXGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 18:06:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A787C061574
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 15:06:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b7so22450319edd.6
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 15:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyKRP/I6esBlhYrEjQLh8BM6N5zOayyRIq/pW8rIAMo=;
        b=fsSA+hM1gQ3dj9V0r6PVdcqg8GIMnU0H2LArYw6UfIkmSDWA7xyVG7fNKpz/dEkoEQ
         SxpEjrlIEqHKNjkl7T6pCX2g5eSPHmzbO0hZDxnUt0UDbVn1IlADDl8KoulkmMpTXprj
         XC5VDGy1beoXsKOs8RdX7NwWeePSeaw8DuiSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyKRP/I6esBlhYrEjQLh8BM6N5zOayyRIq/pW8rIAMo=;
        b=E4RP2dS8YQcYBsEufgTOQ7SOehMx/hSQ+s47j6Ot6brsyiyfeCAuXQON7uffvS4Dmf
         /705J9KWmRnktFdpNnx/agWDIhJXMc1eiBL1s/4/m/iqjlfZpLz3Lgp+vJIWCzebNYtV
         goE6tGq2tN4VQxTf1RerFWhhvgpAu5spuDTNZ94x4k7nowjVSUcwX3OrxmPCh9OD/oII
         N7/bfWVB5ZrrZUP9GysYFWOkYmAH143/iBUD/iKlAlOPf+cI579iayhIgXV3j6/fvbrA
         tbpPEu7ZVr8kvp/eqCUabcvWxCiFpaKtBoNw6bY99QKTxOrWd4NMJBpGOhs6lUjywiHp
         ymMg==
X-Gm-Message-State: AOAM5302xC7WKS455MPA+u1p7+1QOQ3WEIoifjTIXW3CfmBnhV9ClsaO
        csEA5fbQPFR5RnmBKDwEcnVxyQWA4v4p0NM4ebM=
X-Google-Smtp-Source: ABdhPJyiboUGap/ftwXEE3DVxch25VGIZXhKUnufV4/Pka9o/EwOKm3VPPuVMYrL5ZGwr0hvHjELxw==
X-Received: by 2002:a05:6402:1008:: with SMTP id c8mr9001121edu.114.1639868782677;
        Sat, 18 Dec 2021 15:06:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o12sm1455837edz.71.2021.12.18.15.06.22
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 15:06:22 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id j6so1892013edw.12
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 15:06:22 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr7529281wrp.442.1639868771784;
 Sat, 18 Dec 2021 15:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com> <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
 <20211218225211.epa4u6mtjnvgkw4x@box.shutemov.name>
In-Reply-To: <20211218225211.epa4u6mtjnvgkw4x@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 15:05:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJWmj70d6yCzYPvrC-6V-6jwkJ4mrVc_p3toy4Lz_nhg@mail.gmail.com>
Message-ID: <CAHk-=whJWmj70d6yCzYPvrC-6V-6jwkJ4mrVc_p3toy4Lz_nhg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 18, 2021 at 2:52 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> So you are saying that if a GUP user wants to see changes made by
> userspace to the page after the GUP it must ask for FOLL_WRITE, even if it
> doesn't have intend to write to the page?

Yup. Put the onus very clearly on GUP.

It's a very special operation, and it's one of the operations that
cause a lot of problems for the VM code. It's by no means the _only_
one - we've got a lot of other things that cause issues - but I think
it's very clear that GUP is very very special, and nobody should say
"I want GUP to do whatever".

There are two cases for GUP:

 - look up the page as it is *NOW*

 - look up the page in order to see any future state on it (and
possibly modify it)

that "any future state" is a fundamentally much heavier operation.
It's the one that really *has* to get rid of any sharing, and it has
to make sure no sharing happens in the future either.

So ii it is an anonymous page, it basically needs to act like a write.
Even if that page is then used only for reading.

Note that here that "if it's anonymous" is kind of a big deal. If it's
a shared file-mapped page, at that point it's "just another
reference". It's potentially problematic even in that case (think of
"truncate()" that tries to force-unmap all pages from VM's), but for
the shared case the answer is "if you truncate it and disassociate the
page from the mapping, it's _your_ problem.

And once it acts as a write, and once it does that COW and we have
exclusive access to it, it might as well be just writable and dirty.
You've done the expensive part already. You've forced it to be private
to that VM.

And this was all triggered by the user doing something very special,
so no amount of "but POSIX" or whatever matters.

GUP is not great. If you use GUP, you get to deal with the downsides.

               Linus
