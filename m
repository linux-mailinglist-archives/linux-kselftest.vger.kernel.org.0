Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743982B79A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 09:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKRIzg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 03:55:36 -0500
Received: from albireo.enyo.de ([37.24.231.21]:60374 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRIzg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 03:55:36 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kfJ8s-0000D4-23; Wed, 18 Nov 2020 08:48:42 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kfJ8s-0001IL-02; Wed, 18 Nov 2020 09:48:42 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 7/7] docs: Document Syscall User Dispatch
References: <20201118032840.3429268-1-krisman@collabora.com>
        <20201118032840.3429268-8-krisman@collabora.com>
Date:   Wed, 18 Nov 2020 09:48:41 +0100
In-Reply-To: <20201118032840.3429268-8-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Tue, 17 Nov 2020 22:28:40 -0500")
Message-ID: <875z63yrrq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Gabriel Krisman Bertazi:

> +Interface
> +---------
> +
> +A process can setup this mechanism on supported kernels
> +CONFIG_SYSCALL_USER_DISPATCH) by executing the following prctl:
> +
> +  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
> +
> +<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
> +disable the mechanism globally for that thread.  When
> +PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
> +
> +<offset> and <offset+length> delimit a closed memory region interval
> +from which syscalls are always executed directly, regardless of the
> +userspace selector.  This provides a fast path for the C library, which
> +includes the most common syscall dispatchers in the native code
> +applications, and also provides a way for the signal handler to return
> +without triggering a nested SIGSYS on (rt_)sigreturn.  Users of this
> +interface should make sure that at least the signal trampoline code is
> +included in this region. In addition, for syscalls that implement the
> +trampoline code on the vDSO, that trampoline is never intercepted.
> +
> +[selector] is a pointer to a char-sized region in the process memory
> +region, that provides a quick way to enable disable syscall redirection
> +thread-wide, without the need to invoke the kernel directly.  selector
> +can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
> +value should terminate the program with a SIGSYS.

Is this a process property or a task/thread property?  The last
paragraph says “thread-wide”, but the first paragraph says “process”.
