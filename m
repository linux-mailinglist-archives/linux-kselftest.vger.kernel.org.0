Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B134AFB09
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiBISll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 13:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbiBISlT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 13:41:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1BC05CBBD
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 10:41:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFD5DB82381
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 18:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F8C340ED;
        Wed,  9 Feb 2022 18:41:08 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:41:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, nd@arm.com, broonie@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, will@kernel.org
Subject: Re: [PATCH v3 3/6] kselftest/arm64: mte: user_mem: check different
 offsets and sizes
Message-ID: <YgQKwYYIM+ubScUB@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
 <20220209152240.52788-4-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209152240.52788-4-joey.gouly@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 09, 2022 at 03:22:37PM +0000, Joey Gouly wrote:
> To check there are no assumptions in the kernel about buffer sizes or alignments of
> user space pointers, expand the test to cover different sizes and offsets.
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
