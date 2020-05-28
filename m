Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176361E6B9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406759AbgE1TsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406730AbgE1Try (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:47:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7CC08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:47:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g5so2586989pfm.10
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/FdgxgI19k7/RKqJ/1UKTtp/t1yUz4BSjmKYARom7w=;
        b=NhnoiyLyrHenDPN/ByLZft3pE/05o6EphRSK5zVl2eNUOny+2wX24yFoolbzQitLUx
         r1GJXMjbbm/uPWj11cJZ0AuerxLLigaZsPLeD6BjBI4nIQcZfUzdv3Ma2fJ9el4c2Mdf
         I2tbk9B6lqi1qJY5nBKMXroSqoQj+E4tNPXHZJyzOGOa40wcvmhJaOsVX2Dkjn6as5+N
         H9n79lJcVEPFG7rwcG4FcNl+zCwgaSH+NoOjN+mYTzMdNLwTXyLsQVmm1TUL2+SWydmQ
         a9S58luzSRtufXod/x4psb8i0Kyky1Fo7GHjE9FpMNuVMaz8XmjXJPtw2XlDn86Atmfn
         2yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/FdgxgI19k7/RKqJ/1UKTtp/t1yUz4BSjmKYARom7w=;
        b=qm9eSUrhXXko2G1SKE5O2VVcSmzxHY+XjSpS/G5TvmOC8EoVI87M4C0nzCxjci/gtr
         TJAO2aQGIPz7DijdsfJtVd11VzfIf6stvaTrOw8L3t8LcoekzpRIwJsgdhjq2WfYzxhy
         vV9s589LKMgn6/piwSCIHum+rSMcM5QVMnWn9q/kg96rhQdTm+iJogp+6fKJPQCwdZWO
         KR5vrkle8b8vdYsX0fQRet966n5mmCAZj1uvUuvCRlyaSgTGlJy8ndRLVEgqHc8tofbh
         WsYBtX6tkkFeP4D13GygjpNgVG0jzz+DN+iH0dTOcz0pB7J4D0fpjYqn688BGgtkAwEE
         +PFg==
X-Gm-Message-State: AOAM531xf5WNuLu8UUyExu/8FuN7wxhat0O4bB2+bzj/GKbB1E3lZfKu
        AQmWaeLlsCwyyExDTNbxMbs6AjJsnIqbG6ae3ClWAQ==
X-Google-Smtp-Source: ABdhPJwgEtpb6jI3FOheNRBghe6AUmRsRvAFRwYEW6C/h7VOF9DNYfEAHMINt1bf+zlknXXh4+o9UNQsHuK9Q3SImW8=
X-Received: by 2002:a62:8c42:: with SMTP id m63mr4739825pfd.106.1590695274111;
 Thu, 28 May 2020 12:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com> <1585313122-26441-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1585313122-26441-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:47:43 -0700
Message-ID: <CAFd5g46uNRwDnKHjukU2gBu6wM0kzBragaWBJigbfJkFuQvsFw@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 2/2] kunit: add support for named resources
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     shuah <shuah@kernel.org>,
        Patricia Alfonso <trishalfonso@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 5:46 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> The kunit resources API allows for custom initialization and
> cleanup code (init/fini); here a new resource add function sets
> the "struct kunit_resource" "name" field, and calls the standard
> add function.  Having a simple way to name resources is
> useful in cases such as multithreaded tests where a set of
> resources are shared among threads; a pointer to the
> "struct kunit *" test state then is all that is needed to
> retrieve and use named resources.  Support is provided to add,
> find and destroy named resources; the latter two are simply
> wrappers that use a "match-by-name" callback.
>
> If an attempt to add a resource with a name that already exists
> is made kunit_add_named_resource() will return -EEXIST.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

FYI, I already gave a reviewed-by for this commit back in v1, so:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
