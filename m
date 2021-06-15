Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452183A788A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFOHzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 03:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhFOHzi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 03:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4086B60E09;
        Tue, 15 Jun 2021 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623743613;
        bh=vDFtBhlYLrwtZnXOmkUZxpC5WdGn3oEPAkfut4CQqlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5TCBQVSBuiL6rRGP41YwOT3DJImXi6Z1ty8MpV5XWkPGRguUfc9uqH2nPdbuWVKF
         nvKqUgp1gYQEozxBTNl+B8OwZn6E0A0Azee9sgNbBFp5f2BF9MrCeazfECaTgWqA9R
         IbVaQdoTKURDMZqti9x/Eraat8P4E50XDSuVD+MuJCPgtp9VnY24fi2kAu85igKzhD
         0A1BkJXNkIQZLCyCOJWVgqoq+ZvwfFA4F+e8cmCvtDh1bylcfCG/QNJysbdmDUL8NF
         wKqmAxU0QdRufELcUgnOVFU0l12rQxTX29JTQBnJJY+L0yB5UefYMAD5OIhB88ScBU
         CFl88in6YsOAw==
Date:   Tue, 15 Jun 2021 10:53:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
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
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
Message-ID: <YMhcek2cIu3Oz5Ek@unreal>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <YMg5xPbmK3myjIX8@unreal>
 <15875c41-e1e7-3bf2-a85c-21384684d279@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15875c41-e1e7-3bf2-a85c-21384684d279@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 15, 2021 at 09:06:43AM +0200, Paolo Bonzini wrote:
> On 15/06/21 07:25, Leon Romanovsky wrote:
> > Sorry for my naive questions, but how does telemetry get statistics
> > for hypervisors? Why is KVM different from hypervisors or NIC's statistics
> > or any other high speed devices (RDMA) that generate tons of data?
> 
> Right now, the only way is debugfs but it's slow, and it's disabled when
> using lockdown mode; this series is a way to fix this.
> 
> I sense that there is another question in there; are you wondering if
> another mechanism should be used, for example netlink?  The main issue there
> is how to identify a VM, since KVM file descriptors don't have a name.
> Using a pid works (sort of) for debugfs, but pids are not appropriate for a
> stable API.  Using a file descriptor as in this series requires
> collaboration from the userspace program; howver, once the file descriptor
> has been transmitted via SCM_RIGHTS, telemetry can read it forever without
> further IPC, and there is proper privilege separation.

Yeah, sorry for mixing different questions into one.

So the answer to the question "why KVM is different" is that it doesn't
have any stable identification except file descriptor. While hypervisors
have stable names, NICs and RDMA devices have interface indexes e.t.c.
Did I get it right?

And this was second part of my question, the first part was my attempt to
get on answer why current statistics like process info (/proc/xxx/*), NICs
(netlink) and RDMA (sysfs) are not using binary format.

Thanks

> 
> Paolo
> 
