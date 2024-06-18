Return-Path: <linux-kselftest+bounces-12143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A2590CC25
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FED1F20F8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F615B558;
	Tue, 18 Jun 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOYi/9Lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF613E41F;
	Tue, 18 Jun 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714244; cv=none; b=PMyaM+JFKDauQwZXEMCbyknRNsu91zGYLvk0HcSMlfh1iIH8UXw7XW+lTl3dh4DervB9XBS2mOyI59UyM7zoxF6+4ev+S0wmaVC3I2s0orQgs++jxrZMZaUbXXrfh6VE0lYG30aPsgFtsnfZIMTEYHdp+Al7By0dM0EXMFLvrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714244; c=relaxed/simple;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym98DPMbOGWij9MRL7TJ41LkvMtdDvfFTnK/AHB6yj5p9HQQS0FyxuwLrJ1UY0WZwD0yffuX7RtSK6hlP05ocp9P4o9rLKBD6Tx8JnsVsLrZgho2jalGTiY8ged13ZKXnWmMJ7GBJ83dSnUWrm1X2nTbDPtlGPgCY1q8seFOTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOYi/9Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26DAC3277B;
	Tue, 18 Jun 2024 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714244;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOYi/9LuC2bmRIvveX+9cnnU3zYdbFfpwOIeX9a37rX7oFvw916D5WUOSyCKiedoG
	 wIej7g1auAOk+IfSu2Ln+EK3CSHlKGWoD31bAwJGJWhcDkPW5Ghiu5oyvyGFLW4os/
	 hGgcBwdmNt0/tsTw3GYWQOQnUHKeERehwVZN6YwCWdMyMgEUGgDMufdZd3SsGaGVTg
	 A7WrwO4+vG1BaKsPprv7Dt0YNDWRE535ZHByG481zuax5LPA+5QkieLq17Ngj9rq8K
	 ZT2cP2ZZQkOBwWKBECdaH4ZefsFOt/8V1HNysyAkIaOYoGR7kQwU7af4YmfXvlWcje
	 tHyf2POhT+Ehg==
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
Subject: [PATCH AUTOSEL 6.9 28/44] selftests/futex: pass _GNU_SOURCE without a value to the compiler
Date: Tue, 18 Jun 2024 08:35:09 -0400
Message-ID: <20240618123611.3301370-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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


