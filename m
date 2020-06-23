Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BFF205409
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgFWOAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732687AbgFWOAH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 10:00:07 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F8C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 07:00:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t25so18890263oij.7
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OWJaEeNqVLaBxo7u+h6+Cgpk3QyvR08wDj4Gz9NXugQ=;
        b=NA0QTCIU1je5pywavX2LTXsKBrnauupeONhOczDdedEK/5BNUj5Erf/sbtjCE2F9eA
         s9SlCsF5hKO5opzOeRrGAegvwpkfADx3SLQRLqf7mRnjrOj1A3rkM+1uHmcJqPku/6GK
         dSfJyzOo7GzkahV15M9LZbzRk8L3zPyj9qbtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OWJaEeNqVLaBxo7u+h6+Cgpk3QyvR08wDj4Gz9NXugQ=;
        b=gkm6m7k7q95TBe4rFlzeBOMaBumI8pa1RbjXFoTthmytJTmUMGiuG/TYgehTnJ8Vg4
         McyTYuxshHaFww/hPqJXKFyC0YDg8GE9fkAsUQs/lII7Y7WeyjyAqXClmlAB/kRgR7vx
         BQEB98vyNC9IRPGse2qZg3arZqnCBe7W2yRuD8OH7caF+bcHwjpJ7mOBB+PT2taUUdJM
         TGt8Rsg1NeLG1U5NFn2oflpHhHf4KIDwn9geJBsptFw1luXO0ObH1LZc6bc5mOltF/+F
         EgdOxNVFU1VWgDZfUalVIIW7Ms11A/EI0GY+TaZLGyRIb2AN2vHy0sSBWwSG2Frad/q4
         vh9g==
X-Gm-Message-State: AOAM530zNfr+eEv4tw1UAWHXdOrpsDqUgnYt0tK9pH7vqKCkJ4XyBDXN
        c+7WdnJ++d8J+7jTO++v4KjUxEN/0K4=
X-Google-Smtp-Source: ABdhPJyaiWH0vRxuZi7aWRwJC6faR9Wg+uqF32tTZr6jxgQa1tELNtstBcDFkGjaORmr9UxzEApbtw==
X-Received: by 2002:a05:6808:60d:: with SMTP id y13mr857118oih.121.1592920805917;
        Tue, 23 Jun 2020 07:00:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k7sm4159264oon.29.2020.06.23.07.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:00:05 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/3] selftests: lib.mk improvements
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
 <CANoWswkwYPmfMbh3U3NRc26JRMe3bkWHcfiMJ6fi-3fXT1OQLA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a63239ee-d198-9305-4690-167d83a05203@linuxfoundation.org>
Date:   Tue, 23 Jun 2020 08:00:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANoWswkwYPmfMbh3U3NRc26JRMe3bkWHcfiMJ6fi-3fXT1OQLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yauheni,

On 6/19/20 10:46 PM, Yauheni Kaliuta wrote:
> Hi!
> 
> Shuah, what about the patchset?
> 
> On Wed, May 27, 2020 at 10:16 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
>>
>> Fix
>> make[1]: execvp: /bin/sh: Argument list too long
>>
>> encountered with some shells and a couple of more potential problems
>> in that part of code.
>>
>> Yauheni Kaliuta (3):
>>    selftests: do not use .ONESHELL
>>    selftests: fix condition in run_tests
>>    selftests: simplify run_tests
>>
>>   tools/testing/selftests/lib.mk | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> --
>> 2.26.2
>>
> 
> 

I am planning to send them in for 5.9-rc1. They should appear
in linux-kselftest next this week.

thanks,
-- Shuah
