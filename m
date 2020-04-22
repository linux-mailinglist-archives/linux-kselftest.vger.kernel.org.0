Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353901B4842
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDVPJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgDVPJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 11:09:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E79C03C1AC
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 08:09:39 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f19so2722557iog.5
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Jm5qkR43ecrqz4QuVW5kTz/d/H3ltLjKcWsZzS+/Mg=;
        b=G60f+9urzqV2BeZgiTHp04ELe2IgFlmAe3N2lpYtRytqBjeAXNr76vEESMrRKEvlMB
         NuhzDzCPwYzndPwz3LScOtUxS403Yu2cjsJWfl7xht7icnUyEwv/RDYXFUbLag48Grlb
         9nuKSeFGYt6FMtkFwWB3s7utCmQcYWvNRm/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Jm5qkR43ecrqz4QuVW5kTz/d/H3ltLjKcWsZzS+/Mg=;
        b=I4SJklyM8Fc4CseOYn+nLEmHK1eqjc34W981k+r4REtYs7wA5JvZ/A62iWHekYcUP+
         9+jm4u4rgenPMvEv5GzmDWiZDa1O8HO0Oi2OBr46gG9c4GU+x+ZhckmDqsrLxGd6HvNh
         dafYotd8WXfGffKtQlmvx5WjNktTrL4FG4bsPVigE0w4nQxgjxSDrgEx1hRNcyTL2s4o
         FujxkYe+Y1Izo0haVVTYDIBqEhZWEbsmGQ9xC5nh19SkNEgaqYeoODTfbMaBLtLv+GyQ
         uzcMTtoIr9dZoPYuORCspU0Xd933XoykZY6qrEVhWtK10Tr4byEgEtYbkn7bb6WAuXFq
         vBuA==
X-Gm-Message-State: AGi0PubReSTPsxWWHrPOxvn2EdhSSuOjMHWeeQUEyk/9+g4/l1gsNoYb
        wJZSXudwLBtByAdE5VdugIJE+A==
X-Google-Smtp-Source: APiQypJaoc4lP9v92w9nAC8tQaT+r7VsVpkADPHchkzskz2PFxvkM5sQgbwb8qYWtSHzTZgS5gLgZQ==
X-Received: by 2002:a02:b055:: with SMTP id q21mr26504210jah.7.1587568178617;
        Wed, 22 Apr 2020 08:09:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e11sm1834430ios.55.2020.04.22.08.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 08:09:37 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Check required filter files before
 running test
To:     Steven Rostedt <rostedt@goodmis.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     shuah@kernel.org, ice_yangxiao@163.com,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        skhan@linuxfoundation.org
References: <20200422095807.548519-1-yangx.jy@cn.fujitsu.com>
 <20200422092110.6a4f0cfb@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <583feda3-5605-f242-b3b0-37c15fa38a58@linuxfoundation.org>
Date:   Wed, 22 Apr 2020 09:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422092110.6a4f0cfb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/22/20 7:21 AM, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 17:58:07 +0800
> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
>> Without CONFIG_DYNAMIC_FTRACE, some tests get failure because required
>> filter files(set_ftrace_filter/available_filter_functions/stack_trace_filter)
>> are missing.  So implement check_filter_file() and make all related tests
>> check required filter files by it.
>>
>> BTW: set_ftrace_filter and available_filter_functions are introduced together
>> so just check either of them.
> 
> I'm fine with that.
> 
> I'd like an Acked-by from Masami, and then Shauh, can you take this?
> 

Yes. I can pick this up after Masami gives his Ack.

thanks,
-- Shuah
