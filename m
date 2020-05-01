Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C381C1A97
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEAQaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEAQae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 12:30:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8FAC061A0C
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 09:30:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so1141815iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZFbo13vf2wV07Z9Rw/Rb5UPHeQ2gxDTLd7RnWBUNYY=;
        b=iJ1jj+9uj29mf+kASJ6SUBvTuuTjHrib0DC3j8oRbbzAbNcPJee6k1g5j2V+5gLEey
         unvXOu5nkU7cZ03JmDWz+XDhzEpCjA+HYZxy9m9kzq7dL0oB34jCs5i3Dt1RSkUh0v56
         j1A+Mt6uyDIT1Yg9e50BhxUxPffIpRmkBjr0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZFbo13vf2wV07Z9Rw/Rb5UPHeQ2gxDTLd7RnWBUNYY=;
        b=DuxZ5z+0nlTIMbu901+4ZRbi4rBQhSnG+6m6OD8R9DsRpwoNLg9SEMp5kjSfFDQNPH
         lCj5+Ku+qfcOhxEH9w+egyaPpYpVNShoRAflcV8ZDiXn1Qh807PPcfchqC68znEDJHBn
         NKgBld0vezm2R6cLPJ1IhIN8YmWn2n3v5kruD2IwICFsMcmqSsc/8zB/5k8hnsaKxtZE
         ZfJbpuKCuCqjM+tk2TfdTal6QyeZLvhHgrTYVBVPbK2wxACBkXwJRZiA7dnq9fq4907g
         AIiEUB1F3BWXiNKHVpOVD7pbR/LDgGSesI/hNhpEQf6H3dMpFM01ZmkbSNWLC04QWsHR
         0tbw==
X-Gm-Message-State: AGi0PuaLVvgkBJFSF9AZAh+crJpyABzlbJKpsxRhKwHaHfXscyq49gWK
        sADvqQ8pQkVhgQPgRXFGaHkWvYSQNPw=
X-Google-Smtp-Source: APiQypK0sA8GMasF8F7ZJqVaCHv+QQtf+EfHM9CfJZjEsbjjhxSBR16yz2faTqw2X6RdIj/Ca21SPw==
X-Received: by 2002:a02:6a4e:: with SMTP id m14mr4044212jaf.17.1588350632708;
        Fri, 01 May 2020 09:30:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n8sm1451816ili.18.2020.05.01.09.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 09:30:32 -0700 (PDT)
Subject: Re: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event to
 test
To:     Steven Rostedt <rostedt@goodmis.org>, shuah <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>, skhan@linuxfoundation.org
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <158834027133.28357.11196486193798517250.stgit@devnote2>
 <20200501101718.5a15e557@gandalf.local.home>
 <7751734b-83f1-bf14-9d8e-9092b0b7be3e@kernel.org>
 <20200501122049.46a93bb5@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1bb4a6f8-eafe-7c2d-c6a2-1caae7cc91b9@linuxfoundation.org>
Date:   Fri, 1 May 2020 10:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501122049.46a93bb5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/1/20 10:20 AM, Steven Rostedt wrote:
> On Fri, 1 May 2020 09:38:59 -0600
> shuah <shuah@kernel.org> wrote:
> 
>> On 5/1/20 8:17 AM, Steven Rostedt wrote:
>>> On Fri,  1 May 2020 22:37:51 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>    
>>>> Since the kprobe/kprobe_args_type.tc reads out all event logs
>>>> from the trace buffer, the test can fail if there is another
>>>> fork event happens.
>>>> Use head command to pick only the first kprobe event from
>>>> the trace buffer to test the argument types.
>>>>
>>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>> ---
>>>>    .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> index 1bcb67dcae26..81490ecaaa92 100644
>>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>>>>      echo 0 > events/kprobes/testprobe/enable
>>>>    
>>>>      : "Confirm the arguments is recorded in given types correctly"
>>>> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>>> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>>>      check_types $ARGS $width
>>>>    
>>>>      : "Clear event for next loop"
>>>
>>> I think I've manually added this exact change to my tests to keep it from
>>> failing.
>>>
>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>    
>>
>> Does this conflict with:
>>
>> Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> Date:   Tue Apr 7 14:34:19 2020 +0800
>>
>>       selftests/ftrace: Check the first record for kprobe_args_type.tc
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba
>>
>> I went into mainline yesterday in my rc4 pull request.
>>
>> Exact change it appears.
> 
> Ah, then I guess we don't need this patch ;-)
> 

I took the first one. Will wait for patch 3 to finalize.

thanks,
-- Shuah

