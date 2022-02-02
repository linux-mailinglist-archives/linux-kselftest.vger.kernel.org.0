Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADB4A7772
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiBBSE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346454AbiBBSEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:04:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702FCC06173B
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 10:04:20 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d188so61492iof.7
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLkmXCB4AfYdAm9hiqZaqGV6EKc/FUxTrxh9W8wogF4=;
        b=gGMebvLeJDhoY6TiETyWGvgv4gT6UwBM6EFgUgxNI3TVlTRioqhkQgaFEcePzO6Tzm
         KhadLqVClZyvRbbfxh9L0ETwhMppREgEHVke9PYpQ+NjWvEx9wDLMF2lTZ009bArbgcu
         Spw/BLAauRt1jIkA2QVh0dmI1n7BjCIjfFnc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLkmXCB4AfYdAm9hiqZaqGV6EKc/FUxTrxh9W8wogF4=;
        b=Br3eRFH4HSQ3sxYdW8E61BAhJk1MjRWqsek/PU3t1NKrqzINdanLwwS1sP5byXxxUM
         2jjYiscfsLX6xO/QEdJsNMj0UiZvwhrlJ2TVi7uRVVCfnSziqql4vip1iQ2dGHfhQYjj
         6tHKMZbOOr+X+5+dCetDUN6ukp6kXy3Z63lUcwelJGGSFJbbQIrGwEzwOPs4xXTlyHXX
         E/uUxze9x54jm8uXrZmblSWindc8Af7aBqglWJp/j+pUnrfJ4tiDhp5oiTGUDXPD1YFa
         SR+S0UcsPC17Lgo5AXv+HKb0wrlZx/fiUlzKODCUEqXqc+azN2Z5mvk+Oq6p1vkiGK1z
         CZAQ==
X-Gm-Message-State: AOAM531Y1r7o+6wSNQlQDZbPdz3xT2knUZGRalBsXk6zEgTsoZEeY2/W
        6I7J3acbEatpBRC8DDNuTbV6Ng==
X-Google-Smtp-Source: ABdhPJyjZbG5YLnI2cwY+L7WSqUOnWQg23FK0SGTMU9yq3T03EBOmn/Rl1HlkL2q67VzfUbyk67Hlg==
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr14752471iow.105.1643825059943;
        Wed, 02 Feb 2022 10:04:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b5sm21121433iln.54.2022.02.02.10.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:04:19 -0800 (PST)
Subject: Re: [PATCH V2 3/4] selftests/sgx: Ensure enclave data available
 during debug print
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <644ac230-0a50-a555-a621-5f72087f54c5@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 11:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 3:47 PM, Reinette Chatre wrote:
> In support of debugging the SGX tests print details from
> the enclave and its memory mappings if any failure is encountered
> during enclave loading.
> 
> When a failure is encountered no data is printed because the
> printing of the data is preceded by cleanup of the data.
> 
> Move the data cleanup after the data print.
> 
> Fixes: 147172148909 ("selftests/sgx: Dump segments and /proc/self/maps only on failure")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---


Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
