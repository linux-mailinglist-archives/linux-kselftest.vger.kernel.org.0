Return-Path: <linux-kselftest+bounces-889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECE47FF218
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E2CB219D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA048CD0;
	Thu, 30 Nov 2023 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IwgDhQC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9B1B4;
	Thu, 30 Nov 2023 06:35:36 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SgzJ34hSZz9shK;
	Thu, 30 Nov 2023 15:35:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1701354931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/Bp7ZCE4LoczhLnxXNT+HgjRVKsaP8cit12SuScveU=;
	b=IwgDhQC3pNSAI+5O9d6vw5OMFBCN8vCCPBS3/BjLjdRO2wi+NECUrHc9PJUrPxL0ew/SVM
	8BVdgvtDDCQnDaJmzua+/obBej3X6+PObowN6U0z/hwU50bkkCaBfKYcF3kR9RpeVAsjuZ
	5LkjXeOJT12xXgArkViPQgeKlmKDL7FWtgQSp+i/pJ7VfmA1D5LYJ8mdO7Y6A9R9XFxlLi
	3CEjthucfRGoWOJy5xOMMeK1ncNIX/cwu9kFFSY4l3eAGBZpdo+olpbN/3ccqmWoNGxzgU
	HmM755zOvyj0qBK9xIisA85TmRipAvoOAtXeB4AbmUs1Z76nBPr25LxrP70Qtg==
Message-ID: <09ea3d40-e8f6-4cba-a576-ffeda8c02734@mailbox.org>
Date: Thu, 30 Nov 2023 15:35:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V11 0/7] amd-pstate preferred core
To: Meng Li <li.meng@amd.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Shimmer Huang <shimmer.huang@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Borislav Petkov <bp@alien8.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20231129065437.290183-1-li.meng@amd.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20231129065437.290183-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d85b6956544caf01d74
X-MBO-RS-META: x9mtin3t79h93gzyxr6bfmadcnbujkqq



On 11/29/23 07:54, Meng Li wrote:
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
> Changes from V10->V11:
> - cpufreq: amd-pstate:
> - - according Perry's commnts, I replace the string with str_enabled_disable().
> 

Hi,

Using clang-17, I get the following warning:

----
   drivers/cpufreq/amd-pstate.c:793:34: warning: variable 'cpudata' is 
uninitialized when used here [-Wuninitialized]
     793 |         if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:789:29: note: initialize the variable 
'cpudata' to silence this warning
     789 |         struct amd_cpudata *cpudata;
         |                                    ^
         |                                     = NULL
   1 warning generated.
----

Cheers,
Tor

