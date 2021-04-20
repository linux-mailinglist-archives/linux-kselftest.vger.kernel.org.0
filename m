Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A236628D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhDTXlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhDTXlF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 19:41:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB781C061763
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 16:40:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b10so40267385iot.4
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgWXnAm5K+neiT/gTZszeD6IV/HEAXXB0Ki6E/5iwoE=;
        b=Shv3OSWuEO9YdF2qaRdYXt8oe6JJgdn4ON977AMM1rMFMnWw4wt/6k1m68jLY6nLs/
         nofYo+WYIITrUPi06juLCcHiHemO0TVH1kIZXwyzSMhRi/6O319n/0ruHXD1Jpx1wRKC
         +6XK3PdmkQ7OG4KIuKmChjojNecLzUFegO0x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgWXnAm5K+neiT/gTZszeD6IV/HEAXXB0Ki6E/5iwoE=;
        b=aSCqjZG32nY5xG53YgjcjpxitgP1mOR3F1wykU6EAKeTniesRjyE66qtGiBYKiuY97
         r2YZgnBuCo5vc6Z1q8qkaFjfgcaMg38SisIApAFPTlmjeYDo8DgbwnY3iVCwZIONNaEz
         qUX2MRyspjV0Yss6ESK8alGatN83J5kWTYlJMx08ycmxsTCaxKksJaUfm4G4YQ3vDMeb
         MIiqN3CoTIpnwzwYm8i8XiyM/fyXr42JhPvI+se0SDVOtNkEnP1NiSlCs0RolksgO+hp
         exdhMRR+aOyq0OiDL8bYMKXSSdFIO8+kdMmbZsXNE15rZT7L34p8gsg2CYLi45K3WMgg
         M5bQ==
X-Gm-Message-State: AOAM531Y1Zr7dDx91nodtGEAV6fD08ukBs4tO7bzTczuA+4+J5+MohS6
        +OAg+7uBPaDIT67psE+fMOYZbg==
X-Google-Smtp-Source: ABdhPJwXSPUsZwcpCGfMhLrRjcZz7pUJKDN7e2coIvECoJ+GsaW10kjQ6DLyKuEQ7KHsmuf6k/ioOg==
X-Received: by 2002:a6b:b48e:: with SMTP id d136mr11453669iof.47.1618962032076;
        Tue, 20 Apr 2021 16:40:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 1sm181125ilz.11.2021.04.20.16.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 16:40:31 -0700 (PDT)
Subject: Re: [PATCH v3] Documentation: dev-tools: Add Testing Overview
To:     David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210415054036.581117-1-davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2a35b57e-3261-8ebe-d9f3-66b3dedff756@linuxfoundation.org>
Date:   Tue, 20 Apr 2021 17:40:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415054036.581117-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/21 11:40 PM, David Gow wrote:
> The kernel now has a number of testing and debugging tools, and we've
> seen a bit of confusion about what the differences between them are.
> 
> Add a basic documentation outlining the testing tools, when to use each,
> and how they interact.
> 
> This is a pretty quick overview rather than the idealised "kernel
> testing guide" that'd probably be optimal, but given the number of times
> questions like "When do you use KUnit and when do you use Kselftest?"
> are being asked, it seemed worth at least having something. Hopefully
> this can form the basis for more detailed documentation later.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> ---
> 
> Thanks again. Assuming no-one has any objections, I think this is good
> to go.
> 
> -- David
> 
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20210414081428.337494-1-davidgow@google.com/
> - A few typo fixes (Thanks Daniel)
> - Reworded description of dynamic analysis tools.
> - Updated dev-tools index page to not use ':doc:' syntax, but to provide
>    a path instead.
> - Added Marco and Daniel's Reviewed-by tags.
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20210410070529.4113432-1-davidgow@google.com/
> - Note KUnit's speed and that one should provide selftests for syscalls
> - Mention lockdep as a Dynamic Analysis Tool
> - Refer to "Dynamic Analysis Tools" instead of "Sanitizers"
> - A number of minor formatting tweaks and rewordings for clarity
> 
>   Documentation/dev-tools/index.rst            |   4 +
>   Documentation/dev-tools/testing-overview.rst | 117 +++++++++++++++++++
>   2 files changed, 121 insertions(+)
>   create mode 100644 Documentation/dev-tools/testing-overview.rst
> 
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> index 1b1cf4f5c9d9..929d916ffd4c 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -7,6 +7,9 @@ be used to work on the kernel. For now, the documents have been pulled
>   together without any significant effort to integrate them into a coherent
>   whole; patches welcome!
>   
> +A brief overview of testing-specific tools can be found in
> +Documentation/dev-tools/testing-overview.rst
> +
>   .. class:: toc-title
>   
>   	   Table of contents
> @@ -14,6 +17,7 @@ whole; patches welcome!
>   .. toctree::
>      :maxdepth: 2
>   
> +   testing-overview
>      coccinelle
>      sparse
>      kcov
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> new file mode 100644
> index 000000000000..b5b46709969c
> --- /dev/null
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Kernel Testing Guide
> +====================
> +
> +
> +There are a number of different tools for testing the Linux kernel, so knowing
> +when to use each of them can be a challenge. This document provides a rough
> +overview of their differences, and how they fit together.
> +
> +
> +Writing and Running Tests
> +=========================
> +
> +The bulk of kernel tests are written using either the kselftest or KUnit
> +frameworks. These both provide infrastructure to help make running tests and
> +groups of tests easier, as well as providing helpers to aid in writing new
> +tests.
> +
> +If you're looking to verify the behaviour of the Kernel — particularly specific
> +parts of the kernel — then you'll want to use KUnit or kselftest.
> +
> +
> +The Difference Between KUnit and kselftest
> +------------------------------------------
> +
> +KUnit (Documentation/dev-tools/kunit/index.rst) is an entirely in-kernel system
> +for "white box" testing: because test code is part of the kernel, it can access
> +internal structures and functions which aren't exposed to userspace.
> +
> +KUnit tests therefore are best written against small, self-contained parts
> +of the kernel, which can be tested in isolation. This aligns well with the
> +concept of 'unit' testing.
> +
> +For example, a KUnit test might test an individual kernel function (or even a
> +single codepath through a function, such as an error handling case), rather
> +than a feature as a whole.
> +
> +This also makes KUnit tests very fast to build and run, allowing them to be
> +run frequently as part of the development process.
> +
> +There is a KUnit test style guide which may give further pointers in
> +Documentation/dev-tools/kunit/style.rst
> +
> +
> +kselftest (Documentation/dev-tools/kselftest.rst), on the other hand, is
> +largely implemented in userspace, and tests are normal userspace scripts or
> +programs.
> +
> +This makes it easier to write more complicated tests, or tests which need to
> +manipulate the overall system state more (e.g., spawning processes, etc.).
> +However, it's not possible to call kernel functions directly from kselftest.
> +This means that only kernel functionality which is exposed to userspace somehow
> +(e.g. by a syscall, device, filesystem, etc.) can be tested with kselftest.  To
> +work around this, some tests include a companion kernel module which exposes
> +more information or functionality. If a test runs mostly or entirely within the
> +kernel, however,  KUnit may be the more appropriate tool.
> +
> +kselftest is therefore suited well to tests of whole features, as these will
> +expose an interface to userspace, which can be tested, but not implementation
> +details. This aligns well with 'system' or 'end-to-end' testing.
> +
> +For example, all new system calls should be accompanied by kselftest tests.
> +
> +Code Coverage Tools
> +===================
> +
> +The Linux Kernel supports two different code coverage measurement tools. These
> +can be used to verify that a test is executing particular functions or lines
> +of code. This is useful for determining how much of the kernel is being tested,
> +and for finding corner-cases which are not covered by the appropriate test.
> +
> +:doc:`gcov` is GCC's coverage testing tool, which can be used with the kernel
> +to get global or per-module coverage. Unlike KCOV, it does not record per-task
> +coverage. Coverage data can be read from debugfs, and interpreted using the
> +usual gcov tooling.
> +
> +:doc:`kcov` is a feature which can be built in to the kernel to allow
> +capturing coverage on a per-task level. It's therefore useful for fuzzing and
> +other situations where information about code executed during, for example, a
> +single syscall is useful.
> +
> +
> +Dynamic Analysis Tools
> +======================
> +
> +The kernel also supports a number of dynamic analysis tools, which attempt to
> +detect classes of issues when they occur in a running kernel. These typically
> +each look for a different class of bugs, such as invalid memory accesses,
> +concurrency issues such as data races, or other undefined behaviour like
> +integer overflows.
> +
> +Some of these tools are listed below:
> +
> +* kmemleak detects possible memory leaks. See
> +  Documentation/dev-tools/kmemleak.rst
> +* KASAN detects invalid memory accesses such as out-of-bounds and
> +  use-after-free errors. See Documentation/dev-tools/kasan.rst
> +* UBSAN detects behaviour that is undefined by the C standard, like integer
> +  overflows. See Documentation/dev-tools/ubsan.rst
> +* KCSAN detects data races. See Documentation/dev-tools/kcsan.rst
> +* KFENCE is a low-overhead detector of memory issues, which is much faster than
> +  KASAN and can be used in production. See Documentation/dev-tools/kfence.rst
> +* lockdep is a locking correctness validator. See
> +  Documentation/locking/lockdep-design.rst
> +* There are several other pieces of debug instrumentation in the kernel, many
> +  of which can be found in lib/Kconfig.debug
> +
> +These tools tend to test the kernel as a whole, and do not "pass" like
> +kselftest or KUnit tests. They can be combined with KUnit or kselftest by
> +running tests on a kernel with these tools enabled: you can then be sure
> +that none of these errors are occurring during the test.
> +
> +Some of these tools integrate with KUnit or kselftest and will
> +automatically fail tests if an issue is detected.
> +
> 

Thank for you writing this much needed document.

Looks great. How about adding a section for Static analysis tools?
A mention coccicheck scripts and mention of smatch?

thanks,
-- Shuah

