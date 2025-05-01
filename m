Return-Path: <linux-kselftest+bounces-32070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF7AA5B90
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 09:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770C77A3DD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 07:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B90270565;
	Thu,  1 May 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="GU6OaxPb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCE18641;
	Thu,  1 May 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746085708; cv=none; b=EUdJWHenpMQC2otm3fvWvaupAMYwOrShcS8yn78hKsqwjAlN3K+rYEbSxFp/1wzkpn23kLGXs+B+A1joZKO3xNsNIUwHYADfYKQyyiuaYFM4nkzgT40/VhDoPCvfSoevZOTLSLAP+YivwP37+L8s/guFMIbSBm2yicMitnVIVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746085708; c=relaxed/simple;
	bh=brUGLvZEs++6wLvCNNOG7rVsnqLnFxn2n8az5V+kYkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTqsYjx2r6tWA/9GpqNjJYRmeYlmUEmPhMNFH/DiHjySq2ejbaIDGyXBlxcgbiF27VlXMUaUEDHJeekJAjJGp2WGBA0bN23KU1ex229GZfb8m7/ADwiAy6nCVS6fDMl2Cc4+ufq6jbIZh/NQOPonSpTj9dpqIrEHur1bJJ3dbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=GU6OaxPb; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746085704; bh=0Pu9rHLu+wQI/d+zKWBJoaB5ShQT0yttj33DmrGvKIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=GU6OaxPbrdxAiiihdkKp7RS+GqJhi3h1zwYaSEZ0zbWQ8c1423FfKYx77N4AuN0Wk
	 MaEB0ckZH9eKutBKS3jgB3Ha4HKL/X7OHqyQvfHC5U8RNbfCsapOgR2zz2z1uv9Ig5
	 N7R2rUq0YmY/g91HngbMWfuJAJ7ty9a9d1RD/CKLebw3iST/1MrV3v/lSRUiz5zGW3
	 6xlOxfRkKewHuYSj7g7zoGWRxQxl2VNJ706A6IYlVkamtmzExQF6tmX1xQG3P9ik+W
	 YW6jY3gNwika4C81cj5rO6rwsbS5IVo0KN391JrzKs0H9KqO3jIbHciWrzwyUZFjVL
	 gJLdD5Iv0lT0Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zp5lD2znrz8ssD;
	Thu,  1 May 2025 09:48:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3636:a700:12b2:e53f:6cbc:f48c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3636:a700:12b2:e53f:6cbc:f48c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/54KqmiSgcn6S5Oa0/ZGbqM5On5wTcHfI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zp5l85rWJz8sjW;
	Thu,  1 May 2025 09:48:20 +0200 (CEST)
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
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next v3 04/11] bpf: Return -EFAULT on internal errors
Date: Thu,  1 May 2025 09:35:55 +0200
Message-ID: <20250501073603.1402960-5-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501073603.1402960-1-luis.gerhorst@fau.de>
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prevents us from trying to recover from these on speculative paths
in the future.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0975169134a..9c921867f77f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11667,7 +11667,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "verifier internal error:");
 				verbose(env, "func %s has non-overwritten BPF_PTR_POISON return type\n",
 					func_id_name(func_id));
-				return -EINVAL;
+				return -EFAULT;
 			}
 			ret_btf = btf_vmlinux;
 			ret_btf_id = *fn->ret_btf_id;
@@ -15261,12 +15261,12 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	if (WARN_ON_ONCE(ptr_reg)) {
 		print_verifier_state(env, vstate, vstate->curframe, true);
 		verbose(env, "verifier internal error: unexpected ptr_reg\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 	if (WARN_ON(!src_reg)) {
 		print_verifier_state(env, vstate, vstate->curframe, true);
 		verbose(env, "verifier internal error: no src_reg\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
 	if (err)
-- 
2.49.0


