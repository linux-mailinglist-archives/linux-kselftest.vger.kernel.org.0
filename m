Return-Path: <linux-kselftest+bounces-20878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65E9B3EE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C8EB2286A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E44431;
	Tue, 29 Oct 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNa9JZJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D127464;
	Tue, 29 Oct 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160654; cv=none; b=iBOn2fndhOmZQUmejx00adliPX+FI9/ZQRn8nzoCcbOKB0Aj2XhAKMjq1ZuhqMSANa0qW4VIuLE6iwndUEt/8XX+NAZHRi1rtvJ2voE0CFFJ8AkCCL+pq0Ei4l58ykwvRQm/zh5cXlqPQyBsVYh+uUd1yWHwd/v9lEItVSFXUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160654; c=relaxed/simple;
	bh=ekBfPnwrdm7KummwdeqiAHhMWmmbyTg1NV1XACHkR0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAXa2RoQfb3AFCxK/WV+izaGBPGc6rG+fjUD3SzuyR6T3JKmoWBJJGPqyfpt5Si1XvvXA35aOEsT+yIeTFJaCKoRtzdwwBGnHeJLx9pXXaTU7vz0XqRaF7mjshcgTJSJCyfMcOdabsbM2IihuIQbqCY2luounoX5xuyogkTIbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNa9JZJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967B5C4CEE4;
	Tue, 29 Oct 2024 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160654;
	bh=ekBfPnwrdm7KummwdeqiAHhMWmmbyTg1NV1XACHkR0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NNa9JZJ0/NkjQTSMfUdbvmoKVqnMhyf17P8SlyuH/JddEH6fifz8ab+/bCqFF6SJg
	 7o6r0lgiEa1lghlFPI0lqzB1/EZDLEANhaql43YsGT5Mye2i7MMZNKYH0/UGSXTgZw
	 oTwi67cRPyomFbqJkSMnMp7W/JbgfKWoJiUGi5m8zl3E8nsqN/74J5SUsw65QhGXJd
	 9tkQPCQFj4RshIGm8M/ETM24z4ORfHsRI7G3pUF0mcDFPFjX/JxkTpnp5UVf3ja06a
	 MsRlXegkTWiHd6De9toOxr6bw9k18y0y3qKpgpQmHIQIdc4TX69sfSDSX+VR2NB96M
	 nZi3D8GU6uc5w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 29 Oct 2024 00:10:40 +0000
Subject: [PATCH 2/2] kselftest/arm64: Lower poll interval while waiting for
 fp-stress children
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm64-fp-stress-interval-v1-2-db540abf6dd5@kernel.org>
References: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
In-Reply-To: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ekBfPnwrdm7KummwdeqiAHhMWmmbyTg1NV1XACHkR0Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnICgHeifBMnCWZ2kSXNB3NMTg0fAwNZRYyu5mcRdL
 hclJyvCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyAoBwAKCRAk1otyXVSH0Iv5B/
 wNabZkh1SOPf/oceJvwEmyr/ynlL8MBnpgH8D74hiwWGMZW2822ciE6V4OFPOV7x41bRR2x0/pZ7Hj
 bWQQTw8qmO2ENaJCt9zsk3NnynS1vO+2xlOCaOIT5bqEk+q6UfvfFvs3QGq+HwY/XRAUFwNhgwI2Km
 oOhTQ2XxUU7UXJaQVerllbxk3RTZuaUqE8IiXi1vuaZTGnvutlasOgZZ2LyJO+mihb+F/W/d2rEad0
 ew2lbo4i9KjaU1T5PVup4NYmVnbeQgGe57bU3BSewpIufI6x4llZT7LccpsdgWsAh5BexwOKdwaQzJ
 MVPqYlljy03PF2SIqScNn2Ou+DayOx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While fp-stress is waiting for children to start it doesn't send any
signals to them so there is no need for it to have as short an epoll()
timeout as it does when the children are all running. We do still want to
have some timeout so that we can log diagnostics about missing children but
this can be relatively large. On emulated platforms the overhead of running
the supervisor process is quite high, especially during the process of
execing the test binaries.

Implement a longer epoll() timeout during the setup phase, using a 5s
timeout while waiting for children and switching  to the signal raise
interval when all the children are started and we start sending signals.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index c986c68fbcacdd295f4db57277075209193cb943..963e2d891ced72fb8d6eff4fdb5c7df0724b14f1 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -453,6 +453,7 @@ int main(int argc, char **argv)
 {
 	int ret;
 	int timeout = 10 * (1000 / SIGNAL_INTERVAL_MS);
+	int poll_interval = 5000;
 	int cpus, i, j, c;
 	int sve_vl_count, sme_vl_count;
 	bool all_children_started = false;
@@ -588,7 +589,7 @@ int main(int argc, char **argv)
 		 * especially useful in emulation where we will both
 		 * be slow and likely to have a large set of VLs.
 		 */
-		ret = epoll_wait(epoll_fd, evs, tests, SIGNAL_INTERVAL_MS);
+		ret = epoll_wait(epoll_fd, evs, tests, poll_interval);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -626,6 +627,7 @@ int main(int argc, char **argv)
 			}
 
 			all_children_started = true;
+			poll_interval = SIGNAL_INTERVAL_MS;
 		}
 
 		if ((timeout % LOG_INTERVALS) == 0)

-- 
2.39.2


