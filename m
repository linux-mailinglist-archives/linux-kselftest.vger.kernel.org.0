Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264ED3DEFB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhHCOHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 10:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhHCOHM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F005160F46;
        Tue,  3 Aug 2021 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999621;
        bh=M6eorEJRReow7oVYrgE5jU5XJOAHXdHNNoKpQRlULRE=;
        h=From:To:Cc:Subject:Date:From;
        b=jj9UohuHMkpY2YuzWcCm18ZkyS8+wHhfQkt9zd5RHpS6+Ca945YOLDTKsP59GcQyh
         Cro1y83ymFXq+eGbEoMZveg7RGjjPjm/gOtw974yMcLwfzv5hLE2QJO8SKfTNOL23G
         IyjbixrB1jzrAR+N0OIjieTI7cnBwa6S+orWWUPnnSPjAiThesz3/NSQ7C+Bqd4RoZ
         TywfUn1X17VfD1hsEJX5w6haDN2soEmSdeJHrFrwlKY45Mp1nwtgtO6+hINeibLrcr
         Eb6YU0zNcBhKAK9q97tfi7Iwd4Wi+Vk8gWsyYYEj980tlsZzNN5sLfg4nkSyvsDbpp
         sO+qPufZC4aKA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/4] kselftest/arm64: Vector length configuration tests
Date:   Tue,  3 Aug 2021 15:04:46 +0100
Message-Id: <20210803140450.46624-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273; h=from:subject; bh=M6eorEJRReow7oVYrgE5jU5XJOAHXdHNNoKpQRlULRE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhCUz9m81xI/MAyY9c11vvl1WsDwoutDa5U0wj0Ugj qHtgx4eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQlM/QAKCRAk1otyXVSH0DqsB/ wKhj8OXiUP56nsNmDbO5uwduiMfZtG80/fXx5B+0Ol2wmjSiTVyfGVVEvZIOBAxXt2ShauV09qbabz 5EoEqRXFEQGhTqwWOgxfL5dx3Yi8bM2KAOyD9p1fS1GC27++TUphyPHj8/CcJxYNtcIXE19A5t3422 1aDrfJcFRpdM6m9Aqx1azFNhMTVLG+y/ZUHdEfSuueLkiQ5YmVwoSBrRttX6wdsxKkQvCAJnMhZBYm 3kQw8xKxTV3qicexm1ZCWjmAU8RIUwQB8cwU1Zc/AjdbxvNbfY4M2Scc+EtWmfs61OZeYZLgP1uM4m M+oWnLHwi8pIoCW/BQSsVUpU1gPkGA
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

v5:
 - Fix a potentially uninialized variable case.
 - Clarify an error message.
 - Add TODO.
v4:
 - Fix fscanf() format string handling to properly confirm the newline.
 - Pull fclose() out of stdio read helper.
 - Change style of child monitoring loop.
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
 tools/testing/selftests/arm64/fp/TODO         |   4 +
 tools/testing/selftests/arm64/fp/rdvl-sve.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |  10 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   8 +
 .../selftests/arm64/fp/sve-probe-vls.c        |   5 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 593 ++++++++++++++++++
 8 files changed, 644 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h
 create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.20.1

