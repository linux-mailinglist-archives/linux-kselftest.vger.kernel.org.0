Return-Path: <linux-kselftest+bounces-48028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BFBCEC696
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B65CB300CAE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900352C08BF;
	Wed, 31 Dec 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SWgzDxwL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64F2BE62D
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202651; cv=none; b=fr2iW2CUv+M5qvdteLCshaOdMsPHbTeYhikebBY5/tlnbc4by7dTPjLwgHOmZGL6JmfFic2aGCxe3JT25eSg0iP2vcPcuhOB7ITgdzSSalqooLDN/srusreno1oc4raGgk/vNekAbKqW4rHoCVXkGr5HveCGll8nnBHewXL6ugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202651; c=relaxed/simple;
	bh=+qs2O0p6JSmasUPfUb0PrNjt2zEzZFmnX/PzeN+aGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=braALlpEmqVp0+Ozg782h3hdNmZlawR0JYpbdv+i+TDEUeONNKIQp3mTbNJL1wCSl5rRzTYUbe8cH+VfCfBF3Gn6VeTyB276/jakk16E5oquWiEIJT6qtIM9GTWE0KUSQpZkIxK96PGTSysrtItFOkf72r5S2rN+SJGrqHtL9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SWgzDxwL; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-37baf2d159bso22697191fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202645; x=1767807445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evGP5W8eaS0gGQmtryNYpPPxNCoy7QWmqYRyuLboZRo=;
        b=SWgzDxwLxk4IHhdqL7am7ZWGGW/UgDtLxQpB+RB2EAoNRxqgf0pqEqmrgtUSkdLEOs
         s3Kz+33lY+oL4kuEITZl7eHMAgn7Z0tA8qWlvOJW/g5YHix/fJvLf7GxnpeR/5Wx+loX
         EqeygASMuZJ+/kDPe0vQKeT6WA2TTwLacxgqR7Z6n9C8JQIDlN9eWnMNIegX6MwfmQKC
         /no0mibjlmypLz4CcnP/45nRK40FnjnrNvXp7r0oy0nHxRMYUbu6hAVFmlqkbnpFcnnp
         SRgM6+mle0M2/xjOs2M+YzOw9VAQqBl48FtLV8KP9ptlwe46UYXjP5i/SSXaeqELQypW
         UrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202645; x=1767807445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evGP5W8eaS0gGQmtryNYpPPxNCoy7QWmqYRyuLboZRo=;
        b=t53egqo/xTMt3AuD/HRnZKA/bUr7KgSLMcQ/re3kiMuYIRFjxf91g9ci5vZx37m2FC
         sGFCzqK6XjbGY9c/22eaXKPKbTyphwGqFOUu6/YUIv+7HvDrGQ1f89bdQCePx4hZ/3/r
         BogQLrgpyQ/ravY5jawUwMvhMA7u+SEAwMf54ncQrRtSqRHCr7dUvJUf6vkjruCSsZMR
         BkFEv+EQSR80gIytjiVREFpQDDh1jwqKDsj8KWLNBMjrJ0dqZYATuqdH+Gc5EvTeVdMd
         Deo004p+/Xh+icpvDAbzXsucDYa5GkvuGFRBe9YIJw3fBTpra9H+mpP1ejSzd2bV4/Y1
         loWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9rOjTx6UCHP8sDj9CJoosEHUJZKTbTME76f7DrUMBjgnjJzKSW61gTqa6f6xnT7gtQA2XMk8TeokVBCmEOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0VBBnq+QBkQMVRW4GtLjgIngH1QA+31Lg4gHEklUHQil6jcu
	HUzcZgxvSsmfwK4Rm2h4y2k2LIoMHpV3MF1/j4rZweFfnCuZ1rxjJNcnNNA5n+ShThz0KB63kJT
	eB3MKHTS4fxY2+vnlK/BVxDfbrngwJHR1AwIo
X-Gm-Gg: AY/fxX6cDDvSROkCYZubGujobVaoKuQ9cIvw8vgw2d4jqYsFsRpcj1xwdTrt+VvHAjT
	jW/CS1fVDM74OEKOrRyj9P85msUQmbcGdBlnkEE2ONyHdILFkOfymojyWjOLxUzNjk0pFsAjNkC
	riQiDql3Bx9zlfozJKeMuvxhWqlTS/umv7bzd/3po36BzYxiJnPV5dMygjqdjB3Pa253OXFkyBd
	xerAMnxZNbgfRQg2y+QCL0HdA0RC8Dtsw3En4hf6DD+gkntfNG7PABR2dS7yDYACaRwE+Q0DcTV
	pCsP8d/FBPJC4knwDtM2AFmcfte+3E6qRSgUYgHDcFy6KRNG3PQuylNt3HMeKmo2wbg0LaT2kOR
	mfEfCYe5JyiwHSKrA1j0a6pSHgCTr+cnsietJqi13tg==
X-Google-Smtp-Source: AGHT+IH27R9QYE1O2Ywp3/SP9pHkjO2yXz4EIipzqt9GsBoAsX+S1qf9N7p0ezxigbjNdJtb7dYT0W/PMzz9
X-Received: by 2002:a05:6512:2388:b0:598:e3ed:b43e with SMTP id 2adb3069b0e04-59a17d75aacmr7318962e87.6.1767202644708;
        Wed, 31 Dec 2025 09:37:24 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-59a18641fe3sm7185875e87.60.2025.12.31.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:24 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C9BEB342241;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C3D39E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
Date: Wed, 31 Dec 2025 10:36:33 -0700
Message-ID: <20251231173633.3981832-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __test_no_cif_ops, __bpf_testmod_ops*, st_ops_cfi_stubs, and
multi_st_ops_cfi_stubs global variables it points to as const. This
tests that BPF struct_ops implementations are allowed to declare
cfi_stubs global variables as const.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 .../testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c |  2 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
index 948eb3962732..1d76912f1a45 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
@@ -39,11 +39,11 @@ static void bpf_test_no_cfi_ops__fn_1(void)
 
 static void bpf_test_no_cfi_ops__fn_2(void)
 {
 }
 
-static struct bpf_test_no_cfi_ops __test_no_cif_ops = {
+static const struct bpf_test_no_cfi_ops __test_no_cif_ops = {
 	.fn_1 = bpf_test_no_cfi_ops__fn_1,
 	.fn_2 = bpf_test_no_cfi_ops__fn_2,
 };
 
 static struct bpf_struct_ops test_no_cif_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 90c4b1a51de6..5e460b1dbdb6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -295,11 +295,11 @@ static int bpf_testmod_test_3(void)
 static int bpf_testmod_test_4(void)
 {
 	return 0;
 }
 
-static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
+static const struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -1273,11 +1273,11 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
 				      struct cgroup *cgrp)
 {
 	return NULL;
 }
 
-static struct bpf_testmod_ops __bpf_testmod_ops = {
+static const struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
@@ -1300,11 +1300,11 @@ static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 
 	ops->test_1();
 	return 0;
 }
 
-static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+static const struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
 	.test_1 = bpf_testmod_test_1,
 };
 
 struct bpf_struct_ops bpf_testmod_ops2 = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
@@ -1547,11 +1547,11 @@ static const struct bpf_verifier_ops st_ops_verifier_ops = {
 	.gen_prologue = st_ops_gen_prologue,
 	.gen_epilogue = st_ops_gen_epilogue,
 	.get_func_proto = bpf_base_func_proto,
 };
 
-static struct bpf_testmod_st_ops st_ops_cfi_stubs = {
+static const struct bpf_testmod_st_ops st_ops_cfi_stubs = {
 	.test_prologue = bpf_test_mod_st_ops__test_prologue,
 	.test_epilogue = bpf_test_mod_st_ops__test_epilogue,
 	.test_pro_epilogue = bpf_test_mod_st_ops__test_pro_epilogue,
 };
 
@@ -1715,11 +1715,11 @@ static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
 static int bpf_testmod_multi_st_ops__test_1(struct st_ops_args *args)
 {
 	return 0;
 }
 
-static struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
+static const struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
 	.test_1 = bpf_testmod_multi_st_ops__test_1,
 };
 
 struct bpf_struct_ops testmod_multi_st_ops = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
-- 
2.45.2


