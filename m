Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92583D9345
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhG1QeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhG1QeI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC6160F9B;
        Wed, 28 Jul 2021 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627490046;
        bh=fCHNswalWnKKT4wRuVuMlstt6Pv0dPNesVKNE64giRo=;
        h=From:To:Cc:Subject:Date:From;
        b=unDImntDPXxrdzerGWr7WwRnz+NTqL+QY4KJJibElwPxrWmfLf7F9KVWOaw7RhHRy
         wSrOUsnmio1HZWLrvOu6Tm2RrBQnImYoYKhP+BMifXctVxVyr58H+mCXDx6kfsnflJ
         tcpj1D3qOq72BnFnD4e+TWNcvBpj+TXPGTbdxxy3jeNHlfEVK3ly8kWAPXtrQcDBt6
         tItLbmBRzt/fyNeGPH2/nsjYeaoDKBZs8PS5mfjq9WMsnRqYMsgHHbOHINKY0bovK+
         viKDm4Em8vA6WsJ+2L+EoFyHpTu75BcHZVq0IuCSRUkOeoefc35xQySk4IfkceeOgv
         4b+Eji9LpFXyw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Vector length configuration tests
Date:   Wed, 28 Jul 2021 17:33:14 +0100
Message-Id: <20210728163318.51492-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625; h=from:subject; bh=fCHNswalWnKKT4wRuVuMlstt6Pv0dPNesVKNE64giRo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAYbI/iHcjDm2Tk8M4LY+hjzqmh4pI2kOIr4Y2t6l ZYKsrqKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQGGyAAKCRAk1otyXVSH0DOkB/ 9n+Zx3xlvOIZ/r8A08bzH3/nSs+N7OAYdK4MU2rwVBuFAAN5g8ZnzdcgQuzylOsyNjgkVumt6sP7rf n2+0BA22WjTH8kCUIXtldAEzuzJhSbur0hitkiM3zYVMxMdV+Oy6RQv2WCsx3UeRp3OrReHRTLHMVq /fyEqcQ9TGwRMYBuZFroldhImL8XPPUwv+yT7fqTSz0WwB9b3Dd6px1FUZW1aW0m/xZd5/CnLlEyvW Tly7hmMHpv3hYDIY+eQkKodoZpyBblPJbN5EAVnifASiMKu40n3dviQBj2TC3wzOMXK1lYVuwz9rC1 r8z+VHvtoyzMKlHQZ9TPlRx1AtoHXI
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we don't have full automated tests for the vector length
configuation ABIs offered for SVE, we have a helper binary for setting
the vector length which can be used for manual tests and we use the
prctl() interface to enumerate the vector lengths but don't actually
verify that the vector lengths enumerated were set.

This patch series provides a small helper which allows us to get the
currently configured vector length using the RDVL instruction via either
a library call or stdout of a process and then uses this to both add
verification of enumerated vector lengths to our existing tests and also
add a new test program which exercises both the prctl() and sysfs
interfaces.

In preparation for the forthcomng support for the Scalable Matrix
Extension (SME) [1] which introduces a new vector length managed via a
very similar hardware interface the helper and new test program are
parameterised with the goal of allowing reuse for SME.

[1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/scalable-matrix-extension-armv9-a-architecture

v2:
 - Tweak log message on failure in sve-probe-vls.
 - Stylistic changes in vec-syscfg.
 - Flush stdout before forking in vec-syscfg.
 - Use EXIT_FAILURE.
 - Use fdopen() to get child output.
 - Replace a bunch of UNIX API usage with stdio.
 - Add a TODO list.
 - Verify that we're root before testing writes to /proc.

Mark Brown (4):
  kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
  kselftest/arm64: Validate vector lengths are set in sve-probe-vls
  kselftest/arm64: Add tests for SVE vector configuration
  kselftest/arm64: Add a TODO list for floating point tests

 tools/testing/selftests/arm64/fp/.gitignore   |   2 +
 tools/testing/selftests/arm64/fp/Makefile     |  11 +-
 tools/testing/selftests/arm64/fp/TODO         |   3 +
 tools/testing/selftests/arm64/fp/rdvl-sve.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |   9 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   8 +
 .../selftests/arm64/fp/sve-probe-vls.c        |   5 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 580 ++++++++++++++++++
 8 files changed, 629 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h
 create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.20.1

