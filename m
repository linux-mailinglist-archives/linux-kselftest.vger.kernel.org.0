Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A249A50B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3408965AbiAYAYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384842AbiAXXeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 18:34:09 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE8C075979
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:35:57 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r15so15086621ilj.7
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hYrpBAikiVvf40qbJLBc9ty//Ul+13OxZpBSqs7E8QM=;
        b=BWEwEal3YXIUIQmTxJT5ds6wEfBcQNsc9Rt41BH+5gLlE7aQdhT994/AEJtV5PHBLV
         31LtmQ1RiJX3OqIcmDNWyk4IGLIWl0GWyMmLj2E3Twb8VvgFbqxkcSWyLfl2GfgJ39YY
         gwAeLG6mYwMccKTTgGqUKV4l7ftQvHLCOnekM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYrpBAikiVvf40qbJLBc9ty//Ul+13OxZpBSqs7E8QM=;
        b=gIF0OjJlQq2qO5ybE0s9JAerw2nZqJkAouPqszf9ufG+169ve9gbmWC5AR3qeLfG+s
         gA1O6K8YFePmsEmG+4luGrgu5R7xzsMclf3DER+wrIYIhyhPHPnScc1IxrztK47ugVWo
         2ZdzqajneRKFEa6ZS+9oDFFCiloR8SnUNaktGjfmRAioIvkaWufRSCs2YxzsKmsQlcLx
         Ya4LRGF691RSuKvOAyihgGZtvP549fSEbqmDKEe2dgCZGl9FRPsJx0Ht7zFtHwXKY7E3
         RlACr4OTN4mDZs20/7YyVqIuhSJBPOhx2zE67JTgPLzM3uXnqJ08x6A99YIyFQoshgvx
         SH2g==
X-Gm-Message-State: AOAM532tCL+kmcr9DVzpkPPIy48FDRJTrQBoAhGamDvUs4gMPWAPWu2U
        LcY2CXj1HonFDalYeLzqSK/A35EazDsVDg==
X-Google-Smtp-Source: ABdhPJwIhZ//l57LlnXHcwD5eoSmWbMq6LcjCsGHRpEM0UeLtUyM20oWLQEaPRZuTj8AQyfiN6rdJA==
X-Received: by 2002:a05:6e02:1c48:: with SMTP id d8mr9502662ilg.297.1643060156597;
        Mon, 24 Jan 2022 13:35:56 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id b12sm2090264ilv.68.2022.01.24.13.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:35:56 -0800 (PST)
Subject: Re: [PATCH] kselftest: alsa: Add test case for writing invalid values
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220124151410.2715572-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9a0addc-9e81-b2c2-e5c7-d5e69dae26cd@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 14:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124151410.2715572-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 8:14 AM, Mark Brown wrote:
> Attempt to write various invalid values for control types we know about and
> check that something sensible happens. The ABI isn't quite as clearly
> defined as one might like, rather than generating an error when an invalid
> value is written many devices will silently rewrite the value into one that
> is valid for the control. The exact value chosen is not predictable so in
> the case the write succeeds we just check that the value we read back is
> one that is valid for the control.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/alsa/mixer-test.c | 222 +++++++++++++++++++++-
>   1 file changed, 221 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
> index 17f158d7a767..15e05b241468 100644
> --- a/tools/testing/selftests/alsa/mixer-test.c
> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -13,6 +13,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <stdbool.h>
> +#include <limits.h>
>   #include <string.h>
>   #include <getopt.h>
>   #include <stdarg.h>
> @@ -26,7 +27,7 @@
>   
>   #include "../kselftest.h"
>   
> -#define TESTS_PER_CONTROL 3
> +#define TESTS_PER_CONTROL 4
>   
>   struct card_data {
>   	snd_ctl_t *handle;
> @@ -679,6 +680,224 @@ void test_ctl_write_valid(struct ctl_data *ctl)
>   			 ctl->card->card, ctl->elem);
>   }
>   
> +bool test_ctl_write_invalid_value(struct ctl_data *ctl,
> +				  snd_ctl_elem_value_t *val)
> +{
> +	int err;
> +	long val_read;
> +
> +	/* Ideally this will fail... */
> +	err = snd_ctl_elem_write(ctl->card->handle, val);
> +	if (err < 0)
> +		return false;
> +
> +	/* ...but some devices will clamp to an in range value */
> +	err = snd_ctl_elem_read(ctl->card->handle, val);
> +	if (err < 0) {
> +		ksft_print_msg("%s failed to read: %s\n",
> +			       ctl->name, snd_strerror(err));
> +		return true;
> +	}
> +
> +	return !ctl_value_valid(ctl, val);
> +}
> +
> +bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
> +{
> +	int err, i;
> +	long val_read;
> +	bool fail = false;
> +	snd_ctl_elem_value_t *val;
> +	snd_ctl_elem_value_alloca(&val);
> +
> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
> +		snd_ctl_elem_value_copy(val, ctl->def_val);
> +		snd_ctl_elem_value_set_boolean(val, i, 2);
> +
> +		if (test_ctl_write_invalid_value(ctl, val))
> +			fail = true;
> +	}
> +
> +	return !fail;
> +}
> +
> +bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
> +{
> +	int i;
> +	bool fail = false;
> +	snd_ctl_elem_value_t *val;
> +	snd_ctl_elem_value_alloca(&val);
> +
> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
> +		if (snd_ctl_elem_info_get_min(ctl->info) != LONG_MIN) {
> +			/* Just under range */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i,
> +			       snd_ctl_elem_info_get_min(ctl->info) - 1);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +
> +			/* Minimum representable value */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i, LONG_MIN);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +		}
> +
> +		if (snd_ctl_elem_info_get_max(ctl->info) != LONG_MAX) {
> +			/* Just over range */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i,
> +			       snd_ctl_elem_info_get_max(ctl->info) + 1);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +
> +			/* Maximum representable value */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i, LONG_MAX);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +		}
> +	}
> +
> +	return !fail;
> +}
> +
> +bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
> +{
> +	int i;
> +	bool fail = false;
> +	snd_ctl_elem_value_t *val;
> +	snd_ctl_elem_value_alloca(&val);
> +
> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
> +		if (snd_ctl_elem_info_get_min64(ctl->info) != LLONG_MIN) {
> +			/* Just under range */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer64(val, i,
> +				snd_ctl_elem_info_get_min64(ctl->info) - 1);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +
> +			/* Minimum representable value */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i, LLONG_MIN);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +		}
> +
> +		if (snd_ctl_elem_info_get_max64(ctl->info) != LLONG_MAX) {
> +			/* Just over range */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer64(val, i,
> +				snd_ctl_elem_info_get_max64(ctl->info) + 1);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +
> +			/* Maximum representable value */
> +			snd_ctl_elem_value_copy(val, ctl->def_val);
> +			snd_ctl_elem_value_set_integer(val, i, LLONG_MAX);
> +
> +			if (test_ctl_write_invalid_value(ctl, val))
> +				fail = true;
> +		}
> +	}
> +
> +	return !fail;
> +}
> +
> +bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
> +{
> +	int err, i;
> +	unsigned int val_read;
> +	bool fail = false;
> +	snd_ctl_elem_value_t *val;
> +	snd_ctl_elem_value_alloca(&val);
> +
> +	snd_ctl_elem_value_set_id(val, ctl->id);
> +
> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
> +		/* One beyond maximum */
> +		snd_ctl_elem_value_copy(val, ctl->def_val);
> +		snd_ctl_elem_value_set_enumerated(val, i,
> +				  snd_ctl_elem_info_get_items(ctl->info));
> +
> +		if (test_ctl_write_invalid_value(ctl, val))
> +			fail = true;
> +
> +		/* Maximum representable value */
> +		snd_ctl_elem_value_copy(val, ctl->def_val);
> +		snd_ctl_elem_value_set_enumerated(val, i, UINT_MAX);
> +
> +		if (test_ctl_write_invalid_value(ctl, val))
> +			fail = true;
> +
> +	}
> +
> +	return !fail;
> +}
> +
> +
> +void test_ctl_write_invalid(struct ctl_data *ctl)
> +{
> +	bool pass;
> +	int err;
> +
> +	/* If the control is turned off let's be polite */
> +	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
> +		ksft_print_msg("%s is inactive\n", ctl->name);
> +		ksft_test_result_skip("write_invalid.%d.%d\n",
> +				      ctl->card->card, ctl->elem);
> +		return;
> +	}
> +
> +	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
> +		ksft_print_msg("%s is not writeable\n", ctl->name);
> +		ksft_test_result_skip("write_invalid.%d.%d\n",
> +				      ctl->card->card, ctl->elem);
> +		return;
> +	}
> +
> +	switch (snd_ctl_elem_info_get_type(ctl->info)) {
> +	case SND_CTL_ELEM_TYPE_BOOLEAN:
> +		pass = test_ctl_write_invalid_boolean(ctl);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER:
> +		pass = test_ctl_write_invalid_integer(ctl);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER64:
> +		pass = test_ctl_write_invalid_integer64(ctl);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_ENUMERATED:
> +		pass = test_ctl_write_invalid_enumerated(ctl);
> +		break;
> +
> +	default:
> +		/* No tests for this yet */
> +		ksft_test_result_skip("write_invalid.%d.%d\n",
> +				      ctl->card->card, ctl->elem);
> +		return;
> +	}
> +
> +	/* Restore the default value to minimise disruption */
> +	err = write_and_verify(ctl, ctl->def_val, NULL);

Why not read the value and then restore the value, in case the value
before the write test is different from the ctl->def_val?

> +	if (err < 0)
> +		pass = false;
> +
> +	ksft_test_result(pass, "write_invalid.%d.%d\n",
> +			 ctl->card->card, ctl->elem);
> +}
> +
>   int main(void)
>   {
>   	struct ctl_data *ctl;
> @@ -697,6 +916,7 @@ int main(void)
>   		test_ctl_get_value(ctl);
>   		test_ctl_write_default(ctl);
>   		test_ctl_write_valid(ctl);
> +		test_ctl_write_invalid(ctl);
>   	}
>   
>   	ksft_exit_pass();
> 

thanks,
-- Shuah
