Return-Path: <linux-kselftest+bounces-20838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35289B3B51
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A431C220E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB291E0485;
	Mon, 28 Oct 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsBl3R+v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531091DEFCF;
	Mon, 28 Oct 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146981; cv=none; b=WfEOWNIXxlmRXcaYxwat6YwpZTIhwHgdFNHHvzHQ4+6qsJyd5kBDNbiX+gvOU12Eld0dMh0DWtwFnlXwlipULmyz2H+6OFXaZkWHJk5dF8EVMQgBA7kwDq2AXnwwzg76A+M8PWzm6PfTKTfn490gl4qwIWyIUflGgHV4OBCjRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146981; c=relaxed/simple;
	bh=h/uAJKk9yowgbk3OaT+oWdhXXiH9RK517VPzloLbJs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s8GHZOtI0AyBvBzOlb/3bgRhJ0DCnkrQcMxg8TvdWWVxnc+1c+rJDc1Ojh4bqQssOKNXam89tD9V9d0mxXr24v4peKGjlCTTp8ekFNG7XHPLeDTcBwI8m3T9FEFIr4nxMqcobLFS0N6leV35cbC1Mhk7w6RARRE8t9m4kB3XJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsBl3R+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D119C4CEE3;
	Mon, 28 Oct 2024 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146981;
	bh=h/uAJKk9yowgbk3OaT+oWdhXXiH9RK517VPzloLbJs0=;
	h=From:Date:Subject:To:Cc:From;
	b=FsBl3R+v8FbAqGjbUZCHo8pAb2LgdeS4sXhlPLjXPciJeru18Ltq//tbfvW/XOOzc
	 dPxkCiQ/HD+RHGdnBPuH9wvg5mz22RK3kURBX93PH8MREV3mQRf41VFjqQARfdXg7v
	 acyj7d6WD98UTV2B9t0GBMW+SXUhHDLNU+3JL/GCNjwnSoIV4jbaHqOLZJ8Ezcyidw
	 IZQeKl1pt7/TbfjEsOUEHd18hFahFOe2GeN8SZqWdZI3tXtnPmF57RK/+pq5h0az+0
	 2QF4YEYmFAJ/k3tyaWQZvkK5bTFVgkXYTJ40x0n5XPKR1QKbQPRmFbEXlE+GquZp6b
	 PVG8YSBpBgsHw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:22:31 +0000
Subject: [PATCH] kselftest/arm64: Fix encoding for SVE B16B16 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-b16b16-test-v1-1-59a4a7449bdf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIbyH2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNLMo1M9FNMjQDIt2S1OIS3UTDZPOkxBQjE3OLVCWgvoKi1LTMCrC
 Z0bG1tQCGNGQSYwAAAA==
X-Change-ID: 20241024-arm64-b16b16-test-a1c7bad2478e
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h/uAJKk9yowgbk3OaT+oWdhXXiH9RK517VPzloLbJs0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/KiTZI1KXJe0z4HBNsQhRwJZzpV12/qfQwGfWxj
 /JMMjJKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/yogAKCRAk1otyXVSH0A2MB/
 0fPO4SRok6s/UUvAbL/isVyPqmA/03nUE6QHn9VxY3eP2r45ADD+X0zKSrpebv4SE8+CULRMla79ma
 yvaQCQ9g+Wd8tibBFEDjn2/n7bybwjl6y+TacYNsspr3wtsRhT7sjheQyW63xSV+WP65GXX/E4Za7r
 O+maPIYtPwwq7DAEOBy8GanTuYI5J1ySnFoUT1KM4OUKhJrgDp/ezC77JvHZORDSRARLYD8S6+VuT2
 hvwUG7zcwa69ykMN23ejQfGa4rWx/beIQtOij9q42uN1xH57cJdrqTQZb0Ha9nzKPCIBC10zp6wtCq
 OWMnQJxx/GhRaqr5iMyIv0zW4p03+Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The test for SVE_B16B16 had a cut'n'paste of a SME instruction, fix it with
a relevant SVE instruction.

Fixes: 44d10c27bd75 ("kselftest/arm64: Add 2023 DPISA hwcap test coverage")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index f2d6007a2b983eba77a880ec7e614396a6cb1377..1e4ed89802f76c2bcbe4bfd1a9a987970db8b97d 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -361,8 +361,8 @@ static void sveaes_sigill(void)
 
 static void sveb16b16_sigill(void)
 {
-	/* BFADD ZA.H[W0, 0], {Z0.H-Z1.H} */
-	asm volatile(".inst 0xC1E41C00" : : : );
+	/* BFADD Z0.H, Z0.H, Z0.H */
+	asm volatile(".inst 0x65000000" : : : );
 }
 
 static void svepmull_sigill(void)

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241024-arm64-b16b16-test-a1c7bad2478e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


