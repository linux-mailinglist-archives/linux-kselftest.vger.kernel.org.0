Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35900592FF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiHONdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiHONcw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185D175B2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3F4EB80EBB
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF100C43470;
        Mon, 15 Aug 2022 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570369;
        bh=pk7Q79jKBzZEn+CCEUhIxWG1JcQQiZbxATsJw8fMdG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uW59T6LjlQr67aU9gYrcKAXoCb8WskckNjJGtcryJpaewZCQZPVYVug47NwbQgSex
         N/2VcIplMu/1N3vxg2LIkG3pnQkGzEyDx11BlDPkKMsf+KYnH/A3DUZP4wDXLGLY8K
         sBF0Wbf16XcXyBiKvq2S9C7Q1GbJ0xwRW9/lfCv9zi8wIsVeinRm/WlqCrC8N4tNlo
         VZgL3WULtR40RaODZvCKWzCdE7eAAlKkSAclZ6blp6xTIXFzWnW/j1b5oWifbDJb9O
         M6385Ytnhg6vkGwRRLSyjFmJekN18dM3cmk15hLCM5wZKeAXunggmIAPbF1cKOSh29
         ssnnAsjWv1LVg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 01/10] kselftest/arm64: Enumerate SME rather than SVE vector lengths for za_regs
Date:   Mon, 15 Aug 2022 14:32:27 +0100
Message-Id: <20220815133236.235464-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=broonie@kernel.org; h=from:subject; bh=pk7Q79jKBzZEn+CCEUhIxWG1JcQQiZbxATsJw8fMdG8=; b=owGbwMvMwMWocq27KDak/QLjabUkhqRfXq+n6bjnuWk72JrZBddnBXke3MD+8O0H8ac/7Nd8v7Ft ZwRjJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAJwkSL2//7fhR/xts1Y8mhP7Du5gt R9pikfDNZkvsvSODpHb8XLv+mfeQPu5qXP5buSz3NYevXbg/fFYgqSEr+bxli7bxa0Lw5f4po+daXy Ge+3k1NVZp9NqQ3o2fxq4skNSosnrPvt8fD0qoYDZb4SLi19HkYOmblOx1wTfx5uuVlv3P362p6miz kLdSauex61gvfR6+cdOoU7e8WjlM+onqqeXrqE00lbPdVt4Uy59xNMtcXCHbTsfKryzn+KMORrjJ1X cH2+2fZ4eYezW14uVDt78uJ1plgxSe0ST99I85QKfd1AbVuLp5aLO49dLl52PD24xNzMsiZKmElOzf 6jtdWiwDWus045HvD9eFszL9MCAA==
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

The za_regs signal test was enumerating the SVE vector lengths rather than
the SME vector lengths through cut'n'paste error when determining what to
test. Enumerate the SME vector lengths instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/za_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b94e4f99fcac..9f1dd70289be 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -22,10 +22,10 @@ static bool sme_get_vls(struct tdescr *td)
 	int vq, vl;
 
 	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 * Enumerate up to SME_VQ_MAX vector lengths
 	 */
 	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		vl = prctl(PR_SME_SET_VL, vq * 16);
 		if (vl == -1)
 			return false;
 
-- 
2.30.2

