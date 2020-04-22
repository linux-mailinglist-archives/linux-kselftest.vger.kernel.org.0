Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398301B4D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVTh0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgDVThZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 15:37:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E78C03C1AA
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 12:37:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so1383600pjw.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thj/2XbdYGnd45UIBdb/K+3rI5B7+sFedV8xUcZtoIk=;
        b=hjLN3SkBerIBxHjnUQT2SUdnPFkD5drDR7f01SNZeaVS5xCzOTm2Iw/uPQw0+n2kh7
         jsKpIAVwKOGRCgjgMw/kmqxcBKxFruKH3j4oViG3Lp4+/bylkEcV5MGwXnraTc/5E2+K
         8WpnqkGYX7jfV1Kpy7gGcFY8NiSDMHbDzpSxsBS86so8nC1DmOggGYElglKJ+Yyn/khT
         ufvafUdQXotrdBYbnzrBKRVjJlhEej4Wy+KXzMfpivUv+5PlvcEY0WDkcYWu8ABwvs37
         rzckJ1YH6TWZPcuJ2ez4yTBaiRbiLHFul41etDggimj+2Oqp7ufBxVchXmDZV6YkBrZz
         RhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thj/2XbdYGnd45UIBdb/K+3rI5B7+sFedV8xUcZtoIk=;
        b=StVktZsjiJcD8uaR/Odc56q0XHehiQfm+kDQYOP5aQFOn85eKSPml4sLIMHowK/Y/3
         +6bP9DOF5rmQmMiT58XqkNHRvMyS0iuK3Mv/Wy+oQCRa1MDo0qRbTtUu9SgBQxYi/u4s
         pnEguD/GIc4DPR9SOYVvNbKkcJ+p4UCP0hxQxAHuLPqHDuUzMttXSvTIBubZEqGmLHi8
         ZiOnaZBW1m5n0VR4HZ28V438OX2tYkthrkjLGL+3p00f73NiDVM0FBJ3VDBaszGvSxOJ
         gFirVr/mUUnwAaghqr5Ac4tlfPPgAZDrUPZVDByrElENxkATAD7fRri8UhbKLrdAL74+
         SI7w==
X-Gm-Message-State: AGi0PubipoCXOe88KA9sbdgP8XemT9mbzSFk4gnsDPiTIWisTHHfz91M
        fnz8aZqbW9WgQ61UrNyZQDjqe4gzdKfBGZMFBqpBjg==
X-Google-Smtp-Source: APiQypILUs95LlF366DopmiBMr297DXFzLN0P4OH0q2ar06Kpx75oV9mi9hpsegNJrmJAlexcg4Yh//bFKSJ+u3kj6I=
X-Received: by 2002:a17:90a:3568:: with SMTP id q95mr341933pjb.47.1587584244759;
 Wed, 22 Apr 2020 12:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com> <alpine.LRH.2.21.2004171103160.32364@localhost>
 <CANpmjNNsSX+C1oXezj+WuW-DQpGJ2ETvqH6n6XryVwmKB0phxw@mail.gmail.com>
In-Reply-To: <CANpmjNNsSX+C1oXezj+WuW-DQpGJ2ETvqH6n6XryVwmKB0phxw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 22 Apr 2020 12:37:13 -0700
Message-ID: <CAFd5g45ykCmhqG_OhOnSXt5JfEbsDRfAMUUF=5QV1BrHxTPG-g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Marco Elver <elver@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 22, 2020 at 4:05 AM Marco Elver <elver@google.com> wrote:
>
> On Fri, 17 Apr 2020 at 12:03, Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Thu, 16 Apr 2020, Marco Elver wrote:
> >
> > > Add missing newline, as otherwise flushing of the final summary message
> > > to the console log can be delayed.
> > >
> > > Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Thanks for finding/fixing this!
> >
> > Alan
> >
> > > ---
> > >  lib/kunit/test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Which tree will pick this up? I cannot yet see this in -next.

This will be picked up by kselftest/kunit:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit
