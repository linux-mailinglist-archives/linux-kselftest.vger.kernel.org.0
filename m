Return-Path: <linux-kselftest+bounces-5503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1986A22C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 23:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149F4282C13
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19E150981;
	Tue, 27 Feb 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvhWH8Ug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE714F992
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071833; cv=none; b=Nw+ntez0OesU4rXP9rda+3NSBr67mCwLq9NVdfR/9HelCZ8CGOxhWVW66CqoyqLxVj8S55Zlz6mmMRgkHNPRmUN7Bc0YYd/T4igqj5FRIV6HG5Nmaj2sf1P2Ry/+ojz+sSJz8TckPzizq8XY/t6YDK9PK5nmAvdmADWwjtU73Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071833; c=relaxed/simple;
	bh=l5Gn3Y2wTP33SecTGWSjFrwoXtHJc9JO2z8Yw3ZZdFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G50Y1q6f0HdQCZddvH1tYK933DSs419H3aWxQk9Es24xlFphtorSDIkkT7LgV0EgxGfW9G2+97fUmSPvdPEJ8366NFwmUgNIQpKn02T4nUMJhhKMxcLbqo8kdlXh6edC89B1QL1sJlkXGdZrNecgxRXFNCMs232pw9zHKKJcRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvhWH8Ug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709071830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FlDDPvmPPqYNYU0IMKtke8zEsxFWk9OvTWFnzQYyYs=;
	b=NvhWH8UgNvHCscgcLq9S5793SckFICqjIJHVJ6qUFmLhNL32HbPTBxNq7nzl600JHDVqAW
	vm4DVR026SwDqdGzyd3IgCd4BvNJwEqX85riw2xYryjI85dhqy417bTFyy0v7f2U/8ttB7
	/6kFoYt0Zob1O2rKq5H5A7RmZ6kOrvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-D3jpE1qkOsqHDdyRZa-3Vw-1; Tue, 27 Feb 2024 17:10:26 -0500
X-MC-Unique: D3jpE1qkOsqHDdyRZa-3Vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6F401024D05;
	Tue, 27 Feb 2024 22:10:25 +0000 (UTC)
Received: from [10.22.17.72] (unknown [10.22.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 734B7492BE2;
	Tue, 27 Feb 2024 22:10:23 +0000 (UTC)
Message-ID: <d1af171a-49e5-4dcb-987c-c41cf166bac1@redhat.com>
Date: Tue, 27 Feb 2024 17:10:22 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests: cgroup: KMEMLEAK in cgroup/test_cpuset_prs.sh
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>, linux-kernel@vger.kernel.org
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 2/27/24 14:50, Mirsad Todorovac wrote:
> Hi, everybody,
>
> In the latest vanilla torvalds tree kernel v6.8-rc6-11-g45ec2f5f6ed3 
> on an Ubuntu 23.10 system, there
> KMEMLEAK detected a couple of memory leaks:
>
> Visually it appears like the same leak repeated six times, but I 
> reckoned it might be of importance to
> review them all.
>
> It happened on two boxes, and both have AMD Ryzen processors 7 and 9.
>
> Please find attached the build .config
>
> Best regards,
> Mirsad Todorovac

Yes, you are right. There is a memory leak under certain condition. Will 
post a patch to fix it.

Thanks,
Longman

>
> # cat /sys/kernel/debug/kmemleak [stack decoded]
> unreferenced object 0xffff8d49bd92a720 (size 8):
> comm "test_cpuset_prs", pid 9213, jiffies 4294953562
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:643 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
> unreferenced object 0xffff8d49bd92a488 (size 8):
> comm "test_cpuset_prs", pid 9213, jiffies 4294953562
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:646 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
> unreferenced object 0xffff8d49bd92a890 (size 8):
> comm "test_cpuset_prs", pid 9213, jiffies 4294953562
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:649 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
> unreferenced object 0xffff8d48c12f3720 (size 8):
> comm "test_cpuset_prs", pid 28081, jiffies 4295018483
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:643 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
> unreferenced object 0xffff8d48c12f3180 (size 8):
> comm "test_cpuset_prs", pid 28081, jiffies 4295018483
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:646 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
> unreferenced object 0xffff8d48c12f3188 (size 8):
> comm "test_cpuset_prs", pid 28081, jiffies 4295018483
> hex dump (first 8 bytes):
> 00 00 00 00 00 00 00 00                          ........
> backtrace (crc 0):
> kmemleak_alloc 
> (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
> __kmalloc_node 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3817 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3860 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3980 
> /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3988)
> alloc_cpumask_var_node 
> (/home/marvin/linux/kernel/linux_torvalds/lib/cpumask.c:71)
> cpuset_write_resmask 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:649 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:2601 
> /home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cpuset.c:3630)
> cgroup_file_write 
> (/home/marvin/linux/kernel/linux_torvalds/kernel/cgroup/cgroup.c:4092)
> kernfs_fop_write_iter 
> (/home/marvin/linux/kernel/linux_torvalds/fs/kernfs/file.c:334)
> vfs_write 
> (/home/marvin/linux/kernel/linux_torvalds/./include/linux/fs.h:2087 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:497 
> /home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:590)
> ksys_write (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:643)
> __x64_sys_write 
> (/home/marvin/linux/kernel/linux_torvalds/fs/read_write.c:652)
> do_syscall_64 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 
> /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe 
> (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
>
>
>
>


