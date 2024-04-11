Return-Path: <linux-kselftest+bounces-7693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B2F8A146D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B14B24883
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903414D430;
	Thu, 11 Apr 2024 12:24:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6014B093;
	Thu, 11 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838292; cv=none; b=ZyJsCVwDJ+X4C9Qt1/MbGKu2uOlRQbUWK0RbJ7g1pJLfuahlwfH8cguAq5nQSxaBfTDViajVvVnHx/yl2mu3ZgDFioVcNwk/VRy1rrrXsh5iWjRx9IKdpQ+cEcA2m1taAgEVnQiJ3Cgqy7r3rqG/PEnbirtqFLWbaqzybhijaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838292; c=relaxed/simple;
	bh=eOJ9su9B/d4b1D3MZvqjUPuVn2n3++RBtNVHTh0Ffq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prKQigG7xiRk+ngxRWqAJ/nwlhtQgnRNUIRiMbJ/RUfOYevGZFnukTpPWu7vUiZVn422mcJTYzheVHV9wgSGt4HfaQGV4coPljUJRg7Buwx4gaWOZB8XKf/XXmdQxEYwoVpQpudQuVqvySaJ0oxz4Zd1Hc+gBsLKkKDuR5Sobg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFf5c6HFrz4f3mJ1;
	Thu, 11 Apr 2024 20:24:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C8E31A01A7;
	Thu, 11 Apr 2024 20:24:45 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S2;
	Thu, 11 Apr 2024 20:24:42 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
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
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 00/11] Add check for bpf lsm return value
Date: Thu, 11 Apr 2024 20:27:41 +0800
Message-Id: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4xArWkWFWxCFyrtr1kXwb_yoW7tF17pr
	4YqF18Kr4IqF4UJF1xCF4UGr1fJFZ7A3WUXryxJr95AF15Gr1DXr1xGr4jqrnxJr4Uur1a
	vF9Fqan5t348XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

A bpf prog returning positive number attached to file_alloc_security hook
will make kernel panic.

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

The reason is that the positive number returned by bpf prog is not a
valid errno, and could not be filtered out with IS_ERR which is used by
the file system to check errors. As a result, the filesystem mistakenly
uses this random positive number as file pointer, causing panic.

To fix this issue, there are two schemes:

1. Modify the calling sites of file_alloc_security to take positive
   return values as zero.

2. Make the bpf verifier to ensure no unpredicted value returned by
   lsm bpf prog.

Considering that hook file_alloc_security never returned positive number
before bpf lsm was introduced, and other lsm hooks may have the same
problem, scheme 2 is more reasonable.

So this series adds lsm return value check in verifier to fix it.

v3:
1. Fix incorrect lsm hook return value ranges, and add disabled hook
   list for bpf lsm, and merge two LSM_RET_INT patches. (KP Singh)
2. Avoid bpf lsm progs attached to different hooks to call each other
   with tail call
3. Fix a CI failure caused by false rejection of AND operation
4. Add tests

v2: https://lore.kernel.org/bpf/20240325095653.1720123-1-xukuohai@huaweicloud.com/
fix bpf ci failure

v1: https://lore.kernel.org/bpf/20240316122359.1073787-1-xukuohai@huaweicloud.com/

Xu Kuohai (11):
  bpf, lsm: Annotate lsm hook return value range
  bpf, lsm: Add helper to read lsm hook return value range
  bpf, lsm: Check bpf lsm hook return values in verifier
  bpf, lsm: Add bpf lsm disabled hook list
  bpf: Avoid progs for different hooks calling each other with tail call
  bpf: Fix compare error in function retval_range_within
  bpf: Fix a false rejection caused by AND operation
  selftests/bpf: Avoid load failure for token_lsm.c
  selftests/bpf: Add return value checks for failed tests
  selftests/bpf: Add test for lsm tail call
  selftests/bpf: Add verifier tests for bpf lsm

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_lsm.h                       |   8 +
 include/linux/lsm_hook_defs.h                 | 591 +++++++++---------
 include/linux/lsm_hooks.h                     |   6 -
 kernel/bpf/bpf_lsm.c                          |  84 ++-
 kernel/bpf/btf.c                              |   5 +-
 kernel/bpf/core.c                             |  22 +-
 kernel/bpf/verifier.c                         |  82 ++-
 security/security.c                           |   1 +
 .../selftests/bpf/prog_tests/test_lsm.c       |  46 +-
 .../selftests/bpf/prog_tests/verifier.c       |   3 +-
 tools/testing/selftests/bpf/progs/err.h       |  10 +
 .../selftests/bpf/progs/lsm_tailcall.c        |  34 +
 .../selftests/bpf/progs/test_sig_in_xattr.c   |   4 +
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 tools/testing/selftests/bpf/progs/token_lsm.c |   4 +-
 .../bpf/progs/verifier_global_subprogs.c      |   7 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 155 +++++
 18 files changed, 754 insertions(+), 318 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

-- 
2.30.2


