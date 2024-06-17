Return-Path: <linux-kselftest+bounces-12052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A690AF71
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8753D28C9A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B01AC44F;
	Mon, 17 Jun 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJwlCP2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA31AC449;
	Mon, 17 Jun 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630520; cv=none; b=A3QOCo9+sj0hwdm9d5b9WrTQoz+obuWICLT2ljqYe1jAupuLwAXKo6eu88ePZkr7bvU6sebQywIQMbbJk7fRVLHfNMl6+QGZhSUmrxXig2NJe0SHr7oIdPdUVcXwpfGfGkBK5WgMyO5MLVoiMII470vqXKjd9kYG7wsnXE5bSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630520; c=relaxed/simple;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHN/GJYSCbh625hurTDpFzQYMTtU2rBRzt6Wh9BtMZ5zzIKO9GVkUmAY79kp6sEgarW1jYDhfNeZnoW/7M96vLUm89cIxc3kZt7kwv0ubaBoB6tFF4aRaeaz6HisieqiKV+OVNK5lpMRgPR3fosQ1bXZonM5uSodgJhoB7YAzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJwlCP2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3404C4AF1C;
	Mon, 17 Jun 2024 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630520;
	bh=Ko6WKs9ylk0r3aUSIT4ZiJ7bdYWw11IOSysG9UUFjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJwlCP2Zc0X+nmjY+kcdnpTK2FMNDEBAOx9lpom/dC/cjZ387qqH1pcWgQ+yKCZyf
	 lkYMbu1DSx3PaX8deNvMGimnMHYzvk/o9GseRdiijnyxA/7EDaH5VSJSm8BfbOt2c/
	 D87KNHSpfzQvpRRnEnqhXkDIbfA98ATfbqElzy5ogF2pFz+76COhzDLLlFXnAwICPm
	 IK4rbAmGiAnNZCLv4qZyo3zSyTF69kvr2j+f1kqy7755Ofgs5xLyyqH3Z21E7NrmTz
	 ZdrUoalrOD5a1/1/ct8cKrgm1fEwtQ5DUp5plRDi1HQEMyGVBC8MS3eyb2T93kRhBM
	 4yl0NK5SnIRxw==
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
Date: Mon, 17 Jun 2024 09:19:41 -0400
Message-ID: <20240617132046.2587008-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


