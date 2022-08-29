Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC85A50FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiH2QHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiH2QHU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86783F39
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F626B810FD
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86717C433D6;
        Mon, 29 Aug 2022 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789237;
        bh=SC6BB0TrtIPgkViF0+V0mHGtjyHV8/yZSD05bZBH27s=;
        h=From:To:Cc:Subject:Date:From;
        b=ls/lQx3FF7ps/2vGhzX9+kjK4FPo4WgrdzXEV/e0F7IVuOEb11FLhzlDNR8jFwBpn
         kOhqnAPlG/+ERaXtpeOvawSqAxFX2VxEunj742fj7olEiFnB7FMogemRbpZJ38HS8S
         CUC6vk45iwdvNA70Gg7Yy2zdVOxrmakEgrcrDagN9VB7KU5B0ixvL1Moo1RmICmEyf
         aD3A6brpr0/RYUgVf2Y1iDlHCOMgVBZ0ovAlG8fkghselI5y8/S7pxtQpJxKU0rIE5
         18n+j/+kkh/7EolsDYmFXTHhHvHe3tqlXNqCXG1FN8Bmi91rJUw6EF8lJ5/eVETvcu
         yf4kKjk1TBKRg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 00/10] kselftest/arm64: EXTRA_CONTEXT related fixes
Date:   Mon, 29 Aug 2022 17:06:53 +0100
Message-Id: <20220829160703.874492-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=broonie@kernel.org; h=from:subject; bh=SC6BB0TrtIPgkViF0+V0mHGtjyHV8/yZSD05bZBH27s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQdczJ2/SN+nEoXBqomPtKkhDivPF2XzYIGYO4i 2p5Ik7aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkHQAKCRAk1otyXVSH0NDuB/ wJY6ScjUcu5rd/Wrw1+W65fR1ZZm9uAZtPO5l5USdjftfEhCldU4xC5hN+RA6OhbfllupWE1cz4Uke ZIHFfq/ZJvqg7+Hu5jNDTxFqeHS90/vtelSPxH5bKsIkQ1W5iurmdlyA4jUh5U5qx4hLizrwrkfI+i wX1QLRZ0O1VAPgbziNHacjMzZ6FNWXedLUrh9BlGDlfStJXdBIY/W3BcH1B5kx+XT5pwNUvKams+k7 CnV4DsfdYFI4egb79obM+NusWD/0S4qgtnjkHY7gz6T04UroZYCL+TNSjiyvrKLqArLMbdZR//UBZL eG+c2XI/bJXKOFhcThR2ibmZTSdq9s
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

v2:
 - Rebase onto v6.0-rc3

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


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

