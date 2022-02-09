Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFC4AFA5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 19:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiBISgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 13:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbiBISgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 13:36:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DFC05CB9D
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 10:36:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11664B821BD
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 18:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463ECC340E7;
        Wed,  9 Feb 2022 18:36:18 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:36:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, nd@arm.com, broonie@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, will@kernel.org
Subject: Re: [PATCH v3 1/6] kselftest/arm64: mte: user_mem: introduce
 tag_offset and tag_len
Message-ID: <YgQJn/NVZFAc3DaG@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
 <20220209152240.52788-2-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209152240.52788-2-joey.gouly@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 09, 2022 at 03:22:35PM +0000, Joey Gouly wrote:
> These can be used to place an MTE tag at an address that is not at a
> page size boundary.
> 
> The kernel prior to 295cf156231c ("arm64: Avoid premature usercopy failure"),
> would infinite loop if an MTE tag was placed not at a PAGE_SIZE boundary.
> This is because the kernel checked if the pages were readable by checking the
> first byte of each page, but would then fault in the middle of the page due
> to the MTE tag.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Tested-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
