Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CA45B201
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhKXCXP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 21:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbhKXCXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 21:23:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A38BC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Nov 2021 18:20:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q17so587978plr.11
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Nov 2021 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPzUdANZ6JjrPyy1OAsYCcoJwwnBIkZtVB6H/wjuicc=;
        b=Jl7apnmW67ouAcAMhWkZ3ZDTYRQHUDtmlvcs4ReNvb6uJreZlU/Jr9YOLWBQmLPN13
         +4kir69qyldny4EM2J1Jznpzn1b0UYNoRwEFBekpR72SuqNTppiAJuQjyaDcBfNYKsZT
         tGM0uQpc2mGtEF1vjCBQMJ8XYdtPTpf5WhzbhIXQTN9emJDtSGswTwkH1RmbNWuAYb2A
         WEBDTrvQqb8xcUXaL+AwcwUSvjoqZhNN45L18d8tIDYVvKSPwqBcRd777Vh44oUTNs6V
         k5eFY3ijmwwYht8PNS59xt8AQlfuo40snjUHh+iv2v70PKs53PI7MzYO6UNflIsN/t0l
         Er0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPzUdANZ6JjrPyy1OAsYCcoJwwnBIkZtVB6H/wjuicc=;
        b=cusVVEIi+5lxpvGnl+sIXRQjtFQx0k/ypLWsahCIxujGhbA3EFF9+R9TKH6G8HT7AX
         0NOWTEAxJ1NgKoUuZstJUAGN39EVsLlOhKot6Rouul0zdq1Q8WSOCxbRnHK7xJvTZTWm
         svuGx54lHNam1LYDNb6z0gx7B2e+Jb974w8r/4ezIVcBobQEHk2L3TLJx4zolEAWHsfw
         0pHCnay7u1pRDpB/PNzqUm3bPpCI/CgKXFn+4tSC57lApVHatJJ7CdLaOLcHKDjdf5um
         S6wqb91FHKMe2VhyFIY+klZUu+Yua3eFBxx2b3nY4/qeMjIAcX9gF27IW6CRHWIEH9GI
         ijIQ==
X-Gm-Message-State: AOAM53359jT962Ty0joqT6ENsqAKqbTd12o44OvxiYu71DBaC+mXMdIy
        JrqQZZonvaegbZ0TMIlWHgdbj7Oo3+4YyB1VH9aG7g==
X-Google-Smtp-Source: ABdhPJw//6jHYsiw6J2hv2rMhFqeq1yedUp1wZmkuP2ypMFfAhC9OCP6NIDZ9FCqxEV2bc7pbH3Q4ENqHTIecYmBzJc=
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mr10009142pjb.7.1637720405664;
 Tue, 23 Nov 2021 18:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123204644.3458700-1-yosryahmed@google.com> <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
In-Reply-To: <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 23 Nov 2021 18:19:29 -0800
Message-ID: <CAJD7tkYZY1g_b9E4ZP3yqHhT36nF57c4bzKRQM-SLftDCYNQ9A@mail.gmail.com>
Subject: Re: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 23, 2021 at 5:08 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/23/21 12:46, Yosry Ahmed wrote:
> > The hugetlb vma mremap() test mentions in the header comment that it
> > uses 10MB worth of huge pages, when it actually uses 1GB. This causes
> > the test to fail on devices with smaller memories.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'll let Mina comment, but I think I know what happened.

Thanks for taking the time to review this and explain what happened.

>
>
> The original version of the test did indeed use 10MB.  However, the mremap
> code must 'unshare' and shared pmd mappings before remapping.  Since sharing
> requires mappings of at least 1GB, the size was changed to make sure unsharing
> worked.
>
> In the end, I believe I suggested adding hugepage-mremap to run_vmtests.sh.
> The script does not try to configure a GB worth of huge pages.  And, I think
> it is somewhat unreasonable to suggest users gave a spare GB to run the test.

Alternatively, we can pass an optional argument to the test that makes it use
1GB instead of 10MB. This way, if the test is run with run_vmtests.sh the
default behavior would be to use 10MB, making sure users do not run out of
memory. Otherwise, an interested user could run the test without run_vmtest.sh
and provide the extra argument to make the test use 1GB and make sure that
unsharing works correctly. Thoughts?

>
> I'm OK with restoring the original value.
>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
