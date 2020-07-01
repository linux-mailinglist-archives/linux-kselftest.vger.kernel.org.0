Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8221134D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jul 2020 21:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGATKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jul 2020 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGATKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:36 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A25C08C5C1
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Jul 2020 12:10:36 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id z23so1287605ood.8
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Jul 2020 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQpzdbIjf113I5LT5xAH3Pi/R/4lrflrWxNFquDKW28=;
        b=FdoyLiw1YEaBJRmbvHwoiLGnoqBFL3sVYQzGpdYTkcc04w7rUWrpiD2CRsjH6qrCqD
         N0OmiCsWjkFTIO1gSatiKqwyKJkvNM7S2l0mAtNk9bA3iQf2fkMCQ3Wu0ZNyFKL8896X
         eVTqaFq/UaoMB5yU04svOiDK4sbp5tLO2/Lkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQpzdbIjf113I5LT5xAH3Pi/R/4lrflrWxNFquDKW28=;
        b=Nqo50/7HNjsg+5+HAINneNrBz21Jp+tPzTr9QIHnG7DnVHa8t4oX+Ig+UcY1PIYNeh
         I0rxIZlB1Y8mUj96yc7YzN77oN9mYCkaKs6QIYOh8ocJOzC8G/iQP1YdIrGim/veStit
         jb3YQaQdw1WFESBZmbIlwCeBpCLeR1jPOEt5mG2KG9b0I++v33TrtqO9bFX1yeRh7ySM
         U8KeROxxykgnW7BbYJJNHI8r9e5BxoE8uKu7KWTTiVIAjs2H99w7QbT39NtFv0W7Xhc2
         r2LXU/bOYjcsl4X8I7XAwqI2BWLxrYRkcVY6Chq0iOJ+6Gh9cneIrGTYT+SodFwJKR01
         Vk5Q==
X-Gm-Message-State: AOAM530N60mGuMQTWe+pPQSk/kqv8LjMXs8JKUKvup2MvbqRHQdo+DuI
        ezj/8hnu9+dohdxZMaD+ops/6g==
X-Google-Smtp-Source: ABdhPJzx9z5yTTETBz/pqFVx0iHUBPxUsqSF0+zDs9TcGwYfRAte2MthXkwd/jt9wLGnktCfYhVTFA==
X-Received: by 2002:a05:6820:50a:: with SMTP id m10mr24591794ooj.54.1593630635940;
        Wed, 01 Jul 2020 12:10:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a204sm1627823oii.34.2020.07.01.12.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:10:35 -0700 (PDT)
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with
 space
To:     David Gow <davidgow@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
 <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da025a82-17ee-e8bb-61dd-e655f0087d8f@linuxfoundation.org>
Date:   Wed, 1 Jul 2020 13:10:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/30/20 1:15 AM, David Gow wrote:
> On Mon, Jun 8, 2020 at 5:57 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
>>
>> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
>> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
>> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
>> parsing which did not like the spaces in the string.
>>
>> Fix this by updating the regex to allow strings containing spaces.
>>
>> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Tested-by: David Gow <davidgow@google.com>
> 
> I've been using this patch quite a bit, and haven't hit any problems.
> 
> +Shuah: Any chance we get this into the kunit branch sooner rather
> than later? The KUnit tooling is quite broken without it.
> 


Applied to linux-kselftest kunit

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

thanks,
-- Shuah
