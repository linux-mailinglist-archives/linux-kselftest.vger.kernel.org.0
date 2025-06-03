Return-Path: <linux-kselftest+bounces-34258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A8ACCEF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587FA1888BA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53D226863;
	Tue,  3 Jun 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="R3pPMiSf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB722579E;
	Tue,  3 Jun 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986111; cv=none; b=UkxS8CTdCjPpYJCz4X3Dgf5WBn6kydciJHm6j9CCsoxBWe/RAgIlEi6Iecu2aFEFEEk2HXfVj1UvBY/XXijQwbvt+hnDRTS+rKbxabQjJT+51agtdYXR5dXFm60sgFMWPKymSacXTc0KB83N2jR73WuyyBs2vnttFUuBr8cmFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986111; c=relaxed/simple;
	bh=91X80LvGHfH90x/qxrnpS8bkmAvt6UUlA5rRQzLZg/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAGDMLJYjxnaHK1y80D5bTUufSvegHgv5Td4LNrFP708rglaNu1xDwJBy9xGsRbmiTSZoLBF/WHJGRD7/RgYk3yzeyUFqmN3txRVSrHAqqzSEkik+vRUFSKBWCwDMs02WtXgGuCGhOJB1TcevLWwR50FnB4uDOmPvIoHE7RQq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=R3pPMiSf; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748986107; bh=ARpytHsyfivjxGjflz99PobPaQ/Mtr9Wv+8PNmUUgKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=R3pPMiSfvWBr9q+phUTH/uIaiJTRngnHfV38FDKrEu0rWW+NROPwI97cQI7vvjF9b
	 QlyUwWpcjrB479J15KVsC/l25vUlnmyiCTosRvJ2hJOtB7Ds9aJObDxXllxWOhaPh8
	 YZre8UFpOFSwEEB9f0BZtu3V6yc+qQt878BdQqa2kxcqpCbIfrOkEDgXcvJd0cBB47
	 QfCCl0tiF4jeF8x+TUt+UUU8xvyOgWNbL+Xc3T65ZjnzZWH5jnWlhreysMVud+aA/U
	 vKr1XiZC/4YJUdN/IdteEihDFKFaeCRI48HciCVZ9uM7rWMkpiKMlLhVpI1pBrIE3j
	 OAviOnKmghToA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBkNB6ZfkzPkZc;
	Tue,  3 Jun 2025 23:28:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18910nUSGoVfudKBySRew8N0fTZeQak0HM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBkN73X7dzPkPR;
	Tue,  3 Jun 2025 23:28:23 +0200 (CEST)
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
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: Add test for Spectre v1 mitigation
Date: Tue,  3 Jun 2025 23:28:14 +0200
Message-ID: <20250603212814.338867-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603205800.334980-1-luis.gerhorst@fau.de>
References: <20250603205800.334980-1-luis.gerhorst@fau.de>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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


