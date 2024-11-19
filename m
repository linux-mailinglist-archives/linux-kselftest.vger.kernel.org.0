Return-Path: <linux-kselftest+bounces-22276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5B9D292A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199201F24A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899131CF7DE;
	Tue, 19 Nov 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="LY2T/Bls"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77D1CC89A;
	Tue, 19 Nov 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028499; cv=pass; b=WijBPusyRvAQc520wyXrAhipgv4gYeR4+TFo15GDkgTKpJ4T/Tj6wq3d4TKdW2q8NT6zKp+y6QIqy+cFaV9WP+FOgoZmnVvIq785Ia0OSF3Pi+w2UVZqqg8XrPf4BflbmImYqSsjeXtyxCgr8fL8X6P34X+WGZqfDoDTqVTAbkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028499; c=relaxed/simple;
	bh=9q0PeQrLAbzBqLAwChZcdX/RcWErMFwvraxjF6rfWmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ma7PIv76ShVtsMyEKkCxxTloyWkIH7S8+yCr5Hs2v30Oa+WWBYXk36xir6Bh6tSULwYqt01LkPagzxL0frm1TAosB2AXnqVEjVl/rLkZPxA1AATS0z6mWVS6Y3allt6AgB3kIutGSpZAPC7ypIaWInrvFOVPWYi23oOCSSFiV5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=LY2T/Bls; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732028486; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W1P5j9Cny8yTZ4a/GYSES7E9yTJHDBxlNlTr9eOG57Wa7p1z6xyaFT02msNzlCY6web3jFM89JjfiF2UQMVPfgmKlj+LqfVFe563IHG1eIcdY3NPUnxU4NDXeww1Nf0PFHaRCu8eGbv2rhyk2ZmNK81Wp+v2mg/yx2qSUUUeNjA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732028486; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wPHTXbM7uBYQXAnpzH2/sAzUM3M6IZfB5rA7jitNM1I=; 
	b=UA4yWCLnwK1FdulA13v4iAbJx2JlX6O+rUocdiFkQGbhHnLzWOcGdTT9MFI3zlZV8DDMvQQi1+S8m3f3TVeBxfiAlHTRW/Lat8Cu6xrg5jwW7J+LeAXjC4tfShOe0WJzoNUivMYaE4oYA++OpcexmlvMjWK+UTmVEavJovOXa0w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732028486;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wPHTXbM7uBYQXAnpzH2/sAzUM3M6IZfB5rA7jitNM1I=;
	b=LY2T/BlsTU5yTfmhfCE+caZbG9eMQ3ZDVOPgwi8OW8T251E0FVI4JiN2ta37SwnE
	ALcJr17lhiZpYOOtqprHjBfkiIkFXU7T3jaFn29pRP3oIHk5zdxNxjliLHqNd4XnzZq
	wn+k/e3Kv8wHsuQv3cVuQnM7ZRoG5+5XhJn7jAeI=
Received: by mx.zohomail.com with SMTPS id 1732028484520928.257236896964;
	Tue, 19 Nov 2024 07:01:24 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: laura.nao@collabora.com,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/watchdog: add -c option to limit the ping loop
Date: Tue, 19 Nov 2024 16:01:26 +0100
Message-Id: <20241119150127.152830-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241119150127.152830-1-laura.nao@collabora.com>
References: <20241119150127.152830-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In order to run the watchdog selftest in a non-interactive environment,
the loop responsible for pinging the watchdog should be finite.
Introduce a new '-c' option to adjust the number of pings as needed.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index bc71cbca0dde..58c25015d5e7 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -27,13 +27,14 @@
 
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
@@ -90,6 +91,7 @@ static void usage(char *progname)
 	printf(" -h, --help\t\tPrint the help message\n");
 	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
 	       DEFAULT_PING_RATE);
+	printf(" -c, --pingcount=C\tLimit the number of pings to C (default infinite)\n");
 	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
 	printf(" -T, --gettimeout\tGet the timeout\n");
 	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
@@ -172,6 +174,7 @@ int main(int argc, char *argv[])
 {
 	int flags;
 	unsigned int ping_rate = DEFAULT_PING_RATE;
+	unsigned int ping_count = -1;
 	int ret;
 	int c;
 	int oneshot = 0;
@@ -248,6 +251,12 @@ int main(int argc, char *argv[])
 				ping_rate = DEFAULT_PING_RATE;
 			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
 			break;
+		case 'c':
+			ping_count = strtoul(optarg, NULL, 0);
+			if (!ping_count)
+				oneshot = 1;
+			printf("Number of pings set to %u.\n", ping_count);
+			break;
 		case 's':
 			flags = 0;
 			oneshot = 1;
@@ -336,9 +345,11 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, term);
 
-	while (1) {
+	while (ping_count != 0) {
 		keep_alive();
 		sleep(ping_rate);
+		if (ping_count > 0)
+			ping_count--;
 	}
 end:
 	/*
-- 
2.30.2


