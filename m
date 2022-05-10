Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889B522225
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiEJRVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbiEJRVl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 13:21:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D4222C35
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:17:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z18so19245579iob.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1vxChpLLl6Hd6PQtWLNidKPzF2B1riRNW8A2GNQgrXk=;
        b=cCzzV0orwnd6Hn6gs5Pa43kcsQ5S3FqnPC5JYQSeh3p6+mRVLDZGGjIJCk4NHv36lL
         4eGIFYauh+3xF1eL7Ui3KNiYMlkSpeGkiwBoA7RdnBJYli8fY7O058hoAbksCAZwdZj2
         faXyccfkfiTfAPKm97YD/wH2Joog3rJuqDcVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1vxChpLLl6Hd6PQtWLNidKPzF2B1riRNW8A2GNQgrXk=;
        b=4Gb7dk8YOcIzCaMb5raPSjjx4vprUGcgwOJMZP1E0Qxu98z6jErNmQu8YFbpThUtfK
         IKuE27XyJm4Chryp2Gx1yQczNQvfEJ/alh2oPiGbooScPheo6v7IrIM1km9ryXiBPnlb
         HoPI1gyrVdD5W+VJi4yOXcmdx5VufVea7rMhHnAYnDQL5c0fWxALPGIv9ongZFKfbxTY
         00KlZu7PX5GYbB+oF53P2Ysc+iDThTiS2nEnleNzFHrO9hY9B4XHApRnAOVwazogIcFX
         jyN1lJoZuFBORd0ZbuEPwyPC9x0hqJdeBqr4UKVMM1EKP4mAsESjRnukqbi+deF0EyIY
         4dxA==
X-Gm-Message-State: AOAM5312JAU90qrEDrEiUkC3wyYmurPo0RmnHe0Q3Fi2M7GvSWaRzJKe
        fkAD3ZDwZ5SEZ2bKyr4DjkygYg==
X-Google-Smtp-Source: ABdhPJwIeTaJpchKRTDPD0G7MkcprL1xcO7zODUbN6oOUlw3AY2G6LNYDTOG/g5lBLqKY7Ap7Djumg==
X-Received: by 2002:a02:aa0d:0:b0:32b:fd69:9ca1 with SMTP id r13-20020a02aa0d000000b0032bfd699ca1mr5784220jam.220.1652203062949;
        Tue, 10 May 2022 10:17:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i16-20020a023b50000000b0032b3a78176fsm4450097jaf.51.2022.05.10.10.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:17:42 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] selftests/arm64: Allow zero tags in
 mte_switch_mode()
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510164520.768783-1-broonie@kernel.org>
 <20220510164520.768783-3-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7052abba-667c-36bf-30ee-58671de655ac@linuxfoundation.org>
Date:   Tue, 10 May 2022 11:17:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510164520.768783-3-broonie@kernel.org>
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
> mte_switch_mode() currently rejects attempts to set a zero tag however
> there are tests such as check_tags_inclusion which attempt to cover cases
> with zero tags using mte_switch_mode(). Since it is not clear why we are
> rejecting zero tags change the test to accept them.
> 
> The issue has not previously been as apparent as it should be since the
> return value of mte_switch_mode() was not always checked in the callers
> and the tests weren't otherwise failing.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/mte/mte_common_util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> index 260206f4dce0..6ff4c4bcbff1 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.c
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -283,7 +283,7 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
>   		return -EINVAL;
>   	}
>   
> -	if (!(incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
> +	if (incl_mask & ~MT_INCLUDE_TAG_MASK) {
>   		ksft_print_msg("FAIL: Invalid incl_mask %lx\n", incl_mask);
>   		return -EINVAL;
>   	}
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
