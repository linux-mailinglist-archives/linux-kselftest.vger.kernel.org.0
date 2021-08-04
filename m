Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5C3E0192
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbhHDNDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 09:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237660AbhHDNDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 09:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628082185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59zmCpCBlITuttXNI4RN6CTgSr+o23QtyJ1nteFPfIs=;
        b=WDOCwrcBw9ZM5iyNU3PVqkmGeodA8HdoEm+yrwEA8BKg9nprWpgdqiGFARQYZ/iuty/kmg
        HXqGgZjez8jsRkXWXEFAN9mdpVG5rjw4qn7E+qZuSg7uL7AL8r5AXVr/iVUeAbUucRZLQV
        cTW1avbLteoXS8gQecBQWhfdcjVrs8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-66hV4PoLOOizQQL6lquQDg-1; Wed, 04 Aug 2021 09:03:02 -0400
X-MC-Unique: 66hV4PoLOOizQQL6lquQDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33CF31853040;
        Wed,  4 Aug 2021 13:03:01 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4518A5DD68;
        Wed,  4 Aug 2021 13:02:59 +0000 (UTC)
Message-ID: <dcb6aad4e544bed88dd05d3d3c64ac4b9b9f5a25.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: fix hyperv_clock test
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Wed, 04 Aug 2021 16:02:58 +0300
In-Reply-To: <74cec7b5-ae92-2f34-9aa5-30306509f933@redhat.com>
References: <20210804112057.409498-1-mlevitsk@redhat.com>
         <74cec7b5-ae92-2f34-9aa5-30306509f933@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-08-04 at 14:24 +0200, Paolo Bonzini wrote:
> On 04/08/21 13:20, Maxim Levitsky wrote:
> > The test was mistakenly using addr_gpa2hva on a gva
> > and that happened to work accidentally.
> > 
> > commit 106a2e766eae ("KVM: selftests:
> > Lower the min virtual address for misc page allocations")
> > revealed this bug.
> > 
> > Fixes: 106a2e766eae ("KVM: selftests: Lower the min virtual address for misc page allocations")
> 
> The right "Fixes" is 2c7f76b4c42b ("selftests: kvm: Add basic Hyper-V 
> clocksources tests", 2021-03-18).

Makes sense. I wasn't sure about which commit to blame here.
I'll resend the patch.

Best regards,
	Maxim Levitsky
> 
> Paolo
> 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> > index bab10ae787b6..e0b2bb1339b1 100644
> > --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> > +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> > @@ -215,7 +215,7 @@ int main(void)
> >   	vcpu_set_hv_cpuid(vm, VCPU_ID);
> >   
> >   	tsc_page_gva = vm_vaddr_alloc_page(vm);
> > -	memset(addr_gpa2hva(vm, tsc_page_gva), 0x0, getpagesize());
> > +	memset(addr_gva2hva(vm, tsc_page_gva), 0x0, getpagesize());
> >   	TEST_ASSERT((addr_gva2gpa(vm, tsc_page_gva) & (getpagesize() - 1)) == 0,
> >   		"TSC page has to be page aligned\n");
> >   	vcpu_args_set(vm, VCPU_ID, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
> > 


