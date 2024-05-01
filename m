Return-Path: <linux-kselftest+bounces-9200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8CC8B8A02
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D31F229A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF781272A5;
	Wed,  1 May 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pu+ywyID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BD85272;
	Wed,  1 May 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566575; cv=none; b=FUFY+xEjunXYOh0R/23fW4xpqu2QkhkJelQEt0iOVGm81ARumcKD5lIf7rU2Rew05mqx8okqJ7EiUDDbW6GR576C5HNMUVPDLoUCwB0EAjmoJf3hvb47RSTVw3DaCEGgQSTy0h5Juw6aNx+Aw7QaRb5ohis53zdkAa2P+s+4YSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566575; c=relaxed/simple;
	bh=6WDcflDy8GlspYBDiWv+GWglNqyttGyX34+sb1SiVNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAYjPPhsY/+J0zw3mWPNPRns0RyCfChHulZwtqSVSGkBIEhyAQ0FZWX1vHp6G+5AzM1+lIUqgUZ81YPcWllirXalKVlL0hGr4BuKNnxhZs8PTX5bDqUeOqh4XWrQtQQEKPF4iWVBBo7NH3HdhgNTqOqRkNKRAR9gbtJjWq6lwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pu+ywyID; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566572;
	bh=6WDcflDy8GlspYBDiWv+GWglNqyttGyX34+sb1SiVNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pu+ywyIDzBU9RlIHo9/cl2kl0/cO3Hvp08AmGN364thN9b9Yq4UtupENafKu9C9zU
	 RXUh7yZOPrK46jTX330leKZUFi+EiDg77lYMkgk3OiUuXzkMJQxnWw+E7VV0Ve/mJZ
	 lwusdvs/ercDP0qJxCYd7GUKEOYzwiDaLp0OHLwLNnlDYmVfg33a6YGA1wM1L+tslX
	 ScME2Pzg2TE0Eg9LT4qKUEi4/FTQh56KfU6lsDRMceePjOpQ5jIkRMaooIyaV3IkIb
	 lrY+sgUpEnjqByyN/JUuSNch7KdLS2i/naGf5HWZw037w3Mon6mD14vOivwvCano2X
	 J44wKeNNjX80g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FBFF37820A4;
	Wed,  1 May 2024 12:29:26 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: kernel@collabora.com
Subject: [PATCH 3/8] selftests: x86: test_vsyscall: remove unused function
Date: Wed,  1 May 2024 17:29:13 +0500
Message-Id: <20240501122918.3831734-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function to fix the following warning:

test_vsyscall.c:100:19: warning: unused function 'sys_clock_gettime' [-Wunused-function]
  100 | static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/test_vsyscall.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index d4c8e8d79d389..1c9895cfc660b 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -97,11 +97,6 @@ static inline long sys_gtod(struct timeval *tv, struct timezone *tz)
 	return syscall(SYS_gettimeofday, tv, tz);
 }
 
-static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
-{
-	return syscall(SYS_clock_gettime, id, ts);
-}
-
 static inline long sys_time(time_t *t)
 {
 	return syscall(SYS_time, t);
-- 
2.39.2


