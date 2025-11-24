Return-Path: <linux-kselftest+bounces-46394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24DC81817
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A96D3A27EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFF314D12;
	Mon, 24 Nov 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt2XVAKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39437314D07
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000821; cv=none; b=SpTt+ihsXLRmYUkNW1swtf4MN0Efo5yyE9S12bdTfMbVB2/oYEKT/303L8x51nGwoduhzvj4jyQ+81L/7mWsvm00NTYaJmm0+WrIGx+lqD9g88zYfJib4VYoJTBGfjrGRNmQHyyCyoTx2b7r3tS1c090pnVUQL0sBq1GbzbZnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000821; c=relaxed/simple;
	bh=jjSP/LYJNyk9jWpRW8gGli2ejZT4h4Y4QXCFB+0nMY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+6yyqiuMYjk8xtCIsm/Vk9BPMO+ncc3p2a14DNx2l4qeHv83aW6D1ZENJAjBr0Bo9fZnE2mOEf/IubDyz2FkUcQh3LyNmj4WhbG9r78lqah97fkyi0mQUhKWgU2yiU77PNf3F5V8EewHxQB485ce6CtVMe3YEYnovCPgHGh+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt2XVAKZ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-299d40b0845so72786395ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764000819; x=1764605619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBGbhFp9ofE9mZ/RF8edJWFX3twAnfhW+YguioC3Mc8=;
        b=mt2XVAKZ+7Uj/JCve6Vt2qnaDyR+aMkL8JTrBcz/jgaDT6kasThXD1YaZKBqdiHrNz
         2zRHY+SobpPkhZWGEH7Kt6q9beRHc0m+KeglkHaIEKSrc9VsKP/6x77KXCBfSK1q16sk
         O6yIItnFM6e2vmXmyOZbejMrg7JYYiWb3KLeAQ5RlGxGG9bIyyvWfDBK3Ad44vOvvgbE
         l+B1GbM0bj1L0akdvtlimeRMmEbYDNJheyYtxI3R1BFHAwx38/wI4MpSVI9kea6e9uMj
         ItyQqrn04AwBsfkWZlsdX1CW0+CANLM03uYflzl3BX6Z+CuXm/xotydRKM0PeFgWkBJM
         Nl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764000819; x=1764605619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBGbhFp9ofE9mZ/RF8edJWFX3twAnfhW+YguioC3Mc8=;
        b=r8rK4Guog8di4hEpweUSHEdR4hYlaY5uR74sicFMKOXUW1mcx0ykffrbtGssf+Gcn1
         babIz7Iresrh68Xqyd/MckCGRD13LalZYMuo+dPFulSpko04ZFB0s5pdvNAf5YHs44zc
         aDzJUzGkg7s1/u0+nmwL25HDFPWShUI7MpBgLxm7vnZDSkUaCisSLNha5DLpmnoWcJa4
         7ggFGO2sxOupHh0mwEf5JSXDwtjLTXWXKJkRSoyd7T028KbwHGuXZnwpSx8t3Rv8rxJZ
         dKB3NNs2K8hmSt0bXi3KhPw5p4J0JBGWJ84c8dujP9vCV8axdEccWDpu+sM6nItUSJ1q
         4Exg==
X-Forwarded-Encrypted: i=1; AJvYcCUR104lFBDhCsc2KNZ6VaQbugKrfgP7DNlZJYiGpyp65ALQ6sPP0p0RLcTROscU3hQa3XP2QheI0t1UvfKvJSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgeinvf0Tb6nd/VQdB2uO5qt6BCLCE2AyZyxRIN+gf3o6RP0H9
	GIDZOhwY8CrM4YyZgZwhtIFQyb/yTa7E7H1Djp5lFkdTJw5dqp14gZTi
X-Gm-Gg: ASbGncuC3qObQu/wtfqrQlPh64mbe8dKk8xfO1jZXVgJvCRPP+joLYXtUP1/wGDgbsM
	nFVM0bBj+/G24X+B3V5rhSjPdIk+9SfHTPW+71NCR9vQov9MftS6eKforAT8M3FdtesYxCYOunt
	Lv6E1EgUFD/tkB57aXFzbXk89oFaMNjnAsD1OqA9FbbDCDLMY90NMqWuGyenzp7wjrhP5wNsmkc
	l/n1ZPTj7uDgQPHD2H3Z5kZqcmCazkP4MIaTdcv8ooOLFBLjVNQ0CVgdAcDANCAsPQUARLh99St
	EkWV/4wJhAGHoMG0w2OjnVO+jgzfvtAzYgkgzZFeWseK4zJXvKQMj2KLKr7w8UsHQIcUOoVPu+G
	6MUyNYklP7XMFPAuflYIzvkf7ds8qEFa6P1jktkyKAAzx06ySW5WS7RRXgtmoZSHwj3Bp/+7BW9
	/lso9sDuQgu0wWSVM7KLeBTkp6jtRsmg==
X-Google-Smtp-Source: AGHT+IFyAWItYzJREMkeo/sQHkp6vA4cekHCSsVdluSIl/JP4S//ICISujXNC1QfyubZ0laErlhTCw==
X-Received: by 2002:a17:903:2343:b0:295:68df:da34 with SMTP id d9443c01a7336-29b6bf5d332mr123003615ad.53.1764000819261;
        Mon, 24 Nov 2025 08:13:39 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29b517sm138118745ad.82.2025.11.24.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:13:38 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/net: initialize char variable to null
Date: Mon, 24 Nov 2025 21:43:24 +0530
Message-ID: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
by when switch default case taken. raises following warning.

	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

initialize these variables to NULL to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/so_txtime.c   | 2 +-
 tools/testing/selftests/net/txtimestamp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..b76df1efc2ef 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);

 	while (1) {
-		const char *reason;
+		const char *reason = NULL;

 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index dae91eb97d69..bcc14688661d 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
 static void print_timestamp(struct scm_timestamping *tss, int tstype,
 			    int tskey, int payload_len)
 {
-	const char *tsname;
+	const char *tsname = NULL;

 	validate_key(tskey, tstype);

--
2.52.0


