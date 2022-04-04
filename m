Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E044F11A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiDDJIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 05:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353219AbiDDJIP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 05:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B853B01F
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 02:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E276661449
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 09:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9EBC340EE;
        Mon,  4 Apr 2022 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649063179;
        bh=DzCNCWMTjtSR9Ub+46QJUre47W1a7+dNlL+O4UxR03w=;
        h=From:To:Cc:Subject:Date:From;
        b=gKx+t0hHHReCZDKdfyTwYQLEzFlkPPMzpj47ESRcLGgosgwypPKbl3RkJFzi55w1y
         XOke1mhpx793jsU6WsEcZ7ibAOXhs3+We3ifX1SBE0Z6tlvdXBPTb/AXaZ8VI61ivS
         /TaclNr4Y2+dEE+lVxzfTRCohPgslJeG0MUfZmPpKAKRPR1ZZzFI9YWRzVCj+ckaP+
         UQR0//3CL2cZc+rIF13OkNMf6by5D5Yd5yxX74Rkv0/PAOcPK6v3aMMBDrBeij4RyN
         pQjP43rn2TVfWEEfKzBAe8cQJYcilzQpdA3C1AtyaifNCOJ0cNUDDpoKy4trkIw8ct
         RYWTe3vQNHHGg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] kselftest/arm64: Test ptrace writing via FPSIMD and reading via SVE
Date:   Mon,  4 Apr 2022 10:06:10 +0100
Message-Id: <20220404090613.181272-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; h=from:subject; bh=DzCNCWMTjtSR9Ub+46QJUre47W1a7+dNlL+O4UxR03w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiSrT/2M8mYc7iCCSobc8xYw3uUXk3y+8vJOev0m4T ivtOwmGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYkq0/wAKCRAk1otyXVSH0EN3B/ 9+lbY9D6q7gWzVaY4sWAn6cBBxAkfM13MlGewbYZ8V2Ga92T6BrClT5zgDe2L1JqFLACzaHUkB+Aeo g0BZ1jaBydua1Ww5YWe/vMPiM1mkm7b71+uhs2XvmEltPP1laATDqrjsGMKebtYLmN1/Kaam3NfJky r09RXTzPD2lCpbF/aEWJzL++mPrEFRdH8jYE5xLbQKBS+Ecqx/HPCo0D/MXzVO2o3fUZCfCRtkpcKb qVnJRk+lmy8tc6PKp2WOh7HhCBPTwB8mc3fq5FDIoTyBqpFi9NUNTO5vNHXiFFgzoQmIOM6+/t7grQ O0hXwYL6TTQ5adFQmAJV5IafbcZsbg
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

This series has a couple of minor fixes and cleanups for sve-ptrace plus
the addition of a new test which validates that we can write using the
FPSIMD regset and then read matching data back using the SVE regset -
previously we only validated writing SVE and reading FPSIMD data.

v2
 - Rebase onto v5.18-rc1

Mark Brown (3):
  kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
  kselftest/arm64: Remove assumption that tasks start FPSIMD only
  kselftest/arm64: Validate setting via FPSIMD and read via SVE regsets

 tools/testing/selftests/arm64/fp/sve-ptrace.c | 164 +++++++++++++++---
 1 file changed, 139 insertions(+), 25 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.30.2

