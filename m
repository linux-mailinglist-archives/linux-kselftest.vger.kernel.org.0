Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABB73F24B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 04:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhHTCVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 22:21:24 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48592 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHTCVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 22:21:24 -0400
X-Greylist: delayed 93332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2021 22:21:23 EDT
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17K2KYWV022187;
        Fri, 20 Aug 2021 11:20:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17K2KYWV022187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629426034;
        bh=xcvwwp1fH+FfoHwEOnlCxdAg+tWWyCWf39a9BIwFHi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJ5bjqn0Bnz6iLhRBuiYLxj6BhD1AWRem/1T/wIV42yCXyq2GIy2QxLh2qmVXbN2E
         i3tdsSRRU3GmkDutM3B6vOTyl7yv2rshN1RGLc4cvr/HFZ32ER6nZW2A6LhXq5OsJ0
         jKeTdCqHD8o7Go5/n14I79jx7YShiMW3hWGwPn9YOcA54pGvTG0JG4GF3W2g9lusGD
         hLYT6ZEknEFoL8vK/YSuexFNgyA7ok00zg2iicTT8GT6D5fvCXCGayUNq0rBo1ViSt
         wb5gf1drCY29jpzO/Rpnukvxa56tYVrkaKvCsqmHN/Y+Ou+SuqR/C6fwaLlGVXUfV/
         wZlnvc9Qi3xHw==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id k19so7298275pfc.11;
        Thu, 19 Aug 2021 19:20:34 -0700 (PDT)
X-Gm-Message-State: AOAM530Ql0vM8zBSbkVJ76vYybWLq1l99nWdAlFKsEtWd3excLxCWysH
        qvtDf8DhX0pe8kfWy/xqjdp4eqYnyRa+UZ8DelU=
X-Google-Smtp-Source: ABdhPJwwpfo9cG34bwOUVjm/o5GBNwjRvwVSL9CK3l6EKiz2bX+uRE8RDk7wl/oj+cBWxC/WECsrKWsncCDRLxZf9/Q=
X-Received: by 2002:aa7:94ac:0:b0:3e0:f21a:e6ff with SMTP id
 a12-20020aa794ac000000b003e0f21ae6ffmr16926073pfl.76.1629426033785; Thu, 19
 Aug 2021 19:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210818154646.925351-1-efremov@linux.com> <20210818154646.925351-3-efremov@linux.com>
 <CAK7LNASTa+_d17wF6NW6GHC7Y+_RrXYZuo0MzzbsNnaRn8KJuQ@mail.gmail.com> <e90603ee-61e0-4530-34dc-087e40c94aa1@linux.com>
In-Reply-To: <e90603ee-61e0-4530-34dc-087e40c94aa1@linux.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 20 Aug 2021 11:19:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKDO1-g7At8q+ivCHm2aDNGupHWoqAt3NRwNTShggeFQ@mail.gmail.com>
Message-ID: <CAK7LNARKDO1-g7At8q+ivCHm2aDNGupHWoqAt3NRwNTShggeFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] gen_initramfs.sh: use absolute path for gen_init_cpio
To:     Denis Efremov <efremov@linux.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 20, 2021 at 5:51 AM Denis Efremov <efremov@linux.com> wrote:
>
>
>
> On 8/19/21 3:24 AM, Masahiro Yamada wrote:
> > On Thu, Aug 19, 2021 at 12:47 AM Denis Efremov <efremov@linux.com> wrote:
> >>
> >> Use absolute path to call gen_init_cpio. This allows one
> >> to use gen_initramfs.sh from any directory.
> >
> > I do not mind this, but $(dirname "$0")
> > is not necessarily an absolute path, is it?
> >
> >
> > I added test code:
> >
> >    echo dirname is $(dirname $0)
> >
> > in this script, and I saw
> >
> >    dirname is usr
>
> Oh, sorry, commit message is wrong. Would that be ok for you if I will change
> it in v2 to something like:
>
> Prepend gen_init_cpio call with the same path as gen_initramfs.sh called. This
> allows one to use gen_initramfs.sh from any directory, not only from the
> kernel's topdir.


I am fine with it.

This patch is prefixed with 2/5, so I assume
you expect another person to pick up
the entire series.

With the commit message updated,

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>





> >
> >
> >
> >
> >>
> >> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >> Signed-off-by: Denis Efremov <efremov@linux.com>
> >> ---
> >>  usr/gen_initramfs.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> >> index 63476bb70b41..2e4a86181c79 100755
> >> --- a/usr/gen_initramfs.sh
> >> +++ b/usr/gen_initramfs.sh
> >> @@ -244,4 +244,4 @@ if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> >>                 timestamp="-t $timestamp"
> >>         fi
> >>  fi
> >> -usr/gen_init_cpio $timestamp $cpio_list > $output
> >> +"$(dirname "$0")"/gen_init_cpio $timestamp $cpio_list > $output
> >> --
> >> 2.31.1
> >>
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >



-- 
Best Regards
Masahiro Yamada
