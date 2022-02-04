Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303424A96F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357272AbiBDJkK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 04:40:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBDJkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 04:40:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D5E621F44E;
        Fri,  4 Feb 2022 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643967608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HKhPrTrS+osv6KlVAcI7StcH6WyLP6pkUwGJOWdhHg=;
        b=1Zubdx1CIs9+nAbXwy4aplmFV5+ZkCKLO5Q3LKDG8aNGWS7yq5aarePU4MhYNEh2B5Lzae
        jOIvcpUmv1OgswK2ZOQDUyjRUZb2jiozUjSjgrQ9dPkQ7sNBoCQLznCBs69mgWy0aY7CgR
        aU1+1RRyM07kElfwqX+0VGVY426LE6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643967608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HKhPrTrS+osv6KlVAcI7StcH6WyLP6pkUwGJOWdhHg=;
        b=OkbE/OTd8wkDBW5AphiJJrqFkGyKecAZRm/Ba+pNYbz0jJYIaLGevIFij3A/a5e4MQLwrv
        QIN6O0pCuCjF1HDQ==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id AA6E0A3B84;
        Fri,  4 Feb 2022 09:40:08 +0000 (UTC)
Date:   Fri, 04 Feb 2022 10:40:08 +0100
Message-ID: <s5h7dabx953.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] kselftest: alsa: Check for event generation when we write to controls
In-Reply-To: <20220202150902.19563-1-broonie@kernel.org>
References: <20220202150902.19563-1-broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 02 Feb 2022 16:09:01 +0100,
Mark Brown wrote:
> 
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
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>

Thanks, applied now to for-next branch.


Takashi
