Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B06D537F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 23:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDCVaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDCVaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 17:30:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DB173F;
        Mon,  3 Apr 2023 14:30:09 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E804660036F;
        Mon,  3 Apr 2023 22:30:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680557407;
        bh=89fICjanYXC+xkrZxmZS2SkgJF0T/OuXjRoo3D52r70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYfo0HacUNTAtvjNKvvgPFM4llq9UPVLoC540U+x2JV+MUhDD8RfP/E1XGMiercQZ
         xY5/E99mJPx55y1H98dCJxXIAUlGWn6mE/yRmzE+BGCYtcGz1O46MCOAz0aRBSp2O4
         REx73GOg533mbBeARwDIvdroan/RC5cUiZ1qK/4k1RuJEZiNc4yBhSU3Kkt/0QK/0n
         636hTgTrMzL6olfi8tKkX/sPaxohFxeoeucI6EhibeiEpdLDNHvJxKeI7IJGGGazgC
         d0KOWznFvkTaO8b2V4uY4Pevxko+oNUUwfa6i5GN76MKkHLPlzOPtkWlyDoS1S49U6
         WQtWTcx8o4CgA==
Date:   Mon, 3 Apr 2023 17:30:02 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/alsa: Increase kselftest timeout
Message-ID: <5302e70d-cb58-4e70-b44f-ff81b138a2e1@notapiano>
References: <20221214130353.1989075-1-nfraprado@collabora.com>
 <808f35bf-2800-c34b-cae9-4d8eaa11294d@linuxfoundation.org>
 <Y5oSui0udT/6cvSI@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5oSui0udT/6cvSI@sirena.org.uk>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 14, 2022 at 06:15:22PM +0000, Mark Brown wrote:
> On Wed, Dec 14, 2022 at 09:40:02AM -0700, Shuah Khan wrote:
> > On 12/14/22 06:03, Nícolas F. R. A. Prado wrote:
> 
> > > The default timeout for kselftests is 45 seconds, but that isn't enough
> > > time to run pcm-test when there are many PCMs on the device, nor for
> > > mixer-test when slower control buses and fancier CODECs are present.
> > > 
> > > As data points, running pcm-test on mt8192-asurada-spherion takes about
> > > 1m15s, and mixer-test on rk3399-gru-kevin takes about 2m.
> > > 
> > > Set the timeout to 4 minutes to allow both pcm-test and mixer-test to
> > > run to completion with some slack.
> 
> > What I have in mind is that the default run can be limited scope.
> > Run it on a few controllers and in the report mention that a full
> > test can be run as needed.
> 
> > There are a couple of examples of default vs. full test runs - cpu
> > and memory hot-lug tests.
> 
> For pcm-test it's probably more sensible to refactor things to run
> multiple PCMs (or at least cards, though that's less relevant in an
> embedded context) in parallel rather than cut down the test coverage,
> it's already very limited coverage as things stand.  There is some risk
> there could be false positives from cross talk between the PCMs but it's
> probably worth it.
> 
> With mixer-test if it's actually taking a long time to run generally
> this is just identifying that the driver could use some work,
> implementing runtime power management and a register cache will probably
> resolve most issues.

Hi Shuah and Mark,

sorry for the delay, but I'd still like to move forward with this.

Shuah, I've checked the tests you mentioned that have limited scope by default,
and we could do the same for the alsa kselftest, but I'm not sure I understand
how this solves the problem here. The fact is that the current timeout is too
short for a full run of the alsa kselftest on some machines, so we need to
increase the timeout in any case regardless of there being a limited scope run
by default or not. Mark implemented the parallelization he mentioned in the
meantime, but it doesn't help every hardware. The only other option I see is
reducing the time the PCM is tested for (currently 4 seconds). But I assume that
number was chosen for a reason.

I'd also like to better understand why we have an arbitrary (45 seconds) default
timeout. If there are users who want to limit the test duration to an arbitrary
time even if that means not getting full test coverage, shouldn't such arbitrary
time be supplied by the users themselves?

And is there any guidance on what are the acceptable exceptions to having a
longer timeout? Because there seem to be many kselftests which override the
default timeout with a longer one, even ones that disable it altogether.

I can see the value of having a timeout as the worst case scenario of how long
the test takes to run, to avoid hanging indefinitely, which is what the tests
with overriden timeout setting do. For the alsa kselftests that's
hardware-dependent (number of kcontrols for mixer-test; and number of PCMs and
working configurations for pcm-test), so we'd either need to guess a high enough
value for the timeout that all known hardware fits, or allow the timeout to be
set dynamically during runtime.

Thanks,
Nícolas
