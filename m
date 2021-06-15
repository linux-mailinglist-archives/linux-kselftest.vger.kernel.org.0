Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A77F3A802C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhFONgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 09:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFONgT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 09:36:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF8716146D;
        Tue, 15 Jun 2021 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623764049;
        bh=REF7Zyu6cbgt3VHjuTrKDBWw8/fKKSkHr0brWCx1WDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkUy3EPUFEC5VTgPlUyI6q6kNVNwNuv+cujwgXgPktfMgwoXCN95LVYvlr2Cxj5lz
         l7GoBU3O5grP+tSvw2b+HZzeV4cPkqgacG9kci2/x8y4ZXP/qpEimP9hJZ0eyIvDWb
         e5t98f1pDJrHOs1eMmm+HNMbbYx0y9UmuOFThQFo+VSYEuyk0VmOVUs27m7Z1XOQ8N
         OzmOPwdzQMYJWZIAF/rw5OQU4jmobLkJjH62eDzX9vHVkkrAFKFk73DgtornGy6rzc
         Q89kw18R9QHxO9McqK/4MPLseixa1r/dEtCbz2OYQIwQJI29SS6qjzYQ0ZfHpVymek
         F4bBAvgv4qHbg==
Date:   Tue, 15 Jun 2021 16:34:05 +0300
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
Message-ID: <YMisTWKdyNgPvdQV@unreal>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <YMg5xPbmK3myjIX8@unreal>
 <15875c41-e1e7-3bf2-a85c-21384684d279@redhat.com>
 <YMhcek2cIu3Oz5Ek@unreal>
 <9df462c0-e0ea-8173-0705-369d6a81107c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df462c0-e0ea-8173-0705-369d6a81107c@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 15, 2021 at 01:03:34PM +0200, Paolo Bonzini wrote:
> On 15/06/21 09:53, Leon Romanovsky wrote:
> > > Sorry for my naive questions, but how does telemetry get statistics
> > > for hypervisors? Why is KVM different from hypervisors or NIC's statistics
> > > or any other high speed devices (RDMA) that generate tons of data?
> > 
> > So the answer to the question "why KVM is different" is that it doesn't
> > have any stable identification except file descriptor. While hypervisors
> > have stable names, NICs and RDMA devices have interface indexes etc.
> > Did I get it right?
> 
> Right.
> 
> > And this was second part of my question, the first part was my attempt to
> > get on answer why current statistics like process info (/proc/xxx/*), NICs
> > (netlink) and RDMA (sysfs) are not using binary format.
> 
> NICs are using binary format (partly in struct ethtool_stats, partly in an
> array of u64).  For KVM we decided to put the schema and the stats in the
> same file (though you can use pread to get only the stats) to have a single
> interface and avoid ioctls, unlike having both ETH_GSTRINGS and ETH_GSTATS.
> 
> I wouldn't say processes are using any specific format.  There's a mix of
> "one value per file" (e.g. cpuset), human-readable tabular format (e.g.
> limits, sched), human- and machine-readable tabular format (e.g. status),
> and files that are ASCII but not human-readable (e.g. stat).

I see, your explanation to Enrico cleared the mud.

Thanks

> 
> Paolo
> 
