Return-Path: <linux-kselftest+bounces-36100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF380AEDD9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB79C3A2384
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412B28937C;
	Mon, 30 Jun 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtPNBY6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F33235074;
	Mon, 30 Jun 2025 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288156; cv=none; b=rreUh1K3pDYZ/ZrxzoHQxueMBDO7I7rS1u2N3aJsYrGuJVESx9m4sp6l14UsfLJRwjADViDTXkhwDHesGHnkbLoyypKLSONLh+r5rh+CfKLsEDcVSiqaTW7pQpG2Bcmrxre0eyjQAgpIdwYMKCY0zj+/+jRX18c7wIKkdr84t7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288156; c=relaxed/simple;
	bh=bHZX5qUURlsW3IxRaCkLaJ2+tiqr+7lPA6WGkySRe1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/WZuf5SI2TvObemHrRKe5uIMFz30haSdC0kMKg/i2FzQBgOaKboZdp9+e7WoUfOsuUVmFNZV10guzZuRBCYIrVEo5jqPqOqAbSL4zdgAzRXRLufTBKI9eu1THbezqpAvCu++FDOP7zB/QcluwzDSF42eLQDwIgO5lbJWvMNCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtPNBY6w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45363645a8eso29984615e9.1;
        Mon, 30 Jun 2025 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751288153; x=1751892953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVSrYd0eHTox1L8UaY8v5yKbEudXIuXJECQmzXWMQ4w=;
        b=MtPNBY6wZh3X7JBQ+ZR8fAuISndIfFUX320WymL6MvDJ6S8MDFR8iAkdffNLDJu+j0
         811a9d+dm838CXs+AAsLoioIAQzcIrSHTPwQmNWXDefOSNcVn0t+KbbRcU8fXLO9HxEb
         2wBIokHba/M7CQAyhHFnjE82fHlwLqETWJeMimYr+WitE2l1LOW54QuCdA1P4gFyGfQN
         T/l+G5d90OITA5iDBs7GJdb8CWvkR7jE2Qepjpvn+SoDN4pCjC2VFoMnsvxxOMJQXA3D
         cCeJljuvfq/zx52gCPv+aDLnQFDbxQYvEfXo530Y1wMjReetC0+j/+v8xkNZDklR7iaZ
         njpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288153; x=1751892953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVSrYd0eHTox1L8UaY8v5yKbEudXIuXJECQmzXWMQ4w=;
        b=fauQK0scIYFBFAWXtzsRzJ+6JsoATw59phmdRDOxJ5etLloUT8mIVYsSkol3fetCBW
         O2IHIboIbYqiY6hOkEhBNsb6QGpUgbbzQhX/p4DycWncMJnChMvZiLyqc6YS9AWZgz4l
         7PNZpgQ3H1jxg8sTerC3OuiprEuhT39YXYQpc/1Halc7KvcREHFrsoFQxsJRaiE8/mYT
         2+lJ7HLxroNEWqPl3w1z+xARagO8R/4hkLeAP9ZXQo2ZroFKuSgv2r3bQsp0Fb47ibLK
         q2ceK0Lo2gJ7Pp+RBStf45n4We2SM8eSrH1DXX+rRMCz3AzwmqFv74c2Ve4mrHNi3wu0
         LiDA==
X-Forwarded-Encrypted: i=1; AJvYcCUmuTkJBK4U8SFZ9f3it6GF8+qhHaCiFVofkR8rR/pNPYnyjQ1OcgE0c6MlPsU2j2Xj/D6KAGXj5n9dpbRFlcvK@vger.kernel.org, AJvYcCXVy1Q2MAdh/LpLv+hSwy8qyiZA79UlanQwvnE6SgCT/JHmO7C/N8zBb5pcQYJenHhXQsA=@vger.kernel.org, AJvYcCXu+AVqLgK5Iqzo5fJvbIZbYN7FaMOi4OSJ71zM0rQjBCbVPeUpeTHqT4RqEMEeFRu7y9Y4SvRiSgYweY2N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YMHkE0nXLwbCkRVyyecikeLfxmYO33SUFweq1i+NiC5KFv0g
	HelTPfFeMxzhgRPTv1r522OUdN49tpqU6ScuKDr7c0cVHpUOL8z1p4jj
X-Gm-Gg: ASbGncu7WzQWc5sbOhuw+PeBxWj9GlCPnxGevAp+wr1UTSIz3Fp8IwhhIWYmViLFetu
	oR3FNNLRzKeh/t8LHbrbuB2OkOfHo0zUg11gXpIQjQW4p8hoAOmgZ9G9eTd8jZcp3adfS2jNVAJ
	TLbJ0l6lYKsEFjfL5dKgQp2TCbpbzKbZWTI4RtO4GMr1PdekfrxPT8Qul1raUbKkF0te1lkXRjQ
	ykpoq5UpOxPHoaLQrin2iKP42DwMDqN1DHFw87WOGlPHjJuT/sNsNzjzH827w6r6R31QlupXV7y
	MebqZXtob8foK9Z2kzONlJMj1A85GYmJBCQ6omW+WqGxodQM5MeSvExMpwoj
X-Google-Smtp-Source: AGHT+IFaYxlSF3efqtSuCLhqTE4oLLoRUny0RrlBdQ3yughk2Xn2MJDUHgEguqJrqhJQ9gZGcEIebA==
X-Received: by 2002:a05:600c:a11b:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-4538ee712f5mr108494835e9.30.1751288152509;
        Mon, 30 Jun 2025 05:55:52 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538234b1b9sm162196265e9.11.2025.06.30.05.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:55:51 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: Fix spelling mistake "subtration" -> "subtraction"
Date: Mon, 30 Jun 2025 13:55:28 +0100
Message-ID: <20250630125528.563077-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in description text. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index e52a24e15b34..6f986ae5085e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1474,7 +1474,7 @@ __naked void sub64_full_overflow(void)
 }
 
 SEC("socket")
-__description("64-bit subtration, partial overflow, result in unbounded reg")
+__description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
 __msg("3: (1f) r3 -= r2 {{.*}} R3_w=scalar()")
 __retval(0)
@@ -1514,7 +1514,7 @@ __naked void sub32_full_overflow(void)
 }
 
 SEC("socket")
-__description("32-bit subtration, partial overflow, result in unbounded u32 bounds")
+__description("32-bit subtraction, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
 __msg("3: (1c) w3 -= w2 {{.*}} R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
-- 
2.50.0


