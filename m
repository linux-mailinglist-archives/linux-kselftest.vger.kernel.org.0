Return-Path: <linux-kselftest+bounces-22160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D59309D06D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3ABB2112B
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCD1DDC3E;
	Sun, 17 Nov 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyOquGKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171831DDC2F;
	Sun, 17 Nov 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731884396; cv=none; b=gX4k2HT3FJDSNgsBbuZLZF2ozV68MTJmd67nd1a5+TlzlmavWIMxE+C0Tfe5PDQ0NzEU4kfhdedruomsJeBwQl4m3Wgh2L4fC3+nhY3iZXDDVegjB6zTQ/6x5LQQBKowtgNxAoVuDD+XVn/QoydMlVf63Gz5GvyAWvqgOpDXeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731884396; c=relaxed/simple;
	bh=uv8Ihhtdg0n2NJQ3p5u110hUeSo0Kpr8GmEcZJ2bcBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8a6uzzxyKZw6TzueVjr7KmZ1LuoGPtSFIEzv5BVvIZZpnzeHxmW5UrtEklWktBDrzAzIrAVT4SWlwSolJthKy60MQjpQalH7N6CtFNGRV7CWqFiLByL0NDvcPhVw+hAKI6t48m7JVVFXG4/ybWgGEj9yU5CyicsUNU2IiZNlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyOquGKX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c693b68f5so23321735ad.1;
        Sun, 17 Nov 2024 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731884394; x=1732489194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDkdpFP063xLDM3wocri/nG7NRGeGfpBxyGmNCvpHu8=;
        b=XyOquGKXF9K3cfZfp1g09hvAzxGjFdCUOQ4zFxXwbEpWWnNTg5q7S66vAzINj0aQFo
         Y1vNUt1ieFuQt2KI7ceqEuTCh89US3nfqvmmbDq4T4gzO3gVyM3P8XL6cqrqN3dp/w34
         ffOJ4AkITTwE504yzhj+RiFArhZQv3CVY5dMVE2ZDGpF8xjZMNk5BYbnmKQJ+AekLkBC
         0O2BdJW5GK+1hFTQ3aWmZvgKi7Lh32NBjO45E3wAR2RHXVNOicD8BlIQMZOER/G5MzTj
         M1WB3kHE4YEwDLqUVVXktVaEOZ4KQet4os3AHTddEyOw8sJM/WbqYoKXrTCkHcbo5xY/
         n6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731884394; x=1732489194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDkdpFP063xLDM3wocri/nG7NRGeGfpBxyGmNCvpHu8=;
        b=UYhKtKAB30W+NADuanDMej/bHqk4j3dMb4vs4kjd1FrojSRQ8p7F1QnknU1GGH1L9o
         OecbMS04a/E3XJjBjL/YVlzJGXRzQpU0IxHlB7G/3GvlpimSpzwZQXrM2Zyyoh4FBFtx
         6Hh57YQO0FY0l2Ab/6LyMOFUmimmaIWm1QYaWXQsIoTlRrB4raPq3Bq8iXIVqmNvcl4K
         5AeSyY9UZqf4aFtT5woPo+zIsQ1JLQVXHJV4flYrAY5dplSWiYm/HkQDwGeN/unYgPid
         17fXuGo1jlhtkgWrImMzAgkWwsK7K/rPF8MN5WDHb5pLxlVFbE/WQiTC8mjNwoMkLxkQ
         i62w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6s5MCrpSHH7Bl4HswD99tl7NRnp+LouSQCgE4at+wAzSq4OEd8MOG7VEWjZMx12FDjak1OB3TjoRmwk=@vger.kernel.org, AJvYcCX6Dyt242rm45qQNV4raeWXgxBWx+WuS/ehMtDq8/h2FC5AmliIFcJhF2/k3pmQdvbYb0fLW/WD08hoprUptCM8@vger.kernel.org, AJvYcCXYddxGSJACeZQWPojqHohMKfcS/ihDBNX1FvN9ljsE6z2ktGi0JGJ/jHfIXmbOlftzd13xZKfx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bqDYIzDId9n+64ZUbZ0WgV92GojMCytBTWnGKbWJ3VZJtQ40
	A3zTeJlDxKJxSVJ2MdX+5j3tlxM4z61ZMp2q7bjdPc8KQX3MhlzW
X-Google-Smtp-Source: AGHT+IG4IhDYQGGogz/AsvycfNbCsZDdahXP/VJU1uZ9sUw3Y9/74uV9EjqxgWYSikEEivGON3kDHg==
X-Received: by 2002:a17:902:da91:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-211d0d92220mr162127935ad.32.1731884394177;
        Sun, 17 Nov 2024 14:59:54 -0800 (PST)
Received: from tp.hsd1.or.comcast.net ([2601:1c2:c104:170:138:7477:f049:643b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f3461fsm44932285ad.154.2024.11.17.14.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 14:59:53 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH net-next] selftests: net/psock_lib: Handle EINTR and EAGAIN
Date: Sun, 17 Nov 2024 14:59:50 -0800
Message-Id: <20241117225950.138968-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pair_udp_send_char handle EAGAIN, EINTR, and partial reads or
writes.

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 tools/testing/selftests/net/psock_lib.h | 39 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
index 6e4fef560873..e28bff95c8e2 100644
--- a/tools/testing/selftests/net/psock_lib.h
+++ b/tools/testing/selftests/net/psock_lib.h
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <arpa/inet.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #include "kselftest.h"
 
@@ -110,21 +111,41 @@ static __maybe_unused void pair_udp_open(int fds[], uint16_t port)
 	}
 }
 
+static void read_write_checked(int fd, char *buf, size_t sz, bool is_write)
+{
+	int bytes_processed = 0;
+	int ret;
+
+	do {
+		if (is_write)
+			ret = write(fd, buf + bytes_processed,
+				    sz - bytes_processed);
+		else
+			ret = read(fd, buf + bytes_processed,
+				   sz - bytes_processed);
+		if (ret == -1) {
+			if (errno == EAGAIN || errno == EINTR) {
+				continue;
+			} else {
+				fprintf(stderr, "ERROR: %s failed, bytes left=%lu\n",
+					is_write ? "send" : "recv",
+					sz - bytes_processed);
+				exit(1);
+			}
+		}
+		bytes_processed += ret;
+	} while (bytes_processed < sz);
+}
+
 static __maybe_unused void pair_udp_send_char(int fds[], int num, char payload)
 {
 	char buf[DATA_LEN], rbuf[DATA_LEN];
 
 	memset(buf, payload, sizeof(buf));
 	while (num--) {
-		/* Should really handle EINTR and EAGAIN */
-		if (write(fds[0], buf, sizeof(buf)) != sizeof(buf)) {
-			fprintf(stderr, "ERROR: send failed left=%d\n", num);
-			exit(1);
-		}
-		if (read(fds[1], rbuf, sizeof(rbuf)) != sizeof(rbuf)) {
-			fprintf(stderr, "ERROR: recv failed left=%d\n", num);
-			exit(1);
-		}
+		read_write_checked(fds[0], buf, sizeof(buf), true);
+		read_write_checked(fds[1], rbuf, sizeof(rbuf), false);
+
 		if (memcmp(buf, rbuf, sizeof(buf))) {
 			fprintf(stderr, "ERROR: data failed left=%d\n", num);
 			exit(1);
-- 
2.39.5


