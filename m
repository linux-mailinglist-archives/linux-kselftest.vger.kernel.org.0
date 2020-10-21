Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5B29470E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411836AbgJUDuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 23:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406836AbgJUDuP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 23:50:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAAC0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 20:50:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so953746ljj.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/mlH7Rkpa560PVMbUdTwC6pWnOxYOo+/fb/Tvvof+c=;
        b=VDLrprWiZQP1zgfYnCdWehDecFvFE8lLk2598g65QwFqRqjJuAbNrrsyUbHO3TBBiA
         RNeEvd75eXYxluuk+Cu/HNJrmvtIQzlDNm7VEbC7jTnP5bVTXKpvnrRvr7/bAVwBS91N
         /NvldJ79ishaAK9RU5azOKXGhwt5Kq6uWfg+atxycc3yqJ3RTZKrRPuRNVkeGtOBakA2
         a//YGod/Ht5R29AqDJTt/yE1D0np2h2h2RA5SjOEMuepkEeG5Lqp45fOTjSrv6lxtp9Y
         NWdkX7ClsfOqlN0kQmn7kX5jxGTJu8V3XEiTl7WEHSvgM493TBWo9XOqJZDXH5SIh4Wo
         RT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/mlH7Rkpa560PVMbUdTwC6pWnOxYOo+/fb/Tvvof+c=;
        b=B8KF133r9LesyOldn9UW7YtfIClHSblhUoRnFINf5Nteq8SW+xfpVWa8DtK4XCMD/O
         Len9kq51E+S46Dh1HsIF973UEWBvJYZEJHQq2d+Is41pa4qmqSs9Br8bSYeWmdjLDSZo
         fgOAdIxlUCvMLWA4z66sy9LtrUBL6SbR4kH7pkhc7MrtgAEzfkBWRcjuC13nKcijfzIU
         yjAC7mR1bHxunCO1ig/APVp2wpoc67QATocFBPNPP8AdTb+R38G7uyNqEX5jlP6fOe2j
         G8+QKRG6fKrautfcTptov66egZWc7k/vctZD80rz0yccMOxKOtw5NhhJBupL/cMJ91ya
         WCpQ==
X-Gm-Message-State: AOAM530CIl/GC7t93z2N9DGi2u+zkk1zvcwdSkCHblS0URJsWJNiUP1O
        Iri6ouf9Rx5GKzEhXuQpLQWO37B2NUeH4yLJcpAdJa0/6eyUEw==
X-Google-Smtp-Source: ABdhPJwp/7M/XgPSYhhApxLoSbfNbAEmtcui4MpeS5LXnKrtmlOBsQfsmhZEIWsjp4lufL41ROXzGdDWeIK5Oyx0wtU=
X-Received: by 2002:a2e:7c0f:: with SMTP id x15mr412496ljc.401.1603252213693;
 Tue, 20 Oct 2020 20:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201020055856.1270482-1-davidgow@google.com> <87d01die4o.fsf@mail.parknet.co.jp>
In-Reply-To: <87d01die4o.fsf@mail.parknet.co.jp>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Oct 2020 11:50:02 +0800
Message-ID: <CABVgOSkQRvRSr-c1FKG+GDr5ewV+FJ-unZbtNvQLayoT6FmBtQ@mail.gmail.com>
Subject: Re: [PATCH v2] fat: Add KUnit tests for checksums and timestamps
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 20, 2020 at 2:51 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> David Gow <davidgow@google.com> writes:
>
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index f1b2a1fc2a6a..445ad3542e74 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -229,6 +229,7 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
> >               ts->tv_nsec = 0;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(fat_time_fat2unix);
>
> Hm, can this export only if FAT_KUNIT_TEST is builtin or module (maybe
> #if IS_ENABLED(...))? And #if will also be worked as the comment too.
>

That's possible, but I'd prefer to export it unconditionally for two reasons:
1. It'd make it possible to build the fat_test module without having
to rebuild the whole kernel/fat.
2. It'd be consistent with fat_time_unix2fat(), which is exported for
use in vfat/msdos anyway.

Neither of those are dealbreakers, though, so if you'd still prefer
this to be behind an ifdef, I'll change it.

-- David
