Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01B867821A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjAWQr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjAWQrZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 11:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FF2124;
        Mon, 23 Jan 2023 08:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D281B80BA2;
        Mon, 23 Jan 2023 16:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A9C433D2;
        Mon, 23 Jan 2023 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492442;
        bh=NtOes/+17oZHKEliSRsrv4ngNKu8bsC9jGTrJ7nKjlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=taoo2tjEF9BVZkFbpzziCUnUw44ONfs/U0ohh9cBi1Y8Rv9NYXAZZVbwsNz3jpe7u
         l/IREHBEjy6BnZZXFM0bKp3CtS+/lzM4TiRj0qVGowld20a3cunf7B+AmfnjOM5L9/
         /tmDyHfYPE59KSiGYf42/gsnUirZlH3cVP17sij4lLXlHy9aZ6JxY4BuVPFHhhl3iB
         RJviMKOkTpOYU1cKNDv0OJjKKDoGE15KxV0py4GvVE95i8uuOuG499A9Wx+amEwmyn
         MihsJKtai9Fqk3d9ZNvdxZFJ0mSnDAKTNuufmIYGVPvMuaotAemhTmto36rUjxrHjl
         1O0Fwd0fuaNVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B60105C084D; Mon, 23 Jan 2023 08:47:21 -0800 (PST)
Date:   Mon, 23 Jan 2023 08:47:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123164721.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121213455.GA16121@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 10:34:55PM +0100, Willy Tarreau wrote:
> On Sat, Jan 21, 2023 at 12:00:38PM -0800, Paul E. McKenney wrote:
> > > There's no matter of urgency for these patches, they're just a bit of
> > > user-friendly stuff. As such, if you're fine with stacking them on top of
> > > what you already have for 6.3, that will be great, otherwise they can
> > > easily wait.
> > > 
> > > Thank you!
> > > Willy
> > 
> > Nice, thank you!
> > 
> > I have these placed on top of the -rcu "dev" branch initially for further
> > review and testing.  If things go well over the next week or so, I will
> > set it up for the upcoming merge window.
> 
> Thanks!
> 
> > One dependency is of course qemu-x86_64, so in the meantime I will figure
> > out where I get that from.  ;-)
> 
> I build it from time to time from the sources, it's not that long and
> normally doesn't reserve me any surprises. But if you have it for other
> platforms it's likely that you have it for most platforms as well,
> including this one.

And building from sources proved to be reasonably easy, so the test
now passes for me.  My initial thought of putting qemu-x86_64 into
my ~/bin directory fails the sudo test, but putting it into /usr/bin
works fine.

Thank you for the hints!

Should I add a sentence to the commit log noting the potential need to
build qemu from the git repo and to install qemu-x86_64, give or take
what architecture one is running?

							Thanx, Paul
