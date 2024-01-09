Return-Path: <linux-kselftest+bounces-2769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D4828F51
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 22:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA82D1C241A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262753DB99;
	Tue,  9 Jan 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ixUKeS9Y";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="UlXXzZ1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73913DB84;
	Tue,  9 Jan 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id F367960177;
	Tue,  9 Jan 2024 22:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837303; bh=gjAe0zsZPSBxzH34pX4YBPhyeK7qeqNr+UXk48KQegA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixUKeS9YXiuHGQIsn/6EYiF8boopbExaMio1xW04/eTd4BNooZvhKf4HDHgvEs4CJ
	 iRx/OpviUAZt5bItzQvMAMCk9KfYivvkMYi1GA5cTvQR1tYe2T++0AVPrLF4haGA4Q
	 jLYx2wAPVjbmBqRHy+jS/oAg9z+KvLBT6Zx6DKeZbWNeTeLMB5MpZoxxciMMgSyJsN
	 VC/xsAGZnkaxcLukyRDnG8fVGhczid5PBJooi+8mScGCCojLjMAH/ev07nbwXzW8It
	 JtZwdf5fLVCbGAptg4YD5VUngoF94FvdWeiE3uckLCBWDNFoGOSA+K9VRhK93w1Ph8
	 lz7mKBvf+H15A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5DVtAp_bDfT; Tue,  9 Jan 2024 22:54:53 +0100 (CET)
Received: from defiant.. (unknown [95.168.105.29])
	by domac.alu.hr (Postfix) with ESMTPSA id 7F19F60171;
	Tue,  9 Jan 2024 22:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837293; bh=gjAe0zsZPSBxzH34pX4YBPhyeK7qeqNr+UXk48KQegA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlXXzZ1RjHV4azFdumDHAoh0tzIvKCLtlN3eUxqwBLXgVjbd6wMzKGBMSkgWPp5bz
	 /k4RcIpjJg/xWTBjahHC7LZHg7mv8DMBeFjWGmia8TGyiULvUkkWQTLHt3PqtLpzVU
	 u10ECKiY8ImNJQB8NjO5UeHarMY0TLPeLrtxU+04IGhWmb9QU9ip5ycaO9UGMiYC+W
	 k7OvwM3XbNkVUvXVfsyLjoksvgTgfIUbqduhnLBjH3kOhTOI+RZPB/xJTsRnIAjT5y
	 KIrVyiIgoLRIo7A2xaDurdRE6KRXvaI/cDoDZ1qZ80MJU6hM0izPpUs/QKow7Ecf9p
	 4wudPnfE5bwcw==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 1/2] selftest: breakpoints: fix a minor typo in the format string
Date: Tue,  9 Jan 2024 22:54:06 +0100
Message-Id: <20240109215406.18218-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109215406.18218-1-mirsad.todorovac@alu.unizg.hr>
References: <20240109215406.18218-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 reported a format string warning:

step_after_suspend_test.c: In function ‘run_test’:
step_after_suspend_test.c:92:32: warning: too many arguments for format [-Wformat-extra-args]
   92 |                 ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~

Fixing the typo $s into %s resolves the issue.

Fixes: 3fa72f2c784b5 ("selftests: breakpoints: step_after_suspend_test use ksft_* var arg msg api")
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 2cf6f10ab7c4..b8703c499d28 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -89,7 +89,7 @@ int run_test(int cpu)
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
-		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
+		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
 		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
-- 
2.40.1


