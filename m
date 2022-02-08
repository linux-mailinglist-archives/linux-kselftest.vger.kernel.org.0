Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE44ACD4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiBHBGN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiBHAPm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:15:42 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452CAC061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:15:41 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so12544190ilm.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BgvLO9hr2V7CyEad4Q9zhVhiiHX9h0qd8phe6mg68zg=;
        b=diok9UMph6A2H5uNb/Z6KYHIB6dvzX6ttLpuifYYoA6h5s8mSmC/WfCD6n5H1XDOEn
         lVguHrxhUHRz3IzbcJCaTLPuuRh4WxEZn3yRP09ANS/ytIPq0BzeEYQ6DDLsyP9NqqTx
         FgBluq9mgpMb5bE/0flXsb4pi3bJwMHofETjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BgvLO9hr2V7CyEad4Q9zhVhiiHX9h0qd8phe6mg68zg=;
        b=eJ+F0+l1Pq2BcSQXC5v3KRK6EDybL/aMSo6Qm2KqxoWuu0HrwaWwt3uIzjKKnn9M9p
         /eyxliFh/MP/mPW1qT8u0qxFLQqLPue3z1gGZl/wbOYW1V/tKQekvUorRXEXw3RIP0/M
         7PIeSRMEtqagHOtMQqVL3/gQbIz0ZXeNMN8O3P0QVr5WlEHj+eANnT2dZPBFRJoWEx9R
         Cnw0Qhrfmn7+LZAmfrqVd2a+3le8eAEE4Pyb+1+cQOWIhcL26k3Dp+Z5pU/VDWqXrALg
         JsyhjqeUCnZ6vuFVnH8lXhSBcRZA6hP0oOKMlsOvLrwO+s1N22fG4KHbYnw55QfNxbrv
         xlpA==
X-Gm-Message-State: AOAM532/Xf6/1T+W8sLToNaI9UkrHcy8axi3+rRtiJcDbHGYxS+PWbkL
        m9OUJq/QshQtHkpPmmc14J86BYSca0WJ4g==
X-Google-Smtp-Source: ABdhPJxVvgElyB8fUYMMP/TOaUOJybzRRArhutl3SBXSxLmUM8fI5K7z6iWl6nKzUSAe8HoSX1giEQ==
X-Received: by 2002:a92:d24b:: with SMTP id v11mr928645ilg.1.1644279340709;
        Mon, 07 Feb 2022 16:15:40 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b5sm1883555ilr.0.2022.02.07.16.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:15:40 -0800 (PST)
Subject: Re: [PATCH v11 31/40] kselftest/arm64: sme: Add SME support to vlset
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
 <20220207152109.197566-32-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fc0d4407-8124-2040-41f5-5de091de588f@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 17:15:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-32-broonie@kernel.org>
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

On 2/7/22 8:21 AM, Mark Brown wrote:
> The Scalable Matrix Extenions (SME) introduces additional register state
> with configurable vector lengths, similar to SVE but configured separately.
> Extend vlset to support configuring this state with a --sme or -s command
> line option.

It would be useful to add a -g command to get the current value.
-g would just do PR_SVE_GET_VL and print the value perhaps?

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/vlset.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/vlset.c b/tools/testing/selftests/arm64/fp/vlset.c
> index 308d27a68226..76912a581a95 100644
> --- a/tools/testing/selftests/arm64/fp/vlset.c
> +++ b/tools/testing/selftests/arm64/fp/vlset.c
> @@ -22,12 +22,15 @@ static int inherit = 0;
>   static int no_inherit = 0;
>   static int force = 0;
>   static unsigned long vl;
> +static int set_ctl = PR_SVE_SET_VL;
> +static int get_ctl = PR_SVE_GET_VL;
>   
>   static const struct option options[] = {
>   	{ "force",	no_argument, NULL, 'f' },
>   	{ "inherit",	no_argument, NULL, 'i' },
>   	{ "max",	no_argument, NULL, 'M' },
>   	{ "no-inherit",	no_argument, &no_inherit, 1 },
> +	{ "sme",	no_argument, NULL, 's' },
>   	{ "help",	no_argument, NULL, '?' },
>   	{}
>   };
> @@ -50,6 +53,9 @@ static int parse_options(int argc, char **argv)
>   		case 'M':	vl = SVE_VL_MAX; break;
>   		case 'f':	force = 1; break;
>   		case 'i':	inherit = 1; break;
> +		case 's':	set_ctl = PR_SME_SET_VL;
> +				get_ctl = PR_SME_GET_VL;
> +				break;
>   		case 0:		break;
>   		default:	goto error;
>   		}
> @@ -125,14 +131,14 @@ int main(int argc, char **argv)
>   	if (inherit)
>   		flags |= PR_SVE_VL_INHERIT;
>   
> -	t = prctl(PR_SVE_SET_VL, vl | flags);
> +	t = prctl(set_ctl, vl | flags);
>   	if (t < 0) {
>   		fprintf(stderr, "%s: PR_SVE_SET_VL: %s\n",
>   			program_name, strerror(errno));
>   		goto error;
>   	}
>   
> -	t = prctl(PR_SVE_GET_VL);
> +	t = prctl(get_ctl);
>   	if (t == -1) {
>   		fprintf(stderr, "%s: PR_SVE_GET_VL: %s\n",
>   			program_name, strerror(errno));
> 

With the above comment addressed or explained:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
