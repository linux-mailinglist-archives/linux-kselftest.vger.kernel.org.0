Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993769B530
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBQWBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 17:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQWBn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 17:01:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3B59736
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 14:01:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l8so2289670wrv.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+RWIU7oYjEmeKhN1BRM+dPgJ9kaVMQBvH0lTKx4gCo=;
        b=P7KlUd8vpj+WjFNp4aWlFlmB/DX+kLVPD3QP7QX7aLNUWsHdPIdNFpbudIqZ+cvY3W
         HE0ybe5TzouaO117yLXbatR1gY8rf1h/o+Bbbu3X5MDM0ZuWico3g9t9+bxjoOmydgzx
         /ZSgmlxE3ZAvzI1Fz/TVDDEHgO5h2G13bQcwPcyDdQd9nb86jlNZWruMtK/sN29vC8EN
         qKYcgdkk5hp4jtKsLRINg8vRhzyDDSkhTbmlmWZWtBZVzH3kKZEN3c8jPfDaXOCTZ1+/
         m7EmHx5R0xdNkHUBsI3nYaZWB6exavhe51sDW3KSusJYEPjUMh4WO7GAZe3VRKgtC57A
         DXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+RWIU7oYjEmeKhN1BRM+dPgJ9kaVMQBvH0lTKx4gCo=;
        b=iERS9IP9NwVMqGpfV7gGYhaKM5f2XRtcONiLgiRCYLEaZ7otROjcLamR/0jiqIz5Vx
         yPKofqbwqAJJwa+5Acb+TNh0WrmkJ+aVL4fDTdRqLqi2WMyw5fEz+3DotS1Q/W2pOfKe
         gTwzq4rnnhMgj4hpV/Dzfh/nNTlRBnVIibONbpAyg9JUAUcVZQSjvfE2qO90kv8Z2eX0
         1ho0H9Lpg2wGZO2lSDnHhvGF0HBOa0X2/6Io6lUgEiZQv/zbjXunt4Xh7cOc47PGGIVW
         wAP2m0LhdCP90kulmDSS6+l0BFh3+pSKue/q5w9uvRM43z00VAuuS0vSinSiNaTXHPK2
         27jQ==
X-Gm-Message-State: AO0yUKW0Cu6vsQEs+vaLBa9mpNq9mEBiYrD36nwGvEPRaxLgEyRYjutL
        /BWfIoShoMOoguzR6+DVo9wLT5HrVutPY+LOy4lt8A==
X-Google-Smtp-Source: AK7set8Y5jxAp9swg/itPrwFcKyXyojx4iwM90gLmILXSZ0Xoyfrwexebu9w/TfSPp/vznOWaghs7HSgvJ2FQTvEhzU=
X-Received: by 2002:a5d:640e:0:b0:2c4:dbc:8e34 with SMTP id
 z14-20020a5d640e000000b002c40dbc8e34mr229772wru.123.1676671299303; Fri, 17
 Feb 2023 14:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com> <20230214184606.510551-4-mizhang@google.com>
In-Reply-To: <20230214184606.510551-4-mizhang@google.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Fri, 17 Feb 2023 22:01:27 +0000
Message-ID: <CAAAPnDFG+9x5A24cDs8344k9W6zddpJ7cKBFOXmzaLhMhvmR=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] KVM: selftests: x86: Add check of CR0.TS in the
 #NM handler in amx_test
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 14, 2023 at 6:46 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> Add check of CR0.TS[bit 3] before the check of IA32_XFD_ERR in the #NM
> handler in amx_test. This is because XFD may not be the only reason of
> the IA32_XFD MSR and the bitmap corresponding to the state components
> required by the faulting instruction." (Intel SDM vol 1. Section 13.14)
>
> Add the missing check of CR0.TS.
>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index aac727ff7cf8..847752998660 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -215,6 +215,7 @@ void guest_nm_handler(struct ex_regs *regs)
>  {
>         /* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
>         GUEST_SYNC(7);
> +       GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);

Can't we infer that the #NM is the result of an XFD error due to the fact
that IA32_XFD_ERR is set?  Is this check needed?
SDM vol 1, 13.14, EXTENDED FEATURE DISABLE (XFD)
 - Device-not-available exceptions that are not due to XFD - those
   resulting from setting CR0.TS to 1 - do not modify the IA32_XFD_ERR
   MSR.

>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
>         GUEST_SYNC(8);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> --
> 2.39.1.581.gbfd45094c4-goog
>
