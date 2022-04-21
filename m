Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97250A93C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391619AbiDUTeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiDUTeZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 15:34:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C824D632
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 12:31:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h83so6396897iof.8
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HO73uRyd1X43sVJIiW9KkHmXq3f6HmsCw1YIk6coAE=;
        b=ekMuS1QzTvsonYzLao+l7J0dZQIQsAVZdPTHIQpineOOdoobgztqbHrGOhZoP5gnMG
         xbM0imCTgCOzDLHsBxp38lXBVmBwac8dHOvMBPSkP3XzbpBEXR/FLgxWg8Axu8NEaw2j
         NBYfJ0j+vNKusiUfPIbshPoEjqLRbPL8LUlBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HO73uRyd1X43sVJIiW9KkHmXq3f6HmsCw1YIk6coAE=;
        b=XfllGOCuZmhuzIObWy42QzE+HoXEJrBJ5TEHP1tzDyI7uKCatSTihTTerlQ/f+e1p6
         QXA0ygyyxbA/mzjc6lY8nNSQUJit/t7P1Ud59BT4x0Hn6MCxCMNkEkBl+19UaCCZQlry
         uR/ehG66xMldRAw3GTd4bvQP5EoVLfAMCcKKo04K/a8G4l9jXIqCuDrhFs4C5Bc000pX
         VMRVsVZvKwKWKkqP+g5cmDbChTmZ4nGuxPK4PIwSVJx4ONAdyVppRpQzuavX2m20stBQ
         KzwU3gMEiTXglEsGe1uvBsEQQNqJwLSPINXmi5r3FZy8Nl38P5/dZpwELCyUD+WWUdSM
         V9sw==
X-Gm-Message-State: AOAM531QP0u4C6jw1ypom2p8CTsFReSR5fdCyfXUw01ttuur0d19gX41
        Ui2AbTUpw3YFAXftJlvIwV/F2w==
X-Google-Smtp-Source: ABdhPJyyLsKZJlRbHN11h9x/HycYVP33FRQi2NRbguiHRjuWWF8Ezo+rPVk/UeaQLntzs1ANS+llIg==
X-Received: by 2002:a05:6602:27c5:b0:631:a30f:143a with SMTP id l5-20020a05660227c500b00631a30f143amr597205ios.40.1650569494038;
        Thu, 21 Apr 2022 12:31:34 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t18-20020a056e02011200b002cbe6ce18e5sm12533395ilm.40.2022.04.21.12.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:31:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] selftest/vm: verify mmap addr in mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff3db00d-3e18-8168-9f7d-d91a5591c7f2@linuxfoundation.org>
Date:   Thu, 21 Apr 2022 13:31:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/20/22 3:57 PM, Sidhartha Kumar wrote:
> Avoid calling mmap with requested addresses that are less than the system's
> mmap_min_addr. When run as root, mmap returns EACCES when trying to map
> addresses < mmap_min_addr. This is not one of the error codes for the
> condition to retry the mmap in the test. Rather than arbitrarily retrying
> on EACCES, don't attempt an mmap until addr > vm.mmap_min_addr.
> 
> Add a munmap call after an alignment check as the mappings are retained
> after the retry and can reach the vm.max_map_count sysctl.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v2:
> -change comment for description of get_mmap_min_addr()
> -fix commit message formatting
> 

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Andrew, please let me know if you would like me to take this
through kselftest tree.

thanks,
-- Shuah
