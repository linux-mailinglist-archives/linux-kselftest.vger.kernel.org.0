Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA87F3E03A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhHDOqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 10:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238713AbhHDOqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 10:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628088360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AtaANfQj7G/12fLVNP8ZEKFYhS90aaah+dzycPwvl7A=;
        b=Usu6I00m+mSEcxWiwh3g4zK7cRSdWg8hljF/vK2YHxHSKrJyyvf4VL4FIUNdj7z4H/2HUu
        K//1pNnNpJfj7SuGRSuHVl3i08+7Eu0fKmIQzZyOw37kEwEc5VsMwknI9axeIzQtWJJw2w
        bkS/junpB8xjJQ68JHAZmg67MCpROV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-RluIBlZvO3Ovj2uUiEH8Iw-1; Wed, 04 Aug 2021 10:45:58 -0400
X-MC-Unique: RluIBlZvO3Ovj2uUiEH8Iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A30AC7400;
        Wed,  4 Aug 2021 14:45:56 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8255410016F2;
        Wed,  4 Aug 2021 14:45:44 +0000 (UTC)
Message-ID: <c82a3abe00d387985ac806c8ff062cc29e192bbd.camel@redhat.com>
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        linux-kselftest@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Date:   Wed, 04 Aug 2021 17:45:43 +0300
In-Reply-To: <42a812a9-7f17-2a26-d289-1f921408a469@intel.com>
References: <20210726183816.1343022-1-erdemaktas@google.com>
         <20210726183816.1343022-2-erdemaktas@google.com>
         <e1651746-aa46-31e7-e1c0-99f3faaf1586@intel.com>
         <ede70f11e713ee0140c0e684c3d46b3aa1176e5e.camel@redhat.com>
         <42a812a9-7f17-2a26-d289-1f921408a469@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-08-04 at 22:42 +0800, Xiaoyao Li wrote:
> On 8/4/2021 10:24 PM, Maxim Levitsky wrote:
> > On Wed, 2021-08-04 at 14:09 +0800, Xiaoyao Li wrote:
> > > On 7/27/2021 2:37 AM, Erdem Aktas wrote:
> > > > Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> > > > Changing the vm_create function to accept type parameter to create
> > > > new VM types.
> > > > 
> > > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > > Reviewed-by: Peter Gonda <pgonda@google.com>
> > > > Reviewed-by: Marc Orr <marcorr@google.com>
> > > > Reviewed-by: Sagi Shahar <sagis@google.com>
> > > > ---
> > > >    .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> > > >    tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
> > > >    2 files changed, 27 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > > > index d53bfadd2..c63df42d6 100644
> > > > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > > > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > > > @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
> > > >    void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> > > >    
> > > >    struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> > > > +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
> > > >    void kvm_vm_free(struct kvm_vm *vmp);
> > > >    void kvm_vm_restart(struct kvm_vm *vmp, int perm);
> > > >    void kvm_vm_release(struct kvm_vm *vmp);
> > > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > index e5fbf16f7..70caa3882 100644
> > > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > @@ -180,13 +180,36 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
> > > >     * Return:
> > > >     *   Pointer to opaque structure that describes the created VM.
> > > >     *
> > > > - * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
> > > > + * Wrapper VM Create function to create a VM with default type (0).
> > > 
> > > Can we pass KVM_X86_LEGACY_VM (whatever name when it's upstreamed)
> > > instead of 0?
> > 
> > To be honest I would prefer this to be called something like KVM_X86_STANDARD_VM,
> > or something.
> > 
> > I don't think that normal unencrypted virtualization is already legacy, even if TDX
> > docs claim that.
> 
> I'm not proposing to use this specific name introduced in TDX RFC 
> series, but proposing to use the name defined in KVM in the future 
> instead of hard-coded 0.
> 
> Yes, KVM_X86_STANDARD_VM or KVM_X86_NORMAL_VM (proposed by Paolo) is 
> better than KVM_X86_LEGACY_VM.

KVM_X86_NORMAL_VM is a very good name IMHO as well.
Thanks!

Best regards,
	Maxim Levitsky

> 
> > Just my personal opinion.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > > > + */
> > > > +struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> > > > +{
> > > > +	return __vm_create(mode, phy_pages, perm, 0);
> > > > +}
> > > > +


