Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC5670C12
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAQWtb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjAQWrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:47:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5720B4E09
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:48:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id r21so2836287plg.13
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWE1pBRG4fQ1NY4iQchgCsAlYp+fjyZRHYiBxqI6Ppc=;
        b=Ytivk0p3o3pKPR4jxRDApSW/X8kWJmOSU/vDUt9s1/F/HroGSdex4UY8cLNEMmie/M
         SJHUrBNsemSTxj4PVT9ABl9rcmXciGL4VBfmkFcaTCLOmPzzeYKcSeCXZ4cAwgHiJimv
         P5A/+mzpvc7I5IwbDpnNQroG3uEIK3/5pYOCtujUe/zOU4LXQdqgLIq9FP3Q8YhyADsX
         +uLJ+IaHx9dxXMM7FC0nBUojSzt7FpQ0Vjr0BfWkXXwaMP20MrlXhoZvPgDK2Rf+cKY0
         NsT2rt/S1e8PyBz8noED+BbjaMjl8Ndsq0XEF5oRKatjF9vLXme/E0dv/4FPKaUF6x7G
         mc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWE1pBRG4fQ1NY4iQchgCsAlYp+fjyZRHYiBxqI6Ppc=;
        b=oHMLJrX0oa5PLcmdG/85asc2/TXw93j4ufcMG0hX6K2w0d5Ud+YtQ0czhxiS6zUGb3
         gYeZ6sqGVNCKV4JG6c66ImlTXUmRyH5set+hNtbNYSi6PI9Ykw6WYaMMYL/QfhaADdBu
         gdJpNlbaW3FfXUDykZIENldEDcitGS1xLvjB6Tsg3WnPnN04FGNU5zn1SPa/vTW63Fq3
         TO8lIaLB/ZKzXNHTTk8mzcURh/1p9/ZU5iZk6rVGdAlPGcBJe1Wjm0z/+BGmNtHf/Zzy
         xLQzWns0qkqIuHxT9z6mxVLhnjcmswqa8eJiYttuNPHrLMY+J6EssmwR8SjirgJBeNZF
         CMRA==
X-Gm-Message-State: AFqh2kq+oc2mg9Opyqi0/T8IazUmanBtPYCJaw89gUgVMBfwc2e3VoOE
        PPzW2EHztE49lQHEo2IB32TTpQ==
X-Google-Smtp-Source: AMrXdXvPkZgs3rtHgy0SGs5XB8Ijo6KKK7MXq+jTg0acICkNfD3dp3J3EcjMZ9hdAQ+KOHkyvoqjTw==
X-Received: by 2002:a17:90b:3941:b0:225:e761:6d2b with SMTP id oe1-20020a17090b394100b00225e7616d2bmr2761268pjb.1.1673992129057;
        Tue, 17 Jan 2023 13:48:49 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nk16-20020a17090b195000b00212e5068e17sm11884pjb.40.2023.01.17.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:48:48 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:48:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V2 PATCH 3/6] KVM: selftests: x86: Add
 IS_ALIGNED/IS_PAGE_ALIGNED helpers
Message-ID: <Y8cXvS2gKcK8tU2D@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-4-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-4-vannapurve@google.com>
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

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> Add IS_ALIGNED/IS_PAGE_ALIGNED helpers for selftests.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h    | 3 +++
>  tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 4ad99f295f2a..7ba32471df50 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -170,6 +170,9 @@ extern enum vm_guest_mode vm_mode_default;
>  #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
>  #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
>  
> +/* @a is a power of 2 value */
> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)

IS_ALIGNED() is provided by tools/include/linux/bitmap.h

>  struct vm_guest_mode_params {
>  	unsigned int pa_bits;
>  	unsigned int va_bits;
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 5d310abe6c3f..4d5dd9a467e1 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -279,6 +279,7 @@ static inline unsigned int x86_model(unsigned int eax)
>  #define PAGE_SHIFT		12
>  #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
>  #define PAGE_MASK		(~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
> +#define IS_PAGE_ALIGNED(x)	IS_ALIGNED(x, PAGE_SIZE)

I certainly don't object to adding IS_PAGE_ALIGNED(), but it's not needed for
this series.  Verifying that KVM doesn't allow an unaligned page conversion during
KVM_HC_MAP_GPA_RANGE belongs in a separate test+series, as that doesn't have a
strict dependency on UPM.

TL;DR: this patch can be dropped, for now at least.

>  #define HUGEPAGE_SHIFT(x)	(PAGE_SHIFT + (((x) - 1) * 9))
>  #define HUGEPAGE_SIZE(x)	(1UL << HUGEPAGE_SHIFT(x))
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
