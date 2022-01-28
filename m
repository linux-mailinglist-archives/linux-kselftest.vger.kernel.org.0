Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E949F5BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiA1I41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 03:56:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41160 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA1I41 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 03:56:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D1D61DA1;
        Fri, 28 Jan 2022 08:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B747C340E0;
        Fri, 28 Jan 2022 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360186;
        bh=nmpe7nogaTvdubctIwwawVdMI9ZoBq5WqV4ZfNn8rx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNkzJWSr05Kni4e9a6Gi8iS86I6Y+xKD4TCUBUudzs1VuNBrXMRsS/0IHHpeoayLO
         s14bBQpfNVHrc71iIZp9eSDdOytEECV987X26Km575N486Ql2OrM2a+ScE4VFg34w3
         zJmgGoWNkrBOOXK30LSuYZ7aOWVYFibrsWjXM0XZSogbWvTspS3sVEJjbJJ5gu48rC
         5+3E5QILB/1Z0UKv/su3LgBUj2o3r79VRFhWyAmwwIB4D7oxYNQir7AkrZ8yAj4Bda
         DQdKsGC8/YHJoBznLZQPUevkSBEqyBHIiYDymONdHyEQ1JpWOvgXEY3Zv5u2CzmOjz
         7btnhZD2fIT7w==
Date:   Fri, 28 Jan 2022 09:56:16 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] pidfd: fix test failure due to stack overflow on some
 arches
Message-ID: <20220128085616.tnsowlg5iff6ofm4@wittgenstein>
References: <20220127212951.3604667-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220127212951.3604667-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 01:29:51PM -0800, Axel Rasmussen wrote:
> When running the pidfd_fdinfo_test on arm64, it fails for me. After some
> digging, the reason is that the child exits due to SIGBUS, because it
> overflows the 1024 byte stack we've reserved for it.
> 
> To fix the issue, increase the stack size to 8192 bytes (this number is
> somewhat arbitrary, and was arrived at through experimentation -- I kept
> doubling until the failure no longer occurred).
> 
> Also, let's make the issue easier to debug. wait_for_pid() returns an
> ambiguous value: it may return -1 in all of these cases:
> 
> 1. waitpid() itself returned -1
> 2. waitpid() returned success, but we found !WIFEXITED(status).
> 3. The child process exited, but it did so with a -1 exit code.
> 
> There's no way for the caller to tell the difference. So, at least log
> which occurred, so the test runner can debug things.
> 
> While debugging this, I found that we had !WIFEXITED(), because the
> child exited due to a signal. This seems like a reasonably common case,
> so also print out whether or not we have WIFSIGNALED(), and the
> associated WTERMSIG() (if any). This lets us see the SIGBUS I'm fixing
> clearly when it occurs.
> 
> Finally, I'm suspicious of allocating the child's stack on our stack.
> man clone(2) suggests that the correct way to do this is with mmap(),
> and in particular by setting MAP_STACK. So, switch to doing it that way
> instead.

Heh, yes. :)

commit 99c3a000279919cc4875c9dfa9c3ebb41ed8773e
Author: Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Thu Nov 14 12:19:21 2019 +0100

    clone.2: Allocate child's stack using mmap(2) rather than malloc(3)

    Christian Brauner suggested mmap(MAP_STACKED), rather than
    malloc(), as the canonical way of allocating a stack for the
    child of clone(), and Jann Horn noted some reasons why:

        Not on Linux, but on OpenBSD, they do use MAP_STACK now
        AFAIK; this was announced here:
        <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
        Basically they periodically check whether the userspace
        stack pointer points into a MAP_STACK region, and if not,
        they kill the process. So even if it's a no-op on Linux, it
        might make sense to advise people to use the flag to improve
        portability? I'm not sure if that's something that belongs
        in Linux manpages.

        Another reason against malloc() is that when setting up
        thread stacks in proper, reliable software, you'll probably
        want to place a guard page (in other words, a 4K PROT_NONE
        VMA) at the bottom of the stack to reliably catch stack
        overflows; and you probably don't want to do that with
        malloc, in particular with non-page-aligned allocations.

    And the OpenBSD 6.5 manual pages says:

        MAP_STACK
            Indicate that the mapping is used as a stack. This
            flag must be used in combination with MAP_ANON and
            MAP_PRIVATE.

    And I then noticed that MAP_STACK seems already to be on
    FreeBSD for a long time:

        MAP_STACK
            Map the area as a stack.  MAP_ANON is implied.
            Offset should be 0, fd must be -1, and prot should
            include at least PROT_READ and PROT_WRITE.  This
            option creates a memory region that grows to at
            most len bytes in size, starting from the stack
            top and growing down.  The stack top is the start‐
            ing address returned by the call, plus len bytes.
            The bottom of the stack at maximum growth is the
            starting address returned by the call.

            The entire area is reserved from the point of view
            of other mmap() calls, even if not faulted in yet.

    Reported-by: Jann Horn <jannh@google.com>
    Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
    Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>


> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---

Yeah, stack handling - especially with legacy clone() - is yucky on the
best of days. Thank you for the fix.

Acked-by: Christian Brauner <brauner@kernel.org>
