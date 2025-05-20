Return-Path: <linux-kselftest+bounces-33426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92875ABE4B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C24A3B84
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D528C841;
	Tue, 20 May 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyoQumk2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FC24677A;
	Tue, 20 May 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773050; cv=none; b=QvHBvMK5Lok+E0H8M4Hn3JMGsI0krIZZnnKv8aR90JkjpAs3uZXixB8CvEfjd6ifEO5qEbRuVBUamgzmbv1YESFySYQRoyhNRU9Z2YjchfQ++CLB9fGPgr5Kb3AY5v19N8ufQ9qAhElxGlsAyWDuLvD4cxgaWyvrCQCUTeLjhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773050; c=relaxed/simple;
	bh=uUMrZw0jkEFqzVjTFFwQnz5ImkmvO+IkfpqEVikOVLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY//w9BU2rU4ZLO9+PlYOrkmvmMEEt0suiPv/LPd4VLMUku0jTQQR9Aot5DoT47u7od08cwhrMbUDaXcJPZeoHJFSGq16Xm4A+jUQy/mR5tcAbo78byg/GVmgQ98z9nxYSJpVAgeOL2P9N3YnFyeVrTUyuYcTAfHOkifBZg3N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyoQumk2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e8feb1830so3797263a91.0;
        Tue, 20 May 2025 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773048; x=1748377848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3x4ZwJCvjDyH1DPNa2rKPhJ0r5FyHxXDH1rgrPNGCs=;
        b=iyoQumk2iahpZa1qdlz5RDuvSEKnjScKGzz6qimXeUWEpIil/3Za+VOBWASuL+Txsk
         ifa1iZLTMwNa8vQU2EJdCnsAeuDP5aL+pxq1v1dsRCfjfnTLHEIJMXWco2qRoHO8chlR
         xsgY9pD9Tma0dq60StTAgnLqdIMrzF0Wphvo+UnR9HQXJkbqWoEvjYTZhTSt1vF0xjDt
         Hrkqy2eic9Sd/ToAVweQF4v0RO19aRnorVEwsZz1T/LN/6UdVAOM2fVDklFbW7HMvOxe
         yOefNxLD1WPMO080AuHnxQ4oHaVFvIOyhn167M6JhviH4GdTZrRfXKVeauV1D1eoNbKj
         FNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773048; x=1748377848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3x4ZwJCvjDyH1DPNa2rKPhJ0r5FyHxXDH1rgrPNGCs=;
        b=P6XHO2hkmcYS6ndnLEV/wuc5gXUnMTYcZDRCMB7IIanXbANxEWY1WQtV1z6LZI32Ig
         ai/pZFIUfGBQzuyDQdQYqbxKhLdyueP+gAdEs4n8a2Fl6m+7Lrm24SgMIubSvpFTFBcQ
         PPB6DrgLAgJWjoN+fESldizin2Xf+36y7WYMkyO78nLKUUaoeFikagRghhVyDYdlBAz4
         uCYG4dmxldSLxn3frukkvxzYdV1aB4UGsLqqLgKBdbjiefYSn0estJVdxZ6qEu4NvUV7
         DRSuyWiHXc3JDy1r3ZoD4Y1UdtlDLtmdJusVO6wP70siZSt8/JLsgZb8Gzx9p3kwSFUb
         qx7g==
X-Forwarded-Encrypted: i=1; AJvYcCUwvqeTQGx0rUQY22+DVBXSTii0Msa+/s7lZkQ8H+0gS6BeNdfXxu+e3RJszCrRIGAlePrDEtj2VF/Ub9o=@vger.kernel.org, AJvYcCWLYPTRm03BWf3+hW9c9vVaKHhQM7JTaqm1ZF19V+N6AjmyZwMyW3R7nu5RnUDeGErKFoXq8bNXnJdHEJKxMUPR@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlJ0ErJa0DmOpx03aTApCn7VrFgjjUdDRoBz7qYR9rENmBvW4
	FqwrKn0HDaDuLwKr6qylwEZFtoze+yLZoc2ATuNDlou08oK4NZrkbWbPzXuz
X-Gm-Gg: ASbGncswj44ohAV1q8UXNo0i0nMDZ3IjexhPwsnB1QTT3WeYbTbZOjZLbmCixPcJEFk
	Q5KC/4jQNGAgLPyqDpaaFVebbUJLaFF0n1wy0bc/qNjNry5F8luzuHf9PwH/mB/zwaUazGV4Z46
	scjud5NNAS0/y7PpoCCrnbj38sWUACbfBEHW/+7w6qxZln6nRvOKK8jpDzY1a/RlTgPsJWbVWf5
	jKnfHMJQP0uJzGLl6b7PZjIw6XyYbzFD8zxP+DDJtLQ/U9HokzLt98lvG0Uv3sppcsCgJvuFsc7
	ZSHYR8hWj5z+FsPIDLlwtGiddPcJrFHSgKeqf5zsuXVs2ZZTeLhz9rWnVprGTwvp9DPSd3zfmTz
	qtm/freSJaSkMPRXYB/TuEl0=
X-Google-Smtp-Source: AGHT+IHAeOXT9r9/4Ht3bKzae4duZEDDYmbi/jArFcmtsm1/TNhEYfnR0TGpe7AR4KpCslrXt4t1LQ==
X-Received: by 2002:a17:90b:2892:b0:310:8d4a:a246 with SMTP id 98e67ed59e1d1-3108d4aa3ccmr141850a91.1.1747773047722;
        Tue, 20 May 2025 13:30:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30f365e5b51sm2130719a91.32.2025.05.20.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:30:47 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	viro@zeniv.linux.org.uk,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sagi@grimberg.me,
	willemb@google.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	stfomichev@gmail.com,
	jdamato@fastly.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/3] selftests: ncdevmem: make chunking optional
Date: Tue, 20 May 2025 13:30:43 -0700
Message-ID: <20250520203044.2689904-2-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520203044.2689904-1-stfomichev@gmail.com>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new -z argument to specify max IOV size. By default, use
single large IOV.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 49 +++++++++++--------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ca723722a810..fc7ba7d71502 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -82,6 +82,9 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
+#define MAX_IOV 1024
+
+static size_t max_chunk;
 static char *server_ip;
 static char *client_ip;
 static char *port;
@@ -834,10 +837,10 @@ static int do_client(struct memory_buffer *mem)
 	struct sockaddr_in6 server_sin;
 	struct sockaddr_in6 client_sin;
 	struct ynl_sock *ys = NULL;
+	struct iovec iov[MAX_IOV];
 	struct msghdr msg = {};
 	ssize_t line_size = 0;
 	struct cmsghdr *cmsg;
-	struct iovec iov[2];
 	char *line = NULL;
 	unsigned long mid;
 	size_t len = 0;
@@ -893,27 +896,29 @@ static int do_client(struct memory_buffer *mem)
 		if (line_size < 0)
 			break;
 
-		mid = (line_size / 2) + 1;
-
-		iov[0].iov_base = (void *)1;
-		iov[0].iov_len = mid;
-		iov[1].iov_base = (void *)(mid + 2);
-		iov[1].iov_len = line_size - mid;
+		if (max_chunk) {
+			msg.msg_iovlen =
+				(line_size + max_chunk - 1) / max_chunk;
+			if (msg.msg_iovlen > MAX_IOV)
+				error(1, 0,
+				      "can't partition %zd bytes into maximum of %d chunks",
+				      line_size, MAX_IOV);
 
-		provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
-					   iov[0].iov_len);
-		provider->memcpy_to_device(mem, (size_t)iov[1].iov_base,
-					   line + iov[0].iov_len,
-					   iov[1].iov_len);
+			for (int i = 0; i < msg.msg_iovlen; i++) {
+				iov[i].iov_base = (void *)(i * max_chunk);
+				iov[i].iov_len = max_chunk;
+			}
 
-		fprintf(stderr,
-			"read line_size=%ld iov[0].iov_base=%lu, iov[0].iov_len=%lu, iov[1].iov_base=%lu, iov[1].iov_len=%lu\n",
-			line_size, (unsigned long)iov[0].iov_base,
-			iov[0].iov_len, (unsigned long)iov[1].iov_base,
-			iov[1].iov_len);
+			iov[msg.msg_iovlen - 1].iov_len =
+				line_size - (msg.msg_iovlen - 1) * max_chunk;
+		} else {
+			iov[0].iov_base = 0;
+			iov[0].iov_len = line_size;
+			msg.msg_iovlen = 1;
+		}
 
 		msg.msg_iov = iov;
-		msg.msg_iovlen = 2;
+		provider->memcpy_to_device(mem, 0, line, line_size);
 
 		msg.msg_control = ctrl_data;
 		msg.msg_controllen = sizeof(ctrl_data);
@@ -934,7 +939,8 @@ static int do_client(struct memory_buffer *mem)
 		fprintf(stderr, "sendmsg_ret=%d\n", ret);
 
 		if (ret != line_size)
-			error(1, errno, "Did not send all bytes");
+			error(1, errno, "Did not send all bytes %d vs %zd", ret,
+			      line_size);
 
 		wait_compl(socket_fd);
 	}
@@ -956,7 +962,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -982,6 +988,9 @@ int main(int argc, char *argv[])
 		case 'f':
 			ifname = optarg;
 			break;
+		case 'z':
+			max_chunk = atoi(optarg);
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;
-- 
2.49.0


