Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B594787BF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 01:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjHXXZ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjHXXYH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 19:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827B212C;
        Thu, 24 Aug 2023 16:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9B8655FC;
        Thu, 24 Aug 2023 23:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73547C433C8;
        Thu, 24 Aug 2023 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692919392;
        bh=ttTEevmZpYzWPrfGGCavNCEDaq1WtPjeyXglT0Kdk4I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U3hwrD94fr/yo7oV6SeVLwbW9ACWlTIP3EPIKRKjXPzZ5at199KHeJZeBbY9f8Cft
         fMwlAoMqoqQn4FKJMKtsYj52ZWcYW4U8qyrYamkOJLkEVb/lHXgRh1vY8qDacdYLR2
         1xuB3J4J9PQNlCVqm94mXhBWVlseGN0AU2ydxq2iQMHrGwGfgW6Go1c5otQBrlSGYo
         pvjhrxXo/1ctyLRdE39Vx+xNyzYFrUhcQJx6mTFR8uzSX5VQv8XpkF/vSqesiCmRpB
         8W0CK8xZaROaxgbKVOsCC9nN//b+IHzwpfcwOK/TaeRSnZkj9dE3DwHn0KyaotGq9o
         5nQj0yPMmd1fQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 127C6CE134A; Thu, 24 Aug 2023 16:23:12 -0700 (PDT)
Date:   Thu, 24 Aug 2023 16:23:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [GIT PULL] scftorture changes for v6.4
Message-ID: <3cf47281-0fd6-451c-8d3b-b7605afb9b6e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
 <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 24, 2023 at 04:07:12PM -0700, Linus Torvalds wrote:
> On Thu, 24 Aug 2023 at 15:06, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Once the merge window opens, please pull these scftorture changes:
> 
> Heh, hedging your bets a bit?
> 
> This email had "for v6.4" in the subject, the CSD-lock one had "for
> v6.5", and the RCU one had "for v6.6".
> 
> But I'll do them all in the next merge window, never fear.

I guess it is one of those days where the best I can hope for is to
provide some humor value and a cautionary tale.

And thank you for correctly interpreting my confused version numbers!

							Thanx, Paul
