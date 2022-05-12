Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB252546B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357259AbiELSEZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357460AbiELSEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:04:23 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD1D26865A
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:04:22 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7599822fac.7
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDvciQFODhdDBATVVOib/Gmk+OU/HVoyX0M9V8aGmGU=;
        b=OhoyWF65mi0OD1ZrwD8K8tghppxQ4nj2MSuR5Is/a/fBxZfTq1JIIHFG0ErtJrVzDY
         Lfte8BPrMs3i/p5Ri02BkwX7KGT4cInuluoAqkOJoKXCQhGZrs0U05Iaco9ILhvaGzwK
         a8EKtmSy9vcAVrmbRbkcd+YW3pSO4sJwTbeVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDvciQFODhdDBATVVOib/Gmk+OU/HVoyX0M9V8aGmGU=;
        b=LMgYgA1vP6DZQOBucqWrRsYfejxjjpRZGPY4s2yP02W7JsBQ7Eo7CZBmzRdpf/eORl
         u9LGNUfiwywv8r0Aig8XsapJR0ClBkFZuCwPapNELWjBA3OFVJqofcUQRoffdLu3NaQS
         Dhk11xTh/vBXnDOuFWdNb8REEReUBQb6o3PsxYqZllxMRjroOwSdwtwwnSAFoOW0Ir+I
         vSF0xvYHDBSFX5yQ1DY2cb4fv7bBITtZlIZ8zDfQCrY4L7V8/WULowM2RLk9+VN11Dae
         aRnfjzfNfvKpN72D958ls5EVUxCfFtFDGiocDQ+hv23dOBpyUJYpyg5fUnsnNbpgE7oG
         mxjA==
X-Gm-Message-State: AOAM533MCB3qd37HsBkNntfA1X1ZAl3T/2iM6Q6yOhb//WHaHm/j2cMs
        OUIXvKXVFt6amDpXzUoETqwVLQ==
X-Google-Smtp-Source: ABdhPJzIgybtu7P78NikEpr7S0+QoB5xWkWXzrunFCazvRkHmyFG0lM9FsiggE8wyigSv4bUgRm6Lw==
X-Received: by 2002:a05:6870:1791:b0:e2:f75b:b15f with SMTP id r17-20020a056870179100b000e2f75bb15fmr592903oae.106.1652378661796;
        Thu, 12 May 2022 11:04:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l93-20020a9d1b66000000b00606aa21608esm149238otl.17.2022.05.12.11.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 11:04:21 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 0/8] selftests: KVM: selftests for fd-based
 approach of supporting private memory
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <20220511000811.384766-1-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4a84dfe-2397-0881-b6bd-1cb2b2d5904e@linuxfoundation.org>
Date:   Thu, 12 May 2022 12:04:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
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
> This v2 series implements selftests targeting the feature floated by Chao
> via:
> https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> 
> Below changes aim to test the fd based approach for guest private memory
> in context of normal (non-confidential) VMs executing on non-confidential
> platforms.
> 
> priv_memfd_test.c file adds a suite of selftests to access private memory
> from the guest via private/shared accesses and checking if the contents
> can be leaked to/accessed by vmm via shared memory view.
> 
> Updates in V2:
> 1) Tests are added to exercise implicit/explicit memory conversion paths.
> 2) Test is added to exercise UPM feature without double memory allocation.
> 

+ shuah <shuah@kernel.org>

Adding  my correct kernel.org address. Please make sure to run
get_maintainers.pl to get the right addresses for miantianers.

thanks,
-- Shuah
