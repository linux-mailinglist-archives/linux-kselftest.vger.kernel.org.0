Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CD656BA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 15:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiL0OVG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 09:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiL0OVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 09:21:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3A64DD
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 06:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C544861169
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 14:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF78CC433D2;
        Tue, 27 Dec 2022 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150862;
        bh=1XAcrcfyXE2/83zp7bpH4uJkMg29hwlnxwK/pLrqMgA=;
        h=From:Subject:Date:To:Cc:From;
        b=uQ2TjkDEIkD5ajlmrnXihqMYDlNVaYovWmYitd13pgC6gcy/Kel1OyXt22Kh5b0kZ
         LUzrQnd/ka/0IYxLTp3KfMYvAR6YaBYw6jyQ4TlEHBcR6hLlXj1CpYuIYqAeHK7Rqn
         c8ZMIg7R2ey9cVUmyukW05W4fNNP5CcaDS+9YTW4Zb8Y4xPcpmf7Vb+MM0bu5an3C5
         q5h8uiiasJriGAS1WDSDaRWuEmgZdxppOco44fQkljYCyUl4wT/zDFJqsiqSfptrpN
         8t2nieBvcpvqAzxLq+BvqOBOvAKUSTurQQSLdADAFQ0INtcpjdYB7rAHYuaUL+dr0X
         rGGIw3Lod61Rg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] arm64/signal: Support TPIDR2
Date:   Tue, 27 Dec 2022 14:20:40 +0000
Message-Id: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADj/qmMC/x2NQQ6CMBAAv2J6toBFFDwZ9QMc1XjYwlI2hpZsq
 zEh/N3CcTKZzCQ8MqEXp80kGL/kydkI+XYjmh6sQUltZKEypXYqKyXwcNjLMFLLSnoysuy0rvKj
 KtoSRcw0eJSawTb9EjomQzYdwAfkxY+MHf3W5fMVuWM3yNAzwjq650V9e1wgq83VplU4e2K0kDg
 2yect5vkPN3CyXrMAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1XAcrcfyXE2/83zp7bpH4uJkMg29hwlnxwK/pLrqMgA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqv9I1ajfhKPHbuSfIWwo/FtNl3/WTxuqFbHg2iQW
 GxITssWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6r/SAAKCRAk1otyXVSH0O6aB/
 9tna8AmGTml1pxajctbY0HbmVtmfWHkvzr2xogaSFGQ2XGXkQ1c3oPE1sgO+X1U6CMzc41kfq0lROW
 Ou7SJBRno5kBByHjPjTKqEr2uAsbFXup211ZJ1s8ZElIwzDoGTQGOgZgBTUXxYo0xekdM5dzUttkiS
 f+/PdE13BtF5E77fBbXVaIr1vtGcLpS0TMN5gVTdNa+8636L4gR/MzPTMADIQGa8vPUlv1uFOj8yR2
 0M9E/dFMYBWZtWkQFasUFRe7icOD+RrSgUtZC/kv6hHqWxoJx/wcUxK4mLSr4nbYYTI7OS50ADHhY6
 0/c8uOL+cSEUwvsZYtxckEJ5Nwzsej
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When SME support was merged support for TPIDR2 in signal frames was
omitted, meaning that it was not possible for signal handers to inspect
or modify it. This will present an issue for programs using signals to
implement lightweight threads so let's provide access to TPIDR2 in
signal handlers.

Implement a new record type for TPIDR2 using the same format as we use
for ESR and add coverage to make sure that this appears in the signal
context as expected.  Due to TPIDR2 being reserved for libc we only
validate that the value is unchanged, meaning we're likely to just be
validating the default value of 0 on current systems. I have tested with
a modified version that sets an explicit value.

v3:
 - Rebase onto v6.2-rc1.
v2:
 - Rebase onto v6.1-rc3.
 - Change the signal frame magic to 0x54504902 (TPI).

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (4):
      arm64/sme: Document ABI for TPIDR2 signal information
      arm64/signal: Include TPIDR2 in the signal context
      kselftest/arm64: Add TPIDR2 to the set of known signal context records
      kselftest/arm64: Add test case for TPIDR2 signal frame records

 Documentation/arm64/sme.rst                        |  3 +
 arch/arm64/include/uapi/asm/sigcontext.h           |  8 ++
 arch/arm64/kernel/signal.c                         | 59 ++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/testcases/testcases.c   |  4 +
 .../arm64/signal/testcases/tpidr2_siginfo.c        | 90 ++++++++++++++++++++++
 6 files changed, 165 insertions(+)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221208-arm64-tpidr2-sig-8fbb93725d8e

Best regards,
-- 
Mark Brown <broonie@kernel.org>
