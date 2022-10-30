Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2AF61291A
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 09:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ3I3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ3I3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 04:29:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB836120
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:29:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso13433545pjz.4
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EA5eB5MFyKixwF/ard/KpTYSQvr6aSxZNo27zLruyco=;
        b=gF/V9gEVUm7tcGsqDi7FYgQwy/7uwHsXRXVFe6VbSSpWl5S78hEtU+mqXTdQfoCmNs
         /8SSDOeMxLdWvoFdjun/+33edYiqf30KYKhs46UGg2s2W7a5Ts8GpbFIIahd4zfScezJ
         EyL4rdqwY58oiAM1hn0Qx+ZUmz7QGze2KIpbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA5eB5MFyKixwF/ard/KpTYSQvr6aSxZNo27zLruyco=;
        b=QuNclokRNWW7gdULrfM+L/8t4caRta8PIQFxwMZGBn/OKRi3WfstfKJfaCfiiZ3scV
         GiW5nboPYP9wxqDaVgZAGQR2CAj6WQZaK59ipan2f5Ao5yM2Zv8vBCgo1zfkPE3xSgSB
         H+iLDdmDwzP1JdCKVfpe0TQrwRmfrEDSDC+0+OLVWS5b6wwuspvCe8KCtJixmIiWcQTB
         sFlH2p2/fCuBTxMp67Bdr3fKTBfknT7fK/DrtB6zCPNOgzR23F7DRkwigJwRFo1XRwy7
         XfB0uCPDJyMI+rl6d2eEjfJfjXFpMM1womBdCb0IyWIARq1TAryrPB/m8Jn5FrOWqcjB
         hpmQ==
X-Gm-Message-State: ACrzQf0rRntpM+GLksL8xaJfJQgIHWLPMpVwBEu4T4ekkXxdG37WcEyx
        piajnf0FzBRhc591lNOOvAl2qgpLfWkzv7ma
X-Google-Smtp-Source: AMsMyM6TOnlXauXk4DlH0pYOW2OrzPeW5NZMYQo1tezMMMP3pCj8nXaAibAq9rDkDalWSGvkwKlZZA==
X-Received: by 2002:a17:90a:d70a:b0:213:8550:730e with SMTP id y10-20020a17090ad70a00b002138550730emr8879703pju.24.1667118554221;
        Sun, 30 Oct 2022 01:29:14 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018668bee7cdsm2315885plk.77.2022.10.30.01.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 01:29:13 -0700 (PDT)
Message-ID: <0dd37277-b660-e62a-5627-280a503935c7@linuxfoundation.org>
Date:   Sun, 30 Oct 2022 02:29:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] selftests: pidfd: Fix compling warnings
To:     Li Zhijian <lizhijian@fujitsu.com>, brauner@kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/31/22 21:17, Li Zhijian wrote:
> Fix warnings and enable Wall.
> 
> pidfd_wait.c: In function ‘wait_nonblock’:
> pidfd_wait.c:150:13: warning: unused variable ‘status’ [-Wunused-variable]
>    150 |  int pidfd, status = 0;
>        |             ^~~~~~
> ...
> pidfd_test.c: In function ‘child_poll_exec_test’:
> pidfd_test.c:438:1: warning: no return statement in function returning non-void [-Wreturn-type]
>    438 | }
>        | ^
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> v2: fix mistake assignment to pidfd
> ---

Sorry for the delay. Now applied to linux-kselftest fixes for rc4

thanks,
-- Shuah

