Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C333D4AC8B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiBGSgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiBGSce (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:32:34 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19AC0401DA
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:32:34 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so17974689iod.11
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lHF1VpH0DQWDH5n7whaT5A/13tsAV04BQTsvPAisIH0=;
        b=Dj8tHg/5t1JB+owhj2ZjiEZL01octdxE8ToKWyyO+Mc27jiSIyo4407/YMOcfmzSnt
         p17FI0FIsTEzmPy2Y5xTPdNLD097MXmh1K+EyMfe5VjMNf1/JZ3EH0bidk6DQhir9imY
         vQWBjEHVY4rmWu/aXT0leiUl8vc/d8lFpNc4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lHF1VpH0DQWDH5n7whaT5A/13tsAV04BQTsvPAisIH0=;
        b=pnvBysc2kPqF/HyW6yZrlRmsKDiQu1AtpCEcnbkYTwXkIjTAsfx3eYEVw3vzzYayCs
         emnJv02dF9VuO1uNQTcfxcVyv/EBKsTR44Zy8Lp3cK2B7rIiqzLcrcKJf41KRzUp0/uk
         QBaUIS6afPMdwYifjmYJirZvo4l/GmGSjW3i3FAKV1743sAIKbZlp4110Zd0qG381meb
         7sGWo1vXz/FzY8UkJlYhjutEzsgm0giJwMQ7F7OmZE94iZIhSvY6rf9wFGpzB9yh54FT
         s5cKKWdxlbD3ubNk59Qqb6uTuzzmGE5wA6Q4FSw2iyxQ14IDTmkc2URGAsjFW+vu302s
         gi0w==
X-Gm-Message-State: AOAM532gTtylbxO3ObenTQ/MgDyWSjDAdMZIe4ue7jF8PC0r2TbRmye+
        +ThTs6HNV+q8KVkM1Y0H+2KfJQ==
X-Google-Smtp-Source: ABdhPJwAi7OgegFLvzLu3DSbiMS8FE+D6rNCLKTStU8ZEgIomXfkDkIRujGcZ3DVxw92MTT9otWwPQ==
X-Received: by 2002:a5e:c20b:: with SMTP id v11mr398967iop.197.1644258753611;
        Mon, 07 Feb 2022 10:32:33 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c11sm1632610iln.56.2022.02.07.10.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 10:32:33 -0800 (PST)
Subject: Re: [PATCH][next] kselftest: alsa: fix spelling mistake "desciptor"
 -> "descriptor"
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207092235.240284-1-colin.i.king@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3c47e21f-45de-1bd1-a547-225b3ef0ebc0@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 11:32:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207092235.240284-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 2:22 AM, Colin Ian King wrote:
> There are some spelling mistakes in some ksft messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/alsa/mixer-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Looks good to me. If it goes through sounds tree:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


