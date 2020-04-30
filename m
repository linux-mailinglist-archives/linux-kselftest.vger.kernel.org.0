Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D1C0394
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Apr 2020 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD3RFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Apr 2020 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3RFO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Apr 2020 13:05:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E134C035494
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 10:05:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so2271285ion.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JE4ZrrZLcPA1hKn3GWMVTGebKqdRD3yDEJ/4573riY=;
        b=B9EsLYqGJOzJDWE8QaHzc2hc06vrGuxXlpM6IWGxJl+MPRS1gHtaswretrKZWVBav9
         Ll2KWG0rTYnWwUHmzcr/0+HKHEF+zDVRZGdTmMsJuhv/bfrJE/HXSHJrCBs9JdvzoBxp
         ES+zgbtThpJuaoNsPok2Fi5dZq4udfovCYb1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JE4ZrrZLcPA1hKn3GWMVTGebKqdRD3yDEJ/4573riY=;
        b=IjY9MtutiOunEJtPXx0QodXdD7SSkPyb6U/s+jMyNupBRf06PeQE6zZ9CFTCfNYcWA
         OXX+oy650EHpTpYmDVec82KN/7rXyfyK+OBGUrrgSKz8J5PPCpqn5N9eS7mMv/aoqaGq
         kLzgXpzEC1nmwox+BFXKFdD+xVWDMSoHch8lcGSgv0KyNOD82bhB51CO7g0QKF9Ayh4i
         YIf9w4p4oEiMIzml9IEXeK1J5K6+pWeNzzJ3pKV5uz2CR15xN0vq55jBds6jVaqysNPu
         vGJeqTFJlpu1bT2IJzQ5/6Q2Qfj9LpN2q3ciOxB8VRf0Qt2RqMxVIC5z6aJSWgC9vHHn
         T1jw==
X-Gm-Message-State: AGi0PuYWmoGxZFJQ+NQ+xkuocWooH2WSywng+FAxqcMjXRAs+IuVMbdF
        STzewaKoEdtD0WmMr0fAYEX2cw==
X-Google-Smtp-Source: APiQypJFyCqODwgTbdRS+FBrGs75q7t1TMwY9cwvUKQ5V0EGD58aoeslibhDzmD1V9MfbpsBH0NhmQ==
X-Received: by 2002:a6b:9346:: with SMTP id v67mr2858780iod.154.1588266313423;
        Thu, 30 Apr 2020 10:05:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n65sm130500ila.69.2020.04.30.10.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:05:12 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Add CONFIG_SAMPLE_FTRACE_DIRECT=m
 kconfig
To:     Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, mingo@redhat.com,
        ice_yangxiao@163.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200405014457.8854-1-yangx.jy@cn.fujitsu.com>
 <20200406092306.7ea72524@gandalf.local.home>
 <34600011-aca9-76ec-fb04-1ddd55d1da91@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2bfe3ebd-eaed-4e6e-db4d-5670cb2066dc@linuxfoundation.org>
Date:   Thu, 30 Apr 2020 11:05:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <34600011-aca9-76ec-fb04-1ddd55d1da91@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Xiao Yang,

On 4/6/20 8:52 AM, Shuah Khan wrote:
> On 4/6/20 7:23 AM, Steven Rostedt wrote:
>> On Sun, 5 Apr 2020 09:44:57 +0800
>> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>>
>>> ftrace-direct.tc and kprobe-direct.tc require 
>>> CONFIG_SAMPLE_FTRACE_DIRECT=m
>>> so add it to config file which is used by merge_config.sh.
>>
>>
>> Shuah,
>>
>> Care to take this in your tree?
>>
>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
> 

I took this patch and sending it in my pull request. Please
make sure your commit logs don't wrap in your future patches.
It makes it easier to read commit logs.

"Without CONFIG_DYNAMIC_FTRACE, some tests get failure because required
     filter 
files(set_ftrace_filter/available_filter_functions/stack_trace_filter)
     are missing.  So implement check_filter_file() and make all related 
tests
     check required filter files by it.

     BTW: set_ftrace_filter and available_filter_functions are 
introduced together
     so just check either of them."


thanks,
-- Shuah
