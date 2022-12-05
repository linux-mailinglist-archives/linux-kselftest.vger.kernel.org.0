Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E0642ECB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiLERa6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 12:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiLERa5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 12:30:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C821889;
        Mon,  5 Dec 2022 09:30:56 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40B3A1FDC4;
        Mon,  5 Dec 2022 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670261455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP2yXFvK7QD2Hx6ii/OrZTCxmC3WDL2ShgKRt5rncp0=;
        b=Ri+NN332f/KKyePcz82OFU8wUVc4dWOzi2tNoEHJpQj+aFtWu82NmkO490PdVym5Sp17RI
        XkeL+TPjPhyk/x9VHsG8yH81Glyy5G49eLRIak487q0YW+lZGShccKEsK2rdteJ1CiFE+n
        66ARIMb9DPP9AM1PlTJW13c3TpaUCTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670261455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP2yXFvK7QD2Hx6ii/OrZTCxmC3WDL2ShgKRt5rncp0=;
        b=JlUtnvEujhtJpXKTrG9YN18kQuL1oaq0OB387IAdTZ72YkiiMKPnHUevps3roMfEg8jszt
        KPq9iTopFNAmb0CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 93F931348F;
        Mon,  5 Dec 2022 17:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id hKrvFMwqjmOocwAAGKfGzw
        (envelope-from <mpdesouza@suse.de>); Mon, 05 Dec 2022 17:30:52 +0000
Date:   Mon, 5 Dec 2022 14:30:49 -0300
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <20221205173049.k66g7o5svtdwnw4w@daedalus>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
 <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
 <Y4nEhb7yPK5l54IX@alley>
 <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
 <ed5a1f19-1e2e-7a04-7cc8-1a0324b2d508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5a1f19-1e2e-7a04-7cc8-1a0324b2d508@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 04:05:25PM -0500, Joe Lawrence wrote:
> On 12/2/22 3:03 PM, Shuah Khan wrote:
> > On 12/2/22 02:25, Petr Mladek wrote:
> >>
> >> Yes, kABI is not backward compatible. But building the tests
> >> modules out-of-tree way would allow to build test modules with
> >> different kABI from the same sources.
> >>
> > 
> > Okay. This is a solid reason for livepatch modules to live under
> > sefltests. Let's capture this in README and the other updates that
> > need to be made to it in v3.
> > 
> 
> One additional benefit, however small, is that I think everyone is
> building production livepatches, source based or via kpatch-build, as
> out-of-tree modules.  (Miroslav/Petr/Marcos please correct me if I'm
> wrong about source based.)

You're correct. We construct our livepatches source based and build them
as out-of-tree modules.

> 
> Having the livepatch selftests live under selftests/ would imply that
> new subsystem (build) features would have to support the production
> build use case from the get go.

Agreed. This change makes the modules to be built as real world livepatches.

> 
> Regards,
> 
> -- 
> Joe
> 
