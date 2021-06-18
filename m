Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D672D3AC45C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFRHAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 03:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhFRHAQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 03:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9D0F60BBB;
        Fri, 18 Jun 2021 06:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623999486;
        bh=m8+3j1h9uPUH7ldRSsFhVI1uLiB+yHr1XUMjZUudEWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujJUai8fcs5lEWU/3cU8/GXeqIcba5i+t/74SdT0lsvSNS5jMnSJkzqTbvpMrEMkJ
         GNZlc0ZiLYB3If5vVG2bGndtSF7yKhimWXiEpNzuorEgiB331hXcnxlleA0v5oj8OO
         poK2IP3ORzF2KLRtDSg759FiOOgN7gPULOcVPPco=
Date:   Fri, 18 Jun 2021 08:58:04 +0200
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
Subject: Re: [PATCH v11 3/7] KVM: stats: Support binary stats retrieval for a
 VM
Message-ID: <YMxD/NxAvKkXB2iM@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-4-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618044819.3690166-4-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 04:48:15AM +0000, Jing Zhang wrote:
> Add a VM ioctl to get a statistics file descriptor by which a read
> functionality is provided for userspace to read out VM stats header,
> descriptors and data.
> Define VM statistics descriptors and header for all architectures.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com> #arm64
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/kvm/guest.c    | 14 +++++++++++++
>  arch/mips/kvm/mips.c      | 14 +++++++++++++
>  arch/powerpc/kvm/book3s.c | 16 +++++++++++++++
>  arch/powerpc/kvm/booke.c  | 16 +++++++++++++++
>  arch/s390/kvm/kvm-s390.c  | 19 +++++++++++++++++
>  arch/x86/kvm/x86.c        | 24 ++++++++++++++++++++++
>  include/linux/kvm_host.h  |  6 ++++++
>  virt/kvm/kvm_main.c       | 43 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 152 insertions(+)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 4962331d01e6..f456d1defe2b 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -28,6 +28,20 @@
>  
>  #include "trace.h"
>  
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = {
> +	KVM_GENERIC_VM_STATS()
> +};
> +static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
> +		sizeof(struct kvm_vm_stat) / sizeof(u64));
> +
> +struct kvm_stats_header kvm_vm_stats_header = {

Can this be const?

> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
> +	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
> +		       sizeof(kvm_vm_stats_desc),
> +};

If it can't be const, what is modified in it that prevents that from
happening?

thanks,

greg k-h
