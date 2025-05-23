Return-Path: <linux-kselftest+bounces-33655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BBAC2670
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B07116D15D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF802951BA;
	Fri, 23 May 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMY4x/M0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD2294A06;
	Fri, 23 May 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014092; cv=none; b=NKVhmHFtlc0YVXdCWFa0E4VzlPkreAa4Jbm+fxYEvS49To6Cet414vo0MqTgl5sUDHp2vIHpTZsWNJuDLDzlN8c0p+oS+U72ZSh20gpcGdifpEfQid24+y+tgrFunTdDeRgxpaZpZN06K2NxxcWgTOGmHX3BgNilUtcMortQ2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014092; c=relaxed/simple;
	bh=AUZ+fD8AIUEXsr3uY/mmdzQaEKRtme5ZcQYFEQojcC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y02eLsT3lTj1Fnsz1lYFOlzSzP7Ao6mbEsddG+qEd31rdU8Z5HSOaEqN8F2tt5TKOPVsJ0VImnHNHipDdcH8/uPuVKJ1EYKWgCQ2CMCxh+rft4xZWcV6eR/p/O+/ZSxm1WM5uiwWBtD6UDP2+Z1ZOvyRSTZPOG369KN5/2qDwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMY4x/M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931AEC4CEE9;
	Fri, 23 May 2025 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014091;
	bh=AUZ+fD8AIUEXsr3uY/mmdzQaEKRtme5ZcQYFEQojcC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BMY4x/M0ATfW9VMXlrWTIcYTFYTqviZvYYBtWGNBPGEb3JshqoszUpxaqfsLeJ4Q8
	 e8EsOkVcpWv5tErDOk5g1NA9Xwge3rCfZRPBazGBkdAZArJp2sN6mU8KsjZwOw/LsL
	 Px9RZvJ2xZhKiG6VSVtsFef28YigCKxDtFRsly0viP/TRfihFdRu1rOIMn+tIfCKUg
	 s94nOX6qsiMicRG/derobY7nT+w+98b9B10ZGQYy6/RBxAjTzRV06dwD7FVyD2Ihb/
	 sqU1jeuXkSqG3RpzN+32RqUlYr1yWuW48K5YBLgnBjSmeBIJkZVcWF1E2ZoSA7kr99
	 20PSiDpK1Ktrw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 23 May 2025 16:27:12 +0100
Subject: [PATCH 1/3] kselftest/arm64: Fix check for setting new VLs in
 sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-kselftest-arm64-ssve-fixups-v1-1-65069a263b21@kernel.org>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AUZ+fD8AIUEXsr3uY/mmdzQaEKRtme5ZcQYFEQojcC0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoMJQEV+AipcEQ1foCd3DCkpsN89qB8XFyKxeR2
 2fY1WEDRKqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDCUBAAKCRAk1otyXVSH
 0OGxB/4q8kvzRRqJYIiDpNrVMBN8jDz/JrNqCUY0F+/fH0wF42Wnwvolp2MxsItzvqHYUvKNj+s
 DSkBlBIlwAd3RvA1V5MFEB6VzGojvousnHJSa+5VjX04vPC12diP1pjAAt3Vhwp4LNBJuAK1p4E
 6I/XelqEGR1LJHAsVkMiE6IUDNt7NAUxygSUKQ+I4MmSCc0Ua+OD4h0cZJtMLW7BQWakSjolY2y
 9FDBh6dRjj52YMm98XEr7h12Qc5VOgSURUigvmCcUTfkwTQa6qStRTXQBaz54qWfSdB02gxKO16
 4sg0vrD0Mi7NLuVJ96eBDsSlxU2szS5MF90sywnEM7/KsiZL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The check that the new vector length we set was the expected one was typoed
to an assignment statement which for some reason the compilers didn't spot,
most likely due to the macros involved.

Fixes: 0dca276ac4d2 ("selftests: arm64: Add test for the SVE ptrace interface")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 577b6e05e860..c499d5789dd5 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -253,7 +253,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 		return;
 	}
 
-	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
+	ksft_test_result(new_sve->vl == prctl_vl, "Set %s VL %u\n",
 			 type->name, vl);
 
 	free(new_sve);

-- 
2.39.5


