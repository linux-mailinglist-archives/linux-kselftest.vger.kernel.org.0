Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA83B77E6FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjHPQxc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbjHPQxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 12:53:08 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08045199B
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:53:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34a91a25db9so2861395ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692204786; x=1692809586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTSeYU3JyTRpC8MJkT9sFIq+oIiYKkH14KvEcr7o5GA=;
        b=BBzzif0AayYda7c4a9xibgNV0egsHz2CC+x+7A2T4Hgb7Noi0B4ZQCjnOk06IN4ydd
         GQNecB6WPh1L6q2HFIvWUmHWGugTWfAhSgg94xGIkLhd76Y8GmsjtfNP0fMWlnEqEYO3
         /2Fm3IXGCiyE4FmUABsfCWEdyutTyTaCDu3M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204786; x=1692809586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTSeYU3JyTRpC8MJkT9sFIq+oIiYKkH14KvEcr7o5GA=;
        b=WGyLoBQPscHnnr8Wv5NNl8G+zbPqkgCCVix10VEp892mHLot0wTb82vTkLiAAaIvPl
         LedsFOdyuJFyaZb5mtDpWWXiMRTxF39c2+J/eMHpvuGPHMKo6C3yfzriOqfsgil3Ag+B
         v3gc9+o7gPAXoRNL2aOx56UhUw6CTsEN0Z9rU4fsF3fuNXkRBrPypE8zPANBnmA5LAMU
         zHfPx06Ot3VMQXpCawevxQTK0c8FpOPb32AIMcZnXRc87hWlxet85sR7bmfEY0phcFck
         JMKVn4SsxVFsMmzfcqlr7D3UySzw/LMc1Nrebc9Tm3xaTIKkOqKCH7UqQhaa6l9Dn9BR
         oeZA==
X-Gm-Message-State: AOJu0Yyp8Xf4dmT7I2a8iwBsIAZU1GQruzU+edMVAIY0abrtHmoFh4nI
        ffS6bR6ZxhFrcYSyWllqaudVIA==
X-Google-Smtp-Source: AGHT+IGvK6s5Yc2BIInO8ztWs1EXMoonbB3rlX4P/LXTaEaHSUlEyofeK7VM2BgXuyJrq2wnnPBmWw==
X-Received: by 2002:a92:b0c:0:b0:349:983c:4940 with SMTP id b12-20020a920b0c000000b00349983c4940mr3556570ilf.1.1692204786417;
        Wed, 16 Aug 2023 09:53:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b16-20020a92db10000000b003424b3d6d37sm4759933iln.24.2023.08.16.09.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:53:05 -0700 (PDT)
Message-ID: <3193a5a7-ea3b-e6ed-d42c-fa034c2affdc@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 10:52:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/futex: Order calls to futex_lock_pi
Content-Language: en-US
To:     "Nysal Jan K.A" <nysal@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230814080927.61048-1-nysal@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230814080927.61048-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/14/23 02:09, Nysal Jan K.A wrote:
> Observed occassional failures in the futex_wait_timeout test:
> 
> ok 1 futex_wait relative succeeds
> ok 2 futex_wait_bitset realtime succeeds
> ok 3 futex_wait_bitset monotonic succeeds
> ok 4 futex_wait_requeue_pi realtime succeeds
> ok 5 futex_wait_requeue_pi monotonic succeeds
> not ok 6 futex_lock_pi realtime returned 0
> ......
> 
> The test expects the child thread to complete some steps before
> the parent thread gets to run. There is an implicit expectation
> of the order of invocation of futex_lock_pi between the child thread
> and the parent thread. Make this order explicit. If the order is
> not met, the futex_lock_pi call in the parent thread succeeds and
> will not timeout.
> 
> Fixes: f4addd54b161 ("selftests: futex: Expand timeout test")
> Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.6-rc1.

thanks,
-- Shuah

