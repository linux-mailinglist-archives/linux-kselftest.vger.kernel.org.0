Return-Path: <linux-kselftest+bounces-47593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EDCC19CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5ED530656D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE730DECE;
	Tue, 16 Dec 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Tp53TIcN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA9335566;
	Tue, 16 Dec 2025 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874339; cv=none; b=LXHjawL1vIyOecoUf/hMjWakRTgRYYCa6alYWNBiHcu7F+a7qTZ1QaVkdQElSRcWkJd9x2tsnCBM8PKn2av7binKXzfdhGxFGhFa8i7F8wCBWBfMEJoVeD377WRtEv1nrnEJ0Oyy5Nl0RPDLVfNrmGug3KyTnwU1XzSaqDQxqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874339; c=relaxed/simple;
	bh=kcav1cg+HdYgDjJOC/hNp56ORnud/k4AVM/NiQVJmfU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Jkg4uXVDXE2OS6esk6yj4PPrjYQP98G8xuzTegoWVpzvvCbaR2+E2AvvgZPnyDs7AWwSszUeHea/WOQv8hMI/Xf9NZrwQKeljBHigErlNhHBoouRgNHp8NzDhQxG19SL7rg2uyULrVPb4dy/VW+90w+zpEdBjFGEtheu5VvQMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Tp53TIcN; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765874318;
	bh=IWT9gfeTkIm2A4e5uwcK4ldmbfVZAgjI6s3F4xV8g6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tp53TIcNOknQBjRS8ImF+iqdqORwDlkaoMlyBwiJr8EqW5n4vUiAIJgLjCKYtoT0t
	 /5nQfhn2u+4mIyoeDgcHISDFgcwpDTrstjs3Amk8vdRqaIa8SM4SxnEBFzGWSj4Dz+
	 dfXL13Pm7I5sK/bZ7+JKLuOjhXLzPZNARwx/4cZc=
Received: from meizu-Precision-3660-casey.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9969D82C; Tue, 16 Dec 2025 16:38:22 +0800
X-QQ-mid: xmsmtpt1765874302txcfvgr6b
Message-ID: <tencent_F566A4499E755FC452693B7DA93F0BEE2808@qq.com>
X-QQ-XMAILINFO: N2PXJXefbcU4s8mU7bkZ456Z3n14Q8PEebtgeJwFWzG1KRvUcjCEGGqr8JZ1Cx
	 B4oC0WLWGRZAbU5o2lmXJukiG8hP5+6LceCFthQ/wYfY77wbJD9SiX7T4ggFF1PlkpatxQKg8KkD
	 Rjyzg256nspUuh0/JoL6Nrz154UXRcC71RrkKd8zJfsvPiWyCDYDITIusVv6+QQ+TykyoST38JEl
	 1NB61L26+a+vBMatZt28J9mKIqEbBCS14Q6oi7u/XsmWznsT8V/tZ3HyONxbscaIkv3JOrjTggsg
	 yrheQwTVQT8DsIttkQNYu2CI/OayUxtYjrgZFKgU/RcDaxn7z09bAVBnxlAzQpNkT0y42HRDLdpF
	 Ii7acm5OBOov3UR6PZh6l4Zoc9W8SaWEmfsjt3FMWkA1b06b2+gQEPlpKnp+Q8ax+zQcwh8NycrT
	 F+72aQJkMDeZ9AjSN9WrREzLqy97R1+fye+RXQSo4WtiiWaAOow1SpZ6NUtynjHxsziXgcvsQgRn
	 RLFzspX+mpTTfsjyN2ORkfb3sZ15jT/8/BHf3P9T4JNcP7QNkwG1eYYe6wFdVozpquwTXPLFgDzK
	 7UAYNe/l3n/NYBzHnMIZ7gLRd0g+XEDVWy4tobPULmJONcX8kG0LrCMLZqsmPBKwreB5W/46UEpt
	 NwrpWVEyRsYqVgvZGVIkp6+bTukyd9Ui+uMPK6Z4j3z4QwuCYNMdg7mgKEUOuQcTJV9SEbwErfPi
	 us8diT7v5yKagruNjf0echpdImkcOKOVf10QhRnCbg9uIh3vITOca40tavLSGHT+d3CIXqW+r82O
	 RzwADf6fnuHSWR19sa638QCRDfGjIe7lnOmlhEoxVv0tJKDVCqJbTJvovoxhU9jsL/vQxlH5GiAJ
	 DYgSnjRJxC/jn8mct2yeIXU1t2ChPfWT2ZsZYBdVTh4M/CU57DgK+jo5mEJgf/y/520hlQG2Hb9V
	 TggegDIOl4t5IV8PhQEX2yzE9b60xgMqDNCIRK/T53B0f+cpbgxmjPGO3toEUNY3zKjZRAovmqdf
	 wV43BrmFkhJJ1k6eR71dXwMSZb4z49OPyJ6zoGTPmqFU/y/bivkE4bk5QZOWiHFfNEtQGevSiAzp
	 VYO1eu
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH v2 1/5] selftests/futex: reduce array declarations in the requeue_single
Date: Tue, 16 Dec 2025 16:38:06 +0800
X-OQ-MSGID: <20251216083806.368651-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_A4A4E388AEB0E748796A5FF75DB44514DC08@qq.com>
References: <tencent_A4A4E388AEB0E748796A5FF75DB44514DC08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In the requeue_single function, the variable "waits" only uses
> one element. There is no need to use an array.
>
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>

Reviewed-by: Licay <licayy@foxmail.com>
> ---
>  tools/testing/selftests/futex/functional/futex_requeue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
> index 69e2555b60399..1807465de2144 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue.c
> @@ -33,7 +33,7 @@ TEST(requeue_single)
>  {
>          volatile futex_t _f1 = 0;
>          volatile futex_t f2 = 0;
> -        pthread_t waiter[10];
> +        pthread_t waiter;
>          int res;
>
>          f1 = &_f1;
> @@ -41,7 +41,7 @@ TEST(requeue_single)
>          /*
>           * Requeue a waiter from f1 to f2, and wake f2.
>           */
> -        if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
> +        if (pthread_create(&waiter, NULL, waiterfn, NULL))
>                  ksft_exit_fail_msg("pthread_create failed\n");
>
>          usleep(WAKE_WAIT_US);
> --
> 2.34.1


