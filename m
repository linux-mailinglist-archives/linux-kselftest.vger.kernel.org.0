Return-Path: <linux-kselftest+bounces-43738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F37FBFA8A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 09:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878E46156E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4092F7AA0;
	Wed, 22 Oct 2025 07:28:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18C2F6587;
	Wed, 22 Oct 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118120; cv=none; b=rg+UtSUXNHIeNVuGLDzhApB44t+XVb2zrG9YWb6cRIw4T7ADq3uCEAgZBSKlOVFoF/pOBHYhbkwFM0iTV0vhtKyNh5iXhaHDVEKkzsnaKxT6AzhD0l1UFD6crttXkysQ6d6P4tPn1MNESQ0T7+0KPAilPGIcSFkiGiRSvkTbF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118120; c=relaxed/simple;
	bh=QK8wO2LnZXdBOBPcu0Yz+H6JeLiJpO6vJbSSQ7bD/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAV9wVrLYE43NgPY3n42M4emVig0A35Z9WQM4K1kLdjcYO7Ct6eUgt9ULkqOTrB1YxEPyGliDI5Qmh0WpHl9pI+cSseiM/h6gH8hkAZp8Qt7ezXLN1+yduBjfZQ82u+O87CuIVc7CSIy6Nh6z0kO5w2OCmleVnnVPQe41elSGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 6C84D8B2A0C; Wed, 22 Oct 2025 15:18:42 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v1] selftests/bpf: Guard addr_space_cast code with __BPF_FEATURE_ADDR_SPACE_CAST
Date: Wed, 22 Oct 2025 15:18:20 +0800
Message-ID: <20251022071825.238909-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling the BPF selftests with Clang versions that do not support
the addr_space_cast builtin, the build fails with assembly errors in
"verifier_ldsx.c" [1].

The root cause is that the inline assembly using addr_space_cast is
being processed by a compiler that lacks this feature. To resolve this,
wrap the affected code sections (specifically the arena_ldsx_* test
functions) with #if defined(__BPF_FEATURE_ADDR_SPACE_CAST). This
ensures the code is only compiled when the Clang supports the necessary
feature, preventing build failures on older or incompatible compiler
versions.

This change maintains test coverage for systems with support while
allowing the tests to build successfully in all environments.

[1]:
root:tools/testing/selftests/bpf$ make

  CLNG-BPF [test_progs] verifier_ldsx.bpf.o
progs/verifier_ldsx.c:322:2: error: invalid operand for instruction
  322 |         "r1 = %[arena] ll;"
      |         ^
<inline asm>:1:52: note: instantiated into assembly here
    1 |         r1 = arena ll;r0 = 0xdeadbeef;r0 = addr_space_cast(r0,...
      |                                                           ^

Fixes: f61654912404 ("selftests: bpf: Add tests for signed loads from arena")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_ldsx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index c8494b682c31..cefa02e417d3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -263,6 +263,7 @@ __naked void ldsx_ctx_8(void)
 	: __clobber_all);
 }
 
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 SEC("syscall")
 __description("Arena LDSX Disasm")
 __success
@@ -425,6 +426,7 @@ __naked void arena_ldsx_s32(void *ctx)
 	:  __clobber_all
 	);
 }
+#endif
 
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
-- 
2.43.0


