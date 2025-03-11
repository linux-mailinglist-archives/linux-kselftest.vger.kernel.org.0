Return-Path: <linux-kselftest+bounces-28756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C0A5CA50
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D81E1696EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BEC25DD06;
	Tue, 11 Mar 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jg4+mTuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EE10E5
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709283; cv=none; b=f6Kc9Lg9jU4aOz+tR4D11qPmVJrruy7l8t+BNH/MbSTZHVosnltZHVF+ma4JYsJDpDuK1yNWCL7mUbf2gEqo+56UZbegjvH5fuTLNERG6ubLEkZYGXNKG40spAANVsot9GQtDaiGEndSlrlUmB/B1BBkcAlMKYdAtgPIsQXaau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709283; c=relaxed/simple;
	bh=XmGc++9nNFvtUszjH6QTM1uA3J5MGoQzqP20Xxvypws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN90InLz6qvGVCZvlb7LVai7B7MT3r1facs51+sqAdc+NQ22tk1H0TUGM26X1FYzD8GpCYvDmPqD9D6dp6k73/4WBsB8loLYykepv+Xko71vf9q49pX2GlPnevgHgDaOv40LiCa1zc9LInqh1/cg6/zOQ/FnDsRo7TtN9HL0zLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jg4+mTuJ; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:921:0:640:b194:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 2785360921;
	Tue, 11 Mar 2025 19:07:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id n7tHR9GLdmI0-reezGEJC;
	Tue, 11 Mar 2025 19:07:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1741709270; bh=+iVKCF0gkd3eqr/AHAxjduxuRkigR0Xbu2aV0HJ7dZw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=jg4+mTuJlrmAuWdy2jbfnYPUCyZ0MLp2r9mpX7xkjnb4KKaNA+JRAKtnLeKs6sLan
	 qwdOnVXFyF63AUlOTrD+/cIZ+alcLKaBtmzUn0X5WP5QynQNYOzjW6tz+MVCGF1fNZ
	 0kWtY7ISrl7V48iMNhh26l4/PL7Ynh6Wft1hOUQE=
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
Subject: [PATCH 2/2] selftests/pidfd: fix building with clang-20
Date: Tue, 11 Mar 2025 19:07:06 +0300
Message-ID: <20250311160706.75319-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311160706.75319-1-dmantipov@yandex.ru>
References: <20250311160706.75319-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using 'make LLVM=1 W=1 -C tools/testing/selftests/pidfd' with
clang-20, I've noticed the following:

pidfd_fdinfo_test.c:230:6: error: call to undeclared function 'mount';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |             ^
pidfd_fdinfo_test.c:230:29: error: use of undeclared identifier 'MS_REC'
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                    ^

and:

pidfd_setns_test.c:172:40: error: call to undeclared function 'ioctl';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
  172 |                 self->child_pidfd_derived_nsfds[i] = \
                               ioctl(self->pidfd, info->pidfd_ioctl, 0);
      |                        ^

So include '<sys/mount.h>' and 'sys/ioctl.h', respectively,
to add all of the required declarations.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 222f8131283b..9b0cebe263bc 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
 #include <linux/ioctl.h>
 
 #include "pidfd.h"
-- 
2.48.1


