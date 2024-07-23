Return-Path: <linux-kselftest+bounces-14052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A378939975
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA26F281F63
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8313D521;
	Tue, 23 Jul 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBvXf343"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842513D538;
	Tue, 23 Jul 2024 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714164; cv=none; b=sI+v1S9fzf6pvdvQ6ni9bWX+QiXXKgZl0BN19Xh0+dwya86NbgjZtnIuoyUDpP8xS+Lc/KXi1mA98fnD6yDXKQKCp00mscs0jAqcBqIOwV84JzPJbGoi0ioMQqzPRyPrMD04JLGGyTT3SKOE76GaWQhvXys8Ov/SbrUCBAfty5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714164; c=relaxed/simple;
	bh=PEm7/5+4mqPKqerOKkFbUuEAWS2RUAn2jW2HlBO/l8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMFI6pCnQITSLEl4xuB0ohOyIw5icsTEiJUUKXEYWA1Z5ENFOMPD4oXHL3K6O4xy+/TKkAigc0k23FdnImNX3wiWFq7aEDrkD1yQ8Eloym4BuZyx/TTnXaC3eO8sZXNsKixFlnBwO+54fBKeSFm1bRlImbb1QI88zMkBld0Xxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBvXf343; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso1641535ad.2;
        Mon, 22 Jul 2024 22:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714162; x=1722318962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enQn2il/q/jEk1kd4P2wJtha1mIWED0XiYGsCh0GBbw=;
        b=FBvXf343V12BTONXQTf1Svumoy8JE3yFJ05vaefFenke7mNlr96EwuUR9m6pbQWEUs
         zD1Y8+HaIy/eVXskBa39ybvp/kqZVXk52o0dwp4G0V6Aof+PZDYGmDdPZh6LALARAq95
         zybreqJptgWHCOxg/Tt6u+gD8KciuUVv0KULX1q596k52L9ShZQfS6Y04APCZrJIzK1o
         WyiD8TFQ3Fy4AXr2ySUpVx7knDD0zfCNaVhqLp6l6FeLgZNR6w4xx3gDe9Y4/AsSuWch
         an1JEl/UlEPiX4063lltnoKCSET5jvaWbzSNJtL+CkB2LJurIl1gXMI2EVdV+korNG6H
         g2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714162; x=1722318962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enQn2il/q/jEk1kd4P2wJtha1mIWED0XiYGsCh0GBbw=;
        b=BW9YJs1dGAT53w0N+pbrAU75LMTDWejAtzZ2vjcu3XQYHRcjjDsvrReek7N1ubW3R2
         q7e6dYo1p/tyiGozMnSuTpSkykBoZ1zQt1DrAevhjD/Cf4dFeQSXhJY/7SaABDgfl6TK
         IJn3F8qoAM3q623JWGn0V9H5ZBLnG2eunvd5t8evLsJH9LyMRtb72Qv4xPjmS9/4m0N3
         td7OunpKBBdJTDqzz7hioMzN3WjtDSGa2SIPymPlRL7QYGxYMjN6lwZqVwj5Kg7T+nHn
         4HpZnbS52At9SaPUOMab9+uI5ZXDdJp9RCcOFiWe4canWhdKgNBi65RrPfN/Ig+0KJTz
         gvGw==
X-Forwarded-Encrypted: i=1; AJvYcCUCeoKVT7+96zHodsYFbGEiq5TrbTSv2uC8U/j8HcbhN36y+SajlsxUapDhdFnZRGdIoPY2y4vt1QXfEGWjzD32joHzm8+PAVeTHO+s2wrF
X-Gm-Message-State: AOJu0YwUoEEOVnPd4Rv0plmnFuCY0cZ2th/EkiAl69MIBqpne+u+P3HE
	KDg9fre763QTO8yms9q130uN9EzVwHL5iyc1T43KGQx2EjVnkm8XcVgC1Kda
X-Google-Smtp-Source: AGHT+IFkt6KxaWnQEzpKj1LsldI+1aAW9WIGIWZth1nj7k40+kpKUYibE7dYdXKTHUmq0E06BXSB1g==
X-Received: by 2002:a17:902:d48f:b0:1fb:3b89:b130 with SMTP id d9443c01a7336-1fd74552854mr91174305ad.19.1721714162524;
        Mon, 22 Jul 2024 22:56:02 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:56:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 15/19] selftests/bpf: Fix compiling core_reloc.c with musl-libc
Date: Mon, 22 Jul 2024 22:54:42 -0700
Message-Id: <11c3af75a7eb6bcb7ad9acfae6a6f470c572eb82.1721713597.git.tony.ambardar@gmail.com>
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

The type 'loff_t' is a GNU extension and not exposed by the musl 'fcntl.h'
header unless _GNU_SOURCE is defined. Add this definition to fix errors
seen compiling for mips64el/musl-libc:

  In file included from tools/testing/selftests/bpf/prog_tests/core_reloc.c:4:
  ./bpf_testmod/bpf_testmod.h:10:9: error: unknown type name 'loff_t'
     10 |         loff_t off;
        |         ^~~~~~
  ./bpf_testmod/bpf_testmod.h:16:9: error: unknown type name 'loff_t'
     16 |         loff_t off;
        |         ^~~~~~

Fixes: 6bcd39d366b6 ("selftests/bpf: Add CO-RE relocs selftest relying on kernel module BTF")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 47f42e680105..26019313e1fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include "progs/core_reloc_types.h"
 #include "bpf_testmod/bpf_testmod.h"
-- 
2.34.1


