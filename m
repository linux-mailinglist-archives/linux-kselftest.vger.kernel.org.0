Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162F8DE653
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfJUI2n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 04:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfJUI2n (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 04:28:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB622064A;
        Mon, 21 Oct 2019 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571646522;
        bh=84/HqT9rjw/ELPe/YzzmH2eHPW0t/8HjIohY6R+znnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMWor8CBwUXiQh5rncav7Kexi7FfflGraUBi23S3CZOr01iNX1VQLsciMv7n2F+gN
         ILZ9SLyBk+ytgnkp0cam9uHOQ+dgrEFa6dNOcDlJ00U174pRoAw6WR3NWQh4FrXQb3
         lTBvwTflNQadK3FLagX7olED2bSz6EsQgUNfXOG8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH v2 4/5] selftests: net: Fix printf format warnings on arm
Date:   Mon, 21 Oct 2019 17:28:38 +0900
Message-Id: <157164651785.17692.6080511663250117610.stgit@devnote2>
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

