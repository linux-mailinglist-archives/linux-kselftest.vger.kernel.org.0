Return-Path: <linux-kselftest+bounces-10708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D98D033B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797929F1D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35416F90C;
	Mon, 27 May 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swWb++BR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577716F905;
	Mon, 27 May 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819210; cv=none; b=kzyUsXPpx0H5oz1CdQxbhdymxtcF9s4bclDAy4XHkjhRg0LqoVtTJJXNoQzHTmNJozXDyVwmw5xiQhu3Kh9W2BTjvGgRTgXKuJzEauaq4vtYh2Ms2Snp+d3e+LJqSQSFreq1mIY/6hP97maH8etlW7jvlMSPgJz7SSKFyig5tsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819210; c=relaxed/simple;
	bh=s+lIrPPcCGvUZL3PbI5a5ZKTRpmk/nMe5exqy1s372s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw1AmECHK6n5yw5IbbP8wJb8aNx5Ja+ez8a69nv6jAB2JzDUzM6yC9ndN1xXUaH7G93N/mJLskU5YQdRkqxVr9D6fxEhgML4f3zJ0+wc81d+ukil68xdfpzYuXVnF5AyEQRVWHs98WMAQ1QjDiC6LTg2po0JsBkWmrntHKG30QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swWb++BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6ABC4AF07;
	Mon, 27 May 2024 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819209;
	bh=s+lIrPPcCGvUZL3PbI5a5ZKTRpmk/nMe5exqy1s372s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swWb++BRCkHO09pbzSQrLJX85vpNXpIQkV2YahdQuyQEsi26+n2T4bKtwhVspiEkb
	 Hvl+a1jYuu215MpNVpn/Zeoe3l0sjuki2ClyvCtZmnoRBw4rOkflum7hfu/zTn6W52
	 wukpV0hRqs2hFpUm46IDwhGDX7CFBrk2XdJ0qPg4ZYaA0b2K4Dw1fhxigPJFWESYGy
	 YlwFT3NBS1GlWGWudBdcebIr/iU6zqo3MZY4LhKlRkj2by4CAPbXc6NboARuITxrGt
	 eU7vT/NNe56G68IdEQM0182haidst4KGuXZkvdj+++mmIUIrwACqmj51Y4poysWsuT
	 8NEMFKVhwKj6g==
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
Subject: [PATCH AUTOSEL 6.9 33/35] selftests: net: fix timestamp not arriving in cmsg_time.sh
Date: Mon, 27 May 2024 10:11:38 -0400
Message-ID: <20240527141214.3844331-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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


