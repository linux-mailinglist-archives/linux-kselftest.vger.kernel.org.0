Return-Path: <linux-kselftest+bounces-46528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CFC8AF95
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6693AA5E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0133C509;
	Wed, 26 Nov 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYRVTlmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152630E0D2
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174669; cv=none; b=VjQyRmZADU2Wf8WyMqppndMkZy7YF4jmkfRZpYyYzMEaNyMkoHU5sCtZ1oVS1Fu9+F1d5IhWlIGmAwy4zu4tYPw4JSwtW1SyGFBKTfxSJGUSChlzaQ9y3/aEb/jeIoultzr+QhRh3IhUKTXxVguPL0U31ds7qkykPdwLUXr2xaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174669; c=relaxed/simple;
	bh=JUk+V7+BC+lkMoAifGFTRedw6UOHlW97lAtjujuGo3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZm/Qg+UkFOnmtDi4xPwHhV767aUD2uTfGJQSbYShpc8sPdrpxuO4LHTG0HdDJmjQppq6hSQDX9mQd3lA6msjvj6RHB33Lat28BJ67S8N/L5m5wMuKVpV9Lw0rdbi64K8lOl4ATxkr1Gclbzpop0RFKEytUFudupkI7FZjeUMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYRVTlmj; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297dd95ffe4so62492675ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174667; x=1764779467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=YYRVTlmj0WXe0OGg28gHJOU4bizezja97OUEzQhNLpXNw7cgAgE4vYJMQWIjf7aQbW
         VdpL8H5gzGbdl6EgBjeOUIYBOREIyPGIU8ZAsLF/hbX9imTNo56Bd0Janql+aNU0zhKT
         1QcanX8GYxbQAunEcRNncralrW9EZdNYfuQmrcZX95jQP4EamSGlN7Ux3HddDa2wC4AL
         xn1950uATu/77O4fbjFHGrQ50RrWiTuGpD8yM+BLuf5Wi64/IOFQiIdwRYb4xQ0pEwvt
         QFH7aQaTGkp+OOv3J75B2AOMvZMiMDIODQ3ZNLbsQtoY9obpQxnV/ypd8d9EnmsarEk0
         LIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174667; x=1764779467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=BEgkR8nzXr7bVsnjzF4d5dAytD7fxxvzmcWmji7bJ3X05gpqbVQWy1L47H6GFCQfPu
         g0o6VqkyX83X6Ik7+dJcsiaMzyWd7/QnUY7CFaQBRp0GhL7LN6/i5BopW4iP2hZGSwLM
         vIfUpmm8d8f45EfBTA/vregmJmQw4vewdJYUgWniSXDS8EO5pkSNc9G90W+IVzFr9Zay
         sQtBVAbm26+f3WbRl5QyMk5jPot3Sn8Z2iV/dajYnWblfb+sdUMyaEbCQDP96WhW+gP2
         me6ahYNxfzBYuBGDWIVgXyvu48RjRlBB/O6uM6tVP4Jk5qseWllQdrCddr6HGcqiKObc
         l0EA==
X-Forwarded-Encrypted: i=1; AJvYcCWYRYtGZqlgVtUqRHWOGKmNNAOyYe29+3ysxVvVLV/SzxLXKcN4y1PyT+81sgLZiAEbFd5qc3E8XdGxEmQghrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9n6cU8t/M4O/oiHGgZ84rT3OIMzMz6hGLC3oIsxw+rLeGzSc
	HZznkPsOAF77yQZOdR7BSbwAssN90qUPgaePBaldqcIVBUe7bD2Uqe9R
X-Gm-Gg: ASbGncvQqk1eZVEUmqY50qTxi8nlWXmxAFQkgvrRfqeNYgzpPn1DIJnGbzJR7cZIg9A
	XU7pPwwuXUwQ8Z7//UoYBJzbQWLDks/mQ5HS6LJkDK1vZsX0G//P5FNW9hbmUjzkFyOXq2j4Fb9
	EIp7KC/lfiPhoqPk7owadypep6FvStD+838BGaH5AfRavqjg6UDoRZ9+x3fDC/PhbJUkrPvErKC
	rAsYxptPY+3e9BeRGsWbQONlKo13qaTQRUMjMtuTBSDTcQfe8DgoXV62yztD5cKxTbdoz91u7ec
	1N25ordEBnrHqnOvVGO4UgBDwzjPzEsIFepT5QrS/6iTgmUTEqmAkBYIeqzz8B/qxNARdmcEPq0
	INZd0kaKpUNfoSXYks7C6iysW6gw/oOJTcByIMaRqZfEcPKXKW5KRGQUNnfAoDXNUz44j5Wc7jX
	qpSFvLtzPqWBIrHGyENMLGXY/NRd/PzA==
X-Google-Smtp-Source: AGHT+IHYlOs7ib3WRoxz+IosxSmgFDE9P7H1+e8rCoPRGJ8hqrHc7dD/TBxgldig3bre3IVxR56yzg==
X-Received: by 2002:a17:90b:2247:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-3475ed5141bmr7678530a91.17.1764174666979;
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm19829401a12.31.2025.11.26.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests: mptcp: initialize raw_addr to Null
Date: Wed, 26 Nov 2025 22:00:46 +0530
Message-ID: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "void *raw_addr" is left uninitialized when else path is
followed raising below warning.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

so the fix is to assign *raw_addr to NULL to suppress the warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).
compilation cmd used:
	make -C tools/testing/selftests/net/mptcp CC=clang V=1 -j8

this maybe also be false positive. But somehow clang - 21.1.5
triggering this.

---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..cdb81e0d08ad 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,8 +1248,8 @@ void xdisconnect(int fd)
 {
 	socklen_t addrlen = sizeof(struct sockaddr_storage);
 	struct sockaddr_storage addr, empty;
+	void *raw_addr = NULL;
 	int msec_sleep = 10;
-	void *raw_addr;
 	int i, cmdlen;
 	char cmd[128];

--
2.52.0


