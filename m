Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50653AC5EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhFRIZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 04:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhFRIZw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 04:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C11F6121D;
        Fri, 18 Jun 2021 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624004622;
        bh=8kIa5sNlt0Pl69kW6P6wTngWvlRlxxluJS87VDmBN58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCkJDdBNLND5GZiz2ir5ovYNPwCGZK758duSM4PdsRVPZV0Mhoa2Lr/wFa597auAS
         Cg+eqS67Tefemzt2Ct2SrkgUota8ywVzoO3dhRgt/YFEZjUwVRJfaawwoZRqyFAIXF
         htQDGfut8cBg5MTrkT24Anjlgi3/h5hx6t3dhEGU=
Date:   Fri, 18 Jun 2021 10:23:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary
 stats data
Message-ID: <YMxYC8syYRBhbBAq@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com>
 <YMxEqvKyGnZinMOS@kroah.com>
 <f2616b8e-0cf8-570f-4bd3-7ef5cbcb37b0@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2616b8e-0cf8-570f-4bd3-7ef5cbcb37b0@gnu.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 10:02:57AM +0200, Paolo Bonzini wrote:
> On 18/06/21 09:00, Greg KH wrote:
> > > +struct kvm_stats_header {
> > > +	__u32 name_size;
> > > +	__u32 count;
> > > +	__u32 desc_offset;
> > > +	__u32 data_offset;
> > > +	char id[];
> > > +};
> > 
> > You mentioned before that the size of this really is the size of the
> > structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?
> > 
> > If so, why not put that value explicitly in:
> > 	char id[THE_REST_OF_THE_HEADER_SPACE];
> > 
> > As this is not a variable header size at all, and you can not change it
> > going forward, so the variable length array here feels disingenuous.
> 
> It can change; the header goes up to desc_offset.  Let's rename desc_offset
> to header_size.

"Traditionally" the first field of a variable length structure like this
has the size.  So maybe this needs to be:

struct kvm_stats_header {
	__u32 header_size;
	__u32 name_size;
	__u32 num_desc;
	__u32 desc_offset;
	__u32 data_offset;
	char id[];
};

I just guessed at what "count" is as I do not remember at the moment,
but obviously "count" wasn't descriptive :)

Wait, what is "name_size" here for?

> > > +struct kvm_stats_desc {
> > > +	__u32 flags;
> > > +	__s16 exponent;
> > > +	__u16 size;
> > > +	__u32 offset;
> > > +	__u32 unused;
> > > +	char name[];
> > > +};
> > 
> > What is the max length of name?
> 
> It's name_size in the header.

So it's specified in the _previous_ header?  That feels wrong, shouldn't
this descriptor define what is in it?

I'm not trying to nit-pick here, I'm actually confused now.  Structures
that contain "headers" should have in those headers at least two things:
	- declare the size of themselves if they are variable length
	- declare offsets to other structures

Don't put a size in this header for the size of a later structure,
that's just extra complexity that is not needed.

Think of this as a stream of bytes across the wire like a hardware
descriptor.  We have loads of experience dealing with this with
protocols like USB and Greybus and PCI and the like.  Let's learn from
those experiences and not try to mess things up where we don't need to
:)


> 
> > Why aren't these structures defined here in kerneldoc so that we can
> > understand them better?  Putting them in a .rst file guarantees they
> > will get out of sync, and you can always directly import the kerneldoc
> > into the .rst file.
> 
> This is a problem in general with Documentation/virt/kvm/api.rst.  The file
> is organized to match the kerneldoc structs to the ioctl that they are used
> for, and sometimes a ioctl includes different structs for each architecture.
> 
> It is probably possible to do it using :identifiers: and/or :doc:, but it
> would require running scripts/kernel-doc on the uAPI headers dozens of
> times.  That is quite expensive at 0.3s each run, but that's what you get
> with Perl (gcc -fsyntax-only is 20 times faster).

Is that what v4l and drm do today?  That's still safer and more
"obvious" than trying to keep two different files in sync which, as I
well know, almost impossible to do well over the _years_ in which you
will have to maintain these files.

Let's make it easier for everyone, put it only in one place and if
people want to see the documentation, they can generate it (it's
auto-generated on kernel.org anyway), no need to worry about multiple
passes or not.

thanks,

greg k-h
