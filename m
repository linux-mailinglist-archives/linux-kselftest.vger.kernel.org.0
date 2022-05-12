Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B552541C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiELRvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357332AbiELRvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:51:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC01C121
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:50:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z26so6174893iot.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dY1IAHPX3orLKxhoM3AAhhrVw5eY9f1RMzZRsDjtfNY=;
        b=ErRS5OUJQ/C/vnqdC79lB42yI67+v0Xc6J+TbM9l4ENEPLivTv7C3YS/w2wHJoXiU5
         cUrI1o4sOMTFAsTuIOt5xh4X5UUXgfMTZ/HE9zDF9wUzYKeaTrYWJnP+6KTJjrejByv0
         Fcc1vAwixzCr6CkZ17cn5DjgUbZQTNp5NbJFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dY1IAHPX3orLKxhoM3AAhhrVw5eY9f1RMzZRsDjtfNY=;
        b=Up6Q/Nus5WsGUHOdZ3zCddm4re7bWEtaKfLzidQvrsKSDvsoUioK/emaNmsyebYBOj
         RhbNGuSYgFySLjVamezyERVCH+bPsPwRP9MVuneDQV4Kcs0MynwqNBA2+3AWg/rbrDc9
         /wv+4MlBoOHsdM0tp+DlgH2OtdQPn5gcmfjEcGZsXys4ic8Pn0oKKZB2dRH79EDhj94c
         zpGkvHy6XOY6axjAqRgIs69EMARxPYYhs0NIO7BfCXwAeSjIRo4H4Zm0WAqg079soVsq
         UMHzbOcU40KmZPs/ntIDl7AUSSkB3v5B9d/4i/LXx1En6eRMq9h7NUdigvqauOrSBh+1
         jYWw==
X-Gm-Message-State: AOAM533/LKrRmHparARiaHdjvS9ISOQ+VnWLAKwmlyQ4/YPJr/5T3Vqt
        WZe17G25rmYUEIK7sQwAf3BF1A==
X-Google-Smtp-Source: ABdhPJwEoXRvKQIN8vE2739qPEYGWAEmkTG5rQoLxtgYV8mD8Q1+9IvS2Cc/+n2TVfVyCI58o8abIw==
X-Received: by 2002:a05:6602:54:b0:65b:15c3:5bb7 with SMTP id z20-20020a056602005400b0065b15c35bb7mr550921ioz.135.1652377858326;
        Thu, 12 May 2022 10:50:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b1-20020a02c981000000b0032b66cb59bfsm31276jap.179.2022.05.12.10.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:50:57 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 6/8] selftests: kvm: Add KVM_HC_MAP_GPA_RANGE
 hypercall test
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
 <20220511000811.384766-7-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81c56e24-af33-bbc5-662e-2478699dcc81@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:50:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-7-vannapurve@google.com>
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
> Add test to exercise explicit memory conversion path using
> KVM_HC_MAP_GPA_RANGE hypercall.
> 

Add details on what this test does and sample output. patch 7/8
in this series is a good example of what I am looking for.

> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---

Please see comments about coding style related comments on other
patches in this series.

thanks,
-- Shuah
