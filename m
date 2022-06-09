Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B005254577E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiFIWfc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiFIWfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 18:35:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B917EF4D
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 15:35:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p69so4846123iod.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CcL5tEAWOxSvJSLnHbD83lzNvUtbyPMt74PxSGG42AU=;
        b=e8nJ/xSrlk9ZVd2GH70OVAgaO7AXDH8rWboLH1I8arvcsGm5WyDMbvg27LL9IdsQHO
         GTj3V3iGPunTzCNidLU1NwSH9BjAJaSoiGP1aUYMHYjFw1oPRAY7zyZ9eexdVRKTjxFO
         YWt+k9YRvJerzn9V5t0Vuaz+xadLTbFh2icxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CcL5tEAWOxSvJSLnHbD83lzNvUtbyPMt74PxSGG42AU=;
        b=rjiBXMZJJrm9ikcqluGlr5llt/LTpRao5ZW9ZflTHGBjpPVu3gRnE7GdaZyEXB3xWX
         +HpNdITfOoe1VuGfKFC/ZL8RrPy4BMuyFxaV9cPkp/WFtsvHave21PRT+r2GU67KDRtm
         uLfqSjWzj/+BfjYTD4XDQOlrVztROWv6zEkk15JykMjbvEjvX3xwQZU/cvmfHTQl9HE1
         fHHSfETk+R8ovbQXBoS4k2387DGhCVymY2r2k6BAC28v4n3kXlUZ7wh+x7mtYx2bZpSM
         biZTn3AfpPHoKqfOnquW2NwUvJK7kaOhXzXgdaICVuAsDACfCnl8gCaIutFynmoFsjBZ
         Nkww==
X-Gm-Message-State: AOAM532ZTjubfTHXzRcoSBD2SK9NvnymJIJVn69YxQF+AFMYayT6RtPh
        RTcuuAnoAyiYswy5n2EN3uENhA==
X-Google-Smtp-Source: ABdhPJwRNw8iyCoQpvWrt1nEIawYeoUMwRRuKns/70qYes3qMOSwq0EW8RvDrYACOZo00kr4uy094w==
X-Received: by 2002:a6b:fa0a:0:b0:668:dfb1:3a68 with SMTP id p10-20020a6bfa0a000000b00668dfb13a68mr18641576ioh.193.1654814130119;
        Thu, 09 Jun 2022 15:35:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m8-20020a927108000000b002d3c93ef865sm10872992ilc.69.2022.06.09.15.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 15:35:29 -0700 (PDT)
Subject: Re: [PATCH] testing: kselftest_harness: add filtering and enumerating
 tests
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609202458.1715942-1-kuba@kernel.org>
 <a360b5e0-4b56-6d90-4060-6760934f7dd8@linuxfoundation.org>
 <20220609143607.2aec9bb8@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e57e0ac4-ed14-4e8b-be18-e8ebff0f0573@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 16:35:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220609143607.2aec9bb8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/22 3:36 PM, Jakub Kicinski wrote:
> On Thu, 9 Jun 2022 14:59:18 -0600 Shuah Khan wrote:
>> Change this to use getopt() to simplify argument parsing and make
>> it easier to maintain.
> 
> Sure thing! Do the options themselves make sense? I wasn't sure if
> there are some restrictions or standards since the output is TAP
> compatible, AFAIU. Or maybe someone has better ideas.
> 

As for options - please see below:

>>    Usage: ./tools/testing/selftests/net/tls [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]
>>     -h       print help
>>     -l       list all tests
>>
>>     -t name  include test
>>     -T name  exclude test

Can be simplified to not include test name by default - drop -T

>>     -v name  include variant
>>     -V name  exclude variant

Same here - drop -V

>>     -f name  include fixture
>>     -F name  exclude fixture

Same here - drop -F
>>     -r name  run specified test
>>

Other choices look fine to me.

thanks,
-- Shuah
