Return-Path: <linux-kselftest+bounces-47460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4AFCB785D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EEA301E1AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 01:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3F2749C9;
	Fri, 12 Dec 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VI3pH1Vc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wX3HdKaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68827280C;
	Fri, 12 Dec 2025 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501939; cv=none; b=r1c366XWAzY4QzU/oRMdQ0WFtAd4J1NlVbA+epdbYBRP8U4VoEqq8EsQsGvw0EydurN5s4i7Pd2JocIcOcMFIQbiIG9aS1tzURMXuwIJN85wvvavxrbzKOtndFSVynjqzqy0qsbiUmIZTM9Od3lIaPghCxHUjIKK/Nr20uZriDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501939; c=relaxed/simple;
	bh=5hWXJxhX5wME82FGFIrBRzJRgBsQr+OdqP9sUt7Njis=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lhZloGHPspCQOYHaH0TbBE5q2DtQhvIvzJJnJ1XY0kn4zExBQYSSvhtlSHz0lDzDVjCln9RHQnvcubpeacNG9bQLj2Ud1vD1IDTD6o2UAzjKJXzSabsI18I5ofQCtAmFDbkxb5GZVo/8VYrj4Arojd3vwSvaIvxLNzEwD8INCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VI3pH1Vc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wX3HdKaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765501936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hWXJxhX5wME82FGFIrBRzJRgBsQr+OdqP9sUt7Njis=;
	b=VI3pH1VcrifbeS9kA3FPBSHylFeLOXjGAye2KPD1jpu3JUjgxWpVrJ7FpQfVodUHXTPATC
	PQlw6QNdJC8x3jc3F7/cvot67LJEbPwOVjjCuGOKF06aYRXBEKuXVBjTQO3rNVN8b2hBhQ
	Yl3yor8zKz7LVv5/SB23naFPfsbs5EwQ7Sn0p2S7wqJ1UN1eZTVTiZ2WWwZW//z9vYv3rD
	OhKN3zFynVYPnDa1v3JPtxSB+ZVXKoeQCfCyW7TiojfhNwEq77I79urwK+TPPzwrc5K/mN
	UpjuzcfUNuBZI3bD4d7Ah5IJ51GjTwUwJC5bk3pkqA4qB+e4NbGbrSFULQvOTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765501936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hWXJxhX5wME82FGFIrBRzJRgBsQr+OdqP9sUt7Njis=;
	b=wX3HdKaaXflaOMKhWkolNsCkdzaVm6/IgPyOJ8qgM/d5MMYeT9V0ed4WOBgPjrqHHa52MA
	7L1NceDmnev/reDQ==
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
In-Reply-To: <e55e9aae-1d84-42a2-bf6a-edc73608733a@arm.com>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
 <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com> <87345hfqyh.ffs@tglx>
 <e55e9aae-1d84-42a2-bf6a-edc73608733a@arm.com>
Date: Fri, 12 Dec 2025 10:12:13 +0900
Message-ID: <87wm2sec5u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 11 2025 at 10:52, Kevin Brodsky wrote:
> On 11/12/2025 07:55, Thomas Gleixner wrote:
>> I have a suspicion that it is TIF_NOTIFY_RESUME. If that's the case
>> you're seing the RSEQ overhead, which should be completely gone with the
>> rewrite that got just merged into Linus tree.
>
> I don't think this is related. This patch inlines syscall_exit_work(),
> which is called if some flag in SYSCALL_WORK_EXIT is set. This includes
> syscall-specific stuff like tracing and singlestep. TIF_NOTIFY_RESUME is
> part of EXIT_TO_USER_MODE_WORK, handled in exit_to_user_mode_prepare(),
> and isn't specific to syscall handling.

Indeed. Confused myself.

