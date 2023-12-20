Return-Path: <linux-kselftest+bounces-2282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2F81A868
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3495D1C21EEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC84C601;
	Wed, 20 Dec 2023 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG68nxr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C54C3DC;
	Wed, 20 Dec 2023 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2356bb40e3so8865466b.1;
        Wed, 20 Dec 2023 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108435; x=1703713235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD7VeMnjKAxyZj8mbMwt4mJMl93BY6cO6FMg2JTnA74=;
        b=fG68nxr1hIC/vqCaABoYJ4jQgTg3zdtHrBewyxENw+WXb/F2tmqvcw+UYwqvgmVre9
         eKYqw7/BgtMmhWkXiYylvKAq1eVCqMCQiSrwKEcV3dTFjvVkviphUm+tYZ9hCjpIAp0a
         pY8oe7VG4H/vqNFbYyZSr+246pyFp70wWWdA2VZDxzlkR1dwlMGB3smvrKXpK20eAbz1
         ozD0yfnvs3RY7Iz4Vh2swhYK1AjGo2NSX2mYdfLjUjix44lXKmDWVWqtTMNx/Y5SbHKq
         sX0/ovkZeI3f41vgzIzF20h67VVLR1pJpMlRADXJqlEDr3DQD53MqGcojJ7GpQfNQtie
         9r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108435; x=1703713235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD7VeMnjKAxyZj8mbMwt4mJMl93BY6cO6FMg2JTnA74=;
        b=EzQ507Wv0a8wv0BSZJtMy631J2xTkVNkhO7GCSL1qCRti06I4iYONvUAvQZBxIV1p+
         jRNlJCygQQECg/eYPlOt41IL5W6aFfsK7f1TFXO7SedM/i7HOxnzhQtiWCyTgAgrvwIx
         /z8EIk+OjvZ116AqRfwvAl6t4fBZLRqHyvyTm0q+PCxyTsoNj7+lpybfJkfjhd5F/j/H
         evqU+laHDaUHjbKJAx2kVIiHlE49H30c02MVlXCYOCsIkZ7EKSbwwTzIhaoax5w4wZDp
         DubY9a7jyIw6Ma00y3dqRKRZKezYxcQ2bz37pNw7LSpB3qVTPS6O+xdeDGTeMFNJdv9Q
         Y1+Q==
X-Gm-Message-State: AOJu0YwGJx29ujtabsppTlBCq2xN2gJ5XocDv/exQiC5AfdrTXqsPAxc
	O9z05gSzds0I5Vm+1RPn8Pk=
X-Google-Smtp-Source: AGHT+IFOZ5KB1f8BKZKidNyLx56gZSqFtkxELjQ1V4ZwxFmpE05JVQpdm3NS3JKmInS9cV/9gheIqA==
X-Received: by 2002:a17:906:5657:b0:a26:88f4:3fae with SMTP id v23-20020a170906565700b00a2688f43faemr1389315ejr.67.1703108435174;
        Wed, 20 Dec 2023 13:40:35 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a236378a43fsm241250ejb.62.2023.12.20.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:34 -0800 (PST)
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
Subject: [PATCH bpf-next 05/15] selftests/bpf: Add a test case for 32-bit spill tracking
Date: Wed, 20 Dec 2023 23:40:03 +0200
Message-ID: <20231220214013.3327288-6-maxtram95@gmail.com>
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

When a range check is performed on a register that was 32-bit spilled to
the stack, the IDs of the two instances of the register are the same, so
the range should also be the same.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 84eccab36582..f2c1fe5b1dba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -737,4 +737,35 @@ __naked void stack_load_preserves_const_precision_subreg(void)
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
2.42.1


