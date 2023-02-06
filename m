Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1D68C387
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBFQoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBFQoN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:44:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136D1D93F;
        Mon,  6 Feb 2023 08:44:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BCA60F85;
        Mon,  6 Feb 2023 16:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53CC433EF;
        Mon,  6 Feb 2023 16:44:08 +0000 (UTC)
Date:   Mon, 6 Feb 2023 16:44:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 07/21] arm64/sme: Enable host kernel to access ZT0
Message-ID: <Y+EuVbkpQJk6z+Zu@arm.com>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
 <20221208-arm64-sme2-v4-7-f2fa0aef982f@kernel.org>
 <86y1pbywbb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y1pbywbb.wl-maz@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 09:31:20AM +0000, Marc Zyngier wrote:
> From a6c4aaccd33e453ffc8d8ea23a4dd4d9a263cc89 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 6 Feb 2023 09:24:40 +0000
> Subject: [PATCH] arm64/sme: Fix __finalise_el2 SMEver check
> 
> When checking for ID_AA64SMFR0_EL1.SMEver, __check_override assumes
> that the ID_AA64SMFR0_EL1 value is in x1, and the intent of the code
> is to reuse value read a few lines above.
> 
> However, as the comment says at the beginning of the macro, x1 will
> be clobbered, and the checks always fails.
> 
> The easiest fix is just to reload the id register before checking it.
> 
> Fixes: f122576f3533 ("arm64/sme: Enable host kernel to access ZT0")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks Marc. I queued it on top of the for-next/sme2 branch.

-- 
Catalin
