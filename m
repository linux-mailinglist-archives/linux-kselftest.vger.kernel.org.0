Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B392ECE6E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfJGPLA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 11:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPK7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 11:10:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DC52070B;
        Mon,  7 Oct 2019 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461059;
        bh=84/HqT9rjw/ELPe/YzzmH2eHPW0t/8HjIohY6R+znnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw9OGIRI9RqdnSy4oZPeNStZX1gdwhkf+OFlDYTq4c51wm4MN+eXD4kZI3N5U29az
         z/nR/xtQIBTxnkrMmxpKLRImytwdFeTX4iTjR5lheoQep6rMnPSE8Jo36e2OPkL78z
         WuVPp9iOi2CVorN32tPZZ6/0e77/+hnXA19UG0sQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH 4/5] selftests: net: Fix printf format warnings on arm
Date:   Tue,  8 Oct 2019 00:10:55 +0900
Message-Id: <157046105559.20724.16258893324176271286.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix printf format warnings on arm (and other 32bit arch).

 - udpgso.c and udpgso_bench_tx use %lu for size_t but it
   should be unsigned long long on 32bit arch.

 - so_txtime.c uses %ld for int64_t, but it should be
   unsigned long long on 32bit arch.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: David S. Miller <davem@davemloft.net>
---
 tools/testing/selftests/net/so_txtime.c       |    4 ++--
 tools/testing/selftests/net/udpgso.c          |    3 ++-
 tools/testing/selftests/net/udpgso_bench_tx.c |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 53f598f06647..34df4c8882af 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -105,8 +105,8 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 	tstop = (gettime_ns() - glob_tstart) / 1000;
 	texpect = ts->delay_us >= 0 ? ts->delay_us : 0;
 
-	fprintf(stderr, "payload:%c delay:%ld expected:%ld (us)\n",
-			rbuf[0], tstop, texpect);
+	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
+			rbuf[0], (long long)tstop, (long long)texpect);
 
 	if (rbuf[0] != ts->data)
 		error(1, 0, "payload mismatch. expected %c", ts->data);
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index b8265ee9923f..cab334e51ac1 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -448,7 +448,8 @@ static bool __send_one(int fd, struct msghdr *msg, int flags)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != msg->msg_iov->iov_len)
-		error(1, 0, "sendto: %d != %lu", ret, msg->msg_iov->iov_len);
+		error(1, 0, "sendto: %d != %llu", ret,
+			(unsigned long long)msg->msg_iov->iov_len);
 	if (msg->msg_flags)
 		error(1, 0, "sendmsg: return flags 0x%x\n", msg->msg_flags);
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index ada99496634a..17512a43885e 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -405,7 +405,8 @@ static int send_udp_segment(int fd, char *data)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != iov.iov_len)
-		error(1, 0, "sendmsg: %u != %lu\n", ret, iov.iov_len);
+		error(1, 0, "sendmsg: %u != %llu\n", ret,
+			(unsigned long long)iov.iov_len);
 
 	return 1;
 }

