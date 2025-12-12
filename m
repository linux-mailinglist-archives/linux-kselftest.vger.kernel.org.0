Return-Path: <linux-kselftest+bounces-47478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4373CB7DD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812EC3027184
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEE2749D2;
	Fri, 12 Dec 2025 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fquwB5u4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6207255F52
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765513842; cv=none; b=G4hrzN3QBZBHVf/KxqIwWBADo/dY4AhhmI99e2ENN4GtZhBoTX+8ZbHwu7/78YYatuGTtxoECsIcpa5qDlrmnPX5d5GlY/cuDniliVFaKGr1G6IZJJcp5iXm4blV+z0UxCZTksc7iaMPljz7Zn/Es9hl5rbJtq1hzwv4ofaEw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765513842; c=relaxed/simple;
	bh=G4U9g3m1Y8+FQFjUgsitU6Hw75sM90WYd7apsdyDX24=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ip0wbGE44W7/5HcU/fXJsWZHkQmIgpGUa06nfIr/H5QNQKR4pu7BbYuA/v+cvxc3y4BnY9xWAX/CsCMwBnhx4XvzLWPFec3HMwggkyjgnFL1j1x6tBxt5olST6PEbqXDf67kqFZG61LIUBcPQDNPQ6V+7zoWU0NMjQP7AV5reHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fquwB5u4; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765513836;
	bh=5rYXFUzmHwfYdKhXjiWDBeziZId8xfDekbig16I89Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fquwB5u4GWdXmm0qyA5awrI6KsVsmWQ5/hof6SrwOIm4g0bGqUJ7CvnuNx1lB6P40
	 sRpcpJ5CT0PMIVH7TeYYqQS9dgXCDFioQJRn0bJeX5h61QjrA6LybK0VY6pmoVhC1h
	 2FOzn6eqk+wA2M4ooBZUqJ2mqfmY56qykwGFrLqQ=
Received: from meizu-Precision-3660-casey.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 79634099; Fri, 12 Dec 2025 12:30:22 +0800
X-QQ-mid: xmsmtpt1765513822tlj8iqyn8
Message-ID: <tencent_735CA2D4910E781E7F514A7DED34A5CE2E0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy705yfgz/SkL340sPsOUypR2JHIZQK78pRc0GyQugDkP9SqaATtdX
	 nktxim17+bA4Pd+IEPDAq/B5V2DNjady/0XMkCFl4eR9/acOBB/B/QBU3olIZOfwT+i8AZLEcKS3
	 P80GeaN+vaYj/I8oC2W6Cht+Qoa+WhwzfCqkHOekxu/r1rCFwcdPBL0RF3Ew3tv+mYXsSi8BCnZt
	 Xvl2lvBZ6WJeibFEYo7EbAN37JQNQgFyQpDuKRIG1QDKg8Vr3oEGXch89/btFtRI+XfKuCLemY8e
	 5Ea4QBvw6lYIXwwKf6bn8NMIs0L7lNwf5aOQONOc2jM2dIIOkp7NM6W0tCE8seTqmAatVnHXDPSk
	 6rG1Zjp1PFO15ED29V4XUUPca3FUzYxVbKVWMt9NrXZBarTLwExm4q2xKm1HCPLys4FnJce/mH2v
	 roCj6eUDN9zzfxc/dzmk1Jus177Qz6vJe35f30asazZGHBiJkyk+Znw8+Lki+GLCSYOD98vpMeHL
	 mZzypm/+6w6T8f/G/1yIKLOr7W15VCHkwBFXOmtZY8Bc1j0czBfIqw2X2uW0FE92PoWg5Gg7ITsz
	 MZmDxOpvNRpEZnFyExCvM0SFRpcvRTqPhC2JWQybFQtwJ5luUlE+P5faaR5tzq956HGWAfabwpsi
	 MXmCPwW17G/91ulDRrlBwcXCUlaXuctpgos5K1fjp9WvleouNGudn9+t1NcIDLxA4hSakDVoEhER
	 IeT8myQ+96eTUO9aCS3jO4W3wCq+JFOiRVJl9v9I2RlT1bR9J7191jtFvDDU00zbxvfADQsf3iqk
	 SuU/D7m6XC1oOd/1Q6gVxYOkbJXo5RzNRlhnXuUy+ZsnvnH7JZ7Ksr3TcNDLiLGbtSz3ZtrOi6L7
	 dFPPRwaV5mRnK/hTBv4CmQBPCOTYmF4vrVlhKyYTh7PoRvwoUrdHFWdizOcjXAY3Hf9RqXWHQpz7
	 AxqrilNXq1+rPqPG1s6rVv5R6/20fjlD6mKgyvn9get7HQ5pG/wh2CXBmbHeEoYFf3u7UgUbnN2g
	 qhv0ZalppyrumgtPu2lw57/8utXiS7tvFvLwWhT14mkD0jk4MEmmdlFBXsKyc9VcMgG2RJo5eVUh
	 UTmot60eIMDkiFcgVq3ZnJjHHiOLyC/D4jLpjkHo9SOhYmNws=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Licay <licayy@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	edliaw@google.com,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
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
	Licay <licayy@outlook.com>
Subject: Re: [PATCH 3/3] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Fri, 12 Dec 2025 12:30:20 +0800
X-OQ-MSGID: <20251212043020.640438-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
References: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Licay <licayy@outlook.com>

Hi Ywen,

Thanks for the patch! I have a few suggestions to improve it:

1. Avoid Parsing /proc
   The current approach uses get_thread_state() to read /proc/$pid/status, which isn't very reliable.
   A better way would be to have waiterfn directly signal when it's ready using atomic operations.

2. Use Atomic Counting Instead of Polling Thread State
   Before entering futex_wait, waiterfn can atomically increment a counter. The parent thread then just waits for this counter to reach the expected value.
   This is much simpler and avoids the overhead of checking /proc repeatedly.

3. Use Standard Atomic Types
   Replace the custom READ_ONCE/WRITE_ONCE macros with standard <stdatomic.h> types like atomic_int.
   It's cleaner and more portable across different platforms.

Here's the basic idea:
- Add a global atomic_int ready_count variable
- In waiterfn: atomic_fetch_add(&ready_count, 1) right before futex_wait()
- Parent thread: spin-wait until atomic_load(&ready_count) reaches the expected value

This approach is much cleaner - no /proc dependency, simpler logic, and better performance.

Best regards,
Licay
Signed-off-by: Licay <licayy@outlook.com>


