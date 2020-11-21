Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9A2BBACF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Nov 2020 01:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKUAYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Nov 2020 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgKUAYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Nov 2020 19:24:06 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF729C061A47
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so3351072plr.7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=Ufe7L8IQ5v/I7T8tt4gsPuDnhpRA272mwrcmv9XewlpzYhDUXW2jqTxD1hslQrth5g
         eDmR9NJxf5+la/wDoV9T4gAXWEe4Q7fIOQHWwX9t1BmbdmwqQejV3fWvEwLhxFduJBYM
         xKz63gHciuxUu58RjUr5pEfsRqThUo8eAQyEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=F3LyBb8gRMRrdk/0gJPRWMwUD9lYHZ4fFrZctixVNWinYibNhHGTd6vZoCpnzr4Y85
         9zZdkLYav5gynECySxedD3p43ytxcLI8vXAhX7oPzL1gjMlnMDcuNrpGMG8H/BSNCpTp
         jJAlUrWJ9Fh6nu3KlGFHrmvqfV11eZB+Db0PY8bIVdG0FhLdPwcJS2853ig9b4KVMMoM
         A0OTXP5/WRzlGRhaNnLIlEuYZk4qihoJTz6Jl1ueAj/s1lnBrbRGQ1UYdQAASnynyxvo
         sLs2bP4ipANgDVur3Jz/HXTRWX7nUSeugILuXgF1lXoGIzZ7BQRjVbFZEeI5iBR8ynuo
         cmsw==
X-Gm-Message-State: AOAM530gilZRHXZTWegNn5DT1Vjbqqgox8jID4viBH/fjsbdLPBNIaeL
        XVU8uj9EAU3fg3SnJEdkVLs5Zw==
X-Google-Smtp-Source: ABdhPJzjpCFLnLrUalvrO32PJt+53p5u2neas7NkD6ncxIwW6NEts5vwrkfDaOU5cA3xZBMV+Vy9Gg==
X-Received: by 2002:a17:902:8e81:b029:d9:f1a8:54ac with SMTP id bg1-20020a1709028e81b02900d9f1a854acmr2502635plb.69.1605918245442;
        Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm5324184pfc.165.2020.11.20.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:24:04 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:24:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, christian.brauner@ubuntu.com,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/7] Syscall User Dispatch
Message-ID: <202011201623.FBFA4471@keescook>
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 19, 2020 at 01:38:27PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:28:33PM -0500, Gabriel Krisman Bertazi wrote:
> > Gabriel Krisman Bertazi (7):
> >   x86: vdso: Expose sigreturn address on vdso to the kernel
> >   signal: Expose SYS_USER_DISPATCH si_code type
> >   kernel: Implement selective syscall userspace redirection
> >   entry: Support Syscall User Dispatch on common syscall entry
> >   selftests: Add kselftest for syscall user dispatch
> >   selftests: Add benchmark for syscall user dispatch
> >   docs: Document Syscall User Dispatch
> 
> Aside from the one little nit this looks good to me.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Agreed, and thank you Gabriel for the SYSCALL_WORK series too. :) That's
so nice to have!

-- 
Kees Cook
