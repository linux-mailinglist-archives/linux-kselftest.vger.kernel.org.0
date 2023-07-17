Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDFE755E83
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQIcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGQIcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 04:32:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02535136
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 01:32:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-316eabffaa6so3625905f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689582728; x=1692174728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGpGIGHpL2BV0gRPe7o+mCUkh562jDYsyKn7ATcWjy4=;
        b=l/Le4Uw/oENU8MdiPbpVIEgMsUnyY9CAc53RvkdusFs8aue63uMVlB7g8UT3sjQUUw
         hdwwTGZffSgmh1UknkjyTdyobVcJqGY0j8K8Y+7Yp7K+W4W+FPp7QIevLmXjFv9PM9Fm
         +AMU4wc35Pjt1wUX3RjjS5VfiD8GdwWXULTOhZWQ2lChyofxd/K2jUrM6hTHKUzumLdj
         lWuWjk0WJR26ighG14Lk7OvIL4C3buqnJJi22YTx26uI0Yx7RyHgB1hJ9kBflO+/k0Sv
         a4ZjCrzM+bj6gVl+yMBnAKHS5SqtRXESPDcsW3PLr4la8E5aPH/aYH/yAyKW18voAS4g
         X3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689582728; x=1692174728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGpGIGHpL2BV0gRPe7o+mCUkh562jDYsyKn7ATcWjy4=;
        b=cXl8i8IrI2XudR6aVBmCxHdXZGPr+U3MzYcfQnG9eOtTODV3G69QieCJGgYl8p+gvl
         Nq8pc3SjdOm4G5h/Z+/5RLf8AnJrEhKc3cqZe9jW31cutOpm04xmQOIOJRdX4iQ0+gbN
         uSm1p9gU76ZTUXkb3J1P+qzx/VI1e5mmukRFXonSp7TExMOLZBKwqQ779W1gNDcM9vvQ
         uyAXdLx8Ha2177gQVkvNiiuv6KMm25SCu1+VqMakMWJfwmKFgus8JZV2WBcKQ0Ke0ge0
         +uYmQ525MyOPlM6usvJ6uCtDg9U+VrfKsQxoJYjtgwZERc1dMbMGZU3RyOuvIkHvhAm4
         cgIg==
X-Gm-Message-State: ABy/qLboyp6yMD9x5GCN12yeDMeVLK1sLugwZzGt6FmxuTTl1H6G5SHq
        RzR9PaCQa2L2r7Mx8DHEMNkXnw==
X-Google-Smtp-Source: APBJJlHVVnqlD7iFaIKgrA7nEDnmp8PC4zO1Sf7ESIkL6tmAxD4qBQpsCb0F0cPBPj5NLKAxliKaUQ==
X-Received: by 2002:a5d:604f:0:b0:315:9c3a:43c3 with SMTP id j15-20020a5d604f000000b003159c3a43c3mr9077329wrt.15.1689582728440;
        Mon, 17 Jul 2023 01:32:08 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b003143d80d11dsm18453833wrt.112.2023.07.17.01.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:32:08 -0700 (PDT)
Message-ID: <3a47f676-d661-0b7a-701b-c4cafdc25394@tessares.net>
Date:   Mon, 17 Jul 2023 10:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 1/3] selftests: tc: set timeout to 15 minutes
Content-Language: en-GB
To:     shaozhengchao <shaozhengchao@huawei.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        mptcp@lists.linux.dev
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net>
 <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhengchao Shao,

On 14/07/2023 04:25, shaozhengchao wrote:
> 
> 
> On 2023/7/14 5:16, Matthieu Baerts wrote:
>> When looking for something else in LKFT reports [1], I noticed that the
>> TC selftest ended with a timeout error:
>>
>>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>
>> The timeout had been introduced 3 years ago, see the Fixes commit below.
>>
>> This timeout is only in place when executing the selftests via the
>> kselftests runner scripts. I guess this is not what most TC devs are
>> using and nobody noticed the issue before.
>>
>> The new timeout is set to 15 minutes as suggested by Pedro [2]. It looks
>> like it is plenty more time than what it takes in "normal" conditions.
>>
>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>> timeout per test")
>> Cc: stable@vger.kernel.org
>> Link:
>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
>> Link:
>> https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
>> Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>   tools/testing/selftests/tc-testing/settings | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/tc-testing/settings
>> b/tools/testing/selftests/tc-testing/settings
>> new file mode 100644
>> index 000000000000..e2206265f67c
>> --- /dev/null
>> +++ b/tools/testing/selftests/tc-testing/settings
>> @@ -0,0 +1 @@
>> +timeout=900
>>
> I remember last year when I tested all the tdc cases（qdisc + filter +
> action + infra） in my vm machine, it took me nearly 20 minutes.
> So I think it should be more than 1200 seconds if all cases need to be
> tested.

Thank you for your feedback!

Be careful that here, it is the timeout to run "tdc.sh" only which is
currently limited to:

  ./tdc.py -c actions --nobuildebpf
  ./tdc.py -c qdisc

(not "filter", nor "infra" then)

I guess for this, 15 minutes is more than enough, no?

At least on my side, I ran it in a i386 VM without KVM and it took less
than 3 minutes [1].

Cheers,
Matt

[1]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWHb7PJfqkUX1m8rLu3GXbsHE0/logs?format=html
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
