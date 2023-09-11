Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FC79AF54
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjIKVTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbjIKMfu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 08:35:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451C1B9;
        Mon, 11 Sep 2023 05:35:44 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0DA866072FE;
        Mon, 11 Sep 2023 13:35:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694435743;
        bh=2yYlnLDcQr0wJy6CrkPZpvlV0KavzexY53zkN7IrZyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UffwBR4KOcQEm5v+0L+6qB8gGt/bAVeSbNBmhf1a73zN/RDNGbGcrKnCtHMwSGRiL
         rTjGEvDl+QywFdr4MH/eG440yLj+DtbxvhC3GcH+0dfXHue/6c+qFHqlH/lfBhdBnJ
         aOrn5xGIMqycaf/ZpkGgnHsYs+KwDejH7J+Fo82Eu++1sW144013s4HL007wQn898U
         so5cg/WoraKt2fvXc+oZk4URl0cNZoboD0Ha2VUc5dw59lbT0G8IxJjmw1idzyWnm5
         p0czQT6hLWTfEIL5sNcEL1k/868b8ZyXV5w1Am6UcLoSpPZA23Xn1MrlQBleo/HP3N
         RgWQuS1ECqEuQ==
Date:   Mon, 11 Sep 2023 08:35:37 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards
 are available
Message-ID: <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
References: <20230908181242.95714-1-nfraprado@collabora.com>
 <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 09, 2023 at 12:08:22AM +0100, Mark Brown wrote:
> On Fri, Sep 08, 2023 at 02:12:40PM -0400, Nícolas F. R. A. Prado wrote:
> > When no soundcards are available, it won't be possible to run any tests.
> > Currently, when this happens, in both pcm-test and mixer-test, 0
> > tests are reported, and the pass exit code is returned. Instead, call
> > ksft_exit_skip() so that the whole test plan is marked as skipped in the
> > KTAP output and it exits with the skip exit code.
> 
> Why?

To better reflect the actual test plan status. If 0 tests were run, it doesn't
really make sense to say that the test plan passed, rather it was skipped since
nothing was run. So with this change, if there's a regression that prevents the
soundcard driver from even probing, the result won't be "pass", but "skip", and
the reason 'No soundcard available' will be in the logs.

Thanks,
Nícolas
