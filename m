Return-Path: <linux-kselftest+bounces-14042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190AE939960
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1241C21948
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926713CFB6;
	Tue, 23 Jul 2024 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDCkgNqw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C313C8F5;
	Tue, 23 Jul 2024 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714144; cv=none; b=seAbNrS6jQ1znPR1GSuSn8E9Z1OcdP1wL8NkFQM5IPW9HHADAeQMbM7Kq1BmUc5auQOj+DGh699NbdvonFK3iXp788o/YV3nvwBAPnKXeDkfgwjZES7YjFUSHAcYH53nnguhrfeYaKUusrOcxULyYV40SFkkMxBZ18M4U6ugHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714144; c=relaxed/simple;
	bh=348kv5TYj77FY2oepxEjwLBdTShFg0FGVTQTHlTuuC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sh+Yt7JW8BcHprNlNm2QOKnok+gYaYLI7qNuw8PgoRtgf0D7O452oxI07qaKoQp5jH1Avq5zGdmAY6Nn5Xbs14APH8o17ina8vAeuHjrRR3aGuUap3GN6cUvKDX3w/muLPA6DbfCNwBYMmbqdKsAr7ZypiEHXfcpLP9TVEeIY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDCkgNqw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc65329979so2067145ad.0;
        Mon, 22 Jul 2024 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714141; x=1722318941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1etmszcNBxjVhKCxwYCScQlTndWHwCT7LiuVHopK3AI=;
        b=bDCkgNqwjZLBkULI8mihmiIsOTKuge1uVHJGXgooe6bVNF4XyHrTi5DfxC9HBJxLLt
         unoUMe01Bj4lBNMyYxROxa2XHatEb/ZDlRMYDvw++SelGrh8SllP1YyasjVXmnZftS8/
         nhP7/xHPr0hJoo3JEdGi9d/atVZvwFmKUhushmzaD89iNLVQ9M0tZvomByMi5kxhLo9Z
         0Z58zo3RXOQ5BPTUhZ0vvSq4IApXhWEGto9yyI7H90x7Eec/indHRF9wZsNBKfCtwaPS
         AB/prPG8QyjQES9HScJ00FH+cB3C12prAdIEfZCRxoHfkiS/K8UWTQ9vuExLUC0CfJuS
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714141; x=1722318941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1etmszcNBxjVhKCxwYCScQlTndWHwCT7LiuVHopK3AI=;
        b=FFCoLFbk9IDpAKHpYXZmqL5A3u3kWrMEYUuv8NbldKYHXM9pRdScxHKfioM3p8CnSV
         POfgr4bUwFE3rrwa6o6Ab/mBF2nDbwtYLitocyYViZ9GHPbT5z0KRb0p0w3r3TpW1rr6
         1gynFEo6OBK4FUtjBxqPUOHG02Dh8GenCisIRsnKvMCKvfnRqoMUUyi9P2IS9BEHl+p8
         oqihofE9kbZ7Zhni4NK9BIesO4JIG67MRk1TnIbhv9uQKRaT2yOdqvKCD3nrlV7UOlXE
         dU4WlFIrCid8AlIkv3OE10qFRKVgySqiTKz1WQx6o19xWxKC2wBJMiYlvCsugxrKzADf
         3/cw==
X-Forwarded-Encrypted: i=1; AJvYcCVEBM2NHVomFluljd1YTeVqKasnjTMGiTO48S4bzp7UJQclsWCs1C+uYWLL5tlhJRc/Ao8Qs4FXYqlU6ZVgjZ78Ns/59DJkG9z5nQrZcTWL
X-Gm-Message-State: AOJu0Yz6WkLaIKbq+KLEsnSKRkbPO2i+oaVg8+bVDbXzSthwqwn05gnn
	n0tvfCeoGuL4vE1SA+CL6sUaOOSbs0BEf4kWCPUJrn88VNvNa8ImEvYJND5S
X-Google-Smtp-Source: AGHT+IHOEKKJNDMqMVAZh3MFFi3CH589ZryUTXLGiJCAeOmmC7E3XkLj9JAU1QPXFtSYZHKtGCg4SQ==
X-Received: by 2002:a17:902:d4c9:b0:1fd:a360:443f with SMTP id d9443c01a7336-1fda360489emr35738695ad.24.1721714140803;
        Mon, 22 Jul 2024 22:55:40 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 05/19] selftests/bpf: Drop unneeded include in sk_lookup.c
Date: Mon, 22 Jul 2024 22:54:32 -0700
Message-Id: <cf73cf1420915a00404eb276564af5d592c46beb.1721713597.git.tony.ambardar@gmail.com>
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

Test prog sk_lookup.c includes glibc extension '<error.h>' and fails to
build for non-glibc (i.e. musl) systems. However, the header is actually
not needed, so remove it to allow more portable compilation.

Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach point")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..dcb2f62cdec6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -18,7 +18,6 @@
 #include <arpa/inet.h>
 #include <assert.h>
 #include <errno.h>
-#include <error.h>
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.34.1


