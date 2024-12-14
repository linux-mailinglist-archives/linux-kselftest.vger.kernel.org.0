Return-Path: <linux-kselftest+bounces-23387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A679F2089
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D42A7A1520
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B51AF4E9;
	Sat, 14 Dec 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RynnjSl0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D21AF0AA;
	Sat, 14 Dec 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203072; cv=none; b=ucVslM8fJLdAyW0hGbVAbS/JMN/tZJk1+SbIEE1Gqbn8GapCictrauDaAWG8mPeLprVMOwKjI+PPCE2wwQrwVQ4zSakJHBeGIkNaXan7eoiLotyD8HSq1wLotQPzrfSvkeI+jMkN6zwXpvfi0FRzUSDGfz/M3jEq9pu+2jk8w04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203072; c=relaxed/simple;
	bh=EpIiynsjnozVqw/0x3LVUCzOWJ6olzjgv5hUvkC7X1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/lKWrPCz77MjYBJ3a0e5u6X23tedflrH8cgTM3ey/1GiBQMLZ3a/ZhxB79AssLHRFvWzE2VOkkT9W/PWRq46aj6T1qvpnooeH/mCWGx2u0LLzzLbHGaqHq/KTfRiQqklIIWUj3TQRkpvIdRfAvPA0YUQlm1nTAwfc8nZB0G7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RynnjSl0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d88cb85987so25320396d6.1;
        Sat, 14 Dec 2024 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203070; x=1734807870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU1DPjWTLJX1jYc4OU+MA5rIh9EYQGoOHy6NRrQN9LI=;
        b=RynnjSl0hTaOpaf5NTpRAPbUmmJ2Ga42vX04vS7HF//TK0zKW0DgW4en0qq8vOyPzE
         2GOR4EnlSGfp0jkswLTyDE86VnGv6KRBBs57GrCjA50I7QxCscYsQzdoLQcVDWj7aq0e
         pKMxB4bgECXfdz6Ajbx+B8YuLypAkQk/kTzW0dul49fUKpUWieA1jAQMbMe4I8Du5uPO
         xUaMcMB605XyBoBaFJ3hTD4CgFix9SE6S4V+8Cb9oFvDzRg3n2bPONBGA3Irawv8KPNb
         c6avaxH1NltJb0okDcjeUxNcUwmfGEADoyqKgJPgHxnhuKwKLLP7J3pyzKTTNeJ7hKIN
         nwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203070; x=1734807870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU1DPjWTLJX1jYc4OU+MA5rIh9EYQGoOHy6NRrQN9LI=;
        b=QMYb3t9fdDug8/haDHmMsRbFnEnu71cO/peeUgL4lMtk4nC5Oosl/F/SU6M+YcWEFf
         G2F0BvcVQYS7kAtpVNCYfFM0kqgABR8NV1LmnTlj9bysftlJ6LB/6AKpiYM6eQJYp0K2
         3x34r897GiK4CakPImfRSmQpXLrTnW0Gm8EwqyqeCXJN+SkiWxBTb7e0nCI+5C5h375N
         HI+zsWOB4kyrsk6KL2QBLVm+3iXzHFCPeqUonShtNzr0RofbyfAtynx9x863WiVyvyQO
         /c/yf5jiU38OD+xGeVJZuNOhJEzYOwhCmCSd3QhNkL5uvVHdaaM4o73SPTjYm0Hi03qj
         syTw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjvU/6yzLNd91X74+Wiq/jSZKga7D/twWieTziebzkP4Ittz1vvZ+pOZyTt9GiqnqKfOTlMi8+cp2hhJ9@vger.kernel.org, AJvYcCX7ri8aONISclKlaWA5K/Syc46/8NL8Al4bjK3kKyoZvDti8NwSToJNkBLqW371oexvp3Y=@vger.kernel.org, AJvYcCXOZ1nIa3zyjNATPvQB2QAozVuP94uc0XfYJj2LRlhoOSDMctV2eoEivGPX9vC3R10xq6BS2NvHOApGTzLj9lMg@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8x60LHNLu0gKxktt+or5nKDlxvBMQw0/c3W0aUBpF4mThsGb
	BxN+5IBdu7boPBDr2Vt1bOefBEwADhK3gfcgcBB0cH3PvPAqlQ03
X-Gm-Gg: ASbGncuZVYsTe4QV/PX0fsNqKgO1+WklJdWWYvZDfsoQBIUvd5glKv5a57HTPOaKdV9
	4sT0cWpCExmzxOUrcYoXOq4zTuokXA2FtPGCOex/o364642bmmdQYtc/ySNryKj2ilBYxDoREB9
	b/7vWYKak9RI6t59RHw5dpcNwGD6vLF9HAiqYZxDKb1ikRUDVh4PS/PxEjuszYjgZw0x8SVGp3E
	Jsi/TckE7eddnHrlb7iEn4wOHVLMJBOapIXQffFUc5vl18nl7jD5i3+8C7IvJc/d4fpvvMURNWF
	swIwW0/mXpP5nSIa5BuD1n/wHg/p3wo=
X-Google-Smtp-Source: AGHT+IHI1DbHgqQJtq3YKkY53ng0b6kzS9Jt47qD4McIfgwzzK7FGksYy0+V/f9P9dBOZ/rzYP7kug==
X-Received: by 2002:ad4:5aac:0:b0:6d8:b81c:ecc1 with SMTP id 6a1803df08f44-6dcbeba6a5amr110614996d6.13.1734203069864;
        Sat, 14 Dec 2024 11:04:29 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6dccd26d086sm9884376d6.55.2024.12.14.11.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:04:28 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@gmail.com,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	m.shachnai@rutgers.edu,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcases for BPF_MUL
Date: Sat, 14 Dec 2024 14:04:11 -0500
Message-Id: <20241214190413.25587-3-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241214190413.25587-1-m.shachnai@gmail.com>
References: <20241214190413.25587-1-m.shachnai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit improves precision of BPF_MUL.
Add tests to exercise updated BPF_MUL.

Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40ea5..0eb33bb801b5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,138 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("multiply mixed sign bounds. test 1")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,umax32=0xfffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
+__naked void mult_mixed0_sign(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xf;"
+	"r6 -= 1000000000;"
+	"r7 &= 0xf;"
+	"r7 -= 2000000000;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply mixed sign bounds. test 2")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=smin32=-100,smax=smax32=200)")
+__naked void mult_mixed1_sign(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xf;"
+	"r6 -= 0xa;"
+	"r7 &= 0xf;"
+	"r7 -= 0x14;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply negative bounds")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=smin32=umin32=0x3ff280b0,smax=umax=smax32=umax32=0x3fff0001,var_off=(0x3ff00000; 0xf81ff))")
+__naked void mult_sign_bounds(void)
+{
+	asm volatile (
+	"r8 = 0x7fff;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xa;"
+	"r6 -= r8;"
+	"r7 &= 0xf;"
+	"r7 -= r8;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply bounds that don't cross signed boundary")
+__success __log_level(2)
+__msg("r8 *= r6 {{.*}}; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R8_w=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))")
+__naked void mult_no_sign_crossing(void)
+{
+	asm volatile (
+	"r6 = 0xb;"
+	"r8 = 0xb3c3f8c99262687 ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= r7;"
+	"r8 *= r6;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiplication overflow, result in unbounded reg. test 1")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__naked void mult_unsign_ovf(void)
+{
+	asm volatile (
+	"r8 = 0x7ffffffffff ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0x7fffffff;"
+	"r7 &= r8;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiplication overflow, result in unbounded reg. test 2")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__naked void mult_sign_ovf(void)
+{
+	asm volatile (
+	"r8 = 0x7ffffffff ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xa;"
+	"r6 -= r8;"
+	"r7 &= 0x7fffffff;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
 char _license[] SEC("license") = "GPL";
-- 
2.25.1


