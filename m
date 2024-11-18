Return-Path: <linux-kselftest+bounces-22167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5F9D0995
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 07:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B231F211B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860D146D53;
	Mon, 18 Nov 2024 06:25:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FE54652;
	Mon, 18 Nov 2024 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911138; cv=none; b=q7yycTATm+OmvMELSeDD7aZPBt3HxuV2cb+9MHCMqVqjo96lcbq9SIeAAOCqthTb3oKDfn7D9aeZw5O4iHnxuzQjkycmL0yYQ8r+M5bb1W4Yya1PSw+LTFJ6Hv4QR03Hj7aoqCZYC/bkrbrqS5C7bpIzWL7n75bgYtQLHLliiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911138; c=relaxed/simple;
	bh=eYvTGSmwc/HG7pTWakworhP5mMe7YU+guEWVku/y6no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HswH7CiV3uvKLVUL5vHJNrYrVeWwNlXM092duvhmhQV6Wol0v7Ao1GDLkJE4i6MLa3OfEqbyokmnt7FFCpjogCLuGcvZ/ur91LQQPXNaNrfxh9CtG1pcablV1fCGbwjS36lJo+pF63UAsW69yaJ9KW3YqPU7ZeBIodfPT+B+7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6673addd61fb-0cacc;
	Mon, 18 Nov 2024 14:25:27 +0800 (CST)
X-RM-TRANSID:2ee6673addd61fb-0cacc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8673addc9ddf-b0623;
	Mon, 18 Nov 2024 14:25:27 +0800 (CST)
X-RM-TRANSID:2ee8673addc9ddf-b0623
From: Ba Jing <bajing@cmss.chinamobile.com>
To: mic@digikod.net
Cc: gnoack@google.com,
	shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] landlock: ptrace_test: remove unused macros
Date: Mon, 18 Nov 2024 12:24:07 +0800
Message-Id: <20241118042407.12900-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reviewing the code, it was found that these macros are never
referenced in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/landlock/ptrace_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..8f31b673ff2d 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -22,8 +22,6 @@
 /* Copied from security/yama/yama_lsm.c */
 #define YAMA_SCOPE_DISABLED 0
 #define YAMA_SCOPE_RELATIONAL 1
-#define YAMA_SCOPE_CAPABILITY 2
-#define YAMA_SCOPE_NO_ATTACH 3
 
 static void create_domain(struct __test_metadata *const _metadata)
 {
-- 
2.33.0




