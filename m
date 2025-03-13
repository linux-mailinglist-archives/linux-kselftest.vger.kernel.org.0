Return-Path: <linux-kselftest+bounces-28979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCCA5FEB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A85A17C4B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58711E8353;
	Thu, 13 Mar 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="AxKMmKCQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD21DC985;
	Thu, 13 Mar 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888664; cv=none; b=sBQYu5leWmorp1Fol35+eAkSEMjWujTBVkZK9jf3wOt2wVUHgPJjPikO+WPZdmOmIwj9OHiFsPvBx2LCKIezZMVZJzeA5SziJshQIDx0dUHDgCdCECAQNPS4lvoQnms6w8XXCx+BcZbm5WtkRudaf2dIpL5UcVTERPv80p0jXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888664; c=relaxed/simple;
	bh=9xFIBcjTWv8GRNX3oe1hCJyXa1xOTn0VkkaumuBVgRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkcaqrVUmPQ3ZRrndJBV+GxCv3SwIffvOFN1jXV1sxLQ/DzlcEA+6920EjpYNXEE29toYl9N9H1XYgZ307MRSJffTxrxyp7RkWkgqEWssjmYz0uvDI7SUDrsQrfGS9nTHMaJExCZ1ZRZQDy1Fk9Iga+vc9iG9xO/8o2dqNlfsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=AxKMmKCQ; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741888660; bh=inXF0fSbPXzIw85fLojKxfeAwoCHVSrQnIcBk6Xmr0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=AxKMmKCQ/tUIryjmV6bln3IsP87BGHN2B6gCMBY0/d23v1QncY7Fg4tvz9Ply2c2E
	 EtZ9j5hk/a93x8xbTIDeFfX4xhjnAVkRHkqxR8JXcWkfYBYn7XqIDdRKjBW5K87Ulo
	 CNJgfqkZkXshsU8mgMnsK14BhABBlO4wuzXR08U5aw0PIYhxgH+zSWNXs1ZU6RpevA
	 c5zAnwkfBTXgRsb0ihRA3j+8KZaIVNDtvH5S/9CVFPq29NX+vt8ZOFeBQn2HXQM5tN
	 9k0MxlQGKreHFKOYa/LE6axle2cpz397PbIJD/cx26VfVqozGpfawjRItUXG8S00o0
	 WqDysq/Kj/HAg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDFZr3T6Cz8t05;
	Thu, 13 Mar 2025 18:57:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+HSEbJ8SZ+LQGIWIboOg0KFAeQEvQjoXs=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDFZm2cS5z8svD;
	Thu, 13 Mar 2025 18:57:36 +0100 (CET)
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
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	WANG Xuerui <git@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next 11/11] bpf: Fall back to nospec for spec path verification
Date: Thu, 13 Mar 2025 18:53:12 +0100
Message-ID: <20250313175312.1120183-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313175312.1120183-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
 <20250313175312.1120183-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This trades verification complexity for runtime overheads due to the
nospec inserted because of the EINVAL.

With increased limits this allows applying mitigations to large BPF
progs such as the Parca Continuous Profiler's prog. However, this
requires a jump-seq limit of 256k. In any case, the same principle
should apply to smaller programs therefore include it even if the limit
stays at 8k for now. Most programs in [1] only require a limit of 32k.

[1] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
    Precise Spectre Defenses for Untrusted Linux Kernel Extensions")

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03af82f52a02..49c7e2608ccd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,7 @@ struct bpf_verifier_stack_elem {
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
+#define BPF_COMPLEXITY_LIMIT_SPEC_V1_VERIFICATION	(BPF_COMPLEXITY_LIMIT_JMP_SEQ / 2)
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
@@ -2010,6 +2011,19 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;
 
+	if (!env->bypass_spec_v1 &&
+	    cur->speculative &&
+	    env->stack_size > BPF_COMPLEXITY_LIMIT_SPEC_V1_VERIFICATION) {
+		/* Avoiding nested speculative path verification because we are
+		 * close to exceeding the jump sequence complexity limit. Will
+		 * instead insert a speculation barrier which will impact
+		 * performace. To improve performance, authors should reduce the
+		 * program's complexity. Barrier will be inserted in
+		 * do_check().
+		 */
+		return ERR_PTR(-EINVAL);
+	}
+
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
 	if (!elem) {
 		err = -ENOMEM;
-- 
2.48.1


