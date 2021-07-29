Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230E03DA74C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhG2PRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 11:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhG2PRm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 11:17:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF4760F23;
        Thu, 29 Jul 2021 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627571858;
        bh=PL8vnhHrPx6WNSFPgJipiTrV5cz4ofT9TlJsPYljmiw=;
        h=From:To:Cc:Subject:Date:From;
        b=TZbZm4wf7DH4abusehxZJbx3Dw22jebxp3WWnolDI6NIZw8U0yFVDd6Z6cBQwxtrK
         UrLoy8amOJZP8dwK2OlARXZ6HJc/DZ2u21O+BaGaj3gK+7TT+B4wnoP4bKgymCl/Yo
         hkuz3mZqQ59GDfYfBwttbbFp6aKcIgSsKABscOjEE4iXVTm83zGaoMDBtO4NMJUOfB
         vOEteizcfZRsgnKmAZQrA/4UCLZQeY09nzdGXV9WT7l4nAmA3JmHnnvf6lJt4PY/fa
         9vzLBFmGVF83474Tp8hxLeseqM0o6v4zzAV5sTKogjA4XAtI+v6UYGOCyEvH52EUZk
         5Cl9KqfQq6cJA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] kselftest/arm64: Vector length configuration tests
Date:   Thu, 29 Jul 2021 16:15:14 +0100
Message-Id: <20210729151518.46388-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; h=from:subject; bh=PL8vnhHrPx6WNSFPgJipiTrV5cz4ofT9TlJsPYljmiw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAsX72RqCtKvAZYQIAdFZX7IXpXKqBlIv1rq0Z6lf F/1dUYCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQLF+wAKCRAk1otyXVSH0DjHB/ 47mtmXDGlVEA0oRazEBVGNra0evz6jdQ8YQnLP7ktEkGsiDYQ1huae1EB6+WKxCH9y1VHxIaY7JsXO LgM/PDkzR/2Pf9BtbIsalTvrkOw9/X3BMZvWEPG29R04l1xgtG2REgyTN9lECCJ0B4dCFtp3hru0cT 1j/0y53XU9DXZ0BnE9djEFsQ6ML0FFwZdLh2R9MmBnGCS4zQmIWxq/vxO5tqHTML0lb/YxJQ6+1ZOn ptR6uma8QwDtHTzx3GeaMMU69TBoLJZr5SBVMfszJHTq7B0G3fs6OJkmia3K+5GJ52AoqRhkRk58bu YO9A40KeNRJfGwLbH2frAxsdV673yZ
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

v3:
 - Add BTI landing pads to the asm helper functions.
 - Clean up pipes used to talk to children.
 - Remove another unneeded include.
 - Make functions in the main executable static.
 - Match the newline when parsing vector length from the child.
 - Factor out the fscanf() and fclose() from parsing integers from file
   descriptors.
 - getauxval() returns unsigned long.
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
 tools/testing/selftests/arm64/fp/rdvl.S       |  10 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   8 +
 .../selftests/arm64/fp/sve-probe-vls.c        |   5 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 594 ++++++++++++++++++
 8 files changed, 644 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h
 create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.20.1

