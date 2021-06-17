Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C83AB2DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhFQLpG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 07:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhFQLpF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 07:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB03B613FE;
        Thu, 17 Jun 2021 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623930178;
        bh=+rV2EQw4mSBWtxauWo8Ivv6JJIjCR1BlgSQtCti76T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOsz88jdOjhZ6ScuC0eG149FufoNS0FvGcFvsN69ADiQV5mtHh1W87F+LbRS8yvVo
         mbmy2yIjlKp44Se/pz59+wlrtaiRV/m81uwUJ0a6bMI1jGc8ExV0kvEn0W5446aUVQ
         3NzuOTVD5WkCd7FwIPYkOZszEcVq8A8n4m8GhHS4=
Date:   Thu, 17 Jun 2021 13:42:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMs1Pwf+nSQsfVUW@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
 <YMrkGZzPrt0jA1iP@kroah.com>
 <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 01:29:22PM +0200, Paolo Bonzini wrote:
> On 17/06/21 07:56, Greg KH wrote:
> > On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> > > +	struct kvm_stats_desc {
> > > +		__u32 flags;
> > > +		__s16 exponent;
> > > +		__u16 size;
> > > +		__u32 offset;
> > > +		__u32 unused;
> > > +		char name[0];
> > > +	};
> > 
> > <snip>
> > 
> > > +The ``unused`` fields are reserved for future support for other types of
> > > +statistics data, like log/linear histogram.
> > 
> > you HAVE to set unused to 0 for now, otherwise userspace does not know
> > it is unused, right?
> 
> Jing, I think you planned to use it with other flags that are unused for
> now?  But please do check that it's zero in the testcase.
> 
> > It is not a pointer, it is the data itself.
> > 
> > > +string starts at the end of ``struct kvm_stats_desc``.
> > > +The maximum length (including trailing '\0') is indicated by ``name_size``
> > > +in ``struct kvm_stats_header``.
> > 
> > I thought we were replacing [0] arrays with [], are you sure you should
> > be declaring this as [0]?  Same for all structures in this document (and
> > code).
> 
> In C code [0] is a bit more flexible than [].  I think in this particular
> case [] won't work due to how the structures are declared. In the
> documentation [] is certainly clearer.

Look at all of the patches that Gustavo has been doing all over the tree
for this work, you do not want to make him do this again here.

Gustavo, is [0] ok for fields like these?

thanks,

greg k-h
