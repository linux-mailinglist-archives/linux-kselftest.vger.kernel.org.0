Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A852222F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiEJRXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiEJRXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 13:23:02 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6E237BA0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:19:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f5so11779840ilj.13
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpw9I89qJYQJF8uFqtgcVw/roX6X9ylD+k7qNFu4ycI=;
        b=A/v5mGazYqIG/bNX4LVLdz9uKerPRuJU0fbbEL2AZA1tr8bZJGyY2rYYZHGlDiri/y
         WUfgaj7DCYUbjWUdGJF8SMrTFnQH3rUQEYMC/K7i9rnDQIS2/0brkF0xnt5DVPajZwO4
         7D0VbyDM59akmHGUzfLATXRWQNsvBIM7RNjf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpw9I89qJYQJF8uFqtgcVw/roX6X9ylD+k7qNFu4ycI=;
        b=f8DclDgBqztiNFfYp6C2QX7zRDOrEyKclOwv+KwDY2+IZlmVG12PjiqNAL3OjsO8F+
         18ro1/Ix+B1Sw/7RqVZSg4fhDSmW/p25SbuGMFnaZymf0RD3KqT9z70Heoup6lTmIPI6
         BKBA2fN7TIzTErGfEKqok4ItEo97Xz/L9IdK+Px/ONBpn5ERbeLqvzJ+7I81r8vXjKAV
         mjWgLxpK5jtbibAM2mi2mYGDaSNETHbfBQfbLpHEBeC4KhhkcmtQbj2Lmq+J0wGElpC7
         Yta80lEkcXyx+a0Uoztkk6JR9DFAzrRskOaaND1MzQdiPhzkQCML3TgYEeyVwe0TmdLz
         RKUQ==
X-Gm-Message-State: AOAM530gmMN7syahMPpkMOPfeYy+lFPNOBX3WGjCIQdAm7hFLX+hy+jV
        nMvGsSiYxEH7JkI0mdOoO7D7qQ==
X-Google-Smtp-Source: ABdhPJy0Gxik5ftsiklTUiYF/kDUbHuHTXb+qZYvQFyMx5wUQ3fecORQ1iROQmASxul9z4x/WOXsbw==
X-Received: by 2002:a92:c8ca:0:b0:2cb:fb69:b0e8 with SMTP id c10-20020a92c8ca000000b002cbfb69b0e8mr9607048ilq.238.1652203143907;
        Tue, 10 May 2022 10:19:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c9-20020a056638028900b0032b3a781796sm4525199jaq.90.2022.05.10.10.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:19:03 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] selftests/arm64: Check failures to set tags in
 check_tags_inclusion
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510164520.768783-1-broonie@kernel.org>
 <20220510164520.768783-4-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff5037e9-d24c-e9d4-518e-c80ec3e42116@linuxfoundation.org>
Date:   Tue, 10 May 2022 11:19:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510164520.768783-4-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 10:45 AM, Mark Brown wrote:
> The MTE check_tags_inclusion test uses the mte_switch_mode() helper but
> ignores the return values it generates meaning we might not be testing
> the things we're trying to test, fail the test if it reports an error.
> The helper will log any errors it returns.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../selftests/arm64/mte/check_tags_inclusion.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 

Thank you. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
