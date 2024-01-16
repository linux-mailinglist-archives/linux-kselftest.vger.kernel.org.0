Return-Path: <linux-kselftest+bounces-3050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B491E82E47E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2942C1C2084F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF01BDFC;
	Tue, 16 Jan 2024 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4GQ4SZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06821BF23;
	Tue, 16 Jan 2024 00:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9065BC43390;
	Tue, 16 Jan 2024 00:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364010;
	bh=uI7Btu/J/8YtgV/1o+liXNpmIE97ptazBIRFlD38JsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4GQ4SZq/cvpCc/9ZhG3QEpESHJHIj+GhGFAIF2EhXinadzfaZ8I/PHPH/o9SnnbR
	 ZmHHrYK7mB4e/toPaf0toKVRQ0Lv4Fz5ZeMJGrhkkb/H/TOKxYaZYjkCyymtt67+TQ
	 BnxAJwm7Ut4mZeDhM1B1kbZcpwIRhpMmMcmckSyMg/tYs18HgalBxVv9ay40wWVRVk
	 57W3SJ1ncasaOAqN0+ZczH1ASKx+tQBf3n0CUMQ6Vmoatjr1PfjTbYE2k3eDIP3Pzn
	 FFb+8Dt48mrX4rFpoI7g7yAzOoVbp2gC/wlmau26Z8xBFwVAOE8Skq/5lOnLNaqvnr
	 tm8HKWTd8WywA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.7 13/18] kunit: Reset test->priv after each param iteration
Date: Mon, 15 Jan 2024 19:12:55 -0500
Message-ID: <20240116001308.212917-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 342fb9789267ee3908959bfa136b82e88e2ce918 ]

If we run parameterized test that uses test->priv to prepare some
custom data, then value of test->priv will leak to the next param
iteration and may be unexpected.  This could be easily seen if
we promote example_priv_test to parameterized test as then only
first test iteration will be successful:

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_priv*

[ ] Starting KUnit Kernel (1/1)...
[ ] ============================================================
[ ] =================== example (1 subtest) ====================
[ ] ==================== example_priv_test  ====================
[ ] [PASSED] example value 3
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 2
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 1
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 0
[ ] # example_priv_test: initializing
[ ] # example_priv_test: cleaning up
[ ] # example_priv_test: pass:1 fail:3 skip:0 total:4
[ ] ================ [FAILED] example_priv_test ================
[ ]     # example: initializing suite
[ ]     # module: kunit_example_test
[ ]     # example: exiting suite
[ ] # Totals: pass:1 fail:3 skip:0 total:4
[ ] ===================== [FAILED] example =====================

Fix that by resetting test->priv after each param iteration, in
similar way what we did for the test->status.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7aceb07a1af9..1cdc405daa30 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -660,6 +660,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.param_index++;
 				test.status = KUNIT_SUCCESS;
 				test.status_comment[0] = '\0';
+				test.priv = NULL;
 			}
 		}
 
-- 
2.43.0


