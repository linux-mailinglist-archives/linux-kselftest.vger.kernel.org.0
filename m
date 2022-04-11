Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2854A4FBB68
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiDKL6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbiDKL6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565543AC6
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 04:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A78615B0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 11:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCF0C385AC;
        Mon, 11 Apr 2022 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678167;
        bh=niTA8yGMk6C4xgjH095qVgtFQfGX5ZsTIZzuU2FMXv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFJU5bXVNAfSusqnS+LiKGPAIpkuRxt8diucNJwIgBkKdH0I3K22j6SOjKmjP8mWj
         UGKlHV2SQI5dC0dYtTSHJ8pFo+TaZvm1mhbp+aAcQdEVKht+k8T1M5L90xf68DxDAN
         uEDX6liRBHHVeqlrK/+CQv4oxWH5KtXeMztn3F9uIGugADzCLkIvKRLrxuFqHcMtxL
         GxZkZZ7ndx4vzrp5sn7iyBvI02IYU76jVxFe/kJKB9wG7r9OpaiwhPY2CC8DKjzWGf
         MyJFTUNE/gtU+AslzP69jMlPGJhwHIvHO9FxPxXnhbYWPFCqXxdWdXG14HZAzBDm6r
         Nm99sQsLUpRJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/4] selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
Date:   Mon, 11 Apr 2022 12:47:07 +0100
Message-Id: <20220411114710.16204-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411114710.16204-1-broonie@kernel.org>
References: <20220411114710.16204-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; h=from:subject; bh=niTA8yGMk6C4xgjH095qVgtFQfGX5ZsTIZzuU2FMXv8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiVBU4EfHRkox3RJIBu/7fbWnH2l7INwpX/OiKMaPF WTHZ5J2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlQVOAAKCRAk1otyXVSH0CRTB/ 9c/A0eL0KHHXTC4VhKaeT+QLChHSqqNmmFRZclJIsUJByegofEn+vZGnojfDZu/RTzH4wySwLgAWGe v4hhT4ygAlGeDV/2IxVOh5rrhVOve5V0jDfTNrjVO4ucSTBxbu7QW/MEsNvWlBx18UQtL8brr6tgiU 477ypXM05Vy2EfiVO9G8vAWdCsWVmi+WA/0KvQcyXDmqXbVFOiFMdZapVIEmBZYJkoV8hTThB9dgUI ca725LNkTR7FelEMPMqOc+d3H3Hr2NGMlCfioYfpTtBF5XzL1YNZ1IETYZ7rik/JsU4T/YSSYgyH1B CrgXMu6J8J/dQ/Kims2hiNNqAkWe1T
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

The kselftest lib.mk provides a default all target which builds additional
programs from TEST_GEN_PROGS_EXTENDED, use that rather than using
TEST_PROGS_EXTENDED which is for programs that don't need to be built like
shell scripts. Leave fpsimd-stress and sve-stress there since they are
scripts.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 95f0b877a060..774c38cee317 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -2,12 +2,11 @@
 
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
-TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
+TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sve \
-	sve-test sve-stress \
+	sve-test \
 	vlset
-
-all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
+TEST_PROGS_EXTENDED := fpsimd-stress sve-stress
 
 fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-- 
2.30.2

