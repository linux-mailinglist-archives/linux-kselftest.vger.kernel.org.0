Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB3640163
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 08:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLBH4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 02:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiLBH4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 02:56:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFAA4334
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 23:54:51 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59D9321BDC;
        Fri,  2 Dec 2022 07:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669967683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZRVzq8sY0vftKWe+iY9HQ+3uMjMKDXQEOhQ9QaYl2c=;
        b=aKxPtLCo1Y16oXbEIOJP38Nzd3pxMdR2M4vW1C8hZU2G+5VqYY1lPlQfxQZWfb8wFDDlKA
        ZtiDgL1nMXNcrEFLoX/0+jcLYZgb3A6snsWIotoRJTkFRTDcoToIqb0jegkZwuSeD/M0/n
        UrN50y4I8+SgF/rzwOFmJSWahvoz9XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669967683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZRVzq8sY0vftKWe+iY9HQ+3uMjMKDXQEOhQ9QaYl2c=;
        b=IX3aH0UaL//a0qV2Bgw6KRctrBom7YC3wKxTnQUUdIOmkUJji+WIxc/WoE+i5gnBTmpytJ
        E2mCVm/kPYVZtvDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 36CF713644;
        Fri,  2 Dec 2022 07:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 68uQC0OviWOqFAAAGKfGzw
        (envelope-from <tiwai@suse.de>); Fri, 02 Dec 2022 07:54:43 +0000
Date:   Fri, 02 Dec 2022 08:54:44 +0100
Message-ID: <87wn7akzp7.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
In-Reply-To: <87y1rqkzto.wl-tiwai@suse.de>
References: <20221130000608.519574-1-broonie@kernel.org>
        <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
        <87359zlz9t.wl-tiwai@suse.de>
        <Y4kOvNi5I8/GK1yU@sirena.org.uk>
        <87y1rqkzto.wl-tiwai@suse.de>
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

On Fri, 02 Dec 2022 08:52:03 +0100,
Takashi Iwai wrote:
> 
> On Thu, 01 Dec 2022 21:29:48 +0100,
> Mark Brown wrote:
> > 
> > On Thu, Dec 01, 2022 at 08:06:22PM +0100, Takashi Iwai wrote:
> > > On Thu, 01 Dec 2022 18:42:22 +0100,
> > > Jaroslav Kysela wrote:
> > > > 
> > > > Let me know, if I can stack your changes on top, or perhaps, you may
> > > > be willing to adapt them.
> > > 
> > > As Mark has already sent a v2 series, I applied his v2 at first.
> > > Could you rebase and resubmit on top of my for-next branch?
> > 
> > Oh, this is getting a little confusing - I'd just picked Jaroslav's
> > patch into my tree and was in the middle redoing my ideas on top of his
> > code!  I might have something more later this evening...  I think we can
> > converge here, let me continue taking a look.
> 
> Ah then it was my misunderstanding, and everything should be fine now
> ;)  Thanks!

Erm, you meant sent as *v3*.  I've seen now.

As the v2 patches were already merged, could you rather rebase and
resubmit?  I'd like to avoid rebase the full series that are already
included in linux-next.

Apologies for the mess.


Takashi
