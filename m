Return-Path: <linux-kselftest+bounces-21373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEFE9BB225
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725151F21170
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E41D63E9;
	Mon,  4 Nov 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc7qSyOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106C1D63E2;
	Mon,  4 Nov 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717628; cv=none; b=mI1IdTuRKrP7kN2TO/QuB2yVSaw1fpYWFDlhxP2qZ4wBKiPzHu+ieZCsvw/PcKj8dcE/3ZQ3gOWPCnt7uikGA6TACDxljqsydy6qlikWN9Y7tiV4vRRh7UZflk4WF3lmDojVZFnOGFbaBqp0u8D/5UxC5A484Ff7qc50egSUz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717628; c=relaxed/simple;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myCIEJVXOOYtnm9qN5LyG77rfttLL8dz9Gn81mMRioNfqnIUHhaEI4jvdKypjq/eJDt0JjY8UF1RSKoUN2qBpRAKqi5esWMCSDkrQGNjAgpFdib62LaKerE8Q3SAQC7jnpVixIV/VSXNoZtvWN9U3ehjlFNcIQF0sztkGvyzkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc7qSyOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD83C4CED1;
	Mon,  4 Nov 2024 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717628;
	bh=+yqfSSt6kLDRneh9fTkP2DWL8YT9Gj+cYVQcFnLkFkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yc7qSyOefwNgL7D/DT6xgZNNPMDo8b3LVu5wnHR+BQrjBZ2Jjl9PrRFRBTRdixPGQ
	 c09bMq4/IJ+DBL/DH9owHYYWLh2js3/LLJvt603jv1JXn+9uX1K1YsCiH1eR1tO9er
	 Ye7KRF2okPg6vFOKPNaLjPSxfn6oenYKjv6EIZThebn4/QKqneP6gaeu2ps5OD8muY
	 m7IigU3lBIfqeVJIPZLTmhDXUIRnatuANCpIDUsNusrPnLapvyDNBh3ycv7GHuHNJQ
	 W/UixAockAbZDKpMH6uy+SagJkKzDXGN2NmZjxZ6oDoOr2tIMdc0bc77RB/iFkFbw/
	 U9iYHoo4kz+fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/11] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Mon,  4 Nov 2024 05:53:05 -0500
Message-ID: <20241104105324.97393-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105324.97393-1-sashal@kernel.org>
References: <20241104105324.97393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.115
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


