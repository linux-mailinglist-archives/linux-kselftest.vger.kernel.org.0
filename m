Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C344BAC83
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiBQWY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 17:24:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiBQWY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 17:24:26 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5F28E20
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 14:24:10 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h16so5427664iol.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=+UCLiLpbu9yxs/LUCntyXYgTWljHDkuh6IEZLpRrja4=;
        b=BssYb1O3urXn2zOuev6luSlaImaAxmPUJYopHspymyl+8zkm/sUxCS9M6P83PMJlnh
         czDDKdyT6wNpRgXioDXvqA2OjD97S4djhORmu9oFE/MCtJgu+egTWLwoSNsg9hcGVkKx
         nxf21UDpTIswslxk886R4rpwN1uN0N3BnEz9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=+UCLiLpbu9yxs/LUCntyXYgTWljHDkuh6IEZLpRrja4=;
        b=sbpic5GTjejwnporZPNYa4QNzFRLa3LW+hmCh4cO91wfP9T0mGTCKXEPhdqshAVA1t
         6qofH+tvdcUrC0eJqW0zZlAQZAeK6h2YdHWrmqjTaOG3vUXKsOzoI4UekNlAP+lpj2Jr
         2KVA4UqBddADNt5S/BYM2A2zd+MWstZIEyHs0g/3qRgvkuzAx89tKKoMX4w0TGtPyqqy
         VxmMPiH+YtwSgxDIyBlkuIs7pg4CfeGxIc2cy3ioCcVvZUlSETaAClFLJZ4BJHqy45sQ
         WK7BbFrrcRdDGfqys8NcXXDLVLa0kAIvqVPpj6v9qWzBQ2koEYIh0t7LtmwLAaorUfxm
         BgFA==
X-Gm-Message-State: AOAM530eQv9BJmNv0HTjJ6FRENMkRr+Mh0/CLBZ6C7tPCFqQm1q80H1y
        HLge6FOD40ath/EHIkAoObsZEw==
X-Google-Smtp-Source: ABdhPJxuO8OABRvc6Tf7zjz8V2OszbI+q8F37UB9WD7C8tVhf6wMGDTfhzAjjoKNYHAiCNimv3iE1A==
X-Received: by 2002:a02:5b0a:0:b0:30f:60e4:b9ab with SMTP id g10-20020a025b0a000000b0030f60e4b9abmr3184609jab.189.1645136650188;
        Thu, 17 Feb 2022 14:24:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d2sm2842914iog.42.2022.02.17.14.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 14:24:09 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.17-rc5
Message-ID: <1b759083-880e-8acc-239b-bba42ec09551@linuxfoundation.org>
Date:   Thu, 17 Feb 2022 15:24:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------04EEBBDFE8B4287E80F46078"
Content-Language: en-US
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------04EEBBDFE8B4287E80F46078
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.17-rc5.

This Kselftest fixes update for Linux 5.17-rc5 consists of fixes
to ftrace, exec, and seccomp tests build, run-time and install
bugs. These bugs are in the way of running the tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 183f80fd72db42c9cc483aa7a5e8e881355d0b03:

   selftests/ir: fix build with ancient kernel headers (2022-02-04 13:14:41 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc5

for you to fetch changes up to 6fec1ab67f8d60704cc7de64abcfd389ab131542:

   selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT (2022-02-14 13:28:17 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.17-rc5

This Kselftest fixes update for Linux 5.17-rc5 consists of fixes
to ftrace, exec, and seccomp tests build, run-time and install
bugs. These bugs are in the way of running the tests.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
       selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT

Muhammad Usama Anjum (1):
       selftests/exec: Add non-regular to TEST_GEN_PROGS

Sherry Yang (1):
       selftests/seccomp: Fix seccomp failure by adding missing headers

  tools/testing/selftests/exec/Makefile                                | 4 ++--
  tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc | 2 +-
  tools/testing/selftests/seccomp/Makefile                             | 2 +-
  3 files changed, 4 insertions(+), 4 deletions(-)
----------------------------------------------------------------

--------------04EEBBDFE8B4287E80F46078
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.17-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.17-rc5.diff"

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 12c5e27d32c1..2d7fca446c7f 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,8 +3,8 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script non-regular
-TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
+TEST_PROGS := binfmt_script
+TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index e96e279e0533..25432b8cd5bd 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="do_softirq"
+FUNC2="scheduler_tick"
 
 ALL_FUNCS="#### all functions enabled ####"
 
diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 0ebfe8b0e147..585f7a0c10cb 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/
 LDFLAGS += -lpthread
 
 TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark

--------------04EEBBDFE8B4287E80F46078--
