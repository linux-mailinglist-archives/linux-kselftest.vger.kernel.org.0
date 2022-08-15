Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC2592FF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHONdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiHONct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D41902F
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E773460EC3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D78C433C1;
        Mon, 15 Aug 2022 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570367;
        bh=2D/qJVEPKZtjtenfb2kXhX2LtUPs45kll/5STRY3OSs=;
        h=From:To:Cc:Subject:Date:From;
        b=s/1BgxDejeV3Ibp/UP7DcWa3v4P52nbjyvUrD4GFymhEQAefSIIE4bei2cQCbOE+9
         e3YMW7gb7961GO3kNR1oL3DxaQVx+AgkBmcBFCA6MXrj1qcmtAzC9rHcvKMadk+Xuq
         Bys4xr5TSeU0WwRS71PYA48Rrg7NEl43NoUMbF0n7K4UPjFpMEv/1cCwNnI9qsQyt4
         6ilnsWZawHK7PfufpPLK+x5UKOoTgz/CvXXosCyfrcfSE2+VSbqtE9MGDEyGASsm6i
         DT8j8ZtcWvfrfGFxhmWOGRPp9MigMt1U+A/gyoILxxICXtwzXb9BZ5v4kOMToOnaw+
         7J6wu7lZ0ASkw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 00/10] kselftest/arm64: EXTRA_CONTEXT related fixes
Date:   Mon, 15 Aug 2022 14:32:26 +0100
Message-Id: <20220815133236.235464-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; i=broonie@kernel.org; h=from:subject; bh=2D/qJVEPKZtjtenfb2kXhX2LtUPs45kll/5STRY3OSs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krqn2sC4nYGLoWnmDv4oxgUYRa0H9pXTL5yQaNW 8zkZDrGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK6gAKCRAk1otyXVSH0EsQB/ 9LlRYMZ2JrjVS4hnbzq+m9oIfDZAIcTodp53JRVaz0zrePgI9EraPYLRnmVtQtJw2A/nekTCvpZ06W /x5uCqXiIMFzcW8Fn9s1NBEz03SpJz7zyhVP8XhuQ+HUwvaH+Du40NSJK6F5vb+Ez5q+fLGCysnnuh P5/GwvLuRg5QDwYq13Pcb53g35RbTAE+rSgWSpQgDVlXXHigm28cAOunqOoX+ZltPfnLAvqZLenHp5 Uwzu7HGwuA6YRZjXGjDCesv79TtuWJg97DVzFPK3pTdwWMlCELqCkTJbQO8QPh9OyZ6ySNH6dhFHln salRADDVdYRNwWcwwFnxXPLuBjxpWh
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm64 architecture originally made the signal context a fixed size
structure containing a linked list of records with the various kinds of
register and other state which may be present. When SVE was implemented
it was realised that it supported implementations with more state than
could fit in that structure so a new record type EXTRA_CONTEXT was
introduced allowing the signal context to be extended beyond the
original size. Unfortunately the signal handling tests can not cope with
these EXTRA_CONTEXT records at all - some support was implemented but it
simply never worked.

This series contains one fix for the actual kernel, rasing an arbatrary
limit which can be exceeded by SME systems, and an overhaul of the
handling of EXTRA_CONTEXT in the signal tests which fixes issues which
would cause spurious failures when one was encountered and then extends
the tests to handle the contents of an EXTRA_CONTEXT record. This allows
removal of the limits on validation of signal contexts for larger SVE
and SME vector lengths from the existing test code.

The separately sent kernel fix "arm64/signal: Raise limit on stack
frames" is needed for these tests to pass, tests for larger SME vector
lengths trigger the issue it fixes.  The fixes for baseline issues were
previously sent separately.

Mark Brown (10):
  kselftest/arm64: Enumerate SME rather than SVE vector lengths for
    za_regs
  kselftest/arm64: Validate signal ucontext in place
  kselftest/arm64: Fix validatation termination record after
    EXTRA_CONTEXT
  kselftest/arm64: Fix validation of EXTRA_CONTEXT signal context
    location
  kselftest/arm64: Remove unneeded protype for validate_extra_context()
  kselftest/arm64: Only validate each signal context once
  kselftest/arm64: Validate contents of EXTRA_CONTEXT blocks
  kselftest/arm64: Preserve any EXTRA_CONTEXT in handle_signal_copyctx()
  kselftest/arm64: Allow larger buffers in get_signal_context()
  kselftest/arm64: Include larger SVE and SME VLs in signal tests

 .../arm64/signal/test_signals_utils.c         | 59 +++++++++++++++++--
 .../arm64/signal/test_signals_utils.h         |  5 +-
 .../testcases/fake_sigreturn_bad_magic.c      |  2 +-
 .../testcases/fake_sigreturn_bad_size.c       |  2 +-
 .../fake_sigreturn_bad_size_for_magic0.c      |  2 +-
 .../fake_sigreturn_duplicated_fpsimd.c        |  2 +-
 .../testcases/fake_sigreturn_misaligned_sp.c  |  2 +-
 .../testcases/fake_sigreturn_missing_fpsimd.c |  2 +-
 .../testcases/fake_sigreturn_sme_change_vl.c  |  2 +-
 .../testcases/fake_sigreturn_sve_change_vl.c  |  2 +-
 .../selftests/arm64/signal/testcases/sme_vl.c |  2 +-
 .../arm64/signal/testcases/ssve_regs.c        | 25 +++-----
 .../arm64/signal/testcases/sve_regs.c         | 23 +++-----
 .../selftests/arm64/signal/testcases/sve_vl.c |  2 +-
 .../arm64/signal/testcases/testcases.c        | 48 +++++++++++----
 .../arm64/signal/testcases/testcases.h        |  9 ++-
 .../arm64/signal/testcases/za_regs.c          | 28 ++++-----
 17 files changed, 137 insertions(+), 80 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

