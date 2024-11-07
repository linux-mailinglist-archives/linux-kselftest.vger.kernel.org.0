Return-Path: <linux-kselftest+bounces-21632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC119C0D86
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F219284A18
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AC217F5B;
	Thu,  7 Nov 2024 18:12:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C624217F29;
	Thu,  7 Nov 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003141; cv=none; b=sADi5mOWZsbpmyNNvhfxrNHOtXHfq8aKuQENYf09O9b4aHDhlUslrPERJ4crt2ezRUfng3/LSPqQifielg4tr1gaOS0Yh41Z99lI8L3EUdo2DsSkmmh+ZFzps3glSstY05ZmFn69zkC8Y/o1pSjHYEbo5FTk3cg08Iun9QvzPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003141; c=relaxed/simple;
	bh=l/t2OEt/S6sMEb2VgG10+aYBp6AnZFYQDPVVgeT5QaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMO2G9rfMe2gFJ3mA59nOxLaCNB5J59vh6/TzOih6YygmIP6K9wX3gkWtCGMgENKZW61k9UGwh+QGw2MGPWezXKUlAir4eT1U798lg9ejyLu8D9FOE46uGnA01hOkcpY5YgnFOgsgwQ4lw1HuG4sv5rp8kgWneuVTzbF0KKl5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1062420a12.2;
        Thu, 07 Nov 2024 10:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003139; x=1731607939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycZNb+MV+lt/bFEqz5a3XvWO/EIFkiP256xD9EmYPa8=;
        b=IMYJ3kG4AOh1yh78bSSA/YgqZbdk2Xc1KNn7Wbq1UUQCguS8BqsLpjvhOZJrbBplIq
         FdUFuWlu+0ERtP7sCC3jPn/Xek7sG1I85tC0htsOT5L3Xe9k8sO5HmbX3a8u0voMlYiQ
         aeF94ZqXHq3CL5lXQzqXKdttVKZA4gWf6LPrnclF0bndDQ8tZL0vQT4r+jAk40jYjSIV
         QvspOt5tzaFWqK9j9pI6W3P+mAfruB0inyp1LWnkbDxUm1sBAeIFo5GpGfKGeO1/yHKm
         UyO/PIoLOCyL83i4zszNY2dXRoNTKPWYY+NHuq15Ctc0soiRSZmqeiymWvEVl8ZaXjnh
         oVTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ac7c18zAUUmjF+WH7OLrQKlHC0kaL1RXMK6/KOMz2qWtwLHY8V3o+3q8bMac9kvcKekYHbCnHyb1QlaiuYYX@vger.kernel.org, AJvYcCW+PKF6s543Jue7gmJ/DdseM4poFrDWXoH5Mve6zvWctH/yS8atiE9BpxYS5iV1zstHxn47vIAFBl5r16o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuXqXHDE7xL16CAIKIVNacfs7Ayf8PEEJXG6qsYM/EIOu0kVk
	4RB5zl3myY6omY0co/jPbxpXkBrRcHHfeikJN1yCmBGVeZCWScI0oWNT
X-Google-Smtp-Source: AGHT+IHm9H1tgRkUbltQueJe7Zk8MP32jmY1Y7IUr6IRDZ3hmf/qvFhRGiZlv0FJHcAhu7KgvBKcrw==
X-Received: by 2002:a05:6a20:72a2:b0:1d9:2b51:3ccd with SMTP id adf61e73a8af0-1dc204ad1cbmr672198637.7.1731003139208;
        Thu, 07 Nov 2024 10:12:19 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f4890d2sm1733076a12.14.2024.11.07.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:18 -0800 (PST)
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
Subject: [PATCH net-next v8 05/12] selftests: ncdevmem: Remove default arguments
Date: Thu,  7 Nov 2024 10:12:04 -0800
Message-ID: <20241107181211.3934153-6-sdf@fomichev.me>
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

To make it clear what's required and what's not. Also, some of the
values don't seem like a good defaults; for example eth1.

Move the invocation comment to the top, add missing -s to the client
and cleanup the client invocation a bit to make more readable.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 61 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index faa9dce121c7..0feeca56c049 100644
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
 
@@ -595,6 +603,15 @@ int main(int argc, char *argv[])
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


