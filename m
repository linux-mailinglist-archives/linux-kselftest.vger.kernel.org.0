Return-Path: <linux-kselftest+bounces-14048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63FB93996D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79E61C21A59
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A2D13CFB7;
	Tue, 23 Jul 2024 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrB/Q9jf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B413C8F6;
	Tue, 23 Jul 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714156; cv=none; b=bR4O8U6IN58f96kOCa0J7ea+HtBExeqs4eXfQbk4FZXZgzy8ZTGHZoT6IWgMUZ2KbEPyNPjU9Y1Qy4VnjqUnq7SkSnHdB8h1KPufTD07zopL1HKeqZwbB8E+OfouobBF9yz0LXvv9j7Tfk9nQBGInQsGZAJQxRNv8GHGPsM79ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714156; c=relaxed/simple;
	bh=AVopjLmg6SFu1C1uyPpuLBVbYdpr2fMsys/diN35S9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFinMca1+K50H6in4tNLz6cR0vohvKwJMv360DJLcHLUwGz7rWJxLUxCQj3cesJuAXQna/pO9HRS4Ag5COM+6geKNy8s0uMd9neY9uSNxOoBIdIMTi40c9Ouyo7RudlF3AmZD2OZLxFYcIrLqXkKEeE6DZTCtAQiVZuGVtSMS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrB/Q9jf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc4fcbb131so2197015ad.3;
        Mon, 22 Jul 2024 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714154; x=1722318954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hDw5eZyspSOvFS9xX81x6DvU6zOqkobsTxzJs34nkg=;
        b=OrB/Q9jfPixgTR6PZwmg4HTwS74eFY3+HXE+O71PCXI7SLun6Qffv4OVfifUAtWvjQ
         +xGXIBx3RXlrP/ZyOKfpxv3519Go2gAuPNnYy8mNDgRMReYeAjNTf+Jg/zZqw8PgxJlu
         /my6v6HX9b46ubCtO3EYF40Az4Gb/VtXkEtwkAgiyfcEbuztHM01D1eD26Mnkszc4aTn
         Gcv/cr41g6PVAwML4Da0kgJo7GhKBVDxGMCffJSeApB5mmi3m0g6v/NFXlfzl1n+7do4
         Cyesqvb7kWsX0QUttu5C01vlijHUH5Czgkn6+W7i2e4ub9mqTqxkHdnJMZ1V8x7+vSQG
         n/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714154; x=1722318954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hDw5eZyspSOvFS9xX81x6DvU6zOqkobsTxzJs34nkg=;
        b=fWXDqwkdaxOQAz4kYJIqcfW+tRR04qqXSThYbudZ6JAY8TbKFwUWHTtA5v/T1/v6Y5
         /y60hKTwTmO/89RCjEIHnxUpFSyj98e/meDH4mpgTc1vLyefmaD2y9MuQTWtLERhZi1H
         mtSzfMRyBqmhUG1p2JROrwpbWy0s79eo3iyAuU9iO6x0wPgz3BrFiFXJMX1wWRZDqvdi
         fyXkTn9BrU2TPDM07uK0HQ+W0Jx9gQSQjOYR5jknPPXBPRsMFrCVY3LkemvgN2TBAPU9
         RusUoUBuCrTQVvzw9hsU7yvejLOXXRQ8NUa5BuSkI31Pvj6sBq+6TkjlzL4UsSsVLIAu
         soTg==
X-Forwarded-Encrypted: i=1; AJvYcCWtLmvvm2V7BX0MIGj/6tRsX5bqbjbv0cT/xcki5uPvtFUn/jnzDgbQoHH7Vvm/ubiYLBhEzSebJHOb8/2iCbPDWs+CslmYLhvPtBQfjWXl
X-Gm-Message-State: AOJu0Yw/0cyFde2ulyCeviUPUqWsQVAg+oUpt8Fw6T/8y0cU3kyXw5VJ
	zC7ALAs3uPPsH1uqN66bVbpdbF5brpGnQIQJQQTNRJ6x5JG2iLyucWaoLyCS
X-Google-Smtp-Source: AGHT+IFHgFZ8QWn6QLe64h/dTxnRj2NJ+FoDrX6dtBeiZ+tL/jVib6uKXF8AyRVQ94hktCP/lbRapA==
X-Received: by 2002:a17:902:d48f:b0:1f7:3a4:f66f with SMTP id d9443c01a7336-1fd7462125cmr106491395ad.43.1721714154062;
        Mon, 22 Jul 2024 22:55:54 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 11/19] selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
Date: Mon, 22 Jul 2024 22:54:38 -0700
Message-Id: <ac5440213c242c62cb4e0d9e0a9cd5058b6a31f6.1721713597.git.tony.ambardar@gmail.com>
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

The GNU version of 'struct tcphdr', with members 'doff' and 'urg_ptr', is
not exposed by musl headers unless _GNU_SOURCE is defined.

Add this definition to fix errors seen compiling for mips64el/musl-libc:

  parse_tcp_hdr_opt.c:18:21: error: 'struct tcphdr' has no member named 'urg_ptr'
     18 |         .pk6_v6.tcp.urg_ptr = 123,
        |                     ^~~~~~~
  parse_tcp_hdr_opt.c:19:21: error: 'struct tcphdr' has no member named 'doff'
     19 |         .pk6_v6.tcp.doff = 9, /* 16 bytes of options */
        |                     ^~~~

Fixes: cfa7b011894d ("selftests/bpf: tests for using dynptrs to parse skb and xdp buffers")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
index daa952711d8f..e9c07d561ded 100644
--- a/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "test_parse_tcp_hdr_opt.skel.h"
-- 
2.34.1


