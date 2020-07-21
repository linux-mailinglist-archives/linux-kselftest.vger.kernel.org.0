Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250CE2282EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgGUO6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgGUO6A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 10:58:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F99C0619DB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 07:57:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so3178063wmf.5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P69TuXHvKNdQBsX1NlqieN+/6fhlcIyh2dYab6XhtNw=;
        b=SnBgx4Gzfcfd974HbTiO6hEVYFWvZ58XMHaSjnkdia94BS6Kfyy1kSjtt3SLY1jUwv
         nm5CGZ2YELLVOYdBig3YU9pqubCGvfIDE8T8yGs2i9lZ8ybJJJ/2U0TBNvbiM5Nm5efU
         Az0OUSooBItyLMK6Fiez5Ddx3TmQCjL5cU9trk1HvY05OqnsAgO6fXfwLIHzBa1rJXvV
         bAWNI7etXswlx2uGkFWCmkk29lxfKaFMwIYCOWBThBiCp3vZb2yWMP9esJ0sMpRrD5tl
         TWV7N1u34O7ubcmuhTr7L+oZlbdBCC4dA24VCxg2SD0elWD72u1wvTJvYpnZG7vumr4C
         rpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P69TuXHvKNdQBsX1NlqieN+/6fhlcIyh2dYab6XhtNw=;
        b=WR8x4ZNULlP/DIvidovF1ZWbCzBxXnt0V/Bng3Z71DVcojA4D/OJ3Cf1eL4vDutudc
         nMT9nBGlE3HGmSVEhf4kX4V8zsOOu39BCFTzGT7x/JlJLjeG2be4gDX19GtqDkNa/qN8
         egCUEAGmQcIkRCCw48HWCGyKQY/a+ooAw2ZczHLPmV8SVnTIAd1r56LV+ZkwYefKriiC
         Brs527HMfvTQi76x7+8MQfcgqZcsPp6YkxaIQELxXRef32AusJoCHcPDWe7lo3lSb/4k
         KzsVjWALEx+cMc3di3DzAlSEo1rIeP5dxTgUXFgjuoBwY1HLtioNieuGorhAmUCN2ywY
         1ObQ==
X-Gm-Message-State: AOAM533cMkSV7T86U19I1cPjylhCCaGo5aa76T2Oota8JZyK8F8Gv4fP
        Ue4IKyLsRdSxT4J0/NprPsiSNKNyqD8=
X-Google-Smtp-Source: ABdhPJwmyYPpJ7IlGzdg37/DHGP0G/PgZIfG3gVw3ye2a3qGLs9fU5dW3PkSOTTiGnteyAU6Eht4DQ==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr4396008wmn.186.1595343477981;
        Tue, 21 Jul 2020 07:57:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id d18sm40382259wrj.8.2020.07.21.07.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 07:57:57 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Selftest for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>, rjw@rjwysocki.net,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        pratik.r.sampat@gmail.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200721124300.65615-1-psampat@linux.ibm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <17e884b8-09d8-98a8-3890-bf506d2cdfca@linaro.org>
Date:   Tue, 21 Jul 2020 16:57:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721124300.65615-1-psampat@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21/07/2020 14:42, Pratik Rajesh Sampat wrote:
> v2: https://lkml.org/lkml/2020/7/17/369
> Changelog v2-->v3
> Based on comments from Gautham R. Shenoy adding the following in the
> selftest,
> 1. Grepping modules to determine if already loaded
> 2. Wrapper to enable/disable states
> 3. Preventing any operation/test on offlined CPUs 
> ---
> 
> The patch series introduces a mechanism to measure wakeup latency for
> IPI and timer based interrupts
> The motivation behind this series is to find significant deviations
> behind advertised latency and resisdency values

Why do you want to measure for the timer and the IPI ? Whatever the
source of the wakeup, the exit latency remains the same, no ?

Is all this kernel-ish code really needed ?

What about using a highres periodic timer and make it expires every eg.
50ms x 2400, so it is 120 secondes and measure the deviation. Repeat the
operation for each idle states.

And in order to make it as much accurate as possible, set the program
affinity on a CPU and isolate this one by preventing other processes to
be scheduled on and migrate the interrupts on the other CPUs.

That will be all userspace code, no?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
