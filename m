Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024F937F4BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 11:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhEMJTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 05:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhEMJTo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 05:19:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D93TOl155080;
        Thu, 13 May 2021 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HUS1vgx07XFhtJ9A6JVfYYAErRkCgsTiRdZOybD0PJY=;
 b=kfa3qdPlVe7c7AqvQpyeIbxi9FkJNIO6yeSpxr8pAD1jlPs9rxpBJ8XwIEMKkX+ungWt
 gsRPX/dwtdjKCPTOq6Fzko8fh0fEks5R7u+OzT94nWgvd8ex7XhxcAMyrnWE9quWtD6R
 dNYtpceS3jWS7B1LLg3uJ2/DatdUMMhSkzyM5h32m0NYu6wB2Mg0BcWZQYqA4UhdPDCd
 t8Axn9jfboUSBXuG3oY8pY51I7gFOBJUMpU2fEyYJiG07p7SJymdZXlKq6NxO/9ho+l6
 PSm+9A70s8EQ6ZiWTDrb/Mw+QLxaY7ZfggmJOldgMHyxnG4r7yBg6A6HM8u/vf1we7Pb hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38h0g01cu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 05:18:28 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14D942ZD157343;
        Thu, 13 May 2021 05:18:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38h0g01ctg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 05:18:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D9FRJF020038;
        Thu, 13 May 2021 09:18:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 38dj98amtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 09:18:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D9INne36634894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 09:18:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76E2F11C05C;
        Thu, 13 May 2021 09:18:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2F811C052;
        Thu, 13 May 2021 09:18:21 +0000 (GMT)
Received: from [9.85.73.125] (unknown [9.85.73.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 09:18:20 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] CPU-Idle latency selftest framework
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        dsmythies@telus.net, dedekind1@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com
References: <20210430082804.38018-1-psampat@linux.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <7324c475-6f33-b075-03ce-2f32f4bf15ff@linux.ibm.com>
Date:   Thu, 13 May 2021 14:48:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210430082804.38018-1-psampat@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AMKV4YYSYdT3xgfWl8PKX2n6Jzw2S_bx
X-Proofpoint-ORIG-GUID: fS_ihhVuGaLAae26maEGYuRN-2iKy-gn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_04:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130070
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi @Rafael and @Shuah,

Gentle ping.

Is there any feedback on this patch-set?

Quick summary and history:
1. The patchset introduces a kernel module and a bash selftest driver to
    estimate wakeup latency caused by entering idle states
2. The patchset has seemed to provide useful feedback on latency of idle 
states
    on the IBM POWER architecture
3. It also seems to also be providing desirable results on Intel 
machines with
    the IPI mechanism (Timer tests are optional here due to some Intel
    processors having a pre-wakeup feature and may not tend to actual idle
    latency) as reviewed by Doug Smythies.
    Intel numbers for reference: https://lkml.org/lkml/2021/4/13/785

--
Thanks
Pratik

On 30/04/21 1:58 pm, Pratik R. Sampat wrote:
> Changelog RFC v4 --> PATCH v5:
> 1. Added a CPU online check prior to parsing the CPU topology to avoid
>     parsing topologies for CPUs unavailable for the latency test
> 2. Added comment describing the selftest in cpuidle.sh
>
> As I have made changes to cpuidle.sh's working, hence dropping
> "Reviewed-by" from Doug Smythies for the second patch, while retaining
> it for the first patch.
>
> RFC v4: https://lkml.org/lkml/2021/4/12/99
> ---
> A kernel module + userspace driver to estimate the wakeup latency
> caused by going into stop states. The motivation behind this program is
> to find significant deviations behind advertised latency and residency
> values.
>
> The patchset measures latencies for two kinds of events. IPIs and Timers
> As this is a software-only mechanism, there will additional latencies of
> the kernel-firmware-hardware interactions. To account for that, the
> program also measures a baseline latency on a 100 percent loaded CPU
> and the latencies achieved must be in view relative to that.
>
> To achieve this, we introduce a kernel module and expose its control
> knobs through the debugfs interface that the selftests can engage with.
>
> The kernel module provides the following interfaces within
> /sys/kernel/debug/latency_test/ for,
>
> IPI test:
>      ipi_cpu_dest = Destination CPU for the IPI
>      ipi_cpu_src = Origin of the IPI
>      ipi_latency_ns = Measured latency time in ns
> Timeout test:
>      timeout_cpu_src = CPU on which the timer to be queued
>      timeout_expected_ns = Timer duration
>      timeout_diff_ns = Difference of actual duration vs expected timer
>
> Sample output on a POWER9 system is as follows:
> # --IPI Latency Test---
> # Baseline Average IPI latency(ns): 3114
> # Observed Average IPI latency(ns) - State0: 3265
> # Observed Average IPI latency(ns) - State1: 3507
> # Observed Average IPI latency(ns) - State2: 3739
> # Observed Average IPI latency(ns) - State3: 3807
> # Observed Average IPI latency(ns) - State4: 17070
> # Observed Average IPI latency(ns) - State5: 1038174
> # Observed Average IPI latency(ns) - State6: 1068784
> #
> # --Timeout Latency Test--
> # Baseline Average timeout diff(ns): 1420
> # Observed Average timeout diff(ns) - State0: 1640
> # Observed Average timeout diff(ns) - State1: 1764
> # Observed Average timeout diff(ns) - State2: 1715
> # Observed Average timeout diff(ns) - State3: 1845
> # Observed Average timeout diff(ns) - State4: 16581
> # Observed Average timeout diff(ns) - State5: 939977
> # Observed Average timeout diff(ns) - State6: 1073024
>
>
> Things to keep in mind:
>
> 1. This kernel module + bash driver does not guarantee idleness on a
>     core when the IPI and the Timer is armed. It only invokes sleep and
>     hopes that the core is idle once the IPI/Timer is invoked onto it.
>     Hence this program must be run on a completely idle system for best
>     results
>
> 2. Even on a completely idle system, there maybe book-keeping tasks or
>     jitter tasks that can run on the core we want idle. This can create
>     outliers in the latency measurement. Thankfully, these outliers
>     should be large enough to easily weed them out.
>
> 3. A userspace only selftest variant was also sent out as RFC based on
>     suggestions over the previous patchset to simply the kernel
>     complexeity. However, a userspace only approach had more noise in
>     the latency measurement due to userspace-kernel interactions
>     which led to run to run variance and a lesser accurate test.
>     Another downside of the nature of a userspace program is that it
>     takes orders of magnitude longer to complete a full system test
>     compared to the kernel framework.
>     RFC patch: https://lkml.org/lkml/2020/9/2/356
>
> 4. For Intel Systems, the Timer based latencies don't exactly give out
>     the measure of idle latencies. This is because of a hardware
>     optimization mechanism that pre-arms a CPU when a timer is set to
>     wakeup. That doesn't make this metric useless for Intel systems,
>     it just means that is measuring IPI/Timer responding latency rather
>     than idle wakeup latencies.
>     (Source: https://lkml.org/lkml/2020/9/2/610)
>     For solution to this problem, a hardware based latency analyzer is
>     devised by Artem Bityutskiy from Intel.
>     https://youtu.be/Opk92aQyvt0?t=8266
>     https://intel.github.io/wult/
>
> Pratik R. Sampat (2):
>    cpuidle: Extract IPI based and timer based wakeup latency from idle
>      states
>    selftest/cpuidle: Add support for cpuidle latency measurement
>
>   drivers/cpuidle/Makefile                   |   1 +
>   drivers/cpuidle/test-cpuidle_latency.c     | 157 ++++++++
>   lib/Kconfig.debug                          |  10 +
>   tools/testing/selftests/Makefile           |   1 +
>   tools/testing/selftests/cpuidle/Makefile   |   6 +
>   tools/testing/selftests/cpuidle/cpuidle.sh | 414 +++++++++++++++++++++
>   tools/testing/selftests/cpuidle/settings   |   2 +
>   7 files changed, 591 insertions(+)
>   create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
>   create mode 100644 tools/testing/selftests/cpuidle/Makefile
>   create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
>   create mode 100644 tools/testing/selftests/cpuidle/settings
>

