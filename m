Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F1587A27
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiHBJ5L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiHBJ5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 05:57:10 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 02:57:08 PDT
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA148C9B
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 02:57:08 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Lxqxs33g8zMptYk;
        Tue,  2 Aug 2022 11:51:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Lxqxr590Qzlqwsl;
        Tue,  2 Aug 2022 11:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659433873;
        bh=1zHRiAqo3P/dojkNK+hYHzjUFBL4CkZLzF7FK2fml6I=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=yubBe6Oo6HwAr99wsPmEZJALzIaciq9i8qNhdXbQ62s5yam2Z21lr4NT1c76h4xVp
         EZndDrz2aLGgYqsCnIkP3v6gXa79Prd3jd3wRVYwWxZK9FxtMha8El+S/oYz018ZQv
         h+Go38FAOlZssRp0+iylAHifHtozQjL+VPDlDORk=
Message-ID: <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
Date:   Tue, 2 Aug 2022 11:51:12 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
In-Reply-To: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This change breaks the Landlock test build when performed on the 
tools/testing/selftests/landlock directory because the 
(non-system/up-to-date) kernel headers aren't found. Looking at the use 
of top_srcdir and HDR_PATH, it seems that multiple subsystems are using 
this feature. I consider this change a regression.

It also removes the check on up-to-date kernel headers (thanks to the 
Makefile's target timestamp).

I wasn't CCed for this change impacting Landlock [1]. Please keep in 
mind to add at least maintainers and related mailing-lists for changes 
on related subsystems.

The following patch almost revert commit a917dd94b832 
("selftests/landlock: drop deprecated headers dependency") and partially 
fixes commit 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):

--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
  TEST_GEN_PROGS_EXTENDED := true

  OVERRIDE_TARGETS := 1
+top_srcdir = ../../../..
  include ../lib.mk

+khdr_dir = $(top_srcdir)/usr/include
+
  $(OUTPUT)/true: true.c
  	$(LINK.c) $< $(LDLIBS) -o $@ -static

-$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
-	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h 
../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)


This doesn't fix the header timestamp check though.

Regards,
  Mickaël

[1] 
https://lore.kernel.org/all/b79c51ed97219b1c10e2e3f2bcd3269305f0f035.1657694067.git.guillaume.tucker@collabora.com/


On 02/08/2022 00:03, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull the following Kselftest update for Linux 5.20-rc1.
> 
> This Kselftest update for Linux 5.20-rc1 consists of:
> 
> - timers test build fixes and cleanups for new tool chains
> - removing khdr from kselftest framework and main Makefile
> - changes to test output messages to improve reports
> 
> Please not that this update also included main Makefile change
> to kselftest build logic in it.
> 
> diff is attached.
> 
> thanks,
> -- Shuah
> 
> ----------------------------------------------------------------
> The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:
> 
>     Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)
> 
> are available in the Git repository at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.20-rc1
> 
> for you to fetch changes up to 4062eba9f3d072e72645860fbc5d160428a75c50:
> 
>     Makefile: replace headers_install with headers for kselftest (2022-07-26 18:06:33 -0600)
> 
> ----------------------------------------------------------------
> linux-kselftest-next-5.20-rc1
> 
> This Kselftest update for Linux 5.20-rc1 consists of:
> 
> - timers test build fixes and cleanups for new tool chains
> - removing khdr from kselftest framework and main Makefile
> - changes to test output messages to improve reports
> 
> ----------------------------------------------------------------
> Gautam (2):
>         kselftests: Enable the echo command to print newlines in Makefile
>         kselftests/damon: add support for cases where debugfs cannot be read
> 
> Gautam Menghani (3):
>         selftests: Make the usage formatting consistent in kselftest_deps.sh
>         selftests/drivers/gpu: Add error messages to drm_mm.sh
>         selftests/kcmp: Make the test output consistent and clear
> 
> Guillaume Tucker (6):
>         selftests: drop khdr make target
>         selftests: stop using KSFT_KHDR_INSTALL
>         selftests: drop KSFT_KHDR_INSTALL make target
>         Makefile: add headers_install to kselftest targets
>         selftests/landlock: drop deprecated headers dependency
>         Makefile: replace headers_install with headers for kselftest
> 
> Johannes Holland (1):
>         selftests/tpm2: increase timeout for kselftests
> 
> Soumya Negi (1):
>         selftests: drivers/dma-buf: Improve message in selftest summary
> 
> Wolfram Sang (9):
>         selftests: timers: valid-adjtimex: build fix for newer toolchains
>         selftests: timers: fix declarations of main()
>         selftests: timers: nanosleep: adapt to kselftest framework
>         selftests: timers: inconsistency-check: adapt to kselftest framework
>         selftests: timers: clocksource-switch: fix passing errors from child
>         selftests: timers: clocksource-switch: sort includes
>         selftests: timers: clocksource-switch: add command line switch to skip sanity check
>         selftests: timers: clocksource-switch: add 'runtime' command line parameter
>         selftests: timers: clocksource-switch: adapt to kselftest framework
> 
> Xiang wangx (1):
>         userfaultfd/selftests: Fix typo in comment
> 
> Zan Aziz (1):
>         selftests:timers: globals don't need initialization to 0
> 
>    Makefile                                           |  4 +-
>    tools/testing/selftests/Makefile                   | 30 +--------
>    tools/testing/selftests/arm64/mte/Makefile         |  1 -
>    tools/testing/selftests/arm64/signal/Makefile      |  1 -
>    .../testing/selftests/arm64/signal/test_signals.h  |  4 +-
>    tools/testing/selftests/damon/_chk_dependency.sh   | 10 +++
>    tools/testing/selftests/drivers/dma-buf/udmabuf.c  |  3 +-
>    tools/testing/selftests/drivers/gpu/drm_mm.sh      |  4 +-
>    .../selftests/drivers/s390x/uvdevice/Makefile      |  1 -
>    tools/testing/selftests/futex/functional/Makefile  |  1 -
>    tools/testing/selftests/kcmp/kcmp_test.c           |  6 +-
>    tools/testing/selftests/kselftest_deps.sh          |  2 +-
>    tools/testing/selftests/kvm/Makefile               |  1 -
>    tools/testing/selftests/landlock/Makefile          | 10 +--
>    tools/testing/selftests/lib.mk                     | 38 ------------
>    tools/testing/selftests/net/Makefile               |  1 -
>    tools/testing/selftests/net/mptcp/Makefile         |  1 -
>    tools/testing/selftests/tc-testing/Makefile        |  1 -
>    tools/testing/selftests/timers/adjtick.c           |  2 +-
>    .../testing/selftests/timers/alarmtimer-suspend.c  |  2 +-
>    tools/testing/selftests/timers/change_skew.c       |  2 +-
>    .../testing/selftests/timers/clocksource-switch.c  | 71 ++++++++++++++--------
>    .../testing/selftests/timers/inconsistency-check.c | 32 +++++-----
>    tools/testing/selftests/timers/nanosleep.c         | 18 +++---
>    tools/testing/selftests/timers/raw_skew.c          |  2 +-
>    tools/testing/selftests/timers/skew_consistency.c  |  2 +-
>    tools/testing/selftests/timers/valid-adjtimex.c    |  2 +-
>    tools/testing/selftests/tpm2/settings              |  1 +
>    tools/testing/selftests/vm/Makefile                |  1 -
>    tools/testing/selftests/vm/userfaultfd.c           |  2 +-
>    30 files changed, 111 insertions(+), 145 deletions(-)
>    create mode 100644 tools/testing/selftests/tpm2/settings
> ----------------------------------------------------------------
