Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331DD3A7670
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 07:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhFOF1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 01:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhFOF1c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 01:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC7106140C;
        Tue, 15 Jun 2021 05:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623734728;
        bh=ccQSlvryxnxETl+l+tNcmXDaNhM9HlrwPO8EJMj+lco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqGj7By+d/l6mauCaIJU0c/KV3+rqklJy6aVtPt9CDzS7chlu0KCSgJohCt6ENRFB
         hZbqrm74sk+HbYGsLB2IFGR0HNlTtEDCiJ45q53lv3oXtKgbUi2LTn6IBkCySex0Ut
         v+lP6YYo+18NfLUwnU/avHN5VCfXxHGNOLiIYOEUwXTfMSpFZLeX2c5sZ6FUPzXloJ
         3NKX84fPqnuujHvw9LaCnskPcKNSo1gTZ6gUirpGBA4TSmfzxMrFZtGX6C09vzgi+w
         E6/8CN+r511QtRKRmtzndwnz2BF4ZxWPZTO723jD82/gwROR8WDqwapMzkmkXos310
         A6WpBeSUo/T1g==
Date:   Tue, 15 Jun 2021 08:25:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
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
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
Message-ID: <YMg5xPbmK3myjIX8@unreal>
References: <20210614212155.1670777-1-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614212155.1670777-1-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 14, 2021 at 09:21:50PM +0000, Jing Zhang wrote:
> This patchset provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.
> It is meant to provide a lightweight, flexible, scalable and efficient
> lock-free solution for user space telemetry applications to pull the
> statistics data periodically for large scale systems. The pulling
> frequency could be as high as a few times per second.
> In this patchset, every statistics data are treated to have some
> attributes as below:
>   * architecture dependent or generic
>   * VM statistics data or VCPU statistics data
>   * type: cumulative, instantaneous, peak
>   * unit: none for simple counter, nanosecond, microsecond,
>     millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
> Since no lock/synchronization is used, the consistency between all
> the statistics data is not guaranteed. That means not all statistics
> data are read out at the exact same time, since the statistics date
> are still being updated by KVM subsystems while they are read out.

Sorry for my naive questions, but how does telemetry get statistics
for hypervisors? Why is KVM different from hypervisors or NIC's statistics
or any other high speed devices (RDMA) that generate tons of data?

Thanks
