Return-Path: <linux-kselftest+bounces-3122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379882FAB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946A928772E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A763C489;
	Tue, 16 Jan 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETxu2V85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958523C062;
	Tue, 16 Jan 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435254; cv=none; b=pOR1agqolHqBX2sH0M+8GzbnfjtvvHDgFE3jZQFCNKPWXK3x85TE45MDSQErb9kgxao5rrT+mFl7v8z4i1RzLoaTBXXwM4U6EbxdbZOkTaG/efsSYzyz7xDN5s3YFMtWW+/XfwJ4btVyhkgZcMAL1KvkjxKE7NNcVQhKb0O+fP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435254; c=relaxed/simple;
	bh=hORw/LjtmLslIhMW3hB1p5s4EeH7XhY/u0cxo++nrUU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=nDkc1YovhypdiJ1dXMKUStJNYTMG2m52sqMIo1s/Vm6MV3SHs6F4IXuphY85MI+wqLGPyXmIJOB429RqV4lEcvrGQhvRgyeHpuTl53NcHRa9VViaJzVkaWnsUPgviMkfsRhRhx3mBUYBB664qoHNDL5FMAAxBJC2YmKH6ukxJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETxu2V85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0881DC433C7;
	Tue, 16 Jan 2024 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435254;
	bh=hORw/LjtmLslIhMW3hB1p5s4EeH7XhY/u0cxo++nrUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETxu2V85gxq2FHHfbakou9AHaRU/Ogkbgxc7Ouaj8jbAHGCGC9JOnh/NM7uQBuAQU
	 3qh1i0N7vrKENUx0Zdx+DFApUdazUMIf+FjAo7LAKz1LgS5TSIwvxjvreOU1Gkpgyd
	 4qTWHj8QITawOHIocV0MK91lzlcGfbhxNPofsh75bmSjfRvunId+uLyUJMIx1SDNlz
	 CXPs2kHgx8oS7kFDiG3T4Fnp91Ryfnmpgg5xuq7tT/nRvYhTKCdKjBsJq/B6iVJG2y
	 US9W20gEo4qVWfM2huWqHOEkEWlPuU3Ywfqe6bs+34bJ2QDuRN85w/834bsK5vlKk0
	 yNk6P6oyiSVUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 03/44] selftests/bpf: Fix pyperf180 compilation failure with clang18
Date: Tue, 16 Jan 2024 14:59:32 -0500
Message-ID: <20240116200044.258335-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 100888fb6d8a185866b1520031ee7e3182b173de ]

With latest clang18 (main branch of llvm-project repo), when building bpf selftests,
    [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j

The following compilation error happens:
    fatal error: error in backend: Branch target out of insn range
    ...
    Stack dump:
    0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
      -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter
      /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include
      -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 --target=bpf
      -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
    1.      <eof> parser at end of file
    2.      Code generation
    ...

The compilation failure only happens to cpu=v2 and cpu=v3. cpu=v4 is okay
since cpu=v4 supports 32-bit branch target offset.

The above failure is due to upstream llvm patch [1] where some inlining behavior
are changed in clang18.

To workaround the issue, previously all 180 loop iterations are fully unrolled.
The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is used to avoid
unrolling changes if cpu=v4. If __BPF_CPU_VERSION__ is not available and the
compiler is clang18, the unrollng amount is unconditionally reduced.

  [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Link: https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/pyperf180.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..42c4a8b62e36 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at clang18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some branch
+ * target distance exceeded 16bit representation which is the maximum for
+ * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang18
+ * to specify which cpu version is used for compilation. So a smaller
+ * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
+ * reduced some branch target distances and resolved the compilation failure.
+ *
+ * To capture the case where a developer/ci uses clang18 but the corresponding
+ * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_count
+ * will be set as well to prevent potential compilation failures.
+ */
+#ifdef __BPF_CPU_VERSION__
+#if __BPF_CPU_VERSION__ < 4
+#define UNROLL_COUNT 90
+#endif
+#elif __clang_major__ == 18
+#define UNROLL_COUNT 90
+#endif
+
 #include "pyperf.h"
-- 
2.43.0


