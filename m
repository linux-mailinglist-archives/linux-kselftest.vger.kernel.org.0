Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5EC1F6763
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgFKMCs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 08:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgFKMCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 08:02:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FEC08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 05:02:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p20so5942647iop.11
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 05:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PrTVFxgVT/NvP9ILwV4SJKEZr2jsHRDOkb31piqOh1k=;
        b=TQm0oXPVGJ8KcJGEZedYpCux3S+acpXNVHfEFzBg3w64Bxr9MKBCd6JzxiE/QDN7fA
         1HmBpJFTlSuufK+DY/MYaX11MA5dvU05VozPfsNRSEcB5f2P2WkGiu0rMCdCGSDD97+R
         xO8G4M0NTczAYdpSLMISz/lD2CeFc9y/Oe+Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PrTVFxgVT/NvP9ILwV4SJKEZr2jsHRDOkb31piqOh1k=;
        b=oYeN+P50NNv6xB6/JOV2K4iT0Me3xSVWsLT19ChRGCZsJMd1lcvufvU+EZfHMitNqR
         UrH/1Wr8mOXHszqEKi0uf9O/KjctwM1rqhlYKty1escoTNcyueWYWsUiqnWyr1YIjQPk
         faCkU6Cpi63krQzatpcy1yxBEOQgtnt/AN+0zxVd0hz4YNgN7+uXIWmqB2T8pCoyraEl
         OcrQxeChzRYt6mfTP2FX3aX1dP5ZnDHoK949Jx8z2X9MR8vKurNtEdJ9kDW5x0PZwp/T
         SBPWk0fmVR2V2oXFZPQGDNF04evUTslRIaYTQb4vDO0rXgkipGc7cCcovbdGFEGFGtgu
         J8XQ==
X-Gm-Message-State: AOAM531QU3aNtfg0vznbeS7ZNg8uiWNkldfcbK1C+Ul5xfnPBczU4EF5
        OcLjKQltcR0YtoOjnq6an2AsOQ==
X-Google-Smtp-Source: ABdhPJyp8j+MCAiGt77ffnAgW7Vmio3yEq7dR5A7tg+D5+xqPYSRvx+RNr9er+bt6DPaZwZbIKtHyw==
X-Received: by 2002:a05:6602:5ce:: with SMTP id w14mr8082162iox.178.1591876966529;
        Thu, 11 Jun 2020 05:02:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm1446984ilt.43.2020.06.11.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:02:45 -0700 (PDT)
Subject: Re: selftests: test stops at step_after_suspend_test
To:     Akira Shibakawa <arabishi900@gmail.com>,
        linux-kselftest@vger.kernel.org
References: <CAE84iWVZt1N=dRzKENeSsBP0V2ka+_gEyfkrVx_8pO9x2tnBFA@mail.gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7e3802bd-ad41-23fb-4c3f-c3a8d31cfd63@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 06:02:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAE84iWVZt1N=dRzKENeSsBP0V2ka+_gEyfkrVx_8pO9x2tnBFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/20 5:21 AM, Akira Shibakawa wrote:
> Hi, I tried to run kselftest but it stops with logs below.
> 
> ----------------------------
> # ./run_kselftest.sh
> [  126.214906] kselftest: Running tests in android
> TAP version 13
> # selftests: android: run.sh
> 1..1
> # ./run.sh: line 3: ./ion_test.sh: not found
> not ok 1 selftests: android: run.sh # exit=127
> [  126.351342] kselftest: Running tests in breakpoints
> TAP version 13
> # selftests: breakpoints: step_after_suspend_test
> 1..2
> [  126.464495] PM: suspend entry (s2idle)
> [  126.496441] Filesystems sync: 0.031 seconds
> [  126.499299] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [  126.501161] OOM killer disabled.
> [  126.501293] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [  126.503018] printk: Suspending console(s) (use no_console_suspend to debug)
> ----------------------------

Looks like you are running as root. breakpoints has a suspend test and
suspending the system. Try as non-root.

thanks,
-- Shuah
