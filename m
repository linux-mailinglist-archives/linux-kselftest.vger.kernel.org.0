Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3863CA8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 22:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiK2Vja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiK2Vj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:39:28 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733D6174E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:39:28 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so4741251ilq.11
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2p1eoCdr7KfcBrhs1qvBb6yKyIDUaXwqBy/UqiA0oU=;
        b=CXGl0fZB4PaRYBUGI0z2HYZzP6fqFPVKlGn03PWwWzbfs56WKmqEpQNQu7T8LgiVfR
         pymxDoBGBdAqVj/jwHnhQZ7xmjPb0yl9JqCEW9ZzerE/3rpiFVaNtV8b9hc2rm7dugfd
         vvTWxvjiFn0acdJVBTJwP2OD5qbktoNW7SLpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2p1eoCdr7KfcBrhs1qvBb6yKyIDUaXwqBy/UqiA0oU=;
        b=wHfbkLoIw8RnOFtfMl7/I4CrXXsltG8OZRQo+o/sy9boYVbUI6rZedgPEdnWJSm30A
         h7yWABKmnBUSBYfx7BRcGcKHv7Z84+ntNFafuo8EfE/E8oMFQQfw7hO9azuzsSp/aSkv
         BsaigtYXXlhgTIxKploSFHd3zO6iQdM3pQEcRYmaM246PIiGqy/EpEOP0pRz0H7aAeZQ
         /6+gnL94KaEI0ynuwRFx5CWwHrfU7oyl+MnGaDaWdFxAEYyVbKeH2W4JPeMMz7hZMC5y
         XpXl3lrTZ/gROnSzcs6D2IChuJTLJSMd+f8DhiOPaXhHPuOyM2LJZMifcaVwTtidTU9j
         A5iQ==
X-Gm-Message-State: ANoB5plo+sieCePD3g/MNErdoVIfFFWk3w2mEe4AxqUGRFVd9ST8vrJt
        TvdOHOqQX4IzTP+dySiyigsrzw/jmo0rvw==
X-Google-Smtp-Source: AA0mqf6qH8euA+r+n8UH6TRig9rXw48v6aSaV/uV9RFgbhVk5ix+kLdPJC7ckGCJzrlPqLBd3gm7CA==
X-Received: by 2002:a92:db11:0:b0:303:1648:f2b9 with SMTP id b17-20020a92db11000000b003031648f2b9mr5085884iln.56.1669757967308;
        Tue, 29 Nov 2022 13:39:27 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b15-20020a02a58f000000b00389e3ca3285sm2014077jam.114.2022.11.29.13.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 13:39:26 -0800 (PST)
Message-ID: <dc7cb519-584c-55f1-4baa-44cd4e0bbfe9@linuxfoundation.org>
Date:   Tue, 29 Nov 2022 14:39:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
 <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/22/22 19:27, Tiezhu Yang wrote:
> It seems that patch #2~#6 has no conflicts with the other related
> git tree, but patch #1 is conflicted with paulmck/linux-rcu.git dev.
> 
> What should I do?
> 
> Shuah, could you please apply patch #2~#6 to your linux-kselftest.git next branch and ignore patch #1?
> 
> And then let me send a seperate patch #1 rebased on paulmck/linux-rcu.git dev branch to rcu@vger.kernel.org.
> 

That won't work because linux-kselftest next won't have the linux-rcu content.
I already picked patches 1,2,6

Patches 3 (powerpc) and 5 (net) go through powerpc and net trees. Please resend
just those cc'ing the right people. get_maintainers.pl will give you the info.

As for patch 1 - perhaps the conflict could be resolved in next.

Paul, would you like me to drop rcutorture patch from linux-kselftest next?

thanks,
-- Shuah
