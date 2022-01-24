Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E666E49A504
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3408928AbiAYAYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847702AbiAXXUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 18:20:23 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1ADC028BE5
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:28:32 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id r15so15070186ilj.7
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4CgKsGzVlMnfjFoeVR5OO6J0ZRUsEJMbJkhPKv8MPqw=;
        b=dTXLQWwaw9jbYBdsqAl1CTCdANKaEWZFRL4AyvTmK7QJSlHkB5wgMGQFcVqHPBlWV2
         hpDLb/5/DgN5tliam4WkYCT6lhB93P5waVpjNHMPnHIc044YVVe6x7D0V7Rt3SYOCcoq
         PSgXlHbQoNvId2Y0Hc/xQglq+MrnIXs2XkTQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4CgKsGzVlMnfjFoeVR5OO6J0ZRUsEJMbJkhPKv8MPqw=;
        b=Q6RWbpikKqzzl5ySbMk/bWYb+JK24beoeaw2Y+mrvh4QPpevBQh2h0D2UNqck/qXqQ
         dqHmLLKL8fcLpO6MhIS/AqPpfACLW71KT0wE/B7CG+wMU/KvPwciMcUsWOpKJTQOCqc8
         TES4mArbRTrenoKisOtCxzigKOc3/wYxKnH9VbZhqK2ZSPtoHVk/shu8uRl7XA36TMe+
         quJpD9+63Tp6hGZS/KbkTs9+aLQPK4EMG9htNPMT4Ko6MYgz0iNqmamyFV0STPJGFgo/
         HdS/ZRgV8cOG8ljgBO2nS31aUvA4k4JXAKdSAFZrH5z9uqKnxbqTwS6NZnYclGgstaY2
         KtjQ==
X-Gm-Message-State: AOAM530Vx0nmS2CA/b3vsWsVQlDY00zH9in5eq8dDFFONEPozfI6Ow5v
        Us1UTU50Pb6YLocnJL3jYjVF6g==
X-Google-Smtp-Source: ABdhPJxFQS93N5SchbQlJSPFBSZGMeNPeZM6BvmEwJWnE8j/0hGQPXFfWUl5TaVdOg6JmLzk3rRl+Q==
X-Received: by 2002:a05:6e02:17c6:: with SMTP id z6mr9151176ilu.128.1643059711847;
        Mon, 24 Jan 2022 13:28:31 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id x2sm7726874ilm.19.2022.01.24.13.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:28:31 -0800 (PST)
Subject: Re: [PATCH v1 2/2] kselftest/arm64: Correct logging of FPSIMD
 register read via ptrace
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
 <20220124175527.3260234-3-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a8ec61fd-45c0-96e2-5a58-7dd3caf22844@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 14:28:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124175527.3260234-3-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 10:55 AM, Mark Brown wrote:
> There's a cut'n'paste error in the logging for our test for reading register
> state back via ptrace, correctly say that we did a read instead of a write.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 0cf78360c5bc..a3c1e67441f9 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -261,7 +261,7 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
>   	}
>   
>   	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
> -			 "Set FPSIMD registers via %s\n", type->name);
> +			 "Got FPSIMD registers via %s\n", type->name);
>   	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
>   		goto out;
>   
> 

Looks good to me. Assuming this is going through ARM tree

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
