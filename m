Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39C61603A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKBJvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBJvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 05:51:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660C1F2D9
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 02:51:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q1so15754858pgl.11
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gO4oBkwXoA7cXVJu0fHO5ySLapcLSIFeRuKjNXMt1c=;
        b=e9M+T/yOXfGHQ0DVOM5Tz3Qgf0kzrIEjhC3+5GeAFHLHbFOx+dKo7vlzfmlj3Ovf8U
         ed/Ff75KRUaGX78mEugrTxGXYSRwXhk7UEthFLKVrTzPCMvdM8I6FbH6bCNDfnh7UQR/
         X86/1nTfVUhv3JluABi7U0eafDbCdOdmp+3Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gO4oBkwXoA7cXVJu0fHO5ySLapcLSIFeRuKjNXMt1c=;
        b=x8m0Oqc3BTaj9C1AaKvss/+vQvE7ypVFWp3OlzmnO2H3Np4LtVJBUbN2YWnVJJoXOr
         sKtN99yoEstvKBB9m40qnrN1UPtQruXQpsnAABqr/xN2IM5qfjtSDbfjRth3NBSnSRqA
         wQOsiPakbkJdvSjoQ9afE943M+40JA64fr4JL7apdW3xYBjCUuU2pRaCxn9OylBDAo7e
         HA14hgMPf+wnxoVSWCen2KBn+Lx/4zNkcvUWwXFMa3c6SlM1d2Nn+IIfBjDBs51XT2tX
         /so/NpSSBPkC7xgSY6KODgieGoSuw82Mq0FDjoE0EkZS4dudtTPSL+gtYcXtf5nsAOBm
         I9wQ==
X-Gm-Message-State: ACrzQf1AEVvukPm4pVbnU8dAgRXoDBZEKMgxXsuuh0B2beemENQ+SV7U
        QJ3me30UGKfc7nYZrbAyLxndNA==
X-Google-Smtp-Source: AMsMyM4W5hLjwS8QmYrG1hulUCgTzpLZ6aI5I6Y3ZqvRqbFiMNvL0q2GziLv1mrFdLcIxLoJJ6MfYg==
X-Received: by 2002:a63:44b:0:b0:46f:1082:32ac with SMTP id 72-20020a63044b000000b0046f108232acmr21727405pge.136.1667382712722;
        Wed, 02 Nov 2022 02:51:52 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902ca9200b00186e8526790sm7841140pld.127.2022.11.02.02.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:51:52 -0700 (PDT)
Message-ID: <58917c1e-9178-e9b7-8630-dbc935963b5a@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:51:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 03:43, Shaopeng Tan wrote:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results("ok","not ok") are printed by ksft_test_result() and then
> temporary result files are cleaned by function
> cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_test_result(),
> function cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>    cmt_resctrl_val()
>    cat_perf_miss_val()
>    mba_schemata_change()
>    mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file.

This isn't making much sense to me. Please include test report before
and after this change in the change log.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---


thanks,
-- Shuah
