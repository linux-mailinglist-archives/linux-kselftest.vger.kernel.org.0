Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3912546DD9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhLHVbI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbhLHVbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:31:08 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA13C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:27:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u74so5862001oie.8
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+6Kg8hk6Iu9Pu3cLAqYxADhT5631YcWaCFKQTfINd0s=;
        b=gsYcFzAa15fPxqMzMzmfghDvXXnI5QSDxbgMrhpjhMy7muF1gzB0CeuzC5TEtSZ5w4
         VHzxhRkiB1+bgIfq7u4YvPnRuUNSwMd4fblycNiyvkPD9vI8qFP/NZChCYoU6dqZc0hx
         O6+lVt4ZWDF0ptDY8SmcX83yjdMwSj+qhHNes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+6Kg8hk6Iu9Pu3cLAqYxADhT5631YcWaCFKQTfINd0s=;
        b=mkLx0Bk3/A05HlSrFfeWC0fVqZ6evOTfX/9dQxU7X+VYocP7Fo1UFnHR8XroydWBtq
         f6SFjlumifxE/FNeGgn3T+we3U+joEjozp+AgFohVvETTCaF7j/LRLh1+q+0TIL6KHfQ
         YyU1HqPaIicpmrqf6MA8ACHhDQQB2zpMbEvKlr6ePHPXRq19UwVVeJc5lL5+CxgKjqUG
         YqoR8bMTrwYTyAyYqnMOR/OlPXw/N0xpTPcpRm7hJBdUqug+AWUDfNp/Dj9bvb4CZL4l
         wW+l9r1eJ/DdqDOZVUXeqEfMjx8Ri6Uv0Y7iNDEbZ9qPrBQ32uhaX1raPjiHGnKyk4Ci
         cK5Q==
X-Gm-Message-State: AOAM533eqJ05WidIEZWG48dUcJ4M/DsYSDsDlONLgBrGdg5XyEXjNxhb
        yrGfdNEG4wiUzv7U7ozDtdKJgOluWfErzg==
X-Google-Smtp-Source: ABdhPJxa89a3lENmzcAzjsaiH81MXzjLZJZZY326hwCw1GT1hjzooiUdCCJqN4iglimK/HBp8CVlBQ==
X-Received: by 2002:a05:6808:8c9:: with SMTP id k9mr1988621oij.147.1638998855585;
        Wed, 08 Dec 2021 13:27:35 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s1sm656841ooo.11.2021.12.08.13.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 13:27:35 -0800 (PST)
Subject: Re: [PATCH v3 3/3] kselftest: alsa: Use private alsa-lib
 configuration in mixer test
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211208211745.533603-1-broonie@kernel.org>
 <20211208211745.533603-4-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b76dd5e0-56ba-79f4-21c2-ac5455d7fd65@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 14:27:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211208211745.533603-4-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/8/21 2:17 PM, Mark Brown wrote:
> From: Jaroslav Kysela <perex@perex.cz>
> 
> As mentined by Takashi Sakamoto, the system-wide alsa-lib configuration
> may override the standard device declarations. This patch use the private
> alsa-lib configuration to set the predictable environment.
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Link: https://lore.kernel.org/r/20211208095209.1772296-1-perex@perex.cz
> [Restructure version test to keep the preprocessor happy -- broonie]
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/alsa/mixer-test.c | 56 ++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
> index 171d33692c7b..a177676c530e 100644
> --- a/tools/testing/selftests/alsa/mixer-test.c
> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -46,22 +46,74 @@ struct ctl_data {
>   	struct ctl_data *next;
>   };
>   
> +static const char *alsa_config =
> +"ctl.hw {\n"
> +"	@args [ CARD ]\n"
> +"	@args.CARD.type string\n"
> +"	type hw\n"
> +"	card $CARD\n"
> +"}\n"
> +;
> +
>   int num_cards = 0;
>   int num_controls = 0;
>   struct card_data *card_list = NULL;
>   struct ctl_data *ctl_list = NULL;
>   
> +#ifdef SND_LIB_VER
> +#if SND_LIB_VERSION >= SND_LIB_VER(1, 2, 6)
> +#define LIB_HAS_LOAD_STRING
> +#endif
> +#endif
> +
> +#ifndef LIB_HAS_LOAD_STRING
> +int snd_config_load_string(snd_config_t **config, const char *s, size_t size)
> +{
> +	snd_input_t *input;
> +	snd_config_t *dst;
> +	int err;
> +
> +	assert(config && s);
> +	if (size == 0)
> +		size = strlen(s);
> +	err = snd_input_buffer_open(&input, s, size);
> +	if (err < 0)
> +		return err;
> +	err = snd_config_top(&dst);
> +	if (err < 0) {
> +		snd_input_close(input);
> +		return err;
> +	}
> +	err = snd_config_load(dst, input);
> +	snd_input_close(input);
> +	if (err < 0) {
> +		snd_config_delete(dst);
> +		return err;
> +	}
> +	*config = dst;
> +	return 0;

Why not consolidate the error path code?

> +}
> +#endif
> +
>   void find_controls(void)
>   {
>   	char name[32];
>   	int card, ctl, err;
>   	struct card_data *card_data;
>   	struct ctl_data *ctl_data;
> +	snd_config_t *config;
>   
>   	card = -1;
>   	if (snd_card_next(&card) < 0 || card < 0)
>   		return;
>   
> +	err = snd_config_load_string(&config, alsa_config, strlen(alsa_config));
> +	if (err < 0) {
> +		ksft_print_msg("Unable to parse custom alsa-lib configuration: %s\n",
> +			       snd_strerror(err));
> +		ksft_exit_fail();
> +	}
> +
>   	while (card >= 0) {
>   		sprintf(name, "hw:%d", card);
>   
> @@ -69,7 +121,7 @@ void find_controls(void)
>   		if (!card_data)
>   			ksft_exit_fail_msg("Out of memory\n");
>   
> -		err = snd_ctl_open(&card_data->handle, name, 0);
> +		err = snd_ctl_open_lconf(&card_data->handle, name, 0, config);
>   		if (err < 0) {
>   			ksft_print_msg("Failed to get hctl for card %d: %s\n",
>   				       card, snd_strerror(err));
> @@ -137,6 +189,8 @@ void find_controls(void)
>   			break;
>   		}
>   	}
> +
> +	snd_config_delete(config);
>   }
>   
>   /*

This open comment at the end of the patch looks odd. Does this compile?

> 

thanks
-- Shuah
