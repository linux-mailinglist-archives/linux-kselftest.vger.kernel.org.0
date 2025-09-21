Return-Path: <linux-kselftest+bounces-42022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DDB8DBCA
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF78189E523
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CE2D8DB7;
	Sun, 21 Sep 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QotlogBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B32D879C;
	Sun, 21 Sep 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461123; cv=none; b=cW9j4FA5C4IT0guCBaw3+YdebeKSggcx/U5hOAaHxSYfsuQA4XJqNSKLW1U3VLdcl/tsGmPzabzmt6evYjvwQpBZiO177UHA4WPfhxk/Q4B0iG5Q1ioSNkizaUxK1KaKFuOWrsROPNU7hFH4J3BZUjRGorLdlkKpXuLpKs54GAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461123; c=relaxed/simple;
	bh=s+wftv/lLO/HEynUJMSqPwVgj4JeieBXIF19Z/tEeQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPuTEAm/wFIP5J4d6p47OqPBFO/V31piY/VnIWgqhnR+5l/P/Di+tDswqePVcZCMNeihYdKcKMHWu4imuAoM2yUuL3GyAr6rr3mMV4AYfFeNLfp+7aw3oQE5WG0gp7Jl7MDj2foKvO1yFVrHFpTkX90YpvhdAaas7CT+FFMz+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QotlogBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546BBC4CEE7;
	Sun, 21 Sep 2025 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461123;
	bh=s+wftv/lLO/HEynUJMSqPwVgj4JeieBXIF19Z/tEeQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QotlogBeC2DAkXLKYM0i4uU3XzeMVEO/V05JQ1xVW2aGY2/WMgdclV3WFKlibnVf6
	 FHDIj6Rkyw3fg/XthzquvfDs24o4marNjzhn7BG7uEO8iUQeGo57iizhxK5MeVzF5F
	 AaRN3UuCvqRiV7NriPgrrdvkVuj3rDy8YWHlDY9+2+kAp+f4mSBThNfRKe8Uyb5W5H
	 MTlWepoOOL9VamUbpmdOc91g6VCaFtXuUUNnNnRCFA7vbwTBS7RwyztWsEWsR9goBq
	 JJPKgs4p8aFwmCPdL1YaFV1WmZAOK3lR/iO+NsJIH93EOeqBaUmMnGOzFZqLkEDPxG
	 F5m4323sX2+Ug==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 21 Sep 2025 14:21:37 +0100
Subject: [PATCH RFC 3/3] kselftest/arm64: Add PR_SHADOW_STACK_EXIT_TOKEN to
 gcs-locking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-arm64-gcs-exit-token-v1-3-45cf64e648d5@kernel.org>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
In-Reply-To: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Carlos O'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Szabolcs Nagy <nsz@port70.net>, Rich Felker <dalias@libc.org>, 
 libc-alpha@sourceware.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s+wftv/lLO/HEynUJMSqPwVgj4JeieBXIF19Z/tEeQI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoz/y1M7sHRQ/XGEyodNfOn9vWhZ9M8eyHg8M9M
 BlLxc+D3NOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM/8tQAKCRAk1otyXVSH
 0FfoCACGdjQtSrOTxShjPpSqtxWnJCMmalNBZUZgxX4Lde+8F29/Ie6usgMTZi7LgEcIB6IuMfp
 c3SsNw4PVX6daOoVIAaeyG1tuRrhnVM49m3Vs1IA7Kg1j0M95+Ptn1cUiFhB0Dja2g3LVHGhGCN
 rbhq1SDo8z0iPIfbAckPabd30aF2b4vx79KQazn7CycchrCtVhXH2/nBP+cGjNKkJ1W0ebxMYOo
 XNC94IgXeu9Eyivm5R6S3uNF+NWuK8vR8wXlwd6pyK8FtNpq+UJqWZxdkki2L7HNPNlNhHRJEPf
 NKwMfkP9asW7LwJldu8/izVUaCnDq1nDZr1bhR9HA55s3WTy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have added PR_SHADOW_STACK_EXIT_TOKEN, ensure that locking works as
expected for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 23 +++++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h    |  3 ++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/gcs-locking.c b/tools/testing/selftests/arm64/gcs/gcs-locking.c
index 989f75a491b7..0e8928096918 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-locking.c
+++ b/tools/testing/selftests/arm64/gcs/gcs-locking.c
@@ -77,6 +77,29 @@ FIXTURE_VARIANT_ADD(valid_modes, enable_write_push)
 		PR_SHADOW_STACK_PUSH,
 };
 
+FIXTURE_VARIANT_ADD(valid_modes, enable_token)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_EXIT_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_write_exit)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE |
+		PR_SHADOW_STACK_EXIT_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_push_exit)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH |
+		PR_SHADOW_STACK_EXIT_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_write_push_exit)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE |
+		PR_SHADOW_STACK_PUSH | PR_SHADOW_STACK_EXIT_TOKEN,
+};
+
 FIXTURE_SETUP(valid_modes)
 {
 }
diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
index c99a6b39ac14..1abc9d122ac1 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-util.h
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -36,7 +36,8 @@ struct user_gcs {
 # define PR_SHADOW_STACK_PUSH		(1UL << 2)
 
 #define PR_SHADOW_STACK_ALL_MODES \
-	PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH
+	PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | \
+	PR_SHADOW_STACK_PUSH | PR_SHADOW_STACK_EXIT_TOKEN
 
 #define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
 #define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */

-- 
2.47.2


