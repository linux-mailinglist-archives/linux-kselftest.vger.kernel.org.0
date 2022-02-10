Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BB4B14D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiBJSCB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:02:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245473AbiBJSCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:02:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E5109E
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:02:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c188so8335782iof.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YepB74YlwePIkAaR4jtJTCENwnjxuVeuYeoAzgmVff4=;
        b=bXMJH/qYLpSGVC+53Dxuy73NFXsj3RTkKnyj0yhH2RrVLo0bm5WgGOa67Qrf9N+Siw
         s7PWaw8C1karEO3Pz9b6Ti5PK/1HjVIZ//eqWs8JWlJ/DJByvN23Ycp2EG4vUz7o8jYr
         JmkKYdMJNUozDO9Z/c9yNb5b1NVKBhWVatPxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YepB74YlwePIkAaR4jtJTCENwnjxuVeuYeoAzgmVff4=;
        b=hmpkAj6WZ+nBac3v+znFZA7sxwdmOwbjr6p0yyzPAWDeNu8QUHPabNsktMf0sJx5Ie
         rsO0n01mveOoHIQm5HPbzySmQ4Zyno8Yz+1qpe26JStNhzVWa99cd+26LDcTEqkqJuqT
         W7M0X8Bq0ZrqyzeIsLfc7K7+XRN5EYvz2127NXT+fWCnwpsjOEcjwFBJq6mQ80me33fW
         K8h9RruiLFLFZpoqUc6B9iMRXZDLPSgof1r3qqiGBRQxdPayGDPwe0Ev8OXZ/yaz5Zum
         BL0w3n1VIUc1NupBQ2olSxs2vlf0yNH8hbP5V3J5GLWdrDLdz6ujkcY/FqsnekFRanr+
         vM+Q==
X-Gm-Message-State: AOAM5311nA39Q10X0MaIYqNLVR6ATZtw15y1yHxHxyC+wlalOBvX2Dxf
        SpwHKTvNhYkcJ15zl0VCyZoB0g==
X-Google-Smtp-Source: ABdhPJwEuUFKMBsXzMtvsJ6U3tEwNExOh8IkrPx4WikpPszvu5J46DYU+pTWMhwP4AnfJ2XywHgyWw==
X-Received: by 2002:a05:6638:2050:: with SMTP id t16mr4618952jaj.144.1644516121336;
        Thu, 10 Feb 2022 10:02:01 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p16sm8482826ilm.85.2022.02.10.10.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:02:01 -0800 (PST)
Subject: Re: [PATCH V2] selftests: kvm: Remove absent target file
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210172352.1317554-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9893f6a-b68b-e759-54f5-eef73e8a9eef@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 11:02:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210172352.1317554-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 10:23 AM, Muhammad Usama Anjum wrote:
> There is no vmx_pi_mmio_test file. Remove it to get rid of error while
> creation of selftest archive:
> 
> rsync: [sender] link_stat "/kselftest/kvm/x86_64/vmx_pi_mmio_test" failed: No such file or directory (2)
> rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]
> 
> Fixes: 6a58150859fd ("selftest: KVM: Add intra host migration tests")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
> Edited the subject line
> ---
>   tools/testing/selftests/kvm/Makefile | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index d61286208e242..b970397f725c7 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -82,7 +82,6 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
>   TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
> -TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
>   TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
>   TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>   TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
> 

I am fine with the change itself. For this patch:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

However, are we missing a vmx_pi_mmio_test and that test needs to be added.

Just in case the test didn't make it into the 6a58150859fd and the intent
was to add it - hence the Makefile addition? This can be addressed in
another patch. Just want to make sure we aren't missing a test.

Peter Gonda can confirm perhaps?

thanks,
-- Shuah
