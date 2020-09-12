Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0232679AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgILLIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgILLI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA2C0613ED
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so9081182pfd.5
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qryMAhh4tCU77jVApdDoFb63yM4c6k01SDqhkwf1rR0=;
        b=lxbnERcXy+J7vWuyRLux24/YF+Scq3YZcjre8kUbR0Fvb4JjXcrDpAuJYIbx0s7Szo
         SCpNE6vcqS6SkUKkfyeHCdjQFgyVa/JW4qT/hBTp7+60WwtB92PGYsy/s6InhaUg0Iqd
         e7QE5NCl5CYO9aCTFnXI0PCpQSxqRvyp3aSGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qryMAhh4tCU77jVApdDoFb63yM4c6k01SDqhkwf1rR0=;
        b=JF4d1ks/iOgIYNCy+jRwsWkUkMbdjq+d+OJc8kIaWDoNnYhuZ+3pT2byauDX3as0gp
         Ekie81XNm6H1UnqVym0CxFJ9jSRWw99KVKEKoXtOSVECLWC6ggOmTOBD/X4x6WwnImfX
         4ghTHyddmNosLdjt+AiK6OroLYKkbkzGj9l31HWzEFFjOc7VqCXz6rpEpLPpQBfXmDyl
         v9158jXsz1YIFSrkxN3/0It1amYdN/8KAMY5nsOnH8Vn3mpjtzxs5HbP8u+pn0gzVEOW
         yiI7sIJHW7TuLO1UBtnMKNYuV1ivRsTJgcp+6k2JbHmmk36jYKgM0vmmTLay/LcUJdel
         GAjw==
X-Gm-Message-State: AOAM531ofXovlwoZds79MZCBYeYZ6oiNOXB49dPTMlFZ8F7FFjinOOpb
        EQcpBhJMbrbEOmxMZE/2kxHdUQ==
X-Google-Smtp-Source: ABdhPJyZOtkAmn+q/X44Pwpnmi6XqAZyxaYzw+q4IoaZx/a0QbSZc5nYuFdBvbPz0fB5B+xl5qPKPA==
X-Received: by 2002:a63:2f43:: with SMTP id v64mr416632pgv.69.1599908904499;
        Sat, 12 Sep 2020 04:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm3964920pgm.40.2020.09.12.04.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
Date:   Sat, 12 Sep 2020 04:08:05 -0700
Message-Id: <20200912110820.597135-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This refactors the seccomp selftest macros used in change_syscall(),
in an effort to remove special cases for mips, arm, arm64, and xtensa,
which paves the way for powerpc fixes.

I'm not entirely done testing, but all-arch build tests and x86_64
selftests pass. I'll be doing arm, arm64, and i386 selftests shortly,
but I currently don't have an easy way to check xtensa, mips, nor
powerpc. Any help there would be appreciated!

(FWIW, I expect to take these via the seccomp tree.)

Thanks,

-Kees


Kees Cook (15):
  selftests/seccomp: Refactor arch register macros to avoid xtensa
    special case
  selftests/seccomp: Provide generic syscall setting macro
  selftests/seccomp: mips: Define SYSCALL_NUM_SET macro
  selftests/seccomp: arm: Define SYSCALL_NUM_SET macro
  selftests/seccomp: arm64: Define SYSCALL_NUM_SET macro
  selftests/seccomp: mips: Remove O32-specific macro
  selftests/seccomp: Remove syscall setting #ifdefs
  selftests/seccomp: Convert HAVE_GETREG into ARCH_GETREG/ARCH_SETREG
  selftests/seccomp: Convert REGSET calls into ARCH_GETREG/ARCH_SETREG
  selftests/seccomp: Avoid redundant register flushes
  selftests/seccomp: Remove SYSCALL_NUM_RET_SHARE_REG in favor of
    SYSCALL_RET_SET
  selftests/seccomp: powerpc: Fix seccomp return value testing
  selftests/seccomp: powerpc: Set syscall return during ptrace syscall
    exit
  selftests/clone3: Avoid OS-defined clone_args
  selftests/seccomp: Use __NR_mknodat instead of __NR_mknod

 .../selftests/clone3/clone3_selftests.h       |  16 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 313 ++++++++++--------
 2 files changed, 184 insertions(+), 145 deletions(-)

-- 
2.25.1

