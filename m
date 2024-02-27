Return-Path: <linux-kselftest+bounces-5483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85B869819
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 15:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA99293888
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFAB146015;
	Tue, 27 Feb 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtouzCBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF4146008;
	Tue, 27 Feb 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044070; cv=none; b=UD5KF89Q9M+Ad2RaSyD1QCWDXNgrW3D3dSg7VsCtgp9HMMtY/ZsFF9yoFw0NlDPwzXD9T++lUvawypa5nn0naO50GGKTG2QJNuGtihu5gLr2fQc/DAxrqut12Smgb3n8yottfL8bCCsS/Rl6UWlBWxzNngZPBhZVzwuSV7/9SXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044070; c=relaxed/simple;
	bh=vJ/n9mcTPOlux9gF800dhfBrTx6jxXg61HNCrSy8pyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amPdFoIGgaHLvSNKUn3oSGG6BUNv3Q4l+PekbEQyjGtFTIrsZYMswvy7Ar5W933tGy9aQTePZb0M+bfSy+UvvoP/ZUIee3LXU3NSTjhNYlUsjRLtaVGPyinou5F4CIkJkEwOq6CQ6I2bUT/dfoHN4EP4dNWFcNO6Fyvq59fxEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtouzCBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF3EC433F1;
	Tue, 27 Feb 2024 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044070;
	bh=vJ/n9mcTPOlux9gF800dhfBrTx6jxXg61HNCrSy8pyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtouzCBPEQ+Mnmh0hwnvSoMh31ymfs8np+NhfXaydpOPNJ3HZ8uSyFm0QiUm8WQjp
	 V75YuTQUyun/ztJ/a+7b+TYSE2j7BnM2I72IzINHQBB3ZYWnA8yIFJEsO9wcbP5pYz
	 q8hHbV9VH8xksKLBm+LtnWUgXMv3GMYqqfcn4UUPkCoCZGSqF6baai4Kf1rcT0mLW9
	 KOpqPlw0W3M+TP95P+DDT54nPwIQh4hOlpwOHii2XpjqWf6lw5nExc/6aD9WqgMlaG
	 Wg6vW/xinP1ASs1vLgD1RYmsZMcnzaybixRMRWYTYD2a9qaPaybTcRV571NcaXrtB2
	 4K3cnzASZbNYw==
Date: Tue, 27 Feb 2024 15:27:42 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
Message-ID: <3jtqytxfqymfx2fenqby2x3zzra63tj7jrxrmunqsk6l7dqyip@jt7kdhxeb4np>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
 <818e43447651af1a659993897c14d05fec5038e4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818e43447651af1a659993897c14d05fec5038e4.camel@gmail.com>

On Feb 23 2024, Eduard Zingerman wrote:
> On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:
> 
> [...]
> 
> > @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
> >  
> >  	if (in_nmi())
> >  		return -EOPNOTSUPP;
> > -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> > +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
> >  		return -EINVAL;
> >  	__bpf_spin_lock_irqsave(&timer->lock);
> >  	t = timer->timer;
> > @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
> >  	if (flags & BPF_F_TIMER_CPU_PIN)
> >  		mode |= HRTIMER_MODE_PINNED;
> >  
> > -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > +	if (flags & BPF_F_TIMER_SLEEPABLE)
> > +		schedule_work(&t->work);
> > +	else
> > +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> 
> It looks like nsecs is simply ignored for sleepable timers.
> Should this be hrtimer_start() that waits nsecs and schedules work,
> or schedule_delayed_work()? (but it takes delay in jiffies, which is
> probably too coarse). Sorry if I miss something.

Yeah, I agree it's confusing, but as mentioned by Toke in his reply, we
should return -EINVAL if a timer value is provided (for now).

Alexei mentioned[0] that he didn't want to mix delays in hrtimers with
workqueue as they are non deterministic. So AFAIU, I should add the only
guarantee we can provide: a sleepable context, and proper delays in
sleepable contexts will be added once we have a better workqueue
selection available.

Cheers,
Benjamin

[0] https://lore.kernel.org/bpf/CAO-hwJKz+eRA+BFLANTrEqz2jQAOANTE3c7eqNJ6wDqJR7jMiQ@mail.gmail.com/T/#md15e431cbcddec9fcaddf1c305234523ed26f7ce

