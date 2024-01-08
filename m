Return-Path: <linux-kselftest+bounces-2728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF182798E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCC028393D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB755E61;
	Mon,  8 Jan 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agrTGG1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDB55E5D;
	Mon,  8 Jan 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e759ece35so2321289e87.3;
        Mon, 08 Jan 2024 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747162; x=1705351962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qdhZQ50yhU/SRCB/PIjXryngjXoiTzCDGKP0J5FKhQ=;
        b=agrTGG1jCiSP2FSDfu/qOl1rTJ2f2CH2PG3s+x8jXsTHKpLSJ6uWQx66tsl8hUjBbX
         A4stqnTzTE2S4w1XexgKjyDY/nwfChlXbxeG4ByYpvVxdA2CeahsDu1eCw8EV5ag8y0p
         GbbMANOuRGxHGV+75B8ND2krdiGKwtVK7EpJUqWxR+B7m/fFH+zq+TOqAoVF3boMFyvl
         i48YZFRWSSOh//OaKcaaSTeXAiR/d0JxIawN8ytylqyGtzBTHBoq1R1Wl0vV35rxCAFO
         vsNz0bqFBa9Pqny7tgp+cx6jaTrXXd1iBfs3jeR1s3Ud/6s2vTTIHLP+sCnHmPNx5rWv
         mSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747162; x=1705351962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qdhZQ50yhU/SRCB/PIjXryngjXoiTzCDGKP0J5FKhQ=;
        b=U2guxmJUjSRnGjqKjfddLqwYaVEGI61i1Br76qElcRHNzJS9UgMkSqP43I/g6LJdXK
         /j2jePghb786hhaQ1O5Gm2R1a3sQncvMKm98yQmLD9TiSPWGSMSGmP6My/JPfcx/QFad
         e7DATq15Y67sv9cRaB6z3fl03SwQKbx+Vh834/UhcndDFkvFJGOiJ4Um5EKUUQsSTW43
         Gj3H4b7QJGw86Ch+ba2PGrYtX/1sBy8Tb2BBxaxm4M/VHf3Az19QEYrd7KSDfCON6s/D
         p1F0yC505wXd1gWVf9NZ5Q9TcYAHDRLyyHB38/yJeUimvzQ6cdTIBPXUDd6uF7d4/G64
         2AmQ==
X-Gm-Message-State: AOJu0YxTytdyArzN6nzTxkAMoE8kvdR9Z8Klqz7y5rtSmMnWx8O1csFF
	RLO48jSzS4NdBg0DVvodaDc=
X-Google-Smtp-Source: AGHT+IFeJ99k98c+GtyJciKxCA0cmzsKkflU47ocxDxxI2gqMKhGDOuOB1GQHhGOHCIXTtn48hv45g==
X-Received: by 2002:a05:6512:2394:b0:50e:7c70:fbe1 with SMTP id c20-20020a056512239400b0050e7c70fbe1mr1874713lfv.100.1704747162071;
        Mon, 08 Jan 2024 12:52:42 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090652c100b00a2777219307sm236577ejn.202.2024.01.08.12.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:41 -0800 (PST)
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
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v2 05/15] selftests/bpf: Add a test case for 32-bit spill tracking
Date: Mon,  8 Jan 2024 22:51:59 +0200
Message-ID: <20240108205209.838365-6-maxtram95@gmail.com>
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

From: Maxim Mikityanskiy <maxim@isovalent.com>

When a range check is performed on a register that was 32-bit spilled to
the stack, the IDs of the two instances of the register are the same, so
the range should also be the same.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 848f2930f599..f303ac19cf41 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -735,4 +735,35 @@ __naked void stack_load_preserves_const_precision_subreg(void)
 	: __clobber_common);
 }
 
+SEC("xdp")
+__description("32-bit spilled reg range should be tracked")
+__success __retval(0)
+__naked void spill_32bit_range_track(void)
+{
+	asm volatile("					\
+	call %[bpf_ktime_get_ns];			\
+	/* Make r0 bounded. */				\
+	r0 &= 65535;					\
+	/* Assign an ID to r0. */			\
+	r1 = r0;					\
+	/* 32-bit spill r0 to stack. */			\
+	*(u32*)(r10 - 8) = r0;				\
+	/* Boundary check on r0. */			\
+	if r0 < 1 goto l0_%=;				\
+	/* 32-bit fill r1 from stack. */		\
+	r1 = *(u32*)(r10 - 8);				\
+	/* r1 == r0 => r1 >= 1 always. */		\
+	if r1 >= 1 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it.   \
+	 * Do an invalid memory access if the verifier	\
+	 * follows it.					\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


