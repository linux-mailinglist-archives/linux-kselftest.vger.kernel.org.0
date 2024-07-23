Return-Path: <linux-kselftest+bounces-14050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202B939971
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445F51C21AC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A8F13D510;
	Tue, 23 Jul 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX5LozTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89A13D51E;
	Tue, 23 Jul 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714160; cv=none; b=AckN2WuRIuV7bT8oNlvqLT3sGW5SvxZe/2pwgBPHQmsrdHFWUlwgpSTdzsQRBttPvUMPatEjjPgIYGFM9WdrCxoxIxsCT1QCX9KObL4unPmg57Sg3mIeqYjXKLR5oDrJKZTCUSUtdiW1GME6NmOxi1xEvm1NKsRSMMrsMqPOFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714160; c=relaxed/simple;
	bh=rzpAkWSl5AYTNo9BzM6c08+Hn9TZeOu3CEalFMyrm94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lblSWabmrhb3FnUViuQicvx+1CHDISH0QQFtSCT7ezIyST9NDc/cUdg/vRWJcrK0h1937tuDFLVBd0IkAABNrR4zs7YIA5yySb3+wyYE0b5UhJB1uG6FC7qhyBVp9uqbNWUzXb05V1kgh8y+1LGEHeEAQtVQHzvUfhRqDaUrUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX5LozTo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc52394c92so3331855ad.1;
        Mon, 22 Jul 2024 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714158; x=1722318958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLx6FsJEB2phPDA8VzOWtEpxZG5nvW0tizstBQr3l3g=;
        b=fX5LozToTVxmJrm+X3parRR3nVpJ/nNTQSshlLlTUnq1FQv6eKe8srfPpBKp2JV2B+
         RQYQu4hQrVdKtsekYg6dL6UO3g25zezdCjyhLLzzz0RHyMZt5dAzsupykFz3MamG/h1T
         So6/BdfCxH1ak0d614rR0kHW+x+7/eTlokJBe2/PkQ2AxSz5BsSWQtd6b8rL1J6yufWI
         h6QmDlmRdSTCxjSXPQ10Ax+S3/LDdgxoQPbrweurqj1j265AkxhcUdU17ZfHn/H2GvRQ
         wybZ2hJsk8DOIuTMFhuoWV6eTaowMPtHud6xN1FTvFuPOk8LeNIkyVvXNSulkIIM164n
         EynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714158; x=1722318958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLx6FsJEB2phPDA8VzOWtEpxZG5nvW0tizstBQr3l3g=;
        b=FsZOMf3v/JBbYacQJwE/vgUFEfDzAlG5o4FjIfB1/e//Xs1syPkLPaRHh457Insr+F
         ndTljRIKd4OIR/j0zb5vDP5Bv1u0Ove6lzjOyjGOSe6f2nsPtbAQ3AcByZ+2UvFoz7si
         Ai7iPxG8/YewsQh7Zt5WDoPof07xsikaZgZpGvn3iszFBRDLN2odPxkSJXvEjGSFHe3/
         G0Kz4S9TpFJ+STGccFFPq1h9dV8jgkl1dFYF37gsu0gfTxgj5jgLqMWqiuNNovcuqg1C
         KZC3uq8PXiGxOkKHTS21zCzkgO6OdHzwce8Ot9UhdDwuY/Vf9bdq5v55MRyVrANzWXlF
         VyFw==
X-Forwarded-Encrypted: i=1; AJvYcCUgcA+9hxWuJK23M2NiMMOMbTgGr8thta/3ji168TCAWpuOIt4kHLti9Ndu9xOOEUadA94yjc+AkCkUhddq6rCMaTrQXYSfKwoU9kR77hP5
X-Gm-Message-State: AOJu0YxB33KrTzzo+xizZdC0m5uGlgYuFZOHI1yxEB9jZ7zj5HMZ1nqR
	7JmfJHgRxYz6sLQ7u7e9kU5ab7yVSEwjm24O0dKeV8NUC7nE/F5EG0+JeQsw
X-Google-Smtp-Source: AGHT+IFnHSYRynMiH0QWiwfM5aMmqoo+7FoZwTUPCVdERQZfI6Kt9/c6GYPILiaefY9bCk/MIVKCNA==
X-Received: by 2002:a17:902:da91:b0:1fb:7e13:a7c5 with SMTP id d9443c01a7336-1fdb5feedfbmr13289915ad.45.1721714157916;
        Mon, 22 Jul 2024 22:55:57 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 13/19] selftests/bpf: Fix compiling flow_dissector.c with musl-libc
Date: Mon, 22 Jul 2024 22:54:40 -0700
Message-Id: <8f7ab21a73f678f9cebd32b26c444a686e57414d.1721713597.git.tony.ambardar@gmail.com>
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

The GNU version of 'struct tcphdr' has members 'doff', 'source' and 'dest',
which are not exposed by musl libc headers unless _GNU_SOURCE is defined.

Add this definition to fix errors seen compiling for mips64el/musl-libc:

  flow_dissector.c:118:30: error: 'struct tcphdr' has no member named 'doff'
    118 |                         .tcp.doff = 5,
        |                              ^~~~
  flow_dissector.c:119:30: error: 'struct tcphdr' has no member named 'source'
    119 |                         .tcp.source = 80,
        |                              ^~~~~~
  flow_dissector.c:120:30: error: 'struct tcphdr' has no member named 'dest'
    120 |                         .tcp.dest = 8080,
        |                              ^~~~

Fixes: ae173a915785 ("selftests/bpf: support BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 9625e6d21791..3171047414a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <linux/if_tun.h>
-- 
2.34.1


