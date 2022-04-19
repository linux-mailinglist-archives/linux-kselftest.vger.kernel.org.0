Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29F507A9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 22:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353707AbiDSUHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356498AbiDSUHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 16:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CB5FB7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 13:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2207B81BE0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A2C385AD;
        Tue, 19 Apr 2022 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650398696;
        bh=D2LmChJ0+2ORzcB56NUTgIYWL7YG0u5JGwAl0YJUK88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvLI6N/Z/pO6GA0ItDkuPRTKJeY6pXth/xHfPO7bOa3AxcFYw/aPt+GXeP6Jw4QIP
         2AT0ItrrwpaWa3nv/5Q59T1IlO2bFMVu6J8fHXpEYYPzwgofgH1x15zTpeHd9rO2Cu
         7kvR+rJYV7O0CiHVM75cu9oqe9Dl1x3C1AWQ+I7Ts735nbsaacpoT1ReujvVeUO7yS
         waKtJhuHoE5O+Cpz/r04ik0xAe8rDIPj4+FB26X5ZlDiXOzABfDXmjaP5ZI6axnam3
         b2xKsjHBn2hhMif9uKUS1D4O34+Q66sySdg3GExPoa/ZgF1f+9IjbDlxduAmCTuEQ2
         htl8enRjikpoA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/4] selftests/arm64: Clean the fp helper libraries
Date:   Tue, 19 Apr 2022 21:04:41 +0100
Message-Id: <20220419200442.1374548-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419200442.1374548-1-broonie@kernel.org>
References: <20220419200442.1374548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; h=from:subject; bh=D2LmChJ0+2ORzcB56NUTgIYWL7YG0u5JGwAl0YJUK88=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXxXYV5yPB64tFLSlYRoGTs1wHoZuexnleQTxzN2S MsEBUkSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl8V2AAKCRAk1otyXVSH0FCKB/ 9nogYuQDOniRGydMHkt71jgwtiAF8oXgJzdpLi5QEKHreCqQnFY5/gMudNK0Xy3WvWPy5VWWkDy7Ct 13l9HVplXRdMvfm95lGsw4KRm4MngjC9L2HgnaMjH39ns9aYfxXD5G8EJfu33TcjNOVqAnkmBQz/2T B4xDlE02t/rglFgCrXuMdYlHHyNJDxvJGsJt9UnCEnc4TY55991r+uI3INxNtRQJY4wRARfBymist3 2+o7ODbMck9ooqV50yVgJeSa6+6qa2WWkBTa6mc/LyyTup/DYDxs4juLBmdm4Z8JJD/8xsXr7MZelT FVGAJOqPDY1PdGxSDhjPlW2p0D+hPF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

