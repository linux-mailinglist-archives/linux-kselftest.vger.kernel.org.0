Return-Path: <linux-kselftest+bounces-3659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A764D83ED53
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 14:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188611F22E9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5A25620;
	Sat, 27 Jan 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTSdU9yU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF51DFF8;
	Sat, 27 Jan 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362413; cv=none; b=ZNJ7LIBVlEQ904i6ynWjwYeH9HJj+htGoTrQavbX0x+IM5+An+jWH3k67uUx69IQiqN2k0AFiYgf7Iafgq+YSVIES7U4H0nKxPYVnUu3L9eFcpKyJicHuz2ZMfKmFKVAdS9O6XE0ZYbJOg0yPULpvDG960YAuhy2T0ISL1jeDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362413; c=relaxed/simple;
	bh=HxytNuJlrtQxQTHqje7b14ETZTAKVN+mgMPY+WYpcIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mni4hcpgUBbY4ASSh4VooJOCN1b7dd3oacGcIpOT57cn8dnG3Cix+1MSw6R6bKS8JNjTMl+bwLxmjD7jkWrT33R2293X4+wbQQWJU76dXiOuIvUt8cDHJEl98jo/ii8B2kE+cA0T6dqzDthFkOGPLMHggyjJKO+UDAFSL9Dk8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTSdU9yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0115DC433F1;
	Sat, 27 Jan 2024 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706362412;
	bh=HxytNuJlrtQxQTHqje7b14ETZTAKVN+mgMPY+WYpcIA=;
	h=From:To:Cc:Subject:Date:From;
	b=fTSdU9yUOu71zNwQm6rcSq0ZeDf4fYdxG0jI8r00OD0iKT1k5kWFYe1k1ZRzPYSty
	 vwBVbTSBmLHYq1d21bsuWPdZF9QBx8y0PxIKjaoU1OLMh6sAM+rmHHr+Pki43AEN+C
	 5hEBM6affWVpzgldoxz0CBJCHRa/nFAb2fyevpbVt9+dYhL7ouzKgCn1+EFeA3oiLA
	 S+pO9gydEoZy3AsEdEDKF9P2vceJpCf7AtpQYC4KlgGL/gTan5PjDWgjMwi5GT0Hq3
	 V1/FdfXxGCdivLwpqDhfb5HFRCjtJM8Xm4WQoTZ6MUIWLZVyekzbaJLD49NZrR4cM9
	 Mvi2Kwdzi6mAQ==
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
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Remove incorrect object path
Date: Sat, 27 Jan 2024 14:33:26 +0100
Message-Id: <20240127133327.1594026-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
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

base-commit: fa7178b0f12e55a4f2d4906df3f25d6d4f88d962
-- 
2.40.1


