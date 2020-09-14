Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DC269685
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 22:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgINU11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 16:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgINUUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 16:20:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FAFC061353
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 13:20:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so522523pfn.8
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qEpgx25Jil12k55o2aeOued7nizFpjWJtIRv7RIrrgA=;
        b=oF8La/idpVXp4VfUhwPPRt9IR/o1RPig2nmeyh8YrhsmHCRvroMtluVJ4o5U4K8AFY
         VbIWbH4IFHNJ2TFc1OFb1H1xtGH98TXoNvfhyYpAj/BvKsAp8ayWj8ANKhK3ots4YK+n
         3o6kijVtSkUUK+lTSVOjqNR35ksbqN8yyS7c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qEpgx25Jil12k55o2aeOued7nizFpjWJtIRv7RIrrgA=;
        b=ROlBlG8Ph44M0PsaN8tfca+nFvsJpyKmKeRWV7+C/3HSl7yhABY3+bo67eCnueNyaq
         uACIqhb2NKzsHBd2XQOZtTkcE9S3sTXZ+OuDInsspj0cfiMDld6P/OFtNEbUUnlEhlFt
         fk5jeMzm1ViKa2AgzwtKeUUfWh7fCBfYHnr0jSTQQy0XwoxjCvlZZnLDG31bfJsHIpkn
         b2gDKpSaB8me3po8k69xhUvpECfuSa2yAwynAESJiuUfspPWttPc7NjqNfp9+UxIzsJB
         gm7IjAgKrd+4szodHs4273XVGHHQ93+2jmErPvd4Y7qTWKAE1g2Fk34GRxjHPjJR+JfL
         Lc0w==
X-Gm-Message-State: AOAM530eykMftZDtyS48MhW6APe+UUd7/UrObxvHKaTeZgyCVbl2NTiW
        pZd2wPjidiW4cGtuL6u9UTsgQQ==
X-Google-Smtp-Source: ABdhPJwzC+6nA3eNHS7MaPMnpM3EiFR22Z/iXFg5GeiL+THEWa6N+D4e+5+NMXy6erXWVC35l1hZ8Q==
X-Received: by 2002:a63:471b:: with SMTP id u27mr12121165pga.139.1600114835739;
        Mon, 14 Sep 2020 13:20:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm10068865pjy.37.2020.09.14.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:20:34 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:20:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/15] selftests/seccomp: powerpc: Set syscall return
 during ptrace syscall exit
Message-ID: <202009141319.FC017B0DB@keescook>
References: <20200912110820.597135-1-keescook@chromium.org>
 <20200912110820.597135-14-keescook@chromium.org>
 <87zh5sq59a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh5sq59a.fsf@mpe.ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 14, 2020 at 03:47:13PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Some archs (like ppc) only support changing the return code during
> > syscall exit when ptrace is used. As the syscall number might not
> > be available anymore during syscall exit, it needs to be saved
> > during syscall enter. Adjust the ptrace tests to do this.
> 
> I'm not that across all the fixture stuff, but if I'm reading it right
> you're now calling change_syscall() on both entry and exit for all
> arches.

Correct.

> That should work, but it no longer tests changing the return code on
> entry on the arches that support it, which seems like a backward step?

That's a good point. I wouldn't be in a position to notice a regression
for the other architectures. I will refactor this one...

-- 
Kees Cook
