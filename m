Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9C4B7B1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 00:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiBOXTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 18:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244784AbiBOXTB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B1F8BAD
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 15:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB466151B
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 23:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89642C340F4;
        Tue, 15 Feb 2022 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967130;
        bh=leuOukXd/9BPT4WefthXdPh41WvQYKVHc47o6vAwfC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3ng0B2Bz02WpP7Rr1CQ0fo9VHJBkX/CFi/Z01WYPFYCLFAJdXOD5M8MNG3/4nDJt
         DXSx5hZHGWwsRzyn8BxUsZS800xIZ7d4vnSkkhSkkNBQ8y/RO3Dl6zrmDkvHXFHx8H
         vSdRlYz2Yk1NcsaFDy9dYLRxe5JTt9zIml5gYSktyu7eRsm4GMKr+VIDOxl4zDvYwt
         6jqK8bgNH72Yfo6o+jaVbDWyOtwJnuAtRavDRGOWvMesVYLSrj3I3bctEtj5hkYMTt
         IWExODjhcoMQC5DtdYVBH5zjR5b8zQfZl9kIqiJ77DPv8o2E1xtGX90eRH98k+6Ver
         KVc7MntlJDlaQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joey Gouly <joey.gouly@arm.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Remove local definitions of MTE prctls
Date:   Tue, 15 Feb 2022 23:18:26 +0000
Message-Id: <164494076043.1781041.7296906088756894923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220126174421.1712795-1-broonie@kernel.org>
References: <20220126174421.1712795-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Jan 2022 17:44:21 +0000, Mark Brown wrote:
> The GCR EL1 test unconditionally includes local definitions of the prctls
> it tests. Since not only will the kselftest build infrastructure ensure
> that the in tree uapi headers are available but the toolchain being used to
> build kselftest may ensure that system uapi headers with MTE support are
> available this causes the compiler to warn about duplicate definitions.
> Remove these duplicate definitions.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Remove local definitions of MTE prctls
      https://git.kernel.org/arm64/c/396520759bd3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
