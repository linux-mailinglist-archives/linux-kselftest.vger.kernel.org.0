Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661C51C5951
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgEEOYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 10:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbgEEOYa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 10:24:30 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13132073B;
        Tue,  5 May 2020 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588688670;
        bh=Fncd22hBUft4LoEM6sUpuOYdu05wvdv4fCIHHEMqIuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=yXVPtTF+RdqYUi/xYVTqkhYS7cbmDmLTR3lXA2CmI0fYlsxJoNLP27zGFTaORuVzd
         lVkisOelsibvTy3tzv15Sf5CDqilxGTLM6XYiazS3Ows+XOk2Tk7prdKTForhpfIoC
         z91usLF/Anl+MDfaI2X6L9+3PDwFbmhQ3iNcU174=
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
To:     Steven Rostedt <rostedt@goodmis.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mhiramat@kernel.org, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
 <20200505090912.7114f420@gandalf.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <e6726e67-243e-876d-9e37-47b40d4bca5c@kernel.org>
Date:   Tue, 5 May 2020 08:22:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505090912.7114f420@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/5/20 7:09 AM, Steven Rostedt wrote:
> 
> You keep forgetting to Cc Shuah's other email.
> 
> On Tue,  5 May 2020 18:14:45 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
> 
>> The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
>> for the absence of the test module, as it matches "test was set up
>> incorrectly" situation in the README file.
>>
>> A possible scenario is that the function was enabled (supported by the
>> kernel) but the module was not installed properly, in this case we
>> cannot call this as UNSUPPORTED.
>>
>> This change also make it consistent with other module-related tests
>> in ftrace.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this after Masami gives his ack (if he does that is).
> 

Yes. I will wait for Masamis's Ack. Will do.

thanks,
-- Shuah
