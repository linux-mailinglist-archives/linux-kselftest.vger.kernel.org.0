Return-Path: <linux-kselftest+bounces-31244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E10A94EB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4461F3AAC80
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52452135AD;
	Mon, 21 Apr 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ZNoe6BCl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A391DA62E;
	Mon, 21 Apr 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228028; cv=none; b=YIliCSW+ztuEDDJBx9LoPvj60Eeat8WmwjJ8Z6BIdOqYwyrWcq6mw46g8pScj7LzzosmBbXZ6zTsbzeezQbUs4BN01uJt98WQz40enTaryq/dQs/xGICaW8g/xf30RzyQyIg4cCuujMlsb8oDd/zfDUkMmRK8/czqJAFtgKTFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228028; c=relaxed/simple;
	bh=AjiLQSurYGYFui7FZ4Kvgm5WBn3PPg41yRmc9IaTzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTszs3Zqo6vr8QjS/Ii1UMZq24LvNM18GbQqknnH2vUkHHr00UCzVMVQxHSYlExOCptEjR291f0Wp3TczXpBJNRBjdGTvOYCVwSLoXIPF7NJn8qMhFOaLDPlXzkmw9VVskS9cUpXWu+5hoEx4/EbO+xFI22MTDT5VRg9RFJdIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ZNoe6BCl; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745228024; bh=0fW+/UjdGfFnzd+EIbCwouM/Fsc8JmJBl2eRcLAaljY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=ZNoe6BClon1RARJg/EpFcIiTktCOgSbom2/RjSc35KJ5bEKxScaX3xLtqUPt6W7AS
	 UH5oL6iZOW2a6Oz/5QsgBgCQgZmt3yb1CfKdpjBHmjEMWUZ0s2DLbvJZBwXQG7IAN9
	 4CPCzwKc6FOm2oJrgUGAUW1Z7CNhjN66b4FKNSJ8Z23+Kh1aeTkvuiJE4B6vtFbMnP
	 P0vDSqeT6JKTLsUkn27pW7BVZZAhT9w3m5UoS9bIPYX7/he4jsdjB4+h7do/W1v43Y
	 f7jpakn0dcYHWXsXZAkiBve1N+4/WnEAaiWN9141VAdoGMB7IRmNPG7W1RywNgTugr
	 s5LprqqNUoqew==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zh0YN440yz8sm5;
	Mon, 21 Apr 2025 11:33:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3600:7e00:5b67:6b9c:caeb:75c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3600:7e00:5b67:6b9c:caeb:75c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18Mub6EG2EVYPnJoCjswmi392jCPxuiAAw=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zh0YJ60Bwz8sgG;
	Mon, 21 Apr 2025 11:33:40 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 04/11] bpf: Return -EFAULT on internal errors
Date: Mon, 21 Apr 2025 11:17:55 +0200
Message-ID: <20250421091802.3234859-5-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421091802.3234859-1-luis.gerhorst@fau.de>
References: <20250421091802.3234859-1-luis.gerhorst@fau.de>
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
index 55c1d7ada098..27d3bc97a9e0 100644
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


