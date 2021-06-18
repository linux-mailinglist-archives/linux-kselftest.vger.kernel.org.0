Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8A3AC620
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhFRIdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 04:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhFRIdd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 04:33:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F5C860FF0;
        Fri, 18 Jun 2021 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624005084;
        bh=IlI2xoknvp6cj5Rqd8Uau9s9Kd6ZolRir32me078cFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIyln4rhWLixs0LTS7Bu13tEWBmArcje3C0Q9GU2Hl/4kYAZ+8gKQnXA0MlPaVoDW
         p4zawkMPjCt5QhuU3d1fjFoKAPJYJ8k43KS60RjuCpcGZZT8diWmrOt+7jTvWZdxGa
         dDrWh0bN0ZTXeA3YdzopcLfHGTbgk+y5u+9NKB3M=
Date:   Fri, 18 Jun 2021 10:31:21 +0200
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
Subject: Re: [PATCH v11 5/7] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMxZ2Z9s5YRvhetZ@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-6-jingzhangos@google.com>
 <YMxE8pUrbQkwlpbD@kroah.com>
 <0036c55a-72d6-7b5c-a6fd-3a285476e522@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0036c55a-72d6-7b5c-a6fd-3a285476e522@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 10:26:59AM +0200, Paolo Bonzini wrote:
> On 18/06/21 09:02, Greg KH wrote:
> > > +	struct kvm_stats_desc {
> > > +		__u32 flags;
> > > +		__s16 exponent;
> > > +		__u16 size;
> > > +		__u32 offset;
> > > +		__u32 unused;
> > > +		char name[];
> > > +	};
> > As I mention in another patch, this should be sucked in directly from
> > the .h file in kerneldoc format, so that everything stays in sync.  I
> > bet almost this whole file can be put into the .h file, look at how drm
> > and v4l2 does this in a way that you only have to write the above one
> > time, not try to keep it in sync in two different places.
> 
> V4L's userspace-api/media/v4l is absurdly good and I'd say it's by far the
> best documentation of any Linux subsystem, but it's all handwritten just
> like in KVM.  In fact, grepping for kernel-doc directives in Documentation/
> gives no hits for the V4L uAPI documentation.
> 
> DRM has great kernel documentation, but quality-wise the KVM userland
> documentation is on a completely different level compared to DRM; just
> compare https://www.kernel.org/doc/html/latest/virt/kvm/api.html to
> https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html.  The latter is not
> about how to use the DRM interfaces from userspace, it's about how to
> implement the userspace interfaces.  It is full of kernel struct definitions
> that should have no place in a uAPI manual, and does not include
> documentation for almost anything in include/uapi/drm/drm.h

Ok, it's your maintenance burden, not mine, I was just suggesting a way
to make it easier :)

I'll not complain about this anymore...

thanks,

greg k-h
