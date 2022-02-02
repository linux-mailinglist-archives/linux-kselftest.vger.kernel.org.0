Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292EA4A74F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbiBBPxx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343836AbiBBPxx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 10:53:53 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71BC06173B
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 07:53:53 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c188so25973943iof.6
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXOsmtDny0WluDniF2bqbqtLayhd1SNumBfgvAoXVDc=;
        b=ENABLJMA05R4soziave+d7UPm5zfjbrRymzXBoJsaW0z6qAKD2n9BRtw7tMe8IWvtT
         Dtw076aY5ms2kHZAAIDpNevhFb8kbWcCRn5sIFiTdWfl+S4e2MesYrqCgrU0NJHNQkOc
         frhUCeyRRNVCb6l36CVwAiB4lbVwnXLyCG9nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXOsmtDny0WluDniF2bqbqtLayhd1SNumBfgvAoXVDc=;
        b=YO6FNN1aBG8hj8FFprvs8pD3SfPUfMdE7YbRBUHX9dGwhOIZ/ATZGMk//beqEoLqk1
         rhkMUq64hpACD117+K5icz4GrnaqdkxWQbhupQJl0swrbUKWmnwVJEIWDmzyvfHNcixI
         A17floHqLvtWLWko/LWLZyvVD/fGOaXuhcO8OxNfels6ka1gGYC+vSZHJMK4RAFq2Bmi
         N/1uEslGqiyuOMM/zxKkCvbnb4KxHv2wvWP2DkxBGES8+pPhokSel4zmIpVhaK/ILh3G
         hOAfJ9w8zvLQhgSZQrsOn5eH4ESKgl9RPA9WEx1DREaJ3iCIT6V85ELOfTlA4aLQ10O4
         78Pg==
X-Gm-Message-State: AOAM533rrHYgBxkzj+Ay5U7V8u7A2u+ZclkD0yK/jvZsuK3oXKBu+w/R
        B2T5xpnBgUY6Nk5gIom6mFlPXg==
X-Google-Smtp-Source: ABdhPJw6EtuJMPNRgqXBZ1urjdtS9DTte0fKkn/dXlVvcSumMDMNt2EoK1WwnohoNyDsHDMB2u/rhg==
X-Received: by 2002:a02:9f07:: with SMTP id z7mr12280320jal.87.1643817232526;
        Wed, 02 Feb 2022 07:53:52 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o4sm17381145iou.42.2022.02.02.07.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:53:52 -0800 (PST)
Subject: Re: [PATCH] selftests: fixup build warnings in pidfd / clone3 tests
To:     Christian Brauner <brauner@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127221115.3731388-1-axelrasmussen@google.com>
 <20220128085759.qgn7o3w57d6oknzv@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54a0cd63-6ec9-21fa-722a-da933b0ff1bf@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 08:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220128085759.qgn7o3w57d6oknzv@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 1:57 AM, Christian Brauner wrote:
> On Thu, Jan 27, 2022 at 02:11:15PM -0800, Axel Rasmussen wrote:
>> These are some trivial fixups, which were needed to build the tests with
>> clang and -Werror. The following issues are fixed:
>>
>> - Remove various unused variables.
>> - In child_poll_leader_exit_test, clang isn't smart enough to realize
>>    syscall(SYS_exit, 0) won't return, so it complains we never return
>>    from a non-void function. Add an extra exit(0) to appease it.
>> - In test_pidfd_poll_leader_exit, ret may be branched on despite being
>>    uninitialized, if we have !use_waitpid. Initialize it to zero to get
>>    the right behavior in that case.
>>
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
> 
> Thanks!
> (Fwiw, all those tests should also be ported to use the TEST_*() harness
> infra. Currently it's an annoying mix.)
> Acked-by: Christian Brauner <brauner@kernel.org>
> 

Yes. Porting would be great. I will take this for now for 5.17-rc4

thanks,
-- Shuah
