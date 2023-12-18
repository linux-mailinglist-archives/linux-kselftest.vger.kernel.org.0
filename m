Return-Path: <linux-kselftest+bounces-2156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10388171E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD141C24C53
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172E3D542;
	Mon, 18 Dec 2023 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ6HXPXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33137884;
	Mon, 18 Dec 2023 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso3799186a12.2;
        Mon, 18 Dec 2023 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908084; x=1703512884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWFFTMmjudAuImn+i/lWj+bNwoNGkXfGjQfocWJc3Zg=;
        b=kQ6HXPXLFCwFPbRh7qCWaS5qpxDVs3I6hbo6rD7Ht5dtrWP3dhYxl9MqrERDgalUCW
         zaG1le/iZNWNTgatNEEoy5BWVyds6GV4cND+HH4ZtW9AYo8Wefw8tOa7MGrdEyNjFmWG
         4II85lEjBpC64UntwfZDMAP5XWHq9JT62cagEyZ5YGqKHm03A0va44K+Pq85zIQ/8/Pc
         Si94d9rijvkWP9+jzkVCz7hc6ydpp1p+ewTEXOh8wkl8VFeZcbtUvBy9wp+Hwxa9AK5z
         iHEABs0+MnAYA3iGd1bVgV99cC3qVIcflzPyOuvnICuVwCpQzd61Jxzb/L1Wokks0d5H
         Izng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908084; x=1703512884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWFFTMmjudAuImn+i/lWj+bNwoNGkXfGjQfocWJc3Zg=;
        b=jDe11PVzelCmacJwykiTxTavkQ0a4k3ZWkBIyqY8hluNdDYR2lSQ7JfgHT2qlxjXFE
         Wn1+EkVOcEKjmppHioFrpUWjA4e9wDNs8MXs+b/yJQlI8ATPlZD+19ykrWBZQ2334jBL
         ULoc/nC/zDXV89OjYUHjs02yJ27mv365O89gBH4udY2cQEKYrXpMmjTHWpAWiUWbqMV6
         NfGSnDiNwMEXz/KV7kic/GSt0w5PT1Zst48RGy2LXU3w4k7TRQgJhlOQQ7u4UtSVr05u
         Uq9oDS8lVJoG1G/MybjnjvQGTjGAES03499XeFIf3HPWsBeadBEJZqGsli1kIaz4ZKFK
         mllQ==
X-Gm-Message-State: AOJu0YyZPUKXboaO5YbEcmZyBdS3FcH9brSt+ZZae+BWrfedaILEEOCF
	tXD/B+O7Iu56giYqj+LRh2Yb6/E2VNvcag==
X-Google-Smtp-Source: AGHT+IFS41/9c/f2zYs5b/v3+TVLnJPotcv5MgPWYGg3SuVtAzleCxrxU+fHoEEzTVwTWj8URLOIFw==
X-Received: by 2002:adf:fa49:0:b0:336:660d:20e1 with SMTP id y9-20020adffa49000000b00336660d20e1mr1127549wrr.75.1702906223578;
        Mon, 18 Dec 2023 05:30:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d45cc000000b003365422e8b9sm8990460wrs.17.2023.12.18.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:30:23 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/net: Fix various spelling mistakes in TCP-AO tests
Date: Mon, 18 Dec 2023 13:30:22 +0000
Message-Id: <20231218133022.321069-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a handful of spelling mistakes in test messages in the
TCP-AIO selftests. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c      | 2 +-
 tools/testing/selftests/net/tcp_ao/lib/proc.c          | 4 ++--
 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c | 2 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 1ca78040d8b7..185a2f6e5ff3 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -55,7 +55,7 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 	err = test_wait_fd(lsk, timeout, 0);
 	if (err == -ETIMEDOUT) {
 		if (!fault(TIMEOUT))
-			test_fail("timeouted for accept()");
+			test_fail("timed out for accept()");
 	} else if (err < 0) {
 		test_error("test_wait_fd()");
 	} else {
diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
index 2322f4d4676d..2fb6dd8adba6 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/proc.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
@@ -227,7 +227,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
 		}
 
 		if (nsb->counters_nr < nsa->counters_nr)
-			test_error("Unexpected: some counters dissapeared!");
+			test_error("Unexpected: some counters disappeared!");
 
 		for (j = 0, i = 0; i < nsb->counters_nr; i++) {
 			if (strcmp(nsb->counters[i].name, nsa->counters[j].name)) {
@@ -244,7 +244,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
 			j++;
 		}
 		if (j != nsa->counters_nr)
-			test_error("Unexpected: some counters dissapeared!");
+			test_error("Unexpected: some counters disappeared!");
 
 		nsb = nsb->next;
 		nsa = nsa->next;
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 7e4601b3f6a3..a329f42f40ce 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -427,7 +427,7 @@ static void test_einval_del_key(void)
 
 	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
 	del.set_current = 1;
-	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-exising current key");
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-existing current key");
 
 	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
 	del.set_rnext = 1;
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 7cffde02d2be..14addfd46468 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -72,7 +72,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 	err = test_wait_fd(lsk, timeout, 0);
 	if (err == -ETIMEDOUT) {
 		if (!fault(TIMEOUT))
-			test_fail("timeouted for accept()");
+			test_fail("timed out for accept()");
 	} else if (err < 0) {
 		test_error("test_wait_fd()");
 	} else {
-- 
2.39.2


