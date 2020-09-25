Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1E279443
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Sep 2020 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgIYWhs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgIYWhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 18:37:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17557C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 15:37:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x69so4408282oia.8
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GUnPWZQb3wmsz17jd8cPsFjDlwSIdeaeunn4YKd8bc=;
        b=cUGmiVVab0u8mYTiDe3U8u1ya2bN2aQHwiRyr0oN+SEQeoBac0yel+rVAJpG23d6Cw
         SkWYyhXR+Q0RhmtVczpwc52Ra7P92GEyVfLujifP74L85bN+J8e9V+D07zbcd4hggTWn
         sTf5Y3Nm3Lj+rn13yl8gTMvITuy5xWYxaBBBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GUnPWZQb3wmsz17jd8cPsFjDlwSIdeaeunn4YKd8bc=;
        b=iQVcqCAnZoajqYOSBKnyQCwHdLoVq8t0/Aitq+DJAbdZdw2SJupqNBWIiQvnt9xYH+
         RQ/avtU5xqfunkiu03Lzek7OOWD5KuDIkjSXJCdTkBbFuTc8zozhxBSM9Nc0F3sus767
         p6CEBwdDiNT1oCN6AtnrOIh3tXHmBzlPv6z7JyfdkRXhNxPuWpvPhaE8iU2hG76ZuZ5z
         oQlygZL41RFHMstBRLegE/4uWF1d/FEyiclUUhnY0KF8nvqX8Vt++TWBYDLvlfgzNy+v
         8ocVHXaY+7KonlAfrnzrtJLZ/0nhkAUU4J9LoOw9hdKe9q+RmJJTeWDlGrMikswkCCxa
         0maw==
X-Gm-Message-State: AOAM5309Pm6SEIbKuw2Lpu9peclpsmV2koeRyQtzF5cjuTz+uOACqvgN
        ywteKQtIQpOtUxg3YDQ/CE9Hwg==
X-Google-Smtp-Source: ABdhPJzlc9XcIwkgj1jA3voZXHCy+z/zzMdn6CUvY2QhJa2e+80Yy/KlTGUEECczFqtoREwqoRqFAA==
X-Received: by 2002:aca:d693:: with SMTP id n141mr496407oig.26.1601073467264;
        Fri, 25 Sep 2020 15:37:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i7sm983027oto.62.2020.09.25.15.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 15:37:46 -0700 (PDT)
Subject: Re: [PATCHv5 kselftest next] selftests/run_kselftest.sh: make each
 test individually selectable
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, Tim.Bird@sony.com,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200914021758.420874-1-liuhangbin@gmail.com/>
 <20200914022227.437143-1-liuhangbin@gmail.com>
 <CA+G9fYvT6Mw2BamoiVyw=wLUqD-3LB2oaDqcuabOyWfFxEN1qg@mail.gmail.com>
 <202009251414.15274C0@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <659b23c9-abf5-0387-c4c6-5d0a48e3afdc@linuxfoundation.org>
Date:   Fri, 25 Sep 2020 16:37:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009251414.15274C0@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/20 3:16 PM, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 01:51:53PM +0530, Naresh Kamboju wrote:
>> On Mon, 14 Sep 2020 at 07:53, Hangbin Liu <liuhangbin@gmail.com> wrote:
>>>
>>> Currently, after generating run_kselftest.sh, there is no way to choose
>>> which test we could run. All the tests are listed together and we have
>>> to run all every time. This patch enhanced the run_kselftest.sh to make
>>> the tests individually selectable. e.g.
>>>
>>>    $ ./run_kselftest.sh -t "bpf size timers"
>>
>> My test run break on linux next
>>
>> ./run_kselftest.sh: line 1331: syntax error near unexpected token `)'
>> ./run_kselftest.sh: line 1331: `-e -s | --summary )
>> logfile=$BASE_DIR/output.log; cat /dev/null > $logfile; shift ;;'
> 
> Yes, please revert this patch. The resulting script is completely
> trashed:
> 
> BASE_DIR=$(realpath $(dirname $0))
> . ./kselftest/runner.sh
> TESTS="seccomp"
> 
> run_seccomp()
> {
> -e      [ -w /dev/kmsg ] && echo "kselftest: Running tests in seccomp" >> /dev/kmsg
> -e      cd seccomp
> -en     run_many
>          \
> -ne             "seccomp_bpf"
>          \
> -ne             "seccomp_benchmark"
> 
> -e      cd $ROOT
> }
> 
> 
> 

Will do.

thanks,
-- Shuah
