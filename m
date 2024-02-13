Return-Path: <linux-kselftest+bounces-4582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC7853C65
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7BB230E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B9612F7;
	Tue, 13 Feb 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXYYtyMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAC612D2;
	Tue, 13 Feb 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857342; cv=none; b=JXnhzyMyYRITKgLbIZIoRm7of+M6lHg9WuSAGRYkB6wErm8LOHX85e1qcbK2aLnZokl22cUtCKIJqC0uQDgmPSlxGWz3u04IchLWWtQfhRJay9x3Mf3p6JQAAfUYYDbjlSq7KU5WFbKnfOiLtqFlp40LbrdNocK6GK6kxz2eCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857342; c=relaxed/simple;
	bh=g+d4sbZEKg/bFb5cr+DKe3rjFLQhm4930PpRaVtJO/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsbUMRsJ/nU2eZYRG5eUYuGofEe6iImxRsddkR0hu2JRFAoM5gjl07ZcScaksXqmNB0dJd/NIdkR6iWWU7hze2+a8Lbu6ltkQnIqTIC9tJIYXGbdIN8kEcwnjhl1Wlx4Ryifh17uqtqT1Q/fBaqOOtr+TbCDaIZvERqDVQfGq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXYYtyMZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36423c819a3so2199645ab.0;
        Tue, 13 Feb 2024 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857340; x=1708462140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+fpHR+QUQmyea//lUFv/vIwu0kcaelqAMzTc7aVo48o=;
        b=KXYYtyMZoz2SxzCYJTllM7CzejU4b9YKOcmBkX+seYDr0LkUPZGvB10q70FRNvU1i/
         SCE/I0LjeLiO/j57EJiUNYj3ORmPQqlbw8eXDzgjCXBc86WhrVN9piugjPJzVE2VhBPy
         mGTuD48U5rAhxcwjHtOtzhUfPnK/ksTqSUxp7HqwhjhCludLr5HWI4vU1R8ZViHjapXx
         V3BbGea8+4XQsDzqDPCqWqPPSdHw1kxMkBxod5YleQhIuwzyjUVx/EYRo8sQSXmn/qnY
         aYrJpvcABCQWhISpXW0xiz+XbuXmxPCzpzqT0sZl/lSxAeMzYBAJwewQM1HG9Deaecpx
         2M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857340; x=1708462140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fpHR+QUQmyea//lUFv/vIwu0kcaelqAMzTc7aVo48o=;
        b=I+8RbrWjEjnFa/3fX512I7wE009io1rM397Olx7+VmtXtmbYOOZcfODeoLkskpcF5M
         a2K5jUJqx0p5XhLLX+WUH23G3MxNabXV0pnHumj5ndnGFxqZ2wPmo9+zStXNpvJGKefu
         9fodUkE/C+00D9NCr8UjIivSXoFm12X1OPDnMu8MhkM+HyemQWHNylFCXyYZSfsWE/Tx
         xPqYPT2FJ6kaL8jNS0KaKagc/lju9eEtxBdYqC4d8qcs8skMqK9sMZuMsOtix4K0rIhr
         BeRrRyDtyginC/sM/T4aoGr88CInF2nlZ9LA4M7w/WMmfPkUhcvRZMFopZ1UoO/+DfKM
         Q8dw==
X-Forwarded-Encrypted: i=1; AJvYcCXLsrDjdwZXZCTLWgN3G9BYKs7uoVXoB9skYZSbsVnSz2JmZbQvdFSLXNXTWe/MvUf4PP+cHw0FsuRxrdAmztZbe2np0M3sgvPXQ6pZFzXPsv53hUPpoJkJWbDP+0jAcgcSxV1iIvYDgWpx/+cTTmpVGGh96z1Zds2oixtXkPn/8vVv21rxbuNV9DBdoNBuZxE1zyUzn6Ra7vVqj773etmwsW39lipMBBpspeJWK4vEbI0akEiC2AJRh9M=
X-Gm-Message-State: AOJu0YzLULLBbveE68EKyTUVJIY1SmOA7RhqTbzRVqksltuBcRNDX7dj
	QF2tF3PCvCxCTY4KIfWbCMRSJ3vhPd7KjuAHzqqqAJMt26Qx568i
X-Google-Smtp-Source: AGHT+IEVpY8npm/c+8s3uUCOpxgYULeEO6wIpsnGdNM5YNXf8Whg2kP3OqBkxfELPfdgDx8RMuaIGg==
X-Received: by 2002:a92:d6c6:0:b0:364:6ae:b5d1 with SMTP id z6-20020a92d6c6000000b0036406aeb5d1mr838572ilp.2.1707857339728;
        Tue, 13 Feb 2024 12:48:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVac0ziro3D+ZTzbw7T3uhMa4Czk5UuDYoXayso7E3Fn3hMqFXP4ya6m+v6zZ5fNa18IkVdnqoPxGNJrXKmqEEoHxKrxQ2Al27nd6BuUo/wjN1m/+yVB5lrLlGaV9i6W4NRZX12+QKUPG3zng4zCmjV5Y0GY0CGZchJMs+HSShZWp2TVNiknjvVyva1J38j7GJNxgN6ffw51O0lmUxB24oDci0k55aRYC+nBQaLotfsVqlpVZ390kwqn7bLkWcCxJt6PUGZkECJXB1GLYfyVP2zFst5E++i+CBFL7VyTjLq0l9nLuOU4wbLY+wdYU3Sj7b7z6DcBR5+BT7x/h1rwHc8jT3G3tUVRtQFfPVH+gSobcC2xNizo1P47wk3IIrdMhdVepyn2O9Tl6Mk6biUI6AShKMLdEcDY2hGIN5AMYmXEB/PgzjB12X3v4iPlYtZaEoYisRVwENizF/7hondDZWlW7O9QewuN7G/kVto+dvN78x0l/cSo20ugC85UsLsFdGkh1PEi7OoMq6EJo+vmgRYoQ/j2uSLNhNRJmHXbh772Qbg7fMwEZxPS2Z+yw9HD/DbzD4vmEebizbkCRsb4GrL9HGErSVvDLsK9e8+DcgSNmff/xYgDJqmLmZ+CIrl90Hnf71y+Q4EdS6JmMB4p7QnwmgQE4dWf5IrP/KLBmnJMJWdatT/VdUDM0m+xFA=
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:500::6:7312])
        by smtp.gmail.com with ESMTPSA id bx41-20020a056a02052900b005d67862799asm2472534pgb.44.2024.02.13.12.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:48:59 -0800 (PST)
Date: Tue, 13 Feb 2024 12:48:55 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
Message-ID: <ztou4yyrsdfmmhdwgu2f2noartpqklhvtbw7vj2ptk54eqohvb@qci7bcnbd56q>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
 <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
 <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
 <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>

On Tue, Feb 13, 2024 at 08:23:17PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Tue, 13 Feb 2024 at 18:46, Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On Feb 12 2024, Alexei Starovoitov wrote:
> > > On Mon, Feb 12, 2024 at 10:21 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > On Mon, Feb 12, 2024 at 6:46 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > > > >
> > > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
> > > > >
> > [...]
> > > I agree that workqueue delegation fits into the bpf_timer concept and
> > > a lot of code can and should be shared.
> >
> > Thanks Alexei for the detailed answer. I've given it an attempt but still can not
> > figure it out entirely.
> >
> > > All the lessons(bugs) learned with bpf_timer don't need to be re-discovered :)
> > > Too bad, bpf_timer_set_callback() doesn't have a flag argument,
> > > so we need a new kfunc to set a sleepable callback.
> > > Maybe
> > > bpf_timer_set_sleepable_cb() ?
> >
> > OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini() flag?

I think the flag for bpf_timer_init() is still needed.
Since we probably shouldn't combine hrtimer with workqueue.
bpf_timer_start() should do schedule_work() directly.
The latency matters in some cases.
We will use flags to specify which workqueue strategy to use.
Fingers crossed, WQ_BH will be merged in the next merge window and we'd need to expose it
as an option to bpf progs.

> >
> > > The verifier will set is_async_cb = true for it (like it does for regular cb-s).
> > > And since prog->aux->sleepable is kinda "global" we need another
> > > per subprog flag:
> > > bool is_sleepable: 1;
> >
> > done (in push_callback_call())
> >
> > >
> > > We can factor out a check "if (prog->aux->sleepable)" into a helper
> > > that will check that "global" flag and another env->cur_state->in_sleepable
> > > flag that will work similar to active_rcu_lock.
> >
> > done (I think), cf patch 2 below
> >
> > > Once the verifier starts processing subprog->is_sleepable
> > > it will set cur_state->in_sleepable = true;
> > > to make all subprogs called from that cb to be recognized as sleepable too.
> >
> > That's the point I don't know where to put the new code.
> >
> 
> I think that would go in the already existing special case for
> push_async_cb where you get the verifier state of the async callback.
> You can make setting the boolean in that verifier state conditional on
> whether it's your kfunc/helper you're processing taking a sleepable
> callback.
> 
> > It seems the best place would be in do_check(), but I am under the impression
> > that the code of the callback is added at the end of the instruction list, meaning
> > that I do not know where it starts, and which subprog index it corresponds to.
> >
> > >
> > > A bit of a challenge is what to do with global subprogs,
> > > since they're verified lazily. They can be called from
> > > sleepable and non-sleepable contex. Should be solvable.
> >
> > I must confess this is way over me (and given that I didn't even managed to make
> > the "easy" case working, that might explain things a little :-P )
> >
> 
> I think it will be solvable but made somewhat difficult by the fact
> that even if we mark subprog_info of some global_func A as
> in_sleepable, so that we explore it as sleepable during its
> verification, we might encounter later another global_func that calls
> a global func, already explored as non-sleepable, in sleepable
> context. In this case I think we need to redo the verification of that
> global func as sleepable once again. It could be that it is called
> from both non-sleepable and sleepable contexts, so both paths
> (in_sleepable = true, and in_sleepable = false) need to be explored,
> or we could reject such cases, but it might be a little restrictive.
> 
> Some common helper global func unrelated to caller context doing some
> auxiliary work, called from sleepable timer callback and normal main
> subprog might be an example where rejection will be prohibitive.
> 
> An approach might be to explore main and global subprogs once as we do
> now, and then keep a list of global subprogs that need to be revisited
> as in_sleepable (due to being called from a sleepable context) and
> trigger do_check_common for them again, this might have to be repeated
> as the list grows on each iteration, but eventually we will have
> explored all of them as in_sleepable if need be, and the loop will
> end. Surely, this trades off logical simplicity of verifier code with
> redoing verification of global subprogs again.
> 
> To add items to such a list, for each global subprog we encounter that
> needs to be analyzed as in_sleepable, we will also collect all its
> callee global subprogs by walking its instructions (a bit like
> check_max_stack_depth does).

imo that would be a serious increase in the verifier complexity.
It's not clear whether this is needed at this point.
For now I would drop cur_state->in_sleepable to false before verifying global subprogs.

> > >
> > > Overall I think this feature is needed urgently,
> > > so if you don't have cycles to work on this soon,
> > > I can prioritize it right after bpf_arena work.
> >
> > I can try to spare a few cycles on it. Even if your instructions were on
> > spot, I still can't make the subprogs recognized as sleepable.
> >
> > For reference, this is where I am (probably bogus, but seems to be
> > working when timer_set_sleepable_cb() is called from a sleepable context
> > as mentioned by Toke):
> >
> 
> I just skimmed the patch but I think it's already 90% there. The only
> other change I would suggest is switching from helper to kfunc, as
> originally proposed by Alexei.

+1. I quickly looked through the patches and it does look like 90% there.

