Return-Path: <linux-kselftest+bounces-28755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D1A5CA4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8CC1685B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCA625C715;
	Tue, 11 Mar 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mIk0shyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6CEC5
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709282; cv=none; b=syJdy7LcG8qmq4I+unK6NPO9S1mLoafnhzIzQYxi1N3ewG1twd25QSOKqXljv/G7jZHJABRZb/+i7BUj3Uc4ssuG7xdD2L5AP80ULpZezroL520vxKHI01kACCNRt4tcdx2ihrw8tUA+v4zgXJhN+6ryJ9wudvW/kKLqpjddqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709282; c=relaxed/simple;
	bh=DMGHNogM7Z4hx/o09y/qGlLY2NWlMqkZQ4VGPdAh6ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWRlXSRg4vg4Jpno3zL759s9kR0eYOmJCn7IBbxfpcZuaJ9jQ7Sudw5irsOU6Q1GBG+KnR8FR3YSP55cqhUTh5mY7p8YHru+CT+GI8JAFFUoNBAS6iR/VUnQsTqhkM680Wm3BwCIqwRGb8gb+AuQd6Kw4q9MfSDXt4s8DTtH1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mIk0shyG; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:921:0:640:b194:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 70F1060AEE;
	Tue, 11 Mar 2025 19:07:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id n7tHR9GLdmI0-wBKxvDjv;
	Tue, 11 Mar 2025 19:07:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1741709270; bh=zyJK+4QXLLXLCqLqyjCnVXKQlXjvZxm1jiEVlWSMYN8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mIk0shyGY8hklIbDpjQgyOOoGEFaRZAe9F/ymOclC3RhD1Gh29kiz3feU+WPd8C0O
	 +m+sdL51Y1djTTsze5fAmoC+3MjrwWiWozTXdDnv4OhjEVejApckFCCpSRX6XemJMz
	 B4pFbx9SOpNOfX7UhgW2jimVQeVdvbG5hHje0ET4=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] selftests/pid_namespace: fix building with clang-20
Date: Tue, 11 Mar 2025 19:07:05 +0300
Message-ID: <20250311160706.75319-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using 'make LLVM=1 W=1 -C tools/testing/selftests/pid_namespace'
with clang-20, I've noticed the following:

pid_max.c:42:8: error: call to undeclared function 'mount'; ISO
C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
   42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |               ^
pid_max.c:42:29: error: use of undeclared identifier 'MS_PRIVATE'
   42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |                                    ^
...

So include '<sys/mount.h>' to add all of the required declarations.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..972bedc475f1 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
-- 
2.48.1


