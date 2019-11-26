Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E234B10A73D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 00:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfKZXvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 18:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfKZXvH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 18:51:07 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCD42064B;
        Tue, 26 Nov 2019 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574812266;
        bh=S0maIKQdKZoARWs5wqFTPH7nxPNc0P+cyL04la3mIsE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=snPKmDleh+IiWBaCRLIL37jok+PPaz09YtjpzE8tACaR664qic8jU4VGsADBRRAhm
         r8aGF1aaRTl/VoJ07KmTybJLWXkhogX25naoBwrrBURUlYzJIAKwENP1y9NXl2Hlmi
         jiBPX6Ova6futsX2RBwfVHmcMgdknI3620Inw7WE=
Subject: Re: [BUGFIX PATCH v4 2/4] selftests/ftrace: Fix ftrace test cases to
 check unsupported
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
 <157475726452.3389.3778488615487716476.stgit@devnote2>
 <20191126124901.22ae2f9f@gandalf.local.home>
 <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cc4c66dd-6f9d-6763-8172-02235e8e60ae@kernel.org>
Date:   Tue, 26 Nov 2019 16:50:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/19 4:31 PM, Masami Hiramatsu wrote:
> On Tue, 26 Nov 2019 12:49:01 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Tue, 26 Nov 2019 17:34:24 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
>>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
>>> @@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
>>>     exit_unresolved
>>>   fi
>>>   
>>> +if ! grep -q function available_tracers ; then
>>> +  echo "Function trace is not enabled"
>>> +  exit_unsupported
>>> +fi
>>> +
>>>   ORIG_CPUMASK=`cat tracing_cpumask`
>>
>> Strange, but the bashism test failed:
>>
>> ++ checkbashisms /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
>> possible bashism in /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc line 18 ('function' is useless):
>> if ! grep -q function available_tracers ; then
>>
>> Not sure why it did not like that line. Maybe my bashism check got
>> confused by the key word "function"?
>>
>> Yep!
>>
>> By adding quotes around "function" it doesn't complain:
>>
>> 	if ! grep -q "function" available_tracers ; then
>>
>> May need to add that.
> 
> Thanks! Shuah, can I update this patch?
> I'll send it asap.
> 
> Thank you,
> 

No worries. Take your time. I won't pull in until things settle down.
I noticed Steve gave you review comments.

thanks,
-- Shuah
