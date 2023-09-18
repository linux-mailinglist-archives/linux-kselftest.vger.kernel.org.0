Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70E7A51F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjIRSXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIRSXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 14:23:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD0FB;
        Mon, 18 Sep 2023 11:23:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203BC433C7;
        Mon, 18 Sep 2023 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695061408;
        bh=/QjMdsE7OVXtJRzPWJ6CSqsPFZENU1J6XX8KyF9J/GI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gIdv79p37IBUvVHTp9qfa8DomqJny5lWDbW3kTAFrYFIxtf7N5eIb49p2SDru3xoL
         tWFIV9eBOb9j6tWbmQscpqCmt6mik+MKsMztmoeMEu7X1qDpcGaS/csrlnQrpUqCa4
         WoRUJcDuYMUKJK9N8kR73yQ+fjHb2Q3iIl4SbAwGSibeRuumTK9gmc5Cu0TL4WJlH2
         vtTzdW33OjDegR8ltzzfh8sdYp599jDGk1ml4YPNufRPLLvJuQtB1OwWZxoZGxDJpL
         tu+VOyclL2hMEfowpbHL7SvWHY7ek+Q3r2/Q7gZ9afULh8wbC1YN5YDKmZZoAczj0D
         PaY8rYBW5mMrQ==
Message-ID: <757ecf2d-f544-1ab5-4d34-ece6a0eb1180@kernel.org>
Date:   Mon, 18 Sep 2023 12:23:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, Meng Li <li.meng@amd.com>,
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
 <400a3e3e-4592-c947-a506-6baf1f268224@linuxfoundation.org>
From:   Shuah <shuah@kernel.org>
In-Reply-To: <400a3e3e-4592-c947-a506-6baf1f268224@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/23 11:44, Shuah Khan wrote:
> On 9/18/23 02:14, Meng Li wrote:
>> Hi all:
>>
>> The core frequency is subjected to the process variation in semiconductors.
>> Not all cores are able to reach the maximum frequency respecting the
>> infrastructure limits. Consequently, AMD has redefined the concept of
>> maximum frequency of a part. This means that a fraction of cores can reach
>> maximum frequency. To find the best process scheduling policy for a given
>> scenario, OS needs to know the core ordering informed by the platform through
>> highest performance capability register of the CPPC interface.
>>
>> Earlier implementations of amd-pstate preferred core only support a static
>> core ranking and targeted performance. Now it has the ability to dynamically
>> change the preferred core based on the workload and platform conditions and
>> accounting for thermals and aging.
>>
>> Amd-pstate driver utilizes the functions and data structures provided by
>> the ITMT architecture to enable the scheduler to favor scheduling on cores
>> which can be get a higher frequency with lower voltage.
>> We call it amd-pstate preferred core.
>>
>> Here sched_set_itmt_core_prio() is called to set priorities and
>> sched_set_itmt_support() is called to enable ITMT feature.
>> Amd-pstate driver uses the highest performance value to indicate
>> the priority of CPU. The higher value has a higher priority.
>>
>> Amd-pstate driver will provide an initial core ordering at boot time.
>> It relies on the CPPC interface to communicate the core ranking to the
>> operating system and scheduler to make sure that OS is choosing the cores
>> with highest performance firstly for scheduling the process. When amd-pstate
>> driver receives a message with the highest performance change, it will
>> update the core ranking.
>>
>> Changes form V6->V7:
>> - x86:
>> - - Modify kconfig about X86_AMD_PSTATE.
>> - cpufreq: amd-pstate:
>> - - modify incorrect comments about scheduler_work().
>> - - convert highest_perf data type.
>> - - modify preferred core init when cpu init and online.
>> - acpi: cppc:
>> - - modify link of CPPC highest performance.
>> - cpufreq:
>> - - modify link of CPPC highest performance changed.
>>
> 
> This series in now in linux-kselftest next branch for Linux 6.7-rc1.
> 
> If there are any changes and/or fixes, please send patches on top of
> linux-kselftest next branch.
> 

Sorry for the mix-up. Wrong series - my bad. This series isn't
in linux-kselftest next.

thanks,
-- Shuah

