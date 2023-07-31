Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB3769624
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGaMX5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGaMX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636AD1724;
        Mon, 31 Jul 2023 05:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FCFE6110F;
        Mon, 31 Jul 2023 12:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339B2C433C8;
        Mon, 31 Jul 2023 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690806204;
        bh=vuba+Vhq5g0pWYAbMHyb5jikpXT3P+OQTVInnYC3tOE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HqBvYQ+OKR/L2+HFOL2swHCVgFG1Xnt7sXVcqOte2mX2t/Gdz7UOwAz447oeObMck
         ssiba4/SfCWGGGuT3i8K9Hd6GE0p4dEMsN9uUVxvfXltThta9wQO6RA21QV/nmQZZp
         e7KDcXzyEz+cp2Q2PMXff370JifZjg5xjsQwXA56GG2gXxmBQjivE4/5lwTXU1eHMc
         /RL/Vld1QklUuizUlHzjcNkUD54+WXyxhbeeLE2tmOOiIQ41iOhNcVLLsZL5ARCUi1
         jEgKxl5Nc9EoQPd/zo4jWS6vA69oC7E20GMaQ40+WD2nLYYS/PWMRckul49yIthvSl
         KktQmZMXOoV7Q==
From:   Maxime Ripard <mripard@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>
Cc:     =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendan.higgins@linux.dev>
In-Reply-To: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
References: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
Subject: Re: [PATCH v3 00/11] drm: kunit: Switch to kunit actions
Message-Id: <169080620207.275106.8542250343147721181.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 14:23:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Jul 2023 11:06:13 +0200, Maxime Ripard wrote:
> Since v6.5-rc1, kunit gained a devm/drmm-like mechanism that makes tests
> resources much easier to cleanup.
> 
> This series converts the existing tests to use those new actions where
> relevant.
> 
> Let me know what you think,
> Maxime
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

