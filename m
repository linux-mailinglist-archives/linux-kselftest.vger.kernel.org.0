Return-Path: <linux-kselftest+bounces-12056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555F90AFFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4082F1C22895
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE511CB31A;
	Mon, 17 Jun 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDcp4FK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FB1CB317;
	Mon, 17 Jun 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630651; cv=none; b=YHysR3L6PWrAK5GjqchCdW3LfnCBObwzfB3WNm4FUC+beodQTdPKjnW7J8eg0PH7kmKGOUV9mfKxIGsBhK7iIttiPhSeDUPgEOaW4KiF3CRe0AiEY+smb0X7Uzn/0f9wJoQCgdUEud7D3BuINcqYFktwsAsCYWhVV4UNUVvbcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630651; c=relaxed/simple;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROkJG5l+ENljT9GOk4q5tDoFrtTUmm0m+a0UmlnE/4V2H3H3mWhm1eGZY12/04z2xuVGayCR1zPl3LcxWxuILPTcISYD2pcsSybvoOPhwt5sycKysRqUtSb3adzHybDcuN8rSUuXFz5ZBZy/IpmTKnCoifurS1Vr6bRIYFnApTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDcp4FK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDD8C4AF1C;
	Mon, 17 Jun 2024 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630651;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDcp4FK3RCxqYrUItBejA3bpA4kmcj13YO+6aYss/PXFyUa3SkS+7N1jGGiio+lTr
	 U8ZGtPhLv56mlxWPgyozbqRWcgZ3+5RCB2C/zpopHwhqFvXOYeKqVzk+AtaSt6Tlrn
	 kIOc1WxHVz5IG+RTbhPAXX4bvc2x5zjTU/KjUt6hQ5+/CSKpmQhcxgIUr8Rj8YczNL
	 7nREW2fCKug9TKSiFx3MswJj4ZHbdXvc0Ai6nMfX0tAp3CRs7fveesOslcLHQLDAW1
	 56Yzyo98bQjV+Be51em/xY9vRPu1QgjD0I51wC8v5m2lUPPWgj6pogstsB3uxjM8LA
	 dSdFvzdgowlfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Hubbard <jhubbard@nvidia.com>,
	Edward Liaw <edliaw@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	shuah@kernel.org,
	nathan@kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 24/35] selftests/futex: pass _GNU_SOURCE without a value to the compiler
Date: Mon, 17 Jun 2024 09:22:22 -0400
Message-ID: <20240617132309.2588101-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit cb708ab9f584f159798b60853edcf0c8b67ce295 ]

It's slightly better to set _GNU_SOURCE in the source code, but if one
must do it via the compiler invocation, then the best way to do so is
this:

    $(CC) -D_GNU_SOURCE=

...because otherwise, if this form is used:

    $(CC) -D_GNU_SOURCE

...then that leads the compiler to set a value, as if you had passed in:

    $(CC) -D_GNU_SOURCE=1

That, in turn, leads to warnings under both gcc and clang, like this:

    futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined

Fix this by using the "-D_GNU_SOURCE=" form.

Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e5..994fa3468f170 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.43.0


