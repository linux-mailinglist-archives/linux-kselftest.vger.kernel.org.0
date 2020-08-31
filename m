Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9D2583C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgHaVpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgHaVpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 17:45:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192EC061573
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:45:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so7653868ioq.6
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHJyRFWfVCm6/zA6iOuXzbpaEsb6fqlByWRhLG6G4Ks=;
        b=HCYX9svxLV++H11XWPbK+Uv9kFI7bhxV52zcCRBX5i6g7xMgPw8jwkhm/LycsHANGs
         GKcoFofSPdNfkEFFfRDrfgDQ1hahrGryypGbiPwkXQJXxeGEUTyEwR1Wf+OV6o6wB8HY
         DCHedhzu1AD/2nwfHFAay9Mx5/9bz9kWDaYAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHJyRFWfVCm6/zA6iOuXzbpaEsb6fqlByWRhLG6G4Ks=;
        b=n6gq9QJ+8fTIRSZJHQ+qdLK9tyvq7fYqYSToo4bGcl4ZhRNoJ8j26DLkB/J7bNjFHn
         4fZrkETDVJifuNd3Xvse/hYUGvY321MxbSW0mKYVThblFr8oG/Eqd7VccllFwoJRL0ua
         DtiwBjpkMaO0EfbHNQTLrxvyXMkr6sikZrdruWDmDooUjij+2IMS84z4huGPd3USQ/n1
         15Z2EdT694LsCOltb2vMVwbRI9o6p5MmZxeMdtPpGeJBUkIkADjf+5u1Nr/LcMLceljb
         tLjOILq6TRPrdv5lYTD58vU91KJO8LX+2upVDtZP9AulEvfwKfcFzs9mlgF3aBGjRGBW
         euEQ==
X-Gm-Message-State: AOAM5319u42UWTxGKtmD+09Z3jB++jOrb+wLKuAOPj3oayEARETEQcoH
        64s0GYvT7L9l87eS0O0bcNR7bA==
X-Google-Smtp-Source: ABdhPJzqVk5jRxl0P6uTanndD+W0euKg7bSlYk0S0EevAfybEpJf3ZyBwZlAzqNnfS0f0OQEn/MaiA==
X-Received: by 2002:a02:749:: with SMTP id f70mr3024220jaf.82.1598910348332;
        Mon, 31 Aug 2020 14:45:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r3sm4619394iov.22.2020.08.31.14.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:45:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] selftests: arm64: Add floating point selftests
To:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20200819114837.51466-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cd9979be-34a3-375d-0fa1-61937337ca14@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:45:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819114837.51466-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/20 5:48 AM, Mark Brown wrote:
> This series imports a series of tests for FPSIMD and SVE originally
> written by Dave Martin to the tree. Since these extensions have some
> overlap in terms of register usage and must sometimes be tested together
> they're dropped into a single directory. I've adapted some of the tests
> to run within the kselftest framework but there are also some stress
> tests here that are intended to be run as soak tests so aren't suitable
> for running by default and are mostly just integrated with the build
> system. There doesn't seem to be a more suitable home for those stress
> tests and they are very useful for work on these areas of the code so it
> seems useful to have them somewhere in tree.
> 
> v2: Rebased onto v5.9-rc1
> 
> Mark Brown (6):
>    selftests: arm64: Test case for enumeration of SVE vector lengths
>    selftests: arm64: Add test for the SVE ptrace interface
>    selftests: arm64: Add stress tests for FPSMID and SVE context
>      switching
>    selftests: arm64: Add utility to set SVE vector lengths
>    selftests: arm64: Add wrapper scripts for stress tests
>    selftests: arm64: Add build and documentation for FP tests
> 
>   tools/testing/selftests/arm64/Makefile        |   2 +-
>   tools/testing/selftests/arm64/fp/.gitignore   |   5 +
>   tools/testing/selftests/arm64/fp/Makefile     |  17 +
>   tools/testing/selftests/arm64/fp/README       | 100 +++
>   .../testing/selftests/arm64/fp/asm-offsets.h  |  11 +
>   tools/testing/selftests/arm64/fp/assembler.h  |  57 ++
>   .../testing/selftests/arm64/fp/fpsimd-stress  |  60 ++
>   .../testing/selftests/arm64/fp/fpsimd-test.S  | 482 +++++++++++++
>   .../selftests/arm64/fp/sve-probe-vls.c        |  58 ++
>   .../selftests/arm64/fp/sve-ptrace-asm.S       |  33 +
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 336 +++++++++
>   tools/testing/selftests/arm64/fp/sve-stress   |  59 ++
>   tools/testing/selftests/arm64/fp/sve-test.S   | 672 ++++++++++++++++++
>   tools/testing/selftests/arm64/fp/vlset.c      | 155 ++++
>   14 files changed, 2046 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/fp/.gitignore
>   create mode 100644 tools/testing/selftests/arm64/fp/Makefile
>   create mode 100644 tools/testing/selftests/arm64/fp/README
>   create mode 100644 tools/testing/selftests/arm64/fp/asm-offsets.h
>   create mode 100644 tools/testing/selftests/arm64/fp/assembler.h
>   create mode 100755 tools/testing/selftests/arm64/fp/fpsimd-stress
>   create mode 100644 tools/testing/selftests/arm64/fp/fpsimd-test.S
>   create mode 100644 tools/testing/selftests/arm64/fp/sve-probe-vls.c
>   create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
>   create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace.c
>   create mode 100755 tools/testing/selftests/arm64/fp/sve-stress
>   create mode 100644 tools/testing/selftests/arm64/fp/sve-test.S
>   create mode 100644 tools/testing/selftests/arm64/fp/vlset.c
> 


Will,

Patches look good to me from selftests perspective. My acked by
for these patches to go through arm64.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you would like me to take these through kselftest tree, give
me your Acks. I can queue these up for 5.10-rc1

thanks,
-- Shuah
