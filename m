Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A39790A7B
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 03:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjICBiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 21:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjICBiQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 21:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E8120;
        Sat,  2 Sep 2023 18:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160326123A;
        Sun,  3 Sep 2023 01:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB9C433C7;
        Sun,  3 Sep 2023 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693705092;
        bh=mLbeMsgnyDnGCgA/p6Hrb2VlLPgAqB23fcud/eP5FRk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q52IxxWydRbFcqHTBG0PvLCV+xxuCfetlsz5GeaqNu9tIZU/4XTGLbyuIlYWrLaF6
         40Q4/YC0qbuspqEQbC70HQeDttFXk4IdKfJLPyYML745aaNEqhOv0us4S7iOqssBIY
         f3ecKWRWyOdzJqjLpMwo1egZZe+FKB81HEAFbqJgDx+OX+B4q167bF+rgLYoGXkC2C
         1dlDoTuij1Jo1EIzF8J5QWV2vl34+BLbw+gmfMFEHCPLhdvq6LlShph/JG0Y2aQRFm
         g/En9PiUywR1WDyF5gtpG3mgLgNph7q6yVx2hgAvaGYuQDZWwJynZ2LYQPyXjFGASu
         LcCRA433jAkHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0426CCE0567; Sat,  2 Sep 2023 18:38:12 -0700 (PDT)
Date:   Sat, 2 Sep 2023 18:38:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] rcu/torture: Improve badness extraction from console logs
Message-ID: <8f55aa64-dfea-4a1a-a7d4-a2335ec07150@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230831012257.1189964-1-joel@joelfernandes.org>
 <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop>
 <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
 <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop>
 <CAEXW_YTzP90zs8z4UFC52fd_KMkpBba6ujBNnDM5Z6exskJ6tg@mail.gmail.com>
 <e0977773-de90-42bb-a67d-dc16d24764a3@paulmck-laptop>
 <CAEXW_YSukJ_SSvy731iF9WZ5N9cycHsfzdz+8MKA4Va+1+FW4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSukJ_SSvy731iF9WZ5N9cycHsfzdz+8MKA4Va+1+FW4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:10:13PM -0400, Joel Fernandes wrote:
> On Sat, Sep 2, 2023 at 3:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> [...]
> > > > Either way, what I don't want is many megabytes of splats from console.log
> > > > duplicated into console.log.diags, especially in those (admittedly sad)
> > > > cases where the console.log file is the largest file in the results
> > > > directory.  Are you really going to be reading carefully after (say)
> > > > the fifth splat?  ;-)
> > >
> > > I could limit it to just the first 5, with the existing unlimited
> > > summary at the top.
> >
> > How about limiting the existing summary to (say) 10 lines?  I do not
> > recall every caring about more than that.  The only reason that I did
> > not ever limit it myself is that the summary is unlikely to be more than
> > a few percent of the full console.log.
> >
> > > Let me know if that works or does not work for you. :-)
> >
> > I do believe that we might be converging.  ;-)
> 
> Ok, so 10 lines of summary (similar to existing), and 10 detailed
> splats below that :-).  If that's not Ok, let me know. Otherwise I
> will send the new patch soon. Thanks!

That works!

						Thanx, Paul
