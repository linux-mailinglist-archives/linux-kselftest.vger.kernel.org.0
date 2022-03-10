Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3EE4D52D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 21:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbiCJUIc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244416AbiCJUIb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 15:08:31 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA7199E3D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:07:22 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x4so7797648iop.7
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8B7PTwpEj2hkDnT/J/VZkso+LVKgn3u2x/4HYZc/AS0=;
        b=e9t9dSxp92zF3Ccwz45XUkbU+or15wnGVIUXYTKL0EVQCW3Bh1cEkGKvKY1iXjJdV1
         /kx8OHDVjqf3YcZNq39+FbucpbZy/IANSYCug+8f/nBJvYPjAVx0uf3rDbqICCXnOK8m
         b+gCb+wN/GzUuY+EP1CYne31Ox/hGM2IJRmQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8B7PTwpEj2hkDnT/J/VZkso+LVKgn3u2x/4HYZc/AS0=;
        b=M1vq8FYH4gmeF+wrL8J51SlgzA7bNiI81Cn5fOgKi/DmQm0RMXp6swBb6hZ2ITKTln
         NV+9topej4eY/r693ArczJH+dK/JHlWwlD0OLeo8glOtrAhrFJjzadaxRydSkH28R7er
         abjvA2nvbqhplxIcyvUCR9zh/Gun3dzpKE2w5Qajj0OQuvjbrGO7zbT1S4omyfXrpfjp
         dM8oqqGzGfVQ5Yfsxv9MI25fV0D9btuTooXZ2lHrqRNgzYvGhv7KCA70VjTjmK3Tit2G
         TDLIAVduMx2ByiAtUCMJvNgL26BR1hindEn7plBzwRLH6A3lUNVKnjYW4F5yqH5WHt3n
         hC7A==
X-Gm-Message-State: AOAM530RlM7Dq15dicB6nAC2p8bMqEcuL1SLaABhISYhGv4tt7raQYM5
        z7J3eMDedJ70SE8oePiacCiZXw==
X-Google-Smtp-Source: ABdhPJws1DU0tJ2NIMXKpuwBkyL2xnVDuJZHGR8sg47tpFADKS9MnxDihrJivPen90+J0NQ7f1N6dQ==
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id g6-20020a05660203c600b0063dcac9bd35mr5237446iov.144.1646942842119;
        Thu, 10 Mar 2022 12:07:22 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 142-20020a6b0194000000b00645b6cda8bfsm3045768iob.17.2022.03.10.12.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:07:21 -0800 (PST)
Subject: Re: [PATCH v1 4/4] kselftest/arm64: Add simple test for MTE prctl
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-5-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8431e34d-183b-368f-37e0-391a6207e2c3@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 13:07:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310144335.2097457-5-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/10/22 7:43 AM, Mark Brown wrote:
> The current tests use the prctls for various things but there's no
> coverage of the edges of the interface so add some basics. This isn't
> hugely useful as it is (it originally had some coverage for the
> combinations with asymmetric mode but we removed the prctl() for that)
> but it might be a helpful starting point for future work, for example
> covering error handling.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/mte/.gitignore  |   1 +
>   .../testing/selftests/arm64/mte/check_prctl.c | 123 ++++++++++++++++++
>   2 files changed, 124 insertions(+)
>   create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
