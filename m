Return-Path: <linux-kselftest+bounces-15133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77194E3F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 02:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7261C210BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097DE2595;
	Mon, 12 Aug 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5kkbm94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8D23B1;
	Mon, 12 Aug 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723422283; cv=none; b=ehrC0ct2quRLuhFQw+KVkKz62+BscDwUYDI7UyX3zkunGJ7qmfRL5fT+cv3l+lT+chl0eW/jLQrA2cwFp37ntqycb3+6wLK/YpF+WInnrKDEepCVfFiPqCpRjNocCC1OXoG8AwfwV2z4aNoyCC7GNx6Tf08vO9QAP0oeQXOnzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723422283; c=relaxed/simple;
	bh=T0mIvCsNRCHERp9BKGKNc3FgDJxbKryymnBKgmdOTnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oaeHqqyfOEe8IwItdEt6Uo6OLCZ+D+s7Q6A1iwwX904bIVt+Q7t6uHDLpMTO0eqn/t7zkjjPWYJhI8B9n2og5u3/7QUhn4t7sROibghrNlwMoS+msgM1sERSsH0Z9XGNcgtRVLl/cTXuYma4pUrAsWl+r7g5f8wj4Ov78yXre0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5kkbm94; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so392465166b.2;
        Sun, 11 Aug 2024 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723422280; x=1724027080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1MLHxo1yaThTf1xoml/JNgFxZCYz4b9tijc9rAA2Vo=;
        b=R5kkbm94tKLoh+oyhYDMKwJHI+Cq8pCJkBsx3Bv5Zy0N2C5dj2OjFwNkKIq8zNrHwR
         2Xh2h3SLwKLRltWlO/nR2MOYDCNdDAXuRnqOAkFOsZm5J3vWkSLBPWuTmHE4cy96ou3W
         uv6Y+e9ty5bMmHJTDXHBIpTR/5fas/f+Ie/ihl68Fgg0zUpxOCQEI/KoVYTfMHoRVYzT
         lgONU1ihKkEBsT5fns9t1/gRpch/iLcPMExKpyIiWeaO2mj8GkylvMuNo+0Vqd2i/rf8
         OQDt1nIAGLTFcgDMGWTR3fH8sglcvFFNgxLlo3wnrWkRd3OuAq1pd0w24Z0jcvE5Ar4a
         OpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723422280; x=1724027080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1MLHxo1yaThTf1xoml/JNgFxZCYz4b9tijc9rAA2Vo=;
        b=RSLmCISGrv19m+n1tciyAaA3O5G8DLwWTBMxe1KZ1LsTbpti/rJLv9U028M77UU3Fd
         UZdeqxKC2BPBdk0t83SUmQEv1XDLiLjZt6Ub+AzsLEK2w2RbVx6yL8youAZRzQeEED/v
         wYeUTfwlbdShLSJ8v6jRPwldxXxVJboXOyPPOIXcLo3/tem+b7froAB59XatronMjO3q
         QnIi5QOR1Oc8E4PVWyoO67Sj7n/7M0z8JVoPG/eMgmr29X/jdgjZOTX/0D55PC3U61Wm
         DeGUFrQ41egmxWtk03q8vUY6ke4u7ZXsu/OPPjGxRpVLgjRicDQzZvpBdu9Bgg6hM4i8
         5ePA==
X-Forwarded-Encrypted: i=1; AJvYcCW6fB4XhHlbXOX4Y0biTfIaQNnkqN9pP4b4mT6qa88CN68lDCPNP3ig7Wzf7eeLQRrXNct77MPHn9T15MYoo+fTNIP3I74LogWn+TqFJ34Pl1rZdoE4ERE+LmOiuNkWvd3NnAJTdN3JYmkHh2iQYa0BaWr7DpHBOVfSuL0owF2QT1MmXJnu
X-Gm-Message-State: AOJu0YwEzjm7hQ39uZMFY7z4Os+Dy58nGNSB7s8ci83P7tidwWsGmiPv
	wCwLMt8Xo9eSto+8JYc8qQttSQykfvM8fdxHx4bakRt0xd9xNkJw
X-Google-Smtp-Source: AGHT+IFec9LhQrJOlj2nALndRcAivlO3EuFeqAAByT82C0H9OIaqHaHAE4atmH9C7Vi8KJkfCKAFUg==
X-Received: by 2002:a17:907:7dac:b0:a7a:a3f7:389f with SMTP id a640c23a62f3a-a80aa676a00mr492655066b.66.1723422279956;
        Sun, 11 Aug 2024 17:24:39 -0700 (PDT)
Received: from localhost (dh207-40-227.xnet.hr. [88.207.40.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb213138sm183990266b.181.2024.08.11.17.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:24:39 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH v1 1/1] selftests: net: af_unix: cast void* to char* in call to macro TH_LOG()
Date: Mon, 12 Aug 2024 02:22:58 +0200
Message-ID: <20240812002257.23447-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 reported warning about (void *) beeing used as a param where (char *) is expected:

In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:
../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
							but argument 6 has type ‘const void *’ [-Wformat=]
  106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
      |                                        ^~~~~~~~~~~~~
../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
  101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
      |                 ^~~~~~~~
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
  235 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
      |                 ^~~~~~
../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
							but argument 6 has type ‘const void *’ [-Wformat=]
  106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
      |                                        ^~~~~~~~~~~~~
../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
  101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
      |                 ^~~~~~~~
msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
  259 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
      |                 ^~~~~~

Casting param to (char *) silences the warning.

Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
v1:
 initial version to fix the compiler warning.

 tools/testing/selftests/net/af_unix/msg_oob.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..ae2623eea8ae 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -232,7 +232,7 @@ static void __recvpair(struct __test_metadata *_metadata,
 
 	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
 		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : (char *)expected_buf);
 
 		ASSERT_EQ(ret[0], expected_len);
 		ASSERT_EQ(recv_errno[0], expected_errno);
@@ -256,7 +256,7 @@ static void __recvpair(struct __test_metadata *_metadata,
 		cmp = strncmp(expected_buf, recv_buf[0], expected_len);
 		if (cmp) {
 			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : (char *)expected_buf);
 
 			ASSERT_EQ(cmp, 0);
 		}
-- 
2.43.0


