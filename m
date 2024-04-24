Return-Path: <linux-kselftest+bounces-8793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9B8B10E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A623B1C231A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19116D4C3;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBHzkQLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660C16D338;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979488; cv=none; b=d/vANw0mAcYAEkuM62cX4teuyQqPj2yQZj38fJJknuRhm9rzjVf4bOwhYQlv9fixhS6TxX5fLbwVJd1Vfn07fFgUUYTJJQRVA4E3FylMdWPrxeXetfePzBETJOfZVstG77AC04YP7+LgYhl2gn8tjV9OBDKM3AaVSxUqHj05sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979488; c=relaxed/simple;
	bh=D85E1t//7pg4Je3S7QzI88EErnsJ7FlfVkbWF4PN0xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpA8BBZ1GAM8f6i5IvJXlCLNGvEUEXbXf/2XV3p019xBsI98ebSXFuUgijXaN3xFz/+TyxKuJ9a4LdASLCZ/MQKyfJ/ZAy5HdS7XHN7JLhxv+rBxcmsh5WNArJkxR6jacqLc6mT1UxmFVSlnKfqEO2UAJw+TwLaUOXHTj4A3GAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBHzkQLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BAEC32781;
	Wed, 24 Apr 2024 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979488;
	bh=D85E1t//7pg4Je3S7QzI88EErnsJ7FlfVkbWF4PN0xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gBHzkQLO5b7D/YUZcX6pBuU7yTPmGpcG+6ecKmSOfoTtQrKC9hS4jX5/MedmdTM3b
	 K57gbBOSvDbUmIYhxGhO2yXYlFPtBeOde4Gb1lRlLj6O48Yg/6cEz4A9fmpCNri7Lp
	 hIie63HLVHyGN77c1dMoHCUmCuc5HtkDw/D/g0XmxTjY51n5Cct9h2mmfaJZ8Zc33o
	 h1gh6jZQlBy6KAReXp2g60KLXtqwWo739lHYBwPdtUH1XhAixxw8AyJHu/ME6OGFNG
	 QJxFtCK1lBkEK2kTD7VOQaFmr/ZFCtPdpCRMmRhPPSA4x0OwkpZ5PAAjtV5mfkLnQo
	 Nhs46dUJryOTQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:04 -0700
Subject: [PATCH v2 01/10] selftests/clone3: ksft_exit functions do not
 return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-1-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 brauner@kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113; i=nathan@kernel.org;
 h=from:subject:message-id; bh=D85E1t//7pg4Je3S7QzI88EErnsJ7FlfVkbWF4PN0xM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrEfXpufeRS1tEFutVdKklDZ5INhHfJ38xf2bRCxD
 jn5wrKuo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkbjvDP1NV3h0fPkroflVJ
 P1ll+Ofcn6UZ1pf+rynx1YvfwLw5oIrhf3V3i4CFzYn3N6f4bV96f0/N7rCWfxve6894VTu7e3p
 vMA8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_{pass,fail}(), as __noreturn
prevents the compiler from warning that a caller of the ksft_exit
functions does not return a value because the program will terminate
upon calling these functions.

Just removing 'return' would have resulted in

  !ret ? ksft_exit_pass() : ksft_exit_fail();

so convert that into the more idiomatic

  if (ret)
    ksft_exit_fail();
  ksft_exit_pass();

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: brauner@kernel.org
---
 tools/testing/selftests/clone3/clone3_clear_sighand.c | 2 +-
 tools/testing/selftests/clone3/clone3_set_tid.c       | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 54a8b2445be9..ce0426786828 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -120,5 +120,5 @@ int main(int argc, char **argv)
 
 	test_clone3_clear_sighand();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index fbf813a5a06f..bfb0da2b4fdd 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -412,5 +412,7 @@ int main(int argc, char *argv[])
 out:
 	ret = 0;
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
 }

-- 
2.44.0


