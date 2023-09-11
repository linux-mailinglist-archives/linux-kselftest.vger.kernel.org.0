Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92779B33B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbjIKVSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjIKNwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 09:52:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA035CD7;
        Mon, 11 Sep 2023 06:52:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32B7C433CA;
        Mon, 11 Sep 2023 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440340;
        bh=G+uYgBverc1Ro/xgHPw6sRBSg+pKfkM04MdXBtul8Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAa4SXRRmgVZFAyg8O4lK6YGb/A1l92rZqVK2b3brRAqh1V3aY8FlNEDTfBH4RIqa
         MdU3LwywjdNmZOZ9VgV3eZMRY2twybZHLb+rXK3Nu8BAYUGWXeHQuU1VC+9s1crcf1
         SK0CAkyO4infzSgIxq+QVLyxneSg7iAom8Fl7M8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 019/739] selftests/harness: Actually report SKIP for signal tests
Date:   Mon, 11 Sep 2023 15:36:58 +0200
Message-ID: <20230911134651.576399076@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit b3d46e11fec0c5a8972e5061bb1462119ae5736d ]

Tests that were expecting a signal were not correctly checking for a
SKIP condition. Move the check before the signal checking when
processing test result.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5fd49ad0c696f..e05ac82610467 100644
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
2.40.1



