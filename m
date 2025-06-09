Return-Path: <linux-kselftest+bounces-34485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62CAD2264
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962313A5812
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4292139B0;
	Mon,  9 Jun 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHFbwsGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530892116F2;
	Mon,  9 Jun 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482753; cv=none; b=gxrvdAbpt1IeQwJVlj+dgd8701EJLXpACEOiJJaY7k6rBR6laipG/IUSCd5zBTXGhzHbo7y9a8K+k4/fRMlUAqQ9AYhpfzk4pwQI9ikkbFs/p7G7QI+ZElzGLcdQJEXqTt7IrAqRIlFdFMsyb3XwLjl5T2Pgo9f+2d6UdZ6ymIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482753; c=relaxed/simple;
	bh=YiFiB0gJqqVhDkl2hVnB2VVfQod5K7jSRTa08zi1g3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBPORXVNfYzOx14iFBZLXd8788tgKYPM6HrNJWNEe8jISOKPPFTOyYWDGHElPUP1Am7GU/Z/VNw4Yb+DeJZWtXL75IUwyTSTo174UbXY08cPAkRMiCCYAYijQScveu4H3QLUzwxxN5BvmhMr7CleI6I4elAILqKKqS3R9P12lH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHFbwsGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27938C4CEEF;
	Mon,  9 Jun 2025 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482752;
	bh=YiFiB0gJqqVhDkl2hVnB2VVfQod5K7jSRTa08zi1g3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JHFbwsGA9NvrUXv28rBLETzbHH3jvPOJSUhw9dTYnxnkZVG7Qf0Syvsx1EKVwZkBp
	 G0hM3XLi4FAoKjzzyhLMv0jNt04ub6m1UmIWHQRzhE2TO+NdhiH6ThMkDfCCqYo03w
	 5zpy0UFHQrgTNQ56io5EC/EOzlWpdAbrzb0lCeygyPeeHYxUE9Z4IIKjlcE1ssrOV7
	 ebs0sAaDzPPSRbTWkqd/qyfxjbEIh3gda8BjCNra/jnD9jMVCxCIeK2R+YKXpkeG/R
	 Rbua09Ds4wfCHWD559/hwdTIHhN4CzDKgWYk6PQpo5OgnDy3kjskIxgeMQVoarYoRs
	 FzmfjWoowOLbA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 16:25:33 +0100
Subject: [PATCH v2 3/3] kselftest/arm64: Specify SVE data when testing VL
 set in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-kselftest-arm64-ssve-fixups-v2-3-998fcfa6f240@kernel.org>
References: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
In-Reply-To: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YiFiB0gJqqVhDkl2hVnB2VVfQod5K7jSRTa08zi1g3A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvz35uw4ddJPvpDN/dzqJsanKCxAQyD2Ha9ER7Yr
 Zs35tqyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb89wAKCRAk1otyXVSH0LAaB/
 9dY59pv9f64cvRL5SwQdgxAsI9AN/Fa8n9B9AOLV/8yI26OL6icpvFxOm+xMGqQrKccfZwBY4dGhFB
 Nh2zxYF3P8mBWOEBSjQDvn8TxyL1GcdZis3jP17X0oEjYh3y4IEjifSazXut+K4Szq2Er68xBv8wXz
 svEqCr4jCZ4e/lzKSUf2OHekwAxbTAiP3EyUyQYAsR9Y926yP2nGmHw/c258cenegC9ZdBH8PiPkLv
 mZn7RQ05xmk0lGHnCL/f58tMLa+RkjssJglDa8AHPPdZBfa/KY7HBzf0sKQli37VRIjZZVYnFBXBJk
 lXWcIrhd0hUxPnCcZx0+nhdyhdWiIJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
streaming-mode state") we reject attempts to write to the streaming mode
regset even if there is no register data supplied, causing the tests for
setting vector lengths and setting SVE_VL_INHERIT in sve-ptrace to
spuriously fail. Set the flag to avoid the issue, we still support not
supplying register data.

Acked-by: Mark Rutland <mark.rutland@arm.com>
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


