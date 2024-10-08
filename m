Return-Path: <linux-kselftest+bounces-19261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD159957F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2931F21F4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D6213EFE;
	Tue,  8 Oct 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNLVO2Y+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C75213EF1
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417409; cv=none; b=kG57YCFy7SSOLIqE7BoK3AQzEL5JI+qURZRJp7VpQV8dapkLniXFujQv5u0uno324xU6o/loFD0YEyp1vX8dTeFNLyPwG/g4cLR6dsE1KZVKnG6tkmlG7vfDOmIXCLJZNZo+Q4Kl8mCZYXhmeUGSMXX9pFIuw/Dv0fiSgFyAYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417409; c=relaxed/simple;
	bh=lJ13KuCMxM+rGS6o4c5nzT7RJcxdk/8pPHoQ2SxGCac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iBvOf0pPfuVjK58lwDVbWBR4wysK74XhRDkF39ZZB8irQhM6anFwrKzZXO7+gLfV/XIFekYd2A3uMZYqONURhza+nujatvEaY+AxuYpvMcdI/W4vM+NTLU8Rq2mtPdaTlGQop0w9lvV2xfh3Pk/Q9VInnXqHYtg+779PNHZW14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNLVO2Y+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e6e98892e1so6876778a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728417407; x=1729022207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/G+V8S+q0QrqWGrvEamJlOg78EP9KmYBGMaK7S1DW0=;
        b=sNLVO2Y+ZGXrk6RtwKZE7YqHM8bPryppBG+/7hGML41/pnL1cb/uihynRVuhIT/ZlK
         cEwInNPyDzNquXLvfArwe/FIvYjCqrfFqMVPo9YBdimTTB3u5To4uIPlvkhkF748E7Om
         QRoUSnsGVY4AEmlp8cAy0t+w3o34FsIJ4zekxPBKrX5qiAPJFuuV+StMJmL/OjgW9uJR
         weCi/a0VosIKdn14acfTv5m6inmMw4+RIUY4EUsf8TqW4ADgB4qU/4iL7danprnteY8T
         GuhehGFM9f9i/mHNwXs4BLpZWYbdu251+bcluXcYp4lpNXny8gE408jDLn+bMn6mtE0/
         n7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417407; x=1729022207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/G+V8S+q0QrqWGrvEamJlOg78EP9KmYBGMaK7S1DW0=;
        b=cm9TvpyYG6m302QQk0Ekx/iVNu9aRUVPZWRqoGTeVrxwQR3p/VYVuVKxOImDeIk57Z
         V1Gr1SNUSo/L60ne1EhK0+Phpd14adbOVZSLLkhEd22bdjIGUSE7uBihLvV/es3VaIcR
         mJND50ZrkNf81cTRRTGynsdZicLqwDEf1pv7hgnytjJ3/xbeWRvmeGdHBSAQzN7fLjXG
         EPEsLJ7D8Aio/Nq34+DUuSlYJIqA+zrJyxYjT1s6Tyw65jdgmwDAiNdwumjSBUrB7xI4
         B90z8zSdGvkUaUyrIjJN4WICKh9x+ckf6mO0OmLHRqDYAo0Hau/Sx2x9HQeRz28WwTGW
         GqGw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9851N71XDq5nWzp3qkQNpB9rK42JPagA+2xS1S6fIgB5I0QiWjsC2rrMtiRKeKkip3xeHo0zzOC+HEir6/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzathtc9ORDIacOSTBKy2mqmxYpP+U0ZZYCKcPom48tWyqfwi4A
	UfDBP6jHFYpCXPCz31kDJh+73pnHi00pYRv+d5wrKkAy5f5CYu4Zy2gY8iKQ03w019OcP6V9l0A
	dpg==
X-Google-Smtp-Source: AGHT+IHyx9QyjvcH0QuqsTJ5s9OSvQOQBKzDDSMtuR28E1GHQRe/I98C0rGCGAu3RxyW1QfCFMI9GKgHUE4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:f151:0:b0:7e9:f98c:e9f7 with SMTP id
 41be03b00d2f7-7ea320f3304mr172a12.10.1728417406827; Tue, 08 Oct 2024 12:56:46
 -0700 (PDT)
Date: Tue, 8 Oct 2024 12:56:45 -0700
In-Reply-To: <diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e8f55fef-1821-408e-88ed-b25200ef66c9@amazon.co.uk> <diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <ZwWOfXd9becAm4lH@google.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Patrick Roy <roypat@amazon.co.uk>, quic_eberman@quicinc.com, tabba@google.com, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org, 
	jgowans@amazon.com, kalyazin@amazon.co.uk, derekmn@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 08, 2024, Ackerley Tng wrote:
> Patrick Roy <roypat@amazon.co.uk> writes:
> > For the "non-CoCo with direct map entries removed" VMs that we at AWS
> > are going for, we'd like a VM type with host-controlled in-place
> > conversions which doesn't zero on transitions,

Hmm, your use case shouldn't need conversions _for KVM_, as there's no need for
KVM to care if userspace or the guest _wants_ a page to be shared vs. private.
Userspace is fully trusted to manage things; KVM simply reacts to the current
state of things.

And more importantly, whether or not the direct map is zapped needs to be a
property of the guest_memfd inode, i.e. can't be associated with a struct kvm.
I forget who got volunteered to do the work, but we're going to need similar
functionality for tracking the state of individual pages in a huge folio, as
folio_mark_uptodate() is too coarse-grained.  I.e. at some point, I expect that
guest_memfd will make it easy-ish to determine whether or not the direct map has
been obliterated.

The shared vs. private attributes tracking in KVM is still needed (I think), as
it communicates what userspace _wants_, whereas he guest_memfd machinery will
track what the state _is_.

> > so if KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new
> > VM type for that.

Maybe we should sneak in a s/KVM_X86_SW_PROTECTED_VM/KVM_X86_SW_HARDENED_VM rename?
The original thought behind "software protected VM" was to do a slow build of
something akin to pKVM, but realistically I don't think that idea is going anywhere.

Alternatively, depending on how KVM accesses guest memory that's been removed from
the direct map, another solution would be to allow "regular" VMs to bind memslots
to guest_memfd, i.e. if the non-CoCo use case needs/wnats to bind all memory to
guest_memfd, not just "private" mappings.

That's probably the biggest topic of discussion: how do we want to allow mapping
guest_memfd into the guest, without direct map entries, but while still allowing
KVM to access guest memory as needed, e.g. for shadow paging.  One approach is
your RFC, where KVM maps guest_memfd pfns on-demand.

Another (slightly crazy) approach would be use protection keys to provide the
security properties that you want, while giving KVM (and userspace) a quick-and-easy
override to access guest memory.

 1. mmap() guest_memfd into userpace with RW protections
 2. Configure PKRU to make guest_memfd memory inaccessible by default
 3. Swizzle PKRU on-demand when intentionally accessing guest memory

It's essentially the same idea as SMAP+STAC/CLAC, just applied to guest memory
instead of to usersepace memory.

The benefit of the PKRU approach is that there are no PTE modifications, and thus
no TLB flushes, and only the CPU that is access guest memory gains temporary
access.  The big downside is that it would be limited to modern hardware, but
that might be acceptable, especially if it simplifies KVM's implementation.

> > Somewhat related sidenote: For VMs that allow inplace conversions and do
> > not zero, we do not need to zap the stage-2 mappings on memory attribute
> > changes, right?

See above.  I don't think conversions by toggling the shared/private flag in
KVM's memory attributes is the right fit for your use case.

