Return-Path: <linux-kselftest+bounces-36489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E3AF8409
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 01:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AED1C854C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF62D94B6;
	Thu,  3 Jul 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilVfLGWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAB2D5427;
	Thu,  3 Jul 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751584670; cv=none; b=bq0WnRgVZg6mXECxsup9Ptc/n0w7ZL6DEhJj9Ml9kPmv9zj8bEbNyYtfUvp7yyPJKTQWv02ftEcbVsVq86zRRvw3ioyd/8cg0NTK0ixsarvD48jwxIsPkGzR7m8cIj/BZ23SGDOHGjStL5+EdGwJwmXRpBEErsWInx+eLhEKh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751584670; c=relaxed/simple;
	bh=uhsiemPpx0IFgieoxgJV8+bHgab638fpTiXPrK5ZQug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihg4HzCFzbrLcFdPSsWVqxFXJnEpRorTtQvKPKFl8oOaaWXy2sbJtRtYgN8SA5tWzP2HzND0Jp6Rkdjj3AaQYgK7mHwaEaa4gqQmD28a5k5PURywiTiXDs1F6OpBBK1WShvkGTk8LJzMGPqoXSYwkiemv4zGtWnPUM4WvbPMDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilVfLGWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFDC4CEE3;
	Thu,  3 Jul 2025 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751584669;
	bh=uhsiemPpx0IFgieoxgJV8+bHgab638fpTiXPrK5ZQug=;
	h=From:To:Cc:Subject:Date:From;
	b=ilVfLGWJzxkpd4YF29J3kgwJOetoi/cZ0RVlxrcxojgyzf/Fqwwo1n/LbHC3yqVDt
	 ONVzIY3WVg55yq+Eod9bbI+ihBORKcEhRGs9gETcito/CdfUqW2OcvUtj+D7Ybw71L
	 T3GkmrYwlAqGsaZe81racJ3wQ8PM2+uWsY+yTCa4=
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: print installation complete message
Date: Thu,  3 Jul 2025 17:17:46 -0600
Message-ID: <20250703231747.37544-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add installation complete message to Makefile install logic.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9dae84a74e7f..b95de208265a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -300,6 +300,7 @@ ifdef INSTALL_PATH
 	else \
 		printf "Unable to get version from git describe\n"; \
 	fi
+	@echo "**Kselftest Installation is complete: $(INSTALL_PATH)**"
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
-- 
2.47.2


