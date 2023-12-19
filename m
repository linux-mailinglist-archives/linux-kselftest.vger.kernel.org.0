Return-Path: <linux-kselftest+bounces-2207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433168188F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4A31F226C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BA1A58C;
	Tue, 19 Dec 2023 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J23keRt2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D731C2B2;
	Tue, 19 Dec 2023 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6d93d15db24so248426b3a.0;
        Tue, 19 Dec 2023 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993856; x=1703598656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYz67IsFZfue1NP3JExLN1mOy5YJ/ePcLatZPz8TkS8=;
        b=J23keRt2Kn+EGTs2WIr+QcttBiZqKx1gltE9odV+0frRXL4OlM12MMA6HRg1irXE+H
         ElopFSa0lGx1NHRnVFYOdvhJxUWe9iMIbzu2s4AKxkUr40qt04GfHD/sxi2hN22tI8m+
         8eb95I9hxdmqr+Pc192CLxR1XN5F/T/i8uav64cilhLG2sT1DLR2LxzLWarUQl661t7k
         +M9AtfDmvS0k51mxTCtY9fwNdPMGmBJDYfmTk3EB7gDiv8xhu8fP++Cjkm69n6/tS6kZ
         JhgFQkrMDw+joI1zFpuyKIGJvrlnwVwC+6cV/SKysw9o/SD7vl4eqF83xX5PUf166SU+
         J8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993856; x=1703598656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYz67IsFZfue1NP3JExLN1mOy5YJ/ePcLatZPz8TkS8=;
        b=dyBN7TNRYKgwRIsTKId1B08YPc5mCpNEaqq8AJuMsOWoa83g73j/hX1tz1hy0OwKPY
         csS4VAtShnafN8FswS9BWwvZjj6pUo0RdiVG1fpK5+x08c4hopgxbtye5O8gUE2mQN6M
         c3tkRMvIEyKodnNcy4T98aLCznMQ48Jt/h02+XRvBqTgxUlZNeQPKAXzeVJT0VE4Pbks
         5YuGcQthFpIBkeSBwgr8D+NvJVZIlIwaWmUT3SdFN97o3Q78OHIsDBONw2uUnDCXmqO4
         q6xvqF7Yloa0M5B7tBVahOmTWwPGlcwNfs7WTewf1hjaFJGwi3CWDbCPIHlYiQCcIPxx
         Uttw==
X-Gm-Message-State: AOJu0Yz4kEDpACoTUlixQml5CjHgUyTBhnA3uil5j/YRDHA4+qZ/MU0x
	KkhJUDuwTohGGgpWbEC1VaI=
X-Google-Smtp-Source: AGHT+IGqYjdAsBO/QZE/Idvn9u+0mC5C5Cl7Crbzazs43pTYyoQ8quPa/0+0RSBS1+rC17ZIbYm5Pw==
X-Received: by 2002:a05:6a20:42a6:b0:18f:97c:8a1c with SMTP id o38-20020a056a2042a600b0018f097c8a1cmr25153568pzj.71.1702993856543;
        Tue, 19 Dec 2023 05:50:56 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b006cddecbf432sm20695264pfj.96.2023.12.19.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:50:56 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	menglong8.dong@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: add testcase to verifier_bounds.c for BPF_JNE
Date: Tue, 19 Dec 2023 21:48:00 +0800
Message-Id: <20231219134800.1550388-5-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219134800.1550388-1-menglong8.dong@gmail.com>
References: <20231219134800.1550388-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcase for the logic that the verifier tracks the BPF_JNE for regs.
The assembly function "reg_not_equal_const()" and "reg_equal_const" that
we add is exactly converted from the following case:

  u32 a = bpf_get_prandom_u32();
  u64 b = 0;

  a %= 8;
  /* the "a > 0" here will be optimized to "a != 0" */
  if (a > 0) {
    /* now the range of a should be [1, 7] */
    bpf_skb_store_bytes(skb, 0, &b, a, 0);
  }

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v5:
- add some comments to the function that we add
- add reg_not_equal_const()
---
 .../selftests/bpf/progs/verifier_bounds.c     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index ec430b71730b..960998f16306 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1075,4 +1075,66 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("bounds check with JMP_NE for reg edge")
+__success __retval(0)
+__naked void reg_not_equal_const(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r4 = r0;					\
+	r4 &= 7;					\
+	if r4 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r5 = 0;						\
+	/* The 4th argument of bpf_skb_store_bytes is defined as \
+	 * ARG_CONST_SIZE, so 0 is not allowed. The 'r4 != 0' \
+	 * is providing us this exclusion of zero from initial \
+	 * [0, 7] range.				\
+	 */						\
+	call %[bpf_skb_store_bytes];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bounds check with JMP_EQ for reg edge")
+__success __retval(0)
+__naked void reg_equal_const(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r4 = r0;					\
+	r4 &= 7;					\
+	if r4 == 0 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r5 = 0;						\
+	/* Just the same as what we do in reg_not_equal_const() */ \
+	call %[bpf_skb_store_bytes];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.2


