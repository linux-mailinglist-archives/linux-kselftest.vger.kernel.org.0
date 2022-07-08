Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565156C0B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiGHQ13 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiGHQ0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAAD275FC
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 09:26:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v2so4100464ilo.7
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQUw4vZY4BvnSh7KPHSdmuXaETUv1lHaapC2abhfgfg=;
        b=ct3+ktVH49MCfFiJ6o81DBq3HSZbOLLwONJvqNT9yh9cpEYi4ozyEA6eXPJ3VdIOHI
         CRVA6tguzlrwAwa0dWLc6Ca9m0MqfW6RwMgo8+50nSoEOvWNO4jj7QG7g7tOdx5SIEdM
         IsE6Wpm9/oGsOekCMaKHdu7bA3aZn1+u/+Noc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQUw4vZY4BvnSh7KPHSdmuXaETUv1lHaapC2abhfgfg=;
        b=OgiagiZYdmrFdg+soS2px6iJ2+t6SDBNrwKdbvwBhmMR//mIE5Tz3nWIBslglNHGiu
         Pa4m0ukUhXBtj0ZGhQiaRkk4LxDwUkzdj1cl/Ycv4ESvtJwn5+UE4GE4p32GT+FthN5v
         0IxeI0NsspnVO0tX36jx1vYmL9TOtuHgpEY1TPCQeHrfdDZBQZZZCRVwEgj/K8bEIeAd
         vEM3ICcPI2N27nqYTPBbtclTwsWlcDhP+tv54WmUFZvo5iyqFw1WQhyl/d8+6Eqemt4w
         WSFFd4EzGNkuQDspOcKBFUOQBh6mKf2pwjwjppCe9KpMiQRE1pRAnsh2LhWpRo789dQy
         N3Hg==
X-Gm-Message-State: AJIora/8YRmGE6UgsDKJ0cszy55owPyLLR/ecPJNrIP24CUJf3kG98b9
        RuWVXbw42c5QlAUYmFN8q8Oiyw==
X-Google-Smtp-Source: AGRyM1sThFjcS5EqDvpKoJme+Hhv9hDsq21JqDJPqe2ryiWhf+tjo7cLo2LxtpV0YJW/liRhaq6hHw==
X-Received: by 2002:a05:6e02:219d:b0:2dc:41c2:a1f3 with SMTP id j29-20020a056e02219d00b002dc41c2a1f3mr2794697ila.79.1657297608686;
        Fri, 08 Jul 2022 09:26:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g6-20020a02bb86000000b0033c14d2386bsm1498295jan.75.2022.07.08.09.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 09:26:48 -0700 (PDT)
Subject: Re: [PATCH v13 3/4] selftests/ftrace: Add testcases for objtrace
To:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        chensong_2000@189.cn, Shuah Khan <skhan@linuxfoundation.org>
References: <20220626025604.277413-1-xiehuan09@gmail.com>
 <20220626025604.277413-4-xiehuan09@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db539a80-8cad-b5bf-3bea-6a883f48585e@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 10:26:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220626025604.277413-4-xiehuan09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/25/22 8:56 PM, Jeff Xie wrote:
> Add a series of testcases to illustrate correct and incorrect usage of
> objtrace trigger.
> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> 

Assuming this patch depends on the other kernel/trace changes in this
series, here is my Ack for this series to go through tracing tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

