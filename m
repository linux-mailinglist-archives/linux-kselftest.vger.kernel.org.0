Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494A646017
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGRZT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLGRZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:25:18 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B65B584;
        Wed,  7 Dec 2022 09:25:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NS3rs5tq6z9xqcC;
        Thu,  8 Dec 2022 01:18:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34m9YzJBjc9DJAA--.62662S2;
        Wed, 07 Dec 2022 18:24:53 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, mykolal@fb.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 0/7] bpf-lsm: Check return values of security modules
Date:   Wed,  7 Dec 2022 18:24:27 +0100
Message-Id: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34m9YzJBjc9DJAA--.62662S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1rCFWrtr4fJrWrZr1UJrb_yoWxGw4fpF
        4Fka4rKF4vkry8CF1UAa18Zw4SyFs5AFWUJFyDtr10y3WUtr1jqryxKr4YvrnxCr4UKr1x
        tr12qanYyryUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
        xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4JqngAAsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Notes:
- This patch set addresses the kernel panic described below, and not the
  more broad issue of accessing kernel objects whose pointer is passed
  as parameter by LSM hooks
- Alternative approaches trying to limit return values at run-time either
  in the security subsystem or in the eBPF JIT are not preferred by the
  respective maintainers
- Although all eBPF selftests have been verified to pass, it still might
  be cumbersome to have an eBPF program being accepted by the eBPF
  verifier (e.g. ANDing negative numbers causes existing bounds to be lost)
- The patch to store whether a register state changed due to an ALU64 or an
  ALU32 operation might not be correct/complete, a review by eBPF
  maintainers would be needed
- This patch set requires "lsm: make security_socket_getpeersec_stream()
  sockptr_t safe", in lsm/next
- The modification of the LSM infrastructure to define allowed return
  values for the LSM hooks could be replaced with an eBPF-only fix, with
  the drawback of having to update the information manually each time a
  new hook is added; allowing zero or negative values by default could be
  reasonable, but there are already exceptions of LSM hooks accepting 0 or
  1 (ismaclabel)
- The patches to fix the LSM infrastructure documentation are separated
  from this patch set and available here:
  https://lore.kernel.org/linux-security-module/20221128144240.210110-1-roberto.sassu@huaweicloud.com/

BPF LSM defines attachment points to allows security modules (eBPF programs
with type LSM) to provide their implementation of the desired LSM hooks.

Unfortunately, BPF LSM does not restrict which values security modules can
return (for non-void LSM hooks). If they put arbitrary values instead of
those stated in include/linux/lsm_hooks.h, they could cause big troubles.

For example, this simple eBPF program:

SEC("lsm/inode_permission")
int BPF_PROG(test_int_hook, struct inode *inode, int mask)
{
	return 1;
}

causes the following kernel panic:

[  181.130807] BUG: kernel NULL pointer dereference, address: 0000000000000079
[  181.131478] #PF: supervisor read access in kernel mode
[  181.131942] #PF: error_code(0x0000) - not-present page
[  181.132407] PGD 0 P4D 0 
[  181.132650] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  181.133054] CPU: 5 PID: 857 Comm: systemd-oomd Tainted: G           OE      6.1.0-rc7+ #530
[  181.133806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  181.134601] RIP: 0010:do_sys_openat2+0x235/0x300

[...]

[  181.136682] RSP: 0018:ffffc90001557ee0 EFLAGS: 00010203
[  181.137154] RAX: 0000000000000001 RBX: ffffc90001557f20 RCX: ffff888112003380
[  181.137790] RDX: 0000000000000000 RSI: ffffffff8280b026 RDI: ffffc90001557e28
[  181.138432] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[  181.139081] R10: ffffffff835097dc R11: 0000000000000000 R12: ffff888106118000
[  181.139717] R13: 000000000000000c R14: 0000000000000000 R15: 0000000000000000
[  181.140149] FS:  00007fa6ceb0bb40(0000) GS:ffff88846fb40000(0000) knlGS:0000000000000000
[  181.140556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.140865] CR2: 0000000000000079 CR3: 0000000135c50000 CR4: 0000000000350ee0
[  181.141239] Call Trace:
[  181.141373]  <TASK>
[  181.141495]  do_sys_open+0x34/0x60
[  181.141678]  do_syscall_64+0x3b/0x90
[  181.141875]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Avoid this situation by statically analyzing the eBPF programs attaching to
LSM hooks, and ensure that their return values are compatible with the LSM
infrastructure conventions.

First, add a preliminary patch (patch 1) to fix a small code duplication
issue.

Extend the eBPF verifier to let BPF LSM determine whether it should check
estimated 64 bit values or the 32 bit ones (patch 2). Also, extend the LSM
infrastructure to record more precisely the allowed return values depending
on the documentation found in include/linux/lsm_hooks.h (patch 3). Add the
LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE, LSM_RET_GT_ONE flags to an LSM hook
if that hook allows respectively > 0, 0, 1, > 1 return values.

Then, extend BPF LSM to verify that return values, estimated by the
verifier by analyzing the eBPF program, fall in the allowed intervals found
from the return value flags of the LSM hook being attached to (patch 4).

Finally, add new tests to ensure that the verifier enforces return values
correctly (patch 5), and slightly modify existing tests to make them follow
the LSM infrastructure conventions (patches 6-7) and are accepted by the
verifier.

Changelog:

v1:
- Complete the documentation of return values in lsm_hooks.h
- Introduce return value flags in the LSM infrastructure
- Use those flags instead of the scattered logic (suggested by KP)
- Expose a single verification function to the verifier (suggested by KP)
- Add new patch to remove duplicated function definition
- Add new patch to let BPF LSM determine the appropriate register values
  to use

Roberto Sassu (7):
  bpf: Remove superfluous btf_id_set_contains() declaration
  bpf: Mark ALU32 operations in bpf_reg_state structure
  lsm: Redefine LSM_HOOK() macro to add return value flags as argument
  bpf-lsm: Enforce return value limitations on security modules
  selftests/bpf: Check if return values of LSM programs are allowed
  selftests/bpf: Prevent positive ret values in test_lsm and
    verify_pkcs7_sig
  selftests/bpf: Change return value in test_libbpf_get_fd_by_id_opts.c

 include/linux/bpf.h                           |   1 -
 include/linux/bpf_lsm.h                       |  11 +-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/lsm_hook_defs.h                 | 780 ++++++++++--------
 include/linux/lsm_hooks.h                     |   9 +-
 kernel/bpf/bpf_lsm.c                          |  81 +-
 kernel/bpf/verifier.c                         |  17 +-
 security/bpf/hooks.c                          |   2 +-
 security/security.c                           |   4 +-
 tools/testing/selftests/bpf/progs/lsm.c       |   4 +
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c |   7 +-
 .../bpf/progs/test_verify_pkcs7_sig.c         |  11 +-
 .../testing/selftests/bpf/verifier/lsm_ret.c  | 148 ++++
 13 files changed, 729 insertions(+), 347 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/lsm_ret.c

-- 
2.25.1

