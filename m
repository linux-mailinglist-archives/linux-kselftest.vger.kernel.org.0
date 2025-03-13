Return-Path: <linux-kselftest+bounces-28971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A190A5FE42
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0061F189DE81
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78AA18A6A5;
	Thu, 13 Mar 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="I2feTtX7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D915172767;
	Thu, 13 Mar 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887595; cv=none; b=Z1q27Zef/hXtIVerUJSRB3v9dJEQHsWHuhRT6YOmwh9hffmppRaxkW6BOFTOapXoYOrg3xCrsaCX48g11PHRQLOT3DB7Mu20oho32SQ5yr1K+339qtgvSiVH5XlYjWfvER/P1TUESbbgkTr+assTVCGscRq1XTfVndzfYa2VME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887595; c=relaxed/simple;
	bh=B0KBCnw2yCEXpkubub/xjcNC00vPbN9ZVdG1ARYgvYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKw41914BxPlJV2tgiH/vso293n0yxriRvk0qPbvuPsDbhm3NJSUkMQRJF8d3pGQ1ltVEyjqI/z6FOAUC5Pg+AR12SkV0UkpHAnjIp628s+OkHnznTvfbdKj7UZTHyNOdumi462vKTDi0uJSVP1q0yW6P0nVf1igAQnQ7sPN42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=I2feTtX7; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741886999; bh=TyzTJDyjEjhuTWC+YeAt2kQlOB+V4PYZZ6Th9P4eghA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=I2feTtX7Au0rx6G7o2ol2PByic4sFahWARoCsYxXMp79Ssb7mulbPxdNQVpmw+4tr
	 dCzNSfkPCVG65PAHTTYS5UArt7QxFVMjUTDUX8utNqwzPehDJb0miHsspmYI765PO2
	 8EqcLIVy2DYlgxSIweDCtq7r3G3h1drAAZ5otuD+HudDyZ5OVaTQ3HCyDqgktT0eDt
	 Y+1FESXMh69QEjYpLkUPrDYmQijZXi43/mu5wnSx/V6oQzDdVxFpNX4Bh/hXzvJc2r
	 MqKTabJCF2VPsVBpDWspcnjWIga4zQ+0MIdQdRwcsUgChihN/rgBW97Z6hHfNyTHeJ
	 5IKHOVZKoct0Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDDyv2xzrz8sjZ;
	Thu, 13 Mar 2025 18:29:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19aVTelOX7AErCo6yoKnt/98T/ktCK6KN8=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDDyr0nnzz8sWt;
	Thu, 13 Mar 2025 18:29:56 +0100 (CET)
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
Subject: [PATCH bpf-next 03/11] bpf: Return -EFAULT on internal errors
Date: Thu, 13 Mar 2025 18:29:19 +0100
Message-ID: <20250313172919.1103397-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313172127.1098195-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
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
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6234d0bb59d6..eb65038682b0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11591,7 +11591,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "verifier internal error:");
 				verbose(env, "func %s has non-overwritten BPF_PTR_POISON return type\n",
 					func_id_name(func_id));
-				return -EINVAL;
+				return -EFAULT;
 			}
 			ret_btf = btf_vmlinux;
 			ret_btf_id = *fn->ret_btf_id;
@@ -15092,12 +15092,12 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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
2.48.1


