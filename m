Return-Path: <linux-kselftest+bounces-46454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ABDC860A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A01E4E2880
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698F329388;
	Tue, 25 Nov 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apIzVQrX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D411329392
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089641; cv=none; b=fhWpTOakJJRNPQeCF0yKmyWY3u7+jhyG1ImBPURo0GOS39uIy24m84WSF+KgdaW1pooiMXVVUihlC2nPRUOAx0Y0pRDjU/X+V7JNZtWf4egvTjZ5SNnd5mewUWNrcF98jlEBjA2Zcbcf3cS/WscrS0HVJi4006Uv8nVADKp4LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089641; c=relaxed/simple;
	bh=aUplM0Q+WymYe+1A/lZP7aug9PsfhHdEn+gWO5zCenM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR5ear0YeWP2o9Tj/8tW3zvZ5JHWOGHxpu37zrhiXvI1e6U4gE1mr+TCrXXRotqJCWpo5oGSXF2IMc5RWChLh+1+2k+m4CtevY3vTFC3RPtmnSxdweXyJ0NzqTNISMEbzOFPQtcr+57Guu9I4aoEdjFHPEbmtrQcjI+wyUikDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apIzVQrX; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2957850c63bso84925ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764089639; x=1764694439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s18FMY7uyV1u44mRCnu5uh2i4blp0jl9qxnh4O2Nz0=;
        b=apIzVQrXn1eJ3b4cYXW4b0RSsqx/8AUv0ki1imPuN0shCz6xwUOoV1nLxYy0t5EPiC
         EkT/p9BuQrPrQGG3R4Ygg37PyhJ5QkWPktWbZLC6el6QFpSKf2H+/cd3V7HGtwcyQLTt
         N5cWzIIwM8Is+1AphzFN2kc/atq3a06B1pB/gELvomI0Zz0G0mqWbXEA4vbM2M1BH06Z
         YsBElocCWuBFPyB2h8bCTe++Wt1VaVEdMe2D7Eb5w50LQf8nmRvNplXzZFFBfomxNG6k
         atW3Y4dU5NxUFK6y19R9t9ym67my3qgbTA6cMqRh8AZusi2f84j4ZOzGfDCsgjrCfxia
         EKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089639; x=1764694439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s18FMY7uyV1u44mRCnu5uh2i4blp0jl9qxnh4O2Nz0=;
        b=Xq9IaROtGuPzpOeeTRUms5PfbAQCwatq25uIUTYGPFc6rxiIWLU/CTbJG1TEnXX4Tg
         m22o5uk9aTmlWCDtbnS3WxHb9QACcVGOKZniD7zaFkhev/xxAgJl/p3Z5gtIe/ovSGif
         r7SoAhosOPt5l2PXwK5k/XPJ8xrJP6YiW+lwqxaOqqhRYbBOLnjlZ5iYw3G9GwEuAorQ
         mFupWCIKYffQWahN3uGGorE2A1RpUpiD/UOp8RjW0Iw163G6tsF6WvnVU4J3opUCY/IQ
         iiyuuJnmq2IHxbTQLr1OeLU+3bR2aoCPMKVGVnmTETaTJpuMR/PEIdxzJ6CK0xLfb1s+
         l9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU29HBunDaHNCLa0ubuwzvkZOITnqy+xVcDqJ8JkPWebqj1cRIM1iY51kzwn7kvNYVRU2qdyLKnsoZqYEAt400=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHb0y9fAZqhf/bFiRrQAs6YhBOSbPJHn2xnmvP2QgnW6VIKjf
	vA1D+fKMOnct0YcVdUueOBYg6QKhfYk96fVZnQnplXYkqwYTJx4BsJyT
X-Gm-Gg: ASbGncvqOzPSSlRfvy72tD6+GW9qPU0SOXoESI7fWfGQi68gDC82lBJCxR04zgEiVkP
	RvJaWXu0Cx8hi9cgI2KWfvwzqo2gVCXqmjXL2rNLh3ZRMg4DScASg6fjAfn3eX9448ZFp8sZLnn
	nt/PsKzkoroefIlzrUdvHauyP0slP7bw4dBT9aSwelY9ZhHjVIBU+rgO+Hax9SdCOPFG6FTh18d
	Ggwp0sO8OEQmjM+fAWFtPpnhYLvUtYUgII2T3y0FzuJwcYyhPalz29Rf3YvQVACFyieql0GnZzb
	Al/OSt3+t4qU5eeJhB49oc48NA6dNljQ8H9ZlElTGFjGmrvwNRh+2fDmyrgpPX9rwm6zoEwnrZL
	7VD0CNL1X6qIshkOm8HlqEIV/PNW9taYvSpxExKdSFWyWIyaGaX1k8LGR7l+Eicu+Z+EwqEHe4k
	kwSUO22rQUbBkx21s=
X-Google-Smtp-Source: AGHT+IHbazQEvSJes2O1nzZNAo1c74boxJ0wjTnr/HuZ/uGnkJLH8XoebhI/9J0mCujwUj3AMXkadw==
X-Received: by 2002:a17:902:f78c:b0:297:eb3c:51ed with SMTP id d9443c01a7336-29b5e38c16dmr231490695ad.16.1764089639434;
        Tue, 25 Nov 2025 08:53:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ad643sm172438435ad.91.2025.11.25.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:53:58 -0800 (PST)
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
Subject: [PATCH net-next v2] selftests/net: initialize char variable to null
Date: Tue, 25 Nov 2025 22:23:02 +0530
Message-ID: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

char variable in 'so_txtime.c' & 'txtimestamp.c' were left uninitilized
when switch default case taken. which raises following warning.

	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

initializing these variables to NULL to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:
v2:
change patch name to net-next.

v1:
https://lore.kernel.org/all/20251124161324.16901-1-ankitkhushwaha.linux@gmail.com/
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


