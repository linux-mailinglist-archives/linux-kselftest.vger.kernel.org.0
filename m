Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165A525391
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355464AbiELR3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356870AbiELR3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:29:12 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227B26BC86
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:29:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f2so6122636ioh.7
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDtS3yYiac007Tq16HyIgANNZvP5Mc1ckKft1G2x8rg=;
        b=EPpUcNHxPhcz5hSlEDa9z2K9TJYgjabImG/SE7YzphxDkTSDjkI1Pf5lkLWuydHVej
         wsSCiVndDr8Plm/gSezwdepsxOasS14AAI9UWHmmtS5jOLIAloeKoY7kRmZ9xSSbIcpS
         8JwVd6YQV++q6V1FMWiX/WVZApJueKMCvqceI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDtS3yYiac007Tq16HyIgANNZvP5Mc1ckKft1G2x8rg=;
        b=G7N1sDmHV4YuxJ/6LEYDKAu10ic3zLq6QkVwZRutM57aVSNhr6/ons6UycUQAdMDqH
         KLUOz0ZfFfLkcTnJJ2aFhtiK91pW82a9zOGJFbO4aJKe8qLopT5LVJv8yW2+bGiitdGB
         G82S1SIF91cNOTIJXwSxJfaTbYq+oNlECrn8x4bkEtaS4UvKkrbe0dFQyXQ9bFaJ5nWR
         pDDI07OlyKGCNXAlCW62QFz2D7koeDqdmEX7mVAlRmXPRTr5bdt+XKy4x4OikoNHnbFe
         h8ZI2tdTJ6d6knj8VIbuVvfIQXKc/hm3hk0HMh9mI7K9aS0uuydsYdGGwxl8JYuZfrf+
         iC5A==
X-Gm-Message-State: AOAM530KruvDexOYcZfiL7pxlAnTk105x2lZo7CoVOnYbEXN5MQCRlWt
        US0LBM28+SK2zSM1lnG21U/pZg==
X-Google-Smtp-Source: ABdhPJzNqYZrxIKI/q6d8RU/W/ess9UcRpvgdtRDWknB3E49FiDZ0BiBVcE5y2GGk30KSYjHpi61zw==
X-Received: by 2002:a05:6638:d01:b0:32b:b9f8:38c4 with SMTP id q1-20020a0566380d0100b0032bb9f838c4mr578797jaj.236.1652376550541;
        Thu, 12 May 2022 10:29:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p14-20020a056e0206ce00b002cde6e352ebsm7245ils.53.2022.05.12.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:29:10 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 2/8] selftests: kvm: Add a basic selftest to test
 private memory
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-3-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7245d147-6e0e-8df2-be8e-549b3216e576@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:29:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-3-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> Add KVM selftest to access private memory privately
> from the guest to test that memory updates from guest
> and userspace vmm don't affect each other.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   tools/testing/selftests/kvm/priv_memfd_test.c | 283 ++++++++++++++++++
>   2 files changed, 284 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/priv_memfd_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 21c2dbd21a81..f2f9a8546c66 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -97,6 +97,7 @@ TEST_GEN_PROGS_x86_64 += max_guest_memory_test
>   TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>   TEST_GEN_PROGS_x86_64 += memslot_perf_test
>   TEST_GEN_PROGS_x86_64 += rseq_test
> +TEST_GEN_PROGS_x86_64 += priv_memfd_test

Add this new exexcutable to .gitignore - Also make sure if there any
error paths that should return skip and not fail in case of unmet
dependencies.

Looks good otherwise.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
