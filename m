Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82C550A93B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391990AbiDUTet (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352795AbiDUTet (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 15:34:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE44D9C2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 12:31:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 79so6398375iou.7
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChcaOOdn/M8suYxqXQ+PGCxHuw+mTiMXMZ+jM9GrefI=;
        b=UjIQ1FFdFQrrSszpwO6Bhhjj/JRqJyhC5nfRIA8HWCyoWI/OEn12Xgn7aDVeMn5K3a
         bNMVs2tMT/tHb2COd9Fjf3B1Y8ZSNjRq+YGqn97BzNYHWuuKmQRNwszD1dxk39JL0J7b
         eiAvhDnwmTe0cpc9OhOFhuQoJiGlF3mSDL85w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChcaOOdn/M8suYxqXQ+PGCxHuw+mTiMXMZ+jM9GrefI=;
        b=PwPVYT75COm+8o6DuYtgo54boMH7PKHwJFzclVVdexR5xBKpspn1MukzwXWiXv9ep7
         vyj6OemBdVOQXsFX7km6Rk9PGsLm5Fk+yVxyHP291MjvCyZzKDh9R7XUx4MCO7sHoeax
         BS1TjW/Qq+rw4yuBxqbS9OFamcxkwVyezJUsO/aHm5GQ9eYEAyQBl44zQii5tzAyTM4k
         XTBPya3xK9Sc3k7apdQR3DqfNIUK/sd0iVWE0QkA+ar3uSwhilgi10Aady4GUwPJxsXJ
         fdnNXdjbnZrf0cjEKKjtIChdz4prWWl06gNa6XriFRrOhQCLirXc5j/qoLmQsU+9+UJc
         6KMQ==
X-Gm-Message-State: AOAM530qRCTKMflXLjZfPPCwm1Nq57sDgEAYJecTscIp7oAhOX8Gj9rK
        pJFVM5YbnX9MAhjq9tGNrLJTELs19j3gHA==
X-Google-Smtp-Source: ABdhPJxBpKoQk/2G24NzJGB83sHvZtecYc3iCN32hGuCxXQOqjgfgf51gXtjUs4//o4vh/1ogzFY4Q==
X-Received: by 2002:a05:6638:2586:b0:32a:9e25:d5d6 with SMTP id s6-20020a056638258600b0032a9e25d5d6mr639819jat.191.1650569517485;
        Thu, 21 Apr 2022 12:31:57 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x9-20020a6b6a09000000b006549545c9d5sm8429268iog.42.2022.04.21.12.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:31:57 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] selftest/vm: verify remap destination address in
 mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
 <20220420215721.4868-2-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76cd8347-a8d0-3b56-a202-17ba2a73503d@linuxfoundation.org>
Date:   Thu, 21 Apr 2022 13:31:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220420215721.4868-2-sidhartha.kumar@oracle.com>
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
> Because mremap does not have a MAP_FIXED_NOREPLACE flag, it can destroy
> existing mappings. This causes a segfault when regions such as text are
> remapped and the permissions are changed.
> 
> Verify the requested mremap destination address does not overlap any
> existing mappings by using mmap's MAP_FIXED_NOREPLACE flag. Keep
> incrementing the destination address until a valid mapping is found or
> fail the current test once the max address is reached.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v2:
> -rename remap_region_valid() to is_remap_region_valid().
> -change return value of is_remap_region_valid() to bool.
> -take out overflow check from is_remap_region_valid() to
>   inside caller.
> -fail just the current test on overflow rather than existing
>   the program
> -fix alignment of mmap calls
> -change "can't" to "couldn't" in error message
> -increment mremap destination address by dest_alignment
>   rather than src_alignment
> 
Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Andrew, please let me know if you would like me to take this
through kselftest tree.
