Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7466D344
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 00:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjAPXio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 18:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjAPXin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 18:38:43 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945864EFE
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jan 2023 15:38:40 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h26so14651280ila.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jan 2023 15:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kx8LnLmJIYuCKyXOPl2pE0fgzE8/ErQvcbd2Anp/+nM=;
        b=WcktAtLKmOTE0jmTGCH5oKyheBkpCKCB4ZL3O/gyhU2eFQmWOqN/4n98gnQRuFxKm3
         ElTXGp/2KEfVtlv2ze64c1FFnT+nm9zlSCf1pWato2G+mVuoF142tvX/Z59xz2X+o0aq
         ssXSP33ARt6oJ2L5go796FrPvlr49TVA2vr7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx8LnLmJIYuCKyXOPl2pE0fgzE8/ErQvcbd2Anp/+nM=;
        b=tHR686sbsE817OITo1SRTBixXZxyoipM+0lZZUoVehwefYZieF7I5I+z1Ql61kFHxp
         FCA5Qe2zu2MlPcCM7+CL7LbHSNdSdUZGQZY8YsfB/ePx4mO4XNCHxya2WF3aahjzSwJn
         9J027ytq5N3mD3n4wP/013ZgvlEYNn0XuNt/78xnQy7dH4qHifhpXzMSEgT4PIFDPgoD
         71q5CKwnFAmW7GWgr8ci27OgfpAaRCfcRVnA3tXhbAw6HLvJ2xmoTFEsyvS0K+rFFTg/
         GRw/kkkd48a06sGMq4JL+Lx06hL80h7BZ85NC0hAffHJBsKxGFKqIh2oB4Rn8jWIkm2Y
         fDHg==
X-Gm-Message-State: AFqh2kpluQk7f98Woy775We07YTcSNJguq2XQyzebIqlsWJ65Rblr+w2
        TpRp/sCrJ5k4EVoCuSp7y6D59r63Pv3RtFMY
X-Google-Smtp-Source: AMrXdXvIYQlF7AdqJnzN1GHk0+Zf9YNSW0KS8LRlQ7RoaGcVM5erMlG6PX69X8brNGwcJMZL/sESoQ==
X-Received: by 2002:a92:d841:0:b0:30e:ed5c:8c87 with SMTP id h1-20020a92d841000000b0030eed5c8c87mr174194ilq.3.1673912319915;
        Mon, 16 Jan 2023 15:38:39 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s20-20020a02b154000000b0039d724c2416sm3931643jah.134.2023.01.16.15.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 15:38:38 -0800 (PST)
Message-ID: <4449d8b5-b7a5-0f09-5b42-7b70ba00f8f6@linuxfoundation.org>
Date:   Mon, 16 Jan 2023 16:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [tip:sched/core 7/28] rseq.c:139:37: error: 'AT_RSEQ_ALIGN'
 undeclared; did you mean 'R_SH_ALIGN'?
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202301170348.7WLKH1pl-lkp@intel.com>
 <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/16/23 13:18, Mathieu Desnoyers wrote:
> On 2023-01-16 14:40, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>> head:   79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
>> commit: 03f5c0272d1b59343144e199becc911dae52c37e [7/28] selftests/rseq: Use ELF auxiliary vector for extensible rseq
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>> reproduce:
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=03f5c0272d1b59343144e199becc911dae52c37e
>>          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>          git fetch --no-tags tip sched/core
>>          git checkout 03f5c0272d1b59343144e199becc911dae52c37e
>>          make O=/tmp/kselftest headers
>>          make O=/tmp/kselftest -C tools/testing/selftests
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
> 
> In order to fix this, I need to change -I../../../../usr/include/ for $(KHDR_INCLUDES) in tools/testing/selftests/rseq/Makefile
> 
> I can find 25 odd uses of the same pattern in the kernel selftests. Should I fix them all in one go ?

kselftest build depends on headers installed in the root directory.
The main makefile enforces this dependency. If this test is being
built without installing headers by itself, I think the scripts that
build individual tests have to makes sure headers are installed first.

thanks,
-- Shuah
