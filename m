Return-Path: <linux-kselftest+bounces-9591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F328BE419
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C55288A47
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2A915EFCD;
	Tue,  7 May 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVfvXmDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06689156F20;
	Tue,  7 May 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087988; cv=none; b=rSFjQnoV5nty1p9u9JvJDtw+kj3EQpWLY+dpwQTikhlXAPZIqcswiStuVokJl1vj7sjc1h/jwvMwkeqVMzeXpTlD65mLzx6tkfAYwFEujN60dTWyP/K+99979FLqKJFyqxK4kwRn8nupCqKDRQT7E01RNY/ys9wkveQZKwoafrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087988; c=relaxed/simple;
	bh=isqHF8HeC8KRWX2yMwQXkLMgFKrRtCaj9HjYSmd5hgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwrAWQEgU6774txEwzOFpPQjbDOiu13hT55MXhNE0sJa7tPFCETyTJWxVaGkXhA7YGz4Vv2HSucMPAJOvpzHfOdialT/2RNiY0uDSrVh2BtN33fRsrtYouwgDWRIbQVSYpnvOiGE/BW9k1Bkl7bJn7xkMo5EJGJM9FgAX0yse3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVfvXmDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB22C2BBFC;
	Tue,  7 May 2024 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087987;
	bh=isqHF8HeC8KRWX2yMwQXkLMgFKrRtCaj9HjYSmd5hgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OVfvXmDQMt7A0kehOhD20thI4YILIa2gsWLgP+ZQg2rnbPe0BuMSrdX/OfP6ZAJ3V
	 CcipwCRBdjvZWaSl2O3WEfoMg/qph0ckxaQ4Ur97A37bkAEbfL3/W+AmVKuyTEu93Y
	 Qs5Jb1Ma8AeyeI+I2VfTAzm1UYp4+sBF4QQ42127o7VDUbbh3vC/s3nZBiL4NOToQG
	 C3fpyeYuzRbPQQ1xXYBJddInSf6grtVjkWvrratJKQQatYXOehprAw73COpQvNoCNy
	 j6xrpEBJPMh1FmPrqNNv7xDx1qh1mXEkMqS6hcuxQSJZxG1KgDvBsHFXY0Jyct31CR
	 A+Er9GRlfbrlQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:29 +0200
Subject: [PATCH RFC bpf-next 1/8] bpf: ignore sleepable prog parameter for
 kfuncs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-1-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=1501;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=isqHF8HeC8KRWX2yMwQXkLMgFKrRtCaj9HjYSmd5hgA=;
 b=k9rUZ8hFqZ1a4Otx1zvx4YybpnqH1zKr1uzHypliJVTIkPrH8HhUQncGvx39vaTB8CsEPXwbL
 L9Lx6klBAfGCaUsqQIF6lcEu73FyZlo049Px7cFVg1Fd+5G54E7eMxj
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

There is no change of behavior: for each kfunc, we store the prog
sleepable state. But this allows to declare an async non sleepable
callback from a syscall, where everything is sleepable.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d42db05315e..856cb77d0f87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5288,8 +5288,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->sleepable ||
-	       (env->cur_state && env->cur_state->in_sleepable);
+	return env->cur_state ? env->cur_state->in_sleepable : env->prog->sleepable;
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -20722,6 +20721,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	state->in_sleepable = env->prog->sleepable;
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
 	if (!state->frame[0]) {
 		kfree(state);

-- 
2.44.0


