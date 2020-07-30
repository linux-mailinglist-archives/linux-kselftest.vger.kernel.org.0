Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C890233874
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgG3ShD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jul 2020 14:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbgG3ShD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF3C2072A;
        Thu, 30 Jul 2020 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596134223;
        bh=9aa7GFDTeNUgLhP0YwH+lSjSF66FaNUkytsGodVj9jU=;
        h=From:To:Cc:Subject:Date:From;
        b=0u7Nl1GQzQR30vx5T8+l8YRnn9jXVe+AwGxuTdyut94CN336S26tiJSjC7Lce0dj9
         hmLdkJHQ0KgKZ4mwzT4zr664kbY6VJW5LAfZ5jqkGJKma90wvkHb7IBLB9c/jW9tgV
         lpDsHtMSmHKsexVC2Awg3z7QwPQUE2czNCvjKL3c=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] selftests: arm64: Add floating point selftests
Date:   Thu, 30 Jul 2020 19:09:14 +0100
Message-Id: <20200730180920.23527-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series imports a series of tests for FPSIMD and SVE originally
written by Dave Martin to the tree. Since these extensions have some
overlap in terms of register usage and must sometimes be tested together
they're dropped into a single directory. I've adapted some of the tests
to run within the kselftest framework but there are also some stress
tests here that are intended to be run as soak tests so aren't suitable
for running by default and are mostly just integrated with the build
system. There doesn't seem to be a more suitable home for those stress
tests and they are very useful for work on these areas of the code so it
seems useful to have them somewhere in tree.

Mark Brown (6):
  selftests: arm64: Test case for enumeration of SVE vector lengths
  selftests: arm64: Add test for the SVE ptrace interface
  selftests: arm64: Add stress tests for FPSMID and SVE context
    switching
  selftests: arm64: Add utility to set SVE vector lengths
  selftests: arm64: Add wrapper scripts for stress tests
  selftests: arm64: Add build and documentation for FP tests

 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/fp/.gitignore   |   5 +
 tools/testing/selftests/arm64/fp/Makefile     |  17 +
 tools/testing/selftests/arm64/fp/README       | 100 +++
 .../testing/selftests/arm64/fp/asm-offsets.h  |  11 +
 tools/testing/selftests/arm64/fp/assembler.h  |  57 ++
 .../testing/selftests/arm64/fp/fpsimd-stress  |  60 ++
 .../testing/selftests/arm64/fp/fpsimd-test.S  | 482 +++++++++++++
 .../selftests/arm64/fp/sve-probe-vls.c        |  58 ++
 .../selftests/arm64/fp/sve-ptrace-asm.S       |  33 +
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 336 +++++++++
 tools/testing/selftests/arm64/fp/sve-stress   |  59 ++
 tools/testing/selftests/arm64/fp/sve-test.S   | 672 ++++++++++++++++++
 tools/testing/selftests/arm64/fp/vlset.c      | 155 ++++
 14 files changed, 2046 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/.gitignore
 create mode 100644 tools/testing/selftests/arm64/fp/Makefile
 create mode 100644 tools/testing/selftests/arm64/fp/README
 create mode 100644 tools/testing/selftests/arm64/fp/asm-offsets.h
 create mode 100644 tools/testing/selftests/arm64/fp/assembler.h
 create mode 100755 tools/testing/selftests/arm64/fp/fpsimd-stress
 create mode 100644 tools/testing/selftests/arm64/fp/fpsimd-test.S
 create mode 100644 tools/testing/selftests/arm64/fp/sve-probe-vls.c
 create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace.c
 create mode 100755 tools/testing/selftests/arm64/fp/sve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/sve-test.S
 create mode 100644 tools/testing/selftests/arm64/fp/vlset.c


base-commit: 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
-- 
2.20.1

