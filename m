Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376DB4ACD80
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiBHBGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiBGX53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 18:57:29 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD8C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:57:29 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 15so12539455ilg.8
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ej/oxUOPfotPxZF6x1ri18KCfGD2YGEa1yg//ehHnUo=;
        b=JM1m+wmNu9FmFD+riCw6wb0p0d0pPl0h2477lD+tG9SKyf0FsP7JkN9pPVcDr3gd+W
         j2ePlxvb84+QbHooh0I29hU87nJlmnnGpzAlcozQSqqYKSVKvv0ozt9M9NGf7soKkz/n
         HC6i2z7jO6xoxajglXYzdv/Xw1DRQ96BgXnt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ej/oxUOPfotPxZF6x1ri18KCfGD2YGEa1yg//ehHnUo=;
        b=Pu1DVR+yp6PRy6RqYEZ8ouCqgsQ/kiZXbXHnaCLESStOIO7udFjvbFMs3RkJOn4Dfx
         8CfkHHW5+kYa63PXC25prziQUEoam0wmhOgEMVZmEvOcJ6IEcs5EvKLcAEVox2in8RsC
         FhwC4iCMfyIckTYhSZhCM6leSu6bLrykcq/FfPUKL7ADYrCs6nbC1YSrvUqorPQjPcDQ
         F5bOjEWVyY9Z0t49FSZ4+K6ULkXQCUvPy8nTn55ui2gwi8poxofLBH8Weaecq1sQ2hj8
         wMiVRHyvGNHM1Se+7wEqp3sSd60V6vH7bGcOM525GAhPgmvAiavghCjFHDey5TeuDSV4
         ScDg==
X-Gm-Message-State: AOAM533iS05aEO36625ZI3SSwRWa11EbqCVDCxX/7SGaNsJk/pDEayy+
        j48Tqtofz59rVtppPOy2AluZYg==
X-Google-Smtp-Source: ABdhPJwk8Uh5JobMOPX23+iidTPeN7IN+ed0TPp/GJ65/GbrujVjigZ3b7VgXcHPdBWjo2As4O2qpQ==
X-Received: by 2002:a05:6e02:e12:: with SMTP id a18mr886458ilk.200.1644278248618;
        Mon, 07 Feb 2022 15:57:28 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b4sm2861038iln.15.2022.02.07.15.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 15:57:28 -0800 (PST)
Subject: Re: [PATCH v11 30/40] kselftest/arm64: Add manual encodings for SME
 instructions
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
 <20220207152109.197566-31-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <638b7ae1-6669-5524-318a-6b8a07cf3919@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 16:57:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-31-broonie@kernel.org>
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

On 2/7/22 8:20 AM, Mark Brown wrote:
> As for the kernel so that we don't have ambitious toolchain requirements
> to build the tests manually encode some of the SVE instructions.
> 

Thank you for thinking about toolchain requirements. Please add a bit more
information on how these defines are used here in this commit log.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Rest looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
