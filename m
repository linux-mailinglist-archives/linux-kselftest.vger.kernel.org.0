Return-Path: <linux-kselftest+bounces-4656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DB854F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51441C28EC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F363104;
	Wed, 14 Feb 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSBuA6CN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273726087D;
	Wed, 14 Feb 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930661; cv=none; b=F2hrDwDkUewkKUDB4oYFur6ik3MG/73VsPGz5QMfItIZw8BQ2EOQoWad7J2PjR1wflukDN957KtJS1Q/JkP/LzfSz+kT9KYIZQqHPKopMIBR2hha523SIH4XZAf7a+0uhPtMBxnB990GegEzutmprpkJxcmQxnF94t5pdYtOMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930661; c=relaxed/simple;
	bh=A6NbyRZQhC46qPsrT0BBp6me28szmBiiUUjKG4u5PT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIbKYlWp6IWUo5/wx1S+PqyZCFZTPgiNKjpnn4jriiqHctDBrXQQI1pOyKyZqoKW9ON7eLvhT61gy0kj7+85qhMGKbuuXDHBqiA83j0CbMSoqcw6j/fyAR4KbI8HgZp+Iqa4Ymll8GqJ7gd/8gD0yJqs5C6ECshRULzkrmsM27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSBuA6CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FB4C43601;
	Wed, 14 Feb 2024 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707930659;
	bh=A6NbyRZQhC46qPsrT0BBp6me28szmBiiUUjKG4u5PT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSBuA6CNHXE7KeWvUxHCv8XUEy7YyEQ9KOnw8syeKd65PeMoml6JLITOjmUgZL1h1
	 1r/o39U9gpoI3eLY8Dy+Woi+y2ZESnI1lE0i+utAPjHGI2JOJfpUv4gUM+FnhHuFyA
	 zTlD9IzT08eFSfjrV5UL97Niv7ZvXsoZ5Ui+8RwkDpYJGYK3Y0m9RafBu49bD0sw0t
	 C6fuAet39YnNfFNzXtxtklDO2ougI34VJtKJQAOComG2377YMWV0j9zWwZ80adERtr
	 BCGw8R1eM03m1UsEQL47IXzebdDou5lyWiZn3IX0XiOOsVpvyX40iQXi/fkUi1FIYE
	 /UqfYUDMIBHYA==
Date: Wed, 14 Feb 2024 18:10:51 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
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
Message-ID: <e6ipl34ajoprzskvjuvdnlw5ak4sjwplh75qqboi2v572byrbm@z4d5ntl27ojp>
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

On Feb 13 2024, Kumar Kartikeya Dwivedi wrote:
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

Hehe, thanks a lot. Indeed, it was a simple fix. I tried to put this
everywhere but here, and with your help got it working in 2 mins :)

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

FWIW, this (or Alexei's suggestion) is still not implemented in v2

> 
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

the kfunc was a rabbit hole:
- I needed to teach the verifier about BPF_TIMER in kfunc
- I needed to teach the verifier about the kfunc itself
- I'm failing at calling the callback :(

Anyway, I'm about to send a second RFC so we can discuss on the code and
see where my monkey patching capabilities are reaching their limits.

Cheers,
Benjamin

