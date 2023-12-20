Return-Path: <linux-kselftest+bounces-2288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E400C81A87B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B665289357
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CA4C634;
	Wed, 20 Dec 2023 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Ur8huf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AC4CB27;
	Wed, 20 Dec 2023 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso134219a12.3;
        Wed, 20 Dec 2023 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108450; x=1703713250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZLSMuU6ksvyVtfD3RmiNa/SVTNHgs0cwXOVuO57y9A=;
        b=Z7Ur8hufGnP4tyA0xa6WulJ7knWMUP066n4dWDZ8v4sA5Rn5kDoJgZN5pHqmZZj11z
         BkSN2vOEHPfSu+WlorOb1nj8KzwPChVY4lYimh2AXvtGUI/SjBDb/DvCHLquPc+YxYwO
         qebkBzTC8XicGMxSM/P7n9avVaZQwrB3aSUX61RzwH6tfFVm7YLQ2IHx8mSFKxQsp2G0
         v9BG71l4dRC8IOKfx6+khG0+BAsaKq8zGeFQ7m7VIjz8753x1QiU8dwCW0XeBUsci5YV
         7QVH3kC+VvU3d95qjHjzukBa4UKnej+KjJBitGONpNRPwxvj4NkYJJE0eKB1WbojV7Jf
         /B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108450; x=1703713250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZLSMuU6ksvyVtfD3RmiNa/SVTNHgs0cwXOVuO57y9A=;
        b=SEdHNJPLi9DxtV0SToDsNKLPEpZu93FUXiV3BdyWZuyv0fAGPb9ELF4P+R1z+vJ++H
         q5oSi2pOstaYLuww/D1IhaXjz1N+5CzHEv+uufl8eZ6cpD5xU9VwTC7+Uf+AFxBJMTQU
         09hi2fQX+itNN7ilwBjg/fIb+QQQWbQgn/Z5RO6ai8LBOGXCl9fXGvpJQFrrK5RmHJ5X
         480ZDuwy84wKB0VxKiV7/K/ogWbo05mqyuRFBdtDIKFvMW1rqlWQoBfdVPEx2LSSOqzZ
         nwtmZSFXM/Ru40cCxPGoh2oQMBrdFfHbcG3uskDp4ho4qzbeQOejPLFpykG5J6xoOaqK
         522A==
X-Gm-Message-State: AOJu0YygW7NO7POuDKwAkPu0rV6LXLD6BDEsUugeQb9I2/AM48Ox21wj
	lfxdMP7zQIApukSubVa5aNQ=
X-Google-Smtp-Source: AGHT+IHq852po/PKaZHcQBG5i9Cih9t5LeGZoL9Nup3vJNnFXdtHs3Tq48dEb9VojCiHIjtMqQ5igw==
X-Received: by 2002:a50:8d85:0:b0:551:16cf:d0ca with SMTP id r5-20020a508d85000000b0055116cfd0camr8365627edh.55.1703108450569;
        Wed, 20 Dec 2023 13:40:50 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id dy21-20020a05640231f500b00553d59acdb3sm295282edb.27.2023.12.20.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:50 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next 11/15] selftests/bpf: Test tracking spilled unbounded scalars
Date: Wed, 20 Dec 2023 23:40:09 +0200
Message-ID: <20231220214013.3327288-12-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The previous commit added tracking for unbounded scalars on spill. Add
the test case to check the new functionality.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 92e446b18e10..809a09732168 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -901,4 +901,31 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("spill unbounded reg, then range check src")
+__success __retval(0)
+__naked void spill_unbounded(void)
+{
+	asm volatile ("					\
+	/* Produce an unbounded scalar. */		\
+	call %[bpf_get_prandom_u32];			\
+	/* Spill r0 to stack. */			\
+	*(u64*)(r10 - 8) = r0;				\
+	/* Boundary check on r0. */			\
+	if r0 > 16 goto l0_%=;				\
+	/* Fill r0 from stack. */			\
+	r0 = *(u64*)(r10 - 8);				\
+	/* Boundary check on r0 with predetermined result. */\
+	if r0 <= 16 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


