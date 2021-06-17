Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE23AABA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 08:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQGJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 02:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhFQGJs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 02:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D7461019;
        Thu, 17 Jun 2021 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623910060;
        bh=RxxDN0+WJx8ilpW/G89Y9l2RP0sjoG+dzwtt9FWmNdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3pebzgE5nwbFTTzr0PIb9z/ZEgnnxnHesRDDy6lJTF8nybwSBUknD/QQcma5fFIi
         +yiHLSvYrwuvj0CXh+GKtYIRSaIhs66caI3lToxlN/iVYsN5GUwnDi1UL9OPBEfA7G
         EB3R+wnhzxf6jPmX6Xi7RyFfIrhgcZdXimzFlbiU=
Date:   Thu, 17 Jun 2021 08:07:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <YMrmqOxDWJ2/8sfD@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617044146.2667540-4-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> This new API provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.
> It is meant to provide a lightweight, flexible, scalable and efficient
> lock-free solution for user space telemetry applications to pull the
> statistics data periodically for large scale systems. The pulling
> frequency could be as high as a few times per second.
> The statistics descriptors are defined by KVM in kernel and can be
> by userspace to discover VM/VCPU statistics during the one-time setup
> stage.
> The statistics data itself could be read out by userspace telemetry
> periodically without any extra parsing or setup effort.

Do you have a pointer to userspace code that can do such a thing that
others can use?  We do not like adding apis to the kernel without at
least seeing the user of those apis, especially for complex things like
this.

Ideally you would include some library code in the kernel tree itself
that everyone can use for this for their own programs.  You have
provided a test which is great, but how do we know it works for "real"
usages?

thanks,

greg k-h
