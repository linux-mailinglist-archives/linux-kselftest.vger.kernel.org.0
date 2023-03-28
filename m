Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3D6CC830
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjC1Qi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjC1Qix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 12:38:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE29D533
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:38:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k17so5620260iob.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680021522; x=1682613522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9KH8xtjT2uay9RuE8InbX2zUThEe1/Y3p+Ny+ncZsQ=;
        b=PytFRiSdnJikNU1nfaYuauOKvTIz0ErnRZMUxY2Cz1177f9USRCA116Akn58EcBll4
         YhZ4W7Wz8janbfNCyn3IgXfC3Wt2JKnxLm2yF4g3FFyPZuYhOEOFJbWS63KqZC+azTCn
         5kiuYWy+00/QbPPK+468NDppzKZh1yt+vDt3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021522; x=1682613522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9KH8xtjT2uay9RuE8InbX2zUThEe1/Y3p+Ny+ncZsQ=;
        b=6vTNnBRNYCFjfbFLipuHrgrbHffky1zaD0umkr+QHxeNMsAMOOTNMDSrKKv9lODzo/
         ygNqwMJ0taTAGAaIcvePnBxT/vhyxLslhzsqyTO/YRRkL3njx9T9W0L65uT0QLHrEpNk
         xAHulQSyYetLMDqajueJGEvVCszVsIDrcogJRaUc8qEGfaH3RewxYwyx/aOqakVfFENX
         8YLMMDbebjZ6F2mohd1xe31yPtvld1sCR7aKkoTctd1oKL6Vsx7hAxqpoXO22TpmMwgc
         7L42kk3dpJ5Z4/d30vp6tYO+2TgaHmjqOCE6t9uhMwiSfkx2uo1mDN8CA0knLHvwD5oY
         NEHg==
X-Gm-Message-State: AO0yUKXqS1zgoKCs4xT5D6k81kyT1T0n+7FKIOYR05zrfpq4KTQklFP7
        ZEPS/sCvcynvS9diY6wBiu+eklkHSC+3ZR5Ppag=
X-Google-Smtp-Source: AK7set/VnehVyoKm9sETjZ4TBO9vEVJfQpDQrPAW1oUdZAWB6BlMISkZOgxV5oAlXQH9LSavp6NmFw==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr11633484iow.2.1680021522586;
        Tue, 28 Mar 2023 09:38:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q12-20020a05663810cc00b003e8a17d7b1fsm10078548jad.27.2023.03.28.09.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:38:42 -0700 (PDT)
Message-ID: <68ef1d33-af91-48df-8735-49c6750f1b99@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:38:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] selftests: sched: Add more core schedule prctl calls
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     himadrispandya@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230327201855.121821-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230327201855.121821-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/23 14:18, Ivan Orlov wrote:
> The core sched kselftest makes prctl calls only with correct
> parameters. This patch will extend this test with more core
> schedule prctl calls with wrong parameters to increase code
> coverage.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2: Unnecessary printing removed - 'validate' will
> automatically print the message in case or error
> 

Thank you. Now applied to linux-kselftest next for Linux 6.4-rc1.

thanks,
-- Shuah

