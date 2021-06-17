Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4846D3AB2B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhFQLgz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 07:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhFQLgz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 07:36:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB320613FF;
        Thu, 17 Jun 2021 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623929687;
        bh=cMOB9S+2dYw6yIe3QIWUKtCOd2frCSqtDIIs3dUr138=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kx8OmuUL4tJIAHyPAWkrARJ0Ir7zyF+ick79boaurToJaLA8Hk8ty/lIedsm9DsF5
         qIfaxY49IOKm7frb9PPKRl36QiLCiTcNC1AHjX42ul5zUDe02zv6pxMJtN20AB5eIc
         Gd09aT5sOD4ToZgHiuHVuYc9NKGjP4ARo9UVwiR0=
Date:   Thu, 17 Jun 2021 13:34:45 +0200
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
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMszVQEK8LHiAT+9@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
 <YMrmqOxDWJ2/8sfD@kroah.com>
 <be506135-5bc3-31bd-1b20-063f01f41df1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be506135-5bc3-31bd-1b20-063f01f41df1@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 01:19:50PM +0200, Paolo Bonzini wrote:
> On 17/06/21 08:07, Greg KH wrote:
> > > The statistics data itself could be read out by userspace telemetry
> > > periodically without any extra parsing or setup effort.
> > Do you have a pointer to userspace code that can do such a thing that
> > others can use?  We do not like adding apis to the kernel without at
> > least seeing the user of those apis, especially for complex things like
> > this.
> > 
> > Ideally you would include some library code in the kernel tree itself
> > that everyone can use for this for their own programs.  You have
> > provided a test which is great, but how do we know it works for "real"
> > usages?
> 
> I am pretty sure that Google is using this internally, but we are also going
> to work on QEMU and Libvirt support for this.

We need an "external user" for something as complex as this to be able
to see if it actually works or not.  Otherwise we have to just guess :(

thanks,

greg k-h
