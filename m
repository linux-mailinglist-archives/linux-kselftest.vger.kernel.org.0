Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998EF441E1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhKAQ3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 12:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232618AbhKAQ3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 12:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635784041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brTRyUOK10v3iQe+BLkt1I7upyFGDqQLk5cXqnsOnA4=;
        b=SlnOQJFai+naWqb+Ob+tRWhkjRc/LhlhSuJCF3pbQeywjuhDpIWiR26sO4LUeBzxWSqLOk
        iu4A2by/1lAO14BCS8KZHuJNvEtmBd6Hh/2wGo82GDDSSdYWP7PX04c6ErIhYFoZDwV3iZ
        1DVIqzXaQkJYzj5xv3KdrOOEqZlS2oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-u-h92Wb-Mpm1t4X1YCeupQ-1; Mon, 01 Nov 2021 12:27:18 -0400
X-MC-Unique: u-h92Wb-Mpm1t4X1YCeupQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFA315721D;
        Mon,  1 Nov 2021 16:27:16 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4024419C79;
        Mon,  1 Nov 2021 16:26:58 +0000 (UTC)
Message-ID: <435a0473c5b42ef3e7c332e386af13f7e8d67c6a.camel@redhat.com>
Subject: Re: [PATCH v2 1/6] KVM: x86: SVM: add module param to control LBR
 virtualization
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Date:   Mon, 01 Nov 2021 18:26:57 +0200
In-Reply-To: <87pmrjkfs9.fsf@vitty.brq.redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
         <20211101140324.197921-2-mlevitsk@redhat.com>
         <87pmrjkfs9.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-11-01 at 17:21 +0100, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > This is useful for debug and also makes it consistent with
> > the rest of the SVM optional features.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/kvm/svm/svm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 21bb81710e0f6..2b5f8e10d686d 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -186,12 +186,13 @@ module_param(vls, int, 0444);
> >  static int vgif = true;
> >  module_param(vgif, int, 0444);
> >  
> > +static int tsc_scaling = true;
> > +module_param(tsc_scaling, int, 0444);
> > +
> >  /* enable/disable LBR virtualization */
> >  static int lbrv = true;
> >  module_param(lbrv, int, 0444);
> >  
> > -static int tsc_scaling = true;
> > -module_param(tsc_scaling, int, 0444);
> 
> Subject line says "KVM: x86: SVM: add module param to control LBR
> virtualization" but the patch just moves 'tsc_scaling' param a couple
> lines up. Was this intended or is this a rebase artifact and the patch
> just needs to be dropped?

Yes, I didn't notice when I rebased the series last time, that this patch was accepted
already.

Sorry for the noise.

Best regards,
	Maxim Levitsky

> 
> >  
> >  /*
> >   * enable / disable AVIC.  Because the defaults differ for APICv


