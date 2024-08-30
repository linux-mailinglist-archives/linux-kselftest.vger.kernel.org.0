Return-Path: <linux-kselftest+bounces-16801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92A9663B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B64284691
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D759818FC81;
	Fri, 30 Aug 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRsGyQhM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDED1509BF;
	Fri, 30 Aug 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026804; cv=none; b=d4cZlHzVyK/j48fs1s2Y5au36yb4q4UXjqvof5gxJmkFMKFGbHHaf9H8jsagjsi14LF9P3Y6m1dicgCQ4Kw6KvUlA/W/4TsqYYUML0HYIL6LWVWtOcgQKqsjxjGVHlXt9CGpLuhOoyKfX4A4rIbzUEWc1z/nSLIHFMd/laQtDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026804; c=relaxed/simple;
	bh=abEBYONWeURF/GdWgpitku0C1PUWqrVWKruQgBNNids=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bSuWaBkuC4+tKc5UIpBXKNg0fXJcnJx0vunxcY9EFU/xfXxMtgJh5Maxg/dnE/UZTCFBpeGR51NUvYAi7wKXAy/oM4eXy1u6dGU4yFi/+OjnkPgTi79ThnOivU1pUI6tOOp3tJN26o5c3GG3jtq8CRbP9L5M/lovMO4gK1FGx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRsGyQhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0035C4CEDB;
	Fri, 30 Aug 2024 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725026804;
	bh=abEBYONWeURF/GdWgpitku0C1PUWqrVWKruQgBNNids=;
	h=From:Date:Subject:To:Cc:From;
	b=JRsGyQhMxJ1Eiksxgq3fkcObUdJoTqTG4uppHFgc/flynZp/Ng2i0rJNC1WmYJiQw
	 lKCXQOJtGBqX9Ydhb14NB7+nUu7M1v8c6D0MNDGF+kuYPTDMxjXfxDEi37XBEoJxnZ
	 gcDortLTd7bpbZBpYHjZr7cBZcvrm7GZ84i8fMkiRCqnnDDNaNyp1CEVDsjMVCDwjW
	 Cng+DMxucDyJ4EaY4Tm7j7IPhlqNGFRclc3pekYDYZj6On5Wk+3imu71iSj7AZezOB
	 ksGXSSY3m6lzktK4XwjEmkE7KGTqq5592DW3v21wPk362CLBIoDICeQcaq6xGJR+rs
	 peAVqTtOnsrSg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 30 Aug 2024 15:06:35 +0100
Subject: [PATCH] selftest/vDSO: Fix cross build for the random tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOrR0WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2MD3bKU4nxdoBQQ6SaVZuak6FqkGJtbWCalmVmaJisB9RUUpaZlVoD
 NjI6trQUAxS5RS2MAAAA=
To: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=broonie@kernel.org;
 h=from:subject:message-id; bh=abEBYONWeURF/GdWgpitku0C1PUWqrVWKruQgBNNids=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm0dHxCKnbF4HVb7+ZyWJRSFnXLyRXFqig2i34/S1C
 pJIuiMOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtHR8QAKCRAk1otyXVSH0OC7B/
 4hi9Hayq1LNVE3MLEl3QmzakeufvKlzwofo9PS4WWX3MsT/R85SiuMrg8u30C78MVNUE4+8BIa8aM9
 qmJIm3fkB6A50fER9q8sy4GvpLDfK3UB4C/1pVP79JRYPQAdbwu4/qe/K8Do2YI3anYMNDjz7ycNYK
 SMMVKztczfNb74s6uz0tOecfdYEbi35Vk3jNF9cfZ7L8jpt3JZJycS0qF/1wMvQg6dURk7bqL4K7r7
 iM7rS8n2zzwvwOSqV5tZGwlozoip+Pic8ZFx5xnkPgXTX5bTdt4FLR5yp8L7brAJBhLc6iNgNJfdJ6
 wAtT2m8kL/o5OG+zESw3Zw2tCWHPLt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike the check for the standalone x86 test the check for building the
vDSO getrandom and chacaha tests looks at the architecture for the host
rather than the architecture for the target when deciding if they should
be built. Since the chacha test includes some assembler code this means
that cross building with x86 as either the target or host is broken. Use
a check for ARCH instead.

Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
The x86_64 build is still broken for me because nothing installs
tools/arch/x86_64/vdso/vgetrandom-chacha.S (I beleive it's supposed to
be copied from ./arch/x86/entry/vdso/vgetrandom-chacha.S but I don't see
how?) but this at least fixes all the other architectures.
---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index e21e78aae24d..7fb59310718c 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -10,7 +10,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(uname_M),x86_64)
+ifeq ($(ARCH),$(filter $(ARCH),x86_64))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif

---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240830-vdso-chacha-build-8d3789bf695c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


