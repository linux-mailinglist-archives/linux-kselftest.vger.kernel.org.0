Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB549A4FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3408922AbiAYAYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847405AbiAXXTo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 18:19:44 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854BC06F8F1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:27:11 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 15so805219ilg.8
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U2OOTEeEVZfOH1K8JKszpYA1Lc7+2wsRJpO5eZWN2Ao=;
        b=PQmntUo/TBuELaF81KWI8+FByADPtTIvkCm1Q9vzpVA0Fu6JOT5pXI3aZnjyB1hgYr
         QrgL9W9w1C7vH7pZwmsoJTD9W7sTNxbvHWQix1DfG8XPjbBEbIDO/M05o9Y/Qp/zPLNZ
         o+KqNjTY2el8Mz+XwRykNM4wmPoRTyLqp/23U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U2OOTEeEVZfOH1K8JKszpYA1Lc7+2wsRJpO5eZWN2Ao=;
        b=UjfICX+dlgyAi9wP451KhO5733uC7qMdZGe+P0sO4kzR5zdyO3P2eakcjksUzhBYzo
         ZRoFJlM70TqCzj+K7Qfhj7vZKsccJkyYZUeWHJkhxZObYY+7nq1eUDtbg3RvG1MK2Zv4
         WCcedjdn+/UlidgioZUYUvROFRRj3KE2Fpxzk2jU0HH2hKgGlRjF01N62UliNh38NTob
         0I3hCN0nx7YoA65GlRpXYPqGfUWladYcy23EZk9uFhMNpZjK5L7UHk1Z1F6wUSxkfEmM
         CQ+u2auZgQbZuAGXqQOlFCM6Lid4vaxv8tVPHV9ZZi0v1dIOTLj3m6gv9TYbo2icsTsr
         CBMA==
X-Gm-Message-State: AOAM533v8yPXe9Q3dz0Q1MDjsc7KX3QhOvnU5jP1kyfncvnYwwPgoeWm
        Ay+dMesNaxVMmDC4n0Wq0yGmfQ==
X-Google-Smtp-Source: ABdhPJwiPWZl3jeukp9LXtarpTVJprj76cYGgmYJJfpDWLQ3lpreXhjBMCZEEyie4LWd53GTAFzbug==
X-Received: by 2002:a05:6e02:1529:: with SMTP id i9mr9681422ilu.149.1643059630444;
        Mon, 24 Jan 2022 13:27:10 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id n9sm8693321ilk.27.2022.01.24.13.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:27:10 -0800 (PST)
Subject: Re: [PATCH v1 1/2] kselftest/arm64: Skip VL_INHERIT tests for
 unsupported vector types
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
 <20220124175527.3260234-2-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e9849218-24aa-cccb-21c4-a0467cffd4fb@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 14:27:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124175527.3260234-2-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 10:55 AM, Mark Brown wrote:
> Currently we unconditionally test the ability to set the vector length
> inheritance flag via ptrace meaning that we generate false failures on
> systems that don't support SVE when we attempt to set the vector length
> there. Check the hwcap and mark the tests as skipped when it's not present.
> 
> Fixes: 0ba1ce1e86052d ("selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index af798b9d232c..0cf78360c5bc 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -557,7 +557,14 @@ static int do_parent(pid_t child)
>   		}
>   
>   		/* prctl() flags */
> -		ptrace_set_get_inherit(child, &vec_types[i]);
> +		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
> +			ptrace_set_get_inherit(child, &vec_types[i]);
> +		} else {
> +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT set\n",
> +					      vec_types[i].name);
> +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT cleared\n",
> +					      vec_types[i].name);

These messages are a bit confusing. Are we skipping two tests?
These messages can be combined into one like this one on lin 572:

ksft_test_result_skip("%s get/set VL %d\n", vec_types[i].name, vl);

> +		}
>   
>   		/* Step through every possible VQ */
>   		for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
> 

thanks,
-- Shuah
