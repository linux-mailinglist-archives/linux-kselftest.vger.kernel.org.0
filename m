Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F026FC43
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 14:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIRMM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIRMM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 08:12:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F54C061797
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 05:12:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so5829969edb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXVwRR7S2pJleVE0kWCorjRyqocJMzCr3ztb7Ymi2Ew=;
        b=SNW5q8gA33z3YM3hJCccTZX3qXftewG/1Ojovv+OgMSuWMu4xvjk83DYiRKmJKPUxu
         79qGiI7qzOntdPNF7Z/Ke4kWi4Oqn9JL1XvhB0nFq2sQ47PEyHBYRAotNJIEPGvEB1vK
         lauC4DNF9I37sAlt/dy7vLbK8a1EsdQSNqOuBpnurrXlSxGiepJKkcCj5cgF2Cpi5ZJs
         mX7QKeZPA2/ZWTKzQzYyOJviQ/PBdzfSICIz27rB6AGA+uMmxvaQHAKYeLOjucSazxIR
         dm6xbSs73rjSzpVFVTMcpv2HSrqUJb8ia7PrO1rygV3SbV0KJ1yJ/7mJ8WcoTonXGdMD
         njFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXVwRR7S2pJleVE0kWCorjRyqocJMzCr3ztb7Ymi2Ew=;
        b=QX9swmmYkoP7ZItzTrbNUzcKIpCFZJp8EAI83tWzgCqtSsv1WSdbPKFn2JD74eEl+g
         vUIG6ZduFi+97IDomvDpIMlp+IoZY3ymLQylartIMJEDbd77R2izZfit6oep23BA6a2/
         RqeNjrutUyxYr0ulQTY3kqvExOH1M7xfpr6+Pt9ac6t5gKTkEUXgumHg5z1GMJEDIwAe
         78xCfsyLVAw0WNbJ1T+5qKPw0H1fbjklz11hA29FfdldMIG6hxCOIuS67P+YVDEm4dkb
         l1fjcp3g+5yox+8thJ1z4CQYpfoaCXKmpY/y4icKAG+vUxeDkA820ylOLUSrgTsDiyLN
         RIAA==
X-Gm-Message-State: AOAM531T4xiqe8MuUnN7g8VcEYsMzyg52Ru8Ld62+YdASM2LWTbBEmgv
        YHh7YGwbFQE5u3c8187Lr4jAcA==
X-Google-Smtp-Source: ABdhPJxmGUaT8TP+U5pUQbXG0N2GrQg4GFgTut5xxYZo7j4hR4AafCcvMY2w11MKtB5UCFc8ZL7skg==
X-Received: by 2002:a05:6402:1b9a:: with SMTP id cc26mr37403176edb.30.1600431174231;
        Fri, 18 Sep 2020 05:12:54 -0700 (PDT)
Received: from localhost.localdomain ([87.66.33.240])
        by smtp.gmail.com with ESMTPSA id h64sm2084555edd.50.2020.09.18.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:12:53 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/5] bpf: selftests: add bpf_mptcp_sock() verifier tests
Date:   Fri, 18 Sep 2020 14:10:44 +0200
Message-Id: <20200918121046.190240-5-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918121046.190240-1-nicolas.rybowski@tessares.net>
References: <20200918121046.190240-1-nicolas.rybowski@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds verifier side tests for the new bpf_mptcp_sock() helper.

Here are the new tests :
- NULL bpf_sock is correctly handled
- We cannot access a field from bpf_mptcp_sock if the latter is NULL
- We can access a field from bpf_mptcp_sock if the latter is not NULL
- We cannot modify a field from bpf_mptcp_sock.

Note that "token" is currently the only field in bpf_mptcp_sock.

Currently, there is no easy way to test the token field since we cannot
get back the mptcp_sock in userspace, this could be a future amelioration.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---

Notes:
    v1 -> v2:
    - new patch: mandatory selftests (Alexei)

 tools/testing/selftests/bpf/verifier/sock.c | 63 +++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index b1aac2641498..9ce7c7ec3b5e 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -631,3 +631,66 @@
 	.prog_type = BPF_PROG_TYPE_SK_REUSEPORT,
 	.result = ACCEPT,
 },
+{
+	"bpf_mptcp_sock(skops->sk): no !skops->sk check",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, sk)),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.result = REJECT,
+	.errstr = "type=sock_or_null expected=sock_common",
+},
+{
+	"bpf_mptcp_sock(skops->sk): no NULL check on ret",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.result = REJECT,
+	.errstr = "invalid mem access 'mptcp_sock_or_null'",
+},
+{
+	"bpf_mptcp_sock(skops->sk): msk->token",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.result = ACCEPT,
+},
+{
+	"bpf_mptcp_sock(skops->sk): msk->token cannot be modified",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ST_MEM(BPF_W, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token), 0x2a),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.result = REJECT,
+	.errstr = "cannot write into mptcp_sock",
+},
-- 
2.28.0

