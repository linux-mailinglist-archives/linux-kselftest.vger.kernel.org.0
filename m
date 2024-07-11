Return-Path: <linux-kselftest+bounces-13580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C092E70D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4581F27E84
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCF16A382;
	Thu, 11 Jul 2024 11:33:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B24167D83;
	Thu, 11 Jul 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697599; cv=none; b=QX/0d6rwzxK3Qa9HWOUpCjG9NHQ3yk9I2XaG8//PfZAxp64oIKbnuFbE7K0XxhoR0uhx8w0GRPUDtFq0aI/ZvEv6IvMDJt5Sc/hbyK6wAv9u6k+lhUEgUzKdTq16HkBTrftKBU9CRxRjZGotfFpj0tFiE0rN0nl0+H+q1PDnPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697599; c=relaxed/simple;
	bh=0D4+hn+mqXg4MVrSEI33bDzLl/YLMPl+CrCDwuSiJlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snCey3iWj7wnYHYHy1zQMyKDPEcz75nXMstrdiH/to8zBKplECHYojovRdB7feIlBOQKLBl7oI382gIsS5fiB3uhEvJ7LRkL4exO+B8wfPUreRgWe8GbEZ9/d//7mcnopbDN8HWscMJV8WSr2DzmgtUCecbQHbtb2/7DrTQX5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXf55G9Mz4f3jrs;
	Thu, 11 Jul 2024 19:33:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 632061A0572;
	Thu, 11 Jul 2024 19:33:13 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgDXKvT0wo9mzI8hBw--.25380S9;
	Thu, 11 Jul 2024 19:33:12 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 20/20] selftests/bpf: Add verifier tests for bpf lsm
Date: Thu, 11 Jul 2024 19:38:28 +0800
Message-Id: <20240711113828.3818398-8-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKvT0wo9mzI8hBw--.25380S9
X-Coremail-Antispam: 1UD129KBjvJXoW3WFykZw4UXFWDJr43Ww47XFb_yoW3try3pF
	nFk34DGF95Ar9xWFWxCFWxuF1fGFn2qF1rXa1FvF1jyFs3Jr97XFW8GF1DX34fJ3Z3uw4Y
	vFZIyayakr1UuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add verifier tests to check bpf lsm return values, output parameter
access and disabled hooks.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_lsm.c        | 274 ++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9dc3687bc406..ff1c7da1d06e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -88,6 +88,7 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
+#include "verifier_lsm.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -206,6 +207,7 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
+void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
new file mode 100644
index 000000000000..fcc74efe46c6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 1")
+__success
+__naked int errno_zero_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 2")
+__success
+__naked int errno_zero_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = -4095;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 3")
+__success
+__naked int errno_zero_retval_test3(void *ctx)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r0 <<= 63;"
+	"r0 s>>= 63;"
+	"r0 &= -13;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("lsm/file_mprotect")
+__description("lsm bpf prog with -4095~0 retval. test 4")
+__failure __msg("R0 has smin=-4096 smax=-4096 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test4(void *ctx)
+{
+	asm volatile (
+	"r0 = -4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_mprotect")
+__description("lsm bpf prog with -4095~0 retval. test 5")
+__failure __msg("R0 has smin=4096 smax=4096 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test5(void *ctx)
+{
+	asm volatile (
+	"r0 = 4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/vm_enough_memory")
+__description("lsm bpf prog with -4095~0 retval. test 6")
+__failure __msg("R0 has smin=1 smax=1 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test6(void *ctx)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 1")
+__success
+__naked int bool_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 2")
+__success
+__success
+__naked int bool_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 3")
+__failure __msg("R0 has smin=-1 smax=-1 should have been in [0, 1]")
+__naked int bool_retval_test3(void *ctx)
+{
+	asm volatile (
+	"r0 = -1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 4")
+__failure __msg("R0 has smin=2 smax=2 should have been in [0, 1]")
+__naked int bool_retval_test4(void *ctx)
+{
+	asm volatile (
+	"r0 = 2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__success
+__description("lsm bpf prog with void retval. test 1")
+__naked int void_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = -4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__success
+__description("lsm bpf prog with void retval. test 2")
+__naked int void_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_match")
+__description("lsm bpf prog read write valid output parameter success")
+__success
+__naked int outparam_valid_test(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x20);"
+	"r2 = *(u8 *)(r1 + 0x0);"
+	"r2 &= 0x1;"
+	"*(u8 *)(r1 + 0x0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_match")
+__description("lsm bpf prog read write output parameter, invalid read offset")
+__failure __msg("invalid read offset: 1 (expected 0, type=_Bool)")
+__naked int outparam_invalid_read_offset(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x20);"
+	"r2 = *(u8 *)(r1 + 0x1);"
+	"r2 &= 0x1;"
+	"*(u8 *)(r1 + 0x0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_match")
+__description("lsm bpf prog read write invalid output parameter, invalid read size")
+__failure __msg("invalid read size: 2 (expected 1, type=_Bool)")
+__naked int outparam_invalid_read_size(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x20);"
+	"r2 = *(u16 *)(r1 + 0x0);"
+	"r2 &= 0x1;"
+	"*(u8 *)(r1 + 0x0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_match")
+__description("lsm bpf prog read write invalid output parameter, invalid write offset")
+__failure __msg("invalid write offset: 1 (expected 0, type=_Bool)")
+__naked int outparam_invalid_write_offset(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x20);"
+	"r2 = *(u8 *)(r1 + 0x0);"
+	"r2 &= 0x1;"
+	"*(u8 *)(r1 + 0x1) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_match")
+__description("lsm bpf prog read write invalid output parameter, invalid write size")
+__failure __msg("invalid write size: 2 (expected 1, type=_Bool)")
+__naked int outparam_invalid_write_size(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x20);"
+	"r2 = *(u8 *)(r1 + 0x0);"
+	"r2 &= 0x1;"
+	"*(u16 *)(r1 + 0x0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* hook prototype:
+ * int bpf_lsm_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+ *
+ * although the last param is a pointer to u32, it iss not the output param for
+ * return value.
+ */
+SEC("lsm/secctx_to_secid")
+__description("lsm bpf prog read write invalid output parameter, not output param hook")
+__failure __msg("invalid mem access 'scalar'")
+__naked int outparam_invalid_hook(void *ctx)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0x10);"
+	"r2 = *(u32 *)(r1 + 0x0);"
+	"r2 &= 0x1;"
+	"*(u32 *)(r1 + 0x0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/getprocattr")
+__description("lsm disabled hook: getprocattr")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/setprocattr")
+__description("lsm disabled hook: setprocattr")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/ismaclabel")
+__description("lsm disabled hook: ismaclabel")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test3(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2


