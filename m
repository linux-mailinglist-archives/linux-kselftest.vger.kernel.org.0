Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0252FE2DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jan 2021 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbhAUG3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 01:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAUG24 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 01:28:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF83C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 22:28:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so992798ejf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 22:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rwgvP8AoqgDSPVMCmPqHU4aJ92n1EnfAeIj2Yz3Gw3Q=;
        b=j/bL1BUg7wEjWJ2XEiCeKl5ZcKNAvNnxWb4MMMEdD5hOt51X0RghRJsnGZzz7W6s6o
         8fGVG7w9V5qTwUN2nIOaymNIO2vSHqLlJ8QFAb6P3iio2PJzO2rKW6UQO2f5mSFeKKFn
         kvQK+eS0BJtCrmt3U9sPtTggAwAtnXLtM9n716BJR2MzGyi5JZIwgXrnmUdQqCa9XsQm
         05/7Q54+iwwqqeJQ/aZ8Miz7feHb9hqv3j+7JOmIGH7E6B6+saD8W3dtsJ+29ewj160F
         C4cT+Z9ZVhY0hzNGiroOqdoIsoCvBleEJ/Dyi8YjqrT6WUgIwgOUzBY6PCC8frdh9ned
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rwgvP8AoqgDSPVMCmPqHU4aJ92n1EnfAeIj2Yz3Gw3Q=;
        b=nlc5mlj/5SrBvd+Kpj/M0I6mmylP5evabrfEP/57UMGx0HFs50X3NNlt3kpk3c+Ld+
         qWuxLY508KSVk6me162Cnoi/WBuTNeBTo2WzLoqZoOpZpLiZq2pJOt2rC0gksmRjTffT
         nbMO4hiwa4KYK1GlswkO2p6tOm5U3rvvFI3fTQmfyw6KY1Pvv2J1wyjzuP6wPJhUyLHv
         U51R3BKs1JtIhQmUstdES2QHlfZTLeh8eIIla+4DaAmUOOo1bHWECpdKcZKbNG/DyJR/
         CSmp9bcMVvchqpjr9tbkE3PB7Zkvz1bXpZDjFZ4nyB2PzeQnL5DO9Yno1NxnwhLzP91B
         l0VQ==
X-Gm-Message-State: AOAM530+u2IS8tMc2o+is+WBUTJwjcTY44acvZz9ZzawyqK1Xpw9DlIU
        7xuZByD453H4OSI1CfkPM+a4M/IZaVGWAhVxPOz83h+492N/rftF
X-Google-Smtp-Source: ABdhPJyrVRb/FAVouTL2Re4ou3lIvSM3uEQTtZMyGaZXV+Wd0nJ3uq/TQmPAFTpawREd5KT4Aqg8GTONmAzC9HMMTHg=
X-Received: by 2002:a17:906:796:: with SMTP id l22mr8379890ejc.247.1611210493617;
 Wed, 20 Jan 2021 22:28:13 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Jan 2021 11:58:02 +0530
Message-ID: <CA+G9fYso2u4Km7mG-PWC_G_BXZRK5qLNN+NK6ws4KmpSZKq4cw@mail.gmail.com>
Subject: test-definitions: kselftest upgrade to v5.10
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Tim.Bird@sony.com,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If you are not using the test-definitions project to run kselftest,
please ignore this email.

A new run script for kselftest, run_kselftest.sh [1], was created during the
Linux v5.10 release.

This script allows someone to run both individual test cases and sets of
test cases. Accordingly, the test-definitions kselftest script [2] was also
improved to support these upstream changes [1].  Currently this change is in
the test-definitions repository in a separate branch "kselftest". This has been
running in LKFT's CI since November 2020 [3].

The test-definitions kselftest script will stop supporting older versions of
the kselftest run script starting 1st-Feb-2021 from master branch.
OTOH, One have to use test-definitions Tag 2021.01 (will be created) for older
kselftest versions.

We request that any users of test-definitions project start updating your
kselftest sources to version v5.10 and above.

Upstream patch,
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/tools/testing/selftests/run_kselftest.sh?id=5da1918446a1d50d57f2f6062f7fdede0b052473
[2] https://github.com/Linaro/test-definitions/tree/kselftest/automated/linux/kselftest
[3] https://github.com/Linaro/test-definitions/tree/kselftest

---
From 5da1918446a1d50d57f2f6062f7fdede0b052473 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Mon, 28 Sep 2020 13:26:49 -0700
Subject: selftests/run_kselftest.sh: Make each test individually selectable

Currently with run_kselftest.sh there is no way to choose which test
we could run. All the tests listed in kselftest-list.txt are all run
every time. This patch enhanced the run_kselftest.sh to make the test
collections (or tests) individually selectable. e.g.:

$ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

Additionally adds a way to list all known tests with "-l", usage
with "-h", and perform a dry run without running tests with "-n".

Co-developed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

--

- Naresh Kamboju
