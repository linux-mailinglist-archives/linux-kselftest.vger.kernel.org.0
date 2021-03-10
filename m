Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C563344C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhCJRFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 12:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhCJRFE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 12:05:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF3964FB0;
        Wed, 10 Mar 2021 17:05:04 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lK2Gc-000oQf-9v; Wed, 10 Mar 2021 17:05:02 +0000
Date:   Wed, 10 Mar 2021 17:05:01 +0000
Message-ID: <8735x3x7lu.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics in binary format
In-Reply-To: <a475d935-e404-93dd-4c6d-a5f8038d8f4d@redhat.com>
References: <20210310003024.2026253-1-jingzhangos@google.com>
        <20210310003024.2026253-4-jingzhangos@google.com>
        <875z1zxb11.wl-maz@kernel.org>
        <a475d935-e404-93dd-4c6d-a5f8038d8f4d@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, jingzhangos@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org, chenhuacai@kernel.org, aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, seanjc@google.com, vkuznets@redhat.com, jmattson@google.com, pshier@google.com, oupton@google.com, rientjes@google.com, eesposit@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 10 Mar 2021 16:03:42 +0000,
Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> On 10/03/21 16:51, Marc Zyngier wrote:
> >> +	kvm_for_each_vcpu(j, vcpu, kvm) {
> >> +		pdata = data + VM_STAT_COUNT;
> >> +		for (i = 0; i < VCPU_STAT_COUNT; i++, pdata++)
> >> +			*pdata += *((u64 *)&vcpu->stat + i);
> > Do you really need the in-kernel copy? Why not directly organise the
> > data structures in a way that would allow a bulk copy using
> > copy_to_user()?
> 
> The result is built by summing per-vCPU counters, so that the counter
> updates are fast and do not require a lock.  So consistency basically
> cannot be guaranteed.

Sure, but I wonder whether there is scope for VM-global counters to be
maintained in parallel with per-vCPU counters if speed/efficiency is
of the essence (and this seems to be how it is sold in the cover
letter).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
