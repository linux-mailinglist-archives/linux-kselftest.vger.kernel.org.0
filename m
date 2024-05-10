Return-Path: <linux-kselftest+bounces-9978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D267A8C1BDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716E91F21C2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E9137915;
	Fri, 10 May 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBtotgt6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABE136E05;
	Fri, 10 May 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302701; cv=none; b=i7TNnGZopJiFbp16HkL09N/stmLzjU2pfub2ivbMisZvUocokYGUDL2RaWVqU+PSIU/JlvJ/ZDXF1w4qWm9b1RArmTeUrY93tU4JQzHTMGMYTkC7GfqaSHfmyl2fJAgOrdjTS4WcrdyFF7POJY07ze2Rql7PZtCMD8uUeVXKpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302701; c=relaxed/simple;
	bh=E1Hg2lIBJlVqWA1nCzaSvAkp8dfFdEjxUy2gGOp3VKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTTDfxgl43yM3SjBn02XmElJzCpXlqUulcFNt9imSuT/J9v3Gf2LXmAVL0DJ2dGJumKWUESgzGLfMBL2WhMTxw5bfhqJw8R0rAr3nLai6rE9DcGzSq+TM91CFW//1imSprcvNa9WC7VPCtM4T43jY8gLUCqLrPU87RmIDi+7US8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBtotgt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA06C116B1;
	Fri, 10 May 2024 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715302700;
	bh=E1Hg2lIBJlVqWA1nCzaSvAkp8dfFdEjxUy2gGOp3VKw=;
	h=From:To:Cc:Subject:Date:From;
	b=MBtotgt6iq92VJbWASqS2h9TDJv+i9Tn/BudkZToXQytIp6I3d3ptkOTAhUaaT43e
	 VjhyiozaWgstU1K56SmhAjhob904nUPSf+o4AYBmp6ubeTuJYnf7Isly3UlG+xl5ZH
	 hpWzaq+oa7bBbMNRTcZXzknbBkrgEFJmvuBwFWw67x628SPNVItIBMf4o+lzGwnF6h
	 zBwjKicxxcS8L6k2Sbp8WtQ74PnrSu2Hnh8hQO6KNDyOvpkbqN+YSNsR4mLszFQIMZ
	 naEWSdKoL13OJx07AguBJFPT3YcH8jcob89wKrsw9+GdTXEHdhFZng2/AZSVun8j0l
	 OfHpyBlRtXHoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/2] selftests: net: fix timestamp not arriving in cmsg_time.sh
Date: Thu,  9 May 2024 17:57:04 -0700
Message-ID: <20240510005705.43069-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On slow machines the SND timestamp sometimes doesn't arrive before
we quit. The test only waits as long as the packet delay, so it's
easy for a race condition to happen.

Double the wait but do a bit of polling, once the SND timestamp
arrives there's no point to wait any longer.

This fixes the "TXTIME abs" failures on debug kernels, like:

   Case ICMPv4  - TXTIME abs returned '', expected 'OK'

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/cmsg_sender.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index c79e65581dc3..f25268504937 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -333,16 +333,17 @@ static const char *cs_ts_info2str(unsigned int info)
 	return "unknown";
 }
 
-static void
+static unsigned long
 cs_read_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 {
 	struct sock_extended_err *see;
 	struct scm_timestamping *ts;
+	unsigned int ts_seen = 0;
 	struct cmsghdr *cmsg;
 	int i, err;
 
 	if (!opt.ts.ena)
-		return;
+		return 0;
 	msg->msg_control = cbuf;
 	msg->msg_controllen = cbuf_sz;
 
@@ -396,8 +397,11 @@ cs_read_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 			printf(" %5s ts%d %lluus\n",
 			       cs_ts_info2str(see->ee_info),
 			       i, rel_time);
+			ts_seen |= 1 << see->ee_info;
 		}
 	}
+
+	return ts_seen;
 }
 
 static void ca_set_sockopts(int fd)
@@ -509,10 +513,16 @@ int main(int argc, char *argv[])
 	err = ERN_SUCCESS;
 
 	if (opt.ts.ena) {
-		/* Make sure all timestamps have time to loop back */
-		usleep(opt.txtime.delay);
+		unsigned long seen;
+		int i;
 
-		cs_read_cmsg(fd, &msg, cbuf, sizeof(cbuf));
+		/* Make sure all timestamps have time to loop back */
+		for (i = 0; i < 40; i++) {
+			seen = cs_read_cmsg(fd, &msg, cbuf, sizeof(cbuf));
+			if (seen & (1 << SCM_TSTAMP_SND))
+				break;
+			usleep(opt.txtime.delay / 20);
+		}
 	}
 
 err_out:
-- 
2.45.0


