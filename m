Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7389761905
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGYM4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjGYM4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 08:56:49 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA110C9
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 05:56:47 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44363f4f128so3709439137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690289806; x=1690894606;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3K1hAL77EV3FRxWnd2RNTvTG5QDf7EWDGIQY4UHons=;
        b=gepNWL2Dbi/KB8KH/eVAkAxBidmJ7rrxP5h5XRpdmreMSz9peNCYbV0eRmwTTwoAXL
         vTizcsUxW9AbwuMLAODGvLeKKA1mUP/uMNFEmYOTPwqlLGMebcO0LVbZApqXOL5w8if5
         fote5no9HawIU6YXfs6Wf76/i2ATNvafO0KR28gdXp/6QaBPU2BCMFEYwQ5zUoo5UuQu
         fuNPauFaF1DnrqjLpXmUpZegOudU6df5GBp2gfCO3FuP1Xx7sP67lZzryQvxxLx0D/d1
         OqQMgKQJKnHtCJmgSSobOlYU0728MlQAOVxm4KEwnPdcrCrUixhSJE95uctuIchL7P0+
         inQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289806; x=1690894606;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3K1hAL77EV3FRxWnd2RNTvTG5QDf7EWDGIQY4UHons=;
        b=f5f6rEpQQUiq+ZOONKOpL/MlkGF/Hx2s2oKQf0LWWRuUmtDoIUuZvk+wW7uFXTulRr
         NPTtKo3DbifF2f7VAjBPWUbg9nsM7RLzRnBfTtSYxLYK87gj+lkiuB5GD7RJHiiXamtr
         cEvqT/kv52UjIMZILlRbRZ2TjGcX7H8LG0o2ss1cMyc6OE5B9YFw023z7Zbu3YpB8O9E
         O4zphwsmr2yRzDvYvMHi3NobzV8fo+lKUAfFGsGyIDpOAXS5PJozX7/UwEB2Z1zV4X7T
         GDwdfnY4oTuSboS8LBsuTc1Cvt0Km9yW23HfYqHAXLlUjnNC6LgAVpMg9pA/nc5gx19j
         BkXg==
X-Gm-Message-State: ABy/qLbsRljP8hqSeVZ3KMaTkbc+bJnVgYmHRWZ2xTSyBHXUCyoNHmG+
        Ehw9JLSjgHE7Om28WAWcVIrq72iYRBePDBUs2u1E8bm5O/RdvltHLzQ=
X-Google-Smtp-Source: APBJJlHqOV1zxGkAtkv8AVZXqJkk9cOFVFd6idRMfTp5RA9uM0oi5pndgFDfSiRKqVMxeZgSEzTrECtj5tOLDWjm89s=
X-Received: by 2002:a05:6102:c02:b0:443:74a8:b7fd with SMTP id
 x2-20020a0561020c0200b0044374a8b7fdmr674386vss.9.1690289806097; Tue, 25 Jul
 2023 05:56:46 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 18:26:34 +0530
Message-ID: <CA+G9fYus3Z8r2cg3zLv8uH8MRrzLFVWdnor02SNr=rCz+_WGVg@mail.gmail.com>
Subject: selftests: arm64: za-fork.c: kselftest.h:123:2: error: call to
 undeclared function 'setvbuf'; ISO C99 and later do not support implicit
 function declarations
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests: arm64: za-fork.c build failed with clang-16 due to below
warnings / errors on Linux next-20230725.

Build failed for:
  - selftests: arm64: za-fork
  - selftests: arm64: za-ptrace

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as
-fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
-include ../../../../include/nolibc/nolibc.h -I../..\
-static -ffreestanding -Wall za-fork.c
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/arm64/fp/za-fork-asm.o
-o /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/arm64/fp/za-fork
In file included from <built-in>:1:
In file included from ./../../../../include/nolibc/nolibc.h:97:
In file included from ./../../../../include/nolibc/arch.h:25:
./../../../../include/nolibc/arch-aarch64.h:178:35: warning: unknown
attribute 'optimize' ignored [-Wunknown-attributes]
void __attribute__((weak,noreturn,optimize("omit-frame-pointer")))
__no_stack_protector _start(void)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from za-fork.c:12:
../../kselftest.h:123:2: error: call to undeclared function 'setvbuf';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
        setvbuf(stdout, NULL, _IOLBF, 0);
        ^
../../kselftest.h:123:24: error: use of undeclared identifier '_IOLBF'
        setvbuf(stdout, NULL, _IOLBF, 0);
                              ^
1 warning and 2 errors generated.
make[5]: Leaving directory '/builds/linux/tools/testing/selftests/arm64/fp'


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/build.log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/


steps to reproduce:
---
# tuxmake \
 --runtime podman \
 --target-arch arm64 \
 --toolchain clang-16 \
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/config
LLVM=1 LLVM_IAS=1 dtbs dtbs-legacy headers kernel kselftest modules


--
Linaro LKFT
https://lkft.linaro.org
