Return-Path: <linux-kselftest+bounces-21398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2A9BBD10
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B523A1F23594
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1D1D0E08;
	Mon,  4 Nov 2024 18:14:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F471CB9EE;
	Mon,  4 Nov 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744080; cv=none; b=dXWZz2lf5ZDSdoLROq9T0R6EM22PGvsAuTziBQZVrbVChaDzmyz90S3s3mSPruC7H/cxDvj7dsxZI2rN63jqDHzwYIv2LOlsRsWpZ1IBtJkoC7oc7xXZh4wV/dzJkW6Ez18H6FUu4Mlum1WdgGaEpq865hazqnvlUgSqbiGRpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744080; c=relaxed/simple;
	bh=X1AHO5hh0Cz7YoXze/wBSjee7SVCwrbQ9TGTRkfLAkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neN0JG/iXd1PWUiMn/v3yf6feoS2vNjFB0RIojtmMV9gXnbgJ3R1DX/oEqi4TCx1wXaq+PM4TIXSajCdaEI7Xg19XjsigRxxMc/KoBvPxHCmar/rkUjyoSRiBSQU0F0qn5DOxzeX94naE7VyDjyRfYH2Q07Xa1F+adtExXJfoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cf6eea3c0so35692365ad.0;
        Mon, 04 Nov 2024 10:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744078; x=1731348878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/Lvchejx+wbbnnPWqy0g/pNEGTgnXT8sEPSjXOpiZQ=;
        b=tJx+5EUKYodPoRpHnjjCE+5VjaVPxTa2sT61ihmdO3CyBFBJqGj3T8KiVivJTXAohT
         UyvK3J4GBLGwHyTKWdY82OyblDERGyIk5RDNPnQOze1Tv8pIyOhOCRBH6MjMaDsAGlAF
         8x8TzKqbGHISOVqknzk4XM0HNPgJmJ5C1MXPMIrETYD4eSPq9mQxTHv26tfhjFoMKXeX
         YYMbTmq56wSnrmeXo8plef9OBwXTO5nsDU6m40/ygROdlpwX5UubILP0d4aXHjgtlw7G
         yfr5O3nTgyqEcbWiP9fvz3djN9LrCekG2SlGngtp+IRn1xhaWPMxAp+QwiHctKG7mP9E
         Lhwg==
X-Forwarded-Encrypted: i=1; AJvYcCV+1bdHJ/2xvF1AhkcyfyQcKgj+Z7caXqEk9qsWDG68KIN4VIF2FhpjFVjDluDDl3g+bHcUDyzKb818N4c=@vger.kernel.org, AJvYcCX5uf8v6VamiP//aO+R6E8JzYXiCPOCy4aZ97fYR0HexKmiKAsht4/cu3kFz40vubs9N2X8qkueMzHVeGaKymwE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPrGOoVhSic7FwDFcsr/x81MQuqEj2/irT3CcRsECT9U/JjC2
	6nBWprsVove40mHL9NJ4y5ZBhHqX0/D3vrLSqCImvO7vSjstiYn1j1GQ
X-Google-Smtp-Source: AGHT+IFQaG/M01w4kzS54ClH+YX+wiP0NG7/rEz4zqdriaevmeGp8BSqvEw9+wSQ/yN05763UJsFFg==
X-Received: by 2002:a17:903:2a90:b0:20c:e8df:2516 with SMTP id d9443c01a7336-210c6c344admr411401635ad.42.1730744078012;
        Mon, 04 Nov 2024 10:14:38 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bffffsm64244045ad.188.2024.11.04.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:37 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 05/12] selftests: ncdevmem: Remove default arguments
Date: Mon,  4 Nov 2024 10:14:23 -0800
Message-ID: <20241104181430.228682-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
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


