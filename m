Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C077378C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 03:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFUBgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 21:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFUBgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 21:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4F170F
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 18:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC2D61454
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 01:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F409AC433C0;
        Wed, 21 Jun 2023 01:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687311372;
        bh=ZGWixlN5rBkKq5OCR8Wk1Arp/RWb39U1SBANUTYo7jo=;
        h=From:Date:Subject:To:Cc:From;
        b=HbQRUqBnRdH7jFr8tL4x015aIf4v4Hw6xX5MHdgNmqrRg8nr+GMGW0b0QioJ76k6N
         YEThYDeaOoShw/5an7/n2vBIEeu+6BTIQo+G1FTpdPXn6abtJSyDNrKmjt5LtLrx2/
         Swn8G5GkbDnY+Ff2vkmYwxVpLyzuM+y4AA94AWusHsI8yq+oHV7AFKY6Oa6thULBKA
         a4DWd3/9cK1bgEPmh6uMy/IET4wwIBMts8w0An/zFOwtKaHjcTm5oUSi/ouf6hbOCe
         0lX0xcTsHa6FSYyNGwglKLVcatiRdyUVZn6jZOm8hBF+f6LevT9xr0VVCPo0T3d/NN
         28OACLqvap9Sg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 21 Jun 2023 02:36:06 +0100
Subject: [PATCH] kselftest/arm64: Log signal code and address for
 unexpected signals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-arm64-selftest-log-wrong-signal-v1-1-3fe29bdaaf38@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAVUkmQC/x2NQQrCMBAAv1JydiGmsYhfEQ/bdJMuxkR2ixVK/
 27qceYwsxklYVJz6zYj9GHlWhqcT50JM5ZEwFNj46zr7eAsoLwGD0o5LqQL5JpglVoSKKeCGcJ
 0Db1HupCPplVGVIJRsIT56KxVnod+C0X+/sf3x77/ANEz7xSIAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZGWixlN5rBkKq5OCR8Wk1Arp/RWb39U1SBANUTYo7jo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkklQJ6+TA37drnqWew4cfOpP1aYFj1zWY5tTJoC5g
 tLq3vGiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJJUCQAKCRAk1otyXVSH0PC8B/
 9OtrQ72sxwIufRZBDUkepbOoVr62YUA1GgCMKFaGC5f5KprdSbnoVPMV5Dt3scl1Zbyy8qRIRKm7AH
 3cLOXxOKduQMmfEZq64OACuaU+ZQCIotjtxFwKLsIPNikvEWVDrSIYUjPNf6q74Np/9uoHeyGIqUPD
 Bx5dlcT4DpXa0O3Ihq4vxPtb0t0s8k2t77npmk3e0WqiJXC3F8M1kRXWTPyMeSRL5H+kyRh7JQpaYM
 Eicl/utvIRxKF5aSvJBX4SsG6Ak9zseW0KbMRYfI6YB1qDHv7dL4/ZX6ed4XAGgaN/060aYgncUcPH
 a2zpoZNNvFM6+C4ckW7Ml1OZnmEWlr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If we get an unexpected signal during a signal test log a bit more data to
aid diagnostics.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 40be8443949d..0dc948db3a4a 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -249,7 +249,8 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
 			fprintf(stderr, "-- Timeout !\n");
 		} else {
 			fprintf(stderr,
-				"-- RX UNEXPECTED SIGNAL: %d\n", signum);
+				"-- RX UNEXPECTED SIGNAL: %d code %d address %p\n",
+				signum, si->si_code, si->si_addr);
 		}
 		default_result(current, 1);
 	}

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230620-arm64-selftest-log-wrong-signal-cd8c34ae5e4f

Best regards,
-- 
Mark Brown <broonie@kernel.org>

