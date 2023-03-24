Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878B6C86F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjCXUjw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCXUju (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:39:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954BB1EBCF
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:39:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5458201ab8cso29765297b3.23
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679690376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWNApcsVqs6b8iyHjgouP8WjDbrbEDYT6YEA+91Iaa0=;
        b=Wkk8GoBMBfAaO8icCREFAmzcGXiN4+5z5fgoxnmaFd/mRFjAqra6kFilc9+/P2Qw4I
         4lEXB8v9R7Dq8iR4IbzrGXtwP0KHP6ErspCQ8wPGgksbkxb3g+Zkqy7VoSMrSeuuZR7u
         33Zrs+DmbpgyjaZa+lufLbAbv/Nr4P/Nh11ixJRvOmPLcGGVFjYRcieZ0Q+bygPlqCfx
         O28jcMtLnxqeSaELNfF7gYOupZwHuDvSbzEXLMN8SCosbtO4hxVQ7uvwyKsljVG2GJfu
         AW+sg+oTbGR9JWn9XoB0BAXxQ2VTXp1RR92nPgmBgOp+gmPSYNDeacU02bOjWr4nP8lL
         2iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWNApcsVqs6b8iyHjgouP8WjDbrbEDYT6YEA+91Iaa0=;
        b=mvVG26kRsmh5kv11u/do3vEh39S4wZTbvLSkYd0WH3V+zoVG32o5kQGHF+2Hjlmgip
         3wfCGF54tiQYHqseo+Cpue9RM2DifVXB8bxeMb4jox6oQ8JL6bYm4pF9YaQrKV4qC2iV
         RVG1ckbNFhI1ApT3BoMfO7ISY7A9m8X0HkDKSkGQy9yZgPmahZqZYn7BNTh85qD7YPxt
         lMusHeG6VcTBl87AtlupYCCAiBV3JGf5g3VR3lQNafF8oln9ew30LoCjgjjTD7qopA4o
         xXe4XoViI8zUmmzhcxJbVQpHL1vo2l0IUsdSfFaxtwgiLyDR1ydoozkyHLQIegxmA2Ih
         97tg==
X-Gm-Message-State: AAQBX9cb0zNGLxJ8aD3NIXCZg179A+/ebK4Nxo4OEg/DocKiQ0o62A5v
        48CgLz8PgjWr5u38D/luoRe7j/M0L00=
X-Google-Smtp-Source: AKy350Y6SEOlHkFCPWC9itRys/kTTth6Cx5cpdUd5JwKTc5t6cutcKsk4wv32TGpACgnm9ef/9QbZ1rGhmI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr2229922ybu.12.1679690375846; Fri, 24 Mar
 2023 13:39:35 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:39:34 -0700
In-Reply-To: <20230221163655.920289-7-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-7-mizhang@google.com>
Message-ID: <ZB4Khv8PLs7aDOks@google.com>
Subject: Re: [PATCH v3 06/13] KVM: selftests: x86: Add the XFD check to
 IA32_XFD in #NM handler
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 21, 2023, Mingwei Zhang wrote:
> Add an extra check to IA32_XFD to ensure the behavior is consistent with
> the AMX archtecture. In addition, repeat the checks across context switch
> to ensure the values of IA32_XFD and IA32_XFD_ERR are well preserved.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index ac49b14460b6..296c954dfd6d 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -218,8 +218,10 @@ void guest_nm_handler(struct ex_regs *regs)
>  	GUEST_SYNC(7);
>  	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);

These should use ==, not &.  The test explicitly writes MSR_IA32_XFD, i.e. if
there are extra bits set then something is buggy.
