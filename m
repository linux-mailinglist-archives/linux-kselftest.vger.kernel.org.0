Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313D765850
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjG0QJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjG0QJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 12:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C12723;
        Thu, 27 Jul 2023 09:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9C761EBA;
        Thu, 27 Jul 2023 16:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B948C433C8;
        Thu, 27 Jul 2023 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474159;
        bh=INyYdjkR7Jcu3V9FQaVLluWCjtOivzhD6P/bDFq/NLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDRDfgG6FlIVcgP2RTcQH1KtPiwx3H8SBBA4eTRrN8W2EJ3Nkxzm7+pmLyQTTzRRV
         UI6QCLCxJ6/zeW99A/20uldruaPCYsBDNdm9zRsf1W72QbGAkDcX+kwZUOGZF/0VdQ
         XRrJykKChN1MJEcYV5nMDyTv961VtQ5bJY6vpY8EADs1i11qHykv6rUFyVJYYR2Imy
         cE4E3WpycfI9KwYd9fgznw6dIgZqsk019G9bxcFm7TwFKYOqb7b7d95ZdzeE7gSL+O
         UVmp5iC64QlammxzYjOpBxBR8/ZeClXVtk/RubkZO7V4LnKfHx7wQEZH5t+JYzNtk9
         wP4UPUDeQkgBg==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Spickett <David.Spickett@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64/fpsimd: Fix use after free in SME when changing SVE VL
Date:   Thu, 27 Jul 2023 17:09:11 +0100
Message-Id: <169047312695.1661739.15888822828616647542.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
References: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 20 Jul 2023 19:38:57 +0100, Mark Brown wrote:
> This series fixes an issue which David Spickett found where if we change
> the SVE VL while SME is in use we can end up attempting to save state to
> an unallocated buffer and adds testing coverage for that plus a bit more
> coverage of VL changes, just for paranioa.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/3] arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
      https://git.kernel.org/arm64/c/d4d5be94a878
[2/3] kselftest/arm64: Add a test case for SVE VL changes with SME active
      https://git.kernel.org/arm64/c/0c7c237b1c35
[3/3] kselftest/arm64: Validate that changing one VL type does not affect another
      https://git.kernel.org/arm64/c/0aeead9bb240

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
