Return-Path: <linux-kselftest+bounces-21303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBE9B9437
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00131B21D4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AD1C6F6A;
	Fri,  1 Nov 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYuZc2if"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381291C32E2
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474296; cv=none; b=UA0OWMgTM2ejxKBdSZFOxIQfloJ17Pz+nD2XchqM1Px6npqGe1GVQCHI1dOpx2MEA6UWIi3GgneYzsDlivRZkxrSisZGYNhajH0hzbvilgLXk/sjtuwRjrWC5BeLDJ9Jc9nGsqIHdUb8x8zgUWjzgMI8pQTzhjZeDMoHrWX5zbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474296; c=relaxed/simple;
	bh=xGkv3LzrhtoCbCqtDpE3y3Q0GFXGAU72Ny2WiKf/Iuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3jM06v8P/gC3/GSGTgvAsyj82pc2dNqEJwGxzTyI8BG+/l35lMHyyb34krj95mIKhRbAZba/7tg6ncylgJAr9pFQBr3bCvIgpB79EX9590DamMqz1hb5VTkQSVt2GY3gZh0TiNg52911EI9mnPu31yQLT8wZSP27rEA6SuxpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYuZc2if; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso42787257b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730474293; x=1731079093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=By0MMba+WbzG2cXuHlWeMQpST2oOpWmZSXA68XVHYo0=;
        b=bYuZc2ifWnC89m8jPwJZ+9o1aVJVUPtGrn+a2Tq6I7DPyGcA7YqMirJwCywfY7dDdV
         LulpNzMnigxZTsvXIDZqVd0UG19ynWGvrjwz5SRW/g2Y3nbuR/kASz3mqdwBJyyZSdij
         jLg+cW5GwRjt6NxPFfAOW9D/BPgCK2aHrRLlZQ2ogRpr/BBTq3vgBDnbUVkErVrPmxGF
         bdEiXB6uJMIDzWdMp3GEumYry8fh8R4gTLUOn89JMNi8cyiQ7KAcdZXj52mMsvzifjMd
         PimfOS64nkjk4Ng7RqN2hT6f6KWwDVzZO89CKJYuXA7RXYpYUiIs1IDUD6eg4ir1Wkv9
         kAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730474293; x=1731079093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By0MMba+WbzG2cXuHlWeMQpST2oOpWmZSXA68XVHYo0=;
        b=NXurbSAxPkOZTcgiRFz3tfKl4ajzYmzVcymTVfM9oD4byluPlQQCTgwJmwz95QguOJ
         3PWgTBlGq5RxBcDz6TA5u40+bLNhgxBBiWKoAfDSt9KNAn/UW/JTcylLRy0cxsX9JQ+Q
         hNnt6njRmtk3oQxjKYQpggpNGbp82dYD8c24X7yiQfv00V+lDtwaUmLHprUpqWSdeyB8
         4ER+eB3Oa6YJUleL4z3G8t23n85UfUNlil+96BddohduK683sxvT5KTA8GaugzxG3pot
         HRBZYGMDsJWx0XkCUq6ONEPxo61lfrjmnl1+xsTqcFI2JzycYwsZwe55zwnbO2bpGHVr
         /5PA==
X-Forwarded-Encrypted: i=1; AJvYcCXqEUJwFgvwnIpSgl3GMXSrO2z++pezC4O7fKodVGvYqxI5WT4LQmXQdWhKvxbaa8uf/Zkd9mjVCcbbTRvCWlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9ich4VkAmUKhMFCFMAVbDCphuB0OiJVZOS13O2JHPO4ktHw7
	rwurre1TtOZhzTR2TeyI4Dm70eb9KHmHbWSYAixt/pG80ODBtA4hsYwMmow1AnY61wO8P2ZeyXW
	loQ==
X-Google-Smtp-Source: AGHT+IFdnwVveoc9N/MGUlZwVqfEB7IUicwB9rrAOOy2FhtDeXiq05HGyssNX0DfJOP/ZgHAaQZXrEGcvIk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6c8c:b0:6e3:1702:b3e6 with SMTP id
 00721157ae682-6ea64b8c450mr251257b3.4.1730474293279; Fri, 01 Nov 2024
 08:18:13 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:18:11 -0700
In-Reply-To: <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk> <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
Message-ID: <ZyTxM7Po4v7VkmHO@google.com>
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Derek Manwaring <derekmn@amazon.com>
Cc: roypat@amazon.co.uk, ackerleytng@google.com, agordeev@linux.ibm.com, 
	aou@eecs.berkeley.edu, borntraeger@linux.ibm.com, bp@alien8.de, 
	catalin.marinas@arm.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@redhat.com, gerald.schaefer@linux.ibm.com, 
	gor@linux.ibm.com, graf@amazon.com, hca@linux.ibm.com, hpa@zytor.com, 
	jgowans@amazon.com, jthoughton@google.com, kalyazin@amazon.com, 
	kernel@xen0n.name, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	luto@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	pbonzini@redhat.com, peterz@infradead.org, quic_eberman@quicinc.com, 
	rostedt@goodmis.org, rppt@kernel.org, shuah@kernel.org, svens@linux.ibm.com, 
	tabba@google.com, tglx@linutronix.de, vannapurve@google.com, will@kernel.org, 
	x86@kernel.org, xmarcalx@amazon.com, David Kaplan <david.kaplan@amd.com>
Content-Type: text/plain; charset="us-ascii"

+David Kaplan

On Thu, Oct 31, 2024, Derek Manwaring wrote:
> On 2024-10-31 at 10:42+0000 Patrick Roy wrote:
> > On Thu, 2024-10-31 at 09:50 +0000, David Hildenbrand wrote:
> > > On 30.10.24 14:49, Patrick Roy wrote:
> > >> Most significantly, I've reduced the patch series to focus only on
> > >> direct map removal for guest_memfd for now, leaving the whole "how to do
> > >> non-CoCo VMs in guest_memfd" for later. If this separation is
> > >> acceptable, then I think I can drop the RFC tag in the next revision
> > >> (I've mainly kept it here because I'm not entirely sure what to do with
> > >> patches 3 and 4).
> > >
> > > Hi,
> > >
> > > keeping upcoming "shared and private memory in guest_memfd" in mind, I
> > > assume the focus would be to only remove the direct map for private memory?
> > >
> > > So in the current upstream state, you would only be removing the direct
> > > map for private memory, currently translating to "encrypted"/"protected"
> > > memory that is inaccessible either way already.
> > >
> > > Correct?
> >
> > Yea, with the upcomming "shared and private" stuff, I would expect the
> > the shared<->private conversions would call the routines from patch 3 to
> > restore direct map entries on private->shared, and zap them on
> > shared->private.
> >
> > But as you said, the current upstream state has no notion of "shared"
> > memory in guest_memfd, so everything is private and thus everything is
> > direct map removed (although it is indeed already inaccessible anyway
> > for TDX and friends. That's what makes this patch series a bit awkward
> > :( )
> 
> TDX and SEV encryption happens between the core and main memory, so
> cached guest data we're most concerned about for transient execution
> attacks isn't necessarily inaccessible.
> 
> I'd be interested what Intel, AMD, and other folks think on this, but I
> think direct map removal is worthwhile for CoCo cases as well.

Removal of the direct map entries for guest private PFNs likely won't affect the
ability of an attacker to glean information from the unencrypted data that's in
the CPU caches, at least not on x86.  Both TDX and SEV steal physical address
bit(s) for tagging encrypted memory, and unless things have changed on recent
AMD microarchitectures (I'm 99.9% certain Intel CPUs haven't changed), those stolen
address bits are propagated into the caches.  I.e. the encrypted and unencrypted
forms of a given PFN are actually two different physical addresses under the hood.

I don't actually know how SEV uses the stolen PA bits though.  I don't see how it
simply be the ASID, because IIUC, AMD CPUs allow for more unique SEV-capable ASIDs
than uniquely addressable PAs by the number of stolen bits.  But I would be very
surprised if the tag for the cache isn't guaranteed to be unique per encryption key.

David?

