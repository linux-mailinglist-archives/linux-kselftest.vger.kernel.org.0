Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98DB7939E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 12:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbjIFK3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 06:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjIFK3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 06:29:49 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3762E47
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 03:29:44 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7a2ab581cb1so1334530241.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693996183; x=1694600983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=14tABX8v9DzRI8vQhmxyZH1rPqnsC0/wtKNBEqsNL9E=;
        b=qgMoEWCcEc3N2kulOWVDfi9PZZKSJguhyD6PGkdFU6WDVA+G7Q3UgJudq73UVJPbJm
         WKh+agt2J01aAsw5iV9eJgcG6e79gbwjkU8d6ZV8vsemtzZUxjFZB5ufR1n2/y8+FOJt
         ocyJXrazFkqD2GslEQSk0C53CeGF3HI1uvTchpeJfYtg2Fy6HCtXkcq4IK66E/tVTxCJ
         t8RjRDN/2Rv/BYS8RFrV7TcCnyDG4KAU3U1YJWlirqDvo3AZkyYjQ5PRbXbzatxTYjbl
         6ya+V4nPQWl+B0zxJe/EHQFpEmefDB7WsGbsbwtQ+UpzSlSFoxh94OxqITnAK+JOoOLJ
         qXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996183; x=1694600983;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14tABX8v9DzRI8vQhmxyZH1rPqnsC0/wtKNBEqsNL9E=;
        b=NVhr7Zjgh+8/Ykf82exPO4e1jVRod1AygYkXGqKq++ySNEzzPjjXfm1aasz+At0mJk
         tHt5QMgE5a+PJNW0C50hf0FaNjYFgbtNG7BVyqel4/7XrVQtlvh2FaZcnECovo1tf5uy
         XN+HYHvMxFQMYVMkk6t3Li/k8NPoO/83NMrI+DioOqMXzCBzvIVf8HeO9N2+SQ+0LqHL
         rsmtOIoDL6ABzgnzFkVGXySl3oF9wNnI4sbgf0HbgmQyFrZAvC70LV3flZZuv4Ms5Bhr
         tYn3mh7r6t/zcy16v/4wiC1wL3FXssiOiUBkypGNCmVBYiMPB2Vc2s/GujikiR7YU5f8
         fWIg==
X-Gm-Message-State: AOJu0YzC0//G1jT1jpYx7JS9g4SDTLMBFjX8sgh5GK5mYHM8VPqhc5B7
        KoWOfv9WIf3CNJ4nfcjN8h/+nWoB6I12TLVcHbKlW8ZJuWkAe2Rg5bjSzg==
X-Google-Smtp-Source: AGHT+IGTFUFDZV/w/ok9OdXf5klp6eJ37RU5Fa69bLIG8TiI4rI3Kzw7Q9EyuRnMTxSYasY7LyaFxDZCXR10IM+gV4Q=
X-Received: by 2002:a67:ff83:0:b0:44d:5b62:bcd5 with SMTP id
 v3-20020a67ff83000000b0044d5b62bcd5mr2639843vsq.23.1693996183486; Wed, 06 Sep
 2023 03:29:43 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Sep 2023 15:59:32 +0530
Message-ID: <CA+G9fYuugZ0OMeS6HvpSS4nuf_A3s455ecipGBvER0LJHojKZg@mail.gmail.com>
Subject: selftests: user_events: Test terminated by assertion
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftests: user_events tests failed on all devices and all architectures.

Test log:
---------
kselftest: Running tests in user_events
TAP version 13
1..4
# timeout set to 90
# selftests: user_events: ftrace_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           user.register_events ...
# # ftrace_test.c:210:register_events:Expected -1 (-1) != self->status_fd (-1)
# # register_events: Test terminated by assertion
# #          FAIL  user.register_events
# not ok 1 user.register_events
# #  RUN           user.write_events ...
# # ftrace_test.c:210:write_events:Expected -1 (-1) != self->status_fd (-1)
# # write_events: Test terminated by assertion
# #          FAIL  user.write_events
# not ok 2 user.write_events
# #  RUN           user.write_empty_events ...
# # ftrace_test.c:210:write_empty_events:Expected -1 (-1) !=
self->status_fd (-1)
# # write_empty_events: Test terminated by assertion
# #          FAIL  user.write_empty_events
# not ok 3 user.write_empty_events
# #  RUN           user.write_fault ...
# # ftrace_test.c:210:write_fault:Expected -1 (-1) != self->status_fd (-1)
# # write_fault: Test terminated by assertion
# #          FAIL  user.write_fault
# not ok 4 user.write_fault
# #  RUN           user.write_validator ...
# # ftrace_test.c:210:write_validator:Expected -1 (-1) != self->status_fd (-1)
# # write_validator: Test terminated by assertion
# #          FAIL  user.write_validator
# not ok 5 user.write_validator
# #  RUN           user.print_fmt ...
# # ftrace_test.c:210:print_fmt:Expected -1 (-1) != self->status_fd (-1)
# # print_fmt: Test terminated by assertion
# #          FAIL  user.print_fmt
# not ok 6 user.print_fmt
# # FAILED: 0 / 6 tests passed.
# # Totals: pass:0 fail:6 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: user_events: ftrace_test # exit=1
# timeout set to 90
# selftests: user_events: dyn_test
# TAP version 13
# 1..4
# # Starting 4 tests from 1 test cases.
# #  RUN           user.basic_types ...
# # dyn_test.c:157:basic_types:Expected -1 (-1) != parse(&self->check,
\"u:__test_event u64 a\") (-1)
# # basic_types: Test terminated by assertion
# #          FAIL  user.basic_types
# not ok 1 user.basic_types
# #  RUN           user.loc_types ...
# # dyn_test.c:181:loc_types:Expected -1 (-1) != parse(&self->check,
\"u:__test_event __data_loc char[] a\") (-1)
# # loc_types: Test terminated by assertion
# #          FAIL  user.loc_types
# not ok 2 user.loc_types
# #  RUN           user.size_types ...
# # dyn_test.c:189:size_types:Expected -1 (-1) != parse(&self->check,
\"u:__test_event struct custom a 20\") (-1)
# # size_types: Test terminated by assertion
# #          FAIL  user.size_types
# not ok 3 user.size_types
# #  RUN           user.matching ...
# # dyn_test.c:199:matching:Expected -1 (-1) !=
check_match(&self->check, \"__test_event u32 a\", \"__test_event u32
a\", &match) (-1)
# # matching: Test terminated by assertion
# #          FAIL  user.matching
# not ok 4 user.matching
# # FAILED: 0 / 4 tests passed.
# # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: user_events: dyn_test # exit=1
# timeout set to 90
# selftests: user_events: perf_test
# TAP version 13
# 1..2
# # Starting 2 tests from 1 test cases.
# #  RUN           user.perf_write ...
# # perf_test.c:117:perf_write:Expected -1 (-1) != self->data_fd (-1)
# # perf_write: Test terminated by assertion
# #          FAIL  user.perf_write
# not ok 1 user.perf_write
# #  RUN           user.perf_empty_events ...
# # perf_test.c:117:perf_empty_events:Expected -1 (-1) != self->data_fd (-1)
# # perf_empty_events: Test terminated by assertion
# #          FAIL  user.perf_empty_events
# not ok 2 user.perf_empty_events
# # FAILED: 0 / 2 tests passed.
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 3 selftests: user_events: perf_test # exit=1
# timeout set to 90
# selftests: user_events: abi_test
# TAP version 13
# 1..4
# # Starting 4 tests from 1 test cases.
# #  RUN           user.enablement ...
# # abi_test.c:106:enablement:Expected 0 (0) ==
reg_enable(&self->check, sizeof(int), 0) (-1)
# # enablement: Test terminated by assertion
# #          FAIL  user.enablement
# not ok 1 user.enablement
# #  RUN           user.bit_sizes ...
# # abi_test.c:126:bit_sizes:Expected 0 (0) ==
reg_enable(&self->check, sizeof(int), 0) (-1)
# # bit_sizes: Test terminated by assertion
# #          FAIL  user.bit_sizes
# not ok 2 user.bit_sizes
# #  RUN           user.forks ...
# # abi_test.c:154:forks:Expected 0 (0) == reg_enable(&self->check,
sizeof(int), 0) (-1)
# # forks: Test terminated by assertion
# #          FAIL  user.forks
# not ok 3 user.forks
# #  RUN           user.clones ...
# # abi_test.c:212:clones:Expected 0 (0) == reg_enable(&self->check,
sizeof(int), 0) (-1)
# # clones: Test terminated by assertion
# #          FAIL  user.clones
# not ok 4 user.clones
# # FAILED: 0 / 4 tests passed.
# # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0
not ok 4 selftests: user_events: abi_test # exit=1


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230906/testrun/19717988/suite/kselftest-user_events/test/user_events_abi_test/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230906/testrun/19717988/suite/kselftest-user_events/test/user_events_abi_test/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2V0Oq00RB2Cvog83Dw4Gg6a4Rtj/

--
Linaro LKFT
https://lkft.linaro.org
