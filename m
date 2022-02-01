Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365384A6432
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbiBAStU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbiBAStR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 13:49:17 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F42C06173E
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 10:49:17 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y17so15099941ilm.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Feb 2022 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YBWpcqo7r9PmZE44Y/rtRRY/rFDY3Yz81vSI7lMsgBk=;
        b=crZKCeXmjdeNhtotolL21onTwntleBAgT/ItIhhzYnnQTNgRvOITvJKOdmFK5q7uEj
         lP/gZn4y8tVfBMCq0QQIsMahVNqGmYmzzeCTyz6P1tnDi7HQjlh6HcvMSo8YLNbrkn3d
         jksclscYjOCa9QVbKwxxBDW0ExnKY4385oUCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBWpcqo7r9PmZE44Y/rtRRY/rFDY3Yz81vSI7lMsgBk=;
        b=rq8Enbl8k7jzFW1ii1WbIjYc5YPEmQpy1jBC+D+HnO4OB/scyfc+zCvFoSlN/eD7F8
         U6kraC+g/vohkJzxH2m8uRFLTQhhkmLX6qg2zMcWLk/VsMHaK5BTVHYk3YUapPe6AtQi
         Q4Zbga8dvNg4rsnNDgINybxMaGsbU0PhMs3r18UFTIvDIfJraFEd7gjn/v01vSCbonjS
         K5n0OznPKtIHbtsYibUBnYlwNzsqriFXsa/VfSDYsH6if7892QiHQwotTa0wfK1umEcZ
         /szfvzDKKJ9ql6SHMuTLfmcPjBmKNZMtJ48/fpyKi5TC95/qxwQwLnJ9Yy0GJTaSm7Ji
         tH6A==
X-Gm-Message-State: AOAM531mZL1iaE3reLXhxT9Vktvi9s9FK2o5UoFDve61LQAuq8ugvvcQ
        7n2qqoSj6o2tL7jl7J3ttxTPamkxlk00bg==
X-Google-Smtp-Source: ABdhPJzrMNz8kG6pYoBfSNtpQG/SHDFYR5k7N9SwSYjtb9EG5VRQTM6Azj18d7UT5qM1jxuDzdB3Vg==
X-Received: by 2002:a05:6e02:1caa:: with SMTP id x10mr15637859ill.249.1643741356967;
        Tue, 01 Feb 2022 10:49:16 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t7sm18534614ilu.37.2022.02.01.10.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:49:16 -0800 (PST)
Subject: Re: [PATCH] kselftest: alsa: Declare most functions static
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220201181530.2405077-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d511cfff-5a0b-38e5-d1f3-b1f47ee8e596@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 11:49:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220201181530.2405077-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 11:15 AM, Mark Brown wrote:
> This program has only one file so most functions can be static.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> This depends on my previously posted patch adding coverage of events:
> 
>    https://lore.kernel.org/all/20220201151551.21497-1-broonie@kernel.org/
> 
>   tools/testing/selftests/alsa/mixer-test.c | 58 ++++++++++++-----------
>   1 file changed, 30 insertions(+), 28 deletions(-)
> 

Thank you Mark. That was quick.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

