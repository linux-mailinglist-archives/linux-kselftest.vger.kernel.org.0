Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E41B73C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXMWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXMWY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 08:22:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED242C09B045
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 05:22:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e8so9044826ilm.7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ElW66CEulda9Y4ovzb0ekLp4iIKON7cFIdh0cvua9lc=;
        b=apfqnI9q0cQrKnsazbrdD2i4pBRgeRUHMYYONh/Za8UUB69RCJIXNqvxgwmGRBBvhB
         AETFgn/QO0HZ897rDqZN8Ffp7aXw/PoFtTsbkOZxIvWdf1xqnpqF+xEJrSRGNcCMzoe2
         aex3dEDORmZg+cXfUy+Tk7AU6I35J+ppyB060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElW66CEulda9Y4ovzb0ekLp4iIKON7cFIdh0cvua9lc=;
        b=Qrzse9T0RgnFj/6eMlfs/kPgYOZqA6a3FAd8zdhi9IqPJ8Y22jV7KI9IE4ejVC8p/m
         HjAjDPnD3iW+SBmXMuISiXhQ/vpdrnUuo3vZfGQ7WEP9E/p4ALWGtnS8ewomPPnCr+Wq
         aNFAWJ7RdHU4EvSMu5NksRzeK+h0e3tdfjYPB2nxmqLBVrI7T0WBldpXKdlppGbazIaw
         8t7dTZE2P49abrJ9NBpNm9EvkHYaL9lPZAGjCyQjk1qG6ih5l1IvPxDDtCz7usAmURNY
         QKWk3eJUrPF61WNf+NlmYvWDP83nLQ57lEPYC1Xm+dyOObZyiP0IxB496qdMbjV2SMYd
         Y7vQ==
X-Gm-Message-State: AGi0PuZbP2adVERPQoV/1vOcZIiAiY0XUpPSxJogErST5vPy4ACiDtgB
        1WQvQdln6ofhPJ9VHAIx1L0tdA==
X-Google-Smtp-Source: APiQypJ66JgX2d7t70NA97tiLDfTCIkwj4PIIj6dHFTmq/QguJp+9UtomBJDuKDeoym1KJFq6AFSrQ==
X-Received: by 2002:a92:2910:: with SMTP id l16mr8609485ilg.256.1587730943299;
        Fri, 24 Apr 2020 05:22:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m14sm2021928ilq.68.2020.04.24.05.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:22:22 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Check the first record for
 kprobe_args_type.tc
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     shuah@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        mingo@redhat.com, ice_yangxiao@163.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200407063419.292821-1-yangx.jy@cn.fujitsu.com>
 <20200407095400.2a13b821@gandalf.local.home>
 <20200408003026.24627a881c8f1eacb01cea48@kernel.org>
 <5E96611B.10100@cn.fujitsu.com> <5EA23D0F.5020304@cn.fujitsu.com>
 <20200423211809.7cdb1f90@oasis.local.home> <5EA242A9.9060104@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5d693b71-1afe-9147-52dd-53824255a49b@linuxfoundation.org>
Date:   Fri, 24 Apr 2020 06:22:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EA242A9.9060104@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/23/20 7:36 PM, Xiao Yang wrote:
> On 2020/4/24 9:18, Steven Rostedt wrote:
>> On Fri, 24 Apr 2020 09:12:47 +0800
>> Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>>
>>> Hi Shuah,
>>>
>>> Ping.
>>
>> Shuah usually responds to her linuxfoundation.org email a bit better [ 
>> added ].
> Hi Steve,
> 
> Thanks for your reminder.
> Sorry for the wrong email(shuah@kernel.org).
> 

Thanks for the ping. Will be applied shortly.

thanks,
-- Shuah
