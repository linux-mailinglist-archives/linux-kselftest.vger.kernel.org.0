Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A72068C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgFXABo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbgFXABn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 20:01:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C9C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 17:01:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so401696pgo.9
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLqWa8D4a1aW1RT9kraxn7fj5TtxyMRknVxZIyfvPbs=;
        b=DBQeiRGu/q1Yt+lss+Q+2dUx4pCfe+ephHr5um4LGMOurwGPtymSQEAhTJ91JQV0bt
         zmf6BHln++YUrrLsbJJuwB9YtNqqpVhnkQ0pNU07Xnc59mjwJtm8T5n09r0XuSo71lbt
         fcTkDrtuJjdDW81JL19V5hkYuKItL4j73afO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLqWa8D4a1aW1RT9kraxn7fj5TtxyMRknVxZIyfvPbs=;
        b=iCpvIzN3h0EK+nPn+ig45SCRgJpf4sMyFh2zxkcxQE789DLVPtrIf0WrXlU5Bzd7BC
         QRp8toPhCSJLtE5lmQWOzaPIh/UpgbPs+OvCEGZ529hwDaPknWJ68AEXVtHAv5Hyaj/R
         1LGAUwdooCD+M/2c8t3nWv7GJLb9tMwco3sibUE71u5hxxdijLNcx8n/bSfzKw8I0mbE
         fE9hr00w2A89v7fedcemhmqZBGIUCTjTlu8QVJdoiuTS3arebbeqB2Jl6rlxUzUkTSQV
         rGuUii726/zV9M0dF2y8blb4PJ098YJekTKT7bnLKuGqeN6tanJhCToTZprzSk6vM+JC
         ICrg==
X-Gm-Message-State: AOAM5328vBuv5ZRFVZ/gBovjoeLHeu43unlVYbCJ9wceuOerwCeAbmVU
        pIf+hLCOKy0b+qSeG6IZErluSg==
X-Google-Smtp-Source: ABdhPJwBxv8t7/01Ji74nGYpd4derLxt90CEgi39v4a5aHoq6nRlRjy+Rm7SzqsfF6j2yT8sZcQ3lA==
X-Received: by 2002:a62:1a87:: with SMTP id a129mr26864467pfa.95.1592956901676;
        Tue, 23 Jun 2020 17:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jz23sm3378905pjb.2.2020.06.23.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 17:01:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:01:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006231701.DACC6F2C9@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 23, 2020 at 04:32:12PM -0700, Randy Dunlap wrote:
> On 6/23/20 4:10 PM, Kees Cook wrote:
> > On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
> >> Hi Greg,
> >>
> >> Can you please apply these patches to your drivers/misc tree for LKDTM?
> >> It's mostly a collection of fixes and improvements and tweaks to the
> >> selftest integration.
> > 
> > Friendly ping -- we're past -rc2 now. :)
> > 
> > Thanks!
> > 
> > -Kees
> > 
> >>
> >> Thanks!
> >>
> >> -Kees
> >>
> >> Kees Cook (4):
> >>   lkdtm: Avoid more compiler optimizations for bad writes
> >>   lkdtm/heap: Avoid edge and middle of slabs
> >>   selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
> >>   lkdtm: Make arch-specific tests always available
> >>
> >>  drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
> >>  drivers/misc/lkdtm/heap.c               |  9 ++---
> >>  drivers/misc/lkdtm/lkdtm.h              |  2 --
> >>  drivers/misc/lkdtm/perms.c              | 22 ++++++++----
> >>  drivers/misc/lkdtm/usercopy.c           |  7 ++--
> >>  tools/testing/selftests/lkdtm/run.sh    |  6 ++++
> >>  tools/testing/selftests/lkdtm/tests.txt |  1 +
> >>  7 files changed, 56 insertions(+), 36 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> 
> >> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> 
> > True that, we can rip the file.
> 
> Has anyone fixed the uml build errors?

Oh, I thought that had nothing to do with the lkdtm changes? Should I
rip out that file and resend?

-- 
Kees Cook
