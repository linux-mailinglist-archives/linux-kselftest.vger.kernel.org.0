Return-Path: <linux-kselftest+bounces-4583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D6853C7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99BC288C4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A061665;
	Tue, 13 Feb 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdCmCYZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D95627E7;
	Tue, 13 Feb 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857575; cv=none; b=rrgk5Or6tdXhDWY5fHJdqFlVwHneD/wKP/N9JeREuHkdfTr1Sptkxn9JFitKTAAOrQr5xc61Z0FNxLVMxTk2M1+dMhjkwTYcUPV6tOFwi9mTA0LbyCuOHeTmvveycOLtgWT44XKmbnoJGTbcexwaabzaABA7al9/AQ9iNDOvgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857575; c=relaxed/simple;
	bh=9PwvXRhAMugLtHuzOt+aDQ3KQbytSBWLZhzNRbCHAUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBgWdGjSC1ARBJh+sAdOOo8FmjT4f8WP6jeZOAJRQGyukGmoFnNeLY2NegEUxhGUgvT4wiQwZ2voa8EkjD5tn1IPkoZIELaXOxhzaTieZQ94nLzZRr9hqUF7HNuGSegA3isBIJ9BEnakNHCE9ishgzRGRvIz0a39AQ9xbwmBfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdCmCYZS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296d24631c0so2805017a91.3;
        Tue, 13 Feb 2024 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857573; x=1708462373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6oMv83TSgQDRLR6Sio2134HLfx7oE5pFJJA1vfpzEPI=;
        b=DdCmCYZScjzHzvNqnWEW1uWEgFmUWPunr7Nmm93TKnrVQVk9hOzq6y4y4aJ6acR5I+
         Ninf9c0MIte7jcFSoUh7hByqzODVQ/UJIFycO5SepgfalXh9ZozlFUs1MUrGYjLH9Pii
         PPjvltsoeKso8F4401//QfCE3pjNEwluhB5WaPilOQ2Tx21DalhSocu4QrKzqrw4SBDw
         Phq053FWjfXpc30HeDDveMAiYkStxrZgaormU8BAy8geGPCDz4oEHhS1Sh61Hft6pt/Z
         TsQ5bQX6IzkgHsNq1EXPvocBLOAP7GztFKp2s5GOZ6CeSHgsVrFBO0YNLf3ScoWkRA/H
         a4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857573; x=1708462373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oMv83TSgQDRLR6Sio2134HLfx7oE5pFJJA1vfpzEPI=;
        b=b0/QTG/DCVB4uBiQxdOy/DlH33wSHr21Jiy8zA+kRfUwfjgH/BKzr46TNyFJ7gtalW
         06GCHWvB0LpS2WU+Yrx+wOaDDUr53SJOLJqeOvILq6DXrzPsr+2zm7xMdod/oeWk8y0U
         QKiFj+ehzJi/T6vg1JhfIqUaInnAZYPZ6/RCeIT64Gk3bDbFYcqRlaM6YhnFw+d12iIb
         dyRBtZXfYlIDZJFq3r0As9cMeArcBWpTrUov1oUVpjUpEgGKV6XOKZ9PqkABDEcbUDPa
         NfPptvuMw2jUtNsxAFeVTcnjiC+oOebU0ghrkBtRNtasiYF6+66QO2i62MXgWJeO4Rdd
         AHmA==
X-Forwarded-Encrypted: i=1; AJvYcCUruUygb7Xvm4mRLOiLFhJ8rkuQSypTMZMOeAuJ2zOctKcEIBDvxHEqseK3nkbh6AD3axUm0qzt2puwJNwkiIgRGvEtjZ6KpIeAFFZYvO7AEkAKSplp/b7FGerl2T0ZNF3Ale3XozdGoYBnz9zIulbSIAhOGHKyb2wEJE8mSB9kvmf3gz+PWIBkZDEa5W7PKiDCsjgZ838YPS5pkPXMOmY0dTmGXfidkUhzPunqlQvOEB20XudsveFMPIQ=
X-Gm-Message-State: AOJu0Ywe81isc/bleaz/LXQJm7YTFlrxBw8cpcBpCBMhG40O7Z/0Br9F
	F9NXnQeSD8hwc8lD9yyaOKRF4rxq+Sz3K+TdrFIJQ3eLX4JvRMep
X-Google-Smtp-Source: AGHT+IHE7IRAy6H5onujqJT/ftqmB93CgRKWtRpljbAkBkwOoObI6kOILuCJtaTXA2cYq7usG9E45w==
X-Received: by 2002:a17:90a:eb0e:b0:297:2f49:7aa with SMTP id j14-20020a17090aeb0e00b002972f4907aamr581305pjz.43.1707857572667;
        Tue, 13 Feb 2024 12:52:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQX4P2q4KPM9M0RPcwWGMfbHa16M6MAKUtvc44DFjC0I+o5aUdqeRReIvnRyuJ2d89DmnqSA7k9VLwU8ANpllpxzKV9ULYoqGccwf6+8PMw7ys5HYrHk8kDM2WkSuFqCgbvrr31ZiQVNRXuHH1AWYu5GFloJ7WZYk/pTJJ6ZWrM7Rjl/mtWiU7eHynd64EuaZqpMQC/KKCPqsBeaqExdPg2qEStG3eO20xTOD1gS0mYbGjgNqAjc/WY20o2QZTraJTY/ooqb3Gddcu+xfEOCnvN8ycs/RcqVw+9kaPSIT4kTqAtWW/0LdqqpeN6azTxYPgwsF4wTZoS/RUZD4HCT4LLWXrmz5gzcLuNI4TSjTpqzbXUPkcoDn1/bHSaiX56JD4VpadM8hyDsyNNlBD8AVscR8FiR/M0dbsbrxu1CpXedBC/ZmKNYq83+/jy9UfbdewaSZS8K893TAevC+K47QKGe9zIskiGByd7NnKdm5xDW+fxZFFOK0jisUY0zc3uKXifkihsm0+k8qZzIymf8J35/BTzGbIWCDhADxaQwiVxIgYNItAdOPTcFTwavuYIeBri35Uus/ENPtNt0JnCF1x4E5t1KCa48J3mvrHnTJKZV7ztkS3GQLK7zy9vNl9aLeIN2J9ucS5jIbBqxRtXdzk7jxMdM0S9fzvSIZ8LvfUuMnn8Y0u6DC1MpBdkAFswGk=
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:500::6:7312])
        by smtp.gmail.com with ESMTPSA id fa3-20020a17090af0c300b00296e2434e7esm2958426pjb.53.2024.02.13.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:52 -0800 (PST)
Date: Tue, 13 Feb 2024 12:52:49 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
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
Message-ID: <b2k6rlzu5vgpouedwjbsigoteo43nwfk6qeeb2pc7c3r4ejnm6@nml66ds6wbeo>
References: <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
 <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
 <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
 <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
 <877cj8f8ht.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cj8f8ht.fsf@toke.dk>

On Tue, Feb 13, 2024 at 08:51:26PM +0100, Toke Høiland-Jørgensen wrote:
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> 
> > On Tue, 13 Feb 2024 at 18:46, Benjamin Tissoires <bentiss@kernel.org> wrote:
> >>
> >> On Feb 12 2024, Alexei Starovoitov wrote:
> >> > On Mon, Feb 12, 2024 at 10:21 AM Benjamin Tissoires
> >> > <benjamin.tissoires@redhat.com> wrote:
> >> > >
> >> > > On Mon, Feb 12, 2024 at 6:46 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> > > >
> >> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
> >> > > >
> >> [...]
> >> > I agree that workqueue delegation fits into the bpf_timer concept and
> >> > a lot of code can and should be shared.
> >>
> >> Thanks Alexei for the detailed answer. I've given it an attempt but still can not
> >> figure it out entirely.
> >>
> >> > All the lessons(bugs) learned with bpf_timer don't need to be re-discovered :)
> >> > Too bad, bpf_timer_set_callback() doesn't have a flag argument,
> >> > so we need a new kfunc to set a sleepable callback.
> >> > Maybe
> >> > bpf_timer_set_sleepable_cb() ?
> >>
> >> OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini() flag?
> >>
> >> > The verifier will set is_async_cb = true for it (like it does for regular cb-s).
> >> > And since prog->aux->sleepable is kinda "global" we need another
> >> > per subprog flag:
> >> > bool is_sleepable: 1;
> >>
> >> done (in push_callback_call())
> >>
> >> >
> >> > We can factor out a check "if (prog->aux->sleepable)" into a helper
> >> > that will check that "global" flag and another env->cur_state->in_sleepable
> >> > flag that will work similar to active_rcu_lock.
> >>
> >> done (I think), cf patch 2 below
> >>
> >> > Once the verifier starts processing subprog->is_sleepable
> >> > it will set cur_state->in_sleepable = true;
> >> > to make all subprogs called from that cb to be recognized as sleepable too.
> >>
> >> That's the point I don't know where to put the new code.
> >>
> >
> > I think that would go in the already existing special case for
> > push_async_cb where you get the verifier state of the async callback.
> > You can make setting the boolean in that verifier state conditional on
> > whether it's your kfunc/helper you're processing taking a sleepable
> > callback.
> >
> >> It seems the best place would be in do_check(), but I am under the impression
> >> that the code of the callback is added at the end of the instruction list, meaning
> >> that I do not know where it starts, and which subprog index it corresponds to.
> >>
> >> >
> >> > A bit of a challenge is what to do with global subprogs,
> >> > since they're verified lazily. They can be called from
> >> > sleepable and non-sleepable contex. Should be solvable.
> >>
> >> I must confess this is way over me (and given that I didn't even managed to make
> >> the "easy" case working, that might explain things a little :-P )
> >>
> >
> > I think it will be solvable but made somewhat difficult by the fact
> > that even if we mark subprog_info of some global_func A as
> > in_sleepable, so that we explore it as sleepable during its
> > verification, we might encounter later another global_func that calls
> > a global func, already explored as non-sleepable, in sleepable
> > context. In this case I think we need to redo the verification of that
> > global func as sleepable once again. It could be that it is called
> > from both non-sleepable and sleepable contexts, so both paths
> > (in_sleepable = true, and in_sleepable = false) need to be explored,
> > or we could reject such cases, but it might be a little restrictive.
> >
> > Some common helper global func unrelated to caller context doing some
> > auxiliary work, called from sleepable timer callback and normal main
> > subprog might be an example where rejection will be prohibitive.
> >
> > An approach might be to explore main and global subprogs once as we do
> > now, and then keep a list of global subprogs that need to be revisited
> > as in_sleepable (due to being called from a sleepable context) and
> > trigger do_check_common for them again, this might have to be repeated
> > as the list grows on each iteration, but eventually we will have
> > explored all of them as in_sleepable if need be, and the loop will
> > end. Surely, this trades off logical simplicity of verifier code with
> > redoing verification of global subprogs again.
> >
> > To add items to such a list, for each global subprog we encounter that
> > needs to be analyzed as in_sleepable, we will also collect all its
> > callee global subprogs by walking its instructions (a bit like
> > check_max_stack_depth does).
> 
> Sorry if I'm being dense, but why is all this needed if it's already
> possible to just define the timer callback from a program type that
> allows sleeping, and then set the actual timeout from a different
> program that is not sleepable? Isn't the set_sleepable_cb() kfunc just a
> convenience then? Or did I misunderstand and it's not actually possible
> to mix callback/timer arming from different program types?

More than just convience.
bpf_set_sleepable_cb() might need to be called from non-sleepable and
there could be no way to hack it around with fake sleepable entry.
bpf_timer_cancel() clears callback_fn.
So if prog wants to bpf_timer_start() and later bpf_timer_cancel()
it would need to bpf_set_sleepable_cb() every time before bpf_timer_start().
And at that time it might be in non-sleepable ctx.

