Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F11615F20
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiKBJMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKBJL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 05:11:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D428715
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 02:11:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k5so8073523pjo.5
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhRLRA04sFsFRg1MijYPrVMq9mkoGl+A2EID9pMn6C0=;
        b=ErPHybm+ZEvQ7ps9ny2DKUwzsGW3kGn0+Rigint7QJwJalC034kPl8+jxxsq+Yo9x5
         /BGlUk707BAPVwhIgKwM9zLbBU3Bir+n6gzs5QcxJ5GU5ErlrSXBHap4cLk13JKKcb8S
         3449vsqNhIyre6C4mdGhJmRVeFoOtckGU3SKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhRLRA04sFsFRg1MijYPrVMq9mkoGl+A2EID9pMn6C0=;
        b=2ApBh7grWlZui3+JghBEQdVH3Yp4lvJq/Ikn4qPVy3mgxDKGDP2II+vo2O26DA/47O
         81q9mWJywSWvZlM0mJxPBtoVOpHaByVzEuh/ZnALRAWutSYPkPuaKCA0motjHhgC6iPg
         YwT1Azjtj0vysrEjGeLYuoHtpFdWBBSUBsHfK8Tl595q9Ym6uEChVm7myuDQnLpN4Krr
         FTj1xsq5BVRU+zCfT2JQ4uyxByG2MW07Hmnw0F9yefN8jeE7WE/p0toEw6pUsCIw7ZGh
         daZNEAeow6IRYx1Z54JOhzo8cADodH2LAKLEdC8KBNhE5ww5wDXpshH8RoHXfaWaqOxb
         fn/g==
X-Gm-Message-State: ACrzQf2UzBPjE/k0If4FPS7WdzKmPhyqnOEPPq7sG1yx7+a+SYkeZFnm
        5IE7aq8wy+r17w2dLTCi0INmCA==
X-Google-Smtp-Source: AMsMyM5bF8I6zcvysOFcJ423OXS3yF376EoksI6rJr8C1u6Ar5A2wK2S0O2EAOimX9ooQxRrDQIKEw==
X-Received: by 2002:a17:90a:6c21:b0:212:f53b:fe22 with SMTP id x30-20020a17090a6c2100b00212f53bfe22mr41845749pjj.27.1667380276860;
        Wed, 02 Nov 2022 02:11:16 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b00186ae540083sm7802875pla.91.2022.11.02.02.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:11:16 -0700 (PDT)
Message-ID: <9dfa47ee-64a1-1215-eb82-a08bbb7f5ec3@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:11:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH -next] selftests/pidfd_test: Remove the erroneous ','
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     brauner@kernel.org, shuah@kernel.org, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101035602.40623-1-zhaogongyi@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101035602.40623-1-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/31/22 21:56, Zhao Gongyi wrote:
> Remove the erroneous ',', otherwise it might result in wrong output
> and report:
>   ...
>   Bail out! (errno %d)
>    test: Unexpected epoll_wait result (c=4208480, events=2)
>   ...
> 
> Fixes: 740378dc7834 ("pidfd: add polling selftests")
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---

Applied to linux-kselftest next for the next rc.

thanks,
-- Shuah

