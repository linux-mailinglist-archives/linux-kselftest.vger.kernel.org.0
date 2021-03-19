Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACE342286
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCSQyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:56790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhCSQxm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8522B101E;
        Fri, 19 Mar 2021 09:53:42 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FFA3F70D;
        Fri, 19 Mar 2021 09:53:40 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 00/11] kselftest/arm64: mte: Fix feature detection and compilation
Date:   Fri, 19 Mar 2021 16:53:23 +0000
Message-Id: <20210319165334.29213-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When trying to run the arm64 MTE (Memory Tagging Extension) selftests
on a model with the new FEAT_MTE3 capability, the MTE feature detection
failed, because it was overzealously checking for one exact feature
version only (0b0010). Trying to fix that (patch 06/11) led me into the
rabbit hole of userland tool compilation, which triggered patches
01-05/11, to let me actually compile the selftests on an arm64
machine running Ubuntu 20.04. Before I actually fixed that, I tried some
other compiler and distro; patches 07 and 08 are my witnesses.
Then I got brave and tried clang: entering patches 09/11 and 10/11.
Eventually I tried to run the whole thing on that model again, and,
you guessed it, patch 11/11 concludes this apparent "2 minute job".

Eventually I can now compile the mte selftests on Ubuntu 20.04 with both
the native gcc and clang without warnings, also with some custom made
cross compiler. And they even run now!

Please have a look, also you may try to compile it on your setup, if you
feel adventurous:
$ make -C tools/testing/selftests TARGETS=arm64 ARM64_SUBTARGETS=mte

Cheers,
Andre

Andre Przywara (11):
  kselftest/arm64: mte: Fix compilation with native compiler
  kselftest/arm64: mte: Fix pthread linking
  kselftest/arm64: mte: ksm_options: Fix fscanf warning
  kselftest/arm64: mte: user_mem: Fix write() warning
  kselftest/arm64: mte: common: Fix write() warnings
  kselftest/arm64: mte: Fix MTE feature detection
  kselftest/arm64: mte: Use cross-compiler if specified
  kselftest/arm64: mte: Output warning about failing compiler
  kselftest/arm64: mte: Makefile: Fix clang compilation
  kselftest/arm64: mte: Fix clang warning
  kselftest/arm64: mte: Report filename on failing temp file creation

 tools/testing/selftests/arm64/mte/Makefile    | 15 +++++--
 .../selftests/arm64/mte/check_ksm_options.c   |  5 ++-
 .../selftests/arm64/mte/check_user_mem.c      |  3 +-
 .../selftests/arm64/mte/mte_common_util.c     | 39 +++++++++++--------
 4 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.17.5

