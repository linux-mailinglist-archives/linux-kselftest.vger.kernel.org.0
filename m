Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E34667FA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjALTyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjALTxq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5D90
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91779B81E64
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AABDC433EF;
        Thu, 12 Jan 2023 19:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553135;
        bh=LHzkF0WxKEJzv8jZ6f2y6u/QTsrdBfz5JWHUtiNC6E4=;
        h=From:Subject:Date:To:Cc:From;
        b=nCmIBGrOOInqXBXNg8aQdQ+5u/V6D0buumoNYiEKsrSMaEMc6oIK6UXjzqe0dGrtP
         XneC05MG5CZVxP/Zl9CHLXwUBpgA+5v15P2zm+hNCjCmVUWnykJ9M3oIAMAYbuCmEC
         dbME9OUM0G5UhEQf1Ni6uqpBxo2lg1Et+2VHSdvppqMor9b8BkR+UmbtCgqufq7gMj
         ti/rylSqK9qisXaPED5fGKB1VvxdX6z+RFUFEd92fkQASV44YjM8z5vlGS4kgYKsct
         ODpQ7wHF0SlyGFbk2VNZ779Y0kTPzCoX3k/MnLGbrixOEQzqeuWTIQvoV93w2M7GQE
         uD+4Mm/tkdwcA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] kselftest/arm64: Build fixes for clang
Date:   Thu, 12 Jan 2023 19:51:47 +0000
Message-Id: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNkwGMC/x2NywqDMBBFf0Vm3YHEJ/RXpIskTnTQRpmRtiD+e
 6PLc7iHe4CSMCk8iwOEPqy8pgz2UUCYXBoJecgMpSkrY61FJ++2xllpiTvpjmHJK4xdVfvWm2Ca
 DnLrnRJ6cSlMV/1dZb70JhT5d9/1r/P8A9TzW2d+AAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LHzkF0WxKEJzv8jZ6f2y6u/QTsrdBfz5JWHUtiNC6E4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjwGTn0RzIAFmCEVSvLXPWXrs3j7TVZMMTzK81TyyD
 VtmSe7eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8Bk5wAKCRAk1otyXVSH0GTHB/
 4r0wCWv4rFmBmkP2tsdYy0wQWk68NmpOeqU93kXLwc9Yq2pv5uCUn7IhE4Xi08lBaOS3oqiL4rCdE4
 N8tWPkthPassR1vQTpw5OysWgQqSxexr/USXIYUO90BB8/FWj9TcCiBn6EAFWoff3/4SWLkrCeDfyu
 lQkJMM6c+jn1SDPqvJE53uLFViInPs7bDP/XfbazPtNEmOmmoWqM4gABbE1QfqByZYJz//t2uj2X1z
 rmecXoNfFInX9GyhTxqq26j7KOPxo6vhM+sFwJHSkX1JjsI8RZCn6Dip6/O+63k1XHDRPKMVTaPmUI
 LySvVCEu1+764lM6NyQx4XeXOT5SZt
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

This series provides a few small build fixes and Makefile tweaks which
allow us to build the arm64 selftests using clang as well as GCC.  I
also fixed one minor issue I noticed in the MTE Makefile while doing the
updates there.

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Shuah Khan <shuah@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
To: Tom Rix <trix@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (6):
      kselftest/arm64: Fix .pushsection for strings in FP tests
      kselftest/arm64: Remove redundant _start labels from FP tests
      kselftest/arm64: Don't pass headers to the compiler as source
      kselftest/arm64: Initialise current at build time in signal tests
      kselftest/arm64: Support build of MTE tests with clang
      kselftest/arm64: Remove spurious comment from MTE test Makefile

 tools/testing/selftests/arm64/fp/assembler.h        |  2 +-
 tools/testing/selftests/arm64/fp/fp-pidbench.S      |  1 -
 tools/testing/selftests/arm64/fp/fpsimd-test.S      |  1 -
 tools/testing/selftests/arm64/fp/sve-test.S         |  1 -
 tools/testing/selftests/arm64/fp/za-test.S          |  1 -
 tools/testing/selftests/arm64/mte/Makefile          | 21 +++++++++++++++------
 tools/testing/selftests/arm64/signal/Makefile       |  8 ++++++--
 tools/testing/selftests/arm64/signal/test_signals.c |  4 +---
 8 files changed, 23 insertions(+), 16 deletions(-)
---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230111-arm64-kselftest-clang-f734b6b0c057

Best regards,
-- 
Mark Brown <broonie@kernel.org>
