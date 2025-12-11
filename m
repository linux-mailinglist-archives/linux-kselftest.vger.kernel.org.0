Return-Path: <linux-kselftest+bounces-47393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31473CB4F0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 07:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FEEF3016FA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CF02BE7AC;
	Thu, 11 Dec 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZvPVcBG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zX3A905+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367E2BDC0F;
	Thu, 11 Dec 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436122; cv=none; b=I3qC+MTZzffaHVjWi1a4HNAJHZew5Xlz2LVjm79sZY4Q0kr1KanGTa1qUMFQwwyc6tUynpGZFYdz3TGQ5RWLs2UF7WvjH3PCW5hY2v/x7KhO0DVVTDqDlW85QAEGDK3aLjUZ9pbVdTc52URilAamcZjxsjl86CHnQmuYoccVN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436122; c=relaxed/simple;
	bh=NkUxSZD/i7BIPKTKRsZIdWTXlYiWuLKixKknfL8XwUs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HJwA2oGC8dZJc46THmJUUyQPfELxnlZUdMaVb9TNPOZcFAP8Ll9TQ/yUC+4PLnPZosAiEeBQcgItCI+TOSl4tiPawtE3uFP/AcrFTtQX4DaPZv1G6r1rVRwfOeMaEmSy4VTHOMLd28QHoex1dXuKY1oHuHYxsyO1cAydeYHSd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZvPVcBG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zX3A905+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765436118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9h1OWF96CLddow2coOp3QyLXBxCw3plI/1ZkVxSj6E=;
	b=EZvPVcBGLN+2H2qD7HiWivEen45LTqFjFqGAgTWy009qCWAR5nf7GSpxgRB8ZheeE34aq1
	DOk9BF5i3LrVdKKl/UwCXiYYU6seMhqR6rC/Juo/jw15ZPEb90dMor5oeSYNuVVwTbR+A0
	fudl7h0XWTH2H0Uvu9XfbrZ2rBusoyeMdo6t/a0Wbsa8v1mlUF9FTfXqjFcf1WIm2hNM6K
	H+3Nsdks7b+RTu1R/1Enm005+od8SBb/eeu1mUXe9N4hqby/eDOLsw8D2mUfXZ0VlSCFEv
	fU9f85XefDM7YVMmxM3gsNKQrtJnIze0flVKSA6HughLKxCT7RxZOsDV5cYzKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765436118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9h1OWF96CLddow2coOp3QyLXBxCw3plI/1ZkVxSj6E=;
	b=zX3A905+owe9rwEyNBGgJtGLbXhfLVD5ZzymJxWEp6aqMvQMFz0wzXZlyGNK6ycc28YDgZ
	0/GVr7NDNMqi/iCw==
To: Kevin Brodsky <kevin.brodsky@arm.com>, Jinjie Ruan
 <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org,
 oleg@redhat.com, peterz@infradead.org, luto@kernel.org, shuah@kernel.org,
 kees@kernel.org, wad@chromium.org, deller@gmx.de, macro@orcam.me.uk,
 charlie@rivosinc.com, ldv@strace.io, mark.rutland@arm.com,
 song@kernel.org, ryan.roberts@arm.com, ada.coupriediaz@arm.com,
 anshuman.khandual@arm.com, broonie@kernel.org, pengcan@kylinos.cn,
 dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 15/16] entry: Inline syscall_exit_work()
In-Reply-To: <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
 <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com>
Date: Thu, 11 Dec 2025 15:55:02 +0900
Message-ID: <87345hfqyh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09 2025 at 14:48, Kevin Brodsky wrote:
> On 04/12/2025 09:21, Jinjie Ruan wrote:
>> After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
>> appeared because syscall_exit_work() is no longer inlined. so inline
>
> Before this series the call to syscall_trace_exit() in el0_svc_common()
> could not be inlined, so "no longer inlined" doesn't seem to be accurate.
>
>> syscall_exit_work(), and it has 2.6% performance uplift on perf bench
>> basic syscall on kunpeng920 as below.
>
> That seems strange. syscall_exit_work() is only called if some flag in
> SYSCALL_WORK_EXIT is set, which means that we're doing something special
> like tracing. That shouldn't be the case when running a simple perf
> bench syscall.
>
> Also worth nothing that its counterpart (syscall_trace_enter())) is not
> currently inlined, the asymmetry would have to be justified.
>
>>     | Metric     | W/O this patch | With this patch | Change    |
>>     | ---------- | -------------- | --------------- | --------- |
>>     | Total time | 2.171 [sec]    | 2.114 [sec]     |  =E2=86=932.6%    |
>>     | usecs/op   | 0.217192       | 0.211453        |  =E2=86=932.6%    |
>>     | ops/sec    | 4,604,225      | 4,729,178       |  =E2=86=912.7%    |
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  include/linux/entry-common.h  | 63 ++++++++++++++++++++++++++++++++++-
>>  kernel/entry/syscall-common.c | 59 ++------------------------------
>
> These changes are purely generic, surely all architectures using
> GENERIC_ENTRY should get similar benefits (assuming LTO isn't used)?

Correct, but as you said this does not make sense as the syscall exit
work should be rare.

Jinjie, can you please figure out which TIF bit is causing this to be
invoked?

I have a suspicion that it is TIF_NOTIFY_RESUME. If that's the case
you're seing the RSEQ overhead, which should be completely gone with the
rewrite that got just merged into Linus tree.

Thanks,

        tglx



