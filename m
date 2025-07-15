Return-Path: <linux-kselftest+bounces-37388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16929B06862
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DFD189FD35
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7C270547;
	Tue, 15 Jul 2025 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaFQhWEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05E8F5B;
	Tue, 15 Jul 2025 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614020; cv=none; b=d8B2Eqml/UTUv74Bb8tezZuijag7+iOLF17qeVK7CSSPua/FGYW0V51D8zW+pXtRbSMFyuky1gg7w3RQAHJHVUbk2hUTMSwXtAOUssxJL6xTo2u5dZWuO45WptY6WQ2IQr55GAnbufNEAJOGgDEPoq1L9DuTbGhauShd5/S5eVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614020; c=relaxed/simple;
	bh=mM1tF2s/b0ZogAi+jxdz4PVOTJW2G4lze14RMnYdd78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kTHNsFiqatINcVI0J4F1C+3yYTiue+66aG1L9EbDpjefmGBw4vdZASC/WRtPXrhAwbZHTx4/HAnOWZw+ZiiNfkcEDdndTVrwspfH1acaJ45So0E7du3Y3S3hSqM2mzdi2TL33huuV9/4rX5CbTTTjH/3xycjL0Gmgr19JzZf5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaFQhWEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA76C4CEE3;
	Tue, 15 Jul 2025 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752614019;
	bh=mM1tF2s/b0ZogAi+jxdz4PVOTJW2G4lze14RMnYdd78=;
	h=From:Date:Subject:To:Cc:From;
	b=UaFQhWEflC8ObsgIHRpF2et4e41GDEat80M6auCJBdhbsH6TmZ69cjyUCaF7JM13W
	 acctdOa7q0H6AKSpF3sKr+XC2GzEec4Mx40VUbu7QU1YCpHOPUqnFUr1OQ6Vn/I3aT
	 +sE9kzfRsaKNjVFSRsFREFv4qp5fFI1IvNjM2YEyo39+Gs4LJy4C4VvA9YeNO0R1tu
	 RraAVr/Cu2/vceflYarGAjllZUfVgx8aXulY4Lp/Alh7LnZfKJZyeHRSFzgO5dKH2r
	 U7B8k7IX9aiuSR+J6ivT4fe300q8Xvn0DitUlTV2I6Tf9SR8AjMbAD2+wHsud9nG9c
	 Cx7IyWkwkKvHQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 15 Jul 2025 22:11:41 +0100
Subject: [PATCH] kselftest/arm4: Provide local defines for AT_HWCAP3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAzEdmgC/x3MywqEMAxA0V+RrA3Ux1T0V8RF2kYN+KIRZ0D8d
 8ssD1zuDcpRWKHLboh8icq+JRR5Bn6mbWKUkAylKT+mKQxSXG2Nyst4sp7o9pCa+evpqNBZcpU
 hZ1sfIB2OyKP8/vd+eJ4XG3gtf20AAAA=
X-Change-ID: 20250710-arm64-selftest-bodge-hwcap3-b6ab30ab69cd
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mM1tF2s/b0ZogAi+jxdz4PVOTJW2G4lze14RMnYdd78=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodsSB/7q/BSdILq7fHH1g2g2xJyjqobvln9I5J
 CmG6HPR+QmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHbEgQAKCRAk1otyXVSH
 0GG+B/wIkoEOIyKfVBaVDbXG1m57caT23WlApoKSOoYziL0zqUa8bn//xVQw0JGfjNMfU31c2gI
 VVmq33UXmcvQEOSaKRa+kIaaOYOVOnMUQ91jJ0Qnu5N2D8VWLh/BZInlAfAcvaqzy/YDU9oviiq
 5D/VMi5hCrxgArDcGGmm0GCCmE+y2fNWw1RuCw+ZQvXPbr3wW9Pp7Us8xvqRzlDSRfw9yi8Eehx
 fSzq43Lwy9fDqjtz67In2e8ovCqMlrfBtCD0fTGjNWeeVGt2EKEc9oSsd4WDQHVNr6iZW89ZViU
 rtziSlLPq/buf3xi3bRwrf8ExA0vdh/G+trEE1zn2SgnWtw2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Some build environments for the selftests are not picking up the newly
added AT_HWCAP3 when using the libc headers, even with headers_install
(which we require already for the arm64 selftests).  As a quick fix add
local definitions of the constant to tools use it, while auxvec.h is
installed with some toolchains it needs some persuasion to get picked up.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c       | 4 ++++
 tools/testing/selftests/arm64/mte/check_prctl.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 35f521e5f41c..aa902408facd 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -21,6 +21,10 @@
 
 #define TESTS_PER_HWCAP 3
 
+#ifndef AT_HWCAP3
+#define AT_HWCAP3 29
+#endif
+
 /*
  * Function expected to generate exception when the feature is not
  * supported and return when it is supported. If the specific exception
diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
index 4c89e9538ca0..c36c4c49ff95 100644
--- a/tools/testing/selftests/arm64/mte/check_prctl.c
+++ b/tools/testing/selftests/arm64/mte/check_prctl.c
@@ -12,6 +12,10 @@
 
 #include "kselftest.h"
 
+#ifndef AT_HWCAP3
+#define AT_HWCAP3 29
+#endif
+
 static int set_tagged_addr_ctrl(int val)
 {
 	int ret;

---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250710-arm64-selftest-bodge-hwcap3-b6ab30ab69cd

Best regards,
--  
Mark Brown <broonie@kernel.org>


