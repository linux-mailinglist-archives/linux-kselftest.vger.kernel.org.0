Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9212C352ED7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBSAE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBSAE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 14:00:04 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8ACC0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 11:00:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so902171iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BFK8O3WQDC/M3xNQ5jj1jPcFnLd/RsWWduVYJodGfgs=;
        b=Fg+LZ/bWuSp3caeP2E/PMSIh1TMI/fM6q3Idcoe6k/lNQl2ksGVDTf/JXO/goUN+Kq
         vMIqg9+4U1YSfKE8URkqr83NYZPP5X9p/tXVE3sMrD5LPBtpjFi3zkBRZXlVTIjSm9Q/
         2hcYG9pFKPGNi7a+xDAEEnI/ECn46t1ZUCDlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFK8O3WQDC/M3xNQ5jj1jPcFnLd/RsWWduVYJodGfgs=;
        b=LhFVdEf+JrAybymYF3codC4FZGfJA0vtsYKblrFTCv9NxlCVw6D1Z1DS+DZ7E0FP2q
         6iOgD8U4OeLgkOXPvpDxL64XP181SUdaFIques8IFevhX1v0wVx+aAywCAUebL55e3pl
         +kYNnKNJxyDsw5ariM6qC03ZU5GiJQtAlr9BC9m6JPuKsiI0/HJCUfxOFdLGmm8fd8Ye
         oe9UhA6Sb0SFw3vk0TqQf7D0d3VHikVwo9kX3kNUDEb6BiKFFDVkAxpqWiP1v0ZKWhg1
         H7q2lW10xYUVVxa9P05t7BVw0kra6dKR2dV5zlyPQBOcvft5sHSjMo4uUiTBJX69oZfm
         W0aQ==
X-Gm-Message-State: AOAM533tdQC3r9btOVZ+riFvQCVKtbx4X6ww6RW8FZLeX59u6miEGVbt
        2S2AhF/r7+7jqvAWaOG5ReEcdw==
X-Google-Smtp-Source: ABdhPJzAWExjZyPWCkQZ61xvtoYqEUWyPA7vvyPakTjAoToxiOIqcD2CDsH/duO6QxS0Soh8ILSxtw==
X-Received: by 2002:a05:6638:329e:: with SMTP id f30mr14077021jav.121.1617386402538;
        Fri, 02 Apr 2021 11:00:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e2sm4758575iov.26.2021.04.02.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:00:01 -0700 (PDT)
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
To:     Brendan Higgins <brendanhiggins@google.com>, dlatypov@google.com
Cc:     davidgow@google.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tytso@mit.edu, Shuah Khan <skhan@linuxfoundation.org>
References: <20210222225241.201145-1-dlatypov@google.com>
 <20210402093228.755260-1-brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <38510e93-843c-b0e0-5ad5-4953660de79b@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 12:00:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402093228.755260-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 3:32 AM, Brendan Higgins wrote:
>> TL;DR
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
>>
>> Per suggestion from Ted [1], we can reduce the amount of typing by
>> assuming a convention that these files are named '.kunitconfig'.
>>
>> In the case of [1], we now have
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
>>
>> Also add in such a fragment for kunit itself so we can give that as an
>> example more close to home (and thus less likely to be accidentally
>> broken).
>>
>> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Should this be captured in  documentation. Especially since this
is file is .* file.

Do you want to include doc in this patch? Might be better that way.

thanks,
-- Shuah
