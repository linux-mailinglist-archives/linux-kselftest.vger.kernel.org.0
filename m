Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F57A512C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjIRRoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjIRRon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 13:44:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC661FA
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 10:44:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso3542875ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695059076; x=1695663876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kgfd/ILwg743YB1IZNWjnxQtieFj1a5XZRKCr5UccQE=;
        b=ie4K+Urc1ptue5uCAUwHypQHoZyT93uGfcLNeOkgSg35ietgXbyxFDuw8XQ7k504Dj
         v6rf5G5AcfTefga1fHJdXYZukMcIWmVK+a7FYMJPoJ2xaGKAYRvLCyivcaWBQfVTtzXZ
         CvI/BfuMGHSOFq1XURY1E3rgscn3RM7h0y5nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059076; x=1695663876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgfd/ILwg743YB1IZNWjnxQtieFj1a5XZRKCr5UccQE=;
        b=wTQNpQPJACB9xEz3S8WudT9kHvLpk3ayWlBmCk/tNy8ArJS9sCDQHc8wz9N/Yg47W/
         esDSp166/KPldT6ZxlTa5vKTmFWKmQzGiSvlJA7qIJoHEf40cAR800e4D2aud3GuWByu
         kagoFqkHtGq3YuVZSG4wJhqS7382iFlRiPZ/d/DQJtP06BePPLuIQXOM/6B7WWRVcZMR
         ezqoQGAi4BGxV3trzDXus7vy3zLWpCGNrEbqit36BDWVcH93D4gTwYuwLKzZtH2rDKrb
         2grVH9BtbTpvbZQBwgmMDfEHqHo4Z0i9uKYd+K4UOZx6fVctQKlXGvdXSVzaqSu8NlKC
         Cixw==
X-Gm-Message-State: AOJu0YwG8CT/tqYg/9Fs0X+1Gwu7tVE3IbueWFDPcEL0KpuO1lzUSQnv
        4HRGFYPaDGbOkPe9kLlFxYIrLw==
X-Google-Smtp-Source: AGHT+IEhDQXkcFFUCK+oCUMmq2zCpQG5cUV3ZbgK2C4ZtZeGRWQt1QaX6jEwo+KzRdDLjN1IA6f1yg==
X-Received: by 2002:a92:907:0:b0:34f:2e07:685b with SMTP id y7-20020a920907000000b0034f2e07685bmr10527191ilg.0.1695059076319;
        Mon, 18 Sep 2023 10:44:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y5-20020a92d805000000b00348ab9bd829sm3145522ilm.53.2023.09.18.10.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:44:36 -0700 (PDT)
Message-ID: <400a3e3e-4592-c947-a506-6baf1f268224@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 11:44:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230918081407.756858-1-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/23 02:14, Meng Li wrote:
> Hi all:
> 
> The core frequency is subjected to the process variation in semiconductors.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reach
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform through
> highest performance capability register of the CPPC interface.
> 
> Earlier implementations of amd-pstate preferred core only support a static
> core ranking and targeted performance. Now it has the ability to dynamically
> change the preferred core based on the workload and platform conditions and
> accounting for thermals and aging.
> 
> Amd-pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on cores
> which can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-pstate
> driver receives a message with the highest performance change, it will
> update the core ranking.
> 
> Changes form V6->V7:
> - x86:
> - - Modify kconfig about X86_AMD_PSTATE.
> - cpufreq: amd-pstate:
> - - modify incorrect comments about scheduler_work().
> - - convert highest_perf data type.
> - - modify preferred core init when cpu init and online.
> - acpi: cppc:
> - - modify link of CPPC highest performance.
> - cpufreq:
> - - modify link of CPPC highest performance changed.
> 

This series in now in linux-kselftest next branch for Linux 6.7-rc1.

If there are any changes and/or fixes, please send patches on top of
linux-kselftest next branch.

thanks,
-- Shuah

