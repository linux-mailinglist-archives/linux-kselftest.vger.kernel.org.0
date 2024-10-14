Return-Path: <linux-kselftest+bounces-19621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B077C99C344
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C3C1F24353
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD2156649;
	Mon, 14 Oct 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rbh2eSM2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B191156222;
	Mon, 14 Oct 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894482; cv=none; b=l6fPCrQ06D4YCH+cN2N4uADJi30Cj+p/GkMXvnjBuFujLbkMXWR5cpyQLafr//jbmWc1gNFyV9RPJf450pZ4VbU4uwEbLKY9+HKWSCi8SkWzM83S60XBwlxMBOeB+bDt7NPB9RshaDGWrA9GXXGISXNIEMTg6ZbTpKMNtqfDDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894482; c=relaxed/simple;
	bh=MXaZ8YeDLqf/ZATmIgljn8OqLLESIPagR9e7Nm4UkjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZXLPCxpNIGLuimoV5AQcEFXKJVjuo0rNB40/N72l8k0rUwMVtb6vAzXWX9htUZc7iuPN3J1NkCj8ijltzwF3VlnW+Y/tdpfBgh2lOTMOsq0h8HV9YNmosOhods3TuI+5mJfsrQW2NX3jdXPmHIz5FTqOIBQz0SmPL5gm2uY4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rbh2eSM2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ifWLYUAWPQcSJ1ZuE1ZsTa5O2LKC8Bl9kn5reO3UHoI=; b=Rbh2eSM2Yqk05pYpRqjlrz6pAW
	RjcaXvC8cWyEzV5fb/C3UrjXg1wJHV7HDoaa7SxZDtVzoO6wu3Q2nzZIbWBPNst+BOXmqPwH//+iH
	gqihsEcIWbHrSq7TbpbHTwbG7bqjYTXFqcIVfFxpHgoOHY7iCWLd4ESpm3aUP5G9cCTw8LBBGSkkZ
	2JadQRByjXtvM4aaxh6nbsOMhDvMTJl0mWxhCE3ovvh0YYSdfTzfpBLCwiexQC+bK6oYuTWTBI48K
	kX9xomETXHcKwgLvlYTgiF61c6qFt5STlIDOw4028FX3gxwlnIW+YyihxS3+tRvpRz180rFQRyEIW
	uCSetNIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GQb-00000006HG0-3lG5;
	Mon, 14 Oct 2024 08:27:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E330300777; Mon, 14 Oct 2024 10:27:45 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:27:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v1 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <20241014082745.GT17263@noisy.programming.kicks-ass.net>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
 <20241013170617.2139204-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013170617.2139204-2-anjali.k.kulkarni@oracle.com>

On Sun, Oct 13, 2024 at 10:06:15AM -0700, Anjali Kulkarni wrote:

> +	if (unlikely(task->flags & PF_EXIT_NOTIFY)) {
> +		task_lock(task);
> +		task->flags &= ~PF_EXIT_NOTIFY;
> +		task_unlock(task);
> +

> @@ -413,6 +440,15 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	if (msg->len == sizeof(*pinput)) {
>  		pinput = (struct proc_input *)msg->data;
>  		mc_op = pinput->mcast_op;
> +		if (mc_op == PROC_CN_MCAST_NOTIFY) {
> +			pr_debug("%s: Received PROC_CN_MCAST_NOTIFY, pid %d\n",
> +					__func__, current->pid);
> +			task_lock(current);
> +			current->flags |= PF_EXIT_NOTIFY;
> +			task_unlock(current);
> +			err = cn_add_elem(pinput->uexit_code, current->pid);
> +			return;
> +		}

You seem to think that task_lock protects task->flags ? Why?

