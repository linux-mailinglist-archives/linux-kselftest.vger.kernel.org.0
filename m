Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC446D75BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjDEHqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjDEHqR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 03:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22310FA;
        Wed,  5 Apr 2023 00:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9953962263;
        Wed,  5 Apr 2023 07:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE943C433EF;
        Wed,  5 Apr 2023 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680680776;
        bh=otKiaXzhKj1d0IElM8EpQMHf8mH/grQNyFMZ3svztDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwwYG8Gq5pNFOAKtfiru6z1sEQq9NXvLDeiCJKPsKLzlyX6icCgl1ezpQWoUGEXj5
         yfHrPSCA0xpxssHPo4tV8NX8HjWHGvAjFtBp6Nx3SaWK8vpBx0zqRn3SPv8dEeRjFd
         12I2HefSZ2l8SNDZe45mauHmgFX6gbR4S4SBuAvqs3ZMuVlFC74jxP2bz5ugchGlIy
         OF67rIZWzr9FXRGCTtZyLq3etAcUElE/dKspPl0Dz+760pgjvXC8HFMMSwJtnJ0jx8
         xhUdT3jCoR0dnM5xNyOKpOSMOtEHHtIsBv/mS88VLpNxOfFjvFBkhgxRwAVOUENmac
         0y96zcWXXmWew==
Date:   Wed, 5 Apr 2023 09:46:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/clone3: fix number of tests in ksft_set_plan
Message-ID: <20230404-wasting-finicky-6f8876022a24@brauner>
References: <20230314115352.20623-1-tklauser@distanz.ch>
 <20230314123414.26907-1-tklauser@distanz.ch>
 <20230314130959.7gfuagxta6k423kf@wittgenstein>
 <20230403205735.ltb3pmh5yl2pjzhu@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403205735.ltb3pmh5yl2pjzhu@distanz.ch>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 03, 2023 at 10:57:37PM +0200, Tobias Klauser wrote:
> On 2023-03-14 at 14:09:59 +0100, Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Mar 14, 2023 at 01:34:14PM +0100, Tobias Klauser wrote:
> > > Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > > added an additional test, so the number passed to ksft_set_plan needs to
> > > be bumped accordingly.
> > > 
> > > Also use ksft_finished() to print results and exit. This will catch future
> > > mismatches between ksft_set_plan() and the number of tests being run.
> > > 
> > > Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > ---
> > 
> > Looks good. Thanks for fixing this,
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > 
> > Feel free to take this through the selftests tree, Shuah.
> 
> It looks like this hasn't made it into Linus' tree yet and I also don't
> see it in Shuah's tree. Would it be possible to still submit this for
> 6.3-rc6 given the commit it fixes has made it to Linus' tree already?

Is it in linux-next?
