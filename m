Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9F2CB079
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 23:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgLAWxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 17:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLAWxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 17:53:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC4C0613CF;
        Tue,  1 Dec 2020 14:53:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606863187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgZGODn285I66J8L4GvbT1qQkmKT/v8XbJlr6izRTLE=;
        b=4ye6Z4KlvJ5qQ5e6FxUs5D46elQxx2dkpqnxyjzngm47Sjliwx+UggMY/SZx6WqtZIgv4E
        Zln2cp7hsd7soJ0kewekcccXZZ09u89CT6NhBrnvApMfIAoNbZzVkDc96jO1jIFSLnUDZb
        fsozrv233+0HplMgX0iipn6SPepjckQTzPB9jE/mapByX8FK3WuOMvz24O/l624gKR7QMg
        42bNa3LW2+FzJA3Hdr5fdKvki3QaX7SN4vmEJdKAb4OB31XEVHe2rIlmDTlRziCdy7oCTJ
        Q2KOKySWJiM3HEMxwidRTBl5xdEHQAGcgmGDDCKHNsP+G7u9U+UvpLdP61hBwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606863187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgZGODn285I66J8L4GvbT1qQkmKT/v8XbJlr6izRTLE=;
        b=g+ac3s3Ylgc621GOUHtTePBTk73TOW5QZ2fc4BThRNc4K3E+KCtT6bg4NS5w9lfDswsp7h
        WxsCMOQu5lSltZAQ==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        keescook@chromium.org
Cc:     gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v8 7/7] docs: Document Syscall User Dispatch
In-Reply-To: <20201127193238.821364-8-krisman@collabora.com>
References: <20201127193238.821364-1-krisman@collabora.com> <20201127193238.821364-8-krisman@collabora.com>
Date:   Tue, 01 Dec 2020 23:53:06 +0100
Message-ID: <87a6uxf8a5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 27 2020 at 14:32, Gabriel Krisman Bertazi wrote:
> +Compatibility layers like Wine need a way to efficiently emulate system
> +calls of only a part of their process - the part that has the
> +incompatible code - while being able to execute native syscalls without
> +a high performance penalty on the native part of the process.  Seccomp
> +falls short on this task, since it has limited support to efficiently
> +filter syscalls based on memory regions, and it doesn't support removing
> +filters.  Therefore a new mechanism is necessary.
> +
> +Syscall User Dispatch brings the filtering of the syscall dispatcher
> +address back to userspace.  The application is in control of a flip
> +switch, indicating the current personality of the process.  A
> +multiple-personality application can then flip the switch without
> +invoking the kernel, when crossing the compatibility layer API
> +boundaries, to enable/disable the syscall redirection and execute
> +syscalls directly (disabled) or send them to be emulated in userspace
> +through a SIGSYS.
> +
> +The goal of this design is to provide very quick compatibility layer
> +boundary crosses, which is achieved by not executing a syscall to change
> +personality every time the compatibility layer executes.  Instead, a
> +userspace memory region exposed to the kernel indicates the current
> +personality, and the application simply modifies that variable to
> +configure the mechanism.
> +
> +There is a relatively high cost associated with handling signals on most
> +architectures, like x86, but at least for Wine, syscalls issued by
> +native Windows code are currently not known to be a performance problem,
> +since they are quite rare, at least for modern gaming applications.
> +
> +Since this mechanism is designed to capture syscalls issued by
> +non-native applications, it must function on syscalls whose invocation
> +ABI is completely unexpected to Linux.  Syscall User Dispatch, therefore
> +doesn't rely on any of the syscall ABI to make the filtering.  It uses
> +only the syscall dispatcher address and the userspace key.

I think this lacks information about the non-visiblity of these
syscalls. Something like this:

  As the ABI of these intercepted syscalls is unknown to Linux, these
  syscalls are not instrumentable via ptrace or the syscall tracepoints.

I'll add that unless someone objects or comes up with better wording
before I apply the lot tomorrow morning.

Thanks,

        tglx
