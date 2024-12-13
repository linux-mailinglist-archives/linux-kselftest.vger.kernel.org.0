Return-Path: <linux-kselftest+bounces-23297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F829F04B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 07:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D70316A175
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FC188724;
	Fri, 13 Dec 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5x1RRPl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7313DDAA
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070763; cv=none; b=lGetYdNs8WrdQOR+YPe45FaiG0vkoaSVvY4NusMgPxTO0VZrfiyC6LiPMwMI1uuAVn/M5cL89ugKqVh980pDJPIwgBECWiFpX8n5Df3Kwu1meQ17FH+qeH3ve2lllGBMIXbOsCW9FwIbiyrbeIKPLQJucKjkUpiFBR6Zq3vkLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070763; c=relaxed/simple;
	bh=K/4DN4i60pVUUdRoPlxfp3YaDzkLkgpBAjbBqyN1pa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OF9aKtp8xDuy1Mkc/9JRm/vXEiRZzR96zwc0Pc6nGWkWywA9git4JMh5E3tvTBm3XlYf6ffOwoibL46yyfab5n6qM7MrKg5haSw+FLkmJg9Bdhs6YpdjtoOikB7NUfFk0q33dJaPjRq1GnftjqTlxvhI4FQ3PuwnQLG7HEnit0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5x1RRPl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so13304695ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 22:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734070761; x=1734675561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5oF9jov6joYFA3TQsmrGHK73Ci9n0mNzk5UXN2ZVo0=;
        b=w5x1RRPl0jnjljVk8biKm5FuC20tYdGff1zmva7uY1u2Ss8Tb8m4x8jc+MiNYwy20j
         wUD3hq3WifxRErQRK0AtuLtjOXELCG4FthSHyJN5PznZdCog+mxHJJXcmWl5Ut+RhCtZ
         lrCcy3TLe4xjf0RhOeJydRecwzcUDxQfKxgFfeJ9UVa3rJX6z6KrZZwZTQAL2EI1uQFc
         v0FVcQQCeYZ9UzjSsYiiZB/YEFqefj85CH0sUShmXPLSnDlo09wAZdtYIaR3stwf5jo9
         AFxGMVafsss1lni47OLUdlIRl3J/q6SsXuFjCa7gRYayRGBASAcwCeVZl8blwBvYHiji
         NWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734070761; x=1734675561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5oF9jov6joYFA3TQsmrGHK73Ci9n0mNzk5UXN2ZVo0=;
        b=skj5v26RSxNCnpcAH87K0CnQuVWNkeoTcxgR/UXjMRAvKSzJT+2cIueQqnAl/M3Mw8
         siztrBX2MNtwLpaAFkogtbYJ3Ly7GscZpyac6gGftgjgon/Baih4Z72vrOddUqE8w3Qq
         iTwzrGDDM8pI0wf0JJzv5sRnzGPnX7H0FZ1UTZmxR6S0CT08rwMlRhVRNmSzhPoSPACJ
         d1H8wWKdUdLVtuFJVf34dmiVszbJetE6dOWdva0n04qjoc/efnOSyicxVdif5Fv/8/q3
         isgscs59ILCBJem+V1d0W9CVNFxZDGDvCh26dbXbcGJ2ieCwPHs2M9xBgzbhjvKA8Zi0
         BAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCIW6pWfPBKIPo5BQb9O/E22mnJv/0jnBRzqplDK4+vIoAN+7SLj7cCUHpIPDjdyNnsAAJ17EEBl50RvXFzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnLX3R2pdl7yrvqGhAvqR+kntlgJ1wPGU96d6KLqZaHXrrjcS
	3+FByUpDIlShT/8FhWrY0oXvpudVrTtuzOODOLh4KXeVc4LNDoZkoS02RqH4kSkLD6b5mBoWezh
	ZKA==
X-Google-Smtp-Source: AGHT+IH8Tju6InYA6vGPE54wU0lZHft8YC7vV4TPTHR62raRBFJyNNwUg/F/hXnhEEHuLnSIeoRbN1q7Bg4=
X-Received: from plqs9.prod.google.com ([2002:a17:902:a509:b0:216:2fcc:4084])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234d:b0:216:70b6:8723
 with SMTP id d9443c01a7336-21892a5440cmr20189615ad.44.1734070761077; Thu, 12
 Dec 2024 22:19:21 -0800 (PST)
Date: Thu, 12 Dec 2024 22:19:07 -0800
In-Reply-To: <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211193706.469817-1-mlevitsk@redhat.com> <20241211193706.469817-2-mlevitsk@redhat.com>
 <Z1ox4OHNT6kkincQ@google.com> <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
Message-ID: <Z1vR25ylN5m_DRSy@google.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 12, 2024, Maxim Levitsky wrote:
> On Wed, 2024-12-11 at 16:44 -0800, Sean Christopherson wrote:
> > But, I can't help but wonder why KVM bothers emulating PML.  I can appreciate
> > that avoiding exits to L1 would be beneficial, but what use case actually cares
> > about dirty logging performance in L1?
> 
> It does help with performance by a lot and the implementation is emulated and simple.

Yeah, it's not a lot of complexity, but it's architecturally flawed.  And I get
that it helps with performance, I'm just stumped as to the use case for dirty
logging in a nested VM in the first place.

> Do you have any comments for the rest of the patch series? If not then I'll send
> v2 of the patch series.

*sigh*

I do.  Through no fault of your own.  I was trying to figure out a way to ensure
the vCPU made meaningful progress, versus just guaranteeing at least one write,
and stumbled onto a plethora of flaws and unnecessary complexity in the test.

Can you post this patch as a standalone v2?  I'd like to do a more agressive
cleanup of the selftest, but I don't want to hold this up, and there's no hard
dependency.

As for the issues I encountered with the selftest:

 1. Tracing how many pages have been written for the current iteration with a
    guest side counter doesn't work without more fixes, because the test doesn't
    collect all dirty entries for the current iterations.  For the dirty ring,
    this results in a vCPU *starting* an iteration with a full dirty ring, and
    the test hangs because the guest can't make forward progress until
    log_mode_collect_dirty_pages() is called.

 2. The test presumably doesn't collect all dirty entries because of the weird
    and unnecessary kick in dirty_ring_collect_dirty_pages(), and all the
    synchronization that comes with it.  The kick is "justified" with a comment
    saying "This makes sure that hardware PML cache flushed", but there's no
    reason to do *if* pages that the test collects dirty pages *after* stopping
    the vCPU.  Which is easy to do while also collecting while the vCPU is
    running, if the kick+synchronization is eliminated (i.e. it's a self-inflicted
    wound of sorts).

 3. dirty_ring_after_vcpu_run() doesn't honor vcpu_sync_stop_requested, and so
    every other iteration runs until the ring is full.  Testing the "soft full"
    logic is interesting, but not _that_ interesting, and filling the dirty ring
    basically ignores the "interval".  Fixing this reduces the runtime by a
    significant amount, especially on nested, at the cost of providing less
    coverage for the dirty ring with default interval in a nested VM (but if
    someone cares about testing the dirty ring soft full in a nested VM, they
    can darn well bump the interval).

 4. Fixing the test to collect all dirty entries for the current iteration
    exposes another flaw.  The bitmaps (not dirty ring) start with all bits
    set.  And so the first iteration can see "dirty" pages that have never
    been written, but only when applying your fix to limit the hack to s390.

 5. "iteration" is synched to the guest *after* the vCPU is restarted, i.e. the
    guest could see a stale iteration if the main thread is delayed.

 6. host_bmap_track and all of the weird exemptions for writes from previous
    iterations goes away if all entries are collected for the current iteration
    (though a second bitmap is needed to handle the second collection; KVM's
    "get" of the bitmap clobbers the previous value).

I have everything more or less coded up, but I need to split it into patches,
write changelogs, and interleave it with your fixes.  Hopefully I'll get to that
tomorrow.

