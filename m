Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3F4A7376
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiBBOmx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 09:42:53 -0500
Received: from mail1.perex.cz ([77.48.224.245]:46498 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237021AbiBBOmw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 09:42:52 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8ED1AA0046;
        Wed,  2 Feb 2022 15:42:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8ED1AA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1643812970; bh=iQb9T/tWOPeYEpN4C4pwSOdLCsO5xelpAVEo95Njk7M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yuk1poWXc6cYQuLYibtUU31Bh9MbNbR8jf7moEFZUX4hRu7ZVqqF5RSKiKSFBYrTg
         kghSXmGck6gEnHMmKKWe33rYI52DTkb/NUGTNYsRy+TE1IrouY+Uih03FyGeegRZfw
         XQNrJseOyKlN73EGnd7m8bxqhz50vyEudi4B0GBE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  2 Feb 2022 15:42:43 +0100 (CET)
Message-ID: <af7680e0-2c76-c625-a761-02d6e1d08c9d@perex.cz>
Date:   Wed, 2 Feb 2022 15:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] kselftest: alsa: Check for event generation when
 we write to controls
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220202141011.14924-1-broonie@kernel.org>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220202141011.14924-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02. 02. 22 15:10, Mark Brown wrote:
> Add some coverage of event generation to mixer-test. Rather than doing a
> separate set of writes designed to trigger events we add a step to the
> existing write_and_verify() which checks to see if the value we read back
> from non-volatile controls matches the value before writing and that an
> event is or isn't generated as appropriate. The "tests" for events then
> simply check that no spurious or missing events were detected. This avoids
> needing further logic to generate appropriate values for each control type
> and maximises coverage.
> 
> When checking for events we use a timeout of 0. This relies on the kernel
> generating any event prior to returning to userspace when setting a control.
> That is currently the case and it is difficult to see it changing, if it
> does the test will need to be updated. Using a delay of 0 means that we
> don't slow things down unduly when checking for no event or when events
> fail to be generated.
> 
> We don't check behaviour for volatile controls since we can't tell what
> the behaviour is supposed to be for any given control.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

...

> +		/* The ID returned from the event is 1 less than numid */
> +		mask = snd_ctl_event_elem_get_mask(event);
> +		ev_id = snd_ctl_event_elem_get_numid(event);
> +		if (ev_id != snd_ctl_elem_info_get_numid(ctl->info)) {
> +			ksft_print_msg("Event for unexpected ctl %s\n",
> +				       snd_ctl_event_elem_get_name(event));
> +			continue;
> +		}
> +	} while ((mask & SND_CTL_EVENT_MASK_VALUE) != SND_CTL_EVENT_MASK_VALUE);

A special check for SND_CTL_EVENT_MASK_REMOVE (~0U) is missing here.

For the rest:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

					Thanks,
						Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
