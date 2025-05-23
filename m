Return-Path: <linux-kselftest+bounces-33695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFBAC2C0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763E9175F6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE522577D;
	Fri, 23 May 2025 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6iUBZ+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D51215789
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041545; cv=none; b=D3WcGC/bFUZpp/vjPtYLfO4yxrA9hEz/tG5ypMcybQDdq+vMQNl+czB4q3ADULgliD09qnhBpdBE1jdvrFrPvRQdOB8kIwY/CFzh7tIKmIVKYhdXh3BmFohZQMT/Rk15A+YnZdxiWO2CUhAem7mdgtfcR3LvnBI8o0XgXPhLgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041545; c=relaxed/simple;
	bh=0JqtZHm1FjwTp/r9FfFXp2DhxiRW0Bdbv5viNa2gMfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eeblFjHbUCy9Vvq3matxLPqBZ105Tm5TqnAP5U9io6FTlpH4la9jic4LRVo0wfSvpmNRY2gNE5jInGjRDhz0dMNh3wxS81+3eMfBsIy0eW/BespXao2vuAt7fDgJoHdj8cbGWU0pO/vJAWg+DS6mGKZVDLmzmXLnb1y1NOj+vrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6iUBZ+9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-232054aa634so2861695ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041542; x=1748646342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9027k/STZBsLuLsL7i9IP6pBTVAG0SO2AdEyoxFagU=;
        b=R6iUBZ+9HVQ0voT5m+RPF6iohB8uARMGrHOt/QAtNhActs24wu0LUZpv9rmD9UQPKA
         7yYVB/6ZynPCnYCMgYYLn7Xzb3f30iagRVmduoJ/cbrN1WfKN6CkmHINV1xcKHUGHUox
         HBVz2TmIHqHoxG+JSj+2OjffHWR/6+UjiYQBBuQ8wsQEXGPQ4tMjaGP3Gj87Fy0P+its
         okRYfbq0gQwBQGOd2rlYAORqCZ2N0mphubNEDbvd+q4ILWY2+28rW6kBOMMWlFAfo/vi
         B+rahlr0S9MvwlbDetoKWBFcCIX3X191jA+N7EFGLwDkhVO/pYUi6lRRcSH+MT65me9b
         BFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041542; x=1748646342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9027k/STZBsLuLsL7i9IP6pBTVAG0SO2AdEyoxFagU=;
        b=AMufIqYFdUc7z5Oih5G6nos9obCmO3g3VyK1vra1CL9212Hkq9NQ4kaebgLQDcc0cb
         k+/KL3eawlRUnwO+OHzlDYbChxc25VT3kJq084C8H6KymTPd2Q2+g/yV5nnVx1MB7JhH
         zbWOzOZEAj4jkqaYA9ZXKgmvJeadOLhy1301iUZd0JZ58eoMRqykQJGfp+yR/cfL+vz8
         ZNYKJyfKtiGchlFlPm2RRmeFrMd8Mh1AmWZ9SGvbBHJpdmLZGfpXXB+d2uMydD7BUltd
         Ncxr3BM82F6NQwdcLLygOWeCq4uD9L/BwX0agmcqJ9nKZwgw5wy00AhEVG3a2geEh/+/
         Olhw==
X-Forwarded-Encrypted: i=1; AJvYcCUOv7iYen8EuOjxO/YqliogB2ZxNCHcrRcwsneag8Z0hB0iq+nqMzEuhv67qgGzC69h1U9P1r7Ti/wEcEZ4uo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRp3zXrz9GteuEYwLJ/rrZ6mEO7dTsHq4uqKVbqjwdxAILsIln
	p4eU2WDvKoShbA2z4shdxvcthVIfmWNABtdTvJWm4nMBo8d5N108uPobKO/d2+/08sczr3QgjfD
	2mtF3Pv8RS38rGO8bLAa7csfluQ==
X-Google-Smtp-Source: AGHT+IHn8TkCdj+ni+aC/DsrAqi9Ur2+n79I6LNfYvaRRRjb46r0pJxbHJPzmzbCwlmXoCzWPkQvZhUhuI8g+DiH4A==
X-Received: from plbms3.prod.google.com ([2002:a17:903:ac3:b0:223:294f:455a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:224:2175:b0cd with SMTP id d9443c01a7336-23414f689ddmr16906845ad.26.1748041542350;
 Fri, 23 May 2025 16:05:42 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:24 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-9-almasrymina@google.com>
Subject: [PATCH net-next v2 8/8] net: devmem: ncdevmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

This variable is unused and can be removed.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3c7529de8d48..03f0498cdffb 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -537,7 +537,6 @@ static struct netdev_queue_id *create_queues(void)
 static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
-	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
 	struct sockaddr_in6 server_sin;
-- 
2.49.0.1151.ga128411c76-goog


