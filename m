Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C679D979
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjILTXp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjILTXo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 15:23:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA49C1;
        Tue, 12 Sep 2023 12:23:40 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16E3566072FA;
        Tue, 12 Sep 2023 20:23:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694546619;
        bh=L5LXCOa8/2p57HUzV4WLPFe2Xu5lNiNBgeYv6A6lup4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGMNuICeZavLkjCjzs0HR+aITpCAoLOzcgQo2B7IjI/edLsI4fMJ/cJmE5kh5ztrv
         759iOSvTYFhUZNT2o+Z2o9+ckESdkjk4VJ6aE/oQNX2y4mVJ6aYH0fEhRkRiwo4e5V
         dQnJk6R42GtChT5a08UERktaP4mGRy7HkJlN2gcbFJPPxJP1p9NxgmYjCPYbRCOw7G
         TF6FU0QlfRafRa7CKhJ/Y7KNh4lHgUyd+IVJMuRD5edD57JftZqR2vsjDFGYYtzIta
         Fib19nE1fo5qmo99YuvD4SpUTIQ8uPcjik5UnooUaQVMNkvpLzeT9LYaJimDQrdWta
         82TDu0ONiYN2Q==
Date:   Tue, 12 Sep 2023 15:23:34 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards
 are available
Message-ID: <a12b1144-bea0-4bd7-a429-da800dc8f568@notapiano>
References: <20230908181242.95714-1-nfraprado@collabora.com>
 <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
 <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
 <ZP8kLM5ln2YBCHap@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP8kLM5ln2YBCHap@finisterre.sirena.org.uk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 11, 2023 at 03:29:00PM +0100, Mark Brown wrote:
> On Mon, Sep 11, 2023 at 08:35:37AM -0400, Nícolas F. R. A. Prado wrote:
> > On Sat, Sep 09, 2023 at 12:08:22AM +0100, Mark Brown wrote:
> 
> > > Why?
> 
> > To better reflect the actual test plan status. If 0 tests were run, it doesn't
> > really make sense to say that the test plan passed, rather it was skipped since
> > nothing was run. So with this change, if there's a regression that prevents the
> > soundcard driver from even probing, the result won't be "pass", but "skip", and
> > the reason 'No soundcard available' will be in the logs.
> 
> So, I would interpret the overall result for the suite as being "No
> errors were found in any of the cards discovered" if there is no
> configuration file specified which enumerates the set of cards that are
> expected (if there is a config file that's a different matter, we know
> what we're expecting).  I'm not sure that the different behaviour for 0
> cards is super useful.

Right... So what we want to be doing is adding a config file for every platform
defining the card(s) and PCMs expected, so that when they're missing a test
failure will be triggered which is even more helpful. Although I've noticed that
only missing PCMs are detected currently, but I imagine it should be possible to
to extend the code to detect missing cards as well.

I take it the intention is to expand the conf.d directory with configs for all
platforms currently being tested then? There's only one example file there so I
wasn't sure.

Thanks,
Nícolas
