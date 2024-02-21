Return-Path: <linux-kselftest+bounces-5191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E785E32E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268CCB257BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF284A23;
	Wed, 21 Feb 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwbLSn6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED68286E;
	Wed, 21 Feb 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532760; cv=none; b=HmJ65YMwo1tAy9o0DGzdWmi7P03+OmMnLVXooy/Tu4xrAIiAaLBRQ0L4QSvMFjXXZPmD0WBk/MrN76LZdP/J7EjughRxWDXZioX2s8WCcUCZ/cb8MQ+yWIGYnwD46aDN41/1L5n31cDe8Mx+Appa16yegqgv++ZMRlxAxoqtMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532760; c=relaxed/simple;
	bh=lWc/Co5ySMroMa/eudRddSJ5CcdAiLdAB0D5VhBoAvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShwC4ssvoRxrDWmEDucjyyqMudCLg3DOetm7tXbr9rUp3QoeUKsMDqOEHOqIJgj65Tu+xF7X0clga9UsVm9wiSAL1JgrQTjcXdf8Hfpfi/0U/w5030Ur1uT8EcWjhs8I2WQDntcBE+/udH/MTHqy8LUiij3MTwQRhAlXHlbbBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwbLSn6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE607C43390;
	Wed, 21 Feb 2024 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532759;
	bh=lWc/Co5ySMroMa/eudRddSJ5CcdAiLdAB0D5VhBoAvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GwbLSn6xfNvIGSAxA1xlvN0b77mdW4g4P25/ipPqgH2WNHi+62OtpMBDANQyXnSim
	 i7ki2gEQlsABylfFaHex6cdNqqkcNT6iK+Arhphll+f+Kv8AUX4oV+Y0dPdUJa2dN8
	 i+1ch7jrLH5E7aobE7omru6fHItFPwFpGEyZwruunze5APqYzEUfI0hS9wV/qH2rZq
	 AhmX7rgXN7xDivI2idAs7nkVppZz86ircA+ZvmWjrfh0ZvdI88UERhKWvV2aQSAGYM
	 +SdvDgsvD9nNrrAEQ8HMpwE77Y55+NJ56EaBDOzfPjplahzraWk4UKUVqOsSMXnt3H
	 /Ca0U1ekgf3Uw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:24 +0100
Subject: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for
 is_bpf_timer_set_sleepable_cb_kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=894;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lWc/Co5ySMroMa/eudRddSJ5CcdAiLdAB0D5VhBoAvg=;
 b=ma84XtgROEN9tdF4Dzdxs29bXjzrN6p+Au89dZQv99gHRtEVfXxzOusC8V/KtrG053LncKsqR
 IKtRuMr0yyuAKjr2zIVovJWW31GKuD6siie2Jkmepj5X7klAxLQuLpx
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is still a WIP, but I think this can be dropped as we never
get to this instruction. So what should we do here?

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4766c43606c4..8a9f268c4ee2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19720,7 +19720,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		if (insn->imm == BPF_FUNC_timer_set_callback) {
+		if (insn->imm == BPF_FUNC_timer_set_callback ||
+		    is_bpf_timer_set_sleepable_cb_kfunc(insn->imm)) {
 			/* The verifier will process callback_fn as many times as necessary
 			 * with different maps and the register states prepared by
 			 * set_timer_callback_state will be accurate.

-- 
2.43.0


