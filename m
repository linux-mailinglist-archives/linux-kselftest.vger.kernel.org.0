Return-Path: <linux-kselftest+bounces-21676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB29C1E6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75322284217
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69791F12FD;
	Fri,  8 Nov 2024 13:49:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959941F12F9
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073768; cv=none; b=C+slVuEzco/V/qHZH6/8zLE8D6cvHv/nrf1RxJYt3WF6X0bz3qDe/QI3+st2r8GMBC7pMKVVDQs22qImcbwUwqyFiGhO1HatzrXBp8ys1Pj6KQPVSN3/Xy3YjnH9yBii6E28xc42QVZGs/WhPNKA36Sp++/fQL1iZe0GFxO/Fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073768; c=relaxed/simple;
	bh=ix5Fxx/i8DQLOqBdQFnrhKj5pOZdSBccJOJpOmxypdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3ho6Dwv3QQZRZeOPB490evWvw0/gVVJGaRVbUsOuGio0oaqq6nrxIFxqhbynHBY3vWgu+MjrlBD5JZpKfcffhodN0xIsE99PlObWMRlR2twwdpXPZztJL2hO3Q4v8cWd7kf5AUiTCOdWHKg6x5Y33GMh+y4T9i2R6Y25IJpXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867AC4CED3;
	Fri,  8 Nov 2024 13:49:27 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/4] kselftest/arm64: Fix printf() compiler warnings in the arm64 syscall-abi.c tests
Date: Fri,  8 Nov 2024 13:49:19 +0000
Message-Id: <20241108134920.1233992-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108134920.1233992-1-catalin.marinas@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the incorrect length modifiers in arm64/abi/syscall-abi.c.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d704511a0955..5ec9a18ec802 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -81,7 +81,7 @@ static int check_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl, uint64_t s
 	 */
 	for (i = 9; i < ARRAY_SIZE(gpr_in); i++) {
 		if (gpr_in[i] != gpr_out[i]) {
-			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %llx != %llx\n",
+			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %lx != %lx\n",
 				       cfg->name, sve_vl, i,
 				       gpr_in[i], gpr_out[i]);
 			errors++;
@@ -112,7 +112,7 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	if (!sve_vl && !(svcr & SVCR_SM_MASK)) {
 		for (i = 0; i < ARRAY_SIZE(fpr_in); i++) {
 			if (fpr_in[i] != fpr_out[i]) {
-				ksft_print_msg("%s Q%d/%d mismatch %llx != %llx\n",
+				ksft_print_msg("%s Q%d/%d mismatch %lx != %lx\n",
 					       cfg->name,
 					       i / 2, i % 2,
 					       fpr_in[i], fpr_out[i]);
@@ -294,13 +294,13 @@ static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	int errors = 0;
 
 	if (svcr_out & SVCR_SM_MASK) {
-		ksft_print_msg("%s Still in SM, SVCR %llx\n",
+		ksft_print_msg("%s Still in SM, SVCR %lx\n",
 			       cfg->name, svcr_out);
 		errors++;
 	}
 
 	if ((svcr_in & SVCR_ZA_MASK) != (svcr_out & SVCR_ZA_MASK)) {
-		ksft_print_msg("%s PSTATE.ZA changed, SVCR %llx != %llx\n",
+		ksft_print_msg("%s PSTATE.ZA changed, SVCR %lx != %lx\n",
 			       cfg->name, svcr_in, svcr_out);
 		errors++;
 	}

