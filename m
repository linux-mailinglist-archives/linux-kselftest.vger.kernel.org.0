Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DA2E0001
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLUSi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 13:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 13:38:27 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC62C0611C5
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 10:37:47 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y5so9728203iow.5
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ke00+sAaFKkeduiGcal2II6nKBm42LPXHyddS/muDEQ=;
        b=G7fsaFig/DFljtn5p26bOvwUMWDifoheK4lKy+CMb1ZFBoPWocHgz594Wv8wi0F9Jp
         zkAqnobCxFAMPqLrd1B/CFRib3g6p9YM8tEkDz8Rl4KVguTfPqQlMWNmg/Nkp4t0jAmg
         J00yCEFgePWBOwJzkE5hTJCbe7hD2okl05Kps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ke00+sAaFKkeduiGcal2II6nKBm42LPXHyddS/muDEQ=;
        b=ri4MR1kj6yx5RwyGH7CHSRU/C/WV5B5hDr6DyC/cNEGsVCqY/SkWmX7vQNk4lnpRGq
         f0Hd9AWwOIvIF2ak7VZm7DhHU9EaUvKRs6lyliJM3ef/gNfSF/qc6F7IBXPNPdt3g/Yx
         IDqAthEd69pi+S053lXCKLpWMGjs5FE3fUr1MOdFJJIu2xRq9AmZnGwS246Vl6CBHYsW
         3Ei9/znA7RPYBNZ83QQiYWjZQMQKU4dL8UjQyQ60+3uXqqFkvM+vhcbYxkpoGh8qSVpd
         RdzYqut6hjd8MpjZLvU1m7PK2Hx6PXUFnX598+ndehvKPzNbw1aDfo6EBQe+CEsQ7k46
         Cn8w==
X-Gm-Message-State: AOAM530HCBKey9832AOfTxJv809jf0XQSu8WGusM0NKbwshk54ridsAv
        0cIl7MeTec67diauoloqYvaTuQ==
X-Google-Smtp-Source: ABdhPJznuPZsJiFos5cD2/p2DqfDlBdezQs6HE3aX1yBCJxClA2z7gtzMYqEUy/Fxj7MbkJfmjydRw==
X-Received: by 2002:a6b:7108:: with SMTP id q8mr15091862iog.204.1608575866710;
        Mon, 21 Dec 2020 10:37:46 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z18sm13168153ilb.26.2020.12.21.10.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:37:45 -0800 (PST)
Subject: Re: kunit stopped working
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
Date:   Mon, 21 Dec 2020 11:37:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201221144510.GS4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/20 7:45 AM, Andy Shevchenko wrote:
> On Mon, Dec 21, 2020 at 04:43:02PM +0200, Andy Shevchenko wrote:
>> Hi!
>>
>> For last few weeks KUnit stopped working. Any insight?
>>
>> P.S. I guess no need to tell that my kernel on which I run tests has not been
>> changed as well as command line for wrapper:
>>
>> 	tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> 
> Current output (expected 18 tests to be run from several modules):
> 
> $ tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> [16:42:24] Configuring KUnit Kernel ...
> [16:42:24] Building KUnit Kernel ...
> [16:42:28] Starting KUnit Kernel ...
> [ERROR] no tests run!
> [16:42:28] ============================================================
> [16:42:28] Testing complete. 0 tests run. 0 failed. 0 crashed.
> [16:42:28] Elapsed time: 3.563s total, 0.002s configuring, 3.441s building, 0.000s running
> 
> 
> 

Hi Andy,

Please give more details on which repo you are using and the what's
the top commit.

thanks,
-- Shuah
