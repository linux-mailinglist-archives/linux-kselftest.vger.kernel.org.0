Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E1752B7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjGMUNm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGMUNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC72D74;
        Thu, 13 Jul 2023 13:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1809561B3C;
        Thu, 13 Jul 2023 20:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413C7C433C9;
        Thu, 13 Jul 2023 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279175;
        bh=qVcKFuriQVeyr6MhUwFkbMmKVD4tsHd8zt+6eZwzjqc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MaPp04sa+9dRgzx0Ioskw1p0t/c/LeAAvtfH4uVqx5gL/D+cYJyNPehiYVwoXfGJk
         jlPVCxE8ui5KfryIrp5jpmkQPJhOgrA4oHKb3eE2yfvQFEH8kgRNlUDG/kc5BqqABh
         Z3SF3B6R46O0fvGbORqKar5CYFYRHVl2SJ9BfycmdbW7/luyM/jaTqOGiI74rnuade
         9cfLyjNccmPn9N1kTnmdlBcxCOKq7juTJRw9ompQugdpwIvlOHGCi4+TOIjUhNRpbe
         hScUxw+4epw0Bqsm0qsAKzMPAb8tydfnQXbvGvu2y84ThjogKrO5YO1LWdvuChFG+b
         KvUKvTrT1EuWA==
From:   Mark Brown <broonie@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
In-Reply-To: <20230712-regmap-kunit-enable-v1-1-13e296bd0204@kernel.org>
References: <20230712-regmap-kunit-enable-v1-1-13e296bd0204@kernel.org>
Subject: Re: [PATCH] regmap: Provide user selectable option to enable
 regmap
Message-Id: <168927917396.271035.8696798387681365367.b4-ty@kernel.org>
Date:   Thu, 13 Jul 2023 21:12:53 +0100
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

On Wed, 12 Jul 2023 00:21:52 +0100, Mark Brown wrote:
> Since apparently enabling all the KUnit tests shouldn't enable any new
> subsystems it is hard to enable the regmap KUnit tests in normal KUnit
> testing scenarios that don't enable any drivers.  Add a Kconfig option
> to help with this and include it in the KUnit all tests config.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Provide user selectable option to enable regmap
      commit: 47ee108a113c72ec8ceee2c7af52c19ed72e6ad7

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

