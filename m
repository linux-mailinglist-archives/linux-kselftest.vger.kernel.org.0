Return-Path: <linux-kselftest+bounces-21377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA49BB295
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BC21C20296
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B091F76B9;
	Mon,  4 Nov 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmJ0QdO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC421F76B5;
	Mon,  4 Nov 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717746; cv=none; b=J6ambWyWcx3Iszx02ah+Scs/BGFJPUqOjwdrrLrfEdkpral1vAXUrEmH0T6sDayYAA44GIRaU7suLAXEqk+Doo9j2Ijlirq7CjkhbgVKv+QXMUD0JiOJ/RC6VA3GPooYLdgUQz7GrUTRb+rujyjLoSVA7KwLGHT2X39RIv39Bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717746; c=relaxed/simple;
	bh=Q2qs2fovbd8YHy9F9ziUFroX7H9CCmhCtSEAJKj5Z4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btamiD89rqIAbncRbc2IXU/uXYiKl01EGyx1zd1pcewV2S+MmfsvEapIR4mHn+ux9Q5y3IR2gVEX1GnKU4ITBAIpmOWY6XVu7LvmA5ElUfnIcvQm2iiJwE4GBGHw05hz5/4r/mE+BGybS13EIr2cE8hoibxpD3P85KuzLQEUpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmJ0QdO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C942C4CED1;
	Mon,  4 Nov 2024 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717746;
	bh=Q2qs2fovbd8YHy9F9ziUFroX7H9CCmhCtSEAJKj5Z4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmJ0QdO7oqnl9flAwJCZ9rtqXMfdTzWkFvvQTJ/3FaEucw44syZiKVvFBuxbjFBat
	 kCXL73a1fm1M9hiNAwevHLOAa9iHy0NKW90tWgMIvM5899qKoUPsmqcOtVzm6/eGki
	 qMqurbkcAduFbcOflB5zCPXooVe1JwyApUW9W511OI+Owra0oA4N7p14whUhVFqgpC
	 1yg0/wy1gB+P2cWa5eAgUJ7KGkUCH6DmIEamKNJQjQWzG0ZpI51Eh6uS+bPptDdt7C
	 uSo3gNF9TBptopMDTCEg/UhiuK951XrGgKRMc0k2X4vAI6HngBgUaGORe2y6DUguKd
	 OZyJcYXMuXI3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:55:32 -0500
Message-ID: <20241104105539.98219-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105539.98219-1-sashal@kernel.org>
References: <20241104105539.98219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index f1c6e025cbe54..561bcc253fb3e 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -152,7 +152,13 @@ int main(int argc, char *argv[])
 
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


