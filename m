Return-Path: <linux-kselftest+bounces-21371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E079BB1C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0801C22090
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8A1C6F66;
	Mon,  4 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ8r06lf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685ED1C4A0D;
	Mon,  4 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717489; cv=none; b=HJw7jkRnDGHvWkANovJh1YbIWs1QjBClvhnwaKnOV+uA6/+GEY0m9afVL96nR4MqB0vBNd7+M13g9kht03ee0yDlWMPMppyAW4bvfKby8XVdLdvpoUAlAirign2np5gIEUXwLHf4Esz9VNKZvzah38ICoooKHDo3aVVIBE2lslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717489; c=relaxed/simple;
	bh=Ls6oxvs+pWHujG4KcpqaVa1cMjZQRW5kwwIpNlsHE3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmH7uSjVVWddXvHpmEyWACvuzMgzqbOX2U1/P8g/X9+3KA7Bqi74o9S8Kp9y4Gc0vLQBS0RtdZr8Yfu/sb+Bdl62w1xIM3CNzv19q9YN7FyWVlee9kG01rqxLLW/5eBXNATR10x3pFQtQd3ue2+V0GE3eTWWYH7EJ3yGslykIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ8r06lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19387C4CECE;
	Mon,  4 Nov 2024 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717489;
	bh=Ls6oxvs+pWHujG4KcpqaVa1cMjZQRW5kwwIpNlsHE3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQ8r06lf5q4XdBWEa0XWcYhVRP0CZsigV1mNzEA6fmw6Bv4lp+9G2I4DnsrluNFE3
	 clecrS8Zv89KvqIytV7xTCAlpijSy78eM8RTxk39Rlp3S5UtfbOWos7/YO7RDWbMWZ
	 xAz1ridrfbXCtmfhAJ9wVd8fnDPLKrNmrsZnNJm/xfSZArqPG0JutdeRnZnsABFrMs
	 Kw8ft/KYOZ6Us+J0GH94+vCaLZrrpqZZbkGffW8lGBQN4YSi17Vg2MGOdUFqdfSnQY
	 4FWtYT/qnsWiV75VvUfqcFiZ1sra8zmylbw6X58U8tYPqIPSWeQb7L0l0LFG9WXq/I
	 TgoegL9/yuPiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 15/21] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:49:51 -0500
Message-ID: <20241104105048.96444-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit dc1308bee1ed03b4d698d77c8bd670d399dcd04d ]

When running watchdog-test with 'make run_tests', the watchdog-test will
be terminated by a timeout signal(SIGTERM) due to the test timemout.

And then, a system reboot would happen due to watchdog not stop. see
the dmesg as below:
```
[ 1367.185172] watchdog: watchdog0: watchdog did not stop!
```

Fix it by registering more signals(including SIGTERM) in watchdog-test,
where its signal handler will stop the watchdog.

After that
 # timeout 1 ./watchdog-test
 Watchdog Ticking Away!
 .
 Stopping watchdog ticks...

Link: https://lore.kernel.org/all/20241029031324.482800-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index bc71cbca0dde7..a1f506ba55786 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -334,7 +334,13 @@ int main(int argc, char *argv[])
 
 	printf("Watchdog Ticking Away!\n");
 
+	/*
+	 * Register the signals
+	 */
 	signal(SIGINT, term);
+	signal(SIGTERM, term);
+	signal(SIGKILL, term);
+	signal(SIGQUIT, term);
 
 	while (1) {
 		keep_alive();
-- 
2.43.0


