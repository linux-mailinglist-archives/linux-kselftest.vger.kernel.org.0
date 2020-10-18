Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF58291A62
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Oct 2020 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgJRTXp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Oct 2020 15:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgJRTXo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Oct 2020 15:23:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D7E222E7;
        Sun, 18 Oct 2020 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049023;
        bh=XvMgVztAh3JO68OK0QUk3KY/LnZc26xvhCUuPLNnCpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL+3xUUzxxqwSgrZ2kvFwfJ0zHu3QPuQ/vwlAcyWMYYwWFtX4s16nGZJkKqUnpgQr
         LQZViAorEsdKQiTIx/1X6IaEsZb+BceZJa2PihmJIQJ01EM5mSHOfDWilh4PKRDYte
         MtcUvQZAOPFcgTXFGtbFlPnBDUuIZ47kXdOiiuBc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 57/80] selftests/bpf: Fix test_sysctl_loop{1, 2} failure due to clang change
Date:   Sun, 18 Oct 2020 15:22:08 -0400
Message-Id: <20201018192231.4054535-57-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 7fb5eefd76394cfefb380724a87ca40b47d44405 ]

Andrii reported that with latest clang, when building selftests, we have
error likes:
  error: progs/test_sysctl_loop1.c:23:16: in function sysctl_tcp_mem i32 (%struct.bpf_sysctl*):
  Looks like the BPF stack limit of 512 bytes is exceeded.
  Please move large on stack variables into BPF per-cpu array map.

The error is triggered by the following LLVM patch:
  https://reviews.llvm.org/D87134

For example, the following code is from test_sysctl_loop1.c:
  static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
  {
    volatile char tcp_mem_name[] = "net/ipv4/tcp_mem/very_very_very_very_long_pointless_string";
    ...
  }
Without the above LLVM patch, the compiler did optimization to load the string
(59 bytes long) with 7 64bit loads, 1 8bit load and 1 16bit load,
occupying 64 byte stack size.

With the above LLVM patch, the compiler only uses 8bit loads, but subregister is 32bit.
So stack requirements become 4 * 59 = 236 bytes. Together with other stuff on
the stack, total stack size exceeds 512 bytes, hence compiler complains and quits.

To fix the issue, removing "volatile" key word or changing "volatile" to
"const"/"static const" does not work, the string is put in .rodata.str1.1 section,
which libbpf did not process it and errors out with
  libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
  libbpf: prog 'sysctl_tcp_mem': bad map relo against '.L__const.is_tcp_mem.tcp_mem_name'
          in section '.rodata.str1.1'

Defining the string const as global variable can fix the issue as it puts the string constant
in '.rodata' section which is recognized by libbpf. In the future, when libbpf can process
'.rodata.str*.*' properly, the global definition can be changed back to local definition.

Defining tcp_mem_name as a global, however, triggered a verifier failure.
   ./test_progs -n 7/21
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  invalid stack off=0 size=1
  verification time 6975 usec
  stack depth 160+64
  processed 889 insns (limit 1000000) max_states_per_insn 4 total_states
  14 peak_states 14 mark_read 10

  libbpf: -- END LOG --
  libbpf: failed to load program 'sysctl_tcp_mem'
  libbpf: failed to load object 'test_sysctl_loop2.o'
  test_bpf_verif_scale:FAIL:114
  #7/21 test_sysctl_loop2.o:FAIL
This actually exposed a bpf program bug. In test_sysctl_loop{1,2}, we have code
like
  const char tcp_mem_name[] = "<...long string...>";
  ...
  char name[64];
  ...
  for (i = 0; i < sizeof(tcp_mem_name); ++i)
      if (name[i] != tcp_mem_name[i])
          return 0;
In the above code, if sizeof(tcp_mem_name) > 64, name[i] access may be
out of bound. The sizeof(tcp_mem_name) is 59 for test_sysctl_loop1.c and
79 for test_sysctl_loop2.c.

Without promotion-to-global change, old compiler generates code where
the overflowed stack access is actually filled with valid value, so hiding
the bpf program bug. With promotion-to-global change, the code is different,
more specifically, the previous loading constants to stack is gone, and
"name" occupies stack[-64:0] and overflow access triggers a verifier error.
To fix the issue, adjust "name" buffer size properly.

Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200909171542.3673449-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c | 4 ++--
 tools/testing/selftests/bpf/progs/test_sysctl_loop2.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index d22e438198cf7..9af8822ece477 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -18,11 +18,11 @@
 #define MAX_ULONG_STR_LEN 7
 #define MAX_VALUE_STR_LEN (TCP_MEM_LOOPS * MAX_ULONG_STR_LEN)
 
+const char tcp_mem_name[] = "net/ipv4/tcp_mem/very_very_very_very_long_pointless_string";
 static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 {
-	volatile char tcp_mem_name[] = "net/ipv4/tcp_mem/very_very_very_very_long_pointless_string";
 	unsigned char i;
-	char name[64];
+	char name[sizeof(tcp_mem_name)];
 	int ret;
 
 	memset(name, 0, sizeof(name));
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
index cb201cbe11e77..55251046c9b73 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
@@ -18,11 +18,11 @@
 #define MAX_ULONG_STR_LEN 7
 #define MAX_VALUE_STR_LEN (TCP_MEM_LOOPS * MAX_ULONG_STR_LEN)
 
+const char tcp_mem_name[] = "net/ipv4/tcp_mem/very_very_very_very_long_pointless_string_to_stress_byte_loop";
 static __attribute__((noinline)) int is_tcp_mem(struct bpf_sysctl *ctx)
 {
-	volatile char tcp_mem_name[] = "net/ipv4/tcp_mem/very_very_very_very_long_pointless_string_to_stress_byte_loop";
 	unsigned char i;
-	char name[64];
+	char name[sizeof(tcp_mem_name)];
 	int ret;
 
 	memset(name, 0, sizeof(name));
-- 
2.25.1

