Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8782725286
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 05:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbjFGDqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 23:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbjFGDpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 23:45:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63871BE2
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 20:45:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so2955981b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686109542; x=1688701542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdpSHMsTOSVCkXRFROKcP6ci/vyGxzV4L9Wlzxsgow0=;
        b=Go5rRhNYT07xJCUsf4tMxKB6OP+B/ECVTPpMmaE0rs1IXaf1pY8RHX4Agu1IbC1Dlp
         lFjBzKmTFhgR6Ha7+lCO1aI6apgzv8BxEb0geTSRhvMYKQtUin4dfnKo5h/DpHREwOyv
         Y0o4YHpAiV22EQX7YNHmO9Biejq3kK1IfY/m1fFEgjOVaY9NtPwq4JtDTiIqAAyv7say
         cRNBDQDb8w6EE4JZr41n6EQU/qxQyRY+m6OGDk4HKHziYbXmvXEGB5rsa+OzdQJXpn4o
         t3im/yUD+lDy5I6vCYApsepqoI0rCNzvVIZzC9u5bxGIQ0pn1vrcOjaEOnSY5Rq0pp2l
         4fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686109542; x=1688701542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdpSHMsTOSVCkXRFROKcP6ci/vyGxzV4L9Wlzxsgow0=;
        b=dqn8W1VzYh8j14uEFhaQZsEPFlhoKL5WLsU/S89Pd5FKZJ96BDbz0npBVL1V4Cph97
         YlqmePH+Cmbp4Vp1EwJ4wgnGHarpWlPCX9mMQbydBSSSveqE6h3BcfAfkV+JV/GTmKU3
         VtmlbaCd7dLSR/Rrh1iqIjrvbExKklsRwkt1j/shgFyTqdrDcAbp4DK1qb1sqxePs4v7
         kHbeZCl03DhzaDbLGECUanWUe++brHRmD5oZ1y7HqlEC3pLLjpFfkbZCvpNdc04VPML0
         tSxL7uDSiXiINlRls1sey9cHKahVkXqO74FraLpe08hoZOuhe2AU/0kAoQgydHfKrQdm
         IixQ==
X-Gm-Message-State: AC+VfDx7DGG9SflENzoSblEifqN8Ksp6wG3yBoxYNUHUZNJsbGTS1Flf
        Vmw/smO2z4KFai1l6CgHp0hFlg==
X-Google-Smtp-Source: ACHHUZ6BOQu7G436PRy1bcsNq9Uf6arDa79terEt7W8v2qvEIMjsbx3eTqDoM5JyO1h6WqZD7F4rRw==
X-Received: by 2002:a05:6a21:33a9:b0:110:9b0b:71a5 with SMTP id yy41-20020a056a2133a900b001109b0b71a5mr1389481pzb.23.1686109542388;
        Tue, 06 Jun 2023 20:45:42 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001b2404c7d53sm1486521plh.175.2023.06.06.20.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:45:41 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:15:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cpufreq: Don't enable generic lock debugging
 options
Message-ID: <20230607034540.ldjugl3g6ryyyi5q@vireshk-i7>
References: <20230605-kselftest-cpufreq-options-v1-1-d4621e0c7cbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-kselftest-cpufreq-options-v1-1-d4621e0c7cbe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06-06-23, 15:11, Mark Brown wrote:
> Currently the the config fragment for cpufreq enables a lot of generic
> lock debugging.  While these options are useful when testing cpufreq
> they aren't actually required to run the tests and are therefore out of
> scope for the cpufreq fragement, they are more of a thing that it's good
> to enable while doing testing than an actual requirement for cpufreq
> testing specifically.  Having these debugging options enabled,
> especially the mutex and spinlock instrumentation, mean that any build
> that includes the cpufreq fragment is both very much larger than a
> standard defconfig (eg, I'm seeing 35% on x86_64) and also slower at
> runtime.
> 
> This is causing real problems for CI systems.  In order to avoid
> building large numbers of kernels they try to group kselftest fragments
> together, frequently just grouping all the kselftest fragments into a
> single block.  The increased size is an issue for memory constrained
> systems and is also problematic for systems with fixed storage
> allocations for kernel images (eg, typical u-boot systems) where it
> frequently causes the kernel to overflow the storage space allocated for
> kernels.  The reduced performance isn't too bad with real hardware but
> can be disruptive on emulated platforms.
> 
> In order to avoid these issues remove these generic instrumentation
> options from the cpufreq fragment, bringing the cpufreq fragment into
> line with other fragments which generally set requirements for testing
> rather than nice to haves.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/cpufreq/config | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
> index 75e900793e8a..ce5068f5a6a2 100644
> --- a/tools/testing/selftests/cpufreq/config
> +++ b/tools/testing/selftests/cpufreq/config
> @@ -5,11 +5,3 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>  CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> -CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_PLIST=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_MUTEXES=y
> -CONFIG_DEBUG_LOCK_ALLOC=y
> -CONFIG_PROVE_LOCKING=y
> -CONFIG_LOCKDEP=y
> -CONFIG_DEBUG_ATOMIC_SLEEP=y

FWIW, I enabled these earlier as cpufreq core had a history of races
that are normally not caught without these enabled. But I think we
have come a long way from that and these can be removed now.

-- 
viresh
