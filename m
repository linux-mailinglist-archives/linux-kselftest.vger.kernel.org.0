Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720BE147EF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgAXKpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 05:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729635AbgAXKpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 05:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579862748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enn+v7cz7QoWzDHWv3aRyENuP7ec0k47YNPibegz3Hs=;
        b=ARs+bUtUcc9/rdZZu0XBS+d4WWZx9P8X+SFhhw03OCq6v0H+rfKqmYlQI1zsXNkd/LSKkn
        xWrbxfFnCPdI35IyuVH/NZyps5Y0tWLG8+J5TnMr+BhImFitVshjdW87yTyMFAYcDhl4ne
        HipGhJSsKGDWDbl41LO7ykTG7nAk9zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-rgmBFWfzO9WL1x97cOKOig-1; Fri, 24 Jan 2020 05:45:46 -0500
X-MC-Unique: rgmBFWfzO9WL1x97cOKOig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26B151902EA4;
        Fri, 24 Jan 2020 10:45:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70EBA19C69;
        Fri, 24 Jan 2020 10:45:40 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:45:38 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set
 to aarch64 and s390x
Message-ID: <20200124104538.44i5ut5uzclz443i@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
 <4dbb6d1b-3162-d9b3-4ebb-5e4061776bb6@redhat.com>
 <20200124093543.m5oqo7fnjnc2scko@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124093543.m5oqo7fnjnc2scko@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 10:35:43AM +0100, Andrew Jones wrote:
> > > +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> > > +{
> > > +	va_list ap;
> > > +
> > > +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> > > +		    "  num: %u\n",
> > > +		    num);
> 
> Weird line breaking. I see it came from the x86 implementation, but it's
> weird there too... Personally I'd just put it all on one line, because
> my vt100 died two decades ago.
> 
> > > +
> > > +	va_start(ap, num);
> > > +
> > > +	for (i = 0; i < num; i++)
> > > +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
>                                                              ^^ should be 'i'

The declaration of 'i' is also missing.

> 
> > > +			va_arg(ap, uint64_t));
> 
> nit: I'd use {} because of the line break. Or just not break the line and
> bust the 80 char "limit" (RIP vt100).
>

Thanks,
drew 

