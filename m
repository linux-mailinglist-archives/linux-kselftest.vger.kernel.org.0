Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4058A4C4991
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiBYPu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiBYPu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB76BDD7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 07:50:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 720EEB83270
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D90C340E7;
        Fri, 25 Feb 2022 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804224;
        bh=6zeaKhd1cDa2VHznk9BHK/J+rUpp98k9PC6C1x/CCcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmQogqEMrHFY/J4fGPzzzQHFACVS3JY4bSut9uF3yhpbwzWJrxULaAJsdBbdLt9G8
         cl5vYyO+5zhZ+F2+6PpBTzuWjzAB65KOxo/+Yi+ANh5kiOmHT4mtyFAwYkYH/WmcOR
         Ash2BtQr0e5U6V6cfHsQ2LPParHbx/cRaI6JNCEcnqgZHai+7cFTvchQcIaV1c3Dl1
         D3CBaSzPYzSV4w5rzOWIzvAK/kO0GYqNq2IKK5smD6uhD9onns158aLqmOiExCIofm
         t9mPL3g0VnSWQF2omRJ4dQA+PfCszH+udd2TajYiX/WHMtnRnxgBz8ki6JslOavKLP
         9jSwUFz0f+aaQ==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v11 00/40] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Fri, 25 Feb 2022 15:50:12 +0000
Message-Id: <164579991080.3691228.14311210559888008730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
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

On Mon, 7 Feb 2022 15:20:29 +0000, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].
> 
> For the kernel SME can be thought of as a series of features which are
> intended to be used together by applications but operate mostly
> orthogonally:
> 
> [...]

Applied patch 5 to arm64 (for-next/kselftest), thanks!

[05/40] kselftest/arm64: signal: Allow tests to be incompatible with features
        https://git.kernel.org/arm64/c/32de73e89099

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
