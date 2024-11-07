Return-Path: <linux-kselftest+bounces-21637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E09C0D98
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E1B1C241B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E1219C8B;
	Thu,  7 Nov 2024 18:12:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAE2194A6;
	Thu,  7 Nov 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003148; cv=none; b=d4Q2g2GkSAFkUD7SDLtfOx48QKGAyNF1EZha9UEpngueDzUaMVoFUAWkE/ZmqPSqlKO7Xfl31xOnVLL/LfXyWGLC/0gmpnaDkjOvOl1zDOojIVnL6dKAPkcNKjBBZ3uVa+oRPtiSnnnqeBlh1rFz0qz3yE+LvXcE/hvWDbgJ7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003148; c=relaxed/simple;
	bh=WCIDt+21qODKvmHLEUAs2MLPOshG5oyBZZXSw4k38Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSlFSRX+OoE79V9Emq5XZC+njtT0jMNv6T7ONKEG+axYQytiuG/7QHVtBk04RWSOJySeDpvSsYGzqB3rzh5bYnPcmxZO7dUqT2sHoP150sh3hMo3bMpOGKJztMiK5wRox41xvBN1jD2EEE9S3YLnWn4jQscRVPlGYJ3LaizR2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c803787abso11507175ad.0;
        Thu, 07 Nov 2024 10:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003145; x=1731607945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6TbHrRXODFPr6hzD7HJyGTadmIdNPZf+yRqUs/51D8=;
        b=foQfRdOrT6d4PLCjkdpbZZCL5EwICKpQa92CAeA9fPv/wrqmvsvgX0JtE0TnjrCjqv
         4QzNCkKslWrSW4S9HFezmBDdRrCM1yDjpxPUCBHXX37lcsAVKFYDv59IX0kwlOuB5uCe
         WP88uEsObVeBGwrYaZKBkh5ka0pSPOZIJLAwxtrH2Aw0Q1YdGV9xpgpIpUovMXkYaWAq
         NEm/NxaKZiiGbv3SSa+d9jRfF8shrVQO7FRpT2i9T471a7yBqklmJ6x/pJqojZgZuNSl
         WwvlbmXo9hcexeJ8RX4ttcBmHiQPSjKVe99ymLlvNj3hhPpuiB5RAcSAZOps8d5pgIk+
         13vw==
X-Forwarded-Encrypted: i=1; AJvYcCVFDOvRfsZn3Sypmq0uyiy+kSklQzpaNx4qfhW/eZricTFvcrBWmIkJesfuNoSin0/wgTreVeE+7Q78nj+CaiGN@vger.kernel.org, AJvYcCXSGt7yY2KbZV0CKZPTIfApdpEtY2YMOdNZWTk41fc/+VO2BHR2dC9VjidpPzuD6ztMXGHAXts6OvacRYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuePj1Y1Rjipa84TZ5q6KN82ivaJqTb+yX/Pow4IJfLjj9+CeW
	yGgkf1oNQefJSZmyGqY7IyWFwOvF/QCXYyVuMzqUWqpt+g7lY4aTjg8g
X-Google-Smtp-Source: AGHT+IFdAzIPzvHOecE6NEoUJONwTO5AcHu5+0SNVy/eNc9HbuclSzPNd0qvUpW/gLAstfj1awcbWg==
X-Received: by 2002:a17:902:f651:b0:211:3363:8c8d with SMTP id d9443c01a7336-21182202b3dmr8010925ad.20.1731003145293;
        Thu, 07 Nov 2024 10:12:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm4177603a91.35.2024.11.07.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:24 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Thu,  7 Nov 2024 10:12:09 -0800
Message-ID: <20241107181211.3934153-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 49 ++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 1ea62c129ddc..8e502a1f8f9b 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -76,7 +76,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -727,19 +727,38 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
-
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
-
 	if (!ifname)
 		error(1, 0, "Missing -f argument\n");
 
 	ifindex = if_nametoindex(ifname);
 
-	if (start_queue < 0) {
-		start_queue = rxq_num(ifindex) - 1;
+	if (!server_ip && !client_ip) {
+		if (start_queue < 0 && num_queues < 0) {
+			num_queues = rxq_num(ifindex);
+			if (num_queues < 0)
+				error(1, 0, "couldn't detect number of queues\n");
+			if (num_queues < 2)
+				error(1, 0,
+				      "number of device queues is too low\n");
+			/* make sure can bind to multiple queues */
+			start_queue = num_queues / 2;
+			num_queues /= 2;
+		}
+
+		if (start_queue < 0 || num_queues < 0)
+			error(1, 0, "Both -t and -q are required\n");
+
+		run_devmem_tests();
+		return 0;
+	}
+
+	if (start_queue < 0 && num_queues < 0) {
+		num_queues = rxq_num(ifindex);
+		if (num_queues < 2)
+			error(1, 0, "number of device queues is too low\n");
+
+		num_queues = 1;
+		start_queue = rxq_num(ifindex) - num_queues;
 
 		if (start_queue < 0)
 			error(1, 0, "couldn't detect number of queues\n");
@@ -750,7 +769,17 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (start_queue < 0)
+		error(1, 0, "Missing -t argument\n");
+
+	if (num_queues < 0)
+		error(1, 0, "Missing -q argument\n");
+
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.47.0


