Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA663F7E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 20:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiLATGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 14:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLATGZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 14:06:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6FAB5DAB
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 11:06:24 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18F2521BF4;
        Thu,  1 Dec 2022 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669921583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtD9PQv9I1gu+bfKZIbAtCKPictMwsec19evQxJwEKI=;
        b=l1IRQ6twuUX0q72OTVKnMYe7bakwFM1iW/0v4liApnWObNCWSBNXUmZ0si9BEePwR9hz5D
        6EtKn73skjA6AiHZjD5imDwc1RXrUxOpKE6lk4/gkQLufODFtsujXiLAUb8kVEayQ+jmWX
        +VJznpatwrFRGwzjPnRG8hHggUyGckw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669921583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtD9PQv9I1gu+bfKZIbAtCKPictMwsec19evQxJwEKI=;
        b=geudLZ7wRS2RwAujOZo2py2cRRC61S0iH4HL+HL/H7Deis4bFbyAhLoCOjio86wscOrPhy
        CXezslUGbTBX71Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E644713503;
        Thu,  1 Dec 2022 19:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ScBYNy77iGOVPQAAGKfGzw
        (envelope-from <tiwai@suse.de>); Thu, 01 Dec 2022 19:06:22 +0000
Date:   Thu, 01 Dec 2022 20:06:22 +0100
Message-ID: <87359zlz9t.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
In-Reply-To: <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
References: <20221130000608.519574-1-broonie@kernel.org>
        <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 01 Dec 2022 18:42:22 +0100,
Jaroslav Kysela wrote:
> 
> Let me know, if I can stack your changes on top, or perhaps, you may
> be willing to adapt them.

As Mark has already sent a v2 series, I applied his v2 at first.
Could you rebase and resubmit on top of my for-next branch?


thanks,

Takashi
