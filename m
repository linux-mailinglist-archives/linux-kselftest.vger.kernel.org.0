Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C06623346
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 20:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKITOQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 14:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiKITON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 14:14:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799C2612E
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 11:14:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC528B81FE3
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 19:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE00C43142;
        Wed,  9 Nov 2022 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668021250;
        bh=ZaYV05A6PUZVPYej+jiUTGp1pw//7+SReSagF7c4iAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbZUa81jV/j5OnJ7Mqkae2zihzcXRqtlSCRWLciH4F6R4DSdNKSgZ7mW49bYM0ZlS
         Vbtx2zj9c/VmnMhweGFh3k9/QNe5c0oOS7frGOgjZcMu+9QslC7bSbBB66OsCSN1w/
         zNmJKhvgz+kOAkXFSaVtRM9TsUgmF4HD4MsGKPWxr48s0xhCBdCw6CPNkugbXKueE8
         bn9JfdD6holQMXQWBemaJ1PYe1kZkAM2z+Wg8Jf5677/2tqlB/RGRFlslrxo4E0/Pj
         8nVacMVIBkvs5PLKBzrMo66qlo2emjp7K+DaMmVIePNoutcodi/ZFC+jpn3VQ9icBX
         zzc1VufMY5mhg==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/6] arm64: Support for 2022 data processing instructions
Date:   Wed,  9 Nov 2022 19:13:59 +0000
Message-Id: <166801649458.857360.157673594634085478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 17 Oct 2022 16:25:14 +0100, Mark Brown wrote:
> The 2022 update to the Arm architecture includes a number of additions
> of generic data processing features, covering the base architecture, SVE
> and SME. Other than SME these are all simple features which introduce no
> architectural state so we simply need to expose hwcaps for them. This
> series covers these simple features. Since the SME updates do introduce
> new architectural state for which we must add new ABI they will be
> handled in a separate series.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/6] arm64/hwcap: Add support for FEAT_CSSC
      https://git.kernel.org/arm64/c/95aa6860d608
[2/6] kselftest/arm64: Add FEAT_CSSC to the hwcap selftest
      https://git.kernel.org/arm64/c/b0ab73a5479f
[3/6] arm64/hwcap: Add support for FEAT_RPRFM
      https://git.kernel.org/arm64/c/939e4649d4fd
[4/6] kselftest/arm64: Add FEAT_RPRFM to the hwcap test
      https://git.kernel.org/arm64/c/989d37fc3d97
[5/6] arm64/hwcap: Add support for SVE 2.1
      https://git.kernel.org/arm64/c/d12aada8dfb0
[6/6] kselftest/arm64: Add SVE 2.1 to hwcap test
      https://git.kernel.org/arm64/c/c5195b027d29

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
