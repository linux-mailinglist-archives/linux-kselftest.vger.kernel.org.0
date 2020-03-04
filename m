Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1017986F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 19:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgCDSy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 13:54:58 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39675 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgCDSy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 13:54:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id x184so3031898ywd.6;
        Wed, 04 Mar 2020 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=khe1MUx9PqquZu/NWJr8F4YAjRSU8XFMfxkg7Szqw/k=;
        b=CXC6Q+wQoWl9wdexagm2bOq8/V59xE/9ozzxW9zmIVQ0RGQsNuQEKbrpCH42mpqvFy
         7kSkHgvYHXRDPIf/dtqJ+Th3TlUvtgFAoQa0w9rUBD+Ee+JoiVWIXdJV+doY2czXesHC
         U9oaT3wUA7i+FAdsCni7JjPUV72lTbe/rt1Nv90Ydjk46HplEbFsoohjLUzUsx/9NEFK
         bBQqhsqEnH3yKkf6qClO2USwptJxcKjvgJlcaI6oivMZCBgMtpPFrb4z9XbncxQXy/Wy
         HYhi3JWBofcBSbrb3Z4FMATE3+LSI3DVwpSurs5Na3ucpegQ37Gpcv5mi22pVuWsxZvw
         PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khe1MUx9PqquZu/NWJr8F4YAjRSU8XFMfxkg7Szqw/k=;
        b=eU6EOWkwXGA46Emq4viyQWaD/esZ2JpK6Xbg+X0WhUxWILtwkx5wrD02uvIDUlUQrV
         iIXtmAwwxWzQU0GDg5yrjsSm+rLtyDznzOhYY3jIbZfr64yx1Wj0FsbQ/1400QHlpBF6
         MFC6HY6JXUcqlH/6WVum3jjWaTsn7w4sGrBMHhEeWCA/PXXNDdJjbYT0VxDSZgkBPZUz
         Z5vdsgb5QD6zzvnCwCSTXc02Iri/SHPGenPJ6clXYpL6rvu+EoYqPXbamADQeSVYFxxi
         GdaQ6Or6ulJCgUQaL89Vx9eyw3C8fHG2DWrXdyO2hMLYLgJlAwKsBpU/870TvVEWf5Fb
         KdOg==
X-Gm-Message-State: ANhLgQ1iLJ8Vo0U16cp54tlWR40SZc+b0G/FuXHnvMtlKLZssv6+rUh1
        M2TZ+htBV5UwGHNLWLGNb3E=
X-Google-Smtp-Source: ADFU+vtGhaed+fgDnjuY/gvhz/ZwNlUnLqo2QG+7+exC1UluwOtASdfgvs7Q2WNuuZrvbHuvEH91Ig==
X-Received: by 2002:a81:98d7:: with SMTP id p206mr4447043ywg.376.1583348096390;
        Wed, 04 Mar 2020 10:54:56 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z126sm645374ywb.49.2020.03.04.10.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:54:56 -0800 (PST)
Subject: Re: [PATCH v6 kunit-next 0/4] kunit: add debugfs representation to
 show results
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
References: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <86d45ff4-1f3b-d22f-08ad-b02bdb60cee2@gmail.com>
Date:   Wed, 4 Mar 2020 12:54:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On 3/4/20 5:07 AM, Alan Maguire wrote:
> When kunit tests are run on native (i.e. non-UML) environments, the results
> of test execution are often intermixed with dmesg output.  This patch
> series attempts to solve this by providing a debugfs representation
> of the results of the last test run, available as
> 
> /sys/kernel/debug/kunit/<testsuite>/results
> 
> Changes since v5:
> 
> - replaced undefined behaviour use of snprintf(buf, ..., buf) in kunit_log()
>   with a function to append string to existing log (Frank, patch 1)
> - added clarification on log size limitations to documentation
>   (Frank, patch 4)

Thanks for all the changes throughout the versions.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

-Frank

> 
> Changes since v4:
> 
> - added suite-level log expectations to kunit log test (Brendan, patch 2)
> - added log expectations (of it being NULL) for case where
>   CONFIG_KUNIT_DEBUGFS=n to kunit log test (patch 2)
> - added patch 3 which replaces subtest tab indentation with 4 space
>   indentation as per TAP 14 spec (Frank, patch 3)
> 
> Changes since v3:
> 
> - added CONFIG_KUNIT_DEBUGFS to support conditional compilation of debugfs
>   representation, including string logging (Frank, patch 1)
> - removed unneeded NULL check for test_case in
>   kunit_suite_for_each_test_case() (Frank, patch 1)
> - added kunit log test to verify logging multiple strings works
>   (Frank, patch 2)
> - rephrased description of results file (Frank, patch 3)
> 
> Changes since v2:
> 
> - updated kunit_status2str() to kunit_status_to_string() and made it
>   static inline in include/kunit/test.h (Brendan)
> - added log string to struct kunit_suite and kunit_case, with log
>   pointer in struct kunit pointing at the case log.  This allows us
>   to collect kunit_[err|info|warning]() messages at the same time
>   as we printk() them.  This solves for the most part the sharing
>   of log messages between test execution and debugfs since we
>   just print the suite log (which contains the test suite preamble)
>   and the individual test logs.  The only exception is the suite-level
>   status, which we cannot store in the suite log as it would mean
>   we'd print the suite and its status prior to the suite's results.
>   (Brendan, patch 1)
> - dropped debugfs-based kunit run patch for now so as not to cause
>   problems with tests currently under development (Brendan)
> - fixed doc issues with code block (Brendan, patch 3)
> 
> Changes since v1:
>  - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
>  - renamed global debugfs functions to be prefixed with kunit_ (Greg)
>  - removed error checking for debugfs operations (Greg)
> 
> Alan Maguire (4):
>   kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
>   kunit: add log test
>   kunit: subtests should be indented 4 spaces according to TAP
>   kunit: update documentation to describe debugfs representation
> 
>  Documentation/dev-tools/kunit/usage.rst |  14 +++
>  include/kunit/test.h                    |  59 +++++++++++--
>  lib/kunit/Kconfig                       |   8 ++
>  lib/kunit/Makefile                      |   4 +
>  lib/kunit/assert.c                      |  79 ++++++++---------
>  lib/kunit/debugfs.c                     | 116 +++++++++++++++++++++++++
>  lib/kunit/debugfs.h                     |  30 +++++++
>  lib/kunit/kunit-test.c                  |  45 +++++++++-
>  lib/kunit/test.c                        | 147 +++++++++++++++++++++++++-------
>  9 files changed, 421 insertions(+), 81 deletions(-)
>  create mode 100644 lib/kunit/debugfs.c
>  create mode 100644 lib/kunit/debugfs.h
> 

