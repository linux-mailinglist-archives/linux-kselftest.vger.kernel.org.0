Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5464672AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhLCHjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 02:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243710AbhLCHjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 02:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638516977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQYyhredCKvJvtuWlGf1vBWT69o93MUm/9UVItQcKys=;
        b=DCZQXj/27ShKsC7yP09GPFoueMNzwc3GyLYQ44wXQ5PJnt6dD77yrEvVHNrGbWe/K01P4V
        51W8JSorgWDzJ5VRwbcApKlBFsIZ1RN1ZYfOjqckmsDnGaf08p2lBDnlc8RtUgjPgs77Fj
        Wp21ULTTrximlprPKvryhMWzFWe7f70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-6nthxne1P6yKLiOSWUleTQ-1; Fri, 03 Dec 2021 02:36:14 -0500
X-MC-Unique: 6nthxne1P6yKLiOSWUleTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B528A190D342;
        Fri,  3 Dec 2021 07:36:13 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15E210016FE;
        Fri,  3 Dec 2021 07:36:11 +0000 (UTC)
Message-ID: <c77e17b70f420b6ba1d7ccf092c439f35456ccd8.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: selftests: svm_int_ctl_test: fix intercept
 calculation
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Dec 2021 09:36:09 +0200
In-Reply-To: <49b9571d25588870db5380b0be1a41df4bbaaf93.1638486479.git.maciej.szmigiero@oracle.com>
References: <49b9571d25588870db5380b0be1a41df4bbaaf93.1638486479.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2021-12-03 at 00:10 +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> INTERCEPT_x are bit positions, but the code was using the raw value of
> INTERCEPT_VINTR (4) instead of BIT(INTERCEPT_VINTR).
> This resulted in masking of bit 2 - that is, SMI instead of VINTR.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> index df04f56ce859..30a81038df46 100644
> --- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> @@ -75,7 +75,7 @@ static void l1_guest_code(struct svm_test_data *svm)
>  	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
>  
>  	/* No intercepts for real and virtual interrupts */
> -	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR | INTERCEPT_VINTR);
> +	vmcb->control.intercept &= ~(BIT(INTERCEPT_INTR) | BIT(INTERCEPT_VINTR));
>  
>  	/* Make a virtual interrupt VINTR_IRQ_NUMBER pending */
>  	vmcb->control.int_ctl |= V_IRQ_MASK | (0x1 << V_INTR_PRIO_SHIFT);
> 
Sorry about that.
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

