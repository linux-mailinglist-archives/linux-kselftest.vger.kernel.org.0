Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A275978D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGSN63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGSN62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806110E5
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 06:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F856171C
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 13:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406D5C433D9;
        Wed, 19 Jul 2023 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689775068;
        bh=8npZXLd2IRgCTmZxfiXFlG2B2pE9tuqQvGjSRbcdj60=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TSixOYvpqdudxfNNWYntqJIv9QWoDxI+GvREThZlZLQ2tsif3QqmKEt4ZfUHKd2iL
         U11UBGYJOsgcylv0boux2dvektMmH0ohvEv75MKPXJZl7DkJNneM+Li3t8ZP8oPTQt
         5Mc1WbrpG6zWjsG4mHdCdkFmXMeozukSkfImLyeIZ5wXuIitkOHndxjl8d918zo6O/
         +fnlhmO4WBugSW6n3ZyKS7s9e66rVRbLVEOarUbq03pU86Qiw9GOhSVct0XWhUFkza
         eY3aysc5X6UKYlNcP3JPtpJVSVYlv2l75iu1PPmFPDl1dp6ND3fhCNhlFZJQNMfSs7
         xIC0ndR0GOMlA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
In-Reply-To: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: Improve coverage in default KUnit runs
Message-Id: <168977506472.48720.7264353211816565204.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 14:57:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Jul 2023 16:40:33 +0100, Mark Brown wrote:
> We have some KUnit tests for ASoC but they're not being run as much as
> they should be since ASoC isn't enabled in the configs used by default
> with KUnit and in the case of the topolofy tests there is no way to
> enable them without enabling drivers that use them.  Let's improve that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] kunit: Enable ASoC in all_tests.config
      commit: 5aaa4024e14f8b878a348338a74b4c97bc2478b1
[2/2] ASoC: topology: Add explicit build option
      commit: b7dc237ef8b0897f5750a738d2c57469909a6a15

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

