Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76A86D07A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjC3OHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjC3OGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 10:06:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEA5A5F0;
        Thu, 30 Mar 2023 07:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFFEB828DC;
        Thu, 30 Mar 2023 14:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EA3C433EF;
        Thu, 30 Mar 2023 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680185206;
        bh=lJRgG0ijuNTvr7x4m8hdCCZZKuGkL+WKbF28E4wbxuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ay3P2CSuw/+fvmO6Rn3XMlJiz90xOzHTFwryntCKPV6sutNjTR2d7z7zJN8LiVgec
         0yjKdXW170g3K/O7k2sBskhKeZGd1QpliNf68L9HoLjIGu2RzC2qTWNk0HvJx/Xut7
         3aLWphRVqVaNDMQDZmpwf5jMwzs/snzbZFDFrxqHBVC7erAvSpNVg2LFgZqBZUM7XN
         lr4UV3OqkaN0Zq4DKvoUbK0E15cbBZL6JeEmqz7T3mVskxniE3GAQrnBaeq1Uk63aJ
         5962vxalSIkkfuFdVhGsWQpS00yBkROVDwVoH3wvIbbJdWyANps8w4YDr5VLB9esQS
         WibSxDqb0KrFA==
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
References: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
Subject: Re: [PATCH 0/2] regmap: Initial KUnit coverage
Message-Id: <168018520412.3348315.6937765619689881822.b4-ty@kernel.org>
Date:   Thu, 30 Mar 2023 15:06:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 25 Mar 2023 00:27:16 +0000, Mark Brown wrote:
> This series provides some initial KUnit coverage for regmap,
> covering most of the interfaces that operate at the register
> level using an instrumented RAM backed bus type.
> 
> 

Applied to

   broonie/regmap.git for-next

Thanks!

[1/2] regmap: Add RAM backed register map
      commit: f6352424e37e7bf72291ceab87dc620172be0999
[2/2] regmap: Add some basic kunit tests
      commit: 2238959b6ad27040275439edd6893e309bc729a3

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

