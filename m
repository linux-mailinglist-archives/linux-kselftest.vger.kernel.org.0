Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354914FBB6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbiDKL6d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiDKL6a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6F403C7
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 04:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C982AB812AA
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 11:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F6C385B0;
        Mon, 11 Apr 2022 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678171;
        bh=D2LmChJ0+2ORzcB56NUTgIYWL7YG0u5JGwAl0YJUK88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6OcA1Zh9rmZt6CHB2utD4yDaCGFCaFJauRYb1yeFXMDZ3LVwz8pBElTbBAgHYHZB
         W0/Xuk3kZ9SuOzBMg9NjWqtWBrszat0F6GfwlW8esltoIN4GZl17ole7GVF8MT73DX
         Rh9L+AnZI9dpefBLoOL+n3mSKZjmuThIUsHg/gmbXz7Zurn2OLJ1MopcsnsT14MiKG
         Qj9OT/zLzXkt9BBhlADukh3LTLRptDKvpNMhGxrwMU+O9UQ2M5WlL96CKqo89y6fZZ
         jxNyTcGeCaoBVdZQR6/mQtXZJ3InhkY48bH1JmpOzpu6hUEsWZe1u2aj0RoIZv0fdf
         aXmRs/U/T2baQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] selftests/arm64: Clean the fp helper libraries
Date:   Mon, 11 Apr 2022 12:47:09 +0100
Message-Id: <20220411114710.16204-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411114710.16204-1-broonie@kernel.org>
References: <20220411114710.16204-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; h=from:subject; bh=D2LmChJ0+2ORzcB56NUTgIYWL7YG0u5JGwAl0YJUK88=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiVBU6V5yPB64tFLSlYRoGTs1wHoZuexnleQTxzN2S MsEBUkSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlQVOgAKCRAk1otyXVSH0KGpB/ 4zU1JkI/DxI+OIy9PbjV99BF4+1U5zoHP5Dit93fKsLuTSAff7jj+z1LwH9mi9JLIdABzMTdmlqiIB TwWToBM7BqWe1xnqW9VFLINwfcral6w5i8Ua9v6D4Z22G6UEz0hRa24Hq5lwDzEnceBoJIg1//Qyrb h0kQ3ZuD063ueczcqD21X8pMMWTy+ae7kFMS6Vk2b1Y/ghd2Ql/zCFSAhaYOU1nQuQzYAwzlSq0Jf8 CQ/Utnl4Ujc6YOG0i84+8A8kR6tAacHI6Uv2N+IVof7Evi+PcoKi4iCq3qby/Eg+Qp9yI2MCUDzC4E AMTPMtRfuVv4qBDUTfTX5STT/mSueO
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

We provide a couple of object files with helpers linked into several of
the test programs, ensure they are cleaned.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 41b420050765..927b1e83f469 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -12,6 +12,8 @@ TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	vlset
 TEST_PROGS_EXTENDED := fpsimd-stress sve-stress
 
+EXTRA_CLEAN += $(OUTPUT)/asm-utils.o $(OUTPUT)/rdvl.o
+
 fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 fpsimd-test: fpsimd-test.o asm-utils.o
-- 
2.30.2

