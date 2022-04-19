Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE730507A9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353459AbiDSUHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353707AbiDSUHl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 16:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5039A3895
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 13:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2DB4B81BE7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205FCC385A5;
        Tue, 19 Apr 2022 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650398694;
        bh=NLOQaF8k2FehRQgK23dKs6nvS8c724u81EF3sa616l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRhyA5dJ5UanUisWsTQqcIqwal+akgzSvsRwWbvGdF1WlwteR/0l8QUbRYPqW6wLp
         Bq+ERQ1pepO3JNZIUuypKDjFkaKrUUrdB5xv4ymIry4XZy/d9BiRFOFrVMmWfgsxFX
         oSy583qqcNAC2vUoPEznCNrXZ75qmbfcivUV/4B8wxU36/Pl3CQKCKQQqwHdtD3SuL
         AfBB7YCivlvBpeONAZ5TPbJkBiNxid5LQBA7FgiMKbQ3hB9A9VGNLC/hHCdiXQyC1n
         bpoGetwcLNUmjSBzACy+RTD8mh0v6P/COdD65IzUeCFwT8m7YwKOCmI1Q9RiKNRTS5
         UzvZeFaO/+DuA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] selftests/arm64: Define top_srcdir for the fp tests
Date:   Tue, 19 Apr 2022 21:04:40 +0100
Message-Id: <20220419200442.1374548-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419200442.1374548-1-broonie@kernel.org>
References: <20220419200442.1374548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; h=from:subject; bh=NLOQaF8k2FehRQgK23dKs6nvS8c724u81EF3sa616l0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXxXXtZfK/ilcHaPTFfvKfsjwxhbshKuSw/rrwZmK AN1XnfCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl8V1wAKCRAk1otyXVSH0DvTB/ sGoCYKdyI75HYeYOdarpJ/UJWCXyOdp8RZ8XfXngkyXPJyvnHTN01zXcPsqLB2LV+/jkCReBRO2+qq 2kufaMzpLPbwUcvdwRr8hed/by8+jBN0TK6NH+K7yE68yxiKXe81m+bIwpR2nBNT7diKxsJc5439V+ P43kf0hIjMMU68ipMxvGjtOfUdaQz3ZlkqTTcmtfkxVeGBNsGjsdygAutorMh5JpPMQYRI0x0O/y27 xwgVZ7WBeY/wNakiBdToDITpnDlf55Kdlz7SOAJ+La8O5krTtsPisLtPDMJ0Ue4M55p9fox3CopcYF wRyICCL2NB5x1YPZ0FSrg7E/mgtJp9
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

Some of the rules in lib.mk use a top_srcdir variable to figure out where
the top of the kselftest tree is, provide it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 774c38cee317..41b420050765 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I../../../../../usr/include/
+# A proper top_srcdir is needed by KSFT(lib.mk)
+top_srcdir = $(realpath ../../../../../)
+
+CFLAGS += -I$(top_srcdir)/usr/include/
+
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sve \
-- 
2.30.2

