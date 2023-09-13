Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CC79E816
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjIMMcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjIMMcn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 08:32:43 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C7019A8;
        Wed, 13 Sep 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694608359; x=1726144359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:reply-to:mime-version:
   content-transfer-encoding;
  bh=5oIhYdCJEkownT50F9w6XGgNq4kRwDe875Odq22n3v0=;
  b=rj9DLiQpKgT1eW9AVJHWZadTQRzs3rqrqJhPFd/kAA7Eu0hcCLMYsS6i
   UpqvIMr6zd729bhQfiMYwSjjydHmFZOrcZx9jNFx1lQE0iGnJB8xMFil3
   DsE1bSFcf71Oj9s4SdjelPmg0+8hurhOKP1ct2Dp4ZEQWi3v+2KTxIadT
   s=;
X-IronPort-AV: E=Sophos;i="6.02,143,1688428800"; 
   d="scan'208";a="238776791"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:32:35 +0000
Received: from EX19D017EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 61788805E0;
        Wed, 13 Sep 2023 12:32:29 +0000 (UTC)
Received: from dev-dsk-gerhorst-1c-a6f23d20.eu-west-1.amazon.com
 (10.15.21.113) by EX19D017EUA004.ant.amazon.com (10.252.50.239) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 12:32:22 +0000
From:   Luis Gerhorst <gerhorst@amazon.de>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <laoar.shao@gmail.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <mykolal@fb.com>, <shuah@kernel.org>,
        <gerhorst@amazon.de>, <iii@linux.ibm.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luis Gerhorst <gerhorst@cs.fau.de>
Subject: [PATCH 3/3] selftests/bpf: Add selftest for packet-pointer Spectre v1 gadget
Date:   Wed, 13 Sep 2023 12:31:54 +0000
Message-ID: <20230913123154.94264-1-gerhorst@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
Reply-To: <gerhorst@cs.fau.de>
MIME-Version: 1.0
X-Originating-IP: [10.15.21.113]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D017EUA004.ant.amazon.com (10.252.50.239)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When allowing speculative leaks by enabling packet pointer accesses
without CAP_PERFMON (i.e., without having [1] reverted):

  $ tools/testing/selftests/bpf/test_progs --name=tc_bpf
  tc_bpf_non_root:PASS:set_cap_bpf_cap_net_admin 0 nsec
  tc_bpf_non_root:PASS:disable_cap_sys_admin 0 nsec
  tc_bpf_non_root:FAIL:test_tc_bpf__open_and_load unexpected pointer: 0x55bbd81969a0
  Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED

With [1] reverted:

  $ tools/testing/selftests/bpf/test_progs --name=tc_bpf
  #238/1   tc_bpf/tc_bpf_root:OK
  #238/2   tc_bpf/tc_bpf_non_root:OK
  #238     tc_bpf:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

[1] d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 ("bpf: Fix issue in verifying allow_ptr_leaks")

Signed-off-by: Luis Gerhorst <gerhorst@amazon.de>
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
Based-on-patch-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/tc_bpf.c | 37 +++++++-
 .../testing/selftests/bpf/progs/test_tc_bpf.c | 95 +++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
index e873766276d1..5319cb94a0ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <linux/pkt_cls.h>
 
+#include "cap_helpers.h"
 #include "test_tc_bpf.skel.h"
 
 #define LO_IFINDEX 1
@@ -327,7 +328,7 @@ static int test_tc_bpf_api(struct bpf_tc_hook *hook, int fd)
 	return 0;
 }
 
-void test_tc_bpf(void)
+void tc_bpf_root(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
 			    .attach_point = BPF_TC_INGRESS);
@@ -393,3 +394,37 @@ void test_tc_bpf(void)
 	}
 	test_tc_bpf__destroy(skel);
 }
+
+void tc_bpf_non_root(void)
+{
+	struct test_tc_bpf *skel = NULL;
+	__u64 caps = 0;
+	int ret;
+
+	/* In case CAP_BPF and CAP_PERFMON is not set */
+	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
+	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
+		return;
+	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
+	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
+		goto restore_cap;
+
+	skel = test_tc_bpf__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "test_tc_bpf__open_and_load"))
+		goto destroy;
+
+	goto restore_cap;
+destroy:
+	test_tc_bpf__destroy(skel);
+restore_cap:
+	if (caps)
+		cap_enable_effective(caps, NULL);
+}
+
+void test_tc_bpf(void)
+{
+	if (test__start_subtest("tc_bpf_root"))
+		tc_bpf_root();
+	if (test__start_subtest("tc_bpf_non_root"))
+		tc_bpf_non_root();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
index d28ca8d1f3d0..3b3f9ce6b9d4 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
@@ -2,6 +2,8 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 
 /* Dummy prog to test TC-BPF API */
 
@@ -10,3 +12,96 @@ int cls(struct __sk_buff *skb)
 {
 	return 0;
 }
+
+/* Prog to verify tc-bpf without cap_sys_admin and cap_perfmon is rejected as
+ * required to prevent Spectre v1 using CPU multiplication port contention
+ * side-channel. This is not a full exploit but rather a PoC for x86_64. With
+ * extensions to the verifier's mitigations this may become obsolete.
+ *
+ * This should compile to the following bytecode if the kernel would allow
+ * unprivileged packet pointer accesses:
+ *
+
+0000000000000000 <pkt_ptr>:
+       0:	b4 00 00 00 00 00 00 00	w0 = 0
+       1:	61 12 50 00 00 00 00 00	r2 = *(u32 *)(r1 + 80)
+       2:	61 11 4c 00 00 00 00 00	r1 = *(u32 *)(r1 + 76)
+       3:	bf 13 00 00 00 00 00 00	r3 = r1
+       4:	07 03 00 00 22 00 00 00	r3 += 34
+       5:	bd 23 07 00 00 00 00 00	if r3 <= r2 goto +7 <LBB1_3>
+       6:	71 10 0e 00 00 00 00 00	r0 = *(u8 *)(r1 + 14)
+       7:	64 00 00 00 18 00 00 00	w0 <<= 24
+       8:	c4 00 00 00 18 00 00 00	w0 s>>= 24
+       9:	bc 01 00 00 00 00 00 00	w1 = w0
+      10:	54 01 00 00 01 00 00 00	w1 &= 1
+      11:	16 01 01 00 00 00 00 00	if w1 == 0 goto +1 <LBB1_3>
+      12:	24 00 00 00 61 00 00 00	w0 *= 97
+
+0000000000000068 <LBB1_3>:
+      13:	95 00 00 00 00 00 00 00	exit
+
+ *
+ * Which should in turn translate to this x86_64 assembly with !allow_ptr_leaks
+ * and !bypass_spec_v1:
+ *
+
+int pkt_ptr(struct __sk_buff * skb):
+bpf_prog_7c3834bad32f2b0f_pkt_ptr:
+; int pkt_ptr(struct __sk_buff *skb)
+   0:   endbr64
+   4:   nopl   0x0(%rax,%rax,1)
+   9:   xchg   %ax,%ax
+   b:   push   %rbp
+   c:   mov    %rsp,%rbp
+   f:   endbr64
+  13:   xor    %eax,%eax
+; if ((long)(iph + 1) > (long)skb->data_end)
+  15:   mov    0x50(%rdi),%rsi
+; struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
+  19:   mov    0xc8(%rdi),%rdi
+; if ((long)(iph + 1) > (long)skb->data_end)
+  20:   mov    %rdi,%rdx
+  23:   add    $0x22,%rdx
+; if ((long)(iph + 1) > (long)skb->data_end)
+  27:   cmp    %rsi,%rdx
+  2a:   ja     0x0000000000000043
+; char secret = *((char *) iph);
+  2c:   movzbq 0xe(%rdi),%rax
+  31:   shl    $0x18,%eax
+  34:   sar    $0x18,%eax
+; if (secret & 1) {
+  37:   mov    %eax,%edi
+  39:   and    $0x1,%edi
+; if (secret & 1) {
+  3c:   test   %edi,%edi
+  3e:   je     0x0000000000000043
+  40:   imul   $0x61,%eax,%eax
+; }
+  43:   leaveq
+  44:   retq
+
+ *
+ */
+SEC("tcx/ingress")
+int pkt_ptr(struct __sk_buff *skb)
+{
+	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
+
+	/* Branch to be speculatively bypassed. */
+	if ((long)(iph + 1) > (long)skb->data_end)
+		return 0;
+
+	/* Speculative access to be prevented. */
+	char secret = *((char *) iph);
+
+	/* Leak the first bit of the secret value that lies behind data_end to a
+	 * SMP silbling thread that also executes imul instructions. If the bit
+	 * is 1, the silbling will experience a slowdown. */
+	long long x = secret;
+	if (secret & 1) {
+		x *= 97;
+	}
+
+	/* To prevent optimization. */
+	return x;
+}
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



