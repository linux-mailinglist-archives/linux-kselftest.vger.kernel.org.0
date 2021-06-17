Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61BA3AAB6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 07:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhFQFyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 01:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhFQFyy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 01:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64E2613B9;
        Thu, 17 Jun 2021 05:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623909165;
        bh=9KBrT/ACir1e2NYW19fTACFyvfP46/nEtRjOwC4TLa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COom/knVjERjbeaSc0vj31xh3o+QfjpOZPlnEyVZZiSgaA48LCYLRHSJNDuspnqSm
         OYdExBPFwSSgDLjQJU4SsiypobFhY6HpllEsKce76jnk7CA6aM1vqUkjLASrpLt0it
         J+4u3QGq+mzIXOigYYBf5VO+NGVjNWZ7L62J3+DE=
Date:   Thu, 17 Jun 2021 07:52:42 +0200
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
Message-ID: <YMrjKhV8TNwmRtf6@kroah.com>
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
> +	struct kvm_stats_desc {
> +		__u32 flags;
> +		__s16 exponent;
> +		__u16 size;
> +		__u32 offset;
> +		__u32 unused;
> +		char name[0];
> +	};
> +
> +The ``flags`` field contains the type and unit of the statistics data described
> +by this descriptor. The following flags are supported:
> +
> +Bits 0-3 of ``flags`` encode the type:

<snip>

As flags is a bit field, what is the endian of it?  Native or LE or BE?
I'm guessing "cpu native", but you should be explicit as userspace will
have to deal with this somehow.

thanks,

greg k-h
