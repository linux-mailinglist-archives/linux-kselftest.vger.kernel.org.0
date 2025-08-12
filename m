Return-Path: <linux-kselftest+bounces-38764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A5B22185
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D7E56366A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A692E7199;
	Tue, 12 Aug 2025 08:33:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF12E3709;
	Tue, 12 Aug 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987629; cv=none; b=pM19rzVCnOTjyW6935IY0TyKfVDbaosQFlBc0av7HwXVEKFwPJnSaK3q5z17qqS0JgEo7nLAlMOwxa7fiuuwFuXcPhlflHgHRB0US6R31Dw9BK2jzC80WY571CPB3Z5Ec5sFV4IWN3nS12SUrtvoablqVMeHwH3H5lPKA9NqICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987629; c=relaxed/simple;
	bh=Sy8/6TluoP6qOLLWpVMHTV68NyWMKz1bCWJXxKwq1aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7YQ8OaiiWhbTvUopPj0McOaBRlzStvAvgxZyhWx2jxRrhBQ+bbLveA1YY8UT2GfAcpRBYt1o2nL4W4cr0knVaMdnZoyOG8aSu5rn4+Sk3zmuheMFPOkyas7wJJi0UZ2+UqfxJMcldbKfJTUZqEyAMEtdUW9iJGuqCjIiAvQWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9689afb9e24f-ce2e8;
	Tue, 12 Aug 2025 16:30:22 +0800 (CST)
X-RM-TRANSID:2ee9689afb9e24f-ce2e8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W4100033 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1689afb97bfe-f081d;
	Tue, 12 Aug 2025 16:30:22 +0800 (CST)
X-RM-TRANSID:2ee1689afb97bfe-f081d
From: bajing <bajing@cmss.chinamobile.com>
To: kees@kernel.org
Cc: luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] seccomp:seccomp_bpf: remove unused macros
Date: Tue, 12 Aug 2025 16:30:10 +0800
Message-ID: <20250812083011.992-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reviewing the code, it was found that these macros are never
referenced in the code. Just remove them.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..a80bcc5149bf 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -78,18 +78,6 @@
 #define PR_GET_NO_NEW_PRIVS 39
 #endif
 
-#ifndef PR_SECCOMP_EXT
-#define PR_SECCOMP_EXT 43
-#endif
-
-#ifndef SECCOMP_EXT_ACT
-#define SECCOMP_EXT_ACT 1
-#endif
-
-#ifndef SECCOMP_EXT_ACT_TSYNC
-#define SECCOMP_EXT_ACT_TSYNC 1
-#endif
-
 #ifndef SECCOMP_MODE_STRICT
 #define SECCOMP_MODE_STRICT 1
 #endif
-- 
2.33.0




