Return-Path: <linux-kselftest+bounces-3681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E883FED8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 08:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391D31F23C9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FD4F1EC;
	Mon, 29 Jan 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAOlWLGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3F4EB58;
	Mon, 29 Jan 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512165; cv=none; b=dDI1/ZmaNMB2v4jq5b5opLyp8QSfBYGAIjT9cVmDYoRm1pHDXfllqa5Vq4Z9D3euyUKWnrxTgDtMxoW2n44rzNAS8dxlSIebz0jlKD7X27tTPg05gfHtq9PdCxx0hsfgRc+ZoZfN+DPHKlDiNCtOuQgZZzDgqOniwUgp4pAm+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512165; c=relaxed/simple;
	bh=YN/crB8LXrIiJ4ypxDLISY5HQ8ZJ79SkHHrUg38rISE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BL/snZEoS/KW9RvLB2A4YVDlyXBP+BE1Ur9yoRQ48WuyiEwfitUFVBqpq4GMpzp9rj04KuRwDc2pnODhovVLi1HH13ts+Tt7KAA06y3JdOIPxmZMxa5PcD2Z/FYv4dSryV8pTq4EfXv11nwhxigOJ+JM2Pn6J6OONPDGqljOi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAOlWLGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4DBC433C7;
	Mon, 29 Jan 2024 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706512164;
	bh=YN/crB8LXrIiJ4ypxDLISY5HQ8ZJ79SkHHrUg38rISE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAOlWLGkEeJSt0RqzPRrqaMZ5fLudUlowqKTETIf9YdpFCbs3/TugY3JUa20nzFHD
	 fkPWs/f/CrmJztM0AC3JWbXTQS0Lqzuge9rphGSQyABt1M0KZEv+FxTLLVixVpYq87
	 TwdDHEY7pHjoy+EpEGNg3/dGMiYSNP+Xg1zaPG9O4r9YjzmqJcUeICIrKyOiLsTuBE
	 GcMuOGXp8sFGtRWeq6DPKY5rdo+gAZQnfjDPc1Kw0GBWqkTrqB7Pd0ANSRH74EvUuZ
	 C+nxwdaBs131PqUFXOCtTG+hzIuzV6oou5f1ksVczaiKG9GfOREOsqmshT4NF+Kdnf
	 9B+sWmvLv5JBQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Remove incorrect object path
Date: Mon, 29 Jan 2024 08:09:14 +0100
Message-Id: <20240129070916.1639008-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129070916.1639008-1-bjorn@kernel.org>
References: <20240129070916.1639008-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The glob path, progs/*.bpf.o, is no longer a correct path. The BPF
object files reside in the top directory, or in the per-flavor
directory (e.g. cpuv4).

Remove the incorrect object path.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..830a34f0aa37 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -612,8 +612,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/uprobe_multi				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
-		       $(wildcard progs/btf_dump_test_case_*.c)		\
-		       $(wildcard progs/*.bpf.o)
+		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
-- 
2.40.1


