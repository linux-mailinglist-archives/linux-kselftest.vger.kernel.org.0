Return-Path: <linux-kselftest+bounces-31325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6FA9716C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4DA7AA792
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2728F949;
	Tue, 22 Apr 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBnuiR+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0528C5C3;
	Tue, 22 Apr 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336616; cv=none; b=tbCSfU6aubtUWVXFyPIeRN+6J6hKfyD/bpxN2vuq/+uoaJgg+TVRVU+ktTE7qqx+1Bc4f9fJ3e0MYiscF4uS9znAA3tvvRQnqAJotUKPt5Swilhg/gXxQbmpucSH+AqvH0octA1IHZCCvpkkI9wQsaJ1vlLpBrp19WhsnEvf7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336616; c=relaxed/simple;
	bh=93fA3MEqR7jQgGkc8H5+YGR3Hp1FrEIvcKzVpqo2Q/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cE/+ILS98TJY5FS9h98M5+EN5Ea9TOe39qwMuhFAEgbyMSoAQfBtJZh7S5dmGpF5dVsBK5aiV033b6VTCRLJgs9mNTTUiSAppCW9acR9fXUf9qob/d9smwEFefygcpi+0tZmCsOTmFvHmd+HJ5/dBHSJPYcTSUf9KYzoLuTEBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBnuiR+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D36C4CEEC;
	Tue, 22 Apr 2025 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336615;
	bh=93fA3MEqR7jQgGkc8H5+YGR3Hp1FrEIvcKzVpqo2Q/w=;
	h=From:Date:Subject:To:Cc:From;
	b=qBnuiR+1qVWakHKLRBmgCfgs0jQJWOrcAu6KAyUpFf9tdCd7idnL1qDf9+iFuxIo/
	 enCBRDaANoVJM6L/O5moXNjuj3zRl8x+FNaUlWOthTqEAxOlqXIRU3lpjUtrsj5sPE
	 n1nZmPh62sPtve4kMTOOonw6UaKdszBTGq8nRUP/t+3lQF2fewgm38A7Pk0dou0yil
	 g56jxzXrOyShyVV6W9Y4+7ZHTPThNaJt8HKnwwaZlDUWicnX3qItyzgh+YPuNIqKOJ
	 2Am7pnAdiIRAeezep+gKvWYiLCD2LMMs4Xwys8EAJ5wRxbS0emObz6bOxzghs0P+8D
	 b4sYzPDf1ZDOQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 22 Apr 2025 16:43:29 +0100
Subject: [PATCH] lib: Ensure prime numbers tests are included in KUnit test
 runs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-lib-fix-prime-numbers-kunit-v1-1-4278c1d4a4ae@kernel.org>
X-B4-Tracking: v=1; b=H4sIACC5B2gC/x3M3QpAQBBA4VfRXJti/BSvIheswYSlWSsl725z+
 dXpPOBYhR3U0QPKlzjZbUAaR2Dmzk6MMgQDJVQkORGu0uMoNx4qG6P1W8/qcPFWTswoK4vKkBm
 ZIBwO5ZD+96Z93w8JFAn2bQAAAA==
X-Change-ID: 20250422-lib-fix-prime-numbers-kunit-323659c2cfe2
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Tamir Duberstein <tamird@gmail.com>, Kees Cook <kees@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=93fA3MEqR7jQgGkc8H5+YGR3Hp1FrEIvcKzVpqo2Q/w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoB7kkKPucI26n3DDxnJ6mefpWWgcg7tZBAr+FuiLY
 8pB21kiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaAe5JAAKCRAk1otyXVSH0PFFB/
 9Mkc101Mi0MUX8nYqI0cZoQgQYFcTtvs3yNYhNHbJZMJW0awYebJvxsYjXbPzKYZQfMQQ0Xxhw1cqD
 KJ4d+2Z6R7OJA6gJLKsOsSvZWwRehpFSPkFeYq+56AwEQGWsweKy8FHNqJyP2v8ck1VUEJLvUSXTTm
 6KNpP5sykVlpk6fbogmAqBPPPE293V/Tbb53VUxEIz3uqOW5Jp+K3yHbQctHdXcrvYS+qHQZEHE0px
 tPQp3Gvxs7WnUVfZhj5Byv55uYv/KxdESHVF0/N9P5Wz6EvI4ofalSnxYeY7r8f/JZk53L5r5Mf24D
 ETd5bEfBdenUaMMFSwSQf7xRdmx/9M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When the select of PRIME_MUMBERS was removed from it's KUnit test
Kconfig nothing was added to the KUnit configs, meaning that when run
via the KUnit runner the tests are neither built nor run.  Add
PRIME_NUMBERS to all_tests.config so they are enabled when the KUnit
runner builds the kernel.

Fixes: 3f2925174f8b ("lib/prime_numbers: KUnit test should not select PRIME_NUMBERS")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index cdd9782f9646..7bb885b0c32d 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -43,6 +43,8 @@ CONFIG_REGMAP_BUILD=y
 
 CONFIG_AUDIT=y
 
+CONFIG_PRIME_NUMBERS=y
+
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
 CONFIG_SECURITY_LANDLOCK=y

---
base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
change-id: 20250422-lib-fix-prime-numbers-kunit-323659c2cfe2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


