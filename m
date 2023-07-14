Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB97541C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjGNRuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjGNRuY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:50:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A944A0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 10:49:45 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e9e14a558f8ab-345d2b936c2so2205155ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689356932; x=1689961732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rBx0jgvBlGgKUiBYRxrHdUfhzMCZMJXxzQSfT+z5ms=;
        b=MHz80M9SgMNaL2mxUsBeYvMr1KU+SpwPbkNiRcXbvsoW7AXU+RPtUAFrDRU27IdiiK
         guFAnLt6DLsbfh7ZN1fwe6TPRzTheYIsz5e9bIrTSoOwfzP7jQ2yYns5GnkWIJ8rPC6K
         jMxkKn+OHq9A+Jo+ljpRbw4i7dc+ebiQ7+SAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356932; x=1689961732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rBx0jgvBlGgKUiBYRxrHdUfhzMCZMJXxzQSfT+z5ms=;
        b=fzLuFM0OA9rzE/1Ovu2MJCY1qfXc2Kyh7KUeRfcebkTD66N30gnvjMxaBOeEmbxiVs
         hVpiW67KkvbyQN5k21wgt6lKzB7x/TgbZFft8ILb0zrBK4n1F5sGixjrnjGFWbSzKw9y
         tTEv0lRJD3bCqfYJC06BebVOHIHsstAXbvOESsUsXuOMLsvfaJ0mPbeIj/z+DvYH4CQs
         zK+mBi+f7ZfB65PAQmcp+eBvexHNJgNdC9B2cALsMevoAEmkDT4uW55UWkUNo+yCcJZW
         T2243jWzGpiBYYzyOBYmjayogAtvDLQJ1PuxXjAXO1Mqj12GJc10dfbeu0xONEf7cX8Y
         GLjg==
X-Gm-Message-State: ABy/qLbNdeiJ59X6JBnltiujRQpwXEklq7KA7vqSrpoUyfbVonmgAjb/
        psHvGQPEIR6y91VOXnsdYM/Jrg==
X-Google-Smtp-Source: APBJJlHbjF5lNN7hgaRIpxd1YDd+wHZqjs5SsXAm5p/LhvZt+LPZnpbvjIv7pPMON+8CDgWkr3CAaw==
X-Received: by 2002:a05:6602:2bd7:b0:783:6e76:6bc7 with SMTP id s23-20020a0566022bd700b007836e766bc7mr4382470iov.2.1689356932715;
        Fri, 14 Jul 2023 10:48:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m17-20020a02cdd1000000b0042bc199556dsm2813883jap.21.2023.07.14.10.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:48:52 -0700 (PDT)
Message-ID: <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
Date:   Fri, 14 Jul 2023 11:48:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/13/23 14:16, John Hubbard wrote:
> On 7/13/23 13:02, Shuah Khan wrote:
>> On 7/10/23 08:04, Mark Brown wrote:
> ...
>>> -kernel_header_files:
>>> -    @ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
>>> -    if [ $$? -ne 0 ]; then                                                 \
>>> -            RED='\033[1;31m';                                                  \
>>> -            NOCOLOR='\033[0m';                                                 \
>>> -            echo;                                                              \
>>> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
>>> -            echo "Please run this and try again:";                             \
>>> -            echo;                                                              \
>>> -            echo "    cd $(top_srcdir)";                                       \
>>> -            echo "    make headers";                                           \
>>> -            echo;                                                              \
>>> -        exit 1; \
>>> -    fi
>>> -
>>> -.PHONY: kernel_header_files
>>> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>>>   define RUN_TESTS
>>>       BASE_DIR="$(selfdir)";            \
>>>
>>> ---
>>> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
>>> change-id: 20230710-kselftest-fix-arm64-c023160018d7
>>>
>>> Best regards,
>>
>> Thank you. Will apply the patch for the next rc
>>
>> thanks,
>> -- Shuah
> 
> Hi Shuah,
> 
> Actually, I was hoping that my two fixes [1], [2] could be used, instead
> of reverting the feature.
> 
> 
> [1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
> 
> [2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/
> 
> 

Thanks - I will go do that now.

Mark! Are you good with taking these two - do these fix the
problems you are seeing?

thanks,
-- Shuah

