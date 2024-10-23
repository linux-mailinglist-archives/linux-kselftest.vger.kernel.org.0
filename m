Return-Path: <linux-kselftest+bounces-20474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D824E9ACF36
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8230B1F22307
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29311CEAD4;
	Wed, 23 Oct 2024 15:44:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F51CCEE9;
	Wed, 23 Oct 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698251; cv=none; b=V270G0Q+oEoSRI9QtpwtxGbLc3AZIYWbcYq1xmP7dgL2OV9kHxlSjK3T1M8qslWmmDE0z85N/49KR+kAfX0srzwpTb6Ed4T5oBJApCh5DnEQGt7eYZR3ou9VqLT6reEFHAGDkrlQOkL0HLPpSaJ/cW2fhmSNg2h3/1pEebKjvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698251; c=relaxed/simple;
	bh=3Q3dlvLAs/sXPMb1qDNuGq5SMufPn93IIeoDTDQN6hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvzBDisIJfuUbVXneGiQqoIAqe5DTCnwvyG6sOPDPDcIf9AqJ0rV9lj8BWaG79UcJ01MK2rKgl7XQY7QuiI5VGS7zQpPRNB4ZWSjKLY1NCP/1PIwynYCrx/gVT4u/xjvTDMBZ8QWjzZT87IPM6vzqWCmDNJ947R4uBqA/NmqBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb7139d9dso64384935ad.1;
        Wed, 23 Oct 2024 08:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698249; x=1730303049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiS+4uLi7KwWxf2hS/+lqiCxxDWyZoQdVn1wNhIX8dw=;
        b=sHBIJ+oeeLgfLaEazDvJKJOQ7mfgpWRC2uTmF8RReju47QdaAsP8m7jOpK87yGryxZ
         XB/mDorPfLJ/l9hZi4qfYo6GtKBYR1lRWFvMeh8PYMmBOcMYempZrjhqhu5sFw+9AAwx
         wBY+Uv/AaMUqMV2tC6Pfh70PQyRXmAmlxB3sK5V8p5lsrjxqEoFJoeSFklvggi/NjNvt
         1O0uXZNfQxc5FAZCNHgufS0f4TQ8sV7VkDTmib1/muY35VrUQNdXsi5bhsq7E691TuF/
         6F9CUG8IiQJhTzRF3meZEx6zL2eQ7OFAXhFNojTMr9YvAu71Cx5vS5EPYmG8KrwZbmqU
         DpmA==
X-Forwarded-Encrypted: i=1; AJvYcCU05BKKcA6z6C5lkJMSgtV0ds4LFYDBZ1dpSQS11i/6fParJQH+VhBIm/PwJ++LFyl1lexYdsyJQ8dcXWs=@vger.kernel.org, AJvYcCUjEjqz3Om70iv6u98ioMf6OJRrx0j3QQ3C0OceMXT2tJBoxjnP7gvFMXFD//G7UnHGBQIIR/NPTRLB2ZHHiWhv@vger.kernel.org
X-Gm-Message-State: AOJu0YyRj2s0SPWCN9ZSOmgxa39z/MuGCIVk0g2Kp6AG9NF8FELLVJFP
	sKl2uCjhrUjHxJIO8OsdMr6MhmioPEcMxLbpa6uZ/gKtgYAYT881ZMPkf0c=
X-Google-Smtp-Source: AGHT+IHKVYwFII+FgdeA/Ug+ahHx5vB6W9ty+r7noIXKmcnI19zzBwv1oQyVPIf460mqnXTILZGFuQ==
X-Received: by 2002:a17:902:e851:b0:20c:b3d9:f5bd with SMTP id d9443c01a7336-20fa9e41304mr33951145ad.18.1729698249163;
        Wed, 23 Oct 2024 08:44:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0cbf1sm59149395ad.103.2024.10.23.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:08 -0700 (PDT)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 05/12] selftests: ncdevmem: Remove default arguments
Date: Wed, 23 Oct 2024 08:43:55 -0700
Message-ID: <20241023154402.441510-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
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
index 051dd8bb0d3c..b81b8de165f0 100644
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


