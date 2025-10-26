Return-Path: <linux-kselftest+bounces-44075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC9C0AF6B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C0E1899F72
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3823EAB6;
	Sun, 26 Oct 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV0C/Lji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505721A436
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500829; cv=none; b=rbuHMT9h5Aeo/tV/965ieG0GNjI9+JzFN4ce2cf7GfrypLBSoUqMSqg4TDxZm71lkkiZE7O4UWpl14wtNUP1gB44WuBP2Vzud7u5mr0s9s2hXfISgsZu8fXna72AaC2ZigGNx+23heJTaHX6SWj8dEWTqba2puTcMAxnOzP6mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500829; c=relaxed/simple;
	bh=a+5TfOJqZaa7uINUuLkBAnYsuEfoCPkWzUliS6FwM7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYx/ZGTkGHfzMqKQYGchtyPZbJAEmXWf27cjNl4sYOB116o54HAlr2QcF6EEB6XkodThf+fyfStIB74NE3uilG7y4tdRP+oqRE5bAn9eM6nTtsTdHPldUXbbiHMjm2CbO3bqt4PUw6fbHnCQav/NSom4pCUS7a8a8sl4NB5fcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV0C/Lji; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4978940a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761500827; x=1762105627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=KV0C/LjiZP6gTyvZ+exzxXK9vCzPEreIHAyBr+17kfxupcEcFvP7xRof15hazqiaLU
         ZtIAGM0Op+fO24lNEMrNfbx/yo3MOqRhVbOqsB84YVZJeS4i7VcLlvrCF7qepThcxLhC
         jKBIMbsogONHJaY9qveUTIPplz1NTdOeXAXeSwziely8wVaN2rQCwZ5PRTRPIErEUaXf
         NmJ89+Aw7sOfhIGTQp11Cb+EOfcUOlCB9CthIAvs1jLR7k0LZHlrAM/O8WPZ9FZUIHjw
         L2MEV8sBkzeoEfPnvUwfjjB7ZVc7dj5Oe6LFkbdz6ZrfZZjgjkKGqZNSuHsXlUn7Foh3
         JHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500827; x=1762105627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=uaBHpNY1+lLvduy5qVmd2Eu7XYUq31zsXnyhWVcGYrvFqxsjRJz0hYRpV+Ex1ZuVuL
         czQKW6p2Cuoqft/d+0haWXNQXh/CvmJjWQirXa6ubDiRIQDu/gfLZGJCs1dLuusnCWRf
         RcYGaUkdGlWZLnuYNNe8QlbwM7ZXurA32NPYjOWFB7inp+po0k10W7J7ut9Pc7CrVxKq
         iEbOhSoYI1YzJelRSACoVrFOekp6GvIUU/gHDdQCJSzNmUFcsBnIGA3zgUTZxw56l6hK
         Pis0EWGnfcDmbgTKpSAm3PRK6d/gotEgbROMq+suKUElGuppUzWtTnppFkxj+KcKgOYM
         UXFw==
X-Forwarded-Encrypted: i=1; AJvYcCVkYVdhcznfJ0xR+ELrWNuUcTX2HhmTaumuqJ2/hgQR/xNXHAzcLbj4qfijjxoEPTcvL8BCyNn1MxhntZLFPPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhq8j/SMeKVICD8mGX8Gksfm9kcXorVHcChDRk/6AHy28Fnlos
	W/eusQgraslQlSD22bEIPtiTRCj2iOp8Q6iDNE1GeE4RrZgonjkA83hM
X-Gm-Gg: ASbGncuJQCRwbrB99F/GBh9OerWPHp2Mio4lniEkzxDJ69I1AWA6+y6nX+q9xNq+NiJ
	vVkKtn3Ck+LCTHrKWBUPyBpvTwlSK6KpTgeMID7Xoj9Nt+H30u/SoRQFfLxY1uCI3zts0Qb2R8g
	jz9HoKQSwsqSXdwpmmtYTKqTweOHntR1hidep7ZNaF7K/mMih3KJ9dzq2V8OmWoVK6f2yihjFX9
	dbX0pmz7UWwISnZNdlORNmIfkWBB9SDhqip+tPUjlkD2WfD/sobLFHdlNZNEbROJPH+6VcKAVV1
	AuG7pz9BvYeYLRfu5jLciCkyuBoDksnnJd9O6+pJ+rVvzWWW0/zhGPPk8bNNmOy7sxOMthosNY4
	6Dn5dzHVy05bRfxn1GvK2nzKUy6gs1qW7YDMlT7N7G0pYeXfB+4Qw+UCwRpmGCEXTcifpI2ce5+
	xI99ZhlypeZzZE58hwZTnQYYJCyL+VmQ==
X-Google-Smtp-Source: AGHT+IGwYCSe19Ty4P2Kg68LQK9vteTSxPeeGBo2iswWXXEumD1EpQASl9RMMGaFry0bwrT+Y8+yLw==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr503829555ad.47.1761500827212;
        Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09855sm55131445ad.30.2025.10.26.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:47:06 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Sun, 26 Oct 2025 23:16:49 +0530
Message-ID: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	int sd, ret;
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
 
-- 
2.51.0


