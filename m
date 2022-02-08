Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5DD4ACD55
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiBHBGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiBHAKi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:10:38 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C53C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:10:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n17so19132177iod.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SrBqlkGqEVLCuNbr1CjFlCILvwaRUMqCDPVo0Ntr/o0=;
        b=M8Pw3UzPapDdWi2l1ctXXBMaMWbnfhNRRe8y/IVeu6nwyHObA4srpBSdptXAYPntEJ
         fr2XvaAgjjHmiUBdVR7Qn+T+t4y+/CdVH3jf+W1l9jo48cqHi+jRiWRJYv0OntDu5W0r
         myAW1P8pWHobosSqZtMLqjhIL05ytrF0BnjCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrBqlkGqEVLCuNbr1CjFlCILvwaRUMqCDPVo0Ntr/o0=;
        b=tjnHZymLxN62g/NXujoNXZmJ1DvYN6RbH5ZVlMbFgA170gvj5i1uWP4glY33Az+b2h
         VT37Gi6XCqMkpzK1AebkYQuLYGu9aM+XN8kdlm+mptqJ5kmKA/Wxog3BfdADiefsHqpj
         Vt4+7szbicPWWd6rt/nRtrSzzH13B0oXPq7G6Nbo7x4YVAlq0dByTJTHNbsErvVxfg/K
         iR9NTWbTimmJoPFk9TEdjW86wfMjCA2yyC7Ajp1mTw7Ce79R+dYUTOYp5XNm2bT8AO6B
         u32wvUbgaE92V1nE8m4s6qSfuTZIeoNZ6fk1rLlF8zlEL2JqN8mz8t7NZc22FWabiYF0
         h4Xw==
X-Gm-Message-State: AOAM530inhl93Ujcp3ZccnrlM7YWLQ59LCAHRMAF7BzQd1GX44hPfvQS
        LuVXgoFYq/zI3Gi8lCLMI5dHlggfHAEEPg==
X-Google-Smtp-Source: ABdhPJz96efCiEzcb2TCaOoSiUJ9kzp5Ms/xo65+4sdHjaY8FTOBmUmbwg4ZUlnUJMMPRZEDyXvyZQ==
X-Received: by 2002:a05:6638:328c:: with SMTP id f12mr972239jav.249.1644279036957;
        Mon, 07 Feb 2022 16:10:36 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l16sm3264042ilc.54.2022.02.07.16.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:10:36 -0800 (PST)
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 17:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-7-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On 2/7/22 8:20 AM, Mark Brown wrote:
> Provide ABI documentation for SME similar to that for SVE. Due to the very
> large overlap around streaming SVE mode in both implementation and
> interfaces documentation for streaming mode SVE is added to the SVE
> document rather than the SME one.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

A few typos and missing SPDX comments below.
> ---
>   Documentation/arm64/index.rst |   1 +
>   Documentation/arm64/sme.rst   | 432 ++++++++++++++++++++++++++++++++++
>   Documentation/arm64/sve.rst   |  70 +++++-
>   3 files changed, 493 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/arm64/sme.rst
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index 4f840bac083e..ae21f8118830 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -21,6 +21,7 @@ ARM64 Architecture
>       perf
>       pointer-authentication
>       silicon-errata
> +    sme
>       sve
>       tagged-address-abi
>       tagged-pointers
> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
> new file mode 100644
> index 000000000000..15df3157c592
> --- /dev/null
> +++ b/Documentation/arm64/sme.rst
> @@ -0,0 +1,432 @@

Missing SPDX here?

> +===================================================
> +Scalable Matrix Extension support for AArch64 Linux
> +===================================================
> +


> +
> +When returning from a signal handler:
> +
> +* If there is no za_context record in the signal frame, or if the record is
> +  present but contains no register data as desribed in the previous section,

described

> +  then ZA is disabled.
> +

> +	PR_SME_SET_VL_ONEXEC
> +
> +	    Defer the requested vector length change until the next execve()
> +	    performed by this thread.
> +
> +	    The effect is equivalent to implicit exceution of the following

execution

> +	    call immediately after the next execve() (if any) by the thread:
> +

> +
> +[3] Documentation/arm64/cpu-feature-registers.rst
> +
> +[4] ARM IHI0055C
> +    http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
> +    http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
> +    Procedure Call Standard for the ARM 64-bit Architecture (AArch64)
> diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
> index 9d9a4de5bc34..93c2c2990584 100644
> --- a/Documentation/arm64/sve.rst
> +++ b/Documentation/arm64/sve.rst
> @@ -7,7 +7,9 @@ Author: Dave Martin <Dave.Martin@arm.com>
>   Date:   4 August 2017
>   

Missing SPDX perhaps?

>   This document outlines briefly the interface provided to userspace by Linux in
> -order to support use of the ARM Scalable Vector Extension (SVE).
> +order to support use of the ARM Scalable Vector Extension (SVE), including
> +interactions with Streaming SVE mode added by the Scalable Matrix Extension
> +(SME).
>   

Looks good otherwise.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
