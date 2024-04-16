Return-Path: <linux-kselftest+bounces-8186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6939B8A7150
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF80B21236
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1FC131BD6;
	Tue, 16 Apr 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ecUigaXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247813173C;
	Tue, 16 Apr 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284804; cv=none; b=aLHVLs4eGt82ntfMFs5HPvIlJgcOROAN9TYc2wNNUC/IOeyVfkFae1AddDTqgI84hdg1oLqBtrHMgtHOmrTZWdpw0YzpPZY+wCmmUttQRolqgXTi19scWebejGkZzs7BtOccZSroWtfqScE4OMjsqjrsra5zdD/SblVXK/86FvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284804; c=relaxed/simple;
	bh=GL6X/fFSI1ioyhzxGjfZhJACrgZ06TMQ9IkjkuaWBvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqRnKuH1UuukRnufkJQqDXovdw+9FwV8GoY1btWwqDc1l0mQHwT1SgDDkBA4KF2JOCmGi6D2n/qL/5vHKeqgj1hLRWZFFFiUSYG6G2L0AmA8CJ/0chMiiUjEaTR0RKcEcaMnwqXfV5JmUboMFOuESgbdXGQi8/YbvtOP9gedxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ecUigaXU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713284800;
	bh=GL6X/fFSI1ioyhzxGjfZhJACrgZ06TMQ9IkjkuaWBvA=;
	h=From:To:Cc:Subject:Date:From;
	b=ecUigaXU7f/lxGTueKQCOBNFi5TeW84E5VmiI2xqJ+bZFZuJwVt51WNjgDrKnV6IJ
	 XgWIzm+H86s6lh8S6oEWDksp+lvLy7cUn6NEAqIbAgzuB/Ut6fDVVSCso/WSuymVWl
	 B90/VNyVUbZSmcwEwsYQKNM/XgsB9WiNW0q9feF27JY4PRYHGrpB67Zbi7R5vvLaH2
	 qXcmiajvmxZ5OsmpOSkqMdMY9o5pOXr8ysodw87NKVOZQlDXD1++zRXFkAL7TUztcD
	 C7ZQw3qHTMx/xTnm8J6J4nxkCUbhTdYNWD4StI0aPP9Xw1J7hRDAWjxtlBcmrHyWzA
	 8PIzm0YI+zt2g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEB733780894;
	Tue, 16 Apr 2024 16:26:35 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Zi Yan <ziy@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: mm: fix unused and uninitialized variable warning
Date: Tue, 16 Apr 2024 21:26:58 +0500
Message-Id: <20240416162658.3353622-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the warnings by initializing and marking the variable as unused.
I've caught the warnings by using clang.

split_huge_page_test.c:303:6: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
  303 |         int dummy;
      |             ^
split_huge_page_test.c:343:3: warning: variable 'dummy' is uninitialized when used here [-Wuninitialized]
  343 |                 dummy += *(*addr + i);
      |                 ^~~~~
split_huge_page_test.c:303:11: note: initialize the variable 'dummy' to silence this warning
  303 |         int dummy;
      |                  ^
      |                   = 0
2 warnings generated.

Fixes: fc4d182316bd ("mm: huge_memory: enable debugfs to split huge pages to any order")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 6c988bd2f3356..d3c7f5fb3e7b7 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 		char **addr)
 {
 	size_t i;
-	int dummy;
+	int __attribute__((unused)) dummy = 0;
 
 	srand(time(NULL));
 
-- 
2.39.2


