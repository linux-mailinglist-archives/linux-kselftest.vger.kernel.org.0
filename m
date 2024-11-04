Return-Path: <linux-kselftest+bounces-21372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326979BB1FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644921C22284
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D31D27B7;
	Mon,  4 Nov 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAu9EYgW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC51BBBD3;
	Mon,  4 Nov 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717577; cv=none; b=ksZ8gCIJFQCsP3NIL0rd+GDx4+I+2hFspaGeY0VnEdGoHSFxq+8WdyT81Aq+cmMH8eNKHQwfNVbzU3X/svNy3ERddTqQtk6oiPTJHTcbd206UY8JTvrm7Sa44qjkmfJwMXkBqHjves+lABFrtscgAc1pUxEvaVimlOZKmPLIji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717577; c=relaxed/simple;
	bh=Ls6oxvs+pWHujG4KcpqaVa1cMjZQRW5kwwIpNlsHE3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b//sTZovQ5+p+L4KaWYeZF2HexQdjDoedrFJz70SKSJIn6+Sq/JwiIEk/kUaqHTEsY5VQnpYzfbgKxVBZLBB5h/qx0pB+uY7UI4SGbftLWKNwdzQSkfwWt7SaZOIjkkRg9mFDk+jR/UpGgnKnCcxAQWocuA2F/Lr5N2rguOAKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAu9EYgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96324C4CED2;
	Mon,  4 Nov 2024 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717577;
	bh=Ls6oxvs+pWHujG4KcpqaVa1cMjZQRW5kwwIpNlsHE3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAu9EYgWJg+L/ErXsaFpxhFi/pjn0UvUmYFY7RFpngGnvfAirhimrjwD/Gm9svVxi
	 bDTVUiSEs5DQtZWys/GnNH/v4THfztVcHgUJtHCxdHl/XKJ5vGwNxEw/o43WQ9l4RY
	 3Vu3jCKrLO7HzJlVleSvkNM0MIZ/XZIZALcZzw9Vb9ysC3y2NeyZ+0+FIM2rpjtYed
	 plJytqNTzawk7TyzPQuWzZRg575RY16BI6HCNYMFuGdejHgOHRghK+ayO7hFiqRlyO
	 u0jionvWAFNXGf+ruXaujj49P8mHtiqR4/Oa7afZZ+1Hruhkxo0YvnQqd25XR3uqjO
	 5A+l7XttJHxyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/14] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:52:02 -0500
Message-ID: <20241104105228.97053-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
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


