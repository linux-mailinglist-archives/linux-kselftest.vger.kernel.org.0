Return-Path: <linux-kselftest+bounces-14040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18993995C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B671F22758
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE5513D282;
	Tue, 23 Jul 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN9Sli/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB39634;
	Tue, 23 Jul 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714134; cv=none; b=tUIWIJylfZEghILtgsLBkt4DbfZCq+DfximaCSl7sb8IO3WnJezYzm+kR4XldIZ5YE+G8a7ZpQ77VMGLcyIGW7n/7if1rpnNMNIbkFvXwdWQvVVsty6omU4Df7M2JMfTUTHaZ7ydOsHv7nYlLIICY39mmvn2h8ybYMmi4CPLqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714134; c=relaxed/simple;
	bh=4RFypAgwGmLTl4twjAhqkZ4m7+hePVxz52CGbCdNIfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/rwjQw4FZBjevGNX3XB8zd1FZbk00BwKuBQNQhQcy0227uACArmTYdvcZjxihqtL7JXXsz5zZD4KZJNzd3Rt/tsfja3r+GrojTXd+pPdO8PqXVpHTnjUG9EVP1SkxJ1zdi0CaZQTCFtPfji5pRxetWmspuqjkyZH2XEdv9xaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN9Sli/0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so38477955ad.2;
        Mon, 22 Jul 2024 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714132; x=1722318932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxK4doYdw1oB9sDNKsPLRlJ7hhIzVIy869hVVfkND8k=;
        b=lN9Sli/0Z2O6aDoeyL+0nra38Xs8N1gBzFVqrP2N00wwwy3Eg4I5rMXbXlX4QlFg7B
         4s5Hv+ZALJOupQNc/J6imC6J88wsCWP7EdNdEZ6BuWeTyXZLUf/mq0+RaBxpdSY0mEea
         Hqo+b5oDPGPGVFep9u0M715ygPjyAByVY2rwX9vOHpJ3XClAbHYzpdj5EMykO5ILmDt0
         sQnpeRhvMOp6z0aFLMKz0yxc72myaFCOyT3iHO5RJedW/6qu11O8p7er/WHeCd3JoJcI
         2lhivCDuV21yjWb/KzlHwgQEMBGA7dYp8iFDP/hVB/2hlr5PJ/9QWC7syKBg6S9m4jOB
         HMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714132; x=1722318932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxK4doYdw1oB9sDNKsPLRlJ7hhIzVIy869hVVfkND8k=;
        b=lZkqcbDubop0rhvBMcgL72A0Kf16O9qVVgiP15K6hxdNAZ/3pfhGk9Vuzhyql1xuG9
         UjC0ZONWkY91DYPmpSapS6CEbn+ma8A2ITFGRPpRIvO+CdrgVyRYwr78LN3p0ShlVkJV
         i9LnQon09gi8U3jlDXpIamDfCW81fzOSdIpKxDd0NVd58siNS/sepnlMNwZuRAOBN/4o
         RAYpSPxm1m6h86cICZvd234V5usCGPnUyMajpuY+Rd2kCX6R6WkPr7ixKsMjB6sNhbOh
         Gj4jTsMGOQ7YDdUpv5zw6+ealAI4kvtO7e3ealR3Rt92UM/CnGsi76GMlAItoa79qx97
         TXvg==
X-Forwarded-Encrypted: i=1; AJvYcCWExHHfsJcy+ffeC5wXZm6Pgg/6ZJGmoZjh7SVEuyG8WmWQbBAkCiS8dkhFFWC7r1DsBPDtzzdDXWtVlDQJwChLlJYnVqeGO3u2k+rGFn2X
X-Gm-Message-State: AOJu0YzQ6h1AcoEZTGxfKqUyLv1vGaQqqzi9WBU71Ld7+Os/yiCAiBuj
	JTkorAFPXLPfyj2mkqKA0/p9mDB9xj0Ce06UDiV7lE/ZOWZWS18MvkTp2TN2
X-Google-Smtp-Source: AGHT+IGHqVCuDbg5s7IOSYDT/FJ30sgl/Yqdr9L6/cQCoQMTT7eVGh24AnmW1A4012tgZPS/qgaxng==
X-Received: by 2002:a17:902:d2c6:b0:1fd:8f14:a109 with SMTP id d9443c01a7336-1fd8f14a474mr45905825ad.32.1721714131685;
        Mon, 22 Jul 2024 22:55:31 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:31 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 03/19] selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
Date: Mon, 22 Jul 2024 22:54:30 -0700
Message-Id: <f41def0f17b27a23b1709080e4e3f37f4cc11ca9.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing code calls getsockname() with a 'struct sockaddr_in6 *' argument
where a 'struct sockaddr *' argument is declared, yielding compile errors
when building for mips64el/musl-libc:

  bpf_iter_setsockopt.c: In function 'get_local_port':
  bpf_iter_setsockopt.c:98:30: error: passing argument 2 of 'getsockname' from incompatible pointer type [-Werror=incompatible-pointer-types]
     98 |         if (!getsockname(fd, &addr, &addrlen))
        |                              ^~~~~
        |                              |
        |                              struct sockaddr_in6 *
  In file included from .../netinet/in.h:10,
                   from .../arpa/inet.h:9,
                   from ./test_progs.h:17,
                   from bpf_iter_setsockopt.c:5:
  .../sys/socket.h:391:23: note: expected 'struct sockaddr * restrict' but argument is of type 'struct sockaddr_in6 *'
    391 | int getsockname (int, struct sockaddr *__restrict, socklen_t *__restrict);
        |                       ^
  cc1: all warnings being treated as errors

This compiled under glibc only because the argument is declared to be a
"funky" transparent union which includes both types above. Explicitly cast
the argument to allow compiling for both musl and glibc.

Fixes: eed92afdd14c ("bpf: selftest: Test batching and bpf_(get|set)sockopt in bpf tcp iter")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index b52ff8ce34db..35363b104dd2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -95,7 +95,7 @@ static unsigned short get_local_port(int fd)
 	struct sockaddr_in6 addr;
 	socklen_t addrlen = sizeof(addr);
 
-	if (!getsockname(fd, &addr, &addrlen))
+	if (!getsockname(fd, (struct sockaddr *) &addr, &addrlen))
 		return ntohs(addr.sin6_port);
 
 	return 0;
-- 
2.34.1


