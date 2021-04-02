Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5E352EC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhDBRxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBRxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 13:53:06 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B5C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 10:53:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z3so3308396ioc.8
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=whRXq76gjLJkPVfSKotV9dDdRpnCQB8vQShEk4qBurw=;
        b=F6SYbw6faTLWfI73meZgPfreP/nqSXtNQdx6iM1rVNVXrfabL9IhrVJ4FEOEYh60n0
         F9G4345qX6aHJLhkwVqs/kHbWZaPG7iyykKqgO3E8BBog5ljCjILCfRpcgaU7M+F8sy/
         UtWs5D2FQVzAGJG+mNgMPimOstbPg4rdg3T8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whRXq76gjLJkPVfSKotV9dDdRpnCQB8vQShEk4qBurw=;
        b=GTNSPmxQo2WMFJTzBDj6xbxc+f/yHmwwwWgvxxJ4xIgxCj09pykyI1KlRki3sK1APt
         Q0CTPBeV9UrrHRzrv+6quw67G5UwmuYtTIaKAgOdMSJTins4InX+HHXJ1CSGPRiYmbVw
         v6ftZj74H3kDn4fY9OQVXYa3GCAz7Sj0iwi5zY2h+fSr27GNdfed0GVuhus/iw8yzVtO
         aiSfJ5xnURogOATcJMXZeAAn0APhiqQr57apzNSfkqaUdkfl6jDmMVgi7HUy1+LV4Ktj
         lahYyu0sz4AZGmoO3jv275htk7b+2UK2QOUSrYB43eDxMRXLDloteuc7dPRfsRqnaKKM
         jM+A==
X-Gm-Message-State: AOAM533SANEWGs4+koUVqXJnTovRLSRVYfyMzd7XxCV+w56BjMh4vQ4W
        GcuN4cvlyQKrnB+9J3nBzq+2wyippe6WRw==
X-Google-Smtp-Source: ABdhPJz1r1Ceyj+k6UwLlZGeWclgyMNhnV+pTsYoP1H/9iIhgVpTVY30rKYBtvBnCi89ACrcNGW83g==
X-Received: by 2002:a5e:980e:: with SMTP id s14mr12260386ioj.63.1617385984539;
        Fri, 02 Apr 2021 10:53:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b9sm4848319iob.4.2021.04.02.10.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:53:04 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Uriel Guajardo <urielguajardo@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210311152314.3814916-1-dlatypov@google.com>
 <20210311152314.3814916-2-dlatypov@google.com>
 <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 11:53:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 2:55 AM, Brendan Higgins wrote:
> On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>>
>> From: Uriel Guajardo <urielguajardo@google.com>
>>
>> Add a kunit_fail_current_test() function to fail the currently running
>> test, if any, with an error message.
>>
>> This is largely intended for dynamic analysis tools like UBSAN and for
>> fakes.
>> E.g. say I had a fake ops struct for testing and I wanted my `free`
>> function to complain if it was called with an invalid argument, or
>> caught a double-free. Most return void and have no normal means of
>> signalling failure (e.g. super_operations, iommu_ops, etc.).
>>
>> Key points:
>> * Always update current->kunit_test so anyone can use it.
>>    * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>>    CONFIG_KASAN=y
>>
>> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
>> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>>
>> * Forward the file and line number to make it easier to track down
>> failures
>>
>> * Declare the helper function for nice __printf() warnings about mismatched
>> format strings even when KUnit is not enabled.
>>
>> Example output from kunit_fail_current_test("message"):
>> [15:19:34] [FAILED] example_simple_test
>> [15:19:34]     # example_simple_test: initializing
>> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
>> [15:19:34]     not ok 1 - example_simple_test
>>
>> Co-developed-by: Daniel Latypov <dlatypov@google.com>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Please run checkpatch on your patches in the future. I am seeing
a few checkpatch readability type improvements that can be made.

Please make changes and send v2 with Brendan's Reviewed-by.

thanks,
-- Shuah
