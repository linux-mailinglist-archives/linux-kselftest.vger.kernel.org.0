Return-Path: <linux-kselftest+bounces-18289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192439842BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316DEB27624
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCD15575C;
	Tue, 24 Sep 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xu2XRwxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87B768FD;
	Tue, 24 Sep 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171670; cv=none; b=SUpqLFzgSgZ95l5FtEULJTSnandrMaDsCNGPYHNW0eh6dmZyEW+hoFQEbZ1ht6xJEqUpNIQk9b1QmqZA3Jl3jbzfX3HvqkjJYSiMKjxbJ3m/S/yIHJIsX8IfiREPoByn4LvZlbn1hCfO4BYaVx5JaAbu3KY/etVDLpUGjPGDSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171670; c=relaxed/simple;
	bh=Gkrrud4kuXvxvQ6MtiC443Wd3/2RFLqYqDIQsc6zefM=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZALwv90ddnTqUZBkw7EEwGhMyMpxHVKLksUUXr32NySWV17zrtRGEN8pGL36XE9/LesaurtuTQatutCn2bcyolIGgoqgGK+lwSSIfP3IEdXxU3bzNPtdB0Kzvq31SaMobbu9Van6CIdJqQuxMnMi3IoKhf5boaSxsxw3zZN2KQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xu2XRwxZ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727171669; x=1758707669;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=K8LrR0vVZyaYFA7OwHUo5vxCOF7p2lb3YoI5XYN1fhE=;
  b=Xu2XRwxZXG6GyjUuyraR4GiLpFna3N0KrKCPGoTe/0IMmbDNgM+IvqUc
   6Ep8Dt6k6gRpcynkh/3+vWUlF81HOkl1yaMMLZyAIwC7hyBUKlSMVRtPs
   bqlRDOicq8eJEZVY9RWtlHMx/AVBFOJbcuTXY8qPfvPoh00Ce3J15OVlh
   U=;
X-IronPort-AV: E=Sophos;i="6.10,254,1719878400"; 
   d="scan'208";a="429947790"
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 09:54:26 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:46744]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.76:2525] with esmtp (Farcaster)
 id bdfbeaad-b03b-481b-a8e4-94c2c0fe622e; Tue, 24 Sep 2024 09:54:25 +0000 (UTC)
X-Farcaster-Flow-ID: bdfbeaad-b03b-481b-a8e4-94c2c0fe622e
Received: from EX19D033EUB004.ant.amazon.com (10.252.61.103) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 24 Sep 2024 09:54:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D033EUB004.ant.amazon.com (10.252.61.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 24 Sep 2024 09:54:24 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 24 Sep 2024 09:54:23 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id 0F60740359;
	Tue, 24 Sep 2024 09:54:23 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id C01BE8A04; Tue, 24 Sep 2024 09:54:22 +0000 (UTC)
Date: Tue, 24 Sep 2024 09:54:22 +0000
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
Message-ID: <20240924095422.GA66922@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20240923141810.76331-1-iorlov@amazon.com>
 <ZvGfnARMqZS0mkg-@google.com>
 <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
 <ZvHhqRWW04jmk8TW@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZvHhqRWW04jmk8TW@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 23, 2024 at 02:46:17PM -0700, Sean Christopherson wrote:
 > >
> > > No.  This is not architectural behavior.  It's not even remotely
> > > close to
> > > architectural behavior.  KVM's behavior isn't great, but making up
> > > _guest visible_
> > > behavior is not going to happen.
> >
> > Is this a no to the whole series or from the cover letter?
> 
> The whole series.
> 
> > For patch 1 we have observed that if a guest has incorrectly set it's
> > IDT base to point inside of an MMIO region it will result in a triple
> > fault (bare metal Cascake Lake Intel).
> 
> That happens because the IDT is garbage and/or the CPU is getting master abort
> semantics back, not because anything in the x86 architectures says that accessing
> MMIO during exception vectoring goes straight to shutdown.
>

Hi Sean, thank you for the detailed reply.

Yes, I ran the reproducer on my AMD Ryzen 5 once again, and it seems like
pointing the IDT descriptor base to a framebuffer works perfectly fine,
without any triple faults, so injecting it into guest is not a correct
solution.

However, I believe KVM should demonstrate consistent behaviour in
handling MMIO during event delivery on vmx/svm, so either by returning
an event delivery error in both cases or going into infinite loop in
both cases. I'm going to test the kvm/next with the commits you
mentioned, and send a fix if it still hits an infinite loop on SVM.

Also, I reckon as detecting such an issue on the KVM level doesn't
introduce much complexity, returning a sane error flag would be nice. For
instance, we could set one of the 'internal.data' elements to identify
that the problem occured due to MMIO during event delivery

> > Yes a sane operating system is not really going to be doing setting it's IDT
> > or GDT base to point into an MMIO region, but we've seen occurrences.
> > Normally when other external things have gone horribly wrong.
> >
> > Ivan can clarify as to what's been seen on AMD platforms regarding the
> > infinite loop for patch one. This was also tested on bare metal
> > hardware. Injection of the #UD within patch 2 may be debatable but I
> > believe Ivan has some more data from experiments backing this up.
> 
> I have no problems improving KVM's handling of scenarios that KVM can't emulate,
> but there needs to be reasonable justification for taking on complexity, and KVM
> must not make up guest visible behavior.

Regarding the #UD-related change: the way how I formulated it in the
cover letter and the patch is confusing, sorry. We are _alredy_ enqueuing
an #UD when fetching from MMIO, so I believe it is already architecturally
incorrect (see handle_emulation_failure in arch/x86/kvm/x86.c). However,
we return an emulation failure after that, and I believe how we do this
is debatable. I maintain we should either set a flag in emulation_failure.flags
to indicate that the error happened due to fetch from mmio (to give more
information to VMM), or we shouldn't return an error at all... Maybe it
should be KVM_EXIT_MMIO with some flag set? What do you think?

Thank you!

Kind regards,
Ivan Orlov

