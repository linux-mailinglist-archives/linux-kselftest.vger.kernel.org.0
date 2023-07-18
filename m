Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB375736D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGRFwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGRFwE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:52:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BF91705
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 22:52:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FD92218F9;
        Tue, 18 Jul 2023 05:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689659520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKTCHsPZDxJHkQIHvvHyKTZbXmSt1k7/MALwL+L6NSA=;
        b=X5ddLOylPh4ISr9lzuTnDKSUSVATs36cH384xGmMFhjBfI6UFttBSxnCZco4R//zrNKNqD
        rKlWh6z9B6YuN8rB3hbt31yZtQiW8TwtKMUvVbRVsVce8rnI13UTVlv8k5yYBvApROi6AJ
        qfp9vs3tGPZQ1pL0ZlteJkIGpG2XYwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689659520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKTCHsPZDxJHkQIHvvHyKTZbXmSt1k7/MALwL+L6NSA=;
        b=UixYD5s7eSu6lwcq/9BddjWZVV92ZcA/yqFgbimriQ9jGg6DH50rNPhxDJKkSbbRfeJDxy
        wPeEyL155JxVqEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBD02133FE;
        Tue, 18 Jul 2023 05:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 29gNOH8otmQ/dgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 18 Jul 2023 05:51:59 +0000
Date:   Tue, 18 Jul 2023 07:51:59 +0200
Message-ID: <87zg3tojgg.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 0/5] ASoC: Improve coverage in default KUnit runs
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 18 Jul 2023 02:28:41 +0200,
Mark Brown wrote:
> 
> We have some KUnit tests for ASoC but they're not being run as much as
> they should be since ASoC isn't enabled in the configs used by default
> with KUnit and in the case of the topology tests there is no way to
> enable them without enabling drivers that use them.  This series
> provides a Kconfig option which KUnit can use directly rather than worry
> about drivers.
> 
> Further, since KUnit is typically run in UML but ALSA prevents build
> with UML we need to remove that Kconfig conflict.  As far as I can tell
> the motiviation for this is that many ALSA drivers use iomem APIs which
> are not available under UML and it's more trouble than it's worth to go
> through and add per driver dependencies.  In order to avoid these issues
> we also provide stubs for these APIs so there are no build time issues
> if a driver relies on iomem but does not depend on it.  With these stubs
> I am able to build all the sound drivers available in a UML defconfig
> (UML allmodconfig appears to have substantial other issues in a quick
> test).
> 
> With this series I am able to run the topology KUnit tests as part of a
> kunit --alltests run.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Add support for building ALSA with UML.
> - Link to v1: https://lore.kernel.org/r/20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org
> 
> ---
> Mark Brown (5):
>       driver core: Provide stubs for !IOMEM builds
>       platform: Provide stubs for !HAS_IOMEM builds
>       ALSA: Enable build with UML
>       kunit: Enable ASoC in all_tests.config
>       ASoC: topology: Add explicit build option

Those look like sensible changes.

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
