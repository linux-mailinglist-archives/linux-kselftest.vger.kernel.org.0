Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7D19487C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 21:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCZUPA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 16:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgCZUPA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 16:15:00 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DCF02070A;
        Thu, 26 Mar 2020 20:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585253698;
        bh=o1vMvq4OXn5LTOH+tAFfGSmQddiNm84t7AUPsdzQFuU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ChYsyZVKrOjooEmo6qcud+pXwOAddaMliBnjJ6d/jq56naAHn7gqJvMaXnFyzMqqD
         M7+kvDPwVeV7QDs/5ja6ycvMAya+St2RxH8s8nW0is6EHpeOilp9xPeOXJF1lnmFmA
         vI72t0ZThRt5T5zqJ+smP/VOjqsH4AQc+5N7rPC8=
Subject: Re: [PATCH v8 kunit-next 0/4] kunit: add debugfs representation to
 show results
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2333d91d-2575-87ba-d8bb-60023cc19990@kernel.org>
Date:   Thu, 26 Mar 2020 14:14:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/26/20 8:25 AM, Alan Maguire wrote:
> When kunit tests are run on native (i.e. non-UML) environments, the results
> of test execution are often intermixed with dmesg output.  This patch
> series attempts to solve this by providing a debugfs representation
> of the results of the last test run, available as
> 
> /sys/kernel/debug/kunit/<testsuite>/results
> 
> Changes since v7:
> 
> - renamed KUNIT_INDENT[2] to KUNIT_SUBTEST_INDENT, KUNIT_SUBSUBTEST_INDENT
>    and added more description to their definitions to clarify why they
>    are defined as they are (Shuah)
> - defined KUNIT_SUBSUBTEST_INDENT directly as 8 spaces to avoid
>    checkpatch error (Shuah)
> 
> Changes since v6:
> 
> - fixed regexp parsing in kunit_parser.py to ensure test results are read
>    successfully with 4-space indentation (Brendan, patch 3)
> 
> Changes since v5:
> 
> - replaced undefined behaviour use of snprintf(buf, ..., buf) in
>    kunit_log() with a function to append string to existing log
>    (Frank, patch 1)
> - added clarification on log size limitations to documentation
>    (Frank, patch 4)
> 
> Changes since v4:
> 
> - added suite-level log expectations to kunit log test (Brendan, patch 2)
> - added log expectations (of it being NULL) for case where
>    CONFIG_KUNIT_DEBUGFS=n to kunit log test (patch 2)
> - added patch 3 which replaces subtest tab indentation with 4 space
>    indentation as per TAP 14 spec (Frank, patch 3)
> 
> Changes since v3:
> 
> - added CONFIG_KUNIT_DEBUGFS to support conditional compilation of debugfs
>    representation, including string logging (Frank, patch 1)
> - removed unneeded NULL check for test_case in
>    kunit_suite_for_each_test_case() (Frank, patch 1)
> - added kunit log test to verify logging multiple strings works
>    (Frank, patch 2)
> - rephrased description of results file (Frank, patch 3)
> 
> Changes since v2:
> 
> - updated kunit_status2str() to kunit_status_to_string() and made it
>    static inline in include/kunit/test.h (Brendan)
> - added log string to struct kunit_suite and kunit_case, with log
>    pointer in struct kunit pointing at the case log.  This allows us
>    to collect kunit_[err|info|warning]() messages at the same time
>    as we printk() them.  This solves for the most part the sharing
>    of log messages between test execution and debugfs since we
>    just print the suite log (which contains the test suite preamble)
>    and the individual test logs.  The only exception is the suite-level
>    status, which we cannot store in the suite log as it would mean
>    we'd print the suite and its status prior to the suite's results.
>    (Brendan, patch 1)
> - dropped debugfs-based kunit run patch for now so as not to cause
>    problems with tests currently under development (Brendan)
> - fixed doc issues with code block (Brendan, patch 3)
> 
> Changes since v1:
>   - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
>   - renamed global debugfs functions to be prefixed with kunit_ (Greg)
>   - removed error checking for debugfs operations (Greg)
> 
> Alan Maguire (4):
>    kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
>    kunit: add log test
>    kunit: subtests should be indented 4 spaces according to TAP
>    kunit: update documentation to describe debugfs representation
> 
>   Documentation/dev-tools/kunit/usage.rst |  14 +++
>   include/kunit/test.h                    |  63 ++++++++++++--
>   lib/kunit/Kconfig                       |   8 ++
>   lib/kunit/Makefile                      |   4 +
>   lib/kunit/assert.c                      |  79 ++++++++---------
>   lib/kunit/debugfs.c                     | 116 +++++++++++++++++++++++++
>   lib/kunit/debugfs.h                     |  30 +++++++
>   lib/kunit/kunit-test.c                  |  44 +++++++++-
>   lib/kunit/test.c                        | 148 +++++++++++++++++++++++++-------
>   tools/testing/kunit/kunit_parser.py     |  10 +--
>   10 files changed, 430 insertions(+), 86 deletions(-)
>   create mode 100644 lib/kunit/debugfs.c
>   create mode 100644 lib/kunit/debugfs.h
> 

Thanks. Applied to linux-kselftest kunit for 5.7-rc1.

thanks,
-- Shuah
