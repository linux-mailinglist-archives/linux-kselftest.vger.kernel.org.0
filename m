Return-Path: <linux-kselftest+bounces-7914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7B8A409E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60981C208ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3561C290;
	Sun, 14 Apr 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wW6aXA+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406801BF35;
	Sun, 14 Apr 2024 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713076002; cv=none; b=rQPO3dM0AHQMH8slv1uJaR6Yncn+PfaCmJWgZ7kEji2gFkNae6b+k2BgVgAaRlKvAQYAAgON3sJVmwUf4H/CnaJayNWL4kkEmNimRk0EaV6Ji2W2RDUprkcIDQvvzcCO2MsscfNyDvVAPi5lDaNafZAX/dby3uDPnp48Q5xgL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713076002; c=relaxed/simple;
	bh=32hefK5w2vixpj4ztrF6kNZlbFfsN97FKuhX9UHWdHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkDpT8zy1HVBhfjWT37Y8lMI/0efE/5DmYNYRk3YrbiQQK5vfNJS2brre0USg3ywiSrApOj5wvCePVHDW00mJOHvCB04C4lOqD/IvpjzbAkhq+uurR15IJk1o2dTgOXhR5LdDGhCNefKExZeTjLq04Zr4Y6xvwh8uoviD8gb4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wW6aXA+N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713075993;
	bh=32hefK5w2vixpj4ztrF6kNZlbFfsN97FKuhX9UHWdHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=wW6aXA+NtlGzcqNL+Eufq/ez8kViP+T+S/wz7eoaLyAYY3VvF/lw50OkwCDp+nAes
	 QrGFKCnrSezT661irTwjH6MFZ4M9F19cRErnltLF+Xz37ahfhswSFJqOdFaL2N7cXt
	 eAnFpZ8s+xuZI0UOOx0MYtJgkbKIuC2XMZdSYHXj873uaXaVF0RjEPRI+gXdYizR5w
	 dq+0zwnDw97OYTpcNr/BBBVTtuJlkCH/jfS7kqIH0Or1z8p/ETLsOLt5ugiJ3tvUM5
	 K8oWfLXdP79INLzNL4YgaqCpgj9h1huRoWFCp4bsZOM/AvgJTn4E3HbyfRqgtcSfEN
	 ro8U24LnPHqNw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33CCA378042B;
	Sun, 14 Apr 2024 06:26:28 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: Mark ksft_exit_fail_perror() as __noreturn
Date: Sun, 14 Apr 2024 11:26:53 +0500
Message-Id: <20240414062653.666919-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the compilers (clang) know that this function would just call
exit() and would never return. It is needed to avoid false positive
static analysis errors. All similar functions calling exit()
unconditionally have been marked as __noreturn.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
This patch has been suggested [1] and tested on top of the following
patches:
- f07041728422 ("selftests: add ksft_exit_fail_perror()") which is
  in kselftest tree already
- ("kselftest: Mark functions that unconditionally call exit() as
  __noreturn") would appear in tip/timers/urgent

[1] https://lore.kernel.org/all/8254ab4d-9cb6-402e-80dd-d9ec70d77de5@linuxfoundation.org
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 050c5fd018400..b43a7a7ca4b40 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -372,7 +372,7 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
-static inline void ksft_exit_fail_perror(const char *msg)
+static inline __noreturn void ksft_exit_fail_perror(const char *msg)
 {
 #ifndef NOLIBC
 	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
-- 
2.39.2


