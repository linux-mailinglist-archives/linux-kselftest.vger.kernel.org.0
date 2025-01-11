Return-Path: <linux-kselftest+bounces-24295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B69A0A51C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B0168E92
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97B1B4232;
	Sat, 11 Jan 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAk+4vcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95D1FC8;
	Sat, 11 Jan 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736617417; cv=none; b=T/oJvV1R512qUHY220Uek4JgxBJ/rtShULDMK/3arhIeGDJOE802vDPK0D9aglJBlEg8KBYqOQHt81ykO+r8w+eKAFL3pKS9NJ2XQvEokjQBxW3PH0TYwdAEr3du3kaZPEG6iV5fnBg4LPPlC/SuiHjRVeWDFo4VGNf+xvaDpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736617417; c=relaxed/simple;
	bh=gfwzQfof4FDZzhjP1I8FK4NWQ2wQZrEEDHH9veGrIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeZ8noG896bwfb0JLUJLVidm4xsR14L86LnAQjPt0V09clut0M33CWTFhKaas7JejificMt8h3XbJx8JtNN+0zjtuSj7ZhSgg8GsXL98QxIr0Z7jP/fu1AV/aCqKxgonvW/XwFvbciz2t2lie5isbFXbI6JXy+mHH9tJAg1WfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAk+4vcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB5C4CED2;
	Sat, 11 Jan 2025 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736617416;
	bh=gfwzQfof4FDZzhjP1I8FK4NWQ2wQZrEEDHH9veGrIXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAk+4vcRAWVH7DLIjuAcmIWQH2hTQoO8I/VFZgL3IeATxvuh+mifQNiieVXvNHWEc
	 HgYYkUO6JGvS4Kr2bm1wI57qlWqNVeaaC72ytPy0Bj8RA/z3f8iEO6IBLBhSY5/GWa
	 CT+SGTMj19zr+dJDWHfohI7AvH016fgaeh5GcCovfJZjMYAjMqMskjTQYxfRzGdF0V
	 5GMoTeCMhYw52NOKgzIqf7Y5yTWlbzV+EoV1iYuVLQCaOWkkwTGhXSgIZqzzsCIexP
	 bs4ZMnGTMqVXElkPXycxl0GfJFQ3SW/9In6Kr2utuCN72J4kcq6TSZK3jX47fAU28S
	 0LtnxcIF6IG0w==
Date: Sat, 11 Jan 2025 12:43:35 -0500
From: Sasha Levin <sashal@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	LTP List <ltp@lists.linux.it>, Barry Song <baohua@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
	David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [LTP] selftests: core: unshare_test: WARNING: at mm/util.c:671
 __kvmalloc_node_noprof
Message-ID: <Z4Ktx-wizYLYnQfM@lappy>
References: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
 <CA+G9fYuHGTKM5P+nEifZwfALPfO9uw7sraCrGo-c3YzR=JjwJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYuHGTKM5P+nEifZwfALPfO9uw7sraCrGo-c3YzR=JjwJg@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:09:46AM +0530, Naresh Kamboju wrote:
>[Gentle Reminder]
>
>On Mon, 26 Aug 2024 at 18:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> The following kernel warning is noticed on all arch and all devices while
>> running selftests: core: unshare_test on Linux next-20240823 and next-20240826.
>>
>> First seen on next-20240823.
>>   Good: next-20240822
>>   BAD:  next-20240823 and next-20240826
>
>This is an open issue from August.
>The reported kernel warning is still seen on linux next and mainline
>while running selftests: core: unshare_test.

I attempted a bisection of the range provided above, and that has landed
on: 611fbeb44a77 ("selftests:core: test coverage for dup_fd() failure
handling in unshare_fd()"), so the underlying issue was probably there
for much longer.

Al, any thoughts on what could trigger this? I'm assuming you had
something in mind when you added the above test?

>Linux version: 6.13.0-rc2-next-20241210
>> Crash log:
>> --------
>> # selftests: core: unshare_test
>> <4>[   61.084149] ------------[ cut here ]------------
>> <4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
>> __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
>> <4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
>> sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
>> <4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
>> tainted 6.11.0-rc5-next-20240826 #1
>> <4>[   61.094558] Hardware name: linux,dummy-virt (DT)
>> <4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
>> -SSBS BTYPE=--)
>> <4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
>> <4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
>> <4>[   61.100448] sp : ffff800080abbce0
>> <4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
>> 0000000000000000
>> <4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
>> fff0000003615e40
>> <4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
>> 0000000200002000
>> <4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
>> 0000000000000000
>> <4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
>> 0000000000000000
>> <4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
>> 0000000000000000
>> <4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
>> 0000000000000000
>> <4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
>> 0000000000000005
>> <4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
>> 0000000000000000
>> <4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
>> 0000000000000000
>> <4>[   61.109262] Call trace:
>> <4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
>> <4>[ 61.110248] alloc_fdtable (fs/file.c:133)
>> <4>[ 61.110751] expand_files
>> (include/linux/atomic/atomic-arch-fallback.h:457
>> include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
>> fs/file.c:238)
>> <4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
>> <4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
>> <4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
>> arch/arm64/kernel/syscall.c:54)
>> <4>[ 61.112480] el0_svc_common.constprop.0
>> (include/linux/thread_info.h:127 (discriminator 2)
>> arch/arm64/kernel/syscall.c:140 (discriminator 2))
>> <4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
>> <4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
>> arch/arm64/include/asm/irqflags.h:76
>> arch/arm64/kernel/entry-common.c:165
>> arch/arm64/kernel/entry-common.c:178
>> arch/arm64/kernel/entry-common.c:713)
>> <4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
>> <4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
>> <4>[   61.115709] ---[ end trace 0000000000000000 ]---
>>
>>
>> Crash Log links,
>> --------
>>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log
>>
>> Crash failed comparison:
>> ----------
>>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/
>>
>> metadata:
>> ----
>>   git describe: next-20240823 and next-20240826
>>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>>   git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
>>
>> Please let me know if you need more information.
>>
>
>Kernel warning log:
>-----------------
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241210/testrun/26261199/suite/kselftest-core/test/core_unshare_test/log
>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
>
>-- 
>Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Thanks,
Sasha

