Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2E642EFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLERkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 12:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLERkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 12:40:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475ABB48E;
        Mon,  5 Dec 2022 09:40:22 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3D531FDC4;
        Mon,  5 Dec 2022 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670262021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRtHAeUghoDAxTltESU2+Id96SnpMkg+sG17WIY6OF4=;
        b=gM6KrKhL93AhwQHepaI8qw3fE1j7SmEdIIU1jA9Ah+nWV+IlEi1r9kZe69bQmaBVbVCw8E
        +/Pr2KVQ/AxKSp3k2Te4GawrmltMQcXPiCYWPwuLhecJK+NI39BDDuboL38GugIEWS3eXz
        SSP1LiBKLAhV/2rt2j5L1Z2MSZ8JXh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670262021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRtHAeUghoDAxTltESU2+Id96SnpMkg+sG17WIY6OF4=;
        b=zdJiwTsa4jnU7Q/TNxreHX+mfL4ddW2AfdAyOS+N0B+mU66yeiCfQhapXvC/hSob5N1p9P
        oPThKjqJkYlN+YBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 46B9113326;
        Mon,  5 Dec 2022 17:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KJPgAwItjmPVeAAAGKfGzw
        (envelope-from <mpdesouza@suse.de>); Mon, 05 Dec 2022 17:40:18 +0000
Date:   Mon, 5 Dec 2022 14:40:15 -0300
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <20221205174015.4u4p665dnh2zdb4u@daedalus>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
 <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
 <Y4nEhb7yPK5l54IX@alley>
 <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 01:03:25PM -0700, Shuah Khan wrote:
> On 12/2/22 02:25, Petr Mladek wrote:
> > On Thu 2022-12-01 16:58:38, Shuah Khan wrote:
> > > On 11/30/22 15:22, Joe Lawrence wrote:
> > > > On 7/15/22 10:45 AM, Petr Mladek wrote:
> > > > > On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
> > > > > > On 7/1/22 1:48 AM, Miroslav Benes wrote:
> > > > > > > On Thu, 30 Jun 2022, Shuah Khan wrote:
> > > > > > > > 
> > > > > > > > Sorry Nack on this. Let's not add modules under selftests. Any usage of
> > > > > > > > module_init()
> > > > > > > > doesn't belong under selftests.
> > > > > > 
> > > > > > Yes I did and after reviewing and thinking about it some more, I decided this
> > > > > > is the right direction go down on.
> > > > > 
> > > > > Do you have some particular reason why building modules in selftests
> > > > > directory might cause problems, please?
> > > > > 
> > > 
> > > My reasons are that with this change module_init() propagates out of
> > > strictly kernel space and now is in selftests which are user-space.
> > > Any changes to this interface will be tied to user-space change.
> > 
> > I am sorry but I do not understand the meaning here. module_init() is
> > called when module is loaded. It is not called in userspace.
> > 
> > Maybe, you mean that modules under lib/ are clearly in-tree
> > modules. If we move then under tools/ then they will be build
> > like out-of-tree modules. Except that they will be maintained in-tree
> > so that it will be easy to keep them in sync.
> > 
> 
> Yes. That is what I mean.
> 
> > And I am sure that they will be actively maintained. The fixes are
> > there to make sure that livepatching still works as expected.
> > They must pass when any change is done in the livepatch subsystem.
> > And they must pass when any kernel is released.
> > 
> 
> In other words, livepatch and kernel are revision matched.
> 
> > The only concern might be how build failure is handled. IMHO, we
> > need to handle it the same way and test failure.
> > 
> > 
> 
> Yes. This is another concern - build failures. Let's experiment with
> modules under selftests and see if this becomes a problem.
> 
> > > In general, newer tests offer the best coverage, hence the recommendation
> > > to run newer tests on older kernels assuming that the tests are built
> > > on a newer kernel and backwards should run in a backwards compatible
> > > way on older kernels.
> > 
> > This works for the userspace interface that should always be backward
> > compatible. But it does not work for kABI.
> > 
> 
> This is broader than revision matching. Tests should gracefully exit
> with skip when a config option they depend on is disabled. The same
> gets extended to older kernel versions.

Agreed. I'll change functions.sh to do better checking when compiling modules.

> 
> > 
> > > Do you have a requirement that livepatch test has to be revision
> > > matched with the kernel? Even if that is the case, there is no real
> > > reason to move modules under selftests other than keeping them in
> > > one location.
> > 
> > Yes, kABI is not backward compatible. But building the tests
> > modules out-of-tree way would allow to build test modules with
> > different kABI from the same sources.
> > 
> 
> Okay. This is a solid reason for livepatch modules to live under
> sefltests. Let's capture this in README and the other updates that
> need to be made to it in v3.

I'm happy that we reached to a point where we agreed to have the modules moved
into kselftests, as the move will allow us to implement more tests that are
currently downstream.

The v3 is being prepared now. I hope to send it soon.

Thanks,
  Marcos

> 
> thanks,
> -- Shuah
