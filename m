Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B3290C4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393211AbgJPTbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393208AbgJPTbo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 15:31:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A2C061755
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 12:31:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r4so5362261ioh.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CoJmX6IpKHCc1tXzEbve866HXUXHp5b/dVlN4op2hOs=;
        b=Hp8RiN00S4UbjdiAH9fYjKe26CEMWqNt0uxrzzh6X+5MxleKUZPwAD9pujs7214dky
         Pf0yW+uAMNd1To0E0/TJeTiVydZALRturHnEmIp5eVrrJR4GapmlF2oku37oSnakQBhQ
         CUr2JzPGlYFHvEOWXJSfyW5k8cBIrDW88rYs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CoJmX6IpKHCc1tXzEbve866HXUXHp5b/dVlN4op2hOs=;
        b=mlnDOcEteLzyt7Mj5we457zolCPy3wVUX7rKr+J8mIenK8TGulYK4AWvWfg8icApWH
         6/xGc4jcl2JEkINLShztaJ8/n88wKE5mYzKa7BF5EOQs25F3W4o1b4flgAK5+r8oJ7Kn
         cWpBdfJ19q3Qq0ayu2L34khBn3/jWTNIOQYYLochjB+NvkhcQFmaHoqX+yFUulclbJVZ
         y89V3I/OaC1Z8n6Ijc9V9oSDw63ZfQf86pE/J7Y15dnKeUNcLZrtY2bw3zPCu2R0xl+J
         gvTh8sy2bgurQa9CzSQoQvWn7HK/bGgSA6tpD+rxi0cHtWHYB2V+7VzpTdABGcv6lHQn
         KTSg==
X-Gm-Message-State: AOAM530Czr87M/Ws3OboK1h2h0YYWo5ONVoZcaNLEusvs8Q89Stc/iij
        luZFfUl69UrEcQFaFCBmzQ8LGWgEpOyqfA==
X-Google-Smtp-Source: ABdhPJzbPIoHRQtkSsGpRRb+pfDeM+Uu778/YVeXK+a58JIJHkGcni4XgazsI35BeJ3VPzkUHYlwXA==
X-Received: by 2002:a5e:c90c:: with SMTP id z12mr1189989iol.150.1602876703661;
        Fri, 16 Oct 2020 12:31:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x13sm3006127iob.8.2020.10.16.12.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 12:31:42 -0700 (PDT)
Subject: Re: [PATCH] lib: kunit: Fix compilation test when using
 TEST_BIT_FIELD_COMPILE
To:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201015120851.229242-1-vitor@massaru.org>
 <CAFd5g46TfFSTDO+SeYVrtJU8b+jYv_U9GWYhcGxGD4r1KHnxtw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac29f7b6-89ba-5bea-d138-d4f3a8ac4db3@linuxfoundation.org>
Date:   Fri, 16 Oct 2020 13:31:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46TfFSTDO+SeYVrtJU8b+jYv_U9GWYhcGxGD4r1KHnxtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/20 12:42 PM, Brendan Higgins wrote:
> On Thu, Oct 15, 2020 at 5:08 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>>
>> A build condition was missing around a compilation test, this compilation
>> test comes from the original test_bitfield code.
>>
>> And removed unnecessary code for this test.
>>
>> Fixes: d2585f5164c2 ("lib: kunit: add bitfield test conversion to KUnit")
>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>> Link: https://lore.kernel.org/linux-next/20201015163056.56fcc835@canb.auug.org.au/
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks for taking care of this so quickly!
> 

Thank you both.

Applied to linux-kselftest kunit branch
I will send the pull request with this in a day or two.

Added Reported-by for Stephen. Thanks for finding the problem.

thanks,
-- Shuah
