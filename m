Return-Path: <linux-kselftest+bounces-8437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295468AB17D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DA91F23B56
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4DE12F394;
	Fri, 19 Apr 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzjkWeY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB42B2D7;
	Fri, 19 Apr 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539699; cv=none; b=ZGfcrqxQe0Z1PeibCRDWKqjX/QywAqCS1QmXYEtV2YtTVJl2VYuNvKMGX7uEixz+OeEpxRhqr3T/+r7kXpr3BhEYzG8Weyh+xUKI23Cy2sCDgRiSjw9SakkKgfv5HJdpnUBRH08w1yVOR6XNAWUB8xqW8+iZNlge0BlA0ge47pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539699; c=relaxed/simple;
	bh=RbyWP0TRgV3mD89DqjmdySW1rSrRZFZkoQUyjq1dfO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlPsOh+mP4mqVk1vzm+0+pqcIZNmkTSRYtn115Lp9LDvsa+EOWgStoTiCHlmMtfVe2OFKXZTqsPC5hVMCKd7/AEuQf7umW/oNrLUPr7YlwLHt7PMm1+lGO+/B2C7astDnplnFMzXrAAa3FFoTHlw1efa++q+sh/C9xuEV8vH5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzjkWeY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73120C072AA;
	Fri, 19 Apr 2024 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713539699;
	bh=RbyWP0TRgV3mD89DqjmdySW1rSrRZFZkoQUyjq1dfO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzjkWeY3E3ceLeVDDaH+oxCjkJllJ7gNkGHkG++1Eq9xeu4vgA+BrPIEKUq+Jd2cR
	 0vw/RKvVQriu/0URyABZP8j4f+1zGHixQhGjYZIVOVn4OKO75+9PLeE3mzJGZM5OU1
	 +dYyqt3DmIwUOGFLwRjXJxtUvctFQ9oqbFwLgXVacTKld3OvWr/AhYw+dqWC0icBNU
	 kYTDnTGZf3jid570L2JBCZb0L95Nh8RB9wsCAsv9pOpjv96ZdICDdXW6c+5QlIA5sd
	 DQBWM/Yo/2OQ7SzbecA2ppawI3p1bGVZK+Fngme5to2NXk8lesN5PNQAetqhzUjJig
	 u3HTOsiuGNHNA==
Date: Fri, 19 Apr 2024 17:14:52 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 17/18] bpf: add bpf_wq_start
Message-ID: <b7akvvt67m7w6hdfq5vboojnzyjbntxrjioh6nuqziz4pzia3d@6x2le6iz6cor>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>
 <khz5omyjsd2iklm66bi3na4gdxw2cpwhb3c2xwu4fjxkaefi77@puck4pfltjgm>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <khz5omyjsd2iklm66bi3na4gdxw2cpwhb3c2xwu4fjxkaefi77@puck4pfltjgm>

On Apr 18 2024, Alexei Starovoitov wrote:
> On Tue, Apr 16, 2024 at 04:08:30PM +0200, Benjamin Tissoires wrote:
> > again, copy/paste from bpf_timer_start().
> > 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  kernel/bpf/helpers.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e5c8adc44619..ed5309a37eda 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2728,6 +2728,29 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags)
> >  	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
> >  }
> >  
> > +__bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
> > +{
> > +	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
> > +	struct bpf_work *w;
> > +	int ret = 0;
> > +
> > +	if (in_nmi())
> > +		return -EOPNOTSUPP;
> > +	if (flags)
> > +		return -EINVAL;
> > +	__bpf_spin_lock_irqsave(&async->lock);
> > +	w = async->work;
> > +	if (!w || !w->cb.prog) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	schedule_work(&w->work);
> > +out:
> > +	__bpf_spin_unlock_irqrestore(&async->lock);
> 
> Looks like you're not adding wq_cancel kfunc in this patch set and
> it's probably a good thing not to expose async cancel to bpf users,
> since it's a foot gun.

Honestly I just felt the patch series was big enough for a PoC and
comparison with sleepable bpf_timer. But if we think this needs not to
be added, I guess that works too :)

> Even when we eventually add wq_cancel_sync kfunc it will not be
> removing a callback.

Yeah, I understood that bit :)

> So we can drop spinlock here.
> READ_ONCE of w and cb would be enough.
> Since they cannot get back to NULL once init-ed and cb is set.

Great, thanks for the review (and the other patches).

I'll work toward v2.

Cheers,
Benjamin

