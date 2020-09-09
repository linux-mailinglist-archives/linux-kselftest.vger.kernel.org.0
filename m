Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7026388A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 23:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIVfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIVfD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 17:35:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CAC061573
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 14:35:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so4822931iof.6
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iFwcM5UOt2dpyB2PsU5iJo0w889YT6WLHO2nVi3J24g=;
        b=J0LLvpo1cupuJbGq53hbp03wzOvwvtjlXRh2BNTpOPik1+TAzMNARHV+0u9Dsqkw2Q
         UVOWKAKJ0/pJuo+XPq06078vVF/QefyQepMqhy76QGGMwWtFW1nE8/N1lWk/4aXezzt9
         0QJebhL8Lhz8LjxzL/CNjj3l1uEIXaLl2IL44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFwcM5UOt2dpyB2PsU5iJo0w889YT6WLHO2nVi3J24g=;
        b=M9cabu2pktgjEe3jnWKsIeYgRzGHwD35J0y+aCM9qsRIrwgEvDIBVfVsHoni7kSGA2
         /5bIEvKsGwfka4shCbcaQ40PxHQrupdyQ/06zIwQSMjFRWdRf9j0iwKcPctm1MYMgeWl
         RJKFL+fenctmJcFjdH6wsdB9Rfti3ECiYn7zZWyEf2tC3amHVgIIx6FfU224DiSK+EFb
         IV3hyanjtGTvYH2/5WarA19p1H8UPIzKG/Hy86+5DZShbbcqZjw7AY01+5aco1erzLLo
         HH2xNJg7s+ELp0o4duUdyFmOX0KePVCYttf0S/T1S0pVpLWqyx+5dCUtO0yld3WA+THj
         EjrA==
X-Gm-Message-State: AOAM530UE2v47HHNvWy0WUtP5KI8LdNawqUtBYDQk5h09dinYGQ+/rjL
        CmtL6UZUmtGbwNqmWeiTgSIx2A==
X-Google-Smtp-Source: ABdhPJw0ea5MrnRi+Y4QQcTgIBMEGCPv9JcBQ/7/MH5C82chfmjUlsoEHZA7di9RgOwbJPC4KJqDSg==
X-Received: by 2002:a05:6602:22cf:: with SMTP id e15mr4928006ioe.114.1599687301932;
        Wed, 09 Sep 2020 14:35:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m12sm1939383ilg.55.2020.09.09.14.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:35:01 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/lkdtm: Use "comm" instead of "diff" for
 dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20200909211700.2399399-1-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f92a05d3-6932-d644-e95f-d63c0a34fa19@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 15:35:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909211700.2399399-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/20 3:17 PM, Kees Cook wrote:
> Instead of full GNU diff (which smaller boot environments may not have),
> use "comm" which is more available.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: add --nocheck-order, thanks to Joe Lawrence
> v1: https://lore.kernel.org/lkml/202006261358.3E8AA623A9@keescook/
> ---
>   tools/testing/selftests/lkdtm/run.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index 8383eb89d88a..bb7a1775307b 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>   ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>   
>   # Record and dump the results
> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> +dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
>   
>   cat "$LOG"
>   # Check for expected output
> 

Greg,

Would you like me to take this through kselftest tree?

If you want to take it through lkdtm tree, here is my Ack:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
