Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1913D7D31
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhG0SMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 14:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhG0SMX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 14:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB2D36056B;
        Tue, 27 Jul 2021 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627409543;
        bh=7RcIOsMhPqCjVMlALQAqOfz8y3JOmozD0Sg4zco0w48=;
        h=From:To:Cc:Subject:Date:From;
        b=s4ylFIWP1fqekNBfyvC46mDuYk8Nj6IiiRGTsM/dVIkHDgSgSgKEcUblW+pPgWfSr
         aiIWdqOw0wpkOnSB9Kh3UthshXsK9QrZkGJoyV4OHYNbTi6Kl4npnowfmoaVzh0/VJ
         95JkClrQB7FoK62jqAvKs8wd5JBqpCdqOK6AHddnxpU1cFYuGyRuSc4sDZDtCJVOPP
         q6EqPyfWWr8xIduJ9eIUUioscck0cXwqLs4NJKpjwKdDsrThwEYVxhIHwKCZwyYp5e
         DzcJGsJiQhDMUYDSh+SJY3dUwIjdtAGzTs+hTAEHoT1RporeRgA5l6XI3rcFrte3Gw
         Owid66HH10qfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] kselftest/arm64: Vector length configuration tests
Date:   Tue, 27 Jul 2021 19:06:46 +0100
Message-Id: <20210727180649.12943-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; h=from:subject; bh=7RcIOsMhPqCjVMlALQAqOfz8y3JOmozD0Sg4zco0w48=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAEs1hXZZGYAYENQPTGZoDCZyuj19iYSp4ALg7M0g YZNRH5SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQBLNQAKCRAk1otyXVSH0BqEB/ 4gHO01LY2Gi9kS1gGWGTkv/t9Wy/X33yQ7ozp/TEsIOkFQI9vhrGv7LCBtRezubElV8D0neescaBK/ iuPaVZKhxqJkouaR1Y1PFyVmif4kKUAXvDikVcJdZYsMsJPCwnUfMOWDHvz3BYrKPMLziYahCGpEhe muQbJORnLcPwbFGfR9IdAcyqJs1a7LTq6oum4QtoTpXsH0FTRW5zLrwtWiA86scQkdF2CYVDM87Mjg E8sDviLlSV6Tzh2rWJs2gPNuC5WUtWt/TANizgnlDExb0p+JJ74eKswCoxwdD//HWoaH4B0IcDWjOh EAL1YDEDvzuOLwWjxryOks5k+hDz68
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

Mark Brown (3):
  kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
  kselftest/arm64: Validate vector lengths are set in sve-probe-vls
  kselftest/arm64: Add tests for SVE vector configuration

 tools/testing/selftests/arm64/fp/.gitignore   |   2 +
 tools/testing/selftests/arm64/fp/Makefile     |  11 +-
 tools/testing/selftests/arm64/fp/rdvl-sve.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |   9 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   8 +
 .../selftests/arm64/fp/sve-probe-vls.c        |   5 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 578 ++++++++++++++++++
 7 files changed, 624 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h
 create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.20.1

