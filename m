Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF1769626
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGaMX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjGaMX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7FD10E2;
        Mon, 31 Jul 2023 05:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F33861119;
        Mon, 31 Jul 2023 12:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FDCC433C9;
        Mon, 31 Jul 2023 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690806201;
        bh=vtiNe4G7rXfUPIV0oIeYWpUQbdzfz9IJ3ODvzvMPr8Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sQQ9jYFpJBhowuZb2LUzf3LfMCUxkBWcgAj7cltelwHQIGRX8IQzivkClN2i9rm/f
         IJ/QymMoYhRsdUKhv9A++TBcHETgIU8L5l2UyWlwzM1PNXNnMU/YkD1rpWWrqYUHxF
         Zac3L5TfY5xMHVbqUiFzIveukUXt9R09FAycpqSb7zD1THki2HXttkrSk9uln+/7aU
         bvxsuCDUxLCh8VPp6c85xra3A0LyrSEqrq7nxFKm8smzbeK1/Fh56E4e5jaSboZbDR
         ySqAs2osdE/oMIR+Pue7t64cZ1/uyJy+7uyKXMa4qM7V/xvuLHOVamuH0B5XSzYbRr
         WdUzhGiWmts0g==
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
In-Reply-To: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
References: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
Subject: Re: [PATCH v2 00/11] drm: kunit: Switch to kunit actions
Message-Id: <169080619883.275106.14754848057224430260.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 14:23:18 +0200
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

On Thu, 20 Jul 2023 13:15:45 +0200, Maxime Ripard wrote:
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

