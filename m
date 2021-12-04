Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B731E468203
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Dec 2021 03:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbhLDClk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 21:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhLDClk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 21:41:40 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4554C061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 18:38:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f186so14722632ybg.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 18:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/mTyk8aIwXaGnyhnIJNEDEMKPBdBItVHe13k9FZkPg=;
        b=kYMahCiLWicebBL5mpWnkZhDF6XeuuB9zqO4/U5pi1B81EWU9r7jTUpJRDRMgjntWS
         cMiV11vX89R/MpHtT2jLjHs90c2nkDQhWtFTzmIcoPbkA5zTlnE3ZHzTivaKltlOEIFc
         J5cu5jjb0pXuuFK/1/jVe8m/hWDwoZiZcSh1scy+VbZD3M0E6svgi6HwJNH+fcpxNNdy
         O7TAu3QWRZb6NdYEmcsuThTRlimoGQdy3ILtV48g8ZMzGN3q63nHDjbBZd/XSEJm72UV
         7G0VeIvNYNlUzv5DcXpPk0DHB2mi/nK4eilMJ2cEgO/7U0Zzl+1WakF10htEFF3XJhAv
         g5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/mTyk8aIwXaGnyhnIJNEDEMKPBdBItVHe13k9FZkPg=;
        b=gOqMSa5o0/iw+3zArW18zpQqku77X3QexU832VBSyionoNcsCDd796UpaqyLT5fGnR
         LOBB3aMo0Oa6E0ch65FDFpRr+4SfwkiUdlCF8WbluwfVk0ugV4/9qOh8ncVLvKj427/9
         XVF4Eyc1Fl+C3gfiUT44SOF/ZJv9lzqzrJCY5UvZHHBKatLnG6BxCoPHKfias0eQyKF+
         vgBWavDkKig8rqOMS46T+g4RTy79XgqY72rXZp2lEDfXQr+4GpuNtlhK/sUFVMOL53Rk
         W6SG1O4y/HVPE58fkuTDHSxC4Qd2OpGpXV+oZU7egJek9f4aetu9XucWxkBmHHYZnjfu
         GXmg==
X-Gm-Message-State: AOAM533gRNPQ+7o2BBAPAfQUsKf1YZIxmBuROu3/SD3VNSROfl6i0XXx
        zUXIrLJtDh+EvDBOZ85+xIAdrHX9qT9ym6oOmdeU3Q==
X-Google-Smtp-Source: ABdhPJz4Q7i8gRI29F+bX6HPgquBXNSajDtNgM4FV0xGjBlDJ0AVdjZe4YDyUFlVYcsvtNAexWmTrtfke0KRjJqBdBo=
X-Received: by 2002:a25:ba0e:: with SMTP id t14mr27840068ybg.49.1638585494982;
 Fri, 03 Dec 2021 18:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20211201150440.1088-1-sj@kernel.org> <20211201150440.1088-5-sj@kernel.org>
 <CAMZfGtUPSmquyMd70HtqFVvxU68kbTdYN1fJU8g35zeXHMJHVA@mail.gmail.com> <20211203124430.bd1879d382010270f4112324@linux-foundation.org>
In-Reply-To: <20211203124430.bd1879d382010270f4112324@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 4 Dec 2021 10:37:37 +0800
Message-ID: <CAMZfGtVO42xt5hwjGXHru3ghEi_EezrEzS22AW_x4uUYiAD9Zg@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/damon/vaddr: Remove an unnecessary warning message
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        brendanhiggins@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 4, 2021 at 4:44 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 3 Dec 2021 11:01:36 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > On Wed, Dec 1, 2021 at 11:05 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > The DAMON virtual address space monitoring primitive prints a warning
> > > message for wrong DAMOS action.  However, it is not essential as the
> > > code returns appropriate failure in the case.  This commit removes the
> > > message to make the log clean.
> > >
> > > Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
> >
> > I don't think there should be a Fixes tag since it's not a serious bug.
>
> "Fixes:" doesn't mean "backport to stable".  At least, not for MM
> patches.  Other subsystems do get their Fixes:-tagged patches
> automatically backported.
>

Got it. Thanks.
