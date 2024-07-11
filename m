Return-Path: <linux-kselftest+bounces-13562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E992E611
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8801F218E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599116849C;
	Thu, 11 Jul 2024 11:14:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AED15CD6A;
	Thu, 11 Jul 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696443; cv=none; b=I5XRGOMMeLW1u5JFZv4ck5USpbdgG5a1mDSOHVBGXcSaMpweP4/g+/iap7aCESxQ8rb/coFaxpVFRfgCBP9Pa1B1PwVvXHgE2TjqGGzsVurOJ1tuoZecWEhsQYgMLRN/t8VA4YFmQIQ5FUzVhb/caOCbLyIOSSbKt8aOluXL9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696443; c=relaxed/simple;
	bh=A8xLk0O3fB7lA9Wxut6B3bY10A+g7jWOyYbNSesqCgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhfSK9sO7n/XudmHPRJQfv7/M6VvT4zjoDg6Y4zuLJFzUjbjNFu77PUpF7ndvQGCTo8iz2irj6Hx05jGTnvnPHLaIXQ/H5hmm4u9NcWM6WGKevlhzKAFJP0ZiQyT1VzuaObHf8A1GprFBGPcMthDkGKmEM7IvlDrSznadRpNNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKXCw64Vwz4f3k5t;
	Thu, 11 Jul 2024 19:13:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7430A1A0199;
	Thu, 11 Jul 2024 19:13:56 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S2;
	Thu, 11 Jul 2024 19:13:54 +0800 (CST)
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
Subject: [PATCH bpf-next v4 00/20] Add return value range check for BPF LSM
Date: Thu, 11 Jul 2024 19:18:48 +0800
Message-Id: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWDJw18Kw4DXFy7KrW8tFb_yoWfJr4DpF
	4FqFyrGr409FW8JF1xGF47Cw4rAFZ3Ca4UJryxJrnYv3W5GF1DXr18GrWjqrZ8Gr45ur1S
	yrZFgFsYy34kZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

LSM BPF prog returning a positive number attached to the hook
file_alloc_security makes kernel panic. 

Here is a panic log:

[  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000009
[  441.236748] #PF: supervisor write access in kernel mode
[  441.237429] #PF: error_code(0x0002) - not-present page
[  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD 0
[  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
[  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cbf23373 #22
[  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b4
[  441.241933] RIP: 0010:alloc_file+0x4b/0x190
[  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe ff ff 48 3d 00 f0 ff fb
[  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
[  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 0000000035b08000
[  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8088ffff
[  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 0000000000000001
[  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffffffffff4
[  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 0000000000170ef0
[  441.252688] Call Trace:
[  441.253011]  <TASK>
[  441.253296]  ? __die+0x24/0x70
[  441.253702]  ? page_fault_oops+0x15b/0x480
[  441.254236]  ? fixup_exception+0x26/0x330
[  441.254750]  ? exc_page_fault+0x6d/0x1c0
[  441.255257]  ? asm_exc_page_fault+0x26/0x30
[  441.255792]  ? alloc_file+0x4b/0x190
[  441.256257]  alloc_file_pseudo+0x9f/0xf0
[  441.256760]  __anon_inode_getfile+0x87/0x190
[  441.257311]  ? lock_release+0x14e/0x3f0
[  441.257808]  bpf_link_prime+0xe8/0x1d0
[  441.258315]  bpf_tracing_prog_attach+0x311/0x570
[  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
[  441.259605]  __sys_bpf+0x1bb7/0x2dc0
[  441.260070]  __x64_sys_bpf+0x20/0x30
[  441.260533]  do_syscall_64+0x72/0x140
[  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  441.261643] RIP: 0033:0x4b0349
[  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 88
[  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 00000000004b0349
[  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000000001c
[  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 0000000000000000
[  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 00000000004004e8

This is because the filesystem uses IS_ERR to check if the return value
is an error code. If it is not, the filesystem takes the return value
as a file pointer. Since the positive number returned by the BPF prog
is not a real file pointer, this misinterpretation causes a panic.

Since other LSM modules always return either a negative error code
or a valid pointer, this specific issue only exists in BPF LSM. The
proposed solution is to reject LSM BPF progs returning unexpected
values in the verifier. This patch set adds return value check to
ensure only BPF progs returning expected values are accepted.

Since each LSM hook has different excepted return values, we need to
know the expected return values for each individual hook to do the
check. Earlier versions of the patch set used LSM hook annotations
to specify the return value range for each hook. Based on Paul's
suggestion, current version gets rid of such annotations and instead
converts hook return values to a common pattern: return 0 on success
and negative error code on failure.

Basically, LSM hooks are divided into two types: hooks that return a
negative error code and zero or other values, and hooks that do not
return a negative error code. This patch set converts all hooks of the
first type and part of the second type to return 0 on success and a
negative error code on failure (see patches 1-10). For certain hooks,
like ismaclabel and inode_xattr_skipcap, the hook name already imply
that returning 0 or 1 is the best choice, so they are not converted.
There are four unconverted hooks. Except for ismaclabel, which is not
used by BPF LSM, the other three are specified with a BTF ID list to
only return 0 or 1.

v4:
1. remove LSM_HOOK return value annotaion and convert LSM hook return
   value to a common patern: return 0 on success and negative error code
   on failure (patch 1-10)
2. enable BPF LSM progs to read and write output params (patch 12)
3. add a special case for bitwise AND on range [-1, 0] (patch 16)
4. add a 32-bit comparing flag for retval_range_within (patch 15)
5. collect ACKs, style fix, etc

v3: https://lore.kernel.org/bpf/20240411122752.2873562-1-xukuohai@huaweicloud.com/
1. Fix incorrect lsm hook return value ranges, and add disabled hook
   list for bpf lsm, and merge two LSM_RET_INT patches. (KP Singh)
2. Avoid bpf lsm progs attached to different hooks to call each other
   with tail call
3. Fix a CI failure caused by false rejection of AND operation
4. Add tests

v2: https://lore.kernel.org/bpf/20240325095653.1720123-1-xukuohai@huaweicloud.com/
fix bpf ci failure

v1: https://lore.kernel.org/bpf/20240316122359.1073787-1-xukuohai@huaweicloud.com/

Xu Kuohai (20):
  lsm: Refactor return value of LSM hook vm_enough_memory
  lsm: Refactor return value of LSM hook inode_need_killpriv
  lsm: Refactor return value of LSM hook inode_getsecurity
  lsm: Refactor return value of LSM hook inode_listsecurity
  lsm: Refactor return value of LSM hook inode_copy_up_xattr
  lsm: Refactor return value of LSM hook getselfattr
  lsm: Refactor return value of LSM hook setprocattr
  lsm: Refactor return value of LSM hook getprocattr
  lsm: Refactor return value of LSM hook key_getsecurity
  lsm: Refactor return value of LSM hook audit_rule_match
  bpf, lsm: Add disabled BPF LSM hook list
  bpf, lsm: Enable BPF LSM prog to read/write return value parameters
  bpf, lsm: Add check for BPF LSM return value
  bpf: Prevent tail call between progs attached to different hooks
  bpf: Fix compare error in function retval_range_within
  bpf: Add a special case for bitwise AND on range [-1, 0]
  selftests/bpf: Avoid load failure for token_lsm.c
  selftests/bpf: Add return value checks for failed tests
  selftests/bpf: Add test for lsm tail call
  selftests/bpf: Add verifier tests for bpf lsm

 fs/attr.c                                     |   5 +-
 fs/inode.c                                    |   4 +-
 fs/nfs/nfs4proc.c                             |   5 +-
 fs/overlayfs/copy_up.c                        |   6 +-
 fs/proc/base.c                                |  10 +-
 fs/xattr.c                                    |  24 +-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_lsm.h                       |  15 +
 include/linux/lsm_hook_defs.h                 |  22 +-
 include/linux/security.h                      |  62 ++--
 include/linux/tnum.h                          |   3 +
 kernel/bpf/bpf_lsm.c                          |  64 +++-
 kernel/bpf/btf.c                              |  21 +-
 kernel/bpf/core.c                             |  21 +-
 kernel/bpf/tnum.c                             |  25 ++
 kernel/bpf/verifier.c                         | 173 ++++++++++-
 net/socket.c                                  |   9 +-
 security/apparmor/audit.c                     |  22 +-
 security/apparmor/include/audit.h             |   2 +-
 security/apparmor/lsm.c                       |  22 +-
 security/commoncap.c                          |  32 +-
 security/integrity/evm/evm_main.c             |   2 +-
 security/keys/keyctl.c                        |  11 +-
 security/lsm_syscalls.c                       |   6 +-
 security/security.c                           | 167 ++++++++---
 security/selinux/hooks.c                      |  94 +++---
 security/selinux/include/audit.h              |   8 +-
 security/selinux/ss/services.c                |  54 ++--
 security/smack/smack_lsm.c                    | 104 ++++---
 .../selftests/bpf/prog_tests/test_lsm.c       |  46 ++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/err.h       |  10 +
 .../selftests/bpf/progs/lsm_tailcall.c        |  34 +++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |   4 +
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 tools/testing/selftests/bpf/progs/token_lsm.c |   4 +-
 .../bpf/progs/verifier_global_subprogs.c      |   7 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 274 ++++++++++++++++++
 38 files changed, 1098 insertions(+), 286 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

-- 
2.30.2


