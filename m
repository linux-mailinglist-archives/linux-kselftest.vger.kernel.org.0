Return-Path: <linux-kselftest+bounces-33071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C1DAB8289
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33A94C6D8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB04B296D1D;
	Thu, 15 May 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha46NoQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E529673D;
	Thu, 15 May 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301253; cv=none; b=fco+P7baH0pkPz+rGIZJi5FUMLZvixadA/NRwgxBy2lQEDR+Wv2Pg9g95cylAmlUZhjUAE7++/ANTGkU/FeI9ZkXiz966fOM+v0aJGtpY3wdV/HEr7FEjqMJ9TpXM9tbX/GF/Q6oSCefMxtRPYIsPozwC1plUTW7IHuHtXS7OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301253; c=relaxed/simple;
	bh=6PmBf/DsE0wy+xDq3yf/Of2lMkBikecvmpMZM32RNVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UDZWBy9pZnZ0Eohu5G+LoTZs1h02Fq8fXDWyC9z5c78VlHDbzZpFklBDM5T3awR3vt432WU5cpj0mchDp4ZxnjIcr07CDZDyPd2vTuTccI10I7GpRbw+Q3fbjfAbyS/E4pAbXjB5J5cYbG6YEsDlWAVMWD7xvGkX4NhYBCqay5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha46NoQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC22AC4CEE7;
	Thu, 15 May 2025 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747301253;
	bh=6PmBf/DsE0wy+xDq3yf/Of2lMkBikecvmpMZM32RNVw=;
	h=From:Date:Subject:To:Cc:From;
	b=ha46NoQLAucxNyE6bG9Y9s4myH8b0Vk2ClGK6ishRVkKSHqsvQoyfgy+S2a441Kjg
	 qAo5A23E7eFq2Cbzj43uOcOGq0TViBnvYewM2dtp5W3E+t11pn3TacR5YiQXRHlqLB
	 o+myAf4h0Okdsj7KXPeCgO+fRYg7K81Mf2yESezcdWE7C7KBmQfx0yiPtiP5Ki9KOO
	 o5ZPGMo2FRbqRyzbTV9RZvb8bkjfqsovcsh49UQP6QgtQFkLkYen+yrA3T855MtEFS
	 7gddqo/K9ArdY46vDAp9prV5SE1x3Nqmdt1DU6HUkAzSQmT4eUaypgeV3zG72ERQR8
	 j6+ZKcG8eA0KA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 15 May 2025 11:27:14 +0200
Subject: [PATCH] selftests/mm: Deduplicate test logging in
 test_mlock_lock()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftest-mm-mlock2-dup-v1-1-963d5d7d243a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHGzJWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0MT3eLUnLSS1OIS3dxc3dyc/ORsI92U0gJdI3PzFFMLs6QkI8sUJaD
 mgqLUtMwKsMHRsbW1AMKRyWRoAAAA
X-Change-ID: 20250514-selftest-mm-mlock2-dup-277d586bb29d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6PmBf/DsE0wy+xDq3yf/Of2lMkBikecvmpMZM32RNVw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoJbOBo/lCc8vlSJhQthtHCWl0Eh1VWbTIdBk3r
 X1Zbc/+Il2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaCWzgQAKCRAk1otyXVSH
 0LMaB/0cfyKQqtwkrhPB7AFDCu2alGaCqjYw20vyqDs+2WTcyFCFnC+PG4ukQGZnoCLKSOSd0D2
 k6iTG3OitMsCtJMAYOpZ0sdYH8v9ao0TWlEDfwzBFUEsWtTXgRVsbsc3gyPtETtre0KB24XL4sZ
 Vc51UG2Ump4zFtGKME2w/E0c0lH2sj9cwxl8FcKCj0BYHipy/cq8p4Tt66nfL2emZyl9j2qME2m
 xIEj88GUHxQ64a7NSy9JIFyuU+8Bmd7QmD4Flg+3ERAO5qSx+oovcisEmhf8d/f3nO+ilz2wZ3Q
 ELuwB/CpMWFKzNV9mQXhKyWEDUXf1Zvoq6En1Db9ySwJjyuj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The mlock2-tests test_mlock_lock() test reports two test results with
an identical string, one reporitng if it successfully locked a block of
memory and another reporting if the lock is still present after doing an
unlock (following a similar pattern to other tests in the same program).
This confuses test automation since the test string is used to deduplicate
tests, change the post unlock test to report "Unlocked" instead like the
other tests to fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/mlock2-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 7f0d50fa361d..3e90ff37e336 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -196,7 +196,7 @@ static void test_mlock_lock(void)
 		ksft_exit_fail_msg("munlock(): %s\n", strerror(errno));
 	}
 
-	ksft_test_result(!unlock_lock_check(map), "%s: Locked\n", __func__);
+	ksft_test_result(!unlock_lock_check(map), "%s: Unlocked\n", __func__);
 	munmap(map, 2 * page_size);
 }
 

---
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
change-id: 20250514-selftest-mm-mlock2-dup-277d586bb29d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


