Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCF2B4FC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgKPSc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 13:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbgKPScx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 13:32:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF8C0613D1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 10:32:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id k1so16183193ilc.10
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 10:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9lE9d9/CKJRF5PYT88VMKA1TfCL9raVeHb+lUFo8Cc=;
        b=fh59IwpEIR+cJ87j4+XJilIeVzjsOf0N8vckF1J+4V9K1IpQscf47H9lkA+wvSdy71
         22e6No7xYC8F/kGXd+U4rL46FQbOQqfYNNPdPX5nh01oo9+7gZor3GFP/AEiNvifMpSi
         sAgdYNWxPg0RZtcFZUJQywwXZBsAPKWlCK37A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9lE9d9/CKJRF5PYT88VMKA1TfCL9raVeHb+lUFo8Cc=;
        b=CWF60JPZzHf2Tf1c2nDWlUT4qBfGx298gifkv/m5ar+WwkV7PYq/K05n/oRrrah0fV
         r2eID5LdTGWAEMutsTRBOabaikqlGwj5ImRHNxmG5faqua87bjprwXvSLb4+Souh3tU4
         LlCoIKIdt1EoxNWjuI83ljSz5eNH5k6sBzh6IlYOKmJcoib5C/tB8wioRJLo9IfiGim6
         +fH0/qhvl678M9qp5C+jFxYZ3bUu+XRFUB0KA9Ty8zaLrbS3+4dguXqMZgTI2dibSrdA
         454HCxgncP6qH+vLEf+UfJtwthHKkLs/0BOh333BZ1NgbLFvmrrHAM/wGA0vkby2LS8b
         +q4w==
X-Gm-Message-State: AOAM531Ajf8NlgSSbkFYnvNGFZae9CBSmGgtHF7Sk7WrSkx2/9okT4nA
        A3caNnSu8/F+YYAgUl2S68ONJ5BlAiV5pA==
X-Google-Smtp-Source: ABdhPJxcuzifQRoMzSvdjcej2uBH2zLWjlvT4vQb3xMGKTuEWgLl54a63oenH9NZ/uFp73baJWMHMg==
X-Received: by 2002:a92:a041:: with SMTP id b1mr1214714ilm.242.1605551572485;
        Mon, 16 Nov 2020 10:32:52 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y6sm8150669iob.48.2020.11.16.10.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 10:32:51 -0800 (PST)
Subject: Re: checking for "config" file existence.
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <2ea637f38be0d03d0e0c545a6d12f36217cededc.camel@rajagiritech.edu.in>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6e1e346-ff95-74ef-7f43-1d2468d5330c@linuxfoundation.org>
Date:   Mon, 16 Nov 2020 11:32:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <2ea637f38be0d03d0e0c545a6d12f36217cededc.camel@rajagiritech.edu.in>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/12/20 10:40 AM, Jeffrin Jose T wrote:
> hello,
> 
> i wrote a  small program to check for the existence of "config" files
> for testing projects under kselftest framework.
> 
> chmod 755 test_config.py
> This file should be located in "tools/testing/selftests"
> This can be run as "./test_config.py"
> 
Why do we need a dedicated script when you can do it with:

cd tools/testing/selftests; find . -name config

I see that your script also prints if config doesn't exist.
It is not a failure not have config as config is necessary
only when a test has config option dependencies.

What does this script attempting to solve?

thanks,
-- Shuah


