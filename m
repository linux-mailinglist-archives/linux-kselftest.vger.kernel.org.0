Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94003AA30F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhFPSUf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 14:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhFPSUf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 14:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AB59613DF;
        Wed, 16 Jun 2021 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623867507;
        bh=yR3TWXQGACrmeWymexeG1By33MQORQQAF0TeHv4GW1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COQk4a/UaxiwMIlcK4ZQEI0MCZ2TthwybNm0T8inJNsh3Yidk2jqKwkYKfI6/vX8w
         pcK3zCUY8ZCDHKJ3+LNjjBfu5DmAu+msMJwlh97PA3HqvuxBhAqDWS4Imj3zI8KyJn
         wjw0iwoWBPke8vFJ7rxJUwH+1tmTb1622MC5+WL8=
Date:   Wed, 16 Jun 2021 20:18:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
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
Subject: Re: [PATCH v9 3/5] KVM: stats: Add documentation for statistics data
 binary interface
Message-ID: <YMpAcaqjk4ZN90gj@kroah.com>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <20210614212155.1670777-4-jingzhangos@google.com>
 <YMoW7SBqO9EPgCXw@kroah.com>
 <9b9a951d-d020-5599-5c4f-e154b40522b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9a951d-d020-5599-5c4f-e154b40522b9@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 16, 2021 at 06:59:15PM +0200, Paolo Bonzini wrote:
> On 16/06/21 17:21, Greg KH wrote:
> > I forgot to comment on this one, sorry for the delay.
> > 
> > Why are you "inventing" your own schema format here for this?  Why not
> > use a well-known or at least well-designed/implemented one that we have
> > in userspace already?
> > 
> > There are a few that I would love to see in the kernel, varlink being
> > the best example.  We have kernel examples of this and I would consider
> > using that as a transport for sysfs-like data in the future, but never
> > got around to it.
> 
> Thanks, that's a good observation, and it's a problem that the rationale and
> the design process didn't end up in either the documentation or the commit
> message (only the outcome did).  In order to fix that, this is going to be
> quite a long message.
> 
> Varlink comprises both a schema and an encoding, and each has its own
> problems.  For the encoding of the data, varlink is really just using JSON
> and it is really just the wrong tool here.  The first few problems that come
> to mind are:
> 
> - varlink structs are encoded as JSON dictionaries.  Therefore, every time
> userspace reads the fields, the kernel has to include the field names as
> JSON dictionary keys.  This means that a lot of time is spent writing
> buffers, and on the receiving side parsing them.

Has this been measured?  Years ago when I messed with this, it was in
the noise as JSON parsing is really fast these days.

> - because numeric data has to be converted to ASCII the output doesn't have
> fixed offsets, so it is not possible to make an efficient implementation of
> pread.

efficient where?  In the kernel?

> - even though Varlink specifies that int is "usually int64", a little-known
> gem is that JSON behavior for numbers not representable as a double (i.e.
> exceeding 2^53) is implementation-defined; implementations can and will mess
> up values outside that range.  This problem is not specific to this KVM
> stats usecase; varlink's schema specification really is at odds with its
> encoding specification.

That's interesting, do the varlink developers know this?  And we can say
"for the kernel int will be int64" and be done with it, so this
shouldn't be that big of an issue.

> For the schema, there are some specific problems with varlink, but also a
> more generic issue.  The specific problems are:
> 
> - the schema doesn't include the length of arrays.  This makes it hard to
> compute in advance lengths and offsets of fields (even ignoring the fact
> that data is not binary, which I'll get to later)

Do you care in advance?

> - the schema also is not extensible with user annotations.  In our case that
> would be mostly the unit in which the value is expressed.

units would be nice, I agree.

> The main problem with the various available serialization formats is that
> their schema languages are designed to be compiled with a code generator.
> Here instead the schema is transmitted from the kernel to userspace.
> Userspace is not really supposed to know what a value means or even that if
> it exists.  Userspace takes care of collecting the data from the kernel, but
> ultimately there will be a human that knows what e.g. "io_exits" or
> "req_event" means, and they will ask for the current value, or a plot over
> time, of a specific statistic.
> 
> Now, unlike most other schema languages, varlink does not require
> precompiling the schema in its C bindings.  However, this was mostly just
> the authors not bothering to write a C code generator---they did write one
> for Rust, for example.  When using the "official" varlink C bindings, you
> hardly use the schema at all.

I don't think the kernel implementation needs this, you can just specify
the schema "on the fly" and it should work.  Or maybe I'm wrong, it's
been a few years.

> Something similar to the above issues is quite common in other formats.  For
> example, FlatBuffers[2]'s schema language[1] does have annotations (which it
> calls metadata), but then we would still have to invent some standard
> annotations and teach programs about them.  However, the deal breaker is
> that again there is no way to transmit the schema from the server to the
> client, and that users are supposed to precompile the schema using a code
> generator.

Again, I didn't think this was an issue with the kernel implementation
in that the userspace side could determine the schema by the data coming
from the kernel, it wouldn't have to "know" about it ahead of time.

But I could be wrong.

> All that said, what we _could_ do is serialize the schema as JSON instead of
> using a binary format, like so:
> 
>   [{
>     "name": "exits",
>     "kind": "cumulative",
>     "count": 1
>   }, {
>     "name": "halt_poll_fail_ns",
>     "kind": "cumulative",
>     "unit": "seconds",
>     "scale": {"base": "pow2", exponent: -9},
>     "count": 1
>   }, ...]
> 
> while keeping the actual statistics as an array of u64 values just like in
> these patches.  The JSON representation of the schema would be always the
> same, so it could be treated as fixed-size and an efficient implementation
> of pread would be possible.  And once the schema is JSON, there could be a
> *meta*-schema expressed using the varlink language:
> 
>   # compare to struct kvm_stats_desc, included after my sig
>   # for reference
>   type StatsDescriptor {
>     name: string,
>     kind: (cumulative, instant, peak),
>     unit: ?(bytes, seconds, cycles),
>     scale: ?(base: (pow2, pow10), exponent: int),
>     count: int
>   }
> 
>   type StatsSchema {
>     name: string,
>     stats: []StatsDescriptor
>   }
> 
> Varlink would *not* be used in the kernel, because Varlink isreally just
> JSON.  The above ten lines (plus comments) would be dropped in
> Documentation/ as a .varlink file; they would be a convenient way to
> describe (to either a human or a program) how to parse the JSON schema.
> 
> There would then be another problem, namely how to include the varlink
> schema in the generated documentation, since right now there are for example
> no sphinx bindings for varlink.  Nevertheless, if you think it's better to
> have the schema as JSON instead of binary, according to the above varlink
> meta-schema, then we can look into it.

It should be in some standard format.  I'm not wed to varlink, but I
thought it solved some of your issues here with userspace not knowing
the schema ahead of time which is the key as it will change over time
and the kernel should be 'self-describing'.

If not, and it sounds like you have looked into it, or at least the
userspace side, then that's fine.

But you should write up a justification somewhere why you didn't use an
existing format (what about the netlink format?) in at least the
changelog, like you did here.  As you will be stuck with this api for
the next 20+ years, it's good to be confident in it :)

maybe someday we can get varlink into the tree, as I still think it
would be better than the ad-hoc implementations we currently have.

thanks,

greg k-h
