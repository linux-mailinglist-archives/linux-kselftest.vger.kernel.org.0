Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A48FB00A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2019 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfKMLws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Nov 2019 06:52:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39278 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKMLwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Nov 2019 06:52:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so1712502lfk.6
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2019 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFFqqw3Ufa59nPQnO8AKe8pY9aTYmmOb+lK9fMEzTEM=;
        b=ix+CLznpSQ1tLLZNz6RZCFgQPIdlVL5Q151AabB6uzzkATEHkpiVu9sFStKHPccleW
         PbED9WU5uFMaahVpLXgFur/D3fLr0bGcHOg8RFJA/WYt961ovBJ3uhiU6ZCpLNg/sE4R
         p+ANHITh49GCRGISYUr590QTEHKy5VhPju4bAkYic0G791xmPvDu5G9v2T1YxEB2tHoI
         D8OYSkKrJB4xwN0X0p8Cm594DYemIlXIxQhjW+v6kOX7pAJbB0mxJuuKacyfkiBcecOD
         daDXWjmeJVLUbFkfEeF2yWoIugHe+j1hv2+S5GscZ5fsfVTC/5BOqSN6sfqpkYa+ey9R
         9t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFFqqw3Ufa59nPQnO8AKe8pY9aTYmmOb+lK9fMEzTEM=;
        b=QHHNXIpIJh7S+6h8majvRvJE/SXfAGjvKcVeUZPxGF/Yf13lg9e9YYSUu8RJHd9o7M
         eq3h9fMoV4AUZweHiqqI44xqPGzaJ3wlQL1Xp2Zj7vQ1G+a2ycXKz+GaE5vFYe41d2gr
         4tMMntEv0jfon0M1ddBKthSYko0026FdE9dRzUppArvtohAXN8qW6gRQnFY7USBLSsYD
         zWtPOsXp/MCpyeoVLB8iukBwt1mZQSXbJxaGqLC3KSY1V1+0tXndkoWOPsmd53tLFiAd
         DlShQa8GbX54jOwYKTmQmIKNFUEZGH19spNFBKS2sYqYVN1ZLzfkropi/6BIVZq8YGuw
         Q+mA==
X-Gm-Message-State: APjAAAWYRnjrM66ISqQ+QhHWuav6AklpfCWjly2GcGY2jE0y32gdN0gj
        whMqYQmw9OVofDQIWtviz0uw4EMg/7k16WLNkbsLOA==
X-Google-Smtp-Source: APXvYqzsyQcFkqMZpLWI3lpEJvXQ9RpSigELq+4YJMGbdlmhcpv7Scg9IpZbaobC2l9k1GV1ST0Y+vojiL21+eqgTQU=
X-Received: by 2002:a19:9116:: with SMTP id t22mr2284983lfd.99.1573645965075;
 Wed, 13 Nov 2019 03:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20191011122323.7770-1-ckellner@redhat.com> <20191014162034.2185-1-ckellner@redhat.com>
 <20191014162034.2185-2-ckellner@redhat.com> <20191015100743.t6gowsic7c347ldv@wittgenstein>
In-Reply-To: <20191015100743.t6gowsic7c347ldv@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Nov 2019 17:22:33 +0530
Message-ID: <CA+G9fYu=Z+mZs7+571PbChODV2drUYrxkdWEb7=XqkK2O3_Tyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pidfd: add tests for NSpid info in fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Kellner <ckellner@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Christian,

On Tue, 15 Oct 2019 at 15:37, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Oct 14, 2019 at 06:20:33PM +0200, Christian Kellner wrote:
> > From: Christian Kellner <christian@kellner.me>
> >
> > Add a test that checks that if pid namespaces are configured the fdinfo
> > file of a pidfd contains an NSpid: entry containing the process id in
> > the current and additionally all nested namespaces. In the case that
> > a pidfd is from a pid namespace not in the same namespace hierarchy as
> > the process accessing the fdinfo file, ensure the 'NSpid' shows 0 for
> > that pidfd, analogous to the 'Pid' entry.
> >
> > Signed-off-by: Christian Kellner <christian@kellner.me>
>
> That looks reasonable to me.

on arm64 Juno-r2, Hikey (hi6220) and dragonboard 410c and arm32
Beagleboard x15 test pidfd_test failed.
and on x86_64 and i386 test fails intermittently with TIMEOUT error.
Test code is being used from linux next tree.

Juno-r2 test output:
--------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
# TAP version 13
version: 13_ #
# 1..4
: _ #
# # Parent pid 10586
Parent: pid_10586 #
# # Parent Waiting for Child (10587) to complete.
Parent: Waiting_for #
# # Time waited for child 0
Time: waited_for #
# Bail out! pidfd_poll check for premature notification on child
thread exec test Failed
out!: pidfd_poll_check #
# # Planned tests != run tests (4 != 0)
Planned: tests_!= #
# # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
Pass: 0_Fail #
[FAIL] 1 selftests pidfd pidfd_test # exit=1
selftests: pidfd_pidfd_test [FAIL]

arm32 x15 output log,
-----------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
[FAIL] 1 selftests pidfd pidfd_test # TIMEOUT
selftests: pidfd_pidfd_test [FAIL]

x86_64 output log,
-------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
[FAIL] 1 selftests pidfd pidfd_test # TIMEOUT
selftests: pidfd_pidfd_test [FAIL]

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kselftest/pidfd_pidfd_test
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/pidfd_pidfd_test

link,
https://lkft.validation.linaro.org/scheduler/job/993549#L17835

- Naresh
