Return-Path: <linux-kselftest+bounces-20472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3709ACF2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FA71C20312
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8E1CC150;
	Wed, 23 Oct 2024 15:44:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C951C830B;
	Wed, 23 Oct 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698249; cv=none; b=lUDLqDIDI0IdP/ZRQiKYg1V/MV1eYGEf00bJXESupLA/yppvmrFq8IMvij0zyZlXvCQI/yCQiyHk952H+SbU/UNVWL/9E4LIz9wZFnFMZxUc5KInp8ySNyARd0f8rgD5QB3fb0G/bcaMTJ+9vd5a3zJv6IHO5877L0WFCw/dqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698249; c=relaxed/simple;
	bh=OaE7XwAEFbIu+s9p7ZnqgQDlY0jv4o3kXb+oqYrd/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahac9Q8ByF3wJ0RJaUBYresVKbSznVfyUd59YBYTJW8ekbe5setgHyu2CXjGFrrbvAzFQs7S9U/6N3BGtKSCqiVXOa1H5vAisRB1tcOXFAOnFmbxJPhZ7zkFbnZYPt7Ry0wLgbHeeD3aUSoj2e4DigMx8wHDXUiy40yVlo+FVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca388d242so50731785ad.2;
        Wed, 23 Oct 2024 08:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698247; x=1730303047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJuaEXoxJxSHRZGvGUlWEOD0V27rFOSWO6abbhkkw/I=;
        b=lQKXJ4r9Ub4Rq+lKRNczOpWKetr36XrFDUwuyVIhMEb9Mi3DTbWe47qKqiqK1wa0Fk
         11f0uggHS5iJO4tE3kPspo6yaz7m5NQyIKYiZf8AOz2UldeldtIVDPRSYW/wORzlQ1pT
         CYWLRSnq4nYIGlqsE2F5B5c2gpFvzSsIdNpgylm1UhSjIEPQKWvEKbecUibEulEy+ItH
         X8demYg8J5amxViIBaqTW+zWkj2wBtYqvxW2xkRvjTz++YbhO6k96eoa5YMM2XDfVnhM
         qd4cssBuz6+U9tqmTG0mQLgAEjOvB2ohooB5ZAI0tn4GE4t6KCkUebuaAOna1rhsJXvm
         gQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy5lm7z49rMvme8VS/ypQx1eFpcRg8XKTmlylGBSMv/8v5f+lwjrjdLC5xl76zt+wBXuYdZ+1rGK+jFO64cTxP@vger.kernel.org, AJvYcCWWJiY17kgA49MNePuYajL4GqUcwWYm6tx10YuRntreEcRgqstThEHleKIhYnO+pO30nYYxB+6w7fbLjU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqLJRVcsqE6Z2i0rKlDV1MwhqzkcBJTIHwrB8vVUT9own2u4J
	KjV0PiqdqL2CVJ1T/GCQezdOK5FQUEq073+YUwXMgOx8ENncBK3zb0JHFxI=
X-Google-Smtp-Source: AGHT+IH2m0+GzmebnxYriEdM12PtEjZTpEDLdoCN3QSsSee+zEiHZfi3qJPnlduMMlvWCHdwLQKSoQ==
X-Received: by 2002:a17:902:ec82:b0:20c:8c0f:f986 with SMTP id d9443c01a7336-20fa9e5b449mr40058585ad.24.1729698246840;
        Wed, 23 Oct 2024 08:44:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9a7esm58947855ad.182.2024.10.23.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:06 -0700 (PDT)
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
Subject: [PATCH net-next v5 03/12] selftests: ncdevmem: Unify error handling
Date: Wed, 23 Oct 2024 08:43:53 -0700
Message-ID: <20241023154402.441510-4-sdf@fomichev.me>
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

There is a bunch of places where error() calls look out of place.
Use the same error(1, errno, ...) pattern everywhere.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 9b3ca6398a9d..07222bfcdb07 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -339,33 +339,33 @@ int do_server(struct memory_buffer *mem)
 	server_sin.sin_port = htons(atoi(port));
 
 	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (socket < 0)
-		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	if (ret < 0)
+		error(1, pton, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
-	if (socket < 0)
-		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	if (socket_fd < 0)
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
 
 	ret = listen(socket_fd, 1);
 	if (ret)
-		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
 
 	client_addr_len = sizeof(client_addr);
 
-- 
2.47.0


