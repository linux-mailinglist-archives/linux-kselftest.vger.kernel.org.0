Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D74DE64A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJUI2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 04:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfJUI2N (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 04:28:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BA62064A;
        Mon, 21 Oct 2019 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571646493;
        bh=jZhiQuwui5uvdxmSEHpGwDzgWsZOGECYi8YLmpO+wis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fw3GOsHcrRlnYf6EDWIghgjjk9tJfPhY068ta0VS9094ZZvjMu4oDQBaQVNwc1Xrx
         rxk1GUJwWwCpcc8CnFg6nQWJLs/BYMEXKhcTeUgej5cLzWIkSf7srtJqqnlJaHwKiT
         1Sk3Y3pvUY6uZ2DLQaBMtLmctGm5JsL8uMssQ6pw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [BUGFIX PATCH v2 1/5] selftests: proc: Make va_max 1GB on 32bit arch
Date:   Mon, 21 Oct 2019 17:28:09 +0900
Message-Id: <157164648909.17692.6080553792829040898.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157164647813.17692.3834082082658965225.stgit@devnote2>
References: <157164647813.17692.3834082082658965225.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently proc-self-map-files-002.c sets va_max (max test address
of user virtual address) to 4GB, but it is too big for 32bit
arch and 1UL << 32 is overflow on 32bit long.

Make va_max 1GB on 32bit arch like i386 and arm.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 Changes in v2:
  - Make the va_max 1GB according to Alexey's comment.
---
 .../selftests/proc/proc-self-map-files-002.c       |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 47b7473dedef..5d372d66d6ad 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <stdlib.h>
+#include <asm/bitsperlong.h>
 
 static void pass(const char *fmt, unsigned long a, unsigned long b)
 {
@@ -44,10 +45,18 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 	exit(1);
 }
 
+#if __BITS_PER_LONG == 32
+# define VA_MAX (1UL << 30)
+#elif __BITS_PER_LONG == 64
+# define VA_MAX (1UL << 32)
+#else
+# define VA_MAX 0
+#endif
+
 int main(void)
 {
 	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	const unsigned long va_max = 1UL << 32;
+	const unsigned long va_max = VA_MAX;
 	unsigned long va;
 	void *p;
 	int fd;

