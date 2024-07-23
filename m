Return-Path: <linux-kselftest+bounces-14055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425D93997B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752D01C21A44
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8313DDC6;
	Tue, 23 Jul 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Ir9Ish"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CB13DDA7;
	Tue, 23 Jul 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714171; cv=none; b=b3nBaBXwS8wsMFAU3Himebn630wGiAWriviRDy0MRKHlTZYkv/aa0HFLgJEyHC5vlk3Bp91+JmkzTlMlPu3dy2SwWKXaG2wnumtfKugxcBWdup4PO0uI+OemGqxaStGLpYC/LCLEAL1uccpINfR5X6nV7H60si+0qHYx/0sd9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714171; c=relaxed/simple;
	bh=WBsVU5zJpQlgvjybeJEYrGnhmGHPlAyn499bj+m9Ha0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYuI7oz/snAl5IqaS0rxw5Y/oKh3swJMjysE1+X9MoNMAKoEMkgE31RhE2iKKCRlouX3JC+v3f3OGDs6ai6INC1R3y/MmOclC7+G1WCD19vk/tWaYMPH1GPsljUhioei9/4j0HuSbGMS9JXDn5NHsZ0rWpKGkWapkJNksi390HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Ir9Ish; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc569440e1so3180115ad.3;
        Mon, 22 Jul 2024 22:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714169; x=1722318969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpPAliQNuZr1whRpDRhhXvNGzN+MtzAqRLS/eXyE1Xo=;
        b=S+Ir9IshfQT45rSVqciXVcmn5UMHYNfE2M6Fvlvfgs0BotTZudoJRnEY0zSeVwVYsV
         mvLy2daxU48/4TZfLR5gJFT/rj6HOOwuo7FKSRJX0ZnoFjwDt60H0MAI/kd6l2iESvEi
         pxO1JzHQwxXUrqZxDUIS4pkqRQ+syNKwRwViC2sSL5x5mk81VR2mGHcGa6bIYLrLlgbh
         FvPnj7RjjS5Scsyj7k+fmEJnzcLXXYVz4udrDdHlnCtckGuo8JsYY3PGcNRyZTWYStnP
         kQVZTpkIlQCEpUNa2GH/VF7i6aoXQdOCXSlDzVmpT/c6zCrPzN2NiBe/A49qfFtTYPmr
         JOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714169; x=1722318969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpPAliQNuZr1whRpDRhhXvNGzN+MtzAqRLS/eXyE1Xo=;
        b=gAxZKRFQ1n8zWBHlbhySp5gBLHLwW+L8o9QhAQ+pAF6VLlXmJsxJexXiRIJrxLshq1
         xMlj4zA3ZxULlWvJeygYUg3RvuaTywZWE5IFsaOYAjbnVdBYomTJCQPKvsLUZvaqSxO3
         R00j7vqrDjGjHa/zgfW0lDc+TZcUZqZ0wfM0YwdvOVaTppH+PSBEryrKz5iQv9CVExQu
         rKEhIWvMDKtNjLLxxiG97tOw7WwUPUKOZO9RuwDiaMnwKR23oP+Ulj08hsTZulOXzPsu
         /T//q7/VAOBzW0Bpozel3dJH8qnt6poCpE/WMjhQrdjyglLfA76T44psGMnoD05ASa1V
         sfyA==
X-Forwarded-Encrypted: i=1; AJvYcCU7qykYcEwEhWp7rH5yQQBWVFjMSK08eFhAkyofg5YAapad7SAqECC1i0F/Wm+LwA75vrVc97E9QRqgIbxRukmPLXKu+A+5MEuS9zu/qE2x
X-Gm-Message-State: AOJu0Yz0ykZwuu/FmvVoZrLGX0S/gQX+EX/20YDATFp7C9JBF1syd9Yx
	M9y3vVboTMIZD/X+OcH2lPkGmiFKDqrxpj1cyuwq1lF0XsgGNZHMhUKSYns7
X-Google-Smtp-Source: AGHT+IF9gLd25SGmUc4FjhG/nOQ4IRMZUktMmGUNeBrI95K/yTIJCzQ+KeSH1c6kWzJMTnYjlqn61Q==
X-Received: by 2002:a17:903:244a:b0:1fb:7b01:7980 with SMTP id d9443c01a7336-1fdb5e6bd61mr20796225ad.0.1721714169229;
        Mon, 22 Jul 2024 22:56:09 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:56:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 18/19] selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
Date: Mon, 22 Jul 2024 22:54:45 -0700
Message-Id: <911293968f424ad7b462d8805aeb3baee8f4985b.1721713597.git.tony.ambardar@gmail.com>
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

Remove a redundant include of '<linux/in6.h>', whose needed definitions are
already provided by 'test_progs.h'. This avoids errors seen compiling for
mips64el/musl-libc:

  In file included from .../arpa/inet.h:9,
                   from ./test_progs.h:17,
                   from prog_tests/crypto_sanity.c:10:
  .../netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
     23 | struct in6_addr {
        |        ^~~~~~~~
  In file included from crypto_sanity.c:7:
  .../linux/in6.h:33:8: note: originally defined here
     33 | struct in6_addr {
        |        ^~~~~~~~
  .../netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
     34 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../linux/in6.h:50:8: note: originally defined here
     50 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
     42 | struct ipv6_mreq {
        |        ^~~~~~~~~
  .../linux/in6.h:60:8: note: originally defined here
     60 | struct ipv6_mreq {
        |        ^~~~~~~~~

Fixes: 91541ab192fc ("selftests: bpf: crypto skcipher algo selftests")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index b1a3a49a822a..42bd07f7218d 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -4,7 +4,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#include <linux/in6.h>
 #include <linux/if_alg.h>
 
 #include "test_progs.h"
-- 
2.34.1


