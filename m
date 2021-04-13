Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E595335E1E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhDMOwo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhDMOwn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 10:52:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475FC061756
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 07:52:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a9so6482682ioc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaG9SlK2TqX99hyj4X3DH5qQ2uV7HTsovkwb7Rge0m0=;
        b=OLZX5pjB4+Qr6jM0mMsqBEBVXYfIiHD0F7lzBGhl3NJKceaJtqhcH7L6PIu3gGrw9y
         OgGRhSeVFCyzHM+uawZvUpGuwpSIQNh0annQ3+zlcE1R16Tz7MuZofY6tF1tUnJKytHF
         d+imtLuTxc81AIJMIFjTwkm1H09XGIXAmFp1OWqjOQqU4JxczaIPfuO/vWD5iEAiCXTf
         8/ym8y8ofR3AYzveO5TSyIw3pC4g4YfI8zyAglmSRaAvBF5KJik4il01hbUjGgDBfkbL
         fcbq1nxUQ7UVo1YKVgl6sMXqfn+sot1o0hXM9X4hXo38v+1WOSHvjSfbqWMKVTiWlCkR
         N0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaG9SlK2TqX99hyj4X3DH5qQ2uV7HTsovkwb7Rge0m0=;
        b=tITm5IRmzS7wabJG1EMSdExHsmHGnh08IfGmMKU0yiEJsgbvZdgx+QulDv54llD9Qv
         704HL+KZhYSP6VWIVb8CV5yf+XAeN1cXXEqpnjQIR2wtw1vrp1cFCze5kmilHm9Evz0f
         gkLyaNsZueASKNabWoDA+nrmpgTQOB3U7cvb+GIQvlgmmbb5E7G3gGkoiQYXTRjX/Nuj
         MhZmvchmsHhaqzhqcb6zbIURDoDU8Ny4pBV2dpwLDe1j77GGPBGRSApNIL1LmikMDotn
         Y/TAjN2YjsOHwFr0YQvoxHRT3qX0qnUMPx2DrnYdOCIxi5P++ONqCQZfjYOviXHecTd0
         j61w==
X-Gm-Message-State: AOAM532zf5+hWNgo5SyaRgRwIg09ed2Gsl9rH0IHuiyP9QLIPXJY4oDm
        iCRXgR3ln7XiDjoE0AaOy+ordGfkDajLS2J/1Vq/wg==
X-Google-Smtp-Source: ABdhPJw+jNjf7CuSQF9i/4XJn8Pnlv48cWwrH20lo7x6+MyPZRxg8ejfueCvWfkLpPOrcJQevhlU+PqzZPPCxfUxpgM=
X-Received: by 2002:a05:6638:ecf:: with SMTP id q15mr3950964jas.129.1618325541042;
 Tue, 13 Apr 2021 07:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210412074309.38484-1-psampat@linux.ibm.com>
In-Reply-To: <20210412074309.38484-1-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 13 Apr 2021 07:52:14 -0700
Message-ID: <CAAYoRsVob1UBukdDAQBJrp6xV03u0V67SgfTVkWQ9bN1XhS8Jw@mail.gmail.com>
Subject: Re: [RFC v4 0/2] CPU-Idle latency selftest framework
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,

V4 seems fine. Thank you.

On Mon, Apr 12, 2021 at 12:43 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
> Changelog v3-->v4
> Based on review comments by Doug Smythies,
> 1. Parsing the thread_siblings_list for CPU topology information to
>    correctly identify the cores the test should run on in
>    default(quick) mode.
> 2. The source CPU to source CPU interaction in the IPI test will always
>    result in a lower latency and cause a bias in the average, hence
>    avoid adding the latency to be averaged for same cpu IPIs. The
>    latency will still be displayed in the detailed logs.
>
> RFC v3: https://lkml.org/lkml/2021/4/4/31

Example output for an Intel i5-10600K, HWP active, performance mode.
System very idle:

$ sudo ./cpuidle.sh -v -i
Inserting /lib/modules/5.12.0-rc7-prs-v4/kernel/drivers/cpuidle/test-cpuidle_latency.ko
module

--IPI Latency Test---
Baseline Avg IPI latency(ns): 686
Observed Avg IPI latency(ns) - State 0: 468
Observed Avg IPI latency(ns) - State 1: 956
Observed Avg IPI latency(ns) - State 2: 17936
Observed Avg IPI latency(ns) - State 3: 17968

--Timeout Latency Test--
Baseline Avg timeout diff(ns): 445
Observed Avg timeout diff(ns) - State 0: 377
Observed Avg timeout diff(ns) - State 1: 630
Observed Avg timeout diff(ns) - State 2: 322812
Observed Avg timeout diff(ns) - State 3: 306067
Removing /lib/modules/5.12.0-rc7-prs-v4/kernel/drivers/cpuidle/test-cpuidle_latency.ko
module
Full Output logged at: cpuidle.log

$ grep . /sys/devices/system/cpu/cpu7/cpuidle/state*/residency
/sys/devices/system/cpu/cpu7/cpuidle/state0/residency:0
/sys/devices/system/cpu/cpu7/cpuidle/state1/residency:1
/sys/devices/system/cpu/cpu7/cpuidle/state2/residency:360
/sys/devices/system/cpu/cpu7/cpuidle/state3/residency:3102
$ grep . /sys/devices/system/cpu/cpu7/cpuidle/state*/latency
/sys/devices/system/cpu/cpu7/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu7/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu7/cpuidle/state2/latency:120
/sys/devices/system/cpu/cpu7/cpuidle/state3/latency:1034

... Doug
