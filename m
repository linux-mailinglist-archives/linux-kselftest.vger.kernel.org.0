Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B544348CF6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 00:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiALXvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 18:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiALXvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 18:51:15 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287EC0611FF
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jan 2022 15:51:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z19so376734ioj.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jan 2022 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CvvG6Sg5CRn0S0loFvtHz3tC3c34qm3FIT7bwi49zU=;
        b=OYDJaZdUTGuRaroxFXXXNdTr51ykvM0AH51j04gwQqdJAUknTFQHloDZAwcIFCBiFZ
         1pW9K243gh8Rv2VPOVecIhOudZ7Is2czEmGsh0yLW1ZcnF9m+HS+CKhgBKLpojiFnBcv
         GM1lR4Pmy/iELtFjIYjkp3K09X+yrltigfhfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CvvG6Sg5CRn0S0loFvtHz3tC3c34qm3FIT7bwi49zU=;
        b=Ky+UVpe5XgT6rqeuhtA29vD57rEw51zswT7KfiyKm6oH4YK7PuhC/N+Zql/6FrE66I
         C0vQYUbd39FLFY3PMxsuN8isjOOhWfKf4EnR8nGPVItCgQXHlbumZqh2cG6XDyo39fiZ
         6g1dqlrNVifZOx8wQY+3DdytML5IMKQSlud8SRhfxu8IynlLzr/CRtLzi8xU6ckG5PAA
         IDk2kpLwdrf1dtfuka3dF0LcUexB5UqQe26gu8VpwfGwKgFDE9TXa83pXv5XycxAp/in
         1wgFZxWtr800c8+E7morMaQ6EF5yNoHMTiecymZS9tprgI6SkdDwgVPOEvQtkxY0Qujc
         Vg1A==
X-Gm-Message-State: AOAM531U8TSdsuptwI2bX1OJ/KirAp1Xii6+nMh1CHYqgGXA/oQf31/F
        q1ecFYmak7uGLy5GOOBlPD/MdA==
X-Google-Smtp-Source: ABdhPJymO1uP67tDwkSLUyfdC2hMMiuA+ArDBEMBICjwJtjISNY2I19w33OarazW9fRbTnq0yUQ7Mg==
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr979952iow.153.1642031474992;
        Wed, 12 Jan 2022 15:51:14 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a12sm930874ilv.69.2022.01.12.15.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 15:51:14 -0800 (PST)
Subject: Re: [PATCH v2] selftests: rtc: Increase test timeout so that all
 tests run
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220112194142.3276385-1-nfraprado@collabora.com>
 <Yd84cDlW9+f7wQxq@piout.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f286a86d-6371-d8bd-6ca9-5f622468d1a4@linuxfoundation.org>
Date:   Wed, 12 Jan 2022 16:51:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yd84cDlW9+f7wQxq@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/12/22 1:22 PM, Alexandre Belloni wrote:
> On 12/01/2022 14:41:42-0500, Nícolas F. R. A. Prado wrote:
>> The timeout setting for the rtc kselftest is currently 90 seconds. This
>> setting is used by the kselftest runner to stop running a test if it
>> takes longer than the assigned value.
>>
>> However, two of the test cases inside rtc set alarms. These alarms are
>> set to the next beginning of the minute, so each of these test cases may
>> take up to, in the worst case, 60 seconds.
>>
>> In order to allow for all test cases in rtc to run, even in the worst
>> case, when using the kselftest runner, the timeout value should be
>> increased to at least 120. Set it to 180, so there's some additional
>> slack.
>>
>> Correct operation can be tested by running the following command right
>> after the start of a minute (low second count), and checking that all
>> test cases run:
>>
>> 	./run_kselftest.sh -c rtc
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thank you both. Will apply this for 5.17-rc2 once the merge window
closes.

thanks,
-- Shuah
