Return-Path: <linux-kselftest+bounces-32075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BEAA5BD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 10:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357FC1616B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B301F098E;
	Thu,  1 May 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="gWbT9+wr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020282DC76D;
	Thu,  1 May 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086631; cv=none; b=kLw9yH7fHyZGCLNXkzGX1hxDV5pe/kjXE1p5KFYJGiiF8i25ahoUKW/oSYNa6QWIXVnx1qnkn64RD87gjXDxT27MFsc1UnEmPAiTa9k+2hZ8HbY2IaK1ZA5wb/1xKkwGGTje2f28y4XWNSTaFuc3xeMRZ5gtqu73O3UFiBMqdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086631; c=relaxed/simple;
	bh=GLEgbpMEfc6DvRYVqlJnbq8YGhcyB3jB8rNmeNWMpc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGw3dIJy8U/TU1GeZHr03vHga6LSJaNW9vQEKpUVFnYzovLaAFln1JdmkWPWGaUNh789LoJ8HhbE+d88WMseSPmyr0nCX4aE47Bs7RXK2IbehgL7ymehCCm43PBTakZuz1H+S//ACzezfI/961TyCyOSSaIQYDkbPghlGreZ6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=gWbT9+wr; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746086626; bh=comqgaUQOxn93ZxQu1EvnNHU0RsO6P+D6nZ/mcIInMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From:To:CC:Subject;
	b=gWbT9+wrMh+BUdg4ZnOZY0mSr2cUtj6Z8ZocBb7DWOxuwLwvdHihDnR2ttewnrGDh
	 k8HHeOw0vbuhqHkTlENIEK82v36G7XJnwlPZXSw+1z5k5CeUaGbDk/0YznzhjNaqkQ
	 dbI4UzG6r7BYCudym66d1pN34Nbed8F8Z8d/4MrDD9X0h0fAAjx31+dwj4DHFJ7lHd
	 wUA5iYkbJ6MMTpRK+VQ5x5CmT4vMAsaws4e55mSinrT92WgGHEtebEthVgKgJql4lf
	 aWdgGrLbuOVmKP3JDenaH5oJfNAQ/h3jmU2JmmBNgzP/5Kr6+cZFHk3D/CnMcNY8+T
	 zxv6cmzBylVXw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zp64y4Fw9z8sb2;
	Thu,  1 May 2025 10:03:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3636:a700:12b2:e53f:6cbc:f48c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3636:a700:12b2:e53f:6cbc:f48c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/VyCT2/hi5OQfWV2DB4gtoSsGC7vYH9bs=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zp64v0sdWz8srN;
	Thu,  1 May 2025 10:03:43 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Jiayuan Chen <mrpre@163.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 09/11] selftests/bpf: Add test for Spectre v1 mitigation
Date: Thu,  1 May 2025 09:36:00 +0200
Message-ID: <20250501073603.1402960-10-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501073603.1402960-1-luis.gerhorst@fau.de>
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is based on the gadget from the description of commit 9183671af6db
("bpf: Fix leakage under speculation on mispredicted branches").

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 .../selftests/bpf/progs/verifier_unpriv.c     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index c42c3839b30c..43236b93ebb5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -729,4 +729,61 @@ l0_%=:	r0 = 0;						\
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: Spectre v1 path-based type confusion of scalar as stack-ptr")
+__success __success_unpriv __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if r0 != 0x1 goto pc+2")
+/* This nospec prevents the exploit because it forces the mispredicted (not
+ * taken) `if r0 != 0x0 goto l0_%=` to resolve before using r6 as a pointer.
+ * This causes the CPU to realize that `r6 = r9` should have never executed. It
+ * ensures that r6 always contains a readable stack slot ptr when the insn after
+ * the nospec executes.
+ */
+__xlated_unpriv("nospec")
+__xlated_unpriv("r9 = *(u8 *)(r6 +0)")
+#endif
+__naked void unpriv_spec_v1_type_confusion(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	/* r0: pointer to a map array entry */		\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	/* r1, r2: prepared call args */		\
+	r6 = r10;					\
+	r6 += -8;					\
+	/* r6: pointer to readable stack slot */	\
+	r9 = 0xffffc900;				\
+	r9 <<= 32;					\
+	/* r9: scalar controlled by attacker */		\
+	r0 = *(u64 *)(r0 + 0); /* cache miss */		\
+	if r0 != 0x0 goto l0_%=;			\
+	r6 = r9;					\
+l0_%=:	if r0 != 0x1 goto l1_%=;			\
+	r9 = *(u8 *)(r6 + 0);				\
+l1_%=:  /* leak r9 */					\
+	r9 &= 1;					\
+	r9 <<= 9;					\
+	*(u64*)(r10 - 8) = r9;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	/* leak secret into is_cached(map[0|512]): */	\
+	r0 = *(u64 *)(r0 + 0);				\
+l2_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


