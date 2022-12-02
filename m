Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B934640340
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLBJZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 04:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLBJZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 04:25:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5A2934A;
        Fri,  2 Dec 2022 01:25:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 05CE81FDB3;
        Fri,  2 Dec 2022 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669973129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKQzPesfFIXU9kqEqHI/x4slupL/82jvdX55wsPLZD4=;
        b=Sy3wVXHao17TNESL3ZmsuofQN6YDA2x6DRwN/w0x4jVw4/iPMjkOsiagP+G5bJO4izPxIG
        D9Wm8vR5FxuzZYknMyhIUXvrvLYLUk9otsdJcD4/PSEU/LuNkQhBqEPnCZJgSxGzO+6SB/
        lVS/BXD0nILSJHcNQkQ8EiJ61DB813k=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D870F2C141;
        Fri,  2 Dec 2022 09:25:28 +0000 (UTC)
Date:   Fri, 2 Dec 2022 10:25:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <Y4nEhb7yPK5l54IX@alley>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
 <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2022-12-01 16:58:38, Shuah Khan wrote:
> On 11/30/22 15:22, Joe Lawrence wrote:
> > On 7/15/22 10:45 AM, Petr Mladek wrote:
> > > On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
> > > > On 7/1/22 1:48 AM, Miroslav Benes wrote:
> > > > > On Thu, 30 Jun 2022, Shuah Khan wrote:
> > > > > > 
> > > > > > Sorry Nack on this. Let's not add modules under selftests. Any usage of
> > > > > > module_init()
> > > > > > doesn't belong under selftests.
> > > > 
> > > > Yes I did and after reviewing and thinking about it some more, I decided this
> > > > is the right direction go down on.
> > > 
> > > Do you have some particular reason why building modules in selftests
> > > directory might cause problems, please?
> > > 
> 
> My reasons are that with this change module_init() propagates out of
> strictly kernel space and now is in selftests which are user-space.
> Any changes to this interface will be tied to user-space change.

I am sorry but I do not understand the meaning here. module_init() is
called when module is loaded. It is not called in userspace.

Maybe, you mean that modules under lib/ are clearly in-tree
modules. If we move then under tools/ then they will be build
like out-of-tree modules. Except that they will be maintained in-tree
so that it will be easy to keep them in sync.

And I am sure that they will be actively maintained. The fixes are
there to make sure that livepatching still works as expected.
They must pass when any change is done in the livepatch subsystem.
And they must pass when any kernel is released.

The only concern might be how build failure is handled. IMHO, we
need to handle it the same way and test failure.


> In general, newer tests offer the best coverage, hence the recommendation
> to run newer tests on older kernels assuming that the tests are built
> on a newer kernel and backwards should run in a backwards compatible
> way on older kernels.

This works for the userspace interface that should always be backward
compatible. But it does not work for kABI.


> Do you have a requirement that livepatch test has to be revision
> matched with the kernel? Even if that is the case, there is no real
> reason to move modules under selftests other than keeping them in
> one location.

Yes, kABI is not backward compatible. But building the tests
modules out-of-tree way would allow to build test modules with
different kABI from the same sources.

IMHO, this is common for any selttests using kernel modules.
I am sure that neither test_printf nor test_scanf modules
could be loaded in older kernels. Even though it might
be useful to run improved tests for stable-like kernels.

Best Regards,
Petr
