Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0679772D3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjHGRsB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHGRsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 13:48:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972010F3
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 10:47:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b9920362so3123884b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691430478; x=1692035278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKaYgqtMlR5WhIH4limsAacts/UKY08TjAm6rewYVlA=;
        b=kTQSF3JWaxS5JICxEvz7bD0rB1hlI5mHP8qd7Fwm014OWO7zqUZ0jW4wYKpAzan+Ho
         cAW3x+G80MggMAOf1sONO1CtJZfc1swqwwyupaN6+bbNSuWvP4pDfhasdIa9TeLqf2Vw
         F839vqrSspTdgGqkHM0mtWE+622uoq339MwOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430478; x=1692035278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKaYgqtMlR5WhIH4limsAacts/UKY08TjAm6rewYVlA=;
        b=LQMP4kCzm6tA/nIaVW34Fak4FlvtgYKyuXoVGj288DnRzUbKocgdxrgw4KpAGPuJ/8
         4UQHb828SLBcP1ItFRuLnEkLZyryhzJoDjsrr1QC9bC15mr0OldHEPgjWZY2/5jUnATq
         mnD9b76J8FzaW9g/0EI41PoNVL4/8yx+p7Mys/PpgpHfUQzOjIYqJYvqc459Nm3CDwT4
         AGFqJb3yfm0CUd8XlbIaz6C61lrbJTV/oUw9RzpHTmnj0CYLRKAuqVZz08cRx6lv7wr3
         KfFmFKJPU4K8MrYXtU5NxqsiMeAzaj5W1zKqkXDKMRz9e9KSaG5GdJQuyUEmBbSaszwS
         qSOg==
X-Gm-Message-State: AOJu0YxgptGJ9Cq2eInecb5yziT2XvYHm8nS2R6astxx+vzPv9S5YjXb
        U7UrfqIcA0j8XsUXMOHK9/MISQ==
X-Google-Smtp-Source: AGHT+IGKe+itZrIImyHKZJ+9kSic6E9IGaC+DVjhSX9EPCD2Jdh0qErbvyUazBTFVXAdvIjXr2mZHg==
X-Received: by 2002:a05:6a20:4422:b0:132:c07d:9dd2 with SMTP id ce34-20020a056a20442200b00132c07d9dd2mr9943521pzb.39.1691430477919;
        Mon, 07 Aug 2023 10:47:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j21-20020a62b615000000b00687375d9135sm6395995pff.4.2023.08.07.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:47:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/harness: Actually report SKIP for signal tests
Date:   Mon,  7 Aug 2023 10:47:53 -0700
Message-Id: <20230807174753.never.547-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=keescook@chromium.org;
 h=from:subject:message-id; bh=RAxZQEsMi71+QLOVGZip55OnqX1tTd8XqrLZIxyuuK4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk0S5JsDfPeKejilUk34p9D4hES6BA/MtQCWhck
 tdHBteX7nSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNEuSQAKCRCJcvTf3G3A
 Ji2/EACo+FuJ7wPfDSuota88CJ/wsp0G8PkCjRaS0EdNDMjuF8oiJeNilpQeImfWF7Y5L6/VGgd
 8W/AN3UP0AE8FS71zpk+DU5oBQI4S0f+5G472EgHq+fP84OQrJAiD9Qt2sZRjrfMPM1aY6IU46K
 f1IWLmsLvkSFyv3ELK4fEqmZDjJQ+5vdxhuwKQpaC6BtXuv5nLBAIJ8IgNX9eyQborjsPciQ/cS
 SRveKXrKeIqI23BqowPDh0shxJHeyShgiD6muEl+WR5fthDxE+qjzNmv4+HC4+fgVqtHwwrkFZx
 KQa9pXduZPydPa51qkRQw3FPcVa8bNA8Q53svOblFhyXsMy2gzzT38L/9qQqlbDoSDDjUn5frm2
 mMZb1jig3QgC6Dnz3JOzpN7hEzDF+Ts6Bo7AI9Cvq8oMu9XdcjqwNeiT7WMJgIElgGCyI3ZhEER
 2eTthAjVFRJJOvpDmicQO+MKrB3SjVN68+tUafGnArrrG2fpcNjQujSvujX/2CJ3NuDq3PVdz4S
 NdqcBF4SkmSvGvfNyUqN2ySoIpRw3E5DAV4oDzKfoeCigJxS8icJnDZK0zWWfXo+jaOVDbFhD10
 8kINaTZWRkTE5S/RsY18RTtPdXW69oQYBCvpxfuYb3DdUPuiIfapCCc2D/bZcOqCuIImMAzMUYk
 1YYiBfP ATZMAOyg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests that were expecting a signal were not correctly checking for a
SKIP condition. Move the check before the signal checking when
processing test result.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5fd49ad0c696..e05ac8261046 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -938,7 +938,11 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (t->termsig != -1) {
+		if (WEXITSTATUS(status) == 255) {
+			/* SKIP */
+			t->passed = 1;
+			t->skip = 1;
+		} else if (t->termsig != -1) {
 			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
@@ -950,11 +954,6 @@ void __wait_for_test(struct __test_metadata *t)
 			case 0:
 				t->passed = 1;
 				break;
-			/* SKIP */
-			case 255:
-				t->passed = 1;
-				t->skip = 1;
-				break;
 			/* Other failure, assume step report. */
 			default:
 				t->passed = 0;
-- 
2.34.1

