Return-Path: <linux-kselftest+bounces-9979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AAB8C1BDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2D01C213E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA04137931;
	Fri, 10 May 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNCIvRRK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA43137925;
	Fri, 10 May 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302701; cv=none; b=gJew4+5I4dVstGeic7kZtp8yUaaTykjCydYjlIJZyrL4u+97yZ+gsn6TRG7MMpHRdQMCX9pvwlvMW1SJuUhQMbYRYCyoO6qglEtD17MBEg8MW+zDXFV6FADkJwucjOV+4IktuColCsT8MToSL79ObzSsTCgHDQcJzxLqhFuZsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302701; c=relaxed/simple;
	bh=7T+Yp+4uFqfXgd2aYFPdSwfxDXWerTLDOmWnFl37rEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfGZnTO94MAPTxyYFd+lrW1QtGr737U98KhUN3+M/8CjtCaD4HLvNd56Vcppf3tC1YCscebcN88Yovr7VXMvVrtiPaxlRnNUvuvCxTp+jS3ZmrmWOypK13nQQViPv3k+LZg22BPISUfxoyahNDtriy74C66ZcT11RedZ4CYGGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNCIvRRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F354BC3277B;
	Fri, 10 May 2024 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715302701;
	bh=7T+Yp+4uFqfXgd2aYFPdSwfxDXWerTLDOmWnFl37rEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNCIvRRKRnr2QVi+J6iFi80IkYQbGPLFHfRupzW1Ni7ToTB+wZ6w8oiua5rDl1L6O
	 zTEaEanhfDlUBg3jEJqZWpTM3Lhv4EdmBBAMIuiyloCKMyiLc3tGPOowlfYGKsA+FL
	 0IhqW2zPB9hPg8SYLFipxX3rrLInqb1pxS6+xCArDStLn0+nzLGkR2doe3XjEYdWMe
	 pWsgOBdJo+V0TzPGFu6mjurqUUlPEPxv+32nbVDIaigbRBSAaFAPyDuuSnffJdaDSL
	 RLVUMgeGuaPQJ2Hv4yxWrQGjtTepy063HVn9RYlWD/k0a3lfyB+VFGgZ0HLYA6deD+
	 4wWWiKcz51UUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: net: increase the delay for relative cmsg_time.sh test
Date: Thu,  9 May 2024 17:57:05 -0700
Message-ID: <20240510005705.43069-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510005705.43069-1-kuba@kernel.org>
References: <20240510005705.43069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slow machines can delay scheduling of the packets for milliseconds.
Increase the delay to 8ms if KSFT_MACHINE_SLOW. Try to limit the
variability by moving setsockopts earlier (before we read time).

This fixes the "TXTIME rel" failures on debug kernels, like:

  Case ICMPv4  - TXTIME rel returned '', expected 'OK'

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/cmsg_sender.c | 32 +++++++++++++----------
 tools/testing/selftests/net/cmsg_time.sh  |  7 +++--
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index f25268504937..b2df05ef71cb 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -260,15 +260,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 			  SOL_IPV6, IPV6_HOPLIMIT, &opt.v6.hlimit);
 
 	if (opt.txtime.ena) {
-		struct sock_txtime so_txtime = {
-			.clockid = CLOCK_MONOTONIC,
-		};
 		__u64 txtime;
 
-		if (setsockopt(fd, SOL_SOCKET, SO_TXTIME,
-			       &so_txtime, sizeof(so_txtime)))
-			error(ERN_SOCKOPT, errno, "setsockopt TXTIME");
-
 		txtime = time_start_mono.tv_sec * (1000ULL * 1000 * 1000) +
 			 time_start_mono.tv_nsec +
 			 opt.txtime.delay * 1000;
@@ -284,13 +277,6 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 		memcpy(CMSG_DATA(cmsg), &txtime, sizeof(txtime));
 	}
 	if (opt.ts.ena) {
-		__u32 val = SOF_TIMESTAMPING_SOFTWARE |
-			    SOF_TIMESTAMPING_OPT_TSONLY;
-
-		if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
-			       &val, sizeof(val)))
-			error(ERN_SOCKOPT, errno, "setsockopt TIMESTAMPING");
-
 		cmsg = (struct cmsghdr *)(cbuf + cmsg_len);
 		cmsg_len += CMSG_SPACE(sizeof(__u32));
 		if (cbuf_sz < cmsg_len)
@@ -426,6 +412,24 @@ static void ca_set_sockopts(int fd)
 	    setsockopt(fd, SOL_SOCKET, SO_PRIORITY,
 		       &opt.sockopt.priority, sizeof(opt.sockopt.priority)))
 		error(ERN_SOCKOPT, errno, "setsockopt SO_PRIORITY");
+
+	if (opt.txtime.ena) {
+		struct sock_txtime so_txtime = {
+			.clockid = CLOCK_MONOTONIC,
+		};
+
+		if (setsockopt(fd, SOL_SOCKET, SO_TXTIME,
+			       &so_txtime, sizeof(so_txtime)))
+			error(ERN_SOCKOPT, errno, "setsockopt TXTIME");
+	}
+	if (opt.ts.ena) {
+		__u32 val = SOF_TIMESTAMPING_SOFTWARE |
+			SOF_TIMESTAMPING_OPT_TSONLY;
+
+		if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
+			       &val, sizeof(val)))
+			error(ERN_SOCKOPT, errno, "setsockopt TIMESTAMPING");
+	}
 }
 
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/net/cmsg_time.sh b/tools/testing/selftests/net/cmsg_time.sh
index af85267ad1e3..1d7e756644bc 100755
--- a/tools/testing/selftests/net/cmsg_time.sh
+++ b/tools/testing/selftests/net/cmsg_time.sh
@@ -66,10 +66,13 @@ for i in "-4 $TGT4" "-6 $TGT6"; do
 		 awk '/SND/ { if ($3 > 1000) print "OK"; }')
 	check_result $? "$ts" "OK" "$prot - TXTIME abs"
 
-	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d 1000 |
+	[ "$KSFT_MACHINE_SLOW" = yes ] && delay=8000 || delay=1000
+
+	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d $delay |
 		 awk '/SND/ {snd=$3}
 		      /SCHED/ {sch=$3}
-		      END { if (snd - sch > 500) print "OK"; }')
+		      END { if (snd - sch > '$((delay/2))') print "OK";
+			    else print snd, "-", sch, "<", '$((delay/2))'; }')
 	check_result $? "$ts" "OK" "$prot - TXTIME rel"
     done
 done
-- 
2.45.0


