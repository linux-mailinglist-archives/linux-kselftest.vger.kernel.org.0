Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9F62566F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiKKJSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 04:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKKJSH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 04:18:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F3CC18;
        Fri, 11 Nov 2022 01:18:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1330720167;
        Fri, 11 Nov 2022 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668158285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sg0XL9IMMLHu41b3KMPw143SB4/bUxyeRYmvJVGYUhk=;
        b=iUiCtmLjvTRIAwo7RL0RPt0jNtLzE2wqZAEJgByrgFPpJflpTDDHxtkrKRvjRL/hgJ3Z46
        l1B4kQUDwE6XJQ6rTrrH1WfP8LmQYB2/zW9rIPRxTQ2X8l+RXXFVKB5goaFOL1HL7Vitj4
        fy1uLqgF3VOV4JeEXfJvkG74jMErTUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668158285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sg0XL9IMMLHu41b3KMPw143SB4/bUxyeRYmvJVGYUhk=;
        b=y+iq6ZFC1pB8zHh2yELDaOlN/q/OMvlpwdcFA+Mq//7dZ4bZpSe5yPJunv6ahmwVUp+68y
        Q/iE3yrnO5lJ2HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7334413273;
        Fri, 11 Nov 2022 09:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2YCyGUwTbmPiWwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 09:18:04 +0000
Date:   Fri, 11 Nov 2022 10:18:02 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y24TSnsYYCQxAJwW@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Martin,

thanks a lot for providing more complete description!

Kind regards,
Petr
