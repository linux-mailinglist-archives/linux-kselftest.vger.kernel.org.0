Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8ED1E6759
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404906AbgE1QYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404875AbgE1QYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 12:24:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3845C08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 09:24:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j145so536405oib.5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNE5zhFi30q9WwsA8BI91uOqjeUOdLA24NbPUP4RY6U=;
        b=f8zB+CQ9fKWIaBHJ3pRbSgQc/OvlY8b4ouWU1n9vC4OCtflD7zxXTJDkmVBl+33vDn
         iWeZHsQkp5lcYaKK6OERajrqZ3NfdOZpj5uNzjN1ur9TcdcH2MoplDaNGt7zN9W4dCos
         N+RFMJn2m8sXhZ0jlBMrWIYOV87q9p6Qq4LWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNE5zhFi30q9WwsA8BI91uOqjeUOdLA24NbPUP4RY6U=;
        b=Nh6KypwsXUF89rxTVRyPTyj/doDZu6cy8uWDOIbH6ai1BQoHF68ZkHMXLz+hMRx2NO
         PKA5MpFijiYWPQziqEIxawlYIpHBO2RPrvW2MGyKQSuXgpUdK0hV6w0TG1Rh1/mWutrF
         Z8hM3ZYA+AE4Jn+dlJg96/sZV+LcNnaPwgy28iO6RED/IM9eQCDSXKJi1+TnZPs23tpI
         V6b/CBVYPYXtKpC/28B9KC62714t0wWZvOx8lVVAbqi0ii8P7Zjp7VpTaKAtx9rvHit8
         D75JC2Qokqxk+1Mw6ly0xbOYJtp669QBrS0vZW/Vk+gfoM86OnsFQTQ6KbWF425UdQbZ
         8J0w==
X-Gm-Message-State: AOAM531/UJ6l5jVUJqZEyB+PyDfjKeDQKIHTjC1PbrIerZlOVtnJAkM2
        rEmjK/smMuuj1gd8EQ9SZ9vdBg==
X-Google-Smtp-Source: ABdhPJwtSYjyMNr1fHEm0+dCoWqlHRseFAIIRs8jo5Jrenwz+++/FVXju5yw2uBEMWhXby7HhbCNyw==
X-Received: by 2002:aca:af55:: with SMTP id y82mr2624443oie.178.1590683060534;
        Thu, 28 May 2020 09:24:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x3sm1839339ooc.22.2020.05.28.09.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 09:24:19 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        skhan@linuxfoundation.org
References: <87imh21x6f.fsf@igel.home>
 <158920418730.16156.8299185499520876735.stgit@devnote2>
 <20200525185905.5fecd8073e686001712dfdf9@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02fbbc09-a52a-5e54-43a5-3de93c698072@linuxfoundation.org>
Date:   Thu, 28 May 2020 10:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525185905.5fecd8073e686001712dfdf9@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/20 3:59 AM, Masami Hiramatsu wrote:
> Hi Shuah,
> 
> Could you pick this to kselftest-next?
> 
> Thank you,
> 
> On Mon, 11 May 2020 22:36:27 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Since the built-in echo has different behavior in POSIX shell
>> (dash) and bash, kprobe_syntax_errors.tc can fail on dash which
>> interpret backslash escape automatically.
>>
>> To fix this issue, we explicitly use printf "%s" (not interpret
>> backslash escapes) if the command string can include backslash.
>>
>> Reported-by: Liu Yiding <yidingx.liu@intel.com>
>> Suggested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>>   tools/testing/selftests/ftrace/test.d/functions    |    8 +++++---
>>   .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    4 +++-
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
>> index 61a3c7e2634d..697c77ef2e2b 100644
>> --- a/tools/testing/selftests/ftrace/test.d/functions
>> +++ b/tools/testing/selftests/ftrace/test.d/functions
>> @@ -119,12 +119,14 @@ yield() {
>>       ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
>>   }
>>   
>> +# Since probe event command may include backslash, explicitly use printf "%s"
>> +# to NOT interpret it.
>>   ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
>> -    pos=$(echo -n "${2%^*}" | wc -c) # error position
>> -    command=$(echo "$2" | tr -d ^)
>> +    pos=$(printf "%s" "${2%^*}" | wc -c) # error position
>> +    command=$(printf "%s" "$2" | tr -d ^)
>>       echo "Test command: $command"
>>       echo > error_log
>> -    (! echo "$command" >> "$3" ) 2> /dev/null
>> +    (! printf "%s" "$command" >> "$3" ) 2> /dev/null
>>       grep "$1: error:" -A 3 error_log
>>       N=$(tail -n 1 error_log | wc -c)
>>       # "  Command: " and "^\n" => 13
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> index ef1e9bafb098..eb0f4ab4e070 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> @@ -91,7 +91,9 @@ esac
>>   if grep -q "Create/append/" README && grep -q "imm-value" README; then
>>   echo 'p:kprobes/testevent _do_fork' > kprobe_events
>>   check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
>> -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
>> +
>> +# Explicitly use printf "%s" to not interpret \1
>> +printf "%s" 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
>>   check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
>>   check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
>>   check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
>>
> 
> 

Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux kselftest.git/ next
branch for Linux 5.8-rc1

thanks,
-- Shuah
