Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB5F29C857
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902440AbgJ0TGt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 15:06:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34487 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369529AbgJ0TGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 15:06:46 -0400
Received: by mail-io1-f65.google.com with SMTP id z5so2760239iob.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=coz6L+xiFoQZV2Vxdqg9iD/Q24xRRVSUodgb27gSoZI=;
        b=NZtVctUU8Wlajt9aO3t4DyQNeU4xDeX79lGJwlAy+vpQiGx73VmhgKRVbFl2ldRUzh
         AS1j+ImOWNJyHPXsQRlAYwDpJdrFG7+1dGGiRrM8Bj/mvM3Sh7UEO78o6P1KAX/nYQGx
         qBG9qTgnmRXKCnP8K72A2EpefUUlte38amUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=coz6L+xiFoQZV2Vxdqg9iD/Q24xRRVSUodgb27gSoZI=;
        b=CqQEhpe+iQE6GX6zE5Xs6koBsWGZPFAhHK0XlmRFykfR4B+WoSyqivZsd2w2w65ebz
         Wu5d3Is3lbDCa+cgUaINHiCm1NoLHJ8rcr5Wl3daN2SK6H8E0Hr5ysBQd1WXdMyBxws+
         Li6Kgstyb4IfDNToKVpaYTTA0gGG2fxTcuV/aoU/zfXCVZZS3OyRdXWqAJjWzMHjt46G
         iEUi7m1iKYNPhGL41gfbfT8bRidxKyFzuTB38pv0tEwur9TfWAWbO4gSu1K4ht/vGLEo
         Td+HFuSeLL7YxWYOQGGf01RsMSXU0sDcXv8PLErGwcj7xJodCof9yCM+hsVo11mNqBBG
         ORaA==
X-Gm-Message-State: AOAM5307BEk4CieP7T4efsC0Hhlp0qJm17DFs+hDES/IiyhaRvlvxVxD
        P7dYr10rb7jFUGLg1OkCHSk9Bg==
X-Google-Smtp-Source: ABdhPJwA0O4Oz5p1kn4CgBnlbdtAWAnkTmCiYd1F+ZisJqDaI+vUGpTJ7L56/22cOXVDAcVi1P/frA==
X-Received: by 2002:a05:6602:22cf:: with SMTP id e15mr3416769ioe.1.1603825604788;
        Tue, 27 Oct 2020 12:06:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n15sm1354758ilt.58.2020.10.27.12.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:06:44 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Use $FUNCTION_FORK to reference kernel
 fork function
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201026162032.124c728d@gandalf.local.home>
 <20201027223831.dba931ab868584fc999b0617@kernel.org>
 <20201027102548.713c4604@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3ba0fbc0-1071-48a4-5821-fbbe75f96d29@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 13:06:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027102548.713c4604@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/27/20 8:25 AM, Steven Rostedt wrote:
> On Tue, 27 Oct 2020 22:38:31 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>>>
>>> Fixes: eea11285dab3 ("tracing: switch to kernel_clone()")
>>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
>> This looks good to me.
>>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Shuah,
> 
> Can you take this through your tree?
> 

Yes. I will queue this up for next rc.

thanks,
-- Shuah
