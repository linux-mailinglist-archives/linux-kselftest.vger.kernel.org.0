Return-Path: <linux-kselftest+bounces-10713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8F8D03B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357B92845C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7C181D0B;
	Mon, 27 May 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJTpAyUl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315C181D06;
	Mon, 27 May 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819330; cv=none; b=JJpYFuHdYFIhGQyaxO2svEMcdpJ29D3sYFdU3uqWe8N9tJxulrGnbmmLT4L+ZEL0fpnTHx7nxMxyk9irl1df6gWJYCZGQE+TUIkkZ/4/ATzk75u7/kfulMzrPdWfRYXYFvruA5y7zLk0B75oJdi4vzoiHzW34NEKdL6LEbnLQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819330; c=relaxed/simple;
	bh=s+lIrPPcCGvUZL3PbI5a5ZKTRpmk/nMe5exqy1s372s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3IlJzS9QtMWBpBcGWWim6Iz+4qdNOsruexyGcR7n1fYcCDLKBKNE6lJEbTJ46obd44xX2Y8o+o0pMas8+3wO9sOPMIr6J5zHeOvFVXxKF5LhTx5j7Id/RsEeDBVG6GOO0M7FlkRHgxJj33Pedq7dhUAirw4rI1xTsuxHhI3Hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJTpAyUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E595CC4AF07;
	Mon, 27 May 2024 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819330;
	bh=s+lIrPPcCGvUZL3PbI5a5ZKTRpmk/nMe5exqy1s372s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJTpAyUlmTcOPgbv1Iom/IegijQaR5HVZ+AbGJ8bNP7MO29GhlKvTBgcIdAx17N4o
	 RcTnRaZ7lj5M/Cv99jze9spVWDMdGmXhZEMXtvJUUMsqhllTRl2xStgywWBobFghDR
	 c36k1nCMd7xn9TUD3fukt5ULLUz+jgVpwOSO3GyyczE59tdsXr3aCsCY5zdUB0GVpy
	 5dJnD/vvvp/rFMXuv+8ibHbgPYNaGB8EJHFz3nqOwSgzAwH1v+P0OztutvfRioTGta
	 2Wp/i5nVNSllOQu3K3KQUo4705Udignf0M6EwRBbQ+wHoq6vnRAz7eCs9mMuv8UMh4
	 iPa6fzlvjZRUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 29/30] selftests: net: fix timestamp not arriving in cmsg_time.sh
Date: Mon, 27 May 2024 10:13:38 -0400
Message-ID: <20240527141406.3852821-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 2d3b8dfd82d76b1295167c6453d683ab99e50794 ]

On slow machines the SND timestamp sometimes doesn't arrive before
we quit. The test only waits as long as the packet delay, so it's
easy for a race condition to happen.

Double the wait but do a bit of polling, once the SND timestamp
arrives there's no point to wait any longer.

This fixes the "TXTIME abs" failures on debug kernels, like:

   Case ICMPv4  - TXTIME abs returned '', expected 'OK'

Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20240510005705.43069-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/cmsg_sender.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index c79e65581dc37..161db24e3c409 100644
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
+	unsigned long ts_seen = 0;
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
2.43.0


