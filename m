Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16303A7A62
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 11:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFOJXq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 05:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhFOJXp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 05:23:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23BF6137D;
        Tue, 15 Jun 2021 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623748901;
        bh=0tj/dQXhQr4F8TkJ6u1QLLJjy1TjKMTf4Ej+MdIFcnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5lST+dKOr4Dkl2UvZOYXFU0nxIYOs1vGMf3GpujfqPe/5SiJ3pNN9BuT6A9RmZcR
         D/kah3Ydys+8ikUaKNj4CpYs+Byb3CybeMwgGrGiBMlDVhfeqyDewJ7I7wZzC0m6fi
         2mRxpNnl2uEoOWM10Sps8EkZbn/PVdnivEL0TO28=
Date:   Tue, 15 Jun 2021 11:21:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
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
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
Message-ID: <YMhxIiciyzPchF/2@kroah.com>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 15, 2021 at 10:37:36AM +0200, Enrico Weigelt, metux IT consult wrote:
> Why not putting this into sysfs ?

Because sysfs is "one value per file".

> I see two options:
> 
> a) if it's really kvm-specific (and no chance of using the same
>    interface for other hypervisors), we could put it under the
>    kvm device (/sys/class/misc/kvm).

Again, that is NOT what sysfs is for.

> b) have a generic VMM stats interface that theroretically could work
>    with any hypervisor.

What other hypervisor matters?

greg k-h
