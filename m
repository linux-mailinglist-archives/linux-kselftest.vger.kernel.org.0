Return-Path: <linux-kselftest+bounces-35589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27241AE3428
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E116F260
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A31C8639;
	Mon, 23 Jun 2025 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6UrStKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9541C8612;
	Mon, 23 Jun 2025 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651491; cv=none; b=LRxTouVHSpPsgD0tLK9xIT5sFes0wCg24Kr9VBP2/zSTAXrr8QrV0hi+nYdPv0iiBWdm/ihzTZ28CdlQIrOFL+HGeoqhWcJx40oSoXXCUdHzWjCpSuhah4XDioOhDx6gzFNC7iEUyVIwXCQQZq4GPcA5KLbdjkweEWgXWCzEkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651491; c=relaxed/simple;
	bh=Om7oDGhV8WhIe7MihQ/sdXI7ZWZeAbnV9SZEqTmmH0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfaBfzy0i9jya7PN/mVXMFrI5pTzSzmWyUnbK4PCJjynkHNrpenbCbTiLagAIkLpCrWTrvQKIF5SQFL+ZDqznHVn5iJrtgelzbP0o2gtriAL+xO9nFecRr5yO4yyu43A3rIRnfHNMUup5VPn8VjhTVJZkbUzTc+lAB3AduwVeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6UrStKy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d38cfa9773so404031785a.2;
        Sun, 22 Jun 2025 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750651488; x=1751256288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxiQZQWkAOiMlWzdIY0yzPCGK3zVKGxK5z7H8GVPDEM=;
        b=f6UrStKyGeCW7VtNtQ30Eq1UcPePgFiF/Wsejo4c52ERdznrbDH5TZCb3KAGa858TR
         T+ix4b81lTBU0mTTULVMzZ1PpTbtH+4nvskLlMf+mRs064Kis5nlAs4oCZM9XaIqx3DD
         3cuEHwavKLhH2ipQBv1b/GPcdOp9RLixKU8IEpwO3O7QP7QXEaDToYOEyslU4geEzbJs
         LiDyjlfC/jPMYt3921Dn83AR1mNEC7rpbwFvastZasjOZYA+L8aCDCJlOw/3woPbsb7+
         MAufcCBtELR//PdlYoIt5wYc7iRf2zKLhXrgNVEr0yDBlkVxPw5J0pRSLiKduku+W1Sc
         lybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750651488; x=1751256288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxiQZQWkAOiMlWzdIY0yzPCGK3zVKGxK5z7H8GVPDEM=;
        b=WUYz5Ey/UQM0P7PqaO+g5+Xqhvy8sP+ubic5gUMLoWSQUswVvg3r2Y6vGCNkq6rnFF
         8n/TAxp9ZnEtSqQ3X0QV5rar3TZvojtuHOQVIgL2lt1Geq66DCUSYVZnl+IIrvmM1gEK
         dj2xp/68ZE9XyPcZwY+JA74jajkqz79+wDT1QZ4jVB/yb6CKrvnt6pgVeCH5Ug44xzmN
         IRroosKEaCWSNW6iakhMBJZ2Zdr9U6R2J7rtKnozgtIl52KesPXKmfm8Zhyc3Frz9raJ
         0LAMyJFHkE00RuCF7CPnY2bTwHjjlgdtp1KDpQ5mR7WXAzmrDL+mtayR6UwTLG3CGK4x
         vnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWGwCqV25g1WDpipx/VfXh0EUrS6x7QepeiV+/YzGp57eVLwCk6J6uOj3bFYnJONo8n/oaveqAR9sJOg7s@vger.kernel.org, AJvYcCVHKLRFy3wq9EDD/mh9swwB1qwHRrZR1YjmYolLVgy4j0zU1ZKEBxkpOxnQh9FEjNgtS929wL8ziOkyty4vjJcV@vger.kernel.org, AJvYcCXEC+ss02RfsYNoSR7CkcLm3OyuwpzE7rUqTfhP4SKGYdvvTyCNpsqEIuZ852haw+9sKSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcH1LmRcYPglwMI5Yd5BIg+2ssn7xl4Fy0FxqGl7pMl7TFV98y
	m+y4Z916wJEkxVesyy2/ZV508lMsrRVLmvPGiNs4VfpzaNZE7oUm1fkx
X-Gm-Gg: ASbGncuuYmcb7V1lf6YeCr/uOKKJAd0wl/CZDWoP+Tf3hXcjor6PU11oeEoB5IzNkka
	Eme6Ig7kPlG/uNFd4YwApDtwUS0SxU6AK+o8L0A/9qjdaf5orDHOUo0BcdAghA059nVfBdWfFA4
	pmpfo94PUqvOV2R2E34r4D6Tqdq7L+J+MpykwrMsw0kpe5KjDpqNPOgQGrv2Y1KasCvHk2gr6Ie
	KuOuuY2vfntemFERXdSH3gsD3Ef6mxWSY8/tdgiv66vtXHECa6TbesHmL+a1BlQneYy/dIsif5v
	EJkzRrWUTN0ZXfPZhMHAvbQuz2h/1Gdsnw+GkLnL8I7+XgwvWxwIp+7GNTKu+6ZBIG+n20DQTcg
	XbOzXJJDuVQ+b0FTNp013goS1lRROtodrJLOqpw4mjguY6aDRjHynWTBUhYEMUaPqHBGTCA==
X-Google-Smtp-Source: AGHT+IEB+CtGeKi3Mghgbkve8NhXsQpZ3/7P7VeN57IvlHIz4GSzj4W8NkOFZ/GfWWwCM3KTkq/J/A==
X-Received: by 2002:a05:620a:bc1:b0:7d1:fc53:c6b2 with SMTP id af79cd13be357-7d3f9939f14mr1645336585a.41.1750651488257;
        Sun, 22 Jun 2025 21:04:48 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fc0a8sm347274385a.80.2025.06.22.21.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:04:48 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
Date: Mon, 23 Jun 2025 00:03:57 -0400
Message-ID: <20250623040359.343235-3-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit improves the precision in scalar(32)_min_max_add,
and scalar(32)_min_max_sub. The improvement in precision occurs in cases
when all outcomes overflow or underflow, respectively.

This commit adds selftests that exercise those cases.

This commit also adds selftests for cases where the output register
state bounds for u(32)_min/u(32)_max are conservatively set to unbounded
(when there is partial overflow or underflow).

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 30e16153fdf1..31986f6c609e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1371,4 +1371,165 @@ __naked void mult_sign_ovf(void)
 	  __imm(bpf_skb_store_bytes)
 	: __clobber_all);
 }
+
+SEC("socket")
+__description("64-bit addition, all outcomes overflow")
+__success __log_level(2)
+__msg("5: (0f) r3 += r3 {{.*}} R3_w=scalar(umin=0x4000000000000000,umax=0xfffffffffffffffe)")
+__retval(0)
+__naked void add64_full_overflow(void)
+{
+	asm volatile (
+	"r4 = 0;"
+	"r4 = -r4;"
+	"r3 = 0xa000000000000000 ll;"
+	"r3 |= r4;"
+	"r3 += r3;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("64-bit addition, partial overflow, result in unbounded reg")
+__success __log_level(2)
+__msg("4: (0f) r3 += r3 {{.*}} R3_w=scalar()")
+__retval(0)
+__naked void add64_partial_overflow(void)
+{
+	asm volatile (
+	"r4 = 0;"
+	"r4 = -r4;"
+	"r3 = 2;"
+	"r3 |= r4;"
+	"r3 += r3;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit addition overflow, all outcomes overflow")
+__success __log_level(2)
+__msg("4: (0c) w3 += w3 {{.*}} R3_w=scalar(smin=umin=umin32=0x40000000,smax=umax=umax32=0xfffffffe,var_off=(0x0; 0xffffffff))")
+__retval(0)
+__naked void add32_full_overflow(void)
+{
+	asm volatile (
+	"w4 = 0;"
+	"w4 = -w4;"
+	"w3 = 0xa0000000;"
+	"w3 |= w4;"
+	"w3 += w3;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit addition, partial overflow, result in unbounded u32 bounds")
+__success __log_level(2)
+__msg("4: (0c) w3 += w3 {{.*}} R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__retval(0)
+__naked void add32_partial_overflow(void)
+{
+	asm volatile (
+	"w4 = 0;"
+	"w4 = -w4;"
+	"w3 = 2;"
+	"w3 |= w4;"
+	"w3 += w3;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("64-bit subtraction, all outcomes underflow")
+__success __log_level(2)
+__msg("6: (1f) r3 -= r1 {{.*}} R3_w=scalar(umin=1,umax=0x8000000000000000)")
+__retval(0)
+__naked void sub64_full_overflow(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"r1 = -r1;"
+	"r2 = 0x8000000000000000 ll;"
+	"r1 |= r2;"
+	"r3 = 0;"
+	"r3 -= r1;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("64-bit subtration, partial overflow, result in unbounded reg")
+__success __log_level(2)
+__msg("3: (1f) r3 -= r2 {{.*}} R3_w=scalar()")
+__retval(0)
+__naked void sub64_partial_overflow(void)
+{
+	asm volatile (
+	"r3 = 0;"
+	"r3 = -r3;"
+	"r2 = 1;"
+	"r3 -= r2;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit subtraction overflow, all outcomes underflow")
+__success __log_level(2)
+__msg("5: (1c) w3 -= w1 {{.*}} R3_w=scalar(smin=umin=umin32=1,smax=umax=umax32=0x80000000,var_off=(0x0; 0xffffffff))")
+__retval(0)
+__naked void sub32_full_overflow(void)
+{
+	asm volatile (
+	"w1 = 0;"
+	"w1 = -w1;"
+	"w2 = 0x80000000;"
+	"w1 |= w2;"
+	"w3 = 0;"
+	"w3 -= w1;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit subtration, partial overflow, result in unbounded u32 bounds")
+__success __log_level(2)
+__msg("3: (1c) w3 -= w2 {{.*}} R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__retval(0)
+__naked void sub32_partial_overflow(void)
+{
+	asm volatile (
+	"w3 = 0;"
+	"w3 = -w3;"
+	"w2 = 1;"
+	"w3 -= w2;"
+	"r0 = 0;"
+	"exit"
+	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.2


