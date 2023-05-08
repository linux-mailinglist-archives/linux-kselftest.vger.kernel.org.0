Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6116FB27C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjEHOXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEHOXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 10:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9C19B7;
        Mon,  8 May 2023 07:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213C662BA9;
        Mon,  8 May 2023 14:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BC5C433EF;
        Mon,  8 May 2023 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683555780;
        bh=U8WykT06be3fQ5xKHsr8qRxuxYlZObvn9l57QXf9BuI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PWq5B/IVZB4+7B7WaduG8OywRrANxcWC4zKV1HzjauuSMdcU75ZfVwW/LI9GQ23aD
         EWHNd09TloWmrUVJ4StKxzT3P5eDfa0tZ5RbDgP77HRyn9/nuai0MrmSbZUpE07dHm
         H5nV9KY/iu9wpBBSDejOViNDX65N9kqiH7NsJKy8pMfaGtmaHzS6ouuz0OUgqQx/d3
         7F6nRJ6ETRsRoPSk5XIOS614xYjfEDNcZ5z25+R5G5YKo0Xh0kSwQfltys2xDaN4eE
         f8xD1VnK1iYLBvhphxo7lNff6wfeVVxd7lZT+0DFwyTAJqCuthsUxS02hc9CpJ6GAF
         pahpbXkAhbvAg==
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <b0a5dbb17c1d5ea482e052e585ae83bb69c48806.1682516005.git.geert@linux-m68k.org>
References: <b0a5dbb17c1d5ea482e052e585ae83bb69c48806.1682516005.git.geert@linux-m68k.org>
Subject: Re: [PATCH v2] regmap: REGMAP_KUNIT must not select REGMAP
Message-Id: <168355577903.271489.7339209827002002335.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 23:22:59 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Apr 2023 15:35:45 +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test must not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
> 
> Fix this by:
>   1. making REGMAP visible if CONFIG_KUNIT_ALL_TESTS is enabled,
>   2. making REGMAP_KUNIT depend on REGMAP instead of selecting it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: REGMAP_KUNIT must not select REGMAP
      commit: 70a640c0efa7667453c3911b13335304ce46ad8b

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

