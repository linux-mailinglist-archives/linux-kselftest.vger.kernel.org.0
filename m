Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F997CB329
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjJPTIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjJPTIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 15:08:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C0A2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:08:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so59692839f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697483317; x=1698088117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcTH0VsoF1buUa3wYI5JOhUxSLxinwGPh2bn6jgrf1M=;
        b=e9LhRIbvi72jdoM/sj1fB8VUKUya4Os1hXbTXmkbsDdRj4jpYqhhu5c/l5qS30Y7KE
         TX85O4ZHF/B8wcuoqb588Socp4Y93e6GH3cbdLbC7B1q8v5oNXwfdN8lbIVqTkewcO05
         LHTUYfxIxiiEliGf715YwOlb2pT0RXLXMPfrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483317; x=1698088117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcTH0VsoF1buUa3wYI5JOhUxSLxinwGPh2bn6jgrf1M=;
        b=mH23hh5Pao4lTqDhbjKtoV8HX5GS7MXh2XwuR1PAbHeF+4/YaQrwsigqbxa8AnX1Vj
         9Uq0rZDZvpkgJXNtSVLF/a9o/0ARl1tj2Ht4EhoOjuP1Sibez0jax4x6BVVJ+5mE9/0F
         BEie3IR90a1RvpH4SG6Zld/6DBvLtg/E1yknaDTcu37oT363NC1DqV76zO2vs+5QLmRU
         f1RBqyZeqlbbwcyDoF3rxSn1wdgku3xg3IIZ/ekRrIWZFisJXQ16CmrBt3cdSudlNEEi
         cpdEB8Z53gqLsphxeRixiNeOpvz6VEunEv29gnDecYLMxsWKTJb5vDzD8nPQXsEa/ZsI
         meNQ==
X-Gm-Message-State: AOJu0YxSVbZoqdeE3WrQqc8z8oI3E7o2lfbsm3diX7TGIkj+2EY84KB2
        zjoyK/tub11rhfYQ/d91SEmEvg==
X-Google-Smtp-Source: AGHT+IFZqRn51Qhe9fFK9A7LVu2ok00fy6CncbigbJiZF2FCNIycDF+wcmggfs1hJxQbjwOnbSsJHg==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr199390iow.0.1697483316996;
        Mon, 16 Oct 2023 12:08:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r22-20020a028816000000b004301f422fbdsm6498947jai.178.2023.10.16.12.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:08:36 -0700 (PDT)
Message-ID: <213fb592-de7d-405e-88bd-595a1cb33d48@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 13:08:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix issues observed in selftests/amd-pstate
Content-Language: en-US
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, Mario.Limonciello@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/23 03:32, Swapnil Sapkal wrote:
> This series fixes issues observed with selftests/amd-pstate while
> running performance comparison tests with different governors. First
> patch changes relative paths with absolute paths and also change it
> with correct paths wherever it is broken.
> The second patch adds an option to provide perf binary path to
> handle the case where distro perf does not work.
> 
> Changelog v3->v4:
> 	* Addressed review comments from v3
> 
> Swapnil Sapkal (2):
>    selftests/amd-pstate: Fix broken paths to run workloads in
>      amd-pstate-ut
>    selftests/amd-pstate: Added option to provide perf binary path
> 
>   .../x86/amd_pstate_tracer/amd_pstate_trace.py |  3 +--
>   .../testing/selftests/amd-pstate/gitsource.sh | 17 +++++++++------
>   tools/testing/selftests/amd-pstate/run.sh     | 21 +++++++++++++------
>   tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
>   4 files changed, 29 insertions(+), 16 deletions(-)
> 

Both applied to linux-kselftest next for Linux 6.7-rc1

thanks,
-- Shuah
