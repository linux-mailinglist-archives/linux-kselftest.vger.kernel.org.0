Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8296664DA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjAJUuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjAJUuU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87A5F5E;
        Tue, 10 Jan 2023 12:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52B12B819AE;
        Tue, 10 Jan 2023 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685E2C43392;
        Tue, 10 Jan 2023 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673383817;
        bh=oY3wvBZf4XVZ7FfVQY2+ildeUBZPFTUHlI/gPRTHgDE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BPDNRPHV4mEsGdGhO89DXKpVbc805b3POUAdyTSa0VIe+onofRGz9SdZs21KcE9XE
         E6+VDRgWOyYHDILgJSFMbeQfWW1RzAHrTcqGWRvvYEcT810dw2S3FV0anyQB496iyv
         i387uVjnNbKCqCnNku9HbWesJkjoWbV4/iQRem/uf878DfbM6Fy0A2nxlIYFJziUpn
         r0BIIuDxo+VTPW9SXkUGvuORU37SSVd1MqRwXUyZFmGUEj7fJEhU+JgRCmJ6swSkyD
         YZY0kF7lMEWM2MmXYcuPazZmpSRy3tIyVXehn4JyFAwQyFFtov3bDMGZL77ZWWsdwE
         Gi2OFdtpi54RQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 10 Jan 2023 20:49:58 +0000
Subject: [PATCH 1/2] kselftest/arm64: Fix test numbering when skipping tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-arm64-bti-selftest-skip-v1-1-143ecdc84567@kernel.org>
References: <20230110-arm64-bti-selftest-skip-v1-0-143ecdc84567@kernel.org>
In-Reply-To: <20230110-arm64-bti-selftest-skip-v1-0-143ecdc84567@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oY3wvBZf4XVZ7FfVQY2+ildeUBZPFTUHlI/gPRTHgDE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvc+D9X6DpxcDtKJLJdmizDcYP6DjKBksJPLbci39
 hGI7bLKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY73PgwAKCRAk1otyXVSH0GxFB/
 0YlSB95Il2YcUisKymkAQG2FEvLeIX4uLmKhLWq7g7HP4wJm1vj0sqA8unZJFsfzsnzgKgY+aDK/m1
 UmxsfuuTV8krPJV2CgN7PSAqCX6Gb/k15INagHdhviTDuWGo0FfmZX3YeY9MDbhrV/tKNk95p01ufr
 p44jtCPSBOYCw82fW8A0MUIJSsJQeIA/WQ6mLfbw9BoLzZdeiCaJ/livYhWOW/8SGm5C+Bh2Hww3e0
 LJ2ptcF/WVoZYNbLvOP/Ve9DlZNsMK2tl2PerXqG2JQ7PQtneGuot0jX4CDJle0QH8ClsOVacvwZK5
 ZCVw1NHWX7duQUN0OnbGNREf1ESvjD
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

Currently when skipping tests in the BTI testsuite we assign the same
number to every test since we forget to increment the current test number
as we skip, causing warnings about not running the expected test count and
potentially otherwise confusing result parsers. Fix this by adding an
appropriate increment.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/bti/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/bti/test.c b/tools/testing/selftests/arm64/bti/test.c
index 67b77ab83c20..4b6dda987c58 100644
--- a/tools/testing/selftests/arm64/bti/test.c
+++ b/tools/testing/selftests/arm64/bti/test.c
@@ -112,7 +112,7 @@ static void __do_test(void (*trampoline)(void (*)(void)),
 	if (skip_all) {
 		test_skipped++;
 		putstr("ok ");
-		putnum(test_num);
+		putnum(test_num++);
 		putstr(" ");
 		puttestname(name, trampoline_name);
 		putstr(" # SKIP\n");

-- 
2.30.2
