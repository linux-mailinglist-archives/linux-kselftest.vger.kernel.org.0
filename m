Return-Path: <linux-kselftest+bounces-2726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C7827987
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C79285056
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC955E73;
	Mon,  8 Jan 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUMVQDkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674B55E68;
	Mon,  8 Jan 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-557d554ca30so977981a12.2;
        Mon, 08 Jan 2024 12:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747152; x=1705351952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adI7f1RlY+ltIHKhZGqEjhbXbsGlT5KUxNsWV+Nqtu8=;
        b=ZUMVQDkTjMcsd6fEbWg4HtlY3et5hzHW8/lrkOrGdlmlyVhcwWcxXpF/sACIuWRFCC
         xd5nbKys+uzLJ9MQBjS2KItcwtlSzNf1PsjkdGyqVKguuZaN+eKIWIiQkjmXh7B6rhC7
         m1RQiKARBWMcvDntXsIIH5XAFs3tk3HisWuzYRzpkuAT+cMKsrEc8Fn57QtkeSzpT+l6
         VYlx+fs+QH87pzpKo7PJ+WVaFvmHh8bBfGc3P0MD0shq+tB5RR9hf7jGskZPUQqllH9q
         s5xmDNGAZ3Vcjs0dU/ZrPhihI1EK5x5py14UwFplaY6GkgcvDBVq2xIZlOL8lF3M7nFx
         DByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747152; x=1705351952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adI7f1RlY+ltIHKhZGqEjhbXbsGlT5KUxNsWV+Nqtu8=;
        b=D6BQqhK5SaElgUNCUMmRI9RZVcOgwhjXzhR+Nu2KjNrigIuOd5vvpj1GfvfWWbYiTM
         OjuOi99jYe0IMPJH+cPmm5DKTcRmSwSIgPBY391VR4OXo9X+zoHiWf+rnu+eQ17TNI/0
         HFnXylJiHbzp5TdUxyFHONGYosnw82Y9JnxBbagnleWJdHIK86BRgc/K5YXcnXrtl/KQ
         zMHh5zqVebnJgyej9+dUl4QR79BeRgm1syPsSxD46e4Dh96D/8mmObfQ/k8kNTyPhB+7
         M/QOtgO8DwWu+0Y89AB8AvSixbpNzDINdkJlZ0KakUychPv5fmREFXFAQ4uEIVB9y1fg
         HEkA==
X-Gm-Message-State: AOJu0Yxg+wKCQX24uh2PMAMD81O2f4L28I7K8ucO1zPk87pz3umVTBDB
	xLx7Bq2vuwoAmt8UPxU55RM=
X-Google-Smtp-Source: AGHT+IFh3NpDyh01CwEX8/55m43siA24ttbMhvSdDCSwNAhhteJmeiKTxLmJqSZKHN1jcuFMmr7fAg==
X-Received: by 2002:a17:906:1cd8:b0:a28:f8d2:7897 with SMTP id i24-20020a1709061cd800b00a28f8d27897mr16527ejh.20.1704747151799;
        Mon, 08 Jan 2024 12:52:31 -0800 (PST)
Received: from localhost (tor-exit-1.zbau.f3netze.de. [185.220.100.252])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906158700b00a2add419e33sm244982ejd.176.2024.01.08.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:31 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 03/15] selftests/bpf: check if imprecise stack spills confuse infinite loop detection
Date: Mon,  8 Jan 2024 22:51:57 +0200
Message-ID: <20240108205209.838365-4-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Verify that infinite loop detection logic separates states with
identical register states but different imprecise scalars spilled to
stack.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_loops1.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index 71735dbf33d4..e07b43b78fd2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -259,4 +259,28 @@ l0_%=:	r2 += r1;					\
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__naked void not_an_inifinite_loop(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r0 = 0;						\
+loop_%=:						\
+	r0 = *(u64 *)(r10 - 8);				\
+	if r0 > 10 goto exit_%=;			\
+	r0 += 1;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r0 = 0;						\
+	goto loop_%=;					\
+exit_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


