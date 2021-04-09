Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944DC359F7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 15:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDINDt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDINDs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 09:03:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09BC061760;
        Fri,  9 Apr 2021 06:03:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0be10087e272fb724c6f37.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:87e2:72fb:724c:6f37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 494F91EC04DE;
        Fri,  9 Apr 2021 15:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617973409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ew12c1cnmAkvuVqrlWjQtHBzOeLUg/EWXSU+IY8aHRs=;
        b=Bk/5MmQtJyuIphXmGn6roxxNaL86fehI19pSHFxgsoCdrmaFvfoGSjojhQGDFhZEIw9V7K
        h07nr6yOtp0mW+ue7jnHFHzsC+ifxyWZyzt9VZD6jwm0j9SL1X1usWhrYLf/ijD3T9edBE
        PDQPyIMVEFOJtkYFEhf5ZkmvvE2P3e8=
Date:   Fri, 9 Apr 2021 15:03:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] KVM: cpuid: fix KVM_GET_EMULATED_CPUID
 implementation
Message-ID: <20210409130329.GD15567@zn.tnic>
References: <20210409125423.26288-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210409125423.26288-1-eesposit@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 09, 2021 at 02:54:19PM +0200, Emanuele Giuseppe Esposito wrote:
> This series aims to clarify the behavior of the KVM_GET_EMULATED_CPUID
> ioctl, and fix a corner case where -E2BIG is returned when
> the nent field of struct kvm_cpuid2 is matching the amount of
> emulated entries that kvm returns.
> 
> Patch 1 proposes the nent field fix to cpuid.c,
> patch 2 updates the ioctl documentation accordingly and
> patches 3 and 4 extend the x86_64/get_cpuid_test.c selftest to check
> the intended behavior of KVM_GET_EMULATED_CPUID.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
> v5:
> - Better comment in cpuid.c (patch 1)

How about you wait a couple of days so people have a chance to look at
your patches instead of sending a new revision every day?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
