Return-Path: <linux-kselftest+bounces-47097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F657CA8631
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78683018E39
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9233FE0A;
	Fri,  5 Dec 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEoTrk5M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA53314D3
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952384; cv=none; b=FMuCSr7vbLBtJM53LqetGzyMksYuaSu1MY+8OXQ/JcbsuyxFwvqr/CLvBlP8QsgFq/pmBBj7sEeU9RSXq/rx4Gh5EagjIlilVecP5LHRDNTQAgB8uA6GOJ3JTh2WWqUTxvr/zFFHaOi1MuT0rYe4uQBJbW0LS+pOo6y7CY7LdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952384; c=relaxed/simple;
	bh=eV3T/Q2J9myl0Knz5MJT/6uNc3o5E5HtielhDfYo9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlOGy56oQmnxmBIVizcOw9doSjG9aHNC060rQcDJEiBuhLgHybAUINoED/2uvrItmhQ8+LYJGRt6eg0ZR+uGa1weV1seyHusJkYzqWzQWOQdQPg6/h0woWjhUK1mx5N6OcIg0hXhny+L5a14X/chKR4K8Nis3kE6OVeSXJbMCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEoTrk5M; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-295548467c7so28431235ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 08:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764952378; x=1765557178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYkMGvBxjwu2a5BBmmqN8avtwEussKPMSW7WaC678gg=;
        b=kEoTrk5MMenybMI1Y48oRpdjS+peUj1gH4xKuRVl8ye6R3nt8AvsOeq0+W3FBSRx0Y
         bcVzB35PYG901NK/bL9TFsk0kSZYUZPMnHIMkzMQamOhwQ6+0lK/+zbKXI7ZGIr5wiZE
         JNdczhQsTuwpkoO/nTw2FbT89GyjERPZWLTykk7Y4o7vRF15Owns4M6zwbDqq+dMOF2P
         b9ZVNHSCPKkZF9wAjuMYiNBh8RHWK9UTFLU7tOYlPTAjdhOHBVs7xSejO07SjmdIpK8j
         AyDn2OWbfvWTLOW01vEdrP6GqFXNE1PAIzaaFUPEZvKDLuZJLsviuynmbkTHnHS0o4cg
         C4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952378; x=1765557178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYkMGvBxjwu2a5BBmmqN8avtwEussKPMSW7WaC678gg=;
        b=woCH0fpcY9YbC8ccsGHgP+zaQEg/N3Sjh8S0w8rrRqYtp+LLmS6OmYV9EZd1TIMRfr
         ml53u7U3j/reBCWJ2Tppx/KUMdSwFOIeNGEpKJq0CEF648zOYqSAtJXUrJHq6Z82tUxf
         Eln61hYVx+xLFmMeldIYCuNUidgu/ngdKdtfFcjkdwwj5I9fAcHMblrMb/fL0JtNH0Gy
         qRPWSiERzOP6+ceZ59GinAbKAGUMDPR6Q7oU0crPDtx9PltMXJbRQ3kO0d/rDkusDSPl
         +70eirUtN/S4hopOSzGF6ohvf6NGJWDiiErqsQ62RbEp7c7+Unr3WqPxZIFzeYMUrMFb
         eiFA==
X-Forwarded-Encrypted: i=1; AJvYcCXvuClgl3z+eQE9G/Qozkdw4XNkHXiaZ/8lFRBUZf/zRxlIqNiuyku8PdOOFM4+Q6PhSMiOHfKOxBjugukaCPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcqyYKr0I7mZfagu51UF1GgtgxDYN6QhXitm4Z+oh/hsP/b6l
	GlfPSgPlAdzRkFR1a5uMj63TviXwrgNXzNBtJm6zU5g4oim0yefIKp58
X-Gm-Gg: ASbGnctggAMgyiyFUxkD06x6HVbw5cWOWGFIX8G7hHbYQ2y6YaqTvoGbX0qOESQ48o4
	L3MW4IK7J6Ot2nK9nytZpaEEGYOx8Rb4YQfrmQphdR0FQ5z9B6lX/FvqQz/SfjRhjjyNe+QW1zd
	KWlhXngvb7JD828JbRXju09/PKrC3sxcQrUJvgTh0a7aUrt/V0rkt/k6fED+EQGhVzSUmYdRKV8
	JojDEYMRAUZr4rRwJsTbWm1n2YEQ6GrOzWRHIKFH0vcTFMQpm3w3JdIqyHv7aLJF8uTfNlwCIS9
	NouTZGsKimuEpAyIxBmcWkBBKme9Gzs2Vu9IeAVtHuPUt/KtWUoS19W5Op8fuU8xXh6EG67fGuP
	A4V/CE5O4KkzKVGn8z5XeYB+mJghNOG5jUblw7IxfSD4xAsrXJfYzLXlOFR/wbfAQfaowyNgwPP
	6jiYaiXRQo9QLcMqEMGdCwvZvdPrDkWQ==
X-Google-Smtp-Source: AGHT+IEJYajNpUZxFYn1PlaVbgGbaj56SMZuY1jHWuulkMOz8mEKtbb2jN+kTWCixJQMXWW/VhXsIA==
X-Received: by 2002:a17:902:d585:b0:297:c0f0:42a1 with SMTP id d9443c01a7336-29d6844f1d3mr110049625ad.44.1764952377960;
        Fri, 05 Dec 2025 08:32:57 -0800 (PST)
Received: from fedora ([117.205.73.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49c358sm53120755ad.5.2025.12.05.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:32:57 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net-next v2] selftests: tls: fix warning of uninitialized variable
Date: Fri,  5 Dec 2025 22:02:42 +0530
Message-ID: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'poll_partial_rec_async' a uninitialized char variable 'token' with
is used for write/read instruction to synchronize between threads
via a pipe.

tls.c:2833:26: warning: variable 'token' is uninitialized
      		   when passed as a const pointer argument

Initialize 'token' to '\0' to silence compiler warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).

changelog:
v2:
- update patch name and msg

v1: https://lore.kernel.org/all/20251129063726.31210-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a3ef4b57eb5f..a4d16a460fbe 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2786,10 +2786,10 @@ TEST_F(tls_err, epoll_partial_rec)
 TEST_F(tls_err, poll_partial_rec_async)
 {
 	struct pollfd pfd = { };
+	char token = '\0';
 	ssize_t rec_len;
 	char rec[256];
 	char buf[128];
-	char token;
 	int p[2];
 	int ret;

--
2.52.0


