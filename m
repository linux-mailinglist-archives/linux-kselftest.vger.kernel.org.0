Return-Path: <linux-kselftest+bounces-12146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7B90CC9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220601C23C05
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809618E749;
	Tue, 18 Jun 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB6iaRDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907018E741;
	Tue, 18 Jun 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714374; cv=none; b=GHCKMJu/7VwdBgMX54FzhfDGvtZZE9wHCDF5tNHB+reLD6OPzgy3toqx+csCIyneGhLHs4EGv59y6dHMCBI0mokwn8cai/pupeWc/bEBa6Zq0PxKSSEZNHR2BNJFPqxeMwDxn/GaPIFATodR5P1z+i3edQjZNio0SrnSVPRQNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714374; c=relaxed/simple;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sejIpQ0QmHJegWOMKvozxzNgGk266Mksyf3/iCMy4bMdPnUZfN8MuAUNQGr0pJMl7l2zvVvPPrZjvvEuG8QM7+sfj2Os6edRdCoAU+80JhN3JxF7rmojH8fiYppzVoaSR2Jf+5Y/oKbMHA0hiR0T1G+DhNK8W2IgrvJkVhexfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB6iaRDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAAFC4AF48;
	Tue, 18 Jun 2024 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714374;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fB6iaRDdWLIJOvXgx1ldaGMbY02LtYRk2dqFnfnilf3pouH/k3P7VS9IDraXKvCaY
	 NQQ6UODTEhi0T6R+/y0tK/oPtLytA0yhUtYBDRHszssHmmFJXEkaah5EGNzlY9RV4s
	 MnbRU3MrSyBgejgjSPeawKY5P0CJ8OMyMFEIQs91x9E7CdRJiMKuZnsBXRoLr+H62/
	 ypdJxkfOF4A9sQn+g3Crg5LNnGKphz3yw40vZqFquEF02UG+QTGQ+bHZhdmrWAgcts
	 Vv5h/bLU4ztrDOitSVehqOAiTSnLq9VjuXQTVnvU0eEs1hYkYtif4qkihqU6yvYzl2
	 ZbwVFJDxfVT1g==
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
Date: Tue, 18 Jun 2024 08:37:44 -0400
Message-ID: <20240618123831.3302346-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
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


