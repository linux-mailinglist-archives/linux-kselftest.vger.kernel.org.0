Return-Path: <linux-kselftest+bounces-9515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278348BCCA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B65B223F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D29142E8F;
	Mon,  6 May 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XRQAvoWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA42320B;
	Mon,  6 May 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994031; cv=none; b=FTEA5YmetGot8M47gzHMJutu4PEnA8uXmKtkoUW2Urd5rfPfpG9TNoBzjNqTa8ezyQBGdsvTFHMtq9hGMl1I7EtDFzFNPmWyYBGbXOOFr9MWj6WRKErZZ2BLLxhA3cO9uAdmxud34/cAg6SiyW9v0jbx/znTU7TcoII7oDG4qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994031; c=relaxed/simple;
	bh=wtv3BIeMxKTtICGscr8EViMh7KNfmJjszltrDuf53hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujFcMez3pGooIwsmIQOX3802us/VsInZ4BJPwctwUpOuagvR2WxyZchACGO0rI/XJ+Du3bbqpSYjhRb6VLzgxvyrC6evI7TVZG5vjEJGmdbaeORyEHCNHMfeTD8xs4vnpSScPM+9Uzz63nV/J6d0DfnGR0lvnkPnF/oljJURctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XRQAvoWR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714994028;
	bh=wtv3BIeMxKTtICGscr8EViMh7KNfmJjszltrDuf53hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRQAvoWRxrOMM9lGgmXA2Q8YyRL1JYSFA8a7Zb/qZJ/NFyvTcQq6Nb8b4qojNIat1
	 eKd0TVnvOebmLmCTsIIdhaL1csD6UltpA0yDZunoumGfYZN9oASmB/FA9MmMzudyfS
	 sVKtSfdj+N1WUQRul5UtnlXpnquWoT1ZHBwweIuJSKFcg+tlAHb5wXbOXlUljleYNf
	 YUkS5mNOKu+wAljOcSAwy7gULquSH5Ly63sBIMQ6ByUhTmdqLsmWGX1z8BigSTs08m
	 W/fLaYfYR8P8nzOmZreQrUQXNvBbRg16j5lsKXiDXDic1pRs64swoFDOACSxB4wEd+
	 hYa2iqIstr7XA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 284F037820D9;
	Mon,  6 May 2024 11:13:48 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 1/2] selftests/watchdog: limit ping loop and allow configuring the number of pings
Date: Mon,  6 May 2024 13:13:58 +0200
Message-Id: <20240506111359.224579-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506111359.224579-1-laura.nao@collabora.com>
References: <20240506111359.224579-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to run the watchdog selftest with the kselftest runner, the
loop responsible for pinging the watchdog should be finite. This
change limits the loop to 5 iterations by default and introduces a new
'-c' option to adjust the number of pings as needed.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index bc71cbca0dde..786cc5a26206 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -24,16 +24,18 @@
 #include <linux/watchdog.h>
 
 #define DEFAULT_PING_RATE	1
+#define DEFAULT_PING_COUNT	5
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:st:Tn:NLf:i";
+static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
 	{"enable",              no_argument, NULL, 'e'},
 	{"help",                no_argument, NULL, 'h'},
 	{"pingrate",      required_argument, NULL, 'p'},
+	{"pingcount",     required_argument, NULL, 'c'},
 	{"status",              no_argument, NULL, 's'},
 	{"timeout",       required_argument, NULL, 't'},
 	{"gettimeout",          no_argument, NULL, 'T'},
@@ -90,6 +92,8 @@ static void usage(char *progname)
 	printf(" -h, --help\t\tPrint the help message\n");
 	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
 	       DEFAULT_PING_RATE);
+	printf(" -c, --pingcount=C\tSet number of pings to C (default %d)\n",
+	       DEFAULT_PING_COUNT);
 	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
 	printf(" -T, --gettimeout\tGet the timeout\n");
 	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
@@ -172,6 +176,7 @@ int main(int argc, char *argv[])
 {
 	int flags;
 	unsigned int ping_rate = DEFAULT_PING_RATE;
+	unsigned int ping_count = DEFAULT_PING_COUNT;
 	int ret;
 	int c;
 	int oneshot = 0;
@@ -248,6 +253,12 @@ int main(int argc, char *argv[])
 				ping_rate = DEFAULT_PING_RATE;
 			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
 			break;
+		case 'c':
+			ping_count = strtoul(optarg, NULL, 0);
+			if (!ping_count)
+				ping_count = DEFAULT_PING_COUNT;
+			printf("Number of pings set to %u.\n", ping_count);
+			break;
 		case 's':
 			flags = 0;
 			oneshot = 1;
@@ -336,9 +347,10 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, term);
 
-	while (1) {
+	while (ping_count > 0) {
 		keep_alive();
 		sleep(ping_rate);
+		ping_count--;
 	}
 end:
 	/*
-- 
2.30.2


