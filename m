Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4842F23C05B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHDUBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHDUBn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 16:01:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B0C061757
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 13:01:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so12975838pfx.13
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGNEd3Lp8fYqN2xdgBLfWZRJYT3O7WzzWQnO9+HSxQk=;
        b=GflFL1WYfQVzQD4fL/T4jBZKh7JPXp0BjIk5sL7JE/3ZK5A3sV3xZbh/yfGVUE0qsP
         E8yzX9X+hsi/jPgMOXv5KyzdGbchiQfB+e6evv0M2SBqQeIpPvQCBY7+peu0nO4BLYGa
         rdDx5ycRqouMDJsTRzYND+Tolb/oVleKFhJtjOjIQORoJT/S/6+FUy7Kqq7ICEsZ9Bbl
         0OVwDgiwpMSYG30M2rS3A8VLQOVW8i0aLpgdwxcBGN+zSp9A98eH6F083YoTKVXDwSul
         ItGmc4NUog48QtQq1C+v7I7SDLF2999IlOerOmbpf1fsDJ45bAYCsHylk7gjqEPEQWPz
         rsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGNEd3Lp8fYqN2xdgBLfWZRJYT3O7WzzWQnO9+HSxQk=;
        b=kSCKOMCK9tPLFrNSKCJky+AjCquvJ9K7EgUaUOURNxYaYRoC+o3X192j3EquCaQtzf
         piedNvMbL3QE6HqoU/8/0mF1SjVWZp34DX7ORKilvVJhyLBCbgT5Acb5e8WgY+eZUL1x
         9GP+2QF9x7H5qZrz192LH5pRv2EbDccwKfxp/k6mg4A3h1tLNujdKRrs8uFsoXkJtpv/
         ygF8Yjur/fOr23hsvtTlSaYQW7LdsKbpBTXbcs/V3nAV2BBKVT7OzkS2MIvS9o2fLlAd
         IU1SKd54HP3vkFPtk+73sVrKLZn7QHvAKYBWvUNFbtPrSd7SSGoUP9fePAbVrMsf6ZgT
         UtUQ==
X-Gm-Message-State: AOAM530Uu43SqysyES/l679ks/gNYwKCytLuCDy/EtUuTsVOLL492MmJ
        fYhUbvBeDHW3BvKjwtQZBvNm6d8n7RTdd15OSRAmjA==
X-Google-Smtp-Source: ABdhPJxibV8WdZD4fajbOd68sN3rQCbVSctPTRSdThTAPzTdQ5zE6A2a16V/r2RcvRmnAUUEZc+Zdf2C7tegXZnxAGI=
X-Received: by 2002:a62:1d0e:: with SMTP id d14mr46991pfd.106.1596571302143;
 Tue, 04 Aug 2020 13:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com> <202006261442.5C245709@keescook>
In-Reply-To: <202006261442.5C245709@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Aug 2020 13:01:30 -0700
Message-ID: <CAFd5g46auR=OgQ4j=P=KH7GDerW-SkB8aFGehuYkmgJ2Z+jGCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 2:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.

Sorry it took so long to reply. I got sucked into some other stuff again.

> So, the new section looks fine to me (modulo the INIT_DATA change). The
> plumbing to start the tests, though, I think is redundant. Why not just
> add a sysctl that starts all known tests?

We already have that; however, we use debugfs to start the tests -
same difference. I just find it convenient to not have to build and
then maintain a userland for each architecture. It's also really nice
that KUnit "just works out of the box" - you don't have to download
anything other than the kernel source, and you don't need to do any
steps outside of just run "kuit.py run". That seems like a big
advantage to me.

> That way you don't need the plumbing into init/main.c, and you can have
> a mode where builtin tests can be started on a fully booted system too.
>
> i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
> "echo start > /proc/sys/kernel/kunit"
>
> And instead of the kunit-specific halt/reboot stuff, how about moving
> /proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
> do:
>
> sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

I think it might be harder to make a case for the reboot stuff without
the stuff I am working on outside of this patchset. I think I will
probably drop that patch from this patchset and reintroduce it later.
