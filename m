Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD971E89FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgE2V0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 17:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE2V0I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 17:26:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F15C03E969
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 14:26:08 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g5so2571443otg.6
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p8dAPHZz+ht/nN+XghF1uMTld/TMP+BOizxf53N3zQw=;
        b=EBp/atAcNaFN+6puN/Jwb4WUQOnZtbjjBHlfOyk5q7ALw8VT2t5On9HYf8HxTqJNVO
         TqhBj4hRJC/0T8uzNoKe+c2rPuMyrCaCgsZPDHg4BT3UJ6/b8iUE8SQ15qBpk19qHVVG
         0o8CsdaoQRbPfklS3B0KS0zjqfQ1pVpf+sNZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p8dAPHZz+ht/nN+XghF1uMTld/TMP+BOizxf53N3zQw=;
        b=JVS+CQT12iZoSb3D7zlYsqGiN367G8yahJlzdVIo4M1+PsV6uKcyIguKG2/a7a50lI
         U5+es+yVVYHK40qj59dvy5AreoR9IVTZiFAnTmiOaAYWezzE1+rEQld+m0THXBiZuv2j
         szWYDBaKjuNSryFGJKR71tDrtvdMhsN7d+EOavF5QHJhU6CaZUxoyx4dR/tIAc38jz11
         oKF9gC4Gkg8pefMoFdfW4jrZ/aX0m4zZSZp1FJY/GiHu9HzZlm2hHTl3+8Hw5U+53ohT
         lAKrfWlG9ePZpI8OBuDguYJ27t6tLSz3wHXuWDKuQqp7CTTfKTqLpFMLf18U9FMsGSXf
         nrVA==
X-Gm-Message-State: AOAM533UxNE9MdmORlASU3X/rcm+1N+KQ+6NdOPo+SAxWEfklQM34iph
        U3Z1ip1chwWhbVcWEBmc30H+3w==
X-Google-Smtp-Source: ABdhPJxEZN3jHXCnJyt5F95GaRnw9TqHldrmjpzX0qnxxu2yYQJLNj90XywZQvbi5zTEizxNkgqYhQ==
X-Received: by 2002:a05:6830:120f:: with SMTP id r15mr4105004otp.348.1590787568026;
        Fri, 29 May 2020 14:26:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f15sm2782569otf.81.2020.05.29.14.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 14:26:07 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in kprobe
 syntax error tests
To:     Seth Forshee <seth.forshee@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304222009.34663-1-seth.forshee@canonical.com>
 <20200529203704.GA57013@ubuntu-x1>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
Date:   Fri, 29 May 2020 15:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529203704.GA57013@ubuntu-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/29/20 2:37 PM, Seth Forshee wrote:
> On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
>> Test cases which use echo to write strings containing backslashes
>> fail with some shells, as echo's treatment of backslashes in
>> strings varies between shell implementations. Use printf instead,
>> as it should behave consistently across different shells. This
>> requires adjustments to the strings to escape \ and % characters.
>> ftrace_errlog_check() must also re-escape these characters after
>> processing them to remove ^ characters.
>>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Ping. Someone just asked me about this patch, and I noticed that it
> hasn't been applied or received any feedback.
> 

I pulled in this patch from Masami:

selftests/ftrace: Use printf for backslash included command
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=8e923a2168afd221ea26e3d9716f21e9578b5c4d

Looks like a duplicate.

Seth,
Is your patch still needed?

+ Steve and Masami

thanks,
-- Shuah
