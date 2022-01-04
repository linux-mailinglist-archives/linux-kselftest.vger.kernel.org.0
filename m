Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582E484902
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiADTyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiADTyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 14:54:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA7C061785
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jan 2022 11:54:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t19so33114302pfg.9
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jan 2022 11:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cdmT5rfhNkWWjGcnFD7NuwPzzDkVYzXEr/P8sZKTqps=;
        b=C129iTBGi8h6CtSob4CAxpAQiIkOcQ2FLgoMbKSA9DIAafCrkRlwq+5Qfsn/GP1s+B
         xikZmG/3k+WSgN+5ZaLdmvqeTzfwgj8TplXAilI8TNQDeSi/tNPUjlGPn4NSfy1UxENO
         i//ZI+GivXS5RUK7yDPzkN3qRs0Ym+9smT3g1qsuN95Ea87FjdxwDGuODadrif1G+SpH
         4LKSBfFbXxaABx9uP3nsoBW97Tvvsz/RNEV3kGvBaSrnZf0bIAwYvNoStL07EcIsnfIX
         XxcMb0PUauPFMPljnZKY+wTE66PWFaw3LHM5P7i9/xxcVK6NHuuuW91h4vh9Tqwde1gu
         AFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdmT5rfhNkWWjGcnFD7NuwPzzDkVYzXEr/P8sZKTqps=;
        b=liYcJsMhB6ArGBC73pJqrYrH7mOHqW9tXn3Dmfs3oBbG9s0oqJxplRen+Z7YdvF+/m
         oKMParwHsHtBtOGm1oYQL5mfuUFAuujDKXZsKvo2LoUGcGRls2iCZcsoKh6et/x6v0Km
         VO2M2nSy13K5PRkwgSXbJ8/gxqV6W4xbcYW/YqHbU42JQ1gdgdbTD/FdIugs6xAjDK1L
         GHO7Ukqxr32kWVtKndLP/y1KUEJVf8FpocdESHwaW2VvrZ0/ufX5nrK7XC9cRpOkogB4
         zY3X7Ye+NzH5YuJ6mpoCE255R7dPIy/QpbNV9l6+U7jD6WEnHMzAiv6dhXBPGPUSBLat
         d/GA==
X-Gm-Message-State: AOAM530234UzrcKKQ4dFUbhrUF4cjaAIFntBInxa5HKS+cavdIOllzJf
        4abu0JaNo3Exr3nu5XeeOD78Fg==
X-Google-Smtp-Source: ABdhPJwbHVoGQWJnx4oFw2JlmF2TRIpvegfLjVIjVehkyjeU2NKQZtaHKzgL82XoXSOhYW8/Eew9aA==
X-Received: by 2002:a63:207:: with SMTP id 7mr45574965pgc.624.1641326054197;
        Tue, 04 Jan 2022 11:54:14 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p37sm40318945pfh.97.2022.01.04.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:54:13 -0800 (PST)
Date:   Tue, 4 Jan 2022 19:54:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v4 03/21] kvm: x86: Fix xstate_required_size() to follow
 XSTATE alignment rule
Message-ID: <YdSl4s78kj/U/5Bl@google.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-4-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229131328.12283-4-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 29, 2021, Yang Zhong wrote:
> From: Jing Liu <jing2.liu@intel.com>
> 
> CPUID.0xD.1.EBX enumerates the size of the XSAVE area (in compacted
> format) required by XSAVES. If CPUID.0xD.i.ECX[1] is set for a state
> component (i), this state component should be located on the next
> 64-bytes boundary following the preceding state component in the
> compacted layout.
> 
> Fix xstate_required_size() to follow the alignment rule. AMX is the
> first state component with 64-bytes alignment to catch this bug.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 07e9215e911d..148003e26cbb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -42,7 +42,8 @@ static u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  		if (xstate_bv & 0x1) {
>  		        u32 eax, ebx, ecx, edx, offset;
>  		        cpuid_count(0xD, feature_bit, &eax, &ebx, &ecx, &edx);
> -			offset = compacted ? ret : ebx;
> +			/* ECX[1]: 64B alignment in compacted form */
> +			offset = compacted ? ((ecx & 0x2) ? ALIGN(ret, 64) : ret) : ebx;

That is impressively difficult to read.

			if (compacted)
				offset = (ecx & 0x2) ? ALIGN(ret, 64) : ret;
			else
				offset = ebx;

>  			ret = max(ret, offset + eax);
>  		}
>  
