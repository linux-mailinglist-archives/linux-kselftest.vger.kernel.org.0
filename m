Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD83249BD42
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiAYUhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 15:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiAYUhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 15:37:20 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C3C061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:37:19 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e79so25153156iof.13
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S114hpLlK1eEOMK2e4rLDa38DT2qlNS0CbSes7k76IU=;
        b=d378eBTUprEfA0JyKd2BgfcVOIdsU2TDPLJesC0g9fQe6T8z5JCBPGDsoNQtEKr/HE
         9ln+MKXxHPBYZ7ttXQAJedWDvUDwaiuV4HbrhmkexmJhuALe5Uhk08pKxLSc8pcF1UHc
         fk3G/swpCUXr5NHD1beQb8N7jZ2NnQed8nS5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S114hpLlK1eEOMK2e4rLDa38DT2qlNS0CbSes7k76IU=;
        b=DFt+YkuqO2D4QfDRXTw8BOjK0vX7o1udowTGciBSgYMWNpMFtMUp18YE+Px2Q6uYg3
         txjK6yaC7HjodhPEYk/Ou5lizyAhHbuOBywC8XA1HaiIeG9buvH0MGy+EwDYtOkZ/J5H
         LoPJc6VM5hxt4qTozRH8tn5IiyR2NVmIpCkOUSpQ5yw0gTkfu+wOZbSFMRUuA6KKo0p1
         gxfBgzPsc2dkM2P5J/HODbD5cxuFqJD5WbaAVQbcCGsSDT3uaIIOi10CwgOyC/8pvkH2
         u0AtrPLdxsFQbB9VC3wKZqPsfUI0lRMAkk5BZvNiIBEY+CO2W/DJHS0W1UtbERqq4FFX
         kSmw==
X-Gm-Message-State: AOAM532MZ0Zev4i78G3ijd054EU1Wie1CRmjubiC4ihZK7adRwNEADh1
        DBzVgU4x5iL0XG68R4LJzJYG/w==
X-Google-Smtp-Source: ABdhPJzffMUcrRKU+oI0gJlv+ICn/cAio7G6+5MfpNppQ5u0GppTC4Rj7r7R4SgFU9HjOi5OBsdBtA==
X-Received: by 2002:a5d:8b82:: with SMTP id p2mr11668599iol.214.1643143039280;
        Tue, 25 Jan 2022 12:37:19 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id r189sm5103334ior.2.2022.01.25.12.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:37:19 -0800 (PST)
Subject: Re: [PATCH 2/3] selftests/zram01.sh: Fix compression ratio
 calculation
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        aleksei.kodanev@bell-sw.com, Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639562171-4434-2-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f80750cd-d2e8-cc57-37b6-cb4f770c61e2@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:37:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1639562171-4434-2-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/21 2:56 AM, Yang Xu wrote:
> zram01 uses `free -m` to measure zram memory usage. The results are nonsense
> because they are polluted by all running processes on the system.
> 

Are the results inaccurate or does /sys/block/zram<id>/mm_stat is a quick
way to get the information?

In any case, this patch and all 3 patches in this series have:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

Please run checkpatch.pl and clean these up.

thanks,
-- Shuah
