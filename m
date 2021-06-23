Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEB3B1B44
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFWNik (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 09:38:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59735 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFWNik (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 09:38:40 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lw33G-0006Xw-5q
        for linux-kselftest@vger.kernel.org; Wed, 23 Jun 2021 13:36:22 +0000
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a7bcc960000b02901de8f2ae18aso615709wma.8
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFaa8u6W+zDom/9rBhd6/YlSvLvLkN2VZM0WHG/5NHM=;
        b=OnjGq7p2lr9yLe6ikZpdOda00+XdNHHuYHaD78UvEFY2s3zBVuAYRNZLjoY7S65fdo
         CmMcIvD6e/uOiVk8gdse7Kdh40NtMe3jPcK+hgehE4+HMOfF97s2kJIApNL1qkfBJM3h
         SUHCn7vwNz7MJgqecZwWHxX/eGjWyRdl5p2Sy30wBMlOt6uy29xyrUJpUV5liSssEM7y
         CkvtpEAHfXstnM7W2lPtXg6ACxzZH/I5KxR/4LmkdVgZvKUP/IY6EAmcI/Pf2lTYymym
         7FTrfQ8KI5VTRnEFXagQSmfayvRrkLt2aHJokk6GRSKUEF2y90idPVpM3lrXk7yKmyBj
         6b1w==
X-Gm-Message-State: AOAM530F/FH5Nh+oRkFIuLpJVFfpRdYoAj+RQfLq/Ffw0VUuylOPZsjH
        MqDhcBo8GVohxLf2hR+mHvAWKf45MwxP4oO94ab0tCv6ouA6Wss+En+SGBOk6ma4L7RmT1sMMNU
        he/dTPCohPGQnnyB8Cdx0aWh5Mm2UUzo6lDJSPqMDiSq3xw==
X-Received: by 2002:adf:d1e5:: with SMTP id g5mr92010wrd.0.1624455381987;
        Wed, 23 Jun 2021 06:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybRy5wqQi/MyRrYzKMVng+kPSe8tybjz3FcM588XL8VQzXNstrtsEbZkVnPOoRf/kVevdesA==
X-Received: by 2002:adf:d1e5:: with SMTP id g5mr91997wrd.0.1624455381817;
        Wed, 23 Jun 2021 06:36:21 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n18sm5977606wmq.41.2021.06.23.06.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:36:21 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: fix event-no-pid on 1-core machine
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623070431.16592-1-krzysztof.kozlowski@canonical.com>
 <20210623085217.036b7e8d@gandalf.local.home>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <02d3ed4d-1814-b16d-1885-e6b173e071d0@canonical.com>
Date:   Wed, 23 Jun 2021 15:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623085217.036b7e8d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/06/2021 14:52, Steven Rostedt wrote:
> On Wed, 23 Jun 2021 09:04:31 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> 
>> When running event-no-pid test on a small machines (e.g. cloud 1-core

If someone would be so kind to fix my grammar as well when applying:

s/on a small machines/on small machines/

>> instance), other events might not happen:
>>
>>     + cat trace
>>     + cnt=0
>>     + [ 0 -eq 0 ]
>>     + fail No other events were recorded
>>     [15] event tracing - restricts events based on pid notrace filtering [FAIL]
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shua, do you want to take this?
> 
> -- Steve
> 
>>
>> Schedule a simple sleep task to be sure that some other process events
>> get recorder.

s/recorder/recorded/

I can also send a v2 with fixed msg.

Best regards,
Krzysztof
