Return-Path: <linux-kselftest+bounces-21375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E369BB266
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19C2280E40
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C31EB9F1;
	Mon,  4 Nov 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euT8xzic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A21EB9E9;
	Mon,  4 Nov 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717702; cv=none; b=VlGANfkvq5XncQxQWRE2/dgQNroZgchLQ5pNrtxf9WzkpKf/zOYFCYQUcwtLYeq+kMN8sTGCVAv/Ueel4O7ORsYaR62QHfb511pPAUog1oJVgOEMts5g92f0tgACDFfYz5RqiUxepBjd27JE33GpEDQDz3WYfM2waSp3BfGBE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717702; c=relaxed/simple;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhQFfZovUTf83dKNQdIsSoFFp6vrb4106sh2BvgW66O3zLgZg7ZnFjgF+CdFMbUM2dInYCTo40JrjHEtLMZr45qNgW29WQv8kxuys/sb1h0TMleQgdxa9w+XT4IuW0fsEFqKK1cvjvBbAGW8yMOQMWa2RT38BfifhcuxtA601F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euT8xzic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26EC4CECE;
	Mon,  4 Nov 2024 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717701;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euT8xzic7bUlJ4SYHotyWLUB7y3iAnjs5QqEg0r4s5+jYi/R3XeqTMUToTF04ZN4f
	 r0+hNcHfOKc8F3HvgoQhX0EuPANJh2E4x6wd812xerQAwCBDIUhwHc+/IwnnCJO9PI
	 665Fr/go4E12LvWBPcVA6p3sXeVAeLWkdqpU8LEx8fyFbO2zWt0VCIxaSohzhxTtSC
	 SaK4AChKJt3PTTDQBwrgkGNVVOyVjVSgKQvyWCt/+AHn/aGnh/g+Y3xCj6R+YVEPqy
	 ATYWP5tMsC+4xLa9VhyRprOK/PsGWGkEiHpvhzBqM3RtR5XrrbpZfMmx2q8Tte/E+k
	 W6SfgeDZcHRsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/6] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:54:44 -0500
Message-ID: <20241104105454.97918-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105454.97918-1-sashal@kernel.org>
References: <20241104105454.97918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index f45e510500c0d..09773695d219f 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -242,7 +242,13 @@ int main(int argc, char *argv[])
 
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


