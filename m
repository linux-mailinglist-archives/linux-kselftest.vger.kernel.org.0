Return-Path: <linux-kselftest+bounces-47576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21669CBCD6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 08:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D82B9300450C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1332E681;
	Mon, 15 Dec 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cnN+fZ/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A832E69C;
	Mon, 15 Dec 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785043; cv=none; b=rSRB7xP+Vnos6c0R+l+a2qw/0Z1c3tsQdjzBPBtXDiclFp0I1A03INie+HKxpxspBjSRoZWgkbmASo3e9V5jVWX0K3PV7YoQ7ZbZdLYQ9a4sfn9yMRox6X2YMXQM4i6+C7S7I4I67Dj4OsWvD+8KMYXF04s3pNuKoLfLYLuyuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785043; c=relaxed/simple;
	bh=/t6y+LLkEm0+PJbWMQGt3yyosJD+7yPGOE7FL8ZFe7I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=vEOMG19bPV1KVtgXoeMebvHeldLpbeygNa9oE77Edaz/HalYpThmQDtYprwsv8ug2BMJcbql8CyLog5R0nda1X417+xzOrfhvR8SqnCgOomcDCCZ1x6bz68HNE+pXd0Zc8uKWaBsXkYZU3sPeSJLsVmKgrZ2UW+gSScfNZdnAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cnN+fZ/E; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765785038;
	bh=4xcvZkMSC5YYucheJfe/1rsYZuLJHZE4HNCoGvQIDdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnN+fZ/EW/K8LVeUn4JVaw2ckLb+hpmJjRSCLl4lcpJO3mGzaAlWJ5ltq3LykGivS
	 3dsxX16tUk8y9RsLHFGFl0RteX5Mc1MTZBs6TlEsRdk95jsbfSK7j0i+4kAZG3M2W0
	 xU08GqmrhJTuDEvmrAuODrYb+gY3ga5XcF53OeEU=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id CA1348BD; Mon, 15 Dec 2025 15:50:33 +0800
X-QQ-mid: xmsmtpt1765785033ts5k3cip7
Message-ID: <tencent_38F3843C852F8CAECF22386E81F151D7A207@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAMBbWgg84slbqoSWobcgrLE+46aQRwPoL0BDReItOde3M67niEU
	 x6m6Tm1nVoTi4dT4ag0dVy7mijd4oaouH2lhxBk6+JLHxirh0pLgjvuIQJii2Dkh5jADCgdrfqDE
	 W3xhDjm4Z2777mPbx76j6e5w4yrQGjSeIYlxAknS5VPALAeHNbpHlCunE36IOzVIPHARCOrTG7VA
	 sb/OV+NmugoNosuoOWGXLWuAxrxKfYVNph0q9vUwMUq6oxE78cXlXlNJEUHVSaG322XFPI8BG2eG
	 sqTgCGp03j1qqBszDijxfoFLqYF7Qd5gmRG6P3okTueMt0RPxhNuGxSISDuQxVVks60ZKOflbO2O
	 dIvRMk77dN9LFM5+dPj3OaftxSheRKLKrl4qe3P7VBIm7x9DhvyriOW2dAmIW2RhnH5aODz2LXj/
	 ol2/OVHNlEnIvCNiCCtGadfuFI6C6BopYRx5yfXAKzhqdbFlnGvrJ5yk6T4fX+pWEp2Vjr3bAJD5
	 bFpkujRWSxqWkP6twQoZ6yvSScmtk7fpeCREI1HivfqbXqlU72M5mPuZCVJXUYSWamOFpgQb/Mjm
	 8Pxc1D3E3PMkBbywT3YeYi3KdJ/EBIFLfvt1pUuSLQvbUgFc+SANxOMu/PkQrWBTwDwUUWylvc62
	 EFnmRfeXG5wxkkUCxrk5BjEdvYmj5XSfPuzICsOihIi495cgZQ0I1IfAfwWVSNqdSG8aF8mon4wA
	 ZCIVn5gCzy6LifVUv9OKS68HhrCK66Rqw1imNXos35PO6OpybQZRGb9zXT/9qqr97dc5pEtNylq3
	 spPTmc87csQzTXqixUorJ3j4MPH4Q+9HhGt/UprWIYsziI3W9IHYTLmOpsLlg27pEBp9nWMVbNjQ
	 qiThZBtRFnSQIfisige/kpX/W+8TbLvzl9F5AlkKrTnoVTePyf5Dt8sBGP4hJvzWc8lF43/BTh2B
	 YQW73QrcybwSZlFiXXXF0uEpxKEdW3TKrNVdfAS2d+wUWNnoXhuNDw0WF2cRH9y2XLjnFusx9LMr
	 zpj/wNncPzwVDwbALa1jFwwNT5pa2bedCuVrQm7NrObvRSKCIqCoFVrR3u0h4ZnBDLfkVeDA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: licayy@foxmail.com
Cc: akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	edliaw@google.com,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
	licayy@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCH 3/3] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Mon, 15 Dec 2025 15:50:33 +0800
X-OQ-MSGID: <20251215075033.2467995-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_735CA2D4910E781E7F514A7DED34A5CE2E0A@qq.com>
References: <tencent_735CA2D4910E781E7F514A7DED34A5CE2E0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on Fri, 12 Dec 2025 12:30:20 +0800, Licay wrote:
> 1. Avoid Parsing /proc
>    The current approach uses get_thread_state() to read /proc/$pid/status, which isn't very reliable.
>    A better way would be to have waiterfn directly signal when it's ready using atomic operations.

I haven't found a better way to check whether a process has entered the
sleep state without using the proc interface for the time being. The kernel
probably doesn't provide a system call to obtain whether a process has
entered the sleep state.

> 2. Use Atomic Counting Instead of Polling Thread State
>    Before entering futex_wait, waiterfn can atomically increment a counter. The parent thread then just waits for this counter to reach the expected value.
>    This is much simpler and avoids the overhead of checking /proc repeatedly.

Using atomic instructions does not guarantee that the process is waiting in futex_wait.

> 3. Use Standard Atomic Types
>    Replace the custom READ_ONCE/WRITE_ONCE macros with standard <stdatomic.h> types like atomic_int.
>    It's cleaner and more portable across different platforms.

Only two operations, atomic_set and atomic_read, are used here. Using
WRITE_ONCE and READ_ONCE can avoid introducing too many dependencies.

> Here's the basic idea:
> - Add a global atomic_int ready_count variable
> - In waiterfn: atomic_fetch_add(&ready_count, 1) right before futex_wait()
> - Parent thread: spin-wait until atomic_load(&ready_count) reaches the expected value

Similarly, using atomic_inc before futex_wait does not guarantee that
the thread has reached the futex_wait execution point.

Thank you very much for your reply.


