Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57969E1153
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 06:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfJWE6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 00:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388661AbfJWE6C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 00:58:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E686921906;
        Wed, 23 Oct 2019 04:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806682;
        bh=FIUvS515BRyZWWsbgjwGzMabdeFOcPuhq53HL6bR4Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eqqx63IuON9QIIijGLi4L9ePjOEInJNUQ9rkqclGQmOOus5TaFFCPoRVMyL1rzngQ
         opv32+qCfjn29o+X2GVx6nNbKQ1mBIA/aKSgFxzneyd30kvmGw+e/SlVJ9V/bkK884
         EvrzwuZjG2G/HPUsOY7GVwBMeju2oNe4n+g4Vc18=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH v3 3/5] selftests: net: Use size_t and ssize_t for counting file size
Date:   Wed, 23 Oct 2019 13:57:58 +0900
Message-Id: <157180667854.17298.10831083001890325403.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157180665007.17298.907392422924029261.stgit@devnote2>
References: <157180665007.17298.907392422924029261.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use size_t and ssize_t correctly for counting send file size
instead of unsigned long and long, because long is 32bit on
32bit arch, which is not enough for counting long file size (>4GB).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
---
 tools/testing/selftests/net/tcp_mmap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 31ced79f4f25..33035d1b3f6d 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -71,7 +71,7 @@
 #define MSG_ZEROCOPY    0x4000000
 #endif
 
-#define FILE_SZ (1UL << 35)
+#define FILE_SZ (1ULL << 35)
 static int cfg_family = AF_INET6;
 static socklen_t cfg_alen = sizeof(struct sockaddr_in6);
 static int cfg_port = 8787;
@@ -155,7 +155,7 @@ void *child_thread(void *arg)
 			socklen_t zc_len = sizeof(zc);
 			int res;
 
-			zc.address = (__u64)addr;
+			zc.address = (__u64)((unsigned long)addr);
 			zc.length = chunk_size;
 			zc.recv_skip_hint = 0;
 			res = getsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
@@ -302,7 +302,7 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage listenaddr, addr;
 	unsigned int max_pacing_rate = 0;
-	unsigned long total = 0;
+	size_t total = 0;
 	char *host = NULL;
 	int fd, c, on = 1;
 	char *buffer;
@@ -417,7 +417,7 @@ int main(int argc, char *argv[])
 		zflg = 0;
 	}
 	while (total < FILE_SZ) {
-		long wr = FILE_SZ - total;
+		ssize_t wr = FILE_SZ - total;
 
 		if (wr > chunk_size)
 			wr = chunk_size;

