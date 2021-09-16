Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6722F40EA80
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbhIPTCU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbhIPTCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 15:02:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F661C122749
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 11:32:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b6so7663154ilv.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8oDQ/PC0mSs3tfTw7SUzq5zGa2yK3bL59PuFy0gaNQ4=;
        b=fdmi9guyDiY+WGfQKFUbJemkGvWWcLjut3+RZWY5yxh4v7lU1sI8q5O6Y7p76Qr6pc
         oaJPPp0swEdwZOhfay3CGEGf3kd7LDtUcCQZkyFuwI4NjcCgSfI2Oq0i9hEpgfAoLZRg
         w+n9zBd6KZSiG0DfO3+W57zlF5OOndBesPg1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8oDQ/PC0mSs3tfTw7SUzq5zGa2yK3bL59PuFy0gaNQ4=;
        b=bLFR5CYaHpexfsReGiF4fPledNhB9ByCq+EyPRvJ/kqflsKwhUGRSfPazjC1qkagV0
         ySkws8j4eZJ5yWSy2QmPfyYEH/mRNCTDM9qtXapLEnMABjP0Q0+ggYIyvVSlPTcSPI2T
         g9Tudi6g8IDawanRo3a7rL9SgNsOBtP/s3Nx9L2QybaKsX/bRtirDEQS73TZfND2Us0Q
         pQBH7rpwImrqPnmOK7PcC7wH3c/iPgZpMZwcis7kP1TbEzgsccjHyJh3EeucwUyZ7Mlc
         wRSyyeh6D+2SIEXUC99H3fvX6wwovtJHUFHgFppe/lt+ESsy1c4Idp0UicUcIRDCMChl
         rffg==
X-Gm-Message-State: AOAM530u1OQY9Dld4l7La8XjubWTnVOAnapzVmu4wl7B7GZfxMKGEg4o
        +tGkkDJXN5CVDdAMiNajKSYo/A==
X-Google-Smtp-Source: ABdhPJzsX6aKm5BI529I3oWsqqT9o/Dsd54++LrAuYgdFelmJPfPeZqo50Bp2cV7MpPb3997QaI4Lg==
X-Received: by 2002:a92:d2d1:: with SMTP id w17mr4987377ilg.145.1631817119777;
        Thu, 16 Sep 2021 11:31:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm2026135ild.31.2021.09.16.11.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 11:31:59 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1631737524.git.skhan@linuxfoundation.org>
 <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
 <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
 <d9da3a33-6ecc-3d52-8f9a-f465692ecb93@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7e23dda4-72cd-db9f-44e3-6027375bb2a2@linuxfoundation.org>
Date:   Thu, 16 Sep 2021 12:31:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d9da3a33-6ecc-3d52-8f9a-f465692ecb93@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/15/21 11:06 PM, Paolo Bonzini wrote:
> On 16/09/21 02:02, Shuah Khan wrote:
>> On 9/15/21 4:34 PM, Paolo Bonzini wrote:
>>> On 15/09/21 23:28, Shuah Khan wrote:
>>>> This patch series fixes fscanf() ignoring return value warnings.
>>>> Consolidates get_run_delay() duplicate defines moving it to
>>>> common library.
>>>>
>>>> Shuah Khan (4):
>>>>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>>>>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>>>>      warn
>>>>    selftests: kvm: move get_run_delay() into lib/test_util
>>>>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
>>>>
>>>>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>>>>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>>>>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>>>>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>>>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>>>>   5 files changed, 26 insertions(+), 33 deletions(-)
>>>>
>>>
>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> Thanks Shuah!
>>>
>>
>> Thank you. I can take these through linux-kselftest - let me know
>> if that causes issues for kvm tree.
> 
> Go ahead if it's for 5.15-rc, I don't have any selftests patches pending.
> 

Thanks Paolo. I will apply these for rc3.

thanks,
-- Shuah

