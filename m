Return-Path: <linux-kselftest+bounces-5186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A429B85E313
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F828757F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94F82D66;
	Wed, 21 Feb 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knrL/Igp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F08062A;
	Wed, 21 Feb 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532737; cv=none; b=sveNfKGLBCoDdsZN7MOCJek89HmuYNBON7keO+g2A0P/R9Rl5wYsij17+9iMarpkmg9eqcaJ9ruBTcpIRkom63wCiBzc+ntVc7meUNjSu6Fevl9gAoALNKD3BGW1Su9WaVF2QmidNFGpSZy7DU+VHfeNrNf04KaPyCY1dRmZISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532737; c=relaxed/simple;
	bh=ifZFLSAYIFkAKgWtCvrWc7FBsIzi3tPzHayMgfZ0rSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImKMnDd6/rCXEQgqGjU6gkAqXdIoqccuZAdHgN6i9pqOttUrmc0uo6g0umEORTnkjTn0ltE1V+IQIvUUx7+4CFt76fvovPtySCbtkArL6lVWdtVQ1TRfgGOdIg1FqAyHGjAzdETLJI9902pSNaOb89TUrpyqgHBayVAxumpKJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knrL/Igp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED0C433F1;
	Wed, 21 Feb 2024 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532737;
	bh=ifZFLSAYIFkAKgWtCvrWc7FBsIzi3tPzHayMgfZ0rSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=knrL/IgpI0fD6He4VSAVpXLKpfzHdDdIIfp3hDSxmOe7ZkDiqhvcQ3gzHmDQU3n6P
	 vMcXB41uLn/QxeNf3PWpMnZDCjn8BA51UTWFzHLOCh3fFBa7ZTFFXRpWkDDIvKuGfM
	 75mCSiVsn0lu2nmM+mUwKmkgUyodZanxAgnPo6AgmmLfnsGHMqWrNf/rVHPJaF9/FT
	 L1Cojcf35a/0mqeDkj4BVW537izWdQzIZb9DMSQ26SB4K5ETzqn9yr8ESAaVC0finh
	 rIc//xvetK6+2TNoSMp1cSBIrcvvpQpgkIxAm/JEQKb+wyTKU9f+ugxEGUsREHn2xh
	 SzQuF0qLG8f/w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:19 +0100
Subject: [PATCH RFC bpf-next v3 03/16] bpf/verifier: add
 is_async_callback_calling_insn() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-3-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=1797;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ifZFLSAYIFkAKgWtCvrWc7FBsIzi3tPzHayMgfZ0rSU=;
 b=JIpXu3g0QunAN4Krqvk/yZ3ph5YehKnA1pxkpJWLimDr+7xLD4HesIWBl5fi/gxLdz+IaKjQS
 6HWbJS3t48jANwXHML823DEwFy3apcxCIjwCzfSeuTPrRLWd5Q92NG/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Currently we have a special case for BPF_FUNC_timer_set_callback,
let's introduce a helper we can extend for the kfunc that will come in
a later patch

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v3
---
 kernel/bpf/verifier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a4b19bea2ac..f81c799b2c80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -528,6 +528,11 @@ static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
 	       (bpf_pseudo_kfunc_call(insn) && is_sync_callback_calling_kfunc(insn->imm));
 }
 
+static bool is_async_callback_calling_insn(struct bpf_insn *insn)
+{
+	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm));
+}
+
 static bool is_storage_get_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_storage_get ||
@@ -9445,9 +9450,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return -EFAULT;
 	}
 
-	if (insn->code == (BPF_JMP | BPF_CALL) &&
-	    insn->src_reg == 0 &&
-	    insn->imm == BPF_FUNC_timer_set_callback) {
+	if (is_async_callback_calling_insn(insn)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer callbacks are async */
@@ -15588,7 +15591,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_timer_set_callback)
+		if (is_async_callback_calling_insn(insn))
 			/* Mark this call insn as a prune point to trigger
 			 * is_state_visited() check before call itself is
 			 * processed by __check_func_call(). Otherwise new

-- 
2.43.0


