Return-Path: <linux-kselftest+bounces-18465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2F9883F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC483282ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE7918BB80;
	Fri, 27 Sep 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C+s65evJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F718B469;
	Fri, 27 Sep 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439218; cv=none; b=qxw+WozdBzHf0PEE5B1AEo9O/z9xs0+TNHSry/ocrtUp3U21StCkDzlBzs/iPg0i/SNl3zJLkB1dTEbBJ2rgW5ZWicGVAhz4LLj3pr3qShHAVPZANa0DqVjqhN++bbPMzoC4H1fFM7xsnhLM6eYxNykz5LhsObHDjSCgmk94r6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439218; c=relaxed/simple;
	bh=BnosdaO32ZN/pUvy3DU6b7SaAw/p453VVtLuoKccxgA=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8cQpcKT6VWtptXui01N2KfHoQAmRxvwTMO8aQSD+2w9Lu6QJGpEXjCnARjDJnzDEegOsJmcVgvc1vFCSuZK0H2pbuoyGoleI7iMqM+IwvIzHKvI/+NLL8WEfyQwO9spnCObW0Qt2fUipOn4mn75jF769o5QMNllqrignbnKxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C+s65evJ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727439217; x=1758975217;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=ZL5/JF3OF7nq2YesB9F5TMPjivF22f+PhP8u0LLBew0=;
  b=C+s65evJhe1dKKZbJ3bFLEGmZUEqJzhLjrXeHCAzPQIikcZzsNl7AaB5
   QOSyaLmkU+izPPvyMAgkWHpQRpKNkZsM1wQ4Yin53u3UEsBuHcIQi5Js8
   8wvYjkdUlfaaFGCN1NTV9mCpAWI+bcqU4kKCbn8q5ueHTup8Vs8ySFQYn
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,158,1725321600"; 
   d="scan'208";a="130899921"
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 12:13:31 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:21628]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.12:2525] with esmtp (Farcaster)
 id d530fc8f-b548-4fc5-99d8-ac8d61b8565d; Fri, 27 Sep 2024 12:13:30 +0000 (UTC)
X-Farcaster-Flow-ID: d530fc8f-b548-4fc5-99d8-ac8d61b8565d
Received: from EX19D033EUB004.ant.amazon.com (10.252.61.103) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 12:13:30 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D033EUB004.ant.amazon.com (10.252.61.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 12:13:30 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 27 Sep 2024 12:13:29 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 6A72380067;
	Fri, 27 Sep 2024 12:13:29 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id F21C9AA3B; Fri, 27 Sep 2024 12:13:28 +0000 (UTC)
Date: Fri, 27 Sep 2024 12:13:28 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: Jack Allister <jalliste@amazon.co.uk>, Ivan Orlov <iorlov@amazon.co.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Message-ID: <20240927121328.GA37012@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20240923141810.76331-1-iorlov@amazon.com>
 <ZvGfnARMqZS0mkg-@google.com>
 <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
 <ZvHhqRWW04jmk8TW@google.com>
 <20240924095422.GA66922@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
 <ZvSllYdtddzHv7vM@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZvSllYdtddzHv7vM@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Sep 25, 2024 at 05:06:45PM -0700, Sean Christopherson wrote:
> 
> Yeah, but only because the alternative sucks worse.  If KVM unconditionally exited
> with an emulation error, then unsuspecting (read: old) VMMs would likely terminate
> the guest, which gives guest userspace a way to DoS the entire VM, especially on
> older CPUs where KVM needs to emulate much more often.
> 
>         if (kvm->arch.exit_on_emulation_error ||
>             (emulation_type & EMULTYPE_SKIP)) {
>                 prepare_emulation_ctxt_failure_exit(vcpu);
>                 return 0;
>         }
> 
>         kvm_queue_exception(vcpu, UD_VECTOR);
> 
>         if (!is_guest_mode(vcpu) && kvm_x86_call(get_cpl)(vcpu) == 0) {
>                 prepare_emulation_ctxt_failure_exit(vcpu);
>                 return 0;
>         }
> 
>         return 1;
> 
> And that's exactly why KVM_CAP_EXIT_ON_EMULATION_FAILURE exists.  VMMs that know
> they won't unintentionally give guest userspace what amounts to a privilege
> escalation can trap the emulation failure, do some logging or whatever, and then
> take whatever action it wants to take.
> 

Hi Sean,

Makes sense, thank you for the explanation.

> > and I believe how we do this
> > is debatable. I maintain we should either set a flag in emulation_failure.flags
> > to indicate that the error happened due to fetch from mmio (to give more
> > information to VMM),
> 
> Generally speaking, I'm not opposed to adding more information along those lines.
> Though realistically, I don't know that an extra flag is warranted in this case,
> as it shouldn't be _that_ hard for userspace to deduce what went wrong, especially
> if KVM_TRANSLATE2[*] lands (though I'm somewhat curious as to why QEMU doesn't do
> the page walks itself).
> 
> [*] https://lore.kernel.org/all/20240910152207.38974-1-nikwip@amazon.de
> 

Fair enough, but I still believe that it would be good to provide more
information about the failure to the VMM (considering the fact that KVM
tries to emulate an instruction anyway, adding a flag won't introduce any
performance overhead). I'll think about how we could do that without
being redundant :)

> > or we shouldn't return an error at all... Maybe it should be KVM_EXIT_MMIO with
> > some flag set? What do you think?
> 
> It'd be a breaking change and added complexity, for no benefit as far as I can
> tell.  KVM_EXIT_INTERNAL_ERROR is _not_ a death sentence, or at least it doesn't
> have to be.  Most VMMs do terminate the guest, but nothing is stopping userspace
> from grabbing RIP and emulating the instruction.  I.e. userspace doesn't need
> "permission" in the form of KVM_EXIT_MMIO to try and keep the guest alive.

Yeah, I just thought that "internal error" is not the best exit code for
the situations when guest fetches from MMIO (since it is a perfectly legal
operation from the architectural point of view). But I agree that it
would be a breaking change without functional benefit ( especially if we
provide a flag about what happened :) ).

P.S. I tested the latest kvm/next, and if we set the IDT descriptor base to
an MMIO address it still falls into the infinite loop on SVM. I'm going
to send the fix in the next couple of days.

Kind regards,
Ivan Orlov

