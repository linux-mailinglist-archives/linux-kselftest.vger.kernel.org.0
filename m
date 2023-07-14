Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946E47541AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjGNRu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjGNRuo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:50:44 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FB35B6
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 10:50:10 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5634db21a58so1539426eaf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689356948; x=1691948948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7DDN8GbZMG3KlpuHTN+v0LnOTBPGrIWfYxu7LMvL/8=;
        b=EsObdH5GmfJY05wMbzoDxMZl7qGlDG1hB3mWeD4J9KH+vhPUO8vzmrTibNYCg3HFsX
         N/yHTsKtySUpQBqoznTOulPdXkVf5BdhhRbu9EJ5Plf9zeBRSvrgCTYrz9g9r9YKgv7P
         /THveqSATuTYP4pJoUUX65Uan3QgCrP+vldmXjs13ym6CziZ2rBvZP2Xn0T2UKRIVHRM
         AochMDIvMr3iWvDt4ot+U2i+6lwRdJJyOJtOSxXxo0HTi0zV9wlssvgbjSZEyuoRkFiD
         d7e0tq9zTPgg6hRtHTm4SCr/NXDD25LFVWKsc5TWQsXVNx76aIbvTrm0/36SWRYONc5H
         2iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356948; x=1691948948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7DDN8GbZMG3KlpuHTN+v0LnOTBPGrIWfYxu7LMvL/8=;
        b=JljnxbJxKFFsLf531HJM2q6wfno+7dJNvRzmg5GQ1Uai+3zEcMuHkFaGArglf9F28d
         c5bL1XA0IzdscZWQOw2ssaQJvC7eW87fvy1M9UppXtxLGaNB8xAJYF+PXyfUBVhak287
         2fhcD+vA5DtTsQqUqxknKbVlshQcDAfd+DJnKGuZdERitWqkEykf/uLKStI1BBs0hCm8
         XVboqOYa8ou2zCOp5d+UBBVqrElUkVQpiUMTKxcLu7B2jgLIupbGQPYHyuS8QDo+T21m
         QY+Bipt9kNo1E0hjG/bWpWK3vWnSPj5iHH2raV6hzUi4xEjhYKlEJv/p2wjd7wACfUvf
         wAOA==
X-Gm-Message-State: ABy/qLYFZIFeQWa7KhF57O4BUKgBnaKrGTjcml1n2dz6+MBdJjVCeiZ6
        NHq4MViReG3FdaNj388cDxSODg==
X-Google-Smtp-Source: APBJJlEFEC11jJ2OVWqVyq80ycE+Wi778tCXgrJAAGfwWU4P6AqQ9H0EWkwamlDgNCerFGk1EU/3MA==
X-Received: by 2002:a4a:d298:0:b0:566:6928:2e3c with SMTP id h24-20020a4ad298000000b0056669282e3cmr5186911oos.9.1689356947824;
        Fri, 14 Jul 2023 10:49:07 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:860d:7d54:c6cc:ceb3? ([2804:14d:5c5e:44fb:860d:7d54:c6cc:ceb3])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a1dc1000000b0055e3dd89c12sm3065807oog.1.2023.07.14.10.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:49:07 -0700 (PDT)
Message-ID: <deeb8fe7-1f0e-bc1c-cde5-74e9af160bf7@mojatatu.com>
Date:   Fri, 14 Jul 2023 14:49:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net 1/3] selftests: tc: set timeout to 15 minutes
Content-Language: en-US
To:     shaozhengchao <shaozhengchao@huawei.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        mptcp@lists.linux.dev
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net>
 <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/07/2023 23:25, shaozhengchao wrote:
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
> 
> Maybe we should really optimize the parallel execution process of tdc.

Let's try to spend some cycles improving the tdc code performance first.
TDC boils down essentially to:
- Setup namespace (if needed)
- Setup network interfaces
- Spawn a few processes
- Match a regex
- Bring down namespace

Nothing above screams expensive, so I'm sure there are some low hanging 
fruits to improve the overall wall time even in debug kernels.

