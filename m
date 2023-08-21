Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AFF782ACE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjHUNsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 09:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjHUNsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 09:48:08 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60689EC
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:48:05 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-447c7607b72so1269970137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692625684; x=1693230484;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jLB+9REAygYY0DOuwfBq/jxAg+N5aJcW36e9CeI5Mwo=;
        b=x/n3TBl+cj7w/o3N8b3V2L6LF5VESVaz1Xd7sOEF3etaG0J5JiDWG9qHfQX+0EsDGY
         gYn1VMPMXIpZnlRlhBVpR0O7QM+p+zEyMvRmSKyXfj8/Gr9wt54zuwipPo9yDYW/c4Hp
         eEz2AyojrFI7xuATX8bTAD/AZIRnlLaOD0L86CMWmFV5jD3EtQHF16sPLFzQX83KWAad
         t17/FJwFzTdykbYjwEFSa6UcEKzjm7GWfNFjpFJZJK7Du0g1W/3bGkeq5Aq9f/C7usTR
         9UtQAnW0+ZqgHbzNTbiHT4gJBAFHg307w3007gSDcF0BHfLuIdI8gcsPBSBGT/XF1omw
         cB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625684; x=1693230484;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLB+9REAygYY0DOuwfBq/jxAg+N5aJcW36e9CeI5Mwo=;
        b=E+8lp8dSZgwn11wJ1bdF1b6z6l6mz2v4NnI4WqaRxHhGb9iWdFpkVSlGDUPmxSGyRR
         bKZLA6rnOTONJvGCZE0sHrj9TV5TzARSIfKwFBuvamY1j16EckadEFUs5FBTzln1ooB9
         /U66PTDf6z9CUhj+pXcpDYbHKKzYYK70+wk25GRHlWlSWyCV0ZVpp7nAf/BV2ZBBEPvJ
         gmrA2VQ7fQk6yNcbq5Lq4LKGYPrVAF03WOAqNQGfhGVe8fXRgKDdcsK7y4oDHNKBWxOm
         DL2V9p+N+MD5bkE3ne/OeR2pFF03rP9u+hQb9z3EZOiLK5sUfN2uEfnOl/RL1TYEPDGK
         bZ+g==
X-Gm-Message-State: AOJu0YwLctT8L9CPzbYQ0nvCqarxp9wCEynN3jXguEW9ARfIgBkB+7ow
        eu8+cpdVibXYu36l4HTE4qoSuGrUQWuQL8iDwd90JA==
X-Google-Smtp-Source: AGHT+IF9fvjUB+rS/XJKPseqYgUHXMa08uiTMMNhG1uODld2kPDyU4fq0bYuoaefzZZ92fcnfawvUwbvDXJB3QYeYHY=
X-Received: by 2002:a67:f1ce:0:b0:44d:50f8:f with SMTP id v14-20020a67f1ce000000b0044d50f8000fmr1793441vsm.17.1692625684430;
 Mon, 21 Aug 2023 06:48:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Aug 2023 19:17:53 +0530
Message-ID: <CA+G9fYt2PZd7Zj5ndPL+LBstGvoVwyCLpFucOY-7UNajvAqRLQ@mail.gmail.com>
Subject: clang: error: cannot specify -o when generating multiple output files
To:     clang-built-linux <llvm@lists.linux.dev>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recently we have updated the toolchain clang-17 version.

While building selftests filesystems/binderfs, openat2, resctrl and x86
following warnings / errors noticed on the Linux next with clang-17.
But pass with gcc-13.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build logs:
========
binderfs_test
clang: error: cannot specify -o when generating multiple output files
...
openat2/openat2_test
clang: error: cannot specify -o when generating multiple output files
...
resctrl/resctrl_tests
clang: error: cannot specify -o when generating multiple output files
...
make[4]: Entering directory 'tools/testing/selftests/x86'
clang --target=x86_64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=x86_64-linux-gnu -fintegrated-as -m64 -o
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/x86/single_step_syscall_64
-O2 -g -std=gnu99 -pthread -Wall -isystem
/home/tuxbuild/.cache/tuxmake/builds/1/build/usr/include -no-pie
-DCAN_BUILD_64 single_step_syscall.c helpers.h -lrt -ldl
clang: error: cannot specify -o when generating multiple output files
make[4]: *** [Makefile:78:
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/x86/single_step_syscall_64]
Error 1


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230821/testrun/19213760/suite/kselftest-x86/test/shardfile-x86/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230821/testrun/19213728/suite/kselftest-openat2/test/shardfile-openat2/details/
 -

Steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/tuxmake_reproducer.sh

tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/config
LLVM=1 LLVM_IAS=1 debugkernel cpupower headers kernel kselftest
modules


--
Linaro LKFT
https://lkft.linaro.org
