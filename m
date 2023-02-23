Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1D6A1114
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 21:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBWUPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 15:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWUPB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 15:15:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A244DE25;
        Thu, 23 Feb 2023 12:14:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so46798776edz.10;
        Thu, 23 Feb 2023 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677183298;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAb0qzqWSP/U+Kj5L5nLqdqYurAmo6JZhKfQvH683Pk=;
        b=BaLgVKhuX1clAmVVahaKedAK7xDb7n37VgbEl5j85och7Y9+re7M8ZB/GCXlN0iW4P
         RpY+bsTzN0egXJpJpNN6fArx526j4YSZMdYk9+RQAwoSaK8RddM/LoJ7NJ4WNge1jI4W
         293i+uUBsLoU17XWO6XQoOMRekI+h/hSXlrVMYaHq9e9lyshfu5uXQ+L7ErgJk07+5VO
         wf5Y+moJHpgaDl2hpoPsc/ktmPyHoaI1J4Y6eO9UQJ0D8/75X+SR2Hgj3Kz+Q7PDGUwJ
         wEKJF4emYuhPovJsIuKN13NKtTWZayn5CQ7InFhtxFJueiuJvH7c89YgRPQnJjKVVYvb
         GSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677183298;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAb0qzqWSP/U+Kj5L5nLqdqYurAmo6JZhKfQvH683Pk=;
        b=vHiNqAvc/PccALmoQ0EPjlIY/OOZ0T01LA7r3KzASoyJEByGIW/NZH+tGAtqUSElAJ
         oLoYWD3vgMROaHvbYPmHWE8FlDLzWEkJdE8YcNPPgGKqLFccypZuJS1EfamoahoR7AFb
         V0HRvl49KfDJo1oqZOBrrDvotbcZxP7OyL0TdlJeUkX+WFJjkKKWjzYY/h0Z6XoCH5AD
         lCumtMaP8W6dYssV33AtZNI6jPeIt/7W/oR8vuT2NzxECTUMhOETYgwLinwIOWiTYKC/
         L7R+HPg7+WyqrOTXovSMZ17OCejv66ti4tSgFp4FyogNaxlyGBKVfEa4WiBKq04XY7jL
         qPyg==
X-Gm-Message-State: AO0yUKX6gTOje0S46Up/4t35JVEHzME9YEEBEzM1O9oh7+lbpnmwz7Rh
        A17AcOpU+FIoKXEXv1AjA7liXXlvyaA0VM71
X-Google-Smtp-Source: AK7set+fyV8NY7swJO99sprnqCQsbhtz4OVtCCE4+qb/xglPT66O02/tvTfiEpZ9YzNZX/uhSq5ksQ==
X-Received: by 2002:a05:6402:34d5:b0:4ac:8e63:300a with SMTP id w21-20020a05640234d500b004ac8e63300amr12695555edc.3.1677183298324;
        Thu, 23 Feb 2023 12:14:58 -0800 (PST)
Received: from [192.168.88.131] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id s21-20020a50d495000000b004aee548b3e2sm5338830edi.69.2023.02.23.12.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 12:14:58 -0800 (PST)
Message-ID: <1db3bfe5-0982-b445-9c94-784478279028@gmail.com>
Date:   Thu, 23 Feb 2023 23:14:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Fix snprintf format warnings during 'alsa' kselftest
 compilation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
References: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
 <Y/eAyrYs+wEu180d@sirena.org.uk>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
In-Reply-To: <Y/eAyrYs+wEu180d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23.02.2023 18:05, Mark Brown wrote:

> What warnings are you seeing in what configuration (arch, toolchain, any
> custom options...)?  I'm not seeing anything when I test.  Are these
> perhaps architecture dependent warnings?
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Thank you for the review! I will follow the common subject lines style 
in the future.

I compiled the test via gcc 11.3.0 without any custom options, the arch 
is x86_64. There were five warnings during the test compilation, and all 
of them were caused by incorrect format in 'snprintf' function calls. As 
I know, using incorrect format in 'snprintf' creates an undefined 
behavior. Maybe there is a point to fix it?
