Return-Path: <linux-kselftest+bounces-3582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3983C772
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DAA1C24696
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6E74E0B;
	Thu, 25 Jan 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daxFFWfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24237633EC;
	Thu, 25 Jan 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198718; cv=none; b=VhbafeaabGCYZiGxmT3k0+iAcdVFeXqAoC/kTSIUXUYoRbHxpLWH2XFfV6QgynJHPKJhG2blDyWrMfh/mbJqB8u1ot/z0zXG1Sh3YvygB74Z7/ISLENohqHlHVpTZjpZ291Owqkdyc9ZT2VBx6rHqZEMnmAaXhC2dM04BxxGfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198718; c=relaxed/simple;
	bh=MRGnGuzapGA9vOYUFqgizcht9g+TsWG6i/tZwigQoRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kumd1GLTvKwmaXu6bHfSUBZhflPoOg5cgtc7twzqIS79e8eLjXS1A/8Ybx312LVOCmtK7d+X5S207NEP9hhCJFu8qp4TUP7hBOmfiGHcCf7GtW3I+Og4VlxxpdxdW7p0M5ifHdwYksQKXxN3JLi+rA/nlpjFwzJcxr8WipKcDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daxFFWfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13300C433C7;
	Thu, 25 Jan 2024 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706198717;
	bh=MRGnGuzapGA9vOYUFqgizcht9g+TsWG6i/tZwigQoRo=;
	h=From:To:Cc:Subject:Date:From;
	b=daxFFWfxY3N+31W9LgvsSPqPEJR00tIQ7fITVaroZHA3ZyockvUtYZlYlrIsWT4u1
	 /6oZpwZca/ESzfp+JCfXrI5q3UMAG3uxEYWLrSI6JcF9RMDdgHLZnFvdf/FsFQDfV5
	 Vy5DUyABhV2Amr/bnWMga6fEEphx20qEBmovpLO0AItdn7z4C+U7d/SoEHcuvIKyet
	 9rla4kHlu+hxkzASzZ9evH/agJGxkxeXRUFUgCYFIF4h9KGLnj5R8GGqGT/9UhrXTd
	 N7kvBzGIPCo/AuB5Fh4l/qVFmOtXca+XgPu0Z4vT7aLJilRuqmHlFz5WCZlk6cvLJY
	 EwOyKkJDN6rbw==
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
Subject: [PATCH bpf-next v2] selftests/bpf: Include runner extras for install target
Date: Thu, 25 Jan 2024 17:05:02 +0100
Message-Id: <20240125160502.1512422-1-bjorn@kernel.org>
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

When using the "install" or targets depending on install, e.g.
"gen_tar", the "runner extras" weren't included for the BPF machine
flavors.

Make sure the necessary helper scripts/tools are added to
corresponding BPF machine flavor.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: Added btf_dump_test_case files
---
tools/testing/selftests/bpf/Makefile | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..d5cff32997b3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -744,8 +744,20 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	@for DIR in $(TEST_INST_SUBDIRS); do		  \
-		mkdir -p $(INSTALL_PATH)/$$DIR;   \
-		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	@for DIR in $(TEST_INST_SUBDIRS); do			\
+		mkdir -p $(INSTALL_PATH)/$$DIR;			\
+		rsync -a --copy-unsafe-links			\
+			$(OUTPUT)/$$DIR/bpf_testmod.ko		\
+			$(OUTPUT)/$$DIR/bpftool			\
+			$(OUTPUT)/$$DIR/ima_setup.sh		\
+			$(OUTPUT)/$$DIR/liburandom_read.so	\
+			$(OUTPUT)/$$DIR/sign-file		\
+			$(OUTPUT)/$$DIR/uprobe_multi		\
+			$(OUTPUT)/$$DIR/urandom_read		\
+			$(OUTPUT)/$$DIR/verify_sig_setup.sh	\
+			$(OUTPUT)/$$DIR/xdp_synproxy		\
+			$(OUTPUT)/$$DIR/btf_dump_test_case_*.c	\
+			$(OUTPUT)/$$DIR/*.bpf.o			\
+			$(INSTALL_PATH)/$$DIR;			\
 	done
 endef

base-commit: c8632acf193beac64bbdaebef013368c480bf74f
-- 
2.40.1


