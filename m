Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C21A67A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgDMOOp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 10:14:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56957 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730372AbgDMOOp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 10:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586787282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pz4ecCGHpD54VRs30aCWNG0g9ZT3H7m50d0kjdfWfs=;
        b=BT8kkx8V53MnLDfjY2/H6exCCxn6rQ0L9/FXUzbCT2CHFJYmb4lQsLV9OxgVHQeZ+k4b//
        W08CfTXLcD1yZ28W9Eyo3w/jc9MSfveNjIajNVo936Jufa1OdTY8/I+Z4w8gn/iM3JbkEC
        Ww6c7Cw7YBiCrQS83BgRdRDZOcz2lCk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-ew7LhxwqM2ez-Y-Ai5_ZmQ-1; Mon, 13 Apr 2020 10:14:33 -0400
X-MC-Unique: ew7LhxwqM2ez-Y-Ai5_ZmQ-1
Received: by mail-qv1-f70.google.com with SMTP id v11so2779137qvw.5
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 07:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pz4ecCGHpD54VRs30aCWNG0g9ZT3H7m50d0kjdfWfs=;
        b=AwCIhBeXqCHhaJFo8YmnTZslAbzU6+esZv3aNv2I7K4kzC6Et6y0NvYhjF5GfVX+GL
         JZDI08lX/jwiih1B52Y4ulb9Mt41cIHIa8OgU/BEiP3AmlczorQgqbY7cZl7KxDhAkmz
         3isSjUJWlxsz/jqycGYlrlRa6Fuq/I0L4ffQiEYH1eHL4mVCGGXlL+T2E7pz7GYFNojS
         PJ1Zyx3ZQY3HMs/nnyOHDloVaxgWGhvD/tO9du3cpUCKQPQ56+J1gzSEDD6JlcRh0SDL
         qTA9xdS8M09KBQXR0avHUz/GNWc68zVPWY95YxfbVwUfoyTxMCKvfomKEo+WkoerlKzs
         O11g==
X-Gm-Message-State: AGi0PuZrQu09RW/sfsPCE9refzwl+a7Ig6/3zhHAr13ePaMSnMMD4UjJ
        5MGMWNh8M/473C5REfxzNK+YpL4MRkmH9QPzzaEWm1rNn/vA0RNKThZpNu/2IQXBJUwrhvG3BWZ
        cGwRIrwcTd/QFvHph2abN2bip2nI1
X-Received: by 2002:a37:bb01:: with SMTP id l1mr16169751qkf.37.1586787272943;
        Mon, 13 Apr 2020 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcyXUmdwZ9EVtC8gVeFjagGEC3vAwbmtSkkop0oHmZV9eVJO4cB8zuzUmSpI+KklOCOl2lAQ==
X-Received: by 2002:a37:bb01:: with SMTP id l1mr16169713qkf.37.1586787272633;
        Mon, 13 Apr 2020 07:14:32 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w2sm2374972qtv.42.2020.04.13.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:14:31 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:14:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: i386: selftests: vm: compaction_test: BUG: kernel NULL pointer
 dereference, address: 00000000
Message-ID: <20200413141429.GE38470@xz-x1>
References: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
 <20200412214150.GB38470@xz-x1>
 <CA+G9fYvARTCKjbfHYEbfOjtn_s7desuAToOF4g+Z_fztzZ-myw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYvARTCKjbfHYEbfOjtn_s7desuAToOF4g+Z_fztzZ-myw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 13, 2020 at 04:51:25PM +0530, Naresh Kamboju wrote:
> On Mon, 13 Apr 2020 at 03:12, Peter Xu <peterx@redhat.com> wrote:
> > And since this one is very easy to reproduce, I finally noticed that
> > we have wrongly enabled uffd-wp on x86_32, which is definely not going
> > to work... Because we'll use bit 2 of swap entry assuming that's the
> > uffd-wp bit, while that's part of swp offset on 32bit systems.
> >
> > Naresh, could you try whether below change fixes the issue for you?
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 8d078642b4be..7ac524d1316e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -149,7 +149,7 @@ config X86
> >         select HAVE_ARCH_TRACEHOOK
> >         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >         select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
> > -       select HAVE_ARCH_USERFAULTFD_WP         if USERFAULTFD
> > +       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
> >         select HAVE_ARCH_VMAP_STACK             if X86_64
> >         select HAVE_ARCH_WITHIN_STACK_FRAMES
> >         select HAVE_ASM_MODVERSIONS
> >
> 
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> The above patch tested and did not notice the crash.
> + cd /opt/kselftests/default-in-kernel/vm/
> + ./compaction_test
> No of huge pages allocated = 297
> + ./compaction_test
> [   46.059785] kauditd_printk_skb: 15 callbacks suppressed
> [   46.059786] audit: type=1334 audit(1586776582.927:25): prog-id=17 op=UNLOAD
> [   46.071997] audit: type=1334 audit(1586776582.927:26): prog-id=16 op=UNLOAD
> No of huge pages allocated = 160
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/1362495#L1308
> 
> Build artifacts.
> https://builds.tuxbuild.com/w0ol7cCsGan0wzPp7bNqkg/

Thanks!  I'll post a formal patch soon.

-- 
Peter Xu

