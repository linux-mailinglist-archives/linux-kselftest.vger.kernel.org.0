Return-Path: <linux-kselftest+bounces-33987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889FAAC7B7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D50A7A43E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0DF2797AD;
	Thu, 29 May 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKnUbsHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66921A452
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512816; cv=none; b=NRMsmeqmzf7jyyAclwA3NGc5MgwXOP6wNOOVJDOYAZ2oqE29wbfZiWDqiI2OD5KG1DvcEh/qaPGkaL106LUpZJgkwlX38WABew+J8fPqmtm+XL3G5nkC+doOM28PVT4lllcqpWrMb34OjxdRdNaYcPiUM+Bcc7DYmqVVVlwFk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512816; c=relaxed/simple;
	bh=/o+pGUCJ2E5HoBczbCx4HweIPeWKZgZ3uF4oHA/2+As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW6Cfmf1ZSAfoa79oLI3U3fybiH9hgaY+ABTjDwGK6zxdFwOlXxFGkTQNgwspkvfMufXg+fQp1uGoUzQHOSj7DuMq6a3fc2N9CtnLF1zhIY5Lyqj+ywjiqr8Uhib2U6IvUNvJlMD6axjVFCgcybvY9iQvDmxb+n2OlEHG2Uwf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKnUbsHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748512811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zibuTGA0nXBdxoQDJlbPTHKTXU5J45rtDsSqDQ/Mtd0=;
	b=LKnUbsHjzWjayAveaxeGTKr05oyR68g0EQjpphm7rAp54bBozVmmcOWvEBGUvWHMhCRVMr
	eqBzCGo/BK3IWzB+Bp34XMwmxdCcUsO7bLZ3rvs+tGSXKaxo9/wCjYgPaALkydUKlsUwJz
	HXY5bq6DMMTzrBd3C/2XSgRfrNsr02I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633--1up1J2wNLC5Wzxz29HCWg-1; Thu,
 29 May 2025 06:00:08 -0400
X-MC-Unique: -1up1J2wNLC5Wzxz29HCWg-1
X-Mimecast-MFC-AGG-ID: -1up1J2wNLC5Wzxz29HCWg_1748512807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 616AB19560AE;
	Thu, 29 May 2025 10:00:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FEEF19560AE;
	Thu, 29 May 2025 09:59:59 +0000 (UTC)
Date: Thu, 29 May 2025 17:59:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/8] ublk: have a per-io daemon instead of a per-queue
 daemon
Message-ID: <aDgwGoGCEpwd1mFY@fedora>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, May 27, 2025 at 05:01:24PM -0600, Uday Shankar wrote:
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
> 
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
> 
> Therefore, address this issue in ublk_drv by allowing each I/O to have
> its own daemon task. Two I/Os in the same queue are now allowed to be
> serviced by different daemon tasks - this was not possible before.
> Imbalanced load can then be balanced across all ublk server threads by
> having the ublk server threads issue FETCH_REQs in a round-robin manner.
> As a small toy example, consider a system with a single ublk device
> having 2 queues, each of depth 4. A ublk server having 4 threads could
> issue its FETCH_REQs against this device as follows (where each entry is
> the qid,tag pair that the FETCH_REQ targets):
> 
> ublk server thread:	T0	T1	T2	T3
> 			0,0	0,1	0,2	0,3
> 			1,3	1,0	1,1	1,2
> 
> This setup allows for load that is concentrated on one hctx/ublk_queue
> to be spread out across all ublk server threads, alleviating the issue
> described above.
> 
> Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk servers
> can use to essentially test for the presence of this change and tailor
> their behavior accordingly.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

This patch looks close to go, just one panic triggered immediately by
the following steps, I think it needs to be addressed first.

Maybe we need to add one such stress test for UBLK_F_PER_IO_DAEMON too.


1) run heavy IO:

[root@ktest-40 ublk]# ./kublk add -t null -q 2 --nthreads 4 --per_io_tasks
dev id 0: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 524288000
	max rq size 1048576 daemon pid 1283 flags 0x2042 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(8 )
[root@ktest-40 ublk]#
[root@ktest-40 ublk]# ~/git/fio/t/io_uring -p 0 -n 8 /dev/ublkb0

Or

`fio -numjobs=8 --ioengine=libaio --iodepth=128 --iodepth_batch_submit=32 \
	--iodepth_batch_complete_min=32`

2) panic immediately:

[   51.297750] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   51.298719] #PF: supervisor read access in kernel mode
[   51.299403] #PF: error_code(0x0000) - not-present page
[   51.300069] PGD 1161c8067 P4D 1161c8067 PUD 11a793067 PMD 0 
[   51.300825] Oops: Oops: 0000 [#1] SMP NOPTI
[   51.301389] CPU: 0 UID: 0 PID: 1285 Comm: kublk Not tainted 6.15.0+ #288 PREEMPT(full) 
[   51.302375] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   51.303551] RIP: 0010:io_uring_cmd_done+0xa7/0x1d0
[   51.304226] Code: 48 89 f1 48 89 f0 48 83 e1 bf 80 cc 01 48 81 c9 00 01 80 00 83 e6 40 48 0f 45 c1 48 89 43 48 44 89 6b 58 c7 43 5c 00 00 00 00 <8b> 07 f6 c4 08 74 12 48 89 93 e8 00 00 0
[   51.306554] RSP: 0018:ffffd1da436e3a40 EFLAGS: 00010246
[   51.307253] RAX: 0000000000000100 RBX: ffff8d9cd3737300 RCX: 0000000000000001
[   51.308178] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   51.309333] RBP: 0000000000000001 R08: 0000000000000018 R09: 0000000000190015
[   51.310744] R10: 0000000000190015 R11: 0000000000000035 R12: ffff8d9cd1c7c000
[   51.311986] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   51.313386] FS:  00007f2c293916c0(0000) GS:ffff8da179df6000(0000) knlGS:0000000000000000
[   51.314899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.315926] CR2: 0000000000000000 CR3: 00000001161c9002 CR4: 0000000000772ef0
[   51.317179] PKRU: 55555554
[   51.317682] Call Trace:
[   51.318040]  <TASK>
[   51.318355]  ublk_cmd_list_tw_cb+0x30/0x40 [ublk_drv]
[   51.319061]  __io_run_local_work_loop+0x72/0x80
[   51.319696]  __io_run_local_work+0x69/0x1e0
[   51.320274]  io_cqring_wait+0x8f/0x6a0
[   51.320794]  __do_sys_io_uring_enter+0x500/0x770
[   51.321422]  do_syscall_64+0x82/0x170
[   51.321891]  ? __do_sys_io_uring_enter+0x500/0x770




Thanks,
Ming


