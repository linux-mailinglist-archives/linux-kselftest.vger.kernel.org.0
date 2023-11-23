Return-Path: <linux-kselftest+bounces-477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953A97F5CC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514362819A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F72233B;
	Thu, 23 Nov 2023 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajdIZ+/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27E184C
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC7C433C7;
	Thu, 23 Nov 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700736363;
	bh=kb3AIT5xG1kFCiQ1Vz+UvRYW0kxBneNP3MyKZ8I3yMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ajdIZ+/e6/N4hUqFRjdNpAhx8Ye4yk+RAxJEwyynxyAOoXTxab//qTui6Vvq/uLiY
	 uHpxjyuH81bRUlgtyjXwhNoIybaLNtYSTGoYjgFzuHX+5wvfR4Orua9Oe/AuMrSV7C
	 5LFOuRGV46yoMjL54cmdPzMacP2qw47l6rN9AybNku1l265sEhcBYP+xWt8GK74JpP
	 khidagGHu+FBOGTC8DTXmlDASF6n+0GzOVf6yfl37qbkW/gAPj/eH0p1OP5UiXViGl
	 21DSJhZm1gNZZy0Qx5eh+ynz8Spe3gu4hrJUYAJP208viZpCI++MlhCE6VLe1ELxbr
	 BNGqHTUYao3Lw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 23 Nov 2023 10:45:48 +0000
Subject: [PATCH 2/3] kselftest/vDSO: Fix message formatting for clock_id
 logging
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-kselftest-vdso-test-name-v1-2-1b30441c422b@kernel.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kb3AIT5xG1kFCiQ1Vz+UvRYW0kxBneNP3MyKZ8I3yMw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1kdvjeWC86olt31l1UALcmPYTkSVpBieK6Q
 AQu19N/ubqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tZAAKCRAk1otyXVSH
 0O9BB/4mWSoAfdRNgPQ8rNiUEhipeTPetXaKsihnKxpsSxSwaR1M2CX0hyEnzzU7yIBXvEsp7nj
 OZ+A+/ALdtzdpXHes2R2/gnRJ9y+ck0SCa80S45QAC6w89R/W09Vq3jZWz33U7SGVH4yBuxol65
 Q3WyjU5Q6mj3GR7BIFFC6reEhfGtvgJsOUpcXcMyvRJF6lxR9iZ9dSi3Cq3ZMl/1TwvHx8ITUw0
 8K8AsnQTlAX1by2G5XKUgPxuV0RWwA7nTkke2Q3yzLb0YnB3GZtpY8zX90X5pvSfUgWfS5aOt1u
 M9edALMMYGp5YvmwUlU5OCeccmQwxWZpVODQ3nAUVkSIh0gK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When logging the ID of the currently tested clock vdso_test_clock() puts a
spurious newline at the start of the format string resulting in output
such as

  #
  clock_id: CLOCK_BOOTTIME

which is a valid but empty KTAP informational message followed by a non
conferment output line. Remove the initial newline to create a more KTAP
friendly

  # clock_id: CLOCK_BOOTTIME

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index b304abae6e8f..d0e247cca58a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -170,7 +170,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
  */
 static inline void vdso_test_clock(clockid_t clock_id)
 {
-	ksft_print_msg("\nclock_id: %s\n", vdso_clock_name[clock_id]);
+	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
 
 	vdso_test_clock_gettime(clock_id);
 

-- 
2.39.2


