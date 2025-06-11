Return-Path: <linux-kselftest+bounces-34659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE57AD4D49
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8BA3A85FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63E248F40;
	Wed, 11 Jun 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZwKLG8I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu9FsCQI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF92242D9D;
	Wed, 11 Jun 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627522; cv=none; b=od3NPQ1Gj9rNuXPqRdKtMN88LUJGR/E6MuqFc6NDt1QIWjl6UuQgeh7oIh8ngyWkujnBE5EdbZc10qGTAUk3fxuvKycKo+DpL4WjkCbIDxnTSP3Wniki8UP9bufNU+d9cpZtv45UP1qHFc91clgd6IgYISkvXyLTSbAI96j3RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627522; c=relaxed/simple;
	bh=bI9Z3Z4OikY2vHRcbYfX3N2odvEeMwzFe2AM1aXY+bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aw7K3iCfDIucYGuoieIGqkNGvY1NgfSBTLjJyqsyvbNStJWUhpXdomV76KJ/UdW5kM2wymU1vLLoNAIzF2F/+dvy452vo+ui5ResupgypezRDkiKdQ35cqP/kO39IyfZvw+tJlZR96Zt63wzLlTF6WhMuxs+oIeL6Dme7fvEc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZwKLG8I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu9FsCQI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTxmS6W6qZRqdjglNd/91xq5t0Sf7lvKNn22lds3tBg=;
	b=oZwKLG8IUYTuUtRD28FKxeMMdCaTX/U77iFBOswUdySXxbVT0aDEE12rgFAxHJCdJ7Tm2U
	j6NkHDdUdtsgxon12m0mDq8uGHOm6NbZH9Wbi8QU0k7qSuW6trogSG6s6qz86EhOh1od19
	EGXzQh4JsW4Y2bflXKGr3DuGTzNmqMU8nmrZQ4ve6JTaAL5koDWhDLxSwQPz3bSPy63zFR
	MTqLMd0CNemfTcflrIwpcgZj/z0ITqLcGZ4FSTgUhKXBbpB4/m9EQJ+v34ck3A4Bg9hqbq
	x0QK8ENEZh104a9oRpzVdBpWgJKwvbgWBntL+tJDDmxIYSks5Dw6ZfZ9TtiB9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTxmS6W6qZRqdjglNd/91xq5t0Sf7lvKNn22lds3tBg=;
	b=Wu9FsCQIrzyRPV9W4FVqoM9fMCPZfkB3SrqeMepwTJ5K0yPoPDHGsRbu3xfz8QlRFhndmH
	eC2CiW8jpb6AobAw==
Date: Wed, 11 Jun 2025 09:38:22 +0200
Subject: [PATCH v3 16/16] kunit: uapi: Validate usability of /proc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-16-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1609;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bI9Z3Z4OikY2vHRcbYfX3N2odvEeMwzFe2AM1aXY+bg=;
 b=BvsjK8jQfTlN3RKliodcN6Wpr2QQ8UHWYzK87A9Ed7LZXQp5P1ASKEUXcxymrizK7ceed/oo0
 tW6g6ftHi92ABxOyphlY05wObpqRI2GKkfZjkxgZImTBYuS2FOV2ylS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show that the selftests are executed from a fairly "normal"
userspace context.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/kunit-example-uapi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uapi.c
index 4ce657050dd4a576632a41ca0309c4cb5134ce14..5e7a0f3b68f182c42b03e667567e66f02d8c2b86 100644
--- a/lib/kunit/kunit-example-uapi.c
+++ b/lib/kunit/kunit-example-uapi.c
@@ -8,13 +8,45 @@
  * This is *userspace* code.
  */
 
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+
 #include "../../tools/testing/selftests/kselftest.h"
 
+static void test_procfs(void)
+{
+	char buf[256];
+	ssize_t r;
+	int fd;
+
+	fd = open("/proc/self/comm", O_RDONLY);
+	if (fd == -1) {
+		ksft_test_result_fail("procfs: open() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	r = read(fd, buf, sizeof(buf));
+	close(fd);
+
+	if (r == -1) {
+		ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (r != 16 || strncmp("kunit-example-u\n", buf, 16) != 0) {
+		ksft_test_result_fail("procfs: incorrect comm\n");
+		return;
+	}
+
+	ksft_test_result_pass("procfs\n");
+}
+
 int main(void)
 {
 	ksft_print_header();
 	ksft_set_plan(4);
-	ksft_test_result_pass("userspace test 1\n");
+	test_procfs();
 	ksft_test_result_pass("userspace test 2\n");
 	ksft_test_result_skip("userspace test 3: some reason\n");
 	ksft_test_result_pass("userspace test 4\n");

-- 
2.49.0


