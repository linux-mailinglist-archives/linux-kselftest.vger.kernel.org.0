Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E13113863
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 01:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfLEABZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 19:01:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36126 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEABZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 19:01:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id k11so1698316qtm.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2019 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJE0pjdE5Zlehm0IQrIdzxUmlagRhXSz8Z6krXba16E=;
        b=dMXveiSdmysvHaaEGqoOeZVSx5EPJ9MpMwSPukSFjNxEoCMpSTZ/b7nW3a3ag+uVAQ
         WJqr3Mqy/7UmoytRqJv1NDqoRpsXix5p5K7lJ1cn9tolu5aMWzqO1bsczgCQX2yBZFio
         /owaBhc98Ur1YVsbX4paW48mWFyWzoO/p1IDD3DFqbUqcIKOR9ok2SpJjnxswQIwl5k8
         11AdS6biXWKXtMXYO02Qbn3EyfPdk9nh44b2fn9WJTrAx07Weld/jA/XnPX9fNhWsxFA
         gK7XXefTKOuYQuo1lCxJjtBIQQPuqF4K/u9J38SLRlccFneeuFHsEIkfmMtJTYKqh5tN
         yB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJE0pjdE5Zlehm0IQrIdzxUmlagRhXSz8Z6krXba16E=;
        b=QUDI6eSXwjB1c8DAza1+kOiSCSJBpV5atuyme77cMPtn1qH0YPpaQeuTF/1y7iipup
         j0kNCA0g4+aVsKHMrpd9sxrDsRgLqDIc9NJV/CL1FgTS3wziR5MgOWpSBD6POIzb9Zym
         /yhjxNILo9Lsn0oIMKg/F0wCz2Oelb/VChNJVX6LM/qB665ZQJfiPyeBs5orzFvsmpjq
         /b7y5bf4tf5ebTT5UcYSigOc3/SepcT6cyNmlV8TSUSAiTd+pHOzoVcZT+gxtrl4qg1V
         wqt1cINNq5sCzxZsIqlwiOOzawHIhypwLI6ZuJzjLhl1dqJHlnO48xbdlW3sgzmfgEbM
         iiMg==
X-Gm-Message-State: APjAAAVg0P704YhPwUJSuwJKZJl096tbPkwDqLYUEWomSnIaPB8t24/j
        RTY8zAkEoN5fx1A44Br7SKRnQU1B7tgFrh6YekeAZPSJXg==
X-Google-Smtp-Source: APXvYqyjERtSkkqd18jJn6NmH7zcnXxSu4imYlM1ke8pU9s0MVgE/EHmIGiKhuYy1w87RsrmzGQgcu4BTCkDWBb0gf0=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr5209796qto.109.1575504084233;
 Wed, 04 Dec 2019 16:01:24 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
 <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
 <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
 <20191204003851.GF86484@mit.edu> <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 4 Dec 2019 16:00:48 -0800
Message-ID: <CAAXuY3qekjWBUTxzAjCs+87nVXpigvzqm7TpG7MtJagTSG-xtg@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> I've also got a patch that I was hoping to send out soon
> that might help.  The idea is that each test suite would create
> a debugfs representation under /sys/kernel/debug/kunit;
> specifically:
>
> /sys/kernel/debug/kunit/results/<suite>
> /sys/kernel/debug/kunit/results/<suite>-tests
>
> ...where cat'ing the former shows the full set of results,
> and the latter is a directory within which we can display
> individual test results in test-case-specific files.
>
> This is all done by ensuring that when tests log information,
> they log to a per-test-case log buffer as well as to dmesg.
>
> If the above sounds useful, I'll try and polish up the patch
> for submission. Thanks!
What would be the best way for kunit_tool to:
1. Know that the tests have completed as QEMU will be just sitting
there with kernel complaining about the absence of init (or running
whatever we give it as init)?
2. Read the test results from debugfs under QEMU virtual machine while
the kernel is still there?
I think supplying an init script/binary that copies the
/sys/kernel/debug/kunit/results/* to a 9p shared dir set up by
kunit_tool would work but it would add a step of cross-compiling and
packaging a userspace binary.
