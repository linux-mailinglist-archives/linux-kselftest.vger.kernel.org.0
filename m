Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730DE5E6B30
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIVSp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIVSpZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 14:45:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD32D01DE
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 11:45:24 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y15so5374692ilq.4
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Sckvs0FTvGyjC/ju9lFywFrSTF78gTiQEzpAFikyqII=;
        b=grnT8CgZ1gQuEDOPJTlzBomCgI4eVGDOtVSRW4oxEgOy/f2NoelS/Ta7NvlEk6LbRX
         gzhUDV71pkz1woX43jN0dWObCEw9lU8dWhiRfx15iMSrLhUu5GH4dwwtQCLgugTvX1z2
         8AU9g2XA10kmW48eSrBKewQqFDDowhwFDMlFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Sckvs0FTvGyjC/ju9lFywFrSTF78gTiQEzpAFikyqII=;
        b=P5We9HnB2/1TRb/d9kl74Hh6e4Uruya20btkkKu8ezctTrVIuJ74b0c1KF2B+O4aep
         dj+PWNlwKV9XkR/OfxaauvOt2nXS7k7KHqUyTVjfntkN4wCi68kuW1hH79+z4a7UbtRT
         17sUpPgKTZSJy+O/u2oL1kaFE9w4wlJPD9A8vyOErPAcnj1x/t+G4hhVAXJ+EQkRd+WY
         ZBRdz8YjAFOKCxeTLPMOTGGOrZoGj1IBrvv9G6noYip8rOHOd3YumfosJ5ykHcmV3Nel
         jMOepNcmtt8TN3j2RCZUAmktIICXxdEQIzSWG6ZJ4/2SjmGjgiIsUoaHWKuGk4MWO8wf
         Fjug==
X-Gm-Message-State: ACrzQf1n8/9j3VtrqwvE74Hi34td3jUP+AVZ4zhtDiOIxMWTbCabaYR9
        RDE96lamjOH8XKKniQ1rI+5d5w==
X-Google-Smtp-Source: AMsMyM4NsHBKiHG3MQq+rQeymQb3KkMESDFz+18LaQ6uVvnQyA4knTwpE59RihAuxGRr3IGvxsamFw==
X-Received: by 2002:a05:6e02:b45:b0:2f5:9ee6:4ff4 with SMTP id f5-20020a056e020b4500b002f59ee64ff4mr2467698ilu.101.1663872323713;
        Thu, 22 Sep 2022 11:45:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c3-20020a0566022d0300b006849ee78e1bsm2619529iow.34.2022.09.22.11.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:45:23 -0700 (PDT)
Message-ID: <b9044b55-1498-3309-4db5-70ca2c20b3f7@linuxfoundation.org>
Date:   Thu, 22 Sep 2022 12:45:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] KVM: selftests: remove redundant variable
 tsc_val
Content-Language: en-US
To:     cgel.zte@gmail.com, pbonzini@redhat.com, shuah@kernel.org,
        seanjc@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dmatlack@google.com, jmattson@google.com, peterx@redhat.com,
        oupton@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/31/22 08:31, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value directly from expression instead of
> getting value from redundant variable tsc_val.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>   tools/testing/selftests/kvm/include/x86_64/processor.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 0cbc71b7af50..75920678f34d 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -237,7 +237,6 @@ static inline uint64_t get_desc64_base(const struct desc64 *desc)
>   static inline uint64_t rdtsc(void)
>   {
>   	uint32_t eax, edx;
> -	uint64_t tsc_val;
>   	/*
>   	 * The lfence is to wait (on Intel CPUs) until all previous
>   	 * instructions have been executed. If software requires RDTSC to be
> @@ -245,8 +244,8 @@ static inline uint64_t rdtsc(void)
>   	 * execute LFENCE immediately after RDTSC
>   	 */
>   	__asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
> -	tsc_val = ((uint64_t)edx) << 32 | eax;
> -	return tsc_val;
> +
> +	return ((uint64_t)edx) << 32 | eax;
>   }
>   
>   static inline uint64_t rdtscp(uint32_t *aux)

My understanding is that this patch isn't coming from individuals that work
for ZTE. We won't be able to accept these patches. Refer to the following
for reasons why we can't accept these patches.

https://patchwork.kernel.org/project/linux-kselftest/patch/20220920063202.215088-1-ye.xingchen@zte.com.cn/

thanks,
-- Shuah
