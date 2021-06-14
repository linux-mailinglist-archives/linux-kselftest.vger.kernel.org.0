Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22CC3A700B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhFNUTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 16:19:21 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33415 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhFNUTU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 16:19:20 -0400
Received: by mail-ot1-f42.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so12126530otl.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hOOlcHmoJBs6LQNLgT05L8MZVpTB0XNq9JFGsS9UAmY=;
        b=YdJ/kzTceSN94t2UrgrvaDVjmYdqq/+un1rAO6TKwE1MUTJT1Zeo/Boqf5onMt+mL/
         hmk56MPSs7jZeCFPKR/exvnfIPzAMmKbHflF7THbfbAez+YSJpCEGwnbiTlYwkOooOEA
         PUNxOVYoUJ5ZhD2rxvEQtjhUmvKt/v6gFSC5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hOOlcHmoJBs6LQNLgT05L8MZVpTB0XNq9JFGsS9UAmY=;
        b=N9oMl4iho3JCj+X+Jo1PuvBEHMlw0OMn0fIIjXVJXO+wmmiSgSLVoAQRirLOeAaaAZ
         FZACBZX17yzUdku3vOIyUXyzWrltvpL328HpEy/AnMgb/xZUcyWt2Orxn8+N1ZSHOqBd
         Uq6ebV4WYwszslyezcSUqDVKgmqWCGTXrtdn6H+P5xpEUxhoOIXIQ/Ihjo2pHvmEazuP
         sZ9+xorrmQmUvYNmsJTSKouOMSjxnfiZAZZLT1tq2wKQNtGx6nIh+W/mgcb/gj5iXG4m
         VJJt53C7s+RmIWzXd8X8djF6+wEWsyTt57odN1kkZlZOwW+EA6gAPlfBLaLfyMjSK+lm
         FbuA==
X-Gm-Message-State: AOAM533vfIWoQhghJWOcBi2h7FF/KKl/LFC3EUW6qXk5g8g5UEYnRcJt
        EZqrHRbmdt/V4uS2uRSO137CZg==
X-Google-Smtp-Source: ABdhPJw1WFHlL52QYsydZyxdmDIQlaJFxO/pMyttFGCSrVmvo4WbwgmvznQBGndync8tE4sSUVPJ6Q==
X-Received: by 2002:a9d:7f8e:: with SMTP id t14mr15079324otp.49.1623701776807;
        Mon, 14 Jun 2021 13:16:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x2sm3259215oog.10.2021.06.14.13.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 13:16:16 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] selftests/sgx: Refine the test enclave to have
 storage
To:     Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-5-jarkko@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b1bf69f5-e203-d69e-d15d-3fb5e98b63dd@linuxfoundation.org>
Date:   Mon, 14 Jun 2021 14:16:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610083021.392269-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> Extend the enclave to have two operations: ENCL_OP_PUT and ENCL_OP_GET.
> ENCL_OP_PUT stores value inside the enclave address space and
> ENCL_OP_GET reads it. The internal buffer can be later extended to be
> variable size, and allow reclaimer tests.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   tools/testing/selftests/sgx/defines.h     | 10 ++++
>   tools/testing/selftests/sgx/main.c        | 57 ++++++++++++++++++-----
>   tools/testing/selftests/sgx/test_encl.c   | 19 +++++++-
>   tools/testing/selftests/sgx/test_encl.lds |  3 +-
>   4 files changed, 74 insertions(+), 15 deletions(-)
> 

Test output before applying the series:

TAP version 13
1..1
# selftests: sgx: test_sgx
# Unable to open /dev/sgx_enclave: No such file or directory
# 1..0 # SKIP cannot load enclaves
ok 1 selftests: sgx: test_sgx # SKIP

Test output after applying second patch

selftests/sgx: Migrate to kselftest harness

Output changes to the following. It doesn't look like the second
patch adds any new tests. What is the point in running the tests
that fail if /dev/sgx_enclave is missing.

Unfortunately this series doesn't have a cover letter that explains
what this series is doing. I don't like the fact that the test
output and behavior changes when migrating the test to kselftest
harness. Shouldn't the output stay the same as in skip the tests
if /dev/sgx_enclave fails.

TAP version 13
1..1
# selftests: sgx: test_sgx
# TAP version 13
# 1..3
# # Starting 3 tests from 2 test cases.
# #  RUN           enclave.unclobbered_vdso ...
# Unable to open /dev/sgx_enclave: No such file or directory
# ok 2 # SKIP cannot load enclaves
# # Planned tests != run tests (3 != 1)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
# # unclobbered_vdso: Test failed at step #4
# #          FAIL  enclave.unclobbered_vdso
# not ok 1 enclave.unclobbered_vdso
# #  RUN           enclave.clobbered_vdso ...
# Unable to open /dev/sgx_enclave: No such file or directory
# ok 3 # SKIP cannot load enclaves
# # Planned tests != run tests (3 != 2)
# # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:1 error:0
# # clobbered_vdso: Test failed at step #4
# #          FAIL  enclave.clobbered_vdso
# not ok 2 enclave.clobbered_vdso
# #  RUN           enclave.clobbered_vdso_and_user_function ...
# Unable to open /dev/sgx_enclave: No such file or directory
# ok 4 # SKIP cannot load enclaves
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:1 error:0
# # clobbered_vdso_and_user_function: Test failed at step #4
# #          FAIL  enclave.clobbered_vdso_and_user_function
# not ok 3 enclave.clobbered_vdso_and_user_function
# # FAILED: 0 / 3 tests passed.
# # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: sgx: test_sgx # exit=1

thanks,
-- Shuah
