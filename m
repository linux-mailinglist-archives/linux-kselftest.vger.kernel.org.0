Return-Path: <linux-kselftest+bounces-23371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE09F1765
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FD5188CDA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DF18F2D8;
	Fri, 13 Dec 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvQpIg44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96233175AB
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121909; cv=none; b=RltsN8fSV80xmLZci1vorCBMqGVj7WocNGfX/gcIjJ5iLvWwGXg46zuRMjD6YNSkEon0ZXfTOd1Tpd7crMKQIiGH/EYvVVmqJT35ICPLKeiftH8pucFLEDlAQFTJ1CfmNu6n3E1yYwUMOB5z5mboLgvA1PNKvx0bJIUF+5aJahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121909; c=relaxed/simple;
	bh=9xB5zQII9gByqe2ZXP6h5gt/kFUwGFWsEl1xx4H4JHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bIMdvjbCt53u1C6UFIxqZaiweBzd3cFal7A3OpXeG8Vq7gbRaIz26JDWb1yFujHe5Og7bxgkudupxh4IvuCEgrI/UqEI6if9lL0UChvYMHhUIbBxDZw39i8TyWIuuL9TH8sp/RqXpv6sWHiFh9BWh7GpfyZCyf3AqW7NdJTNy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvQpIg44; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f71e2fc065so1444769a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734121907; x=1734726707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWHqkJtQWzEFFZ8Kp1Au9t//E/0RpuQvQSaS19c/OkQ=;
        b=CvQpIg44ZNBRi7gExue7K2x33dAUYK5CL9Dopxlmto6J/SL5jwmmZZIGYWVAq4HYg0
         z/SVLHF5R9tZmE45hOBmoKIeA7kJy4npQZtaHFxRB1cpx6J9yw1V+Pc8tt0mC+xh4OOU
         osefJQrfx8L0hTVP4yisNjW00V+kSNSyVwLKwh0dXn8C26sL5rirRPtcti1W78jkeVuq
         nYO0ExnllNjk5TEY9kD5YjBtJb4YzqtupBo32JU8YuewRFoBZDCCjOOInWse4RReMnhZ
         I/FjPGFYhBzrBZ59KXVKQr14EDOITvfsQNsUwfWpVJ6Vdi5im2/90UsmLflx+qhkVInO
         Km5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734121907; x=1734726707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWHqkJtQWzEFFZ8Kp1Au9t//E/0RpuQvQSaS19c/OkQ=;
        b=imuXl/px903jHvPkSd6L7JcnWeo7deLH1yNddEdVOUKYRliD44oIf5ZcnL7AMZYm70
         0xkDvZV79PSGngelDEClbCrDjZVLAmZMEKECKZu0aMFqnUSkeIPsIC1rHmH6g7tLXIpu
         YZuaH9jQ+xd8xy+VTf88kEq+jjUAIK8dOGN3dbY/Vj837yD4kwI1bS6eKa+Yi0mvKa4c
         sFhLtDpxavZ/AcToXHvCH92MsEZ1sMe5854iESQUDXD/5o9NMWFIvM/QSOzb9rOOewBt
         za62QJnzhkU2J4Rc6MhQKfVfZD3M1ouRKRtASulAXOr0NuVlWer14uYKE+bhHxR8NH6+
         TQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCX5d04k0uGaCjS3Il71Yi2qlYea+wQGQIXO28wNd1mSwAIG5vmQOAsqdx92+ochWxA0ieuDOoVlGRjwb8cvfkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7CvphNgJXd4HtB3vE7hJTiezbIcRN/ohz5Wi6Fdtgz/s0eu5
	iDk9x8Ie/gg9hCynai0vFdn6C1TpZJYv7QVU28Gwn3vWei5xv6sHfLhNDQS0xjHhGbl26yupSK0
	QZA==
X-Google-Smtp-Source: AGHT+IHmL+ftw/cybJHUE3JtWq+YXSDYzxtQNtcJvZnpiaDeGGmJ22cl+McBVze/UuOAIfzl+cLHrIzNtHY=
X-Received: from pjbpl7.prod.google.com ([2002:a17:90b:2687:b0:2e9:ee22:8881])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3952:b0:2ee:db8a:29f0
 with SMTP id 98e67ed59e1d1-2f2900a6ef2mr5918047a91.27.1734121906955; Fri, 13
 Dec 2024 12:31:46 -0800 (PST)
Date: Fri, 13 Dec 2024 12:31:45 -0800
In-Reply-To: <88706b97f374bd425da82e78789e6234cb6baed2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211193706.469817-1-mlevitsk@redhat.com> <20241211193706.469817-2-mlevitsk@redhat.com>
 <Z1ox4OHNT6kkincQ@google.com> <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
 <Z1vR25ylN5m_DRSy@google.com> <88706b97f374bd425da82e78789e6234cb6baed2.camel@redhat.com>
Message-ID: <Z1yZsUFKhuw6KASe@google.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 13, 2024, Maxim Levitsky wrote:
> On Thu, 2024-12-12 at 22:19 -0800, Sean Christopherson wrote:
> > On Thu, Dec 12, 2024, Maxim Levitsky wrote:
> > > On Wed, 2024-12-11 at 16:44 -0800, Sean Christopherson wrote:
> > > > But, I can't help but wonder why KVM bothers emulating PML.  I can appreciate
> > > > that avoiding exits to L1 would be beneficial, but what use case actually cares
> > > > about dirty logging performance in L1?
> > > 
> > > It does help with performance by a lot and the implementation is emulated and simple.
> > 
> > Yeah, it's not a lot of complexity, but it's architecturally flawed.  And I get
> > that it helps with performance, I'm just stumped as to the use case for dirty
> > logging in a nested VM in the first place.
> > 
> > > Do you have any comments for the rest of the patch series? If not then I'll send
> > > v2 of the patch series.
> > 
> > *sigh*
> > 
> > I do.  Through no fault of your own.  I was trying to figure out a way to ensure
> > the vCPU made meaningful progress, versus just guaranteeing at least one write,
> > and stumbled onto a plethora of flaws and unnecessary complexity in the test.
> > 
> > Can you post this patch as a standalone v2?  I'd like to do a more agressive
> > cleanup of the selftest, but I don't want to hold this up, and there's no hard
> > dependency.
> > 
> > As for the issues I encountered with the selftest:
> > 
> >  1. Tracing how many pages have been written for the current iteration with a
> >     guest side counter doesn't work without more fixes, because the test doesn't
> >     collect all dirty entries for the current iterations.  For the dirty ring,
> >     this results in a vCPU *starting* an iteration with a full dirty ring, and
> >     the test hangs because the guest can't make forward progress until
> >     log_mode_collect_dirty_pages() is called.
> > 
> >  2. The test presumably doesn't collect all dirty entries because of the weird
> >     and unnecessary kick in dirty_ring_collect_dirty_pages(), and all the
> >     synchronization that comes with it.  The kick is "justified" with a comment
> >     saying "This makes sure that hardware PML cache flushed", but there's no
> >     reason to do *if* pages that the test collects dirty pages *after* stopping
> >     the vCPU.  Which is easy to do while also collecting while the vCPU is
> >     running, if the kick+synchronization is eliminated (i.e. it's a self-inflicted
> >     wound of sorts).
> > 
> >  3. dirty_ring_after_vcpu_run() doesn't honor vcpu_sync_stop_requested, and so
> >     every other iteration runs until the ring is full.  Testing the "soft full"
> >     logic is interesting, but not _that_ interesting, and filling the dirty ring
> >     basically ignores the "interval".  Fixing this reduces the runtime by a
> >     significant amount, especially on nested, at the cost of providing less
> >     coverage for the dirty ring with default interval in a nested VM (but if
> >     someone cares about testing the dirty ring soft full in a nested VM, they
> >     can darn well bump the interval).
> > 
> >  4. Fixing the test to collect all dirty entries for the current iteration
> >     exposes another flaw.  The bitmaps (not dirty ring) start with all bits
> >     set.  And so the first iteration can see "dirty" pages that have never
> >     been written, but only when applying your fix to limit the hack to s390.
> > 
> >  5. "iteration" is synched to the guest *after* the vCPU is restarted, i.e. the
> >     guest could see a stale iteration if the main thread is delayed.
> > 
> >  6. host_bmap_track and all of the weird exemptions for writes from previous
> >     iterations goes away if all entries are collected for the current iteration
> >     (though a second bitmap is needed to handle the second collection; KVM's
> >     "get" of the bitmap clobbers the previous value).
> > 
> > I have everything more or less coded up, but I need to split it into patches,
> > write changelogs, and interleave it with your fixes.  Hopefully I'll get to that
> > tomorrow.
> > 
> 
> Hi!
> 
> I will take a look at your patch series once you post it.
> I also think that the logic in the test is somewhat broken, but then this also 
> serves as a way to cause as much havoc as possible.
> 
> The fact that not all dirty pages are collected is because the ring harvest happens
> at the same time the guest continues dirtying the pages, adding more entries to the
> ring, simulating what would happen during real-life migration.

But as above, that behavior is trivially easy to mimic even when collecting all
entries simply by playing nice with multiple collections per iteration.  

> kicking the guest just before ring harvest is also IMHO a good thing as it also
> simulates the IRQ load that would happen.

I am not at all convinced that's interesting.  And *if* it's really truly all
that interesting, then the kick should be done for all flavors.

Unless the host is tickless, the vCPU will get interrupt from time to time, at
least for any decently large interval.  The kick from the test itself adds an
absurd amount of complexity for no meaningful test coverage.

> we can avoid kicking the guest if it is already stopped due to dirty ring, in fact,
> the fact that we still kick it, delays the kick to the point where we resume the guest
> and wait for it to stop again before the do the verify step, which makes it often
> exit not due to log full event.
> 
> I did this but this makes the test be way less random, and the whole point of this
> test is to cause as much havoc as possible.

I agree randomness is a good thing for testing, but this is more noise than
random/controlled chaos.

E.g. we can do _far_ better for large interval numbers.  As is, collecting _once_
per iteration means the vCPU is all but guarantee to stall on a dirty ring for
any decently large interval.

And conversely, not honor the "stop" request means every other iteration is all
but guaranteed to fill the dirty ring, even for small intervals.

> I do think that we don't need to stop the guest during verify for the
> dirty-ring case, this is probably a code that only dirty bitmap part of the
> test needs.

Not stopping the vCPU would reduce test coverage (which is one of my complaints
with not fully harvesting the dirty entries).  If KVM misses a dirty log event
on iteration X, and the vCPU also writes the same page in iteration X+1, then the
test will get a false pass because iteration X+1 will see the page as dirty and
think all is well.

