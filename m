Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3309782A92
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjHUNdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjHUNdT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 09:33:19 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E11B9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:33:15 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-79df1303d01so1055778241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692624794; x=1693229594;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=khLlIHW+Jm6+gOuRPwp6mA1hqc/ytZ1HIVMa6QE2/hc=;
        b=MXqe80sAtCGV+ehrYswoWLd5KZQCoK6YAWu+x7WyF7bblYFwKE8dxoIJCEKNNOqOlJ
         Mt2GOg1xTnUJEsJddpIoaHb68m741jH19GWHZ6/N5iu8aVIXEPbzrOxypYsdTRQNWW1R
         2f1YQZqbibNrPXuxOVZ2kLXGOk83zrkxtXB4EqyU6vm8XW08d195A1t+1nAO/dNyv3Or
         9oQ0M0exaWivUrnn4YHQuODXM5FUQbQHDOGBQmkug+deAvhzv0UYalzocevQ7dbZza1v
         aolc7gU+vocnsbh37DmZ5rKUoH9pH4RGDRsOEdRaHJbWbdz5V+D0j76QZZ4CNQFLGb5w
         5dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624794; x=1693229594;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khLlIHW+Jm6+gOuRPwp6mA1hqc/ytZ1HIVMa6QE2/hc=;
        b=XQhQhyO/ENrlpLPsP/fUM5x1K946HW5sXp71qWXAP+K62pv1tjTW6RHJ6QrBW2ylEK
         KfYQSPQvSdDnNDpEfjpAdI5/9nyjYcFatE9vOmbpSz7ePrjf62TjB+r+HTIpBc0NPx9U
         l/mk5NF+fRKgHND0rTUbYufcGV+lVRsgVwrUrAB+0fc+EHtWICuHdTKD1HZq5vO/+6K0
         yjmZD+JqpuLzAEDbXo3mB0X/Iq441vveNN36hHH0YN+LcgpGoboH8QngZFUxTe2HbOpp
         XSYCNJp2YnCQMzeLnJcllXbDyCb+MhlUNoKN5mJJqBdKijsWhh0rI+9ijVq7ilYi1R0u
         /gMA==
X-Gm-Message-State: AOJu0YwCm0j12XXulo1eTmAdQiX+uipeTxhBjMjUeZUbFN7PGI4Jcr8u
        5iSZSfUTOPP7xXpgU5n56+ddbbY5MTWUdeCOeYRgyA==
X-Google-Smtp-Source: AGHT+IGdiroFpyHjOCjxX3nFiWrenguPGn6R1CMfgDrH4PeozwIcKL/83yaISys0pAnDYUzENf41pAhVnMM9BFjR72s=
X-Received: by 2002:a67:cd99:0:b0:430:e0:ac2e with SMTP id r25-20020a67cd99000000b0043000e0ac2emr6220213vsl.15.1692624794563;
 Mon, 21 Aug 2023 06:33:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Aug 2023 19:03:03 +0530
Message-ID: <CA+G9fYsQBg2SwfAyzyJmkz2kOQa7Ef+NZVnpEwqc4y911DBzVw@mail.gmail.com>
Subject: clang-17: selftests: vdso_standalone_test_x86.c:(.text+0x1e6):
 undefined reference to `memcpy'
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recently we have updated toolchain clang-17 version.

While building selftests vdso following warnings / errors noticed on the
Linux next with clang-17. but pass with gcc-13.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make[4]: Entering directory 'tools/testing/selftests/vDSO'
clang --target=x86_64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=x86_64-linux-gnu -fintegrated-as -std=gnu99 -nostdlib
-fno-asynchronous-unwind-tables -fno-stack-protector \
vdso_standalone_test_x86.c parse_vdso.c \
-o /vDSO/vdso_standalone_test_x86
vdso_standalone_test_x86.c:73:16: warning: unknown attribute
'externally_visible' ignored [-Wunknown-attributes]
   73 | __attribute__((externally_visible)) void c_main(void **stack)
      |                ^~~~~~~~~~~~~~~~~~
1 warning generated.
parse_vdso.c:65:9: warning: using the result of an assignment as a
condition without parentheses [-Wparentheses]
   65 |                 if (g = h & 0xf0000000)
      |                     ~~^~~~~~~~~~~~~~~~
parse_vdso.c:65:9: note: place parentheses around the assignment to
silence this warning
   65 |                 if (g = h & 0xf0000000)
      |                       ^
      |                     (                 )
parse_vdso.c:65:9: note: use '==' to turn this assignment into an
equality comparison
   65 |                 if (g = h & 0xf0000000)
      |                       ^
      |                       ==
parse_vdso.c:206:22: warning: passing 'const char *' to parameter of
type 'const unsigned char *' converts between pointers to integer
types where one is of the unique plain 'char' type and the other is
not [-Wpointer-sign]
  206 |         ver_hash = elf_hash(version);
      |                             ^~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
   59 | static unsigned long elf_hash(const unsigned char *name)
      |                                                    ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of
type 'const unsigned char *' converts between pointers to integer
types where one is of the unique plain 'char' type and the other is
not [-Wpointer-sign]
  207 |         ELF(Word) chain = vdso_info.bucket[elf_hash(name) %
vdso_info.nbucket];
      |                                                     ^~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
   59 | static unsigned long elf_hash(const unsigned char *name)
      |                                                    ^
3 warnings generated.
/usr/bin/x86_64-linux-gnu-ld: /tmp/vdso_standalone_test_x86-31b09f.o:
in function `c_main':
vdso_standalone_test_x86.c:(.text+0x1e6): undefined reference to `memcpy'
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[4]: Leaving directory 'tools/testing/selftests/vDSO'

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230821/testrun/19213783/suite/kselftest-vDSO/test/shardfile-vDSO/details/

Steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/tuxmake_reproducer.sh

tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/config
LLVM=1 LLVM_IAS=1 debugkernel cpupower headers kernel kselftest
modules


--
Linaro LKFT
https://lkft.linaro.org
