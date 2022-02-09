Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB54AFB94
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbiBISrf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 13:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiBISq3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 13:46:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEDBC002184
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 10:43:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FB95B821BD
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 18:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F46C340EF;
        Wed,  9 Feb 2022 18:43:27 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:43:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, nd@arm.com, broonie@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, will@kernel.org
Subject: Re: [PATCH v3 5/6] kselftest/arm64: mte: user_mem: add more test
 types
Message-ID: <YgQLTDAgOcfSdoFq@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
 <20220209152240.52788-6-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209152240.52788-6-joey.gouly@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 09, 2022 at 03:22:39PM +0000, Joey Gouly wrote:
> To expand the test coverage for MTE tags in userspace memory,
> also perform the test with `write`, `readv` and `writev` syscalls.
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
