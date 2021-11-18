Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59827455945
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbhKRKoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343546AbhKRKoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 05:44:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33579C061764
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 02:41:03 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l25so8491265eda.11
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 02:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/KSiRc7oNYzOW4CK1BZ0cCm2AAq7/+zfddZF7SXbKM=;
        b=UJxm76ZB0KzfUep9Thp1f2rhYqUhJnJ+BbuZFbMPaQd0qfx9qbM6b6hIpk/UpRzSfr
         k2zjOv+hUA6WRSFtxuM1fNRHA5A32XxK30KKdxpjntk49fZSmwXkmjRXZm90qlapoCsf
         qHWMLH1C1lvNqxTOG7rJKXfGoIA0JDYvOK4HGmJ3KRYUwYB9Rw7e6y45NxdtkZKJnyhw
         OeLJpjZ3blmiaAP0O75pLBYxwNtlWdxJ9UHDikBUrx9v3EnbdYnHANpgQPFqc6j7W2TD
         sKgEbeik7xjTCGRGyhnJDPFCkHLnFtyOnA6Spxlm5S1qFLeNI2A2Fo5l/Ta2TojyQHt9
         qC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/KSiRc7oNYzOW4CK1BZ0cCm2AAq7/+zfddZF7SXbKM=;
        b=wksXDDtdAgzGvZandeN9xFdyXFPZRCukLfBZIhk0NqcBZ7JD03R2aBqGjtdXm2neVY
         wyrakv4jGMu8C+TSz86gH3yUhNRcoA2agHF/AY19ZcudrVQwCB39WPvl0Iba3mkT8J8p
         UeeNV/MFVhLhBK3BbuWBsFE6eg9gB8/xpMEZJu0ocB1Urn6mchVCiyWm7TrdmXVxDrLk
         VBuJtdLud1X1jDzvFkR8C5QplBjAaWH2wV2iI+d3IDvY6vG3r995bmrsPkQBG+lNShcq
         g8gFLSAUaJoPmjC9dr46I5mpsRQHmm/E5L1XAVIQL7lR8Pvmb160Jiut3CLlNBe1Mhim
         1ySw==
X-Gm-Message-State: AOAM531iDzkrMGNf3PfAeZr+gfC9EadCn1SecG68E0xY6Ai/juW1Xrk/
        5j8ztTsJp1WeoXDGA6hj8oRyHIn8HTJMS9P73B8eYQ==
X-Google-Smtp-Source: ABdhPJxYNwCzJKpVqZOSc+cef4RPv+4x9Rs+TqbqBc/rs/Dm99bpBfCvifu2+8PysuQwOudP3oH7O+FDG63pehPRwD0=
X-Received: by 2002:a17:907:7f90:: with SMTP id qk16mr32602837ejc.169.1637232061458;
 Thu, 18 Nov 2021 02:41:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+3zgmtHdCE3TZn3Hc8+nsYc+mHHvACNgFY_Z_Z4nCAmhSnQPg@mail.gmail.com>
In-Reply-To: <CA+3zgmtHdCE3TZn3Hc8+nsYc+mHHvACNgFY_Z_Z4nCAmhSnQPg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 Nov 2021 16:10:50 +0530
Message-ID: <CA+G9fYuFqFyYXkvGK8jVCZAiDZW_oNG4dNY_2q9BG__uXRR1DQ@mail.gmail.com>
Subject: Re: Re: [PATCH 5.10 000/578] 5.10.80-rc2 review
To:     Tim Lewis <elatllat@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+ Kernel Selftest
+ Anders

Hi Tim,

Thanks for your email.

On Wed, 17 Nov 2021 at 20:07, Tim Lewis <elatllat@gmail.com> wrote:
>
> > No regressions on arm64, arm, x86_64, and i386.
>
> I got
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.

It is a known intermittent failure due to test running more than expected time
and runner script killed it.

I have noticed intermittent failures on slow devices.

You can see the history of the test case on Linux next here
intermittently failing.
I do compare between the stable-rc branches, Linux mainline and next.
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210924/testrun/5897899/suite/kselftest-proc/test/proc.proc-uptime-001/history/


> I don't see proc-uptime-001 on
> https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/skipfile-lkft.yaml

We will add this as known intermittent failure.
It would be great if we report this to the test author and ask them to
review the test case for
the reason for long run time on slow devices.

>
> my proc-uptime-001 history

In general when a test fails,
Please re-run the test independently for 10 times or more on the same
kernel / device before we report it as regression.

> 5.10.80-rc2-dirty:not ok 10 selftests: proc: proc-uptime-001 # exit=134

exit=134 which means Aborted.
When the test runs more than X time (45 sec i guess) the script will
be killed by the runner script.

> 5.10.80-rc1-dirty:ok 10 selftests: proc: proc-uptime-001

This test log details gives more insight that the test was timeout and Aborted.
Test output log:
--------------------
# selftests: proc: proc-uptime-001
[   43.200262] audit: type=1701 audit(1618432600.255:6):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=11758
comm=\"proc-uptime-001\"
exe=\"/opt/kselftest_intree/proc/proc-uptime-001\" sig=6 res=1
# proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
# /usr/bin/tim[   43.224097] audit: type=1701 audit(1618432600.259:7):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=11756 comm=\"timeout\"
exe=\"/usr/bin/timeout.coreutils\" sig=6 res=1
eout: the monitored command dumped core
# ./kselftest/runner.sh: line 33: 11756 Aborted
/usr/bin/timeout --foreground \"$kselftest_timeout\" \"$1\"
not ok 11 selftests: proc: proc-uptime-001 # exit=134

However, It is good to find that system running slowly.

- Naresh
