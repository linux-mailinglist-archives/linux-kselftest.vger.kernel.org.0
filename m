Return-Path: <linux-kselftest+bounces-14781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B89472FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 03:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB991C20993
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41C13D2A4;
	Mon,  5 Aug 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfsSuUu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE313CFAB
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821457; cv=none; b=qSC/F+SephFFFisw2lGU2nRGtQcvqbvDV8VfzdchvOFHsmmKn2SOcScyT9zWtXpaNgT9YSMVKWb74EzQ4aXOw8z8Te7iyvsHFePUSFFRDPRRlfYf7nlTOvM/aGqNyUyG97n3toBPm5FWPLezkVpTfVXCI0DtQxr73u5DmW2STW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821457; c=relaxed/simple;
	bh=24n0O8EihRmwu/U40b2U1GbKUUo+VNmhOv4QXRNc14U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfwZFPc4CPYEdphd/zWmyPKiSx2dqpKP34dgZcOojkjrhpWqy0Exl/IAsteVwUWdj8S9sggEqfYrRG3H5JTLX4tj7j8sg7ShV1LxuLdLl1DykjltHMNoCpjnil2Myj/UokEzi1aNs0MiA8i26novyjfzFxm99+pjBszEb8XnDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfsSuUu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sP3iZPGlfOi9UUNw+wqCkMAcnRxwaFx/V0HEvg4RAIU=;
	b=YfsSuUu3p5tu+iyO4JGFNoTPGPbLgk2EsvNnmouUWmPdNAo7hpceFAxuRTZNcSUbIFzwdz
	QOmLQSXpcrv5fT6wyTKSLY5hEkG/ZBmxRPYcIVBZKLJ6ruEqf4vxafb1v3URaYzhY3Rtnp
	WJQyTMVdnlo2Sao1fUgbNW3aNcH0gc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-CAp74mqCMo2Xhn59WViRog-1; Sun,
 04 Aug 2024 21:30:51 -0400
X-MC-Unique: CAp74mqCMo2Xhn59WViRog-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F70F195608A;
	Mon,  5 Aug 2024 01:30:50 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D521A1955E80;
	Mon,  5 Aug 2024 01:30:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 1/5] cgroup/cpuset: fix panic caused by partcmd_update
Date: Sun,  4 Aug 2024 21:30:15 -0400
Message-ID: <20240805013019.724300-2-longman@redhat.com>
In-Reply-To: <20240805013019.724300-1-longman@redhat.com>
References: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Chen Ridong <chenridong@huawei.com>

We find a bug as below:
BUG: unable to handle page fault for address: 00000003
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 358 Comm: bash Tainted: G        W I        6.6.0-10893-g60d6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/4
RIP: 0010:partition_sched_domains_locked+0x483/0x600
Code: 01 48 85 d2 74 0d 48 83 05 29 3f f8 03 01 f3 48 0f bc c2 89 c0 48 9
RSP: 0018:ffffc90000fdbc58 EFLAGS: 00000202
RAX: 0000000100000003 RBX: ffff888100b3dfa0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002fe80
RBP: ffff888100b3dfb0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc90000fdbcb0 R11: 0000000000000004 R12: 0000000000000002
R13: ffff888100a92b48 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f44a5425740(0000) GS:ffff888237d80000(0000) knlGS:0000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100030973 CR3: 000000010722c000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 ? show_regs+0x8c/0xa0
 ? __die_body+0x23/0xa0
 ? __die+0x3a/0x50
 ? page_fault_oops+0x1d2/0x5c0
 ? partition_sched_domains_locked+0x483/0x600
 ? search_module_extables+0x2a/0xb0
 ? search_exception_tables+0x67/0x90
 ? kernelmode_fixup_or_oops+0x144/0x1b0
 ? __bad_area_nosemaphore+0x211/0x360
 ? up_read+0x3b/0x50
 ? bad_area_nosemaphore+0x1a/0x30
 ? exc_page_fault+0x890/0xd90
 ? __lock_acquire.constprop.0+0x24f/0x8d0
 ? __lock_acquire.constprop.0+0x24f/0x8d0
 ? asm_exc_page_fault+0x26/0x30
 ? partition_sched_domains_locked+0x483/0x600
 ? partition_sched_domains_locked+0xf0/0x600
 rebuild_sched_domains_locked+0x806/0xdc0
 update_partition_sd_lb+0x118/0x130
 cpuset_write_resmask+0xffc/0x1420
 cgroup_file_write+0xb2/0x290
 kernfs_fop_write_iter+0x194/0x290
 new_sync_write+0xeb/0x160
 vfs_write+0x16f/0x1d0
 ksys_write+0x81/0x180
 __x64_sys_write+0x21/0x30
 x64_sys_call+0x2f25/0x4630
 do_syscall_64+0x44/0xb0
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
RIP: 0033:0x7f44a553c887

It can be reproduced with cammands:
cd /sys/fs/cgroup/
mkdir test
cd test/
echo +cpuset > ../cgroup.subtree_control
echo root > cpuset.cpus.partition
cat /sys/fs/cgroup/cpuset.cpus.effective
0-3
echo 0-3 > cpuset.cpus // taking away all cpus from root

This issue is caused by the incorrect rebuilding of scheduling domains.
In this scenario, test/cpuset.cpus.partition should be an invalid root
and should not trigger the rebuilding of scheduling domains. When calling
update_parent_effective_cpumask with partcmd_update, if newmask is not
null, it should recheck newmask whether there are cpus is available
for parect/cs that has tasks.

Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9066f9b4af24..f1846a08e245 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1978,6 +1978,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			part_error = PERR_CPUSEMPTY;
 			goto write_error;
 		}
+		/* Check newmask again, whether cpus are available for parent/cs */
+		nocpu |= tasks_nocpu_error(parent, cs, newmask);
 
 		/*
 		 * partcmd_update with newmask:
-- 
2.43.5


