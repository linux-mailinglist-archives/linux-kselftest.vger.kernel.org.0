Return-Path: <linux-kselftest+bounces-47596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A43CC1C38
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67231303C83D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C579328261;
	Tue, 16 Dec 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xzGVDH3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614252D8DDF;
	Tue, 16 Dec 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876759; cv=none; b=ryUj6JfjJqbAC/vWbBTgSB8DTEwZIGY3zznvMDdMCgeCZPGopLdJf7GunysJvyyHuiE/YHWzFoW67VrFjUModbeHNdAl6YRAO1fayWqhl61UBFlrN2hDHP5/l4n0u+d8pmionq/00yNpp8MOyw7YLUyDl3TEIeMp8xxJ2zju9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876759; c=relaxed/simple;
	bh=j0l9bHcYi2OyVD05iFn+9D9HSZYKbGafOTio1/IMZfs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CoRdagsLILrZ4jZA6caGVNWxyDz1H/xBil8UkR7A91b4V5AHlz3IZ9Rs9CAUrD5a78PqLDmdwfOUhMMVr/vVU89FJ4CPX1m9IcG510SpU9aYJdMlkpCsEjdD/1fX62VQfGgLEwiXZoXxFM/bSit+71N4YPw+q07UMQ2uAT+ml3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xzGVDH3X; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765876752;
	bh=+p1Ovp6aX/21hIWV61+zLi6V26YcLBMVDrQizO8eE2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xzGVDH3XiHkko3/r5wg3bKhwICU2La244WQq2asXqO/H8nH/HbgNVZIAAiMAq8uRR
	 8NBRhRLAbVFwXCS/qQJH/Lo1zmxSms2j3y7PlUtE71A4XvJI/6NZ/QhYXLp1z8uhO9
	 GeFyVx6hF9K+0yjMxPLHd1vhLw4AOgWkoSy/DvUs=
Received: from meizu-Precision-3660-casey.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4C32E0A7; Tue, 16 Dec 2025 17:19:03 +0800
X-QQ-mid: xmsmtpt1765876743t3l7djlyi
Message-ID: <tencent_14CA2C6995E7C11795D4F60E656AD9422C06@qq.com>
X-QQ-XMAILINFO: Mu/Y/wNdJF3zpalTRJXdyTl1WMKOxe8rCHvfKkfFjEwu07KnmtQcHEI9hHJVNi
	 0MkP2f8fBi8eRapugQnnqs+wUBxjMNva4evjh73mWQPEwyrkaG+bDioZTUyg6mdkjidA/ACJipgU
	 LtH6VcAH5/AhM6AKutLYw7u+SHtW1rnXrk9bS/GIjFm0aKFwBS63UxnywLVX1GBc7EtAOg5hp66g
	 sN72IO0Lu4eiBdg+nKaKF1x94gVOoU8ZDWkUdr3lVfQ/as9FHOhreNsoNZSLSJNeWfLpcrKHlkKX
	 0mw2f1MuByyD8D3uBD5XhZTfaq6RIcCTQO5gu68+rHD9IHBYPFCnmNWQxUTb2ezSC2IyV6SsPd6N
	 csyWRXuFGg1cCOw6Nu4Qe5rCmBjsRf1Na+TyxqaI/RyX04Awj+AtR2V9EUkjKMO+mpfP/wlwczFX
	 JBhRAY17C5GjO8PeKy+FY42rieUiCBXyF1Ub4BI+fVwgACwJb1KoPU7rKSE6ZwQ4cvYJOQ8LXYKW
	 eMvQmq7MK9mfifERvDqs+OMZaUIEJI+R6jGnnbYDKlhNAx6Ok5iAWbbNStUAFNtK+7hjxXVRyGXF
	 Br9Z/Qb6mN/Yqgcaq8PN32Qta0k18qlrvYE8Xa2jiUUUptLyGw8mOcOvNnqPfK3U0c/p21HYvXID
	 axElotLuiFwp9ai800/XxLQ4OCI/IFzvEXJdIjeGzDpCxbbLzDBxhvQIxxzLgWl2j4QAUO0W0+P+
	 e9qe5yAzYWDHm4Ic3QhT7qs50SUzLWHr9vFRK4eWsQHOWJW2yHXiYj2W/2MuEB8/8Qn+Ati/dZWS
	 XVUIo3ku/pZJXeegAt9Z7QPSsB8IQ69+RHRkWEfmHEHVjemrPT1svEsgjLIWYgKT+rS9NauxArBR
	 gbKWPhneMwd/m39PbYo0S0Op4GaSsR3xrHRS2WxkdxR0OblRcPvTXl1+lpy4xXJQLz9A4ASbpOT9
	 xeiLDK6JQmE5+ULTU/5smlUM/59pUqU6bXrng8KWy4q1DgfToI2l1CLwa7Mf+IgV20nT+LX3YjxG
	 ykKe5yiQgN0v4nTatWjZuSdiASwhN75/7q0+ryKLOXGIE2LdpwN2bIMdSb8RTaJTNthoXE+Uouo5
	 rHYvIG7jUBTMNjAoQJOcZ/FdPEHsSosbsB+dXp
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Licay <licayy@foxmail.com>
To: ywen.chen@foxmail.com,
	akpm@linux-foundation.org
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	Licay <licayy@foxmail.com>
Subject: [PATCH v2 5/5] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Tue, 16 Dec 2025 17:19:02 +0800
X-OQ-MSGID: <20251216091902.428791-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_52B929C6A35C2BCE33F3F2BEF4BAA48A4409@qq.com>
References: <tencent_52B929C6A35C2BCE33F3F2BEF4BAA48A4409@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes a race between parent and child threads in futex_requeue.
>
> Similar to commit fbf4dec70277 ("selftests/futex: Order calls to
> futex_lock_pi"), which fixed a flake in futex_lock_pi due to racing
> between the parent and child threads.
>
> The same issue can occur in the futex_requeue test, because it expects
> waiterfn to make progress to futex_wait before the parent starts to
> requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
> it still fails occasionally. This can be reproduced by adding a sleep in
> the waiterfn before futex_wait:
>
> TAP version 13
> 1..2
> not ok 1 futex_requeue simple returned: 0
> not ok 2 futex_requeue simple returned: 0
> not ok 3 futex_requeue many returned: 0
> not ok 4 futex_requeue many returned: 0
>
> This issue can be resolved by checking whether the child thread is in a
> sleeping state. This is because when the child thread goes to sleep, it
> indicates that it is waiting for the futex lock.
>
> Fixes: 7cb5dd8e2c8c ("selftests: futex: Add futex compare requeue test")
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Co-developed-by: Edward Liaw <edliaw@google.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  .../futex/functional/futex_requeue.c          | 58 ++++++++++++++++---
>  1 file changed, 51 insertions(+), 7 deletions(-)
Reviewed-by: Licay <licayy@foxmail.com>


