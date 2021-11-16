Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A6453BC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 22:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhKPVl6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Nov 2021 16:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhKPVl6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Nov 2021 16:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637098740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTjW19qZdyUqpVYPyw3O2e3LOsDvSyyIGNuakp97I8M=;
        b=dQe2uZdxvvDobpzplqFRYPadkCpeBK6sLC8xyOj6pBEtx/JrTAt19AkJb+YAn++t/cvD7g
        Sji9zJVsW2YrPq5GTgDM59r2hLb//d4BByaq3hVvbePBCqFfvvgJ8xRuQo0RoHHQGWduvc
        hf3P0lUcXVsmj3LKcESMIJMRq4pqghg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-VIIy0NdwMbur5PwILq9BcQ-1; Tue, 16 Nov 2021 16:38:59 -0500
X-MC-Unique: VIIy0NdwMbur5PwILq9BcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6258C15721;
        Tue, 16 Nov 2021 21:38:57 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1762760BF1;
        Tue, 16 Nov 2021 21:38:48 +0000 (UTC)
Message-ID: <f983e2e343f600ab5196aef8389d719bc2ab7308.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] nSVM optional features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Date:   Tue, 16 Nov 2021 23:38:47 +0200
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-11-01 at 16:03 +0200, Maxim Levitsky wrote:
> This is a resend of a few patches that implement few
> SVM's optional features for nesting.
> 
> I was testing these patches during last few weeks with various nested configurations
> and I was unable to find any issues.
> 
> I also implemented support for nested vGIF in the last patch.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (6):
>   KVM: x86: SVM: add module param to control LBR virtualization
>   KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running
>   KVM: x86: nSVM: implement nested LBR virtualization
>   KVM: x86: nSVM: implement nested VMLOAD/VMSAVE
>   KVM: x86: nSVM: support PAUSE filter threshold and count when
>     cpu_pm=on
>   KVM: x86: SVM: implement nested vGIF
> 
>  arch/x86/kvm/svm/nested.c |  86 ++++++++++++++++++++---
>  arch/x86/kvm/svm/svm.c    | 140 ++++++++++++++++++++++++++++++++------
>  arch/x86/kvm/svm/svm.h    |  38 +++++++++--
>  3 files changed, 228 insertions(+), 36 deletions(-)
> 
> -- 
> 2.26.3
> 
> 
Kind ping on these patches.

Best regards,
	Maxim Levitsky

