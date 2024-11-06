Return-Path: <linux-kselftest+bounces-21547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7349BF3F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D7D2876D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B242064FB;
	Wed,  6 Nov 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH7afEYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B291DEFE7;
	Wed,  6 Nov 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912886; cv=none; b=bZEGPOg31Ld7VYuW2GoqkgZwC7P1slCNdPagshPjGO30ICHR1vqXZB4a/55Y6x4RBSa8e2bJGy/1lpq7uD0ypN7qSqGVqMGNNLbB2cMfEAihV0t1SlnyZfzrLC5AXz5xZaUE0PYRZkWIwB1lHcvGPqxISCr++UnJDl4tLj6xD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912886; c=relaxed/simple;
	bh=RvQnEtV8Mg7m4PiUUGqAJHzKfykaMnUeLxanj8XBb88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OPCi/DkPbvFSUJOE8/BJCLGdMLCtNZvet3UG6YvxPLTytZM3uTXFxb1gt7+nZgwd4Gpd13lBxdO3sd0YSTTs+sC6UIkxOd/0ChO5gc9cmLjzKENr5tdGc5DcHYd2Mqg8bRUVNDPuyi+RiNtpHKfBsUe60h3GxUs8aROj3TeGzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH7afEYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E1C4CEC6;
	Wed,  6 Nov 2024 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912886;
	bh=RvQnEtV8Mg7m4PiUUGqAJHzKfykaMnUeLxanj8XBb88=;
	h=From:Date:Subject:To:Cc:From;
	b=bH7afEYmmFzgQrhCdFISW4fVzk1/qQASxU7hpEvH5CIktMz4IWmchHfzAlFJN0Gv3
	 lWptnw7fs+G0n3pnFOSUCcZ3e+smHfxdmNzQx19k4m6iMMtjTDNxN9LLrdrpSEC8A0
	 dn0f9La3G2ld3VKQI/eLhjU/6sOHcadaN8Mxsl3TVFIJcmpcYqmqsQy64RaKxxrib+
	 aD9QVMfs/Uqsiu1TjA0GHeGaHyc1DNzUCvbgKV2u2amypTTk6xiKNloff+1Ddvbpcy
	 dxkyriVMSyjMdN/3E+APhWRCfLjg54mbrDxX7qaRHnKQggsIlZnya1Bs/dNWeC1due
	 l5+u5NN+fS7xQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Nov 2024 17:07:51 +0000
Subject: [PATCH] kselftest/arm64: Check that SVCR is 0 in signal handlers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGaiK2cC/x3MwQqDMAyA4VeRnBdIpVbYq4wduprWgHaSiAzEd
 1/x+B3+/wRjFTZ4dicoH2LyrQ3u0UGaYy2MMjVDT713jgJGXYPHvK2KJqXGBXe2HRNFSsMnkxs
 9tHhTzvK7x6/3df0BsNtNpmgAAAA=
X-Change-ID: 20241106-arm64-fpmr-signal-test-c0a0c5bf0174
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RvQnEtV8Mg7m4PiUUGqAJHzKfykaMnUeLxanj8XBb88=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnK6J0FNSRVwvQyvp7AdBVppeCP00LI4e3lhe2d0eV
 bFuvv3OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyuidAAKCRAk1otyXVSH0Ll9B/
 9fqWoycHjyPVfNACHQpdTKiWUo8wwpnvLIKZWgG1cEChaIPzaCLd9z6rrc4Wyx7iwFwwYskiUW9V6P
 oMChZ6F6YnncZ/kfOLieaGy0WkOLQcRMMGJjc1Kd3cwMV19hwuEPglL3fUv9VwIqAEUbQxRQyP8tX5
 SfLCt9UIcaAEAHikWj/NUC9Dv5mj9RUJaX080rojMwRNnTbHXLSoZxmy73T5seuZaZlbpChduwn3HK
 BbtvE6ufpDQxqiwl+rrN2SSfcUwIhUhzK1ZkC5OpsqjKX2ho6h6e/R3bew6Em4QsOhT3KEHcO74MIE
 r6kuqtvivxckQpFAY+sET42YZVJC24
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We don't currently validate that we exit streaming mode and clear ZA when
we enter a signal handler. Add simple checks for this in the SSVE and ZA
tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/sve_helpers.h         | 13 +++++++++++++
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c |  5 +++++
 tools/testing/selftests/arm64/signal/testcases/za_regs.c   |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.h b/tools/testing/selftests/arm64/signal/sve_helpers.h
index 50948ce471cc620118a0c7c8df70d66dbdfbb160..ca133b93375fa587b5e02cd76b2f2fcd92591723 100644
--- a/tools/testing/selftests/arm64/signal/sve_helpers.h
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.h
@@ -18,4 +18,17 @@ extern unsigned int nvls;
 
 int sve_fill_vls(bool use_sme, int min_vls);
 
+static inline uint64_t get_svcr(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, S3_3_C4_C2_2\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
 #endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index 6dbe48cf8b09ed8b7a5ab47690bd87e39e18e1e6..3dee68fa36d1cf2716f54d5f328b3f4077493c3b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -85,6 +85,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 	fprintf(stderr, "Got expected size %u and VL %d\n",
 		head->size, ssve->vl);
 
+	if (get_svcr() != 0) {
+		fprintf(stderr, "Unexpected SVCR %llx\n", get_svcr());
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b9e13f27f1f9aaf55db2a5e391f360993561d0b7..9fff4c50030414d06157e0da0c29fd794f707309 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -91,6 +91,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 		return 1;
 	}
 
+	if (get_svcr() != 0) {
+		fprintf(stderr, "Unexpected SVCR %llx\n", get_svcr());
+		return 1;
+	}
+
 	return 0;
 }
 

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241106-arm64-fpmr-signal-test-c0a0c5bf0174

Best regards,
-- 
Mark Brown <broonie@kernel.org>


