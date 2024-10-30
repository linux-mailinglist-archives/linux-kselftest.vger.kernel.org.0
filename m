Return-Path: <linux-kselftest+bounces-21112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B59B65CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C003F1F21FCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A81F7091;
	Wed, 30 Oct 2024 14:27:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B11F5834;
	Wed, 30 Oct 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298453; cv=none; b=o7owTkAajulY3Tvpq+I1XHALMRanehmBSbVBc/1hrJ1WJVS7zwwgqM477ZS+DNMDZV+lUkU9+npx5PQ+LjxjEI1AaMqME2UuwLLiCmUSm4LOkaculdbizYnpSZaubdNULwC7Qqyu5phykILOH7K0U80yGuhoGY+Y5ODoYfZmufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298453; c=relaxed/simple;
	bh=cZM8NLCE5I1kpIKc1v+Fo5zXbiCk1fh2kkSluf5P1Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDDKYV3R9iB3kBNscPM2j4nT6pOhYjorp+nMnshPQVUARaGg/QrDdBThXjKubfqQTnn//dElJR7wbGSJxvop2bWUOW1Krdl+bID4k0YS8yaj4w1FRdEnIacZyOVW8GkbYEz0hFF0Tfo3wsi/wHq1nV+9KoO1W0i1jE+d9REMtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cbcd71012so72606835ad.3;
        Wed, 30 Oct 2024 07:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298450; x=1730903250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFRG3akeouWA/XW0R5O9u9ae+dag70KWFU2wlOjYpuY=;
        b=W6bP70s6Bw/oe4pkTk+VHhB6Qp0vuBa+zH+WmuVQSuz2X05xcO0hzDFrsidoFKgm0n
         4Dh7DqXMk16NU/jRpqrDW7YXRYNbVZLbmS11DBSzF57sxj6OiH8ONJfhJirpvy3PmBxm
         9gAfc97wfK04HFyRJhCzilIChwUlkjac1jv829n0C7AT6uFjFN6lrWgcrluI7ck3jTlG
         xvE31w4VXIyPGDFottls4FjiLHPxOjKXKGlv9PH+PegZ2UW1aV7Fqv5lqjIuWEgD+o9n
         PqB+vpyAHN66sMP0SP3GLHTsQc7lbqWihyO96nK3FbgPgYKAwiAAUSusjByJl6PtrQIc
         agSw==
X-Forwarded-Encrypted: i=1; AJvYcCWVp44bpV7hgVvs+7hdcSpXZQzuv4Hi4mSKpFEE4RK8Zsuosmx7x8XMzMs9vvTXTCuXjywQ2jdHOq3J6+v+0lKY@vger.kernel.org, AJvYcCXXNGk2Ti2MYEHlAK5ZGz+ZD6wsWZ7ri96d51mn1ET4IvwmzGPuSF2E3bGt9qsS0IqS216RMh6uy1DG4jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdDA0TtknEJIHgtePZseFP7mmIvsKMEKK5k/otAT93Nlb4Lj0
	A8KEeKD4q+4NdSLHVANRvdKXPRbLalfJvnydKQexehf1lVWh0UrX7/0frE4=
X-Google-Smtp-Source: AGHT+IHvi+b4Ud2DkRezJIKBc+Yh572At2DSidGhkmiYh+PniSjY+SwMvBTo2m333/Q5LjDypq/O6Q==
X-Received: by 2002:a17:903:2312:b0:205:8407:6321 with SMTP id d9443c01a7336-210c6879f49mr199352505ad.9.1730298450223;
        Wed, 30 Oct 2024 07:27:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3e7sm81009385ad.89.2024.10.30.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:29 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 05/12] selftests: ncdevmem: Remove default arguments
Date: Wed, 30 Oct 2024 07:27:15 -0700
Message-ID: <20241030142722.2901744-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make it clear what's required and what's not. Also, some of the
values don't seem like a good defaults; for example eth1.

Move the invocation comment to the top, add missing -s to the client
and cleanup the client invocation a bit to make more readable.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 61 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index b94f7c4a53ed..037fb6e97d29 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -1,4 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
+ * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
+ *
+ * Usage:
+ *
+ *     On server:
+ *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
+ *
+ *     On client:
+ *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
+ *
+ * Test data validation:
+ *
+ *     On server:
+ *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201 -v 7
+ *
+ *     On client:
+ *     yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+ *             tr \\n \\0 | \
+ *             head -c 5G | \
+ *             nc <server IP> 5201 -p 5201
+ *
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
 #define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
@@ -42,32 +69,13 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
-/*
- * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
- * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
- *
- * Usage:
- *
- *	On server:
- *	ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
- *
- *	On client:
- *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
- *		tr \\n \\0 | \
- *		head -c 5G | \
- *		nc <server IP> 5201 -p 5201
- *
- * Note this is compatible with regular netcat. i.e. the sender or receiver can
- * be replaced with regular netcat to test the RX or TX path in isolation.
- */
-
-static char *server_ip = "192.168.1.4";
+static char *server_ip;
 static char *client_ip;
-static char *port = "5201";
+static char *port;
 static size_t do_validation;
 static int start_queue = 8;
 static int num_queues = 8;
-static char *ifname = "eth1";
+static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
@@ -596,6 +604,15 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
+
+	if (!ifname)
+		error(1, 0, "Missing -f argument\n");
+
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-- 
2.47.0


