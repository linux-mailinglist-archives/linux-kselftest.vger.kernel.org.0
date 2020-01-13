Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9CB139697
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMQnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 11:43:24 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:26288 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgAMQnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 11:43:24 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 883BA3C1610;
        Mon, 13 Jan 2020 16:43:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a88.g.dreamhost.com (100-96-6-15.trex.outbound.svc.cluster.local [100.96.6.15])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 56B763C16D5;
        Mon, 13 Jan 2020 16:43:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a88.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Mon, 13 Jan 2020 16:43:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Keen-Stretch: 3235dbbf22ea3696_1578933801931_2886516590
X-MC-Loop-Signature: 1578933801930:4209032477
X-MC-Ingress-Time: 1578933801929
Received: from pdx1-sub0-mail-a88.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a88.g.dreamhost.com (Postfix) with ESMTP id 68405804B1;
        Mon, 13 Jan 2020 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=gotplt.org; bh=cD2vVZ2ZPP1g0U3aa4tqp4qDQSc=; b=jnHEh8whc1Z/n/
        L0df/B8iUhfgav37u3J/myrP1pw6td+64j9GQ8PBidyp5+6hWJ/IvVc9/aXIKmr7
        NOEkM/SZ/Kq+ret99VzpEFq301m8TSYBxQzqDyDfxGxM1XYdTzx7uiR/WuXR4omq
        7bqVAEAYfND2KF74vAZmavrlJ756g=
Received: from linaro-laptop.intra.reserved-bit.com (unknown [123.252.202.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a88.g.dreamhost.com (Postfix) with ESMTPSA id 26CCC804B3;
        Mon, 13 Jan 2020 08:43:07 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a88
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH] kselftest: Minimise dependency of get_size on C library interfaces
Date:   Mon, 13 Jan 2020 22:11:58 +0530
Message-Id: <20200113164158.15803-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuihguughhvghshhcurfhohigrrhgvkhgrrhcuoehsihguughhvghshhesghhothhplhhtrdhorhhgqeenucffohhmrghinheplhhinhgrrhhordhorhhgnecukfhppeduvdefrddvhedvrddvtddvrddujedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehlihhnrghrohdqlhgrphhtohhprdhinhhtrhgrrdhrvghsvghrvhgvugdqsghithdrtghomhdpihhnvghtpeduvdefrddvhedvrddvtddvrddujedvpdhrvghtuhhrnhdqphgrthhhpefuihguughhvghshhcurfhohigrrhgvkhgrrhcuoehsihguughhvghshhesghhothhplhhtrdhorhhgqedpmhgrihhlfhhrohhmpehsihguughhvghshhesghhothhplhhtrdhorhhgpdhnrhgtphhtthhopehmrghsrghmihdrhhhirhgrmhgrthhsuheslhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It was observed[1] on arm64 that __builtin_strlen led to an infinite
loop in the get_size selftest.  This is because __builtin_strlen (and
other builtins) may sometimes result in a call to the C library
function.  The C library implementation of strlen uses an IFUNC
resolver to load the most efficient strlen implementation for the
underlying machine and hence has a PLT indirection even for static
binaries.  Because this binary avoids the C library startup routines,
the PLT initialization never happens and hence the program gets stuck
in an infinite loop.

On x86_64 the __builtin_strlen just happens to expand inline and avoid
the call but that is not always guaranteed.

Further, while testing on x86_64 (Fedora 31), it was observed that the
test also failed with a segfault inside write() because the generated
code for the write function in glibc seems to access TLS before the
syscall (probably due to the cancellation point check) and fails
because TLS is not initialised.

To mitigate these problems, this patch reduces the interface with the
C library to just the syscall function.  The syscall function still
sets errno on failure, which is undesirable but for now it only
affects cases where syscalls fail.

[1] https://bugs.linaro.org/show_bug.cgi?id=3D5479

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Reported-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
---
 tools/testing/selftests/size/get_size.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/self=
tests/size/get_size.c
index d4b59ab979a0..f55943b6d1e2 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -12,23 +12,35 @@
  * own execution.  It also attempts to have as few dependencies
  * on kernel features as possible.
  *
- * It should be statically linked, with startup libs avoided.
- * It uses no library calls, and only the following 3 syscalls:
+ * It should be statically linked, with startup libs avoided.  It uses
+ * no library calls except the syscall() function for the following 3
+ * syscalls:
  *   sysinfo(), write(), and _exit()
  *
  * For output, it avoids printf (which in some C libraries
  * has large external dependencies) by  implementing it's own
  * number output and print routines, and using __builtin_strlen()
+ *
+ * The test may crash if any of the above syscalls fails because in some
+ * libc implementations (e.g. the GNU C Library) errno is saved in
+ * thread-local storage, which does not get initialized due to avoiding
+ * startup libs.
  */
=20
 #include <sys/sysinfo.h>
 #include <unistd.h>
+#include <sys/syscall.h>
=20
 #define STDOUT_FILENO 1
=20
 static int print(const char *s)
 {
-	return write(STDOUT_FILENO, s, __builtin_strlen(s));
+	size_t len =3D 0;
+
+	while (s[len] !=3D '\0')
+		len++;
+
+	return syscall(SYS_write, STDOUT_FILENO, s, len);
 }
=20
 static inline char *num_to_str(unsigned long num, char *buf, int len)
@@ -80,12 +92,12 @@ void _start(void)
 	print("TAP version 13\n");
 	print("# Testing system size.\n");
=20
-	ccode =3D sysinfo(&info);
+	ccode =3D syscall(SYS_sysinfo, &info);
 	if (ccode < 0) {
 		print("not ok 1");
 		print(test_name);
 		print(" ---\n reason: \"could not get sysinfo\"\n ...\n");
-		_exit(ccode);
+		syscall(SYS_exit, ccode);
 	}
 	print("ok 1");
 	print(test_name);
@@ -101,5 +113,5 @@ void _start(void)
 	print(" ...\n");
 	print("1..1\n");
=20
-	_exit(0);
+	syscall(SYS_exit, 0);
 }
--=20
2.24.1

