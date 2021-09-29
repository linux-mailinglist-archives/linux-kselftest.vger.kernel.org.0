Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39041CA13
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbhI2Q2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbhI2Q2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 12:28:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B4C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 09:26:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i13so3508451ilm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nvuL53GG4ZKcbarpu9fgiT4nxY3Ya+EWac650T7Wl+I=;
        b=XcSO1sDId1+SHHk+UyucSVrt5zUeR7axtjojlaAXN0DgbbzXMhXDnUFvckaPx0VvMZ
         cujcoUirOyn/2fIBsEQRz3vJQM3mEGu6yHNJGY8JjQZ27Iae6AzJmf43K6+cCXS+gLZT
         jUcX3vab4MGz4Wr8bVEgG9ArDSyHd24GEMtvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nvuL53GG4ZKcbarpu9fgiT4nxY3Ya+EWac650T7Wl+I=;
        b=eIDHd5zLnOVPGl8jcugEmR3nUJq4Ylj/FpyD3NKBhC4TMBPRU12JAsAclcIQS1nvWh
         uCZAAr04zV8jkbW5d/AeBhH3HzIffQvSXgdo0kiFn1i0LdZ1O1U/ECGYTbIWdp/Qtm3v
         vXjfrfUCGDsXxjwWEYCt6aDnEW5rtHr4mCVntoQe4WcgTOYSJdSkIRFZ76dM2vA/g/NJ
         XjXn4hxSXrgCnGHkVyovgW2RF/+vh8ewPasbiD5eCgPGvkvUMVdIbbIv8kfMiZwneLW6
         wKU71Qb68zy436QqqnilGBoWE5uqtcKByGI9IeyJ9GHZOFc2xIXO3nUv5wBu/VnM5g1A
         1tmw==
X-Gm-Message-State: AOAM532MfqqytDXLqknq5ZLsM+wSMBIYUpc2E6ouH7ZhAhDeM9EQosHg
        1++CQHM0/Ynn2N38RfTFM7KMyQ==
X-Google-Smtp-Source: ABdhPJwYGVu9LWWLKU5+zt5Dh26Qzuzn6kc/7fVZKzaYWO+hcZEhSaUyZdGsYCovA+0FCET8IyJEHQ==
X-Received: by 2002:a05:6e02:1caa:: with SMTP id x10mr425573ill.280.1632932810795;
        Wed, 29 Sep 2021 09:26:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q17sm133023iod.51.2021.09.29.09.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:26:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
 <20210929144323.GQ4199@sirena.org.uk>
 <20210929153511.GB22029@willie-the-truck>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1b573881-ef9f-c7ae-c08b-8079f63f66ec@linuxfoundation.org>
Date:   Wed, 29 Sep 2021 10:26:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210929153511.GB22029@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/21 9:35 AM, Will Deacon wrote:
> On Wed, Sep 29, 2021 at 03:43:23PM +0100, Mark Brown wrote:
>> On Wed, Sep 29, 2021 at 03:31:14PM +0100, Will Deacon wrote:
>>
>>> With this series applied, I see a test failing under qemu with:
>>
>>> # selftests: arm64: vec-syscfg
>>> # TAP version 13
>>> # 1..10
>>> # ok 1 SVE default vector length 64
>>> # ok 2 # SKIP Need to be root to write to /proc
>>> # ok 3 # SKIP Need to be root to write to /proc
>>
>> AFAICT this is due to running as a non-root user, the testsuite was
>> already having serious issues before then...
>>
>>> # ok 4 SVE current VL is 64
>>> # ok 5 SVE set VL 64 and have VL 64
>>> # ok 6 # SKIP SVE only one VL supported
>>> # ok 7 # SKIP SVE only one VL supported
>>> # ok 8 # SKIP SVE only one VL supported
>>> # ok 9 # SKIP SVE only one VL supported
>>> # # SVE VL 272 returned 256 not maximum 0
>>
>> ...as it's starting off by testing an interface that's only writable by
>> root and then relying on that information, the existing tests were also
>> not working usefully.  qemu by default supports way more than one vector
>> length.  In any case it's just the test added by the last patch that's
>> causing the output here, the first four patches should be fine and fix
>> issues.
>>
>> I'm not sure it's a particularly good idea to run kselftest as a
>> non-root user TBH, it's going to cause you to skip a lot of tests.
> 

We don't want Kselftest default run to be as root. Users can choose to
run as root which would be an explicit choice so they expect and plan
for the impact. Example panic test.

> Ah, thanks for pointing that out. It would probably be better to skip the
> tests rather than fail them if they're not running with sufficient
> permissions, but I'll go ahead and queue your v3 for now.
> 

Correct. I would like to see tests skipped not failed if either config
or permissions are lacking to run the tests.

thanks,
-- Shuah
