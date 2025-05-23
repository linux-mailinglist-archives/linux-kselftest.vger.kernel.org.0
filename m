Return-Path: <linux-kselftest+bounces-33657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286BAC2674
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD394A47378
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228B296D31;
	Fri, 23 May 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnclN2YV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2922155B;
	Fri, 23 May 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014097; cv=none; b=Yo6gJd5CT3Hltbo8/vLppxq3Nfy38V68p4E7MH6koNimgjeUeHui4YCh+xBiHFEAjFplxTLJTW24Oq56fmFLfcFWwPlHDvaoVln/kVqPrXqGlS3WuFvD4eReTb4Tc9NYLT7W+TBVesxQ6mAPxqLvCMSRjZvN91RHBKq6EvXoiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014097; c=relaxed/simple;
	bh=7qPuzgw0bn3QpiAY8R1qChXrcf2gq10ANDQmt+B1bVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DX5mbdk3avV6++IppESUkI0Mcq61hj6q9VAQKHuCPkOWjCKWiVoYK21Fmd2r9GVnOkTkQpQxBGy/fyDJ1VTVoTHQfQFvYM/pfyK4E4IQgQrR1KrVsCQ1KPVaNAmObUgnyysb2F1sJ9Gz5xrwjRM+4mo3XlbpotxgOfqzqMB/R4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnclN2YV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F316C4CEF1;
	Fri, 23 May 2025 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014096;
	bh=7qPuzgw0bn3QpiAY8R1qChXrcf2gq10ANDQmt+B1bVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lnclN2YVgjbXlaCUpmnfEGix2NPLg2Cu2qrZkH0MRI8aj1/ZkOnM/aBYdVSoJ1HCf
	 mIdCiHcTaE2XX/dbT+2VGu/u6V1rQQl05pa7WZzJ4eRWqA+mW5d5iNHg4+UUFyi8Fu
	 sUjrJBZnWFdNtxGozFWcYKiG76g88kD7DdcHkdVh9YKJ9b7YNwivorY59rF17jJv8R
	 VV+vY0197+JIBqid9x44tJggS3npfPqJfmCaX+FZWt5i2z6tYyXIH7tGu022HW1G6s
	 KL/quD9rY05T7tQO4ZirVa+KdA1Cf1u4x/bhteHgwEaNSKbNETs2i6VGV4TO43it+5
	 oE+FLOtENJsHw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 23 May 2025 16:27:14 +0100
Subject: [PATCH 3/3] kselftest/arm64: Specify SVE data when testing VL set
 in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-kselftest-arm64-ssve-fixups-v1-3-65069a263b21@kernel.org>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7qPuzgw0bn3QpiAY8R1qChXrcf2gq10ANDQmt+B1bVE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoMJQFGYi9rGbF8w0qTU6qYFovn3AABE/NB8RyD
 EYawPnIr7uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDCUBQAKCRAk1otyXVSH
 0PrBB/wN0FmdQUosY4F0ELo5Y70/0OwxSXRQpwwNsaHyw0J3yI6F5zScuTW82gkJ96P5ZJUeGxp
 xYK/ozDDRzAx9EqOirNEVxPJpyNsHNr+N3MRE2F765o9mlk49X096nE0MhOtXMZBmC4fGMZZaa+
 BzPalcgYEpEiF3x7aD2zJYRJqtWWeuriH7YvuMHqK6tlqmOaGZx+6xJrrRlgs1exhDq20yxXyKL
 p1dvp8awOan24B5SgIfj06vjDc5lBNmDLxFKJbBW6kmybAMiIAir/vttxxBIv1sug0J45hPkavS
 r0HSTC5HyUASaTyRa/GOzbbukPwF6zzqMD7SYswtK1ULgznk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
streaming-mode state") we reject attempts to write to the streaming mode
regset even if there is no register data supplied, causing the tests for
setting vector lengths and setting SVE_VL_INHERIT in sve-ptrace to
spuriously fail. Set the flag to avoid the issue, we still support not
supplying register data.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7e259907805b..7f9b6a61d369 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -170,7 +170,7 @@ static void ptrace_set_get_inherit(pid_t child, const struct vec_type *type)
 	memset(&sve, 0, sizeof(sve));
 	sve.size = sizeof(sve);
 	sve.vl = sve_vl_from_vq(SVE_VQ_MIN);
-	sve.flags = SVE_PT_VL_INHERIT;
+	sve.flags = SVE_PT_VL_INHERIT | SVE_PT_REGS_SVE;
 	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
 		ksft_test_result_fail("Failed to set %s SVE_PT_VL_INHERIT\n",
@@ -235,6 +235,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 	/* Set the VL by doing a set with no register payload */
 	memset(&sve, 0, sizeof(sve));
 	sve.size = sizeof(sve);
+	sve.flags = SVE_PT_REGS_SVE;
 	sve.vl = vl;
 	ret = set_sve(child, type, &sve);
 	if (ret != 0) {

-- 
2.39.5


