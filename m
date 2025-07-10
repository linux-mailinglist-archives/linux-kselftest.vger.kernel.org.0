Return-Path: <linux-kselftest+bounces-36968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68FB00456
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60477481C3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1D274B2C;
	Thu, 10 Jul 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jrc78443"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6F27467B;
	Thu, 10 Jul 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155407; cv=none; b=enAOVa9AVf3RhH5U1UdLljgqNZLUWQOJXBdFnqRyhFWA5vhv+/7JRtXsz9v3bkZUZLEL1o42A1/H0GSwJH1+gXUQ2Blsnt7pbk98wzgYx5HF6W4bymlfz5owrLBc+UbWe0V5sVWgSYb7vHdVJFeoLie4VINt9FsKKHtcGso1pco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155407; c=relaxed/simple;
	bh=SUWRZ9dxXGm6+zx/mzro3m8Nr7n+JkOPnhEWZD0cam4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCYKqnEywXp0JBegHkzVDnIfb2IATOjlcLRQBAIvgEGqIX9YEw6b80cVr3/kXpIY+8gh6OTGLHQh/m+BNglZcItZZKM+twGnvgGhfQ+UnC+25IDoJEhWmSFBjPjCMr2W9MmB3qUFNOavD2lOAJZAGOQ4s+1sxgYHLF+qgKPzlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jrc78443; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752155352;
	bh=eER373CBKVzjZU12vPfZqu6v9KD+kKd8SlW6nlnHSPM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jrc78443Mz4tHwjHVtUWntmpM82FBBwwHUxk6kSDZDC9ZiMWMfC0mJ8B6cQ2IJeTa
	 QMXAD7kyjEvgkC6/P/BQtgT+uWYvy94iH+5l0nz5TPeydTtpuHJNsXM1YLDLcLpZkB
	 KkaUkV4JC3nQooWSsDwSN6vW/F8HdrXURS42n38U=
X-QQ-mid: zesmtpip2t1752155310tec24b4f1
X-QQ-Originating-IP: y3pfuQqVdTiPsuUM2wAolixPa+zMpnrZCdXw+LqGsSI=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 21:48:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6548783299079273511
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: akpm@linux-foundation.org,
	chelsyratnawat2001@gmail.com,
	guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	niecheng1@uniontech.cm,
	shuah@kernel.org,
	zhanjun@uniontech.com
Subject: [PATCH] selftests/thermal: Remove duplicate newlines in perror calls
Date: Thu, 10 Jul 2025 21:47:51 +0800
Message-ID: <F482FB1EC020000C+20250710134751.306096-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <6338CD0E839B770B+20250710130412.284531-1-wangyuli@uniontech.com>
References: <6338CD0E839B770B+20250710130412.284531-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N+/GyfuFbcLiCJEi0ToNj6nxMYd6PUav400TffcjIuPYO83RisX08Ozs
	1m8ky8xgCqM/A3ZIax8Ev0dLPz46SpHlBZbu3+HBsBJ4/TarRA3JIS7HBXZnIk8md3r9ET/
	rHs804FKnhhXSRMrLn/0MeolYYFFy7aggMQy/akDm0oY7UuZWmgDJOG+F9h+eAP1ieWbrke
	YMRry0X3nsFnFPO03A8aAthsmeRKUdc7vgUBtGRHNUXEhVvUkQNKHX8mURHG/r1YDI7k0LQ
	RjEN1IDeXp1XCpHEy3JkSabtDW947PKUr5f4+z5bLjeOFnsXTu4Onzzc6HjOfyHGzD1isAf
	V5nsJf1UMv6GyxZtSueKiSIWhyp/tKsDMyBG+vqmwtJL9xEbxeVl3crsmiOEYqo0iZfs9tm
	X3trSWqlrrGzBI90wKzy9R3aOh0VVmC1hrUumCp1tv0JevAL9AkpPwWafUrKTXK92Paas1W
	j9i5es9gZmeRmu7gWOcVP81+VdypGU5SOX0KE+UTk4B9VXQqAEe8hmLEeWW7dtLqIx32FbS
	HIzCEVUo1a44p7pmY/kneBGpf1ntXIEj6ahoL/p3x4KFxauwxbZvo5LLtVbdu6tJ/3N7kr6
	9dFz9ma3bTKIStThTJCcQ1bLdPvKx5iODYaFwyQXilFzaSb634KcbtPq/HBrnF0nfJgiK8f
	OhQ7iXbc3KsARV6d4QfJYcteSwYuGWvL/zHQ+r2eGQziKj6Ql/TQDIqtMxgrLprstFit3R6
	4ZfOLaWR/peI3fumd5uqGm9HyIqG0oZWL5c9FiyralWfsgsXElSwyMxYoRLAZkF+4I6lHh0
	uBz7akEnFAIROFGPyA4lTsxgzDj6H7b7CC1ADZQyNl4BMsI1HGm0Nt7wTE9ZTtMlQlm+aUQ
	v2LrIMUSKu3MjGcPtUDm4fQ//FVyaC/P0MmJ8laBZ+nd0ebA/FoyA7qHkwLuFB2Bk/giL9c
	xhvdCIna4T760ilpEvSYhMlmDn+ULXHLyu9fjsG81sgE2Nm/QcX4uQMusb8Ukyw3/6eHeOb
	JUW2RRhAgGsWGQXKDt1DQW5/ox+zo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The perror() function automatically appends a newline character,
so the explicit '\n' in the format strings is redundant and results
in duplicate newlines in the output.

Remove the redundant '\n' characters from perror() calls in
workload_hint_test.c to fix the formatting.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../intel/workload_hint/workload_hint_test.c       | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index bda006af8b1b..ba58589a1145 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -32,12 +32,12 @@ void workload_hint_exit(int signum)
 
 	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
 	if (fd < 0) {
-		perror("Unable to open workload type feature enable file\n");
+		perror("Unable to open workload type feature enable file");
 		exit(1);
 	}
 
 	if (write(fd, "0\n", 2) < 0) {
-		perror("Can't disable workload hints\n");
+		perror("Can't disable workload hints");
 		exit(1);
 	}
 
@@ -70,12 +70,12 @@ int main(int argc, char **argv)
 		sprintf(delay_str, "%s\n", argv[1]);
 		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
 		if (fd < 0) {
-			perror("Unable to open workload notification delay\n");
+			perror("Unable to open workload notification delay");
 			exit(1);
 		}
 
 		if (write(fd, delay_str, strlen(delay_str)) < 0) {
-			perror("Can't set delay\n");
+			perror("Can't set delay");
 			exit(1);
 		}
 
@@ -92,12 +92,12 @@ int main(int argc, char **argv)
 	/* Enable feature via sysfs knob */
 	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
 	if (fd < 0) {
-		perror("Unable to open workload type feature enable file\n");
+		perror("Unable to open workload type feature enable file");
 		exit(1);
 	}
 
 	if (write(fd, "1\n", 2) < 0) {
-		perror("Can't enable workload hints\n");
+		perror("Can't enable workload hints");
 		exit(1);
 	}
 
@@ -108,7 +108,7 @@ int main(int argc, char **argv)
 	while (1) {
 		fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY);
 		if (fd < 0) {
-			perror("Unable to open workload type file\n");
+			perror("Unable to open workload type file");
 			exit(1);
 		}
 
-- 
2.50.0


