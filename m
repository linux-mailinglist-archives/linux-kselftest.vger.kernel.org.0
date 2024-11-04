Return-Path: <linux-kselftest+bounces-21376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725F9BB283
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0512283B51
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793071F666C;
	Mon,  4 Nov 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvSaGUWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A271F6668;
	Mon,  4 Nov 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717725; cv=none; b=aZ9cLvd6tdPBaSdLQdv9IxSK2Ltz5iKteUEvEYsgpxNtV6UnWrKCSK2metKuQKyeOdBhLBgEEjE9NpqAPXqwugkbPE4xLtwYT/NqKpHn6LXfWVy6TU3fyOn+5G+BRpWmuRDvZN4zDguM8vGCCkalgbD1p2JkEiKBJzjCRGWNdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717725; c=relaxed/simple;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtMWl6cjdaCykuuC8jCQMmjobIBcZqsmjC2H3PXnU/mcH/CdZB9jT0Odcra0Y5ZwuDhieIH2wgLt/vJ6gmXRN4xftOkTmFNa95lYZ6FKg84PETj+VBbGKJ9XxOyFrX83O71cboLijJhy8TuIL6HTfU5ZshN7EjtPQHssggldah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvSaGUWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00431C4CED1;
	Mon,  4 Nov 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717724;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvSaGUWRunto/IUHpuDc1khHTI7DNGsovuItv5UgHL2+CuPd7U522Epq/1nUeCJo3
	 qlffAj1V3rQNMYbnt+Kz7RU9IElfpVzZjH7Ke2QrLM2BZ4kd/WzJQa7pOiUgq1j76c
	 IMMWCS047hUKcYolt1wek7ZN8iHfjBTA0eYL9hFKjyejugGWpRx27XT2FDEtg19QOM
	 2YSguEyMl+arjKKQUg8OHZrr3qRmXUrLemOIq603wBtDKCH/80siFGtrdK0PVi4d00
	 ZOhvf7QWptWvSj2qBDQeguchM6Yva64nYVDgWnoHlMa1r9JDwgCeZz6F4hnKupQigu
	 XV8eaiXIdNMFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/6] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:55:07 -0500
Message-ID: <20241104105517.98071-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105517.98071-1-sashal@kernel.org>
References: <20241104105517.98071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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


