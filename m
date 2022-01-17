Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC3490063
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jan 2022 03:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiAQCz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jan 2022 21:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiAQCz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jan 2022 21:55:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E99C061574;
        Sun, 16 Jan 2022 18:55:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so9766941pjl.0;
        Sun, 16 Jan 2022 18:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TC/ZT9U+TsRTqvL1Tb9mnrdS2C63NBDexd+hsYqZ5YA=;
        b=ioltH1Ov2iDS+zfilvwI9UGF/CcMMagRNRziEiYf2LDCpGiJQ5VKUVsRKGbDL57Ian
         qV7rRvMH6jMd6xxyawKRu8OEhYYK+u1ryc19EBCI4k4+3VWPGLxhCQN55lY/QnMJugLo
         PEY+EJKkFtlWKdemG4U3XYmDnUb8K3GigGkkVrHATN6McN6YEYpHbwsBp8WoUs+yW/MV
         LNMk9YDZfGJ5YXB0W9hSPadI23jKwX2dTBIa7PITQW3ocP0ZoaADw3aHlajQA/DdE8sr
         vHMXqTlkZSHrFBN2aHbHP03zDZmRT23xeaCusaHDFUVxSHgo4t18fgvNCjft6DaQLLue
         7euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TC/ZT9U+TsRTqvL1Tb9mnrdS2C63NBDexd+hsYqZ5YA=;
        b=S9zwKH+Yd9sXbHmW0BD1+BCB+aXCbXmghiYerqKZsFSciH0jhKWRu9NFo/tePS6o7m
         5Og7Jp2lOj3j0nFc5zMrpfFgpdNVABJGzMFE9WfiUKjR8vKF9WX/48VKD3TIuA8Cocvy
         VdkJrrHFo3Dmxri6aP3n+GS06shYzwe3TdFbKiuHV+Y3ACXo+2FwwlYYlVmq7adIEfun
         dS6rhuRM7kYarWHb6YgGjiH5MANwgLO3+UibVu/jH39dWrJlJd7e4t4136fZOaG3nWfU
         wzf7AyFzUiYZ5MDZPeybUyO8QkOeHpW3If7EQbOaVpxAM26KIVjEGPh8wVBAENhRRjVn
         KBmg==
X-Gm-Message-State: AOAM531DPPNCrumWg7g1j7dGWXt25x8ehpLRgfYNVlUpyxG/ETWfhbWh
        NHFfdJsZgCEB/8LRBHEW5/U=
X-Google-Smtp-Source: ABdhPJxX/DmQygLiFOoAZgI7NcB5iJLAGqce8UZtJc2Um6HmytK1FcZF0sGb0BRyMsGrnTTICGFByg==
X-Received: by 2002:a17:90b:4012:: with SMTP id ie18mr22834074pjb.43.1642388126918;
        Sun, 16 Jan 2022 18:55:26 -0800 (PST)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id t3sm12457550pfj.137.2022.01.16.18.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 18:55:26 -0800 (PST)
Message-ID: <ed1dc51a-8dfb-1179-3200-13669a25c845@gmail.com>
Date:   Sun, 16 Jan 2022 18:55:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com> <YeQs7Fy5NaK6m6Ar@iki.fi>
 <YeR6Z9a4Z3Xz79Tp@iki.fi> <070044a5-5468-1095-334f-67cf98eb30b3@gmail.com>
 <YeTKG3qPxm2DJGCN@iki.fi>
From:   Tadeusz Struk <tstruk@gmail.com>
In-Reply-To: <YeTKG3qPxm2DJGCN@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/16/22 17:44, Jarkko Sakkinen wrote:
> NP, Both are applied now.

Looking at
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/
I can see only the 2/2 selftest applied.
