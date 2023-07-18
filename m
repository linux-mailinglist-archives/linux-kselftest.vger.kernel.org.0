Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716FC758038
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjGRO4J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGRO4F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 10:56:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE6E0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 07:56:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so64212539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689692163; x=1690296963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeHT0zydz+0w5I8HKlizsWfWr7LYvvd7fgi2ymHMZI8=;
        b=J70rq8D+w1tLfc+0W5pJfo3meh52rl5Rs0QFgKESlAc47YUZYVWAgf1I4+HKcsRtJB
         FLnS2AptqfDQhI4DupNlLoETiR1d5yyKkAFfr3gfV8O7lmmUoAiuzYFlAQYTg98Ju+qf
         Y5qO/1KdeLhwD6h8lCb8KRvE1lxbvOG4xlE/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692163; x=1690296963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeHT0zydz+0w5I8HKlizsWfWr7LYvvd7fgi2ymHMZI8=;
        b=Gg5Mx8MrAtZWYZN6Jvc6zv8/aQ9HbH4Ayr19zGY9HcfuF80s6PK+u+NNIchxBKKxf6
         6eCzsJn45wRBUdOt8oZRFhdg1uRBuXOZe/TLt5gy6D93iUFDqpaZTXvP24zQNEPkWlPA
         uCZgbnHT1QfAD7iL6BBww3ugOfqiHuoRH6q8Gv+Rtihf+RLX2rU1EAUe97hp8QOFlCbX
         FnK8hjzEPZ4i+tlAtcYPhhSzNS89nNVEHXZqM2653VWf2iIh7CX5fKlVIiarLt7jukHu
         NhDEA1qP/NrRh8v9JQMbmw4YnY4kw9CWvHRACvpmVrnH8aCo9CGuEUKTZI7YpKwZ4JMO
         aiWA==
X-Gm-Message-State: ABy/qLaI7Od7ZPM20UFuYc+9a+d+C9uHLiqSnMNEcTwg5wBdui9rGMAe
        lvBV8Csovcdo36s2qaAWdHNoAg==
X-Google-Smtp-Source: APBJJlE6M96ra9gMUGegHCOM8kskOLL5xWPIi3X5Rc4jOWW3jiblfvSJopoPWcaI6n8RvCQjduj+mg==
X-Received: by 2002:a05:6e02:219b:b0:345:a3d0:f0d4 with SMTP id j27-20020a056e02219b00b00345a3d0f0d4mr3059419ila.3.1689692163683;
        Tue, 18 Jul 2023 07:56:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t6-20020a92c906000000b00345d3f2bb6asm728099ilp.56.2023.07.18.07.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:56:03 -0700 (PDT)
Message-ID: <d8c8d82d-059c-fa98-09de-9eda61370f7e@linuxfoundation.org>
Date:   Tue, 18 Jul 2023 08:56:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
To:     Mark Brown <broonie@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
 <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
 <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
 <85526b4e-c2ba-4b19-9c2f-ba39a248a713@sirena.org.uk>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <85526b4e-c2ba-4b19-9c2f-ba39a248a713@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/18/23 08:54, Mark Brown wrote:
> On Fri, Jul 14, 2023 at 01:11:10PM -0600, Shuah Khan wrote:
>> On 7/14/23 12:36, John Hubbard wrote:
> 
>>> Just to be clear, when you say you're applying "both", I'm hoping you mean
>>> both of these:
> 
>>> [1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
>>> [2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/
> 
>> Right. The ones you have links to:
> 
>> Please check the latest fixes to see if we are all squared away:
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes
> 
> These didn't seem to make it to -rc2 - it'd be *really* good to get them
> for -rc3, not having the selftests there would be very disruptive to the
> standard arm64 workflow.

Just about to send the pull request for rc3

thanks,
-- Shuah
