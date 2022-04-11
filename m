Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06574FBB6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbiDKL60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbiDKL6Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E623150B
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 04:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD60DB815A6
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 11:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE9C385A4;
        Mon, 11 Apr 2022 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678169;
        bh=NLOQaF8k2FehRQgK23dKs6nvS8c724u81EF3sa616l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT7AXWFgvitIp74zJN+jSmXWLafialKODSiDSuaQmvxclNrqRGTB4dWZkpfkOLNEJ
         LjGqaJoKclIUaGoWOCwLOorG9k/X1TKdinLEUEeQXyXvDyL8cxm/rEVnySvKC4xbC6
         1QPvJaXsSppS5MFaw5xPqesMlrdMJEMPGHJVGw9I3EH7i8+6oUody+ymzzBGCgWA4o
         HEEr+escb4LTy1rOcuFzxMzf98xfs3inQNNIU7uMvDUoaU+Fa8sypgtjtX+x7r4P4q
         0H4Tqa9NANRH/k4t5FAW7437OO4J9AzBZVLP1sjD8kaxnO0A1vm+XOzV7AQPcNIm6y
         TcobanAjIO/dQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] selftests/arm64: Define top_srcdir for the fp tests
Date:   Mon, 11 Apr 2022 12:47:08 +0100
Message-Id: <20220411114710.16204-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411114710.16204-1-broonie@kernel.org>
References: <20220411114710.16204-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; h=from:subject; bh=NLOQaF8k2FehRQgK23dKs6nvS8c724u81EF3sa616l0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiVBU5tZfK/ilcHaPTFfvKfsjwxhbshKuSw/rrwZmK AN1XnfCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlQVOQAKCRAk1otyXVSH0DgbB/ 9gzIzUoqJgy8eZkeipDOYYaEUCYZuz9m/HyqyF8jw75ywY4Uq4Aa7G0z/y1D3CCaXfnFecTmD2Xht2 Hv5bX1vWDNxfMMrwipdN2BxmTGI03ZZCrMxYnpD86i3VlWRw1MgCvgYeKwufFPr93y89gp3LbbKi9S HlIrNkEQhLfqWaOaiG3kcNzFs+K4EbDMTNQIJ9QtCzyMK8TopixlFdbJFG7xbrK01uJvn759ylM1KZ IEWFc6shkbraTABGKQQLHYWwfKAGDkJ8IaEMIOyL7SjNpgNWfu9LrrqFwubUNT4O9tLJXamm+Pi3Y6 gpbgQ315qTjB76odm4QSUGHadN3Wv0
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

