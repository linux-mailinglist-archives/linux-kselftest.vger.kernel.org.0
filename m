Return-Path: <linux-kselftest+bounces-21089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C99B5FA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 11:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39E3B22B47
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3331E32A9;
	Wed, 30 Oct 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2F9aeuq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFE1E25E0;
	Wed, 30 Oct 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282492; cv=none; b=M0aVZt7hHkXPKSgbc1U01rjJKS+Sc5FQVI834O73BSX3A34+swjcyAAB+dFswL4UrnAvaCbKKqoLE1S2h2AEC6q3g07n0pvEWLXdYVqcoQO6+xcIvSvROrWF5cwYCd30p1A/z9A601sM6ZPI3TYY3LA8H9sp/1jMPO14VnIk9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282492; c=relaxed/simple;
	bh=7Lb9jgXBsueULSwXmVHO9S0yQGKVhSQ+fOmcIjWvodw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOwyHHgx5UZ/O/LsD2j2RbWqurKH5qhzLuCK0ZNIkdgFA506tSOfy9aG1Ybt4eIqpIAVQ6e2+i6qHaOhjuJl1ZnpJ+7fiX6GhI8glxilMN1XA/pRmk0WOrI3fpa23/igcXkIizlst1CT6TcDcdIL9e0uMfcIJd0+JOkA4bWs4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2F9aeuq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so5216254a91.0;
        Wed, 30 Oct 2024 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730282490; x=1730887290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AzW1atrg/A1gulnP13fPkOgabCdL8saqqVxwhxHSn4=;
        b=U2F9aeuqsZk0lyjsr4T3OSGDggYV0+fiXcDjdCRjJ0xZrDAqsCmsEOGiDb5kseGy53
         zxmMwd8YQL8RBAw7e7V3LvBWSjQn3wSs5pOmC+PLXuL2ggxd8PAJzf098Bh8s1m9CaBb
         KG3QcIPWup4ZxVEIUWrjWuGkrt45iuOkoQpV3jN/3aomR8Tq/GbfcLVNeENsifAtDH1U
         a7YUAmMipve0THjVFw+JzdtitsqNvxVaxMUlYne5Seoe2HxpB55TpCdgrVRnW/Uy+zNn
         8yBGr7ChYWCaHnpWZYDV8IUYC0hZGQ5WIK9q+90OtIwfwbQzX0KzNzmSWloZyKPDR1aY
         S2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282490; x=1730887290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AzW1atrg/A1gulnP13fPkOgabCdL8saqqVxwhxHSn4=;
        b=tSBoVMhUCQTs8nLz73arHPMdzcNIGe1C54l0vcDpY14LasdqZL3fwXVQAPPCThTg/s
         zxrOFqsTFAxVtGCuhhGiS5P5W16NlTU+G3dt5FUAoPBLiBwKFdxAW5FoSWTGT2wr5j56
         Y2DuEWC7YjNrZId3UsykKo0nI9l2my5ltVlyFt0/0ys1MC/Tp37jDijEhPyaBlAXOBbM
         9XocBPexgWxNR9xUB+juVEZA5TTb9gFlG6vrC0sErpnYRQmU1EUplk32rsXhdyPD7Sdf
         R3kBl8+R7M6DStlRJrztCca8ftSXtoHlB7N+MDrIHk9KMXXSpP+wG9IVvW/k83mmeTcr
         vOWg==
X-Forwarded-Encrypted: i=1; AJvYcCV93U7ONck6J7nE6hk9RmIIJDXkr6CQ/j8+QZBKSQfublcj0YDeKsVmEcGWZ7bBkLgzr0sken+RirtY2ax3Fzp4@vger.kernel.org, AJvYcCVDtSLxxuLObo4rCuRtbAqz+d9z2b1jIKrWbVMojAMNymgCg3s3bJFb482EnBXlA/Dv5CBCXhAtu6tCQAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPvQ/zwqxkTLtuN38/dXiJJv5Ev764GCz4PWccGqtqxDeg7FQ
	Hd0+rsQtnonaF+Y0VwkMSiB4+L+T354rjVVqjcjJ0XpupKYaekIx+aGDuQ==
X-Google-Smtp-Source: AGHT+IEEymCR2vDG/9y53R5Zf9cd1nP744F8u68gMP4feSlmPSZtEdAZ4OCPtMvXE5+WpvBw4aF6Kg==
X-Received: by 2002:a17:90a:b305:b0:2e2:9038:4a48 with SMTP id 98e67ed59e1d1-2e8f10a6e39mr16216607a91.32.1730282489470;
        Wed, 30 Oct 2024 03:01:29 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa3dbd2sm1294830a91.20.2024.10.30.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:01:29 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not support
Date: Wed, 30 Oct 2024 18:01:08 +0800
Message-Id: <20241030100108.2443371-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compile error when MPTCP feature not support, though eBPF core check
already done which seems invalid in this situation, the error info like:
progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
tcp_sock'
   49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?

The filed created in new definitions with eBPF core feature to solve
this build problem, and test case result still ok in MPTCP kernel.

176/1   mptcp/base:OK
176/2   mptcp/mptcpify:OK
176     mptcp:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index f3acb90588c7..2f80d042686a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -25,13 +25,23 @@ struct {
 	__type(value, struct mptcp_storage);
 } socket_storage_map SEC(".maps");
 
+struct tcp_sock___new {
+	bool is_mptcp;
+} __attribute__((preserve_access_index));
+
+struct mptcp_sock___new {
+	__u32 token;
+	struct sock *first;
+	char ca_name[TCP_CA_NAME_MAX];
+} __attribute__((preserve_access_index));
+
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
-	struct mptcp_sock *msk;
+	struct mptcp_sock___new *msk;
 	int op = (int)ctx->op;
-	struct tcp_sock *tsk;
+	struct tcp_sock___new *tsk;
 	struct bpf_sock *sk;
 	bool is_mptcp;
 
@@ -42,11 +52,16 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!sk)
 		return 1;
 
-	tsk = bpf_skc_to_tcp_sock(sk);
+	/* recast pointer to capture new type for compiler */
+	tsk = (void *)bpf_skc_to_tcp_sock(sk);
 	if (!tsk)
 		return 1;
 
-	is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
+	if (bpf_core_field_exists(tsk->is_mptcp))
+		is_mptcp = BPF_CORE_READ(tsk, is_mptcp);
+	else
+		is_mptcp = 0;
+
 	if (!is_mptcp) {
 		storage = bpf_sk_storage_get(&socket_storage_map, sk, 0,
 					     BPF_SK_STORAGE_GET_F_CREATE);
@@ -57,7 +72,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 		__builtin_memset(storage->ca_name, 0, TCP_CA_NAME_MAX);
 		storage->first = NULL;
 	} else {
-		msk = bpf_skc_to_mptcp_sock(sk);
+		msk = (void *)bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
 			return 1;
 
@@ -66,9 +81,9 @@ int _sockops(struct bpf_sock_ops *ctx)
 		if (!storage)
 			return 1;
 
-		storage->token = msk->token;
-		__builtin_memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
-		storage->first = msk->first;
+		storage->token = BPF_CORE_READ(msk, token);
+		BPF_CORE_READ_STR_INTO(&storage->ca_name, msk, ca_name);
+		storage->first = BPF_CORE_READ(msk, first);
 	}
 	storage->invoked++;
 	storage->is_mptcp = is_mptcp;
@@ -81,8 +96,15 @@ SEC("fentry/mptcp_pm_new_connection")
 int BPF_PROG(trace_mptcp_pm_new_connection, struct mptcp_sock *msk,
 	     const struct sock *ssk, int server_side)
 {
-	if (!server_side)
-		token = msk->token;
+	struct mptcp_sock___new *mskw;
+
+	if (!server_side) {
+		mskw = (void *)msk;
+		if (bpf_core_field_exists(mskw->token))
+			token = BPF_CORE_READ(mskw, token);
+		else
+			token = 0;
+	}
 
 	return 0;
 }
-- 
2.43.0


