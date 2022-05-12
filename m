Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83E5253B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiELRbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357085AbiELRbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:31:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035B053B57
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:31:46 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r17so4005033iln.9
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jy6c2iz4pBZ4h+6A8F5x31O1bbz13zfB7+MvdwkltFQ=;
        b=V5E2LbmUQEz+VqDpvO+TqhyA1VCGZZb3ILk4eW9F+NnQyIENOHalX+haeb7RBvqORn
         jBh4SYWNLX6kNf7FdM/WCCwrR6Pefkq6GfBB1ON1K7lYr1k0jaN1QnNC4B3I1FZqj1Nz
         A4Uhq6rzpkVVaHd2yzKh7gJ6MjwdWl3o6sNAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jy6c2iz4pBZ4h+6A8F5x31O1bbz13zfB7+MvdwkltFQ=;
        b=hIp7jYnsrWUmsQh3GgOzEjg5d07RxooyInFtjeiyuQwhlxuHMpJs3XMMcNg7b249II
         FGtkxZ29ULFHUyIgRpcksqBXhXRcTSb91n3xAziWf4Vd+Cxc2XuiucMPuEzsZ0K0deJb
         FSFvhvWMHtHJAm/bqCBqAEpqxv1RV3KCX3mZqUCkxx+qh5sdWHQpNYZVWokGZ29VXVSl
         Uwc3FNEyx34mlDk7T8JaPZkPyYtWLd4P9OHCDYLfR/jViZqNeTHXBhbbizMdjoiEGj7g
         C/99jRchCsP/MxJcVvZExy0bxYuA4u7hFlnqSuYhDNyZUbRCj/stdjeI5gxQJ+mQxIdR
         Wgyg==
X-Gm-Message-State: AOAM530f8yU3KGZKg3Duhze4k8Z46RRR9bGmbjNCBH2mEzfUKhyclwdl
        GIM035BDvk49OGnBdFEQgbPXDg==
X-Google-Smtp-Source: ABdhPJxagzDS7W1MRsPhk0moVV2S6eg7NnFxnir3mVlj6mKNutZJdJBAswwbztf/bIkYcGF3exjiug==
X-Received: by 2002:a05:6e02:1a44:b0:2cf:d085:949a with SMTP id u4-20020a056e021a4400b002cfd085949amr571164ilv.131.1652376705348;
        Thu, 12 May 2022 10:31:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x8-20020a056638034800b0032bee2b5acasm20650jap.165.2022.05.12.10.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:31:44 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 1/8] selftests: kvm: Fix inline assembly for
 hypercall
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
 <20220511000811.384766-2-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <506a2e59-eea5-8c1e-ee1b-fbb7a401bd8d@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:31:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-2-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> Fix inline assembly for hypercall to explicitly set
> eax with hypercall number to allow the implementation
> to work even in cases where compiler would inline the
> function.
> 

Please explain what happens without this change as well.

> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>   tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 9f000dfb5594..4d88e1a553bf 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1461,7 +1461,7 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>   
>   	asm volatile("vmcall"
>   		     : "=a"(r)
> -		     : "b"(a0), "c"(a1), "d"(a2), "S"(a3));
> +		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
>   	return r;
>   }
>   
> 

With the above change to commit log:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
