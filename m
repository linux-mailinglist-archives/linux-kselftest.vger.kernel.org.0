Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847562CB08F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLAW6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 17:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgLAW6I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 17:58:08 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE5C0613D4
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Dec 2020 14:57:28 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q22so1896523pfk.12
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Dec 2020 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mfm81XCcJKf/0ns4PxId/S79la9obThZUGZ2CR40z18=;
        b=Jm92V4Wy4ZXFTfDxQFr2dJCmhE7bpPZIUHYELek8z1/CO4Y1WoJrDTqgi8FkAEInXa
         lZ8OYHo9fmRtwdI1fNdN9qvjJ4UPbaCbLp4KhDigzIz8tSd/xdGv5/CAllauIu03Gk1o
         EtAeBbwpM4V7tbzqj/K9PdycneNJnRV93XkKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mfm81XCcJKf/0ns4PxId/S79la9obThZUGZ2CR40z18=;
        b=NHWe7cgRIRQBj6+BoTNeWiE1ip6/f57QQqs27gqcyh2fzoKT7xTPfIVj2vHbY83hDM
         CDQ3xhWMgLmIH2YKBs4d9P3xiMp51Av+HcogWh/g0FS0UptBCEV6YJ6eqlJdRGQ+OSAa
         zzFfULSYEwnwg9cJyZcikQRkRVrmb7a1IH+u+e7DMB/yvMhBYyNOFH7QTgHDwl+urqXs
         rreVGQ2Hmm9nm6gNrFhvuiLXokhODNlbUHtkXgdfWtuBuZwpr0vmfeN3HkPy5mNmPQHs
         ItQ8DaXNXjpdPARBADdYtRJiDzKBc0M8DbNK9MWd0DG4z7kM/87dcXqM+RhwatB0uape
         a64g==
X-Gm-Message-State: AOAM5303Jxq+zsyAywGbbLK9mvJX334haQQxydQyZCgQiGRDEsZoGA+M
        pKXrwpXZHQ7KCHzUhEXmiI83pQ==
X-Google-Smtp-Source: ABdhPJxC8oUUVRC4p7tFIkPqeMj8OD4Q0SDjNXzQn9WmurpEcptKRx4Nk7igggK2YMCx9lYijFntnw==
X-Received: by 2002:a62:8685:0:b029:197:f766:b135 with SMTP id x127-20020a6286850000b0290197f766b135mr4745230pfd.0.1606863447614;
        Tue, 01 Dec 2020 14:57:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21sm721946pfc.151.2020.12.01.14.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:57:26 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:57:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, gofmanp@gmail.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 3/7] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202012011457.DAA0F0F5@keescook>
References: <20201127193238.821364-1-krisman@collabora.com>
 <20201127193238.821364-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127193238.821364-4-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 27, 2020 at 02:32:34PM -0500, Gabriel Krisman Bertazi wrote:
> Introduce a mechanism to quickly disable/enable syscall handling for a
> specific process and redirect to userspace via SIGSYS.  This is useful
> for processes with parts that require syscall redirection and parts that
> don't, but who need to perform this boundary crossing really fast,
> without paying the cost of a system call to reconfigure syscall handling
> on each boundary transition.  This is particularly important for Windows
> games running over Wine.
> 
> The proposed interface looks like this:
> 
>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <off>, <length>, [selector])
> 
> The range [<offset>,<offset>+<length>) is a part of the process memory
> map that is allowed to by-pass the redirection code and dispatch
> syscalls directly, such that in fast paths a process doesn't need to
> disable the trap nor the kernel has to check the selector.  This is
> essential to return from SIGSYS to a blocked area without triggering
> another SIGSYS from rt_sigreturn.
> 
> selector is an optional pointer to a char-sized userspace memory region
> that has a key switch for the mechanism. This key switch is set to
> either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
> redirection without calling the kernel.
> 
> The feature is meant to be set per-thread and it is disabled on
> fork/clone/execv.
> 
> Internally, this doesn't add overhead to the syscall hot path, and it
> requires very little per-architecture support.  I avoided using seccomp,
> even though it duplicates some functionality, due to previous feedback
> that maybe it shouldn't mix with seccomp since it is not a security
> mechanism.  And obviously, this should never be considered a security
> mechanism, since any part of the program can by-pass it by using the
> syscall dispatcher.
> 
> For the sysinfo benchmark, which measures the overhead added to
> executing a native syscall that doesn't require interception, the
> overhead using only the direct dispatcher region to issue syscalls is
> pretty much irrelevant.  The overhead of using the selector goes around
> 40ns for a native (unredirected) syscall in my system, and it is (as
> expected) dominated by the supervisor-mode user-address access.  In
> fact, with SMAP off, the overhead is consistently less than 5ns on my
> test box.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Paul Gofman <gofmanp@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
