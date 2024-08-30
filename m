Return-Path: <linux-kselftest+bounces-16789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7F9661AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE091B253E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32F199FDD;
	Fri, 30 Aug 2024 12:29:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68624199FA4;
	Fri, 30 Aug 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020940; cv=none; b=kw4EwxKc8ECWGBtw57srqal613bKu/22hJbN8HVGIA7V6AzIorjVME/zwrh2/mmidC8HHF5QCnXcBUzBX6aPWDKdUTNXA02LvGjxHX5TCIX/i3tyFAUCtThrH5QCqq15Fdgr8KcH57etdusVb8FwQz7Fr6avemlgxDPtynodjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020940; c=relaxed/simple;
	bh=oJ1xcMwdmfR/v7V7BgzIj/WZTewzoHvz/SQaj3yOdaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe/nEkNVAUmf6N/DbS0tZT8d5YsuYvJ2Z/pAKnwOqJFE6NBpkxm0WyjnOpScDjIFKFnXXBM9vEYUZOyWu5xL/w+vcKya5jknvtNX5OwQPvKZPZYDeykaYrHF45SjrtnWm46crhG/cnistvOk7yKFqE4vAjF7867jCWVATBHFPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwHWS32fZz9sSK;
	Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqpSmI7yge0W; Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwHWR5DWgz9sS8;
	Fri, 30 Aug 2024 14:28:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A1C238B764;
	Fri, 30 Aug 2024 14:28:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TbYxRHbKDEWk; Fri, 30 Aug 2024 14:28:51 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 263AD8B799;
	Fri, 30 Aug 2024 14:28:51 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@mit.edu>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] selftests: vdso: Fix vdso_config for powerpc
Date: Fri, 30 Aug 2024 14:28:36 +0200
Message-ID: <f6b730b24361e4154019ec5fefdb8b9b10afb396.1725020674.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
References: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725020918; l=1294; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=oJ1xcMwdmfR/v7V7BgzIj/WZTewzoHvz/SQaj3yOdaw=; b=ola5krc4mogdL/CH2op9DISC1pgL83EAmvQG0ipPNvIi4OTmpyR5rqdBXqAi/GUztMEdV3jnO AA4aGWq4LdpCk99ICkbprGAUK68fxmfkBshaZFfPlqnNGAlyTYJjTq4
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Running vdso_test_correctness on powerpc64 gives the following warning:

  ~ # ./vdso_test_correctness
  Warning: failed to find clock_gettime64 in vDSO

This is because vdso_test_correctness was built with VDSO_32BIT defined.

__powerpc__ macro is defined on both powerpc32 and powerpc64 so
__powerpc64__ needs to be checked first in vdso_config.h

Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/vDSO/vdso_config.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 7b543e7f04d7..00bfed6e4922 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -18,13 +18,13 @@
 #elif defined(__aarch64__)
 #define VDSO_VERSION		3
 #define VDSO_NAMES		0
-#elif defined(__powerpc__)
+#elif defined(__powerpc64__)
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
-#define VDSO_32BIT		1
-#elif defined(__powerpc64__)
+#elif defined(__powerpc__)
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
+#define VDSO_32BIT		1
 #elif defined (__s390__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
-- 
2.44.0


